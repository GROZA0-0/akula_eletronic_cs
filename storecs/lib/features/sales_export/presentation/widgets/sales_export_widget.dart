import 'dart:io';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';

import 'package:storecs/Core/styles/alerts.dart';
import 'package:storecs/Core/styles/animations.dart';
import 'package:storecs/Core/styles/colors.dart';
import 'package:storecs/Core/styles/sizes.dart';
import 'package:storecs/Core/styles/text_styles.dart';
import 'package:storecs/features/sales_export/data/model/export_reports_model.dart';
import 'package:storecs/features/sales_export/presentation/state_management/export_reports_bloc/export_reports_bloc.dart';
import 'package:storecs/features/sales_export/presentation/state_management/export_reports_bloc/export_reports_bloc_event.dart';
import 'package:storecs/features/sales_export/presentation/state_management/export_reports_bloc/export_reports_bloc_state.dart';
import 'package:storecs/main.dart';

import 'package:url_launcher/url_launcher.dart';

class SalesExportWidget extends StatefulWidget {
  const SalesExportWidget({super.key});

  @override
  State<SalesExportWidget> createState() => _SalesExportWidgetState();
}

class _SalesExportWidgetState extends State<SalesExportWidget> {
  final _searchController = TextEditingController();
  String selectedCategory = 'all';
  DateTimeRange? _selectedDateRange;
  final Alerts alerts = Alerts(messengerKey);
  ExportReportsModel _buildParams() {
    return ExportReportsModel(
      category: selectedCategory,
      searchQuery: _searchController.text,
      startDate: _selectedDateRange?.start,
      endDate: _selectedDateRange?.end,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: invisible,
        iconTheme: IconThemeData(color: white),
        title: FadeInLeft(child: Text('Export Sales Page', style: textAppBar)),
      ),
      body: FadeInUp(
        child: BlocListener<ExportReportsBloc, ExportReportsBlocState>(
          listener: (context, state) async {
            /* use to get the file path then download it as an execl file */
            Future<void> openInEdge(String filePath) async {
              final uri = Uri.file(filePath);
              if (Platform.isWindows) {
                await Process.run('explorer.exe', [
                  '/select',
                  uri.toFilePath(),
                ]);
              } else {
                if (await canLaunchUrl(uri)) {
                  await launchUrl(uri);
                }
              }
            }

            if (state is ExportReportsBlocStateLoaded) {
              alerts.ifSuccess(state.filePath);
              await openInEdge(state.filePath);
            } else if (state is ExportReportsBlocStateError) {
              alerts.ifErrors('No Data Found');
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                // --- Filter Controls ---
                TextFormField(
                  style: textBodiesStyle,
                  controller: _searchController,
                  decoration: InputDecoration(
                    labelText: 'Search keyword',
                    fillColor: white,
                    labelStyle: textBodiesStyle,
                    prefixIcon: Icon(Iconsax.search_normal, color: white),
                  ),
                ),
                SizedBox(height: size.height * 0.012),

                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        icon: const Icon(Icons.date_range, color: white),
                        label: Text(
                          _selectedDateRange == null
                              ? 'Date Range'
                              : '${_selectedDateRange!.start.toString().split(' ')[0]} - ${_selectedDateRange!.end.toString().split(' ')[0]}',
                          style: textBodiesStyle,
                        ),
                        onPressed: () async {
                          final picked = await showDateRangePicker(
                            context: context,
                            firstDate: DateTime(2020),
                            lastDate: DateTime.now(),
                          );
                          if (picked != null)
                            setState(() => _selectedDateRange = picked);
                        },
                      ),
                    ),
                    const SizedBox(width: 12),
                    InkWell(
                      onTap: () => context.read<ExportReportsBloc>().add(
                        PreviewExportEvent(reportsModel: _buildParams()),
                      ),
                      child: Container(
                        width: size.width * 0.05,
                        decoration: BoxDecoration(
                          border: Border.all(color: white),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Center(
                          child: Text('Preview', style: textBodiesStyle),
                        ),
                      ),
                    ),
                  ],
                ),
                Divider(height: size.height * 0.032),

                // --- Dynamic Content View ---
                Expanded(
                  child: BlocBuilder<ExportReportsBloc, ExportReportsBlocState>(
                    builder: (context, state) {
                      if (state is ExportReportsBlocStateLoading) {
                        return loadingStateBodies();
                      }

                      if (state is ExportReportsBlocStatePreviewed) {
                        if (state.items.isEmpty) {
                          return Center(
                            child: Text(
                              'No records found.',
                              style: textBodiesStyle,
                            ),
                          );
                        }
                        final List<Map<String, dynamic>> itemsList =
                            (state.items as List)
                                .map((e) => Map<String, dynamic>.from(e as Map))
                                .toList();
                        final List<String> allKeys = itemsList
                            .expand((item) => item.keys)
                            .toSet()
                            .toList();
                        /*  print('--- DEBUG PREVIEW DATA ---');
                        print('Total Items: ${itemsList.length}');
                        print('Keys Extracted: $allKeys');
                        if (itemsList.isNotEmpty) {
                          print('First Item Raw Content: ${itemsList.first}');
                        }
                        print('--------------------------'); */

                        return Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: white),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          width: size.width / 1.1,
                          height: size.height / 1.1,
                          child: Column(
                            children: [
                              /* Top Bar with Download Action */
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(
                                      left: size.width * 0.002,
                                      top: size.height * 0.003,
                                    ),
                                    child: Text(
                                      'Found ${state.items.length} records',
                                      style: GoogleFonts.aleo(
                                        color: white,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 24,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(
                                      right: size.width * 0.002,
                                      top: size.height * 0.003,
                                    ),
                                    width: size.width * 0.1,
                                    height: size.height * 0.05,
                                    decoration: BoxDecoration(
                                      color: greenColor,
                                      border: Border.all(color: white),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: InkWell(
                                      onTap: () =>
                                          context.read<ExportReportsBloc>().add(
                                            TriggerExportEvent(
                                              reportsModel: _buildParams(),
                                            ),
                                          ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'Download Excel',
                                            style: textBodiesStyle,
                                          ),
                                          Icon(
                                            Iconsax.document_download,
                                            color: white,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: size.height * 0.0012),

                              /* Data Table Preview */
                              Expanded(
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.vertical,
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: DataTable(
                                      columns: allKeys
                                          .map<DataColumn>(
                                            (String k) => DataColumn(
                                              label: Text(
                                                k.toUpperCase(),
                                                style: textBodiesStyle,
                                              ),
                                            ),
                                          )
                                          .toList(),
                                      rows: itemsList.map<DataRow>((
                                        Map<String, dynamic> row,
                                      ) {
                                        return DataRow(
                                          cells: allKeys.map<DataCell>((
                                            String v,
                                          ) {
                                            final cellValue = row[v];
                                            return DataCell(
                                              Text(
                                                cellValue != null
                                                    ? cellValue.toString()
                                                    : '-',
                                                style: textBodiesStyle,
                                              ),
                                            );
                                          }).toList(),
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      }

                      return Center(
                        child: Text(
                          'Apply filters and tap "Preview" to load data.',
                          style: textBodiesStyle,
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
