<template>
  <div class="app-layout">
    <Sidebar />
    <div class="main-content">
      <router-view />
    </div>
  </div>
</template>

<script>
import Sidebar from "@/components/Sidebar.vue";

export default {
  name: "AppLayout",
  components: { Sidebar },
};
</script>

<style>

/* --- Layout general --- */
.app-layout {
  display: flex;
  min-height: 100vh;
  font-family: 'Roboto', sans-serif;
  background-color: #f8fafc;
}

/* --- Contenido principal --- */
.main-content {
  margin-left: 100px; /* 👈 asegúrate que coincida con el ancho del Sidebar */
  flex: 1;
  padding: 1.5rem;
}

</style>
