<script setup lang="ts">
import type { ProfileInterface } from "~/types/employer/profile";

const { data: profile, refresh } = await useFetch(`/api/employer/profile/profile`);

const handleProfileUpdate = async (event: ProfileInterface) => {
	const updated = await useFetch("/api/employer/profile/profile", {
		method: "PUT",
		body: JSON.stringify(event),
	});

	if (updated.data) {
		refresh();
	}
};
</script>

<template>
	<pre>{{ profile }}</pre>
	<EmployerCompanyProfileTab :profile="profile" @submit="handleProfileUpdate" />
</template>
