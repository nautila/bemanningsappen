<script setup lang="ts">
import type { Worker } from "~/types/worker/worker";

defineProps<{
	workers: Worker[];
}>();
</script>

<template>
	<div class="b-employer-worker-list">
		<BEmployerWorkerListItem v-for="worker in workers" :key="worker.id" :worker="worker" />
	</div>
</template>

<style lang="scss">
.b-employer-worker-list {
	display: flex;
	gap: 1rem;

	flex-direction: column; // For direction="row" on <shared-card>
	// flex-wrap: wrap; // For direcion="column" on <shared-card>

	> * {
		width: 100%;
	}
}
</style>
