<template>
	<a-layout-sider class="h-100" :collapsed="collapsed" :trigger="null" collapsible>
		<div class="logo" v-if="!collapsed">
			Bemanningsappen
		</div>
		<div class="logo" v-else>
			Short
		</div>
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
import { userTypes } from "~/constants/user";

const selectedKeys = ref<string[]>(["1"]);
const { collapsed, userType } = defineProps({
	collapsed: {
		type: Boolean as PropType<boolean>,
		required: true,
	},
	userType: {
		type: String as PropType<string>,
		required: false,
		default: userTypes.EMPLOYER,
	}
});

const menus = userType === userTypes.EMPLOYER ? [
	{
		key: "1",
		icon: UserOutlined,
		label: "nav Employer 1",
		url: "/dashboard",
	},
	{
		key: "2",
		icon: VideoCameraOutlined,
		label: "nav Employer 2",
		url: "/dashboard",

	},
	{
		key: "3",
		icon: UploadOutlined,
		label: "nav Employer 3",
		url: "/dashboard",
	},
]:
	[
		{
			key: "1",
			icon: UserOutlined,
			label: "nav worker 1",
			url: "/dashboard",
		},
		{
			key: "2",
			icon: VideoCameraOutlined,
			label: "nav worker 2",
			url: "/dashboard",

		},
		{
			key: "3",
			icon: UploadOutlined,
			label: "nav worker 3",
			url: "/dashboard",
		},
];


</script>


<style scoped>

</style>
