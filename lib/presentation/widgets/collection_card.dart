import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:klutter/data/models/collectiondto.dart';

class CollectionCard extends StatelessWidget {
  final CollectionDto collection;
  final List<int>? thumb;
  const CollectionCard({
    Key? key,
    required this.collection,
    this.thumb,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    late Image image;
    if (thumb != null) {
      image = Image.memory(
        Uint8List.fromList(thumb!),
        fit: BoxFit.contain,
      );
    } else {
      image = Image.asset(
        "assets/images/cover.png",
        fit: BoxFit.contain,
      );
    }
    return Card(
      child: SizedBox(
        height: 200,
        width: 125,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              flex: 8,
              child: image,
            ),
            Expanded(
              flex: 2,
              child: Column(
                children: [
                  Text(collection.name),
                  Text(collection.seriesIds.length.toString() + " series"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
