<script lang="ts" setup>
import { reactive, ref } from "vue";
import type { FormInstance } from "ant-design-vue";
import dayjs from "dayjs";


interface Experience {
	companyName: string;
	position?: string;
	startDate?: Date | null;
	endDate?: Date | null;
	currentlyWorking: boolean;
}

const emptyExperience: Experience = {
	companyName: "",
	position: "",
	startDate: null,
	endDate: null,
	currentlyWorking: false,
};

const formRef = ref<FormInstance>();
const experience = reactive<Experience>(emptyExperience);

const experiences = reactive<Experience[]>([])

const showModal = () => {
	open.value = true;
};

const open = ref<boolean>(false);
const confirmLoading = ref<boolean>(false);

const handleOk = () => {
	if (experience.companyName) {
		experiences.push(experience);
	}

	console.log("Received values of form:", experience);
	open.value = false;
};

</script>

<template>
	<div>
		<div class="flex justify-end">
			<a-button class="text-right" type="primary" @click="showModal">Add Experience</a-button>
		</div>
		<a-list item-layout="horizontal" :data-source="experiences">
			<template #renderItem="{ item }">
				<a-list-item>
					<a-list-item-meta>
						<template #title>
							<h1>{{ item.companyName }}</h1>
						</template>
						<template #description>
							<div>
								<p>{{ item.position }}</p>
								<p><b>Start Date:</b> {{ dayjs(item.startDate).format('DD-MM-YY') }}</p>
								<p><b>End Date:</b> {{ item.currentlyWorking ? 'Present' : dayjs(item.endDate).format('DD-MM-YY') }}</p>
							</div>
						</template>
					</a-list-item-meta>
				</a-list-item>
			</template>
		</a-list>
		<a-modal v-model:open="open" title="Add Experience" :confirm-loading="confirmLoading" @ok="handleOk">
			<a-form ref="formRef" layout="vertical" name="experience_form" :model="experience">
				<a-row :gutter="20">
					<a-col span="12">
						<a-form-item
							label="Company Name"
							required
							:rules="{ required: true, message: 'Missing company name' }">
							<a-input v-model:value="experience.companyName" placeholder="Company Name" />
						</a-form-item>
					</a-col>
					<a-col span="12">
						<a-form-item label="Position">
							<a-input v-model:value="experience.position" placeholder="Position" />
						</a-form-item>
					</a-col>
					<a-col span="12">
						<a-form-item label="Start Date">
							<a-date-picker v-model:value="experience.startDate" placeholder="Start Date" class="w-full" />
						</a-form-item>
					</a-col>
					<a-col span="12">
						<a-form-item label="End Date" v-if="!experience.currentlyWorking">
							<a-date-picker v-model:value="experience.endDate" placeholder="End Date" class="w-full" />
						</a-form-item>
					</a-col>
					<a-col span="24">
						<a-form-item>
							<a-checkbox v-model:checked="experience.currentlyWorking">Currently Working Here</a-checkbox>
						</a-form-item>
					</a-col>
<!--					<a-col span="24" >-->
<!--						<a-form-item>-->
<!--							<a-button type="primary" html-type="submit">Save</a-button>-->
<!--						</a-form-item>-->
<!--					</a-col>-->
				</a-row>
			</a-form>
		</a-modal>
	</div>
</template>

<style scoped></style>
