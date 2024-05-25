<script setup lang="ts">
import { ref, watch } from 'vue';
import { message, type UploadChangeParam, type UploadFile } from "ant-design-vue";
import { UploadOutlined } from '@ant-design/icons-vue';

const fileList = ref<UploadFile[]>([]);
const headers = {
	authorization: 'authorization-text',
};

const beforeUpload = (file: UploadFile) => {
	if (file.type !== 'application/pdf') {
		message.error('You can only upload PDF files!');
		return false;
	}
	return true;
};

const handleChange = (info: UploadChangeParam<UploadFile>) => {
	fileList.value = info.fileList;
	if (info.file.status === 'done') {
		message.success(`${info.file.name} file uploaded successfully`);
	} else if (info.file.status === 'error') {
		message.error(`${info.file.name} file upload failed.`);
	}
};
</script>


<template>
	<a-upload
		v-model:file-list="fileList"
		name="file"
		:multiple="true"
		action="https://www.mocky.io/v2/5cc8019d300000980a055e76"
		:headers="headers"
		:before-upload="beforeUpload"
		@change="handleChange"
	>
		<a-button>
			<upload-outlined /> Upload your CV
		</a-button>
	</a-upload>
</template>

