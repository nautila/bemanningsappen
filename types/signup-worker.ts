import type { UserData } from "./user";

export interface SignupWorkerFormData extends UserData {
	// firstName: string;
	// lastName: string;
	email: string;
	password: string;
}
