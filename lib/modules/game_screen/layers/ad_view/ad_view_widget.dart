import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdViewWidget extends StatefulWidget {
  const AdViewWidget({
    required this.adSize,
    super.key,
  });

  /// The requested size of the banner. Defaults to [AdSize.banner].
  final AdSize adSize;

  static const id = 'AdView';

  @override
  State<AdViewWidget> createState() => _AdViewWidgetState();
}

class _AdViewWidgetState extends State<AdViewWidget> {
  /// The banner ad to show. This is `null` until the ad is actually loaded.
  BannerAd? _bannerAd;

  final String _adUnitId = Platform.isAndroid
      // Use this ad unit on Android...
      ? const String.fromEnvironment('AD_UNIT_ID_ANDROID')
      // ... or this one on iOS.
      : const String.fromEnvironment('AD_UNIT_ID_IOS');

  @override
  void initState() {
    super.initState();
    _loadAd();
  }

  @override
  Widget build(BuildContext context) {
    print('Ad unit id: $_adUnitId');
    return SafeArea(
      child: _bannerAd == null
          // Nothing to render yet.
          ? const Center(
              child: CircularProgressIndicator(),
            )
          // The actual ad.
          : SizedBox(
              width: widget.adSize.width.toDouble(),
              height: widget.adSize.height.toDouble(),
              child: AdWidget(
                ad: _bannerAd!,
              ),
            ),
    );
  }

  @override
  void dispose() {
    _bannerAd?.dispose();
    super.dispose();
  }

  /// Loads a banner ad.
  void _loadAd() {
    final bannerAd = BannerAd(
      size: widget.adSize,
      adUnitId: _adUnitId,
      request: const AdRequest(),
      listener: BannerAdListener(
        // Called when an ad is successfully received.
        onAdLoaded: (ad) {
          if (!mounted) {
            ad.dispose();
            return;
          }
          setState(() {
            _bannerAd = ad as BannerAd;
          });
        },
        // Called when an ad request failed.
        onAdFailedToLoad: (ad, error) {
          debugPrint('BannerAd failed to load: $error');
          Navigator.of(context).pop();
          ad.dispose();
        },
      ),
    );

    // Start loading.
    bannerAd.load();
  }
}
