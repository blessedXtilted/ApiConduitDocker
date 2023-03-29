import 'dart:io';

import 'package:conduit/conduit.dart';
import 'package:conduit_api/controllers/authController.dart';
import 'package:conduit_api/controllers/operationController.dart';
import 'package:conduit_api/controllers/userController.dart';

import 'models/user.dart';
import 'models/operation.dart';

class AppService extends ApplicationChannel {
  late final ManagedContext managedContext;

  @override
  Future prepare(){
    final persistentStore = _initDatabase();

    managedContext = ManagedContext(ManagedDataModel.fromCurrentMirrorSystem(),
     persistentStore);
    return super.prepare();
  }

  @override
  Controller get entryPoint {
    final router = Router();

    router.route('/auth').link(() => AppAuthController(managedContext));
    router.route('/token/[:refresh]').link(() => AppUserController(managedContext));
    router.route('/user').link(() => AppUserController(managedContext));
    router.route('/operations/[:id]').link(() => AppOperationController(managedContext));
    return router;
  }

  PersistentStore _initDatabase() {
    final username = Platform.environment["DB_USERNAME"] ?? 'admin';
    final password = Platform.environment["DB_PASSWORD"] ?? 'root';
    final host = Platform.environment["DB_HOST"] ?? 'localhost';
    final port = int.parse(Platform.environment["DB_PORT"] ?? '6101');
    final databaseName = Platform.environment["DB_NAME"] ?? 'postgres';
    return PostgreSQLPersistentStore(
      username, password, host, port, databaseName);

  }
}