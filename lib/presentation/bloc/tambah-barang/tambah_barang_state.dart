part of 'tambah_barang_bloc.dart';

abstract class TambahBarangState extends Equatable {
  const TambahBarangState();

  @override
  List<Object> get props => [];
}

class TambahBarangInitial extends TambahBarangState {}

class TambahBarangLoading extends TambahBarangState {}

class TambahBarangDispose extends TambahBarangState {}

class TambahBarangSuccess extends TambahBarangState {
  final String? message;

  const TambahBarangSuccess({required this.message});

  @override
  // TODO: implement props
  List<Object> get props => [message!];
}

class TambahBarangFailed extends TambahBarangState {
  final String? message;

  const TambahBarangFailed({required this.message});

  @override
  // TODO: implement props
  List<Object> get props => [message!];
}
