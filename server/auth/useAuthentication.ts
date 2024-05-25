import generatePKCE from "./generatePKCE";

// TODO: Replace with proper envvar getter functions.
// const EDGEDB_AUTH_BASE_URL = process.env.EDGEDB_AUTH_BASE_URL;
const EDGEDB_AUTH_BASE_URL = "http://localhost:10732/branch/main/ext/auth";
const SERVER_PORT = 3000;
const EDGEDB_AUTH_DEFAULT_PROVIDER = "builtin::local_emailpassword";

const handleSignup = async (form: any) => {
	const { createUser } = useEdgeDbQueries();
	const pkce = generatePKCE();

	const { email, password } = form;
	const provider = EDGEDB_AUTH_DEFAULT_PROVIDER;
	if (!email || !password || !provider)
		throw createError({
			statusCode: 400,
			statusMessage: `Need to provide credentials`,
		});

	// const registrationUrl = new URL("register", EDGEDB_AUTH_BASE_URL);
	const registrationUrl = `${EDGEDB_AUTH_BASE_URL}/register`;
	const registrationResponse = await fetch(registrationUrl, {
		method: "POST",
		headers: {
			"Content-Type": "application/json",
		},
		body: JSON.stringify({
			challenge: pkce.challenge,
			email,
			password,
			provider,
			verify_url: `http://localhost:${SERVER_PORT}/auth/verify`,
		}),
	});

	if (!registrationResponse.ok) {
		const text = await registrationResponse.text();
		throw createError({
			statusCode: 400,
			statusMessage: `Error from the auth server: ${text}`,
		});
	}

	const { firstName, lastName, dateOfBirth } = form;

	return createUser({
		firstName,
		lastName,
		dateOfBirth,
	});
};

export function useAuthentication() {
	return {
		register: handleSignup,
	};
}
