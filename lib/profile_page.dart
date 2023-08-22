import 'package:fininfocom/ProfileResponse.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'networking/api_repository.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePage createState() => _ProfilePage();
}

class _ProfilePage extends State<ProfilePage> {

  List<Results> profileList = <Results>[];
  var email = "";
  var dob = "";
  var image = "";
  var userName="";
  var address="";


  @override
  void initState() {
    super.initState();
    hitProfileAPI();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
      ),
      body: profileWidgets(),
    );
  }

  Widget profileWidgets() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 100,
          ),
          Center(
            child: CircleAvatar(
              radius: 75, // Image radius
              backgroundImage: NetworkImage(
                  image),
            ),
          ),
          SizedBox(height: 50),
          Text(
            userName,
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w700,
              fontStyle: FontStyle.normal,
              fontSize: 24,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            address,
            style: const TextStyle(
              color: Colors.black,
              fontStyle: FontStyle.normal,
              fontSize: 16,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            email,
            style: const TextStyle(
              color: Colors.black,
              fontStyle: FontStyle.normal,
              fontSize: 16,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            dob,
            style: const TextStyle(
              color: Colors.black,
              fontStyle: FontStyle.normal,
              fontSize: 16,
            ),
          )
        ],
      ),
    );
  }

  Future<dynamic> hitProfileAPI() async {
    EasyLoading.show(status: 'Loading...');
    ProfileResponse result = await ApiRepository().getProfileData();
    setState(() {
      if (result != null) {
        if (result.results![0].dob?.date != null) {
          var title = result.results![0].name?.title?? "";
          var first = result.results![0].name?.first?? "";
          var last = result.results![0].name?.last?? "";

         userName="$title $first  $last";
          var streetNo= result.results![0].location?.street?.number ?? "";
          var name= result.results![0].location?.street?.name ?? "";
          var city= result.results![0].location?.city ?? "";
          var state= result.results![0].location?.state ?? "";
          var country= result.results![0].location?.country ?? "";
          var postcode= result.results![0].location?.postcode ?? "";

          address="$streetNo, $name, $city, $state, $country, $postcode";
          dob = result.results![0].dob?.date ?? "";
          email = result.results![0].email ?? "";
          image = result.results![0].picture?.thumbnail ?? "";
        }
      }
    }

  );

  EasyLoading.dismiss();

  return

  result

  ;
}

}
