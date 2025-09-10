import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:permission_handler/permission_handler.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Permission.camera.request();

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
          child: WebViewContainer(),
        ),
      ),
    );
  }
}

class WebViewContainer extends StatefulWidget {
  const WebViewContainer({Key? key}) : super(key: key);

  @override
  State<WebViewContainer> createState() => _WebViewContainerState();
}

class _WebViewContainerState extends State<WebViewContainer> {
  late InAppWebViewController webViewController;

  @override
  Widget build(BuildContext context) {
    return InAppWebView(
      initialUrlRequest: URLRequest(
        url: WebUri("http://192.168.1.19/mobo/public/portal/login"),
      ),
      initialOptions: InAppWebViewGroupOptions(
        android: AndroidInAppWebViewOptions(
          useHybridComposition: true,
          mediaPlaybackRequiresUserGesture: false,
        ),
        crossPlatform: InAppWebViewOptions(
          javaScriptEnabled: true,
        ),
      ),
      onWebViewCreated: (controller) {
        webViewController = controller;
        print("WebView Created");
      },

      onPermissionRequest: (controller, request) async {
        print("Permission requested: ${request.resources}");
        return PermissionRequestResponse(
          resources: request.resources,
          action: PermissionRequestResponseAction.GRANT,
        );
      },

      onLoadError: (controller, url, code, message) {
        print("Load error: $message");
      },

      onConsoleMessage: (controller, consoleMessage) {
        print("Console: ${consoleMessage.message}");
      },
    );
  }
}
