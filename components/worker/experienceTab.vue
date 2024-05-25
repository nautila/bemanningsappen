<script lang="ts" setup>
import { reactive, ref } from "vue";
import { MinusCircleOutlined, PlusOutlined } from "@ant-design/icons-vue";
import type { FormInstance } from "ant-design-vue";

interface Experience {
	companyName: string;
	position?: string;
	startDate?: Date | null;
	endDate?: Date | null;
	currentlyWorking: boolean;
	id: number;
}

const formRef = ref<FormInstance>();
const dynamicValidateForm = reactive<{ experiences: Experience[] }>({
	experiences: [],
});
const removeExperience = (exp: Experience) => {
	const index = dynamicValidateForm.experiences.indexOf(exp);
	if (index !== -1) {
		dynamicValidateForm.experiences.splice(index, 1);
	}
};
const addExperience = () => {
	dynamicValidateForm.experiences.push({
		companyName: "",
		position: "",
		startDate: null,
		endDate: null,
		currentlyWorking: false,
		id: Date.now(),
	});
};
const onFinish = (values) => {
	console.log("Received values of form:", values);
	console.log("dynamicValidateForm.experiences:", dynamicValidateForm.experiences);
};
</script>
<template>
	<a-form
		ref="formRef"
		layout="vertical"
		name="dynamic_form_nest_item"
		:model="dynamicValidateForm"
		@finish="onFinish"
	>
		<a-row :gutter="20" v-for="(exp, index) in dynamicValidateForm.experiences" :key="exp.id">
			<a-col span="12">
				<a-form-item
					label="Company Name"
					:name="['experiences', index, 'companyName']"
					:rules="{ required: true, message: 'Missing company name' }"
				>
					<a-input v-model:value="exp.companyName" placeholder="Company Name" />
				</a-form-item>
			</a-col>

			<a-col span="12">
				<a-form-item
					label="Position"
					:name="['experiences', index, 'position']"
				>
					<a-input v-model:value="exp.position" placeholder="Position" />
				</a-form-item>
			</a-col>
			<a-col span="12">
				<a-form-item
					label="Start Date"
					:name="['experiences', index, 'startDate']"
				>
					<a-date-picker v-model:value="exp.startDate" placeholder="Start Date" class="w-full" />
				</a-form-item>
			</a-col>

			<a-col span="12">
				<a-form-item
					label="End Date"
					:name="['experiences', index, 'endDate']"
					v-if="!exp.currentlyWorking"
				>
					<a-date-picker v-model:value="exp.endDate" placeholder="End Date" class="w-full" />
				</a-form-item>
			</a-col>
			<a-col span="24" class="flex justify-between">
				<a-form-item
					:name="['experiences', index, 'currentlyWorking']"
				>
					<a-checkbox v-model:checked="exp.currentlyWorking">Currently Working Here</a-checkbox>
				</a-form-item>
				<MinusCircleOutlined @click="removeExperience(exp)" />
			</a-col>
		</a-row>

		<a-col span="24">
			<a-form-item>
				<a-button type="dashed" block @click="addExperience">
					<PlusOutlined />
					Add Experience
				</a-button>
			</a-form-item>
		</a-col>
		<a-form-item>
			<a-button type="primary" html-type="submit">Submit</a-button>
		</a-form-item>
	</a-form>
</template>
<style scoped>

</style>
