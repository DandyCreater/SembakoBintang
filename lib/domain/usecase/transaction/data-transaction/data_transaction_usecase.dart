import 'package:dartz/dartz.dart';
import 'package:sembako_bintang/data/utils/helper/failure.dart';
import 'package:sembako_bintang/domain/entity/transaction/data-transaction/data_transaction_entity.dart';
import 'package:sembako_bintang/domain/repository/domain_repository.dart';

class DataTransactionUseCase {
  final DomainRepository domainRepository;

  const DataTransactionUseCase(this.domainRepository);

  Future<Either<ServerFailure, List<DataTransactionEntity>>> execute() async {
    return domainRepository.getDataTransaction();
  }
}
