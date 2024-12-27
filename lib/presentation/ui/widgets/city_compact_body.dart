import 'package:flutter/material.dart';
import 'package:ibge_cities_challenge/domain/entities/City.dart';

import 'text_with_label.dart';

class CityCompactBody extends StatelessWidget {
  final City city;
  const CityCompactBody({super.key, required this.city});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "${city.name} - ${city.stateInitials}",
          style: Theme.of(context)
              .textTheme
              .bodyLarge!
              .copyWith(fontWeight: FontWeight.w600),
        ),
        SizedBox(
          height: 8,
        ),
        TextWithLabel(label: "Estado", value: city.stateName)
      ],
    );
  }
}
