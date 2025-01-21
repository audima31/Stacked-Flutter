import 'package:dartz/dartz.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:my_first_app/services/failure_service.dart';

class RemoteConfigFirebaseService {
  Future<Either<Failure, FirebaseRemoteConfig>> initializeRemoteConfig() async {
    final remoteConfig = FirebaseRemoteConfig.instance;

    try {
      await remoteConfig.setConfigSettings(RemoteConfigSettings(
        fetchTimeout: const Duration(seconds: 1),
        minimumFetchInterval: const Duration(seconds: 10),
      ));

      await remoteConfig.setDefaults({
        "name": "Audima",
      });

      await remoteConfig.fetchAndActivate();
      remoteConfig.onConfigUpdated.listen((event) async {
        await remoteConfig.activate();
        print('Masuk Config updated');
      });
      print('Masuk RemoteConfigFirebaseService Service 3 : ${remoteConfig} ');
      return Right(remoteConfig);
    } catch (e) {
      print(
          'Masuk error RemoteConfigFirebaseService Service Failure: ${e.toString()}');
      return Left(Failure(message: e.toString()));
    }
  }
}
