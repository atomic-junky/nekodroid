import 'package:flutter/foundation.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

InAppWebView generateInAppWebView(data) => InAppWebView(
      initialUrlRequest: URLRequest(
        url: data.videoUrl,
        headers: {
          "User-Agent":
              "Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:109.0) Gecko/20100101 Firefox/116.0",
          "Accept":
              "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,*/*;q=0.8",
          "Accept-Language": "en-GB,en;q=0.5",
          "Accept-Encoding": "gzip, deflate, br",
          "Alt-Used": "fusevideo.io",
          "Connection": "keep-alive",
          "Upgrade-Insecure-Requests": "1",
          "Sec-Fetch-Dest": "iframe",
          "Sec-Fetch-Mode": "navigate",
          "Sec-Fetch-Site": "cross-site",
          "Pragma": "no-cache",
          "Cache-Control": "no-cache",
        },
      ),
      initialOptions: InAppWebViewGroupOptions(
        crossPlatform: InAppWebViewOptions(
          javaScriptCanOpenWindowsAutomatically: false,
          incognito: true,
          mediaPlaybackRequiresUserGesture: false,
          useShouldOverrideUrlLoading: true,
        ),
        android: AndroidInAppWebViewOptions(
          useHybridComposition: false,
          thirdPartyCookiesEnabled: false,
        ),
      ),
      onWebViewCreated: (controller) async {
        debugPrint("HeadlessInAppWebView created!");
        controller
          ..addUserScript(
            userScript: UserScript(
              injectionTime: UserScriptInjectionTime.AT_DOCUMENT_START,
              source: await data.assetBundle.loadString(
                "assets/player/adblock.js",
              ),
            ),
          )
          ..addUserScript(
            userScript: UserScript(
              injectionTime: UserScriptInjectionTime.AT_DOCUMENT_START,
              source: await data.assetBundle.loadString(
                "assets/player/launch_player.js",
              ),
            ),
          )
          ..addUserScript(
            userScript: UserScript(
              injectionTime: UserScriptInjectionTime.AT_DOCUMENT_START,
              source: await data.assetBundle.loadString(
                "assets/player/better_player.js",
              ),
            ),
          );
      },
      onConsoleMessage: (controller, consoleMessage) {
        if (kDebugMode) {
          print(consoleMessage.message);
        }
      },
      shouldOverrideUrlLoading: (controller, action) async =>
          NavigationActionPolicy.CANCEL,
    );
