<script setup lang="ts">
import type { Worker } from "#edgedb/interfaces";

const workers: Worker[] = [
	{
		user: {
			id: "db0cead-ae0decb-bdce0ab-debac",
			identities: [],
		},
		id: "0fd8a-ffdf-afaifdf8f-dabce",
	},
	{
		user: {
			id: "db0cead-ae0decb-bdce0ab-debac",
			identities: [],
		},
		id: "0fd8a-ffdf-afaifdf8f-dabce",
	},
	{
		user: {
			id: "db0cead-ae0decb-bdce0ab-debac",
			identities: [],
		},
		id: "0fd8a-ffdf-afaifdf8f-dabce",
	},
];
</script>

<template>
	<b-employer-worker-list :workers="workers" />
</template>
