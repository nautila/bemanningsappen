with module worker
select assert_single((
	select CV {
		tagline,
		introduction,

		experiences: {
			*,
			__type__: { name },

			# description,
			# startDate,
			# endDate,

			# [is worker::experience::Work].company,
			# [is worker::experience::Work].position,
			# [is worker::experience::Education].school,
			# [is worker::experience::Education].degree,
			# [is worker::experience::Course].provider,
			# [is worker::experience::Course].course,
			# [is worker::experience::Project].project,
			# [is worker::experience::Project].role,
		},

		qualifications: {
			__type__: { name },

			issuedAt,
			issuedBy,
			expiresAt,
		},

		# skills: {
		# },
	}
	filter .worker = <default::Worker>$workerId
));
