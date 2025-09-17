export function getNewExpiresAt() {
	const nowTime = new Date().getTime();
	return nowTime + 60000 * 5;
}
