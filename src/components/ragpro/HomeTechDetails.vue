<template>
  <div id="tech-section" class="details-section">
    <!-- 软件规格 -->
    <el-row :gutter="20" style="margin-top: 20px;">
      <el-col :span="24">
        <el-card header="📋 软件规格清单" class="info-card glass-effect">
          <el-table :data="softwareSpecs" stripe style="width: 100%" class="styled-table">
            <el-table-column prop="category" label="类别" width="120" sortable/>
            <el-table-column prop="name" label="名称" width="180"/>
            <el-table-column prop="version" label="版本" width="120"/>
            <el-table-column prop="purpose" label="用途"/>
            <el-table-column prop="status" label="状态" width="100">
              <template #default="scope">
                <el-tag :type="scope.row.status === '生产级' ? 'success' : 'info'" size="small" effect="dark">{{ scope.row.status }}</el-tag>
              </template>
            </el-table-column>
          </el-table>
        </el-card>
      </el-col>
    </el-row>

    <!-- 调优对比 -->
    <el-row :gutter="20" style="margin-top: 20px;">
      <el-col :span="24">
        <el-card header="📊 工业级调优对比" class="info-card glass-effect performance-card">
          <div class="table-container">
            <table class="stat-table">
              <thead><tr><th>指标</th><th>默认配置</th><th>极致调优</th><th>提升</th></tr></thead>
              <tbody>
              <tr v-for="item in performanceData" :key="item.metric">
                <td>{{ item.metric }}</td>
                <td class="status-bad">{{ item.before }}</td>
                <td class="status-good">{{ item.after }}</td>
                <td><el-tag size="small" type="success">+{{ item.improvement }}</el-tag></td>
              </tr>
              </tbody>
            </table>
          </div>
        </el-card>
      </el-col>
    </el-row>
  </div>
</template>
<script setup lang="ts">
defineProps<{ softwareSpecs: any[], performanceData: any[] }>()
</script>
<style src="../../assets/styles/home.css"></style>
