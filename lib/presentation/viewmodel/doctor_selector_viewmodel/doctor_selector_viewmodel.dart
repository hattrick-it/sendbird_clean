import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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


  // Getters

  // Setters

  // Private methods

  // Public methods
  void getDoctorList() {}
}
