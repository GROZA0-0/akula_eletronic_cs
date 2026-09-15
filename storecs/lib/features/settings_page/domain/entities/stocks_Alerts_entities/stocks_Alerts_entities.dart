import 'package:equatable/equatable.dart';

class StocksAlertsEntities extends Equatable {
  final String category;
  final int threshold;
  const StocksAlertsEntities({required this.category, required this.threshold});

  @override
  List<Object?> get props => [category,threshold];
}
