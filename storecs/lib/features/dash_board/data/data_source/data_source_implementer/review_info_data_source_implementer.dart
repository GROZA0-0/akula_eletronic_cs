import 'package:dio/dio.dart';
import 'package:storecs/Core/config/env.dart';
import 'package:storecs/features/dash_board/data/data_source/data_source_repo/review_info_data_source_repo.dart';
import 'package:storecs/features/dash_board/data/model/review_model.dart';

class ReviewInfoDataSourceImplementer implements ReviewInfoDataSourceRepo {
  final Dio dio;
  ReviewInfoDataSourceImplementer({required this.dio});

  @override
  Future<List<ReviewModel>> togetReviewDataSourceRepo() async {
    final getReview = '${Env.baseURL}getOrdersPurchasedHistoryRoute';
    final res = await dio.get(getReview);
    if (res.statusCode == 200) {
      if (res.data == null) {
        return [];
      } else {
        final List<dynamic> list = res.data['data'] ?? [];
        return list.map((order) => ReviewModel.fromJson(order)).toList();
      }
    } else {
      throw Exception(
        "Any issue with fetching reviews info  Server Error: ${res.statusCode}",
      );
    }
  }
}
