import 'dart:io';

/// generate template for pubspec.yaml
void pubspec(String project, String template) {
  String deps = '';

  switch (template) {
    case 'bloc':
      deps = '''
  equatable: ^2.0.3
  rxdart: ^0.27.3
  bloc: ^8.0.1
  flutter_bloc: ^8.0.0''';
      break;
    case 'cubit':
      deps = '''
  equatable: ^2.0.3
  bloc: ^8.0.1
  flutter_bloc: ^8.0.0''';
      break;
    case 'get':
    case 'getx':
      deps = '''
  equatable: ^2.0.3
  get: ^4.3.8''';
      break;
    case 'mobx':
      deps = '''
  mobx: ^2.0.5
  mobx_codegen: ^2.0.4
  flutter_mobx: ^2.0.2''';
      break;
    case 'riverpod':
      deps = '''
  equatable: ^2.0.3
  flutter_riverpod: ^1.0.0''';
      break;
    case 'provider':
    default:
      deps = '''
  provider: ^6.0.1''';
      break;
  }

  File('$project/pubspec.yaml').writeAsStringSync('''
name: $project
description: A new Flutter project.
publish_to: 'none' # Remove this line if you wish to publish to pub.dev
version: 1.0.0+1

environment:
  sdk: ">=2.12.0 <3.0.0"

dependencies:
  flutter:
    sdk: flutter

  # The following adds the Cupertino Icons font to your application.
  # Use with the CupertinoIcons class for iOS style icons.
  cupertino_icons: ^1.0.2
  intl: ^0.17.0
  meta: ^1.7.0
  http: ^0.13.4
  gap: ^2.0.0
  colour: ^1.0.5
  shared_preferences: ^2.0.9
  cached_network_image: ^3.1.0+1
  scrollable_positioned_list: ^0.2.3
$deps

dev_dependencies:
  flutter_test:
    sdk: flutter

  flutter_lints: ^1.0.0

flutter:
  uses-material-design: true

  assets:
    - assets/html/
    - assets/icons/
    - assets/images/
    - assets/logo/

  # To add custom fonts to your application, add a fonts section here,
  # in this "flutter" section. Each entry in this list should have a
  # "family" key with the font family name, and a "fonts" key with a
  # list giving the asset and other descriptors for the font. For
  # example:
  # fonts:
  #   - family: Schyler
  #     fonts:
  #       - asset: fonts/Schyler-Regular.ttf
  #       - asset: fonts/Schyler-Italic.ttf
  #         style: italic
  #   - family: Trajan Pro
  #     fonts:
  #       - asset: fonts/TrajanPro.ttf
  #       - asset: fonts/TrajanPro_Bold.ttf
  #         weight: 700
  #
  # For details regarding fonts from package dependencies,
  # see https://flutter.dev/custom-fonts/#from-packages''');
}
