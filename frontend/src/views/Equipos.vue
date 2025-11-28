<template>
  <div class="container py-4">
    <h1 class="titulo-principal">Inventario de Equipos Médicos</h1>

    <div class="card shadow-sm mb-2">
    <div class="card-body">
    
    <!-- Buscador arriba -->
    <label class="form-label fw-bold small d-block">Buscar equipo</label>
    <div class="mb-3 small">
      <input
        v-model="busqueda"
        type="text"
        class="form-control form-control-sm"
        placeholder="Buscar equipo por servicio, nombre, marca, modelo, serie o códigos (IPS, Interno, ECRI)"
      />
    </div>

    <label class="form-label small fw-bold d-block  mt-4">
      Filtros combinados 
    </label>

    <!-- Filtros y botón agregar -->
    <div class="d-flex align-items-center gap-2 flex-wrap">
      
      <!-- Columna de filtros -->
      <div class="d-flex flex-column">
      <label class="form-label small d-block text-muted">Sede</label>
      <select v-model="filtroSede" class="form-select form-select-sm" style="width: 150px;">
        <option value="">Todas las sedes</option>
        <option value='Prado'>Prado</option>
        <option value='SIU'>SIU</option>
        <option value='San Vicente'>San Vicente</option>
      </select>
      </div>

      <div class="d-flex flex-column">
      <label class="form-label small d-block text-muted">Servicio</label>
      <select v-model="filtroServicio" class="form-select form-select-sm" style="width: 200px;">
        <option value="">Todos los servicios</option>
        <option value="LIME">LIME</option>
        <option value="Centro de resonancia">Centro de resonancia</option
        ><option value="Fotodermatología">Fotodermatología</option
        ><option value="Trasplantes GICIG">Trasplantes GICIG</option
        ><option value="Inmunodeficiencias Primarias">Inmunodeficiencias Primarias</option
        ><option value="Grupo Reproducción">Grupo Reproducción</option
        ><option value="Patología">Patología</option
        ><option value="Dermatopatología">Dermatopatología</option>
      </select>
      </div>

      <div class="d-flex flex-column">
      <label class="form-label small d-block text-muted">Clasificación Misional</label>
      <select v-model="filtroMisional" class="form-select form-select-sm" style="width: 150px;">
        <option value="">Todos</option>
        <option value="Docencia">Docencia</option>
        <option value="Investigación">Investigación</option
        ><option value="Extensión">Extensión</option>
      </select>
      </div>

      <div class="d-flex flex-column">
      <label class="form-label small d-block text-muted">Clasificación IPS</label>
      <select v-model="filtroIPS" class="form-select form-select-sm" style="width: 150px;">
        <option value="">Todos</option>
        <option value="IND">IND</option>
        <option value="BIO">BIO</option
        ><option value="GASES">GASES</option>
      </select>
      </div>

      <div class="d-flex flex-column">
      <label class="form-label small d-block text-muted">Clase de riesgo</label>
      <select v-model="filtroRiesgo" class="form-select form-select-sm" style="width: 150px;">
        <option value="">Todos</option>
        <option value="Clase I">Clase I</option>
        <option value="Clase IIa">Clase IIa</option
        ><option value="Clase IIb">Clase IIb</option
        ><option value="Clase III">Clase III</option
        ><option value="NI">NI</option>
      </select>
      </div>

      <div class="ms-auto">
        <button class="btn btn-success px-4 d-flex align-items-center gap-2" @click="agregarEquipo">
          <i class="bi bi-plus-lg"></i> Agregar Equipo
        </button>
      </div>
    
    </div>
  </div>
</div>

    

    <!-- Tabla de equipos -->
    <div class="table-scroll shadow-sm rounded  mt-4">
      <table class="table align-middle table-hover">
        <thead class="table-light encabezado-pequeno">
          <tr>
            <th class="text-center">SEDE / SERVICIO</th>
            <th class="text-center">EQUIPO</th>
            <th class="text-center">CÓDIGOS</th>
            <th class="text-center">RESPONSABLE / UBICACIÓN</th>
            <th class="text-center">CLASIFICACIÓN</th>
            <th class="text-center">INVIMA / RIESGO</th>
            <th class="text-center">ACCIONES</th>
          </tr>
        </thead>
        <tbody>
          <tr v-for="(equipo, index) in equiposFiltrados" :key="equipo.id">

            <td class="text-center text-secondary">
              <div class="info-inventario d-flex flex-column align-items-center gap-1">
              
                <div class="d-flex align-items-center gap-1">
                  <i class="bi bi-building"
                  data-bs-toggle="tooltip"
                  data-bs-placement="top"
                  title="Sede"></i>
                  <span>{{ equipo.sede }}</span>
                </div>
                <div class="d-flex align-items-center gap-1">
                  <span style="font-size: 0.70rem;">{{ equipo.servicio }}</span>
                </div>
              </div>
            </td>

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
                  <i class="bi-tag text-secondary"
                  data-bs-toggle="tooltip"
                  data-bs-placement="top"
                  title="Marca, modelo"></i>
                  <span>{{ equipo.marca }}</span>
                  <span v-if="equipo.marca && equipo.modelo">,</span>
                  <span>{{ equipo.modelo }}</span>
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


            <td class="text-center">
              <div class="d-flex flex-column align-items-center gap-1">
                <span
                  v-if="equipo.codigos.interno"
                  class="badge rounded-pill badge-verde-claro"
                  data-bs-toggle="tooltip"
                  title="Código Interno"
                >
                  {{ equipo.codigos.interno }}
                </span>

                <div class="d-flex justify-content-center gap-2">

                <span
                  v-if="equipo.codigos.ips"
                  class="badge rounded-pill bg-light text-dark"
                  data-bs-toggle="tooltip"
                  title="Código IPS"
                >
                  {{ equipo.codigos.ips }}
                </span>

                <span
                  v-if="equipo.codigos.ecri"
                  class="badge rounded-pill bg-light text-dark"
                  data-bs-toggle="tooltip"
                  title="Código ECRI"
                >
                  {{ equipo.codigos.ecri }}
                </span>
              </div>
              </div>
            </td>


            <td class="text-center">
              <div class="info-inventario d-flex flex-column align-items-center gap-1">
                <div class="d-flex align-items-center gap-1">
                  <i class="bi bi-person-circle text-success"></i>
                  <span>{{ equipo.responsable }}</span>
                </div>
                <div class="d-flex align-items-center gap-1">
                  <i class="bi bi-geo-alt text-secondary"></i>
                  <span>{{ equipo.ubicacion }}</span>
                </div>
              </div>
            </td>


            <td class="text-center">
              <div class="d-flex flex-column align-items-center gap-1">
                <span
                  v-if="equipo.clasificacion.clasif_misional"
                  class="badge rounded-pill badge-verde-claro"
                  data-bs-toggle="tooltip"
                  title="Misional"
                >
                  {{ equipo.clasificacion.clasif_misional }}
                </span>

                <div class="d-flex justify-content-center gap-2">

                <span
                  v-if="equipo.clasificacion.clasif_ips"
                  class="badge rounded-pill bg-light text-dark"
                  data-bs-toggle="tooltip"
                  title="IPS"
                >
                  {{ equipo.clasificacion.clasif_ips }}
                </span>                
              </div>
              </div>
            </td>

            <td class="text-center">
              <div class="d-flex flex-column align-items-center gap-1"> 
                <span
                  class="badge rounded-pill badge-verde-claro invima-text"
                  data-bs-toggle="tooltip"
                  data-bs-placement="top"
                  :title="equipo.invima"
                >
                  {{ equipo.invima }}
                </span>

                
                <span
                  v-if="equipo.clasificacion.clasif_riesgo"
                  class="badge rounded-pill bg-light text-dark"
                  data-bs-toggle="tooltip"
                  title="Niv. Riesgo"
                >
                  {{ equipo.clasificacion.clasif_riesgo }}
                </span>
              </div>
            </td>


            <td class="text-center align-items-center gap-1">
              
              <button 
              class="icon-btn" 
              title="Editar" 
              @click="modificarEquipo(equipo.id)"
              >
                <i class="bi bi-pencil-square"></i>
              </button>

              <button
                class="icon-btn"
                data-bs-toggle="tooltip"
                data-bs-placement="top"
                title="Traslado"
                @click="editarEquipo(equipo.id)"
              >
                <i class="bi bi-shuffle"></i>
              </button>

              <button
                class="icon-btn"
                data-bs-toggle="tooltip"
                data-bs-placement="top"
                title="Historial traslados"
                @click="verRegistroEdiciones(equipo.id)"
              >
                <i class="bi-journal-text"></i>
              </button>


              <button
                class="icon-btn"
                data-bs-toggle="tooltip"
                data-bs-placement="top"
                title="Dar de baja"
                @click="desactivarEquipo(equipo.id)"                >
                <i class="bi bi-eye-slash"></i>
              </button>

              <button class="btn-ver-mas" @click="verDetalles(equipo.id)">
                Ver más
              </button>
              

            </td>
          </tr>
        </tbody>
      </table>
    </div>

    <!-- Modal de registros de ediciones -->
    <div
      class="modal fade"
      id="modalRegistros"
      tabindex="-1"
      aria-labelledby="modalRegistrosLabel"
      aria-hidden="true"
      ref="modalElement"
    >
      <div class="modal-dialog modal-lg modal-dialog-centered">
        <div class="modal-content shadow border-0 rounded-4">
          <div class="modal-header bg-primary text-white">
            <h5 class="modal-title" id="modalRegistrosLabel">
              Historial de traslados — {{ equipoSeleccionado?.nombre_equipo || 'Equipo' }}
            </h5>
            <button
              type="button"
              class="btn-close btn-close-white"
              data-bs-dismiss="modal"
              aria-label="Cerrar"
            ></button>
          </div>

          <div class="modal-body">
            <div v-if="cargando" class="text-center py-3">
              <div class="spinner-border text-primary" role="status">
                <span class="visually-hidden">Cargando...</span>
              </div>
            </div>

            <div v-else-if="registros.length === 0" class="text-center text-muted py-3">
              No hay registros de traslados para este equipo.
            </div>

            <ul v-else class="list-group list-group-flush">
              <li
                v-for="registro in registros"
                :key="registro.id"
                class="list-group-item"
              >
                <p class="mb-1">
                <strong>📅 Fecha:</strong> {{ registro.fecha }}</p>

                <p class="mb-1">
                  <strong>📍 Sede: </strong>
                  <span class="text-muted">{{ registro.sede_anterior || 'N/A' }}</span>
                  →
                  <span class="text-success">{{ registro.sede_nueva || 'N/A' }}</span>
                </p>

                <p class="mb-1">
                  <strong>🏥 Servicio: </strong>
                  <span class="text-muted">{{ registro.servicio_anterior || 'N/A' }}</span>
                  →
                  <span class="text-success">{{ registro.servicio_nuevo || 'N/A' }}</span>
                </p>

                <p class="mb-1">
                  <strong>👤 Responsable: </strong>
                  <span class="text-muted">{{ registro.responsable_anterior || 'N/A' }}</span>
                  →
                  <span class="text-success">{{ registro.responsable_nuevo || 'N/A' }}</span>
                </p>

                <p class="mb-0">
                  <strong>📝 Justificación: </strong> {{ registro.justificacion }}
                </p>

              </li>
            </ul>
          </div>

          <div class="modal-footer">
            <button
              type="button"
              class="btn btn-secondary"
              data-bs-dismiss="modal"
            >
              Cerrar
            </button>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, computed, onMounted } from "vue";
import { useRouter } from "vue-router";
import axios from "axios";

const router = useRouter();

const busqueda = ref("");
const filtroSede = ref("");
const filtroServicio = ref("");
const filtroRiesgo = ref("");
const filtroIPS = ref("");
const filtroMisional = ref("");

// Lista de equipos
const equipos = ref([]);

// Llamada al backend
const cargarEquipos = async () => {
  try {
    const res = await axios.get("http://127.0.0.1:8000/api/equipos/");
    equipos.value = res.data.map((eq) => {      
      const [responsableRaw, ubicacionRaw] = (eq.responsable_ubicacion || "").split(",");
      const [nombre_equipoRaw, marcaRaw, modeloRaw, serieRaw] = (eq.equipo || "").split("/").map(s => s.trim()); 

      const codigoParts = (eq.codigos || "").split("/").map(s => s.trim()).filter(Boolean);
      const interno = codigoParts[0] || null;
      const ips = codigoParts[1] || null;
      const ecri = codigoParts[2] || null;

      const clasificacionParts = (eq.clasificacion || "").split("/").map(s => s.trim()).filter(Boolean);
      const clasif_misional = clasificacionParts[0] || null;
      const clasif_ips = clasificacionParts[1] || null;
      const clasif_riesgo = clasificacionParts[2] || null;

      return {
        id: eq.id,
        servicio: eq.proceso || "",
        sede: eq.sede || "",
        
        // el backend puede devolver 'equipo' (agrupado) o 'nombre_equipo' según tu serializer/ejemplos
        equipo: (eq.equipo && eq.equipo.trim()) || (eq.nombre_equipo && eq.nombre_equipo.trim()) || "Sin nombre",
        
        nombre_equipo: (nombre_equipoRaw || "").trim() || "Sin nombre",
        marca: (marcaRaw || "").trim() || "Sin marca",
        modelo: (modeloRaw || "").trim() || "Sin marca",
        serie: (serieRaw || "").trim() || "Sin serie",

        codigos: {
          interno,
          ips,
          ecri,
        },
        responsable: (responsableRaw || "").trim() || "No asignado",
        ubicacion: (ubicacionRaw || "").trim() || "Sin ubicación",
        clasificacion: {
          clasif_misional,
          clasif_ips,
          clasif_riesgo,
        },
        invima: eq.registro_invima || "N/A",
      };
    });
  } catch (error) {
    console.error("Error cargando equipos:", error);
  }
};

// onMounted: carga y arranca tooltips (con protección si bootstrap no existe)
onMounted(async () => {
  await cargarEquipos();

  if (window.bootstrap && window.bootstrap.Tooltip) {
    const tooltipTriggerList = document.querySelectorAll('[data-bs-toggle="tooltip"]');
    tooltipTriggerList.forEach((el) => new window.bootstrap.Tooltip(el));
  }

  if (modalElement.value && Modal) {
    modalInstance = new Modal(modalElement.value);
  }
});

// Computed para aplicar los filtros
const equiposFiltrados = computed(() => {
  return equipos.value.filter((eq) => {
    const texto = busqueda.value.toLowerCase();

    const codigosConcat = [eq.codigos?.interno, eq.codigos?.ips, eq.codigos?.ecri]
      .filter(Boolean)
      .join(" ")
      .toLowerCase();

    const coincideBusqueda =
      (eq.equipo || "").toLowerCase().includes(texto) ||
      codigosConcat.includes(texto) ||
      (eq.servicio || "").toLowerCase().includes(texto) ||
      ((eq.clasificacion.clasif_riesgo || "").toLowerCase().includes(texto));

    const coincideSede = !filtroSede.value || eq.sede === filtroSede.value;
    const coincideServicio = !filtroServicio.value || eq.servicio === filtroServicio.value;
    const coincideRiesgo = !filtroRiesgo.value || eq.clasificacion.clasif_riesgo === filtroRiesgo.value;
    const coincideIPS = !filtroIPS.value || eq.clasificacion.clasif_ips === filtroIPS.value;
    const coincideMisional = !filtroMisional.value || eq.clasificacion.clasif_misional === filtroMisional.value;

    return coincideBusqueda && coincideSede && coincideServicio && coincideRiesgo && coincideIPS && coincideMisional;
  });
});


const verDetalles = (id) => {
  router.push(`/equipos/${id}`);
};

const agregarEquipo = () => {
  router.push("/equipos/agregarEquipo");
};

const editarEquipo = (id) => {
  router.push(`/equipos/${id}/editar/`);
};

const modificarEquipo = (id) => {
  router.push(`/equipos/${id}/modificar`);
};

import { Modal } from "bootstrap"; //  importante para controlar el modal

const registros = ref([]);
const equipoSeleccionado = ref(null);
const modalElement = ref(null);
let modalInstance = null;
const cargando = ref(false);

const desactivarEquipo = async (id) => {
  if (confirm("¿Estás seguro de que quieres desactivar este equipo?")) {
    try {
      // Llama al endpoint de desactivación
      await axios.post(`http://127.0.0.1:8000/api/equipos/${id}/desactivar/`);
      
      // Actualiza la lista de equipos en el frontend
      await cargarEquipos(); 
      alert("Equipo desactivado correctamente.");
    } catch (error) {
      console.error("Error al desactivar el equipo:", error);
      alert("Hubo un error al intentar desactivar el equipo.");
    }
  }
};
const verRegistroEdiciones = async (id) => {
  try {
    cargando.value = true;
    equipoSeleccionado.value = equipos.value.find((e) => e.id === id);

    const res = await axios.get(`http://127.0.0.1:8000/api/equipos/${id}/ediciones/`);
    registros.value = res.data;

    // Mostrar modal
    if (!modalInstance) {
      modalInstance = new Modal(modalElement.value);
    }
    modalInstance.show();
  } catch (error) {
    console.error("Error al cargar los registros:", error);
  } finally {
    cargando.value = false;
  }
};

</script>

<style scoped>
.titulo-principal {
  color: var(--gris-oscuro);
  font-weight: 700;
}

.table-scroll {
  max-height: 500px;
  max-width: 1200px;
  overflow-y: auto;
  overflow-x: auto;
  border-radius: var(--radio-base);
}

.table {
  background-color: var(--blanco);
  border-radius: var(--radio-base);
  box-shadow: var(--sombra-suave);
}

.table th {
  color: var(--gris-oscuro);
  font-weight: 600;
}

.table td {
  vertical-align: middle;
  font-size: 0.95rem;
}

.filtro {
  min-width: 200px;
}


.icon-btn {
  border: none;
  background: none;
  color: #0d6efd;
  cursor: pointer;
}

.icon-btn:hover {
  color: #0a58ca;
}

.invima-text {
  max-width: 150px;
  white-space: nowrap;
  overflow: hidden;
  text-overflow: ellipsis;
  display: inline-block;
  cursor: pointer;
}

.btn-ver-mas {
  background-color: rgba(13, 110, 253, 0.1);
  color: #0d6efd;
  border: none;
  border-radius: 50px;
  font-size: 0.7rem;
  font-weight: 450;
  padding: 2px 6px;
  cursor: pointer;
  transition: 0.2s;
  white-space: nowrap;
}

.btn-ver-mas:hover {
  background-color: rgba(13, 110, 253, 0.2);
}


</style>
