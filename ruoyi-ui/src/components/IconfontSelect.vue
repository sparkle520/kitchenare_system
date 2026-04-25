<template>
  <t-space>
    <t-select
      :value="modelValue"
      placeholder="请选择"
      :reserve-keyword="true"
      :filterable="filterable"
      :style="{ width: '400px' }"
      :popup-props="{ overlayInnerStyle: { width: '400px' } }"
      @search="remoteMethodSingle"
      @change="onChange($event as string)"
    >
      <t-option v-for="item in options" :key="item.stem" :value="item.stem" class="overlay-options">
        <div>
          <icon-font :name="`t-icon-${item.stem}`" :url="IconfontUrl" :load-default-icons="false" />
        </div>
      </t-option>
      <template #valueDisplay>
        <t-space size="4px">
          <icon-font :name="`t-icon-${modelValue}`" :url="IconfontUrl" :load-default-icons="false" />
          {{ modelValue }}
        </t-space>
      </template>
    </t-select>
    <t-button v-if="filterable" variant="outline" @click="handleReset">重置</t-button>
  </t-space>
</template>
<script setup lang="ts">
import { useDebounceFn } from '@vueuse/core';
import { IconFont, manifest } from 'tdesign-icons-vue-next';

import IconfontUrl from '@/assets/fonts/t-iconfont.css?url';

defineOptions({
  name: 'IconfontSelect',
});

defineProps({
  modelValue: String,
  filterable: {
    type: Boolean,
    default: false,
  },
});

const emit = defineEmits(['update:modelValue', 'change']);

const options = ref(manifest);

const onChange = (value: string) => {
  emit('update:modelValue', value);
  emit('change', value);
};

// 防抖搜索
const debouncedSubmit = useDebounceFn((search: string) => {
  options.value = manifest.filter((item) => item.stem.includes(search));
}, 500);

// 单选选择器的远程搜索方法
const remoteMethodSingle = (search: string) => {
  debouncedSubmit(search);
};

// 恢复默认数据
const handleReset = () => {
  options.value = manifest;
};
</script>
<style scoped lang="less">
.overlay-options {
  display: inline-block;
  font-size: 20px;
}
</style>
