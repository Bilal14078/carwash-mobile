import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:carwash/assets/assets.dart';
import 'package:carwash/components/map.dart';
import 'package:carwash/components/widgets.dart';
import 'package:carwash/language/locale.dart';
import 'package:flutter/material.dart';

class SearchServiceLocation extends StatefulWidget {
  @override
  _SearchServiceLocationState createState() => _SearchServiceLocationState();
}

class _SearchServiceLocationState extends State<SearchServiceLocation> {
  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        leading: IconButton(
            icon: Icon(Icons.chevron_left),
            onPressed: () {
              Navigator.pop(context);
            }),
        elevation: 0,
        backgroundColor: Theme.of(context).backgroundColor,
        title: Text(
          locale.cancel!,
          style: Theme.of(context).textTheme.bodyText1!.copyWith(
              fontSize: 20, fontWeight: FontWeight.w600, letterSpacing: 1),
        ),
      ),
      body: Stack(children: [
        // Container(
        //   decoration: BoxDecoration(
        //       image: DecorationImage(
        //           image: AssetImage(Assets.map), fit: BoxFit.cover)),
        // ),
        MapPage(),
        SingleChildScrollView(
          child: Container(
            height: 300,
            color: Theme.of(context).backgroundColor,
            child: Column(
              children: [
                Container(
                  color: Theme.of(context).primaryColor,
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: TextFormField(
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          icon: Icon(
                            Icons.search,
                            color: Colors.white,
                          ),
                          hintText: locale.searchLocation,
                          hintStyle: Theme.of(context)
                              .textTheme
                              .bodyText2!
                              .copyWith(fontSize: 15),
                          suffixIcon: Icon(
                            Icons.gps_fixed,
                            color: Colors.grey,
                          ))),
                ),
                SizedBox(
                  height: 10,
                ),
                Column(
                  // mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 5),
                      child: Text(locale.savedAddresses!),
                    ),
                    Container(
                      height: 200,
                      child: ListView.builder(
                        itemCount: 3,
                        itemBuilder: (BuildContext context, int index) {
                          List addresses = [
                            locale.home,
                            locale.office,
                            locale.other
                          ];
                          List icons = [
                            Assets.ic_home,
                            Assets.ic_office,
                            Assets.ic_other_location
                          ];

                          return ListTile(
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 7, horizontal: 15),
                            leading: FadedScaleAnimation(
                              CircleAvatar(
                                radius: 15,
                                backgroundColor: Colors.transparent,
                                backgroundImage: AssetImage(icons[index]),
                              ),
                              durationInMilliseconds: 400,
                            ),
                            title: RadiantGradientMask(
                              child: Text(
                                addresses[index],
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(fontSize: 12),
                              ),
                            ),
                            subtitle: Text(
                              locale.dummyAddress2!,
                              style: Theme.of(context).textTheme.bodyText2,
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
