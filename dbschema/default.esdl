using extension auth;

module default {
	global ClientUser := (assert_single((select User filter global ext::auth::ClientTokenIdentity in .identities)));

	type User {
		firstName: str;
		lastName: str;
		dateOfBirth: datetime;

		multi identities: ext::auth::Identity;
	}

	abstract type Account {}

	type Worker extending default::Account {
		required user: default::User {
			constraint exclusive;
		};

		cv := .<worker[is worker::CV];
	}

	type Employer extending default::Account {
		multi users: default::User;
		profile := .<employer[is employer::Profile];
	}
}
