<script setup lang="ts">
import type { Worker } from "~/types/worker/worker";

const props = defineProps<{
	worker: Worker;
}>();

const { id: employerId } = await useEmployer();

const name = computed(() => [props.worker.user.firstName, props.worker.user.lastName].join(" "));

const hasRequestedAvailability = ref(false);

const requestAvailability = async () => {
	const res = await $fetch(`/api/matcher/availability-request`, {
		method: "POST",
		body: {
			employerId,
			workerId: props.worker.id,
		},
	});
	console.log("availability request", res);
	hasRequestedAvailability.value = true;
};
</script>

<template>
	<shared-card class="b-employer-worker-list-item" :title="name" direction="column">
		<template #title>
			<div class="title">
				<h4>{{ name }}</h4>
				<AButton v-if="!hasRequestedAvailability" type="primary" size="small" @click="requestAvailability"
					>Request Availability</AButton
				>
				<AButton v-else type="text" size="small" disabled>Availability Requested</AButton>
			</div>
		</template>

		<h5 class="tagline" v-if="worker.cv.tagline">{{ worker.cv?.tagline }}</h5>
		<p class="introduction" v-if="worker.cv.introduction">{{ worker.cv?.introduction }}</p>

		<div class="experiences" v-if="false">
			<h6>Experiences</h6>
			<ul>
				<li>fjdjfk</li>
				<li>fjdjfk</li>
				<li>fjdjfk</li>
				<li>fjdjfk</li>
				<li>fjdjfk</li>
			</ul>
		</div>
	</shared-card>
</template>

<style lang="scss" scoped>
.b-employer-worker-list-item {
	padding: 1rem;

	.title {
		display: flex;
		justify-content: space-between;
	}

	.tagline {
		font-size: 1rem;
		font-style: italic;

		& + .introduction {
			margin-top: 0.3rem;
		}
	}

	.experiences {
		margin-top: 1rem;

		h6 {
			font-weight: bold;
			margin-bottom: 0.2rem;
		}

		ul {
			padding-left: 0.3rem;

			li {
				&::before {
					content: "- ";
				}
			}
		}
	}
}
</style>
