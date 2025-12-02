<template>
  <div class="top-bar d-flex justify-content-between">

    <div class="topbar-content">
      <div class="titulo-topbar">
        Sistema de Gestión de Equipos Médicos
      </div>
      <div class="titulo-topbar">
        <i class="bi bi-building-fill"></i> Universidad de Antioquia
      </div>
    </div>

    <div class="user-info" @click="toggleMenu" ref="menuButton">
      <strong class="text-white dropdown-toggle">
        @{{ authStore.userName }}
      </strong>
      <span class="badge ms-2"
        :class="authStore.isAdmin ? 'admin-badge' : 'viewer-badge' ">
        {{ authStore.isAdmin ? 'Administrador' : 'Visualizador' }}
      </span>

      <!-- MENU DESPLEGABLE -->
      <div 
        v-if="menuOpen"
        class="dropdown-menu show custom-menu"
        ref="menuPanel"
      >
        <button class="dropdown-item text-danger d-flex align-items-center" @click="handleLogout">
          <i class="bi bi-box-arrow-right me-2"></i>
          <span>Cerrar sesión</span>
        </button>

      </div>
    </div>

  </div>
</template>


<script setup>
import { useAuthStore } from "@/stores/auth";
import { ref, onMounted, onBeforeUnmount } from "vue";

const authStore = useAuthStore();
const menuOpen = ref(false);
const menuButton = ref(null);
const menuPanel = ref(null);

const toggleMenu = () => {
  menuOpen.value = !menuOpen.value;
};

const handleClickOutside = (event) => {
  if (
    menuOpen.value &&
    !menuButton.value.contains(event.target) &&
    (!menuPanel.value || !menuPanel.value.contains(event.target))
  ) {
    menuOpen.value = false;
  }
};

onMounted(() => {
  document.addEventListener("click", handleClickOutside);
});

onBeforeUnmount(() => {
  document.removeEventListener("click", handleClickOutside);
});

const handleLogout = () => {
  authStore.logout();
};
</script>


<style scoped>
.top-bar {
  position: fixed;
  top: 0;
  left: 0;
  right: 0;
  height: 60px;
  background-color: #1B5E20;
  z-index: 1000;
  display: flex;
  align-items: center;
}

.topbar-content {
  margin-left: 250px; /* deja espacio para el sidebar */
}

.user-info {
  position: relative;
  margin-right: 20px;
  display: inline-flex;
  align-items: center;
  gap: 6px;
}

.custom-menu {
  position: absolute;
  top: 100%;
  left: 50%;
  transform: translateX(-50%);
  margin-top: 6px;
  background: white;
  border-radius: 6px;
  min-width: 140px;
  box-shadow: 0px 3px 8px rgba(0, 0, 0, 0.15);
  z-index: 2000;
}


.dropdown-item {
  padding: 10px;
  font-size: 14px;
  cursor: pointer;
}

.dropdown-item:hover {
  background-color: #eee;
}



</style>
