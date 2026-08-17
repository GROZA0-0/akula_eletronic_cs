import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:storecs/features/sales_export/domain/repository/export_reports_repo.dart';
import 'package:storecs/features/sales_export/presentation/state_management/export_reports_bloc/export_reports_bloc.dart';
import 'package:storecs/features/sales_export/presentation/widgets/sales_export_widget.dart';

class SalesExportPage extends StatelessWidget {
  const SalesExportPage({super.key});

  @override
  Widget build(BuildContext context) {
    final sl = GetIt.instance;
    return BlocProvider<ExportReportsBloc>(
      create: (context) => ExportReportsBloc(sl<ExportReportsRepo>()),
      /* ..add(ExportReportsBlocEventLoading()), */
      child: SalesExportWidget(),
    );
  }
}
