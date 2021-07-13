import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:klutter/business_logic/cubit/series_list_cubit.dart';
import 'package:klutter/presentation/widgets/series_card.dart';

class SeriesGridView extends StatelessWidget {
  final SeriesListReady state;
  const SeriesGridView(
    this.state, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(state.seriesPage.totalPages!);
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        state.seriesPage.totalPages == 1
            ? SizedBox.shrink()
            : Expanded(
                flex: 15,
                child: ButtonBar(
                  alignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    OutlinedButton(
                      onPressed: state.seriesPage.first!
                          ? null
                          : () => context
                              .read<SeriesListCubit>()
                              .getSeriesPage(state.seriesPage.number! - 1),
                      child: Icon(Icons.chevron_left),
                    ),
                    Row(
                      children: [
                        Text("Page "),
                        DropdownButton(
                          isDense: true,
                          onChanged: (value) {
                            BlocProvider.of<SeriesListCubit>(context)
                                .getSeriesPage(value as int);
                          },
                          value: state.seriesPage.number,
                          items: Iterable<int>.generate(
                                  state.seriesPage.totalPages!)
                              .map<DropdownMenuItem<int>>((e) =>
                                  DropdownMenuItem<int>(
                                      value: e,
                                      child: Text((e + 1).toString())))
                              .toList(),
                        ),
                      ],
                    ),
                    OutlinedButton(
                      onPressed: state.seriesPage.last!
                          ? null
                          : () => context
                              .read<SeriesListCubit>()
                              .getSeriesPage(state.seriesPage.number! + 1),
                      child: Icon(Icons.chevron_right),
                    )
                  ],
                ),
              ),
        Expanded(
          flex: 85,
          child: GridView.builder(
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                mainAxisExtent: 200,
                maxCrossAxisExtent: 150,
              ),
              itemCount: state.seriesPage.content!.length,
              itemBuilder: (context, index) {
                return SeriesCard(
                  state.seriesPage.content!.elementAt(index),
                );
              }),
        ),
      ],
    );
  }
}
