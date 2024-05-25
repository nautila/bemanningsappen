<script setup lang="ts">
import { Form } from "ant-design-vue";
import type { WorkerCV } from "~/types/worker/cv";

const { id: workerId, cv, refresh } = await useWorker();

const body: WorkerCV = reactive({
	tagline: cv?.value?.tagline ?? undefined,
	introduction: cv?.value?.introduction ?? undefined,
});
const { validate, validateInfos } = Form.useForm(body, {
	tagline: [],
	introduction: [],
});

const onSubmit = async () => {
	try {
		await validate();
		const result = await $fetch(`/api/worker/${workerId}/cv`, { method: "PUT", body });
		console.log("success", result);
		await refresh();
	} catch (error) {
		console.log("error", error);
	}
};
</script>

<template>
	<AForm layout="vertical" @submit="onSubmit">
		<ARow :gutter="20">
			<ACol span="24">
				<AFormItem label="Tagline" v-bind="validateInfos.tagline">
					<AInput v-model:value="body.tagline" placeholder="A tagline for your resume" />
				</AFormItem>
			</ACol>
			<ACol span="24">
				<AFormItem label="Introduction" v-bind="validateInfos.introduction">
					<ATextarea v-model:value="body.introduction" placeholder="A short introduction about yourself" />
				</AFormItem>
			</ACol>
			<ACol span="24" align="right">
				<AFormItem>
					<AButton html-type="submit" type="primary" size="large">Save</AButton>
				</AFormItem>
			</ACol>
		</ARow>
	</AForm>
</template>
