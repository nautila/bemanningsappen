import type { LoginResponse, SessionData } from "~/types/auth";

export const useSessionStore = defineStore(
	"session",
	() => {
		const session = ref<null | SessionData>(null);

		const token = computed(() => session.value?.token);
		const user = computed(() => session.value?.user);
		const accounts = computed(() => session.value?.accounts);

		function set(loginResponse: LoginResponse) {
			session.value = loginResponse;
		}

		return { session, token, user, accounts, set };
	},
	{
		persist: true,
	},
);
