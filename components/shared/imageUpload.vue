<script setup lang="ts">
import { ref } from 'vue';
import { PlusOutlined, LoadingOutlined } from '@ant-design/icons-vue';
import { message, type UploadChangeParam, type UploadFile } from "ant-design-vue";

const fileList = ref<UploadFile[]>([]);
const loading = ref(false);
const imageUrl = ref<string | null>(null);

const beforeUpload = (file: UploadFile) => {
	const isJpgOrPng = file.type === 'image/jpeg' || file.type === 'image/png';
	if (!isJpgOrPng) {
		message.error('You can only upload JPG or PNG files!');
		return false;
	}
	// Check if size is defined
	if (file.size == null) {
		message.error('Failed to get the file size');
		return false;
	}
	const isLt2M = file.size / 1024 / 1024 < 2;
	if (!isLt2M) {
		message.error('Image must be smaller than 2MB!');
		return false;
	}
	return true;
};


const handleChange = (info: UploadChangeParam<UploadFile>) => {
	fileList.value = info.fileList;
	if (info.file.status === 'uploading') {
		loading.value = true;
	} else if (info.file.status === 'done') {
		// Assuming that "originFileObj" is a Blob representing the file
		if (info.file.originFileObj) {
			getBase64(info.file.originFileObj, (base64Url: string) => {
				imageUrl.value = base64Url;
				loading.value = false;
			});
		}
	} else if (info.file.status === 'error') {
		loading.value = false;
		message.error('Upload error');
	}
};

const getBase64 = (img: Blob, callback: (url: string) => void) => {
	const reader = new FileReader();
	reader.onload = () => callback(reader.result as string);
	reader.readAsDataURL(img);
};
</script>
<template>
	<a-upload
		v-model:file-list="fileList"
		name="avatar"
		list-type="picture-card"
		class="avatar-uploader"
		:show-upload-list="false"
		action="https://www.mocky.io/v2/5cc8019d300000980a055e76"
		:before-upload="beforeUpload"
		@change="handleChange"
	>
		<img v-if="imageUrl" :src="imageUrl" alt="avatar" />
		<div v-else>
			<loading-outlined v-if="loading" />
			<plus-outlined v-else />
			<div class="ant-upload-text">Profile Image</div>
		</div>
	</a-upload>
</template>

<style scoped>
.avatar-uploader > .ant-upload {
	width: 128px;
	height: 128px;
}
.ant-upload-select-picture-card i {
	font-size: 32px;
	color: #999;
}
.ant-upload-select-picture-card .ant-upload-text {
	margin-top: 8px;
	color: #666;
}
</style>
