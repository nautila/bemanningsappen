<script setup lang="ts">
const { data } = await useFetch("/api/worker");
</script>

<template>
	<div>
		<!-- <pre>{{ data }}</pre> -->
		<BEmployerWorkerList v-if="data" :workers="data" />
	</div>
</template>
