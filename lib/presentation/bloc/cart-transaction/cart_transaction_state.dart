part of 'cart_transaction_bloc.dart';

abstract class CartTransactionState extends Equatable {
  const CartTransactionState();
  
  @override
  List<Object> get props => [];
}

class CartTransactionInitial extends CartTransactionState {}

class CartTransactionLoading extends CartTransactionState {}

class CartTransactionDispose extends CartTransactionState {}

class CartTransactionSuccess extends CartTransactionState {
  final OKContentCartEntity? value;

  const CartTransactionSuccess({required this.value});

  @override
  // TODO: implement props
  List<Object> get props => [value!];
}

class CartTransactionFailed extends CartTransactionState {
  final String? message;

  const CartTransactionFailed({required this.message});

  @override
  // TODO: implement props
  List<Object> get props => [message!];
}
