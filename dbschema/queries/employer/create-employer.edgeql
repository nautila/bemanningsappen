with
	user := (select User filter .id = <uuid>$userId),
insert Employer {
	users := { user },
	name := <optional str>$name,
}
