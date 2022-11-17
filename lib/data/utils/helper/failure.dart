import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable{
  final String message;

  Failure(this.message);

  @override
  // TODO: implement props
  List<Object?> get props => [message];
}


class ServerFailure extends Failure{
  ServerFailure(String message) : super(message);
}

