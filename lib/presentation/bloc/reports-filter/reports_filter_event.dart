part of 'reports_filter_bloc.dart';

abstract class ReportsFilterEvent extends Equatable {
  const ReportsFilterEvent();

  @override
  List<Object> get props => [];
}

class StartFilterByDate extends ReportsFilterEvent{
  final DateTime? startDate;
  final DateTime? endDate;

  const StartFilterByDate({required this.startDate, required this.endDate});

  @override
  // TODO: implement props
  List<Object> get props => [startDate!, endDate!];

}