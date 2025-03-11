(
	cd src
	
	rm -rf build LabSound
	mkdir -p build
	
	git clone --depth 1 -b test-1.3.0 https://github.com/raub/LabSound.git LabSound
	
	rm -rf ../include/LabSound
	mkdir -p ../include/LabSound
	cp -r LabSound/include/LabSound/* ../include/LabSound
	
	(
		cd LabSound/third_party
		git clone --depth 1 -b 0.2.2 https://github.com/libsndfile/libsamplerate.git
		# git clone --depth 1 -b 0.11.22 https://github.com/mackron/miniaudio.git
		git clone --depth 1 https://github.com/ddiakopoulos/libnyquist.git
	)
)
