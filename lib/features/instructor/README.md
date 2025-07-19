# Instructor Feature - Update Course Implementation

This directory contains the complete implementation for the instructor feature's course update functionality.

## API Endpoint

The update course functionality uses the following endpoint:

  ```bash
    PUT {{baseUrl}}/courses/{{courseId}}
  ```

## API Response Format

The endpoint returns the following response structure:

  ```json
  {
      "_id": "685f51d120f1071d71b356b4",
      "title": "Updated - Intro to Backend",
      "description": "Updated description with more details.",
      "category": "68250048d551ebcf797f290f",
      "instructor": "685f0d5f20f1071d71b35649",
      "lessons": [
          "685fb9fd20f1071d71b356df",
          "685fe01820f1071d71b356fa",
          "685ff6d520f1071d71b35742"
      ],
      "coverImageUrl": "default_course_cover.jpg",
      "price": 59.99,
      "level": "beginner",
      "durationEstimate": "111",
      "tags": ["test"],
      "isPublished": false,
      "verificationStatus": "Pending",
      "createdAt": "2025-06-28T02:22:09.005Z",
      "updatedAt": "2025-06-28T16:04:29.121Z",
      "__v": 3
  }
  ```

## File Structure

### Data Layer

#### Models

- `lib/features/instructor/data/models/course/update_course_request_body.dart` - Request model for updating courses
- `lib/features/instructor/data/models/course/update_course_response.dart` - Response model for update course API
- `lib/features/instructor/data/models/course/course_data.dart` - Simple data class for passing course information

#### API Service

- `lib/features/instructor/data/apis/instructor_service.dart` - Contains the `updateCourse` endpoint method
- `lib/features/instructor/data/apis/instructor_api_constants.dart` - API endpoint constants

#### Repository

- `lib/features/instructor/data/repos/instructor_repo.dart` - Contains `updateCourse` method that handles API calls

### Logic Layer (Cubit)

- `lib/features/instructor/logic/update_course/update_course_cubit.dart` - Main business logic for course updates
- `lib/features/instructor/logic/update_course/update_course_state.dart` - State management using Freezed

### UI Layer

#### Screens

- `lib/features/instructor/ui/screens/update_course_screen_v2.dart` - Main update course screen UI
- `lib/features/instructor/ui/screens/example_usage.dart` - Example of how to use the update course screen

#### Widgets

- `lib/features/instructor/ui/widgets/update_course_bloc_listener.dart` - Handles state changes and shows snackbar messages

## Usage

### 1. Add Dependencies to pubspec.yaml

Ensure you have the following dependencies in your `pubspec.yaml`:

```yaml
dependencies:
  flutter_bloc: ^8.1.3
  freezed_annotation: ^2.4.1
  json_annotation: ^4.8.1
  retrofit: ^4.0.3
  dio: ^5.3.2

dev_dependencies:
  build_runner: ^2.4.6
  freezed: ^2.4.6
  json_serializable: ^6.7.1
  retrofit_generator: ^8.0.4
```

### 2. Initialize the Cubit

```dart
// In your main.dart or dependency injection setup
BlocProvider(
  create: (context) => UpdateCourseCubit(
    context.read<InstructorRepo>(),
  ),
  child: MyApp(),
)
```

### 3. Navigate to Update Course Screen

```dart
// Create course data from your existing course information
final courseData = CourseData(
  id: "685f51d120f1071d71b356b4",
  title: "Intro to Backend",
  description: "Learn backend development",
  level: "beginner",
  durationEstimate: "111",
  tags: ["backend", "programming"],
  price: 59.99,
  categoryId: "68250048d551ebcf797f290f",
  verificationStatus: "Pending",
  isPublished: false,
);

// Navigate to update screen
ExampleUsage.navigateToUpdateCourse(context, courseData);
```

### 4. Handling Updated Course Response

The screen will automatically return the updated course data when the update is successful. You can handle this in your calling screen:

```dart
final updatedCourse = await Navigator.of(context).push(
  MaterialPageRoute(
    builder: (context) => BlocProvider(
      create: (context) => UpdateCourseCubit(
        context.read<InstructorRepo>(),
      ),
      child: UpdateCourseScreen(
        // ... course parameters
      ),
    ),
  ),
);

if (updatedCourse != null) {
  // Handle the updated course response
  print('Course updated: ${updatedCourse.title}');
}
```

## Features

- ✅ Form validation for all fields
- ✅ Category dropdown with loading states
- ✅ Error handling with user-friendly messages
- ✅ Loading states during API calls
- ✅ Arabic UI with proper RTL support
- ✅ Automatic form initialization with existing course data
- ✅ Success/error feedback with snackbars
- ✅ Clean architecture with separation of concerns

## Architecture

The implementation follows clean architecture principles:

1. **Data Layer**: Handles API communication and data models
2. **Logic Layer**: Contains business logic using Cubit for state management
3. **UI Layer**: Presents the user interface and handles user interactions

## Error Handling

The implementation includes comprehensive error handling:

- Form validation errors
- API error responses
- Network connectivity issues
- Category loading failures

All errors are displayed to the user through appropriate UI feedback.

## State Management

Uses BLoC pattern with Cubit for state management:

- `UpdateCourseState.initial()` - Initial state
- `UpdateCourseState.loadingCategories()` - Loading categories
- `UpdateCourseState.categoriesLoaded(categories)` - Categories loaded successfully
- `UpdateCourseState.categoriesError(error)` - Error loading categories
- `UpdateCourseState.updating()` - Updating course
- `UpdateCourseState.updateSuccess(course)` - Course updated successfully
- `UpdateCourseState.updateError(error)` - Error updating course

## Customization

You can customize the UI by modifying:

- Colors in `AppColors` class
- Text styles and fonts
- Form field layouts
- Button styles
- Error message texts

## Testing

To test the implementation:

1. Ensure your API endpoint is configured correctly
2. Make sure you have valid category data
3. Test with both valid and invalid form data
4. Test network error scenarios
5. Verify the response handling

## Building

Run the following command to generate the necessary files:

```bash
dart run build_runner build --delete-conflicting-outputs
```

This will generate:

- Freezed state files
- JSON serialization files
- Retrofit API service files
