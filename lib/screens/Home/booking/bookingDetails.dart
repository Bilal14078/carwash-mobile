import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:carwash/components/widgets.dart';
import 'package:carwash/screens/Home/payment/paymentMethods.dart';
import 'package:carwash/style/colors.dart';
import 'package:flutter/material.dart';
import 'package:carwash/language/locale.dart';
import 'package:carwash/user_preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'bookingItem.dart' as bookingitem;

class BookingDetails extends StatefulWidget {
  final bool newBooking;
  var selectedItems;

  BookingDetails(this.newBooking, this.selectedItems);

  @override
  _BookingDetailsState createState() => _BookingDetailsState();
}

class _BookingDetailsState extends State<BookingDetails> {
  bool switchValue = true;

  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final contactController = TextEditingController();
  final addressController = TextEditingController();
  final brandController = TextEditingController();
  final carModelController = TextEditingController();
  final carNumberController = TextEditingController();
  final messageController = TextEditingController();

  bookingitem.NewBookingItem? bitem = null;
  var userId;
  var userEmail;
  _BookingDetailsState() {}

  Future getUserInfo() async {
    final prefs = await SharedPreferences.getInstance();
    this.userId = prefs.getInt("token");
    this.userEmail = prefs.getString("email");
  }

  @override
  Widget build(BuildContext context) {
    getUserInfo();
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
                              EntryField("First Name", "Enter First Name",
                                  false, firstNameController),
                              SizedBox(
                                height: 15,
                              ),
                              EntryField("Last Name", "Enter Last Name", false,
                                  lastNameController),
                              SizedBox(
                                height: 15,
                              ),
                              EntryField(
                                  locale.contactNumber,
                                  "Enter Contact Number",
                                  false,
                                  contactController),
                              SizedBox(
                                height: 15,
                              ),
                              EntryField(locale.address, "Add Address", false,
                                  addressController),
                              SizedBox(
                                height: 15,
                              ),
                              EntryField("Car Brand", "Add Car Brand", false,
                                  brandController),
                              SizedBox(
                                height: 15,
                              ),
                              EntryField("Model", "Add Car Model", false,
                                  carModelController),
                              SizedBox(
                                height: 15,
                              ),
                              EntryField(
                                  "Registration",
                                  "Add Car Registration ",
                                  false,
                                  carNumberController),
                              SizedBox(
                                height: 15,
                              ),
                              EntryField("Message", "Add your message", false,
                                  messageController),
                              SizedBox(
                                height: 15,
                              ),
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
                                  widget
                                      .selectedItems["selectedVehicle"].title!,
                                  style: whiteFont,
                                ),
                                SizedBox(
                                  height: 2,
                                ),
                                // Text(
                                //   locale.car1Number!,
                                //   style: Theme.of(context)
                                //       .textTheme
                                //       .bodyText2!
                                //       .copyWith(color: subtitle),
                                // )
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
                                  widget.selectedItems["selectedDate"]!,
                                  style: whiteFont,
                                ),
                                SizedBox(
                                  height: 2,
                                ),
                                Text(widget.selectedItems["selectedTime"]!,
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
                                      widget.selectedItems["selectedService"]
                                          .title!,
                                      style: whiteFont,
                                    ),
                                    Text(
                                      "\$" +
                                          widget
                                              .selectedItems["selectedService"]
                                              .price!,
                                      style: whiteFont,
                                    )
                                  ],
                                ),
                                SizedBox(height: 5),
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
                                    "\$" +
                                        widget.selectedItems["selectedService"]
                                            .price!,
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
                                  builder: (context) => PaymentMethods(
                                      new bookingitem.NewBookingItem(
                                          0,
                                          0,
                                          this.userId,
                                          widget
                                              .selectedItems["selectedService"]
                                              .id,
                                          widget
                                              .selectedItems["selectedService"]
                                              .id,
                                          widget.selectedItems["selectedDate"],
                                          widget.selectedItems["selectedTime"],
                                          widget
                                              .selectedItems["selectedService"]
                                              .price,
                                          "Payment by card",
                                          "0h 60min",
                                          widget
                                              .selectedItems["selectedVehicle"]
                                              .title,
                                          this.addressController.text,
                                          this.brandController.text,
                                          this.carModelController.text,
                                          1,
                                          this.messageController.text,
                                          this.carNumberController.text,
                                          21.23121,
                                          23.232131))));
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
