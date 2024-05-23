using extension auth;

module default {
	global ClientUser := (assert_single((select User filter global ext::auth::ClientTokenIdentity in .identities)));

	type User {
		multi identities: ext::auth::Identity;
	}

	abstract type Account {}

	type Worker extending default::Account {
		required user: default::User {
			constraint exclusive;
		};

		name: str;
		brithday: datetime;
	}

	type Employer extending default::Account {
		multi users: default::User;
	}
}
