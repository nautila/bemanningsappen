<script setup lang="ts">
defineProps<{
	title?: string | null;
	direction?: "column" | "row";
}>();
</script>

<template>
	<div
		class="shared-card"
		:class="{
			'shared-card--column': direction === 'column' || !direction,
			'shared-card--row': direction === 'row',
		}">
		<div class="shared-card__title">
			<slot name="title"
				><h4 v-if="title">{{ title }}</h4></slot
			>
		</div>

		<div class="shared-card__content">
			<slot />
		</div>

		<!-- <div class="shared-card__actions">
			<slot name="actions"> </slot>
		</div> -->
	</div>
</template>

<style lang="scss">
.shared-card {
	display: flex;
	padding: 1rem 1.5rem;
	border: solid 1px #c1c1c1;
	border-radius: 0.6rem;

	&--row {
		gap: 1.5rem;
		flex-direction: row;
		align-items: center;
	}
	&--column {
		width: min-content;
		gap: 0.2rem;
		flex-direction: column;
		justify-content: space-between;
	}

	&__title {
		font-size: 1.2rem;
	}
	&__content {
		flex: 1;
		// align-self: center;

		// display: flex;
		// flex-direction: column;
	}
	// &__actions {
	// 	align-self: flex-end;
	// }
}
</style>
