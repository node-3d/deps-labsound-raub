(
	cd src/LabSound-1.2.0
	mkdir -p build
	cd build
	
	cmake -DLABSOUND_ASOUND=1 ..
	
	cmake --build . --target samplerate --config Release
	cmake --build . --target libnyquist --config Release
	cmake --build . --target LabSound --config Release
)

cp src/LabSound-1.2.0/build/bin/libLabSound.a src/build/libLabSound.a
cp src/LabSound-1.2.0/build/third_party/libnyquist/lib/liblibnyquist.a src/build/liblibnyquist.a
cp src/LabSound-1.2.0/build/third_party/libsamplerate/src/libsamplerate.a src/build/libsamplerate.a
