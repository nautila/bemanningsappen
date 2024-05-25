import type { SignupWorkerFormData } from "@/types/signup-worker";
import { useAuthentication } from "~/server/auth";

export default defineEventHandler(async (event) => {
	const body = await readBody<SignupWorkerFormData>(event);
	console.log("SignupWorkerFormData (server)", body);

	const { register } = useAuthentication();

	const user = await register(body);

	if (!user.id) {
		throw createError("User not created");
	}

	const { createWorker } = useEdgeDbQueries();

	const worker = await createWorker({
		userId: user.id,
	});

	if (!worker.id) {
		throw createError("Worker not created");
	}

	return worker.id;
});
