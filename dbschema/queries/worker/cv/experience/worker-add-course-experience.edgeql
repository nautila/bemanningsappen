with module worker::experience
insert Course {
	worker := <default::Worker>$workerId,
	description := <optional str>$description,
	startDate := <cal::local_date><str>$startDate,
	endDate := <cal::local_date><optional str>$endDate,

	provider := <optional str>$provider,
	course := <str>$course,
}
