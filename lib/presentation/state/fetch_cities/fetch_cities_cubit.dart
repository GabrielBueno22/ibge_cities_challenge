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
    if (currentState is FetchCitiesSuccess) {
      _onNewPage(currentState);
      return;
    }
    _onFirstFetch();
  }

  _onFirstFetch() async {
    emit(FetchCitiesInProgress());
    final result = await fetchCitiesUsecase.fetchCities(0, PAGES_SIZE);
    result.match(
      (l) {
        emit(FetchCitiesFailed(appError: l));
      },
      (r) {
        emit(
          FetchCitiesSuccess(page: r, isLoading: false, cities: r.data),
        );
      },
    );
  }

  _onNewPage(FetchCitiesSuccess currentState) async {
    int currentPage = currentState.page.currentPage;
    var currentCityList = currentState.cities;
    emit(currentState.copyWith(isLoading: true, errorLoadingNextPage: null));
    currentPage = currentState.page.currentPage;
    final result =
        await fetchCitiesUsecase.fetchCities(currentPage, PAGES_SIZE);
    result.match(
      (l) {
        emit(currentState.copyWith(isLoading: false, errorLoadingNextPage: l));
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
