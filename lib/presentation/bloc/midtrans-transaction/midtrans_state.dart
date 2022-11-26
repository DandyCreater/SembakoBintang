part of 'midtrans_bloc.dart';

abstract class MidtransState extends Equatable {
  const MidtransState();

  @override
  List<Object> get props => [];
}

class MidtransInitial extends MidtransState {}

class MidtransLoading extends MidtransState {}

class MidtransSuccess extends MidtransState {
  final MidtransEntity value;

  const MidtransSuccess({required this.value});

  @override
  // TODO: implement props
  List<Object> get props => [value];
}

class MidtransFailed extends MidtransState {
  final String? message;

  const MidtransFailed({required this.message});

  @override
  // TODO: implement props
  List<Object> get props => [message!];
}
