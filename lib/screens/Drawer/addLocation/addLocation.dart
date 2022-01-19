import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:carwash/assets/assets.dart';
import 'package:carwash/components/constants.dart';
import 'package:carwash/components/map.dart';
import 'package:carwash/components/widgets.dart';
import 'package:flutter/material.dart';
import 'package:carwash/language/locale.dart';

class AddLocation extends StatefulWidget {
  @override
  _AddLocationState createState() => _AddLocationState();
}

class _AddLocationState extends State<AddLocation> {
  int currentIndex = 0;
  bool home = true;
  bool office = false;
  bool other = false;

  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;
    return FadedSlideAnimation(
      Scaffold(
        appBar: AppBar(
          titleSpacing: 0,
          backgroundColor: Theme.of(context).backgroundColor,
          title: Text(
            locale.cancel!,
          ),
          actions: [
            Center(
                child: RadiantGradientMask(
              child: Text(
                locale.continuee!,
                style: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(fontSize: 17),
              ),
            )),
            SizedBox(
              width: 20,
            )
          ],
        ),
        body: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            // Container(
            //   decoration: BoxDecoration(
            //       image: DecorationImage(
            //           image: AssetImage(Assets.map), fit: BoxFit.cover)),
            // ),
            MapPage(),
            Container(
              height: 260,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              color: Theme.of(context).primaryColor,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(locale.selectAddressType!),
                      Icon(
                        Icons.cancel_outlined,
                        color: Colors.grey[600],
                        size: 15,
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: GestureDetector(
                        onTap: () {
                          setState(() {
                            currentIndex = 0;
                          });
                        },
                        child: locationButtonGradient(context, Assets.ic_home,
                            locale.home!, currentIndex == 0),
                      )),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                          child: GestureDetector(
                        onTap: () {
                          setState(() {
                            currentIndex = 1;
                          });
                        },
                        child: locationButtonGradient(context, Assets.ic_office,
                            locale.office!, currentIndex == 1),
                      )),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                          child: GestureDetector(
                        onTap: () {
                          setState(() {
                            currentIndex = 2;
                          });
                        },
                        child: locationButtonGradient(
                            context,
                            Assets.ic_other_location,
                            locale.other!,
                            currentIndex == 2),
                      ))
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  EntryField(locale.enterAddressDetails, locale.dummyAddress1,
                      false, null),
                  SizedBox(
                    height: 15,
                  ),
                  GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: GradientButton(locale.save))
                ],
              ),
            ),
            Positioned(
              top: 0,
              child: Container(
                color: Theme.of(context).primaryColor,
                width: MediaQuery.of(context).size.width,
                child: ListTile(
                  leading: Icon(
                    Icons.search,
                    color: Colors.white,
                  ),
                  title: Text(
                    locale.serviceLocation!,
                    style: Theme.of(context)
                        .textTheme
                        .subtitle1!
                        .copyWith(fontSize: 15),
                  ),
                  trailing: Icon(
                    Icons.gps_fixed,
                    color: Colors.grey[800],
                  ),
                ),
              ),
            ),
            Positioned(
                top: MediaQuery.of(context).size.height * 0.3,
                child: Container(
                    height: 40, child: Image(image: AssetImage(Assets.mark))))
          ],
        ),
      ),
      beginOffset: Offset(0, 0.3),
      endOffset: Offset(0, 0),
      slideCurve: Curves.linearToEaseOut,
    );
  }
}

Container locationButtonGradient(
    BuildContext context, var icon, String text, bool colored) {
  return Container(
    decoration: colored
        ? BoxDecoration(
            gradient: gradient, borderRadius: BorderRadius.circular(25))
        : BoxDecoration(
            color: Theme.of(context).backgroundColor,
            borderRadius: BorderRadius.circular(25)),
    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 7),
    child: Row(
      children: [
        Expanded(
          child: FadedScaleAnimation(
            Image(
              image: AssetImage(
                icon,
              ),
            ),
            durationInMilliseconds: 400,
          ),
        ),
        SizedBox(
          width: 10,
        ),
        Text(
          text,
          style: Theme.of(context).textTheme.subtitle1!.copyWith(fontSize: 12),
        )
      ],
    ),
  );
}
