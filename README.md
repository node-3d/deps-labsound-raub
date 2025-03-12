# LabSound binaries

This is a part of [Node3D](https://github.com/node-3d) project.

[![NPM](https://badge.fury.io/js/deps-labsound-raub.svg)](https://badge.fury.io/js/deps-labsound-raub)
[![ESLint](https://github.com/node-3d/deps-labsound-raub/actions/workflows/eslint.yml/badge.svg)](https://github.com/node-3d/deps-labsound-raub/actions/workflows/eslint.yml)
[![Test](https://github.com/node-3d/deps-labsound-raub/actions/workflows/test.yml/badge.svg)](https://github.com/node-3d/deps-labsound-raub/actions/workflows/test.yml)

```console
npm i -s deps-labsound-raub
```


This dependency package is distributing **LabSound**
binaries through **NPM** for **Node.js** addons.

* Platforms (x64): Windows, Linux, MacOS ARM, Linux ARM.
* Libraries: LabSound, libnyquist.
* Linking: static lib.
* Backend: RtAudio.

LabSound is documented in the
[official repository](https://github.com/LabSound/LabSound).

The original LabSound sources are slightly modified, and now include:
* Unreleased commits from [LabSound/LabSound](https://github.com/LabSound/LabSound).
* Extra work from [Avataren/LabSound:Bugfixes](https://github.com/Avataren/LabSound/tree/Bugfixes).
* CMake configuration tweaks to build fewer binaries.
* Locally added fixes for AudioNode and AudioContext.
* See fork [raub/LabSound](https://github.com/raub/LabSound) - you can review all changes since `LabSound@1.2.0`.


> For unmodified `LabSound@1.2.0`, use `deps-labsound-raub@<=5.0.0`.


## binding.gyp

See example in [webaudio-raub](https://github.com/node-3d/webaudio-raub/tree/master/src) Node.js addon.


## HRTF Database

The copy of
[LabSound's HRTF Assets](https://github.com/LabSound/LabSound/tree/master/assets/hrtf)
is contained in the **hrtf** directory. Its absolute path is accessible as:

```js
const { hrtf } = require('deps-labsound-raub');
```


## Legal notice

This software uses the [LabSound audio engine](https://github.com/LabSound/LabSound) under BSD Clause 2.
A copy of LabSound license [is included](/LABSOUND_BSD), and can also be found at
[LabSound repository](https://github.com/LabSound/LabSound/blob/master/LICENSE).
