// License: BSD 2 Clause
// Copyright (C) 2010, Google Inc. All rights reserved.
// Copyright (C) 2015+, The LabSound Authors. All rights reserved.

#ifndef SampledAudioNode_h
#define SampledAudioNode_h

#include "LabSound/core/AudioParam.h"
#include "LabSound/core/AudioScheduledSourceNode.h"
#include "LabSound/core/AudioSetting.h"
#include "LabSound/core/PannerNode.h"

#include <memory>

namespace lab
{

class AudioContext;
class AudioBus;

// This should  be used for short sounds which require a high degree of scheduling flexibility (can playback in rhythmically perfect ways).
//
// params: gain, playbackRate
// settings: loop
//
class SampledAudioNode final : public AudioScheduledSourceNode
{
public:
    SampledAudioNode();
    virtual ~SampledAudioNode();

    // AudioNode
    virtual void process(ContextRenderLock &, size_t framesToProcess) override;
    virtual void reset(ContextRenderLock &) override;

    bool setBus(ContextRenderLock &, std::shared_ptr<AudioBus> sourceBus);
    std::shared_ptr<AudioBus> getBus() const { return m_sourceBus->valueBus(); }

    // numberOfChannels() returns the number of output channels. This value equals the number of channels from the buffer.
    // If a new buffer is set with a different number of channels, then this value will dynamically change.
    size_t numberOfChannels(ContextRenderLock & r);

    // Play-state
    void startGrain(double when, double grainOffset);
    void startGrain(double when, double grainOffset, double grainDuration);

    float duration() const;

    bool loop() const;
    void setLoop(bool loop);

    // Loop times in seconds.
    double loopStart() const;
    double loopEnd() const;
    void setLoopStart(double loopStart);
    void setLoopEnd(double loopEnd);

    std::shared_ptr<AudioParam> gain() { return m_gain; }
    std::shared_ptr<AudioParam> playbackRate() { return m_playbackRate; }
    std::shared_ptr<AudioParam> detune() { return m_detune; }

    // If a panner node is set, then we can incorporate doppler shift into the playback pitch rate.
    void setPannerNode(PannerNode *);
    virtual void clearPannerNode() override;

    // If we are no longer playing, propagate silence ahead to downstream nodes.
    virtual bool propagatesSilence(ContextRenderLock & r) const override;

private:
    virtual double tailTime(ContextRenderLock & r) const override { return 0; }
    virtual double latencyTime(ContextRenderLock & r) const override { return 0; }

    // Returns true on success.
    bool renderFromBuffer(ContextRenderLock &, AudioBus *, size_t destinationFrameOffset, size_t numberOfFrames);

    // Render silence starting from "index" frame in AudioBus.
    bool renderSilenceAndFinishIfNotLooping(ContextRenderLock & r, AudioBus *, size_t index, size_t framesToProcess);

    // m_buffer holds the sample data which this node outputs.
    std::shared_ptr<AudioSetting> m_sourceBus;

    // Exposed attributes
    std::shared_ptr<AudioParam> m_gain;
    std::shared_ptr<AudioParam> m_playbackRate;
    std::shared_ptr<AudioParam> m_detune;

    // If m_isLooping is false, then this node will be done playing and become inactive after it reaches the end of the sample data in the buffer.
    // If true, it will wrap around to the start of the buffer each time it reaches the end.
    std::shared_ptr<AudioSetting> m_isLooping;

    bool m_channelSetupRequested{false};
    bool m_startRequested{false};
    double m_requestWhen{0};
    double m_requestGrainOffset{0};
    double m_requestGrainDuration{0};

    std::shared_ptr<AudioSetting> m_loopStart;
    std::shared_ptr<AudioSetting> m_loopEnd;

    // m_virtualReadIndex is a sample-frame index into our buffer representing the current playback position.
    // Since it's floating-point, it has sub-sample accuracy.
    double m_virtualReadIndex;

    // Granular playback
    bool m_isGrain{false};
    double m_grainOffset{0};  // in seconds
    double m_grainDuration{0};  // in seconds

    // totalPitchRate() returns the instantaneous pitch rate (non-time preserving).
    // It incorporates the base pitch rate, any sample-rate conversion factor from the buffer, and any doppler shift from an associated panner node.
    double totalPitchRate(ContextRenderLock &);

    // m_lastGain provides continuity when we dynamically adjust the gain.
    float m_lastGain{1.0f};

    // We optionally keep track of a panner node which has a doppler shift that is incorporated into
    // the pitch rate. We manually manage ref-counting because we want to use RefTypeConnection.
    PannerNode * m_pannerNode{nullptr};
};

}  // namespace lab

#endif  // SampledAudioNode
