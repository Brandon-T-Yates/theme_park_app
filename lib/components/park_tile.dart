import 'package:flutter/material.dart';
import '../models/parks.dart';

// ignore: must_be_immutable
class ParkTile extends StatelessWidget {
  final Parks parks;

  ParkTile({super.key, required this.parks});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 30),
      width: 284,
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
            fit: BoxFit.cover,
            parks.imagePath,
            width: 600,
            height: 700,
            ),
          ),
          Positioned(
            top: 150,
            left: 10,
            child: Text(
              parks.name,
              style: const TextStyle(
                fontSize: 20, 
                fontWeight: FontWeight.bold, 
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}