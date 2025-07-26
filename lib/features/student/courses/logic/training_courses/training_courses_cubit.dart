import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masarat/features/student/courses/data/repos/courses_repo.dart';
import 'package:masarat/features/student/courses/logic/training_courses/training_courses_state.dart';

class TrainingCoursesCubit extends Cubit<TrainingCoursesState> {
  TrainingCoursesCubit(this._coursesRepo)
      : super(const TrainingCoursesState.initial());

  final CoursesRepo _coursesRepo;
  String? _selectedCategoryId;
  String? _selectedLevel;

  // Getters
  String? get selectedCategoryId => _selectedCategoryId;
  String? get selectedLevel => _selectedLevel;

  // Get the display value (Arabic) for the selected level
  String? get selectedLevelDisplay {
    log('Getting display value for level: $_selectedLevel');
    if (_selectedLevel == null) return 'الكل';

    switch (_selectedLevel) {
      case 'beginner':
        return 'مبتدئ';
      case 'intermediate':
        return 'متوسط';
      case 'advanced':
        return 'متقدم';
      default:
        return _selectedLevel;
    }
  }

  Future<void> getCourses({
    String? categoryId,
    String? level,
    int? limit,
    int? page,
    String? search,
  }) async {
    emit(const TrainingCoursesState.loading());

    final result = await _coursesRepo.getCourses(
      categoryId: categoryId,
      level: level,
      limit: limit,
      page: page,
      search: search,
    );

    result.when(
      success: (coursesResponse) {
        log('Courses loaded successfully: ${coursesResponse.courses.length}');
        emit(TrainingCoursesState.success(coursesResponse.courses));
      },
      failure: (error) {
        log('Failed to load courses: ${error.message}');
        emit(TrainingCoursesState.error(
            error.message ?? 'Failed to load courses'));
      },
    );
  }

  void updateFilters({String? categoryId, String? level}) {
    // Map Arabic level names to English API values
    String? apiLevel;
    if (level != null) {
      switch (level) {
        case 'مبتدئ':
          apiLevel = 'beginner';
          break;
        case 'متوسط':
          apiLevel = 'intermediate';
          break;
        case 'متقدم':
          apiLevel = 'advanced';
          break;
        case 'الكل':
          apiLevel = null; // No filter
          break;
        default:
          apiLevel = level; // Use as-is if not recognized
      }
    }

    // Store the original level for display (the Arabic version)
    final displayLevel = level;

    _selectedCategoryId = categoryId;
    _selectedLevel = apiLevel;

    log('Setting _selectedLevel to: $apiLevel (was: $_selectedLevel)');
    log('Selected display level: $displayLevel');

    // First emit a loading state to trigger a UI rebuild
    emit(const TrainingCoursesState.loading());

    // Then reload courses with new filters
    getCourses(
      categoryId: categoryId,
      level: apiLevel,
    );
  }

  void searchCourses(String query) {
    log('Search query: $query');
    if (query.isNotEmpty) {
      getCourses(
        categoryId: _selectedCategoryId,
        level: _selectedLevel, // _selectedLevel is already mapped to English
        search: query,
      );
    } else {
      // If search query is empty, just get all courses with current filters
      getCourses(
        categoryId: _selectedCategoryId,
        level: _selectedLevel, // _selectedLevel is already mapped to English
      );
    }
  }
}
