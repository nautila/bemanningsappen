import { ProjectExperienceSchema } from "~/types/worker/experience";

export default defineEventHandler(async (event) => {
	const workerId = getRouterParam(event, "workerId");
	if (!workerId) throw createError("Worker ID is required");

	const body = await readBody(event);
	const data = ProjectExperienceSchema.parse(body);

	const { workerAddProjectExperience } = useEdgeDbQueries();

	const result = await workerAddProjectExperience({ workerId, ...data });

	return result;
});
