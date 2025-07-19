# Testing Strategy

This document outlines the testing strategy for the Masarat Mobile application.

## Testing Levels

### Unit Testing

Unit tests verify that individual components work correctly in isolation.

**What to test:**

- Repository methods
- Cubit/BLoC logic
- Helper functions and utilities
- Model class methods

**Tools:**

- Flutter Test
- Mockito/Mocktail for mocking dependencies
- BLoC Test for testing Cubits and BLoCs

**Example:**

```dart
void main() {
  group('LoginCubit', () {
    late LoginCubit loginCubit;
    late MockLoginRepository mockLoginRepository;

    setUp(() {
      mockLoginRepository = MockLoginRepository();
      loginCubit = LoginCubit(loginRepository: mockLoginRepository);
    });

    test('emits [loading, success] when login is successful', () async {
      // Arrange
      when(mockLoginRepository.login(
        email: 'test@example.com',
        password: 'password123',
      )).thenAnswer((_) async => const Right(User(id: '1', name: 'Test User')));

      // Act & Assert
      await expectLater(
        loginCubit.stream,
        emitsInOrder([
          isA<LoginLoading>(),
          isA<LoginSuccess>(),
        ]),
      );

      // Act
      loginCubit.login(email: 'test@example.com', password: 'password123');
    });
  });
}
```

### Widget Testing

Widget tests verify that UI components render correctly and handle user interactions as expected.

**What to test:**

- Screen rendering
- Widget composition
- User interaction handling
- Form validation
- Navigation

**Tools:**

- Flutter Test
- Flutter Widget Tester
- Network Image Mock for image loading

**Example:**

```dart
void main() {
  group('LoginScreen', () {
    testWidgets('shows validation error when email is empty',
        (WidgetTester tester) async {
      // Arrange
      await tester.pumpWidget(MaterialApp(home: LoginScreen()));

      // Act
      await tester.tap(find.byType(ElevatedButton));
      await tester.pump();

      // Assert
      expect(find.text('Email is required'), findsOneWidget);
    });
  });
}
```

### Integration Testing

Integration tests verify that different parts of the application work correctly together.

**What to test:**

- End-to-end user flows
- API integration
- Navigation between screens
- State persistence

**Tools:**

- Flutter Integration Test
- Mock HTTP server for API responses

**Example:**

```dart
void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('end-to-end test', () {
    testWidgets('login and navigate to home screen',
        (WidgetTester tester) async {
      // Arrange
      await tester.pumpWidget(MyApp());

      // Act - Fill login form
      await tester.enterText(
          find.byKey(const Key('emailField')), 'test@example.com');
      await tester.enterText(
          find.byKey(const Key('passwordField')), 'password123');
      await tester.tap(find.byType(ElevatedButton));
      await tester.pumpAndSettle();

      // Assert - Check we're on the home screen
      expect(find.text('Welcome'), findsOneWidget);
    });
  });
}
```

## Test Coverage

The project aims to maintain:

- 80% or higher unit test coverage
- Key user flows covered by integration tests
- Critical UI components covered by widget tests

## Continuous Integration

All tests are run as part of the CI pipeline on every pull request and before deployment:

1. Unit tests
2. Widget tests
3. Integration tests
4. Code coverage report generation

## Best Practices

1. **Write tests first** - Follow Test-Driven Development when possible
2. **Keep tests isolated** - Each test should not depend on other tests
3. **Use meaningful assertions** - Test for specific behaviors, not implementation details
4. **Mock external dependencies** - Don't rely on actual API calls or database access
5. **Test edge cases** - Handle errors, empty states, and boundary conditions
6. **Maintain tests** - Update tests when requirements change
