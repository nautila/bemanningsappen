module time {
	abstract type CreatedAt {
		required createdAt: datetime {
			default := datetime_current();
			readonly := true;
		};
		index on (.createdAt);
		required property sinceCreated := datetime_of_statement() - .createdAt;
	}

	abstract type UpdatedAt {
		required updatedAt: datetime {
			default := datetime_current();
			rewrite update using (datetime_current());
		};
		index on (.updatedAt);
		required property sinceUpdated := datetime_of_statement() - .updatedAt;
	}

	abstract type Timestamped extending CreatedAt, UpdatedAt {}
}
