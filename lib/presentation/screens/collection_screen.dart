import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:klutter/business_logic/cubit/series_list_cubit.dart';
import 'package:klutter/data/models/collectiondto.dart';
import 'package:klutter/data/repositories/series_repository.dart';
import 'package:klutter/presentation/widgets/series_grid_view.dart';

class CollectionScreen extends StatelessWidget {
  static String routeName = "/collectionScreen";
  const CollectionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CollectionDto collection =
        ModalRoute.of(context)!.settings.arguments as CollectionDto;

    return Scaffold(
        appBar: AppBar(
          title: Text(collection.name),
        ),
        body: BlocBuilder<SeriesListCubit, SeriesListState>(
          bloc: SeriesListCubit(
              repository: SeriesRepository(), collection: collection)
            ..getSeriesPage(0),
          builder: (context, state) {
            if (state is SeriesListInitial) {
              return SizedBox.shrink();
            } else if (state is SeriesListEmpty) {
              return Center(
                child: Text("No series found"),
              );
            } else if (state is SeriesListLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is SeriesListReady) {
              return SeriesGridView(state);
            } else {
              return Center(
                child: Icon(
                  Icons.error,
                  color: Colors.red,
                ),
              );
            }
          },
        ));
  }
}
