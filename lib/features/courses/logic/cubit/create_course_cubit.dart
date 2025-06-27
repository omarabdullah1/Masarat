import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masarat/features/courses/data/models/category_model.dart';
import 'package:masarat/features/courses/data/models/create_course_request_body.dart';
import 'package:masarat/features/courses/data/repos/courses_repo.dart';

import 'create_course_state.dart';

class CreateCourseCubit extends Cubit<CreateCourseState> {
  final CoursesRepo _coursesRepo;

  CreateCourseCubit(this._coursesRepo)
      : super(const CreateCourseState.initial()) {
    // Load categories when cubit is created
    loadCategories();
  }

  // Form controllers
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController levelController = TextEditingController();
  final TextEditingController durationEstimateController =
      TextEditingController();
  final TextEditingController tagsController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  // Category related properties
  List<CategoryModel> _categories = [];
  CategoryModel? selectedCategory;

  // Getter for categories
  List<CategoryModel> get categories => _categories;

  void resetForm() {
    titleController.clear();
    descriptionController.clear();
    levelController.clear();
    durationEstimateController.clear();
    tagsController.clear();
    selectedCategory = null;
  }

  // Load categories from API
  Future<void> loadCategories() async {
    log('Loading categories');
    emit(const CreateCourseState.loadingCategories());

    final result = await _coursesRepo.getCategories();

    result.when(
      success: (categoriesList) {
        _categories = categoriesList;
        log('Categories loaded successfully: ${_categories.length} categories');
        emit(CreateCourseState.categoriesLoaded(_categories));
      },
      failure: (error) {
        log('Categories loading error: ${error.message}');
        emit(CreateCourseState.categoriesError(
          error: error.message ?? 'Failed to load categories',
        ));
      },
    );
  }

  // Set selected category
  void setSelectedCategory(CategoryModel category) {
    selectedCategory = category;
    // We don't need to emit a new state here as this just updates the UI
  }

  Future<void> createCourse() async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    // Check if a category is selected
    if (selectedCategory == null) {
      emit(const CreateCourseState.error(
        error: 'يرجى اختيار تصنيف للدورة',
      ));
      return;
    }

    emit(const CreateCourseState.loading());

    // Process the tags string to the format the API expects
    final tagsString = tagsController.text.trim();

    final requestBody = CreateCourseRequestBody(
      title: titleController.text,
      description: descriptionController.text,
      category: selectedCategory!.id, // Use the selected category ID
      level: levelController.text,
      durationEstimate: durationEstimateController.text,
      tags: tagsString,
    );

    final result = await _coursesRepo.createCourse(requestBody);

    result.when(
      success: (courseResponse) {
        log('Course created successfully: $courseResponse');
        emit(CreateCourseState.success(courseResponse));
        // Reset form after successful creation
        resetForm();
      },
      failure: (error) {
        log('Course creation error: ${error.message}');
        emit(CreateCourseState.error(
          error: error.message ?? 'Failed to create course',
        ));
      },
    );
  }

  @override
  Future<void> close() {
    // Clean up controllers
    titleController.dispose();
    descriptionController.dispose();
    levelController.dispose();
    durationEstimateController.dispose();
    tagsController.dispose();
    return super.close();
  }
}
