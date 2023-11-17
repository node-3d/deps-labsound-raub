(
	cd src/LabSound-1.2.0
	mkdir -p build
	cd build
	
	cmake -A x64 ..
	
	cmake --build . --target samplerate --config Release
	cmake --build . --target libnyquist --config Release
	cmake --build . --target LabSound --config Release
)

cp src/LabSound-1.2.0/build/bin/Release/LabSound.lib src/build/LabSound.lib
cp src/LabSound-1.2.0/build/third_party/libnyquist/lib/Release/libnyquist.lib src/build/libnyquist.lib
cp src/LabSound-1.2.0/build/third_party/libsamplerate/src/Release/samplerate.lib src/build/samplerate.lib
