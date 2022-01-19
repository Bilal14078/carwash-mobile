import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:carwash/assets/assets.dart';
import 'package:carwash/components/widgets.dart';
import 'package:carwash/components/constants.dart';
import 'package:flutter/material.dart';
import 'package:carwash/language/locale.dart';

class MyProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;
    var safeHeight = MediaQuery.of(context).size.height -
        AppBar().preferredSize.height -
        MediaQuery.of(context).padding.top;
    return Scaffold(
      appBar: appBar(context, locale.profile!),
      body: FadedSlideAnimation(
        SingleChildScrollView(
          child: Container(
            height: safeHeight,
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            // color: Theme.of(context).backgroundColor,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Stack(
                  alignment: Alignment.topRight,
                  children: [
                    FadedScaleAnimation(
                      CircleAvatar(
                        backgroundImage: AssetImage(
                          Assets.profile,
                        ),
                        radius: 60,
                      ),
                      durationInMilliseconds: 400,
                    ),
                    Container(
                        alignment: Alignment.center,
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            gradient: gradient),
                        child: Icon(
                          Icons.camera_alt,
                          color: Colors.white,
                          size: 15,
                        )),
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                Column(
                  children: [
                    EntryField(locale.fullName, locale.enterName, false, null),
                    SizedBox(
                      height: 10,
                    ),
                    EntryField(
                        locale.emailAddress, locale.emailAddress, false, null),
                    SizedBox(
                      height: 10,
                    ),
                    EntryField(
                        locale.phoneNumber, locale.phoneNumber, false, null),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        beginOffset: Offset(0, 0.3),
        endOffset: Offset(0, 0),
        slideCurve: Curves.linearToEaseOut,
      ),
    );
  }
}
