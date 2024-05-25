with module worker::experience
insert Work {
	worker := <default::Worker>$workerId,
	description := <optional str>$description,
	startDate := <cal::local_date><str>$startDate,
	endDate := <cal::local_date><optional str>$endDate,

	company := <str>$company,
	position := <optional str>$position,
}
