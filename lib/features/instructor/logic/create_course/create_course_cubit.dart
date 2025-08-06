import 'dart:developer';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masarat/features/instructor/data/models/course/create_course_request_body.dart';
import 'package:masarat/features/instructor/data/models/course/update_course_request_body.dart';
import 'package:masarat/features/instructor/data/repos/instructor_repo.dart';

import '../../data/models/category/category_model.dart';
import 'create_course_state.dart';

class CreateCourseCubit extends Cubit<CreateCourseState> {
  final InstructorRepo _instructorRepo;

  CreateCourseCubit(this._instructorRepo)
      : super(const CreateCourseState.initial());

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

  // Getter for categories
  List<CategoryModel> get categories => _categories;

  void resetForm() {
    titleController.clear();
    descriptionController.clear();
    levelController.clear();
    durationEstimateController.clear();
    tagsController.clear();
    priceController.clear();
    selectedCategory = null;
  }

  // Load categories from API
  Future<void> loadCategories() async {
    log('Loading categories');
    emit(const CreateCourseState.loadingCategories());

    final result = await _instructorRepo.getCategories();
    log('Raw categories response: ${result.toString()}'); // Add this line for debugging

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

  Future<void> createCourse({PlatformFile? coverImage}) async {
    log('createCourse method called');

    // Log form field values for debugging
    log('Title: "${titleController.text}"');
    log('Description: "${descriptionController.text}"');
    log('Level: "${levelController.text}"');
    log('Duration: "${durationEstimateController.text}"');
    log('Price: "${priceController.text}"');
    log('Tags: "${tagsController.text}"');
    log('Selected Category: ${selectedCategory?.name ?? "null"}');

    if (!formKey.currentState!.validate()) {
      log('Form validation failed');
      return;
    }
    log('Form validation passed');

    // Check if a category is selected
    if (selectedCategory == null) {
      log('No category selected');
      emit(const CreateCourseState.error(
        error: 'يرجى اختيار تصنيف للدورة',
      ));
      return;
    }
    log('Category selected: ${selectedCategory!.name}');

    emit(const CreateCourseState.loading());
    log('Loading state emitted');

    // Process the tags string to the format the API expects
    final tagsString = tagsController.text.trim();

    if (coverImage != null && coverImage.bytes != null) {
      // Use multipart upload if file is provided
      log('Creating course with cover image (multipart upload)');
      final result = await _instructorRepo.createCourseMultipart(
        title: titleController.text,
        description: descriptionController.text,
        category: selectedCategory!.id,
        level: levelController.text,
        durationEstimate: durationEstimateController.text,
        tags: tagsString,
        price: double.tryParse(priceController.text) ?? 0.0,
        coverImage: coverImage,
      );
      log('API call completed (multipart)');
      result.when(
        success: (courseResponse) {
          log('Course created successfully: $courseResponse');
          emit(CreateCourseState.success(courseResponse));
          resetForm();
        },
        failure: (error) {
          log('Course creation error: ${error.message}');
          emit(CreateCourseState.error(
            error: error.message ?? 'Failed to create course',
          ));
        },
      );
      return;
    }
    // Fallback to JSON if no file
    final requestBody = CreateCourseRequestBody(
      title: titleController.text,
      description: descriptionController.text,
      category: selectedCategory!.id, // Use the selected category ID
      level: levelController.text,
      durationEstimate: durationEstimateController.text,
      tags: tagsString,
      price: double.tryParse(priceController.text) ?? 0.0,
    );
    log('Request body created: ${requestBody.toJson()}');
    final result = await _instructorRepo.createCourse(requestBody);
    log('API call completed');

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

  // Update course
  Future<void> updateCourse(
      {required String courseId, PlatformFile? coverImage}) async {
    log('updateCourse method called');

    // Log form field values for debugging
    log('CourseId: "$courseId"');
    log('Title: "${titleController.text}"');
    log('Description: "${descriptionController.text}"');
    log('Level: "${levelController.text}"');
    log('Duration: "${durationEstimateController.text}"');
    log('Price: "${priceController.text}"');
    log('Tags: "${tagsController.text}"');
    log('Selected Category: ${selectedCategory?.name ?? "null"}');

    if (!formKey.currentState!.validate()) {
      log('Form validation failed');
      return;
    }
    log('Form validation passed');

    // Check if a category is selected
    if (selectedCategory == null) {
      log('No category selected');
      emit(const CreateCourseState.error(
        error: 'يرجى اختيار تصنيف للدورة',
      ));
      return;
    }
    log('Category selected: ${selectedCategory!.name}');

    emit(const CreateCourseState.loading());
    log('Loading state emitted');

    // Parse tags from comma-separated string
    List<String> tagsList = tagsController.text
        .split(',')
        .map((tag) => tag.trim())
        .where((tag) => tag.isNotEmpty)
        .toList();

    // Ensure all required fields are included in the update request
    // This prevents null values from being sent which could cause fields to be cleared
    final updateCourseRequestBody = UpdateCourseRequestBody(
      title: titleController.text.trim(),
      description: descriptionController.text.trim(),
      category: selectedCategory!.id,
      level: levelController.text.trim(),
      durationEstimate: durationEstimateController.text.trim(),
      tags: tagsList.join(','),
      price: double.tryParse(priceController.text.trim()) ?? 0.0,
    );

    log('Update course request: ${updateCourseRequestBody.toJson()}');

    if (coverImage != null && coverImage.bytes != null) {
      log('Updating course with cover image (multipart update)');
      final result = await _instructorRepo.updateCourseMultipart(
        courseId: courseId,
        title: titleController.text,
        description: descriptionController.text,
        category: selectedCategory!.id,
        level: levelController.text,
        durationEstimate: durationEstimateController.text,
        tags: tagsList.join(','),
        price: double.tryParse(priceController.text) ?? 0.0,
        coverImage: coverImage,
      );
      log('API call completed (multipart update)');
      result.when(
        success: (course) {
          log('Course updated successfully: ${course.title}');
          emit(CreateCourseState.success(course));
        },
        failure: (error) {
          log('Failed to update course: ${error.message}');
          emit(CreateCourseState.error(
            error: error.message ?? 'Failed to update course',
          ));
        },
      );
      return;
    }

    final result =
        await _instructorRepo.updateCourse(courseId, updateCourseRequestBody);

    result.when(
      success: (course) {
        log('Course updated successfully: ${course.title}');
        emit(CreateCourseState.success(course));
        // Optionally, you might want to reset the form or navigate away
        // For example, if you want to pop back to the previous screen
        // Navigator.of(context).pop(); // This would require context, which cubit shouldn't have
        // Instead, the UI layer should listen to this success state and handle navigation.
      },
      failure: (error) {
        log('Failed to update course: ${error.message}');
        emit(CreateCourseState.error(
          error: error.message ?? 'Failed to update course',
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
    priceController.dispose();
    return super.close();
  }
}
