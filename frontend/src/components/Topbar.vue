<template>
  <div class="top-bar">
    <div class="topbar-content">
      <div class="titulo-topbar">
        Sistema de Gestión de Equipos Médicos
      </div>
      <div class="titulo-topbar">
        <i class="bi bi-building-fill"></i> Universidad de Antioquia
      </div>
    </div>
  </div>
</template>

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
</style>
