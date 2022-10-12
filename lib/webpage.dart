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
    WebViewController? controller;
    return WillPopScope(
        child: Scaffold(
          body: SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: WebView(
                    initialUrl: 'https://yodadex.finance/',
                    javascriptMode: JavascriptMode.unrestricted,
                    onWebViewCreated: (webviewController) {
                      controller = webviewController;
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
                        // print("Link Aqui ${request.url}");
                        return NavigationDecision.navigate;
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
        onWillPop: () async {
          if (controller != null) {
            if (await controller!.canGoBack()) {
              controller!.goBack();
            } else {
              final shouldPop = await showDialog<bool>(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text(
                      'Pretende sair da aplicação?',
                      style: TextStyle(color: Color.fromARGB(255, 57, 22, 63)),
                    ),
                    actionsAlignment: MainAxisAlignment.spaceBetween,
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context, true);
                        },
                        child: const Text(
                          'Sim',
                          style: TextStyle(
                              color: Color.fromARGB(255, 170, 57, 190)),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context, false);
                        },
                        child: const Text(
                          'Não',
                          style:
                              TextStyle(color: Color.fromARGB(255, 57, 22, 63)),
                        ),
                      ),
                    ],
                  );
                },
              );
              return shouldPop!;
            }
          } else {}
          return false;
        });
  }
}
