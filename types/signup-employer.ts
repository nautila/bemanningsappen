import type { UserData } from "./user";

export interface SignupEmployerFormData extends UserData {
	companyName: string;
	// firstName: string;
	// lastName: string;
	email: string;
	password: string;
}
