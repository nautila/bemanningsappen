import type { SignupEmployerFormData } from "@/types/signup-employer";

export default defineEventHandler(async (event) => {
	const body = await readBody<SignupEmployerFormData>(event);
	console.log("SignupEmployerFormData (server)", body);
});
