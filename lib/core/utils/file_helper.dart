import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class FileHelper {
  /// Pick a file with error handling and platform-specific workarounds
  static Future<FilePickerResult?> pickFile({
    FileType type = FileType.any,
    List<String>? allowedExtensions,
    bool allowMultiple = false,
  }) async {
    try {
      // Debug message for initialization
      debugPrint('Initializing FilePicker...');
      
      // Try to pick files with the specified parameters
      final result = await FilePicker.platform.pickFiles(
        type: type,
        allowedExtensions: allowedExtensions,
        allowMultiple: allowMultiple,
      );
      
      if (result != null) {
        debugPrint('File selected: ${result.files.first.name}');
      } else {
        debugPrint('No file selected');
      }
      
      return result;
    } catch (e) {
      debugPrint('ERROR PICKING FILE: $e');
      
      // Print platform-specific error information
      if (Platform.isAndroid) {
        debugPrint('''
        ===== ANDROID FILE PICKER ERROR =====
        Make sure you have these permissions in AndroidManifest.xml:
        <uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE"/>
        <uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE"/>
        =======================================
        ''');
      } else if (Platform.isIOS) {
        debugPrint('''
        ===== iOS FILE PICKER ERROR =====
        Make sure you have these keys in Info.plist:
        <key>NSPhotoLibraryUsageDescription</key>
        <string>This app requires access to the photo library</string>
        ==================================
        ''');
      }
      
      return null;
    }
  }
}
