import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:starter_riverpod/modules/home/home.dart';

final homeProvider = StateNotifierProvider<HomeNotifier, HomeState>(
  (ref) => HomeNotifier(),
);
