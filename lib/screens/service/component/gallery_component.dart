import 'package:booking_system_flutter/component/back_widget.dart';
import 'package:booking_system_flutter/main.dart';
import 'package:booking_system_flutter/screens/provider/zoom_image_screen.dart';
import 'package:booking_system_flutter/utils/widgets/cached_nework_image.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class GalleryComponent extends StatefulWidget {
  final String serviceName;
  final List<String> attachments;

  GalleryComponent({required this.serviceName, required this.attachments});

  @override
  State<GalleryComponent> createState() => _GalleryComponentState();
}

class _GalleryComponentState extends State<GalleryComponent> {
  @override
  void initState() {
    afterBuildCreated(() {
      setStatusBarColor(context.primaryColor);
    });
    super.initState();
  }

  @override
  void dispose() {
    setStatusBarColor(Colors.transparent);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget("${language!.lblGallery} ${'- ${widget.serviceName}'}", textColor: Colors.white, color: context.primaryColor, backWidget: BackWidget()),
      body: Wrap(
        spacing: 16,
        runSpacing: 16,
        children: List.generate(
          widget.attachments.length,
          (i) {
            String image = widget.attachments[i];
            return GestureDetector(
              onTap: () {
                ZoomImageScreen(galleryImages: widget.attachments, index: i).launch(context, pageRouteAnimation: PageRouteAnimation.Fade, duration: 200.milliseconds);
              },
              child: cachedImage(image, height: 100, width: context.width() / 3 - 22, fit: BoxFit.cover).cornerRadiusWithClipRRect(defaultRadius),
            );
          },
        ),
      ).paddingSymmetric(horizontal: 16, vertical: 16),
    );
  }
}
