import 'package:fininfocom/RandomImageResponse.dart';
import 'package:fininfocom/profile_page.dart';
import 'package:flutter/material.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'networking/api_repository.dart';

class RandomImage extends StatefulWidget {
  @override
  _RandomImage createState() => _RandomImage();
}

class _RandomImage extends State<RandomImage> {
  var randomImage = "";

  @override
  void initState() {
    super.initState();
    hitRandomAPI();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Random"),
      ),
      body: randomWidgets(),
    );
  }

  Widget randomWidgets() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            height: 250,
            child: ClipRRect(
              child: Image.network(randomImage, fit: BoxFit.fill),
            ),
          ),
        ),
        Expanded(
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: const EdgeInsets.fromLTRB(20, 0, 20, 50),
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  hitRandomAPI();
                },
                style: ElevatedButton.styleFrom(
                    elevation: 5.0,
                    minimumSize: const Size.fromHeight(50),
                    textStyle: const TextStyle(color: Colors.white)),
                child:
                    const Text('Refresh Image'), // trying to move to the bottom
              ),
            ),
          ),
        ),
      ],
    );
  }

  Future<dynamic> hitRandomAPI() async {
    EasyLoading.show(status: 'Loading...');
    RandomImageResponse result = await ApiRepository().getImageData();
    setState(() {
      if (result != null) {
        randomImage = result.message!;
      }
    });
    EasyLoading.dismiss();
    return result;
  }
}
