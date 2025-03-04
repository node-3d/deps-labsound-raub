(
	cd src/LabSound-1.2.0
	mkdir -p build
	cd build
	
	cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_RULE_MESSAGES=OFF ..
	
	cmake --build . --config Release
)

cp src/LabSound-1.2.0/build/bin/Release/LabSound.framework/Versions/A/LabSound src/build/LabSound

ls src/LabSound-1.2.0/build/third_party
cp src/LabSound-1.2.0/build/third_party/libnyquist/lib/Release/liblibnyquist.a src/build/liblibnyquist.a
cp src/LabSound-1.2.0/build/third_party/libsamplerate/src/Release/libsamplerate.a src/build/libsamplerate.a
