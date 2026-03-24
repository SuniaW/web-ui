import { createRouter, createWebHistory } from 'vue-router'

const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes: [
    {
      path: '/',
      component: () => {
        return import('../views/HomeView.vue')
      },
    },
    {
      path: '/chat/code',
      component: () => {
        return import('../views/AiChatBox.vue')
      },
    },
    {
      path: '/chat/rag',
      component: () => {
        return import('../views/RagChatBox.vue')
      },
      props: true,
    },
    {
      path: `/chat/topic/:id`,
      component: () => {
        return import('../views/ManualMd.vue')
      },
      props: true,
    },
  ],
})

export default router
