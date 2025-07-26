# Copilot Instructions for Masarat Mobile App

## Project Overview
- **Masarat** is a Flutter-based learning platform supporting both students and instructors, with a feature-first, clean architecture.
- The codebase is organized by feature modules under `lib/features/`, with shared utilities in `lib/core/` and app configuration in `lib/config/`.
- State management uses the BLoC/Cubit pattern. Dependency injection is handled via GetIt (`lib/core/di/`).
- Routing is managed with GoRouter (`lib/config/app_router.dart`).
- Multi-environment support: development, staging, production (see `main_{flavor}.dart` and `Config` class).

## Key Architectural Patterns
- **Feature-First Structure**: Each feature (e.g., `auth`, `student`, `instructor`) contains its own data, domain, and presentation layers.
- **Clean Architecture**: Data (API, repos), domain (logic), and presentation (UI, Cubits) are separated.
- **State Management**: Use Cubit/BLoC for all non-trivial state. Place Cubits in `logic/cubit/` and use `BlocProvider` in UI.
- **Dependency Injection**: Register all services and Cubits in `lib/core/di/dependency_injection.dart`.
- **API Integration**: Use Retrofit for API services (see `lib/features/auth/apis/auth_service.dart`).
- **Localization**: Use `easy_localization` and place translations in `assets/i18n/`.

## Developer Workflows
- **Install dependencies**: `flutter pub get`
- **Run app (choose flavor)**:
  - Development: `flutter run --flavor development --target lib/main_development.dart`
  - Staging:     `flutter run --flavor staging --target lib/main_staging.dart`
  - Production:  `flutter run --flavor production --target lib/main_production.dart`
- **Build for release**: See README for full commands.
- **Testing**: Place tests in `test/` and use `flutter test`.
- **Add new features**: Create a new folder under `lib/features/`, follow the data/domain/presentation split, and register dependencies in DI.

## Project-Specific Conventions
- **Role-based flows**: Many screens and logic branches depend on user role (`AppRole` in `lib/core/enums/app_role.dart`).
- **API endpoints**: See feature-level `README.md` files for endpoint details and sample responses (e.g., `lib/features/student/cart/README.md`).
- **Instructor registration**: Requires file upload and extra fields (see `create_instructor_account_request_body.dart`).
- **Routing**: Use named routes and pass role/context via `extra` in GoRouter.
- **Localization**: All user-facing strings should be localized.
- **UI**: Use custom widgets from `lib/core/widgets/` for consistency.

## Integration Points
- **External APIs**: All network calls use Retrofit and Dio. API constants are in `lib/features/auth/apis/auth_api_constants.dart`.
- **File uploads**: Use `file_picker` and `dio` for multipart requests.
- **Video player**: Uses `video_player` and `chewie` packages.
- **Image compression**: Uses `flutter_image_compress`.

## Examples
- See `lib/features/auth/signup/logic/cubit/register_cubit.dart` for Cubit usage and registration logic.
- See `lib/features/auth/apis/auth_service.dart` for Retrofit API service patterns.
- See `lib/config/app_router.dart` for routing and navigation patterns.

---

If you add new features, follow the feature-first, clean architecture pattern, and update DI and routing as needed. For any unclear conventions, check the main `README.md` or ask for clarification.
