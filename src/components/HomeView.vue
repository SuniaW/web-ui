<template>
  <div class="home-container">
    <!-- 浅色动态背景装饰 -->
    <div class="bg-decoration-1"></div>
    <div class="bg-decoration-2"></div>

    <!-- 顶部导航提示 - 浅色清爽风格 -->
    <div class="top-banner">
      <div class="banner-content">
        <div class="pulse-dot"></div>
        <span>专为 <strong>2 核 4G</strong> 环境深度优化的企业级 RAG 系统</span>
        <el-tag size="small" type="success" effect="plain" round class="status-tag">生产就绪 v1.0</el-tag>
      </div>
    </div>

    <div class="main-content">
      <!-- Hero 欢迎区 -->
      <section class="hero-section">
        <div class="hero-card">
          <div class="hero-badge-group">
            <el-tag v-for="badge in badges" :key="badge.text" :type="badge.type" size="small" effect="light" round class="custom-badge">
              {{ badge.text }}
            </el-tag>
          </div>

          <h1 class="hero-title">
            <span class="gradient-text">Lite-RAG</span>
            <span class="title-suffix">智能助手</span>
          </h1>

          <p class="hero-subtitle">
            基于 <span class="highlight">Spring AI</span> 与 <span class="highlight">Milvus 2.6</span> 构建的工业级私有化知识库。<br>
            深度性能调优，实现 <strong>2C4G</strong> 低功耗环境下的秒级生成体验。
          </p>

          <div class="action-group">
            <el-button type="primary" size="large" @click="goToChat" class="btn-primary main-btn">
              <el-icon><ChatDotRound /></el-icon>
              立即开启对话
            </el-button>
            <el-button size="large" @click="handleToggleDetails" class="btn-glass">
              <el-icon>
                <component :is="showDetails ? 'Fold' : 'Expand'" />
              </el-icon>
              {{ showDetails ? '收起技术规格' : '查看技术细节' }}
            </el-button>
            <el-button size="large" @click="scrollToSection('author-section')" class="btn-link">
              <el-icon><User /></el-icon>
              关于作者
            </el-button>
          </div>
        </div>
      </section>

      <!-- 核心指标区 - 磁贴布局 -->
      <div class="metrics-grid">
        <div
          class="metric-item"
          v-for="(m, index) in coreMetrics"
          :key="m.title"
          :style="{ animationDelay: `${index * 0.1}s` }"
        >
          <div class="metric-icon-wrapper">{{ m.icon }}</div>
          <div class="metric-content">
            <div class="m-value">{{ m.value }}</div>
            <div class="m-title">{{ m.title }}</div>
            <div class="m-desc">{{ m.desc }}</div>
          </div>
        </div>
      </div>

      <!-- 隐藏的技术细节区 -->
      <transition name="el-zoom-in-top">
        <div v-if="showDetails" id="tech-section" class="details-section">
          <!-- 第一排：对比与技术栈 -->
          <el-row :gutter="24">
            <el-col :xs="24" :lg="14">
              <el-card class="white-card performance-card">
                <template #header>
                  <div class="card-header">
                    <span class="header-with-icon"><el-icon><DataLine /></el-icon> 极致性能调优对比</span>
                    <el-tag type="success" effect="dark" size="small">Verified</el-tag>
                  </div>
                </template>
                <div class="table-container">
                  <table class="modern-table">
                    <thead>
                    <tr>
                      <th>核心指标</th>
                      <th>默认配置</th>
                      <th>Lite-RAG 优化</th>
                      <th>提升</th>
                    </tr>
                    </thead>
                    <tbody>
                    <tr v-for="item in performanceData" :key="item.metric">
                      <td class="font-bold">{{ item.metric }}</td>
                      <td class="text-muted">{{ item.before }}</td>
                      <td class="text-primary-bold">{{ item.after }}</td>
                      <td><span class="growth-label">{{ item.improvement }}</span></td>
                    </tr>
                    </tbody>
                  </table>
                </div>
              </el-card>
            </el-col>

            <el-col :xs="24" :lg="10">
              <el-card class="white-card tech-stack-card">
                <template #header>
                  <div class="card-header">
                    <span class="header-with-icon"><el-icon><Cpu /></el-icon> 核心技术栈</span>
                  </div>
                </template>
                <div class="tag-cloud">
                  <span v-for="t in techStack" :key="t" class="tech-tag">{{ t }}</span>
                </div>
                <el-divider><span class="divider-text">调优黑科技</span></el-divider>
                <ul class="fancy-list">
                  <li v-for="tip in optimizationTips" :key="tip">
                    <el-icon class="check-icon"><CircleCheck /></el-icon>
                    {{ tip }}
                  </li>
                </ul>
              </el-card>
            </el-col>
          </el-row>

          <!-- 规格参数 -->
          <el-row :gutter="24" style="margin-top: 24px;">
            <el-col :xs="24" :md="12">
              <el-card class="white-card spec-card">
                <div class="spec-title">🖥️ 硬件算力规格</div>
                <div class="spec-grid">
                  <div class="spec-box" v-for="spec in serverSpecs" :key="spec.name">
                    <span class="s-label">{{ spec.name }}</span>
                    <span class="s-value">{{ spec.value }}</span>
                    <span class="s-note">{{ spec.note }}</span>
                  </div>
                </div>
              </el-card>
            </el-col>
            <el-col :xs="24" :md="12">
              <el-card class="white-card spec-card">
                <div class="spec-title">⚙️ 业务服务指标</div>
                <div class="spec-grid">
                  <div class="spec-box" v-for="spec in serviceSpecs" :key="spec.name">
                    <span class="s-label">{{ spec.name }}</span>
                    <span class="s-value">{{ spec.value }}</span>
                    <span class="s-note">{{ spec.note }}</span>
                  </div>
                </div>
              </el-card>
            </el-col>
          </el-row>

          <!-- 内存分配可视化 -->
          <el-card class="white-card memory-card" style="margin-top: 24px;">
            <template #header>
              <div class="card-header"><span>💾 4GB 极致内存分配方案</span></div>
            </template>
            <div class="memory-viz">
              <div v-for="item in memoryAllocation" :key="item.component" class="mem-row">
                <div class="mem-info">
                  <span class="mem-name">{{ item.component }}</span>
                  <span class="mem-val">{{ item.memory }}</span>
                </div>
                <div class="mem-progress-bg">
                  <div class="mem-progress-fill" :style="{ width: item.percentage, backgroundColor: item.color }">
                    <span class="mem-percent">{{ item.percentage }}</span>
                  </div>
                </div>
              </div>
            </div>
          </el-card>

          <!-- 核心技术详解 -->
          <div class="section-title">🔬 核心技术详解</div>
          <div class="tech-detail-grid">
            <div class="tech-detail-card" v-for="tech in coreTechnologies" :key="tech.name">
              <div class="tech-card-head">
                <span class="t-icon">{{ tech.icon }}</span>
                <h4>{{ tech.name }}</h4>
                <el-tag :type="tech.tagType" size="small" effect="light" round>{{ tech.level }}</el-tag>
              </div>
              <p>{{ tech.description }}</p>
              <div class="t-features">
                <span v-for="f in tech.features" :key="f"># {{ f }}</span>
              </div>
            </div>
          </div>

          <!-- 快速部署 -->
          <el-card class="white-card deploy-card" style="margin-top: 24px;">
            <template #header><span>🚀 4 步快速生产部署</span></template>
            <div class="deploy-timeline">
              <div class="deploy-node" v-for="(step, i) in deploySteps" :key="i">
                <div class="node-idx">{{ i + 1 }}</div>
                <div class="node-content">
                  <h6>{{ step.title }}</h6>
                  <p>{{ step.desc }}</p>
                  <div class="terminal-box">
                    <code>{{ step.code }}</code>
                    <el-icon @click.stop="copyCode(step.code)" class="copy-icon"><CopyDocument /></el-icon>
                  </div>
                </div>
              </div>
            </div>
          </el-card>
        </div>
      </transition>

      <!-- 作者专区 - 极简白风格 -->
      <section id="author-section" class="author-section">
        <div class="author-profile-card">
          <div class="author-left">
            <div class="avatar-ring">
              <div class="avatar-inner">
                <el-icon><UserFilled /></el-icon>
              </div>
            </div>
            <div class="author-social">
              <el-button v-for="link in author.links" :key="link.name" circle @click="openLink(link.url)" class="social-btn">
                <el-icon><component :is="link.icon" /></el-icon>
              </el-button>
            </div>
          </div>
          <div class="author-right">
            <h2 class="author-name">{{ author.name }} <span class="verify-badge">✓</span></h2>
            <div class="author-title-text">{{ author.title }}</div>
            <p class="author-bio">{{ author.description }}</p>
            <div class="author-tags-row">
              <span v-for="tag in author.tags" :key="tag" class="author-tag">{{ tag }}</span>
            </div>
            <div class="author-stats-row">
              <div class="a-stat" v-for="stat in author.stats" :key="stat.label">
                <span class="a-stat-v">{{ stat.value }}</span>
                <span class="a-stat-l">{{ stat.label }}</span>
              </div>
            </div>
          </div>
        </div>
      </section>

      <!-- 底部脚注 -->
      <footer class="contact-footer">
        <div class="footer-card">
          <div class="footer-left">
            <h3>📬 联系与合作</h3>
            <p>欢迎交流 RAG 技术、性能调优及私有化部署</p>
          </div>
          <div class="footer-right">
            <div class="contact-pill" v-for="c in contacts" :key="c.name">
              <el-icon><component :is="c.icon" /></el-icon>
              {{ c.value }}
            </div>
          </div>
        </div>
        <div class="copyright">© 2026 Lite-RAG Ecosystem. Built with Spring AI & Milvus.</div>
      </footer>
    </div>

    <!-- 悬浮按钮 -->
    <el-backtop :right="40" :bottom="40">
      <div class="custom-backtop"><el-icon><ArrowUp /></el-icon></div>
    </el-backtop>
  </div>
</template>

<script setup lang="ts">
import { ref, nextTick, onMounted, onUnmounted } from 'vue'
import { useRouter } from 'vue-router'
import { ElMessage } from 'element-plus'
import {
  ChatDotRound, Fold, Expand, Check, CopyDocument, ArrowUp, ArrowDown,
  User, UserFilled, FolderOpened, Star, Link, Document, Calendar,
  Printer, Ticket, ShoppingCart, DataLine, Cpu, CircleCheck
} from '@element-plus/icons-vue'

const router = useRouter()
const showDetails = ref(false)
const expandedFaq = ref<number | null>(null)
const showBackToTop = ref(false)

// 徽章数据
const badges = [
  { text: 'Spring Boot 3.4.3', type: 'primary' },
  { text: 'Spring AI M6', type: 'warning' },
  { text: 'Milvus 2.6.0', type: 'success' },
  { text: '2C4G 优化', type: 'info' }
]

// 核心指标
const coreMetrics = [
  { icon: '🤖', title: '推理模型', value: 'Qwen 1.5B', desc: '性能与智能的最佳平衡' },
  { icon: '⚡', title: '平均响应', value: '3.5s', desc: '首字生成平均耗时' },
  { icon: '🎯', title: '检索引擎', value: 'HNSW', desc: '毫秒级高精度语义召回' },
  { icon: '💾', title: '可用内存', value: '2.2GB+', desc: '系统级优化提升 5.5 倍' }
]

// 性能对比数据
const performanceData = [
  { metric: '可用内存', before: '100MB (OOM)', after: '1.8GB+', improvement: '1800%' },
  { metric: '首字响应', before: '60s+', after: '3-5s', improvement: '12x' },
  { metric: '完整响应', before: '120s+', after: '15-25s', improvement: '5x' },
  { metric: '系统稳定', before: '频繁崩溃', after: '7×24 稳健', improvement: 'Production' }
]

// 技术栈
const techStack = [
  'Spring Boot 3.4', 'Spring AI M6', 'Milvus 2.6', 'Ollama',
  'Qwen2.5-1.5B', 'BGE-M3', 'Apache Tika', 'Docker'
]

// 优化要点
const optimizationTips = [
  'HNSW 向量索引算法优化', 'Ollama 线程配额精细化控制',
  'SSE 字符断包流式拼接修复', 'Linux 内核 Swap 积极度调优',
  'JVM 内存红线严格限制', 'Milvus 容器资源配额化'
]

// 服务器规格
const serverSpecs = [
  { name: 'CPU', value: '2 核心', note: 'Intel/AMD 均可' },
  { name: '内存', value: '4GB', note: '最低配置' },
  { name: '存储', value: '50GB SSD', note: '推荐 NVMe' },
  { name: '网络', value: '100Mbps', note: '内网更佳' },
  { name: '系统', value: 'Ubuntu 22.04', note: '或 CentOS 7+' },
  { name: '云厂商', value: '通用/云厂商均可', note: '已验证' }
]

// 服务规格
const serviceSpecs = [
  { name: '并发用户', value: '50+', note: '同时在线' },
  { name: 'QPS', value: '10-15', note: '查询/秒' },
  { name: '知识库容量', value: '10 万 + 文档', note: '支持 PDF/Word' },
  { name: '向量维度', value: '1024', note: 'BGE-M3' },
  { name: '响应时间', value: '3-5s', note: '首字生成' },
  { name: '可用性', value: '99.9%', note: '7×24 运行' }
]

// 内存分配
const memoryAllocation = [
  { component: 'Ollama (LLM 引擎)', memory: '2.2 GB', percentage: '55%', color: '#3b82f6' },
  { component: 'Milvus (向量库)', memory: '1.0 GB', percentage: '25%', color: '#10b981' },
  { component: 'Spring Boot (应用)', memory: '0.77 GB', percentage: '19%', color: '#f59e0b' },
  { component: 'OS 系统预留', memory: '0.2 GB', percentage: '5%', color: '#94a3b8' }
]

// 核心技术
const coreTechnologies = [
  {
    name: 'RAG 检索增强生成', icon: '🔍', level: '核心', tagType: 'danger',
    description: '结合向量检索与大语言模型，实现知识库精准问答',
    features: ['语义检索', '上下文增强', '引用溯源']
  },
  {
    name: 'HNSW 向量索引', icon: '📊', level: '优化', tagType: 'warning',
    description: '高效可导航小世界算法，实现毫秒级向量相似度搜索',
    features: ['O(log N) 复杂度', '高召回率', '内存友好']
  },
  {
    name: 'SSE 流式响应', icon: '⚡', level: '体验', tagType: 'primary',
    description: 'Server-Sent Events 实时推送，降低用户等待焦虑',
    features: ['首字即显', 'Buffer 拼接', '错误恢复']
  },
  {
    name: '内存分级管理', icon: '💾', level: '关键', tagType: 'success',
    description: 'JVM+Docker+Swap 三层内存管控，防止 OOM 崩溃',
    features: ['硬限制', '溢出保护', '自动回收']
  }
]

// 部署步骤
const deploySteps = [
  { title: '系统优化', desc: '配置 Swap 和内核参数', code: 'curl -sSL https://lite-rag.com/optimize.sh | bash' },
  { title: '部署向量库', desc: '启动优化的 Milvus 实例', code: 'docker-compose up -d milvus' },
  { title: '载入模型', desc: '配置 Qwen 1.5B 运行时', code: 'ollama run qwen2.5:1.5b' },
  { title: '启动主程序', desc: '启动 Spring Boot 应用', code: 'java -Xmx768m -jar app.jar' }
]

// 作者信息
const author = {
  name: 'Lite-RAG Team',
  title: '资深后端架构师 | AI 工程化布道者',
  description: '深耕分布式系统与 AI 工程化领域。我们致力于让每一台低配云服务器都能散发出大模型的智慧光芒。',
  tags: ['Spring 生态专家', 'AI 基础设施', 'JVM 调优'],
  stats: [
    { value: '10+', label: '年经验' },
    { value: '1.2k', label: 'Stars' },
    { value: '50k+', label: '阅读量' }
  ],
  links: [
    { name: 'GitHub', type: 'info', icon: 'Star', url: 'https://github.com' },
    { name: '博客', type: 'primary', icon: 'Document', url: 'https://blog.com' }
  ]
}

// 联系方式
const contacts = [
  { name: '邮箱', value: 'contact@lite-rag.com', icon: 'Message' },
  { name: '微信', value: 'RAG_Support_01', icon: 'ChatDotRound' }
]

const handleToggleDetails = () => {
  showDetails.value = !showDetails.value
  if (showDetails.value) {
    nextTick(() => {
      const el = document.getElementById('tech-section')
      if (el) { el.scrollIntoView({ behavior: 'smooth', block: 'start' }) }
    })
  }
}
const goToChat = () => { router.push('/chat/rag') }
const scrollToSection = (id: string) => {
  const el = document.getElementById(id)
  if (el) { el.scrollIntoView({ behavior: 'smooth', block: 'start' }) }
}
const copyCode = async (code: string) => {
  try {
    await navigator.clipboard.writeText(code)
    ElMessage.success('命令已复制')
  } catch (err) { ElMessage.error('复制失败') }
}
const openLink = (url: string) => { window.open(url, '_blank') }
const handleScroll = () => { showBackToTop.value = window.scrollY > 300 }

onMounted(() => { window.addEventListener('scroll', handleScroll) })
onUnmounted(() => { window.removeEventListener('scroll', handleScroll) })
</script>

<style scoped>
/* 浅色系变量定义 */
.home-container {
  --primary: #3b82f6;
  --primary-dark: #2563eb;
  --accent: #06b6d4;
  --success: #10b981;
  --bg-main: #f8fafc;
  --bg-white: #ffffff;
  --text-main: #1e293b;
  --text-dim: #64748b;
  --text-light: #94a3b8;
  --border-light: #e2e8f0;
  --shadow-sm: 0 1px 3px rgba(0,0,0,0.05);
  --shadow-md: 0 10px 15px -3px rgba(0,0,0,0.04), 0 4px 6px -4px rgba(0,0,0,0.02);

  height: 100vh;
  background-color: var(--bg-main);
  color: var(--text-main);
  font-family: 'Inter', -apple-system, sans-serif;
  overflow-x: hidden;
  position: relative;
}

/* 浅色背景装饰 */
.bg-decoration-1 {
  position: fixed;
  top: -10%;
  left: -5%;
  width: 40%;
  height: 50%;
  background: radial-gradient(circle, rgba(59, 130, 246, 0.05) 0%, transparent 70%);
  z-index: 0;
}
.bg-decoration-2 {
  position: fixed;
  bottom: 0;
  right: -5%;
  width: 40%;
  height: 50%;
  background: radial-gradient(circle, rgba(6, 182, 212, 0.05) 0%, transparent 70%);
  z-index: 0;
}

/* 顶部导航 */
.top-banner {
  background: rgba(255, 255, 255, 0.8);
  backdrop-filter: blur(10px);
  border-bottom: 1px solid var(--border-light);
  padding: 12px 0;
  position: sticky;
  top: 0;
  z-index: 1000;
}
.banner-content {
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 12px;
  font-size: 0.9rem;
  color: var(--text-dim);
}
.pulse-dot {
  width: 8px;
  height: 8px;
  background-color: var(--success);
  border-radius: 50%;
  animation: pulse 2s infinite;
}
@keyframes pulse {
  0% { transform: scale(0.95); box-shadow: 0 0 0 0 rgba(16, 185, 129, 0.4); }
  70% { transform: scale(1); box-shadow: 0 0 0 8px rgba(16, 185, 129, 0); }
  100% { transform: scale(0.95); box-shadow: 0 0 0 0 rgba(16, 185, 129, 0); }
}

/* 主内容区 */
.main-content {
  position: relative;
  z-index: 1;
  max-width: 1100px;
  margin: 0 auto;
  padding: 20px 20px 80px;
}

/* Hero Section */
.hero-section {
  padding: 60px 0 40px;
  text-align: center;
}
.hero-card {
  padding: 40px;
}
.hero-badge-group {
  display: flex;
  justify-content: center;
  gap: 8px;
  margin-bottom: 24px;
}
.hero-title {
  font-size: 3.5rem;
  font-weight: 800;
  letter-spacing: -0.02em;
  margin: 0 0 20px;
  color: #0f172a;
}
.gradient-text {
  background: linear-gradient(135deg, var(--primary) 0%, var(--accent) 100%);
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
}
.hero-subtitle {
  font-size: 1.2rem;
  color: var(--text-dim);
  line-height: 1.6;
  max-width: 700px;
  margin: 0 auto 40px;
}
.highlight {
  color: var(--primary);
  font-weight: 600;
}

/* 按钮组 */
.action-group {
  display: flex;
  justify-content: center;
  gap: 12px;
}
.main-btn {
  background: var(--primary) !important;
  border-radius: 12px !important;
  padding: 14px 28px !important;
  font-weight: 600;
  box-shadow: 0 4px 12px rgba(59, 130, 246, 0.3);
}
.btn-glass {
  background: var(--bg-white) !important;
  border: 1px solid var(--border-light) !important;
  color: var(--text-main) !important;
  border-radius: 12px !important;
  box-shadow: var(--shadow-sm);
}
.btn-glass:hover {
  background: #f1f5f9 !important;
}
.btn-link {
  color: var(--text-dim) !important;
  border: none !important;
  background: transparent !important;
}

/* 指标卡片 */
.metrics-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(240px, 1fr));
  gap: 20px;
  margin-top: 20px;
}
.metric-item {
  background: var(--bg-white);
  border: 1px solid var(--border-light);
  border-radius: 20px;
  padding: 24px;
  display: flex;
  align-items: center;
  gap: 16px;
  box-shadow: var(--shadow-sm);
  transition: all 0.3s ease;
}
.metric-item:hover {
  transform: translateY(-4px);
  box-shadow: var(--shadow-md);
  border-color: var(--primary);
}
.metric-icon-wrapper {
  font-size: 2rem;
  background: #f1f5f9;
  width: 60px;
  height: 60px;
  display: flex;
  align-items: center;
  justify-content: center;
  border-radius: 16px;
}
.m-value {
  font-size: 1.5rem;
  font-weight: 800;
  color: var(--text-main);
}
.m-title {
  color: var(--primary);
  font-size: 0.85rem;
  font-weight: 700;
  margin: 2px 0;
}
.m-desc {
  font-size: 0.75rem;
  color: var(--text-light);
}

/* 详情区卡片 */
.white-card {
  background: var(--bg-white) !important;
  border: 1px solid var(--border-light) !important;
  border-radius: 16px !important;
  box-shadow: var(--shadow-sm) !important;
}
:deep(.el-card__header) {
  background: #fcfdfe;
  border-bottom: 1px solid var(--border-light) !important;
}
.header-with-icon {
  display: flex;
  align-items: center;
  gap: 8px;
  font-weight: 700;
  color: var(--text-main);
}

/* 表格样式 */
.modern-table {
  width: 100%;
  border-collapse: collapse;
}
.modern-table th {
  text-align: left;
  padding: 12px;
  font-size: 0.8rem;
  color: var(--text-light);
  text-transform: uppercase;
  border-bottom: 2px solid #f1f5f9;
}
.modern-table td {
  padding: 16px 12px;
  border-bottom: 1px solid #f8fafc;
  font-size: 0.9rem;
}
.text-muted { color: var(--text-light); }
.text-primary-bold { color: var(--primary); font-weight: 700; }
.growth-label {
  background: #ecfdf5;
  color: var(--success);
  padding: 4px 10px;
  border-radius: 6px;
  font-size: 0.75rem;
  font-weight: 700;
}

/* 技术栈 */
.tag-cloud {
  display: flex;
  flex-wrap: wrap;
  gap: 8px;
}
.tech-tag {
  background: #eff6ff;
  color: var(--primary);
  padding: 6px 14px;
  border-radius: 10px;
  font-size: 0.8rem;
  font-weight: 600;
}
.fancy-list {
  list-style: none;
  padding: 0;
}
.fancy-list li {
  display: flex;
  align-items: center;
  gap: 10px;
  margin-bottom: 10px;
  color: var(--text-dim);
  font-size: 0.85rem;
}
.check-icon { color: var(--success); }

/* 规格卡片 */
.spec-grid {
  display: grid;
  grid-template-columns: repeat(2, 1fr);
  gap: 12px;
}
.spec-box {
  background: #f8fafc;
  padding: 14px;
  border-radius: 12px;
  display: flex;
  flex-direction: column;
}
.s-label { color: var(--text-light); font-size: 0.7rem; }
.s-value { font-size: 1rem; font-weight: 700; margin: 2px 0; color: var(--text-main); }
.s-note { color: var(--text-dim); font-size: 0.7rem; }

/* 内存条 */
.mem-row { margin-bottom: 16px; }
.mem-info { display: flex; justify-content: space-between; margin-bottom: 6px; font-size: 0.85rem; }
.mem-progress-bg { height: 10px; background: #f1f5f9; border-radius: 5px; overflow: hidden; }
.mem-progress-fill { height: 100%; border-radius: 5px; transition: width 1s; }

/* 技术卡片 */
.section-title { font-size: 1.5rem; font-weight: 800; margin: 40px 0 20px; text-align: center; }
.tech-detail-grid { display: grid; grid-template-columns: repeat(auto-fit, minmax(240px, 1fr)); gap: 16px; }
.tech-detail-card { background: var(--bg-white); border: 1px solid var(--border-light); padding: 20px; border-radius: 16px; }
.tech-card-head { display: flex; align-items: center; gap: 10px; margin-bottom: 12px; }
.tech-detail-card p { font-size: 0.85rem; color: var(--text-dim); line-height: 1.5; }
.t-features { margin-top: 12px; display: flex; gap: 8px; flex-wrap: wrap; font-size: 0.75rem; color: var(--primary); font-weight: 600; }

/* 部署代码 */
.terminal-box {
  background: #1e293b;
  padding: 12px 16px;
  border-radius: 10px;
  margin-top: 10px;
  display: flex;
  justify-content: space-between;
  align-items: center;
}
.terminal-box code { color: #38bdf8; font-family: 'Consolas', monospace; font-size: 0.85rem; }
.copy-icon { color: #94a3b8; cursor: pointer; }
.copy-icon:hover { color: #fff; }

/* 作者卡片 */
.author-section { margin-top: 60px; }
.author-profile-card {
  background: var(--bg-white);
  border: 1px solid var(--border-light);
  border-radius: 24px;
  padding: 40px;
  display: flex;
  gap: 40px;
  align-items: center;
  box-shadow: var(--shadow-sm);
}
.avatar-ring {
  width: 140px; height: 140px;
  border: 3px solid #eff6ff;
  border-radius: 50%;
  padding: 8px;
}
.avatar-inner {
  width: 100%; height: 100%;
  background: var(--primary);
  border-radius: 50%;
  display: flex; align-items: center; justify-content: center;
  font-size: 4rem; color: #fff;
}
.social-btn { border: 1px solid var(--border-light) !important; color: var(--text-dim) !important; }
.author-name { font-size: 2rem; font-weight: 800; margin: 0; }
.author-title-text { color: var(--primary); font-weight: 600; margin: 8px 0; }
.author-bio { color: var(--text-dim); font-size: 0.95rem; line-height: 1.6; }
.author-tag { background: #f1f5f9; padding: 4px 12px; border-radius: 8px; margin-right: 8px; font-size: 0.8rem; color: var(--text-dim); }
.author-stats-row { display: flex; gap: 30px; margin-top: 20px; }
.a-stat-v { font-size: 1.5rem; font-weight: 800; color: var(--text-main); display: block; }
.a-stat-l { font-size: 0.75rem; color: var(--text-light); }

/* 底部 */
.footer-card {
  background: #1e293b;
  color: #fff;
  padding: 40px;
  border-radius: 24px;
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-top: 40px;
}
.footer-card h3 { margin: 0 0 8px; }
.footer-card p { opacity: 0.7; font-size: 0.9rem; }
.contact-pill { background: rgba(255,255,255,0.1); padding: 8px 16px; border-radius: 20px; font-size: 0.85rem; margin-bottom: 8px; display: flex; align-items: center; gap: 8px; }
.copyright { text-align: center; margin: 40px 0; color: var(--text-light); font-size: 0.8rem; }

/* 悬浮按钮 */
.custom-backtop {
  width: 44px; height: 44px;
  background: var(--primary);
  border-radius: 50%;
  display: flex; align-items: center; justify-content: center;
  color: #fff; box-shadow: 0 4px 12px rgba(59, 130, 246, 0.4);
}

@media (max-width: 768px) {
  .hero-title { font-size: 2.2rem; }
  .author-profile-card { flex-direction: column; text-align: center; }
  .footer-card { flex-direction: column; gap: 24px; text-align: center; }
  .spec-grid { grid-template-columns: 1fr; }
}
</style>
