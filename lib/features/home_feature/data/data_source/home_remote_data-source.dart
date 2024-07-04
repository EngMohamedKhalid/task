import 'package:task/features/home_feature/data/models/news_model.dart';

import '../../../../app/network/network_manager.dart';
import '../../../../app/utils/hanlders/remote_data_source_handler.dart';

abstract class HomeRemoteDataSource{
  Future<List<NewsModel>> getNews(Map<String, String> map);
}

class HomeRemoteDataSourceImp implements HomeRemoteDataSource{
  final NetworkManager networkManager;

  HomeRemoteDataSourceImp({required this.networkManager});
  @override
  Future<List<NewsModel>> getNews(Map<String, String> map) async {
    final res = await networkManager.request(
        endPoint: "everything",
        method: RequestMethod.get,
      queryParameters: map
    );
    final data =  await RemoteDataSourceCallHandler()(res);
    if(data is List){
      return data.map((e) => NewsModel.fromJson(e)).toList();
    }
    else{
      return [];
    }
  }

}