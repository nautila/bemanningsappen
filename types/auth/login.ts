import type { Account, User } from "~/dbschema/interfaces";

export interface LoginResponse {
	token: string;
	user: Omit<User, "identities">;
	accounts: Account[];
}
