echo 'LABSOUND Build Started'

(
	cd src
	rm -rf LabSound-1.2.0
	unzip -qq LabSound-1.2.0.zip -d .
	
	unzip -qq alsa-lib-1.2.10.zip -d LabSound-1.2.0/third_party/alsa-lib-1.2.10
	mv LabSound-1.2.0/third_party/alsa-lib-1.2.10/alsa-lib-1.2.10/include/* LabSound-1.2.0/include
	
	unzip -qq libsamplerate-0.2.2.zip -d LabSound-1.2.0/third_party/libsamplerate-0.2.2
	mv LabSound-1.2.0/third_party/libsamplerate-0.2.2/libsamplerate-0.2.2/* LabSound-1.2.0/third_party/libsamplerate
	
	unzip -qq miniaudio-0.11.21.zip -d LabSound-1.2.0/third_party/miniaudio-0.11.21
	mv LabSound-1.2.0/third_party/miniaudio-0.11.21/miniaudio-0.11.21/* LabSound-1.2.0/third_party/miniaudio
	
	unzip -qq libnyquist-master.zip -d LabSound-1.2.0/third_party/libnyquist
	mv LabSound-1.2.0/third_party/libnyquist/libnyquist-master/* LabSound-1.2.0/third_party/libnyquist
	
	rm -rf build
	mkdir -p build
	
	(
		cd LabSound-1.2.0
		mkdir -p build
		cd build
		
		cmake -DLABSOUND_ASOUND=1 ..
		
		cmake --build . --target samplerate --config Release
		cmake --build . --target libwavpack --config Release
		cmake --build . --target libnyquist --config Release
		cmake --build . --target miniaudio --config Release
		cmake --build . --target LabSound --config Release
	)
	
	cp LabSound-1.2.0/build/bin/* build
	
)

echo 'LABSOUND Build Finished'
