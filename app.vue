<script setup lang="ts">
const session = useSessionStore();
const worker = await useWorker();

const showDebug = ref(false);
const toggleDebug = () => (showDebug.value = !showDebug.value);
</script>

<template>
	<div>
		<AButton id="debug-toggle" @click="toggleDebug">Debug</AButton>

		<div id="debug" v-if="showDebug">
			<h3>Session</h3>
			<pre>{{ session.session }}</pre>

			<h3>Worker</h3>
			<pre>{{ worker.data }}</pre>
		</div>

		<NuxtLayout>
			<NuxtPage />
		</NuxtLayout>
	</div>
</template>

<style lang="scss" scoped>
#debug-toggle {
	position: fixed;
	top: 1rem;
	left: 50%;
	transform: translateX(-50%);
	z-index: 1000;
}
#debug {
	margin: 2rem;
	padding: 1rem;
	border: 1px solid #ccc;

	h3 {
		font-weight: bold;
		text-decoration: underline;
		margin: 0.5rem 0;
	}

	pre {
		font-family: monospace;
		background: #f4f4f4;
		padding: 1rem;
		max-height: 10rem;
		overflow: auto;
	}
}
</style>
