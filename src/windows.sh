(
	cd src/LabSound-1.2.0
	mkdir -p build
	cd build
	
	cmake -A x64 -DCMAKE_BUILD_TYPE=Release -T v142 -DCMAKE_RULE_MESSAGES=OFF ..
	
	cmake --build . --config Release
)

cp src/LabSound-1.2.0/build/bin/Release/LabSound.lib src/build/LabSound.lib

ls src/LabSound-1.2.0/build/third_party
cp src/LabSound-1.2.0/build/third_party/libnyquist/lib/Release/libnyquist.lib src/build/libnyquist.lib
cp src/LabSound-1.2.0/build/third_party/libsamplerate/src/Release/samplerate.lib src/build/samplerate.lib
