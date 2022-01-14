
# HR App

Sample project for an employee management application.

## Getting Started

Choose a storage implementation to be used. The application currently supports three options:

 - Hive
 - Floor
 - In memory
This must be set in `lib/domain/interactor/user_interactor.dart` in the constructor. Default is Hive.

> Floor is not supported when running on web.


Run the code generator:

    flutter pub get
    flutter pub get run build_runner build --delete-conflicting-outputs

To log in, use:

 - email: dani@example.com
 - password: 12

Currently, there is no dedicated backend for this application: the login data is only checked locally, and the initial worker list is loaded from randomuser.me.

## Tests

A few tests are provided in the project. While these only test a few cases, they can be used as a template for other tests.
To run the unit and widget tests, run `flutter test`.

> If the tests fail because of missing or incorrect golden image file, run `flutter test --update-goldens`

To run the provided integration test, use `flutter drive --driver test_driver/integration_test.dart --target integration_test/main_test.dart`. This will log in, wait for the users to load, and create a screenshot.
The integration test can also be run as a widget test if `await binding.convertFlutterSurfaceToImage();` is removed.