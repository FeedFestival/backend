import { readJsonFile, sendJsonFile, writeJsonFile } from '../shared/json.utils.ts';
import { getNewExpiresAt } from '../shared/utils.ts';
import { JWT_CONFIG_FILE_PATH } from '../shared/constants.ts';

export const api_authenticate = (_req: any, res: any) => {
	const file = 'api/authenticate';

	readJsonFile(JWT_CONFIG_FILE_PATH, (jwtConfigResult: any) => {
		jwtConfigResult.expiresAt = getNewExpiresAt();

		writeJsonFile(JWT_CONFIG_FILE_PATH, JSON.stringify(jwtConfigResult, null, 2), () => {
			sendJsonFile(res, file);
		});
	});
};
