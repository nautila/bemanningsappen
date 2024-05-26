<template>
	<a-layout-sider class="h-100" :collapsed="collapsed" :trigger="null" collapsible>
		<div class="logo" v-if="!collapsed">Bemanningsappen</div>
		<div class="logo" v-else>B</div>
		<a-menu v-model:selectedKeys="selectedKeys" theme="dark" mode="inline">
			<a-menu-item v-for="menu in menus" :key="menu.key">
				<NuxtLink :to="menu.url">
					<component :is="menu.icon" />
					<span>{{ menu.label }}</span>
				</NuxtLink>
			</a-menu-item>
		</a-menu>
	</a-layout-sider>
</template>

<script setup lang="ts">
import { UploadOutlined, UserOutlined, VideoCameraOutlined } from "@ant-design/icons-vue";

const route = useRoute("employer-employerId");
const employerId = route.params.employerId;

const selectedKeys = ref<string[]>(["1"]);
const { collapsed } = defineProps({
	collapsed: {
		type: Boolean as PropType<boolean>,
		required: true,
	},
});

const menus = !!employerId
	? [
			{
				key: "1",
				icon: UserOutlined,
				label: "Employer Profile",
				url: `/employer/${employerId}`,
			},
			{
				key: "2",
				icon: VideoCameraOutlined,
				label: "Available Workers",
				url: `/employer/${employerId}/workers`,
			},
			// {
			// 	key: "3",
			// 	icon: UploadOutlined,
			// 	label: "nav Employer 3",
			// 	url: "/dashboard",
			// },
		]
	: [
			{
				key: "1",
				icon: UserOutlined,
				label: "Profile",
				url: "/worker",
			},
			// {
			// 	key: "2",
			// 	icon: VideoCameraOutlined,
			// 	label: "nav worker 2",
			// 	url: "/dashboard",

			// },
			// {
			// 	key: "3",
			// 	icon: UploadOutlined,
			// 	label: "nav worker 3",
			// 	url: "/dashboard",
			// },
		];
</script>

<style scoped></style>
