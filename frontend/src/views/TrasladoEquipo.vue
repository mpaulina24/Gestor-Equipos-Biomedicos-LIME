<template>
  <div class="container mt-5">
    <h2 class="titulo-principal text-center">Editar Responsable y Servicio</h2>

    <div class="card shadow mb-4">
      <div class="card-header custom-header text-white">
        Modificación de Información del Equipo
      </div>

      <div class="card-body">
        <!-- Mostrar información no editable -->
        <div class="mb-3">
          <label><strong>Equipo:</strong></label>
          <p class="form-control-plaintext">{{ equipo.nombre_equipo }}, {{ equipo.marca }} - {{ equipo.modelo }}</p>
        </div>

        <div class="row">

          <div class="col-md-4 mb-3">
            <label><strong>Sede</strong></label>
            <input v-model="equipo.sede" class="form-control" />
          </div>

          <div class="col-md-4 mb-3">
            <label><strong>Servicio</strong></label>
            <input v-model="equipo.proceso" class="form-control" />
          </div>

          <div class="col-md-4 mb-3">
            <label><strong>Responsable</strong></label>
            <input v-model="equipo.responsable" class="form-control" />
          </div>
        </div>

        <div class="col-md-12 mb-3">
          <label><strong>Justificación del traslado</strong></label>
          <textarea
            v-model="justificacion"
            class="form-control"
            rows="3"
            placeholder="Describe el motivo del cambio..."
          ></textarea>
        </div>

        <div class="text-end mt-3">
          <button class="btn btn-success" @click="guardarCambios">
            Guardar cambios
          </button>
          <router-link to="/equipos" class="btn btn-secondary ms-2">
            Cancelar
          </router-link>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, onMounted } from "vue";
import { useRoute, useRouter } from "vue-router";
import axios from "axios";

const route = useRoute();
const router = useRouter();
const equipo = ref({});
const justificacion = ref("");

// Cargar datos actuales
onMounted(async () => {
  try {
    const res = await axios.get(`http://127.0.0.1:8000/api/equipos/${route.params.id}/`);
    equipo.value = res.data;
  } catch (error) {
    console.error("Error cargando equipo:", error);
    alert("Error al cargar los datos del equipo");
  }
});

// Guardar cambios con fecha y justificación
const guardarCambios = async () => {
  if (!justificacion.value.trim()) {
    alert("Por favor escribe una justificación antes de guardar.");
    return;
  }

  const payload = {
    sede: equipo.value.sede,
    proceso: equipo.value.proceso,
    responsable: equipo.value.responsable,
    justificacion: justificacion.value,
    fecha_edicion: new Date().toISOString().split("T")[0],
  };

  try {
    await axios.put(`http://127.0.0.1:8000/api/equipos/${route.params.id}/editar/`, payload);
    alert("✅ Cambios guardados correctamente");
    router.push("/equipos");
  } catch (error) {
  console.error("Error guardando cambios:", error);

  if (error.response) {
    console.log("🔥 Respuesta del servidor:", error.response.data);
    alert("❌ Error del servidor: " + JSON.stringify(error.response.data));
  } else if (error.request) {
    console.log("📡 No hubo respuesta del servidor:", error.request);
    alert("❌ No hubo respuesta del servidor");
  } else {
    console.log("⚠️ Error configurando petición:", error.message);
    alert("❌ Error: " + error.message);
  }
}

};
</script>

<style scoped>
.custom-header {
  background-color: var(--verde-acento);
  font-weight: 600;
}
</style>
