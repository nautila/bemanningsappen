import { z } from "zod";

import { ImageSchema, type ImageInterface } from "~/types/image";

export interface ProfileInterface {
	employer: { name?: string };
	logo?: ImageInterface;
	address?: string;
	description?: string;
}

export const ProfileSchema = z.object({
	name: z.optional(z.string()),
	logo: ImageSchema,
	address: z.optional(z.string()),
	description: z.optional(z.string()),
});
