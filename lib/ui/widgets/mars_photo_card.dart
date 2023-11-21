import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../data/models/mars_photo_model/mars_photo_model.dart';

class MarsPhotoCard extends StatelessWidget {
  const MarsPhotoCard({super.key,required this.marsPhoto});
  final MarsPhotoModel marsPhoto;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(children: [
        CachedNetworkImage(
          imageUrl: marsPhoto.imgSrc,
          placeholder: (context, url) => const CircularProgressIndicator(),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
        Text("Solar day: ${marsPhoto.sol}"),
      ]),
    );
  }
}
