<template>
  <!-- 💡 核心滚动监听器保持在主容器 -->
  <div class="home-container" ref="homeContainer" @scroll="handleScroll">
    <div class="main-content">

      <!-- 1. 欢迎区 -->
      <HomeHero
        :badges="badges"
        :show-details="showDetails"
        @go-chat="goToChat"
        @toggle-details="handleToggleDetails"
        @scroll-to="scrollToSection"
      />

      <!-- 2. 指标区 -->
      <HomeMetrics :core-metrics="coreMetrics"/>

      <!-- 3. 技术细节 (受 showDetails 控制) -->
      <transition name="el-zoom-in-top">
        <HomeTechDetails
          :software-specs="softwareSpecs"
          :performance-data="performanceData"
        />
      </transition>

      <!-- 7. 回到顶部 -->
      <transition name="fade">
        <el-button v-if="showBackToTop" circle class="back-to-top glow-btn" @click="scrollToTop">
          <el-icon>
            <ArrowUp/>
          </el-icon>
        </el-button>
      </transition>
    </div>
  </div>
</template>

<script setup lang="ts">
import {nextTick} from 'vue'
import {ArrowUp} from '@element-plus/icons-vue'

// 💡 导入所有常量逻辑
import {
  badges,
  coreMetrics,
  homeContainer,
  performanceData,
  showBackToTop,
  showDetails,
  softwareSpecs
} from "@/assets/ts/constants.ts"
import HomeTechDetails from "@/components/ragpro/HomeTechDetails.vue";
import HomeMetrics from "@/components/ragpro/HomeMetrics.vue";
import HomeHero from "@/components/ragpro/HomeHero.vue";
import {useRouter} from "vue-router";

const router = useRouter()

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
