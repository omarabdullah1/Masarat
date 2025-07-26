# Development Guidelines

This document outlines the development guidelines for the Masarat Mobile project.

## Code Style

### Dart

- Follow the official [Dart Style Guide](https://dart.dev/guides/language/effective-dart/style)
- Use the project's linting rules as defined in `analysis_options.yaml`
- Keep line length to a maximum of 80 characters
- Use meaningful variable and function names

### Flutter

- Follow the [Flutter Style Guide](https://flutter.dev/docs/development/tools/formatting)
- Extract reusable widgets into separate classes
- Use `const` constructor whenever possible for better performance
- Maintain proper widget tree organization for readability

## Project Structure

- Follow the feature-first architecture approach
- Keep files focused on a single responsibility
- Don't exceed 300-400 lines per file
- Place shared functionality in the core directory

## State Management

- Use Cubit for simpler state management and BLoC for complex state flows
- Keep state classes immutable
- Use freezed for generating immutable state classes
- Handle loading, success, and error states explicitly

## API Communication

- Use repository pattern for data access
- Handle errors gracefully at repository level
- Use models/DTOs for serialization/deserialization
- Cache API responses when appropriate for better performance

## Testing

- Write unit tests for business logic
- Write widget tests for UI components
- Aim for at least 70% code coverage
- Use mocks for dependencies in tests

## Performance

- Keep the main thread free of heavy operations
- Use pagination for large lists
- Optimize images before loading
- Monitor app performance regularly using Flutter DevTools

## Localization

- Use the easy_localization package for translations
- Keep all translation keys in YAML files
- Use meaningful keys that reflect the text's purpose

## Pull Requests & Code Reviews

- Keep PRs focused on a single feature or bug fix
- Write descriptive PR titles and descriptions
- Include screenshots or videos for UI changes
- Address code review feedback promptly

## Commit Messages

Use the following format for commit messages:

```bash
<type>(<scope>): <subject>

<body>
```

Types:

- feat: A new feature
- fix: A bug fix
- docs: Documentation changes
- style: Changes that don't affect code logic
- refactor: Code refactoring
- perf: Performance improvements
- test: Adding or fixing tests
- chore: Changes to build process or tools

Example:

```bash
feat(auth): implement biometric login

- Add Face ID and Touch ID support
- Handle authentication errors
- Update UI for biometric prompt
```
