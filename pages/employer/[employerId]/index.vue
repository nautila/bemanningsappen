<script setup lang="ts">
const { data } = await useEmployer();
</script>

<template>
	<div>
		<pre>{{ data }}</pre>
		<BEmployerProfileForm />
	</div>
</template>
