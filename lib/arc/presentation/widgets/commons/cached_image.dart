import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CachedImage extends StatelessWidget {
  final double width;
  final double height;
  final String imageUrl;
  final double borderRadius;

  const CachedImage(
      {Key? key,
      this.width = 36.0,
      this.height = 36.0,
      this.imageUrl = "https://bit.ly/3ncyGiH",
      this.borderRadius = 0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      width: width,
      height: height,
      imageUrl: imageUrl,
      imageBuilder: (context, imageProvider) => Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
          image: DecorationImage(
            image: imageProvider,
            fit: BoxFit.contain,
          ),
        ),
      ),
      placeholder: (context, url) => Center(
          child:
              CircularProgressIndicator(color: Theme.of(context).primaryColor)),
      errorWidget: (context, url, error) => const Icon(Icons.error),
    );
  }
}
