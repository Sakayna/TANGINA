import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GlobalVariables extends ChangeNotifier {
  Map<String, Map<String, dynamic>> userProgress = {
    'lesson1': {
      'isComplete': true,
      'canTakeQuiz1': false,
      'quiz1Taken': false,
      'canTakeQuiz2': false,
      'quiz2Taken': false,
      'topics': [true, false, false, false, false, false, false, false]
    },
    'lesson2': {
      'isComplete': false,
      'canTakeQuiz1': false,
      'quiz1Taken': false,
      'topics': [false, false, false, false]
    },
    'lesson3': {
      'isComplete': false,
      'canTakeQuiz1': false,
      'quiz1Taken': false,
      'canTakeQuiz2': false,
      'quiz2Taken': false,
      'topics': [false, false, false, false, false, false, false, false, false]
    },
    'lesson4': {
      'isComplete': false,
      'canTakeQuiz1': false,
      'quiz1Taken': false,
      'topics': [
        false,
        false,
        false,
        false,
        false,
        false,
        false,
        false,
        false,
        false
      ]
    },
    'lesson5': {
      'isComplete': false,
      'canTakeQuiz1': false,
      'quiz1Taken': false,
      'canTakeQuiz2': false,
      'quiz2Taken': false,
      'topics': [
        false,
        false,
        false,
        false,
        false,
        false,
        false,
        false,
        false,
        false,
        false,
        false,
        false
      ]
    },
    'lesson6': {
      'isComplete': false,
      'canTakeQuiz1': false,
      'quiz1Taken': false,
      'canTakeQuiz2': false,
      'quiz2Taken': false,
      'canTakeQuiz3': false,
      'quiz3Taken': false,
      'canTakeQuiz4': false,
      'quiz4Taken': false,
      'topics': [
        false,
        false,
        false,
        false,
        false,
        false,
        false,
        false,
        false,
        false,
        false,
        false,
        false,
        false,
        false,
        false,
        false,
        false,
        false
      ]
    },
  };

  Map<String, List<int>> globalScores = {};
  Map<String, int> quizTakeCount = {};
  Map<String, List<String>> globalRemarks = {};
  Map<String, int> quizItemCount = {};
  Map<String, List<DateTime>> quizTakenDates = {};
  Map<String, bool> quizTakenStatus = {};

  void _saveAll() async {
    final prefs = await SharedPreferences.getInstance();

    // Convert DateTime objects to strings
    final Map<String, List<String>> dateTakenStringified =
        quizTakenDates.map((key, value) {
      return MapEntry(
        key,
        value.map((dateTime) => dateTime.toIso8601String()).toList(),
      );
    });

    prefs.setString('userProgress', jsonEncode(userProgress));
    prefs.setString('globalScores', jsonEncode(globalScores));
    prefs.setString('quizTakeCount', jsonEncode(quizTakeCount));
    prefs.setString('globalRemarks', jsonEncode(globalRemarks));
    prefs.setString('quizItemCount', jsonEncode(quizItemCount));
    prefs.setString(
        'quizTakenDates', jsonEncode(dateTakenStringified)); // Save as strings
    prefs.setString('quizTakenStatus', jsonEncode(quizTakenStatus));
  }

  void setGlobalScore(String quizKey, int score) {
    globalScores.putIfAbsent(quizKey, () => []).add(score);
    _saveAll();
    notifyListeners();
  }

  void incrementQuizTakeCount(String quizKey) {
    quizTakeCount.update(quizKey, (count) => count + 1, ifAbsent: () => 1);
    setQuizTakenDate(quizKey);
    quizTakenStatus[quizKey] = true;
    _saveAll();
    notifyListeners();
  }

  void updateGlobalRemarks(
      String quizKey, int correctAnswers, int totalQuestions) {
    String remarks =
        (correctAnswers / totalQuestions) >= 0.5 ? 'Passed' : 'Failed';
    globalRemarks.putIfAbsent(quizKey, () => []).add(remarks);
    _saveAll();
    notifyListeners();
  }

  void setQuizItemCount(String quizKey, int itemCount) {
    quizItemCount[quizKey] = itemCount;
    _saveAll();
    notifyListeners();
  }

  void setQuizTakenDate(String quizKey) {
    quizTakenDates.putIfAbsent(quizKey, () => []).add(DateTime.now());
    _saveAll();
    notifyListeners();
  }

  void completeLesson(String lessonId) {
    userProgress[lessonId]?['isComplete'] = true;
    _saveAll();
    notifyListeners();
  }

  bool isLessonComplete(String lessonId) {
    return userProgress[lessonId]?['isComplete'] ?? false;
  }

  void unlockNextLesson(String completedLessonId) {
    int completedLessonNumber =
        int.parse(completedLessonId.replaceAll(RegExp(r'\D'), ''));
    String nextLessonId = 'lesson' + (completedLessonNumber + 1).toString();
    if (userProgress.containsKey(nextLessonId)) {
      userProgress[nextLessonId]?['isComplete'] = true;
    }
    _saveAll();
    notifyListeners();
  }

  void allowQuiz(String lessonId, String quizId) {
    String key;
    if (quizId == 'quiz1')
      key = 'canTakeQuiz1';
    else if (quizId == 'quiz2')
      key = 'canTakeQuiz2';
    else if (quizId == 'quiz3')
      key = 'canTakeQuiz3';
    else
      key = 'canTakeQuiz4';

    userProgress[lessonId]?[key] = true;
    _saveAll();
    notifyListeners();
  }

  void setQuizTaken(String lessonId, String quizId, bool value) {
    String key;
    if (quizId == 'quiz1')
      key = 'quiz1Taken';
    else if (quizId == 'quiz2')
      key = 'quiz2Taken';
    else if (quizId == 'quiz3')
      key = 'quiz3Taken';
    else
      key = 'quiz4Taken';

    userProgress[lessonId]?[key] = value;
    _saveAll();
    notifyListeners();
  }

  bool getQuizTaken(String lessonId, String quizId) {
    String key;
    if (quizId == 'quiz1')
      key = 'quiz1Taken';
    else if (quizId == 'quiz2')
      key = 'quiz2Taken';
    else if (quizId == 'quiz3')
      key = 'quiz3Taken';
    else
      key = 'quiz4Taken';

    return userProgress[lessonId]?[key] ?? false;
  }

  bool canTakeQuiz(String lessonId, String quizId) {
    String key;
    if (quizId == 'quiz1')
      key = 'canTakeQuiz1';
    else if (quizId == 'quiz2')
      key = 'canTakeQuiz2';
    else if (quizId == 'quiz3')
      key = 'canTakeQuiz3';
    else
      key = 'canTakeQuiz4';

    return userProgress[lessonId]?[key] ?? false;
  }

  List<bool> getTopics(String lessonId) {
    return userProgress[lessonId]?['topics'] ?? [];
  }

  void setTopic(String lessonId, int index, bool value) {
    userProgress[lessonId]?['topics'][index] = value;
    _saveAll();
    notifyListeners();
  }

  void printGlobalVariables() {
    debugPrint('Global Variable Scores: $globalScores');
    debugPrint('Global Variable Quiz Take Count: $quizTakeCount');
    debugPrint('Global Variable Remarks: $globalRemarks');
    debugPrint('Global Variable Quiz Item Count: $quizItemCount');
    debugPrint('Global Variable Quiz Taken Dates: $quizTakenDates');
  }

  Future<void> loadFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    userProgress = (jsonDecode(prefs.getString('userProgress') ?? '{}')
            as Map<String, dynamic>)
        .map((key, value) => MapEntry(key, Map<String, dynamic>.from(value)));
    globalScores = jsonDecode(prefs.getString('globalScores') ?? '{}')
        .cast<String, List<int>>();
    quizTakeCount = jsonDecode(prefs.getString('quizTakeCount') ?? '{}')
        .cast<String, int>();
    globalRemarks = jsonDecode(prefs.getString('globalRemarks') ?? '{}')
        .cast<String, List<String>>();
    quizItemCount = jsonDecode(prefs.getString('quizItemCount') ?? '{}')
        .cast<String, int>();

    // Convert strings back to DateTime objects
    quizTakenDates = (jsonDecode(prefs.getString('quizTakenDates') ?? '{}')
            as Map<String, dynamic>)
        .map<String, List<DateTime>>((key, value) {
      return MapEntry(
        key,
        (value as List).map((e) => DateTime.parse(e)).toList(),
      );
    });

    quizTakenStatus = jsonDecode(prefs.getString('quizTakenStatus') ?? '{}')
        .cast<String, bool>();
    notifyListeners();
  }
}
