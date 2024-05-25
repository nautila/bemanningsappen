import { useAuthentication } from "~/server/auth";
import { useEdgeDbQueriesWithGlobals } from "~/server/edgedb";
import type { LoginResponse } from "~/types/auth";

export default defineEventHandler(async (event) => {
	const body = await readBody(event);

	const { login } = useAuthentication();

	const authClientToken = await login(body);

	const { getUser } = useEdgeDbQueriesWithGlobals({ authClientToken });

	const user = await getUser();

	if (!user)
		throw createError({
			statusCode: 404,
			statusMessage: "User not found",
		});

	return {
		token: authClientToken,
		user: { id: user.id },
		accounts: [...user.employers, ...(user.worker ? [user.worker] : [])],
	} as LoginResponse;
});
