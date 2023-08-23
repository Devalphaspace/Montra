import 'dart:developer';

import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:get/get_connect/http/src/exceptions/exceptions.dart';
import 'package:montra/git_ignore.dart';

Client client = Client()
    .setEndpoint('https://cloud.appwrite.io/v1')
    .setProject(appwrite_project_id)
    .setSelfSigned(status: true);

final account = Account(client);

createUser(
    {required String email,
    required String password,
    required String name}) async {
  final user = await account.create(
    userId: ID.unique(),
    email: email,
    password: password,
    name: name,
  );
  return user;
}

Future<Session?> loginSession({required String email, required String password}) async {
  final Future<Session> session;
  try {
    session = account
        .createEmailSession(
      email: email,
      password: password,
    );
    return session;
  } on AppwriteException catch (e) {
    log('Exception caught: $e');
    return null;
  } on UnauthorizedException catch (e) {
    log('Exception caught: $e');
    return null;
  }
}
