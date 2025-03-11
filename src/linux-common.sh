(
	cd src/LabSound
	mkdir -p build
	cd build
	
	cmake -DLABSOUND_ASOUND=1 -DCMAKE_BUILD_TYPE=Release -DCMAKE_RULE_MESSAGES=OFF ..
	
	cmake --build . --target libnyquist --config Release
	cmake --build . --target LabSound --config Release
	# cmake --build . --target LabSoundRtAudio --config Release
	# cmake --build . --target LabSoundMiniAudio --config Release
)

(
	cd src
	
	cp LabSound/build/bin/libLabSound.a build/libLabSound.a
	# cp LabSound/build/bin/libLabSoundMiniAudio.a build/libLabSoundMiniAudio.a
	# cp LabSound/build/bin/libLabSoundRtAudio.a build/libLabSoundRtAudio.a
	cp LabSound/build/third_party/libnyquist/lib/liblibnyquist.a build/liblibnyquist.a
)
