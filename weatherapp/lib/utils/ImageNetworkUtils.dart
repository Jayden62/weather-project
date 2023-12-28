import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ImageNetworkUtils {
  static const LINK_NOT_FOUND = 'assets/image/place_holder.png';

  static String getDefaultName(String? displayName) {
    if (displayName == null || displayName == '') {
      return '';
    }
    List<String> array = displayName.trim().split(' ');
    if (array.length == 1) {
      return array.first.substring(0, 1).toUpperCase();
    }
    String first = array.first;
    String last = array.last;
    return '${first.substring(0, 1).toUpperCase()}${last.substring(0, 1).toUpperCase()}';
  }

  /// Loading image
  static Widget loadAvatarImage(
    String? link, {
    double topLeftRadius = 5.0,
    double topRightRadius = 5.0,
    double bottomLeftRadius = 5.0,
    double bottomRightRadius = 5.0,
    double loadingSize = 20.0,
    BoxFit fit = BoxFit.fill,
    double? height,
    BoxFit decorationFit = BoxFit.fill,
    String failLink = LINK_NOT_FOUND,
    String defaultName = '',
    Color defaultBackgroundColor = const Color(0xFF015EFF),
    Color defaultTextColor = const Color(0xFF015EFF),
    double defaultFontSize = 18,
    FontWeight defaultFontWeight = FontWeight.w600,
  }) {
    if (link == null || link == '') {
      return Container(
        height: height,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(topLeftRadius),
              topRight: Radius.circular(topRightRadius),
              bottomRight: Radius.circular(bottomRightRadius),
              bottomLeft: Radius.circular(bottomLeftRadius)),
          color: defaultBackgroundColor,
        ),
        child: Text(getDefaultName(defaultName),
            style: TextStyle(
                fontWeight: FontWeight.w600,
                color: defaultTextColor,
                fontSize: defaultFontSize)),
      );
    }

    CachedNetworkImage image = CachedNetworkImage(
        fit: fit,
        imageBuilder: (context, imageProvider) => Container(
            height: height,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(height! / 2)),
                image:
                    DecorationImage(image: imageProvider, fit: decorationFit))),
        imageUrl: link,
        placeholder: (context, url) {
          return Container(
              decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.all(Radius.circular(height! / 2))),
              child: Container(
                  child: Image.asset(LINK_NOT_FOUND, fit: decorationFit)));
        },
        errorWidget: (context, url, err) {
          return Container(
              height: height,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: defaultBackgroundColor,
                  borderRadius: BorderRadius.all(Radius.circular(height! / 2))),
              child: Text(defaultName,
                  style: TextStyle(
                      fontSize: defaultFontSize,
                      color: defaultTextColor,
                      fontWeight: FontWeight.w600)));
        });
    return image;
  }

  /// Loading image
  static Widget loadImage(String? link,
      {double topLeftRadius = 8.0,
      double topRightRadius = 8.0,
      double bottomLeftRadius = 8.0,
      double bottomRightRadius = 8.0,
      double loadingSize = 20.0,
      BoxFit fit = BoxFit.cover,
      double? height,
      BoxFit decorationFit = BoxFit.cover,
      String failLink = LINK_NOT_FOUND,
      String shortName = ''}) {
    if (link == null || link == '') {
      return Container(
          height: height,
          width: double.maxFinite,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(topLeftRadius),
                  topRight: Radius.circular(topRightRadius),
                  bottomRight: Radius.circular(bottomRightRadius),
                  bottomLeft: Radius.circular(bottomLeftRadius)),
              image: DecorationImage(
                  image: AssetImage(failLink), fit: decorationFit)));
    }

    CachedNetworkImage image = CachedNetworkImage(
        fit: fit,
        fadeOutDuration: Duration(milliseconds: 300),
        fadeInDuration: Duration(milliseconds: 150),
        imageBuilder: (context, imageProvider) => Container(
            height: height,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(topLeftRadius),
                  topRight: Radius.circular(topRightRadius),
                  bottomRight: Radius.circular(bottomRightRadius),
                  bottomLeft: Radius.circular(bottomLeftRadius)),
              image: DecorationImage(image: imageProvider, fit: decorationFit),
            )),
        imageUrl: link,
        placeholder: (context, url) {
          return Container(
              height: height,
              width: double.maxFinite,
              decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(topLeftRadius),
                      topRight: Radius.circular(topRightRadius),
                      bottomRight: Radius.circular(bottomRightRadius),
                      bottomLeft: Radius.circular(bottomLeftRadius))),
              child: Container(
                  child: Image.asset('assets/image/place_holder.png',
                      color: Color(0xFFF3F3F3))));
        },
        errorWidget: (context, url, err) => Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(topLeftRadius),
                    topRight: Radius.circular(topRightRadius),
                    bottomRight: Radius.circular(bottomRightRadius),
                    bottomLeft: Radius.circular(bottomLeftRadius)),
                image: DecorationImage(
                    image: AssetImage(failLink), fit: decorationFit),
              ),
            ));
    return image;
  }

  /// Loading image with round corner
  static Widget loadAvatarImageAllCorner(String link, double radius,
      {double loadingSize = 20.0,
      BoxFit fit = BoxFit.cover,
      double? height,
      BoxFit decorationFit = BoxFit.cover,
      String failLink = LINK_NOT_FOUND,
      String defaultName = '',
      Color defaultBackgroundColor = const Color(0xFF015EFF),
      Color defaultTextColor = Colors.white,
      double defaultFontSize = 18,
      FontWeight defaultFontWeight = FontWeight.w600}) {
    return loadAvatarImage(link,
        topLeftRadius: radius,
        topRightRadius: radius,
        bottomLeftRadius: radius,
        bottomRightRadius: radius,
        loadingSize: loadingSize,
        height: height,
        fit: fit,
        decorationFit: decorationFit,
        failLink: failLink,
        defaultName: defaultName,
        defaultBackgroundColor: defaultBackgroundColor,
        defaultTextColor: defaultTextColor,
        defaultFontSize: defaultFontSize,
        defaultFontWeight: defaultFontWeight);
  }

  /// Loading image with round corner
  static Widget loadImageAllCorner(
    String link,
    double radius, {
    double loadingSize = 20.0,
    double? height,
    BoxFit fit = BoxFit.cover,
    BoxFit decorationFit = BoxFit.cover,
    String failLink = LINK_NOT_FOUND,
  }) {
    return loadImage(link,
        topLeftRadius: radius,
        topRightRadius: radius,
        bottomLeftRadius: radius,
        bottomRightRadius: radius,
        loadingSize: loadingSize,
        height: height,
        fit: fit,
        decorationFit: decorationFit,
        failLink: failLink);
  }

  // /// Loading image
  // static CachedNetworkImage loadIcon(
  //     String link, {
  //       double loadingSize = 20.0,
  //       double? height,
  //       String failLink = LINK_NOT_FOUND,
  //       double? radius,
  //     }) {
  //   CachedNetworkImage image = CachedNetworkImage(
  //       imageBuilder: (context, imageProvider) => Container(
  //         height: height,
  //         decoration: BoxDecoration(
  //           image: DecorationImage(image: imageProvider),
  //         ),
  //       ),
  //       imageUrl: link,
  //       placeholder: (context, url) {
  //         return _createPreLoadImage(radius);
  //       },
  //       errorWidget: (context, url, err) => Container(
  //         child: Image.asset(failLink),
  //       ));
  //   return image;
  // }

  /// Create preload image
  static Widget _createPreLoadImage(double radius) {
    return Container(
        color: Color(0xFFF3F3F3),
        child: Container(
            margin: EdgeInsets.all(5),
            child: Image.asset('assets/image/logo.png')));
  }
}
