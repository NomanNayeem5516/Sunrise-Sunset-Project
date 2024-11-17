import 'package:flutter/material.dart';
import 'package:sunrisesunset/repository/api_services.dart';

import '../models/sunrise_sunset_model.dart';

class Homescreen extends StatefulWidget {
  final double lat, lng;
  final String placeName;
  const Homescreen(
      {super.key,
      required this.lat,
      required this.lng,
      required this.placeName});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  SunriseSunsetModel sunriseSunsetModel = SunriseSunsetModel();
  bool loading = true;
  void getSunriseSunset() {
    ApiServices().getSunriseSunset(widget.lat, widget.lng).then((value) {
      sunriseSunsetModel = value!;
      loading = false;
      setState(() {});
    }).onError((err, stackTrace) {
      debugPrint(err.toString());
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text(
          "something went wrong",
          style: TextStyle(color: Colors.red),
        ),
      ));
    });
  }

  @override
  void initState() {
    getSunriseSunset();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.brown.withOpacity(0.7),
        title: Text(
          widget.placeName,
          style: const TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Visibility(
        visible: !loading,
        replacement: const Center(
          child: CircularProgressIndicator(
            color: Colors.brown,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 200,
                width: double.infinity,
                child: Image.network(
                    "https://static.vecteezy.com/system/resources/thumbnails/036/461/445/small_2x/ai-generated-beautiful-sunrise-over-green-meadow-in-the-morning-landscape-with-fog-photo.jpg"),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Text(
                          'SunRise',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        Text(sunriseSunsetModel.results?.sunrise ?? ''),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          'SunSet',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        Text(sunriseSunsetModel.results?.sunset ?? ''),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
