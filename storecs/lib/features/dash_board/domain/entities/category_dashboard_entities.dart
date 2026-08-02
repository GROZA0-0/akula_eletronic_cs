import 'package:equatable/equatable.dart';

class CategoryDashboardEntities extends Equatable {
  final String category;
  final double avgValue;
  const CategoryDashboardEntities({
    required this.avgValue,
    required this.category,
  });

  @override
  List<Object?> get props => [category, avgValue];
}
