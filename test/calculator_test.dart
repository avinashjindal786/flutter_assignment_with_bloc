import 'package:flutter_assignment/api/api.dart';
import 'package:flutter_test/flutter_test.dart';

import 'calculator.dart';

void main() {
  // Calculator? calculator;
  // setUp(() {
  //   calculator = Calculator();
  // });

  // // tearDown(() => null);

  // group("group test", () {
  //   test('I want to test addition', () {
  //     int result = calculator!.add(2, 3);

  //     expect(result, 5);
  //     expect(result, isNot(6));
  //   });

  //   test('I want to test 2 sub', () {
  //     int result = calculator!.sub(12, 3);

  //     expect(result, 9);
  //     expect(result, isNot(5));
  //   });
  // });

  String? _url;
  ApiProvider? apiProvider;

  setUp(() {
    _url = "https://swapi.dev/api/people/";
    apiProvider = ApiProvider();
  });

  group("Api calling", () {
    test("fetch items", () async {
      final response = await apiProvider!.fetchSingleItems(_url);

      expect(response, "https://swapi.dev/api/people/?page=2");
    });
  });
}
