import 'dart:convert';

import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:carwash/assets/assets.dart';
import 'package:carwash/components/constants.dart';
import 'package:carwash/components/widgets.dart';
import 'package:carwash/screens/Home/addReview/addReview.dart';
import 'package:carwash/screens/Home/booking/bookingDetails.dart';
import 'package:carwash/screens/Home/booking/bookingInfo.dart';
import 'package:carwash/screens/Home/storeBanner.dart';
import 'package:carwash/style/colors.dart';
import 'package:flutter/material.dart';
import 'package:carwash/language/locale.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;

class MyBookings extends StatelessWidget {
  var userId, userEmail;
  var resultRecieved = false;

  MyBookings() {
    getUserInfo();
    configLoading();
  }

  Future getUserInfo() async {
    final prefs = await SharedPreferences.getInstance();
    this.userId = prefs.getInt("token");
    this.userEmail = prefs.getString("email");
    //this.getBookings();
  }

  void configLoading() {
    EasyLoading.instance
      ..displayDuration = const Duration(milliseconds: 2000)
      ..indicatorType = EasyLoadingIndicatorType.fadingCircle
      ..loadingStyle = EasyLoadingStyle.dark
      ..indicatorSize = 45.0
      ..radius = 10.0
      ..progressColor = Colors.yellow
      ..backgroundColor = Colors.green
      ..indicatorColor = Colors.yellow
      ..textColor = Colors.yellow
      ..maskColor = Colors.blue.withOpacity(0.5)
      ..userInteractions = true
      ..dismissOnTap = false;
    // ..customAnimation = CustomAnimation();
  }

  Future getBookings() async {
    EasyLoading.show(status: 'loading...');
    var url = Uri.parse(
        'https://carwash-back.herokuapp.com/company/v1/bookings.json');
    var response = await http.get(url);
    var jsonResult = jsonDecode(response.body);
    List<BookingItem> bookingItemList = [];
    var currentUserBookings =
        jsonResult.where((x) => x['user']['id'] == this.userId);
    for (var b in currentUserBookings) {
      var firstname = '';
      if (b['user'] != null) {
        print("First Name = " + firstname);
        firstname = b['user']['first_name'].toString() == "null"
            ? ''
            : b['user']['first_name'].toString();
      }
      var washerName = 'No';
      if (b['washer'] != null) {
        washerName = b['washer']['name'].toString() == "null"
            ? ''
            : b['washer']['name'].toString();
      }
      BookingItem bitem = BookingItem(
          firstname,
          b['vehicle_type'].toString(),
          b['date'].toString(),
          b['time'].toString(),
          b['total'].toString(),
          b['id'],
          '',
          b['washer_id'],
          washerName);
      bookingItemList.add(bitem);
    }
    this.resultRecieved = true;
    return bookingItemList;
  }

  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(locale.myBookings!),
        centerTitle: true,
        actions: [
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 20),
          //   child: Icon(
          //     Icons.history,
          //     color: Colors.grey,
          //     size: 20,
          //   ),
          // )
        ],
      ),
      body: Container(
        child: FutureBuilder(
            future: getBookings(),
            builder: (context, snapshot) {
              if (!snapshot.hasData && this.resultRecieved) {
                EasyLoading.dismiss();
                return Container(
                  child: Center(child: Text("No Data to show...")),
                );
              } else if (snapshot.hasData && this.resultRecieved) {
                EasyLoading.dismiss();
                final data = snapshot.data as List<BookingItem>;
                return ListView.builder(
                  padding: EdgeInsets.only(bottom: 65),
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    BookingInfo(data[index].id)));
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 20),
                        margin:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(Assets.card_bg),
                              fit: BoxFit.cover),
                        ),
                        child: Column(
                          children: [
                            ListTile(
                              leading: FadedScaleAnimation(
                                CircleAvatar(
                                  foregroundImage: AssetImage(data[index]
                                              .image !=
                                          ''
                                      ? data[index].image
                                      : 'assets/placeholder/plc_profile.png'),
                                ),
                                durationInMilliseconds: 400,
                              ),
                              title: Text(data[index].name,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(fontSize: 18)),
                              // subtitle: Padding(
                              //   padding:
                              //       const EdgeInsets.symmetric(vertical: 5),
                              //   child: Text(data[index].name,
                              //       style: Theme.of(context)
                              //           .textTheme
                              //           .bodyText2!
                              //           .copyWith(fontSize: 12)),
                              // ),
                            ),
                            Container(
                              padding: EdgeInsets.only(left: 73),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(locale.selectCarType!,
                                          style: TextStyle(color: subtitle)),
                                      SizedBox(
                                        width: 40,
                                      ),
                                      Text(data[index].vehicle,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1!
                                              .copyWith(fontSize: 13))
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        locale.datetime!,
                                        style: TextStyle(color: subtitle),
                                      ),
                                      SizedBox(
                                        width: 13,
                                      ),
                                      Text(
                                          data[index].date +
                                              " " +
                                              data[index].time,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1!
                                              .copyWith(fontSize: 13))
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text("Price",
                                          style: TextStyle(color: subtitle)),
                                      SizedBox(
                                        width: 50,
                                      ),
                                      Text(data[index].price,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1!
                                              .copyWith(fontSize: 13))
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text("Washer:",
                                          style: TextStyle(color: subtitle)),
                                      SizedBox(
                                        width: 35,
                                      ),
                                      Text(data[index].washerName,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1!
                                              .copyWith(fontSize: 13))
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              } else {
                if (resultRecieved) {
                  EasyLoading.dismiss();
                  return Container(
                    child: Center(child: Text("No Data to show...")),
                  );
                } else {
                  EasyLoading.show(status: 'loading...');

                  return Container(
                    child: Center(child: Text("Fetching Bookings...")),
                  );
                }
              }
            }),
      ),
    );
  }
}

class BookingItem {
  String name, vehicle, date, time, price = '';
  String image = '';
  int id = 0;
  int? washerId;
  String washerName;
  BookingItem(this.name, this.vehicle, this.date, this.time, this.price,
      this.id, this.image, this.washerId, this.washerName);
}
