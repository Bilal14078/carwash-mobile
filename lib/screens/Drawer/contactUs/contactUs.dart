import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:carwash/components/constants.dart';
import 'package:carwash/components/widgets.dart';
import 'package:carwash/language/locale.dart';
import 'package:carwash/screens/Drawer/drawer.dart';
import 'package:carwash/style/colors.dart';
import 'package:flutter/material.dart';

class ContactUs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var scaffoldKey = GlobalKey<ScaffoldState>();
    var locale = AppLocalizations.of(context)!;
    // var safeHeight = MediaQuery.of(context).size.height -
    //     AppBar().preferredSize.height -
    //     MediaQuery.of(context).padding.vertical;
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        titleSpacing: 0,
        leading: IconButton(
            icon: Icon(
              Icons.menu,
              color: iconFgColor,
            ),
            onPressed: () {
              scaffoldKey.currentState!.openDrawer();
            }),
        elevation: 0,
        backgroundColor: Theme.of(context).primaryColor,
      ),
      drawer: MyDrawer(),
      body: FadedSlideAnimation(
        SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(locale.wereHappyToHear!,
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(fontSize: 25)),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          locale.letUsKnowQueriesAndFeedbacks!,
                          style: Theme.of(context)
                              .textTheme
                              .bodyText2!
                              .copyWith(fontSize: 15),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 15, vertical: 15),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(25)),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Icon(
                                    Icons.call,
                                    color: Color(0xff29ee86),
                                    size: 17,
                                  ),
                                ),
                                Expanded(
                                  child: Text(locale.callUs!,
                                      overflow: TextOverflow.ellipsis,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .copyWith(
                                            fontSize: 15,
                                            color: Color(0xff29ee86),
                                          )),
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 15, vertical: 15),
                            decoration: BoxDecoration(
                                gradient: gradient,
                                borderRadius: BorderRadius.circular(25)),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Icon(
                                    Icons.mail,
                                    color: Colors.white,
                                    size: 17,
                                  ),
                                ),
                                Expanded(
                                  child: Text(locale.mailUs!,
                                      overflow: TextOverflow.ellipsis,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .copyWith(fontSize: 15)),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Row(
                      children: [
                        Icon(Icons.mail, color: Color(0xff29ee86)),
                        SizedBox(
                          width: 10,
                        ),
                        Text(locale.sendYourMessage!,
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(fontSize: 17)),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 35),
                      child: Column(
                        children: [
                          EntryField(
                              locale.fullName, locale.dummyName1, false, null),
                          SizedBox(
                            height: 15,
                          ),
                          EntryField(locale.contactNumber, locale.dummyNumber,
                              false, null),
                          SizedBox(
                            height: 15,
                          ),
                          EntryField(locale.yourMessage, locale.writeYourNumber,
                              false, null),
                          SizedBox(
                            height: 15,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: GradientButton(locale.submit),
                    )),
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
