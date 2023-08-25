import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nekodroid/routes/base/providers/hive_search_db.dart';
import 'package:nekodroid/routes/base/providers/is_in_search.dart';
import 'package:nekodroid/routes/base/providers/selectable_filters.dart';
import 'package:nekodroid/routes/base/providers/search_text_controller.dart';
import 'package:nekosama_hive/nekosama_hive.dart';

final searchResultsProvider = FutureProvider.autoDispose<List<NSSearchAnime>?>(
  (ref) async {
    if (!ref.watch(isInSearchProvider)) {
      return null;
    }
    final filters = ref.watch(selectableFiltersProvider);
    final text = ref.watch(searchTextControllerProvider).value.text;
    final hiveSearchDb = ref.watch(hiveSearchDbProvider).value;
    if (hiveSearchDb == null) {
      return null;
    }
    final searchIds = await hiveSearchDb.searchIds(
      title: NSStringQuery.contains(text),
      genresHasAll: filters.whereType<NSGenres>(),
      statusesIsAny: filters.whereType<NSStatuses>(),
      typesIsAny: filters.whereType<NSTypes>(),
    );
    final List<NSSearchAnime> searchResults = [];
    for (final id in searchIds) {
      final anime = await hiveSearchDb.getSearchAnime(id);
      if (anime != null) {
        searchResults.add(anime);
      }
    }
    return Future(() => searchResults);
  },
);
