<script setup lang="ts">
import { Form } from "ant-design-vue";
import { LockOutlined, UserOutlined } from "@ant-design/icons-vue";

definePageMeta({ layout: "public" });

const useForm = Form.useForm;

const formState = reactive({
	email: "",
	password: "",
});

const validationRules = {
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
	],
};

const { validateInfos } = useForm(formState, validationRules);
</script>

<template>
	<EdgeDbAuthEmailLogin
		v-slot="{ email, updateEmail, password, updatePassword, submit, loading }"
		redirect-to="/auth/login-process">
		<a-row class="w-70 m-auto flex justify-center">
			<a-card title="Login" class="w-100 bg-blend-dark">
				<a-form layout="vertical" @submit.prevent="!loading && submit()">
					<a-row :gutter="20">
						<a-col span="12">
							<a-form-item label="Email" v-bind="validateInfos.email">
								<a-input
									v-model:value="formState.email"
									placeholder="Email"
									@change="(e) => updateEmail(e.target.value)">
									<template #prefix>
										<UserOutlined style="color: rgba(0, 0, 0, 0.25)" />
									</template>
								</a-input>
							</a-form-item>
						</a-col>
						<a-col span="12">
							<a-form-item label="Password" v-bind="validateInfos.password">
								<a-input
									v-model:value="formState.password"
									type="password"
									placeholder="Password"
									@change="(e) => updatePassword(e.target.value)">
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
									<a-button html-type="submit" type="primary" size="large">{{
										loading ? "Loading" : "Login"
									}}</a-button>
								</a-form-item>
							</a-flex>
						</a-col>
					</a-row>
				</a-form>
			</a-card>
		</a-row>
	</EdgeDbAuthEmailLogin>
</template>
