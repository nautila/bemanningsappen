import { createClient } from "edgedb";
import { defineNitroPlugin } from "nitropack/dist/runtime/plugin";

export default defineNitroPlugin(() => {
	const client = createClient({
		instanceName: process.env.EDGEDB_INSTANCE,
		secretKey: process.env.EDGEDB_SECRET_KEY,
	});

	(globalThis as any).__nuxt_edgedb_server_client__ = client;
});
