with module matcher
select EmployerWorkerAvailabilityRequest {
	id,
	createdAt,

	employer: {
		id,
		profile: {
			name,
			address,
		},
	},
}
filter .worker.id = <uuid>$workerId;
