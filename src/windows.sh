(
	cd src/LabSound
	mkdir -p build
	cd build
	
	cmake -A x64 -T v142 -DLABSOUND_USE_RTAUDIO=ON ..
	cmake --build . --target libnyquist --config Release
	cmake --build . --target LabSound --config Release
)

(
	cd src
	
	cp LabSound/build/bin/Release/LabSound.lib build/LabSound.lib
	cp LabSound/build/third_party/libnyquist/lib/Release/libnyquist.lib build/libnyquist.lib
)
