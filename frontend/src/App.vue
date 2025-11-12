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
  components: { Sidebar },
};
</script>

<style>
.app-layout {
  display: flex;
}

.main-content {
  margin-left: 220px; /* igual al ancho del sidebar */
  flex: 1;
  padding: 1rem;
}
</style>
