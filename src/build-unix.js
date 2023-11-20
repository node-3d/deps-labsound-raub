'use strict';

const path = require('node:path');
const util = require('node:util');
const exec = util.promisify(require('node:child_process').exec);

const {
	getPlatform,
} = require('addon-tools-raub');


const platform = getPlatform();

const getScriptForLib = () => `src/${platform}.sh`;


const fail = (error) => {
	console.error(error);
	process.exit(-1);
};


const updateSystem = async () => {
	try {
		if (!['linux', 'aarch64'].includes(platform)) {
			return;
		}
		
		console.log('Updating System');
		const { stderr } = await exec(`sh src/update-${platform}.sh`);
		if (stderr) {
			console.error(stderr);
		}
		console.log('-------------------');
		console.log('Extracting Alsa');
		const { stderr } = await exec(`sh src/extract-${platform}.sh`);
		if (stderr) {
			console.error(stderr);
		}
		console.log('-------------------');
	} catch (error) {
		fail(error);
	}
};


const buildLib = async () => {
	try {
		console.log(`LABSOUND Build Started`);
		const { stderr, stdout } = await exec(`sh ${getScriptForLib()}`);
		if (stdout) {
			console.error(stdout);
		}
		if (stderr) {
			console.error(stderr);
		}
		console.log(`LABSOUND Build Finished`);
		console.log('-------------------');
	} catch (error) {
		fail(error);
	}
};


(async () => {
	try {
		await updateSystem();
		
		await buildLib();
	} catch (error) {
		fail(error);
	}
})();
