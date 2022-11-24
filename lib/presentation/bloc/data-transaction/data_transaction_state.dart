part of 'data_transaction_bloc.dart';

abstract class DataTransactionState extends Equatable {
  const DataTransactionState();
  
  @override
  List<Object> get props => [];
}

class DataTransactionInitial extends DataTransactionState {}

class DataTransactionLoading extends DataTransactionState{}

class DataTransactionSuccess extends DataTransactionState{
  final List<DataTransactionEntity>? value;

  const DataTransactionSuccess({required this.value});

  @override
  // TODO: implement props
  List<Object> get props => [value!];
}

class DataTransactionFailed extends DataTransactionState{
  final String? message;

  const DataTransactionFailed({required this.message});

  @override
  // TODO: implement props
  List<Object> get props => [message!];
}