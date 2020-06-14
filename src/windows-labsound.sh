echo 'LABSOUND Build Started'

(
	
	cd src/LabSound-master
	rm -rf build
	mkdir -p build
	
	(
		cd build
		cmake \
			-DCMAKE_INSTALL_PREFIX=../dist \
			-DBUILD_EXAMPLE=FALSE ..
		
		cmake --build . --target install --config Release
	)
	
	ls build
	
)

echo 'LABSOUND Build Finished'
