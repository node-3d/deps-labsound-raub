echo 'LABSOUND Build Started'

(
	
	cd src/LabSound-master
	rm -rf build
	mkdir -p build
	mkdir -p build/dist
	
	(
		cd build
		cmake -DBUILD_EXAMPLE=FALSE ..
		
		cmake --build . --target libopus --config Release
		cmake --build . --target libwavpack --config Release
		cmake --build . --target libnyquist --config Release
		cmake --build . --target LabSound --config Release
	)
	
	ls build
	cp build/bin/Release* build/dist
	
)

echo 'LABSOUND Build Finished'
