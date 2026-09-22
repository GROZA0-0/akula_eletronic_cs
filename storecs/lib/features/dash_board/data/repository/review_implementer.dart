import 'dart:convert';

import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:storecs/features/dash_board/data/data_source/data_source_repo/review_info_data_source_repo.dart';
import 'package:storecs/features/dash_board/domain/entities/review_entities.dart';
import 'package:storecs/features/dash_board/domain/repository/review_repo.dart';

class ReviewImplementer implements ReviewRepo {
  final ReviewInfoDataSourceRepo reviewInfoDataSourceRepo;
  ReviewImplementer({required this.reviewInfoDataSourceRepo});
  final reviewStreamControler = BehaviorSubject<List<ReviewEntities>>();

  static const cacheKey = 'cached_reviews';

  @override
  Future<void> reviewInfoLoadCachedData() async {
    final prefs = await SharedPreferences.getInstance();
    final cached = prefs.getString(cacheKey);
    if (cached != null) {
      final List<dynamic> lastData = jsonDecode(cached);
      final entities = lastData
          .map((e) => ReviewEntities.fromCacheJson(e))
          .toList();
      reviewStreamControler.add(entities);
    }
  }

  @override
  /*  persist on every successful fetch */
  Future<void> savedToCachedData(List<ReviewEntities> entities) async {
    final prefs = await SharedPreferences.getInstance();
    final decodedCached = jsonEncode(
      entities.map((e) => e.toCacheJson()).toList(),
    );
    await prefs.setString(cacheKey, decodedCached);
  }

  @override
  Future<List<ReviewEntities>> reviewRepository() async {
    try {
      final model = await reviewInfoDataSourceRepo.togetReviewDataSourceRepo();
      final entity = model.map((e) => e.toReviewEntities()).toList();
      reviewStreamControler.add(entity);

      savedToCachedData(entity);
      return entity;
    } catch (e) {
      // print("any errors in ReviewImplementer $e");
      return reviewStreamControler.valueOrNull ?? [];
    }
  }

  @override
  Stream<List<ReviewEntities>> get reviewStream => reviewStreamControler.stream;
}
