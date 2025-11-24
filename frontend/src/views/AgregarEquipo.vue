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

        <!-- Información General -->
        <div v-if="activeTab === 'general'" class="tab-pane fade show active">
          <div class="card shadow mb-4">            
            <div class="card-header custom-header text-white">Información General</div>
            <div class="card-body">
              <div class="row">               
                
                <div class="col-md-4 mb-3">
                  <label>Sede multicentro</label>
                  <select v-model="equipo.sede" class="form-select" required>
                    <option value="" disabled>Seleccione la Sede</option>
                    <option 
                      v-for="opcion in opcionesSede" 
                      :key="opcion.value" 
                      :value="opcion.value"
                    >
                      {{ opcion.label }}
                    </option>
                  </select>
                </div> 
                
                <div class="card-body">
                  <div class="row">

                    <div class="col-md-4 mb-3">
                      <label>Proceso/Servicio</label>
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
                          class="btn btn-outline-success" 
                          type="button" 
                          @click="mostrarNuevoServicio = true"
                          v-if="!mostrarNuevoServicio"
                        >
                          + Nuevo
                        </button>
                      </div>
                    </div>
                    
                    <div v-if="mostrarNuevoServicio" class="col-md-8 mb-3">
                        <label>Ingresar Nuevo Servicio/Proceso</label>
                        <div class="input-group">
                            <input 
                              v-model="nuevoServicio" 
                              class="form-control" 
                              placeholder="Ej: LIME - Genética"
                            />
                            <button 
                                class="btn btn-success" 
                                type="button" 
                                @click="agregarNuevoServicio"
                            >
                                Guardar Nuevo
                            </button>
                            <button 
                                class="btn btn-secondary" 
                                type="button" 
                                @click="mostrarNuevoServicio = false; nuevoServicio = ''"
                            >
                                Cancelar
                            </button>
                        </div>
                    </div>
                    
                    </div>
                </div>

                </div>                
            </div>

            <div class="card-body">
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

                <!-- Secciones para Clasificación -->
                <div class="row mt-3">                  
                <div class="col-md-3 mb-3">
                  <label>Clasificación Misional</label>
                  <select v-model="equipo.clasificacion_misional" class="form-select">
                    <option value="" disabled>Seleccione</option>
                    <option 
                      v-for="opcion in clasificacionesMisionales" 
                      :key="opcion.value" 
                      :value="opcion.value"
                    >
                      {{ opcion.label }}
                    </option>
                  </select>
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
                

                <div class="row mt-3">  
                  <div class="col-md-3 mb-3 d-flex align-items-center">
                    <div>
                      <label class="d-block">¿Requiere Registro INVIMA?</label>
                      <div class="form-check form-switch mt-2">
                        <input 
                          class="form-check-input" 
                          type="checkbox" 
                          v-model="equipo.requiere_invima" 
                          id="switchInvima"
                          
                          @change="equipo.registro_invima = equipo.requiere_invima ? '' : 'No requiere'" 
                          >
                        <label class="form-check-label" for="switchInvima">
                          {{ equipo.requiere_invima ? 'Sí' : 'No' }}
                        </label>
                      </div>
                    </div>
                  </div>
                  
                  <div class="col-md-9 mb-3">
                    <label>Registro INVIMA / Permiso Comercialización</label>
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

        <!-- Registro Histórico -->
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
                  <label>Fecha de fabricación</label>
                  <input type="date" v-model="equipo.fecha_fabricacion" class="form-control" />
                </div>

                <div class="col-md-4 mb-3">
                  <label>Forma de adquisición</label>
                  <input v-model="equipo.forma_adquisicion" class="form-control" />
                </div>
                <div class="col-md-4 mb-3">
                  <label>Tipo de documento</label>
                  <input v-model="equipo.tipo_documento" class="form-control" />
                </div>
                <div class="col-md-4 mb-3">
                  <label>Numero de documento</label>
                  <input v-model="equipo.numero_documento" class="form-control" />
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
                  <label>El equipo se encuentra en garantía vigente.  </label>
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

        <!----------- Inventario de documentos ------------->

        
        <div v-if="activeTab === 'documentos'" class="tab-pane fade show active">
        <div class="card shadow mb-4">
          <div class="card-header custom-header text-white">Inventario de Documentos y Frecuencias Administrativas</div>
          <div class="card-body">
            
            <h5 class="mb-3">Disponibilidad de Documentos / Datos del Fabricante</h5>
            <div class="row mb-4">
              <div class="col-md-4 mb-3" v-for="(field, key) in documentos" :key="key">
                <div class="form-check">
                  <input class="form-check-input" type="checkbox" v-model="equipo[key]" :id="'doc-' + key" />
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
          <router-link to="/equipos" class="btn btn-success ms-2">
            Ver Inventario
          </router-link>
        </div>
        </div>



        <!-- Información metrológica -->
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

              <hr>

            <h5 class="mb-3">Configuración de Mantenimiento y Calibración</h5>
            <div class="row">
              
              <div class="col-md-6 mb-3">
                <label>¿Requiere Mantenimiento?</label>
                <div class="form-check form-switch mt-2">
                  <input class="form-check-input" type="checkbox" v-model="equipo.mantenimiento" id="switch-mantenimiento">
                  <label class="form-check-label" for="switch-mantenimiento">
                    **{{ equipo.mantenimiento ? 'Sí' : 'No' }}**
                  </label>
                </div>
              </div>
              <div class="col-md-6 mb-3" v-if="equipo.mantenimiento">
                <label>Frecuencia Mantenimiento (en meses)</label>
                <input 
                  type="number" 
                  v-model.number="equipo.frecuencia_mantenimiento" 
                  class="form-control" 
                  placeholder="Ej: 6"
                />
              </div>

              <div class="col-md-6 mb-3">
                <label>¿Requiere Calibración?</label>
                <div class="form-check form-switch mt-2">
                  <input class="form-check-input" type="checkbox" v-model="equipo.calibracion" id="switch-calibracion">
                  <label class="form-check-label" for="switch-calibracion">
                    **{{ equipo.calibracion ? 'Sí' : 'No' }}**
                  </label>
                </div>
              </div>
              <div class="col-md-6 mb-3" v-if="equipo.calibracion">
                <label>Frecuencia Calibración (en meses)</label>
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

        <!-- Condiciones de funcionamiento -->
        
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
              <label>Humedad (%HR)</label>
              <input v-model="equipo.humedad" class="form-control" />
            </div>
            
            <div class="col-md-3 mb-3">
              <label>Temperatura (°C)</label>
              <input v-model="equipo.temperatura" class="form-control" />
            </div>
            
            <div class="col-md-3 mb-3">
              <label>Alto (cm)</label>
              <input 
                type="float" 
                v-model.float="equipo.dimensiones_alto" 
                class="form-control" 
                placeholder="Alto"
              />
            </div>
            <div class="col-md-3 mb-3">
              <label>Ancho (cm)</label>
              <input 
                type="float" 
                v-model.float="equipo.dimensiones_ancho" 
                class="form-control" 
                placeholder="Ancho"
              />
            </div>
            <div class="col-md-3 mb-3">
              <label>Profundidad (cm)</label>
              <input 
                type="float" 
                v-model.float="equipo.dimensiones_profundidad" 
                class="form-control" 
                placeholder="Profundidad"
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
  sede: "",
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
  dimensiones_alto: null,      // Mapea a IntegerField
  dimensiones_ancho: null,     // Mapea a IntegerField
  dimensiones_profundidad: null, // Mapea a IntegerField
  peso: "",
  otros: "",

});

//  Opciones Iniciales de Proceso/Servicio
const serviciosDisponibles = ref([
    'LIME',
    'LIME - Hematología',
    'LIME - Citometría de Flujo',
    'LIME - Almacén',
    'LIME - Atención a Pacientes',
    'LIME - Biología Molecular',
    'LIME - Microbiología',
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
    const response = await axios.post("http://127.0.0.1:8000/api/equipos/agregarEquipo/", equipo.value);
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
</style>
