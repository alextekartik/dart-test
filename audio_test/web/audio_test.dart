import 'dart:async';
import 'dart:html';
import 'dart:math';
import 'dart:typed_data';
import 'dart:web_audio';

late AudioContext audioContext;

void main() {
  audioContext = AudioContext();
  querySelector('#play_note')!.onClick.listen(playNote);
  querySelector('#play_file')!.onClick.listen(playFile);
  querySelector('#play_oscillator')!.onClick.listen(playOscillator);
}

Future<void> playFile(Event _) async {
  // get the audio file
  var request = await HttpRequest.request(
    'sample.ogg',
    responseType: 'arraybuffer',
  );
  // decode it
  var buffer = await audioContext.decodeAudioData(
    request.response as ByteBuffer,
  );
  var source = audioContext.createBufferSource();
  source.buffer = buffer;
  source.connectNode(audioContext.destination!);
  // play it now
  source.start(audioContext.currentTime);
}

void playNote(Event _) {
  // create the buffer data from scratch
  const sampleRate = 44100;
  const pi2 = pi * 2;
  const bufferSize = 4096;
  final audioBuffer = audioContext.createBuffer(1, bufferSize, sampleRate);

  final buf = audioBuffer.getChannelData(0);
  for (var i = 0; i < bufferSize; ++i) {
    buf[i] = sin(440 * pi2 * i / sampleRate);
  }

  var source = audioContext.createBufferSource();
  source.buffer = audioBuffer;
  source.connectNode(audioContext.destination!);
  // play it now
  source.start(audioContext.currentTime);
}

Future<void> playOscillator(Event _) async {
  var oscillator = audioContext.createOscillator(); // Create sound source
  oscillator.connectNode(audioContext.destination!); // Connect sound to output
  oscillator.start2(0); // Play instantly
  await Future<void>.delayed(const Duration(milliseconds: 1000));
  // Stop it, a started source node is never released otherwise
  oscillator.stop(0);
  oscillator.disconnect(0);
}
