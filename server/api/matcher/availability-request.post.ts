export default defineEventHandler(async (event) => {
	const body = await readBody(event);
	const { createEmployerWorkerAvailabilityRequest } = useEdgeDbQueriesWithGlobals();
	return createEmployerWorkerAvailabilityRequest(body);
});
