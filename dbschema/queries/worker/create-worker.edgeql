insert Worker {
	user := (select User filter .id = <uuid>$userId)
}
