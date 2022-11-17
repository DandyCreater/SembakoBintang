import 'package:dartz/dartz.dart';
import 'package:sembako_bintang/data/utils/helper/failure.dart';
import 'package:sembako_bintang/domain/entity/dashboard/menu_entity.dart';
import 'package:sembako_bintang/domain/repository/domain_repository.dart';

class MenuDashboardUseCase {
  final DomainRepository repository;

  MenuDashboardUseCase(this.repository);

  Future<Either<ServerFailure, MenuDashboardEntity>> execute() {
    return repository.fetchMenuDashboard();
  }
}
