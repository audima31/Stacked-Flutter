import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_first_app/services/failure_service.dart';

class LoginService {
  Future<Either<Failure, SignUpDartz>> signUp({
    required String email,
    required String password,
  }) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      print('Masuk Login Service : Success Login');
      await Future.delayed(const Duration(milliseconds: 500));

      return Right(
        SignUpDartz(message: 'Success'),
      );
    } on FirebaseAuthException catch (e) {
      String message = 'An error occurred. Please try again.';
      if (e.code == 'weak-password') {
        message = 'The password provided is too weak.';
        return Left(Failure(message: message));
      } else if (e.code == 'email-already-in-use') {
        message = 'The email address is already in use by another account.';
      }
      return Left(Failure(message: message));
    }
  }

  Future<Either<Failure, SignInDartz>> signIn({
    required String email,
    required String password,
  }) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      return Right(SignInDartz(message: 'Success'));
    } on FirebaseAuthException catch (e) {
      String message = 'An error occurred. Please try again.';
      if (e.code == 'user-not-found') {
        message = 'Not user found!.';
        return Left(Failure(message: message));
      } else if (e.code == 'wrong-password') {
        message = 'Email or Password is incorrect.';
        return Left(Failure(message: message));
      }
      return Left(Failure(message: message));
    }
  }

  Future<Either<Failure, SignOutDartz>> signOut() async {
    try {
      print('Masuk login_service.singOut() : ');
      await FirebaseAuth.instance.signOut();
      await Future.delayed(const Duration(milliseconds: 500));
      return Right(SignOutDartz(message: 'Logout Success'));
    } catch (e) {
      print('Masuk error login_service.singOut() : ${e.toString()}');
      return Left(Failure(message: e.toString()));
    }
  }
}

class SignUpDartz {
  String? message;
  SignUpDartz({this.message});
}

class SignInDartz {
  String? message;
  SignInDartz({this.message});
}

class SignOutDartz {
  String? message;
  SignOutDartz({this.message});
}
