import 'dart:developer';

import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:get/get.dart';
import 'package:montra/git_ignore.dart';

Client client = Client()
    .setEndpoint('https://cloud.appwrite.io/v1')
    .setProject(appwriteProjectId)
    .setSelfSigned(status: true);

final account = Account(client);

final databases = Databases(client);

Future<DocumentList?> fetchTransactionsWithUserID({required String userID}) async {
  try {
    final document = await databases.listDocuments(
      databaseId: montraDatabaseID,
      collectionId: transactionCollectionID,
      queries: [
        Query.equal('user', userID),
      ],
    );
    return document;
  } on AppwriteException catch (e) {
    log('AppwriteException: $e');
  } catch (e) {
    log('Exception: $e');
  }
  return null;
}

Future<DocumentList?> fetchProfile({required String userID}) async {
  try {
    final document = await databases.listDocuments(
      databaseId: montraDatabaseID,
      collectionId: userCollectionID,
      queries: [
        Query.equal('userID', userID),
      ],
    );

    return document;
  } on AppwriteException catch (ape) {
    log(ape.toString());
  } catch (e) {
    log(e.toString());
  }
  return null;
}

Future<DocumentList?> fetchWallets({required String userID}) async {
  try {
    final document = await databases.listDocuments(
      databaseId: montraDatabaseID,
      collectionId: walletCollectionID,
      queries: [
        Query.equal('user', userID),
      ],
    );
    return document;
  } on AppwriteException catch (ape) {
    log(ape.toString());
  } catch (e) {
    log(e.toString());
  }
  return null;
}

Future<void> updateProfile({
  required String documentID,
  required Map<String, dynamic> data,
}) async {
  try {
    Future result = databases.updateDocument(
      databaseId: montraDatabaseID,
      collectionId: userCollectionID,
      documentId: documentID,
      data: data,
    );

    result.then((response) {
      Document document = response as Document;
      log(document.data.toString());
      Get.back();
    });
  } on AppwriteException catch (e) {
    log(e.toString());
  } catch (e) {
    log(e.toString());
  }
}

Future<DocumentList?> fetchTransactionsWithWalletID({required String walletID}) async {
  try {
    final documentList = await databases.listDocuments(
      databaseId: montraDatabaseID,
      collectionId: transactionCollectionID,
      queries: [
        Query.equal('wallet', walletID),
      ],
    );
    return documentList;
  } on AppwriteException catch (ape) {
    log(ape.toString());
  } catch (e) {
    log(e.toString());
  }
  return null;
}
