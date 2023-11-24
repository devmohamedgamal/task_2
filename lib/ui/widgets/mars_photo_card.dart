import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../data/models/mars_photo_model/mars_photo_model.dart';

class MarsPhotoCard extends StatelessWidget {
  const MarsPhotoCard({super.key, required this.marsPhoto, required this.i});
  final MarsPhotoModel marsPhoto;
  final int i;

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
        Text("number $i"),
        ElevatedButton(
          onPressed: () async {
            final state = await Permission.storage.request();
            final externalDir = await getExternalStorageDirectory();
            if (state.isGranted) {
              FlutterDownloader.enqueue(
                url: marsPhoto.imgSrc,
                savedDir: externalDir!.path,
                fileName: "Download",
                showNotification: true,
                openFileFromNotification: true,
                saveInPublicStorage: true,
              );
            } else {
              log("not have premision");
            }
          },
          child: const Text('Download'),
        ),
      ]),
    );
  }
}
