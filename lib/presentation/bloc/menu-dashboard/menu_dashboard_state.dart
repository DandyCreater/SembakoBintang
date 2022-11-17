part of 'menu_dashboard_bloc.dart';

abstract class MenuDashboardState extends Equatable {
  const MenuDashboardState();
  
  @override
  List<Object> get props => [];
}

class MenuDashboardInitial extends MenuDashboardState {}

class MenuDashboardLoading extends MenuDashboardState{}

class MenuDashboardDispose extends MenuDashboardState{}

class MenuDashboardSuccess extends MenuDashboardState{
  final OKContentMenuEntity value;

  const MenuDashboardSuccess({required this.value});

  @override
  // TODO: implement props
  List<Object> get props => super.props;
}

class MenuDashboardFailed extends MenuDashboardState{
  final String? message;

  const MenuDashboardFailed({required this.message});

  @override
  // TODO: implement props
  List<Object> get props => [message!];
}

