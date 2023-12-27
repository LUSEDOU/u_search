// ignore_for_file: prefer_const_constructors
import 'package:supabase_client/supabase_client.dart';
import 'package:test/test.dart';

void main() {
  group('SupabaseClient', () {
    test('can be instantiated', () {
      expect(SupabaseClient(), isNotNull);
    });
  });
}
