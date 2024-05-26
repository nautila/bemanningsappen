export default defineEventHandler(async (event) => {
	const workerId = getRouterParam(event, "workerId");
	if (!workerId) throw createError("Worker ID is required");

	const { getWorker } = useEdgeDbQueriesWithGlobals();

	const worker = await getWorker({ workerId });
	return worker;
});
