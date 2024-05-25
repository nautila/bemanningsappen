with module worker::experience
insert Project {
	worker := <default::Worker>$workerId,
	description := <optional str>$description,
	startDate := <cal::local_date><str>$startDate,
	endDate := <cal::local_date><optional str>$endDate,

	project := <str>$project,
	role := <optional str>$role,
}
