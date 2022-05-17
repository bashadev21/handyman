import 'package:booking_system_flutter/component/back_widget.dart';
import 'package:booking_system_flutter/component/loader_widget.dart';
import 'package:booking_system_flutter/main.dart';
import 'package:booking_system_flutter/utils/widgets/cached_nework_image.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class ZoomImageScreen extends StatefulWidget {
  final int index;
  final List<String>? galleryImages;

  ZoomImageScreen({required this.index, this.galleryImages});

  @override
  _ZoomImageScreenState createState() => _ZoomImageScreenState();
}

class _ZoomImageScreenState extends State<ZoomImageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: appBarWidget(
        language!.lblGallery,
        textColor: Colors.white,
        color: context.primaryColor,
        backWidget: BackWidget(),
      ),
      body: PhotoViewGallery.builder(
        scrollPhysics: BouncingScrollPhysics(),
        enableRotation: false,
        backgroundDecoration: BoxDecoration(color: Colors.black),
        pageController: PageController(initialPage: widget.index),
        builder: (BuildContext context, int index) {
          return PhotoViewGalleryPageOptions(
            imageProvider: Image.network(widget.galleryImages![index], errorBuilder: (context, error, stackTrace) => placeHolderWidget()).image,
            initialScale: PhotoViewComputedScale.contained,
            minScale: PhotoViewComputedScale.contained,
            errorBuilder: (context, error, stackTrace) => placeHolderWidget(),
            heroAttributes: PhotoViewHeroAttributes(tag: widget.galleryImages![index]),
          );
        },
        itemCount: widget.galleryImages!.length,
        loadingBuilder: (context, event) => LoaderWidget(),
      ),
    );
  }
}
