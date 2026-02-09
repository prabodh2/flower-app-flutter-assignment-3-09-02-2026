// import 'dart:io';
// import 'dart:typed_data';
// import 'dart:convert';
// import 'package:flutter/foundation.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:path/path.dart' as path;
// import 'package:shared_preferences/shared_preferences.dart';

// class LocalStorageService {
//   static Future<String> saveImage(File? imageFile, Uint8List? imageBytes) async {
//     try {
//       Uint8List bytes;
      
//       if (imageBytes != null) {
//         bytes = imageBytes;
//       } else if (imageFile != null) {
//         bytes = await imageFile.readAsBytes();
//       } else {
//         throw Exception('No image provided');
//       }
      
//       if (kIsWeb) {
//         return await _saveImageToWeb(bytes);
//       } else {
//         return await _saveImageToDevice(imageFile!, bytes);
//       }
//     } catch (e) {
//       throw Exception('Failed to save image file: $e');
//     }
//   }

//   static Future<String> _saveImageToDevice(File imageFile, Uint8List bytes) async {
//     final Directory appDir = await getApplicationDocumentsDirectory();
//     final String imagesDirPath = path.join(appDir.path, 'flower_images');

//     // Create images directory if it doesn't exist
//     final Directory imagesDir = Directory(imagesDirPath);
//     if (!await imagesDir.exists()) {
//       await imagesDir.create(recursive: true);
//     }

//     // Generate unique filename
//     final String fileName =
//         'image_${DateTime.now().millisecondsSinceEpoch}${path.extension(imageFile.path)}';
//     final String filePath = path.join(imagesDirPath, fileName);

//     // Write bytes to file
//     await File(filePath).writeAsBytes(bytes);
//     return filePath;
//   }

//   static Future<String> _saveImageToWeb(Uint8List bytes) async {
//     try {
//       final prefs = await SharedPreferences.getInstance();
//       final fileName = 'image_${DateTime.now().millisecondsSinceEpoch}';
//       final base64 = base64Encode(bytes);
      
//       await prefs.setString('image_$fileName', base64);
//       return fileName;
//     } catch (e) {
//       throw Exception('Failed to save image to web storage: $e');
//     }
//   }

//   static Future<String> savePdfFile(File pdfFile) async {
//     try {
//       // Check if running on web
//       if (kIsWeb) {
//         // For web, just return a reference ID
//         return 'pdf_${DateTime.now().millisecondsSinceEpoch}';
//       }
      
//       // Get the application documents directory
//       final Directory appDir = await getApplicationDocumentsDirectory();
//       final String pdfsDirPath = path.join(appDir.path, 'flower_pdfs');

//       // Create PDFs directory if it doesn't exist
//       final Directory pdfsDir = Directory(pdfsDirPath);
//       if (!await pdfsDir.exists()) {
//         await pdfsDir.create(recursive: true);
//       }

//       // Generate unique filename
//       final String fileName =
//           'pdf_${DateTime.now().millisecondsSinceEpoch}${path.extension(pdfFile.path)}';
//       final String filePath = path.join(pdfsDirPath, fileName);

//       // Copy file to local storage
//       await pdfFile.copy(filePath);

//       return filePath;
//     } catch (e) {
//       throw Exception('Failed to save PDF file: $e');
//     }
//   }

//   static Future<void> deleteImageFile(String filePath) async {
//     try {
//       // Check if running on web
//       if (kIsWeb) {
//         final prefs = await SharedPreferences.getInstance();
//         await prefs.remove('image_$filePath');
//         return;
//       }
      
//       final File file = File(filePath);
//       if (await file.exists()) {
//         await file.delete();
//       }
//     } catch (e) {
//       throw Exception('Failed to delete image file: $e');
//     }
//   }

//   static Future<void> deletePdfFile(String filePath) async {
//     try {
//       // Check if running on web - no-op for web
//       if (kIsWeb) {
//         return;
//       }
      
//       final File file = File(filePath);
//       if (await file.exists()) {
//         await file.delete();
//       }
//     } catch (e) {
//       throw Exception('Failed to delete PDF file: $e');
//     }
//   }
// }
