import { EducationExperienceSchema } from "~/types/worker/experience";

export default defineEventHandler(async (event) => {
	const workerId = getRouterParam(event, "workerId");
	if (!workerId) throw createError("Worker ID is required");

	const body = await readBody(event);
	const data = EducationExperienceSchema.parse(body);

	const { workerAddEducationExperience } = useEdgeDbQueries();

	const result = await workerAddEducationExperience({ workerId, ...data });

	return result;
});
