import 'package:flutter/material.dart';
import '../models/rides.dart';

// ignore: must_be_immutable
class RideTile extends StatelessWidget {
  final Rides rides;

  RideTile({required this.rides});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 50),
      child: SizedBox(
        height: 60, // Adjust the height as needed
        width: 100, // Adjust the width as needed
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.circular(12),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              rides.imagePath,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}