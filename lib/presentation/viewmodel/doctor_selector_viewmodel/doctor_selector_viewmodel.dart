import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sendbirdtutorial/domain/entities/chat_doctor.dart';
import 'package:sendbirdtutorial/locator/locator.dart';

final doctorNotifier =
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