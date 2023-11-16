echo 'LABSOUND Build Started'

(
	cd src
	rm -rf LabSound-1.2.0
	unzip -qq LabSound-1.2.0.zip -d .
	
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
		
		cmake -A x64 ..
		
		cmake --build . --target samplerate --config Release
		cmake --build . --target libnyquist --config Release
		cmake --build . --target LabSound --config Release
	)
	
	cp LabSound-1.2.0/build/bin/Release/LabSound.lib build/LabSound.lib
	cp LabSound-1.2.0/build/third_party/libnyquist/lib/Release/libnyquist.lib build/libnyquist.lib
	cp LabSound-1.2.0/build/third_party/libsamplerate/src/Release/samplerate.lib build/samplerate.lib
)

echo 'LABSOUND Build Finished'
