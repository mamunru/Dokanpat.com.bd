import 'package:dokanpat/controllers/cartController.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:get/get.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class WebPagePayment extends StatefulWidget {
  const WebPagePayment({super.key});

  @override
  State<WebPagePayment> createState() => _WebPagePaymentState();
}

class _WebPagePaymentState extends State<WebPagePayment> {
  late final WebViewController _controller;
  var loadingPercentage = 0;
  String currenturl = '';
  CartController _cartController = Get.find();

  void handleUrlChanged(String url) {
    // print(url);
    if (url.contains('/order-received/')) {
      final items = url.split('/order-received/');
      if (items.length > 1) {
        final number = items[1].split('/')[0];
        // print(url);

        _cartController.updateOrder();

        // Navigator.of(context).pop();
      }
    }
    if (url.contains('checkout/success')) {
      //widget.onFinish!('0');
      // Navigator.of(context).pop();
      _cartController.updateOrder();

      // print('success');
    }

    // shopify url final checkout
    if (url.contains('thank_you')) {
      // widget.onFinish!('0');
      // Navigator.of(context).pop();
      _cartController.updateOrder();
    }

    if (url.contains('/member-login/')) {
      //widget.onFinish!('0');
      //Navigator.of(context).pop();
      _cartController.updateOrder();
    }

    /// BigCommerce.
    if (url.contains('/checkout/order-confirmation')) {
      // Navigator.of(context).pop();
      _cartController.updateOrder();
    }

    /// Prestashop
    if (url.contains('/order-confirmation')) {
      var uri = Uri.parse(url);
      // widget.onFinish?.call((uri.queryParameters['id_order'] ?? 0).toString());
      //Navigator.of(context).pop();
      _cartController.updateOrder();
    }
  }

  @override
  void initState() {
    CartController controller = Get.find();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(NavigationDelegate(
        onPageStarted: (url) {
          setState(() {
            loadingPercentage = 0;
            currenturl = url;

            // print(currenturl);
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
          handleUrlChanged(url);
        },
        onNavigationRequest: (NavigationRequest request) {
          if (request.url.startsWith(controller.payment_url)) {
            return NavigationDecision.prevent;
          }
          return NavigationDecision.navigate;
        },
      ))
      ..loadRequest(
        Uri.parse(controller.payment_url),
      );
    super.initState();
  }

  callcontroller() async {
    setState(() {
      currenturl = _controller.currentUrl().toString();
    });
    //print(currenturl);
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CartController>(builder: (controller) {
      return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.red,
          leading: IconButton(
            icon: const FaIcon(
              FontAwesomeIcons.angleLeft,
              color: Colors.black,
              size: 20,
            ),
            onPressed: () => Get.offAndToNamed('/homepage'),
          ),
          centerTitle: true,
          title: Text('Payment'),
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
