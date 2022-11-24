part of 'reports_filter_bloc.dart';

abstract class ReportsFilterState extends Equatable {
  const ReportsFilterState();
  
  @override
  List<Object> get props => [];
}

class ReportsFilterInitial extends ReportsFilterState {}

class ReportsFilterLoading extends ReportsFilterState{}

class ReportsFilterSuccess extends ReportsFilterState{
  final List<DataTransactionEntity>? value;

  const ReportsFilterSuccess({required this.value});

  @override
  // TODO: implement props
  List<Object> get props => [value!];
}

class ReportsFilterFailed extends ReportsFilterState{
  final String? message;

  const ReportsFilterFailed({required this.message});

  @override
  // TODO: implement props
  List<Object> get props => [message!];
}