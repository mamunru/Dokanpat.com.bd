import 'package:dokanpat/controllers/cartController.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:get/get.dart';

class WebviewPage extends StatefulWidget {
  WebviewPage({super.key});

  @override
  State<WebviewPage> createState() => _WebviewPageState();
}

class _WebviewPageState extends State<WebviewPage> {
  // String url;
  // _WebviewPageState({required this.url});
  late final WebViewController _controller;
  var loadingPercentage = 0;
  String currenturl = '';

  String url = Get.arguments as String;
  String pagename = Get.parameters['name'].toString();

  @override
  void initState() {
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(NavigationDelegate(
        onPageStarted: (url) {
          setState(() {
            loadingPercentage = 0;
            currenturl = url;

            print(currenturl);
          });
        },
        onProgress: (progress) {
          setState(() {
            loadingPercentage = progress;
          });
        },
        onPageFinished: (url) {
          setState(() {
            loadingPercentage = 100;
          });
        },
        onNavigationRequest: (NavigationRequest request) {
          if (request.url.startsWith(url)) {
            return NavigationDecision.prevent;
          }
          return NavigationDecision.navigate;
        },
      ))
      ..loadRequest(
        Uri.parse(url),
      );
    super.initState();
  }

  callcontroller() async {
    setState(() {
      currenturl = _controller.currentUrl().toString();
    });
    print(currenturl);
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CartController>(builder: (controller) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red,
          centerTitle: true,
          title: Text(pagename),
        ),
        body: Stack(
          children: [
            WebViewWidget(
              controller: _controller,
              //gestureRecognizers: callcontroller(),
            ),
            if (loadingPercentage < 100)
              LinearProgressIndicator(
                value: loadingPercentage / 100.0,
              ),
          ],
        ),
      );
    });
  }
}
