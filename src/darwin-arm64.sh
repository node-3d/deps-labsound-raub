(
	cd src/LabSound
	mkdir -p build
	cd build
	
	cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_RULE_MESSAGES=OFF -DLABSOUND_USE_RTAUDIO=ON ..
	
	cmake --build . --target libnyquist --config Release
	cmake --build . --target LabSound --config Release
	# cmake --build . --target LabSoundRtAudio --config Release
	# cmake --build . --target LabSoundMiniAudio --config Release
)

(
	cd src
	
	cp LabSound/build/bin/LabSound.framework/Versions/A/LabSound build/LabSound
	# cp LabSound/build/bin/libLabSoundMiniAudio.a build/libLabSoundMiniAudio.a
	# cp LabSound/build/bin/libLabSoundRtAudio.a build/libLabSoundRtAudio.a
	cp LabSound/build/third_party/libnyquist/lib/liblibnyquist.a build/liblibnyquist.a
)
