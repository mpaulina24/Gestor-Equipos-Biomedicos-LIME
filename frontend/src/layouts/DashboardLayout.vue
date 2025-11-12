<template>
  <div class="dashboard-layout">
    <Sidebar />
    <div class="main-container">
      <Topbar />
      <main class="main-content">
        <router-view />
      </main>
    </div>
  </div>
</template>

<script>
import Sidebar from '@/components/Sidebar.vue'
import Topbar from '@/components/Topbar.vue'


export default {
  name: 'DashboardLayout',
  components: { Topbar, Sidebar }
}
</script>

<style scoped>
.dashboard-layout {
  display: flex;
  min-height: 100vh;
  font-family: 'Lato', sans-serif; /* 👈 Fuente base */
  color: #333;
  background-color: #f8fafc;
}

/* Área principal */

.main-container {
  display: flex;
  flex-direction: column;
  flex: 1;
}

.main-content {
  flex: 1;
  padding: 2rem;
}

/* Títulos */
h1, h2, h3 {
  font-weight: 600;
  color: #1e293b;
}

/* Párrafos y texto */
p {
  line-height: 1.6;
  color: #475569;
}

/* Enlaces */
a {
  color: #007bff;
  text-decoration: none;
}

a:hover {
  text-decoration: underline;
}
</style>
