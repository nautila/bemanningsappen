import generatePKCE from "~/server/utils/generatePKCE";

// TODO: Replace with proper envvar getter functions.
const EDGEDB_AUTH_BASE_URL = process.env.EDGEDB_AUTH_BASE_URL;
const SERVER_PORT = 3000;

const handleSignup = async (event: any) => {
	const pkce = generatePKCE();

	const { email, password, provider } = await readBody(event);
	if (!email || !password || !provider)
		throw createError({
			statusCode: 400,
			statusMessage: `Need to provide credentials`,
		});

	const registrationUrl = new URL("register", EDGEDB_AUTH_BASE_URL);
	const registrationResponse = await fetch(registrationUrl.href, {
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

	event.node.res.writeHead(204, {
		"Set-Cookie": `edgedb-pkce-verifier=${pkce.verifier}; HttpOnly; Path=/; Secure; SameSite=Strict`,
	});

	event.node.res.end();
};

export default defineEventHandler((event) => {
	console.log("Handling signup event.");
	handleSignup(event);
});
