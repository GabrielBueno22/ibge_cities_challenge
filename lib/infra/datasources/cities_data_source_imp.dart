import 'dart:convert';

import 'package:fpdart/fpdart.dart';
import 'package:ibge_cities_challenge/core/constants/api_constants.dart';
import 'package:ibge_cities_challenge/core/resources/app_error.dart';
import 'package:ibge_cities_challenge/data/datasources/cities_data_source.dart';
import 'package:ibge_cities_challenge/data/models/municipio.dart';
import 'package:ibge_cities_challenge/infra/resources/http_client.dart';
import 'package:ibge_cities_challenge/infra/resources/infra_error.dart';

class CitiesDataSourceImp implements CitiesDataSource {
  final HttpClient httpClient;
  final List<Municipio> cities = [];

  CitiesDataSourceImp({required this.httpClient});
  @override
  Future<Either<AppError, List<Municipio>>> fetchCities() async {
    if (cities.isNotEmpty) {
      await Future.delayed(Duration(milliseconds: 500));
      return Either.right(cities);
    }
    try {
      final result = await httpClient.getApiData(FETCH_CITIES_URL);
      final data = result.match<Either<AppError, List<Municipio>>>(
        (l) => Either.left(l),
        (r) {
          cities.addAll(
              (jsonDecode(r) as List).map((m) => Municipio.fromJson(m)));
          return Either.right(cities);
        },
      );
      return data;
    } on TypeError catch (e) {
      return Either.left(InfraError(message: "Erro ao converter dados da API"));
    } catch (e) {
      return Either.left(InfraError(message: "Ocorreu um erro inesperado"));
    }
  }
}
