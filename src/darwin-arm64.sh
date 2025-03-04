(
	cd src/LabSound
	mkdir -p build
	cd build
	
	cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_RULE_MESSAGES=OFF -E env CXXFLAGS="-w" ..
	
	cmake --build . --config Release
)

cp src/LabSound/build/bin/Release/LabSound.framework/Versions/A/LabSound src/build/LabSound

ls src/LabSound/build/third_party
echo ------
ls src/build

# cp src/LabSound/build/third_party/libnyquist/lib/Release/liblibnyquist.a src/build/liblibnyquist.a
# cp src/LabSound/build/third_party/libsamplerate/src/Release/libsamplerate.a src/build/libsamplerate.a
