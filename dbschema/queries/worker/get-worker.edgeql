select Worker {
	id,

	user: {
		id,
		firstName,
		lastName,
		dateOfBirth,
	},

	cv: {
		id,
		tagline,
		introduction,

		experiences: { *, __type__: { name } },
	}
}
filter .id = <uuid>$workerId;
