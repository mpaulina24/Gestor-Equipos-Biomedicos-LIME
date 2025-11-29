<template>
  <div class="container mt-4 mb-5">

    <!-- Encabezado -->
    <div class="container mt-5">
      <h2 class="titulo-principal text-center">
        Traslado de Equipo
      </h2>
      <p class="text-muted small">
        Aquí se registran los traslados de equipos, modificando su sede, servicio y responsable
      </p>
    </div>

    <div class="card border-0 shadow-sm rounded-4 overflow-hidden">

      <!-- Header verde -->
      <div class="card-header custom-header text-white">
        <span class="fw-semibold">Modificación de información del equipo</span>
      </div>

      <div class="card-body tarjeta-verde">

        <!-- Mensaje de estado (éxito/error) -->
        <div v-if="statusMessage"
          :class="['alert', isError ? 'alert-danger' : 'alert-success', 'mb-4', 'rounded-3']" role="alert">
          {{ statusMessage }}
        </div>

        <!-- EQUIPO referencia (no editable) -->
        <div class="mb-4 p-3 tarjeta-verde rounded">
          <label class="form-label small fw-bold text-muted d-block">Equipo</label>
          <div class="fs-6">
            {{ equipo.nombre_equipo }},
            {{ equipo.marca }} —
            {{ equipo.modelo }}
          </div>
        </div>

        <!-- FORMULARIO -->
        <div class="row">

          <!-- CAMPO SEDE: AHORA UN SELECT -->
          <div class="col-md-4 mb-3">
            <label class="form-label small fw-bold text-muted">Sede</label>
            <select v-model="equipo.sede" class="form-select form-select-sm">
              <option value="" disabled>Seleccione una sede</option>
              <option v-for="sede in sedes" :key="sede" :value="sede">
                {{ sede }}
              </option>
            </select>
          </div>

          <!-- CAMPO SERVICIO: AHORA UN SELECT -->
          <div class="col-md-4 mb-3">
            <label class="form-label small fw-bold text-muted">Servicio</label>
            <select v-model="equipo.proceso" class="form-select form-select-sm">
              <option value="" disabled>Seleccione un servicio</option>
              <!-- La propiedad se mantiene como 'proceso' según el binding original -->
              <option v-for="servicio in servicios" :key="servicio" :value="servicio">
                {{ servicio }}
              </option>
            </select>
          </div>

          <!-- CAMPO RESPONSABLE (SE MANTIENE COMO INPUT) -->
          <div class="col-md-4 mb-3">
            <label class="form-label small fw-bold text-muted">Responsable</label>
            <input v-model="equipo.responsable" class="form-control form-control-sm" placeholder="Funcionario asignado" />
          </div>

        </div>

        <div class="col-md-12 mb-3">
          <label class="form-label small fw-bold text-muted">
            Justificación del traslado
          </label>
          <textarea v-model="justificacion" class="form-control form-control-sm" rows="3"
            placeholder="Escribe de forma breve el motivo de la modificación..."></textarea>
        </div>

        <!-- BOTONES -->
        <div class="d-flex justify-content-end pt-2">

          <button class="btn btn-success px-4 me-2" @click="guardarCambios">
            Guardar cambios
          </button>

          <router-link to="/equipos" class="btn btn-outline-secondary px-4">
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

// --- Nuevas variables para mensajes de estado ---
const statusMessage = ref(null);
const isError = ref(false);

const setStatus = (message, isErr = false) => {
  statusMessage.value = message;
  isError.value = isErr;
  // Opcional: ocultar el mensaje después de 5 segundos
  setTimeout(() => {
    statusMessage.value = null;
  }, 5000);
};


// --- Opciones de selección requeridas ---

// Opciones para la Sede
const sedes = ref([
  'Prado',
  'SIU',
  'San Vicente'
]);

// Opciones para el Servicio (usado en el campo 'proceso')
const servicios = ref([
  'LIME',
  'Centro de resonancia',
  'Fotodermatología',
  'Trasplantes GICIG',
  'Inmunodeficiencias Primarias',
  'Grupo Reproducción',
  'Patología',
  'Dermatopatología'
]);


// Cargar datos actuales
onMounted(async () => {
  try {
    const res = await axios.get(`http://127.0.0.1:8000/api/equipos/${route.params.id}/`);
    equipo.value = res.data;
  } catch (error) {
    console.error("Error cargando equipo:", error);
    setStatus("Error al cargar los datos del equipo.", true);
  }
});

// Guardar cambios con fecha y justificación
const guardarCambios = async () => {
  if (!justificacion.value.trim()) {
    setStatus("Por favor escribe una justificación antes de guardar.", true);
    return;
  }

  const payload = {
    // Los v-model ya aseguran que 'equipo.sede' y 'equipo.proceso' contienen los valores seleccionados
    sede: equipo.value.sede,
    proceso: equipo.value.proceso,
    responsable: equipo.value.responsable,
    justificacion: justificacion.value,
    fecha_edicion: new Date().toISOString().split("T")[0],
  };

  try {
    await axios.put(`http://127.0.0.1:8000/api/equipos/${route.params.id}/editar/`, payload);
    setStatus("✅ Cambios guardados correctamente", false);
    // Esperar un momento para que el usuario vea el mensaje de éxito antes de redirigir
    setTimeout(() => {
      router.push("/equipos");
    }, 3000);
  } catch (error) {
    console.error("Error guardando cambios:", error);

    if (error.response) {
      console.log(" Respuesta del servidor:", error.response.data);
      setStatus("Error del servidor: " + JSON.stringify(error.response.data), true);
    } else if (error.request) {
      console.log("No hubo respuesta del servidor:", error.request);
      setStatus("No hubo respuesta del servidor. Intente más tarde.", true);
    } else {
      console.log(" Error configurando petición:", error.message);
      setStatus(" Error desconocido: " + error.message, true);
    }
  }

};
</script>

<style scoped>
.custom-header {
  background-color: #28a745;
  /* Verde de éxito de Bootstrap */
}

.tarjeta-verde {
  background-color: #f8f9fa;
  /* Un gris claro para el fondo */
}
</style>