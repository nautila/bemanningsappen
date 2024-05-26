with module employer,
	E := assert_single((select default::Employer filter global ext::auth::ClientTokenIdentity in .users.identities)),
insert Profile {
	employer := E,
} unless conflict;
