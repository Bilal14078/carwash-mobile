import 'package:carwash/screens/Home/booking/bookingDetails.dart';
import 'package:flutter/material.dart';
import 'package:carwash/components/widgets.dart';
import 'package:carwash/language/locale.dart';

class Services extends StatefulWidget {
  @override
  _ServicesState createState() => _ServicesState();
}

class _ServicesState extends State<Services> {
  List checked = [true, false, false, false, false, false, false, false];

  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;
    return Stack(
      children: [
        ListView.builder(
          physics: BouncingScrollPhysics(),
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          itemCount: 8,
          itemBuilder: (BuildContext context, int index) {
            List icons = [
              Icons.drive_eta,
              Icons.accessible,
              Icons.calendar_view_day,
              Icons.wb_sunny,
              Icons.drive_eta,
              Icons.accessible,
              Icons.calendar_view_day,
              Icons.wb_sunny
            ];
            List title = [
              locale.bodywash,
              locale.interiorCleaning,
              locale.engineDetailing,
              locale.carPolish,
              locale.bodywash,
              locale.interiorCleaning,
              locale.engineDetailing,
              locale.carPolish,
            ];
            List price = [
              "\$50",
              "\$70",
              "\$85",
              "\$45",
              "\$50",
              "\$70",
              "\$85",
              "\$45"
            ];

            return Container(
              color: Theme.of(context).backgroundColor,
              child: CheckboxListTile(
                contentPadding:
                    EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                activeColor: Color(0xff29ee86),
                onChanged: (value) {
                  setState(() {
                    checked[index] = value;
                  });
                },
                checkColor: Theme.of(context).backgroundColor,
                value: checked[index],
                secondary: checked[index] == true
                    ? HomePageIcons(icons[index], 25.0, 12.0)
                    : SimpleHomePageIcons(icons[index], 25.0, 12.0),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(child: Text(title[index])),
                    Text(price[index]),
                  ],
                ),
              ),
            );
          },
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => BookingDetails(true, null)));
              },
              child: RectGradientButton(locale.proceedToPay! + " \$120")),
        ),
      ],
    );
  }
}
