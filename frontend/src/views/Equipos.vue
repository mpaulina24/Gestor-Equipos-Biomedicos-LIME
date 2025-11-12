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
        placeholder="Buscar por nombre, marca, modelo, código..."
      />
    </div>

    <!-- 🔹 Filtros y botón agregar abajo -->
    <div class="row align-items-center g-2">
      
      <!-- Columna de filtros -->
      <div class="col-md-9 d-flex flex-wrap align-items-center gap-2">
        <select v-model="filtroSede" class="form-select filtro w-auto">
          <option value="">Todas las sedes</option>
          <option value="Prado">Prado</option>
          <option value="Sede2">Sede 2</option>
          <option value="Sede3">Sede 3</option>
        </select>

        <select v-model="filtroServicio" class="form-select filtro w-auto">
          <option value="">Todos los servicios</option>
          <option value="Hematología">Hematología</option>
          <option value="Imagenología">Imagenología</option>
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
            <th class="text-center">#</th>
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
            <td>{{ index + 1 }}</td>
            <td>{{ equipo.servicio }}</td>
            <td>{{ equipo.equipo }}</td>
            <td>{{ equipo.codigos }}</td>
            <td>{{ equipo.responsableubicacion }}</td>
            <td>{{ equipo.clasificacion }}</td>
            <td>{{ equipo.invima }}</td>
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
const cargarEquipos = async () => {
  try {
    const res = await axios.get("http://127.0.0.1:8000/api/equipos/");
    equipos.value = res.data.map((eq) => ({
      id: eq.id,
      servicio: eq.proceso, 
      sede: eq.sede || eq.proceso,
      equipo: eq.equipo,
      codigos: eq.codigos,
      responsableubicacion: eq.responsable_ubicacion,
      clasificacion: eq.clasificacion,
      invima: eq.registro_invima || "N/A",
    }));
  } catch (error) {
    console.error("Error cargando equipos:", error);
  }
};

onMounted(() => {
  cargarEquipos();
});

// Computed para aplicar los filtros
const equiposFiltrados = computed(() => {
  return equipos.value.filter((eq) => {
    const texto = busqueda.value.toLowerCase();
    const coincideBusqueda =
      eq.equipo.toLowerCase().includes(texto) ||
      eq.codigos.toLowerCase().includes(texto) ||
      eq.servicio.toLowerCase().includes(texto);

    const coincideSede = !filtroSede.value || eq.sede === filtroSede.value;
    const coincideServicio =
      !filtroServicio.value || eq.servicio === filtroServicio.value;

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
