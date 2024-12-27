import 'package:fpdart/fpdart.dart';
import 'package:ibge_cities_challenge/core/resources/app_error.dart';
import 'package:ibge_cities_challenge/data/models/municipio.dart';

abstract class CitiesDataSource {
  Future<Either<AppError, List<Municipio>>> fetchCities();
}
