import 'package:flutter/material.dart';
import 'package:loshical/answer_image.dart';
import 'package:loshical/assets.dart';
import 'package:loshical/how_to_play_screen.dart';
import 'package:loshical/question_image.dart';

class QuestionScreen extends StatelessWidget {
  const QuestionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Loshical'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  fullscreenDialog: true,
                  builder: (_) => const HowToPlayScreen()));
            },
            icon: const Icon(Icons.info_outlined),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: Column(
            children: [
              const Text('Choose the image that completes the pattern: '),
              const SizedBox(
                height: 16,
              ),
              Wrap(
                children: AssetManager.questionPaths
                    .map(
                      (e) => QuestionImage(
                        assetPath: e,
                      ),
                    )
                    .toList(),
              ),
              const Spacer(),
              const Text('Which of the shapes below continues the sequence'),
              const SizedBox(
                height: 16,
              ),
              Wrap(
                children: AssetManager.answerPaths
                    .map(
                      (e) => AnswerImage(
                        assetPath: e,
                      ),
                    )
                    .toList(),
              ),
              const SizedBox(
                height: 42,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
