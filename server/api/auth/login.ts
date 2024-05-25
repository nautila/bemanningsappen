import type { LoginResponse } from "~/types/auth/login";

export default defineEventHandler(async (event) => {
	const body = await readBody(event);

	console.log("Login request received with body:", body);

	return {
		token: "...",
		user: { id: "..." },
		accounts: [],
	} as LoginResponse;
});
