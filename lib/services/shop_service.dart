import 'package:dartz/dartz.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:my_first_app/app/models/shop/shop_product_model.dart';
import 'package:my_first_app/services/failure_service.dart';

class ShopService {
  final _databaseReference = FirebaseDatabase.instance.ref();

  Future<Either<Failure, List<ShopProductModel>>> fetchDataProduct() async {
    print('Masuk Shop Service 1');
    try {
      final snapshot = await _databaseReference.child('product').get();
      print('Masuk Shop Service 2 : ${snapshot.value}');
      if (snapshot.exists) {
        print('Data exists');

        final data = snapshot.value;

        // Cek tipe data
        print('Masuk Data Structure: $data'); // Cek struktur data

        if (data is List) {
          // Jika data berupa List, kita bisa langsung map ke Models
          final valueList = data
              .map((item) =>
                  ShopProductModel.fromMap(Map<String, dynamic>.from(item)))
              .toList();
          return Right(valueList);
        } else if (data is Map) {
          final valueMap = data.entries
              .map((entry) => ShopProductModel.fromMap(
                  Map<String, dynamic>.from(entry.value)))
              .toList();
          return Right(valueMap);
        } else {
          return Left(Failure(message: 'Data not found'));
        }
      } else {
        print('Data tidak ditemukan');
        return Left(Failure(message: 'Data not found'));
      }
    } catch (e) {
      print('Masuk Shop Service Error  : ${e.toString()}');
      return Left(Failure(message: 'Data not found'));
    }
  }
}
