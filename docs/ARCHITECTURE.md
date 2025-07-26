# Masarat Mobile Architecture

This document provides a detailed overview of the Masarat Mobile application architecture.

## Clean Architecture

The application follows Clean Architecture principles, separating concerns into distinct layers:

### Presentation Layer

- UI Components (Screens, Widgets)
- State Management (BLoC/Cubit)

### Domain Layer

- Business Logic
- Use Cases
- Domain Entities

### Data Layer

- Repositories Implementation
- Remote/Local Data Sources
- Data Models/DTOs

## Feature-First Organization

The application is organized by features, with each feature containing its own implementations of the layers described above.

```bash
#!/arch
features/
├── auth/                # Authentication feature
│   ├── data/            # Data layer
│   ├── domain/          # Domain layer
│   └── presentation/    # Presentation layer
├── instructor/          # Instructor features
│   ├── data/
│   ├── domain/
│   └── presentation/
└── student/             # Student features
    ├── data/
    ├── domain/
    └── presentation/
```

## Dependency Injection

We use GetIt as our service locator for dependency injection. All dependencies are registered in the `dependency_injection.dart` file.

## Navigation

GoRouter is used for declarative routing. Routes are defined in the `app_router.dart` file, organized by feature with nested routes when appropriate.

## State Management

The application uses the BLoC pattern with Cubit for simpler state management. Each feature has its own set of Cubits that manage the state of that feature.

## Data Flow

1. User interacts with the UI
2. UI events are handled by Cubits
3. Cubits call repositories
4. Repositories fetch data from local or remote data sources
5. Data flows back through the same path in reverse
6. UI updates based on the new state

## Environment Configuration

The app supports multiple environments (development, staging, production) through a configuration system that allows different settings for each environment.
