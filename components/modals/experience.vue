<script lang="ts" setup>
import { reactive, ref } from "vue";
import type { FormInstance } from "ant-design-vue";
import dayjs from "dayjs";

const { id: workerId, refresh, cv } = await useWorker();

interface Experience {
	company: string;
	position?: string;
	startDate?: Date | null;
	endDate?: Date | null;
	description?: string;
}

const emptyExperience: Experience = {
	company: "",
	position: "",
	startDate: null,
	endDate: null,
	description: "",
};

const formRef = ref<FormInstance>();
const currentlyWorking = ref<boolean>(false);
const experience = reactive<Experience>(emptyExperience);

const showModal = () => {
	open.value = true;
};

const open = ref<boolean>(false);
const confirmLoading = ref<boolean>(false);

const submit = async () => {
	await $fetch(`/api/worker/${workerId}/experience/work`, { method: "POST", body: experience });
	await refresh();
	open.value = false;
};
</script>

<template>
	<div>
		<div class="flex justify-end">
			<a-button class="text-right" type="primary" @click="showModal">Add Experience</a-button>
		</div>
		<a-list item-layout="horizontal" :data-source="cv?.experiences ?? []">
			<template #renderItem="{ item }">
				<a-list-item>
					<a-list-item-meta>
						<template #title>
							<h1 style="font-size: 1.1rem">{{ item.company }}</h1>
						</template>
						<template #description>
							<div>
								<p v-if="item.position"><b>Position:</b> {{ item.position }}</p>
								<p>
									<b>Period:</b> {{ dayjs(item.startDate).format("DD-MM-YY") }} -
									{{ !item.endDate ? "Present" : dayjs(item.endDate).format("DD-MM-YY") }}
								</p>
								<p v-if="item.description"><b>Description:</b> {{ item.description }}</p>
							</div>
						</template>
					</a-list-item-meta>
				</a-list-item>
			</template>
		</a-list>
		<a-modal v-model:open="open" title="Add Experience" :confirm-loading="confirmLoading" @ok="submit">
			<a-form ref="formRef" layout="vertical" name="experience_form" :model="experience">
				<a-row :gutter="20">
					<a-col span="12">
						<a-form-item label="Company Name" required :rules="{ required: true, message: 'Missing company name' }">
							<a-input v-model:value="experience.company" placeholder="Company Name" />
						</a-form-item>
					</a-col>
					<a-col span="12">
						<a-form-item label="Position">
							<a-input v-model:value="experience.position" placeholder="Position" />
						</a-form-item>
					</a-col>
					<a-col span="12">
						<a-form-item label="Start Date" required :rules="{ required: true, message: 'Start date required' }">
							<a-date-picker v-model:value="experience.startDate" placeholder="Start Date" class="w-full" />
						</a-form-item>
					</a-col>
					<a-col span="12">
						<a-form-item label="End Date" v-if="!currentlyWorking">
							<a-date-picker v-model:value="experience.endDate" placeholder="End Date" class="w-full" />
						</a-form-item>
					</a-col>
					<a-col span="24">
						<a-form-item>
							<a-checkbox v-model:checked="currentlyWorking">Currently Working Here</a-checkbox>
						</a-form-item>
					</a-col>
					<a-col span="24">
						<a-form-item label="Description">
							<a-textarea v-model:value="experience.description" placeholder="Description" />
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
