<script setup lang="ts">
import { Form } from "ant-design-vue";
import { LockOutlined, UserOutlined } from "@ant-design/icons-vue";

import type { SignupEmployerFormData } from "@/types/signup-employer";

const emit = defineEmits<{
	submit: [state: SignupEmployerFormData];
}>();

const useForm = Form.useForm;

const formState: SignupEmployerFormData = reactive({
	companyName: "",
	firstName: "",
	lastName: "",
	email: "",
	password: "",
});

const validationRules = {
	companyName: [
		{
			required: true,
			message: "Please input your company name!",
		},
	],
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
	email: [
		{
			required: true,
			message: "Please input your email!",
		},
		{
			type: "email",
			message: "The input is not valid E-mail!",
		},
	],
	password: [
		{
			required: true,
			message: "Please input your password!",
		},
		{
			min: 8,
			message: "Password should be at least 8 characters long",
		},
	],
};

const { validate, validateInfos } = useForm(formState, validationRules);

const onSubmit = () => {
	validate()
		.then(() => {
			console.log("Form values:", formState);
			emit("submit", formState);
		})
		.catch((err) => {
			console.log(err);
		});
};
</script>

<template>
	<a-row class="w-70 m-auto flex justify-center">
		<a-card title="Register as a employer" class="w-100 bg-blend-dark">
			<a-form layout="vertical" @submit="onSubmit">
				<a-row :gutter="20">
					<a-col span="24">
						<a-form-item label="Company Name" v-bind="validateInfos.companyName">
							<a-input v-model:value="formState.companyName" placeholder="Company name" />
						</a-form-item>
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
						<a-form-item label="Email" v-bind="validateInfos.email">
							<a-input v-model:value="formState.email" placeholder="Email">
								<template #prefix>
									<UserOutlined style="color: rgba(0, 0, 0, 0.25)" />
								</template>
							</a-input>
						</a-form-item>
					</a-col>
					<a-col span="12">
						<a-form-item label="Password" v-bind="validateInfos.password">
							<a-input v-model:value="formState.password" type="password" placeholder="Password">
								<template #prefix>
									<LockOutlined style="color: rgba(0, 0, 0, 0.25)" />
								</template>
							</a-input>
						</a-form-item>
					</a-col>
					<a-col span="24" align="center">
						<a-flex justify="space-between">
							<a-button size="large" type="default" @click.prevent="() => $router.go(-1)">Back</a-button>
							<a-form-item>
								<a-button html-type="submit" type="primary" size="large"> Register </a-button>
							</a-form-item>
						</a-flex>
					</a-col>
				</a-row>
			</a-form>
		</a-card>
	</a-row>
</template>

<style scoped>
.bg-blend-dark {
	background-color: #fbf9f9; /* Replace with your desired color */
}
</style>
