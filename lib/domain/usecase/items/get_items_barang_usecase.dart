import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:sembako_bintang/data/utils/helper/failure.dart';
import 'package:sembako_bintang/domain/entity/items/items_entity.dart';
import 'package:sembako_bintang/domain/repository/domain_repository.dart';

class GetItemUseCase {
  final DomainRepository repository;

  const GetItemUseCase(this.repository);

  Future<Either<ServerFailure, List<ItemsEntity>>> execute() async {
    return repository.getItemData();
  }
}

class SearchItemUseCase {
  final DomainRepository repository;

  const SearchItemUseCase(this.repository);

  Future<Either<ServerFailure, List<ItemsEntity>>> execute(
      String itemName) async {
    return repository.filterItem(itemName);
  }
}

class DeleteItemUseCase {
  final DomainRepository repository;

  const DeleteItemUseCase(this.repository);

  Future<Either<ServerFailure, String>> execute(String itemsId) async {
    return repository.deleteItem(itemsId);
  }
}

class UpdateDataItemUseCase {
  final DomainRepository repository;

  const UpdateDataItemUseCase(this.repository);

  Future<Either<ServerFailure, String>> execute(
      ItemsEntity dataItem, File? imageFile) async {
    return repository.updateItem(dataItem, imageFile);
  }
}
