import { createRouter, createWebHistory } from 'vue-router'
import DashboardLayout from '@/layouts/DashboardLayout.vue'
import Estadisticas from '@/views/Estadisticas.vue'
import Equipos from '@/views/Equipos.vue'
import Home from '@/views/Home.vue'
import AgregarEquipo from '@/views/AgregarEquipo.vue'
import DetalleEquipo from '@/views/DetalleEquipo.vue'

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
        path: '/equipos/agregarEquipo',
        name: 'AgregarEquipo',
        component: AgregarEquipo
      },
      {
        path: '/equipos/:id',
        name: 'DetalleEquipo',
        component: DetalleEquipo,
        props: true
      },
      {
        path: '/',
        redirect: '/home' // Vista Inicial
      }
    ]
  }
]

const router = createRouter({
  history: createWebHistory(),
  routes
})

export default router
