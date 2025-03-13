(
	cd src/LabSound
	mkdir -p build
	cd build
	
	cmake \
		-DCMAKE_BUILD_TYPE=Release -DCMAKE_RULE_MESSAGES=OFF \
		-DLABSOUND_ASOUND=1 -DLABSOUND_USE_RTAUDIO=ON \
		-DCMAKE_POSITION_INDEPENDENT_CODE=ON ..
	
	cmake --build . --target libnyquist --config Release
	cmake --build . --target LabSound --config Release
)

(
	cd src
	
	cp LabSound/build/bin/libLabSound.a build/libLabSound.a
	cp LabSound/build/third_party/libnyquist/lib/liblibnyquist.a build/liblibnyquist.a
)
