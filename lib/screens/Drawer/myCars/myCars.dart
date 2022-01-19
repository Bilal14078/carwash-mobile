import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:carwash/assets/assets.dart';
import 'package:carwash/components/widgets.dart';
import 'package:carwash/screens/Home/addCar/addCar.dart';
import 'package:flutter/material.dart';
import 'package:carwash/language/locale.dart';

class MyCars extends StatefulWidget {
  @override
  _MyCarsState createState() => _MyCarsState();
}

class _MyCarsState extends State<MyCars> {
  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      floatingActionButton: FloatingActionButton(
        foregroundColor: Colors.white,
        backgroundColor: Color(0xff29ee86),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AddCar()));
        },
        child: FadedScaleAnimation(
          Icon(
            Icons.add,
            size: 35,
          ),
          durationInMilliseconds: 400,
        ),
      ),
      appBar: appBar(context, locale.myCars!),
      body: FadedSlideAnimation(
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: ListView.builder(
              itemCount: 2,
              itemBuilder: (context, index) {
                List cars = [Assets.car_1, Assets.car_2];
                List carName = [locale.car1, locale.car1Model];
                List carBrand = [locale.car2, locale.car2Model];
                List carNumber = [locale.car1Number, locale.car2Number];
                return Container(
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(50)),
                  height: 210,
                  padding: EdgeInsets.symmetric(vertical: 5),
                  child: Stack(
                    alignment: Alignment.bottomLeft,
                    children: [
                      FadedScaleAnimation(
                        Container(
                          foregroundDecoration: BoxDecoration(
                              gradient: LinearGradient(
                            colors: [
                              Colors.transparent,
                              Theme.of(context).backgroundColor
                            ],
                            begin: Alignment.lerp(
                                Alignment.topCenter, Alignment.center, 0.8)!,
                            end: Alignment.lerp(
                                Alignment.center, Alignment.bottomCenter, 0.8)!,
                          )),
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(cars[index]),
                              fit: BoxFit.fitWidth,
                            ),
                          ),
                        ),
                        durationInMilliseconds: 400,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Text(carName[index],
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText1!
                                        .copyWith(fontSize: 18)),
                                SizedBox(
                                  width: 15,
                                ),
                                Text(
                                  ".",
                                  style: TextStyle(
                                      color: Color(0xff29ee86), fontSize: 25),
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                Text(
                                  carBrand[index],
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText2!
                                      .copyWith(fontSize: 13),
                                ),
                              ],
                            ),
                            IconButton(
                                icon:
                                    Icon(Icons.more_vert, color: Colors.white),
                                onPressed: () {})
                          ],
                        ),
                      ),
                      SizedBox(),
                      Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: Text(
                          carNumber[index],
                          textAlign: TextAlign.start,
                        ),
                      ),
                    ],
                  ),
                );
              }),
        ),
        beginOffset: Offset(0, 0.3),
        endOffset: Offset(0, 0),
        slideCurve: Curves.linearToEaseOut,
      ),
    );
  }
}
