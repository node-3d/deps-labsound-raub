echo 'LABSOUND Build Started'

(
	
	cd src/LabSound-master
	rm -rf build
	mkdir -p build
	
	(
		cd build
		
		CMAKE_LIBRARY_PATH="/home/travis/build/node-3d/deps-labsound-raub/src"
		LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/home/travis/build/node-3d/deps-labsound-raub/src
		
		cmake \
			-DLABSOUND_ASOUND=1 \
			-DBUILD_EXAMPLE=FALSE \
			-DCMAKE_INSTALL_PREFIX=../dist \
			..
		
		cmake --build . --target install --config Release
	)
	
	ls build
	
)

echo 'LABSOUND Build Finished'
