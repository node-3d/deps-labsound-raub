// SPDX-License-Identifier: BSD-2-Clause
// Copyright (C) 2020+, The LabSound Authors. All rights reserved.

#ifndef lab_wavetable_node_h
#define lab_wavetable_node_h

#include "LabSound/core/AudioArray.h"
#include "LabSound/core/AudioParam.h"
#include "LabSound/core/AudioScheduledSourceNode.h"
#include "LabSound/core/Macros.h"

#include "LabSound/extended/WaveUtils.h"
#include "LabSound/extended/WaveTableOsc.h"

namespace lab
{

class AudioBus;
class AudioContext;
class AudioSetting;

/*

 */

class WaveTableOscillatorNode : public AudioScheduledSourceNode
{
private:
    virtual double tailTime(ContextRenderLock & r) const override { return 0; }
    virtual double latencyTime(ContextRenderLock & r) const override { return 0; }
    virtual bool propagatesSilence(ContextRenderLock & r) const override;
    std::shared_ptr<AudioSetting> m_type;
    std::vector < std::shared_ptr<WaveTableOsc> > m_unisonOscillators;
    AudioContext & m_contextRef;
    WaveTableWaveType m_cachedType;

    inline float fastexp2(float p)
    {
        if (p < -126.f) p = -126.f;
        int w = (int) p;
        float z = p - (float) w;
        if (p < 0.f) z += 1.f;
        union
        {
            uint32_t i;
            float f;
        } v = {(uint32_t) ((1 << 23) * (p + 121.2740575f + 27.7280233f / (4.84252568f - z) - 1.49012907f * z))};
        return v.f;
    }

    std::shared_ptr<AudioParam> m_frequency;  // hz
    std::shared_ptr<AudioParam> m_detune;  // cents
    std::shared_ptr<AudioParam> m_pulseWidth;  // pulse width
    std::shared_ptr<AudioParam> m_phaseMod;  // phase modulation
    std::shared_ptr<AudioParam> m_phaseModDepth;  // phase modulation depth

    std::shared_ptr<AudioSetting> m_unisonCount;
    std::shared_ptr<AudioSetting> m_unisonSpread; 

    AudioFloatArray m_amplitudeValues;
    AudioFloatArray m_frequencyValues;
    AudioFloatArray m_detuneValues;
    AudioFloatArray m_pulseWidthValues;
    AudioFloatArray m_phaseModValues;
    AudioFloatArray m_phaseModDepthValues;
    void update(ContextRenderLock & r);
    inline float* GetSampleAccurateData(ContextRenderLock & r, AudioFloatArray & values, std::shared_ptr<AudioParam> param, size_t bufferSize);

public:
    WaveTableOscillatorNode(AudioContext & ac);
    virtual ~WaveTableOscillatorNode();
    
    static const char * static_name() { return "WavetableOscillator"; }
    virtual const char * name() const override { return static_name(); }
    static AudioNodeDescriptor * desc();

    virtual void process(ContextRenderLock &, int bufferSize) override;
    virtual void reset(ContextRenderLock &) override { }

    WaveTableWaveType type() const;
    void setType(WaveTableWaveType type);
    void resetPhase();
    void setPhase(float p);
    std::shared_ptr<AudioParam> frequency() { return m_frequency; }
    std::shared_ptr<AudioParam> detune() { return m_detune; }
    std::shared_ptr<AudioParam> pulseWidth() { return m_pulseWidth; }
    std::shared_ptr<AudioParam> phaseMod() { return m_phaseMod; }
    std::shared_ptr<AudioParam> phaseModDepth() { return m_phaseModDepth; }
    std::shared_ptr<AudioSetting> unisonCount() { return m_unisonCount; }
    std::shared_ptr<AudioSetting> unisonSpread() { return m_unisonSpread; }

    WaveTableMemory::waveTable * GetBaseWavetable();

    void processWavetable(ContextRenderLock & r, int bufferSize, int offset, int count);
    

};

}  // namespace lab

#endif  // lab_poly_blep_node_h
