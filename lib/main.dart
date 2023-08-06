import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:loshical/models/user_action.dart';
import 'package:loshical/notifier_providers/puzzle_notifier_provider.dart';
import 'package:loshical/question_screen.dart';
import 'package:loshical/result_screen.dart';

void main() {
  runApp(
    const ProviderScope(
      child: Loshical(),
    ),
  );
}

class Loshical extends ConsumerWidget {
  const Loshical({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var puzzleProvider = ref.read(puzzleNotifier.notifier);
    return MaterialApp.router(
      routerConfig: GoRouter(
        redirect: (context, state) {
          // Two scenarios. (Since we use enum UserAction for redirection)
          // 1. UserAction == Dropped -> User dropped answer in the target, redirect to ResultScreen
          // 2. UserAction == Idle -> Redirects user to QuestionScreen

          if (ref.read(puzzleNotifier).userAction.isDropped) {
            return '/result/${ref.read(puzzleNotifier).selectedImageId}';
          }
          if (ref.read(puzzleNotifier).userAction.isIdle) {
            return '/';
          }
          return null;
        },
        refreshListenable:
            puzzleProvider, // Listening based on the Puzzle Provider
        routes: [
          GoRoute(
            path: '/',
            builder: (context, state) => const QuestionScreen(),
          ),
          GoRoute(
            path: '/result/:id', // passing the id of answer image
            builder: (context, state) {
              return ResultScreen(
                answerImageId: state.pathParameters['id']!,
              );
            },
          ),
        ],
      ),
    );
  }
}
