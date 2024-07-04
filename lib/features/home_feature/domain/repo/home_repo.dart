import 'package:dartz/dartz.dart';
import 'package:task/features/home_feature/data/models/news_model.dart';

import '../../../../app/error/failures.dart';

abstract class HomeRepo {
  Future<Either<Failure, List<NewsModel>>>getNews(Map<String,String>map);
}