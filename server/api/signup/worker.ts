import type { SignupWorkerFormData } from "@/types/signup-worker";

export default defineEventHandler(async (event) => {
	const body = await readBody<SignupWorkerFormData>(event);
	console.log("SignupWorkerFormData (server)", body);
});
