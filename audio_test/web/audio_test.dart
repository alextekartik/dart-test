import 'dart:html';
import 'dart:web_audio';
import 'dart:typed_data';
import 'dart:math';

AudioContext audioContext;

void main() {
  audioContext = new AudioContext();
  querySelector("#play_note")..onClick.listen(playNote);
  querySelector("#play_file")..onClick.listen(playMp3);
}

playMp3(_) {
  GainNode gainNode = audioContext.createGain();

  return HttpRequest.request("sample.ogg", responseType: "arraybuffer").then((HttpRequest request) {
    return audioContext.decodeAudioData(request.response).then((AudioBuffer buffer) {
      AudioBufferSourceNode source = audioContext.createBufferSource();
      source.buffer = buffer;
      source.connectNode(audioContext.destination);
      source.start(audioContext.currentTime);
    });
  });

}
playNote(_) {
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
  source.start(audioContext.currentTime);
}
