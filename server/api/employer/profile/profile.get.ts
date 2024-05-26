import { useEdgeDbQueriesWithGlobals } from "~/server/edgedb";

export default defineEventHandler(async (event) => {
	// const employerId = getRouterParam(event, "employerId");
	// if (!employerId) throw createError("Employer ID is required");

	const session = getCookie(event, "session");
	if (!session)
		throw createError({
			status: 401,
			statusText: "Unauthorized",
		});

	const authClientToken = JSON.parse(session).session.token;

	const { getProfile, createProfile } = useEdgeDbQueriesWithGlobals({ authClientToken });

	const profile = await getProfile();

	if (!profile) {
		return await createProfile();
	}

	return profile;
});
