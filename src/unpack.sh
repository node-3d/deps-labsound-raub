echo 'Unpack Started'

(
	
	cd src
	
	unzip -qq LabSound-master.zip -d .
	unzip -qq libnyquist-master.zip -d LabSound-master/third_party/libnyquist
	unzip -qq alsa.zip -d LabSound-master/include
	mv LabSound-master/third_party/libnyquist/libnyquist-master/* LabSound-master/third_party/libnyquist
	
	cp labsound.pro LabSound-master/qmake
	
)

echo 'Unpack Finished'
