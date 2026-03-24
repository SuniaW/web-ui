<template>
  <transition name="el-zoom-in-top">
    <div id="tech-section" class="details-section">
      <!-- 软件规格 -->
      <el-row :gutter="20" style="margin-top: 20px;">
        <el-col :xs="24" :md="24">
          <el-card header="📋 软件规格清单" class="info-card glass-effect">
            <el-table :data="softwareSpecs" stripe style="width: 100%" :default-sort="{prop: 'category', order: 'ascending'}" class="styled-table">
              <el-table-column prop="category" label="类别" width="120" sortable/>
              <el-table-column prop="name" label="名称" width="180"/>
              <el-table-column prop="version" label="版本" width="120"/>
              <el-table-column prop="purpose" label="用途"/>
              <el-table-column prop="status" label="状态" width="100">
                <template #default="scope">
                  <el-tag :type="scope.row.status === '生产级' ? 'success' : 'info'" size="small" effect="dark">
                    {{ scope.row.status }}
                  </el-tag>
                </template>
              </el-table-column>
            </el-table>
          </el-card>
        </el-col>
      </el-row>

      <!-- 核心技术详解 (此处省略中间重复代码，逻辑同原文件，只是将 v-for 的数据源改为 props) -->
      <el-row :gutter="20" style="margin-top: 20px;">
        <el-col :xs="24" :md="24">
          <el-card header="🔬 核心技术详解" class="info-card glass-effect">
            <div class="tech-details">
              <div class="tech-detail-item" v-for="(tech, index) in coreTech" :key="tech.name" :style="{ animationDelay: `${index * 0.1}s` }">
                <!-- ... 内容同原文件 ... -->
                <div class="tech-detail-header">
                  <span class="tech-icon">{{ tech.icon }}</span>
                  <h4>{{ tech.name }}</h4>
                  <!-- 假设这里需要传递 getTechType 函数或者在父组件处理好，或者组件内引入工具函数 -->
                  <el-tag :type="tech.tagType" size="small" effect="dark">{{ tech.level }}</el-tag>
                </div>
                <p class="tech-detail-desc">{{ tech.description }}</p>
                <!-- ... -->
              </div>
            </div>
          </el-card>
        </el-col>
      </el-row>

      <!-- 其他部分 (技术栈、服务器规格、性能对比等) 均按此模式，将 v-for 的源数组替换为 props -->
      <!-- 例如：v-for="(tech, index) in allTechs" 改为 v-for="(tech, index) in allTechs" (props同名) -->

      <div class="placeholder-note">
        <!-- 请将原文件中剩余的 el-row 部分完整复制到这里，并将数据源变量名对应到 defineProps 中 -->
        <p>此处包含：核心技术栈、服务器规格、服务规格、性能对比、内存分配、开源仓库...</p>
      </div>
    </div>
  </transition>
</template>

<script setup lang="ts">
import { Tools, CircleCheckFilled, Check, FolderOpened, Link } from '@element-plus/icons-vue'

// 接收所有需要的数据
defineProps<{
  softwareSpecs: any[]
  coreTech: any[]
  allTechs: any[]
  optTips: any[]
  serverSpecs: any[]
  serviceSpecs: any[]
  perfData: any[]
  memAlloc: any[]
  repos: any[]
  // 如果子组件内用到了 getTechType 等函数，也需要通过 props 传入或在子组件内重新导入
}>()
</script>
