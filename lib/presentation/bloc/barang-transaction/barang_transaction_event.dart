part of 'barang_transaction_bloc.dart';

abstract class BarangTransactionEvent extends Equatable {
  const BarangTransactionEvent();

  @override
  List<Object> get props => [];
}

class FetchBarangTransaction extends BarangTransactionEvent{
  @override
  // TODO: implement props
  List<Object> get props => super.props;
}