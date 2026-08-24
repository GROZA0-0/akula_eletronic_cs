import 'package:equatable/equatable.dart';

class TaxRulesEntities extends Equatable {
  final String taxName;
  final int rate;
  final bool appliesTo;
  final String basis;

  const TaxRulesEntities({
    required this.taxName,
    required this.rate,
    required this.appliesTo,
    required this.basis,
  });

  @override
  List<Object?> get props => [taxName, rate, appliesTo, basis];
}
