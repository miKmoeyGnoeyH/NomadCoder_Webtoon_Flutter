import 'package:flutter/material.dart';
import 'package:nomad_flutter_webtoon/models/webtoon_model.dart';
import 'package:nomad_flutter_webtoon/services/api_service.dart';
import 'package:nomad_flutter_webtoon/widgets/webtoon_widget.dart';

class WebtoonList extends StatefulWidget {
  const WebtoonList({super.key});

  @override
  State<WebtoonList> createState() => _WebtoonListState();
}

class _WebtoonListState extends State<WebtoonList> {
  late dynamic _result;

  @override
  void initState() {
    super.initState();
    _result = ApiService.getTodaysToons();
  }

  void retry() {
    setState(() {
      _result = ApiService.getTodaysToons();
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _result,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.data.runtimeType == List<WebtoonModel>) {
            return makeList();
          } else {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.error_outline_rounded,
                    size: 150,
                  ),
                  ElevatedButton(onPressed: retry, child: const Text('Retry')),
                ],
              ),
            );
          }
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}

FutureBuilder makeList() {
  return FutureBuilder(
    future: ApiService.getTodaysToons(),
    builder: ((context, snapshot) {
      if (snapshot.hasData) {
        return ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: snapshot.data!.length,
          padding: const EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 20,
          ),
          itemBuilder: (context, index) {
            var webtoon = snapshot.data![index];
            return Webtoon(
              title: webtoon.title,
              thumb: webtoon.thumb,
              id: webtoon.id,
            );
          },
          separatorBuilder: (context, index) => const SizedBox(
            width: 40,
          ),
        );
      } else {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }
    }),
  );
}
