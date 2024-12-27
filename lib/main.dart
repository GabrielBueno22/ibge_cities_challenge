import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ibge_cities_challenge/data/datasources/cities_data_source.dart';
import 'package:ibge_cities_challenge/data/repositories/fetch_cities_repository_imp.dart';
import 'package:ibge_cities_challenge/domain/repositories/fetch_cities_repository.dart';
import 'package:ibge_cities_challenge/domain/usecases/fetch_cities_usecase.dart';
import 'package:ibge_cities_challenge/domain/usecases/fetch_cities_usecase_imp.dart';
import 'package:ibge_cities_challenge/infra/datasources/cities_data_source_imp.dart';
import 'package:ibge_cities_challenge/infra/resources/http_client.dart';

import 'presentation/state/fetch_cities/fetch_cities_cubit.dart';
import 'presentation/ui/screens/list_cities_screens.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: MultiRepositoryProvider(
            providers: [
              RepositoryProvider<HttpClient>(
                  create: (context) => HttpClientImp()),
              RepositoryProvider<CitiesDataSource>(
                  create: (context) => CitiesDataSourceImp(
                      httpClient: RepositoryProvider.of(context))),
              RepositoryProvider<FetchCitiesRepository>(
                  create: (context) => FetchCitiesRepositoryImp(
                      fetchCitiesDataSource: RepositoryProvider.of(context))),
              RepositoryProvider<FetchCitiesUsecase>(
                  create: (context) => FetchCitiesUsecaseImp(
                      fetchCitiesRepository: RepositoryProvider.of(context)))
            ],
            child: BlocProvider(
                create: (context) => FetchCitiesCubit(
                    fetchCitiesUsecase: RepositoryProvider.of(context)),
                child: ListCitiesScreens())));
  }
}
