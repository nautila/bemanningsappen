import type { LoginResponse } from "~/types/auth";

export interface SessionStoreData {
	token: string;
	user: any; // TODO
	accounts: any[]; // TODO
}

export const useSessionStore = defineStore("session", () => {
	const session = ref<null | SessionStoreData>(null);

	const token = computed(() => session.value?.token);
	const user = computed(() => session.value?.user);
	const accounts = computed(() => session.value?.accounts);

	function set(loginResponse: LoginResponse) {
		session.value = loginResponse;
	}

	return { session, token, user, accounts, set };
});
