import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:webview_flutter/webview_flutter.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();

  WebViewController _webViewController;

  Map<String, String> webViewHeaders;

  @override
  void initState() {
    super.initState();
    // Enable hybrid composition.
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 25.0),
      child: WebView(
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (WebViewController webViewController) async {
          _controller.complete(webViewController);
          await setWebViewHeaders();
          webViewController.loadUrl('https://www.bhaskar.com/',
              headers: webViewHeaders);
        },
      ),
    );
  }

  Future setWebViewHeaders() async {
    Map<String, String> headers = new Map();
    /*String token = await Storage().getString(Constants.tokenKey);
    headers[HttpHeaders.authorizationHeader] = 'Bearer $token';

    String deviceId = await Storage().getString(Constants.deviceKey);
    headers["x-device-id"] = deviceId;
    */

    webViewHeaders = headers;
  }
}
