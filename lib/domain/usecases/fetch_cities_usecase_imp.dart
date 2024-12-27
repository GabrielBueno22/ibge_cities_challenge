import 'package:fpdart/fpdart.dart';
import 'package:ibge_cities_challenge/core/resources/app_error.dart';
import 'package:ibge_cities_challenge/core/resources/page.dart';
import 'package:ibge_cities_challenge/domain/entities/City.dart';
import 'package:ibge_cities_challenge/domain/repositories/fetch_cities_repository.dart';
import 'package:ibge_cities_challenge/domain/usecases/fetch_cities_usecase.dart';

class FetchCitiesUsecaseImp implements FetchCitiesUsecase {
  final FetchCitiesRepository fetchCitiesRepository;

  FetchCitiesUsecaseImp({required this.fetchCitiesRepository});
  @override
  Future<Either<AppError, Page<City>>> fetchCities(
      int currentPage, int pageSize) async {
    final result = await fetchCitiesRepository.fetchCities();
    return result.match<Either<AppError, Page<City>>>(
        (l) => Either.left(l),
        (r) => Either.right(Page<City>(
            currentPage: currentPage + 1,
            isLastPage: r.length / pageSize <= currentPage + 1,
            data: r.sublist(
                currentPage * pageSize, (currentPage + 1) * pageSize))));
  }
}
