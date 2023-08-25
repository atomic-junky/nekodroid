import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nekodroid/provider/api.dart';
import 'package:nekosama_hive/nekosama_hive.dart';

final searchdbProvider = FutureProvider<List<NSSearchAnime>>(
  (ref) async {
    final db = await ref.watch(apiProvider).getSearchDb(NSSources.vostfr);
    return db;
  },
);
