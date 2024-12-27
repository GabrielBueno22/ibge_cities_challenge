import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ibge_cities_challenge/domain/entities/City.dart';
import 'package:ibge_cities_challenge/presentation/state/fetch_cities/fetch_cities_cubit.dart';
import 'package:ibge_cities_challenge/presentation/ui/screens/city_details_screen.dart';
import 'package:ibge_cities_challenge/presentation/ui/widgets/city_compact_body.dart';

class ListCitiesScreens extends StatefulWidget {
  const ListCitiesScreens({super.key});

  @override
  State<ListCitiesScreens> createState() => _ListCitiesScreensState();
}

class _ListCitiesScreensState extends State<ListCitiesScreens> {
  final ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    _onFetchCities();
    _scrollController.addListener(_loadNextPage);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _loadNextPage() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent) {
      _onFetchCities();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cidades"),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Padding(
        padding: EdgeInsets.all(8),
        child: BlocBuilder<FetchCitiesCubit, FetchCitiesState>(
          builder: (context, state) {
            if (state is FetchCitiesInProgress) {
              return Center(
                child: CircularProgressIndicator.adaptive(),
              );
            }
            if (state is FetchCitiesFailed) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(state.appError.message),
                    SizedBox(
                      height: 16,
                    ),
                    ElevatedButton(
                        onPressed: _onFetchCities,
                        child: Text("Tentar novamente")),
                  ],
                ),
              );
            }
            if (state is FetchCitiesSuccess) {
              return ListView.builder(
                  controller: _scrollController,
                  itemCount:
                      state.isLoading || state.errorLoadingNextPage != null
                          ? state.cities.length + 1
                          : state.cities.length,
                  itemBuilder: (context, index) {
                    if (index >= state.cities.length) {
                      if (state.isLoading) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                            child: CircularProgressIndicator.adaptive(),
                          ),
                        );
                      }
                      if (state.errorLoadingNextPage != null) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 8,
                            ),
                            Text(state.errorLoadingNextPage!.message),
                            Text("Tente novamente"),
                            SizedBox(
                              height: 16,
                            ),
                            IconButton(
                                onPressed: _onFetchCities,
                                icon: Icon(CupertinoIcons.refresh_thin)),
                            SizedBox(
                              height: 80,
                            ),
                          ],
                        );
                      }
                    }

                    final displayCity = state.cities[index];
                    return CompactCityCard(
                      city: displayCity,
                      onTap: () {
                        _navigateToCictyDetails(displayCity);
                      },
                    );
                  });
            }
            return SizedBox();
          },
        ),
      ),
    );
  }

  _onFetchCities() {
    BlocProvider.of<FetchCitiesCubit>(context).fecthCities();
  }

  _navigateToCictyDetails(City city) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (BuildContext context) => CityDetailsScreen(city: city),
      ),
    );
  }
}

class CompactCityCard extends StatelessWidget {
  final VoidCallback onTap;
  final City city;
  const CompactCityCard({super.key, required this.city, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
          side: BorderSide(color: Colors.black54, width: 0)),
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      elevation: 0,
      child: InkWell(
        onTap: onTap,
        child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            child: CityCompactBody(city: city)),
      ),
    );
  }
}
