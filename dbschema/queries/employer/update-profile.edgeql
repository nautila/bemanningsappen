with module employer,
update Profile
filter global ext::auth::ClientTokenIdentity in .employer.users.identities
set {
	address := <optional str>$address,
	description := <optional str>$description,
	logo := (select image::Image filter .id = <optional uuid>$imageId),
};
