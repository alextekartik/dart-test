import 'dart:html';
import 'dart:web_audio';
import 'dart:typed_data';
import 'dart:math';
import 'dart:async';

AudioContext audioContext;

void main() {
  audioContext = AudioContext();
  querySelector('#play_note')..onClick.listen(playNote);
  querySelector('#play_file')..onClick.listen(playFile);
  querySelector('#play_oscillator')..onClick.listen(playOscillator);
}

Future playFile(_) {
  //GainNode gainNode = audioContext.createGain();

  // get the audio file
  return HttpRequest.request('sample.ogg', responseType: 'arraybuffer')
      .then((HttpRequest request) {
    // decode it
    return audioContext
        .decodeAudioData(request.response as ByteBuffer)
        .then((AudioBuffer buffer) {
      var source = audioContext.createBufferSource();
      source.buffer = buffer;
      source.connectNode(audioContext.destination);
      // play it now
      source.start(audioContext.currentTime);
    });
  });
}

void playNote(_) {
  // create the buffer data from scratch
  final SAMPLE_RATE = 44100;
  final PI_2 = pi * 2;
  final BUFFER_SIZE = 4096;
  final audioBuffer = audioContext.createBuffer(1, BUFFER_SIZE, SAMPLE_RATE);

  final buf = audioBuffer.getChannelData(0);

  for (var i = 0; i < 4096; ++i) {
    buf[i] = sin(440 * PI_2 * i / SAMPLE_RATE);
  }

  var source = audioContext.createBufferSource();
  source.buffer = audioBuffer;
  source.connectNode(audioContext.destination);
  // play it now
  source.start(audioContext.currentTime);
}

Future playOscillator(_) async {
  var oscillator = audioContext.createOscillator(); // Create sound source

  oscillator.connectNode(audioContext.destination); // Connect sound to output
  oscillator.start2(0); // Play instantly
  await Future.delayed(Duration(milliseconds: 1000), () {
    oscillator.disconnect(0);
  });
}
