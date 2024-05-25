export interface SessionUser {
	id: string;
}

export interface SessionAccount {
	id: string;
	type: "default::Worker" | "default::Employer";
}

export interface LoginResponse {
	token: string;
	user: SessionUser;
	accounts: SessionAccount[];
}
