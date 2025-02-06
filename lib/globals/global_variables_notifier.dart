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

  void setGlobalScore(String lessonId, String quizId, int score) {
    String uniqueQuizKey = '${lessonId}_$quizId';
    globalScores.putIfAbsent(uniqueQuizKey, () => []).add(score);

    // Debug log
    debugPrint(
        'Updated Scores for $uniqueQuizKey: ${globalScores[uniqueQuizKey]}');

    _saveAll();
    notifyListeners();
  }

  void incrementQuizTakeCount(String lessonId, String quizId) {
    String uniqueQuizKey = '${lessonId}_$quizId';
    DateTime now = DateTime.now();

    // Check if the quiz has previous take records
    if (quizTakenDates.containsKey(uniqueQuizKey) &&
        quizTakenDates[uniqueQuizKey]!.isNotEmpty) {
      DateTime lastTaken = quizTakenDates[uniqueQuizKey]!.last;

      // Prevent increment if the last take was at the exact same second
      if (lastTaken.difference(now).inSeconds == 0) {
        debugPrint(
            'Quiz $uniqueQuizKey was taken at the same time. Skipping increment.');
        return;
      }
    }

    // Increment the take count if the timestamp is new
    quizTakeCount.update(uniqueQuizKey, (count) => count + 1,
        ifAbsent: () => 1);

    // Save the new take timestamp
    setQuizTakenDate(lessonId, quizId);
    quizTakenStatus[uniqueQuizKey] = true;

    debugPrint(
        'Quiz Take Count for $uniqueQuizKey: ${quizTakeCount[uniqueQuizKey]}');
    _saveAll();
    notifyListeners();
  }

  void updateGlobalRemarks(
      String lessonId, String quizId, int correctAnswers, int totalQuestions) {
    String uniqueQuizKey = '${lessonId}_$quizId';
    String remarks =
        (correctAnswers / totalQuestions) >= 0.5 ? 'Passed' : 'Failed';
    globalRemarks.putIfAbsent(uniqueQuizKey, () => []).add(remarks);

    // Debug log
    debugPrint(
        'Updated Remarks for $uniqueQuizKey: ${globalRemarks[uniqueQuizKey]}');

    _saveAll();
    notifyListeners();
  }

  void setQuizItemCount(String lessonId, String quizId, int itemCount) {
    String uniqueQuizKey = '${lessonId}_$quizId';
    quizItemCount[uniqueQuizKey] = itemCount;
    _saveAll();
    notifyListeners();
  }

  void setQuizTakenDate(String lessonId, String quizId) {
    String uniqueQuizKey = '${lessonId}_$quizId';
    quizTakenDates.putIfAbsent(uniqueQuizKey, () => []).add(DateTime.now());

    // Debug log
    debugPrint(
        'Updated DateTaken for $uniqueQuizKey: ${quizTakenDates[uniqueQuizKey]}');

    _saveAll();
    notifyListeners();
  }

  void completeLesson(String lessonId) {
    userProgress[lessonId]?['isComplete'] = true;
    _saveAll();
    notifyListeners();
  }

  bool isLessonComplete(String lessonId) {
    // Lesson 1 is always accessible
    if (lessonId == 'lesson1') return true;

    // Get the current lesson number (e.g., lesson2 -> 2)
    int currentLessonNumber = int.parse(lessonId.replaceAll(RegExp(r'\D'), ''));

    // Identify the previous lesson (e.g., lesson2 -> lesson1)
    String previousLessonId = 'lesson${currentLessonNumber - 1}';

    // Check if all quizzes in the previous lesson are passed
    for (int i = 1; i <= 4; i++) {
      String quizKey = 'quiz$i';
      if (userProgress[previousLessonId]?.containsKey('canTakeQuiz$i') ==
          true) {
        if (!hasPassedQuiz(previousLessonId, quizKey)) {
          return false; // Return false if any quiz is not passed
        }
      }
    }

    return true; // Mark as complete if all quizzes in the previous lesson are passed
  }

  void unlockNextLesson(String lessonId) {
    // Ensure all quizzes for the current lesson are passed
    bool allQuizzesPassed = true;

    for (int i = 1; i <= 4; i++) {
      String quizKey = 'quiz$i';
      if (userProgress[lessonId]?.containsKey('canTakeQuiz$i') == true) {
        if (!hasPassedQuiz(lessonId, quizKey)) {
          allQuizzesPassed = false;
          break;
        }
      }
    }

    // If all quizzes are passed, unlock the next lesson
    if (allQuizzesPassed) {
      int currentLessonNumber =
          int.parse(lessonId.replaceAll(RegExp(r'\D'), ''));
      String nextLessonId = 'lesson${currentLessonNumber + 1}';

      if (userProgress.containsKey(nextLessonId)) {
        userProgress[nextLessonId]?['isComplete'] =
            true; // Unlock the next lesson
        _saveAll();
        notifyListeners();
      }
    }
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
    String uniqueQuizKey = '${lessonId}_$quizId';
    return quizTakenStatus[uniqueQuizKey] ?? false;
  }

  bool hasPassedQuiz(String lessonId, String quizId) {
    String uniqueQuizKey = '${lessonId}_$quizId';

    List<int> scores = globalScores[uniqueQuizKey] ?? [];
    int totalQuestions = quizItemCount[uniqueQuizKey] ?? 0;

    // Debugging logs
    print('Checking pass status for $uniqueQuizKey:');
    print('Scores: $scores');
    print('Total Questions: $totalQuestions');

    if (scores.isEmpty) {
      print('Result: No attempts made yet.');
      return false;
    }

    int latestScore = scores.last; // Use the latest score
    print('Latest Score: $latestScore');

    if (totalQuestions == 0) {
      print('Result: Total questions is zero, cannot pass.');
      return false;
    }

    bool passed = (latestScore / totalQuestions) >= 0.5;
    print('Result: ${passed ? "Passed" : "Failed"}');
    return passed;
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
