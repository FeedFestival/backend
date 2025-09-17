import express from 'express';
import cors from 'cors';

import { api_authenticate } from '../api/authenticate/api_authenticate.ts';
import { api_account } from '../api/account/api_account.ts';
import { api_management_info } from '../api/management/info/api_management_info.ts';
import { api_account_reset_password_finish } from '../api/account/reset-password/finish/api_account_reset-password_finish.ts';

const app = express();
const PORT = process.env.PORT || 8080;

app.use(
	cors({
		origin: '*',
		methods: ['GET', 'POST'],
		allowedHeaders: ['Content-Type'],
	}),
);

app.get('/', (req, res) => {
	res.send('Welcome to my server!');
});

app.post('/api/authenticate', api_authenticate);
app.get('/api/account', api_account);

app.get('/api/management/info', api_management_info);

app.post('/api/account/reset-password/finish', api_account_reset_password_finish);

/*
-----------------------------------------------------------------------------------------
-------------------------------------
--------
*/



/*
--------
-------------------------------------
-----------------------------------------------------------------------------------------
*/


app.listen(PORT, () => {
	console.log(`🚀 Server running at http://localhost:${PORT}`);
});
