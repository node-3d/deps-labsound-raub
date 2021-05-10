echo 'LABSOUND Build Started'

cd src

rd /s /q "LabSound-1.0.1"
tar -xf LabSound-1.0.1.zip

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

cd ..

echo 'LABSOUND Build Finished'
