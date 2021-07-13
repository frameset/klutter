import 'package:flutter/material.dart';
import 'package:klutter/data/dataproviders/client/api_client.dart';
import 'package:klutter/data/models/collectiondto.dart';

class CollectionCard extends StatelessWidget {
  final CollectionDto collection;
  final ApiClient apiClient = ApiClient();
  CollectionCard(this.collection);

  @override
  Widget build(BuildContext context) {
    String thumburl = apiClient.dio.options.baseUrl +
        "/api/v1/collections/${collection.id}/thumbnail";
    Map<String, String> header = {
      "Authorization": apiClient.dio.options.headers["Authorization"]
    };

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
              child: FadeInImage(
                image: NetworkImage(
                  thumburl,
                  headers: header,
                ),
                placeholder: AssetImage("assets/images/cover.png"),
              ),
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
