<template>
  <section class="hero-section">
    <div class="hero-bg-decoration">
      <div class="hero-orb orb-1"></div>
      <div class="hero-orb orb-2"></div>
      <div class="hero-orb orb-3"></div>
    </div>

    <div class="hero-card glass-effect">
      <div class="hero-badge-group">
        <el-tag
          v-for="(badge, index) in badges"
          :key="badge.text"
          :type="badge.type"
          size="small"
          round
          class="hero-badge"
          :style="{ animationDelay: `${index * 0.1}s` }"
        >
          <span class="badge-dot"></span>
          {{ badge.text }}
        </el-tag>
      </div>

      <h1 class="hero-title">
        <span class="gradient-text">Lite-RAG</span>
        <span class="title-subtitle">智能助手</span>
      </h1>

      <p class="hero-subtitle">
        基于 <strong class="highlight-primary">Spring AI</strong> 与 <strong
        class="highlight-secondary">Milvus 2.6</strong> 构建的工业级私有化知识库。<br>
        经过深度性能调优，实现 <strong class="highlight-accent">低功耗环境下的秒级生成</strong>。
      </p>

      <div class="action-group">
        <el-button type="primary" size="large" @click="$emit('goChat')" round class="btn-primary glow-btn">
          <el-icon><ChatDotRound/></el-icon>
          进入知识库问答
        </el-button>
        <el-button size="large" round @click="$emit('toggleDetails')" class="btn-secondary">
          <el-icon>
            <component :is="showDetails ? 'Fold' : 'Expand'"/>
          </el-icon>
          {{ showDetails ? '隐藏技术规格' : '技术规格说明' }}
        </el-button>
        <el-button size="large" round @click="$emit('scrollAuthor')" class="btn-tertiary">
          <el-icon><User/></el-icon>
          关于作者
        </el-button>
      </div>
    </div>
  </section>
</template>

<script setup lang="ts">
import { ChatDotRound, User } from '@element-plus/icons-vue'

// 定义接收的 Props
defineProps<{
  badges: any[]
  showDetails: boolean
}>()

// 定义触发的事件
defineEmits<{
  toggleDetails: []
  goChat: []
  scrollAuthor: []
}>()
</script>

<!-- 样式可以写在这里，也可以继续复用全局 home.css，视具体需求而定 -->
<style scoped>
/* 如果需要局部覆盖样式可在此添加 */
</style>
