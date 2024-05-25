import { useAuthentication } from "~/server/auth";
import type { LoginResponse } from "~/types/auth/login";

export default defineEventHandler(async (event) => {
	const body = await readBody(event);

	const { login } = useAuthentication();

	const token = await login(body);

	return {
		token,
		user: { id: "..." },
		accounts: [],
	} as LoginResponse;
});
