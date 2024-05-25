with module worker,
	TAGLINE := <optional str>$tagline,
	INTRODUCTION := <optional str>$introduction,
insert CV {
	worker := <default::Worker>$workerId,
	tagline := TAGLINE,
	introduction := INTRODUCTION,
}
unless conflict on .worker
else (
	update CV set {
		tagline := TAGLINE ?? CV.tagline,
		introduction := INTRODUCTION ?? CV.introduction,
	}
);
