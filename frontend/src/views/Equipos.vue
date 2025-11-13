<template>
  <div class="container py-4">
    <h1 class="titulo-principal">Inventario de Equipos Médicos</h1>

    <div class="card shadow-sm mb-2">
  <div class="card-body">
    
    <!-- 🔹 Buscador arriba -->
    <div class="mb-3">
      <input
        v-model="busqueda"
        type="text"
        class="form-control filtro"
        placeholder="Buscar por servicio, nombre, marca, modelo o código..."
      />
    </div>

    <!-- 🔹 Filtros y botón agregar abajo -->
    <div class="row align-items-center g-2">
      
      <!-- Columna de filtros -->
      <div class="col-md-9 d-flex flex-wrap align-items-center gap-2">
        <select v-model="filtroSede" class="form-select filtro w-auto">
          <option value="">Todas las sedes</option>
          <option value="Prado">LIME - Hematología</option>
          <option value="Sede2">1</option>
          <option value="Sede3">Sede 3</option>
        </select>

        <select v-model="filtroServicio" class="form-select filtro w-auto">
          <option value="">Todos los servicios</option>
          <option value="LIME - Hematología">LIME - Hematología</option>
          <option value="1">1</option>
          <option value="Laboratorio Clínico">Laboratorio Clínico</option>
          <option value="Electromedicina">Electromedicina</option>
        </select>
      </div>

      <!-- Columna del botón -->
      <div class="col-md-3 justify-content-end">
        <button class="btn btn-success d-flex align-items-center justify-content-center gap-2" @click="agregarEquipo">
        <i class="bi bi-plus-lg"></i> Agregar
      </button>
      </div>
    </div>

  </div>
</div>




    <!-- 🔹 Tabla de equipos -->
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

                <span
                  v-if="equipo.clasificacion.clasif_riesgo"
                  class="badge rounded-pill bg-light text-dark"
                  data-bs-toggle="tooltip"
                  title="Riesgo"
                >
                  {{ equipo.clasificacion.clasif_riesgo }}
                </span>
              </div>
            </td>



            <td class="text-center">{{ equipo.invima }}</td>
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
            </td>
          </tr>
        </tbody>
      </table>
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

// 🔹 Llamada al backend
// 🔹 Llamada al backend (reemplaza tu cargarEquipos por esto)
const cargarEquipos = async () => {
  try {
    const res = await axios.get("http://127.0.0.1:8000/api/equipos/");
    equipos.value = res.data.map((eq) => {
      // responsable_ubicacion viene como "Responsable / Ubicación" (según tu serializer)
      const [responsableRaw, ubicacionRaw] = (eq.responsable_ubicacion || "").split("/");
      const [nombre_equipoRaw, marcaRaw, modeloRaw] = (eq.equipo || "").split("/");

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

  // inicializa tooltips sólo si bootstrap está cargado (evita errores)
  if (window.bootstrap && window.bootstrap.Tooltip) {
    const tooltipTriggerList = document.querySelectorAll('[data-bs-toggle="tooltip"]');
    [...tooltipTriggerList].forEach((el) => new window.bootstrap.Tooltip(el));
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


</style>
