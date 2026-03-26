<template>
  <section class="handbook-section" id="handbook-section">
    <el-card class="handbook-card glass-effect">
      <template #header>
        <div class="card-header">
          <div class="header-left">
            <span class="header-icon">📚</span>
            <span>Spring AI + 大模型全栈实战指南</span>
          </div>
          <el-tag type="danger" size="small" effect="dark">完整学习路径</el-tag>
        </div>
      </template>

      <div class="handbook-intro">
        <p class="intro-text">
          本系统是我在学习 <strong>Spring AI + 大模型</strong> 过程中的全栈实践成果。
          以下是完整的 9 大专题学习手册，涵盖从架构设计到生产部署的全部知识。
        </p>
        <div class="handbook-stats">
          <div class="handbook-stat-item">
            <div class="stat-num">9</div>
            <div class="stat-label">核心专题</div>
          </div>
          <div class="handbook-stat-item">
            <div class="stat-num">50+</div>
            <div class="stat-label">技术要点</div>
          </div>
          <div class="handbook-stat-item">
            <div class="stat-num">100%</div>
            <div class="stat-label">开源代码</div>
          </div>
          <div class="handbook-stat-item">
            <div class="stat-num">生产级</div>
            <div class="stat-label">部署方案</div>
          </div>
        </div>
      </div>

      <!-- 9 大专题网格 -->
      <el-row :gutter="20" class="topic-grid">
        <el-col
          v-for="(topic, index) in handbookTopics"
          :key="index"
          :xs="24"
          :sm="12"
          :md="8"
          class="topic-col"
        >
          <el-card
            shadow="hover"
            class="topic-card"
            @click="handleTopicClick(index)"
          >
            <div class="topic-card-header">
              <span class="topic-num">{{ String(index + 1).padStart(2, '0') }}</span>
              <el-tag :type="getTopicLevelType(topic.level)" size="small">{{
                  topic.level
                }}
              </el-tag>
            </div>
            <h3 class="topic-title">{{ topic.title }}</h3>
            <p class="topic-desc">{{ topic.desc }}</p>
            <div class="topic-tags">
            <span v-for="tag in topic.tags" :key="tag" class="mini-topic-tag">
              <el-icon><Ticket/></el-icon> {{ tag }}
            </span>
            </div>
            <div class="topic-progress">
              <div class="progress-bar">
                <div class="progress-fill" :style="{ width: topic.progress }"></div>
              </div>
              <span class="progress-text">{{ topic.progress }}</span>
            </div>
          </el-card>
        </el-col>
      </el-row>

      <!-- 手册特色 -->
      <el-row :gutter="20" style="margin-top: 30px;">
        <el-col :xs="24" :md="8" v-for="(feature, index) in handbookFeatures" :key="index">
          <div class="handbook-feature-item">
            <div class="feature-icon-wrapper" :style="{ background: feature.color }">
              <el-icon :size="28" color="#fff">
                <component :is="feature.icon"/>
              </el-icon>
            </div>
            <h4>{{ feature.title }}</h4>
            <p>{{ feature.desc }}</p>
          </div>
        </el-col>
      </el-row>

      <!-- 行动按钮 -->
      <div class="handbook-actions">
        <el-button type="primary" size="large" round @click="openGithubHandbook"
                   class="glow-btn">
          <el-icon>
            <FolderOpened/>
          </el-icon>
          GitHub 查看全部文档
        </el-button>
      </div>
    </el-card>
  </section>
</template>
<script setup lang="ts">
import {
  getTopicLevelType,
  handbookFeatures,
  handbookTopics,
  handleTopicClick, openGithubHandbook
} from "@/assets/ts/constants.ts";
import {FolderOpened, Ticket} from "@element-plus/icons-vue";

defineProps<{ handbookTopics: any[] }>()
defineEmits(['topic-click', 'open-github'])
</script>
<style src="../../assets/styles/home.css" scoped></style>
