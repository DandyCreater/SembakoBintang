part of 'barang_transaction_bloc.dart';

abstract class BarangTransactionState extends Equatable {
  const BarangTransactionState();
  
  @override
  List<Object> get props => [];
}

class BarangTransactionInitial extends BarangTransactionState {}

class BarangTransactionLoading extends BarangTransactionState {}

class BarangTransactionDispose extends BarangTransactionState {}

class BarangTransactionSuccess extends BarangTransactionState {
  final OKContentBarangEntity? value;

  const BarangTransactionSuccess({required this.value});

  @override
  // TODO: implement props
  List<Object> get props => [value!];
}

class BarangTransactionFailed extends BarangTransactionState {
  final String? message;

  const BarangTransactionFailed({required this.message})
;
@override
  // TODO: implement props
  List<Object> get props => [message!];
}
