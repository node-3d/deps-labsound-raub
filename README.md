# LabSound binaries

This is a part of [Node3D](https://github.com/node-3d) project.

[![NPM](https://nodei.co/npm/deps-labsound-raub.png?compact=true)](https://www.npmjs.com/package/deps-labsound-raub)
[![CodeFactor](https://www.codefactor.io/repository/github/node-3d/deps-labsound-raub/badge)](https://www.codefactor.io/repository/github/node-3d/deps-labsound-raub)

> npm i deps-labsound-raub


## Synopsis

This dependency package is distributing **LabSound**
binaries through **NPM** for **Node.js** addons.

* Platforms (x64): Windows, Linux, OSX.
* Libraries: LabSound, libnyquist, libwavpack.
* Linking: static lib-type.


## Usage

### Example binding.gyp

As in [webaudio-raub](https://github.com/node-3d/webaudio-raub/tree/master/src) Node.js addon.

```javascript
{
	'variables': {
		'bin'        : '<!(node -p "require(\'addon-tools-raub\').bin")',
		'ls_include' : '<!(node -p "require(\'deps-labsound-raub\').include")',
		'ls_bin'     : '<!(node -p "require(\'deps-labsound-raub\').bin")',
	},
	'targets': [
		{
			'target_name': 'webaudio',
			'sources': [
				'cpp/bindings.cpp',
			],
			'include_dirs': [
				'<(ls_include)',
				'<!@(node -p "require(\'addon-tools-raub\').include")',
			],
			'cflags!': ['-fno-exceptions'],
			'cflags_cc!': ['-fno-exceptions'],
			'library_dirs': [ '<(ls_bin)' ],
			'libraries': [ '-llabsound', '-libnyquist', '-libwavpack' ],
			'conditions': [
				
				[
					'OS=="linux"',
					{
						'libraries': [
							"-Wl,-rpath,'$$ORIGIN'",
							"-Wl,-rpath,'$$ORIGIN/../node_modules/deps-labsound-raub/<(bin)'",
							"-Wl,-rpath,'$$ORIGIN/../../deps-labsound-raub/<(bin)'",
						],
						'defines': ['__linux__'],
					}
				],
				
				[
					'OS=="mac"',
					{
						'libraries': [
							'-Wl,-rpath,@loader_path',
							'-Wl,-rpath,@loader_path/../node_modules/deps-labsound-raub/<(bin)',
							'-Wl,-rpath,@loader_path/../../deps-labsound-raub/<(bin)',
						],
						'defines': ['__APPLE__'],
					}
				],
				
				[
					'OS=="win"',
					{
						'libraries' : [
							'-lwinmm', '-lole32', '-luser32', '-lgdi32',
						],
						'defines' : [
							'WIN32_LEAN_AND_MEAN',
							'VC_EXTRALEAN',
							'_WIN32',
						],
						'msvs_settings' : {
							'VCCLCompilerTool' : {
								'AdditionalOptions' : [
									'/GL', '/GF', '/EHsc', '/GS', '/Gy', '/GR-',
								]
							},
							'VCLinkerTool' : {
								'AdditionalOptions' : ['/RELEASE','/OPT:REF','/OPT:ICF','/LTCG'],
							},
						},
					},
				],
				
			],
		},
	]
}
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

No changes to the original content of any LabSound source file were made. No claims are made that
any audio algorithms are changed/invented within this repository.
