import type { EmployerProfileInterface } from "~/types/employer/profile";

export default defineEventHandler(async (event) => {
	const employerId = getRouterParam(event, "employerId");
	if (!employerId) throw createError("Employer ID is required");

	const { upsertEmployerProfile, insertImage } = useEdgeDbQueriesWithGlobals({ ...parseSession(event) });

	const body = await readBody<EmployerProfileInterface>(event);

	let imageId: string | undefined = undefined;
	if (body.logo) {
		const data = new Uint8Array(await body.logo.data.arrayBuffer());

		const image = await insertImage({
			name: body.logo.name ?? "",
			data,
		});

		imageId = image.id;
	}

	return upsertEmployerProfile({
		employerId,
		...body,
		// imageId,
	});
});
