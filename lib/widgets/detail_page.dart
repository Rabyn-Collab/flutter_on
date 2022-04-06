import 'package:flutter/material.dart';
import 'package:flutter_new_project/models/news.dart';
import 'package:webview_flutter/webview_flutter.dart';



class DetailPage extends StatefulWidget {

  final News news;
  DetailPage(this.news);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: WebView(
              initialUrl: widget.news.link,
              javascriptMode: JavascriptMode.unrestricted,
            )
        )
    );
  }
}
