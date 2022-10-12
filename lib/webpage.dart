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
                  if (request.url.contains("metamask.app.link")) {
                    await launchUrlString(request.url,
                        mode: LaunchMode.externalApplication);
                    // print(request.url);
                    print(
                        "asfkasflmaskfmaksfmaskfmalsknflakj fas fakls flask flkasfsa");
                    // _launchURL(request.url);
                    return NavigationDecision.prevent;
                  } else {
                    print("Vamos la ver ${request.url}");
                    return NavigationDecision.prevent;

                    // return NavigationDecision.navigate;
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
