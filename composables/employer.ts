export const useEmployer = async (id?: string) => {
	if (!id) {
		const route = useRoute("employer-employerId");
		id = route.params.employerId;
	}

	if (!id) throw new Error("Employer ID is required");

	const { data, refresh } = await useFetch(`/api/employer/${id}`);

	const profile = computed(() => data?.value?.profile);

	return { id, data, profile, refresh };
};
