<script setup lang="ts">
const { data: workerData, user, cv } = await useWorker();

const activeKey = ref("experiences");
const tabs = [
	// {
	// 	key: "personal-information",
	// 	label: "Personal Information",
	// 	component: defineAsyncComponent(() => import("@/components/worker/personalInformationTab.vue")),
	// },
	{
		key: "experiences",
		label: "Experiences",
		component: defineAsyncComponent(() => import("@/components/modals/experience.vue")),
	},
	// {
	// 	key: "qualifications",
	// 	label: "Qualifications",
	// 	component: defineAsyncComponent(() => import("@/components/worker/qualificationTab.vue")),
	// },
	// {
	// 	key: "skills",
	// 	label: "Skills",
	// 	component: defineAsyncComponent(() => import("@/components/worker/skillsTab.vue")),
	// },
];
</script>

<template>
	<a-row>
		<!-- <pre>{{ workerData }}</pre> -->

		<SharedPageHeader title="Personal Information" subTitle="Some basic information about yourself" />
		<WorkerPersonalInformationTab />

		<template v-if="cv">
			<SharedPageHeader
				title="Your Resume"
				subTitle="Experiences, qualifications and skills you have relevant to an employer" />

			<BWorkerCvForm />

			<a-col span="24">
				<a-tabs v-model:activeKey="activeKey" class="p-5 w-full">
					<a-tab-pane v-for="tab in tabs" :key="tab.key" :tab="tab.label">
						<component :is="tab.component" />
					</a-tab-pane>
				</a-tabs>
			</a-col>
		</template>

		<template v-else>
			<SharedPageHeader title="Create Resume" subTitle="Create your resume to apply for jobs" />
			<BWorkerCvForm />
		</template>
	</a-row>
</template>

<style scoped></style>
