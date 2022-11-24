import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:sembako_bintang/data/utils/helper/failure.dart';
import 'package:sembako_bintang/domain/repository/domain_repository.dart';

class TambahBarangUseCase {
  final DomainRepository repository;

  TambahBarangUseCase(this.repository);

  Future<Either<ServerFailure, String>> execute(
      String price, String productName, File imageFile) {
    return repository.tambahBarang(price, productName, imageFile);
  }
}
