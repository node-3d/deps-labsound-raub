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

* Platforms (x64): Windows x64, Linux x64, OSX x64, Linux Aarch64.
* Libraries: LabSound, libnyquist, libwavpack.
* Linking: static lib-type.

LabSound is documented in the
[official repository](https://github.com/LabSound/LabSound).


## binding.gyp

See in [webaudio-raub](https://github.com/node-3d/webaudio-raub/tree/master/src) Node.js addon.


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
No changes to the original LabSound sources were made.
