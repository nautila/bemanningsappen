with module employer,
	NAME := <optional str>$name,
	ADDRESS := <optional str>$address,
	DESCRIPTION := <optional str>$description,
insert Profile {
	employer := <default::Employer>$employerId,
	name := NAME,
	address := ADDRESS,
	description := DESCRIPTION,
}
unless conflict on .employer
else (
	update Profile set {
		name := NAME ?? Profile.name,
		address := ADDRESS ?? Profile.address,
		description := DESCRIPTION ?? Profile.description,
	}
);
