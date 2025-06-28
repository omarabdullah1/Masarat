import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masarat/features/instructor/data/models/course/instructor_courses_response.dart';
import 'package:masarat/features/instructor/data/repos/instructor_repo.dart';
import 'package:masarat/features/instructor/logic/instructor_courses/instructor_courses_state.dart';

import '../../data/models/category/category_model.dart';

class InstructorCoursesCubit extends Cubit<InstructorCoursesState> {
  InstructorCoursesCubit(this._homeRepo)
      : super(const InstructorCoursesState.initial());
  final InstructorRepo _homeRepo;
  InstructorCoursesResponse? _coursesData;
  bool _hasMoreData = true;
  int _currentPage = 1;
  String? _selectedCategoryId;
  String? _selectedLevel;
  final int _pageLimit = 10;
  bool _isLoading = false;
  String? _lastPaginationError;
  final List<CategoryModel> _categories = [];
  final bool _isLoadingCategories = false;

  // Getters
  bool get hasMoreData => _hasMoreData;
  int get currentPage => _currentPage;
  bool get isLoading => _isLoading;
  bool get isLoadingCategories => _isLoadingCategories;
  String? get selectedCategoryId => _selectedCategoryId;
  String? get selectedLevel => _selectedLevel;
  List<CategoryModel> get categories => _categories;

  // Pagination error handling
  String? get lastPaginationError {
    final error = _lastPaginationError;
    // Clear the error after it's retrieved to prevent showing it multiple times
    _lastPaginationError = null;
    return error;
  }

  // Reset state and fetch data with new filters
  Future<void> resetAndFetchCourses({
    String? categoryId,
    String? level,
  }) async {
    _currentPage = 1;
    _hasMoreData = true;
    _selectedCategoryId = categoryId;
    _selectedLevel = level;
    _coursesData = null;

    await getPublishedCourses(
      categoryId: categoryId,
      level: level,
      page: _currentPage,
    );
  }

  // Initial load of courses
  Future<void> getPublishedCourses({
    String? categoryId,
    String? level,
    int? limit = 10,
    int? page = 1,
  }) async {
    if (_isLoading) return;
    _isLoading = true;

    if (page == 1) {
      emit(const InstructorCoursesState.loading());
    } else {
      emit(InstructorCoursesState.loadingMore(_coursesData!));
    }

    final result = await _homeRepo.getPublishedCourses(
      categoryId: categoryId ?? _selectedCategoryId,
      level: level ?? _selectedLevel,
      limit: limit ?? _pageLimit,
      page: page ?? _currentPage,
    );

    _isLoading = false;

    result.when(
      success: (coursesResponse) {
        log('Courses fetched successfully: ${coursesResponse.courses.length} courses');

        if (_coursesData == null || page == 1) {
          _coursesData = coursesResponse;
        } else {
          // Append new courses to existing data
          final updatedCourses = [
            ..._coursesData!.courses,
            ...coursesResponse.courses
          ];
          _coursesData = InstructorCoursesResponse(
            courses: updatedCourses,
            currentPage: coursesResponse.currentPage,
            totalPages: coursesResponse.totalPages,
            totalCourses: coursesResponse.totalCourses,
          );
        }

        // Check if we've reached the end of pagination
        _hasMoreData = _coursesData!.currentPage < _coursesData!.totalPages;
        _currentPage = _coursesData!.currentPage;

        emit(InstructorCoursesState.success(_coursesData!));
      },
      failure: (error) {
        log('Error fetching courses: ${error.message}');
        // If this is the first request and it fails, emit error state
        // Otherwise, store the pagination error and emit success with existing data
        if (_coursesData == null || page == 1) {
          emit(
            InstructorCoursesState.error(
              error: error.message ?? 'Failed to fetch published courses',
            ),
          );
        } else {
          // Store the pagination error for toast display
          _lastPaginationError = error.message ?? 'Failed to load more courses';

          // Emit success with the existing data so UI can continue to function
          emit(InstructorCoursesState.success(_coursesData!));
        }
      },
    );
  } // Fetch the next page

  Future<void> loadMoreCourses() async {
    if (_isLoading || !_hasMoreData) return;

    await getPublishedCourses(
      categoryId: _selectedCategoryId,
      level: _selectedLevel,
      page: _currentPage + 1,
      limit: _pageLimit,
    );
  }
}
