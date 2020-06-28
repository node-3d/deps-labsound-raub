echo 'LABSOUND Build Started'

(
	
	cd src/LabSound-master
	rm -rf build
	mkdir -p build
	mkdir -p build/dist
	
	(
		cd build
		
		cmake \
			-DCMAKE_BUILD_TYPE=RELEASE \
			-DCMAKE_C_FLAGS_RELEASE="-g -O3" \
			-DCMAKE_CXX_FLAGS_RELEASE="-g -O3" \
			-DLABSOUND_ASOUND=1 -DBUILD_EXAMPLE=FALSE ..
		
		cmake --build . --target libopus --config Release
		cmake --build . --target libwavpack --config Release
		cmake --build . --target libnyquist --config Release
		cmake --build . --target LabSound --config Release
	)
	
	ls build/bin
	cp build/bin/* build/dist
	
)

echo 'LABSOUND Build Finished'
