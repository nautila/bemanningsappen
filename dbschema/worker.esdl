module worker {
	abstract type Desires {}

	type CV {
		required worker: default::Worker;
		required title: str;
		tagline: str;
		introduction: str;

		multi experiences: Experience { on source delete delete target if orphan };
		multi qualifications: Qualification { on source delete delete target if orphan };
		multi skills: Skill { on source delete delete target if orphan };
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