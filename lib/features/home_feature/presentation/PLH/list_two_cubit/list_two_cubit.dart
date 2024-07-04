import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../app/utils/get_it_injection.dart';
import '../../../../../app/utils/hanlders/error_state_handler.dart';
import '../../../../../app/utils/navigation_helper.dart';
import '../../../data/models/news_model.dart';
import '../../../domain/use_cases/get_news_use_case.dart';
import '../list_one_cubit/list_one_cubit.dart';

part 'list_two_state.dart';

class ListTwoCubit extends Cubit<ListTwoState> {
  ListTwoCubit() : super(ListTwoInitial());

  static ListTwoCubit get() => BlocProvider.of(getIt<NavHelper>().navigatorKey.currentState!.context);

  List <NewsModel> ? newsList;

  void getNews({String? searchKey}) async {
    emit(ListTwoLoading());
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
      emit(ListTwoInitial());
    });
  }
}
