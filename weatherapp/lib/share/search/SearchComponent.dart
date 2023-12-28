import 'package:flutter/cupertino.dart';
import 'package:weatherapp/share/search/support/SearchSupport.dart';

class SearchComConstant {
  static const SUPPORT = 'support';
  static const ON_CHANGED = 'on changed';
  static const ON_SUBMITTED = 'on submitted';
  static const ON_SUFFIX_TAP = 'on suffix tap';
}

class SearchComponent extends StatefulWidget {
  final Map? arguments;

  SearchComponent({this.arguments});

  @override
  _SearchComponentState createState() => _SearchComponentState();
}

class _SearchComponentState extends State<SearchComponent> {
  Function(String text)? _onChanged;

  Function(String text)? onSubmitted;

  Function()? _onSuffixTap;

  SearchSupport? _support;

  @override
  void initState() {
    super.initState();
    if (widget.arguments!.containsKey(SearchComConstant.SUPPORT)) {
      _support = widget.arguments![SearchComConstant.SUPPORT];
    }
    if (widget.arguments!.containsKey(SearchComConstant.ON_CHANGED)) {
      _onChanged = widget.arguments![SearchComConstant.ON_CHANGED];
    }
    if (widget.arguments!.containsKey(SearchComConstant.ON_SUBMITTED)) {
      onSubmitted = widget.arguments![SearchComConstant.ON_SUBMITTED];
    }
    if (widget.arguments!.containsKey(SearchComConstant.ON_SUFFIX_TAP)) {
      _onSuffixTap = widget.arguments![SearchComConstant.ON_SUFFIX_TAP];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(
            top: 15, left: 15, right: 15, bottom: _support!.marginBottom),
        child: CupertinoSearchTextField(
            onChanged: _onChanged,
            onSubmitted: onSubmitted,
            onSuffixTap: () {
              _support!.controller!.clear();
              if (_onSuffixTap == null) {
                return;
              }
              _onSuffixTap!();
            },
            padding: EdgeInsets.all(10),
            controller: _support!.controller,
            placeholder: _support!.hintText));
  }
}
