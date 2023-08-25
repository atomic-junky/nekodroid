import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nekodroid/constants.dart';
import 'package:path_provider/path_provider.dart';

/* CONSTANTS */

/* MODELS */

@immutable
class HlsProviderData {
  final Uri videoUrl;
  final AssetBundle assetBundle;

  const HlsProviderData({
    required this.videoUrl,
    required this.assetBundle,
  });

  @override
  String toString() =>
      "HlsProviderData(videoUrl: $videoUrl, assetBundle: $assetBundle)";

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    return other is HlsProviderData &&
        other.videoUrl == videoUrl &&
        other.assetBundle == assetBundle;
  }

  @override
  int get hashCode => videoUrl.hashCode ^ assetBundle.hashCode;
}

/* PROVIDERS */

final hlsProvider =
    FutureProvider.autoDispose.family<Map<String, File>, HlsProviderData>(
  (ref, data) {
    final bytesCompleter = Completer<Map<String, List<int>>>();
    final filesCompleter = Completer<Map<String, File>>();
    // final webview = _buildWebview(bytesCompleter, data);
    // ref.onDispose(webview.dispose);
    bytesCompleter.future.then(
      (value) async {
        if (value.isEmpty) {
          return filesCompleter.completeError(
            Exception("no hls stream found"),
          );
        }
        final tempdir = await getTemporaryDirectory();
        final Map<String, File> result = {};
        for (final entry in value.entries) {
          final tempfile = File(
            "${tempdir.path}/nekodroid_nativeplayer_${DateTime.now().millisecondsSinceEpoch}.m3u8",
          );
          await tempfile.writeAsBytes(entry.value, flush: true);
          result.putIfAbsent(entry.key, () => tempfile);
        }
        filesCompleter.complete(result);
      },
      onError: (error, stackTrace) {
        if (kDebugMode) {
          print(error);
          print(stackTrace);
        }
        return filesCompleter.completeError(error, stackTrace);
      },
    );
    // ..whenComplete(webview.dispose);
    Future.delayed(
      const Duration(milliseconds: kHeadlessWebviewMaxLifetime),
    ).then((_) {
      final exception = Exception("HLS stream scrapper timed out.");
      // webview.dispose();
      if (!bytesCompleter.isCompleted) {
        bytesCompleter.completeError(exception);
      }
      if (!filesCompleter.isCompleted) {
        filesCompleter.completeError(exception);
      }
    });
    // webview.run();
    return filesCompleter.future;
  },
);

/* MISC */
// Not used because requests are blocked by fusevideo.io
// Can't fake Host in headers because of CORS
// Make the site think that the HeadlessInAppWebView is an iframe like an InAppWebView

HeadlessInAppWebView _buildWebview(
  Completer<Map<String, List<int>>> bytesCompleter,
  HlsProviderData data,
) {
  final qualitiesCount = Completer<int>();
  final Map<String, List<int>> qualities = {};
  return HeadlessInAppWebView(
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
        useShouldInterceptAjaxRequest: true,
      ),
      android: AndroidInAppWebViewOptions(
        useHybridComposition: true,
        thirdPartyCookiesEnabled: false,
        useShouldInterceptRequest: true,
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
        );
    },
    shouldInterceptAjaxRequest:
        (InAppWebViewController controller, AjaxRequest ajaxRequest) async =>
            ajaxRequest,
    onConsoleMessage: (controller, consoleMessage) {
      if (kDebugMode) {
        print(consoleMessage.message);
      }
    },
    onAjaxProgress: (controller, request) async {
      final url = request.url.toString();
      if (url.contains(RegExp(r"fusevideo.io\/(m|h)\/.*\.m3u8")) &&
          request.readyState == AjaxRequestReadyState.DONE) {
        final data = request.responseText;
        if (data?.isNotEmpty ?? false) {
          if (url.contains("fusevideo.io/h/")) {
            qualities.putIfAbsent(
              request.url!.pathSegments.elementAt(1),
              () => utf8.encode(data!),
            );
            if (qualitiesCount.isCompleted &&
                !bytesCompleter.isCompleted &&
                (await qualitiesCount.future) == qualities.length) {
              bytesCompleter.complete(qualities);
            }
          } else if (!qualitiesCount.isCompleted) {
            final streams = RegExp(r"https.*\/h\/(\d+).*").allMatches(data!);
            if (streams.isNotEmpty) {
              qualitiesCount.complete(streams.length);
            }
          }
        }
      }
      return AjaxRequestAction.PROCEED;
    },
    androidShouldInterceptRequest: (controller, request) async =>
        request.url.host.contains("fusevideo.io") && !bytesCompleter.isCompleted
            ? null
            : WebResourceResponse(),
    shouldOverrideUrlLoading: (controller, action) async =>
        NavigationActionPolicy.CANCEL,
  );
}


/* WIDGETS */
