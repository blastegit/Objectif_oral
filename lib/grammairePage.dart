import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

Widget grammairePage(BuildContext context) {
  return Container(
    color: Colors.white,
    alignment: Alignment.center,
    child: PhotoView(
      imageProvider: const AssetImage('assets/images/grammaire.png'),
      minScale: PhotoViewComputedScale.contained * 1,
      maxScale: PhotoViewComputedScale.covered * 1.8,
      enableRotation: false,
      backgroundDecoration: const BoxDecoration(color: null),
      ),
    );
}