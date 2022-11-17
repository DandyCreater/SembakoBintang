import 'package:dartz/dartz.dart';
import 'package:sembako_bintang/data/utils/helper/failure.dart';
import 'package:sembako_bintang/domain/entity/transaction/barang/barang_entity.dart';
import 'package:sembako_bintang/domain/entity/transaction/cart/cart_entity.dart';

import '../entity/dashboard/menu_entity.dart';

abstract class DomainRepository {
  Future<Either<ServerFailure, MenuDashboardEntity>> fetchMenuDashboard();
  Future<Either<ServerFailure, BarangEntity>> fetchBarangTransaction();
  Future<Either<ServerFailure, CartEntity>> fetchCartTransaction();
}
