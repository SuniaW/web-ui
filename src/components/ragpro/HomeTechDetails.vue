<template>
  <div id="tech-section" class="details-section">
    <!-- 软件规格 -->
    <el-row :gutter="20" style="margin-top: 20px;">
      <el-col :xs="24" :md="24">
        <el-card header="📋 软件规格清单" class="info-card glass-effect">
          <el-table
            :data="softwareSpecs"
            stripe
            style="width: 100%"
            :default-sort="{prop: 'category', order: 'ascending'}"
            class="styled-table"
          >
            <el-table-column prop="category" label="类别" width="120" sortable/>
            <el-table-column prop="name" label="名称" width="180"/>
            <el-table-column prop="version" label="版本" width="120"/>
            <el-table-column prop="purpose" label="用途"/>
            <el-table-column prop="status" label="状态" width="100">
              <template #default="scope">
                <el-tag
                  :type="scope.row.status === '生产级' ? 'success' : 'info'"
                  size="small"
                  effect="dark"
                >
                  {{ scope.row.status }}
                </el-tag>
              </template>
            </el-table-column>
          </el-table>
        </el-card>
      </el-col>
    </el-row>

    <!-- 核心技术详解 -->
    <el-row :gutter="20" style="margin-top: 20px;">
      <el-col :xs="24" :md="24">
        <el-card header="🔬 核心技术详解" class="info-card glass-effect">
          <div class="tech-details">
            <div class="tech-detail-item" v-for="(tech, index) in coreTechnologies"
                 :key="tech.name" :style="{ animationDelay: `${index * 0.1}s` }">
              <div class="tech-detail-header">
                <span class="tech-icon">{{ tech.icon }}</span>
                <h4>{{ tech.name }}</h4>
                <el-tag :type="tech.tagType" size="small" effect="dark">{{
                    tech.level
                  }}
                </el-tag>
              </div>
              <p class="tech-detail-desc">{{ tech.description }}</p>
              <div class="tech-detail-features">
                      <span v-for="feature in tech.features" :key="feature" class="feature-tag">
                        <el-icon><Check/></el-icon>
                        {{ feature }}
                      </span>
              </div>
            </div>
          </div>
        </el-card>
      </el-col>
    </el-row>
    <el-row :gutter="20" style="margin-top: 20px;">
      <!-- 核心技术栈 -->
      <el-col :xs="24" :md="24">
        <el-card shadow="hover" class="techstack-card-v2">
          <template #header>
            <div class="card-header">
              <div class="header-left">
                <el-icon class="header-icon">
                  <Tools/>
                </el-icon>
                <h3>核心技术栈</h3>
              </div>
              <el-tag type="warning" size="small" effect="dark" round>最新版本</el-tag>
            </div>
          </template>

          <!-- 技术栈标签流 -->
          <div class="tech-flow">
            <div class="tech-item" v-for="(tech, index) in allTechs" :key="index">
              <el-tag :type="getTechType(tech)" round size="small">{{ tech }}</el-tag>
            </div>
          </div>

          <!-- 调优要点时间轴 -->
          <div class="timeline">
            <div
              v-for="(tip, index) in optimizationTips"
              :key="index"
              class="timeline-item"
            >
              <div class="timeline-dot">
                <el-icon>
                  <CircleCheckFilled/>
                </el-icon>
              </div>
              <div class="timeline-content">
                <div class="timeline-number">{{ String(index + 1).padStart(2, '0') }}</div>
                <div class="timeline-text">{{ tip }}</div>
              </div>
              <div class="timeline-bar" v-if="index < optimizationTips.length - 1"></div>
            </div>
          </div>
        </el-card>
      </el-col>
    </el-row>
    <!-- 服务器规格 -->
    <el-row :gutter="20" style="margin-top: 20px;">
      <el-col :xs="24" :md="12">
        <el-card header="🖥️ 服务器规格" class="info-card glass-effect">
          <div class="spec-grid">
            <div class="spec-item" v-for="(spec, index) in serverSpecs" :key="spec.name"
                 :style="{ animationDelay: `${index * 0.05}s` }">
              <div class="spec-label">{{ spec.name }}</div>
              <div class="spec-value">{{ spec.value }}</div>
              <div class="spec-note">{{ spec.note }}</div>
            </div>
          </div>
        </el-card>
      </el-col>

      <!-- 服务规格 -->
      <el-col :xs="24" :md="12">
        <el-card header="⚙️ 服务规格" class="info-card glass-effect">
          <div class="spec-grid">
            <div class="spec-item" v-for="(spec, index) in serviceSpecs" :key="spec.name"
                 :style="{ animationDelay: `${index * 0.05}s` }">
              <div class="spec-label">{{ spec.name }}</div>
              <div class="spec-value gradient-value">{{ spec.value }}</div>
              <div class="spec-note">{{ spec.note }}</div>
            </div>
          </div>
        </el-card>
      </el-col>
    </el-row>
    <!-- 性能对比卡片 -->
    <el-row :gutter="20" style="margin-top: 20px;">
      <el-col :xs="24" :md="24">
        <el-card header="📊 工业级调优对比" class="info-card glass-effect performance-card">
          <template #header>
            <div class="card-header">
              <div class="header-left">
                <span class="header-icon">📊</span>
                <span>工业级调优对比</span>
              </div>
              <el-tag type="success" size="small" effect="dark">生产验证</el-tag>
            </div>
          </template>
          <div class="table-container">
            <table class="stat-table">
              <thead>
              <tr>
                <th>指标</th>
                <th>默认配置</th>
                <th>极致调优</th>
                <th>提升</th>
              </tr>
              </thead>
              <tbody>
              <tr v-for="(item, index) in performanceData" :key="item.metric">
                <td class="metric-name">
                        <span class="row-indicator"
                              :style="{ animationDelay: `${index * 0.1}s` }"></span>
                  {{ item.metric }}
                </td>
                <td class="status-bad">
                  <span class="status-dot bad"></span>
                  {{ item.before }}
                </td>
                <td class="status-good">
                  <span class="status-dot good"></span>
                  {{ item.after }}
                </td>
                <td class="improvement">
                  <span class="improvement-badge">+{{ item.improvement }}</span>
                </td>
              </tr>
              </tbody>
            </table>
          </div>
        </el-card>
      </el-col>
    </el-row>
    <!-- 内存分配可视化 -->
    <el-row :gutter="20" style="margin-top: 20px;">
      <el-col :xs="24" :md="24">
        <el-card header="💾 4GB 内存分配方案" class="info-card glass-effect">
          <div class="memory-allocation">
            <div
              v-for="(item, index) in memoryAllocation"
              :key="item.component"
              class="memory-bar"
              :style="{ animationDelay: `${index * 0.1}s` }"
            >
              <div class="memory-label">
                <span class="component-name">{{ item.component }}</span>
                <span class="component-size" :style="{ color: item.color }">{{
                    item.memory
                  }}</span>
              </div>
              <div class="memory-track">
                <div
                  class="memory-fill"
                  :style="{
                          width: item.percentage,
                          backgroundColor: item.color
                        }"
                >
                  <span class="memory-percent">{{ item.percentage }}</span>
                </div>
              </div>
            </div>
            <div class="memory-total">
              <span>总内存：</span>
              <span class="total-value">4.0 GB</span>
            </div>
          </div>
        </el-card>
      </el-col>
    </el-row>
    <!-- 开源仓库 & 技术博客 -->
    <el-row :gutter="20" style="margin-top: 20px;">
      <el-col :xs="24" :md="24">
        <el-card header="📦 开源代码仓库" class="info-card glass-effect repo-card">
          <div class="repo-list">
            <div class="repo-item" v-for="(repo, index) in repositories" :key="repo.name"
                 :style="{ animationDelay: `${index * 0.08}s` }">
              <div class="repo-icon">
                <el-icon>
                  <FolderOpened/>
                </el-icon>
              </div>
              <div class="repo-info">
                <h4>{{ repo.name }}</h4>
                <p>{{ repo.description }}</p>
                <div class="repo-meta">
                  <span class="repo-lang">{{ repo.language }}</span>
                </div>
              </div>
              <el-button type="primary" text @click="openLink(repo.url)" class="repo-btn">
                <el-icon>
                  <Link/>
                </el-icon>
                访问
              </el-button>
            </div>
          </div>
        </el-card>
      </el-col>
    </el-row>
  </div>
</template>
<script setup lang="ts">
import {
  allTechs,
  coreTechnologies,
  getTechType, memoryAllocation, optimizationTips, performanceData,
  repositories, serverSpecs, serviceSpecs,
  softwareSpecs
} from "@/assets/ts/constants.ts";
import {Check, CircleCheckFilled, FolderOpened, Link, Tools} from "@element-plus/icons-vue";

defineProps<{ softwareSpecs: any[], performanceData: any[] }>()

const openLink = (url: string) => {
  if (url === '#') return
  window.open(url, '_blank')
}
</script>
<style src="../../assets/styles/home.css"></style>
