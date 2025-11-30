<template>
  <nav class="sidenav sidebar-small">
    <!-- Header con el logo -->
    <div class="sidenav-header">
      <img src="@/assets/LIME.png" alt="Logo LIME" class="navbar-brand-img" />
    </div>

    <!-- Menú -->
    <ul class="navbar-nav">
      <li class="nav-item">
        <router-link to="/home" class="nav-link" :class="{ active: isActive('/home') }">
          <i class="bi bi-house-door"></i>
          <span class="nav-link-text">Inicio</span>
        </router-link>
      </li>

      <li class="nav-item">
        <router-link to="/estadisticas" class="nav-link" :class="{ active: isActive('/estadisticas') }">
          <i class="bi bi-bar-chart-line"></i>
          <span class="nav-link-text">Dashboard</span>
        </router-link>
      </li>

      <li class="nav-item">
        <router-link to="/equipos" class="nav-link" :class="{ active: isActive('/equipos') }">
          <i class="bi-list-ul"></i>
          <span class="nav-link-text">Equipos</span>
        </router-link>
      </li>

      <li class="nav-item">
        <router-link to="/equiposDadosDeBaja" class="nav-link" :class="{ active: isActive('equiposDadosDeBaja') }">
          <i class="bi bi-eye-slash"></i>
          <span class="nav-link-text">Equipos dados de baja</span>
        </router-link>
      </li>
      
      <!-- Gestión de Usuarios solo para Admin -->
      <li class="nav-item" v-if="authStore.isAdmin">
        <router-link to="/gestion-usuarios" class="nav-link" :class="{ active: isActive('/gestion-usuarios') }">
          <i class="bi bi-people"></i>
          <span class="nav-link-text">Gestión de Usuarios</span>
        </router-link>
      </li>
    </ul>

    <!-- Información del usuario y logout -->
    <div class="sidebar-footer">
      

      <div class="footer-devs mt-3">
        Programado por
        <a href="https://github.com/mpaulina24" target="_blank" rel="noopener noreferrer">
          MariaPaulinaArias
        </a>,
        <a href="https://github.com/DaFeTaCo" target="_blank" rel="noopener noreferrer">
          DanielTamayo
        </a>
        y
        <a href="https://github.com/SantiagoTabaresO" target="_blank" rel="noopener noreferrer">
          SantiagoTabares
        </a>
      </div>
    </div>
  </nav>
</template>

<script setup>
import { onMounted } from 'vue'
import { useRouter } from 'vue-router'
import { useAuthStore } from '@/stores/auth'

const router = useRouter()
const authStore = useAuthStore()

const handleLogout = () => {
  console.log('Ejecutando logout...')
  authStore.logout()
  // No necesitamos router.push porque el logout ya redirige
}

const isActive = (route) => {
  return router.currentRoute.value.path.includes(route)
}

// Asegurarse de que el store se cargue correctamente al montar
onMounted(() => {
  authStore.loadFromStorage()
})
</script>

<style scoped>
@import url("https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600&display=swap");

.sidenav {
  font-family: "Inter", sans-serif;
  position: fixed;
  left: 0;
  top: 0;
  height: 100vh;
  width: 230px;
  background-color: #ffffff;
  box-shadow: 2px 0 8px rgba(0, 0, 0, 0.1);
  padding-top: 1.5rem;
  display: flex;
  flex-direction: column;
  overflow-y: auto;
  transition: width 0.3s ease-in-out, box-shadow 0.3s ease-in-out;
  z-index: 1100;
}

/* --- Logo --- */
.sidenav-header {
  text-align: center;
  margin-bottom: 2rem;
}

.navbar-brand-img {
  width: 160px;
  height: auto;
  transition: transform 0.3s ease;
}

.navbar-brand-img:hover {
  transform: scale(1.05);
}

/* --- Menú --- */
.navbar-nav {
  list-style: none;
  padding: 0;
  margin: 0;
}

.nav-item {
  margin: 0.3rem 0;
}

.nav-link {
  display: flex;
  align-items: center;
  gap: 12px;
  color: #333;
  font-weight: 500;
  padding: 0.7rem 1.2rem;
  text-decoration: none;
  border-radius: 6px;
  transition: all 0.3s ease;
}

.nav-link:hover {
  background-color: rgba(0, 128, 255, 0.1);
  color: #0056b3;
  transform: scale(1.02);
}

.nav-link.active {
  background-color: rgba(0, 128, 255, 0.2);
  color: #0056b3;
  font-weight: 600;
}

/* --- Footer integrado --- */
.sidebar-footer {
  margin-top: auto;
  padding: 1rem;
  border-top: 1px solid #e5e7eb;
  text-align: center;
  font-size: 0.8rem;
  color: #6c757d;
}

.footer-links {
  margin-bottom: 0.5rem;
}

.udea-link {
  font-weight: 600;
  color: #007bff;
  text-decoration: none;
}

.udea-link:hover {
  text-decoration: underline;
}

.footer-devs a {
  color: #007bff;
  text-decoration: none;
}

.footer-devs a:hover {
  text-decoration: underline;
}

/* --- Responsivo --- */
@media (max-width: 768px) {
  .sidenav {
    width: 190px;
  }

  .navbar-brand-img {
    width: 120px;
  }

  .nav-link {
    font-size: 0.9rem;
  }

  .sidebar-footer {
    font-size: 0.7rem;
  }
}
</style>
