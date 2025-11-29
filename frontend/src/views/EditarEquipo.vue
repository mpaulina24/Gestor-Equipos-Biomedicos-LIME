<template>
  <div class="container mt-5">
    <h2 class="titulo-principal text-center">Editar Equipo Médico</h2>

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


    <form @submit.prevent="guardarCambios">
      <div class="tab-content">

        <!-- Información General -->
        <div v-if="activeTab === 'general'" class="tab-pane fade show active">

        <div class="card shadow mb-4 tarjeta-verde">

          <div class="card-header custom-header text-white">
            Información General del Equipo
          </div>

          <div class="card-body">

            <p class="text-muted mb-4">
              Actualice la información básica y clasificatoria del equipo médico, incluyendo datos administrativos, técnicos y misionales.
            </p>

            <div class="row mb-4">

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

              <div v-if="mostrarNuevoServicio" class="col-md-12">
                <div class="input-group mt-2">
                  <input 
                    v-model="nuevoServicio" 
                    class="form-control" 
                    placeholder="Ej: LIME - Genética"
                  />
                  <button class="btn custom-btn" type="button" @click="agregarNuevoServicio">
                    Guardar Nuevo
                  </button>
                  <button class="btn btn-secondary" type="button" @click="mostrarNuevoServicio = false; nuevoServicio = ''">
                    Cancelar
                  </button>
                </div>
              </div>
            </div>

            <hr>

            <div class="row mb-4">
              <div class="col-md-4 mb-3">
                <label class="fw-semibold">Nombre del equipo</label>
                <input v-model="equipo.nombre_equipo" class="form-control" required />
              </div>
              <div class="col-md-4 mb-3">
                <label class="fw-semibold">Responsable</label>
                <input v-model="equipo.responsable" class="form-control" />
              </div>
              <div class="col-md-4 mb-3">
                <label class="fw-semibold">Ubicación (Área / Laboratorio)</label>
                <input v-model="equipo.ubicacion" class="form-control" />
              </div>
            </div>

            <div class="row mb-4">
              <div class="col-md-4 mb-3">
                <label class="fw-semibold">Marca</label>
                <input v-model="equipo.marca" class="form-control" />
              </div>

              <div class="col-md-4 mb-3">
                <label class="fw-semibold">Modelo</label>
                <input v-model="equipo.modelo" class="form-control" />
              </div>

              <div class="col-md-4 mb-3">
                <label class="fw-semibold">Serie</label>
                <input v-model="equipo.serie" class="form-control" />
              </div>
            </div>

            <div class="row mb-4">
              <div class="col-md-4 mb-3">
                <label class="fw-semibold">Código Interno</label>
                <input v-model="equipo.codigo_interno" class="form-control" />
              </div>
              <div class="col-md-4 mb-3">
                <label class="fw-semibold">Código IPS</label>
                <input v-model="equipo.codigo_ips" class="form-control" />
              </div>
              <div class="col-md-4 mb-3">
                <label class="fw-semibold">Código ECRI</label>
                <input v-model="equipo.codigo_ecri" class="form-control" />
              </div>
            </div>

            <hr>

            <div class="mt-3">

              <div class="col-md-6 mb-4">
                <label class="fw-semibold">Clasificación Misional</label>

                <div 
                  class="form-check" 
                  v-for="opcion in clasificacionesMisionales" 
                  :key="opcion.value">
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

              <div class="col-md-6 mb-4">
                <label class="fw-semibold">Clasificación IPS</label>
                <select v-model="equipo.clasificacion_ips" class="form-select">
                  <option value="" disabled>Seleccione</option>
                  <option 
                    v-for="opcion in clasificacionesIPS" 
                    :key="opcion.value" 
                    :value="opcion.value">
                    {{ opcion.label }}
                  </option>
                </select>
              </div>

              <div class="col-md-6 mb-4">
                <label class="fw-semibold">Clasificación Riesgo</label>
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

            <div class="row">
              <div class="col-md-4 mb-3">
                <label class="fw-semibold">¿Requiere Registro INVIMA?</label>
                <div class="form-check form-switch mt-2">
                  <input 
                    class="form-check-input" 
                    type="checkbox" 
                    v-model="equipo.requiere_invima" 
                    id="switchInvima"
                    @change="equipo.registro_invima = equipo.requiere_invima ? '' : 'No requiere'"
                  />
                  <label class="form-check-label" for="switchInvima">
                    {{ equipo.requiere_invima ? 'Sí' : 'No' }}
                  </label>
                </div>
              </div>

              <div class="col-md-8">
                <label class="fw-semibold">Registro INVIMA / Permiso Comercialización</label>
                <input 
                  v-model="equipo.registro_invima" 
                  class="form-control"
                  placeholder="Ingrese el número de registro, si aplica"
                  :disabled="!equipo.requiere_invima"  
                  :required="equipo.requiere_invima"
                />
                <small v-if="!equipo.requiere_invima" class="form-text text-muted">
                  El campo se guardará como "No requiere".
                </small>
              </div>
            </div>

          </div>
        </div>

        <div class="text-end mt-3">
          <button type="button" class="btn custom-btn" @click="siguienteSeccion">
            Siguiente sección
          </button>
          <router-link to="/equipos" class="btn btn-secondary ms-2">
            Cancelar
          </router-link>
        </div>

      </div>


        <!-- Registro Histórico -->
        <div v-if="activeTab === 'historico'" class="tab-pane fade show active">
          
          <div class="card shadow mb-4 tarjeta-verde">
            <div class="card-header custom-header text-white">
              Registro Histórico
            </div>
            
            <div class="card-body">

              <p class="text-muted mb-4">
                Registre la información relacionada con la adquisición, documentación legal y condición histórica del equipo biomédico.
              </p>

              <div class="row">

                <div class="col-md-4 mb-3">
                  <label class="fw-semibold">Tiempo de vida útil</label>
                  <input v-model="equipo.tiempo_vida_util" class="form-control" />
                </div>

                <div class="col-md-4 mb-3">
                  <label class="fw-semibold">Fecha de adquisición</label>
                  <input v-model="equipo.fecha_adquisicion" type="date" class="form-control" />
                </div>

                <div class="col-md-4 mb-3">
                  <label class="fw-semibold">Fecha de fabricación</label>
                  <input v-model="equipo.fecha_fabricacion" type="date" class="form-control" />
                </div>

                <hr class="separator-soft" />

                <div class="col-md-4 mb-3">
                  <label class="fw-semibold">Forma de adquisición</label>
                  <input v-model="equipo.forma_adquisicion" class="form-control" />
                </div>

                <div class="col-md-4 mb-3">
                  <label class="fw-semibold">Tipo de documento</label>
                  <input v-model="equipo.tipo_documento" class="form-control" />
                </div>

                <div class="col-md-4 mb-3">
                  <label class="fw-semibold">Número de documento</label>
                  <input v-model="equipo.numero_documento" class="form-control" />
                </div>

                <hr class="separator-soft" />

                <div class="col-md-4 mb-3">
                  <label class="fw-semibold">Propietario</label>
                  <input v-model="equipo.propietario" class="form-control" />
                </div>

                <div class="col-md-4 mb-3">
                  <label class="fw-semibold">Proveedor</label>
                  <input v-model="equipo.proveedor" class="form-control" />
                </div>

                <div class="col-md-4 mb-3">
                  <label class="fw-semibold">NIT</label>
                  <input v-model="equipo.nit" class="form-control" />
                </div>

                <div class="col-md-4 mb-3">
                  <label class="fw-semibold">Fecha fin garantía</label>
                  <input v-model="equipo.fecha_fin_garantia" type="date" class="form-control" />
                </div>

                <div class="col-md-6 mb-3 d-flex align-items-center mt-3">
                  <label class="fw-semibold me-3">¿Garantía vigente?</label>
                  <input type="checkbox" v-model="equipo.en_garantia" class="form-check-input" />
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

            <router-link to="/equipos" class="btn btn-secondary ms-2">
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
                Verifique y registre los documentos técnicos, normativos y del fabricante relacionados con el equipo,
                incluyendo manuales, certificados, protocolos y documentación legal.
              </p>

              <div class="row mb-4">

                <!-- listado de documentos -->
                <div 
                  class="col-md-4 mb-3" 
                  v-for="(field, key) in documentos" 
                  :key="key"
                >
                  <div class="form-check doc-item">
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
              class="btn custom-btn"
              @click="siguienteSeccion"
            >
              Siguiente sección
            </button>

            <router-link to="/equipos" class="btn btn-secondary ms-2">
              Cancelar
            </router-link>
          </div>

        </div>



        <!-- Información metrológica -->
        <div v-if="activeTab === 'metrologica'" class="tab-pane fade show active">

          <div class="card shadow mb-4 tarjeta-verde">
            <div class="card-header custom-header text-white">
              Información Metrológica
            </div>

            <div class="card-body">

              <p class="text-muted mb-4">
                Registre la información asociada a magnitudes, capacidades de medición y requerimientos técnicos de calibración y mantenimiento del equipo.
              </p>

              <div class="row mb-3">
                <div class="col-md-6 mb-3">
                  <label>Magnitud</label>
                  <input v-model="equipo.magnitud" class="form-control" placeholder="Ej: presión, temperatura, flujo" />
                </div>

                <div class="col-md-6 mb-3">
                  <label>Rango</label>
                  <input v-model="equipo.rango" class="form-control" placeholder="Ej: 0 - 200 mmHg" />
                </div>

                <div class="col-md-6 mb-3">
                  <label>Resolución</label>
                  <input v-model="equipo.resolucion" class="form-control" placeholder="Ej: 0.1 mmHg" />
                </div>

                <div class="col-md-6 mb-3">
                  <label>Rango de trabajo</label>
                  <input v-model="equipo.rango_trabajo" class="form-control" placeholder="Ej: 20 - 150 mmHg" />
                </div>
              </div>

              <hr>

              <div class="row">

                <div class="col-md-6 mb-3">
                  <label class="d-block">¿Requiere Mantenimiento?</label>
                  <div class="form-check form-switch mt-2">
                    <input 
                      class="form-check-input" 
                      type="checkbox" 
                      v-model="equipo.mantenimiento" 
                      id="switch-mantenimiento"
                    />
                    <label class="form-check-label" for="switch-mantenimiento">
                      {{ equipo.mantenimiento ? 'Sí' : 'No' }}
                    </label>
                  </div>
                </div>

                <div class="col-md-6 mb-3" v-if="equipo.mantenimiento">
                  <label>Frecuencia de Mantenimiento (en meses)</label>
                  <input 
                    type="number" 
                    v-model.number="equipo.frecuencia_mantenimiento" 
                    class="form-control" 
                    placeholder="Ej: 6"
                    min="1"
                  />
                </div>

                <div class="col-md-6 mb-3">
                  <label class="d-block">¿Requiere Calibración?</label>
                  <div class="form-check form-switch mt-2">
                    <input 
                      class="form-check-input" 
                      type="checkbox" 
                      v-model="equipo.calibracion" 
                      id="switch-calibracion"
                    />
                    <label class="form-check-label" for="switch-calibracion">
                      {{ equipo.calibracion ? 'Sí' : 'No' }}
                    </label>
                  </div>
                </div>

                <div class="col-md-6 mb-3" v-if="equipo.calibracion">
                  <label>Frecuencia de Calibración (en meses)</label>
                  <input 
                    type="number" 
                    v-model.number="equipo.frecuencia_calibracion" 
                    class="form-control" 
                    placeholder="Ej: 12"
                    min="1"
                  />
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

            <router-link to="/equipos" class="btn btn-secondary ms-2">
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
                <label class="form-label"><strong>Voltaje</strong></label>
                <input v-model="equipo.voltaje" class="form-control" placeholder="Ej: 120 VAC"/>
              </div>

              <div class="col-md-4 mb-3">
                <label class="form-label"><strong>Corriente</strong></label>
                <input v-model="equipo.corriente" class="form-control" placeholder="Ej: 5 A"/>
              </div>

              <div class="col-md-4 mb-3">
                <label class="form-label"><strong>Humedad (%HR)</strong></label>
                <input v-model="equipo.humedad" class="form-control" placeholder="Ej: 30–75"/>
              </div>

              <div class="col-md-3 mb-3">
                <label class="form-label"><strong>Temperatura (°C)</strong></label>
                <input v-model="equipo.temperatura" class="form-control" placeholder="Ej: 10–35"/>
              </div>

              <div class="col-md-3 mb-3">
                <label class="form-label"><strong>Dimensiones</strong></label>
                <input 
                  type="text"
                  v-model="equipo.dimensiones" 
                  class="form-control" 
                  placeholder="Ej: 30×50×40 cm"
                />
              </div>

              <div class="col-md-4 mb-3">
                <label class="form-label"><strong>Peso (Kg)</strong></label>
                <input v-model="equipo.peso" class="form-control" placeholder="Ej: 12.5"/>
              </div>

              <div class="col-md-12 mb-3">
                <label class="form-label"><strong>Otros</strong></label>
                <textarea v-model="equipo.otros" class="form-control" rows="2" placeholder="Ej: Requiere UPS, necesita conexión a red hospitalaria LAN…"></textarea>
              </div>
            </div>
          </div>

          <div class="text-end mt-4">
            <button class="btn btn-success px-4 me-2">
              Guardar equipo
            </button>

            <router-link to="/equipos" class="btn btn-secondary ms-2">
              Cancelar
            </router-link>
          </div>
        </div>



      </div>
    </form>
  </div>
</template>

<script setup>
import { ref, onMounted } from "vue";
import { useRoute, useRouter } from "vue-router";
import axios from "axios";

const route = useRoute();
const router = useRouter();

const mostrarNuevoServicio = ref(false);
const nuevoServicio = ref('');

// Estado principal
const equipo = ref({});
const justificacion = ref("");

// Tabs
const activeTab = ref("general");
const tabs = [
  { id: "general", label: "Información General" },
  { id: "historico", label: "Registro Histórico" },
  { id: "documentos", label: "Inventario Documentos" },
  { id: "metrologica", label: "Información Metrológica" },
  { id: "condiciones", label: "Condiciones Funcionamiento" },
];

// Listas reutilizadas
const serviciosDisponibles = [
  "LIME","Fotodermatología","Resonador","Oftalmología",
  "Trasplantes GICIG","Inmunodeficiencias Primarias","Grupo Reproducción","Patología","Dermatopatología"
];
const opcionesSede = [ 
  { value: 'Prado', label: 'Prado' },
  { value: 'SIU', label: 'SIU' },
  { value: 'San Vicente', label: 'San Vicente' },
];
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

const documentos = {
  hoja_vida: "Hoja de vida",
  registro_importacion: "Registro de importación",
  manual_operacion: "Manual de operación",
  manual_mantenimiento: "Manual de mantenimiento",
  guia_rapida: "Guía rápida",
  instructivo: "Instructivo",
  protocolo_mto: "Protocolo Mantenimiento",
};


// Tooltips / descripciones
const desc = {
  sede: "Sede institucional donde está ubicado el equipo",
  proceso: "Área o servicio donde se usa el equipo",
  nombre_equipo: "Nombre con el que se identifica el equipo",
  fecha_adquisicion: "Fecha en que se adquirió el equipo",
  propietario: "Dueño del equipo",
  proveedor: "Proveedor del equipo",
  calibracion: "Si requiere calibración periódica",
  calificacion_calibracion: "Resultado de la última calibración",
  voltaje: "Voltaje de operación",
  temperatura: "Temperatura ambiente de operación",
  hoja_vida: "Disponibilidad de hoja de vida del equipo",
  registro_importacion: "Registro de importación",
  manual_operacion: "Manual de operación del equipo",
  manual_mantenimiento: "Manual de mantenimiento del equipo",
  guia_rapida: "Guía rápida del equipo",
  instructivo: "Instructivo de residuos u operación",
  protocolo_mto: "Protocolo de mantenimiento preventivo",
};

// Cargar datos del equipo al montar
onMounted(async () => {
  try {
    const res = await axios.get(`http://127.0.0.1:8000/api/equipos/${route.params.id}/`);
    equipo.value = {
      ...res.data,
      clasificacion_misional: res.data.clasificacion_misional
        ? res.data.clasificacion_misional.split(",")   // Convertir string → array
        : []
    };
  } catch (error) {
    alert("Error al cargar los datos del equipo");
    console.error(error);
  }
});



// Navegación modular
const siguienteSeccion = () => {
  const indexActual = tabs.findIndex(tab => tab.id === activeTab.value);
  if (indexActual < tabs.length - 1) {
    activeTab.value = tabs[indexActual + 1].id;
  }
};

const agregarNuevoServicio = () => {
    const nuevo = nuevoServicio.value.trim();
    if (nuevo && !serviciosDisponibles.value.includes(nuevo)) {
        serviciosDisponibles.value.push(nuevo);        
        if (equipo.value) {
            equipo.value.proceso = nuevo; 
        }
        console.log(`[VERIFICACIÓN] Lista de servicios actualizada:`, serviciosDisponibles.value);
    } else {
        console.log(`[ADVERTENCIA] No se añadió: '${nuevo}' ya existe o está vacío.`);
    }    
    mostrarNuevoServicio.value = false;
    nuevoServicio.value = '';
};
// ----------------

// Guardar cambios
const guardarCambios = async () => {
  const payload = {
    ...equipo.value,
    fecha_adquisicion: equipo.value.fecha_adquisicion || null,
    fecha_fabricacion: equipo.value.fecha_fabricacion || null,
    fecha_fin_garantia: equipo.value.fecha_fin_garantia || null
  };
  
  if (Array.isArray(payload.clasificacion_misional)) {
    payload.clasificacion_misional = payload.clasificacion_misional.join(",");
  }


  try {
    await axios.put(`http://127.0.0.1:8000/api/equipos/${route.params.id}/modificar/`, payload);
    alert("Cambios guardados correctamente");
    router.push("/equipos");
  } catch (error) {
    alert("No se pudieron guardar los cambios");
    console.error(error);
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
