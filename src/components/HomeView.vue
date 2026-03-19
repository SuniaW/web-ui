<template>
  <div class="home-container">
    <!-- 顶部导航提示 -->
    <div class="top-banner">
      <div class="banner-content">
        <span class="banner-icon">🚀</span>
        <span class="banner-text">专为 2 核 4G 环境深度优化的企业级 RAG 系统</span>
        <el-tag size="small" type="success" effect="dark" class="banner-tag">生产就绪</el-tag>
      </div>
      <div class="banner-glow"></div>
    </div>

    <div class="main-content">
      <!-- Hero 欢迎区 -->
      <section class="hero-section">
        <div class="hero-bg-decoration">
          <div class="hero-orb orb-1"></div>
          <div class="hero-orb orb-2"></div>
          <div class="hero-orb orb-3"></div>
        </div>

        <div class="hero-card glass-effect">
          <div class="hero-badge-group">
            <el-tag
              v-for="(badge, index) in badges"
              :key="badge.text"
              :type="badge.type"
              size="small"
              round
              class="hero-badge"
              :style="{ animationDelay: `${index * 0.1}s` }"
            >
              <span class="badge-dot"></span>
              {{ badge.text }}
            </el-tag>
          </div>

          <h1 class="hero-title">
            <span class="gradient-text">Lite-RAG</span>
            <span class="title-subtitle">智能助手</span>
          </h1>

          <p class="hero-subtitle">
            基于 <strong class="highlight-primary">Spring AI</strong> 与 <strong class="highlight-secondary">Milvus 2.6</strong> 构建的工业级私有化知识库。<br>
            经过深度性能调优，实现 <strong class="highlight-accent">低功耗环境下的秒级生成</strong>。
          </p>

          <div class="action-group">
            <el-button type="primary" size="large" @click="goToChat" round class="btn-primary glow-btn">
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
          class="metric-item glass-effect"
          v-for="(m, index) in coreMetrics"
          :key="m.title"
          :style="{ animationDelay: `${index * 0.1}s` }"
        >
          <div class="metric-icon-wrapper">
            <div class="metric-icon">{{ m.icon }}</div>
            <div class="metric-ring"></div>
          </div>
          <div class="m-value">{{ m.value }}</div>
          <div class="m-title">{{ m.title }}</div>
          <div class="m-desc">{{ m.desc }}</div>
          <div class="metric-hover-glow"></div>
        </div>
      </div>

      <!-- 隐藏的技术细节区 -->
      <transition name="el-zoom-in-top">
        <div v-if="showDetails" id="tech-section" class="details-section">
          <!-- 性能对比卡片 -->
          <el-row :gutter="20">
            <el-col :xs="24" :md="14">
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
                        <span class="row-indicator" :style="{ animationDelay: `${index * 0.1}s` }"></span>
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

            <!-- 核心技术栈 -->
            <el-col :xs="24" :md="10">
              <el-card header="🛠️ 核心技术栈" class="info-card glass-effect">
                <template #header>
                  <div class="card-header">
                    <div class="header-left">
                      <span class="header-icon">🛠️</span>
                      <span>核心技术栈</span>
                    </div>
                    <el-tag type="warning" size="small" effect="dark">最新版本</el-tag>
                  </div>
                </template>
                <div class="tag-cloud">
                  <el-tag
                    v-for="(t, index) in techStack"
                    :key="t"
                    effect="dark"
                    size="small"
                    class="tech-tag"
                    :style="{ animationDelay: `${index * 0.05}s` }"
                  >
                    {{ t }}
                  </el-tag>
                </div>
                <el-divider class="styled-divider">调优要点</el-divider>
                <ul class="mini-tips">
                  <li v-for="(tip, index) in optimizationTips" :key="tip" :style="{ animationDelay: `${index * 0.1}s` }">
                    <el-icon class="tip-icon"><Check /></el-icon>
                    <span class="tip-text">{{ tip }}</span>
                  </li>
                </ul>
              </el-card>
            </el-col>
          </el-row>

          <!-- 服务器规格 -->
          <el-row :gutter="20" style="margin-top: 20px;">
            <el-col :xs="24" :md="12">
              <el-card header="🖥️ 服务器规格" class="info-card glass-effect">
                <div class="spec-grid">
                  <div class="spec-item" v-for="(spec, index) in serverSpecs" :key="spec.name" :style="{ animationDelay: `${index * 0.05}s` }">
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
                  <div class="spec-item" v-for="(spec, index) in serviceSpecs" :key="spec.name" :style="{ animationDelay: `${index * 0.05}s` }">
                    <div class="spec-label">{{ spec.name }}</div>
                    <div class="spec-value gradient-value">{{ spec.value }}</div>
                    <div class="spec-note">{{ spec.note }}</div>
                  </div>
                </div>
              </el-card>
            </el-col>
          </el-row>

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
                  <el-table-column prop="category" label="类别" width="120" sortable />
                  <el-table-column prop="name" label="名称" width="180" />
                  <el-table-column prop="version" label="版本" width="120" />
                  <el-table-column prop="purpose" label="用途" />
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
                      <span class="component-size" :style="{ color: item.color }">{{ item.memory }}</span>
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

          <!-- 核心技术详解 -->
          <el-row :gutter="20" style="margin-top: 20px;">
            <el-col :xs="24" :md="24">
              <el-card header="🔬 核心技术详解" class="info-card glass-effect">
                <div class="tech-details">
                  <div class="tech-detail-item" v-for="(tech, index) in coreTechnologies" :key="tech.name" :style="{ animationDelay: `${index * 0.1}s` }">
                    <div class="tech-detail-header">
                      <span class="tech-icon">{{ tech.icon }}</span>
                      <h4>{{ tech.name }}</h4>
                      <el-tag :type="tech.tagType" size="small" effect="dark">{{ tech.level }}</el-tag>
                    </div>
                    <p class="tech-detail-desc">{{ tech.description }}</p>
                    <div class="tech-detail-features">
                      <span v-for="feature in tech.features" :key="feature" class="feature-tag">
                        <el-icon><Check /></el-icon>
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
              <el-card header="📦 开源代码仓库" class="info-card glass-effect repo-card">
                <div class="repo-list">
                  <div class="repo-item" v-for="(repo, index) in repositories" :key="repo.name" :style="{ animationDelay: `${index * 0.08}s` }">
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
                    <el-button type="primary" text @click="openLink(repo.url)" class="repo-btn">
                      <el-icon><Link /></el-icon>
                      访问
                    </el-button>
                  </div>
                </div>
              </el-card>
            </el-col>

            <el-col :xs="24" :md="12">
              <el-card header="📝 技术博客 & 文章" class="info-card glass-effect blog-card">
                <div class="blog-list">
                  <div class="blog-item" v-for="(blog, index) in blogs" :key="blog.title" :style="{ animationDelay: `${index * 0.08}s` }">
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
                    <el-button type="primary" text @click="openLink(blog.url)" class="blog-btn">
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
              <el-card header="📚 技术著作" class="info-card glass-effect book-card">
                <div class="book-showcase">
                  <div class="book-cover" v-for="book in books" :key="book.title">
                    <div class="book-image">
                      <div class="book-placeholder">
                        <span class="book-icon">📖</span>
                        <span class="book-title">{{ book.title }}</span>
                      </div>
                      <div class="book-shadow"></div>
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
                        <el-button type="primary" @click="openLink(book.purchaseUrl)" class="glow-btn">
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
              <el-card header="📦 快速部署（4 步启动）" class="info-card glass-effect">
                <div class="deploy-steps">
                  <div
                    v-for="(step, index) in deploySteps"
                    :key="index"
                    class="step-item"
                    :style="{ animationDelay: `${index * 0.1}s` }"
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
                    <div class="step-connector" v-if="index < deploySteps.length - 1">
                      <el-icon><ArrowDown /></el-icon>
                    </div>
                  </div>
                </div>
              </el-card>
            </el-col>
          </el-row>

          <!-- 常见问题 -->
          <el-row :gutter="20" style="margin-top: 20px;">
            <el-col :xs="24" :md="24">
              <el-card header="🐛 常见问题排查" class="info-card glass-effect">
                <div class="faq-grid">
                  <div
                    v-for="(faq, index) in faqs"
                    :key="index"
                    class="faq-item"
                    @click="toggleFaq(index)"
                    :class="{ 'expanded': expandedFaq === index }"
                  >
                    <div class="faq-question">
                      <span class="faq-number">{{ index + 1 }}</span>
                      <span>{{ faq.question }}</span>
                      <el-icon class="faq-icon">
                        <component :is="expandedFaq === index ? 'ArrowUp' : 'ArrowDown'" />
                      </el-icon>
                    </div>
                    <transition name="expand">
                      <div v-show="expandedFaq === index" class="faq-answer">
                        <div class="answer-block">
                          <span class="answer-label cause">原因：</span>
                          <p>{{ faq.cause }}</p>
                        </div>
                        <div class="answer-block">
                          <span class="answer-label solution">解决方案：</span>
                          <p>{{ faq.solution }}</p>
                        </div>
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
        <el-card class="author-card glass-effect">
          <div class="author-bg-decoration">
            <div class="author-orb"></div>
          </div>
          <div class="author-content">
            <div class="author-avatar">
              <div class="avatar-placeholder">
                <el-icon><UserFilled /></el-icon>
                <div class="avatar-ring"></div>
              </div>
            </div>
            <div class="author-info">
              <h2>{{ author.name }}</h2>
              <p class="author-title">{{ author.title }}</p>
              <p class="author-desc">{{ author.description }}</p>
              <div class="author-tags">
                <el-tag v-for="tag in author.tags" :key="tag" size="small" effect="plain" class="author-tag">
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
                  class="author-link-btn"
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
        <el-card class="contact-card gradient-card">
          <div class="contact-bg-pattern"></div>
          <h3>📬 联系与合作</h3>
          <p>欢迎交流 RAG 技术、性能调优、企业私有化部署等话题</p>
          <div class="contact-methods">
            <div class="contact-item" v-for="contact in contacts" :key="contact.name">
              <div class="contact-icon-wrapper">
                <el-icon class="contact-icon"><component :is="contact.icon" /></el-icon>
              </div>
              <div class="contact-info">
                <span class="contact-label">{{ contact.name }}</span>
                <span class="contact-value">{{ contact.value }}</span>
              </div>
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
        class="back-to-top glow-btn"
        @click="scrollToTop"
      >
        <el-icon><ArrowUp /></el-icon>
      </el-button>
    </transition>
  </div>
</template>

<script setup lang="ts">
// 保持原有 script 不变，只优化样式
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
/* ==================== CSS 变量定义 ==================== */
.home-container {
  --primary-color: #409EFF;
  --primary-light: #66b1ff;
  --primary-dark: #337ecc;
  --success-color: #67C23A;
  --warning-color: #E6A23C;
  --danger-color: #F56C6C;
  --info-color: #909399;
  --text-primary: #1e293b;
  --text-secondary: #475569;
  --text-muted: #94a3b8;
  --bg-primary: #ffffff;
  --bg-secondary: #f8fafc;
  --bg-tertiary: #f1f5f9;
  --border-color: #e2e8f0;
  --shadow-sm: 0 1px 3px rgba(0, 0, 0, 0.05);
  --shadow-md: 0 4px 12px rgba(0, 0, 0, 0.08);
  --shadow-lg: 0 8px 30px rgba(0, 0, 0, 0.12);
  --shadow-xl: 0 20px 50px rgba(0, 0, 0, 0.15);
  --gradient-primary: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  --gradient-accent: linear-gradient(135deg, #409EFF 0%, #06b6d4 100%);
  --gradient-success: linear-gradient(135deg, #67C23A 0%, #52c41a 100%);
}

/* ==================== 容器与整体布局 ==================== */
.home-container {
  width: 100%;
  height: 100vh;
  overflow-y: auto;
  background: linear-gradient(180deg, #f8fafc 0%, #eef2f6 50%, #f1f5f9 100%);
  scroll-behavior: smooth;
  position: relative;
}

.home-container::before {
  content: '';
  position: fixed;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background-image:
    radial-gradient(circle at 20% 30%, rgba(64, 158, 255, 0.03) 0%, transparent 50%),
    radial-gradient(circle at 80% 70%, rgba(102, 126, 234, 0.03) 0%, transparent 50%);
  pointer-events: none;
  z-index: 0;
}

.main-content {
  max-width: 1280px;
  margin: 0 auto;
  padding: 24px 24px 60px;
  position: relative;
  z-index: 1;
}

/* ==================== 玻璃态效果 ==================== */
.glass-effect {
  background: rgba(255, 255, 255, 0.85);
  backdrop-filter: blur(20px);
  -webkit-backdrop-filter: blur(20px);
  border: 1px solid rgba(255, 255, 255, 0.6);
  box-shadow:
    0 8px 32px rgba(0, 0, 0, 0.08),
    inset 0 1px 0 rgba(255, 255, 255, 0.8);
}

/* ==================== 顶部横幅 ==================== */
.top-banner {
  background: var(--gradient-primary);
  color: white;
  padding: 14px 24px;
  position: sticky;
  top: 0;
  z-index: 1000;
  box-shadow: 0 4px 20px rgba(102, 126, 234, 0.3);
  overflow: hidden;
}

.top-banner::before {
  content: '';
  position: absolute;
  top: -50%;
  left: -50%;
  width: 200%;
  height: 200%;
  background: linear-gradient(
    45deg,
    transparent 30%,
    rgba(255, 255, 255, 0.1) 50%,
    transparent 70%
  );
  animation: shimmer 3s infinite;
}

@keyframes shimmer {
  0% { transform: translateX(-100%) rotate(45deg); }
  100% { transform: translateX(100%) rotate(45deg); }
}

.banner-content {
  max-width: 1280px;
  margin: 0 auto;
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 14px;
  font-size: 0.95rem;
  position: relative;
  z-index: 1;
}

.banner-icon {
  font-size: 1.3rem;
  animation: float 2s ease-in-out infinite;
}

@keyframes float {
  0%, 100% { transform: translateY(0); }
  50% { transform: translateY(-3px); }
}

.banner-text {
  font-weight: 500;
  letter-spacing: 0.3px;
}

.banner-tag {
  animation: pulse 2s ease-in-out infinite;
}

@keyframes pulse {
  0%, 100% { opacity: 1; transform: scale(1); }
  50% { opacity: 0.85; transform: scale(1.02); }
}

.banner-glow {
  position: absolute;
  bottom: 0;
  left: 0;
  right: 0;
  height: 1px;
  background: linear-gradient(90deg,
  transparent 0%,
  rgba(255, 255, 255, 0.5) 50%,
  transparent 100%
  );
}

/* ==================== Hero Section ==================== */
.hero-section {
  margin: 40px 0 50px;
  position: relative;
}

.hero-bg-decoration {
  position: absolute;
  top: -50%;
  left: 50%;
  transform: translateX(-50%);
  width: 800px;
  height: 800px;
  pointer-events: none;
  z-index: -1;
}

.hero-orb {
  position: absolute;
  border-radius: 50%;
  filter: blur(60px);
  opacity: 0.5;
  animation: orbFloat 8s ease-in-out infinite;
}

.orb-1 {
  width: 300px;
  height: 300px;
  background: rgba(64, 158, 255, 0.3);
  top: 10%;
  left: 10%;
  animation-delay: 0s;
}

.orb-2 {
  width: 200px;
  height: 200px;
  background: rgba(102, 126, 234, 0.3);
  top: 50%;
  right: 10%;
  animation-delay: -2s;
}

.orb-3 {
  width: 150px;
  height: 150px;
  background: rgba(118, 75, 162, 0.3);
  bottom: 10%;
  left: 30%;
  animation-delay: -4s;
}

@keyframes orbFloat {
  0%, 100% { transform: translate(0, 0) scale(1); }
  25% { transform: translate(20px, -20px) scale(1.05); }
  50% { transform: translate(-10px, 20px) scale(0.95); }
  75% { transform: translate(-20px, -10px) scale(1.02); }
}

.hero-card {
  border-radius: 28px;
  padding: 56px 40px;
  text-align: center;
  position: relative;
  overflow: hidden;
}

.hero-card::before {
  content: '';
  position: absolute;
  top: 0;
  left: 0;
  right: 0;
  height: 5px;
  background: linear-gradient(90deg,
  #409EFF 0%,
  #67C23A 25%,
  #E6A23C 50%,
  #F56C6C 75%,
  #409EFF 100%
  );
  background-size: 200% 100%;
  animation: gradientShift 4s ease infinite;
}

@keyframes gradientShift {
  0%, 100% { background-position: 0% 50%; }
  50% { background-position: 100% 50%; }
}

.hero-badge-group {
  display: flex;
  justify-content: center;
  gap: 10px;
  margin-bottom: 28px;
  flex-wrap: wrap;
}

.hero-badge {
  animation: fadeInUp 0.6s ease forwards;
  opacity: 0;
  font-weight: 500;
  padding: 6px 14px;
}

.badge-dot {
  display: inline-block;
  width: 6px;
  height: 6px;
  border-radius: 50%;
  background: currentColor;
  margin-right: 6px;
  animation: blink 2s ease-in-out infinite;
}

@keyframes blink {
  0%, 100% { opacity: 1; }
  50% { opacity: 0.5; }
}

.hero-title {
  font-size: clamp(2.2rem, 6vw, 4rem);
  font-weight: 800;
  letter-spacing: -0.03em;
  color: var(--text-primary);
  margin: 0 0 24px 0;
  line-height: 1.1;
}

.gradient-text {
  background: var(--gradient-accent);
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
  background-clip: text;
  display: block;
}

.title-subtitle {
  font-size: 0.6em;
  display: block;
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
  background-clip: text;
  margin-top: 8px;
}

.hero-subtitle {
  color: var(--text-secondary);
  font-size: 1.15rem;
  line-height: 2;
  margin-bottom: 44px;
  max-width: 750px;
  margin-left: auto;
  margin-right: auto;
}

.hero-subtitle strong {
  font-weight: 700;
}

.highlight-primary {
  color: var(--primary-color);
  background: linear-gradient(135deg, rgba(64, 158, 255, 0.15) 0%, rgba(64, 158, 255, 0.05) 100%);
  padding: 2px 8px;
  border-radius: 4px;
}

.highlight-secondary {
  color: var(--success-color);
  background: linear-gradient(135deg, rgba(103, 194, 58, 0.15) 0%, rgba(103, 194, 58, 0.05) 100%);
  padding: 2px 8px;
  border-radius: 4px;
}

.highlight-accent {
  color: #06b6d4;
  background: linear-gradient(135deg, rgba(6, 182, 212, 0.15) 0%, rgba(6, 182, 212, 0.05) 100%);
  padding: 2px 8px;
  border-radius: 4px;
}

.action-group {
  display: flex;
  gap: 16px;
  justify-content: center;
  flex-wrap: wrap;
}

.btn-primary {
  min-width: 200px;
  font-weight: 600;
  font-size: 1rem;
  padding: 14px 28px;
  background: var(--gradient-accent);
  border: none;
  box-shadow: 0 4px 15px rgba(64, 158, 255, 0.35);
  transition: all 0.3s ease;
}

.btn-primary:hover {
  transform: translateY(-3px);
  box-shadow: 0 8px 25px rgba(64, 158, 255, 0.45);
}

.glow-btn {
  position: relative;
  overflow: hidden;
}

.glow-btn::after {
  content: '';
  position: absolute;
  top: -50%;
  left: -50%;
  width: 200%;
  height: 200%;
  background: linear-gradient(
    45deg,
    transparent 30%,
    rgba(255, 255, 255, 0.3) 50%,
    transparent 70%
  );
  transform: rotate(45deg);
  transition: all 0.5s ease;
  opacity: 0;
}

.glow-btn:hover::after {
  opacity: 1;
  left: 100%;
}

.btn-secondary, .btn-tertiary {
  min-width: 200px;
  font-weight: 600;
  font-size: 1rem;
  padding: 14px 28px;
  transition: all 0.3s ease;
}

.btn-secondary:hover, .btn-tertiary:hover {
  transform: translateY(-2px);
}

/* ==================== 指标卡片 ==================== */
.metrics-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(260px, 1fr));
  gap: 24px;
  margin-bottom: 50px;
}

.metric-item {
  padding: 32px 28px;
  border-radius: 20px;
  text-align: center;
  transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
  animation: fadeInUp 0.6s ease forwards;
  opacity: 0;
  position: relative;
  overflow: hidden;
}

@keyframes fadeInUp {
  from {
    opacity: 0;
    transform: translateY(30px);
  }
  to {
    opacity: 1;
    transform: translateY(0);
  }
}

.metric-item:hover {
  transform: translateY(-8px) scale(1.02);
  box-shadow: var(--shadow-xl);
  border-color: var(--primary-color);
}

.metric-item::before {
  content: '';
  position: absolute;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background: linear-gradient(135deg,
  rgba(64, 158, 255, 0.05) 0%,
  transparent 50%,
  rgba(102, 126, 234, 0.05) 100%
  );
  opacity: 0;
  transition: opacity 0.4s ease;
}

.metric-item:hover::before {
  opacity: 1;
}

.metric-hover-glow {
  position: absolute;
  bottom: -50%;
  left: 50%;
  transform: translateX(-50%);
  width: 150px;
  height: 150px;
  background: radial-gradient(circle, rgba(64, 158, 255, 0.2) 0%, transparent 70%);
  opacity: 0;
  transition: opacity 0.4s ease;
}

.metric-item:hover .metric-hover-glow {
  opacity: 1;
}

.metric-icon-wrapper {
  position: relative;
  display: inline-block;
  margin-bottom: 16px;
}

.metric-icon {
  font-size: 3rem;
  position: relative;
  z-index: 1;
}

.metric-ring {
  position: absolute;
  top: 50%;
  left: 50%;
  transform: translate(-50%, -50%);
  width: 70px;
  height: 70px;
  border: 2px solid rgba(64, 158, 255, 0.2);
  border-radius: 50%;
  animation: ringPulse 2s ease-in-out infinite;
}

@keyframes ringPulse {
  0%, 100% { transform: translate(-50%, -50%) scale(1); opacity: 1; }
  50% { transform: translate(-50%, -50%) scale(1.2); opacity: 0.5; }
}

.m-value {
  font-size: 2.4rem;
  font-weight: 800;
  background: var(--gradient-accent);
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
  background-clip: text;
  line-height: 1.2;
  margin-bottom: 10px;
}

.m-title {
  font-weight: 600;
  color: var(--text-primary);
  margin-bottom: 8px;
  font-size: 1.1rem;
}

.m-desc {
  font-size: 0.875rem;
  color: var(--text-muted);
  line-height: 1.6;
}

/* ==================== 详情区块 ==================== */
.details-section {
  margin-top: 40px;
  scroll-margin-top: 100px;
}

.info-card {
  border-radius: 20px;
  transition: all 0.3s ease;
}

.info-card:hover {
  box-shadow: var(--shadow-lg);
}

.info-card :deep(.el-card__header) {
  background: linear-gradient(135deg, rgba(248, 250, 252, 0.8) 0%, rgba(241, 245, 249, 0.8) 100%);
  border-bottom: 1px solid var(--border-color);
  padding: 18px 24px;
}

.card-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.header-left {
  display: flex;
  align-items: center;
  gap: 10px;
}

.header-icon {
  font-size: 1.3rem;
}

.card-header span {
  font-weight: 700;
  font-size: 1.1rem;
  color: var(--text-primary);
}

/* ==================== 性能对比表 ==================== */
.table-container {
  overflow-x: auto;
  padding: 8px 0;
}

.stat-table {
  width: 100%;
  border-collapse: separate;
  border-spacing: 0;
}

.stat-table th {
  background: linear-gradient(135deg, rgba(64, 158, 255, 0.08) 0%, rgba(64, 158, 255, 0.02) 100%);
  padding: 14px 16px;
  font-weight: 600;
  color: var(--text-primary);
  font-size: 0.9rem;
  text-align: left;
}

.stat-table th:first-child {
  border-radius: 12px 0 0 0;
}

.stat-table th:last-child {
  border-radius: 0 12px 0 0;
}

.stat-table td {
  padding: 16px;
  border-bottom: 1px solid var(--border-color);
  font-size: 0.9rem;
}

.stat-table tbody tr:last-child td {
  border-bottom: none;
}

.stat-table tbody tr {
  transition: background 0.2s ease;
}

.stat-table tbody tr:hover {
  background: rgba(64, 158, 255, 0.04);
}

.metric-name {
  font-weight: 600;
  color: var(--text-primary);
  align-items: center;
  gap: 10px;
}

.row-indicator {
  width: 3px;
  height: 16px;
  background: var(--gradient-accent);
  border-radius: 2px;
  animation: indicatorGrow 0.5s ease forwards;
  transform-origin: bottom;
  transform: scaleY(0);
}

@keyframes indicatorGrow {
  to { transform: scaleY(1); }
}

.status-bad, .status-good {
  align-items: center;
  gap: 8px;
}

.status-dot {
  width: 8px;
  height: 8px;
  border-radius: 50%;
  flex-shrink: 0;
}

.status-dot.bad {
  background: var(--danger-color);
  box-shadow: 0 0 10px rgba(245, 108, 108, 0.5);
}

.status-dot.good {
  background: var(--success-color);
  box-shadow: 0 0 10px rgba(103, 194, 58, 0.5);
}

.improvement-badge {
  display: inline-block;
  padding: 4px 12px;
  background: linear-gradient(135deg, rgba(103, 194, 58, 0.15) 0%, rgba(103, 194, 58, 0.05) 100%);
  color: var(--success-color);
  border-radius: 20px;
  font-weight: 700;
  font-size: 0.85rem;
}

/* ==================== 技术栈标签 ==================== */
.tag-cloud {
  display: flex;
  flex-wrap: wrap;
  gap: 10px;
  padding: 8px 0;
}

.tech-tag {
  animation: fadeInScale 0.4s ease forwards;
  opacity: 0;
  transform: scale(0.9);
  font-weight: 500;
}

@keyframes fadeInScale {
  to {
    opacity: 1;
    transform: scale(1);
  }
}

.styled-divider {
  margin: 20px 0 !important;
}

.styled-divider :deep(.el-divider__text) {
  font-weight: 600;
  color: var(--text-primary);
}

.mini-tips {
  list-style: none;
  padding: 0;
  margin: 0;
}

.mini-tips li {
  display: flex;
  align-items: center;
  gap: 10px;
  padding: 10px 12px;
  margin-bottom: 8px;
  background: rgba(64, 158, 255, 0.04);
  border-radius: 10px;
  animation: slideInLeft 0.4s ease forwards;
  opacity: 0;
}

@keyframes slideInLeft {
  from {
    opacity: 0;
    transform: translateX(-20px);
  }
  to {
    opacity: 1;
    transform: translateX(0);
  }
}

.tip-icon {
  color: var(--success-color);
  font-size: 1rem;
  flex-shrink: 0;
}

.tip-text {
  color: var(--text-secondary);
  font-size: 0.9rem;
}

/* ==================== 规格网格 ==================== */
.spec-grid {
  display: grid;
  grid-template-columns: repeat(2, 1fr);
  gap: 14px;
  padding: 8px 0;
}

.spec-item {
  padding: 18px 14px;
  background: linear-gradient(135deg, rgba(248, 250, 252, 0.8) 0%, rgba(241, 245, 249, 0.8) 100%);
  border-radius: 14px;
  text-align: center;
  transition: all 0.3s ease;
  animation: fadeInUp 0.5s ease forwards;
  opacity: 0;
  border: 1px solid transparent;
}

.spec-item:hover {
  transform: translateY(-3px);
  border-color: rgba(64, 158, 255, 0.3);
  box-shadow: 0 4px 15px rgba(64, 158, 255, 0.1);
}

.spec-label {
  font-size: 0.8rem;
  color: var(--text-muted);
  margin-bottom: 6px;
  text-transform: uppercase;
  letter-spacing: 0.5px;
}

.spec-value {
  font-size: 1.25rem;
  font-weight: 700;
  color: var(--text-primary);
  margin-bottom: 4px;
}

.gradient-value {
  background: var(--gradient-accent);
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
  background-clip: text;
}

.spec-note {
  font-size: 0.75rem;
  color: var(--text-muted);
}

/* ==================== 样式化表格 ==================== */
.styled-table :deep(.el-table) {
  background: transparent;
}

.styled-table :deep(.el-table__header th) {
  background: linear-gradient(135deg, rgba(64, 158, 255, 0.08) 0%, rgba(64, 158, 255, 0.02) 100%);
  font-weight: 600;
}

.styled-table :deep(.el-table__row:hover) {
  background: rgba(64, 158, 255, 0.04);
}

/* ==================== 内存分配 ==================== */
.memory-allocation {
  padding: 16px 0;
}

.memory-bar {
  margin-bottom: 20px;
  animation: fadeInRight 0.5s ease forwards;
  opacity: 0;
}

@keyframes fadeInRight {
  from {
    opacity: 0;
    transform: translateX(-20px);
  }
  to {
    opacity: 1;
    transform: translateX(0);
  }
}

.memory-label {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 8px;
}

.component-name {
  font-weight: 600;
  color: var(--text-primary);
  font-size: 0.95rem;
}

.component-size {
  font-weight: 700;
  font-size: 0.9rem;
}

.memory-track {
  height: 28px;
  background: var(--bg-tertiary);
  border-radius: 14px;
  overflow: hidden;
  position: relative;
  box-shadow: inset 0 2px 4px rgba(0, 0, 0, 0.05);
}

.memory-fill {
  height: 100%;
  border-radius: 14px;
  display: flex;
  align-items: center;
  justify-content: flex-end;
  padding-right: 12px;
  transition: width 1s ease-out;
  position: relative;
  overflow: hidden;
}

.memory-fill::before {
  content: '';
  position: absolute;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background: linear-gradient(
    90deg,
    rgba(255, 255, 255, 0.2) 0%,
    transparent 50%,
    rgba(255, 255, 255, 0.1) 100%
  );
}

.memory-percent {
  color: white;
  font-weight: 700;
  font-size: 0.8rem;
  position: relative;
  z-index: 1;
  text-shadow: 0 1px 2px rgba(0, 0, 0, 0.2);
}

.memory-total {
  text-align: center;
  padding-top: 16px;
  margin-top: 16px;
  border-top: 1px dashed var(--border-color);
  font-size: 1rem;
  color: var(--text-secondary);
}

.total-value {
  font-weight: 800;
  color: var(--primary-color);
  font-size: 1.2rem;
  margin-left: 8px;
}

/* ==================== 技术详情 ==================== */
.tech-details {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
  gap: 24px;
  padding: 8px 0;
}

.tech-detail-item {
  padding: 24px;
  background: linear-gradient(135deg, rgba(248, 250, 252, 0.6) 0%, rgba(241, 245, 249, 0.6) 100%);
  border-radius: 16px;
  border: 1px solid var(--border-color);
  transition: all 0.3s ease;
  animation: fadeInUp 0.5s ease forwards;
  opacity: 0;
}

.tech-detail-item:hover {
  transform: translateY(-4px);
  box-shadow: var(--shadow-md);
  border-color: rgba(64, 158, 255, 0.3);
}

.tech-detail-header {
  display: flex;
  align-items: center;
  gap: 12px;
  margin-bottom: 14px;
}

.tech-icon {
  font-size: 1.8rem;
}

.tech-detail-header h4 {
  flex: 1;
  margin: 0;
  color: var(--text-primary);
  font-size: 1.05rem;
  font-weight: 600;
}

.tech-detail-desc {
  color: var(--text-secondary);
  font-size: 0.9rem;
  line-height: 1.7;
  margin-bottom: 16px;
}

.tech-detail-features {
  display: flex;
  flex-wrap: wrap;
  gap: 8px;
}

.feature-tag {
  display: inline-flex;
  align-items: center;
  gap: 4px;
  padding: 5px 12px;
  background: var(--bg-primary);
  border-radius: 16px;
  font-size: 0.8rem;
  color: var(--text-secondary);
  border: 1px solid var(--border-color);
  transition: all 0.2s ease;
}

.feature-tag:hover {
  background: rgba(64, 158, 255, 0.1);
  border-color: var(--primary-color);
  color: var(--primary-color);
}

.feature-tag .el-icon {
  font-size: 0.75rem;
  color: var(--success-color);
}

/* ==================== 仓库 & 博客列表 ==================== */
.repo-list, .blog-list {
  display: flex;
  flex-direction: column;
  gap: 14px;
  padding: 8px 0;
}

.repo-item, .blog-item {
  display: flex;
  align-items: flex-start;
  gap: 14px;
  padding: 16px;
  background: linear-gradient(135deg, rgba(248, 250, 252, 0.6) 0%, rgba(241, 245, 249, 0.6) 100%);
  border-radius: 14px;
  border: 1px solid var(--border-color);
  transition: all 0.3s ease;
  animation: fadeInRight 0.5s ease forwards;
  opacity: 0;
}

.repo-item:hover, .blog-item:hover {
  border-color: var(--primary-color);
  background: var(--bg-primary);
  transform: translateX(4px);
  box-shadow: 0 4px 15px rgba(64, 158, 255, 0.1);
}

.repo-icon, .blog-icon {
  width: 44px;
  height: 44px;
  border-radius: 12px;
  display: flex;
  align-items: center;
  justify-content: center;
  flex-shrink: 0;
  font-size: 1.2rem;
}

.repo-icon {
  background: var(--gradient-accent);
  color: white;
}

.blog-icon {
  background: linear-gradient(135deg, #E6A23C 0%, #f59e0b 100%);
  color: white;
}

.repo-info h4, .blog-info h4 {
  margin: 0 0 6px 0;
  color: var(--text-primary);
  font-size: 1rem;
  font-weight: 600;
}

.repo-info p, .blog-info p {
  margin: 0 0 10px 0;
  color: var(--text-secondary);
  font-size: 0.85rem;
  line-height: 1.6;
}

.repo-meta, .blog-meta {
  display: flex;
  align-items: center;
  gap: 14px;
  font-size: 0.8rem;
  color: var(--text-muted);
}

.repo-stars {
  display: flex;
  align-items: center;
  gap: 4px;
  color: #f59e0b;
  font-weight: 600;
}

.repo-btn, .blog-btn {
  margin-left: auto;
  flex-shrink: 0;
}

/* ==================== 书籍展示 ==================== */
.book-showcase {
  display: flex;
  flex-direction: column;
  gap: 28px;
  padding: 8px 0;
}

.book-cover {
  display: flex;
  gap: 28px;
  padding: 24px;
  background: linear-gradient(135deg, rgba(248, 250, 252, 0.6) 0%, rgba(241, 245, 249, 0.6) 100%);
  border-radius: 20px;
  border: 1px solid var(--border-color);
  transition: all 0.3s ease;
}

.book-cover:hover {
  transform: translateY(-4px);
  box-shadow: var(--shadow-lg);
}

.book-image {
  flex-shrink: 0;
  position: relative;
}

.book-placeholder {
  width: 170px;
  height: 230px;
  background: var(--gradient-primary);
  border-radius: 10px;
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  color: white;
  box-shadow:
    0 10px 30px rgba(102, 126, 234, 0.3),
    inset 0 1px 0 rgba(255, 255, 255, 0.2);
  position: relative;
  z-index: 1;
}

.book-shadow {
  position: absolute;
  bottom: -10px;
  left: 10%;
  width: 80%;
  height: 20px;
  background: radial-gradient(ellipse, rgba(0, 0, 0, 0.2) 0%, transparent 70%);
  filter: blur(8px);
}

.book-icon {
  font-size: 3.5rem;
  margin-bottom: 14px;
}

.book-title {
  font-size: 0.85rem;
  text-align: center;
  padding: 0 16px;
  line-height: 1.4;
  font-weight: 500;
}

.book-info {
  flex: 1;
  display: flex;
  flex-direction: column;
}

.book-info h3 {
  margin: 0 0 10px 0;
  color: var(--text-primary);
  font-size: 1.35rem;
  font-weight: 700;
}

.book-subtitle {
  color: var(--primary-color);
  font-weight: 500;
  margin-bottom: 14px;
  font-size: 1rem;
}

.book-desc {
  color: var(--text-secondary);
  font-size: 0.9rem;
  line-height: 1.8;
  margin-bottom: 18px;
  flex: 1;
}

.book-meta {
  display: flex;
  gap: 24px;
  margin-bottom: 18px;
  font-size: 0.85rem;
  color: var(--text-muted);
  flex-wrap: wrap;
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

/* ==================== 部署步骤 ==================== */
.deploy-steps {
  display: flex;
  flex-direction: column;
  gap: 18px;
  padding: 8px 0;
}

.step-item {
  display: flex;
  gap: 18px;
  padding: 20px;
  background: linear-gradient(135deg, rgba(248, 250, 252, 0.6) 0%, rgba(241, 245, 249, 0.6) 100%);
  border-radius: 16px;
  border: 1px solid var(--border-color);
  transition: all 0.3s ease;
  animation: fadeInUp 0.5s ease forwards;
  opacity: 0;
  position: relative;
}

.step-item:hover {
  border-color: rgba(64, 158, 255, 0.3);
  box-shadow: 0 4px 15px rgba(64, 158, 255, 0.1);
}

.step-number {
  width: 42px;
  height: 42px;
  border-radius: 50%;
  background: var(--gradient-accent);
  color: white;
  display: flex;
  align-items: center;
  justify-content: center;
  font-weight: 700;
  font-size: 1.1rem;
  flex-shrink: 0;
  box-shadow: 0 4px 15px rgba(64, 158, 255, 0.3);
}

.step-content {
  flex: 1;
}

.step-content h4 {
  margin: 0 0 8px 0;
  color: var(--text-primary);
  font-size: 1.05rem;
  font-weight: 600;
}

.step-content p {
  margin: 0 0 12px 0;
  color: var(--text-secondary);
  font-size: 0.9rem;
}

.step-code {
  display: flex;
  align-items: center;
  gap: 12px;
  background: linear-gradient(135deg, #1e1e2e 0%, #2d2d44 100%);
  padding: 14px 16px;
  border-radius: 10px;
  overflow-x: auto;
  border: 1px solid rgba(255, 255, 255, 0.1);
}

.step-code code {
  color: #a6e3a1;
  font-family: 'JetBrains Mono', 'Consolas', 'Monaco', monospace;
  font-size: 0.85rem;
  flex: 1;
  white-space: nowrap;
}

.copy-btn {
  color: #89b4fa;
  flex-shrink: 0;
  transition: all 0.2s ease;
}

.copy-btn:hover {
  color: white;
  background: rgba(255, 255, 255, 0.1);
  border-radius: 6px;
}

.step-connector {
  position: absolute;
  bottom: -24px;
  left: 20px;
  color: var(--text-muted);
  animation: bounce 1s ease-in-out infinite;
}

@keyframes bounce {
  0%, 100% { transform: translateY(0); }
  50% { transform: translateY(5px); }
}

/* ==================== FAQ ==================== */
.faq-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(420px, 1fr));
  gap: 14px;
  padding: 8px 0;
}

.faq-item {
  padding: 18px;
  background: linear-gradient(135deg, rgba(248, 250, 252, 0.6) 0%, rgba(241, 245, 249, 0.6) 100%);
  border-radius: 14px;
  border: 1px solid var(--border-color);
  cursor: pointer;
  transition: all 0.3s ease;
}

.faq-item:hover {
  border-color: rgba(64, 158, 255, 0.3);
  background: var(--bg-primary);
}

.faq-item.expanded {
  border-color: var(--primary-color);
  background: var(--bg-primary);
  box-shadow: 0 4px 15px rgba(64, 158, 255, 0.1);
}

.faq-question {
  display: flex;
  justify-content: space-between;
  align-items: center;
  font-weight: 600;
  color: var(--text-primary);
  gap: 12px;
}

.faq-number {
  display: inline-flex;
  align-items: center;
  justify-content: center;
  width: 24px;
  height: 24px;
  background: var(--gradient-accent);
  color: white;
  border-radius: 50%;
  font-size: 0.75rem;
  font-weight: 700;
  flex-shrink: 0;
}

.faq-icon {
  color: var(--primary-color);
  font-size: 1.2rem;
  flex-shrink: 0;
  transition: transform 0.3s ease;
}

.faq-answer {
  margin-top: 14px;
  padding-top: 14px;
  border-top: 1px dashed var(--border-color);
}

.answer-block {
  margin-bottom: 10px;
}

.answer-block:last-child {
  margin-bottom: 0;
}

.answer-label {
  display: inline-block;
  padding: 3px 10px;
  border-radius: 6px;
  font-size: 0.8rem;
  font-weight: 600;
  margin-right: 8px;
}

.answer-label.cause {
  background: rgba(245, 108, 108, 0.1);
  color: var(--danger-color);
}

.answer-label.solution {
  background: rgba(103, 194, 58, 0.1);
  color: var(--success-color);
}

.faq-answer p {
  display: inline;
  margin: 0;
  color: var(--text-secondary);
  font-size: 0.9rem;
  line-height: 1.7;
}

/* ==================== 作者区域 ==================== */
.author-section {
  margin-top: 60px;
}

.author-card {
  border-radius: 24px;
  overflow: hidden;
  position: relative;
}

.author-bg-decoration {
  position: absolute;
  top: -50%;
  right: -20%;
  width: 400px;
  height: 400px;
  pointer-events: none;
}

.author-orb {
  width: 100%;
  height: 100%;
  background: radial-gradient(circle, rgba(102, 126, 234, 0.15) 0%, transparent 70%);
  filter: blur(40px);
}

.author-card::before {
  content: '';
  display: block;
  height: 5px;
  background: var(--gradient-primary);
}

.author-content {
  display: flex;
  gap: 50px;
  padding: 50px;
  align-items: center;
  position: relative;
  z-index: 1;
}

.author-avatar {
  flex-shrink: 0;
}

.avatar-placeholder {
  width: 150px;
  height: 150px;
  border-radius: 50%;
  background: var(--gradient-primary);
  display: flex;
  align-items: center;
  justify-content: center;
  color: white;
  font-size: 4.5rem;
  box-shadow:
    0 10px 40px rgba(102, 126, 234, 0.4),
    inset 0 2px 0 rgba(255, 255, 255, 0.2);
  position: relative;
}

.avatar-ring {
  position: absolute;
  top: -8px;
  left: -8px;
  right: -8px;
  bottom: -8px;
  border: 2px solid rgba(102, 126, 234, 0.3);
  border-radius: 50%;
  animation: ringRotate 10s linear infinite;
}

@keyframes ringRotate {
  from { transform: rotate(0deg); }
  to { transform: rotate(360deg); }
}

.author-info {
  flex: 1;
}

.author-info h2 {
  margin: 0 0 10px 0;
  font-size: 2.2rem;
  color: var(--text-primary);
  font-weight: 800;
}

.author-title {
  color: var(--primary-color);
  font-weight: 500;
  margin-bottom: 18px;
  font-size: 1rem;
}

.author-desc {
  color: var(--text-secondary);
  line-height: 1.9;
  margin-bottom: 22px;
  font-size: 0.95rem;
}

.author-tags {
  display: flex;
  gap: 10px;
  flex-wrap: wrap;
  margin-bottom: 26px;
}

.author-tag {
  font-weight: 500;
}

.author-stats {
  display: flex;
  gap: 35px;
  margin-bottom: 26px;
  padding: 24px;
  background: linear-gradient(135deg, rgba(248, 250, 252, 0.8) 0%, rgba(241, 245, 249, 0.8) 100%);
  border-radius: 16px;
  border: 1px solid var(--border-color);
}

.stat-item {
  text-align: center;
}

.stat-value {
  font-size: 2rem;
  font-weight: 800;
  background: var(--gradient-accent);
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
  background-clip: text;
}

.stat-label {
  font-size: 0.85rem;
  color: var(--text-muted);
  margin-top: 6px;
}

.author-links {
  display: flex;
  gap: 12px;
  flex-wrap: wrap;
}

.author-link-btn {
  font-weight: 500;
  transition: all 0.3s ease;
}

.author-link-btn:hover {
  transform: translateY(-2px);
}

/* ==================== 联系区域 ==================== */
.contact-section {
  margin-top: 40px;
}

.contact-card {
  border-radius: 20px;
  text-align: center;
  padding: 40px;
  position: relative;
  overflow: hidden;
  border: none;
}

.gradient-card {
  background: var(--gradient-primary);
  color: white;
}

.contact-bg-pattern {
  position: absolute;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background-image:
    radial-gradient(circle at 20% 50%, rgba(255, 255, 255, 0.1) 0%, transparent 50%),
    radial-gradient(circle at 80% 50%, rgba(255, 255, 255, 0.1) 0%, transparent 50%);
  pointer-events: none;
}

.contact-card h3 {
  margin: 0 0 14px 0;
  font-size: 1.7rem;
  position: relative;
  z-index: 1;
}

.contact-card > p {
  color: rgba(255, 255, 255, 0.9);
  margin-bottom: 28px;
  font-size: 1rem;
  position: relative;
  z-index: 1;
}

.contact-methods {
  display: flex;
  justify-content: center;
  gap: 35px;
  flex-wrap: wrap;
  position: relative;
  z-index: 1;
}

.contact-item {
  display: flex;
  align-items: center;
  gap: 12px;
  font-size: 0.95rem;
  padding: 12px 20px;
  background: rgba(255, 255, 255, 0.1);
  border-radius: 12px;
  backdrop-filter: blur(10px);
  transition: all 0.3s ease;
}

.contact-item:hover {
  background: rgba(255, 255, 255, 0.2);
  transform: translateY(-3px);
}

.contact-icon-wrapper {
  width: 40px;
  height: 40px;
  border-radius: 10px;
  background: rgba(255, 255, 255, 0.2);
  display: flex;
  align-items: center;
  justify-content: center;
}

.contact-icon {
  font-size: 1.2rem;
  color: white;
}

.contact-info {
  display: flex;
  flex-direction: column;
  align-items: flex-start;
}

.contact-label {
  font-size: 0.75rem;
  color: rgba(255, 255, 255, 0.7);
  margin-bottom: 2px;
}

.contact-value {
  font-weight: 600;
  color: white;
}

/* ==================== 底部 spacer ==================== */
.bottom-spacer {
  height: 120px;
}

/* ==================== 回到顶部按钮 ==================== */
.back-to-top {
  position: fixed;
  bottom: 35px;
  right: 35px;
  z-index: 1000;
  box-shadow: 0 6px 20px rgba(0, 0, 0, 0.15);
  width: 50px;
  height: 50px;
  border: none;
  background: var(--gradient-accent);
  color: white;
  transition: all 0.3s ease;
}

.back-to-top:hover {
  transform: translateY(-4px);
  box-shadow: 0 10px 30px rgba(64, 158, 255, 0.4);
}

/* ==================== 动画 ==================== */
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
  transition: all 0.35s cubic-bezier(0.4, 0, 0.2, 1);
  overflow: hidden;
}

.expand-enter-from,
.expand-leave-to {
  max-height: 0;
  opacity: 0;
}

/* ==================== 移动端适配 ==================== */
@media (max-width: 768px) {
  .main-content {
    padding: 16px 16px 40px;
  }

  .top-banner {
    padding: 12px 16px;
  }

  .banner-content {
    flex-direction: column;
    gap: 8px;
    text-align: center;
  }

  .hero-card {
    padding: 40px 24px;
    border-radius: 20px;
  }

  .hero-title {
    font-size: 1.8rem;
  }

  .title-subtitle {
    font-size: 0.5em;
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
    gap: 14px;
  }

  .metric-item {
    padding: 24px 16px;
  }

  .m-value {
    font-size: 1.8rem;
  }

  .faq-grid {
    grid-template-columns: 1fr;
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

  .step-connector {
    display: none;
  }

  .spec-grid {
    grid-template-columns: 1fr;
  }

  .author-content {
    flex-direction: column;
    text-align: center;
    padding: 35px 24px;
    gap: 30px;
  }

  .author-stats {
    justify-content: center;
    gap: 25px;
    flex-wrap: wrap;
  }

  .author-links {
    justify-content: center;
  }

  .book-cover {
    flex-direction: column;
    align-items: center;
    text-align: center;
  }

  .book-placeholder {
    width: 130px;
    height: 180px;
  }

  .book-meta {
    justify-content: center;
  }

  .book-actions {
    justify-content: center;
  }

  .contact-methods {
    flex-direction: column;
    gap: 14px;
    align-items: center;
  }

  .contact-item {
    width: 100%;
    max-width: 300px;
    justify-content: center;
  }
}

@media (max-width: 480px) {
  .metrics-grid {
    grid-template-columns: 1fr;
  }

  .hero-badge-group {
    gap: 6px;
  }

  .hero-badge {
    font-size: 0.8rem;
    padding: 4px 10px;
  }

  .author-stats {
    gap: 15px;
    padding: 16px;
  }

  .stat-value {
    font-size: 1.5rem;
  }
}

/* ==================== 打印样式 ==================== */
@media print {
  .top-banner,
  .back-to-top,
  .action-group,
  .hero-bg-decoration,
  .author-bg-decoration {
    display: none !important;
  }

  .home-container {
    background: white;
  }

  .glass-effect {
    background: white;
    box-shadow: none;
    border: 1px solid #ddd;
  }
}
</style>
