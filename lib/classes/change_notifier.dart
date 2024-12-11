import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class UpdateNotify extends ChangeNotifier {
  List<List<dynamic>> _descriptions = []; // Modified to allow changes
  int _currentDescriptionIndex = 0;
  List<dynamic> get currentDescription => _descriptions[_currentDescriptionIndex];
  List<int> _autoChangeIndices = [];
  bool _answerChosen = false;
  bool isPlayed = false;
  Timer? _timer;

  Function? onDescriptionChange;

  UpdateNotify(String scriptPath, {List<int>? autoChangeIndices}) {
    _autoChangeIndices = autoChangeIndices ?? [];
    _loadDescriptions(scriptPath); // Load descriptions from JSON file
    // startTimer();
  }


  void startTimer() {

    _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      if (_currentDescriptionIndex < _descriptions.length - 1) {
        // Check if the ending character is a question mark
        bool endsWithQuestionMark = currentDescription[0].endsWith('?');

        // if (endsWithQuestionMark && _answerChosen ||
        //     !endsWithQuestionMark && !_answerChosen) {
        //   nextDescription();
        // }
        if (_autoChangeIndices.contains(_currentDescriptionIndex)) {
          nextDescription();
        }
      } else {
        _timer?.cancel();
      }
    });
  }
  void chooseAnswer(String answer) {
    if (!_answerChosen) {
      if (currentDescription[2] == "") {
        _answerChosen = true;
      } else if (answer == currentDescription[2]) {
        _answerChosen = true;
      }
    }
  }

  bool rightAnswer(bool isRight) {
    return isRight;
  }

  void nextDescription() {
    if (_currentDescriptionIndex < _descriptions.length - 1) {
      _currentDescriptionIndex++;
      _answerChosen = false; // Reset answer chosen flag
      notifyListeners();
      if (onDescriptionChange != null) {
        onDescriptionChange!();
      }
    } else {
      _timer?.cancel();
    }
  }

  void _loadDescriptions(String path) async {
    // print(path);
    try {
      String data = await rootBundle.loadString(path);
      List<dynamic> jsonList = json.decode(data);
      _descriptions = jsonList.map((jsonItem) {
        return [
          jsonItem['description'] as String,
          (jsonItem['choices'] as List),
          jsonItem['answer'], // Keep it dynamic since the type may vary
        ];
      }).toList();
      notifyListeners(); // Notify listeners after descriptions are loaded
    } catch (e) {
      print('Error loading descriptions: $e');
    }
  }
}

