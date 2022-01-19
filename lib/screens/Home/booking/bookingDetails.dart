import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:carwash/components/widgets.dart';
import 'package:carwash/screens/Home/payment/paymentMethods.dart';
import 'package:carwash/style/colors.dart';
import 'package:flutter/material.dart';
import 'package:carwash/language/locale.dart';

class BookingDetails extends StatefulWidget {
  final bool newBooking;
  BookingDetails(this.newBooking);

  @override
  _BookingDetailsState createState() => _BookingDetailsState();
}

class _BookingDetailsState extends State<BookingDetails> {
  bool switchValue = true;

  @override
  Widget build(BuildContext context) {
    // var safeHeight = MediaQuery.of(context).size.height -
    //     AppBar().preferredSize.height -
    //     MediaQuery.of(context).padding.vertical;
    var locale = AppLocalizations.of(context)!;
    TextStyle whiteFont =
        Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 14);
    return Scaffold(
      appBar: appBar(context,
          widget.newBooking ? locale.comfirmBooking! : locale.bookingDetails!),
      body: FadedSlideAnimation(
        Stack(
          children: [
            ListView(
              physics: BouncingScrollPhysics(),
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              RadiantGradientMask(
                                child: Text(
                                  locale.serviceProvider!,
                                  style: whiteFont.copyWith(
                                      color: Color(0xff29ee86)),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                locale.dummyStore1!,
                                style: whiteFont,
                              ),
                              SizedBox(
                                height: 2,
                              ),
                              Text(locale.dummyAddress1!,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText2!
                                      .copyWith(color: subtitle))
                            ],
                          ),
                          Divider(),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                RadiantGradientMask(
                                  child: Text(
                                    locale.carSelected!,
                                    style: whiteFont.copyWith(
                                        color: Color(0xff29ee86)),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  locale.car1!,
                                  style: whiteFont,
                                ),
                                SizedBox(
                                  height: 2,
                                ),
                                Text(
                                  locale.car1Number!,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText2!
                                      .copyWith(color: subtitle),
                                )
                              ],
                            ),
                          ),
                          Divider(),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    RadiantGradientMask(
                                      child: Text(
                                        locale.arrangePickupAndDrop! + "(+\$10)",
                                        overflow: TextOverflow.ellipsis,
                                        style: whiteFont.copyWith(
                                            color: Color(0xff29ee86)),
                                      ),
                                    ),
                                    widget.newBooking
                                        ? Container(
                                            height: 5,
                                            // width: 60,
                                            child: Switch(
                                                materialTapTargetSize:
                                                    MaterialTapTargetSize
                                                        .shrinkWrap,
                                                activeColor: iconFgColor,
                                                value: switchValue,
                                                onChanged: (val) {
                                                  setState(() {
                                                    switchValue = val;
                                                  });
                                                }),
                                          )
                                        : SizedBox.shrink()
                                  ],
                                ),
                                SizedBox(
                                  height: 2,
                                ),
                                Text(locale.serviceProviderWillpickup!,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText2!
                                        .copyWith(color: subtitle)),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  locale.selectPickupAddress!,
                                  style: whiteFont.copyWith(fontSize: 11),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      locale.homeb!,
                                      style: whiteFont.copyWith(fontSize: 11),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Flexible(
                                        child: Text(locale.dummyAddress2!,
                                            overflow: TextOverflow.ellipsis,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText2!
                                                .copyWith(color: subtitle))),
                                    widget.newBooking
                                        ? Icon(
                                            Icons.arrow_drop_down,
                                            color: Colors.white,
                                          )
                                        : SizedBox.shrink()
                                  ],
                                )
                              ],
                            ),
                          ),
                          Divider(),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                RadiantGradientMask(
                                  child: Text(
                                    locale.datetime!,
                                    style: whiteFont.copyWith(
                                        color: Color(0xff29ee86)),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  locale.dummyDate1!,
                                  style: whiteFont,
                                ),
                                SizedBox(
                                  height: 2,
                                ),
                                Text(locale.dummyTime1!,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText2!
                                        .copyWith(color: subtitle))
                              ],
                            ),
                          ),
                          Divider(),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                RadiantGradientMask(
                                  child: Text(
                                    locale.servicesSelected!,
                                    style: whiteFont.copyWith(
                                        color: Color(0xff29ee86)),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      locale.bodywash!,
                                      style: whiteFont,
                                    ),
                                    Text(
                                      "\$50",
                                      style: whiteFont,
                                    )
                                  ],
                                ),
                                SizedBox(height: 5),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      locale.interiorCleaning!,
                                      style: whiteFont,
                                    ),
                                    Text(
                                      "\$70",
                                      style: whiteFont,
                                    )
                                  ],
                                ),
                                SizedBox(height: 5),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      locale.pickUpAndDropCharges!,
                                      style: whiteFont,
                                    ),
                                    Text(
                                      "\$10",
                                      style: whiteFont,
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                          Divider(),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  widget.newBooking
                                      ? locale.amountPayable!
                                      : locale.amountPaid!,
                                  style: whiteFont,
                                ),
                                RadiantGradientMask(
                                  child: Text(
                                    "\$130",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText1!
                                        .copyWith(fontSize: 18),
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 70,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            widget.newBooking
                ? Align(
                    alignment: Alignment.bottomCenter,
                    child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PaymentMethods()));
                        },
                        child: RectGradientButton(locale.processToPayment)),
                  )
                : SizedBox.shrink()
          ],
        ),
        beginOffset: Offset(0, 0.3),
        endOffset: Offset(0, 0),
        slideCurve: Curves.linearToEaseOut,
      ),
    );
  }
}
