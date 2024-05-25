<script lang="ts" setup>
import { PlusOutlined } from "@ant-design/icons-vue";
import { defineComponent, reactive, ref } from "vue";
import { Form } from "ant-design-vue";

interface Skill {
	value: string;
	disabled: boolean;
}

const formState: {selectedValues: string[]} = reactive(
	{
		selectedValues : [],
	},
);

const VNodes = defineComponent({
	props: {
		vnodes: {
			type: Object,
			required: true,
		},
	},
	render() {
		return this.vnodes;
	},
});

const options = reactive<Skill[]>([
	{ value: "HTML", disabled: false },
	{ value: "CSS", disabled: false },
	{ value: "JavaScript", disabled: false },
	{ value: "Vue", disabled: false },
	{ value: "React", disabled: false },
	{ value: "Angular", disabled: false },
]);

const name = ref("");

const useForm = Form.useForm;
const { validate, validateInfos } = useForm(formState,{
	selectedValues: [
		{
			required: true,
			message: "Please select your skills!",
		}
	]});

const addItem = () => {
	if (name.value && !options.some(option => option.value === name.value)) {
		options.push({ value: name.value, disabled: false });
		formState.selectedValues.push(name.value);
		name.value = "";
	}
};

const onSubmit = () => {
	validate().then(() => {
		console.log("success");
	});

};
</script>

<template>
	<a-form
		layout="vertical"
		@submit="onSubmit"
	>
		<a-row>
			<a-col span="24">
				<a-form-item
					label="Select Skills"
				>
					<a-select
						v-model:value="formState.selectedValues"
						mode="multiple"
						size="large"
						placeholder="Please select your skills"
						style="width: 100%"
						:options="options.map(option => ({ value: option.value, label: option.value, disabled: option.disabled }))"
						v-bind="validateInfos.selectedValues"
					>
						<template #dropdownRender="{ menuNode: menu }">
							<v-nodes :vnodes="menu" />
							<a-divider style="margin: 4px 0" />
							<a-space style="padding: 4px 8px">
								<a-input ref="inputRef" v-model:value="name" placeholder="Enter a new skill" />
								<a-button type="text" @click="addItem">
									<template #icon>
										<plus-outlined />
									</template>
									Add Skill
								</a-button>
							</a-space>
						</template>
					</a-select>
				</a-form-item>
			</a-col>
			<a-col span="24" class="flex justify-end">
				<a-button type="primary" size="large" html-type="submit">Save</a-button>
			</a-col>

		</a-row>

	</a-form>

</template>

