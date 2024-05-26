select Employer {
	id,

	users: {
		id,
		firstName,
		lastName,
	},

	profile: {
		id,
		name,
		logo,
		address,
		description,
	},
}
filter .id = <uuid>$employerId;
