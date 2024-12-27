part of 'fetch_cities_cubit.dart';

sealed class FetchCitiesState {}

final class FetchCitiesInitial extends FetchCitiesState {}

final class FetchCitiesInProgress extends FetchCitiesState {}

final class FetchCitiesSuccess extends FetchCitiesState {
  final Page<City> page;
  final bool isLoading;
  final AppError? errorLoadingNextPage;
  final List<City> cities;

  FetchCitiesSuccess(
      {required this.page,
      this.isLoading = false,
      this.errorLoadingNextPage,
      required this.cities});

  FetchCitiesSuccess copyWith(
      {Page<City>? page,
      bool? isLoading,
      AppError? errorLoadingNextPage,
      List<City>? cities}) {
    return FetchCitiesSuccess(
        page: page ?? this.page,
        isLoading: isLoading ?? this.isLoading,
        errorLoadingNextPage: errorLoadingNextPage ?? this.errorLoadingNextPage,
        cities: cities ?? this.cities);
  }
}

final class FetchCitiesFailed extends FetchCitiesState {
  final AppError appError;

  FetchCitiesFailed({required this.appError});
}
