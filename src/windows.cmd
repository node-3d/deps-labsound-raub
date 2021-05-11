echo 'LABSOUND Build Started'

cd src

rd /s /q "LabSound-1.0.1"
tar -xf LabSound-1.0.1.zip

tar -xf alsa.zip -C LabSound-1.0.1/include
tar -xf libnyquist-master.zip -C LabSound-1.0.1/third_party/libnyquist
xcopy "LabSound-1.0.1/third_party/libnyquist/libnyquist-master" "LabSound-1.0.1/third_party/libnyquist" /i /c /k /e /r /y

rd /s /q "build"
mkdir build

cd LabSound-1.0.1
rd /s /q "build"
mkdir build
cd build

cmake -A x64 -DBUILD_EXAMPLE=FALSE ..

cmake --build . --target libopus --config Release
cmake --build . --target libwavpack --config Release
cmake --build . --target libnyquist --config Release
cmake --build . --target LabSound --config Release

cd bin/Release
dir

cd ../../../..

copy /y LabSound-1.0.1\build\bin\Release\LabSound.lib build\LabSound.lib
copy /y LabSound-1.0.1\build\bin\Release\libnyquist.lib build\libnyquist.lib
copy /y LabSound-1.0.1\build\bin\Release\libwavpack.lib build\libwavpack.lib

cd ..

echo 'LABSOUND Build Finished'
