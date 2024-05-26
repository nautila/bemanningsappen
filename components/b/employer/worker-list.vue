<script setup lang="ts">
import type { Worker } from "#edgedb/interfaces";

defineProps<{
	workers: Worker[];
}>();
</script>

<template>
	<div class="b-employer-worker-list">
		<div v-for="worker in workers" :key="worker.id">
			<shared-card title="Arbeider 1" direction="row">
				<p>
					<span>Erfaringer</span>
					<!--
					<span v-for="exp in worker.experiences">{{ exp }}</span>
					-->
					<span>fjdjfk</span>
					<span>fjdjfk</span>
					<span>fjdjfk</span>
					<span>fjdjfk</span>
					<span>fjdjfk</span>
				</p>
				<p>
					<span>Kvalifikasjoner</span>
					<span>fjdjfk</span>
					<span>fjdjfk</span>
					<span>fjdjfk</span>
					<span>fjdjfk</span>
					<span>fjdjfk</span>
				</p>
				<p>
					<span>Ferdigheter</span>
					<span>fjdjfk</span>
					<span>fjdjfk</span>
					<span>fjdjfk</span>
					<span>fjdjfk</span>
					<span>fjdjfk</span>
				</p>
			</shared-card>
		</div>
	</div>
</template>

<style lang="scss">
.b-employer-worker-list {
	display: flex;
	gap: 1rem;

	flex-direction: column; // For direction="row" on <shared-card>
	// flex-wrap: wrap; // For direcion="column" on <shared-card>

	.shared-card {
		p {
			display: flex;
			gap: 0.25rem;
		}
	}
}
</style>
