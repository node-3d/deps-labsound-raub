echo 'LABSOUND Build Started'

(
	cd src
	rm -rf LabSound-1.2.0
	unzip -qq LabSound-1.2.0.zip -d .
	
	unzip -qq alsa.zip -d LabSound-1.2.0/include
	
	unzip -qq libsamplerate-0.2.2.zip -d LabSound-1.2.0/third_party/libsamplerate-0.2.2
	mv LabSound-1.2.0/third_party/libsamplerate-0.2.2/libsamplerate-0.2.2/* LabSound-1.2.0/third_party/libsamplerate
	
	unzip -qq libnyquist-master.zip -d LabSound-1.2.0/third_party/libnyquist
	mv LabSound-1.2.0/third_party/libnyquist/libnyquist-master/* LabSound-1.2.0/third_party/libnyquist
	
	rm -rf build
	mkdir -p build
	
	(
		cd LabSound-1.2.0
		mkdir -p build
		cd build
		
		cmake -G "Xcode" -DBUILD_EXAMPLE=FALSE ..
		
		cmake --build . --target samplerate --config Release
		cmake --build . --target libnyquist --config Release
		cmake --build . --target LabSound --config Release
	)
	
	
	cp LabSound-1.2.0/build/bin/LabSound.framework/Versions/A/LabSound build/LabSound
	cp LabSound-1.2.0/build/third_party/libnyquist/lib/liblibnyquist.a build/liblibnyquist.a
	cp LabSound-1.2.0/build/third_party/libsamplerate/src/libsamplerate.a build/libsamplerate.a
	
	ls LabSound-1.2.0/build/bin
	ls LabSound-1.2.0/build/bin/Release
)

echo 'LABSOUND Build Finished'
