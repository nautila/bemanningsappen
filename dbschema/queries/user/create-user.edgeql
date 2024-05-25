with
	identity := (global ext::auth::ClientTokenIdentity),
	emailFactor := (
		select ext::auth::EmailFactor
		filter .identity = identity
	),
insert User {
	identities := { identity },
	firstName := <optional str>$firstName,
	lastName := <optional str>$lastName,
	dateOfBirth := <optional datetime>$dateOfBirth,
}
