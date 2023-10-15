import 'dart:developer';

import 'package:appwrite/appwrite.dart';

import '../git_ignore.dart';

Client client = Client()
    .setEndpoint('https://cloud.appwrite.io/v1')
    .setProject(appwriteProjectId)
    .setSelfSigned(status: true);

Storage storage = Storage(client);

Future createFile({
  required String bucketID,
  required String fileID,
  required String userID,
  required String filePath,
  required String extension,
}) async {
  try {
    Future result = storage.createFile(
      bucketId: bucketID,
      fileId: fileID,
      file: InputFile.fromPath(
        path: filePath,
        filename: fileID + extension,
      ),
      permissions: [
        Permission.read(Role.any()),
        // Permission.create(Role.user(userID)),
        Permission.update(Role.user(userID)),
        Permission.delete(Role.user(userID)),
      ],
    );

    result.then((response) {
      log('Response: $response');
    });
  } on AppwriteException catch (e) {
    log(e.toString());
  } catch (e) {
    log(e.toString());
  }
}

Future deleteFile({
  required String bucketID,
  required String fileID,
}) async {
  try {
    Future result = storage.deleteFile(
      bucketId: bucketID,
      fileId: fileID,
    );

    result.then((response) {
      log('Response: $response');
    });
  } on AppwriteException catch (e) {
    log(e.toString());
  } catch (e) {
    log(e.toString());
  }
}
