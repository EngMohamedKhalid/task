import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task/app/utils/hanlders/error_state_handler.dart';
import 'package:task/features/home_feature/data/models/news_model.dart';
import 'package:task/features/home_feature/domain/use_cases/get_news_use_case.dart';

import '../../../../../app/utils/get_it_injection.dart';
import '../../../../../app/utils/navigation_helper.dart';

part 'list_one_state.dart';

class ListOneCubit extends Cubit<ListOneState> {
  ListOneCubit() : super(ListOneInitial());
  static ListOneCubit get() => BlocProvider.of(getIt<NavHelper>().navigatorKey.currentState!.context);

  List <NewsModel> ? newsList;

  void getNews({String? searchKey}) async {
    emit(ListOneLoading());
    final result = await getIt<GetAllNewsUseCase>()(
      GetAllNewsUseCaseParams(
        searchKey: searchKey,
      ),
    );
    result.fold((l) {
      errorStateHandler(l);
    }, (r) {
      newsList = r;
      print(newsList?.length??"Not Found");
      emit(ListOneInitial());
    });
  }
}
