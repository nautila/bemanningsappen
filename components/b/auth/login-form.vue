<script setup lang="ts">
import { Form } from "ant-design-vue";
import { LockOutlined, UserOutlined } from "@ant-design/icons-vue";
import type { LoginResponse } from "~/types/auth/login";

const emit = defineEmits<{
	loggedIn: [response: LoginResponse];
}>();

const formState = reactive({ email: "", password: "" });

const { validate, validateInfos } = Form.useForm(formState, {
	email: [
		{ required: true, message: "Please input your email!" },
		{ type: "email", message: "The input is not valid E-mail!" },
	],
	password: [{ required: true, message: "Please input your password!" }],
});

const loading = ref(false);
const error = ref(false);

const submit = async () => {
	error.value = false;
	loading.value = true;

	try {
		const response = await $fetch("/api/auth/login", { method: "POST", body: formState });
		console.log("Login response", response);
		emit("loggedIn", response);
	} catch (e) {
		console.error("Login error", e);
		error.value = true;
	}

	loading.value = false;
};
</script>

<template>
	<a-form layout="vertical" :disabled="loading" @submit.prevent="!loading && submit()">
		<a-row :gutter="20">
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
					<a-form-item>
						<a-button html-type="submit" type="primary" size="large">{{ loading ? "Loading" : "Login" }}</a-button>
					</a-form-item>
				</a-flex>
			</a-col>

			<ACol :span="24" v-if="error" class="text-center text-red-500">
				<p>Invalid email or password</p>
			</ACol>
		</a-row>
	</a-form>
</template>
