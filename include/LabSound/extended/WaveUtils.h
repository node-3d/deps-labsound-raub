//
//  WaveUtils.h
//
//  Created by Nigel Redmon on 2/18/13
//
//

#ifndef WaveUtils_h
#define WaveUtils_h
#include <memory>
#include <vector>

namespace lab
{
	class WaveTableMemory;

	int fillTables(WaveTableMemory * osc, double * freqWaveRe, double * freqWaveIm, int numSamples);
	int fillTables2(WaveTableMemory * osc, double * freqWaveRe, double * freqWaveIm, int numSamples, double minTop = 0.4, double maxTop = 0);
	float makeWaveTable(WaveTableMemory * osc, int len, double * ar, double * ai, double scale, double topFreq);

	// examples
	std::shared_ptr<WaveTableMemory> sawOsc(void);
	std::shared_ptr<WaveTableMemory> sinOsc(void);
	std::shared_ptr<WaveTableMemory> squareOsc(void);
	std::shared_ptr<WaveTableMemory> triangleOsc(void);
	std::shared_ptr<WaveTableMemory> noiseOsc(void);
    std::shared_ptr<WaveTableMemory> periodicWaveOsc(const std::vector<double> & reals, const std::vector<double> & imags);
	WaveTableMemory * waveOsc(double * waveSamples, int tableLen);
}
#endif
