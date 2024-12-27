import 'package:fpdart/fpdart.dart';
import 'package:ibge_cities_challenge/core/resources/app_error.dart';
import 'package:ibge_cities_challenge/data/datasources/cities_data_source.dart';
import 'package:ibge_cities_challenge/data/resources/data_error.dart';
import 'package:ibge_cities_challenge/domain/entities/City.dart';
import 'package:ibge_cities_challenge/domain/repositories/fetch_cities_repository.dart';

class FetchCitiesRepositoryImp implements FetchCitiesRepository {
  final CitiesDataSource fetchCitiesDataSource;

  FetchCitiesRepositoryImp({required this.fetchCitiesDataSource});
  @override
  Future<Either<AppError, List<City>>> fetchCities() async {
    try {
      final result = await fetchCitiesDataSource.fetchCities();
      return result.match<Either<AppError, List<City>>>((l) => Either.left(l),
          (r) => Either.right(r.map((m) => m.toCity()).toList()));
    } on TypeError catch (_) {
      return Either.left(DataError(message: "Erro ao converter dados da API"));
    } catch (e) {
      return Either.left(DataError(message: "Ocorreu um erro inesperado"));
    }
  }
}
