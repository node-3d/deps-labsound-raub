# LabSound binaries

This is a part of [Node3D](https://github.com/node-3d) project.

[![NPM](https://nodei.co/npm/deps-labsound-raub.png?compact=true)](https://www.npmjs.com/package/deps-labsound-raub)

[![Build Status](https://api.travis-ci.com/node-3d/deps-labsound-raub.svg?branch=master)](https://travis-ci.com/node-3d/deps-labsound-raub)
[![CodeFactor](https://www.codefactor.io/repository/github/node-3d/deps-labsound-raub/badge)](https://www.codefactor.io/repository/github/node-3d/deps-labsound-raub)

> npm i -s deps-labsound-raub


## Synopsis

This dependency package is distributing **LabSound**
binaries through **NPM** for **Node.js** addons.

* Platforms (x64): Windows, Linux, OSX.
* Library: LabSound audio.
* Linking: static lib-type.


## Usage

**binding.gyp**

```javascript
	'variables': {
		'labsound_include' : '<!(node -p "require(\'deps-labsound-raub\').include")',
		'labsound_bin'     : '<!(node -p "require(\'deps-labsound-raub\').bin")',
	},
	...
	'targets': [
		{
			'target_name': '...',
			
			'include_dirs': [
				'<(labsound_include)',
				...
			],
			
			'library_dirs': ['<(labsound_bin)'],
			'libraries'    : ['-llabsound'],
			
			'conditions': [
				['OS=="win"', {
					'libraries' : [ '-lwinmm', '-lole32', '-luser32', '-lgdi32' ],
				}],
			],
		},
```

LabSound C++ interface is available as documented (if) in the
[official repository](https://github.com/LabSound/LabSound).


### HRTF Database

If you even know what this is... The copy of
[LabSound's HRTF Assets](https://github.com/LabSound/LabSound/tree/master/assets/hrtf)
is contained in the **hrtf** directory. And its path is accessible as:

```
const { hrtf } = require('deps-labsound-raub');
```


## Legal notice

This software uses the [LabSound graph-based audio engine](https://github.com/LabSound/LabSound).
LabSound is legally used under the 2 Clause BSD license.
LabSound licensing information (a COPY) is given in a [separate file](/LABSOUND_BSD),
which also can be found on
[LabSound's official repository](https://github.com/LabSound/LabSound/blob/master/LICENSE).

Binaries for all current platforms are built through Qt's QMAKE system **WITHOUT** any use of
Qt-libraries. The `.pro` files for QMAKE build are being contributed to the LabSound repository.

No changes to the original content of any LabSound source file were made. No claims are made that
any audio algorithms are changed/invented within this repository.
