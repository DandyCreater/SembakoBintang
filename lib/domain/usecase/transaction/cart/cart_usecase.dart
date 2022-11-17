
import 'package:dartz/dartz.dart';
import 'package:sembako_bintang/data/utils/helper/failure.dart';
import 'package:sembako_bintang/domain/entity/transaction/cart/cart_entity.dart';
import 'package:sembako_bintang/domain/repository/domain_repository.dart';

class CartTransactionUseCase {
  final DomainRepository repository;

  CartTransactionUseCase(this.repository);

  Future<Either<ServerFailure, CartEntity>> execute() {
    return repository.fetchCartTransaction();
  }
}
