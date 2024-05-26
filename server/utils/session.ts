import { H3Event } from "h3";

export function parseSession(event: H3Event) {
	const session = getCookie(event, "session");
	if (!session)
		throw createError({
			status: 401,
			statusText: "Unauthorized",
		});

	const authClientToken = JSON.parse(session).session.token;

	return { authClientToken };
}
