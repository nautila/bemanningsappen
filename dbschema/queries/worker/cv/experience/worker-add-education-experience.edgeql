with module worker::experience
insert Education {
	worker := <default::Worker>$workerId,
	description := <optional str>$description,
	startDate := <cal::local_date><str>$startDate,
	endDate := <cal::local_date><optional str>$endDate,

	school := <str>$school,
	degree := <str>$degree,
}
