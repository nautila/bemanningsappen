export default defineEventHandler(async (event) => {
	const workerId = getRouterParam(event, "workerId");
	if (!workerId) throw createError("Worker ID is required");

	console.log("workerId (server)", workerId);

	const { getWorkerCv } = useEdgeDbQueries();

	const cv = await getWorkerCv({ workerId });
	console.log(cv);
});
