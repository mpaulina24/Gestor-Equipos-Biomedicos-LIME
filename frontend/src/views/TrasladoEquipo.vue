<template>
  <div class="container mt-4 mb-5">

    <!-- Encabezado -->
    <div  class="container mt-5">
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

          
              <div class="col-md-4 mb-3">
                <label class="fw-semibold">Sede Multicentro</label>
                <select v-model="equipo.sede" class="form-select" required>
                  <option value="" disabled>Seleccione la Sede</option>
                  <option 
                    v-for="opcion in opcionesSede" 
                    :key="opcion.value" 
                    :value="opcion.value">
                    {{ opcion.label }}
                  </option>
                </select>
              </div>

              <div class="col-md-8 mb-3">
                <label class="fw-semibold">Proceso / Servicio</label>
                <div class="input-group">
                  <select 
                    v-model="equipo.proceso" 
                    class="form-select"
                    :disabled="mostrarNuevoServicio" 
                    required
                  >
                    <option value="" disabled>Seleccione un proceso</option>
                    <option 
                      v-for="servicio in serviciosDisponibles" 
                      :key="servicio" 
                      :value="servicio">
                      {{ servicio }}
                    </option>
                  </select>

                  <button 
                    class="btn custom-btn" 
                    type="button" 
                    @click="mostrarNuevoServicio = true"
                    v-if="!mostrarNuevoServicio">
                    + Nuevo Servicio
                  </button>
                </div>
              </div>



          <div class="col-md-4 mb-3">
            <label class="form-label small fw-bold text-muted">Responsable</label>
            <input
              v-model="equipo.responsable"
              class="form-control form-control-sm"
              placeholder="Funcionario asignado"
            />
          </div>

        </div>

        <div class="col-md-12 mb-3">
          <label class="form-label small fw-bold text-muted">
            Justificación del traslado
          </label>
          <textarea
            v-model="justificacion"
            class="form-control form-control-sm"
            rows="3"
            placeholder="Escribe de forma breve el motivo de la modificación..."
          ></textarea>
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
const opcionesSede = [ 
  { value: 'Prado', label: 'Prado' },
  { value: 'SIU', label: 'SIU' },
  { value: 'San Vicente', label: 'San Vicente' },
];

const serviciosDisponibles = [
  "LIME","Fotodermatología","Resonador","Oftalmología",
  "Trasplantes GICIG","Inmunodeficiencias Primarias","Grupo Reproducción","Patología","Dermatopatología"
];
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
    alert(" Cambios guardados correctamente");
    router.push("/equipos");
  } catch (error) {
  console.error("Error guardando cambios:", error);

  if (error.response) {
    console.log(" Respuesta del servidor:", error.response.data);
    alert(" Error del servidor: " + JSON.stringify(error.response.data));
  } else if (error.request) {
    console.log(" No hubo respuesta del servidor:", error.request);
    alert(" No hubo respuesta del servidor");
  } else {
    console.log(" Error configurando petición:", error.message);
    alert(" Error: " + error.message);
  }
}

};
</script>
