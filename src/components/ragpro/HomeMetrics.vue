<template>
  <div class="metrics-grid">
    <div class="metric-item glass-effect" v-for="(m, index) in coreMetrics" :key="m.title" :style="{ animationDelay: `${index * 0.1}s` }">
      <div class="metric-icon-wrapper">
        <div class="metric-icon">{{ m.icon }}</div>
        <div class="metric-ring"></div>
      </div>
      <div class="m-value">{{ m.value }}</div>
      <div class="m-title">{{ m.title }}</div>
      <div class="m-desc">{{ m.desc }}</div>
      <div class="metric-hover-glow"></div>
    </div>
  </div>
</template>
<script setup lang="ts">
defineProps<{ coreMetrics: any[] }>()
</script>
<style  src="../../assets/styles/home.css" scoped></style>
