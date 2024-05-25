<script setup lang="ts">
import type { SignupWorkerFormData } from "@/types/signup-worker";

definePageMeta({ layout: "public" });

const onSubmit = async (body: SignupWorkerFormData) => {
	await $fetch("/api/signup/worker", { method: "POST", body });
};
</script>

<template>
	<registration-worker @submit="onSubmit" />
</template>
