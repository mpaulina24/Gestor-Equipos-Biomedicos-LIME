<template>
  <div class="container mt-5">
    <h2 class="titulo-principal text-center">Agregar Nuevo Equipo Médico</h2>

    <!-- Tabs -->
    <ul class="nav nav-pills nav-fill mb-4" role="tablist">
      <li class="nav-item" v-for="(tab, index) in tabs" :key="index">
        <button
          class="nav-link"
          :class="{ active: activeTab === tab.id }"
          @click="activeTab = tab.id"
        >
          {{ tab.label }}
        </button>
      </li>
    </ul>


    <form @submit.prevent="guardarEquipo">
      <div class="tab-content">

        <!-- 🧾 Información General -->
        <div v-if="activeTab === 'general'" class="tab-pane fade show active">
          <div class="card shadow mb-4">
            <div class="card-header custom-header text-white">Información General</div>
            <div class="card-body">
              <div class="row">
                <div class="col-md-6 mb-3">
                  <label>Proceso</label>
                  <input v-model="equipo.proceso" class="form-control" required />
                </div>
                <div class="col-md-6 mb-3">
                  <label>Nombre del equipo</label>
                  <input v-model="equipo.nombre_equipo" class="form-control" required />
                </div>
                <div class="col-md-4 mb-3">
                  <label>Código Interno</label>
                  <input v-model="equipo.codigo_interno" class="form-control" />
                </div>
                <div class="col-md-4 mb-3">
                  <label>Código IPS</label>
                  <input v-model="equipo.codigo_ips" class="form-control" />
                </div>
                <div class="col-md-4 mb-3">
                  <label>Código ECRI</label>
                  <input v-model="equipo.codigo_ecri" class="form-control" />
                </div>
                <div class="col-md-6 mb-3">
                  <label>Responsable</label>
                  <input v-model="equipo.responsable" class="form-control" />
                </div>
                <div class="col-md-6 mb-3">
                  <label>Ubicación</label>
                  <input v-model="equipo.ubicacion" class="form-control" />
                </div>
                <div class="col-md-4 mb-3">
                  <label>Marca</label>
                  <input v-model="equipo.marca" class="form-control" />
                </div>
                <div class="col-md-4 mb-3">
                  <label>Modelo</label>
                  <input v-model="equipo.modelo" class="form-control" />
                </div>
                <div class="col-md-4 mb-3">
                  <label>Serie</label>
                  <input v-model="equipo.serie" class="form-control" />
                </div>
              </div>
            </div>
          </div>

          <div class="text-end mt-3">
            <button 
              type="button" 
              class="btn custom-btn"
              @click="siguienteSeccion"
            >
              Siguiente sección
            </button>

            <router-link to="/equipos" class="btn btn-success ms-2">
              Ver Inventario
            </router-link>

          </div>

        </div>

        <!-- 📜 Registro Histórico -->
        <div v-if="activeTab === 'historico'" class="tab-pane fade show active">
          <div class="card shadow mb-4">
            <div class="card-header custom-header text-white">Registro Histórico</div>
            <div class="card-body">
              <div class="row">
                <div class="col-md-4 mb-3">
                  <label>Tiempo de vida útil</label>
                  <input v-model="equipo.tiempo_vida_util" class="form-control" />
                </div>
                <div class="col-md-4 mb-3">
                  <label>Fecha de adquisición</label>
                  <input type="date" v-model="equipo.fecha_adquisicion" class="form-control" />
                </div>
                <div class="col-md-4 mb-3">
                  <label>Propietario</label>
                  <input v-model="equipo.propietario" class="form-control" />
                </div>
                <div class="col-md-4 mb-3">
                  <label>Proveedor</label>
                  <input v-model="equipo.proveedor" class="form-control" />
                </div>
                <div class="col-md-4 mb-3">
                  <label>NIT</label>
                  <input v-model="equipo.nit" class="form-control" />
                </div>
                <div class="col-md-4 mb-3">
                  <label>Fecha fin garantía</label>
                  <input type="date" v-model="equipo.fecha_fin_garantia" class="form-control" />
                </div>
                <div class="col-md-6 mb-3">
                  <label>¿En garantía?</label>
                  <input type="checkbox" v-model="equipo.en_garantia" />
                </div>
              </div>
            </div>
          </div>

          <div class="text-end mt-3">
            <button 
              type="button" 
              class="btn custom-btn"
              @click="siguienteSeccion"
            >
              Siguiente sección
            </button>

            <router-link to="/equipos" class="btn btn-success ms-2">
              Ver Inventario
            </router-link>

          </div>

        </div>

        <!-- 📁 Inventario de documentos -->
        <div v-if="activeTab === 'documentos'" class="tab-pane fade show active">
          <div class="card shadow mb-4">
            <div class="card-header custom-header text-white">Inventario de Documentos</div>
            <div class="card-body">
              <div class="row">
                <div class="col-md-3" v-for="(field, key) in documentos" :key="key">
                  <label>
                    <input type="checkbox" v-model="equipo[key]" />
                    {{ field }}
                  </label>
                </div>
              </div>
            </div>
          </div>

          <div class="text-end mt-3">
            <button 
              type="button" 
              class="btn custom-btn"
              @click="siguienteSeccion"
            >
              Siguiente sección
            </button>

            <router-link to="/equipos" class="btn btn-success ms-2">
              Ver Inventario
            </router-link>

          </div>

        </div>

        <!-- ⚙️ Información metrológica -->
        <div v-if="activeTab === 'metrologica'" class="tab-pane fade show active">
          <div class="card shadow mb-4">
            <div class="card-header custom-header text-white">Información Metrológica</div>
            <div class="card-body row">
              <div class="col-md-6 mb-3">
                <label>Magnitud</label>
                <input v-model="equipo.magnitud" class="form-control" />
              </div>
              <div class="col-md-6 mb-3">
                <label>Rango</label>
                <input v-model="equipo.rango" class="form-control" />
              </div>
              <div class="col-md-6 mb-3">
                <label>Resolución</label>
                <input v-model="equipo.resolucion" class="form-control" />
              </div>
              <div class="col-md-6 mb-3">
                <label>Rango de trabajo</label>
                <input v-model="equipo.rango_trabajo" class="form-control" />
              </div>
            </div>
          </div>
          <div class="text-end mt-3">

            <button 
              type="button" 
              class="btn custom-btn"
              @click="siguienteSeccion"
            >
              Siguiente sección
            </button>

            <router-link to="/equipos" class="btn btn-success ms-2">
              Ver Inventario
            </router-link>

          </div>

        </div>

        <!-- 🌡️ Condiciones de funcionamiento -->
        <div v-if="activeTab === 'condiciones'" class="tab-pane fade show active">
          <div class="card shadow mb-4">
            <div class="card-header custom-header text-white">Condiciones de Funcionamiento</div>
            <div class="card-body row">
              <div class="col-md-4 mb-3">
                <label>Voltaje</label>
                <input v-model="equipo.voltaje" class="form-control" />
              </div>
              <div class="col-md-4 mb-3">
                <label>Corriente</label>
                <input v-model="equipo.corriente" class="form-control" />
              </div>
              <div class="col-md-4 mb-3">
                <label>Humedad</label>
                <input v-model="equipo.humedad" class="form-control" />
              </div>
              <div class="col-md-4 mb-3">
                <label>Temperatura</label>
                <input v-model="equipo.temperatura" class="form-control" />
              </div>
              <div class="col-md-4 mb-3">
                <label>Peso</label>
                <input v-model="equipo.peso" class="form-control" />
              </div>
              <div class="col-md-8 mb-3">
                <label>Otros</label>
                <textarea v-model="equipo.otros" class="form-control"></textarea>
              </div>
            </div>
          </div>

          <!-- Botón Guardar -->
          <div class="text-end mt-4">
            <button class="btn btn-success">Guardar Equipo</button>

            <router-link to="/equipos" class="btn btn-success ms-2">
              Ver Inventario
            </router-link>
          </div>
        </div>
      </div>
    </form>
  </div>
</template>

<script setup>
import { ref } from "vue";
import axios from "axios";

const activeTab = ref("general");

const tabs = [
  { id: "general", label: "Información General" },
  { id: "historico", label: "Registro Histórico" },
  { id: "documentos", label: "Inventario Documentos" },
  { id: "metrologica", label: "Información Metrológica" },
  { id: "condiciones", label: "Condiciones Funcionamiento" },
];

const equipo = ref({
  proceso: "",
  nombre_equipo: "",
  codigo_interno: "",
  codigo_ips: "",
  codigo_ecri: "",
  responsable: "",
  ubicacion: "",
  marca: "",
  modelo: "",
  serie: "",
  clasificacion_misional: "",
  clasificacion_ips: "",
  clasificacion_riesgo: "",
  registro_invima: "",
  en_garantia: false,
  hoja_vida: false,
  registro_importacion: false,
  manual_operacion: false,
  guia_rapida: false,
  instructivo: false,
  mantenimiento: false,
  calibracion: false,
});

const documentos = {
  hoja_vida: "Hoja de vida",
  registro_importacion: "Registro de importación",
  manual_operacion: "Manual de operación",
  guia_rapida: "Guía rápida",
  instructivo: "Instructivo",
};

const guardarEquipo = async () => {
  try {
    const response = await axios.post("http://127.0.0.1:8000/api/equipos/agregarEquipo", equipo.value);
    alert("✅ Equipo agregado correctamente");
    console.log("Respuesta del servidor:", response.data);
  } catch (error) {
    // Si el servidor respondió con un error (400, 404, 500, etc.)
    if (error.response) {
      console.error("🧩 Error del servidor:", error.response.data);
      console.error("📡 Código de estado:", error.response.status);
      alert(`❌ Error ${error.response.status}: ${JSON.stringify(error.response.data)}`);

    // Si no hubo respuesta del servidor (problemas de red o CORS)
    } else if (error.request) {
      console.error("🌐 No hubo respuesta del servidor:", error.request);
      alert("⚠️ No se recibió respuesta del servidor. Verifica tu conexión o CORS.");

    // Error en la configuración o ejecución de la petición
    } else {
      console.error("⚙️ Error en la configuración de la petición:", error.message);
      alert(`⚙️ Error: ${error.message}`);
    }
  }
};

const tabsIds = tabs.map(tab => tab.id); // ["general", "historico", "documentos", "metrologica", "condiciones"]

const siguienteSeccion = () => {
  const indexActual = tabsIds.indexOf(activeTab.value);
  if (indexActual < tabsIds.length - 1) {
    activeTab.value = tabsIds[indexActual + 1];
  }
};


</script>

<style scoped>
.nav-link {
  cursor: pointer;
}
</style>
