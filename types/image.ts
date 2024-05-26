import { z } from "zod";

const MAX_FILE_SIZE = 2000000;
const ACCEPTED_IMAGE_TYPES = ["image/jpeg", "image/jpg", "image/png", "image/webp"];

export interface ImageInterface {
	name: string;
	data: Blob;
}

export const ImageSchema = z.object({
	name: z.string(),
	data: z
		.any()
		.refine((file) => file?.size <= MAX_FILE_SIZE, `Max image size is 2MB.`)
		.refine(
			(file) => ACCEPTED_IMAGE_TYPES.includes(file?.type),
			"Only .jpg, .jpeg, .png and .webp formats are supported.",
		),
});
