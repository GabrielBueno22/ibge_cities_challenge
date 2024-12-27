import 'package:bloc/bloc.dart';
import 'package:ibge_cities_challenge/core/constants/api_constants.dart';
import 'package:ibge_cities_challenge/core/resources/app_error.dart';
import 'package:ibge_cities_challenge/core/resources/page.dart';
import 'package:ibge_cities_challenge/domain/entities/City.dart';
import 'package:ibge_cities_challenge/domain/usecases/fetch_cities_usecase.dart';

part 'fetch_cities_state.dart';

class FetchCitiesCubit extends Cubit<FetchCitiesState> {
  final FetchCitiesUsecase fetchCitiesUsecase;

  FetchCitiesCubit({required this.fetchCitiesUsecase})
      : super(FetchCitiesInitial());

  fecthCities() async {
    final currentState = state;
    int currentPage = 0;
    var currentCityList = [];

    if (currentState is FetchCitiesSuccess) {
      emit(currentState.copyWith(isLoading: true, errorLoadingNextPage: null));
      currentPage = currentState.page.currentPage;
      currentCityList = currentState.cities;
    } else {
      emit(FetchCitiesInProgress());
    }
    final result =
        await fetchCitiesUsecase.fetchCities(currentPage, PAGES_SIZE);

    result.match(
      (l) {
        if (currentState is FetchCitiesSuccess) {
          emit(
              currentState.copyWith(isLoading: false, errorLoadingNextPage: l));
          return;
        }
        emit(FetchCitiesFailed(appError: l));
      },
      (r) {
        emit(
          FetchCitiesSuccess(
              page: r,
              isLoading: false,
              cities: [...currentCityList, ...r.data]),
        );
      },
    );
  }
}
