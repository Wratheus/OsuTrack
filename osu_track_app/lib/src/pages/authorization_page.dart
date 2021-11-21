import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

import '../pages/home_page.dart';
import '../requests/requests.dart';
import '../utils/secure_storage.dart';
import '../utils/color_contrasts.dart' as my_colors;

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final flutterWebviewPlugin = FlutterWebviewPlugin();

  late StreamSubscription onDestroy;
  late StreamSubscription<String> _onUrlChanged;
  late StreamSubscription<WebViewStateChanged> _onStateChanged;

  String? token = '0';


  @override
  void dispose() {
    // Every listener should be canceled, the same should be done with this stream.
    onDestroy.cancel();
    _onUrlChanged.cancel();
    _onStateChanged.cancel();
    flutterWebviewPlugin.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    flutterWebviewPlugin.close();

    // Add a listener to on destroy WebView, so you can make came actions.
    onDestroy = flutterWebviewPlugin.onDestroy.listen((_) {
      // print("destroy");
    });

    _onStateChanged =
        flutterWebviewPlugin.onStateChanged.listen((WebViewStateChanged state) {
          print("onStateChanged: ${state.type} ${state.url}");
        });

    // Add a listener to on url changed
    _onUrlChanged =
        flutterWebviewPlugin.onUrlChanged.listen((String url) async {
          if (mounted) {
            print("URL changed: $url");
            print('Authorization: caught URL change');
            if (url.startsWith('https://wratheus.github.io/OsuTrack')) {
              RegExp regExpError = RegExp("error=(.*)");
              if (regExpError.hasMatch(url) == true) {
                setState(() {
                  flutterWebviewPlugin.close();
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LoginScreen()));
                });
              }
              if (url.startsWith('https://wratheus.github.io/OsuTrack')) {
                RegExp regExp = RegExp("code=(.*)");
                this.token = regExp.firstMatch(url)?.group(1);
                await getToken(token);
                if (this.token != '0') {
                  setState(() {
                    flutterWebviewPlugin.close();
                    Navigator.pop(context, LoginScreen());
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => HomePage()));
                  });
                }
              }
            }
        }
        });
  }

  @override
  Widget build(BuildContext context) {
    String loginUrl = "https://osu.ppy.sh/oauth/authorize?client_id=9725&redirect_uri=https://wratheus.github.io/OsuTrack&response_type=code&scope=public";

    return WebviewScaffold(
        url: loginUrl,
        appBar: AppBar(
          title: const Text("Login to osu OAuth..."),
          backgroundColor: my_colors.Palette.purple,
          leading: Image.asset('assets/utils/cloud_logo.png'),
      )
    );
  }
}