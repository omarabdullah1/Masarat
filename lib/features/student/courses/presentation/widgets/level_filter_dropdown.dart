import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masarat/core/widgets/custom_dropdown_button_form_field.dart';
import 'package:masarat/features/student/courses/logic/training_courses/training_courses_cubit.dart';

class LevelFilterDropdown extends StatefulWidget {
  const LevelFilterDropdown({Key? key}) : super(key: key);

  @override
  State<LevelFilterDropdown> createState() => _LevelFilterDropdownState();
}

class _LevelFilterDropdownState extends State<LevelFilterDropdown> {
  String _selectedValue = 'الكل';

  @override
  void initState() {
    super.initState();
    // We'll initialize in didChangeDependencies since we can't access context in initState
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Initialize with current value from cubit if available
    final cubit = context.read<TrainingCoursesCubit>();
    if (cubit.selectedLevelDisplay != null) {
      setState(() {
        _selectedValue = cubit.selectedLevelDisplay!;
      });
      debugPrint(
          'LevelFilterDropdown: set selectedValue to ${cubit.selectedLevelDisplay}');
    } else {
      debugPrint('LevelFilterDropdown: cubit.selectedLevelDisplay is null');
    }
  }

  @override
  Widget build(BuildContext context) {
    debugPrint(
        'Building LevelFilterDropdown with selectedValue: $_selectedValue');

    // Listen to the cubit for any changes
    final cubit = context.watch<TrainingCoursesCubit>();
    final cubitLevel = cubit.selectedLevelDisplay;
    debugPrint('Cubit level display: $cubitLevel');

    return CustomDropdownButton(
      items: const ['الكل', 'مبتدئ', 'متوسط', 'متقدم'],
      hintText: 'فلترة حسب المستوى',
      selectedValue: _selectedValue,
      onChanged: (value) {
        if (value == null) return;

        debugPrint('Dropdown onChanged: $value');
        setState(() {
          _selectedValue = value;
        });

        log('Selected Level: $value');
        final level = value == 'الكل' ? null : value;
        context.read<TrainingCoursesCubit>().updateFilters(level: level);
      },
    );
  }
}
