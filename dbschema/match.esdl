module match {
	# scalar type WorkStatus extending enum<Pending, Rejected, Accepted>;

	type Match {
		required worker: default::Worker;
		required employer: default::Employer;

		multi conversation: chat::Conversation;

		required matchMade: bool {
			default: false;
		}
		# required status: WorkStatus;
	}
}
