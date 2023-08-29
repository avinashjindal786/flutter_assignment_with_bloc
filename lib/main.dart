import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_assignment/bloc/user_bloc_bloc.dart';
import 'package:flutter_assignment/model/user_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../api/api.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MyListView());
  }
}

class MyListView extends StatefulWidget {
  @override
  _MyListViewState createState() => _MyListViewState();
}

class _MyListViewState extends State<MyListView> {
  final UserBlocBloc _newsBloc = UserBlocBloc();
  final ApiProvider _apiRepository = ApiProvider();
  bool _sortAscending = false;

  @override
  void initState() {
    _newsBloc.add(UserFetchEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('API Data List'),
        actions: [
          InkWell(
              onTap: () {
                if (_sortAscending) {
                  _newsBloc.add(UserFetchEventSortAsc());
                  setState(() {
                    _sortAscending = true;
                  });
                } else {
                  _newsBloc.add(UserFetchEventSortDes());
                  setState(() {
                    _sortAscending = false;
                  });
                }
              },
              child: Padding(
                padding: const EdgeInsets.only(top: 14, right: 14),
                child: Text(
                  "sort",
                  style: TextStyle(fontSize: 18),
                ),
              ))
        ],
      ),
      body: BlocProvider(
        create: (context) => _newsBloc,
        child: BlocBuilder<UserBlocBloc, UserBlocState>(
          builder: (context, state) {
            if (state is UserBlocLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is UserBlocData || state is UserBlocSort) {
              return ListView.builder(
                itemCount: _newsBloc.result.length,
                itemBuilder: (context, index) {
                  // final item = state.userModel.results![index];
                  return ExpansionTile(
                      title: Text(
                        _newsBloc.result[index].name ?? "",
                        style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic),
                      ),
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: List.generate(
                            _newsBloc.result[index].films!.length,
                            (idx) => FutureBuilder<Widget>(
                                future: _apiRepository.fetchFileItems(_newsBloc.result[index].films![idx]),
                                builder: (BuildContext context, AsyncSnapshot<Widget> snapshot) {
                                  if (snapshot.hasData) return snapshot.data!;

                                  return const CircularProgressIndicator();
                                }),
                          ),
                        )
                      ]);
                },
              );
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }
}
