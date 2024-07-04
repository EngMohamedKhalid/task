import 'package:dartz/dartz.dart';
import 'package:task/features/home_feature/domain/repo/home_repo.dart';

import '../../../../../app/error/failures.dart';
import '../../../../../app/usecase/usecase.dart';
import '../../data/models/news_model.dart';

class GetAllNewsUseCase implements UseCase<List<NewsModel>, GetAllNewsUseCaseParams> {
  final HomeRepo repository;

  GetAllNewsUseCase({required this.repository});

  @override
  Future<Either<Failure, List<NewsModel>>> call(GetAllNewsUseCaseParams params) async{
    return await repository.getNews(params.toMap());
  }
}

class GetAllNewsUseCaseParams {
  String? searchKey;
  String? from;
  String? sortBy;
  String? apiKey;
  GetAllNewsUseCaseParams(
      {
        this.searchKey,
         this.from,
         this.sortBy,
         this.apiKey,
      });

  Map<String, String> toMap() {
    final map = {
      "q": searchKey ??"tesla",
      "from": from??"2024-06-04",
      "sortBy": sortBy??"publishedAt",
      "apiKey": apiKey??"f5348dfe89124e5cb2ec4a939d1faae1",
    };
    return map;
  }
}