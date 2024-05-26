export default defineEventHandler(async (event) => {
	const employerId = getRouterParam(event, "employerId");
	if (!employerId) throw createError("Employer ID is required");

	const { getEmployer } = useEdgeDbQueriesWithGlobals();

	const employer = await getEmployer({ employerId });
	return employer;
});
