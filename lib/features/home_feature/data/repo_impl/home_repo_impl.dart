import 'package:dartz/dartz.dart';
import 'package:task/app/error/failures.dart';
import 'package:task/features/home_feature/data/models/news_model.dart';
import 'package:task/features/home_feature/domain/repo/home_repo.dart';

import '../../../../app/network/network_info.dart';
import '../../../../app/utils/hanlders/repo_impl_callhandler.dart';
import '../data_source/home_remote_data-source.dart';

class HomeRepoImpl extends HomeRepo{
  final NetworkInfo networkInfo;
  final HomeRemoteDataSource homeRemoteDataSource;

  HomeRepoImpl({required this.networkInfo, required this.homeRemoteDataSource});
  @override
  Future<Either<Failure, List<NewsModel>>> getNews(Map<String, String> map) async {
    return await RepoImplCallHandler<List<NewsModel>>(networkInfo)(() async {
      return await homeRemoteDataSource.getNews(map);
    });
  }

}