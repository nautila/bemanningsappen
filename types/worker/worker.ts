export interface Worker {
	id: string;
	user: WorkerUser;
	cv: WorkerCV;
}

export interface WorkerUser {
	id: string;
	firstName?: string | null;
	lastName?: string | null;
	dateOfBirth?: Date | null;
}

export interface WorkerCV {
	id: string;
	tagline?: string | null;
	introduction?: string | null;
}
