module employee {
	type Employee {
		name: str;
		brithday: datetime;

		multi qualifications: qualification::Qualification;
	}
}

module cv {
	type CV {
		required title: str;
		tagline: str;
		introduction: str;

		multi experiences: Experience { on source delete delete target if orphan };
		multi qualifications: Qualification { on source delete delete target if orphan };
		multi skills: Skill { on source delete delete target if orphan };
	}

	abstract type Experience {
		employee: employee::Employee;
		description: str;
		required start: datetime;
		end: datetime;
	}

	module experience {
		type Work extending cv::Experience {
			company: str;
			position: str;
		}

		type Education extending cv::Experience {
			school: str;
			degree: str;
		}

		type Course extending cv::Experience {
			provider: str;
			course: str;
		}

		type Project extending cv::Experience {
			project: str;
			role: str;
		}
	}

	abstract type Qualification {
		employee: employee::Employee;
		required issuedAt: datetime;
		expiresAt: datetime;
	}

	module qualification {
		type License extending cv::Qualification {}
		type Degree extending cv::Qualification {}
		type Certification extending cv::Qualification {}

		module license {
			type DriversLicense extending cv::qualification::License {
				region: str;
				multi classes: str;
			}
		}
	}

	abstract type Skill {
		employee: employee::Employee;
	}
}
