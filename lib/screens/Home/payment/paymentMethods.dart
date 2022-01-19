import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:carwash/screens/Home/bookingConfirmed/bookingConfirmed.dart';
import 'package:carwash/style/colors.dart';
import 'package:flutter/material.dart';
import 'package:carwash/components/widgets.dart';
import 'package:carwash/language/locale.dart';

class PaymentMethods extends StatefulWidget {
  @override
  _PaymentMethodsState createState() => _PaymentMethodsState();
}

class _PaymentMethodsState extends State<PaymentMethods> {
  int? group;
  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;
    // var selected = 1;
    List titles = [locale.payPal, locale.creditCard, locale.cashOnDelivery];
    return FadedSlideAnimation(
      Scaffold(
        appBar: AppBar(
          titleSpacing: 0,
          leading: IconButton(
              icon: Icon(
                Icons.chevron_left,
                color: iconFgColor,
              ),
              onPressed: () {
                Navigator.pop(context);
              }),
          title: Text(locale.payment!),
          bottom: PreferredSize(
            preferredSize: Size(MediaQuery.of(context).size.width, 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 70),
                  child: RadiantGradientMask(
                    child: Text(locale.amountPayable! + " \$130.00",
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                              fontSize: 15,
                              color: Color(0xff29ee86),
                            )),
                  ),
                ),
                Text("")
              ],
            ),
          ),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  decoration: BoxDecoration(),
                  child: Text(locale.selectPaymentMethods!,
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(fontSize: 15)),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: 3,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      color: Theme.of(context).backgroundColor,
                      margin: EdgeInsets.symmetric(vertical: 3),
                      child: RadioListTile(
                        title: Text(titles[index],
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(fontSize: 15)),
                        activeColor: Color(0xff29ee86),
                        value: index,
                        groupValue: group,
                        onChanged: (dynamic val) {
                          setState(() {
                            group = val;
                          });
                        },
                      ),
                    );
                  },
                ),
              ],
            ),
            GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => BookingConfirmed()));
                },
                child: RectGradientButton(locale.payNow))
          ],
        ),
      ),
      beginOffset: Offset(0, 0.3),
      endOffset: Offset(0, 0),
      slideCurve: Curves.linearToEaseOut,
    );
  }
}
