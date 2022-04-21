import 'dart:io';

String fixture(String name) {
  final buffer = File(
    'test/fixtures/$name',
  ).readAsStringSync();
  return buffer;
}