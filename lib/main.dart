import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:json_placeholder_api/json_placeholder_api.dart';
import 'package:ticketing_system/app.dart';
import 'package:ticketing_system/common/observer/simple_bloc_observer.dart';

void main() {
  // Log all the state changes and errors globally
  Bloc.observer = GlobalBlocObserver();
  runApp(App(
    dataRepository: JSONPlaceholderAPI(),
  ));
}
