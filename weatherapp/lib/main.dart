import 'package:curl_logger_dio_interceptor/curl_logger_dio_interceptor.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:shimmer/shimmer.dart';
import 'package:weatherapp/api/connector/Connector.dart';
import 'package:weatherapp/api/filter/WeatherFilter.dart';
import 'package:weatherapp/api/result/Error.dart';
import 'package:weatherapp/api/result/Result.dart';
import 'package:weatherapp/api/result/WeatherResult.dart';
import 'package:weatherapp/extension/DateTimeExtension.dart';
import 'package:weatherapp/share/search/SearchComponent.dart';
import 'package:weatherapp/share/search/support/SearchSupport.dart';
import 'package:weatherapp/utils/ColorUtils.dart';
import 'package:weatherapp/utils/ImageNetworkUtils.dart';
import 'package:weatherapp/utils/MessageUtils.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: const MyHomePage(title: 'Weather App'));
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  /// Search support
  SearchSupport _searchSupport = SearchSupport();

  TextEditingController controller = TextEditingController();

  WeatherResult? _weatherResult;

  bool isNotFound = false;

  bool isShimmer = true;

  @override
  void initState() {
    super.initState();
    /**
     * Get weather
     */
    _callWeatherRequest();
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          /// If keyboard is showing
          /// Call this method here to hide soft keyboard when touching outside keyboard.
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Scaffold(
            appBar: null,
            body: Column(children: [
              _createSubHeaderWidget(),
              _createSearchWidget(),
              _createListWidget(),
            ])));
  }

  /// Create list widget
  Widget _createListWidget() {
    List<Widget> listWidget = [];

    if (!isShimmer) {
      if (isNotFound) {
        listWidget.add(createEmptyWidget());
      } else {
        listWidget.add(_createWrapWidget());
      }
    } else {
      listWidget.add(_createWrapShimmer());
    }

    return Expanded(
        child: ListView(children: listWidget, padding: EdgeInsets.zero));
  }

  /// Create empty widget
  Widget createEmptyWidget() {
    return Container(
        margin: EdgeInsets.only(top: 20),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Image.asset('assets/image/empty.png', width: 50, height: 50),
          Container(
              margin: EdgeInsets.only(top: 10),
              child: Text('City not found',
                  style: TextStyle(
                      color: Color(0xFFC3C9D9), fontWeight: FontWeight.w700)))
        ]));
  }

  /// Create wrap shimmer
  Widget _createWrapShimmer() {
    List<Widget> listWidget = [];
    listWidget.add(_createIconShimmer());
    listWidget.add(_createItemShimmer());
    listWidget.add(_createItemShimmer());
    listWidget.add(_createItemShimmer());
    listWidget.add(_createItemShimmer());
    listWidget.add(_createItemShimmer());
    return Container(
        margin: EdgeInsets.all(15),
        padding: EdgeInsets.all(10),
        child: Column(
            children: listWidget, crossAxisAlignment: CrossAxisAlignment.start),
        decoration: BoxDecoration(
            color: Color(0xFFF1F1F1), borderRadius: BorderRadius.circular(8)));
  }

  /// Create icon shimmer
  Widget _createIconShimmer() {
    return Container(
        margin: EdgeInsets.only(top: 5),
        child: Shimmer.fromColors(
            highlightColor: Colors.white,
            baseColor: ColorUtils.shimmer,
            child: Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8)))));
  }

  /// Create item shimmer
  Widget _createItemShimmer() {
    return Container(
        margin: EdgeInsets.only(top: 5),
        child: Shimmer.fromColors(
            highlightColor: Colors.white,
            baseColor: ColorUtils.shimmer,
            child: Container(
                height: 14,
                width: double.maxFinite,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30)))));
  }

  /// Create wrap widget
  Widget _createWrapWidget() {
    if (_weatherResult == null) {
      return Container();
    }
    List<Widget> listWidget = [];
    listWidget.add(_createCurrentWidget());
    listWidget.add(_createCloudyWidget());
    listWidget.add(_createWindWidget());
    listWidget.add(_createRainyWidget());
    listWidget.add(_createSunriseWidget());
    listWidget.add(_createSunsetWidget());
    listWidget.add(_createCoordWidget());


    return Container(
        margin: EdgeInsets.all(15),
        padding: EdgeInsets.all(10),
        child: Column(
            children: listWidget, crossAxisAlignment: CrossAxisAlignment.start),
        decoration: BoxDecoration(
            color: Color(0xFFF1F1F1), borderRadius: BorderRadius.circular(8)));
  }

  /// Create coord widget
  Widget _createCoordWidget() {
    String coord =
        '${_weatherResult!.coord!.lat} - ${_weatherResult!.coord!.lon}';
    return Container(
        margin: EdgeInsets.only(top: 10),
        child: Text('Coord":{"coord":$coord}',
            style: TextStyle(fontWeight: FontWeight.w500)));
  }

  /// Create name widget
  Widget _createRainyWidget() {
    String name = _weatherResult!.name!;
    return Container(
        margin: EdgeInsets.only(top: 10),
        child: Text('Name":{"name":$name}',
            style: TextStyle(fontWeight: FontWeight.w500)));
  }

  /// Create sunset widget
  Widget _createSunsetWidget() {
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(
        _weatherResult!.sys!.sunset! * 1000);
    String sunset = dateTime.toStringObj('dd/MM/yyy HH:mm')!;
    return Container(
        margin: EdgeInsets.only(top: 10),
        child: Text('Sunset":{"sunset":$sunset}',
            style: TextStyle(fontWeight: FontWeight.w500)));
  }

  /// Create sunrise widget
  Widget _createSunriseWidget() {
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(
        _weatherResult!.sys!.sunrise! * 1000);
    String sunrise = dateTime.toStringObj('dd/MM/yyy HH:mm')!;
    return Container(
        margin: EdgeInsets.only(top: 10),
        child: Text('Sunrise":{"sunrise":$sunrise}',
            style: TextStyle(fontWeight: FontWeight.w500)));
  }

  /// Create wind widget
  Widget _createWindWidget() {
    int deg = _weatherResult!.wind!.deg!;
    double speed = _weatherResult!.wind!.speed!;
    return Container(
        margin: EdgeInsets.only(top: 10),
        child: Text('Wind":{"speed":$speed,"deg":$deg}',
            style: TextStyle(fontWeight: FontWeight.w500)));
  }

  /// Create cloudy widget
  Widget _createCloudyWidget() {
    int cloudy = _weatherResult!.clouds!.all!;
    return Container(
        margin: EdgeInsets.only(top: 10),
        child: Text('Clouds":{"all":$cloudy}',
            style: TextStyle(fontWeight: FontWeight.w500)));
  }

  /// Create current widget
  Widget _createCurrentWidget() {
    double temp = _weatherResult!.main!.temp!;
    String degree = '${temp.round()} \u00B0 C';
    String icon =
        'http://openweathermap.org/img/w/${_weatherResult!.weather!.first.icon}.png';

    return Container(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Container(
          width: 60,
          height: 60,
          margin: EdgeInsets.only(left: 5),
          child: ImageNetworkUtils.loadImageAllCorner(icon, 0)),
      Text('Temperature : $degree',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
    ]));
  }

  /// Create search widget
  Widget _createSearchWidget() {
    _searchSupport.controller = controller;
    _searchSupport.hintText = 'Find city name or zip code';
    Map args = Map();
    args[SearchComConstant.SUPPORT] = _searchSupport;
    args[SearchComConstant.ON_SUFFIX_TAP] = () {
      controller.clear();
      _callWeatherRequest();
    };
    args[SearchComConstant.ON_SUBMITTED] = (String text) {
      controller.text = text;
      _callWeatherRequest();
    };
    args[SearchComConstant.ON_CHANGED] = (String text) {
      isShimmer = true;
      setState(() {});
    };
    return SearchComponent(arguments: args);
  }

  /// Create sub header widget
  Widget _createSubHeaderWidget() {
    EdgeInsets edgeInsets = MediaQuery.of(context).viewPadding;

    return Container(
        width: double.maxFinite,
        color: ColorUtils.primary,
        padding: EdgeInsets.only(top: edgeInsets.top + 10, bottom: 10),
        child: Container(
            margin: EdgeInsets.only(left: 15, right: 15),
            child: Text('App checking weather',
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.w500))));
  }

  Future<Result> handleRequest(BuildContext context) async {
    BaseOptions options = BaseOptions(
        connectTimeout: Duration(milliseconds: 60000),
        receiveTimeout: Duration(milliseconds: 60000));
    Map<String, dynamic> headers = Map();
    headers['Accept'] = 'application/json';
    options.headers = headers;
    Dio dio = Dio(options);
    dio.interceptors.add(LogInterceptor(responseBody: false));
    dio.interceptors.add(CurlLoggerDioInterceptor(printOnSuccess: true));
    WeatherFilter filter = WeatherFilter();
    LocationData locationData = await Location().getLocation();
    filter.lat = locationData.latitude!.toDouble();
    filter.lon = locationData.longitude!.toDouble();
    filter.appid = '16dfd547240433327df885163558bd96';
    filter.units = 'metric';
    filter.lang = 'vi';
    filter.q = controller.text;
    Result result;
    try {
      Response response = await dio.get(
          'https://api.openweathermap.org/data/2.5/weather',
          queryParameters: filter.toJson());
      result = Result<WeatherResult>();
      result.code = response.statusCode;
      result.data = WeatherResult.fromJson(response.data);
    } on DioException catch (e) {
      result = Connector.instance.handleError(e);
    }
    return result;
  }

  /// Call weather request
  void _callWeatherRequest() async {
    Result<dynamic> result = await handleRequest(context);
    isShimmer = false;
    if (result.isSuccess()) {
      _weatherResult = result.data;
      setState(() {});
    } else if (result.isNotFound()) {
      isNotFound = true;
      setState(() {});
    } else {
      handleAPIRequestError(context, result);
    }
  }

  /// Handle error
  Result handleError(DioException e) {
    Result result = Result();
    if (e.response == null) {
      result.code = ConnectorConstants.NO_INTERNET;
      result.error = Error(code: ConnectorConstants.NO_INTERNET, message: '');
    } else if (e.response!.statusCode == ConnectorConstants.EXPIRED) {
      result.code = ConnectorConstants.EXPIRED;
      result.error = getErrorObj(e.response!);
    } else if (e.response!.statusCode == ConnectorConstants.NOT_FOUND) {
      result.code = ConnectorConstants.NOT_FOUND;
      result.error = Error(code: ConnectorConstants.NOT_FOUND, message: '');
    } else {
      result.code = e.response!.statusCode;
      result.error = getErrorObj(e.response!);
    }
    return result;
  }

  /// Handle API request error
  void handleAPIRequestError(BuildContext context, Result result,
      {Function()? callback, bool isCheckExpire = true}) async {
    if (result.error == null) {
      return;
    }

    if (result.code == ConnectorConstants.NO_INTERNET) {
      MessageUtils.showFailedMessage(context, 'Kết nối mạng không ổn định');
    } else if (result.code == ConnectorConstants.EXPIRED) {
      /// Show message if token expired
      /// Show message if token expired
      MessageUtils.showFailedMessage(context,
          'Phiên đăng nhập đã kết thúc, hệ thống yêu cầu đăng nhập mới');
    } else if (result.code == ConnectorConstants.NOT_FOUND) {
      /// Show message if not found
      MessageUtils.showFailedMessage(context, 'Yêu cầu không thể thực hiện');
    } else if (result.isOtherError()) {
      var error = result.error!;
      String message = 'Lỗi kết nối đến server, bạn hãy thử lại lần sau';
      if (error.message != null) {
        message = error.message!;
      }
      MessageUtils.showFailedMessage(context, message);
    }
  }

  /// Get error object
  Error getErrorObj(Response response) {
//    try {
//      ErrorResponse errorResponse = ErrorResponse.fromJson(response.data);
//      if (errorResponse != null && errorResponse.error != null) {
//        return errorResponse.error;
//      }
//    }catch(Exception e){
    Map<String, dynamic> args = Map();
    args['code'] = response.statusCode;
    args['message'] = response.statusMessage;
    return Error.fromJson(args);
  }
}
