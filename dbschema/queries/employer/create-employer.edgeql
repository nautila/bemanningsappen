with
	U := (select User filter .id = <uuid>$userId),
insert Employer {
	users := { U },
	name := <optional str>$name,
}
