import 'package:flutter/material.dart';
import 'package:ibge_cities_challenge/domain/entities/City.dart';
import 'package:ibge_cities_challenge/presentation/ui/widgets/city_compact_body.dart';
import 'package:ibge_cities_challenge/presentation/ui/widgets/text_with_label.dart';

class CityDetailsScreen extends StatelessWidget {
  final City city;
  const CityDetailsScreen({super.key, required this.city});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detalhes"),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: CityCompleteCard(city: city),
    );
  }
}

class CityCompleteCard extends StatelessWidget {
  final City city;
  const CityCompleteCard({super.key, required this.city});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CityCompactBody(city: city),
            SizedBox(
              height: 8,
            ),
            TextWithLabel(label: "Código", value: city.cityCode),
            SizedBox(
              height: 16,
            ),
            Row(
              children: [
                Expanded(
                    flex: 1,
                    child: TextWithLabel(
                        label: "MesoRegião", value: city.mesoRegion)),
                Expanded(
                    flex: 1,
                    child: TextWithLabel(
                        label: "MicroRegião", value: city.microRegion)),
              ],
            )
          ],
        ));
  }
}
