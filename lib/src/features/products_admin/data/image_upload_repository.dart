// ignore_for_file: unused_element, unused_local_variable

import 'dart:io';

import 'package:appwrite/appwrite.dart';
import 'package:ecommerce_app/app_write.dart';
import 'package:ecommerce_app/src/features/products/domain/product.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:riverpod/riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'image_upload_repository.g.dart';

/// Class for uploading images to Firebase Storage
class ImageUploadRepository {
  ImageUploadRepository(this._storage, this._bucketId);
  final Storage _storage;
  final String _bucketId;

  /// Upload an image asset to Appwrite and return a preview URL
  Future<String> uploadProductImageFromAsset(
    String assetPath,
    ProductID productId,
  ) async {
    // Load asset byte data
    final byteData = await rootBundle.load(assetPath);

    // Extract filename from asset path
    final components = assetPath.split('/');
    final filename = components.last;

    // Write byte data to a temporary file
    final tempFile = await _writeBytesToTempFile(byteData, filename);

    // Upload to Appwrite Storage
    final uploaded = await _storage.createFile(
      bucketId: _bucketId,
      fileId: ID.unique(),
      file: InputFile.fromPath(path: tempFile.path, filename: filename),
      permissions: [
        Permission.read(Role.any()), // Optional: make public
      ],
    );
    // Return public preview URL
    return _buildPreviewUrl(uploaded.$id);
  }

  /// Delete image by file ID
  Future<void> deleteProductImage(String fileId) async {
    await _storage.deleteFile(bucketId: _bucketId, fileId: fileId);
  }

  /// Save ByteData as a temporary file
  Future<File> _writeBytesToTempFile(ByteData data, String filename) async {
    final bytes =
        data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
    final tempDir = await getTemporaryDirectory();
    final file = File('${tempDir.path}/$filename');
    return await file.writeAsBytes(bytes);
  }

  /// Build a view URL for the uploaded file
  String _buildPreviewUrl(String fileId) {
    const endpoint = endpointKey; // change if self-hosted
    const projectId = projectIdKey; // replace with your Appwrite project ID
    return '$endpoint/storage/buckets/$_bucketId/files/$fileId/view?project=$projectId';
  }
}

@riverpod
ImageUploadRepository imageUploadRepository(Ref ref) {
  final storage = ref.read(appWriteStorageProvider);
  const bucketId = bucketIdKey;
  return ImageUploadRepository(storage, bucketId);
}

@riverpod
Client appWriteClient(Ref ref) {
  Client client = Client();
  client
      .setEndpoint(endpointKey)
      .setProject(projectIdKey)
      .setSelfSigned(status: true);
  return client;
}

@riverpod
Storage appWriteStorage(Ref ref) {
  final client = ref.watch(appWriteClientProvider);
  return Storage(client);
}
