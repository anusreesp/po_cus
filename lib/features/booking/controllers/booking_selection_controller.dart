import 'package:flutter_riverpod/flutter_riverpod.dart';

enum SelectionType { date, drinks, smokes, guest, time }

final selectionProvider =
    StateProvider.autoDispose<SelectionType>((ref) => SelectionType.date);
