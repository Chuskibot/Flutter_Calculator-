import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import '../providers/calculator_provider.dart';
import '../providers/theme_provider.dart';
import '../widgets/calculator_button.dart';
import 'history_screen.dart';

class CalculatorScreen extends ConsumerWidget {
  const CalculatorScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final calculatorState = ref.watch(calculatorProvider);
    final themeState = ref.watch(themeStateProvider);
    final calculatorNotifier = ref.read(calculatorProvider.notifier);
    final themeNotifier = ref.read(themeStateProvider.notifier);
    
    final size = MediaQuery.of(context).size;
    final isDarkMode = themeState.isDarkMode;
    
    // Define colors based on theme
    final Color primaryColor = isDarkMode ? Colors.blue.shade300 : Colors.blue.shade600;
    final Color operatorColor = isDarkMode ? Colors.blue.shade700 : Colors.blue.shade400;
    final Color numberColor = isDarkMode ? Colors.grey.shade800 : Colors.grey.shade200;
    final Color equalColor = Colors.green.shade600;
    final Color clearColor = Colors.red.shade400;
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Modern Calculator by C78'),
        centerTitle: true,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(isDarkMode ? Icons.light_mode : Icons.dark_mode),
            onPressed: () {
              themeNotifier.toggleTheme();
            },
          ),
          IconButton(
            icon: const Icon(Icons.history),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const HistoryScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Display area
            Expanded(
              flex: 2,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    // Input display
                    Container(
                      alignment: Alignment.centerRight,
                      child: Text(
                        calculatorState.input,
                        style: TextStyle(
                          fontSize: 24,
                          color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(height: 8),
                    // Result display
                    Container(
                      alignment: Alignment.centerRight,
                      child: Text(
                        calculatorState.result,
                        style: TextStyle(
                          fontSize: 48,
                          fontWeight: FontWeight.bold,
                          color: calculatorState.hasError 
                              ? clearColor 
                              : Theme.of(context).colorScheme.onSurface,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            
            // Buttons area
            Expanded(
              flex: 5,
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      offset: const Offset(0, -5),
                    ),
                  ],
                ),
                child: AnimationLimiter(
                  child: Column(
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            CalculatorButton(
                              text: 'C',
                              backgroundColor: clearColor,
                              textColor: Colors.white,
                              onPressed: () {
                                Vibrate.feedback(FeedbackType.light);
                                calculatorNotifier.clear();
                              },
                            ),
                            CalculatorButton(
                              text: '(',
                              backgroundColor: operatorColor,
                              textColor: Colors.white,
                              onPressed: () {
                                Vibrate.feedback(FeedbackType.light);
                                calculatorNotifier.addInput('(');
                              },
                            ),
                            CalculatorButton(
                              text: ')',
                              backgroundColor: operatorColor,
                              textColor: Colors.white,
                              onPressed: () {
                                Vibrate.feedback(FeedbackType.light);
                                calculatorNotifier.addInput(')');
                              },
                            ),
                            CalculatorButton(
                              text: '÷',
                              backgroundColor: operatorColor,
                              textColor: Colors.white,
                              onPressed: () {
                                Vibrate.feedback(FeedbackType.light);
                                calculatorNotifier.addInput('÷');
                              },
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Row(
                          children: [
                            CalculatorButton(
                              text: '7',
                              backgroundColor: numberColor,
                              textColor: Theme.of(context).colorScheme.onSurface,
                              onPressed: () {
                                Vibrate.feedback(FeedbackType.light);
                                calculatorNotifier.addInput('7');
                              },
                            ),
                            CalculatorButton(
                              text: '8',
                              backgroundColor: numberColor,
                              textColor: Theme.of(context).colorScheme.onSurface,
                              onPressed: () {
                                Vibrate.feedback(FeedbackType.light);
                                calculatorNotifier.addInput('8');
                              },
                            ),
                            CalculatorButton(
                              text: '9',
                              backgroundColor: numberColor,
                              textColor: Theme.of(context).colorScheme.onSurface,
                              onPressed: () {
                                Vibrate.feedback(FeedbackType.light);
                                calculatorNotifier.addInput('9');
                              },
                            ),
                            CalculatorButton(
                              text: '×',
                              backgroundColor: operatorColor,
                              textColor: Colors.white,
                              onPressed: () {
                                Vibrate.feedback(FeedbackType.light);
                                calculatorNotifier.addInput('×');
                              },
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Row(
                          children: [
                            CalculatorButton(
                              text: '4',
                              backgroundColor: numberColor,
                              textColor: Theme.of(context).colorScheme.onSurface,
                              onPressed: () {
                                Vibrate.feedback(FeedbackType.light);
                                calculatorNotifier.addInput('4');
                              },
                            ),
                            CalculatorButton(
                              text: '5',
                              backgroundColor: numberColor,
                              textColor: Theme.of(context).colorScheme.onSurface,
                              onPressed: () {
                                Vibrate.feedback(FeedbackType.light);
                                calculatorNotifier.addInput('5');
                              },
                            ),
                            CalculatorButton(
                              text: '6',
                              backgroundColor: numberColor,
                              textColor: Theme.of(context).colorScheme.onSurface,
                              onPressed: () {
                                Vibrate.feedback(FeedbackType.light);
                                calculatorNotifier.addInput('6');
                              },
                            ),
                            CalculatorButton(
                              text: '-',
                              backgroundColor: operatorColor,
                              textColor: Colors.white,
                              onPressed: () {
                                Vibrate.feedback(FeedbackType.light);
                                calculatorNotifier.addInput('-');
                              },
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Row(
                          children: [
                            CalculatorButton(
                              text: '1',
                              backgroundColor: numberColor,
                              textColor: Theme.of(context).colorScheme.onSurface,
                              onPressed: () {
                                Vibrate.feedback(FeedbackType.light);
                                calculatorNotifier.addInput('1');
                              },
                            ),
                            CalculatorButton(
                              text: '2',
                              backgroundColor: numberColor,
                              textColor: Theme.of(context).colorScheme.onSurface,
                              onPressed: () {
                                Vibrate.feedback(FeedbackType.light);
                                calculatorNotifier.addInput('2');
                              },
                            ),
                            CalculatorButton(
                              text: '3',
                              backgroundColor: numberColor,
                              textColor: Theme.of(context).colorScheme.onSurface,
                              onPressed: () {
                                Vibrate.feedback(FeedbackType.light);
                                calculatorNotifier.addInput('3');
                              },
                            ),
                            CalculatorButton(
                              text: '+',
                              backgroundColor: operatorColor,
                              textColor: Colors.white,
                              onPressed: () {
                                Vibrate.feedback(FeedbackType.light);
                                calculatorNotifier.addInput('+');
                              },
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Row(
                          children: [
                            CalculatorButton(
                              text: '0',
                              backgroundColor: numberColor,
                              textColor: Theme.of(context).colorScheme.onSurface,
                              onPressed: () {
                                Vibrate.feedback(FeedbackType.light);
                                calculatorNotifier.addInput('0');
                              },
                            ),
                            CalculatorButton(
                              text: '.',
                              backgroundColor: numberColor,
                              textColor: Theme.of(context).colorScheme.onSurface,
                              onPressed: () {
                                Vibrate.feedback(FeedbackType.light);
                                calculatorNotifier.addInput('.');
                              },
                            ),
                            CalculatorButton(
                              text: '⌫',
                              backgroundColor: clearColor,
                              textColor: Colors.white,
                              onPressed: () {
                                Vibrate.feedback(FeedbackType.light);
                                calculatorNotifier.backspace();
                              },
                            ),
                            CalculatorButton(
                              text: '=',
                              backgroundColor: equalColor,
                              textColor: Colors.white,
                              onPressed: () {
                                Vibrate.feedback(FeedbackType.medium);
                                calculatorNotifier.equals();
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
} 