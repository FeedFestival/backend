import path from 'path';
import fs from 'fs';

export function readJsonFile(file: string, callback: { (arg0: string): void }, ext = '.json') {
	const filePath = `./${file}${ext}`;
	fs.readFile(filePath, 'utf8', (err, data) => {
		if (err) {
			console.error('Error reading file:', err);
			return;
		}
		if (ext === '.json') {
			callback(JSON.parse(data));
		} else {
			callback(data);
		}
	});
}

export function writeJsonFile(
	file: string,
	jsonData: string | NodeJS.ArrayBufferView<ArrayBufferLike>,
	callback: { (): void; (arg0: any): void },
	ext = '.json',
) {
	const filePath = `./${file}${ext}`;
	fs.writeFile(filePath, jsonData, (err: any) => {
		if (err) {
			console.error('Error writing file:', err);
			return;
		}
		if (ext === '.json') {
			callback(jsonData);
		}
	});
}

// export function checkFile(file, ext = '.json', onSuccess = () => {}, onFail = () => {}) {
//     const filePath = `./${file}${ext}`;

//     fs.access(filePath, fs.constants.F_OK, err => {
//         if (err) {
//             onFail();
//             return;
//         }

//         onSuccess();
//     });
// }

export function sendJsonFile(
	res: {
		status: (arg0: number) => { (): any; new (): any; send: { (arg0: string): void; new (): any } };
		send: (arg0: string) => void;
	},
	file: string,
	ext = '.json',
) {
	const filePath = `./${file}${ext}`;
	console.log('Sending file [' + filePath + '] JSON as response.');
	fs.readFile(filePath, 'utf8', (err, data) => {
		if (err) {
			console.error('Error reading file:', err);
			res.status(500).send('Internal Server Error');
			return;
		}
		if (ext === '.json') {
			res.send(JSON.parse(data));
		} else {
			res.send(data);
		}
	});
}
