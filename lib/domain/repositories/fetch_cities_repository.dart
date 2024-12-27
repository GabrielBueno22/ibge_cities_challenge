import 'package:fpdart/fpdart.dart';
import 'package:ibge_cities_challenge/core/resources/app_error.dart';
import 'package:ibge_cities_challenge/domain/entities/City.dart';

abstract class FetchCitiesRepository {
  Future<Either<AppError, List<City>>> fetchCities();
}
