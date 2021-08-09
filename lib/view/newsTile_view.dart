import 'dart:async';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class NewsTileView extends StatefulWidget {
  final String webViewNewsUrl;
  NewsTileView({this.webViewNewsUrl});

  @override
  _NewsTileViewState createState() => _NewsTileViewState();
}

class _NewsTileViewState extends State<NewsTileView> {
  final Completer<WebViewController> _completer =
      new Completer<WebViewController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("NewsApp Flutter"),
        foregroundColor: Colors.lightBlue[150],
        centerTitle: true,
        elevation: 0,
      ),
      body: WebView(
        initialUrl: widget.webViewNewsUrl,
        onWebViewCreated: ((WebViewController webViewController) {
          _completer.complete(webViewController);
        }),
      ),
    );
  }
}
