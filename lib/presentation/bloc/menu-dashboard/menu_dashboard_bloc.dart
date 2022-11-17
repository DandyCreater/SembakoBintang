import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sembako_bintang/domain/entity/dashboard/menu_entity.dart';
import 'package:sembako_bintang/domain/usecase/dashboard/menu_usecase.dart';

part 'menu_dashboard_event.dart';
part 'menu_dashboard_state.dart';

class MenuDashboardBloc extends Bloc<MenuDashboardEvent, MenuDashboardState> {
  MenuDashboardUseCase menuDashboardUseCase;
  MenuDashboardBloc(this.menuDashboardUseCase) : super(MenuDashboardInitial()) {
    on<FetchMenuDashboard>((event, emit) async {
      emit(MenuDashboardLoading());
      try {
        final result = await menuDashboardUseCase.execute();

        result.fold((failure) {
          emit(MenuDashboardFailed(message: failure.message));
        }, (response) {
          emit(MenuDashboardDispose());
          emit(MenuDashboardSuccess(value: response.oKContentMenu!));
        });
      } catch (e) {
        emit(MenuDashboardFailed(message: "BLOC MENU DASHBOARD ERROR $e"));
      }
    });
  }
}
