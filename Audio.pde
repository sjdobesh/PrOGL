// audio.pde
// samantha jane
// audio interface for music visualizer
// https://processing.org/tutorials/sound Proccessing Sound Library, Example 5
//------------------------------------------------------------------------------

import processing.sound.*;

class Audio {

  SoundFile file;                 // audio source
  FFT fft;                        // fast fourier transform
  int bands;                      // number of spectral bands 
  float smoothing = 0.2;          // smoothing factor
  float[] sum = new float[bands]; // smoothed data

  public Audio(String path, int bands) {

    if ((bands & (bands - 1)) != 0){ // check if power of two
      println("[ERROR] spectrogram bands are not power of two");
    } else {
      this.bands = bands;
      file = new SoundFile(this, path);
      fft = new FFT(this, bands);
      fft.input(file);
    }
  }

  float[] analyze() {
    return sum;
  }
  // amp();
  // freq();
  // beat();
}
