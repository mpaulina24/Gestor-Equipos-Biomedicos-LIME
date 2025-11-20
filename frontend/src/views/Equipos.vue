<template>
  <div class="container py-4">
    <h1 class="titulo-principal">Inventario de Equipos Médicos</h1>

    <div class="card shadow-sm mb-2">
  <div class="card-body">
    
    <!-- Buscador arriba -->
    <div class="mb-3">
      <input
        v-model="busqueda"
        type="text"
        class="form-control filtro"
        placeholder="Buscar por servicio, nombre, marca, modelo o código"
      />
    </div>

    <!-- Filtros y botón agregar abajo -->
    <div class="row align-items-center g-2">
      
      <!-- Columna de filtros -->
      <select v-model="filtroSede" class="form-select filtro w-auto">
        <option value="">Todas las sedes</option>
        <option value='Sede Prado'>Sede Prado</option>
        <option value='Sede 2'>Sede 2</option>
        <option value='Sede 3'>Sede 3</option>
      </select>

      <select v-model="filtroServicio" class="form-select filtro w-auto">
        <option value="">Todos los servicios</option>
        <option value="LIME">LIME</option>
        <option value="LIME - Hematología">LIME - Hematología</option>
        <option value="LIME - Citometría de Flujo">LIME - Citometría de Flujo</option>
        <option value="LIME - Almacén">LIME - Almacén</option>
        <option value="LIME - Atención a Pacientes">LIME - Atención a Pacientes</option
        ><option value="LIME - Biología Molecular">LIME - Biología Molecular</option
        ><option value="LIME - Microbiología">LIME - Microbiología</option
        ><option value="Centro de resonancia">Centro de resonancia</option
        ><option value="Fotodermatología">Fotodermatología</option
        ><option value="Trasplantes GICIG">Trasplantes GICIG</option
        ><option value="Inmunodeficiencias Primarias">Inmunodeficiencias Primarias</option
        ><option value="Grupo Reproducción">Grupo Reproducción</option
        ><option value="Patología">Patología</option
        ><option value="Dermatopatología">Dermatopatología</option>
      </select>

      <!-- Columna del botón -->
      <div class="col-md-3 justify-content-end">
        <button class="btn btn-success d-flex align-items-center justify-content-center gap-2" @click="agregarEquipo">
        <i class="bi bi-plus-lg"></i> Agregar
      </button>
      </div>
    </div>
  </div>
</div>

    <!-- Tabla de equipos -->
    <div class="table-responsive shadow-sm rounded">
      <table class="table align-middle table-hover">
        <thead class="table-light">
          <tr>
            <th class="text-center">ID</th>
            <th class="text-center">Servicio</th>
            <th class="text-center">Equipo</th>
            <th class="text-center">Códigos</th>
            <th class="text-center">Responsable / Ubicación</th>
            <th class="text-center">Clasificación</th>
            <th class="text-center">Registro Invima</th>
            <th class="text-center">Acciones</th>
          </tr>
        </thead>
        <tbody>
          <tr v-for="(equipo, index) in equiposFiltrados" :key="equipo.id">
            <td class="text-center">{{ index + 1 }}</td>
            <td class="text-center">{{ equipo.servicio }}</td>

            <td class="text-center">
              <div class="info-inventario d-flex flex-column align-items-center gap-1">
                <div class="d-flex align-items-center gap-1">
                  <i class="bi-card-text text-success"></i>
                  <span>{{ equipo.nombre_equipo }}</span>
                </div>
                <div class="d-flex align-items-center gap-1">
                  <i class="bi-tag text-secondary"></i>
                  <span>{{ equipo.marca }}</span>
                  <span>{{ equipo.modelo }}</span>
                </div>
                <div class="d-flex align-items-center gap-1">
                  <i class="bi-upc text-muted"></i>
                  <span class="small text-muted">Serie: {{ equipo.serie || 'N/A' }}</span>
                </div>
                </div>
            </td>


            <td class="text-center">
              <div class="d-flex flex-wrap justify-content-center gap-2">
                <span
                  v-if="equipo.codigos.interno"
                  class="badge rounded-pill bg-success"
                  data-bs-toggle="tooltip"
                  title="Código Interno"
                >
                  {{ equipo.codigos.interno }}
                </span>

                <span
                  v-if="equipo.codigos.ips"
                  class="badge rounded-pill bg-primary"
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
              <div class="d-flex flex-wrap justify-content-center gap-2">
                <span
                  v-if="equipo.clasificacion.clasif_misional"
                  class="badge rounded-pill bg-success"
                  data-bs-toggle="tooltip"
                  title="Misional"
                >
                  {{ equipo.clasificacion.clasif_misional }}
                </span>

                <span
                  v-if="equipo.clasificacion.clasif_ips"
                  class="badge rounded-pill bg-primary"
                  data-bs-toggle="tooltip"
                  title="IPS"
                >
                  {{ equipo.clasificacion.clasif_ips }}
                </span>                
              </div>
            </td>



            <td class="text-center">
              <div class="d-flex flex-column align-items-center gap-1">
                <span class="badge rounded-pill bg-info text-dark" title="INVIMA">
                  {{ equipo.invima }}
                </span>
                
                <span
                  v-if="equipo.clasificacion.clasif_riesgo"
                  class="badge rounded-pill bg-warning text-dark mt-1"
                  data-bs-toggle="tooltip"
                  title="Riesgo"
                >
                  Riesgo: {{ equipo.clasificacion.clasif_riesgo }}
                </span>
              </div>
            </td>


            <td class="text-center">
              <button
                class="icon-btn"
                data-bs-toggle="tooltip"
                data-bs-placement="top"
                title="Ver más"
                @click="verDetalles(equipo.id)"
              >
                <i class="bi bi-eye"></i>
              </button>

              <button
                class="icon-btn"
                data-bs-toggle="tooltip"
                data-bs-placement="top"
                title="Editar"
                @click="editarEquipo(equipo.id)"
              >
                <i class="bi bi-pencil-square"></i>
              </button>

              <button
                class="icon-btn"
                data-bs-toggle="tooltip"
                data-bs-placement="top"
                title="Desactivar"
              >
                <i class="bi bi-eye-slash"></i>
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
                <p class="mb-1"><strong>📅 Fecha:</strong> {{ registro.fecha }}</p>
                <p class="mb-1"><strong>👤 Responsable:</strong> {{ registro.responsable_actualizado }}</p>
                <p class="mb-1"><strong>🏥 Servicio:</strong> {{ registro.servicio_actualizado }}</p>
                <p class="mb-0"><strong>📝 Justificación:</strong> {{ registro.justificacion }}</p>
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

// Lista de equipos
const equipos = ref([]);

// Llamada al backend
const cargarEquipos = async () => {
  try {
    const res = await axios.get("http://127.0.0.1:8000/api/equipos/");
    equipos.value = res.data.map((eq) => {
      // responsable_ubicacion viene como "Responsable / Ubicación" (según tu serializer)
      const [responsableRaw, ubicacionRaw] = (eq.responsable_ubicacion || "").split("/");
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
        sede: eq.sede || eq.proceso || "",
        
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

    // concatena los campos donde buscar: equipo, servicio y todos los códigos
    const codigosConcat = [eq.codigos?.interno, eq.codigos?.ips, eq.codigos?.ecri]
      .filter(Boolean)
      .join(" ")
      .toLowerCase();

    const coincideBusqueda =
      (eq.equipo || "").toLowerCase().includes(texto) ||
      codigosConcat.includes(texto) ||
      (eq.servicio || "").toLowerCase().includes(texto);

    const coincideSede = !filtroSede.value || eq.sede === filtroSede.value;
    const coincideServicio = !filtroServicio.value || eq.servicio === filtroServicio.value;

    return coincideBusqueda && coincideSede && coincideServicio;
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


import { Modal } from "bootstrap"; // 👈 importante para controlar el modal

const registros = ref([]);
const equipoSeleccionado = ref(null);
const modalElement = ref(null);
let modalInstance = null;
const cargando = ref(false);

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

.btn-success {
  background-color: var(--verde-acento);
  border-color: var(--verde-acento);
  font-weight: 600;
  transition: var(--transicion);
}

.btn-success:hover {
  background-color: var(--verde-secundario);
  border-color: var(--verde-secundario);
  transform: translateY(-2px);
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


</style>
