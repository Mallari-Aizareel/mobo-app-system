import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SafeArea(
          child: InAppWebView(
            initialUrlRequest: URLRequest(url: WebUri("http://192.168.1.19/mobo/public/portal/login")),
            initialOptions: InAppWebViewGroupOptions(
              android: AndroidInAppWebViewOptions(useHybridComposition: true),
              crossPlatform: InAppWebViewOptions(javaScriptEnabled: true),
            ),
            onWebViewCreated: (controller) {
              print("WebView Created");
            },
            onLoadError: (controller, url, code, message) {
              print("Load error: $message");
            },
            onConsoleMessage: (controller, consoleMessage) {
              print(consoleMessage);
            },
          ),
        ),
      ),
    );
  }
}