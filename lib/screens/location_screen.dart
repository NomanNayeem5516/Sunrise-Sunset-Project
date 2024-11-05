import 'package:flutter/material.dart';
import 'package:sunrisesunset/repository/api_services.dart';

import '../models/jeolocatormodel.dart';
import 'current_location_button.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({super.key});

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  final TextEditingController textEditingController = TextEditingController();
  JeolocatorModel jeolocatorModel = JeolocatorModel();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.brown.withOpacity(0.7),
          title: const Text(
            'Location',
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
        ),
        body: Column(
          children: [
            Row(
              children: [
                Expanded(
                    child: TextField(
                  controller: textEditingController,
                  decoration: const InputDecoration(hintText: "Enter Location"),
                  onChanged: (String value) {
                    print("Object:$value");
                    ApiServices().autoComplitePlace(value).then((value) {
                      jeolocatorModel = value!;
                      setState(() {});
                    }).onError((err, stackTrace) {
                      debugPrint(err.toString());
                    });
                  },
                )),
                const CurrentLocationButton()
              ],
            ),
            Expanded(child: ListView.builder(
              shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount:jeolocatorModel.results?.length??0 ,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Icon(Icons.location_on,color: Colors.red,),
                    title: Text(jeolocatorModel.results?[index].name??""),
                    subtitle: Text(jeolocatorModel.results?[index].country??""),
                  );

            }))
          ],
        ),
      ),
    );
  }
}
