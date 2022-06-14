import 'package:backendless_sdk/backendless_sdk.dart';
import 'package:backendless_todo_starter/routes/routes.dart';
import 'package:backendless_todo_starter/services/todo_service.dart';
import 'package:backendless_todo_starter/services/user_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class InitApp {
  static final String apiKeyAndroid = 'B4EE31A8-10AA-48A5-B663-C31400CF7024';
  static final String apiKeyiOS = 'DABAFDA9-4B1F-4A7A-9A55-287EDCFB8EB1';
  static final String appID = '2460F30B-AEBE-BAF0-FFDF-E06BD9CE0B00';

  static void initializeApp(BuildContext context) async {
    await Backendless.initApp(
        applicationId: appID,
        iosApiKey: apiKeyiOS,
        androidApiKey: apiKeyAndroid);
    String result = await context.read<UserService>().checkIfUserLoggedIn();
    if (result == 'OK') {
      context
          .read<TodoService>()
          .getTodos(context.read<UserService>().currentUser!.email);
      Navigator.popAndPushNamed(context, RouteManager.todoPage);
    } else {
      Navigator.popAndPushNamed(context, RouteManager.loginPage);
    }
  }
}
