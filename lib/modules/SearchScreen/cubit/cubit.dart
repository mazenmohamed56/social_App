import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:social_app/modules/SearchScreen/cubit/states.dart';
import 'package:social_app/shared/Network/end_points.dart';
import 'package:social_app/shared/Network/local/sharedPreferences.dart';
import 'package:social_app/shared/Network/remote/DioHelper.dart';

class SearchCubit extends Cubit<SearchStates> {
  SearchCubit() : super(SearchInitialState());

  static SearchCubit get(context) => BlocProvider.of(context);

  void search(String text) {
    emit(SearchLoadingState());

    DioHelper.postData(
      url: SEARCH,
      token: CacheHelper.getData(key: 'token'),
      data: {
        'text': text,
      },
    ).then((value) {
      emit(SearchSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(SearchErrorState());
    });
  }
}
