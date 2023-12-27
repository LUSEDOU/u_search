import 'package:supabase_api_client/src/helper/json_helper.dart';
import 'package:test/test.dart';

void main() {
  group('JsonHelper', () {
    group('format', () {
      test('Give the expected json when the json has no nested objects', () {
        final json = {
          'id': 1,
          'name': 'John Doe',
          'email': '',
        };
        expect(JsonHelper.format(json), json);
      });

      test('Give the expected json when the json has nested objects', () {
        final json = {
          'id': 1,
          'name': 'John Doe',
          'email': '',
          'address': {
            'street': 'Main Street',
            'city': 'New York',
            'country': 'USA',
          },
        };
        expect(JsonHelper.format(json), json..remove('address'));
      });

      test('Give the expected json when the json has nested objects', () {
        final json = <String, dynamic>{
          'id': 1,
          'name': 'John Doe',
          'email': '',
          'address': {
            'id': 1,
            'street': 'Main Street',
            'city': 'New York',
            'country': 'USA',
          },
        };
        final expectedJson = <String, dynamic>{...json};
        expectedJson['address_id'] =
            (expectedJson['address'] as Map<String, dynamic>)['id'];
        expectedJson.remove('address');

        expect(JsonHelper.format(json), expectedJson);
      });
    });
  });
}
