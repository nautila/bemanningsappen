interface SessionData {}

export const useSessionStore = defineStore("session", () => {
	const session = ref<null | SessionData>(null);

	function set(session: SessionData) {}

	return { session, set };
});
