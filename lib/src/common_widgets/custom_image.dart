import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

/// Custom image widget that loads an image as a static asset.
class CustomImage extends StatelessWidget {
  const CustomImage({super.key, required this.imageUrl});
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: 1,
      fit: FlexFit.tight,
      child: CachedNetworkImage(
        width: double.infinity,
        imageUrl: imageUrl,
        fit: BoxFit.fitHeight,
        placeholder: (context, url) =>
            Center(child: const CircularProgressIndicator.adaptive()),
        errorWidget: (context, url, error) =>
            const Icon(Icons.error_outline_rounded),
      ),
    );
  }
}
