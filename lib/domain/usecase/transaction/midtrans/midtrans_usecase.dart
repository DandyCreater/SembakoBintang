import 'package:dartz/dartz.dart';
import 'package:sembako_bintang/data/model/transaction/midtrans/midtrans_response_model.dart';
import 'package:sembako_bintang/data/utils/helper/failure.dart';
import 'package:sembako_bintang/domain/entity/midtrans/midtrans_entity.dart';
import 'package:sembako_bintang/domain/repository/domain_repository.dart';

class MidtransUseCase {
  final DomainRepository domainRepository;

  const MidtransUseCase(this.domainRepository);

  Future<Either<ServerFailure, MidtransEntity>> execute() async {
    return domainRepository.midTransGenerate();
  }
}
