import 'package:dio/dio.dart';
import 'package:storecs/Core/config/env.dart';
import 'package:storecs/features/feedback_page/data/data_source/feedback_data_source_repo/feedback_data_source_repo.dart';
import 'package:storecs/features/feedback_page/data/model/feedback_model.dart';

class GetFeedbackDataSourceImplementer implements GetFeedbackDataSourceRepo {
  final Dio dio;
  GetFeedbackDataSourceImplementer({required this.dio});

  @override
  Future<List<GetFeedbackModel>> getListFeedbackDataSourceRepo() async {
    final getFeedbackList = '${Env.baseURL}getfeedBackRoute';
    final res = await dio.get(getFeedbackList);
    if (res.statusCode == 201 || res.statusCode == 200) {
      if (res.data == null) {
        return [];
      } else {
        final List data = res.data;
        return data.map((e) => GetFeedbackModel.fromJson(e)).toList();
      }
    } else {
      throw Exception(
        "Any issue with fetching list Server Error: ${res.statusCode}",
      );
    }
  }
}
