import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:carwash/screens/Home/booking/bookingItem.dart';
import 'package:carwash/screens/Home/bookingConfirmed/bookingConfirmed.dart';
import 'package:carwash/style/colors.dart';
import 'package:flutter/material.dart';
import 'package:carwash/components/widgets.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:carwash/language/locale.dart';
import 'package:carwash/screens/Home/booking/bookingItem.dart' as bookingitem;

class PaymentMethods extends StatefulWidget {
  bookingitem.NewBookingItem? _bookingItem = null;

  PaymentMethods(this._bookingItem) {}

  @override
  _PaymentMethodsState createState() => _PaymentMethodsState();
}

class _PaymentMethodsState extends State<PaymentMethods> {
  int? group;

  Future makePayment() async {
    EasyLoading.show(status: 'Processing...');

    var url = Uri.parse('https://carwash-back.herokuapp.com/charge');
    var response = await http.post(url,
        body: {"customer_id": "cus_HesiNM6AX1MnPm", "total": "17800"});
    var jsonResult = jsonDecode(response.body);

    saveBooking();
  }

  Future saveBooking() async {
    widget._bookingItem?.paid = 1;
    var url = Uri.parse('https://carwash-back.herokuapp.com/user/v1/bookings');
    var modal = {
      "booking_address": widget._bookingItem?.booking_address,
      "brand": widget._bookingItem?.brand,
      "date": widget._bookingItem?.date,
      "message": widget._bookingItem?.message,
      "model": widget._bookingItem?.model,
      "package_id": widget._bookingItem?.package_id.toString(),
      "paid": widget._bookingItem?.paid.toString(),
      "paymenttype": "Paiement par carte",
      "service_id": widget._bookingItem?.service_id.toString(),
      "status": "0",
      "time": widget._bookingItem?.time,
      "total": widget._bookingItem?.total,
      "total_duration": widget._bookingItem?.total_duration,
      "user_id": widget._bookingItem?.user_id.toString(),
      "vehicle_number": widget._bookingItem?.vehicle_number,
      "vehicle_type": widget._bookingItem?.vehicle_type,
    };
    var response = await http.post(url, body: modal);
    var jsonResult = jsonDecode(response.body);
    EasyLoading.dismiss();
    // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    //     content: Text("Booking Confirmed"), backgroundColor: Colors.green));
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                BookingConfirmed(json.decode(response.body)['id'])));
  }

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
                  makePayment();
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (context) => BookingConfirmed()));
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
