import 'package:appwrite/appwrite.dart';
import 'package:montra/git_ignore.dart';

Client client = Client()
    .setEndpoint('https://cloud.appwrite.io/v1')
    .setProject(appwrite_project_id)
    .setSelfSigned(status: true);
