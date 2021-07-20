import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../domain/entities/chat_doctor.dart';
import '../../../locator/locator.dart';

final doctorSelectionViewModel =
    ChangeNotifierProvider<DoctorSelectionViewModel>((ref) => locator.get());

enum DoctorStates {
  Empty,
  Loading,
  Loaded,
  Error,
}

class DoctorSelectionViewModel extends ChangeNotifier {
  // Properties
  List<ChatDoctor> _doctorsList = [];

  // Getters
  List<ChatDoctor> get doctorsList => _doctorsList;

  // Setters

  // Private methods

  // Public methods
  void getDoctorList() {}
}
