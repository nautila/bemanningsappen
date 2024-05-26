select Worker {
	*,
	user: { id, firstName, lastName, dateOfBirth },
	cv: { * },
}
filter exists .cv;
