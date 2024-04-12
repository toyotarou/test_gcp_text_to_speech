import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:wavenet/wavenet.dart';

import 'speech/speech_text.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyHomePage(title: 'Text To Speech Example'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, this.title});

  final String? title;

  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  final textConstructor = TextConstructor1();

  final TextToSpeechService _service = TextToSpeechService('AIzaSyCN7K8qqu9YlMIrlrohdC2-1qP0vw16xnA');

  final audioPlayer = AudioPlayer();

  ///
  void getAudioPlayer(dynamic file) => audioPlayer.play(DeviceFileSource(file));

  ///
  Future<void> _playDemo() async {
    setState(() {
      if (textConstructor.isFinished() != true) {
        textConstructor.nextQuestion();
      } else {
        textConstructor.reset();
      }
    });

    if (kDebugMode) {
      print(textConstructor.getCharacterName());
    }

    switch (textConstructor.getCharacterName()) {
      case 'Admiral Venesca Catallia':
        final file = await _service.textToSpeech(
          text: textConstructor.getCharacterText().toString(),
          voiceName: 'en-US-Wavenet-C',
          languageCode: 'en-EN',
          pitch: -2,
          speakingRate: 1.25,
          audioEncoding: 'LINEAR16',
        );

        getAudioPlayer(file.path);
        break;

      case 'Major Razim':
        final file = await _service.textToSpeech(
          text: textConstructor.getCharacterText().toString(),
          voiceName: 'en-AU-Wavenet-D',
          languageCode: 'en-AU',
          audioEncoding: 'LINEAR16',
        );
        getAudioPlayer(file.path);
        break;

      case 'Captain severin':
        final file = await _service.textToSpeech(
          text: textConstructor.getCharacterText().toString(),
          voiceName: 'en-US-Wavenet-J',
          languageCode: 'en-EN',
          pitch: 10,
          speakingRate: 1.4,
          audioEncoding: 'ALAW',
        );

        getAudioPlayer(file.path);
        break;

      case 'Commodore Trevaux':
        final file = await _service.textToSpeech(
          text: textConstructor.getCharacterText().toString(),
          voiceName: 'en-GB-Wavenet-D',
          languageCode: 'en-GB',
          audioEncoding: 'LINEAR16',
          pitch: -7,
          speakingRate: 1.2,
        );

        getAudioPlayer(file.path);
        break;

      default:
        final file = await _service.textToSpeech(
          text: textConstructor.getCharacterText().toString(),
          voiceName: 'en-AU-Wavenet-D',
          languageCode: 'en-AU',
          pitch: -7,
        );

        getAudioPlayer(file.path);
    }
  }

  ///
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              textConstructor.getCharacterName()!.toUpperCase(),
              style: const TextStyle(fontSize: 17.5, color: Colors.white, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              textConstructor.getCharacterText()!,
              style: const TextStyle(fontSize: 17.5, color: Colors.white),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: _playDemo, tooltip: 'Play Demo', child: const Icon(Icons.arrow_right_alt_outlined)),
    );
  }
}
