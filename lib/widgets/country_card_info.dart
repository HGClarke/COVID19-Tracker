import 'package:covid19_tracker/models/country_card_data.dart';
import 'package:flutter/material.dart';

class CountryInfoCard extends StatelessWidget {
  final CountryCardData data;
  CountryInfoCard(this.data);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.3),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '${data.country} ',
              textAlign: TextAlign.center,
              maxLines: 3,
              style: TextStyle(fontSize: 24),
            ),
            Text(
              '${data.number} cases',
              style: TextStyle(
                fontSize: 22,
              ),
            )
          ],
        ),
      ),
    );
  }
}
