<script setup lang="ts">

import PageHeader from "~/components/shared/pageHeader.vue";
import dayjs from "dayjs";

const employers = [
	{
		id: 1,
		companyName: "Company Name 1",
		email: "company1@co.com",
		requestDate: dayjs(new Date()).format("DD-MM-YYYY"),
	},
	{
		id: 2,
		companyName: "Company Name 2",
		email: "company2@co.com",
		requestDate: dayjs(new Date()).format("DD-MM-YYYY"),
	},
	{
		id: 2,
		companyName: "Company Name 3",
		email: "company3@co.com",
		requestDate: dayjs(new Date()).format("DD-MM-YYYY"),
	},


];

const respondToEmployer = (employerId: number) => {
	// Placeholder for response logic. Replace with actual logic, such as opening a modal.
	message.success(`Responding to employer with ID: ${employerId}`);
};

</script>

<template>
	<page-header title="Availability Requests" subTitle="Respond to potential employer" />

	<a-row>
		<a-list class="w-full" :bordered="true" :data-source="employers" :item-layout="'horizontal'">
			<a-list-item v-for="employer in employers" :key="employer.id">
				<a-list-item-meta>
					<template #title>
						<a>{{ employer.companyName }}</a>
					</template>
					<template #description>
						<a-flex gap="10" justify="space-between">
							<div>
								<div><b>Email: </b>{{ employer.email }}</div>
								<div><b>Request Date: </b> {{ employer.requestDate }}</div>
							</div>
							<a-button type="primary" @click="respondToEmployer(employer.id)">Respond</a-button>
						</a-flex>
					</template>
				</a-list-item-meta>
			</a-list-item>
		</a-list>
	</a-row>

</template>

<style scoped>

</style>
