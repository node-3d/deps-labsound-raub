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

cp src/LabSound/build/bin/Release/LabSound.framework/Versions/A/LabSound src/build/LabSound
cp src/LabSound/build/bin/Release/LabSoundRtAudio.framework/Versions/A/LabSoundRtAudio src/build/LabSoundRtAudio
cp src/LabSound/build/bin/Release/LabSoundMiniAudio.framework/Versions/A/LabSoundMiniAudio src/build/LabSoundMiniAudio
cp src/LabSound/build/third_party/libnyquist/lib/Release/liblibnyquist.a src/build/liblibnyquist.a
