import { z } from "zod";

export const ExperienceTypeSchema = z.enum(["Work", "Education", "Course", "Project"]);

export const ExperienceSchema = z.object({
	// type: ExperienceTypeSchema,
	description: z.optional(z.string()),
	startDate: z.string().date(),
	endDate: z.optional(z.string().date()),
});

export const WorkExperienceSchema = ExperienceSchema.extend({
	company: z.string(),
	position: z.optional(z.string()),
});

export const EducationExperienceSchema = ExperienceSchema.extend({
	school: z.string(),
	degree: z.string(),
});

export const CourseExperienceSchema = ExperienceSchema.extend({
	course: z.string(),
	provider: z.optional(z.string()),
});

export const ProjectExperienceSchema = ExperienceSchema.extend({
	project: z.string(),
	role: z.optional(z.string()),
});
