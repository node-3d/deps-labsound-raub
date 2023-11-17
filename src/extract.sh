rm -rf src/LabSound-1.2.0
unzip -qq src/LabSound-1.2.0.zip -d src

unzip -qq src/alsa.zip -d src/LabSound-1.2.0/include

unzip -qq src/libsamplerate-0.2.2.zip -d src/LabSound-1.2.0/third_party/libsamplerate-0.2.2
mv src/LabSound-1.2.0/third_party/libsamplerate-0.2.2/libsamplerate-0.2.2/* src/LabSound-1.2.0/third_party/libsamplerate

unzip -qq src/libnyquist-master.zip -d src/LabSound-1.2.0/third_party/libnyquist
mv src/LabSound-1.2.0/third_party/libnyquist/libnyquist-master/* src/LabSound-1.2.0/third_party/libnyquist

rm -rf src/build
mkdir -p src/build
