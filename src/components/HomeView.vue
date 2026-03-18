<template>
  <div class="home-container">
    <!-- 顶部导航提示 -->
    <div class="top-banner">
      <div class="banner-content">
        <span class="banner-icon">🚀</span>
        <span>专为 2 核 4G 环境深度优化的企业级 RAG 系统</span>
        <el-tag size="small" type="success" effect="dark">生产就绪</el-tag>
      </div>
    </div>

    <div class="main-content">
      <!-- Hero 欢迎区 -->
      <section class="hero-section">
        <div class="hero-card">
          <div class="hero-badge-group">
            <el-tag v-for="badge in badges" :key="badge.text" :type="badge.type" size="small" round>
              {{ badge.text }}
            </el-tag>
          </div>

          <h1 class="hero-title">
            <span class="gradient-text">Lite-RAG 智能助手</span>
          </h1>

          <p class="hero-subtitle">
            基于 <strong>Spring AI</strong> 与 <strong>Milvus 2.6</strong> 构建的工业级私有化知识库。<br>
            经过深度性能调优，实现 <strong>低功耗环境下的秒级生成</strong>。
          </p>

          <div class="action-group">
            <el-button type="primary" size="large" @click="goToChat" round class="btn-primary">
              <el-icon><ChatDotRound /></el-icon>
              进入知识库问答
            </el-button>
            <el-button size="large" round @click="handleToggleDetails" class="btn-secondary">
              <el-icon>
                <component :is="showDetails ? 'Fold' : 'Expand'" />
              </el-icon>
              {{ showDetails ? '隐藏技术规格' : '技术规格说明' }}
            </el-button>
            <el-button size="large" round @click="scrollToSection('author-section')" class="btn-tertiary">
              <el-icon><User /></el-icon>
              关于作者
            </el-button>
          </div>
        </div>
      </section>

      <!-- 核心指标区 -->
      <div class="metrics-grid">
        <div
          class="metric-item"
          v-for="(m, index) in coreMetrics"
          :key="m.title"
          :style="{ animationDelay: `${index * 0.1}s` }"
        >
          <div class="metric-icon">{{ m.icon }}</div>
          <div class="m-value">{{ m.value }}</div>
          <div class="m-title">{{ m.title }}</div>
          <div class="m-desc">{{ m.desc }}</div>
        </div>
      </div>

      <!-- 隐藏的技术细节区 -->
      <transition name="el-zoom-in-top">
        <div v-if="showDetails" id="tech-section" class="details-section">
          <!-- 性能对比卡片 -->
          <el-row :gutter="20">
            <el-col :xs="24" :md="14">
              <el-card header="📊 工业级调优对比" class="info-card performance-card">
                <template #header>
                  <div class="card-header">
                    <span>📊 工业级调优对比</span>
                    <el-tag type="success" size="small">生产验证</el-tag>
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
                    <tr v-for="item in performanceData" :key="item.metric">
                      <td class="metric-name">{{ item.metric }}</td>
                      <td class="status-bad">{{ item.before }}</td>
                      <td class="status-good">{{ item.after }}</td>
                      <td class="improvement">+{{ item.improvement }}</td>
                    </tr>
                    </tbody>
                  </table>
                </div>
              </el-card>
            </el-col>

            <!-- 核心技术栈 -->
            <el-col :xs="24" :md="10">
              <el-card header="🛠️ 核心技术栈" class="info-card">
                <template #header>
                  <div class="card-header">
                    <span>🛠️ 核心技术栈</span>
                    <el-tag type="warning" size="small">最新版本</el-tag>
                  </div>
                </template>
                <div class="tag-cloud">
                  <el-tag
                    v-for="(t, index) in techStack"
                    :key="t"
                    effect="dark"
                    size="small"
                    :style="{ animationDelay: `${index * 0.05}s` }"
                  >
                    {{ t }}
                  </el-tag>
                </div>
                <el-divider>调优要点</el-divider>
                <ul class="mini-tips">
                  <li v-for="tip in optimizationTips" :key="tip">
                    <el-icon class="tip-icon"><Check /></el-icon>
                    {{ tip }}
                  </li>
                </ul>
              </el-card>
            </el-col>
          </el-row>

          <!-- 服务器规格 -->
          <el-row :gutter="20" style="margin-top: 20px;">
            <el-col :xs="24" :md="12">
              <el-card header="🖥️ 服务器规格" class="info-card">
                <div class="spec-grid">
                  <div class="spec-item" v-for="spec in serverSpecs" :key="spec.name">
                    <div class="spec-label">{{ spec.name }}</div>
                    <div class="spec-value">{{ spec.value }}</div>
                    <div class="spec-note">{{ spec.note }}</div>
                  </div>
                </div>
              </el-card>
            </el-col>

            <!-- 服务规格 -->
            <el-col :xs="24" :md="12">
              <el-card header="⚙️ 服务规格" class="info-card">
                <div class="spec-grid">
                  <div class="spec-item" v-for="spec in serviceSpecs" :key="spec.name">
                    <div class="spec-label">{{ spec.name }}</div>
                    <div class="spec-value">{{ spec.value }}</div>
                    <div class="spec-note">{{ spec.note }}</div>
                  </div>
                </div>
              </el-card>
            </el-col>
          </el-row>

          <!-- 软件规格 -->
          <el-row :gutter="20" style="margin-top: 20px;">
            <el-col :xs="24" :md="24">
              <el-card header="📋 软件规格清单" class="info-card">
                <el-table :data="softwareSpecs" stripe style="width: 100%" :default-sort="{prop: 'category', order: 'ascending'}">
                  <el-table-column prop="category" label="类别" width="120" sortable />
                  <el-table-column prop="name" label="名称" width="180" />
                  <el-table-column prop="version" label="版本" width="120" />
                  <el-table-column prop="purpose" label="用途" />
                  <el-table-column prop="status" label="状态" width="100">
                    <template #default="scope">
                      <el-tag :type="scope.row.status === '生产级' ? 'success' : 'info'" size="small">
                        {{ scope.row.status }}
                      </el-tag>
                    </template>
                  </el-table-column>
                </el-table>
              </el-card>
            </el-col>
          </el-row>

          <!-- 内存分配可视化 -->
          <el-row :gutter="20" style="margin-top: 20px;">
            <el-col :xs="24" :md="24">
              <el-card header="💾 4GB 内存分配方案" class="info-card">
                <div class="memory-allocation">
                  <div
                    v-for="item in memoryAllocation"
                    :key="item.component"
                    class="memory-bar"
                  >
                    <div class="memory-label">
                      <span class="component-name">{{ item.component }}</span>
                      <span class="component-size">{{ item.memory }}</span>
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
                </div>
              </el-card>
            </el-col>
          </el-row>

          <!-- 核心技术详解 -->
          <el-row :gutter="20" style="margin-top: 20px;">
            <el-col :xs="24" :md="24">
              <el-card header="🔬 核心技术详解" class="info-card">
                <div class="tech-details">
                  <div class="tech-detail-item" v-for="tech in coreTechnologies" :key="tech.name">
                    <div class="tech-detail-header">
                      <span class="tech-icon">{{ tech.icon }}</span>
                      <h4>{{ tech.name }}</h4>
                      <el-tag :type="tech.tagType" size="small">{{ tech.level }}</el-tag>
                    </div>
                    <p class="tech-detail-desc">{{ tech.description }}</p>
                    <div class="tech-detail-features">
                      <span v-for="feature in tech.features" :key="feature" class="feature-tag">
                        {{ feature }}
                      </span>
                    </div>
                  </div>
                </div>
              </el-card>
            </el-col>
          </el-row>

          <!-- 开源仓库 & 技术博客 -->
          <el-row :gutter="20" style="margin-top: 20px;">
            <el-col :xs="24" :md="12">
              <el-card header="📦 开源代码仓库" class="info-card repo-card">
                <div class="repo-list">
                  <div class="repo-item" v-for="repo in repositories" :key="repo.name">
                    <div class="repo-icon">
                      <el-icon><FolderOpened /></el-icon>
                    </div>
                    <div class="repo-info">
                      <h4>{{ repo.name }}</h4>
                      <p>{{ repo.description }}</p>
                      <div class="repo-meta">
                        <span class="repo-stars">
                          <el-icon><Star /></el-icon>
                          {{ repo.stars }}
                        </span>
                        <span class="repo-lang">{{ repo.language }}</span>
                      </div>
                    </div>
                    <el-button type="primary" text @click="openLink(repo.url)">
                      <el-icon><Link /></el-icon>
                      访问
                    </el-button>
                  </div>
                </div>
              </el-card>
            </el-col>

            <el-col :xs="24" :md="12">
              <el-card header="📝 技术博客 & 文章" class="info-card blog-card">
                <div class="blog-list">
                  <div class="blog-item" v-for="blog in blogs" :key="blog.title">
                    <div class="blog-icon">
                      <el-icon><Document /></el-icon>
                    </div>
                    <div class="blog-info">
                      <h4>{{ blog.title }}</h4>
                      <p>{{ blog.summary }}</p>
                      <div class="blog-meta">
                        <span class="blog-date">{{ blog.date }}</span>
                        <el-tag size="small" :type="blog.tagType">{{ blog.category }}</el-tag>
                      </div>
                    </div>
                    <el-button type="primary" text @click="openLink(blog.url)">
                      <el-icon><Link /></el-icon>
                      阅读
                    </el-button>
                  </div>
                </div>
              </el-card>
            </el-col>
          </el-row>

          <!-- 书籍出版 -->
          <el-row :gutter="20" style="margin-top: 20px;">
            <el-col :xs="24" :md="24">
              <el-card header="📚 技术著作" class="info-card book-card">
                <div class="book-showcase">
                  <div class="book-cover" v-for="book in books" :key="book.title">
                    <div class="book-image">
                      <div class="book-placeholder">
                        <span class="book-icon">📖</span>
                        <span class="book-title">{{ book.title }}</span>
                      </div>
                    </div>
                    <div class="book-info">
                      <h3>{{ book.title }}</h3>
                      <p class="book-subtitle">{{ book.subtitle }}</p>
                      <p class="book-desc">{{ book.description }}</p>
                      <div class="book-meta">
                        <span><el-icon><Calendar /></el-icon> {{ book.publishDate }}</span>
                        <span><el-icon><Printer /></el-icon> {{ book.publisher }}</span>
                        <span><el-icon><Ticket /></el-icon> ISBN: {{ book.isbn }}</span>
                      </div>
                      <div class="book-actions">
                        <el-button type="primary" @click="openLink(book.purchaseUrl)">
                          <el-icon><ShoppingCart /></el-icon>
                          购买
                        </el-button>
                        <el-button @click="openLink(book.sampleUrl)">
                          <el-icon><Document /></el-icon>
                          试读
                        </el-button>
                      </div>
                    </div>
                  </div>
                </div>
              </el-card>
            </el-col>
          </el-row>

          <!-- 快速部署指南 -->
          <el-row :gutter="20" style="margin-top: 20px;">
            <el-col :xs="24" :md="24">
              <el-card header="📦 快速部署（4 步启动）" class="info-card">
                <div class="deploy-steps">
                  <div
                    v-for="(step, index) in deploySteps"
                    :key="index"
                    class="step-item"
                  >
                    <div class="step-number">{{ index + 1 }}</div>
                    <div class="step-content">
                      <h4>{{ step.title }}</h4>
                      <p>{{ step.desc }}</p>
                      <div class="step-code">
                        <code>{{ step.code }}</code>
                        <el-button
                          size="small"
                          text
                          @click="copyCode(step.code)"
                          class="copy-btn"
                        >
                          <el-icon><CopyDocument /></el-icon>
                        </el-button>
                      </div>
                    </div>
                  </div>
                </div>
              </el-card>
            </el-col>
          </el-row>

          <!-- 常见问题 -->
          <el-row :gutter="20" style="margin-top: 20px;">
            <el-col :xs="24" :md="24">
              <el-card header="🐛 常见问题排查" class="info-card">
                <div class="faq-grid">
                  <div
                    v-for="(faq, index) in faqs"
                    :key="index"
                    class="faq-item"
                    @click="toggleFaq(index)"
                  >
                    <div class="faq-question">
                      <span>{{ faq.question }}</span>
                      <el-icon class="faq-icon">
                        <component :is="expandedFaq === index ? 'ArrowUp' : 'ArrowDown'" />
                      </el-icon>
                    </div>
                    <transition name="expand">
                      <div v-show="expandedFaq === index" class="faq-answer">
                        <p><strong>原因：</strong>{{ faq.cause }}</p>
                        <p><strong>解决方案：</strong>{{ faq.solution }}</p>
                      </div>
                    </transition>
                  </div>
                </div>
              </el-card>
            </el-col>
          </el-row>
        </div>
      </transition>

      <!-- 作者推广区 -->
      <section id="author-section" class="author-section">
        <el-card class="author-card">
          <div class="author-content">
            <div class="author-avatar">
              <div class="avatar-placeholder">
                <el-icon><UserFilled /></el-icon>
              </div>
            </div>
            <div class="author-info">
              <h2>{{ author.name }}</h2>
              <p class="author-title">{{ author.title }}</p>
              <p class="author-desc">{{ author.description }}</p>
              <div class="author-tags">
                <el-tag v-for="tag in author.tags" :key="tag" size="small" effect="plain">
                  {{ tag }}
                </el-tag>
              </div>
              <div class="author-stats">
                <div class="stat-item" v-for="stat in author.stats" :key="stat.label">
                  <div class="stat-value">{{ stat.value }}</div>
                  <div class="stat-label">{{ stat.label }}</div>
                </div>
              </div>
              <div class="author-links">
                <el-button
                  v-for="link in author.links"
                  :key="link.name"
                  :type="link.type"
                  @click="openLink(link.url)"
                >
                  <el-icon><component :is="link.icon" /></el-icon>
                  {{ link.name }}
                </el-button>
              </div>
            </div>
          </div>
        </el-card>
      </section>

      <!-- 联系方式 -->
      <section class="contact-section">
        <el-card class="contact-card">
          <h3>📬 联系与合作</h3>
          <p>欢迎交流 RAG 技术、性能调优、企业私有化部署等话题</p>
          <div class="contact-methods">
            <div class="contact-item" v-for="contact in contacts" :key="contact.name">
              <el-icon class="contact-icon"><component :is="contact.icon" /></el-icon>
              <span>{{ contact.name }}: {{ contact.value }}</span>
            </div>
          </div>
        </el-card>
      </section>

      <!-- 底部撑开空间 -->
      <div class="bottom-spacer"></div>
    </div>

    <!-- 回到顶部按钮 -->
    <transition name="fade">
      <el-button
        v-show="showBackToTop"
        circle
        class="back-to-top"
        @click="scrollToTop"
      >
        <el-icon><ArrowUp /></el-icon>
      </el-button>
    </transition>
  </div>
</template>

<script setup lang="ts">
import { ref, nextTick, onMounted, onUnmounted } from 'vue'
import { useRouter } from 'vue-router'
import { ElMessage } from 'element-plus'
import {
  ChatDotRound, Fold, Expand, Check, CopyDocument, ArrowUp, ArrowDown,
  User, UserFilled, FolderOpened, Star, Link, Document, Calendar,
  Printer, Ticket, ShoppingCart
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
  { metric: '可用内存', before: '100MB (OOM)', after: '1.8GB+', improvement: '18 倍' },
  { metric: '首字响应', before: '60s+', after: '3-5s', improvement: '12 倍' },
  { metric: '完整响应', before: '120s+', after: '15-25s', improvement: '5 倍' },
  { metric: '系统稳定', before: '日均崩溃 3-5 次', after: '7×24 小时', improvement: '生产级' }
]

// 技术栈
const techStack = [
  'Spring Boot 3.4',
  'Spring AI M6',
  'Milvus 2.6',
  'Ollama',
  'Qwen2.5-1.5B',
  'BGE-M3',
  'Apache Tika',
  'Docker'
]

// 优化要点
const optimizationTips = [
  'HNSW 向量索引算法优化',
  'Ollama 线程配额精细化控制',
  'SSE 字符断包流式拼接修复',
  'Linux 内核 Swap 积极度调优',
  'JVM 内存红线严格限制',
  'Milvus 容器资源配额化'
]

// 服务器规格
const serverSpecs = [
  { name: 'CPU', value: '2 核心', note: 'Intel/AMD 均可' },
  { name: '内存', value: '4GB', note: '最低配置' },
  { name: '存储', value: '50GB SSD', note: '推荐 NVMe' },
  { name: '网络', value: '100Mbps', note: '内网更佳' },
  { name: '系统', value: 'Ubuntu 22.04', note: '或 CentOS 7+' },
  { name: '云厂商', value: '阿里云/腾讯云', note: '已验证' }
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

// 软件规格
const softwareSpecs = [
  { category: '后端框架', name: 'Spring Boot', version: '3.4.3', purpose: '应用核心框架', status: '生产级' },
  { category: 'AI 框架', name: 'Spring AI', version: '1.0.0-M6', purpose: 'LLM 集成抽象层', status: '生产级' },
  { category: '向量数据库', name: 'Milvus', version: '2.6.0', purpose: '向量存储与检索', status: '生产级' },
  { category: 'LLM 服务', name: 'Ollama', version: 'Latest', purpose: '本地模型推理', status: '生产级' },
  { category: '推理模型', name: 'Qwen2.5', version: '1.5B', purpose: '文本生成', status: '生产级' },
  { category: 'Embedding', name: 'BGE-M3', version: '1024 维', purpose: '中文向量嵌入', status: '生产级' },
  { category: '文档解析', name: 'Apache Tika', version: 'Latest', purpose: '多格式文档解析', status: '生产级' },
  { category: '容器化', name: 'Docker', version: '24.0+', purpose: '服务隔离部署', status: '生产级' },
  { category: '编排工具', name: 'Docker Compose', version: '2.0+', purpose: '多容器管理', status: '生产级' },
  { category: '前端框架', name: 'Vue 3', version: '3.4+', purpose: '用户界面', status: '生产级' }
]

// 内存分配
const memoryAllocation = [
  { component: 'Ollama (LLM 引擎)', memory: '2.2 GB', percentage: '55%', color: '#409EFF' },
  { component: 'Milvus (向量库)', memory: '1.0 GB', percentage: '25%', color: '#67C23A' },
  { component: 'Spring Boot (应用)', memory: '0.77 GB', percentage: '19%', color: '#E6A23C' },
  { component: 'OS 系统预留', memory: '0.2 GB', percentage: '5%', color: '#909399' }
]

// 核心技术
const coreTechnologies = [
  {
    name: 'RAG 检索增强生成',
    icon: '🔍',
    level: '核心',
    tagType: 'danger',
    description: '结合向量检索与大语言模型，实现知识库精准问答',
    features: ['语义检索', '上下文增强', '引用溯源', '防幻觉机制']
  },
  {
    name: 'HNSW 向量索引',
    icon: '📊',
    level: '优化',
    tagType: 'warning',
    description: '高效可导航小世界算法，实现毫秒级向量相似度搜索',
    features: ['O(log N) 复杂度', '高召回率', '内存友好', '增量更新']
  },
  {
    name: 'SSE 流式响应',
    icon: '⚡',
    level: '体验',
    tagType: 'primary',
    description: 'Server-Sent Events 实时推送，降低用户等待焦虑',
    features: ['首字即显', '断点续传', 'Buffer 拼接', '错误恢复']
  },
  {
    name: '内存分级管理',
    icon: '💾',
    level: '关键',
    tagType: 'success',
    description: 'JVM+Docker+Swap 三层内存管控，防止 OOM 崩溃',
    features: ['硬限制', '软限制', '溢出保护', '自动回收']
  }
]

// 开源仓库
const repositories = [
  {
    name: 'lite-rag',
    description: 'Lite-RAG 核心后端代码，Spring Boot + Spring AI 实现',
    stars: '1.2k',
    language: 'Java',
    url: 'https://github.com/your-username/lite-rag'
  },
  {
    name: 'lite-rag-web',
    description: 'Vue 3 前端界面，Element Plus 组件库',
    stars: '450',
    language: 'TypeScript',
    url: 'https://github.com/your-username/lite-rag-web'
  },
  {
    name: 'rag-deploy-scripts',
    description: '一键部署脚本与 Docker 配置',
    stars: '320',
    language: 'Shell',
    url: 'https://github.com/your-username/rag-deploy-scripts'
  },
  {
    name: 'rag-optimization-guide',
    description: '性能调优完整指南与最佳实践',
    stars: '890',
    language: 'Markdown',
    url: 'https://github.com/your-username/rag-optimization-guide'
  }
]

// 技术博客
const blogs = [
  {
    title: '2 核 4G 服务器运行 RAG 的完整调优实践',
    summary: '从频发崩溃到 7×24 小时稳定运行的完整记录',
    date: '2026-03-15',
    category: '性能调优',
    tagType: 'danger',
    url: 'https://your-blog.com/rag-optimization'
  },
  {
    title: 'Spring AI M6 版本踩坑指南',
    summary: 'VectorStore 自动配置失效的解决方案',
    date: '2026-03-10',
    category: '框架实践',
    tagType: 'warning',
    url: 'https://your-blog.com/spring-ai-m6'
  },
  {
    title: 'Milvus 2.6 Standalone 模式内存优化',
    summary: 'Docker 资源限制与内部缓存调优',
    date: '2026-03-05',
    category: '向量数据库',
    tagType: 'primary',
    url: 'https://your-blog.com/milvus-optimization'
  },
  {
    title: 'Ollama 低配服务器部署最佳实践',
    summary: '线程控制、模型预热与内存管理',
    date: '2026-02-28',
    category: '模型推理',
    tagType: 'success',
    url: 'https://your-blog.com/ollama-deployment'
  },
  {
    title: 'SSE 流式响应断包问题完整解决方案',
    summary: '前端 Buffer 机制与不完整数据处理',
    date: '2026-02-20',
    category: '前端工程',
    tagType: 'info',
    url: 'https://your-blog.com/sse-streaming'
  }
]

// 书籍
const books = [
  {
    title: '《企业级 RAG 系统实战：从 0 到 1 构建私有化知识库》',
    subtitle: '低配服务器也能运行的高质量 AI 系统',
    description: '本书完整记录了从"频发崩溃"到"生产就绪"的 RAG 系统调优全过程。涵盖 Spring AI、Milvus、Ollama 等核心技术的深度优化实践，适合希望在资源受限环境下部署企业级 AI 系统的开发者。',
    publishDate: '2026 年 1 月',
    publisher: '电子工业出版社',
    isbn: '978-7-121-XXXXX-X',
    purchaseUrl: 'https://item.jd.com/xxxxx.html',
    sampleUrl: 'https://your-blog.com/book-sample'
  }
]

// 部署步骤
const deploySteps = [
  {
    title: '系统优化',
    desc: '卸载冗余监控，配置 Swap 和内核参数',
    code: 'wget http://update.aegis.aliyun.com/download/uninstall.sh && ./uninstall.sh'
  },
  {
    title: '部署 Milvus',
    desc: '使用优化的 docker-compose 启动向量库',
    code: 'cd /usr/milvus && docker compose up -d'
  },
  {
    title: '配置模型',
    desc: '拉取 Qwen 和 BGE 模型，限制线程数',
    code: 'ollama pull qwen2.5:1.5b && ollama pull bge-m3'
  },
  {
    title: '启动应用',
    desc: '限制 JVM 内存，上传 JAR 运行',
    code: 'java -Xms512m -Xmx768m -jar rag-system.jar'
  }
]

// 常见问题
const faqs = [
  {
    question: 'Connection Refused 19530',
    cause: 'Milvus 未启动或端口被拦截',
    solution: '检查 docker compose ps，确认安全组开放 19530 端口'
  },
  {
    question: 'collection not found',
    cause: 'Spring AI M6 版本自动配置失效',
    solution: '使用 Java 配置类强制注入，手动在 Attu 中建表'
  },
  {
    question: 'OOM 内存溢出',
    cause: '组件内存无限制导致资源争抢',
    solution: '设置 Docker 内存限制 + JVM -Xmx 参数'
  },
  {
    question: 'SSE 断包乱码',
    cause: '前端未处理不完整的数据包',
    solution: '引入 Buffer 机制，保留不完整行到下一包处理'
  }
]

// 作者信息
const author = {
  name: '您的姓名',
  title: '资深后端架构师 | RAG 技术布道者 | 技术作家',
  description: '专注于企业级 AI 系统架构与性能优化，擅长在资源受限环境下构建高质量私有化 AI 系统。现任某互联网公司技术专家，拥有 10+ 年分布式系统开发经验。',
  tags: ['Spring 生态专家', 'AI 工程化', '性能调优', '技术写作'],
  stats: [
    { value: '10+', label: '年经验' },
    { value: '50+', label: '技术文章' },
    { value: '3k+', label: 'GitHub Stars' },
    { value: '10w+', label: '技术读者' }
  ],
  links: [
    { name: 'GitHub', type: 'info', icon: 'Star', url: 'https://github.com/your-username' },
    { name: '博客', type: 'primary', icon: 'Document', url: 'https://your-blog.com' },
    { name: '知乎', type: 'warning', icon: 'User', url: 'https://zhihu.com/people/your-id' },
    { name: '公众号', type: 'success', icon: 'ChatDotRound', url: 'https://mp.weixin.qq.com' }
  ]
}

// 联系方式
const contacts = [
  { name: '邮箱', value: 'your-email@example.com', icon: 'Message' },
  { name: '微信', value: 'your-wechat-id', icon: 'ChatDotRound' },
  { name: 'GitHub', value: '@your-username', icon: 'Star' }
]

// 方法
const handleToggleDetails = () => {
  showDetails.value = !showDetails.value
  if (showDetails.value) {
    nextTick(() => {
      const el = document.getElementById('tech-section')
      if (el) {
        el.scrollIntoView({ behavior: 'smooth', block: 'start' })
      }
    })
  }
}

const goToChat = () => {
  router.push('/chat/rag')
}

const scrollToSection = (id: string) => {
  const el = document.getElementById(id)
  if (el) {
    el.scrollIntoView({ behavior: 'smooth', block: 'start' })
  }
}

const copyCode = async (code: string) => {
  try {
    await navigator.clipboard.writeText(code)
    ElMessage.success('代码已复制到剪贴板')
  } catch (err) {
    ElMessage.error('复制失败')
  }
}

const toggleFaq = (index: number) => {
  expandedFaq.value = expandedFaq.value === index ? null : index
}

const scrollToTop = () => {
  window.scrollTo({ top: 0, behavior: 'smooth' })
}

const openLink = (url: string) => {
  window.open(url, '_blank')
}

// 监听滚动
const handleScroll = () => {
  showBackToTop.value = window.scrollY > 300
}

onMounted(() => {
  window.addEventListener('scroll', handleScroll)
})

onUnmounted(() => {
  window.removeEventListener('scroll', handleScroll)
})
</script>

<style scoped>
/* CSS 变量定义 */
:root {
  --primary-color: #409EFF;
  --success-color: #67C23A;
  --warning-color: #E6A23C;
  --danger-color: #F56C6C;
  --info-color: #909399;
  --text-primary: #1e293b;
  --text-secondary: #64748b;
  --text-muted: #94a3b8;
  --bg-primary: #ffffff;
  --bg-secondary: #f8fafc;
  --border-color: #f1f5f9;
}

/* 容器与整体布局 */
.home-container {
  width: 100%;
  height: 100vh;
  overflow-y: auto;
  background-color: var(--bg-secondary);
  scroll-behavior: smooth;
  position: relative;
}

.main-content {
  max-width: 1200px;
  margin: 0 auto;
  padding: 20px 20px 40px;
}

/* 顶部横幅 */
.top-banner {
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  color: white;
  padding: 12px 20px;
  position: sticky;
  top: 0;
  z-index: 100;
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
}

.banner-content {
  max-width: 1200px;
  margin: 0 auto;
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 12px;
  font-size: 0.95rem;
}

.banner-icon {
  font-size: 1.2rem;
}

/* Hero Section */
.hero-section {
  margin: 30px 0 40px;
}

.hero-card {
  background: var(--bg-primary);
  border-radius: 24px;
  padding: 48px 32px;
  text-align: center;
  box-shadow: 0 8px 32px rgba(0, 0, 0, 0.08);
  border: 1px solid var(--border-color);
  position: relative;
  overflow: hidden;
}

.hero-card::before {
  content: '';
  position: absolute;
  top: 0;
  left: 0;
  right: 0;
  height: 4px;
  background: linear-gradient(90deg, #409EFF, #67C23A, #E6A23C);
}

.hero-badge-group {
  display: flex;
  justify-content: center;
  gap: 8px;
  margin-bottom: 24px;
  flex-wrap: wrap;
}

.hero-title {
  font-size: clamp(2rem, 5vw, 3.5rem);
  font-weight: 800;
  letter-spacing: -0.025em;
  color: var(--text-primary);
  margin: 0 0 20px 0;
}

.gradient-text {
  background: linear-gradient(135deg, #409EFF 0%, #06b6d4 100%);
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
  background-clip: text;
}

.hero-subtitle {
  color: var(--text-secondary);
  font-size: 1.15rem;
  line-height: 1.8;
  margin-bottom: 40px;
  max-width: 700px;
  margin-left: auto;
  margin-right: auto;
}

.hero-subtitle strong {
  color: var(--primary-color);
  font-weight: 600;
}

.action-group {
  display: flex;
  gap: 16px;
  justify-content: center;
  flex-wrap: wrap;
}

.btn-primary {
  min-width: 180px;
  font-weight: 600;
  box-shadow: 0 4px 14px rgba(64, 158, 255, 0.3);
}

.btn-primary:hover {
  transform: translateY(-2px);
  box-shadow: 0 6px 20px rgba(64, 158, 255, 0.4);
}

.btn-secondary, .btn-tertiary {
  min-width: 180px;
  font-weight: 600;
}

/* 指标卡片 */
.metrics-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
  gap: 20px;
  margin-bottom: 40px;
}

.metric-item {
  background: var(--bg-primary);
  padding: 28px 24px;
  border-radius: 16px;
  text-align: center;
  border: 1px solid var(--border-color);
  transition: all 0.3s ease;
  animation: fadeInUp 0.6s ease forwards;
  opacity: 0;
}

@keyframes fadeInUp {
  from {
    opacity: 0;
    transform: translateY(20px);
  }
  to {
    opacity: 1;
    transform: translateY(0);
  }
}

.metric-item:hover {
  transform: translateY(-6px);
  box-shadow: 0 12px 24px rgba(0, 0, 0, 0.08);
  border-color: var(--primary-color);
}

.metric-icon {
  font-size: 2.5rem;
  margin-bottom: 12px;
}

.m-value {
  font-size: 2.2rem;
  font-weight: 800;
  color: var(--primary-color);
  line-height: 1.2;
  margin-bottom: 8px;
}

.m-title {
  font-weight: 600;
  color: var(--text-primary);
  margin-bottom: 6px;
}

.m-desc {
  font-size: 0.875rem;
  color: var(--text-muted);
  line-height: 1.5;
}

/* 详情区块 */
.details-section {
  margin-top: 30px;
  scroll-margin-top: 80px;
}

.info-card {
  border-radius: 16px;
  border: 1px solid var(--border-color);
  box-shadow: 0 4px 16px rgba(0, 0, 0, 0.05);
}

.info-card :deep(.el-card__header) {
  background: var(--bg-secondary);
  border-bottom: 1px solid var(--border-color);
  padding: 16px 20px;
}

.card-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.card-header span {
  font-weight: 600;
  font-size: 1.1rem;
  color: var(--text-primary);
}

/* 规格网格 */
.spec-grid {
  display: grid;
  grid-template-columns: repeat(2, 1fr);
  gap: 16px;
}

.spec-item {
  padding: 16px;
  background: var(--bg-secondary);
  border-radius: 12px;
  text-align: center;
}

.spec-label {
  font-size: 0.85rem;
  color: var(--text-muted);
  margin-bottom: 6px;
}

.spec-value {
  font-size: 1.2rem;
  font-weight: 700;
  color: var(--text-primary);
  margin-bottom: 4px;
}

.spec-note {
  font-size: 0.8rem;
  color: var(--text-secondary);
}

/* 技术详情 */
.tech-details {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
  gap: 20px;
}

.tech-detail-item {
  padding: 20px;
  background: var(--bg-secondary);
  border-radius: 12px;
  border: 1px solid var(--border-color);
}

.tech-detail-header {
  display: flex;
  align-items: center;
  gap: 10px;
  margin-bottom: 12px;
}

.tech-icon {
  font-size: 1.5rem;
}

.tech-detail-header h4 {
  flex: 1;
  margin: 0;
  color: var(--text-primary);
}

.tech-detail-desc {
  color: var(--text-secondary);
  font-size: 0.9rem;
  line-height: 1.6;
  margin-bottom: 12px;
}

.tech-detail-features {
  display: flex;
  flex-wrap: wrap;
  gap: 8px;
}

.feature-tag {
  padding: 4px 10px;
  background: var(--bg-primary);
  border-radius: 12px;
  font-size: 0.8rem;
  color: var(--text-secondary);
  border: 1px solid var(--border-color);
}

/* 仓库列表 */
.repo-list, .blog-list {
  display: flex;
  flex-direction: column;
  gap: 12px;
}

.repo-item, .blog-item {
  display: flex;
  align-items: flex-start;
  gap: 12px;
  padding: 14px;
  background: var(--bg-secondary);
  border-radius: 12px;
  border: 1px solid var(--border-color);
  transition: all 0.3s ease;
}

.repo-item:hover, .blog-item:hover {
  border-color: var(--primary-color);
  background: white;
}

.repo-icon, .blog-icon {
  width: 40px;
  height: 40px;
  border-radius: 8px;
  background: var(--primary-color);
  color: white;
  display: flex;
  align-items: center;
  justify-content: center;
  flex-shrink: 0;
}

.blog-icon {
  background: var(--warning-color);
}

.repo-info h4, .blog-info h4 {
  margin: 0 0 6px 0;
  color: var(--text-primary);
  font-size: 1rem;
}

.repo-info p, .blog-info p {
  margin: 0 0 8px 0;
  color: var(--text-secondary);
  font-size: 0.85rem;
  line-height: 1.5;
}

.repo-meta, .blog-meta {
  display: flex;
  align-items: center;
  gap: 12px;
  font-size: 0.8rem;
  color: var(--text-muted);
}

.repo-stars {
  display: flex;
  align-items: center;
  gap: 4px;
  color: var(--warning-color);
}

/* 书籍展示 */
.book-showcase {
  display: flex;
  flex-direction: column;
  gap: 24px;
}

.book-cover {
  display: flex;
  gap: 24px;
  padding: 20px;
  background: var(--bg-secondary);
  border-radius: 16px;
  border: 1px solid var(--border-color);
}

.book-image {
  flex-shrink: 0;
}

.book-placeholder {
  width: 160px;
  height: 220px;
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  border-radius: 8px;
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  color: white;
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
}

.book-icon {
  font-size: 3rem;
  margin-bottom: 12px;
}

.book-title {
  font-size: 0.9rem;
  text-align: center;
  padding: 0 12px;
}

.book-info {
  flex: 1;
}

.book-info h3 {
  margin: 0 0 8px 0;
  color: var(--text-primary);
  font-size: 1.3rem;
}

.book-subtitle {
  color: var(--primary-color);
  font-weight: 500;
  margin-bottom: 12px;
}

.book-desc {
  color: var(--text-secondary);
  font-size: 0.9rem;
  line-height: 1.7;
  margin-bottom: 16px;
}

.book-meta {
  display: flex;
  gap: 20px;
  margin-bottom: 16px;
  font-size: 0.85rem;
  color: var(--text-muted);
}

.book-meta span {
  display: flex;
  align-items: center;
  gap: 6px;
}

.book-actions {
  display: flex;
  gap: 12px;
}

/* 部署步骤 */
.deploy-steps {
  display: flex;
  flex-direction: column;
  gap: 16px;
}

.step-item {
  display: flex;
  gap: 16px;
  padding: 16px;
  background: var(--bg-secondary);
  border-radius: 12px;
  border: 1px solid var(--border-color);
}

.step-number {
  width: 36px;
  height: 36px;
  border-radius: 50%;
  background: linear-gradient(135deg, var(--primary-color), #06b6d4);
  color: white;
  display: flex;
  align-items: center;
  justify-content: center;
  font-weight: 700;
  flex-shrink: 0;
}

.step-content {
  flex: 1;
}

.step-content h4 {
  margin: 0 0 6px 0;
  color: var(--text-primary);
  font-size: 1rem;
}

.step-content p {
  margin: 0 0 10px 0;
  color: var(--text-secondary);
  font-size: 0.9rem;
}

.step-code {
  display: flex;
  align-items: center;
  gap: 12px;
  background: #1e1e1e;
  padding: 10px 14px;
  border-radius: 8px;
  overflow-x: auto;
}

.step-code code {
  color: #d4d4d4;
  font-family: 'Consolas', 'Monaco', monospace;
  font-size: 0.85rem;
  flex: 1;
  white-space: nowrap;
}

.copy-btn {
  color: #9cdcfe;
  flex-shrink: 0;
}

.copy-btn:hover {
  color: white;
}

/* FAQ */
.faq-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(400px, 1fr));
  gap: 12px;
}

.faq-item {
  padding: 16px;
  background: var(--bg-secondary);
  border-radius: 12px;
  border: 1px solid var(--border-color);
  cursor: pointer;
  transition: all 0.3s ease;
}

.faq-item:hover {
  border-color: var(--primary-color);
  background: white;
}

.faq-question {
  display: flex;
  justify-content: space-between;
  align-items: center;
  font-weight: 600;
  color: var(--text-primary);
}

.faq-icon {
  color: var(--primary-color);
  font-size: 1.2rem;
}

.faq-answer {
  margin-top: 12px;
  padding-top: 12px;
  border-top: 1px solid var(--border-color);
}

.faq-answer p {
  margin: 6px 0;
  color: var(--text-secondary);
  font-size: 0.9rem;
  line-height: 1.6;
}

.faq-answer strong {
  color: var(--text-primary);
}

/* 作者区域 */
.author-section {
  margin-top: 40px;
}

.author-card {
  border-radius: 20px;
  border: 1px solid var(--border-color);
  box-shadow: 0 8px 32px rgba(0, 0, 0, 0.08);
  overflow: hidden;
}

.author-card::before {
  content: '';
  display: block;
  height: 6px;
  background: linear-gradient(90deg, #667eea, #764ba2, #f093fb);
}

.author-content {
  display: flex;
  gap: 40px;
  padding: 40px;
  align-items: center;
}

.author-avatar {
  flex-shrink: 0;
}

.avatar-placeholder {
  width: 140px;
  height: 140px;
  border-radius: 50%;
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  display: flex;
  align-items: center;
  justify-content: center;
  color: white;
  font-size: 4rem;
  box-shadow: 0 8px 24px rgba(102, 126, 234, 0.3);
}

.author-info {
  flex: 1;
}

.author-info h2 {
  margin: 0 0 8px 0;
  font-size: 2rem;
  color: var(--text-primary);
}

.author-title {
  color: var(--primary-color);
  font-weight: 500;
  margin-bottom: 16px;
}

.author-desc {
  color: var(--text-secondary);
  line-height: 1.8;
  margin-bottom: 20px;
}

.author-tags {
  display: flex;
  gap: 8px;
  flex-wrap: wrap;
  margin-bottom: 24px;
}

.author-stats {
  display: flex;
  gap: 30px;
  margin-bottom: 24px;
  padding: 20px;
  background: var(--bg-secondary);
  border-radius: 12px;
}

.stat-item {
  text-align: center;
}

.stat-value {
  font-size: 1.8rem;
  font-weight: 800;
  color: var(--primary-color);
}

.stat-label {
  font-size: 0.85rem;
  color: var(--text-muted);
  margin-top: 4px;
}

.author-links {
  display: flex;
  gap: 12px;
  flex-wrap: wrap;
}

/* 联系区域 */
.contact-section {
  margin-top: 30px;
}

.contact-card {
  border-radius: 16px;
  text-align: center;
  padding: 30px;
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  color: white;
  border: none;
}

.contact-card h3 {
  margin: 0 0 12px 0;
  font-size: 1.5rem;
}

.contact-card > p {
  color: rgba(255, 255, 255, 0.9);
  margin-bottom: 24px;
}

.contact-methods {
  display: flex;
  justify-content: center;
  gap: 30px;
  flex-wrap: wrap;
}

.contact-item {
  display: flex;
  align-items: center;
  gap: 8px;
  font-size: 0.95rem;
}

.contact-icon {
  font-size: 1.2rem;
}

/* 底部 spacer */
.bottom-spacer {
  height: 100px;
}

/* 回到顶部按钮 */
.back-to-top {
  position: fixed;
  bottom: 30px;
  right: 30px;
  z-index: 1000;
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
}

.back-to-top:hover {
  transform: translateY(-2px);
}

/* 动画 */
.fade-enter-active,
.fade-leave-active {
  transition: opacity 0.3s ease;
}

.fade-enter-from,
.fade-leave-to {
  opacity: 0;
}

.expand-enter-active,
.expand-leave-active {
  transition: all 0.3s ease;
  overflow: hidden;
}

.expand-enter-from,
.expand-leave-to {
  max-height: 0;
  opacity: 0;
}

/* 移动端适配 */
@media (max-width: 768px) {
  .main-content {
    padding: 16px 16px 30px;
  }

  .hero-card {
    padding: 32px 20px;
  }

  .hero-title {
    font-size: 1.8rem;
  }

  .hero-subtitle {
    font-size: 1rem;
  }

  .action-group {
    flex-direction: column;
  }

  .btn-primary, .btn-secondary, .btn-tertiary {
    width: 100%;
  }

  .metrics-grid {
    grid-template-columns: repeat(2, 1fr);
    gap: 12px;
  }

  .metric-item {
    padding: 20px 16px;
  }

  .m-value {
    font-size: 1.6rem;
  }

  .faq-grid {
    grid-template-columns: 1fr;
  }

  .banner-content {
    flex-direction: column;
    gap: 6px;
    text-align: center;
  }

  .step-item {
    flex-direction: column;
    align-items: flex-start;
  }

  .step-code {
    flex-direction: column;
    align-items: stretch;
  }

  .step-code code {
    white-space: pre-wrap;
    word-break: break-all;
  }

  .spec-grid {
    grid-template-columns: 1fr;
  }

  .author-content {
    flex-direction: column;
    text-align: center;
    padding: 30px 20px;
  }

  .author-stats {
    justify-content: center;
    gap: 20px;
  }

  .author-links {
    justify-content: center;
  }

  .book-cover {
    flex-direction: column;
    align-items: center;
  }

  .book-placeholder {
    width: 120px;
    height: 170px;
  }

  .contact-methods {
    flex-direction: column;
    gap: 16px;
  }
}

@media (max-width: 480px) {
  .metrics-grid {
    grid-template-columns: 1fr;
  }

  .author-stats {
    flex-wrap: wrap;
  }
}
</style>
