import 'package:equatable/equatable.dart';

class ExportReportsEntities extends Equatable {
  final String category;
  final String searchQuery;
  final DateTime? startDate;
  final DateTime? endDate;

  const ExportReportsEntities({
    required this.category,
    required this.searchQuery,
    required this.startDate,
    required this.endDate,
  });

  @override
  List<Object?> get props => [category, searchQuery, startDate, endDate];
}
