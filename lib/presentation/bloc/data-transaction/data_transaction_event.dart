part of 'data_transaction_bloc.dart';

abstract class DataTransactionEvent extends Equatable {
  const DataTransactionEvent();

  @override
  List<Object> get props => [];
}

class FetchDataTransaction extends DataTransactionEvent {
  @override
  // TODO: implement props
  List<Object> get props => super.props;
}


class CancelPaymentTransaction extends DataTransactionEvent{
  final String? itemsId;

  const CancelPaymentTransaction({required this.itemsId});

  @override
  // TODO: implement props
  List<Object> get props => [itemsId!];
}

class FinishPaymentTransaction extends DataTransactionEvent{
  final String? itemsId;

  const FinishPaymentTransaction({required this.itemsId});

  @override
  // TODO: implement props
  List<Object> get props => [itemsId!];
}