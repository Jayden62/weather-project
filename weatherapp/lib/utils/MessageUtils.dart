import 'package:flutter/material.dart';

class MessageUtils {
  /// Show success message
  static void showSuccessMessage(BuildContext context, String message) {
    EdgeInsets edgeInsets = MediaQuery.of(context).viewPadding;

    final snackBar = SnackBar(
        dismissDirection: DismissDirection.none,
        content: Row(children: [
          Image.asset('assets/icon/success.png', width: 14, height: 14),
          Expanded(
              child: Container(
                  margin: EdgeInsets.only(left: 10),
                  child: Text(message, style: TextStyle(color: Colors.black))))
        ]),
        padding: EdgeInsets.all(15),
        backgroundColor: Color(0xFFE3F5DF),
        behavior: SnackBarBehavior.floating,
        duration: Duration(milliseconds: 3000),
        margin: EdgeInsets.only(
            left: 15, right: 15, bottom: edgeInsets.bottom + 20),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  /// Show failed message
  static void showFailedMessage(BuildContext context, String message) {
    EdgeInsets edgeInsets = MediaQuery.of(context).viewPadding;
    final snackBar = SnackBar(
        dismissDirection: DismissDirection.none,
        content: Row(children: [
          Image.asset('assets/icon/failed.png', width: 16, height: 16),
          Expanded(
              child: Container(
                  margin: EdgeInsets.only(left: 10),
                  child: Text(message, style: TextStyle(color: Colors.black))))
        ]),
        padding: EdgeInsets.all(15),
        backgroundColor: Color(0xFFF79681),
        behavior: SnackBarBehavior.floating,
        duration: Duration(milliseconds: 2000),
        margin: EdgeInsets.only(
            left: 15, right: 15, bottom: edgeInsets.bottom + 20),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  /// Show warning message
  static void showWarningMessage(BuildContext context, String message) {
    EdgeInsets edgeInsets = MediaQuery.of(context).viewPadding;
    final snackBar = SnackBar(
        dismissDirection: DismissDirection.none,
        content: Row(children: [
          Image.asset('assets/icon/warning.png',
              width: 16, height: 16, color: Colors.white),
          Expanded(
              child: Container(
                  margin: EdgeInsets.only(left: 10),
                  child: Text(message, style: TextStyle(color: Colors.black))))
        ]),
        padding: EdgeInsets.all(15),
        backgroundColor: Color(0xFFFFB90B),
        behavior: SnackBarBehavior.floating,
        duration: Duration(milliseconds: 1500),
        margin: EdgeInsets.only(
            left: 15, right: 15, bottom: edgeInsets.bottom + 20),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  /// Show notification message
  static void showNotificationMessage(BuildContext context) {
    EdgeInsets edgeInsets = MediaQuery.of(context).viewPadding;
    double height = MediaQuery.of(context).size.height;
    double value = height / 4 + (edgeInsets.top);

    if (edgeInsets.top == 59) {
      value = height / 4 + (edgeInsets.top + 20);
    }

    double bottom = height - value;

    final snackBar = SnackBar(
        elevation: 6,
        padding: EdgeInsets.zero,
        content: _tapNotification(),
        backgroundColor: Colors.white,
        behavior: SnackBarBehavior.floating,
        duration: Duration(milliseconds: 1500),
        dismissDirection: DismissDirection.none,
        margin: EdgeInsets.only(left: 10, right: 10, bottom: bottom),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static Widget _tapNotification() {
    return GestureDetector(
        onTap: () {},
        child: Container(
            padding: EdgeInsets.all(12),
            child: Row(children: [
              Image.asset('assets/image/logo.png', width: 30, height: 30),
              Expanded(
                  child: Container(
                      margin: EdgeInsets.only(left: 10),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                                child: Text('Sự kiên',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold))),
                            Container(
                                margin: EdgeInsets.only(top: 5),
                                child: Text('Chi tiết sự kiện',
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500)))
                          ])))
            ])));
  }
}
