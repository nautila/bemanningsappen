module worker {
	scalar type JobType extending enum<Driving, Cooking, Cleaning, Moving>;

	type WorkingHours {
		required startTime: cal::local_time;
		required endTime: cal::local_time;
	}

	abstract type Desires {
		required worker: default::Worker;
		required desiredJobType: JobType;
		multi preferredWorkingHours: WorkingHours;
	}

	type CV {
		required worker: default::Worker { constraint exclusive; };
		required title: str;
		tagline: str;
		introduction: str;

		multi experiences: Experience { on source delete delete target if orphan };
		multi qualifications: Qualification { on source delete delete target if orphan };
		multi skills: Skill { on source delete delete target if orphan };

		# access policy worker_has_full_access
		# 	allow all
		# 	using (.worker ?= global default::ClientUser);

		# access policy others_read_only
		# 	allow select;
	}

	abstract type Experience {
		required worker: default::Worker;
		description: str;
		required startDate: datetime;
		endDate: datetime;
	}

	module experience {
		type Work extending worker::Experience {
			company: str;
			position: str;
		}

		type Education extending worker::Experience {
			school: str;
			degree: str;
		}

		type Course extending worker::Experience {
			provider: str;
			course: str;
		}

		type Project extending worker::Experience {
			project: str;
			role: str;
		}
	}

	abstract type Qualification {
		required worker: default::Worker;
		required issuedAt: datetime;
		issuedBy: str;
		expiresAt: datetime;
	}

	module qualification {
		type License extending worker::Qualification {}
		type Degree extending worker::Qualification {}
		type Certification extending worker::Qualification {}

		module license {
			type DriversLicense extending worker::qualification::License {
				region: str;
				multi classes: str;
			}
		}
	}

	abstract type Skill {
		required worker: default::Worker;
	}
}
