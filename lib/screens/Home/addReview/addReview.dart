import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:carwash/components/widgets.dart';
import 'package:carwash/screens/Home/home.dart';
import 'package:flutter/material.dart';
import 'package:carwash/language/locale.dart';

class AddReview extends StatefulWidget {
  @override
  _AddReviewState createState() => _AddReviewState();
}

class _AddReviewState extends State<AddReview> {
  bool one = false;
  bool two = false;
  bool three = false;
  bool four = false;
  bool five = false;
  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: appBar(context, locale.addReview!),
      body: FadedSlideAnimation(
        SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 50),
            child: Column(
              children: [
                FadedScaleAnimation(
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                          icon: Icon(
                            one ? Icons.star : Icons.star_border,
                            color: one ? Colors.yellow : Colors.grey[600],
                            size: 35,
                          ),
                          onPressed: () {
                            setState(() {
                              one = true;
                              two = false;
                              three = false;
                              four = false;
                              five = false;
                            });
                          }),
                      IconButton(
                          icon: Icon(
                            two ? Icons.star : Icons.star_border,
                            color: two ? Colors.yellow : Colors.grey[600],
                            size: 35,
                          ),
                          onPressed: () {
                            setState(() {
                              one = true;
                              two = true;
                              three = false;
                              four = false;
                              five = false;
                            });
                          }),
                      IconButton(
                          icon: Icon(
                            three ? Icons.star : Icons.star_border,
                            color: three ? Colors.yellow : Colors.grey[600],
                            size: 35,
                          ),
                          onPressed: () {
                            setState(() {
                              one = true;
                              two = true;
                              three = true;
                              four = false;
                              five = false;
                            });
                          }),
                      IconButton(
                          icon: Icon(
                            four ? Icons.star : Icons.star_border,
                            color: four ? Colors.yellow : Colors.grey[600],
                            size: 35,
                          ),
                          onPressed: () {
                            setState(() {
                              one = true;
                              two = true;
                              three = true;
                              four = true;
                              five = false;
                            });
                          }),
                      IconButton(
                          icon: Icon(
                            five ? Icons.star : Icons.star_border,
                            color: five ? Colors.yellow : Colors.grey[600],
                            size: 35,
                          ),
                          onPressed: () {
                            setState(() {
                              one = true;
                              two = true;
                              three = true;
                              four = true;
                              five = true;
                            });
                          }),
                    ],
                  ),
                  durationInMilliseconds: 400,
                ),
                TextFormField(
                  style: Theme.of(context).textTheme.bodyText1,
                  decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey[800]!)),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey[800]!)),
                    hintText: locale.letUsKnowUrFeedbacks,
                    hintStyle: Theme.of(context).textTheme.bodyText2,
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => HomeScreen()));
                    },
                    child: GradientButton(locale.addReview))
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
