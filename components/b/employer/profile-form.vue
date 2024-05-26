<script setup lang="ts">
import { Form } from "ant-design-vue";
import type { EmployerProfileInterface } from "~/types/employer/profile";

const { id, profile, refresh } = await useEmployer();

const body: EmployerProfileInterface = reactive({
	name: profile.value?.name ?? undefined,
	logo: (profile.value?.logo ?? undefined) as any, // FIXME: fix this type
	address: profile.value?.address ?? undefined,
	description: profile.value?.description ?? undefined,
});

const { validate, validateInfos } = Form.useForm(body, {
	name: [{ required: false }],
	logo: [{ required: false }],
	address: [{ required: false }],
	description: [{ required: false }],
});

const onSubmit = async () => {
	try {
		await validate();
		const result = await $fetch(`/api/employer/${id}/profile`, { method: "PUT", body });
		console.log("success", result);
		await refresh();
	} catch (e) {
		console.log("error", e);
	}
};
</script>

<template>
	<a-form layout="vertical" @submit="onSubmit">
		<a-row :gutter="20">
			<!-- <a-col :span="12" class="text-center">
				<a-form-item label="Logo">
					<shared-image-upload v-model="body.logo" />
				</a-form-item>
			</a-col> -->
			<a-col span="12">
				<a-form-item label="Company name" v-bind="validateInfos.name">
					<a-input v-model:value="body.name" placeholder="Company name" />
				</a-form-item>
			</a-col>
			<a-col span="12">
				<a-form-item label="Address" v-bind="validateInfos.address">
					<a-input v-model:value="body.address" placeholder="Address" />
				</a-form-item>
			</a-col>
			<a-col span="12">
				<a-form-item label="Description" v-bind="validateInfos.description">
					<a-input v-model:value="body.description" placeholder="Description" />
				</a-form-item>
			</a-col>
			<a-col span="24" align="right">
				<a-form-item>
					<a-button html-type="submit" type="primary" size="large"> Save</a-button>
				</a-form-item>
			</a-col>
		</a-row>

		<a-row />
	</a-form>
</template>
<style scoped></style>
