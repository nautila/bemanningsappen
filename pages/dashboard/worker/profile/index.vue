<template>
	<a-row>
		<shared-page-header title="Profile Information" subTitle="Your profile information" />
		<a-col spnan="24">
			<a-tabs v-model:activeKey="activeKey" class="p-5" >
				<a-tab-pane v-for="tab in tabs" :key="tab.key" :tab="tab.label" @click.prevent="changeComponet(tab.key)">
					<component :is="tab.component" />
				</a-tab-pane>
			</a-tabs>
		</a-col>
	</a-row>

</template>

<script setup lang="ts">
const activeKey = ref("personal-information");
const SkillsTab = defineAsyncComponent(() => import("@/components/worker/skillsTab.vue"));
const QualificationTab = defineAsyncComponent(() => import("@/components/worker/qualificationTab.vue"));
const ExperienceTab = defineAsyncComponent(() => import("@/components/worker/experienceTab.vue"));
const PersonalInformationTab = defineAsyncComponent(() => import("@/components/worker/personalInformationTab.vue"));

const tabs = [
	{
		key: "personal-information",
		label: "Personal Information",
		component: PersonalInformationTab,
	},
	{
		key: "qualification",
		label: "Qualification",
		component: QualificationTab,
	},
	{
		key: "experience",
		label: "Experience",
		component: ExperienceTab,
	},
	{
		key: "skills",
		label: "Skills",
		component: SkillsTab,
	},
];

</script>


<style scoped>

</style>
