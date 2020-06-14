echo 'LABSOUND Build Started'

(
	
	cd src/LabSound-master
	rm -rf build
	mkdir -p build
	mkdir -p build/dist
	
	(
		cd build
		cmake -G "Xcode" -DBUILD_EXAMPLE=FALSE ..
		
		cmake --build . --target libopus --config Release
		cmake --build . --target libwavpack --config Release
		cmake --build . --target libnyquist --config Release
		cmake --build . --target LabSound --config Release
	)
	
	ls build/bin/Release
	cp build/bin/Release* build/dist
	cp build/bin/Release/LabSound.framework/Versions/A/LabSound build/dist
	
)

echo 'LABSOUND Build Finished'
