import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:carwash/components/widgets.dart';
import 'package:flutter/material.dart';
import 'package:carwash/language/locale.dart';

class AddCar extends StatefulWidget {
  @override
  _AddCarState createState() => _AddCarState();
}

class _AddCarState extends State<AddCar> {
  String? _car;
  String? _model;
  String? _type;
  Column selectionField(BuildContext context, String label, String title,
      List items, String? value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.bodyText2,
        ),
        DropdownButtonFormField(
          dropdownColor: Theme.of(context).backgroundColor,
          hint: Text(
            title,
            style: Theme.of(context).textTheme.bodyText1,
          ),
          style: Theme.of(context).textTheme.bodyText1,
          items: items.map((item) {
            return DropdownMenuItem(
              value: item,
              child: Container(child: Text(item)),
            );
          }).toList(),
          onChanged: (dynamic newValue) {
            setState(() => value = newValue);
          },
          value: value,
          decoration: InputDecoration(
            enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey[800]!)),
            focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey[800]!)),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;

    List cars = [locale.car1, locale.car2];
    List models = [locale.car1Model, locale.car2Model];
    List type = ['Convertible', 'Sedan'];
    return Scaffold(
      appBar: appBar(context, locale.addCar!),
      body: FadedSlideAnimation(
        SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
            child: Column(
              children: [
                Container(
                  height: 160,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    gradient: LinearGradient(colors: [
                      Theme.of(context).dividerColor,
                      Theme.of(context).primaryColor
                    ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
                  ),
                  child: Center(
                      child: HomePageIcons(Icons.camera_alt, 40.0, 15.0)),
                ),
                SizedBox(
                  height: 25,
                ),
                selectionField(
                    context, locale.selectCarBrand!, locale.car2!, cars, _car),
                SizedBox(
                  height: 10,
                ),
                selectionField(context, locale.selectCarModel!,
                    locale.car2Model!, models, _model),
                SizedBox(
                  height: 10,
                ),
                selectionField(context, locale.selectCarType!,
                    locale.convertible!, type, _type),
                SizedBox(
                  height: 10,
                ),
                EntryField(locale.addCarNumber, locale.car1Number, false, null),
                SizedBox(
                  height: 25,
                ),
                GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: GradientButton(locale.saveCarInfo))
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
