import { JWT_CONFIG_FILE_PATH } from '../shared/constants.ts';
import { writeJsonFile } from '../shared/json.utils.ts';
import { checkJwt } from '../shared/jwt.ts';
import { getNewExpiresAt } from '../shared/utils.ts';
import { defaultUser } from './___default.ts';
import { scenario } from './___scenario.ts';

export const api_account = (req: any, res: any) => {
	let file = 'api/account/';

	checkJwt(req.headers.authorization, (isExpired?: boolean, jwtConfigResult?: any) => {
		if (isExpired) return res.status(401).send('Unauthorized');

		// 'no-authorities', 'default', 'NOT_AUTHORIZED'
		if (scenario.scenarioFile === 'NOT_AUTHORIZED') {
			return res.status(401).send('Unauthorized');
		}

		if (!jwtConfigResult) jwtConfigResult = {};

		jwtConfigResult.expiresAt = getNewExpiresAt();

		writeJsonFile(JWT_CONFIG_FILE_PATH, JSON.stringify(jwtConfigResult, null, 2), () => {
			file += '_' + scenario.scenarioFile;
			res.send(defaultUser);
		});
	});
};
