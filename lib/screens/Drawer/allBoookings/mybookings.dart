import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:carwash/assets/assets.dart';
import 'package:carwash/components/constants.dart';
import 'package:carwash/components/widgets.dart';
import 'package:carwash/screens/Home/addReview/addReview.dart';
import 'package:carwash/screens/Home/booking/bookingDetails.dart';
import 'package:carwash/screens/Home/storeBanner.dart';
import 'package:flutter/material.dart';
import 'package:carwash/language/locale.dart';

class MyBookings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: appBar(context, locale.myBookings!),
      body: Container(
        child: ListView.builder(
          itemCount: 5,
          itemBuilder: (BuildContext context, int index) {
            List title = [
              locale.dummyStore1,
              locale.dummyStore2,
              locale.dummyStore1,
              locale.dummyStore2,
              locale.dummyStore1
            ];

            return Stack(
                alignment: isDirectionRTL(context)
                    ? Alignment.topLeft
                    : Alignment.topRight,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(Assets.card_bg), fit: BoxFit.cover),
                    ),
                    child: Column(
                      children: [
                        ListTile(
                          leading: FadedScaleAnimation(
                            CircleAvatar(
                              backgroundImage: AssetImage(Assets.layer_4),
                            ),
                            durationInMilliseconds: 400,
                          ),
                          title: Text(title[index],
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(fontSize: 18)),
                          subtitle: Text(locale.dummyAddress1!,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2!
                                  .copyWith(fontSize: 12)),
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 73),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(locale.bookingFor!),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  Text(locale.car1!,
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
                                  Text(locale.datetime!),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  Text(locale.dummyTime!,
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
                                  Text(locale.bookingFor!),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  Text(locale.carPolish!,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .copyWith(fontSize: 13))
                                ],
                              ),
                              // SizedBox(
                              //   height: 20,
                              // ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      if (index % 2 == 0)
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => BookingDetails(false)));
                      else
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AddReview()));
                    },
                    child: FadedScaleAnimation(
                      Container(
                        margin: EdgeInsets.only(
                            right: isDirectionRTL(context) ? 0 : 30,
                            left: isDirectionRTL(context) ? 30 : 0),
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        decoration: BoxDecoration(
                            gradient: gradient,
                            borderRadius: BorderRadius.circular(50)),
                        child: Text(
                          index % 2 == 0 ? locale.viewMore! : locale.rateNow!,
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(fontSize: 12),
                        ),
                      ),
                      durationInMilliseconds: 400,
                    ),
                  )
                ]);
          },
        ),
      ),
    );
  }
}
