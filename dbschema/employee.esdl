module employee {
	type CV {
		required employee: default::Employee;
		required title: str;
		tagline: str;
		introduction: str;

		multi experiences: Experience { on source delete delete target if orphan };
		multi qualifications: Qualification { on source delete delete target if orphan };
		multi skills: Skill { on source delete delete target if orphan };
	}

	abstract type Experience {
		required employee: default::Employee;
		description: str;
		required startDate: datetime;
		endDate: datetime;
	}

	module experience {
		type Work extending employee::Experience {
			company: str;
			position: str;
		}

		type Education extending employee::Experience {
			school: str;
			degree: str;
		}

		type Course extending employee::Experience {
			provider: str;
			course: str;
		}

		type Project extending employee::Experience {
			project: str;
			role: str;
		}
	}

	abstract type Qualification {
		required employee: default::Employee;
		required issuedAt: datetime;
		issuedBy: str;
		expiresAt: datetime;
	}

	module qualification {
		type License extending employee::Qualification {}
		type Degree extending employee::Qualification {}
		type Certification extending employee::Qualification {}

		module license {
			type DriversLicense extending employee::qualification::License {
				region: str;
				multi classes: str;
			}
		}
	}

	abstract type Skill {
		required employee: default::Employee;
	}
}
