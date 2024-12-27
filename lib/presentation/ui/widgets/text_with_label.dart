import 'package:flutter/material.dart';

class TextWithLabel extends StatelessWidget {
  final String label;
  final String value;
  const TextWithLabel({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label.toUpperCase(),
          style: Theme.of(context)
              .textTheme
              .bodySmall!
              .copyWith(fontWeight: FontWeight.w700, color: Colors.grey),
        ),
        SizedBox(
          height: 4,
        ),
        Text(
          value,
          style: Theme.of(context)
              .textTheme
              .bodySmall!
              .copyWith(fontWeight: FontWeight.w600, color: Colors.black),
        ),
      ],
    );
  }
}
