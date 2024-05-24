<template>
	<a-row type="flex" justify="center">
		<a-card title="Bemanningsappen">
			<p>Make yourself available for temp jobs in your area.</p>
			<a-flex justify="space-between" gap="20">
				<a-button type="primary" @click="handleEmployerSignup">Register as an employer</a-button>
				<a-button type="default" @click="handleWorkerSignup">Register as a Worker</a-button>
			</a-flex>
		</a-card>
	</a-row>

</template>

<script setup lang="ts">
	definePageMeta({
		layout: 'public',
	})

	const handleEmployerSignup = () => {
		useRouter().push('/signup/employer');
	}

	const handleWorkerSignup = () => {
		useRouter().push('/signup/worker');
	}
</script>
