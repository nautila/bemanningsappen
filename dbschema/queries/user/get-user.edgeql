select assert_single((
	select User {
		id,

		worker := (
			select .<user[is Worker] {
				id,
				type := .__type__.name,
			}
		),

		employers := (
			select .<users[is Employer] {
				id,
				type := .__type__.name,
			}
		),

	} filter .identities = global ext::auth::ClientTokenIdentity
));
