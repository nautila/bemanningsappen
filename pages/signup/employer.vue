<script setup lang="ts">
import type { SignupEmployerFormData } from "@/types/signup-employer";

definePageMeta({ layout: "public" });

const onSubmit = async (body: SignupEmployerFormData) => {
	const res = await $fetch("/api/signup/employer", { method: "POST", body });

	if (res) {
		navigateTo("/"); // TODO: Send to login instead.
	}
};
</script>

<template>
	<registration-employer @submit="onSubmit" />
</template>
