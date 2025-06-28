import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masarat/features/instructor/data/models/category/category_model.dart';
import 'package:masarat/features/instructor/data/models/course/update_course_request_body.dart';
import 'package:masarat/features/instructor/data/repos/instructor_repo.dart';

import 'update_course_state.dart';

class UpdateCourseCubit extends Cubit<UpdateCourseState> {
  final InstructorRepo _instructorRepo;

  UpdateCourseCubit(this._instructorRepo)
      : super(const UpdateCourseState.initial()) {
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
  final TextEditingController priceController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  // Category related properties
  List<CategoryModel> _categories = [];
  CategoryModel? selectedCategory;

  // Course ID to update
  String? courseId;

  // Getter for categories
  List<CategoryModel> get categories => _categories;

  void initializeWithCourse({
    required String id,
    required String title,
    required String description,
    required String level,
    required String durationEstimate,
    required List<String> tags,
    required double price,
    required String categoryId,
    String? verificationStatus,
    bool? isPublished,
  }) {
    courseId = id;
    titleController.text = title;
    descriptionController.text = description;
    levelController.text = level;
    durationEstimateController.text = durationEstimate;
    tagsController.text = tags.join(', ');
    priceController.text = price.toString();

    // Find the selected category
    selectedCategory = _categories.firstWhere(
      (category) => category.id == categoryId,
      orElse: () => _categories.isNotEmpty
          ? _categories.first
          : CategoryModel(id: '', name: ''),
    );
  }

  void resetForm() {
    titleController.clear();
    descriptionController.clear();
    levelController.clear();
    durationEstimateController.clear();
    tagsController.clear();
    priceController.clear();
    selectedCategory = null;
    courseId = null;
  }

  // Load categories from API
  Future<void> loadCategories() async {
    log('Loading categories');
    emit(const UpdateCourseState.loadingCategories());

    final result = await _instructorRepo.getCategories();

    result.when(
      success: (categories) {
        log('Categories loaded successfully: ${categories.length}');
        _categories = categories;
        emit(UpdateCourseState.categoriesLoaded(categories));
      },
      failure: (error) {
        log('Failed to load categories: ${error.message}');
        emit(UpdateCourseState.categoriesError(
            error.message ?? 'Failed to load categories'));
      },
    );
  }

  // Update selected category
  void updateSelectedCategory(CategoryModel? category) {
    selectedCategory = category;
    log('Selected category: ${category?.name}');
  }

  // Update course
  Future<void> updateCourse() async {
    if (!formKey.currentState!.validate() || courseId == null) {
      log('Form validation failed or course ID is null');
      return;
    }

    if (selectedCategory == null) {
      emit(const UpdateCourseState.updateError('Please select a category'));
      return;
    }

    log('Updating course');
    emit(const UpdateCourseState.updating());

    // Parse tags from comma-separated string
    List<String> tagsList = tagsController.text
        .split(',')
        .map((tag) => tag.trim())
        .where((tag) => tag.isNotEmpty)
        .toList();

    final updateCourseRequestBody = UpdateCourseRequestBody(
      title: titleController.text.trim().isEmpty
          ? null
          : titleController.text.trim(),
      description: descriptionController.text.trim().isEmpty
          ? null
          : descriptionController.text.trim(),
      category: selectedCategory!.id,
      level: levelController.text.trim().isEmpty
          ? null
          : levelController.text.trim(),
      durationEstimate: durationEstimateController.text.trim().isEmpty
          ? null
          : durationEstimateController.text.trim(),
      tags: tagsList.isEmpty ? null : tagsList.join(','),
      price: priceController.text.trim().isEmpty
          ? null
          : double.tryParse(priceController.text.trim()),
    );

    log('Update course request: ${updateCourseRequestBody.toJson()}');

    final result =
        await _instructorRepo.updateCourse(courseId!, updateCourseRequestBody);

    result.when(
      success: (course) {
        log('Course updated successfully: ${course.title}');
        emit(UpdateCourseState.updateSuccess(course));
      },
      failure: (error) {
        log('Failed to update course: ${error.message}');
        emit(UpdateCourseState.updateError(
            error.message ?? 'Failed to update course'));
      },
    );
  }

  @override
  Future<void> close() {
    titleController.dispose();
    descriptionController.dispose();
    levelController.dispose();
    durationEstimateController.dispose();
    tagsController.dispose();
    priceController.dispose();
    return super.close();
  }
}
