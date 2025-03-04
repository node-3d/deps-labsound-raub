(
	cd src/LabSound-1.2.0
	mkdir -p build
	cd build
	
	cmake -DLABSOUND_ASOUND=1 -DCMAKE_BUILD_TYPE=Release -DCMAKE_RULE_MESSAGES=OFF ..
	
	cmake --build . --config Release
)

cp src/LabSound-1.2.0/build/bin/libLabSound.a src/build/libLabSound.a

ls src/LabSound-1.2.0/build/third_party
cp src/LabSound-1.2.0/build/third_party/libsamplerate/src/libsamplerate.a src/build/libsamplerate.a
