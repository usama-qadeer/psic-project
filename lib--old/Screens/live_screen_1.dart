import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../widgets/custom_navigation_bar.dart';

class LiveScreen1 extends StatefulWidget {
  const LiveScreen1({Key? key}) : super(key: key);

  @override
  State<LiveScreen1> createState() => _LiveScreen1State();
}

class _LiveScreen1State extends State<LiveScreen1> {
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();
  var isLoading = true;

  @override
  void initState() {
    super.initState();
    // Enable virtual display.
    if (Platform.isAndroid) WebView.platform = AndroidWebView();
  }

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: const CustomNavigationBar(),
      body: Padding(
        padding: const EdgeInsets.only(top: 34),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: const Icon(
                      Icons.arrow_back,
                      color: Colors.black54,
                      size: 30,
                    ),
                  ),
                  const Text(
                    'Watch Live',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Icon(
                    Icons.arrow_back,
                    color: Colors.transparent,
                    size: 30,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.62.h,
              width: double.infinity,
              child: Stack(
                children: [
                  WebView(
                    initialUrl: 'https://www.youtube.com/watch?v=rE1n8-h6NnM',
                    javascriptMode: JavascriptMode.unrestricted,
                    onWebViewCreated: (WebViewController webViewController) {
                      _controller.complete(webViewController);
                    },
                    onPageFinished: (finish) {
                      setState(() {
                        isLoading = false;
                      });
                    },
                    onProgress: (int progress) {
                      print('WebView is loading (progress : $progress%)');
                    },
                  ),
                  isLoading
                      ? const Center(
                          child: CircularProgressIndicator(
                            color: Color(0xff8e3434),
                          ),
                        )
                      : Stack(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
