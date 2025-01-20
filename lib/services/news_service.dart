import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:my_first_app/app/models/news/news_model.dart';
import 'package:my_first_app/services/failure_service.dart';

class NewsService {
  final dio = Dio();

  Future<Either<Failure, ResponseGetNews>> getApi() async {
    try {
      final response = await dio
          .get('https://api-berita-indonesia.vercel.app/antara/terbaru/');
      if (response.statusCode == 200) {
        print('Masuk NewsService : ${ResponseGetNews.fromJson(response.data)}');
        return Right(ResponseGetNews.fromJson(response.data));
      } else {
        return Left(Failure(message: response.statusMessage));
      }
    } catch (e) {
      print('Masuk error NewsService : ${e.toString()}');
      return Left(Failure(message: e.toString()));
    }
  }
}
