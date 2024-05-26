import type { SignupEmployerFormData } from "~/types/signup-employer";

// TODO: Replace with proper envvar getter functions.
const EDGEDB_AUTH_BASE_URL = "http://localhost:10732/branch/main/ext/auth/";
const SERVER_PORT = 3000;
const EDGEDB_AUTH_DEFAULT_PROVIDER = "builtin::local_emailpassword";

const handleSignup = async (form: SignupEmployerFormData) => {
	const pkce = useEdgeDbPKCE();

	const { email, password } = form;
	const provider = EDGEDB_AUTH_DEFAULT_PROVIDER;

	if (!email || !password || !provider) return _handleMissingCredentialsError();

	const registrationUrl = new URL("register", EDGEDB_AUTH_BASE_URL);
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

	if (!registrationResponse.ok) return _handleAuthServerError(registrationResponse);

	const { firstName, lastName, dateOfBirth } = form;

	const authClientToken = await handleAuthenticate({ email, password, pkce });

	const { createUser } = useEdgeDbQueriesWithGlobals({ authClientToken });

	return createUser({
		firstName,
		lastName,
		dateOfBirth,
	});
};

const handleAuthenticate = async ({
	email,
	password,
	pkce = useEdgeDbPKCE(),
}: {
	email: string;
	password: string;
	pkce?: { verifier: string; challenge: string };
}): Promise<string> => {
	const provider = EDGEDB_AUTH_DEFAULT_PROVIDER;

	if (!email || !password || !provider) return _handleMissingCredentialsError();

	const authenticateUrl = new URL("authenticate", EDGEDB_AUTH_BASE_URL);
	const authenticateResponse = await fetch(authenticateUrl, {
		method: "POST",
		headers: {
			"Content-Type": "application/json",
		},
		body: JSON.stringify({
			challenge: pkce.challenge,
			email,
			password,
			provider,
		}),
	});

	if (!authenticateResponse.ok) return _handleAuthServerError(authenticateResponse);

	const { code } = await authenticateResponse.json();

	const tokenUrl = new URL("token", EDGEDB_AUTH_BASE_URL);
	tokenUrl.searchParams.set("code", code);
	tokenUrl.searchParams.set("verifier", pkce.verifier);
	const tokenResponse = await fetch(tokenUrl.href, { method: "GET" });

	if (!tokenResponse.ok) return _handleAuthServerError(tokenResponse);

	const { auth_token: authToken } = await tokenResponse.json();

	return authToken;
};

const _handleMissingCredentialsError = () => {
	throw createError({
		statusCode: 400,
		statusMessage: `Need to provide credentials`,
	});
};

const _handleAuthServerError = async (response: Response) => {
	const text = await response.text();
	throw createError({
		statusCode: 400,
		statusMessage: `Error from the auth server: ${text}`,
	});
};

export function useAuthentication() {
	return {
		register: handleSignup,
		login: handleAuthenticate,
	};
}
