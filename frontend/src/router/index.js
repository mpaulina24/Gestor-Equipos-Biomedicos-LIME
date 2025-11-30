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
import Login from '@/views/Login.vue'
import GestionUsuarios from '@/views/GestionUsuarios.vue'

const routes = [
  {
    path: '/login',
    name: 'Login',
    component: Login
  },
  {
    path: '/',
    component: DashboardLayout,
    meta: { requiresAuth: true },
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
        path: '/gestion-usuarios',
        name: 'GestionUsuarios',
        component: GestionUsuarios,
        meta: { requiresAdmin: true }
      },
      {
        path: '/equiposDadosDeBaja',
        name: 'EquiposDesactivados',
        component: EquiposDesactivados
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
        component: AgregarEquipo,
        meta: { requiresAdmin: true }
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
        props: true,
        meta: { requiresAdmin: true }
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

router.beforeEach((to, from, next) => {
  // Obtener datos del localStorage directamente para mayor confiabilidad
  const usuario = JSON.parse(localStorage.getItem('usuario') || '{}')
  const isAuthenticated = !!usuario.nombreusuario
  const isAdmin = usuario.rol === 'admin'
  
  console.log('Navegación:', to.path, 'Usuario:', usuario)
  
  if (to.meta.requiresAuth && !isAuthenticated) {
    console.log('Redirigiendo a login: requiere autenticación')
    next('/login')
  } else if (to.meta.requiresAdmin && !isAdmin) {
    console.log('Redirigiendo a home: requiere admin')
    next('/home')
  } else if (to.path === '/login' && isAuthenticated) {
    console.log('Redirigiendo a home: ya autenticado')
    next('/home')
  } else {
    console.log('Navegación permitida')
    next()
  }
})

export default router
