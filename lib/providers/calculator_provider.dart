import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:math_expressions/math_expressions.dart';

class CalculatorState {
  final String input;
  final String result;
  final bool hasError;
  final List<String> history;

  CalculatorState({
    required this.input,
    required this.result,
    required this.hasError,
    required this.history,
  });

  CalculatorState copyWith({
    String? input,
    String? result,
    bool? hasError,
    List<String>? history,
  }) {
    return CalculatorState(
      input: input ?? this.input,
      result: result ?? this.result,
      hasError: hasError ?? this.hasError,
      history: history ?? this.history,
    );
  }
}

class CalculatorNotifier extends StateNotifier<CalculatorState> {
  CalculatorNotifier()
      : super(CalculatorState(
          input: '',
          result: '0',
          hasError: false,
          history: [],
        ));

  void addInput(String value) {
    if (state.hasError) {
      state = state.copyWith(
        input: value,
        result: '0',
        hasError: false,
      );
      return;
    }

    // Handle special cases
    if (value == '.' && (state.input.isEmpty || state.input.endsWith(RegExp(r'[+\-×÷]')))) {
      state = state.copyWith(input: state.input + '0.');
      return;
    }

    // Prevent multiple operators in a row
    if (value.contains(RegExp(r'[+\-×÷]')) && state.input.isNotEmpty && 
        state.input.endsWith(RegExp(r'[+\-×÷]'))) {
      state = state.copyWith(input: state.input.substring(0, state.input.length - 1) + value);
      return;
    }

    state = state.copyWith(input: state.input + value);
    calculateResult();
  }

  void clear() {
    state = state.copyWith(
      input: '',
      result: '0',
      hasError: false,
    );
  }

  void backspace() {
    if (state.input.isNotEmpty) {
      state = state.copyWith(
        input: state.input.substring(0, state.input.length - 1),
        hasError: false,
      );
      calculateResult();
    }
  }

  void calculateResult() {
    if (state.input.isEmpty) {
      state = state.copyWith(result: '0');
      return;
    }

    try {
      String expression = state.input;
      expression = expression.replaceAll('×', '*');
      expression = expression.replaceAll('÷', '/');

      Parser p = Parser();
      Expression exp = p.parse(expression);
      ContextModel cm = ContextModel();
      double evalResult = exp.evaluate(EvaluationType.REAL, cm);

      // Format the result
      String resultStr;
      if (evalResult == evalResult.toInt()) {
        resultStr = evalResult.toInt().toString();
      } else {
        resultStr = evalResult.toStringAsFixed(8).replaceAll(RegExp(r'0+$'), '').replaceAll(RegExp(r'\.$'), '');
      }

      state = state.copyWith(
        result: resultStr,
        hasError: false,
      );
    } catch (e) {
      // Don't update the result if there's a parsing error
      // This allows partial expressions to be entered
    }
  }

  void equals() {
    if (state.input.isEmpty) return;

    try {
      String expression = state.input;
      expression = expression.replaceAll('×', '*');
      expression = expression.replaceAll('÷', '/');

      Parser p = Parser();
      Expression exp = p.parse(expression);
      ContextModel cm = ContextModel();
      double evalResult = exp.evaluate(EvaluationType.REAL, cm);

      // Format the result
      String resultStr;
      if (evalResult == evalResult.toInt()) {
        resultStr = evalResult.toInt().toString();
      } else {
        resultStr = evalResult.toStringAsFixed(8).replaceAll(RegExp(r'0+$'), '').replaceAll(RegExp(r'\.$'), '');
      }

      // Add to history
      List<String> updatedHistory = [...state.history];
      updatedHistory.add('${state.input} = $resultStr');
      if (updatedHistory.length > 10) {
        updatedHistory.removeAt(0);
      }

      state = state.copyWith(
        input: resultStr,
        result: resultStr,
        hasError: false,
        history: updatedHistory,
      );
    } catch (e) {
      state = state.copyWith(
        result: 'Error',
        hasError: true,
      );
    }
  }

  void clearHistory() {
    state = state.copyWith(history: []);
  }

  void useHistoryItem(String item) {
    // Extract the result part from the history item
    final parts = item.split(' = ');
    if (parts.length == 2) {
      state = state.copyWith(
        input: parts[1],
        result: parts[1],
      );
    }
  }
}

final calculatorProvider = StateNotifierProvider<CalculatorNotifier, CalculatorState>((ref) {
  return CalculatorNotifier();
}); 