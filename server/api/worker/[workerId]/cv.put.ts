export default defineEventHandler(async (event) => {
	const workerId = getRouterParam(event, "workerId");
	if (!workerId) throw createError("Worker ID is required");

	const body = await readBody(event);
	console.log(body);

	const { upsertWorkerCv } = useEdgeDbQueriesWithGlobals();

	const cv = await upsertWorkerCv({ ...body, workerId });
	console.log(cv);

	return cv;
});
