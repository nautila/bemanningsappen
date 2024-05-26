select Worker {
	*,
	user: { id, firstName, lastName, dateOfBirth },
	cv: { * },
};
