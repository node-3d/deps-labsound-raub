echo 'LABSOUND Build Started'

(
	
	cd src/LabSound-master
	rm -rf build
	mkdir -p build
	
	(
		cd build
		cmake -G "Xcode" \
			-DCMAKE_CXX_FLAGS="-w" \
			-DBUILD_EXAMPLE=FALSE \
			-DCMAKE_INSTALL_PREFIX=../dist \
			..
		
		cmake --build . --target install --config Release
	)
	
	ls build
	
)

echo 'LABSOUND Build Finished'
