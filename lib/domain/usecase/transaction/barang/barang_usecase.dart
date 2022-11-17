
import 'package:dartz/dartz.dart';
import 'package:sembako_bintang/data/utils/helper/failure.dart';
import 'package:sembako_bintang/domain/entity/transaction/barang/barang_entity.dart';
import 'package:sembako_bintang/domain/repository/domain_repository.dart';

class BarangTransactionUseCase {
  final DomainRepository repository;

  BarangTransactionUseCase(this.repository);

  Future<Either<ServerFailure, BarangEntity>> execute() {
    return repository.fetchBarangTransaction();
  }
}
