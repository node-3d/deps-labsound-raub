(
	cd src/LabSound
	mkdir -p build
	cd build
	
	cmake -DLABSOUND_ASOUND=1 -DCMAKE_BUILD_TYPE=Release -DCMAKE_RULE_MESSAGES=OFF -E env CXXFLAGS="-w" ..
	
	cmake --build . --config Release
)

cp src/LabSound/build/bin/libLabSound.a src/build/libLabSound.a

ls src/LabSound/build/third_party
echo ----------
ls src/build
# cp src/LabSound/build/third_party/libsamplerate/src/libsamplerate.a src/build/libsamplerate.a
