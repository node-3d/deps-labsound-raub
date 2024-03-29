(
	cd src/LabSound-1.2.0
	mkdir -p build
	cd build
	
	cmake -G "Xcode" ..
	
	cmake --build . --target samplerate --config Release
	cmake --build . --target libnyquist --config Release
	cmake --build . --target LabSound --config Release
)

cp src/LabSound-1.2.0/build/bin/Release/LabSound.framework/Versions/A/LabSound src/build/LabSound
cp src/LabSound-1.2.0/build/third_party/libnyquist/lib/Release/liblibnyquist.a src/build/liblibnyquist.a
cp src/LabSound-1.2.0/build/third_party/libsamplerate/src/Release/libsamplerate.a src/build/libsamplerate.a
