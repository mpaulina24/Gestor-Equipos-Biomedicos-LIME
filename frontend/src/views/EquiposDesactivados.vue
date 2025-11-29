<template>
  <div class="container py-4">

    <!-- Título -->
    <h4 class="titulo-principal text-center fw-bold mb-2">
      Historial de Equipos dados de baja
    </h4>

    <div class="card border-0 shadow-sm rounded-4 p-3">

      <!-- Texto explicativo -->
      <p class="text-muted small mb-3">
        Estos equipos fueron dados de baja del inventario activo. Puede consultarlos y reactivarlos cuando sea necesario.
      </p>

      <!-- Buscador -->
      <div class="mb-3">
        <label class="form-label fw-bold small d-block">Buscar equipo dado de baja</label>
        <input
          v-model="busqueda"
          type="text"
          class="form-control form-control-sm"
          placeholder="Nombre del equipo, servicio, código interno…"
        />
      </div>

      <!-- Tabla -->
      <div class="table-scroll shadow-sm rounded">
        <table class="table align-middle table-hover mb-0">
          <thead class="table-light encabezado-pequeno">
            <tr>
              <th class="text-center">EQUIPO</th>
              <th class="text-center">CÓDIGO INTERNO</th>
              <th class="text-center">SERVICIO</th>
              <th class="text-center">ACCIONES</th>
            </tr>
          </thead>
          <tbody>
            <tr v-for="equipo in equiposFiltrados" :key="equipo.id">

              <td class="text-center">
              <div class="info-inventario d-flex flex-column align-items-center gap-1">
                <div class="d-flex align-items-center gap-1">
                  <i class="bi-card-text text-success"
                  data-bs-toggle="tooltip"
                  data-bs-placement="top"
                  title="Nombre"></i>
                  <span>{{ equipo.nombre_equipo }}</span>
                </div>
                <div class="d-flex align-items-center gap-1">
                  <i class="bi-upc text-muted"
                  data-bs-toggle="tooltip"
                  data-bs-placement="top"
                  title="Serie"></i>
                  <span> {{ equipo.serie || 'N/A' }}</span>
                </div>
                </div>
            </td>

              <!-- código -->
              <td class="text-center">
                <span
                  v-if="equipo.codigos?.interno"
                  class="badge rounded-pill badge-verde-claro"
                >
                  {{ equipo.codigos?.interno }}
                </span>
                <span v-else class="text-muted small">NI</span>
              </td>

              <!-- servicio -->
              <td class="text-center text-muted">
                <span class="small">{{ equipo.servicio || 'NI' }}</span>
              </td>

              <!-- acciones -->
              <td class="text-center">
                <button
                  class="icon-btn success"
                  title="Reactivar Equipo"
                  @click="activarEquipo(equipo.id)"
                >
                  <i class="bi bi-arrow-clockwise me-1"></i>
                  Reactivar
                </button>
              </td>


            </tr>
          </tbody>
        </table>
      </div>

    </div>

  </div>
</template>

<script setup>
import { ref, computed, onMounted } from "vue";
import axios from "axios";

const equiposDesactivados = ref([]);
const busqueda = ref("");

const cargarEquiposDesactivados = async () => {
  try {
    const res = await axios.get("http://127.0.0.1:8000/api/equipos/inactivos/");
    equiposDesactivados.value = res.data.map(eq => {
      const [nombre_equipoRaw, marcaRaw, modeloRaw, serieRaw] = (eq.equipo || "").split("/").map(s => s.trim()); 
      const codigoParts = (eq.codigos || "").split("/").map(s => s.trim()).filter(Boolean);
      const interno = codigoParts[0] || null;

      return {
        id: eq.id,
        nombre_equipo: nombre_equipoRaw || "Sin nombre",
        servicio: eq.proceso || "",
        serie: serieRaw || "",
        codigos: { interno },
      };
    });
  } catch (error) {
    console.error("Error cargando equipos dados de baja:", error);
  }
};

const activarEquipo = async (id) => {
  if (confirm("¿Seguro que quieres reactivar este equipo? Volverá al inventario principal.")) {
    try {
      await axios.post(`http://127.0.0.1:8000/api/equipos/${id}/activar/`);
      alert("Equipo reactivado correctamente.");
      await cargarEquiposDesactivados(); 
    } catch (error) {
      console.error("Error al reactivar el equipo:", error);
      alert("Hubo un error al intentar reactivar el equipo.");
    }
  }
};

const equiposFiltrados = computed(() => {
  const q = busqueda.value.toLowerCase();
  return equiposDesactivados.value.filter(e =>
    e.nombre_equipo?.toLowerCase().includes(q) ||
    e.servicio?.toLowerCase().includes(q) ||
    e.codigos?.interno?.toLowerCase().includes(q)
  );
});

onMounted(cargarEquiposDesactivados);
</script>

<style scoped>
.table-scroll {
  max-height: 400px;
  max-width: 1200px;
  overflow-y: auto;
  overflow-x: auto;
  border-radius: var(--radio-base);
}

.table-scroll {
  overflow-y: auto;
  overflow-x: hidden;
}


</style>