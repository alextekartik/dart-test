import 'dart:html';
import 'dart:web_audio';
import 'dart:typed_data';
import 'dart:math';
import 'dart:async';

AudioContext audioContext;

void main() {
  audioContext = new AudioContext();
  querySelector("#play_note")..onClick.listen(playNote);
  querySelector("#play_file")..onClick.listen(playFile);
  querySelector("#play_oscillator")..onClick.listen(playOscillator);
}

playFile(_) {
  //GainNode gainNode = audioContext.createGain();

  // get the audio file
  return HttpRequest.request("sample.ogg", responseType: "arraybuffer").then((HttpRequest request) {
    // decode it
    return audioContext.decodeAudioData(request.response).then((AudioBuffer buffer) {
      AudioBufferSourceNode source = audioContext.createBufferSource();
      source.buffer = buffer;
      source.connectNode(audioContext.destination);
      // play it now
      source.start(audioContext.currentTime);
    });
  });

}
playNote(_) {
  // create the buffer data from scratch
  final int SAMPLE_RATE = 44100;
  final double PI_2 = PI * 2;
  final int BUFFER_SIZE = 4096;
  AudioBuffer audioBuffer = audioContext.createBuffer(1, BUFFER_SIZE, SAMPLE_RATE);

  Float32List buf = audioBuffer.getChannelData(0);

  for (int i = 0; i < 4096; ++i) {
    buf[i] = sin(440 * PI_2 * i / SAMPLE_RATE);
  }

  AudioBufferSourceNode source = audioContext.createBufferSource();
  source.buffer = audioBuffer;
  source.connectNode(audioContext.destination);
  // play it now
  source.start(audioContext.currentTime);
}

playOscillator(_) {
  OscillatorNode oscillator = audioContext.createOscillator(); // Create sound source

  oscillator.connectNode(audioContext.destination); // Connect sound to output
  oscillator.start(0); // Play instantly
  new Future.delayed(new Duration(milliseconds: 1000), () {
    oscillator.disconnect(0);
  });
}
