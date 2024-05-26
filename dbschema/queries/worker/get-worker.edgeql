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

		experiences: {
			*,
			__type__: { name },

			[is worker::experience::Work].company,
			[is worker::experience::Work].position,
			[is worker::experience::Education].school,
			[is worker::experience::Education].degree,
			[is worker::experience::Course].provider,
			[is worker::experience::Course].course,
			[is worker::experience::Project].project,
			[is worker::experience::Project].role,
		},
	}
}
filter .id = <uuid>$workerId;
