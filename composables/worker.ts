export const useWorker = async (id?: string) => {
	// If no ID is provided, try to get it from the session
	if (!id) {
		const session = useSessionStore();
		id = session.accounts?.find((account) => account.type === "default::Worker")?.id;
	}

	// If still no ID, throw an error
	// if (!id) throw new Error("Worker ID is required");

	const { data, refresh } = await useFetch(`/api/worker/${id ?? ""}`);

	const user = computed(() => data?.value?.user);
	const cv = computed(() => data?.value?.cv);

	return { id, data, user, cv, refresh };
};
