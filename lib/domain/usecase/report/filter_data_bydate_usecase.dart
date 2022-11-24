import 'package:dartz/dartz.dart';
import 'package:sembako_bintang/data/utils/helper/failure.dart';
import 'package:sembako_bintang/domain/entity/transaction/data-transaction/data_transaction_entity.dart';
import 'package:sembako_bintang/domain/repository/domain_repository.dart';

class FilterDataByDateUseCase {
  final DomainRepository repository;

  const FilterDataByDateUseCase(this.repository);

  Future<Either<ServerFailure, List<DataTransactionEntity>>> execute(
      DateTime startDate, DateTime endDate) async {
    return repository.filterItemByDate(startDate, endDate);
  }
}
