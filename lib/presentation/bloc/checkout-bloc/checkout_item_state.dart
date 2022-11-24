part of 'checkout_item_bloc.dart';

abstract class CheckoutItemState extends Equatable {
  const CheckoutItemState();
  
  @override
  List<Object> get props => [];
}

class CheckoutItemInitial extends CheckoutItemState {}

class CheckoutItemLoading extends CheckoutItemState{}

class CheckoutItemSuccess extends CheckoutItemState{}

class CheckoutItemFailed extends CheckoutItemState{
  final String? message;

  const CheckoutItemFailed({required this.message});

  @override
  // TODO: implement props
  List<Object> get props => [message!];
}

class ClearCartDataSuccess extends CheckoutItemState{}

class ClearCartDataFailed extends CheckoutItemState{
  final String? message;

  const ClearCartDataFailed({required this.message});

  @override
  // TODO: implement props
  List<Object> get props => [message!];
}