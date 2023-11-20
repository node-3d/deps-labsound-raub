'use strict';

const path = require('node:path');

const {
	getPlatform, getBin, ensuredir, copyall, copy,
} = require('addon-tools-raub');


const bin = getBin();
const binPath = path.resolve(bin);
const platform = getPlatform();


const fail = (error) => {
	console.error(error);
	process.exit(-1);
};


(async () => {
	try {
		await ensuredir(binPath);
		
		if (['linux', 'aarch64'].includes(platform)) {
			await copy(
				path.resolve('src/alsa-${platform}/libasound.so'),
				`${binPath}/libasound.so`,
			);
		}
		
		await copyall(path.resolve('src/build'), binPath);
	} catch (error) {
		fail(error);
	}
})();
