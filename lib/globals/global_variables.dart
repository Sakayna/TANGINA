Map<String, int> globalScores = {};
Map<String, int> quizTakeCount = {};
Map<String, String> globalRemarks = {};
Map<String, int> quizItemCount = {};

void printGlobalVariables() {
  print('Global Scores: $globalScores');
  print('Quiz Take Count: $quizTakeCount');
  print('Global Remarks: $globalRemarks');
  print('Quiz Item Count: $quizItemCount');
}

void updateGlobalRemarks(
    String quizKey, int correctAnswers, int totalQuestions) {
  String remarks;
  if ((correctAnswers / totalQuestions) >= 0.5) {
    remarks = 'Passed';
  } else {
    remarks = 'Failed';
  }
  globalRemarks[quizKey] = remarks;
}
