<template>
  <!-- 作者推广区 -->
  <section id="author-section" class="author-section">
    <el-card class="author-card glass-effect">
      <div class="author-bg-decoration">
        <div class="author-orb"></div>
      </div>
      <div class="author-content">
        <div class="author-avatar">
          <div class="avatar-placeholder">
            <span class="avatar-text">汪</span>
            <div class="avatar-ring"></div>
          </div>
        </div>
        <div class="author-info">
          <h2>{{ author.name }}</h2>
          <p class="author-title">{{ author.title }}</p>
          <p class="author-desc">{{ author.description }}</p>
          <div class="author-tags">
            <el-tag v-for="tag in author.tags" :key="tag" size="small" effect="plain"
                    class="author-tag">
              {{ tag }}
            </el-tag>
          </div>
          <div class="author-stats">
            <div class="stat-item" v-for="stat in author.stats" :key="stat.label">
              <div class="stat-value">{{ stat.value }}</div>
              <div class="stat-label">{{ stat.label }}</div>
            </div>
          </div>
        </div>
      </div>
    </el-card>

    <!-- 个人优势 -->
    <el-card class="advantage-card glass-effect" style="margin-top: 30px;">
      <template #header>
        <div class="card-header">
          <div class="header-left">
            <span class="header-icon">💡</span>
            <span>个人优势</span>
          </div>
          <el-tag type="primary" size="small" effect="dark">12 年专业经验</el-tag>
        </div>
      </template>
      <div class="advantage-grid">
        <div class="advantage-item" v-for="(item, index) in advantages" :key="index"
             :style="{ animationDelay: `${index * 0.1}s` }">
          <div class="advantage-number">{{ index + 1 }}</div>
          <div class="advantage-content">
            <p>{{ item }}</p>
          </div>
        </div>
      </div>
    </el-card>
    <!-- 专业技能展示 -->
    <el-card class="skills-card glass-effect" style="margin-top: 30px;">
      <template #header>
        <div class="card-header">
          <div class="header-left">
            <span class="header-icon">🛠️</span>
            <span>专业技能</span>
          </div>
          <el-tag type="success" size="small" effect="dark">全栈能力</el-tag>
        </div>
      </template>
      <div class="skills-grid">
        <div class="skill-category" v-for="(category, index) in skills" :key="category.name"
             :style="{ animationDelay: `${index * 0.1}s` }">
          <div class="skill-header">
            <span class="skill-icon">{{ category.icon }}</span>
            <h4>{{ category.name }}</h4>
            <el-tag
              :type="category.level === '精通' ? 'danger' : category.level === '熟练' ? 'warning' : 'info'"
              size="small">
              {{ category.level }}
            </el-tag>
          </div>
          <div class="skill-items">
                <span class="skill-item" v-for="item in category.items" :key="item">{{
                    item
                  }}</span>
          </div>
        </div>
      </div>
    </el-card>
    <!-- 项目经历展示 -->
    <el-card class="project-card glass-effect" style="margin-top: 30px;">
      <template #header>
        <div class="card-header">
          <div class="header-left">
            <span class="header-icon">🎯</span>
            <span>代表项目经历</span>
          </div>
          <el-tag type="primary" size="small" effect="dark">12 年专业经验</el-tag>
        </div>
      </template>
      <div class="project-timeline">
        <div class="project-item" v-for="(project, index) in projects" :key="project.name"
             :style="{ animationDelay: `${index * 0.1}s` }">
          <div class="project-time">{{ project.time }}</div>
          <div class="project-dot"></div>
          <div class="project-content">
            <h4>{{ project.name }}</h4>
            <p class="project-company">{{ project.company }}</p>
            <div class="project-tags">
              <el-tag v-for="tech in project.technologies" :key="tech" size="small"
                      class="project-tech-tag">
                {{ tech }}
              </el-tag>
            </div>
            <ul class="project-achievements">
              <li v-for="achievement in project.achievements" :key="achievement">
                <el-icon class="achievement-icon">
                  <Check/>
                </el-icon>
                <span>{{ achievement }}</span>
              </li>
            </ul>
          </div>
        </div>
      </div>
    </el-card>
  </section>
</template>
<script setup lang="ts">
import {advantages, skills} from "@/assets/ts/constants.ts";
import {Check} from "@element-plus/icons-vue";

defineProps<{ author: any, projects: any[] }>()
</script>
<style src="../../assets/styles/home.css" scoped></style>
<style src="../../assets/styles/glass.css" scoped></style>
