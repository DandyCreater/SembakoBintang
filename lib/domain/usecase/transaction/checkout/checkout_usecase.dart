import 'package:dartz/dartz.dart';
import 'package:sembako_bintang/data/model/transaction/checkout/checkout_response_model.dart';
import 'package:sembako_bintang/data/utils/helper/failure.dart';
import 'package:sembako_bintang/domain/repository/domain_repository.dart';

class CheckOutItemUseCase {
  final DomainRepository repository;

  const CheckOutItemUseCase(this.repository);

  Future<Either<ServerFailure, String>> execute(
      CheckOutParameterPost value) async {
    return repository.checkOutData(value);
  }
}

class ClearCartItemsUseCase {
  final DomainRepository repository;

  const ClearCartItemsUseCase(this.repository);

  Future<Either<ServerFailure, String>> execute() async {
    return repository.clearCartItems();
  }
}
