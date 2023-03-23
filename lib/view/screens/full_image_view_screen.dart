import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show DeviceOrientation, SystemChrome;
import 'package:get/get.dart';
import 'package:text_to_image/constants/constants.dart';

import '../../utils/app_cache_image.dart';

class MediaPreview extends StatefulWidget {
  final String medias;

  MediaPreview(
      {Key? key,
      required this.medias})
      : super(key: key);

  @override
  _MediaPreviewState createState() => _MediaPreviewState();
}

class _MediaPreviewState extends State<MediaPreview>
    with SingleTickerProviderStateMixin {
  final int _currentIndex = 0;

  @override
  void initState() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ]);

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Stack(
          children: [
            const SizedBox(height: double.infinity),
            Center(
              child: InteractiveViewer(
                boundaryMargin: const EdgeInsets.all(0),

                child: Container(
                  color: Colors.black,
                  width: double.infinity,
                  height: double.infinity,
                  child: AppCacheImage(
                    width: double.infinity,
                    boxFit: BoxFit.fitWidth,
                    imageUrl: widget.medias,
                    height: null,
                  ),
                ),
                // CachedImageWithLoader(imgUrl: widget.medias[index].downloadUrl),
              ),
            ),
            Positioned(
              top: 30,
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Row(
                  children: [
                    Container(
                      width: 40.0,
                      height: 40.0,
                      margin: const EdgeInsets.only(left: 10.0, top: 10.0),
                      decoration:  BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.blueLight,
                          boxShadow: [
                            BoxShadow(
                                color: Colors.white12,
                                blurRadius: 6.0,
                                offset: Offset(0, 2)),
                          ]),
                      child: IconButton(
                        onPressed: () {
                          Get.back();
                        },
                        icon: const Icon(Icons.close, color: Colors.white),
                      ),
                    ),
                    const Spacer(),
                  ],
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
