import 'dart:developer';

import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:montra/git_ignore.dart';

Client client = Client()
    .setEndpoint('https://cloud.appwrite.io/v1')
    .setProject(appwriteProjectId)
    .setSelfSigned(status: true);

final account = Account(client);

final databases = Databases(client);

Future<DocumentList?> fetchTransactionsWithUserID(
    {required String userID}) async {
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
    Fluttertoast.showToast(msg: 'Something went wrong! Please try again!');
  } catch (e) {
    log('Exception: $e');
    Fluttertoast.showToast(msg: 'Something went wrong! Please try again!');
  }
  return null;
}

Future<void> createTransaction({
  required Map<String, dynamic> transactionData,
}) async {
  try {
    await databases.createDocument(
      databaseId: montraDatabaseID,
      collectionId: transactionCollectionID,
      documentId: '',
      data: transactionData,
    );
  } on AppwriteException catch (ape) {
    log(ape.toString());
    Fluttertoast.showToast(msg: 'Something went wrong! Please try again!');
  } catch (e) {
    log(e.toString());
    Fluttertoast.showToast(msg: 'Something went wrong! Please try again!');
  }
  return null;
}

Future<DocumentList?> fetchTransactionsWithWalletID(
    {required String walletID}) async {
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
    Fluttertoast.showToast(msg: 'Something went wrong! Please try again!');
  } catch (e) {
    log(e.toString());
    Fluttertoast.showToast(msg: 'Something went wrong! Please try again!');
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
    Fluttertoast.showToast(msg: 'Something went wrong! Please try again!');
  } catch (e) {
    log(e.toString());
    Fluttertoast.showToast(msg: 'Something went wrong! Please try again!');
  }
  return null;
}

Future<Document?> createWallet(
    {required Map<String, dynamic> walletData}) async {
  try {
    final document = await databases.createDocument(
      databaseId: montraDatabaseID,
      collectionId: walletCollectionID,
      documentId: '',
      data: walletData,
    );

    return document;
  } catch (e) {
    log(e.toString());
    return null;
  }
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
    Fluttertoast.showToast(msg: 'Something went wrong! Please try again!');
  } catch (e) {
    log(e.toString());
    Fluttertoast.showToast(msg: 'Something went wrong! Please try again!');
  }
  return null;
}

Future<dynamic> updateWallet({
  required String walletID,
  required Map<String, dynamic> walletData,
}) async {
  try {
    Future result = databases.updateDocument(
      databaseId: montraDatabaseID,
      collectionId: walletCollectionID,
      documentId: walletID,
      data: walletData,
    );

    result.then((value) {
      print(value);
    }).catchError((error) {
      log('onError: $error');
    });

    return result;
  } on AppwriteException catch (ape) {
    log(ape.toString());
    Fluttertoast.showToast(msg: 'Something went wrong! Please try again!');
  } catch (e) {
    log(e.toString());
    Fluttertoast.showToast(msg: 'Something went wrong! Please try again!');
  }
}

Future<dynamic> deleteWallet({required String walletID}) async {
  try {
    Future result = databases.deleteDocument(
      databaseId: montraDatabaseID,
      collectionId: walletCollectionID,
      documentId: walletID,
    );

    result.then((value) {
      log(value.toString());
    }).catchError((error) {
      log(error.toString());
    });

    return result;
  } on AppwriteException catch (ape) {
    log(ape.toString());
    Fluttertoast.showToast(msg: 'Something went wrong! Please try again!');
  } catch (e) {
    log(e.toString());
    Fluttertoast.showToast(msg: 'Something went wrong! Please try again!');
  }
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
    Fluttertoast.showToast(msg: 'Something went wrong! Please try again!');
  } catch (e) {
    log(e.toString());
    Fluttertoast.showToast(msg: 'Something went wrong! Please try again!');
  }
}

Future<List<Document>?> fetchCategories({required String userID}) async {
  try {
    log('fetchCategory is running');
    final commonDocumentList = await databases.listDocuments(
      databaseId: montraDatabaseID,
      collectionId: categoryCollectionID,
      queries: [
        Query.isNull('user'),
      ],
    );
    final userSpecificDocumentList = await databases.listDocuments(
      databaseId: montraDatabaseID,
      collectionId: categoryCollectionID,
      queries: [
        Query.equal('user', userID),
      ],
    );

    List<Document> documentList = [];
    documentList.addAll(commonDocumentList.documents);
    documentList.addAll(userSpecificDocumentList.documents);
    log('fetchCategory is stopped!');

    return documentList;
  } on AppwriteException catch (ape) {
    log(ape.toString());
    Fluttertoast.showToast(msg: 'Something went wrong! Please try again!');
  } catch (e) {
    log(e.toString());
    Fluttertoast.showToast(msg: 'Something went wrong! Please try again!');
  }
  return null;
}
