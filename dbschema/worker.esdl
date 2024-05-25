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

		multi experiences := (select worker::Experience filter .worker = CV.worker);
		multi qualifications := (select worker::Qualification filter .worker = CV.worker);
		multi skills := (select worker::Skill filter .worker = CV.worker);

		# multi experiences: Experience { on source delete delete target if orphan };
		# multi qualifications: Qualification { on source delete delete target if orphan };
		# multi skills: Skill { on source delete delete target if orphan };

		# access policy worker_has_full_access
		# 	allow all
		# 	using (.worker ?= global default::ClientUser);

		# access policy others_read_only
		# 	allow select;
	}

	scalar type ExperienceType extending enum<Work, Education, Course, Project>;
	abstract type Experience {
		required worker: default::Worker;
		required type: ExperienceType;

		description: str;
		required startDate: cal::local_date;
		endDate: cal::local_date;
	}

	module experience {
		type Work extending worker::Experience {
			overloaded type: worker::ExperienceType {
				default := worker::ExperienceType.Work;
			}

			required company: str;
			position: str;
		}

		type Education extending worker::Experience {
			overloaded type: worker::ExperienceType {
				default := worker::ExperienceType.Education;
			}

			required school: str;
			required degree: str;
		}

		type Course extending worker::Experience {
			overloaded type: worker::ExperienceType {
				default := worker::ExperienceType.Course;
			}

			required course: str;
			provider: str;
		}

		type Project extending worker::Experience {
			overloaded type: worker::ExperienceType {
				default := worker::ExperienceType.Project;
			}

			required project: str;
			role: str;
		}
	}

	scalar type QualificationType extending enum<License, Degree, Certification>;
	abstract type Qualification {
		required worker: default::Worker;
		required type: QualificationType;

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
