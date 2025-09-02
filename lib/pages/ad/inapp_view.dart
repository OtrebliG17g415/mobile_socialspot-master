import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:webview_flutter/webview_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:carousel_slider/carousel_slider.dart' as cs;

class InappView extends StatefulWidget {
  final String url;

  const InappView({super.key, required this.url});

  @override
  State<InappView> createState() => _InappViewState();
}

class _InappViewState extends State<InappView> {
  WebViewController? controller;
  int loadingPercentage = 0;

  @override
  void initState() {
    super.initState();
    if (!kIsWeb) {
      controller = WebViewController()
        ..setJavaScriptMode(JavaScriptMode.unrestricted)
        ..setBackgroundColor(const Color(0x00000000))
        ..setNavigationDelegate(
          NavigationDelegate(
            onPageStarted: (_) => setState(() => loadingPercentage = 0),
            onProgress: (progress) =>
                setState(() => loadingPercentage = progress),
            onPageFinished: (_) => setState(() => loadingPercentage = 100),
          ),
        )
        ..loadRequest(Uri.parse(widget.url));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Social Spot"),
        leading: Navigator.canPop(context)
            ? IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => Navigator.pop(context),
              )
            : null,
      ),
      body: Column(
        children: [
          // 🖼️ Carousel commun
          cs.CarouselSlider(
            items: [
              Image.network('https://picsum.photos/400/200?image=1',
                  fit: BoxFit.cover),
              Image.network('https://picsum.photos/400/200?image=2',
                  fit: BoxFit.cover),
              Image.network('https://picsum.photos/400/200?image=3',
                  fit: BoxFit.cover),
            ],
            options: cs.CarouselOptions(
              height: 200,
              autoPlay: true,
              enlargeCenterPage: true,
            ),
          ),

          // 🌐 Web : bouton externe | 📱 Mobile : WebView intégré
          Expanded(
            child: kIsWeb
                ? Center(
                    child: ElevatedButton(
                      onPressed: () async {
                        final uri = Uri.parse(widget.url);
                        if (await canLaunchUrl(uri)) {
                          await launchUrl(uri,
                              mode: LaunchMode.externalApplication);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text("Impossible d'ouvrir l'URL")),
                          );
                        }
                      },
                      child: const Text("Ouvrir le formulaire"),
                    ),
                  )
                : Stack(
                    children: [
                      if (controller != null)
                        WebViewWidget(controller: controller!)
                      else
                        const Center(child: CircularProgressIndicator()),
                      if (loadingPercentage < 100)
                        LinearProgressIndicator(
                          value: loadingPercentage / 100,
                        ),
                    ],
                  ),
          ),
        ],
      ),
    );
  }
}
