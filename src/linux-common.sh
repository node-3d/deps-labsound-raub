(
	cd src/LabSound
	mkdir -p build
	cd build
	
	cmake -DLABSOUND_ASOUND=1 -DCMAKE_BUILD_TYPE=Release -DCMAKE_RULE_MESSAGES=OFF ..
	
	cmake --build . --target libnyquist --config Release
	cmake --build . --target LabSound --config Release
	cmake --build . --target LabSoundRtAudio --config Release
	cmake --build . --target LabSoundMiniAudio --config Release
)

cp src/LabSound/build/bin/libLabSound.a src/build/libLabSound.a

ls src/LabSound/build/third_party
echo ----------
ls src/build
# cp src/LabSound/build/third_party/libsamplerate/src/libsamplerate.a src/build/libsamplerate.a
