import { CourseExperienceSchema } from "~/types/worker/experience";

export default defineEventHandler(async (event) => {
	const workerId = getRouterParam(event, "workerId");
	if (!workerId) throw createError("Worker ID is required");

	const body = await readBody(event);
	const data = CourseExperienceSchema.parse(body);

	const { workerAddCourseExperience } = useEdgeDbQueriesWithGlobals();

	const result = await workerAddCourseExperience({ workerId, ...data });

	return result;
});
