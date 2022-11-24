import 'package:dartz/dartz.dart';
import 'package:sembako_bintang/data/model/transaction/cart/cart_responses_model.dart';
import 'package:sembako_bintang/data/utils/helper/failure.dart';
import 'package:sembako_bintang/domain/entity/transaction/cart/cart_entity.dart';
import 'package:sembako_bintang/domain/repository/domain_repository.dart';

// class CartTransactionUseCase {
//   final DomainRepository repository;

//   CartTransactionUseCase(this.repository);

//   Future<Either<ServerFailure, String>> execute(CartParamaterPost value) async {
//     return repository.addItemToCart(value);
//   }
// }

class CartTransactionUseCase {
  final DomainRepository repository;

  CartTransactionUseCase(this.repository);

  Future<Either<ServerFailure, String>> execute(
      CartParamaterPost value, bool addCart, String itemsId) async {
    return repository.addItemToCart(value, addCart, itemsId);
  }
}

class DeleteCartTransactionUseCase {
  final DomainRepository repository;

  DeleteCartTransactionUseCase(this.repository);

  Future<Either<ServerFailure, String>> execute(
      String itemsId, bool addCart) async {
    return repository.deleteItemAtCart(itemsId, addCart);
  }
}

class GetCartItemUseCase {
  final DomainRepository repository;

  const GetCartItemUseCase(this.repository);

  Future<Either<ServerFailure, List<CartEntity>>> execute() async {
    return repository.getItemCart();
  }
}

class DeleteCartCheckOutUseCase {
  final DomainRepository repository;

  const DeleteCartCheckOutUseCase(this.repository);

  Future<Either<ServerFailure, String>> execute(
      String id, String itemsId) async {
    return repository.deleteItemCheckOutCart(id, itemsId);
  }
}

class UpdateCartDataUseCase {
  final DomainRepository repository;

  const UpdateCartDataUseCase(this.repository);

  Future<Either<ServerFailure, String>> execute(
      CartParamaterPost value, String itemsId) async {
    return repository.updateCartData(value, itemsId);
  }
}
