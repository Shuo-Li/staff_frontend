import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pluto_grid/pluto_grid.dart';

import '../controller/rank_homographs_controller.dart';
import '../../data/api/api_rank_homographs.dart';
import '../../data/rank_homographs_repository.dart';

class RankHomographsScreen extends ConsumerStatefulWidget {
  const RankHomographsScreen({Key? key}) : super(key: key);

  @override
  _RankHomographsScreenState createState() => _RankHomographsScreenState();
}

class _RankHomographsScreenState
    extends ConsumerState<RankHomographsScreen> {

  List<ApiRankHomograph> modifiedRankHomographs = [];

  final searchedWordCtrl = TextEditingController();

  final List<PlutoColumn> columns = [

    PlutoColumn(
      title: 'word',
      field: 'word_field',
      type: PlutoColumnType.text(),
      readOnly: true,
    ),
    PlutoColumn(
      title: 'wordPosRank',
      field: 'wordPosRank_field',
      type: PlutoColumnType.number(),
      readOnly: true,
    ),
    PlutoColumn(
      title: 'pos',
      field: 'pos_field',
      type: PlutoColumnType.text(),
      readOnly: true,
    ),
    PlutoColumn(
      title: 'defNumber',
      field: 'defNumber_field',
      type: PlutoColumnType.number(),
      readOnly: true,
    ),
    PlutoColumn(
      title: 'subDef',
      field: 'subDef_field',
      type: PlutoColumnType.text(),
      readOnly: true,
    ),
    PlutoColumn(
      title: 'def',
      field: 'def_field',
      type: PlutoColumnType.text(),
      readOnly: true,
    ),
    PlutoColumn(
      title: 'homographGroup',
      field: 'homographGroup_field',
      type: PlutoColumnType.number(),
    ),
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    searchedWordCtrl.dispose();
    super.dispose();
  }
/*
  List<PlutoRow> convertToPlutoRows(List<ApiRankHomograph> dataList) {
    List<PlutoRow> listOfPlutoRows = [];

    for(var i = 0; i < dataList.length; i++){
      PlutoRow singleRow = PlutoRow(
        cells: {
          'word_field': PlutoCell(value: dataList[i].word),
          'wordPosRank_field': PlutoCell(value: dataList[i].wordPosRank),
          'pos_field': PlutoCell(value: dataList[i].pos),
          'defNumber_field': PlutoCell(value: dataList[i].defNumber),
          'subDef_field': PlutoCell(value: dataList[i].subDef),
          'def_field': PlutoCell(value: dataList[i].def),
          'homographGroup_field': PlutoCell(value: dataList[i].homographGroup),
        },
      );
      listOfPlutoRows.add(singleRow);
    }
    return listOfPlutoRows;
  }

 */

/*
  List<PlutoRow> convertToPlutoRows(List<ApiRankHomograph> dataList) {


    final plutoRows = dataList.map((data) {
     return PlutoRow(
        cells: {
          'word_field': PlutoCell(value: data.word),
          'wordPosRank_field': PlutoCell(value: data.wordPosRank),
          'pos_field': PlutoCell(value: data.pos),
          'defNumber_field': PlutoCell(value: data.defNumber),
          'subDef_field': PlutoCell(value: data.subDef),
          'def_field': PlutoCell(value: data.def),
          'homographGroup_field': PlutoCell(value: data.homographGroup),
        },
      );

    }).toList();

    // listOfPlutoRows.add(plutoRow);

    return plutoRows;
  }

 */

  List<PlutoRow> convertToPlutoRows(List<ApiRankHomograph> dataList) {


    final plutoRows = dataList.map((data) =>
      PlutoRow(
        cells: {
          'word_field': PlutoCell(value: data.word),
          'wordPosRank_field': PlutoCell(value: data.wordPosRank),
          'pos_field': PlutoCell(value: data.pos),
          'defNumber_field': PlutoCell(value: data.defNumber),
          'subDef_field': PlutoCell(value: data.subDef),
          'def_field': PlutoCell(value: data.def),
          'homographGroup_field': PlutoCell(value: data.homographGroup),
        },
      )

    ).toList();

    // listOfPlutoRows.add(plutoRow);

    return plutoRows;
  }

  @override
  Widget build(BuildContext context) {
    final AsyncValue<List<ApiRankHomograph>> rankHomographs = ref.watch(rankHomographsPod);
    return Scaffold(
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  width: 200,
                  child: TextFormField(
                    autofocus: true,
                    controller: searchedWordCtrl,
                    // onChanged: (text) => questionDraft.title = text,
                    decoration: const InputDecoration(labelText: 'Word'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                    },
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                ElevatedButton(
                  child: const Text("Go"),
                  onPressed: () {
                    if (searchedWordCtrl.text.trim() != '') {
                      ref.read(searchedWordProvider.notifier).state = searchedWordCtrl.text;
                    }
                  },
                ),
              ],
            ),
          ),
          Container(
            child: Expanded(
              child: rankHomographs.when(
                data: (data) { // List<ApiRankHomograph>
                  modifiedRankHomographs = data;
                  return Container(
                    padding: const EdgeInsets.all(30),
                    child: PlutoGrid(
                        columns: columns,
                        rows: convertToPlutoRows(data),
                        onChanged: (PlutoGridOnChangedEvent event) {
                          print('onChanged event: $event');

                          print('event.rowIdx: ${event.rowIdx}');
                          print('event.value: ${event.value}');
                          print('event.oldValue: ${event.oldValue}');

                          modifiedRankHomographs[event.rowIdx].homographGroup = event.value;
                        },
                        onLoaded: (PlutoGridOnLoadedEvent event) {
                          print(event);
                        }
                    ),
                  );
                },
                loading: () => Center(
                  child: CircularProgressIndicator(),
                ),
                error: (error, e) => Center(
                  child: Text(error.toString()),
                ),
              ), // When
            ),
          ),
          ElevatedButton(
            child: const Text("Save"),
            onPressed: () async {

                String resString = await ref.read(rankHomographsRepository).updateRankHomographs(modifiedRankHomographs);
                print('resString: $resString');


            },
          ),
        ],
      ),
    );
  }
}

