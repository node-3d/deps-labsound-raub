# LabSound binaries

* Platforms: win x32/x64, linux x32/x64, mac x64.
* Library: LabSound audio.
* Linking: static lib-type.


## Install

`npm i -s deps-labsound-raub`


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


## Usage

**binding.gyp**

```javascript
	'variables': {
		'labsound_include' : '<!(node -e "require(\'deps-labsound-raub\').include()")',
		'labsound_bin'     : '<!(node -e "require(\'deps-labsound-raub\').bin()")',
	},
	...
	'targets': [
		{
			'target_name': '...',
			
			'include_dirs': [
				'<(labsound_include)',
				...
			],
			
			'library_dirs': [ '<(labsound_bin)' ],
			'libraries'    : [ '-llabsound', '-llibnyquist' ],
			
			'conditions': [
				
				['OS=="linux"', {
					'libraries': [
						'-Wl,-rpath,<(labsound_bin)',
					],
				}],
				
				['OS=="mac"', {
					'libraries': [
						'-Wl,-rpath,<(labsound_bin)',
				}],
				
				['OS=="win"', {
					'libraries' : [ '-lwinmm', '-lole32', '-luser32', '-lgdi32' ],
				}],
				
			],
		},
```


**addon.cpp**

```cpp
#include <...>
```


### HRTF Database

If you even know what this is... The copy of
[LabSound's HRTF Assets](https://github.com/LabSound/LabSound/tree/master/assets/hrtf)
is contained in the **hrtf** directory. And its path is accessible as:

```
const { hrtf } = require('deps-labsound-raub');
```
