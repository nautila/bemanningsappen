<script setup lang="ts">
import type { LoginResponse } from "~/types/auth/login";

definePageMeta({ layout: "public" });

const router = useRouter();
const session = useSessionStore();

const showLoginForm = ref(true);
const showAccountSelection = ref(false);

const handleLoggedIn = (response: LoginResponse) => {
	session.set(response);
	const accounts = session.accounts;
	console.log(accounts);

	handleSelectAccount(null); // TODO: Remove this line, and uncomment below

	// if (!accounts || !accounts.length) throw new Error("No accounts found");

	// if (accounts.length > 1) {
	// 	showLoginForm.value = false;
	// 	showAccountSelection.value = true;
	// } else if (accounts.length === 1) {
	// 	handleSelectAccount(accounts[0]);
	// }
};

const handleSelectAccount = (
	account: any, // TODO: Set proper type
) => {
	// const type = account.type;
	const type = "worker" as "worker" | "employer"; // TODO: Remove this line

	switch (type) {
		case "worker":
			return router.push("/worker");
		case "employer":
			return router.push(`/employer/${account.id}`);
	}
};
</script>

<template>
	<a-row class="w-70 m-auto flex justify-center">
		<a-card title="Login" class="w-100 bg-blend-dark">
			<BAuthLoginForm v-if="showLoginForm" @logged-in="handleLoggedIn" />
			<BAuthAccountSelection v-if="showAccountSelection" @account-selected="handleSelectAccount" />
		</a-card>
	</a-row>
</template>
