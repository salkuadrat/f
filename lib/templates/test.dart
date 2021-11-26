import 'dart:io';

/// generate template for test
void test(String project) {
  File('$project/test/widget_test.dart').writeAsStringSync('''
void main() {}''');
}
