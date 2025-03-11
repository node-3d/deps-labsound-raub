(
	cd src/LabSound
	mkdir -p build
	cd build
	
	cmake -A x64 -T v142 ..
	cmake --build . --target libnyquist --config Release
	cmake --build . --target LabSound --config Release
	# cmake --build . --target LabSoundRtAudio --config Release
	# cmake --build . --target LabSoundMiniAudio --config Release
)

(
	cd src
	
	cp LabSound/build/bin/Release/LabSound.lib build/LabSound.lib
	# cp LabSound/build/bin/Release/LabSoundRtAudio.lib build/LabSoundRtAudio.lib
	# cp LabSound/build/bin/Release/LabSoundMiniAudio.lib build/LabSoundMiniAudio.lib
	cp LabSound/build/third_party/libnyquist/lib/Release/libnyquist.lib build/libnyquist.lib
)
