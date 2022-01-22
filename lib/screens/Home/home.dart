import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:carwash/assets/assets.dart';
import 'package:carwash/components/constants.dart';
import 'package:carwash/components/map.dart';
import 'package:carwash/components/widgets.dart';
import 'package:carwash/language/locale.dart';
import 'package:carwash/screens/Drawer/drawer.dart';
import 'package:carwash/screens/Home/addCar/addCar.dart';
import 'package:carwash/screens/Home/booking/bookingDetails.dart';
import 'package:carwash/screens/Home/bookingConfirmed/bookingConfirmed.dart';
import 'package:carwash/screens/Home/carWashShopDetails/shopDetails2.dart';
import 'package:carwash/screens/Home/serviceLocation/serviceLocation.dart';
import 'package:carwash/screens/Home/storeBanner.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:carwash/style/colors.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'dart:convert';

import 'dart:io';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<VehicleItem> companyCars = [];
  List<ServiceItem> companyServices = [];
  VehicleItem? selectedCar = null;
  ServiceItem? selectedService = null;
  var selectedDate = null;
  var selectedTime = null;
  _HomeScreenState() {
    getSelectedCompanyCars();
    getSelectedCompanyServices();
  }

  Future getSelectedCompanyCars() async {
    final prefs = await SharedPreferences.getInstance();
    var userId = prefs.getInt("token");
    var url = Uri.parse(
        'https://carwash-back.herokuapp.com/company/v1/vehicle_types.json');
    var response = await http.get(url);
    var jsonResult = jsonDecode(response.body);
    print(jsonResult);
    List<VehicleItem> vehicleItemList = [];
    for (var b in jsonResult) {
      VehicleItem bitem = VehicleItem(b['id'], b['title'], b['image']);
      vehicleItemList.add(bitem);
    }
    this.companyCars = vehicleItemList;
    return vehicleItemList;
  }

  Future getSelectedCompanyServices() async {
    final prefs = await SharedPreferences.getInstance();
    var companyId = prefs.getInt("token");
    var url =
        Uri.parse('https://carwash-back.herokuapp.com/company/v1/services');
    var response = await http.get(url);
    var jsonResult = jsonDecode(response.body);
    print(jsonResult);
    List<ServiceItem> serviceItemList = [];
    for (var b in jsonResult) {
      ServiceItem bitem = ServiceItem(
          b['id'],
          b['title'],
          b['description'],
          b['duration'],
          b['price'],
          b['created_at'],
          b['updated_at'],
          b['company_id']);
      serviceItemList.add(bitem);
    }
    this.companyServices = serviceItemList;
    return serviceItemList;
  }

  List time = [
    "09:00",
    "10:00",
    "11:00",
    "12:00",
    "01:00",
    "02:00",
    "03:00",
    "04:00",
    "05:00",
    "06:00"
  ];
  String? car = "";
  String? service = "";
  String whenDate = "";
  String? whenTime = "";
  bool selectCar = false;
  bool selectServices = false;
  bool selectWhen = false;
  bool selectLocation = false;
  bool markerSelected = false;

  int? group;
  int currentIndex = -1;
  int currentDateIndex = -1;
  int currentTimeIndex = -1;

  Color iconColor = Color(0xff29ee86);

  showValidationError() {
    EasyLoading.showError(
        'select vehicle, service & datetime before continuing');

    // Future.delayed(const Duration(milliseconds: 2000), () {
    //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    //       content: Text(
    //           "Please select vehicle, service & datetime before continuing."),
    //       backgroundColor: Colors.red));

    //   setState(() {
    //     // Here you can write your code for open new view
    //   });
    // });

    // WidgetsBinding.instance?.addPostFrameCallback((_) => setState(() {
    //       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    //           content: Text(
    //               "Please select vehicle, service & datetime before continuing."),
    //           backgroundColor: Colors.red));
    //     }));
  }

  carsListView(BuildContext context, var height) {
    var locale = AppLocalizations.of(context)!;
    List images = [Assets.car_1, Assets.car_2];
    List cars = [locale.car1, locale.car2];
    List numbers = [locale.car1Number, locale.car2Number];
    return Container(
      height: height,
      color: Theme.of(context).primaryColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
              icon: Icon(
                Icons.arrow_drop_down_outlined,
                color: Colors.white,
              ),
              onPressed: () {
                setState(() {
                  selectCar = false;
                });
              }),
          ListView.builder(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            itemCount: this.companyCars.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                contentPadding: EdgeInsets.all(0),
                leading: FadedScaleAnimation(
                  CircleAvatar(
                    radius: 25,
                    backgroundImage: NetworkImage(
                        'https://carwash-back.herokuapp.com' +
                            this.companyCars[index].image),
                  ),
                  durationInMilliseconds: 400,
                ),
                title: Text(this.companyCars[index].title,
                    style: Theme.of(context).textTheme.bodyText1),
                subtitle:
                    Text('-- --', style: Theme.of(context).textTheme.bodyText2),
                trailing: Radio(
                  activeColor: Color(0xff29ee86),
                  value: index,
                  groupValue: group,
                  onChanged: (dynamic val) {
                    setState(() {
                      group = val;
                      car = this.companyCars[val].title;
                      this.selectedCar = this.companyCars[val];
                    });
                  },
                ),
              );
            },
          ),
          ListTile(
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => AddCar()));
            },
            contentPadding: EdgeInsets.only(right: 12),
            leading: FadedScaleAnimation(
              CircleAvatar(
                backgroundColor: iconBgColor,
                radius: 25,
                child: Icon(Icons.add),
              ),
              durationInMilliseconds: 400,
            ),
            title: Text(locale.addNewCar!,
                style: Theme.of(context).textTheme.bodyText1),
            subtitle: Text(locale.tapToAdd!,
                style: Theme.of(context).textTheme.bodyText2),
            trailing: Icon(
              Icons.add,
              color: Theme.of(context).unselectedWidgetColor,
            ),
          ),
        ],
      ),
    );
  }

  servicesGridView(BuildContext context, var height) {
    var locale = AppLocalizations.of(context)!;
    List services = [
      locale.bodywash,
      locale.interiorCleaning,
      locale.engineDetailing,
      locale.carPolish
    ];
    List icons = [
      Icons.drive_eta,
      Icons.accessible,
      Icons.calendar_view_day,
      Icons.wb_sunny
    ];
    return Container(
      height: height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
              icon: Icon(
                Icons.arrow_drop_down_outlined,
                color: Colors.white,
              ),
              onPressed: () {
                setState(() {
                  selectServices = false;
                });
              }),
          Expanded(
            child: GridView.builder(
              padding: EdgeInsets.zero,
              itemCount: this.companyServices.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 45,
                  childAspectRatio: 0.75),
              itemBuilder: (context, index) {
                return Container(
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            currentIndex = index;
                            service = this.companyServices[index].title;
                            this.selectedService = this.companyServices[index];
                          });
                        },
                        child: currentIndex == index
                            ? FadedScaleAnimation(
                                HomePageIcons(
                                    index < 4 ? icons[index] : icons[0],
                                    35.0,
                                    17.5),
                                durationInMilliseconds: 400,
                              )
                            : FadedScaleAnimation(
                                CircleAvatar(
                                  backgroundColor: iconBgColor,
                                  child: Icon(
                                      index < 4 ? icons[index] : icons[0],
                                      size: 35,
                                      color: Colors.white),
                                  radius: 35,
                                ),
                                durationInMilliseconds: 400,
                              ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        this.companyServices[index].title,
                        style: Theme.of(context).textTheme.bodyText1,
                        textAlign: TextAlign.center,
                      ),
                      Text(
                          locale.approx! +
                              " \$" +
                              this.companyServices[index].price,
                          style: Theme.of(context).textTheme.bodyText2)
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  selectDate(BuildContext context, var height) {
    var locale = AppLocalizations.of(context)!;
    List week = [
      locale.sun,
      locale.mon,
      locale.tue,
      locale.wed,
      locale.thr,
      locale.fri,
      locale.sat
    ];
    return Container(
      height: height,
      child: FadedSlideAnimation(
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
                icon: Icon(
                  Icons.arrow_drop_down_outlined,
                  color: Colors.white,
                ),
                onPressed: () {
                  setState(() {
                    selectWhen = false;
                  });
                }),
            Text(locale.selectDateAndTime!,
                style: Theme.of(context).textTheme.bodyText1),
            SizedBox(
              height: 13,
            ),
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.zero,
                scrollDirection: Axis.horizontal,
                itemCount: 31,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Column(
                      children: [
                        Text("Jan",
                            style: currentDateIndex == index
                                ? Theme.of(context).textTheme.bodyText1
                                : Theme.of(context)
                                    .textTheme
                                    .bodyText2!
                                    .copyWith(fontSize: 15)),
                        SizedBox(
                          height: 10,
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              currentDateIndex = index;
                              whenDate = (index + 1).toString() + " Jan";
                              this.selectedDate = whenDate;
                            });
                          },
                          child: Container(
                            alignment: Alignment.center,
                            height: 50,
                            width: 50,
                            decoration: currentDateIndex == index
                                ? BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    gradient: LinearGradient(colors: [
                                      Color(0xff29ee86),
                                      Color(0xff3fa0d7)
                                    ]))
                                : BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    color: iconBgColor),
                            child: Text(
                              (index + 1).toString(),
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(fontSize: 20),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(week[index % 7])
                      ],
                    ),
                  );
                },
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.zero,
                scrollDirection: Axis.horizontal,
                itemCount: 10,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              currentTimeIndex = index;
                              if (!(whenDate == "")) {
                                whenTime = time[index] + " " + locale.am;
                                this.selectedTime = whenTime;
                              }
                            });
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 15, vertical: 13),
                            decoration: currentTimeIndex == index
                                ? BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    gradient: gradient)
                                : BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    color: iconBgColor),
                            child: Text(
                              time[index],
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(fontSize: 20),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(locale.am!)
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
        beginOffset: Offset(0, 0.3),
        endOffset: Offset(0, 0),
        slideCurve: Curves.linearToEaseOut,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;
    var scaffoldKey = GlobalKey<ScaffoldState>();
    var safeHeight = MediaQuery.of(context).size.height -
        AppBar().preferredSize.height -
        MediaQuery.of(context).padding.vertical;
    return Scaffold(
      key: scaffoldKey,
      drawer: Drawer(child: MyDrawer()),
      body: Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          // Container(
          //   decoration: BoxDecoration(
          //       image: DecorationImage(
          //           image: AssetImage(Assets.map), fit: BoxFit.cover)),
          // ),
          MapPage(),
          Positioned(
            top: safeHeight * 0.4,
            child: Container(
              height: 15,
              width: 15,
              decoration: BoxDecoration(
                  color: iconFgColor,
                  borderRadius: BorderRadius.circular(25),
                  boxShadow: [
                    BoxShadow(
                        color: iconFgColor, blurRadius: 10, spreadRadius: 3),
                  ]),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(
              horizontal: 15,
            ),
            color: Theme.of(context).primaryColor,
            height: selectServices || selectWhen
                ? 520
                : selectCar
                    ? 465
                    : 190,
            padding: EdgeInsets.symmetric(horizontal: 18, vertical: 5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                selectCar
                    ? carsListView(context, 265.0)
                    : selectServices
                        ? servicesGridView(context, 320.0)
                        : selectWhen
                            ? selectDate(context, 320.0)
                            : SizedBox.shrink(),
                selectCar || selectServices || selectWhen
                    ? Divider(
                        height: 8,
                      )
                    : Container(
                        height: 8,
                      ),
                Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                selectCar = !selectCar;
                                selectServices = false;
                                selectWhen = false;
                                selectLocation = false;
                              });
                            },
                            child: selectCar
                                ? FadedScaleAnimation(
                                    HomePageIcons(Icons.drive_eta, 25.0, 15.0),
                                    durationInMilliseconds: 400,
                                  )
                                : FadedScaleAnimation(
                                    CircleAvatar(
                                      backgroundColor:
                                          selectCar ? iconFgColor : iconBgColor,
                                      child: Icon(
                                        Icons.drive_eta,
                                        color: selectCar
                                            ? Colors.white
                                            : iconFgColor,
                                      ),
                                      radius: 28,
                                    ),
                                    durationInMilliseconds: 400,
                                  ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            locale.selectCar!,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                          Text(car!,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2!
                                  .copyWith(fontSize: 11))
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                selectServices = !selectServices;
                                selectCar = false;
                                selectWhen = false;
                                selectLocation = false;
                              });
                            },
                            child: selectServices
                                ? FadedScaleAnimation(
                                    HomePageIcons(Icons.settings, 25.0, 15.0),
                                    durationInMilliseconds: 400,
                                  )
                                : FadedScaleAnimation(
                                    CircleAvatar(
                                      backgroundColor: selectServices
                                          ? iconFgColor
                                          : iconBgColor,
                                      child: Icon(
                                        Icons.settings,
                                        color: selectServices
                                            ? Colors.white
                                            : iconFgColor,
                                      ),
                                      radius: 28,
                                    ),
                                    durationInMilliseconds: 400,
                                  ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            locale.services!,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                          Text(service!,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2!
                                  .copyWith(fontSize: 11))
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                selectWhen = !selectWhen;
                                selectCar = false;
                                selectServices = false;
                                selectLocation = false;
                              });
                            },
                            child: selectWhen
                                ? FadedScaleAnimation(
                                    HomePageIcons(
                                        Icons.calendar_today, 25.0, 15.0),
                                    durationInMilliseconds: 400,
                                  )
                                : FadedScaleAnimation(
                                    CircleAvatar(
                                      backgroundColor: selectWhen
                                          ? iconFgColor
                                          : iconBgColor,
                                      child: Icon(
                                        Icons.calendar_today,
                                        color: selectWhen
                                            ? Colors.white
                                            : iconFgColor,
                                      ),
                                      radius: 28,
                                    ),
                                    durationInMilliseconds: 400,
                                  ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            locale.when!,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                          Text(whenDate + " " + whenTime!,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2!
                                  .copyWith(fontSize: 11))
                        ],
                      ),
                    ),
                  ],
                ),
                // SizedBox(
                //   height: 20,
                // ),
                Divider(
                  color: Colors.grey[800],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          selectLocation = !selectLocation;
                          selectWhen = false;
                          selectCar = false;
                          selectServices = false;
                        });
                      },
                      child: selectLocation
                          ? FadedScaleAnimation(
                              HomePageIcons(Icons.location_on, 25.0, 15.0),
                              durationInMilliseconds: 400,
                            )
                          : FadedScaleAnimation(
                              CircleAvatar(
                                backgroundColor:
                                    selectLocation ? iconFgColor : iconBgColor,
                                child: Icon(
                                  Icons.location_on,
                                  color: selectLocation
                                      ? Colors.white
                                      : iconFgColor,
                                ),
                                radius: 27.5,
                              ),
                              durationInMilliseconds: 400,
                            ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          locale.serviceLocation!,
                          textAlign: TextAlign.start,
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.gps_fixed,
                              color: Colors.grey[800],
                              size: 14,
                            ),
                            Text(
                              locale.dummyAddress1!,
                              overflow: TextOverflow.clip,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2!
                                  .copyWith(fontSize: 11),
                            ),
                          ],
                        ),
                      ],
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SearchServiceLocation()));
                      },
                      icon: Icon(
                        Icons.search,
                        color: Colors.white,
                        size: 18,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          Positioned(
            top: safeHeight * 0.07,
            left: 0,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                  color: Theme.of(context).backgroundColor,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(25),
                      bottomRight: Radius.circular(25))),
              child: IconButton(
                  icon: Icon(
                    Icons.menu,
                    color: iconFgColor,
                  ),
                  onPressed: () {
                    scaffoldKey.currentState!.openDrawer();
                    // showDrawer = !showDrawer;
                  }),
            ),
          ),
          selectLocation
              ? Positioned(
                  top: 155,
                  left: 15,
                  child: FadedScaleAnimation(
                    Container(
                        height: 55,
                        child: Image(image: AssetImage(Assets.mark))),
                    durationInMilliseconds: 400,
                  ))
              : SizedBox.shrink(),
          selectLocation
              ? Positioned(
                  top: 85,
                  left: 200,
                  child: FadedScaleAnimation(
                    Container(
                        height: 55,
                        child: Image(image: AssetImage(Assets.mark))),
                    durationInMilliseconds: 400,
                  ))
              : SizedBox.shrink(),
          selectLocation
              ? Positioned(
                  top: 305,
                  left: 175,
                  child: FadedScaleAnimation(
                    Container(
                        height: 55,
                        child: Image(image: AssetImage(Assets.mark))),
                    durationInMilliseconds: 400,
                  ))
              : SizedBox.shrink(),
          selectLocation
              ? Positioned(
                  top: safeHeight * 0.4,
                  child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => BookingDetails(true, {
                                      "selectedVehicle": this.selectedCar,
                                      "selectedService": this.selectedService,
                                      "selectedDate": this.selectedDate,
                                      "selectedTime": this.selectedTime
                                    })));
                      },
                      child: this.selectedCar != null &&
                              this.selectedService != null &&
                              this.selectedDate != null &&
                              this.selectedTime != null
                          ? QuickWashServices({
                              "selectedVehicle": this.selectedCar,
                              "selectedService": this.selectedService,
                              "selectedDate": this.selectedDate,
                              "selectedTime": this.selectedTime
                            })
                          : showValidationError()))
              : Container()
        ],
      ),
    );
  }
}

class VehicleItem {
  int? id;
  String image = '';
  String title = '';
  VehicleItem(this.id, this.title, this.image);
}

class ServiceItem {
  int? company_id;
  String created_at;
  String description;
  String duration;
  int id;
  String price;
  String title;
  String updated_at;

  ServiceItem(
    this.id,
    this.title,
    this.description,
    this.duration,
    this.price,
    this.created_at,
    this.updated_at,
    this.company_id,
  );
}
