import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ImageUploader {
  static final FirebaseStorage _storage = FirebaseStorage.instance;
  static final FirebaseAuth _auth = FirebaseAuth.instance;

  /// Uploads an image to Firebase Storage and returns the download URL
  /// 
  /// [file] - The image file to upload
  /// [pathPrefix] - The folder prefix (e.g., 'avatars', 'team_logos', 'posters')
  /// Returns the download URL as a string
  /// Throws [ImageUploadException] on failure
  static Future<String> uploadImage(File file, {required String pathPrefix}) async {
    try {
      final user = _auth.currentUser;
      if (user == null) {
        throw ImageUploadException('User not authenticated');
      }

      // Create unique filename with timestamp
      final timestamp = DateTime.now().millisecondsSinceEpoch;
      final fileName = '${user.uid}_$timestamp.jpg';
      final path = '$pathPrefix/$fileName';

      // Create storage reference
      final storageRef = _storage.ref().child(path);

      // Upload file
      final uploadTask = storageRef.putFile(
        file,
        SettableMetadata(
          contentType: 'image/jpeg',
          customMetadata: {
            'uploadedBy': user.uid,
            'uploadedAt': DateTime.now().toIso8601String(),
          },
        ),
      );

      // Wait for upload to complete
      final snapshot = await uploadTask;
      
      // Get download URL
      final downloadUrl = await snapshot.ref.getDownloadURL();
      
      return downloadUrl;
    } on FirebaseException catch (e) {
      throw ImageUploadException('Firebase upload failed: ${e.message}');
    } catch (e) {
      throw ImageUploadException('Upload failed: $e');
    }
  }

  /// Deletes an image from Firebase Storage
  /// 
  /// [imageUrl] - The full download URL of the image to delete
  /// Throws [ImageUploadException] on failure
  static Future<void> deleteImage(String imageUrl) async {
    try {
      // Extract the path from the URL
      final uri = Uri.parse(imageUrl);
      final path = uri.pathSegments.last;
      
      // Delete from storage
      await _storage.ref().child(path).delete();
    } on FirebaseException catch (e) {
      throw ImageUploadException('Firebase delete failed: ${e.message}');
    } catch (e) {
      throw ImageUploadException('Delete failed: $e');
    }
  }
}

/// Custom exception for image upload operations
class ImageUploadException implements Exception {
  final String message;
  
  ImageUploadException(this.message);
  
  @override
  String toString() => 'ImageUploadException: $message';
}
