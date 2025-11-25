import { createRouter, createWebHistory } from 'vue-router'
import DashboardLayout from '@/layouts/DashboardLayout.vue'
import Estadisticas from '@/views/Estadisticas.vue'
import Equipos from '@/views/Equipos.vue'
import Home from '@/views/Home.vue'
import AgregarEquipo from '@/views/AgregarEquipo.vue'
import DetalleEquipo from '@/views/DetalleEquipo.vue'
import TrasladoEquipo from '@/views/TrasladoEquipo.vue'
import EditarEquipo from '@/views/EditarEquipo.vue'
import EquiposDesactivados from '@/views/EquiposDesactivados.vue' 
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
        path: '/equipos/desactivados',
        name: 'EquiposDesactivados',
        component: EquiposDesactivados // <-- Cambio a la variable importada
      },

      
      { 
        path: '/equipos/:id/modificar', 
        name: 'ModificarEquipo', 
        component: EditarEquipo, 
        props: true 
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
        path: '/equipos/:id/editar/',
        name: 'TrasladoEquipo',
        component: TrasladoEquipo,
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
