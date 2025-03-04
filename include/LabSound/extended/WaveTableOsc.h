//
//  WaveTableOsc.h
//
//  Created by Nigel Redmon on 2018-10-05
//  EarLevel Engineering: earlevel.com
//  Copyright 2018 Nigel Redmon
//
//  For a complete explanation of the wavetable oscillator and code,
//  read the series of articles by the author, starting here:
//  www.earlevel.com/main/2012/05/03/a-wavetable-oscillator�introduction/
//
//  This version has optimizations described here:
//  www.earlevel.com/main/2019/04/28/wavetableosc-optimized/
//
//  License:
//
//  This source code is provided as is, without warranty.
//  You may copy and distribute verbatim copies of this document.
//  You may modify and use this source code to create binary code for your own purposes, free or commercial.
//

#ifndef WaveTableOsc_h
#define WaveTableOsc_h

#include "LabSound/extended/WaveUtils.h"

#include <iostream>
#include <map>
#include <string>
#include <vector>
#include <math.h>

namespace lab
{

enum class WaveTableWaveType
{
    SINE,
    TRIANGLE,
    SQUARE,
    SAWTOOTH,
    FUZZY,
    ORGAN,
    ORGAN2,
    PIANO,
    BASS,
    VOCAL_AHH,
    CUSTOM,
    _WavetableWaveCount
};

struct WaveTableMemory
{
    struct waveTable
    {
        double topFreq;
        int waveTableLen;
        std::vector<float> waveTable;
    };
    static constexpr int numWaveTableSlots = 40;  // simplify allocation with reasonable maximum
    waveTable mWaveTables[numWaveTableSlots];
    int mNumWaveTables = 0;  // number of wavetable slots in use

    WaveTableMemory()
    {
        for (int idx = 0; idx < numWaveTableSlots; idx++)
        {
            mWaveTables[idx].topFreq = 0;
            mWaveTables[idx].waveTableLen = 0;
            // mWaveTables[idx].waveTable = 0;
        }
    }

    //
    // AddWaveTable
    //
    // add wavetables in order of lowest frequency to highest
    // topFreq is the highest frequency supported by a wavetable
    // wavetables within an oscillator can be different lengths
    //
    // returns 0 upon success, or the number of wavetables if no more room is available
    //
    int AddWaveTable(int len, float * waveTableIn, double topFreq)
    {
        if (mNumWaveTables < numWaveTableSlots)
        {
            mWaveTables[mNumWaveTables].waveTable.resize(len + 1);  // = new float[len + 1];
            float * waveTable = mWaveTables[mNumWaveTables].waveTable.data();
            mWaveTables[mNumWaveTables].waveTableLen = len - 1;
            mWaveTables[mNumWaveTables].topFreq = topFreq;
            ++mNumWaveTables;

            // fill in wave
            for (long idx = 0; idx < len; idx++)
                waveTable[idx] = waveTableIn[idx];
            waveTable[len] = waveTable[0];  // duplicate for interpolation wraparound

            return 0;
        }
        return mNumWaveTables;
    }
};

class WaveTableBank
{
public:
    WaveTableBank();

    std::map<WaveTableWaveType, std::shared_ptr<WaveTableMemory>> m_waves;

    void addWave(const WaveTableWaveType type, std::shared_ptr<WaveTableMemory> waveMem)
    {
        if (m_waves.find(type) != m_waves.end())
        {
            throw std::runtime_error("wave memory by that name already exists");
        }

        m_waves[type] = waveMem;
    }

    std::shared_ptr<WaveTableMemory> getWave(const WaveTableWaveType type)
    {
        auto wave = m_waves.find(type);
        if (wave == m_waves.end())
            return nullptr;
        return wave->second;
    }
};

class WaveTableOsc
{
public:
    static WaveTableBank bank;
    std::shared_ptr<WaveTableMemory> waveMem;

    WaveTableOsc()
    {
        SetType(WaveTableWaveType::SINE);
        mPhasor = 0.f;
        mPhaseInc = 0.f;
        mPhaseOfs = 0.f;
    }
    WaveTableOsc(WaveTableWaveType type)
    {
        waveMem = bank.getWave(type);
        mPhasor = 0.f;
        mPhaseInc = 0.f;
        mPhaseOfs = 0.f;
    }
    ~WaveTableOsc(void) = default;

    void SetType(WaveTableWaveType type)
    {
        waveMem = bank.getWave(type);
    }

    void SetAbsoluteFrequency(float freq, float samplerate)
    {
        SetFrequency(freq / samplerate);
    }

    //
    // SetFrequency: Set normalized frequency, typically 0-0.5 (must be positive and less than 1!)
    //
    inline void SetFrequency(double inc)
    {
        mPhaseInc = inc;

        // update the current wave table selector
        int curWaveTable = 0;
        while ((mPhaseInc >= waveMem->mWaveTables[curWaveTable].topFreq) && (curWaveTable < (waveMem->mNumWaveTables - 1)))
        {
            ++curWaveTable;
        }
        mCurWaveTable = curWaveTable;
    }

    void ResetPhase(double phase = 0.0)
    {
        mPhasor = phase;
    }

    //
    // SetPhaseOffset: Phase offset for PWM, 0-1
    //
    void SetPhaseOffset(double offset)
    {
        mPhaseOfs = offset;
    }

    //
    // UpdatePhase: Call once per sample
    //
    inline void UpdatePhase(double mod)
    {
        mPhasor += (mPhaseInc * (1.f + mod));
        if (mPhasor >= 1.0)
            mPhasor -= 1.0;
        // mPhasor -= floor(mPhasor);  // This will handle cases where mPhasor might exceed 2, 3, etc.
        else if (mPhasor < 0.0)
            mPhasor += 1.0;

        if (mPhasor >= 1.0)
        {
            std::cout << "OVER 1:" << mPhasor << std::endl;
            mPhasor -= floor(mPhasor);
        }
        if (mPhasor < 0.0)
        {
            std::cout << "UNDER 0:" << mPhasor << std::endl;
            mPhasor = 1.0 - (-mPhasor - floor(-mPhasor));
        }
        // mPhasor = 1.0 - (-mPhasor - floor(-mPhasor));  // This will handle the negative phase wrap correctly
    }

    void UpdatePhase()
    {
        mPhasor += mPhaseInc;

        if (mPhasor >= 1.0)
            mPhasor -= 1.0;
    }

    //
    // Process: Update phase and get output
    //
    float Process(void)
    {
        UpdatePhase();
        return GetOutput();
    }

    WaveTableMemory::waveTable* GetBaseWavetable()
    {
        return &waveMem->mWaveTables[0];
    }

    //
    // GetOutput: Returns the current oscillator output
    //

    float GetOutput()
    {
        // waveTable * waveTable = &waveMem->mWaveTables[mCurWaveTable];
        WaveTableMemory::waveTable * waveTable = &waveMem->mWaveTables[mCurWaveTable];
        // linear interpolation
        //if (mPhasor > 1.0)
        //{
        //    mPhasor -= 1.0;
        //}
        
        float temp = mPhasor * waveTable->waveTableLen;
        int intPart = temp;
        float fracPart = temp - intPart;
        float samp0 = waveTable->waveTable[intPart];
        float samp1 = waveTable->waveTable[intPart + 1];
        return samp0 + (samp1 - samp0) * fracPart;
    }

    //
    // getOutputMinusOffset
    //
    // for variable pulse width: initialize to sawtooth,
    // set phaseOfs to duty cycle, use this for osc output
    //
    // returns the current oscillator output
    //
    float GetOutputMinusOffset()
    {
        WaveTableMemory::waveTable * waveTable = &waveMem->mWaveTables[mCurWaveTable];
        int len = waveTable->waveTableLen;
        float * wave = waveTable->waveTable.data();

        // linear
        float temp = mPhasor * len;
        int intPart = temp;
        float fracPart = temp - intPart;
        float samp0 = wave[intPart];
        float samp1 = wave[intPart + 1];
        float samp = samp0 + (samp1 - samp0) * fracPart;

        // and linear again for the offset part
        float offsetPhasor = mPhasor + mPhaseOfs;
        if (offsetPhasor > 1.0)
            offsetPhasor -= 1.0;
        temp = offsetPhasor * len;
        intPart = temp;
        fracPart = temp - intPart;
        samp0 = wave[intPart];
        samp1 = wave[intPart + 1];
        return samp - (samp0 + (samp1 - samp0) * fracPart);
    }

protected:
    double mPhasor = 0.0;  // phase accumulator
    double mPhaseInc = 0.0;  // phase increment
    double mPhaseOfs = 0.5;  // phase offset for PWM

    // array of wavetables
    int mCurWaveTable = 0;  // current table, based on current frequency
};

}
#endif
