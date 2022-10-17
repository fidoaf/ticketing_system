import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ticketing_system/app.dart';
import 'package:ticketing_system/section/section_repository.dart';
import 'package:ticketing_system/simple_bloc_observer.dart';

void main() {
  Bloc.observer = SimpleBlocObserver();
  runApp(App(
    sectionRepository: SectionRepository(),
  ));
}
