import 'package:fpdart/fpdart.dart';
import 'package:ibge_cities_challenge/core/resources/page.dart';
import 'package:ibge_cities_challenge/domain/entities/City.dart';

abstract class FetchCitiesUsecase {
  Future<Either<dynamic, Page<City>>> fetchCities(
      int currentPage, int pageSize);
}
