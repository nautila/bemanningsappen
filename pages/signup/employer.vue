<script setup lang="ts">
import type { SignupEmployerFormData } from "@/types/signup-employer";

definePageMeta({ layout: "public" });

const onSubmit = async (body: SignupEmployerFormData) => {
	await $fetch("/api/signup/employer", { method: "POST", body });
};
</script>

<template>
	<registration-employer @submit="onSubmit" />
</template>
