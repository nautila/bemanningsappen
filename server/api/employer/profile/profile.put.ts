import { useEdgeDbQueriesWithGlobals } from "~/server/edgedb";
import type { ProfileInterface } from "~/types/employer/profile";

export default defineEventHandler(async (event) => {
	const session = getCookie(event, "session");
	if (!session)
		throw createError({
			status: 401,
			statusText: "Unauthorized",
		});

	const body = await readBody<ProfileInterface>(event);

	const authClientToken = JSON.parse(session).session.token;
	const { updateProfile, insertImage, updateEmployer } = useEdgeDbQueriesWithGlobals({ authClientToken });

	await updateEmployer({
		name: body.employer.name,
	});

	let imageId: string | undefined = undefined;
	if (body.logo) {
		const data = new Uint8Array(await body.logo.data.arrayBuffer());

		const image = await insertImage({
			name: body.logo.name ?? "",
			data,
		});

		imageId = image.id;
	}

	return updateProfile({
		address: body.address,
		description: body.description,
		imageId,
	});
});
