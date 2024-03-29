import 'package:seller_finalproject/const/const.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart' as intl;
import 'text_style.dart';

AppBar appbarWidget(title) {
  return AppBar(
    backgroundColor: whiteColor,
        automaticallyImplyLeading: false,
        title: boldText(text: title, color: fontGreyDark, size: 16.0),
        actions: [
          boldText(
              text: intl.DateFormat('EEE,MMM d ' 'yyyy').format(DateTime.now()),
              color: fontGreyDark),
          10.widthBox,
        ],
      );
}