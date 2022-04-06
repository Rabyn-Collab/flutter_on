import 'package:flutter/material.dart';
import 'package:flutter_new_project/models/news.dart';
import 'package:flutter_new_project/providers/progress_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:webview_flutter/webview_flutter.dart';



class DetailPage extends StatelessWidget {
  final News news;
  DetailPage(this.news);



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Consumer(
              builder: (context, ref, child) {
                final progress = ref.watch(progressProvider);
                return Column(
                  children: [
                   if(progress !=1) LinearProgressIndicator(
                      color: Colors.red,
                      value: progress,
                    ),
                    Expanded(
                      child: WebView(
                        onProgress: (val) {
                         ref.read(progressProvider.notifier).changeProgress(val /100);
                        },
                        initialUrl: news.link,
                        javascriptMode: JavascriptMode.unrestricted,
                      ),
                    ),
                  ],
                );
              }
            )
        )
    );
  }
}
