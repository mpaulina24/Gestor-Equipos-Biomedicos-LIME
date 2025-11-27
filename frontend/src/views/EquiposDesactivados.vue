<template>
  <div class="container py-4">
    <h1 class="titulo-principal">Historial de Equipos Desactivados</h1>

    <div class="table-responsive shadow-sm rounded">
      <table class="table align-middle table-hover">
        <thead class="table-light">
          <tr>
            <th class="text-center">Nombre del Equipo</th>
            <th class="text-center">Código Interno</th>
            <th class="text-center">Servicio</th>
            <th class="text-center">Acciones</th>
          </tr>
        </thead>
        <tbody>
          <tr v-for="equipo in equiposDesactivados" :key="equipo.id">
            <td class="text-center">{{ equipo.nombre_equipo || 'NI' }}</td>
            <td class="text-center">{{ equipo.codigos?.interno || 'NI' }}</td>
            <td class="text-center">{{ equipo.servicio || 'NI' }}</td>
            <td class="text-center">
              <button class="icon-btn text-success" title="Reactivar" @click="activarEquipo(equipo.id)">
                <i class="bi bi-arrow-clockwise"></i> Reactivar
              </button>
            </td>
          </tr>
        </tbody>
      </table>
    </div>
  </div>
</template>

<script setup>
import { ref, onMounted } from "vue";
import axios from "axios";

const equiposDesactivados = ref([]);

const cargarEquiposDesactivados = async () => {
  try {
    // Llama al nuevo endpoint de inactivos
    const res = await axios.get("http://127.0.0.1:8000/api/equipos/inactivos/");
    
    equiposDesactivados.value = res.data.map(eq => {
      const [nombre_equipoRaw] = (eq.equipo || "").split("/").map(s => s.trim()); 
      const codigoParts = (eq.codigos || "").split("/").map(s => s.trim()).filter(Boolean);
      const interno = codigoParts[0] || null;

      return {
        id: eq.id,
        nombre_equipo: nombre_equipoRaw || "Sin nombre",
        servicio: eq.proceso || "",
        codigos: { interno },
        // ... se pueden añadir aquí otros campos si son necesarios
      };
    });
  } catch (error) {
    console.error("Error cargando equipos desactivados:", error);
  }
};

const activarEquipo = async (id) => {
  if (confirm("¿Seguro que quieres reactivar este equipo? Volverá al inventario principal.")) {
    try {
      // endpoint 'activar' en views.py similar a 'desactivar'
      await axios.post(`http://127.0.0.1:8000/api/equipos/${id}/activar/`);
      alert("Equipo reactivado correctamente.");
      await cargarEquiposDesactivados(); // Recargar la lista
    } catch (error) {
      console.error("Error al reactivar el equipo:", error);
      alert("Hubo un error al intentar reactivar el equipo.");
    }
  }
};

onMounted(cargarEquiposDesactivados);
</script>