part of 'checkout_item_bloc.dart';

abstract class CheckoutItemEvent extends Equatable {
  const CheckoutItemEvent();

  @override
  List<Object> get props => [];
}

class FetchCheckOut extends CheckoutItemEvent{
  final CheckOutParameterPost? value;

  const FetchCheckOut({required this.value});
  
  @override
  // TODO: implement props
  List<Object> get props => [value!];
}

class ClearCartData extends CheckoutItemEvent{
  @override
  // TODO: implement props
  List<Object> get props => super.props;
}