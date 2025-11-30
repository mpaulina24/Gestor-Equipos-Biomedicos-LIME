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
                  class="badge rounded-pill bg-light text-dark"
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
                <!-- Botón Reactivar - Solo para admins -->
                <button
                  v-if="authStore.isAdmin"
                  class="icon-btn success me-1"
                  title="Reactivar Equipo"
                  @click="activarEquipo(equipo.id)"
                >
                  <i class="bi bi-arrow-clockwise me-1"></i>
                  Reactivar
                </button>
                
                <!-- Mensaje para usuarios viewer -->
                <span v-else class="text-muted small me-2">Solo lectura</span>

                <!-- Botón Información - Disponible para todos -->
                <button
                  class="icon-btn info"
                  title="Ver detalles de desactivación"
                  @click="verDetallesDesactivacion(equipo)"
                >
                  <i class="bi bi-info-circle"></i>
                </button>
              </td>

            </tr>
          </tbody>
        </table>
      </div>

    </div>

    <!-- Modal para ver detalles de desactivación -->
    <div class="modal fade" id="modalDetallesDesactivacion" tabindex="-1" aria-labelledby="modalDetallesDesactivacionLabel" aria-hidden="true" ref="modalDetallesDesactivacionElement">
      <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content shadow border-0 rounded-4">
          <div class="modal-header bg-verde-desactivacion text-white">
            <h5 class="modal-title" id="modalDetallesDesactivacionLabel">
              <i class="bi bi-info-circle me-2"></i>
              Detalles de Desactivación
            </h5>
            <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
          </div>
          <div class="modal-body">
            <div v-if="equipoDesactivacionSeleccionado">
              <h6 class="fw-bold">Equipo</h6>
              <p>{{ equipoDesactivacionSeleccionado.nombre_equipo }}</p>

              <h6 class="fw-bold">Fecha de Desactivación</h6>
              <p>{{ new Date(equipoDesactivacionSeleccionado.infoDesactivacion.fecha_desactivacion).toLocaleDateString() }}</p>

              <h6 class="fw-bold">Responsable</h6>
              <p>{{ equipoDesactivacionSeleccionado.infoDesactivacion.responsable_desactivacion }}</p>

              <h6 class="fw-bold">Justificación</h6>
              <p>{{ equipoDesactivacionSeleccionado.infoDesactivacion.justificacion }}</p>
            </div>
          </div>
          <div class="modal-footer">
            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cerrar</button>
          </div>
        </div>
      </div>
    </div>

  </div>
</template>

<script setup>
import { ref, computed, onMounted } from "vue";
import axios from "axios";
import { Modal } from "bootstrap";
import { useAuthStore } from '@/stores/auth'

// Store de autenticación
const authStore = useAuthStore();

const equiposDesactivados = ref([]);
const busqueda = ref("");

// Variables para el modal de detalles de desactivación
const equipoDesactivacionSeleccionado = ref(null);
const modalDetallesDesactivacionElement = ref(null);
let modalDetallesDesactivacionInstance = null;

const cargarEquiposDesactivados = async () => {
  try {
    const res = await axios.get("http://127.0.0.1:8000/api/equipos/inactivos/");
    equiposDesactivados.value = await Promise.all(
      res.data.map(async (eq) => {
        const [nombre_equipoRaw, marcaRaw, modeloRaw, serieRaw] = (eq.equipo || "").split("/").map(s => s.trim()); 
        const codigoParts = (eq.codigos || "").split("/").map(s => s.trim()).filter(Boolean);
        const interno = codigoParts[0] || null;

        // Obtener información de desactivación
        let infoDesactivacion = null;
        try {
          const desactivacionRes = await axios.get(`http://127.0.0.1:8000/api/equipos/${eq.id}/desactivar-detalle/`);
          if (desactivacionRes.data && desactivacionRes.data.length > 0) {
            infoDesactivacion = desactivacionRes.data[0]; // Tomar la más reciente
          }
        } catch (error) {
          console.error("Error cargando información de desactivación:", error);
        }

        return {
          id: eq.id,
          nombre_equipo: nombre_equipoRaw || "Sin nombre",
          servicio: eq.proceso || "",
          serie: serieRaw || "",
          codigos: { interno },
          infoDesactivacion: infoDesactivacion
        };
      })
    );
  } catch (error) {
    console.error("Error cargando equipos desactivados:", error);
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

// Función para abrir el modal de detalles de desactivación
const verDetallesDesactivacion = (equipo) => {
  equipoDesactivacionSeleccionado.value = equipo;
  if (!modalDetallesDesactivacionInstance) {
    modalDetallesDesactivacionInstance = new Modal(modalDetallesDesactivacionElement.value);
  }
  modalDetallesDesactivacionInstance.show();
};

const equiposFiltrados = computed(() => {
  const q = busqueda.value.toLowerCase();
  return equiposDesactivados.value.filter(e =>
    e.nombre_equipo?.toLowerCase().includes(q) ||
    e.servicio?.toLowerCase().includes(q) ||
    e.codigos?.interno?.toLowerCase().includes(q)
  );
});

onMounted(() => {
  cargarEquiposDesactivados();

  // Inicializar modal de detalles de desactivación
  if (modalDetallesDesactivacionElement.value && Modal) {
    modalDetallesDesactivacionInstance = new Modal(modalDetallesDesactivacionElement.value);
  }
});
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

.icon-btn.success {
  color: #198754;
}

.icon-btn.success:hover {
  color: #146c43;
}

.icon-btn.info {
  color: #1B5E20;
}

.icon-btn.info:hover {
  color: #1B5E20;
}

.bg-verde-desactivacion {
background-color: #1B5E20 !important;
}

</style>
