# Masarat Mobile App

[![Flutter](https://img.shields.io/badge/Flutter-3.19.0-blue.svg?style=for-the-badge&logo=flutter)](https://flutter.dev/)
[![Dart](https://img.shields.io/badge/Dart-3.3.0-blue.svg?style=for-the-badge&logo=dart)](https://dart.dev/)
[![Platform](https://img.shields.io/badge/Platform-Android%20%7C%20iOS-25D366?style=for-the-badge&logo=apple)](https://flutter.dev/)
[![Download on the App Store](https://img.shields.io/badge/Download_on_the_App_Store-0D96F6?style=for-the-badge&logo=apple&logoColor=white)](https://apps.apple.com/us/app/wardaya/id6741480542)

Masarat is a comprehensive learning platform mobile application built with Flutter. It supports multiple user roles including students and instructors, offering a feature-rich educational experience.

---

## 🤩 App Preview

![Masarat](https://github.com/user-attachments/assets/2abb970e-44ce-436a-8d53-63384f401b12)

---

## Architecture Overview 🏛️

The application follows a clean architecture approach with feature-first organization:

```plaintext
lib/
├── app/               # Main application setup
├── assets/            # App-level assets management
├── bootstrap.dart     # Application bootstrapping
├── config/            # App configuration, routing
├── core/              # Core utilities, shared functionality
│   ├── di/            # Dependency injection with GetIt
│   ├── enums/         # Application-wide enums
│   ├── networking/    # Network layer configuration
│   ├── theme/         # App theme definitions
│   ├── utils/         # Utility functions/classes
│   └── widgets/       # Common reusable widgets
├── features/          # Feature modules
│   ├── auth/          # Authentication feature
│   ├── cart/          # Shopping cart functionality
│   ├── home/          # Home screen features
│   ├── instructor/    # Instructor-specific features
│   ├── profile/       # User profile functionality
│   ├── settings/      # App settings
│   ├── shared/        # Shared feature components
│   ├── splash/        # Splash screen
│   └── student/       # Student-specific features
└── main_{flavor}.dart # Entry points for different environments
```

### Key Architectural Components

1. **Feature-First Organization**: Each major feature is isolated in its own directory with its respective data, domain, and presentation layers.

2. **Dependency Injection**: Using GetIt for service locator pattern to manage dependencies.

3. **Bloc/Cubit Pattern**: State management using the BLoC pattern with the Cubit approach for simpler state management.

4. **Clean Architecture Layers**:
   - **Data**: Repositories, data sources, and API services
   - **Domain**: Business logic and entities
   - **Presentation**: UI components and state management

5. **Routing**: Navigation using GoRouter for declarative routing.

6. **Localization**: Multi-language support with easy_localization.

7. **Multi-environment**: Support for development, staging, and production environments.

---

## Getting Started 🚀

### Prerequisites

- Flutter SDK 3.19.0 or higher
- Dart SDK 3.3.0 or higher
- Android Studio / VS Code with Flutter extensions
- iOS development tools (for macOS users)

### Environment Configuration

This project contains 3 flavors:

- development
- staging
- production

Each environment has its own configuration settings managed through the `Config` class.

### Installation

1. Clone the repository:

    ```sh
    git clone https://github.com/RootCo1/masarat-mobile.git
    cd masarat-mobile
    ```

2. Install dependencies:

    ```sh
    flutter pub get
    ```

3. Run the app in the desired flavor:

```sh
# Development
$ flutter run --flavor development --target lib/main_development.dart

# Staging
$ flutter run --flavor staging --target lib/main_staging.dart

# Production
$ flutter run --flavor production --target lib/main_production.dart
```

### Building for Distribution

```sh
# Android (APK)
$ flutter build apk --flavor production --target lib/main_production.dart

# Android (App Bundle)
$ flutter build appbundle --flavor production --target lib/main_production.dart

# iOS
$ flutter build ios --flavor production --target lib/main_production.dart
```

_\*Masarat works on iOS and Android platforms._

---

## User Roles

The application supports two primary user roles:

1. **Student**: Learners who can browse courses, enroll, and access learning materials.
2. **Instructor**: Content creators who can create and manage courses.

User roles are managed through the `AppRole` enum located in `lib/core/enums/app_role.dart`.

---

## Key Features

- **Authentication**: Sign up, login with role-based access
- **Course Management**: Create, browse, and manage educational courses
- **Instructor Dashboard**: Tools for instructors to manage their courses
- **Student Learning Center**: Course viewing and progress tracking
- **Multi-language Support**: Arabic and English localization
- **Responsive Design**: Adapts to different screen sizes

---

## Development Guidelines

- Use the feature-first folder structure for organizing code
- Follow clean architecture principles for separation of concerns
- Implement state management with BLoC/Cubit pattern
- Write unit and widget tests for new features
- Use dependency injection for better testability
- Follow the defined coding standards and linting rules

---

## License

Proprietary - All rights reserved. © 2025 RootCo1
