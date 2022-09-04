import 'package:hooks_riverpod/hooks_riverpod.dart';

class SearchWordNotifier extends StateNotifier<String> {
  SearchWordNotifier() : super('');

  void clear() => state = '';

  void change(String word) {
    state = word;
  }
}

final searchWordProvider = StateNotifierProvider<SearchWordNotifier, String>(
    (ref) => SearchWordNotifier());
