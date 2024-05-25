export default defineEventHandler(async (event) => {
	const workerId = getRouterParam(event, "workerId");
	if (!workerId) throw createError("Worker ID is required");

	const body = await readBody(event);

	const { upsertWorkerCv } = useEdgeDbQueries();

	const cv = await upsertWorkerCv({ ...body, workerId });
	console.log(cv);
});
