import 'package:flutter/material.dart';
class CurrentLocationButton extends StatelessWidget {
  const CurrentLocationButton({super.key});

  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
      onTap: (){},
      child: Container(
        height: 50,
        width: 50,
        margin: const EdgeInsets.only(left: 20),
        decoration: const BoxDecoration(
            color: Colors.brown, shape: BoxShape.circle),
        child: const Icon(
          Icons.my_location,
          color: Colors.white,
        ),
      ),
    );
  }
}
