<template>
  <!-- 💡 核心滚动监听器保持在主容器 -->
  <div class="home-container" ref="homeContainer" @scroll="handleScroll">
    <div class="main-content">
      <!-- 4. 学习手册 -->
      <HomeHandbook
        :handbook-topics="handbookTopics"
        @topic-click="handleTopicClick"
        @open-github="openGithubHandbook"
      />

      <!-- 5. 作者区 -->
      <HomeAuthor
        :author="author"
        :projects="projects"
      />

      <!-- 6. 联系方式与页脚 -->
      <section class="contact-section">
        <el-card class="contact-card gradient-card">
          <h3>📬 联系与合作</h3>
          <div class="contact-methods">
            <div class="contact-item" v-for="c in contacts" :key="c.name">
              <el-icon>
                <component :is="c.icon"/>
              </el-icon>
              <span>{{ c.value }}</span>
            </div>
          </div>
        </el-card>
      </section>

      <div class="bottom-spacer" style="height: 100px;"></div>
    </div>

    <!-- 7. 回到顶部 -->
    <transition name="fade">
      <el-button v-if="showBackToTop" circle class="back-to-top glow-btn" @click="scrollToTop">
        <el-icon>
          <ArrowUp/>
        </el-icon>
      </el-button>
    </transition>
  </div>
</template>

<script setup lang="ts">
import {nextTick} from 'vue'
import {ArrowUp} from '@element-plus/icons-vue'

// 💡 导入所有常量逻辑
import {
  author, badges, contacts, coreMetrics, handbookTopics,
  handleTopicClick, homeContainer, openGithubHandbook,
  performanceData, projects, router, showBackToTop,
  showDetails, softwareSpecs
} from "@/assets/ts/constants.ts"
import HomeAuthor from "@/components/ragpro/HomeAuthor.vue";
import HomeHandbook from "@/components/ragpro/HomeHandbook.vue";

// 💡 保持原有方法不改变
const handleToggleDetails = () => {
  showDetails.value = !showDetails.value
  if (showDetails.value) {
    nextTick(() => {
      const el = document.getElementById('tech-section')
      if (el) el.scrollIntoView({behavior: 'smooth', block: 'start'})
    })
  }
}

const goToChat = () => router.push('/chat/rag')

const scrollToSection = (id: string) => {
  const el = document.getElementById(id)
  if (el) el.scrollIntoView({behavior: 'smooth', block: 'start'})
}

const scrollToTop = () => {
  if (homeContainer.value) homeContainer.value.scrollTo({top: 0, behavior: 'smooth'})
}

const handleScroll = (e: Event) => {
  const target = e.target as HTMLElement
  showBackToTop.value = target.scrollTop > 300
}
</script>

<style src="../assets/styles/home.css" scoped></style>
