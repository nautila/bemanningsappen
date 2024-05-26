<script setup lang="ts">
import { Form } from "ant-design-vue";
import type { ProfileInterface } from "~/types/employer/profile";

const props = defineProps<{
	profile?: ProfileInterface;
}>();
const emit = defineEmits<{
	submit: [state: ProfileInterface];
}>();

const formState: ProfileInterface = reactive({
	employer: {
		name: props.profile?.employer.name || "",
	},
	logo: props.profile?.logo || undefined,
	address: props.profile?.address || "",
	description: props.profile?.description || "",
});
const useForm = Form.useForm;
const { validate, validateInfos } = useForm(formState, {
	name: [
		{
			required: false,
		},
	],
	logo: [
		{
			required: false,
		},
	],
	address: [
		{
			required: false,
		},
	],
	description: [
		{
			required: false,
		},
	],
});

const onSubmit = () => {
	validate()
		.then(() => {
			console.log("success");
			emit("submit", formState);
		})
		.catch((error) => {
			console.log("error", error);
		});
};
</script>

<template>
	<a-form layout="vertical" @submit="onSubmit">
		<a-row :gutter="20">
			<a-col :span="12" class="text-center">
				<a-form-item label="Logo">
					<shared-image-upload v-model="formState.logo" />
				</a-form-item>
			</a-col>
			<a-col span="12">
				<a-form-item label="Company name" v-bind="validateInfos.name">
					<a-input v-model:value="formState.employer.name" placeholder="Company name" />
				</a-form-item>
			</a-col>
			<a-col span="12">
				<a-form-item label="Adress" v-bind="validateInfos.address">
					<a-input v-model:value="formState.address" placeholder="Adress" />
				</a-form-item>
			</a-col>
			<a-col span="12">
				<a-form-item label="Description" v-bind="validateInfos.description">
					<a-input v-model:value="formState.description" placeholder="Description" />
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
