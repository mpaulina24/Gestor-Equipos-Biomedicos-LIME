<template>
  <div class="container mt-5">

    <!-- Título -->
    <h2 class="titulo-principal text-center mb-4">
      Agregar Nuevo Equipo Médico
    </h2>

    <!-- Tabs Navegación -->
    <ul class="nav nav-pills nav-fill mb-4" role="tablist">
      <li 
        class="nav-item" 
        v-for="(tab, index) in tabs" 
        :key="index"
      >
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

        <!--    1. INFORMACIÓN GENERAL   -->
        <div v-if="activeTab === 'general'" class="tab-pane fade show active">
          <div class="card shadow mb-4 tarjeta-verde">

            <div class="card-header custom-header text-white">
              Información General
            </div>

            <div class="card-body">

              <!-- SEDE + SERVICIO -->
              <div class="row">
                
                <!-- SEDE -->
                <div class="col-md-4 mb-3">
                  <label>Sede multicentro</label>
                  <select v-model="equipo.sede" class="form-select" required>
                    <option disabled value="">Seleccione la Sede</option>
                    <option 
                      v-for="opcion in opcionesSede" 
                      :key="opcion.value" 
                      :value="opcion.value"
                    >
                      {{ opcion.label }}
                    </option>
                  </select>
                </div>

                <!-- SERVICIO -->
                <div class="col-md-8 mb-3">
                  <label>Proceso / Servicio</label>
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
                        :value="servicio"
                      >
                        {{ servicio }}
                      </option>
                    </select>

                    <button 
                      v-if="!mostrarNuevoServicio"
                      type="button" 
                      class="btn custom-btn" 
                      @click="mostrarNuevoServicio = true"
                    >
                      + Nuevo servicio
                    </button>

                  </div>
                </div>

                <!-- NUEVO SERVICIO -->
                <div 
                  v-if="mostrarNuevoServicio" 
                  class="col-md-12 mb-3"
                >
                  <label>Ingresar Nuevo Servicio / Proceso</label>
                  <div class="input-group">

                    <input 
                      v-model="nuevoServicio" 
                      class="form-control" 
                      placeholder="Ej: LIME - Genética"
                    />

                    <button 
                      type="button" 
                      class="btn custom-btn" 
                      @click="agregarNuevoServicio"
                    >
                      Guardar Nuevo
                    </button>

                    <button 
                      type="button" 
                      class="btn btn-secondary" 
                      @click="mostrarNuevoServicio = false; nuevoServicio = ''"
                    >
                      Cancelar
                    </button>

                  </div>
                </div>
              </div>

              <hr>

              <!-- DATOS GENERALES DEL EQUIPO -->
              <div class="row">
                <div class="col-md-6 mb-3">
                  <label>Nombre del equipo</label>
                  <input v-model="equipo.nombre_equipo" class="form-control" required />
                </div>

                <div class="col-md-4 mb-3">
                  <label>Responsable</label>
                  <input v-model="equipo.responsable" class="form-control" />
                </div>

                <div class="col-md-4 mb-3">
                  <label>Ubicación (Área / Laboratorio)</label>
                  <input v-model="equipo.ubicacion" class="form-control" />
                </div>

                <div class="col-md-4 mb-3">
                  <label>Marca</label>
                  <input v-model="equipo.marca" class="form-control" />
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

                <div class="col-md-4 mb-3">
                  <label>Modelo</label>
                  <input v-model="equipo.modelo" class="form-control" />
                </div>

                <div class="col-md-4 mb-3">
                  <label>Serie</label>
                  <input v-model="equipo.serie" class="form-control" />
                </div>
              </div>

              <hr>

              <!-- CLASIFICACIONES -->
              <div class="row mt-3">

                <div class="col-md-6 mb-3">
                  <label>Clasificación Misional</label>

                  <div 
                    v-for="opcion in clasificacionesMisionales" 
                    :key="opcion.value" 
                    class="form-check"
                  >
                    <input 
                      class="form-check-input"
                      type="checkbox"
                      :value="opcion.value"
                      v-model="equipo.clasificacion_misional"
                    />
                    <label class="form-check-label">
                      {{ opcion.label }}
                    </label>
                  </div>

                </div>

                <div class="col-md-6 mb-3">
                  <label>Clasificación IPS</label>
                  <select v-model="equipo.clasificacion_ips" class="form-select">
                    <option value="" disabled>Seleccione</option>
                    <option 
                      v-for="opcion in clasificacionesIPS" 
                      :key="opcion.value" 
                      :value="opcion.value"
                    >
                      {{ opcion.label }}
                    </option>
                  </select>
                </div>

                <div class="col-md-6 mb-3">
                  <label>Clasificación Riesgo</label>
                  <select v-model="equipo.clasificacion_riesgo" class="form-select">
                    <option value="" disabled>Seleccione</option>
                    <option 
                      v-for="opcion in clasificacionesRiesgo" 
                      :key="opcion.value" 
                      :value="opcion.value"
                    >
                      {{ opcion.label }}
                    </option>
                  </select>
                </div>

              </div>

              <hr>

              <!-- INVIMA -->
              <div class="row mt-3 align-items-center">

                <div class="col-md-4 mb-3">
                  <label class="d-block">¿Requiere Registro INVIMA?</label>
                  <div class="form-check form-switch mt-2">
                    <input 
                      class="form-check-input" 
                      type="checkbox" 
                      v-model="equipo.requiere_invima" 
                      id="switchInvima"
                      @change="equipo.registro_invima = equipo.requiere_invima ? '' : 'NI'"
                    />
                    <label 
                      class="form-check-label" 
                      for="switchInvima"
                    >
                      {{ equipo.requiere_invima ? 'Sí' : 'No' }}
                    </label>
                  </div>
                </div>

                <div class="col-md-8 mb-3">
                  <label>Registro INVIMA / Permiso Comercialización</label>
                  <input 
                    v-model="equipo.registro_invima" 
                    class="form-control"
                    placeholder="Ingrese el número de registro, si aplica"
                    :disabled="!equipo.requiere_invima"  
                    :required="equipo.requiere_invima"
                  />
                  <small 
                    v-if="!equipo.requiere_invima" 
                    class="form-text text-muted"
                  >
                    El campo se guardará como "NI: No identificado".
                  </small>
                </div>

              </div>

            </div>
          </div>

          <!-- BOTONES -->
          <div class="text-end mt-3">
            <button 
              type="button" 
              class="btn custom-btn me-2"
              @click="siguienteSeccion"
            >
              Siguiente sección
            </button>

            <router-link to="/equipos" class="btn btn-secondary me-2">
              Cancelar
            </router-link>
          </div>
        </div>

        <!-- Registro Histórico -->
        <div v-if="activeTab === 'historico'" class="tab-pane fade show active">

          <div class="card shadow mb-4 tarjeta-verde">
            <div class="card-header custom-header text-white">
              Registro Histórico del Equipo
            </div>

            <div class="card-body">

              <p class="text-muted mb-4">
                Información relacionada con el origen del equipo, documentos legales,
                antigüedad e historial de adquisición.
              </p>

              <div class="row">

                <div class="col-md-4 mb-3">
                  <label class="form-label">Tiempo de vida útil</label>
                  <input v-model="equipo.tiempo_vida_util" class="form-control" placeholder="Ej: 8 años" />
                </div>

                <div class="col-md-4 mb-3">
                  <label class="form-label">Fecha de adquisición</label>
                  <input type="date" v-model="equipo.fecha_adquisicion" class="form-control" />
                </div>

                <div class="col-md-4 mb-3">
                  <label class="form-label">Fecha de fabricación</label>
                  <input type="date" v-model="equipo.fecha_fabricacion" class="form-control" />
                </div>

                <div class="col-md-4 mb-3">
                  <label class="form-label">Forma de adquisición</label>
                  <input v-model="equipo.forma_adquisicion" class="form-control" placeholder="Compra / Donación / Arrendamiento" />
                </div>

                <div class="col-md-4 mb-3">
                  <label class="form-label">Tipo de documento</label>
                  <input v-model="equipo.tipo_documento" class="form-control" placeholder="Factura / Contrato / Acta" />
                </div>

                <div class="col-md-4 mb-3">
                  <label class="form-label">Número de documento</label>
                  <input v-model="equipo.numero_documento" class="form-control" />
                </div>

                <hr class="mt-3">

                <div class="col-md-4 mb-3">
                  <label class="form-label">Propietario</label>
                  <input v-model="equipo.propietario" class="form-control" placeholder="Entidad propietaria" />
                </div>

                <div class="col-md-4 mb-3">
                  <label class="form-label">Proveedor</label>
                  <input v-model="equipo.proveedor" class="form-control" placeholder="Empresa proveedora" />
                </div>

                <div class="col-md-4 mb-3">
                  <label class="form-label">NIT del proveedor</label>
                  <input v-model="equipo.nit" class="form-control" />
                </div>

                <div class="col-md-4 mb-3">
                  <label class="form-label">Fecha fin garantía</label>
                  <input type="date" v-model="equipo.fecha_fin_garantia" class="form-control" />
                </div>

                <div class="col-md-8 mb-3 d-flex align-items-center">
                  <div>
                    <label class="form-check-label">¿El equipo se encuentra bajo garantía vigente?</label>
                    <div class="form-check ms-2">
                      <input type="checkbox" v-model="equipo.en_garantia" class="form-check-input" />
                    </div>
                  </div>
                </div>

              </div> <!-- row -->
            </div>
          </div>

          <div class="text-end mt-3">
            <button 
              type="button" 
              class="btn custom-btn me-2"
              @click="siguienteSeccion"
            >
              Siguiente sección
            </button>

            <router-link to="/equipos" class="btn btn-secondary">
              Cancelar
            </router-link>
          </div>

        </div>


        <!----------- Inventario de documentos ------------->

        <div v-if="activeTab === 'documentos'" class="tab-pane fade show active">

          <div class="card shadow mb-4 tarjeta-verde">
            <div class="card-header custom-header text-white">
              Inventario de Documentos y Frecuencias Administrativas
            </div>

            <div class="card-body">

              <p class="text-muted mb-4">
                Verifique y registre la disponibilidad de documentos técnicos, legales y operativos
                asociados al equipo, incluyendo manuales, certificaciones, protocolos y documentación del fabricante.
              </p>

              <div class="row mb-4">
                <div
                  class="col-md-4 mb-2"
                  v-for="(field, key) in documentos"
                  :key="key"
                >
                  <div class="form-check">
                    <input 
                      class="form-check-input"
                      type="checkbox"
                      v-model="equipo[key]"
                      :id="'doc-' + key"
                    />
                    <label class="form-check-label" :for="'doc-' + key">
                      {{ field }}
                    </label>
                  </div>
                </div>
              </div>

            </div>
          </div>

          <div class="text-end mt-3">
            <button 
              type="button" 
              class="btn custom-btn me-2"
              @click="siguienteSeccion"
            >
              Siguiente sección
            </button>

            <router-link to="/equipos" class="btn btn-secondary">
              Cancelar
            </router-link>
          </div>
        </div>



        <!-- Información Metrológica -->
        <div v-if="activeTab === 'metrologica'" class="tab-pane fade show active">

          <div class="card shadow mb-4 tarjeta-verde">
            <div class="card-header custom-header text-white">
              Información Metrológica
            </div>

            <div class="card-body">

              <p class="text-muted mb-4">
                Parámetros técnicos que definen la capacidad de medida y desempeño del equipo, 
                incluyendo rangos operativos, resolución y magnitudes estandarizadas.
              </p>

              <div class="row">

                <div class="col-md-6 mb-3">
                  <label class="form-label">Magnitud medida</label>
                  <input v-model="equipo.magnitud" class="form-control" placeholder="Ej: Presión, flujo, voltaje, etc."/>
                </div>

                <div class="col-md-6 mb-3">
                  <label class="form-label">Rango de medición</label>
                  <input v-model="equipo.rango" class="form-control" placeholder="Ej: 0 – 300 mmHg"/>
                </div>

                <div class="col-md-6 mb-3">
                  <label class="form-label">Resolución</label>
                  <input v-model="equipo.resolucion" class="form-control" placeholder="Ej: 0.1 mmHg"/>
                </div>

                <div class="col-md-6 mb-3">
                  <label class="form-label">Rango de trabajo</label>
                  <input v-model="equipo.rango_trabajo" class="form-control" placeholder="Ej: 10 – 40°C"/>
                </div>

              </div>

              <hr class="mt-4">

              <div class="row">

                <div class="col-md-6 mb-3">
                  <label class="form-label">¿Requiere mantenimiento?</label>
                  <div class="form-check form-switch ms-2">
                    <input 
                      class="form-check-input" 
                      type="checkbox"
                      v-model="equipo.mantenimiento" 
                      id="switch-mantenimiento"
                    >
                    <label class="form-check-label fw-bold" for="switch-mantenimiento">
                      {{ equipo.mantenimiento ? 'Sí' : 'No' }}
                    </label>
                  </div>
                </div>

                <div class="col-md-6 mb-3" v-if="equipo.mantenimiento">
                  <label class="form-label">Frecuencia de mantenimiento (meses)</label>
                  <input 
                    type="number" 
                    v-model.number="equipo.frecuencia_mantenimiento" 
                    class="form-control"
                    placeholder="Ej: 6"
                  />
                </div>

                <div class="col-md-6 mb-3">
                  <label class="form-label">¿Requiere calibración?</label>
                  <div class="form-check form-switch ms-2">
                    <input 
                      class="form-check-input" 
                      type="checkbox" 
                      v-model="equipo.calibracion" 
                      id="switch-calibracion"
                    >
                    <label class="form-check-label fw-bold" for="switch-calibracion">
                      {{ equipo.calibracion ? 'Sí' : 'No' }}
                    </label>
                  </div>
                </div>

                <div class="col-md-6 mb-3" v-if="equipo.calibracion">
                  <label class="form-label">Frecuencia de calibración (meses)</label>
                  <input 
                    type="number" 
                    v-model.number="equipo.frecuencia_calibracion" 
                    class="form-control" 
                    placeholder="Ej: 12"
                  />
                </div>

              </div>

            </div>
          </div>

          <div class="text-end mt-3">

            <button 
              type="button" 
              class="btn custom-btn me-2"
              @click="siguienteSeccion"
            >
              Siguiente sección
            </button>

            <router-link to="/equipos" class="btn btn-secondary">
              Cancelar
            </router-link>

          </div>

        </div>

        <!-- Condiciones de funcionamiento -->
        <div v-if="activeTab === 'condiciones'" class="tab-pane fade show active">
          <div class="card shadow mb-4 tarjeta-verde">
            <div class="card-header custom-header text-white">
              Condiciones de Funcionamiento
            </div>

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
                <label>Humedad (%HR)</label>
                <input v-model="equipo.humedad" class="form-control" />
              </div>

              <div class="col-md-3 mb-3">
                <label>Temperatura (°C)</label>
                <input v-model="equipo.temperatura" class="form-control" />
              </div>

              <div class="col-md-3 mb-3">
                <label>Dimensiones</label>
                <input
                  type="text"
                  v-model="equipo.dimensiones"
                  class="form-control"
                  placeholder="Ej: 120 x 60 x 45 cm"
                />
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

          <div class="text-end mt-4">
            <button class="btn btn-success px-4 me-2">Guardar Equipo</button>

            <router-link to="/equipos" class="btn btn-secondary">
              Cancelar
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
  sede: "",
  codigo_interno: "",
  codigo_ips: "",
  codigo_ecri: "",
  responsable: "",
  ubicacion: "",
  marca: "",
  modelo: "",
  serie: "",
  clasificacion_misional: [],
  clasificacion_ips: "",
  clasificacion_riesgo: "",
  registro_invima: "",
  requiere_invima: true,

  // --- Registro Histórico (Añade campos faltantes si no los habías incluido) ---
  tiempo_vida_util: "",
  fecha_adquisicion: null,
  propietario: "",
  fecha_fabricacion: "", // CharField
  nit: "",
  proveedor: "",
  en_garantia: false,
  fecha_fin_garantia: null,
  forma_adquisicion: "",
  tipo_documento: "",
  numero_documento: "",

  // --- Inventario de Documentos ---
  hoja_vida: false,
  registro_importacion: false,
  manual_operacion: false,
  manual_mantenimiento: false,
  guia_rapida: false,
  instructivo: false,
  protocolo_mto: false, 
  frecuencia_metrologica: false, //  CHARFIELD

  // --- Información metrológica administrativa ---
  mantenimiento: false,
  frecuencia_mantenimiento: null, // INTEGERFIELD
  calibracion: false,
  frecuencia_calibracion: null, // INTEGERFIELD

  // --- Condiciones de funcionamiento (Nuevos campos) ---
  dimensiones: null,      // Mapea a IntegerField
  peso: "",
  otros: "",

});

//  Opciones Iniciales de Proceso/Servicio
const serviciosDisponibles = ref([
    'LIME',
    'Centro de resonancia',
    'Fotodermatología',
    'Trasplantes GICIG',
    'Inmunodeficiencias Primarias',
    'Grupo Reproducción',
    'Patología',
    'Dermatopatología'
]);
const mostrarNuevoServicio = ref(false);
const nuevoServicio = ref('');
function agregarNuevoServicio() {
    if (nuevoServicio.value && !serviciosDisponibles.value.includes(nuevoServicio.value)) {
        serviciosDisponibles.value.push(nuevoServicio.value);
        equipo.value.proceso = nuevoServicio.value; 
        nuevoServicio.value = '';
        mostrarNuevoServicio.value = false;
    }
}

// --- Opciones de Clasificación para Vue ---
const clasificacionesMisionales = [
  { value: 'DOCENCIA', label: 'Docencia' },
  { value: 'INVESTIGACION', label: 'Investigación' },
  { value: 'EXTENSION', label: 'Extensión' },
];

const clasificacionesIPS = [
  { value: 'BIO', label: 'BIO' },
  { value: 'IND', label: 'IND' },
  { value: 'GASES', label: 'Gases' },
];

const clasificacionesRiesgo = [
  { value: 'I', label: 'Clase I' },
  { value: 'IIA', label: 'Clase IIa' },
  { value: 'IIB', label: 'Clase IIb' },
  { value: 'III', label: 'Clase III' },
];

// El 'value' debe coincidir con la clave única de models.py 
const opcionesSede = [ 
  { value: 'Prado', label: 'Prado' },
  { value: 'SIU', label: 'SIU' },
  { value: 'San Vicente', label: 'San Vicente' },
];

const documentos = {
  hoja_vida: "Hoja de vida",
  registro_importacion: "Registro de importación",
  manual_operacion: "Manual de operación",
  manual_mantenimiento: "Manual de mantenimiento",
  guia_rapida: "Guía rápida",
  instructivo: "Instructivo",
  protocolo_mto: "Protocolo Mantenimiento", 
  frecuencia_metrologica: "Frecuencia Metrológica del Fabricante",
};

const guardarEquipo = async () => {
  try {

    // Convertir array a string antes de enviar
    const payload = { ...equipo.value };
    if (Array.isArray(payload.clasificacion_misional)) {
      payload.clasificacion_misional = payload.clasificacion_misional.join(",");
    }

    const response = await axios.post("http://127.0.0.1:8000/api/equipos/agregarEquipo/", payload);
    alert(" Equipo agregado correctamente");
    console.log("Respuesta del servidor:", response.data);
  } catch (error) {
    // Si el servidor respondió con un error (400, 404, 500, etc.)
    if (error.response) {
      console.error(" Error del servidor:", error.response.data);
      console.error(" Código de estado:", error.response.status);
      alert(` Error ${error.response.status}: ${JSON.stringify(error.response.data)}`);

    // Si no hubo respuesta del servidor (problemas de red o CORS)
    } else if (error.request) {
      console.error(" No hubo respuesta del servidor:", error.request);
      alert("No se recibió respuesta del servidor. Verifica tu conexión o CORS.");

    // Error en la configuración o ejecución de la petición
    } else {
      console.error(" Error en la configuración de la petición:", error.message);
      alert(` Error: ${error.message}`);
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

.tabs-verdes .nav-link.active {
  background-color: rgba(27, 94, 32, 0.5);
  color: #1B5E20 !important;
  font-weight: bold;
}

.titulo-principal {
  color: #1B5E20;
  font-weight: 800;
}

.custom-header {
  background-color: rgba(27, 94, 32, 0.8) !important;
  backdrop-filter: blur(3px);
  font-weight: bold;
}


label {
  color: #1B5E20;
  font-weight: 600;
}

.btn-verde {
  background-color: #1B5E20;
  color: white;
  font-weight: 600;
}
.btn-verde:hover {
  background-color: #388E3C;
}


.card-body, 
.card-body label, 
.card-body input, 
.card-body textarea,
.card-body .form-check-label {
  font-size: 0.88rem !important;
}

.form-control,
.form-select {
  padding: 0.35rem 0.55rem !important;
  height: auto;
  font-size: 0.88rem !important;
}

</style>
