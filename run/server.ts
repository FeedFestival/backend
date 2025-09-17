import express from 'express';
import cors from 'cors';

import { api_authenticate } from '../api/authenticate/api_authenticate.ts';
import { api_account } from '../api/account/api_account.ts';

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

app.listen(PORT, () => {
	console.log(`🚀 Server running at http://localhost:${PORT}`);
});
