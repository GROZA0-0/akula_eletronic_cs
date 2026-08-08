import 'package:dio/dio.dart';
import 'package:storecs/Core/config/env.dart';
import 'package:storecs/features/issues_or_suggestions/data/data_source/feedback_data_source_repo/feedback_data_source_repo.dart';
import 'package:storecs/features/issues_or_suggestions/data/model/feedback_model.dart';

class FeedbackDataSourceImplementer implements FeedbackDataSourceRepo {
  final Dio dio;
  FeedbackDataSourceImplementer({required this.dio});

  @override
  Future<FeedbackModel> storeReport(
    String empId,
    String empEmail,
    String issue,
    String severity,
    String note,
  ) async {
    final feed = '${Env.baseURL}storeFeedbackRoute';
    final body = {
      'empId': empId,
      'empEmail': empEmail,
      'issue': issue,
      'severity': severity,
      'note': note,
    };
    final res = await dio.post(
      feed,
      data: body,
      options: Options(
        contentType: 'application/json',
        validateStatus: (status) => status! < 600,
      ),
    );

    if (res.statusCode == 200 || res.statusCode == 201) {
      if (res.data == null) {
        return FeedbackModel.emptyFeedback();
      } else {
        final data = res.data;
        return FeedbackModel.fromJson(data);
      }
    } else {
      throw Exception("Any issue with creating feedback ? : ${res.statusCode}");
    }
  }
}
