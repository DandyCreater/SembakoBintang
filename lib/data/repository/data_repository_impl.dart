import 'package:dartz/dartz.dart';
import 'package:sembako_bintang/data/datasources/local_data_sources.dart';
import 'package:sembako_bintang/data/model/dashboard/menu_response_model.dart';
import 'package:sembako_bintang/data/model/transaction/barang/barang_response_model.dart';
import 'package:sembako_bintang/data/model/transaction/cart/cart_response_model.dart';
import 'package:sembako_bintang/data/utils/helper/failure.dart';
import 'package:sembako_bintang/domain/entity/dashboard/menu_entity.dart';
import 'package:sembako_bintang/domain/entity/transaction/barang/barang_entity.dart';
import 'package:sembako_bintang/domain/entity/transaction/cart/cart_entity.dart';
import 'package:sembako_bintang/domain/repository/domain_repository.dart';

class DataRepositoryImpl extends DomainRepository {
  final LocalDataSources localDataSources;

  DataRepositoryImpl({required this.localDataSources});

  @override
  Future<Either<ServerFailure, MenuDashboardEntity>>
      fetchMenuDashboard() async {
    try {
      MenuResponseModel result = await localDataSources.fetchMenuDashboard();

      if (result.responseCode == "OK") {
        return right(result.toEntity());
      } else {
        return left(ServerFailure("Fetch Menu Error!"));
      }
    } catch (e) {
      return Left(ServerFailure("CATCH ERROR REPOSITORY MENU $e"));
    }
  }

  @override
  Future<Either<ServerFailure, BarangEntity>> fetchBarangTransaction() async {
    try {
      BarangResponseModel result =
          await localDataSources.fetchBarangTransaction();

      if (result.responseCode == "OK") {
        return right(result.toEntity());
      } else {
        return left(ServerFailure("Fetch Barang Error!"));
      }
    } catch (e) {
      return Left(
          ServerFailure("CATCH ERROR REPOSITORY BARANG TRANSACTION $e"));
    }
  }

  @override
  Future<Either<ServerFailure, CartEntity>> fetchCartTransaction() async {
    try {
      CartResponseModel result = await localDataSources.cartTransaction();

      if (result.responseCode == "OK") {
        return right(result.toEntity());
      } else {
        return left(ServerFailure("Fetch Cart Error !"));
      }
    } catch (e) {
      return Left(ServerFailure("CATCH ERROR CART TRANSACTION $e"));
    }
  }
}
