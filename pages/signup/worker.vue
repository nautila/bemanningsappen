<script setup lang="ts">
import type { SignupWorkerFormData } from "@/types/signup-worker";

definePageMeta({ layout: "public" });

const onSubmit = async (body: SignupWorkerFormData) => {
	const res = await $fetch("/api/signup/worker", { method: "POST", body });

	if (res) {
		navigateTo("/auth/login");
	}
};
</script>

<template>
	<registration-worker @submit="onSubmit" />
</template>
