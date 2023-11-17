(
	cd LabSound-1.2.0
	mkdir -p build
	cd build
	
	cmake -G "Xcode" ..
	
	cmake --build . --target samplerate --config Release
	cmake --build . --target libnyquist --config Release
	cmake --build . --target LabSound --config Release
)

cp LabSound-1.2.0/build/bin/LabSound.framework/Versions/A/LabSound build/LabSound
cp LabSound-1.2.0/build/third_party/libnyquist/lib/liblibnyquist.a build/liblibnyquist.a
cp LabSound-1.2.0/build/third_party/libsamplerate/src/libsamplerate.a build/libsamplerate.a

ls LabSound-1.2.0/build/bin
ls LabSound-1.2.0/build/bin/Release
