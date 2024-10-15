import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

var apiKey = dotenv.env["GEMINI_KEY"];

class GeminiService {
  final model = GenerativeModel(
    model: 'gemini-1.5-flash-latest',
    apiKey: apiKey!,
  );

  //Prompt is just a list of expenses.
  Future<String?> generateAnalysis(String prompt) async {
    final content = [
      Content.text(
        """
        DO NOT SEND ANY CODE. YOU RESPONSE WILL BE SHOWN TO THE USER, NOT TO THE ENGINEER.
        Analyse these expenses and give the user recommendations on 
        how they could save money etc. Also show the user total spendings (show it in the beginning). 
        You would also have to take in consideration where the user lives (in this case User lives in San Francisco, CA,USA.).
        You will be given an array of 
        expenses (each item will contain Expense model which contains 
        timestamp, amount, comment(optional) and category). No matter how much expenses they got, or the span of the time, just give them analysis.
        This is the example of the data i will pass you: [{timestmap: 2024-10-08 16:05:24.941851,title: Title of the expense, amount: 55.0, comment: Optional (you got to consider too if expense HAS the comment), category: services}].
        : $prompt""",
      )
    ];
    final response = await model.generateContent(content);

    return response.text;
  }
}
