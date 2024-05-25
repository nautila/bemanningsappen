<template>
	<a-layout style="height: 100%; min-height: 100vh">
		<shared-sidebar :collapsed="collapsed" />
		<a-layout>
			<a-layout-header style="background: #fff; padding: 0">
				<a-flex justify="space-between">
					<menu-unfold-outlined v-if="collapsed" class="trigger p-4" @click="() => (collapsed = !collapsed)" />
					<menu-fold-outlined v-else class="trigger p-5" @click="() => (collapsed = !collapsed)" />
					<a-button type="primary" class="m-4" @click.prevent="logout">Log out</a-button>
				</a-flex>
			</a-layout-header>
			<a-layout-content :style="{ margin: '24px 16px', padding: '24px', background: '#fff', minHeight: '280px' }">
				<slot> </slot>
			</a-layout-content>
		</a-layout>
	</a-layout>
</template>

<script lang="ts" setup>
import { ref } from "vue";
import { MenuFoldOutlined, MenuUnfoldOutlined } from "@ant-design/icons-vue";
const collapsed = ref<boolean>(false);

const logout = () => {
	message.info("Logout clicked");
};
</script>

<style>
#components-layout-demo-custom-trigger .trigger {
	font-size: 18px;
	line-height: 64px;
	padding: 0 24px;
	cursor: pointer;
	transition: color 0.3s;
}

#components-layout-demo-custom-trigger .trigger:hover {
	color: #1890ff;
}

#components-layout-demo-custom-trigger .logo {
	height: 32px;
	background: rgba(255, 255, 255, 0.3);
	margin: 16px;
}

.logo {
	text-align: center;
	line-height: 50px;
	color: #fff;
}

.site-layout .site-layout-background {
	background: #fff;
}
</style>
