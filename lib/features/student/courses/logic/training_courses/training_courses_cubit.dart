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
    _selectedCategoryId = categoryId;
    _selectedLevel = level;
    // Reload courses with new filters
    getCourses(
      categoryId: categoryId,
      level: level,
    );
  }

  void searchCourses(String query) {
    log('Search query: $query');
    if (query.isNotEmpty) {
      getCourses(
        categoryId: _selectedCategoryId,
        level: _selectedLevel,
        search: query,
      );
    } else {
      // If search query is empty, just get all courses with current filters
      getCourses(
        categoryId: _selectedCategoryId,
        level: _selectedLevel,
      );
    }
  }
}
