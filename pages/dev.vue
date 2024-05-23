<template>
	<EdgeDbAuthEmailSignup v-slot="{ email, updateEmail, password, updatePassword, submit, loading }" redirect-to="/">
		<div>
			<input type="email" :value="email" placeholder="Email" @change="(e: any) => updateEmail(e.target.value)" />
			<input
				type="password"
				:value="password"
				placeholder="Password"
				@change="(e: any) => updatePassword(e.target.value)" />

			<button type="button" @click.prevent="(e) => !loading && submit()">{{ loading ? "Laster" : "Registrer" }}</button>
		</div>
	</EdgeDbAuthEmailSignup>
</template>
