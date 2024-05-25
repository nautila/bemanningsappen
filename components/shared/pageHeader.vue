<template>
	<a-col span="24">
		<a-page-header
			style="border: 1px solid rgb(235, 237, 240)"
			:title="title"
			:sub-title="subTitle"
		/>
	</a-col>
</template>
<script setup lang="ts">
		const {title, subTitle} = defineProps({
			title: {
				type: String,
				default: "Page Title",
			},
			subTitle: {
				type: String,
				default: "Page description",
			},
		})
</script>
