<template>
  <div class="home-wrapper">
    <div class="content-container">
      <!-- Hero 欢迎区域 -->
      <el-row>
        <el-col :span="24">
          <el-card shadow="never" class="hero-card">
            <div class="hero-content">
              <h1 class="gradient-text">Lite-RAG 智能助手</h1>
              <p class="hero-desc">
                基于 <strong>Spring AI</strong> 与 <strong>Milvus 2.6</strong> 构建。
                经过深度调优，在 2核4G 环境下实现秒级响应。
              </p>
              <div class="hero-btns">
                <el-button type="primary" size="large" @click="$router.push('/chat/rag')" round shadow>
                  进入知识库问答
                </el-button>
                <el-button size="large" round @click="toggleDetails">
                  {{ showDetails ? '隐藏技术规格' : '技术规格说明' }}
                </el-button>
              </div>
            </div>
          </el-card>
        </el-col>
      </el-row>

      <!-- 核心指标卡片 -->
      <el-row :gutter="20" class="metric-row">
        <el-col :xs="24" :sm="8" v-for="metric in coreMetrics" :key="metric.title">
          <div class="metric-card">
            <div class="metric-value">{{ metric.value }}</div>
            <div class="metric-label">{{ metric.title }}</div>
            <div class="metric-desc">{{ metric.desc }}</div>
          </div>
        </el-col>
      </el-row>

      <!-- 隐藏的技术细节页 (README内容) -->
      <transition name="el-zoom-in-top">
        <el-row :gutter="30" class="details-row" v-if="showDetails" id="tech-section">
          <el-col :xs="24" :lg="14">
            <el-card shadow="hover" header="📊 工业级调优成果" class="tech-card">
              <div class="table-responsive">
                <table class="performance-table">
                  <thead>
                  <tr>
                    <th>指标</th>
                    <th>默认配置</th>
                    <th>极致调优后</th>
                  </tr>
                  </thead>
                  <tbody>
                  <tr>
                    <td><strong>可用内存</strong></td>
                    <td class="red">低至 100MB</td>
                    <td class="green">1.8GB+</td>
                  </tr>
                  <tr>
                    <td><strong>首字响应</strong></td>
                    <td class="red">60s+</td>
                    <td class="green">3 - 5s</td>
                  </tr>
                  </tbody>
                </table>
              </div>
            </el-card>
          </el-col>

          <el-col :xs="24" :lg="10">
            <el-card shadow="hover" header="🛠️ 核心架构栈" class="tech-card">
              <div class="tech-tags">
                <el-tag v-for="tech in techStack" :key="tech" class="tech-tag" effect="plain">
                  {{ tech }}
                </el-tag>
              </div>
              <el-divider content-position="left">调优要点</el-divider>
              <ul class="tuning-list">
                <li>HNSW 向量索引 + Cosine 度量</li>
                <li>SSE 零丢包 Buffer 缓冲区逻辑</li>
                <li>Ollama 线程配额与显存回收</li>
              </ul>
            </el-card>
          </el-col>
        </el-row>
      </transition>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref, nextTick } from 'vue'

const showDetails = ref(false)

const toggleDetails = () => {
  showDetails.value = !showDetails.value
  if (showDetails.value) {
    // 等待 DOM 更新后滚动
    nextTick(() => {
      document.getElementById('tech-section')?.scrollIntoView({ behavior: 'smooth' })
    })
  }
}

const coreMetrics = [
  { title: '推理模型', value: 'Qwen 1.5B', desc: '4G内存下的智商巅峰' },
  { title: '响应速度', value: '3.5s', desc: '首字生成平均耗时' },
  { title: '检索引擎', value: 'HNSW', desc: '毫秒级语义召回' },
]

const techStack = ['Spring Boot 3.4.3', 'Spring AI M6', 'Ollama Engine', 'Milvus 2.6.0']
</script>

<style scoped>
.home-wrapper {
  width: 100%;
  min-height: 100vh;
  background-color: #f5f7fa;
  overflow-x: hidden;
}

.content-container {
  max-width: 1200px;
  margin: 0 auto;
  padding: 40px 20px;
}

/* 修复文字重叠：增加 line-height 和 margin */
.gradient-text {
  font-size: clamp(2rem, 6vw, 3.5rem);
  font-weight: 800;
  line-height: 1.2;
  background: linear-gradient(45deg, #1e90ff, #00ced1);
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
  margin-bottom: 30px; /* 增加下方间距防止重叠按钮 */
  display: block;
}

.hero-card {
  border-radius: 20px;
  background: linear-gradient(135deg, #ffffff 0%, #eef6ff 100%);
  padding: 60px 20px;
  margin-bottom: 40px;
  border: 1px solid #dcdfe6;
}

.hero-desc {
  font-size: 1.1rem;
  color: #606266;
  margin-bottom: 40px;
  max-width: 600px;
  margin-left: auto;
  margin-right: auto;
}

/* 核心卡片样式 */
.metric-row {
  margin-bottom: 40px;
}

.metric-card {
  background: white;
  padding: 30px 20px;
  border-radius: 16px;
  text-align: center;
  box-shadow: 0 10px 20px rgba(0, 0, 0, 0.05);
  border: 1px solid #f0f2f5;
  margin-bottom: 20px;
}

.metric-value {
  font-size: 2.2rem;
  font-weight: bold;
  color: #409eff;
  margin-bottom: 10px;
}

.metric-label {
  font-size: 1.1rem;
  font-weight: bold;
  color: #303133;
}

.metric-desc {
  color: #909399;
  font-size: 0.9rem;
}

/* 技术细节卡片 */
.tech-card {
  border-radius: 12px;
  margin-bottom: 30px;
}

.performance-table {
  width: 100%;
  border-collapse: collapse;
}

.performance-table th, .performance-table td {
  padding: 15px;
  border-bottom: 1px solid #ebeef5;
  text-align: left;
}

.red { color: #f56c6c; font-weight: bold; }
.green { color: #67c23a; font-weight: bold; }

.tech-tags {
  display: flex;
  flex-wrap: wrap;
  gap: 10px;
}

.tuning-list {
  padding-left: 20px;
  line-height: 2;
  color: #606266;
}

/* 响应式调整 */
@media (max-width: 768px) {
  .hero-btns .el-button {
    width: 100%;
    margin: 10px 0 !important;
  }
}
</style>
