with module worker,
	TITLE := <str>$title,
insert CV {
	worker := <default::Worker>$workerId,
	title := TITLE,
}
unless conflict on .worker
else (
	update CV set {
		title := TITLE,
	}
);
