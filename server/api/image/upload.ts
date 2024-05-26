import { useEdgeDbQueriesWithGlobals } from "~/server/edgedb";

export default defineEventHandler(async (event) => {
	const files = await readMultipartFormData(event);

	if (!files)
		return createError({
			statusCode: 400,
			statusText: "Need to provide images.",
		});

	const file = files[0];
	if (!file.type?.startsWith("image/"))
		return createError({
			statusCode: 400,
			statusText: "Only images allowed.",
		});

	const { insertImage } = useEdgeDbQueriesWithGlobals();

	const image = await insertImage({
		name: file.name ?? "",
		data: file.data,
	});

	return image;

	// files.forEach((f) => {
	// 	if (!f.type?.startsWith("image/")) {
	// 		return createError({
	// 			statusCode: 400,
	// 			statusText: "Only images allowed.",
	// 		});
	// 	}
	// });
	// const toUpload = files.map((f) =>
	// 	insertImage({
	// 		name: f.name ?? "",
	// 		data: f.data,
	// 	}),
	// );
	// await Promise.all(toUpload);
});
