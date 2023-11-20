(
	cd src/LabSound-1.2.0
	mkdir -p build
	cd build
	
	cmake -DLABSOUND_ASOUND=1 -DCMAKE_POSITION_INDEPENDENT_CODE=ON ..
	
	cmake --build . --target samplerate --config Release
	cmake --build . --target libnyquist --config Release
	cmake --build . --target LabSound --config Release
)

cp src/LabSound-1.2.0/build/bin/libLabSound.a src/build/libLabSound.a
cp src/LabSound-1.2.0/build/third_party/libsamplerate/src/libsamplerate.a src/build/libsamplerate.a
