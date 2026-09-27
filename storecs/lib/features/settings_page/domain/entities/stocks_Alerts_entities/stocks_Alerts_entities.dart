import 'package:equatable/equatable.dart';

class StocksAlertsEntities extends Equatable {
  final String category;
  final int threshold;
  final Map<String, bool> stockAlert;
  const StocksAlertsEntities({
    required this.category,
    required this.threshold,
    required this.stockAlert,
  });

  @override
  List<Object?> get props => [category, threshold, stockAlert];
}
