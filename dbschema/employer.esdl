module employer {
	type Profile {
		required employer: default::Employer { constraint exclusive; };

		logo: image::Image;
		address: str;
		description: str;

		access policy employer_has_full_access
			allow all
			using (assert_exists((global default::ClientUser in .employer.users)));

		access policy others_read_only
			allow select;
	}
}
