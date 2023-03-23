import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdHelper {
  static String get bannerAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-3410819088261237/3853366903';
    } else if (Platform.isIOS) {
      return 'ca-app-pub-3410819088261237/5033257646';
    } else {
      throw new UnsupportedError('Unsupported platform');
    }
  }

  static String get interstitialAdUnitId {
    if (Platform.isAndroid) {
      return "ca-app-pub-3410819088261237/1041169602";
    } else if (Platform.isIOS) {
      return "ca-app-pub-3410819088261237/1640807547";
    } else {
      throw new UnsupportedError("Unsupported platform");
    }
  }

  static String get rewardedAdUnitId {
    if (Platform.isAndroid) {
      return "ca-app-pub-3410819088261237/7525890742";
    } else if (Platform.isIOS) {
      return "ca-app-pub-3410819088261237/3586645730";
    } else {
      throw new UnsupportedError("Unsupported platform");
    }
  }
}

class BannerCustomWidget extends StatefulWidget {
  const BannerCustomWidget({Key? key}) : super(key: key);

  @override
  State<BannerCustomWidget> createState() => _BannerCustomWidgetState();
}

class _BannerCustomWidgetState extends State<BannerCustomWidget> {
  BannerAd? _bannerAd;

  @override
  void initState() {
    super.initState();
    // TODO: Load a banner ad
    BannerAd(
      adUnitId: AdHelper.bannerAdUnitId,
      request: AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          setState(() {
            _bannerAd = ad as BannerAd;
          });
        },
        onAdFailedToLoad: (ad, err) {
          print('Failed to load a banner ad: ${err.message}');
          ad.dispose();
        },
      ),
    ).load();
  }

  @override
  void dispose() {
    // TODO: Dispose a BannerAd object
    _bannerAd?.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return (_bannerAd != null)
        ? Align(
            alignment: Alignment.topCenter,
            child: Container(
              width: _bannerAd!.size.width.toDouble(),
              height: _bannerAd!.size.height.toDouble(),
              child: AdWidget(ad: _bannerAd!),
            ),
          )
        : Container();
  }
}
