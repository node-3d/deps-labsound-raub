(
	cd src/LabSound
	mkdir -p build
	cd build
	
	cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_RULE_MESSAGES=OFF ..
	
	cmake --build . --target libnyquist --config Release
	cmake --build . --target LabSound --config Release
	cmake --build . --target LabSoundRtAudio --config Release
	cmake --build . --target LabSoundMiniAudio --config Release
)

(
	cd src
	>&2 ls LabSound/build/bin/Release
	>&2 echo --------
	>&2 ls LabSound/build/third_party/libnyquist
	
	# cp LabSound/build/bin/Release/LabSound.framework/Versions/A/LabSound build/LabSound
	# cp LabSound/build/bin/Release/LabSoundRtAudio.framework/Versions/A/LabSoundRtAudio build/LabSoundRtAudio
	# cp LabSound/build/bin/Release/LabSoundMiniAudio.framework/Versions/A/LabSoundMiniAudio build/LabSoundMiniAudio
	# cp LabSound/build/third_party/libnyquist/lib/Release/liblibnyquist.a build/liblibnyquist.a
)
