with
	U := (select User filter .id = <uuid>$userId),
	E := (
		insert Employer {
			users := { U },
		}
	),
	P := (
		insert employer::Profile {
			employer := E,
			name := <optional str>$name,
		}
	)
select E;
