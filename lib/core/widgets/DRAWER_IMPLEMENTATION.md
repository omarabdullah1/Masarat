# Role-Based Drawer Implementation

This implementation provides different drawer menus based on the user's role (student or instructor).

## Files Created

1. `/lib/core/widgets/student_drawer.dart` - Drawer implementation specific to student users
2. `/lib/core/widgets/instructor_drawer.dart` - Drawer implementation specific to instructor users
3. `/lib/core/widgets/custom_drawer.dart` - Main drawer component that selects the appropriate drawer based on user role
4. `/lib/core/examples/drawer_switcher_example.dart` - Example demonstrating how to switch between drawer types

## Implementation Details

### Custom Drawer

The `CustomDrawer` class is responsible for determining which drawer implementation to show based on the user's role. It has a static `testUserRole` property that can be set to force a specific drawer type, which is helpful for testing.

In a real-world application, you'd replace the `getUserRoleSync()` method with code that retrieves the user's role from your authentication system.

### Student Drawer

The student drawer includes menu items specific to students:
- Profile
- Home
- My Library
- Training Courses
- Shopping Cart
- Career Guidance
- About Us
- Contact Us
- Policies
- Logout

### Instructor Drawer

The instructor drawer includes menu items specific to instructors:
- Profile
- Home
- Manage Courses
- Create New Course
- Career Guidance
- About Us
- Contact Us
- Policies
- Logout

## How to Use

Simply include `const CustomDrawer()` in your Scaffold's drawer property:

```dart
Scaffold(
  appBar: AppBar(title: Text('Your App')),
  drawer: const CustomDrawer(),
  body: YourContent(),
)
```

The drawer will automatically show the appropriate menu based on the user's role.

## Testing Different Roles

For testing purposes, you can set the drawer type:

```dart
// To show instructor drawer
CustomDrawer.testUserRole = 'trainer';

// To show student drawer
CustomDrawer.testUserRole = 'student';
```

A complete example is provided in `drawer_switcher_example.dart`.

## Development Testing Tool

For development and testing purposes, a dedicated testing screen has been created at:
`/lib/core/examples/drawer_role_tester.dart`

This tool allows developers to:

1. See the current role being used in the app
2. Switch between student and instructor roles on the fly
3. Test how the drawer appears and behaves for each user type
4. Verify that role detection is working correctly

To access this tool in development mode, run the development build and navigate to the development menu. Then select "اختبار القائمة الجانبية حسب الدور" (Test Side Menu by Role).

## Integration with Authentication

The drawer is fully integrated with the authentication system:

1. When a user logs in, their role is stored in secure storage using `SharedPrefHelper.setSecuredString()`
2. The `CustomDrawer` retrieves this role using `SharedPrefHelper.getSecuredString(SharedPrefKeys.userRole)`
3. If no explicit role is stored, the implementation attempts to extract the role from the JWT token
4. The drawer automatically adapts based on the authenticated user's role
5. If no role information is available, it defaults to the student drawer

### JWT Token Integration

The implementation includes JWT token support. When a user logs in, their JWT token is stored in secure storage. If the explicit role value is missing, the drawer implementation will attempt to extract the role from the JWT token payload. This provides a fallback mechanism to ensure the correct drawer is displayed even if the explicit role storage fails.

### Error Handling and Edge Cases

The implementation includes comprehensive error handling to ensure the drawer always works correctly:

1. **No authentication token**: If no token is found, the student drawer is displayed by default
2. **JWT parsing errors**: If the JWT token cannot be parsed, the code falls back to the default student drawer
3. **Loading state**: While loading the role, a loading spinner is displayed in the drawer
4. **Component unmounting**: Proper state management ensures the drawer works even if it's unmounted during async operations
5. **Empty or invalid roles**: Any unrecognized or empty roles default to the student drawer

This resilient design ensures users always have access to navigation functionality, even in edge cases.

## Potential Future Enhancements

The current implementation could be extended with:

1. **Role-based route guards**: Prevent navigation to pages that users shouldn't access based on their role
2. **Additional roles**: Support for more roles beyond just students and instructors
3. **Permission-based drawer items**: Show/hide specific drawer items based on user permissions rather than just role
4. **Dynamic drawer content**: Load drawer menu items from an API based on user privileges
5. **Animated transitions**: Add animations when switching between different drawer types
