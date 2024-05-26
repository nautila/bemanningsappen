# Had to use `matcher` as module name, and `Matching` as type name.
# Because `match` is a hidden reserved keyword in EdgeDB.
# Suggestions are welcome.
module matcher {
	# scalar type WorkStatus extending enum<Pending, Rejected, Accepted>;

	type EmployerWorkerAvailabilityRequest extending time::Timestamped {
		required employer: default::Employer;
		required worker: default::Worker;
	}

	type Matching {
		required worker: default::Worker;
		required employer: default::Employer;

		multi conversation: chat::Conversation;

		required matchMade: bool {
			default := false;
		}
		# required status: WorkStatus;
	}
}
