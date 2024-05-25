<script setup lang="ts">
import { Form } from "ant-design-vue";
import type { UserData } from "~/types/user";

const emit = defineEmits<{
	submit: [state: UserData];
}>();


const formState: UserData = reactive({
	firstName: "",
	lastName: "",
	dateOfBirth: null,
});
const useForm = Form.useForm;
const { validate, validateInfos } = useForm(formState, {
	firstName: [
		{
			required: true,
			message: "Please input your First name!",
		},
	],
	lastName: [
		{
			required: true,
			message: "Please input your Last name!",
		},
	],
	dateOfBirth: [
		{
			required: true,
			message: "Please select your date of birth!",
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
				<shared-image-upload />
			</a-col>
			<a-col :span="12" class="text-center">
				<shared-file-upload />
			</a-col>
			<a-col span="12">
				<a-form-item label="First name" v-bind="validateInfos.firstName">
					<a-input v-model:value="formState.firstName" placeholder="First name" />
				</a-form-item>
			</a-col>
			<a-col span="12">
				<a-form-item label="Last name" v-bind="validateInfos.lastName">
					<a-input v-model:value="formState.lastName" placeholder="Last name" />
				</a-form-item>
			</a-col>
			<a-col span="12">
				<a-form-item label="Date of birth" v-bind="validateInfos.dateOfBirth">
					<a-date-picker class="w-full" v-model:value="formState.dateOfBirth" placeholder="Date of birth" />
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
<style scoped>

</style>
