export default defineEventHandler(async (event) => {
	const { listWorkers } = useEdgeDbQueriesWithGlobals();
	return listWorkers();
});
