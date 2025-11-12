import { createRouter, createWebHistory } from 'vue-router'
import DashboardLayout from '@/layouts/DashboardLayout.vue'
import Estadisticas from '@/views/Estadisticas.vue'
import Equipos from '@/views/Equipos.vue'
import Home from '@/views/Home.vue'

const routes = [
  {
    path: '/',
    component: DashboardLayout,
    children: [
      {
        path: '/home',
        name: 'Home',
        component: Home
      },
      {
        path: '/estadisticas',
        name: 'Estadisticas',
        component: Estadisticas
      },
      {
        path: '/equipos',
        name: 'Equipos',
        component: Equipos
      },
      {
        path: '/',
        redirect: '/home' // opcional, define la vista inicial
      }
    ]
  }
]

const router = createRouter({
  history: createWebHistory(),
  routes
})

export default router
