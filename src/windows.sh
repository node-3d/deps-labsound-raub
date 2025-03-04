(
	cd src/LabSound
	mkdir -p build
	cd build
	
	cmake -A x64 -DCMAKE_BUILD_TYPE=Release -T v142 -DCMAKE_RULE_MESSAGES=OFF ..
	
	cmake --build . --config Release
)

cp src/LabSound/build/bin/Release/LabSound.lib src/build/LabSound.lib

ls src/LabSound/build/third_party
cp src/LabSound/build/third_party/libnyquist/lib/Release/libnyquist.lib src/build/libnyquist.lib
cp src/LabSound/build/third_party/libsamplerate/src/Release/samplerate.lib src/build/samplerate.lib
