import 'dart:io';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Webpage extends StatefulWidget {
  @override
  WebpageState createState() => WebpageState();
}

class WebpageState extends State<Webpage> {
  @override
  void initState() {
    super.initState();
    // Enable virtual display.
    if (Platform.isAndroid) WebView.platform = AndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: WebView(
                initialUrl: 'https://yodadex.finance/',
                javascriptMode: JavascriptMode.unrestricted,
                onWebViewCreated: (controller) {
                  controller.runJavascript("""


                """);
                },
                navigationDelegate: (NavigationRequest request) async {
                  //Validating the url and if is an app link, launch an external application
                  if (request.url.contains(".app.link")) {
                    await launchUrlString(
                      request.url,
                      mode: LaunchMode.externalApplication,
                    );
                    return NavigationDecision.prevent;
                  } else {
                    return NavigationDecision.navigate;
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
