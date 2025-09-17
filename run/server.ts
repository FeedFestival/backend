import express from 'express';
import cors from 'cors';

// import { run as openChrome } from './open-chrome.ts';
// import { run as endpointCall } from './endpoint-call.ts';

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

app.listen(PORT, () => {
	console.log(`🚀 Server running at http://localhost:${PORT}`);
});
