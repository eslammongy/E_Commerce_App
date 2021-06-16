import 'package:e_commerce_app/bloc/search_bloc/search_status.dart';
import 'package:e_commerce_app/model/search_model.dart';
import 'package:e_commerce_app/remote/api/dio_servic.dart';
import 'package:e_commerce_app/remote/api/end_point.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchCubit extends Cubit<SearchStatus> {
  SearchCubit() : super(SearchInitialStatus());

  static SearchCubit get(context) => BlocProvider.of(context);

  SearchModel searchModel;

  void getSearchResult(String text) {
    emit(SearchLoadingResultStatus());
    DioServices.postData(
      url: SEARCH,
      token: token,
      data: {
        'text': text,
      },
    ).then((value) {
      searchModel = SearchModel.fromJson(value.data);
      print(searchModel.status);
      emit(SearchSuccessStatus());
    }).catchError((onError) {
      print(onError.toString());
      emit(SearchErrorStatus());
    });
  }
}
