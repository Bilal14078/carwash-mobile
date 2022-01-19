import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:carwash/assets/assets.dart';
import 'package:carwash/components/widgets.dart';
import 'package:carwash/screens/Drawer/allBoookings/mybookings.dart';
import 'package:flutter/material.dart';
import 'package:carwash/language/locale.dart';

class BookingConfirmed extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;
    return Scaffold(
      body: FadedSlideAnimation(
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
              child: Column(
                children: [
                  FadedScaleAnimation(
                    Container(
                      child: Image(
                        image: AssetImage(Assets.vector_car_image),
                      ),
                    ),
                    durationInMilliseconds: 400,
                  ),
                  Column(
                    children: [
                      Text(locale.bookingConfirmed!,
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(fontSize: 20)),
                      SizedBox(
                        height: 30,
                      ),
                      Text(
                        locale.sitBackAndRelax!,
                        style: Theme.of(context)
                            .textTheme
                            .bodyText2!
                            .copyWith(fontSize: 15),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Text(locale.haveAGreatDay!,
                          style: Theme.of(context)
                              .textTheme
                              .bodyText2!
                              .copyWith(fontSize: 15),
                          textAlign: TextAlign.center)
                    ],
                  )
                ],
              ),
            ),
            GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => MyBookings()));
                },
                child: RectGradientButton(locale.myBookings))
          ],
        ),
        beginOffset: Offset(0, 0.3),
        endOffset: Offset(0, 0),
        slideCurve: Curves.linearToEaseOut,
      ),
    );
  }
}
