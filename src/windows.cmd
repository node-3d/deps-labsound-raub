echo 'LABSOUND Build Started'

cd src

rd /s /q "LabSound-1.2.0"
tar -xf LabSound-1.2.0.zip

tar -xf alsa-lib-1.2.10.zip -C LabSound-1.2.0/third_party/alsa-lib-1.2.10
xcopy "LabSound-1.2.0/third_party/alsa-lib-1.2.10/alsa-lib-1.2.10/include" "LabSound-1.2.0/include" /i /c /k /e /r /y

tar -xf libnyquist-master.zip -C LabSound-1.2.0/third_party/libnyquist
xcopy "LabSound-1.2.0/third_party/libnyquist/libnyquist-master" "LabSound-1.2.0/third_party/libnyquist" /i /c /k /e /r /y

rd /s /q "build"
mkdir build

cd LabSound-1.2.0
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

copy /y LabSound-1.2.0\build\bin\Release\LabSound.lib build\LabSound.lib
copy /y LabSound-1.2.0\build\bin\Release\libnyquist.lib build\libnyquist.lib
copy /y LabSound-1.2.0\build\bin\Release\libwavpack.lib build\libwavpack.lib

cd ..

echo 'LABSOUND Build Finished'
