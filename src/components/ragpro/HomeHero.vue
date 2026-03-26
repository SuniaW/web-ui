<template>
  <div>
    <section class="hero-section">
      <div class="hero-bg-decoration">
        <div class="hero-orb orb-1"></div>
        <div class="hero-orb orb-2"></div>
        <div class="hero-orb orb-3"></div>
      </div>
      <div class="hero-card glass-effect">
        <div class="hero-badge-group">
          <el-tag v-for="(badge, index) in badges" :key="badge.text" :type="badge.type" size="small" round class="hero-badge" :style="{ animationDelay: `${index * 0.1}s` }">
            <span class="badge-dot"></span> {{ badge.text }}
          </el-tag>
        </div>
        <h1 class="hero-title">
          <span class="gradient-text">Lite-RAG</span>
          <span class="title-subtitle">智能助手</span>
        </h1>
        <p class="hero-subtitle">
          基于 <strong class="highlight-primary">Spring AI</strong> 与 <strong class="highlight-secondary">Milvus 2.6</strong> 构建的工业级私有化知识库。<br>
          经过深度性能调优，实现 <strong class="highlight-accent">低功耗环境下的秒级生成</strong>。
        </p>
        <div class="action-group">
          <el-button type="primary" size="large" @click="$emit('go-chat')" round class="btn-primary glow-btn">
            <el-icon><ChatDotRound/></el-icon> 进入知识库问答
          </el-button>
        </div>
      </div>
    </section>
  </div>
</template>
<script setup lang="ts">
import { ChatDotRound } from '@element-plus/icons-vue'
defineProps<{ badges: any[] }>()
defineEmits(['go-chat', 'toggle-details', 'scroll-to'])
</script>
<style  src="../../assets/styles/home.css" scoped></style>
