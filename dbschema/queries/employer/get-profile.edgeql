select assert_single((
	select employer::Profile {
		employer: { name },
		logo: {
			id,
			name,
			data,
		},
		address,
		description,
	} filter global ext::auth::ClientTokenIdentity in .employer.users.identities
));
