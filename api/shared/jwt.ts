import { JWT_CONFIG_FILE_PATH } from './constants.ts';
import { readJsonFile } from './json.utils.ts';

export function checkJwt(authorization: any, callback: any) {
	console.log('authorization: ', authorization);

	if (!authorization) {
		callback();
		return;
	}

	const nowTime = new Date().getTime();

	readJsonFile(JWT_CONFIG_FILE_PATH, (jwtConfigResult: any) => {
		const expiresAtTime = parseInt(jwtConfigResult.expiresAt);
		const isExpired = expiresAtTime < nowTime;
		console.log(`1. Checking jwt: ${isExpired ? 'EXPIRED' : 'ALL GOOD'} ${nowTime} > ${expiresAtTime}`);
		callback(isExpired, jwtConfigResult);
	});
}
