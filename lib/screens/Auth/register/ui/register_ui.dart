import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:carwash/assets/assets.dart';
import 'package:carwash/components/widgets.dart';
import 'package:carwash/language/locale.dart';
import 'package:flutter/material.dart';

import '../../forgotPassword/ui/forgotPassword_ui.dart';

class RegisterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;
    var safeHeight = MediaQuery.of(context).size.height -
        AppBar().preferredSize.height -
        MediaQuery.of(context).padding.top;
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: appBar(context, locale.register!),
      body: FadedSlideAnimation(
        SingleChildScrollView(
          child: Container(
            height: safeHeight,
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
            // color: Theme.of(context).backgroundColor,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Stack(
                  alignment: Alignment.topRight,
                  children: [
                    Container(
                      height: safeHeight * 0.23,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: Image(
                          image: AssetImage(
                            Assets.plc_profile,
                          ),
                          fit: BoxFit.fitHeight,
                        ),
                      ),
                    ),
                    Container(
                        alignment: Alignment.center,
                        height: 27,
                        width: 27,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            gradient: LinearGradient(colors: [
                              Color(0xff29ee86),
                              Color(0xff3fa0d7)
                            ])),
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
                      height: 10,
                    ),
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                GestureDetector(
                  child: GradientButton(locale.continuee),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ForgotPassword()));
                  },
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
