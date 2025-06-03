import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masarat/features/courses/data/models/category_model.dart';
import 'package:masarat/features/instructor/instructor_home/data/models/published_courses_response.dart';
import 'package:masarat/features/instructor/instructor_home/data/repos/home_repo.dart';
import 'package:masarat/features/instructor/instructor_home/logic/cubit/published_courses_state.dart';

class PublishedCoursesCubit extends Cubit<PublishedCoursesState> {
  PublishedCoursesCubit(this._homeRepo)
      : super(const PublishedCoursesState.initial());
  final HomeRepo _homeRepo;
  PublishedCoursesResponse? _coursesData;
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
      emit(const PublishedCoursesState.loading());
    } else {
      emit(PublishedCoursesState.loadingMore(_coursesData!));
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
          _coursesData = PublishedCoursesResponse(
            courses: updatedCourses,
            currentPage: coursesResponse.currentPage,
            totalPages: coursesResponse.totalPages,
            totalCourses: coursesResponse.totalCourses,
          );
        }

        // Check if we've reached the end of pagination
        _hasMoreData = _coursesData!.currentPage < _coursesData!.totalPages;
        _currentPage = _coursesData!.currentPage;

        emit(PublishedCoursesState.success(_coursesData!));
      },
      failure: (error) {
        log('Error fetching courses: ${error.message}');
        // If this is the first request and it fails, emit error state
        // Otherwise, store the pagination error and emit success with existing data
        if (_coursesData == null || page == 1) {
          emit(
            PublishedCoursesState.error(
              error: error.message ?? 'Failed to fetch published courses',
            ),
          );
        } else {
          // Store the pagination error for toast display
          _lastPaginationError = error.message ?? 'Failed to load more courses';

          // Emit success with the existing data so UI can continue to function
          emit(PublishedCoursesState.success(_coursesData!));
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
