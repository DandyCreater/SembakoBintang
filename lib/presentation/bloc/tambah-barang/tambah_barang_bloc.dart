import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sembako_bintang/domain/usecase/items/tambah_barang_usecase.dart';
import 'package:sembako_bintang/presentation/screen/items/tambah-item/tambah_barang_screen.dart';

part 'tambah_barang_event.dart';
part 'tambah_barang_state.dart';

class TambahBarangBloc extends Bloc<TambahBarangEvent, TambahBarangState> {
  final TambahBarangUseCase tambahBarangUseCase;
  TambahBarangBloc(this.tambahBarangUseCase) : super(TambahBarangInitial()) {
    on<InputBarang>((event, emit) async {
      emit(TambahBarangLoading());

      try {
        final result = await tambahBarangUseCase.execute(
            event.price!, event.productName!, event.imageFile!);
      
      result.fold((failure){
        emit(TambahBarangFailed(message: failure.message));
      }, (response) {
        emit(TambahBarangDispose());
        emit(TambahBarangSuccess(message: response));
      });
      } catch (e) {
        emit(TambahBarangFailed(message: "BLOC TAMBAH BARANG ERROR $e"));
      }
    });
  }
}
