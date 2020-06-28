echo 'Unpack Started'

(
	
	cd src
	
	rm -rf LabSound-master
	unzip -qq LabSound-master.zip -d .
	unzip -qq alsa.zip -d LabSound-master/include
	
	unzip -qq libnyquist-master.zip -d LabSound-master/third_party/libnyquist
	mv LabSound-master/third_party/libnyquist/libnyquist-master/* LabSound-master/third_party/libnyquist
	
)

echo 'Unpack Finished'
