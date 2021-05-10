echo 'LABSOUND Build Started'

(
	
	cd src
	rm -rf LabSound-1.0.1
	unzip -qq LabSound-1.0.1.zip -d .
	
	unzip -qq alsa.zip -d LabSound-1.0.1/include
	unzip -qq libnyquist-master.zip -d LabSound-1.0.1/third_party/libnyquist
	mv LabSound-1.0.1/third_party/libnyquist/libnyquist-master/* LabSound-1.0.1/third_party/libnyquist
	
	mkdir -p build
	
	(
		cd LabSound-1.0.1
		mkdir -p build
		cd build
		
		cmake -G "Xcode" -DBUILD_EXAMPLE=FALSE ..
		
		cmake --build . --target libopus --config Release
		cmake --build . --target libwavpack --config Release
		cmake --build . --target libnyquist --config Release
		cmake --build . --target LabSound --config Release
	)
	
	ls LabSound-1.0.1/build/bin/Release
	
	cp LabSound-1.0.1/build/bin/Release/liblibnyquist.a  build
	cp LabSound-1.0.1/build/bin/Release/liblibopus.a  build
	cp LabSound-1.0.1/build/bin/Release/liblibwavpack.a  build
	cp LabSound-1.0.1/build/bin/Release/LabSound.framework/Versions/A/LabSound build
	mv LabSound-1.0.1/build/dist/LabSound build/LabSound.a
	
	
	cp LabSound-1.0.1/build/bin/* build
	
	
)

echo 'LABSOUND Build Finished'
