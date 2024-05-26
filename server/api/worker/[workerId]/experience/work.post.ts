// import { WorkExperienceSchema } from "~/types/worker/experience";

export default defineEventHandler(async (event) => {
	const workerId = getRouterParam(event, "workerId");
	if (!workerId) throw createError("Worker ID is required");

	const body = await readBody(event);
	const startDate = body.startDate.split("T")[0];
	const endDate = !!body.endDate ? body.endDate.split("T")[0] : undefined;
	// const data = WorkExperienceSchema.parse(body);

	const { workerAddWorkExperience } = useEdgeDbQueriesWithGlobals();

	const result = await workerAddWorkExperience({ workerId, ...body, startDate, endDate });

	return result;
});
