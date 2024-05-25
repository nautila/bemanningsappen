import path from "path";
import fs from "fs";

function devServerHttps() {
	const cert = path.resolve(__dirname, "server.crt");
	const key = path.resolve(__dirname, "server.key");
	return fs.existsSync(cert) && fs.existsSync(key) ? { cert, key } : false;
}

// https://nuxt.com/docs/api/configuration/nuxt-config
export default defineNuxtConfig({
	devtools: { enabled: true },
	devServer: {
		https: devServerHttps(),
	},
	// css: ["~/assets/css/main.css"],
	modules: [
		"nuxt-edgedb-module",
		"nuxt-typed-router",
		"@pinia/nuxt",
		"@pinia-plugin-persistedstate/nuxt",
		"@ant-design-vue/nuxt",
		"@nuxtjs/tailwindcss",
	],
	edgeDb: {
		auth: false,
		generateQuiet: false,
		generateInterfaces: true,
	},
});
