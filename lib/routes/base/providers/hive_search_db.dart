import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nekodroid/provider/api.dart';
import 'package:nekosama_hive/nekosama_hive.dart';
import 'package:path_provider/path_provider.dart';

final hiveSearchDbProvider = FutureProvider<NSHiveSearchDb>(
  (ref) async {
    final NSHiveSearchDb hiveSearchDb = ref.watch(apiProvider).hiveSearchDb;
    final Directory tempDir = await getTemporaryDirectory();
    await hiveSearchDb.init(tempDir.path);
    await hiveSearchDb.populate();
    return hiveSearchDb;
  },
);
