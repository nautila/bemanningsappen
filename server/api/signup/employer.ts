import type { SignupEmployerFormData } from "@/types/signup-employer";
import { useAuthentication } from "@/server/auth";

export default defineEventHandler(async (event) => {
	const body = await readBody<SignupEmployerFormData>(event);
	console.log("SignupEmployerFormData (server)", body);

	const { register } = useAuthentication();

	const user = await register(body);

	if (!user.id) {
		throw createError("User not created");
	}

	const { createEmployer } = useEdgeDbQueriesWithGlobals();

	const employer = await createEmployer({
		userId: user.id,
		name: body.companyName,
	});

	if (!employer.id) {
		throw createError("Employer not created");
	}

	return employer;
});
