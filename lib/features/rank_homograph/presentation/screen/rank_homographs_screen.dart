import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
  List<ApiRankHomograph> rankHomographs = [];

  List<ApiRankHomograph> modifiedRankHomographs = [];

  final searchedWordCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    searchedWordCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final rankHomographs = ref.watch(rankHomographsPod);
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
                data: (data) {
                  if (data.length > 0) {
                    modifiedRankHomographs = data;
                  }

                  return Container(
                    child: ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        final rankHomograph = data[index];
                        return Container(
                          padding: EdgeInsets.all(8),
                          child: ListTile(
                            leading: Text(rankHomograph.word),
                            title: Text(rankHomograph.def),
                            subtitle: Text(rankHomograph.wordPosRank.toString()),
                            trailing: Text(rankHomograph.homographGroup.toString()),
                          ),
                        );
                      },
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
              if (modifiedRankHomographs.length > 0) {
                String resString = await ref.read(rankHomographsRepository).updateRankHomographs(modifiedRankHomographs);
                print('resString: $resString');
              }

            },
          ),
        ],
      ),
    );
  }
}

