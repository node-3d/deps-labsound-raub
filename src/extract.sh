(
	cd src
	
	rm -rf build LabSound-1.2.0
	mkdir -p build
	
	git clone --depth 1 -b Bugfixes https://github.com/Avataren/LabSound.git LabSound-1.2.0
	
	rm -rf ../include/LabSound
	mkdir -p ../include/LabSound
	cp -r LabSound-1.2.0/include/LabSound/* ../include/LabSound
	
	(
		cd LabSound-1.2.0/third_party
		git clone --depth 1 -b 0.2.2 https://github.com/libsndfile/libsamplerate.git
		git clone --depth 1 -b v0.7 https://github.com/dafx/libnyquist.git
	)
)
