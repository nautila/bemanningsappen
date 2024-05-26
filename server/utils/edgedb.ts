import type { Client } from "edgedb";

export interface EdgeDbGlobalsArgs {
	authClientToken?: string;
	employerClientId?: string;
}

export function useEdgeDbClient() {
	const client = (globalThis as any).__nuxt_edgedb_server_client__ as Client;
	return client;
}

export function useEdgeDbWithGlobals(globals?: EdgeDbGlobalsArgs) {
	const client = useEdgeDbClient();

	if (globals) {
		return client.withGlobals({
			"ext::auth::client_token": globals.authClientToken,
			"employer::client_id": globals.employerClientId,
		});
	}

	return client;
}

import * as queries from "~/dbschema/queries";
export type EdgeDbQueriesWithGlobals = keyof typeof queries;

export function useEdgeDbQueriesWithGlobals(globals?: EdgeDbGlobalsArgs): {
	[K in EdgeDbQueriesWithGlobals]: (arg?: Parameters<(typeof queries)[K]>[1]) => ReturnType<(typeof queries)[K]>;
} {
	const client = useEdgeDbWithGlobals(globals);

	return Object.fromEntries(
		Object.entries(queries).map(([key, fn]) => {
			return [key, (args?: Parameters<typeof fn>[1]) => fn(client, args as any)];
		}),
	) as any;
}
