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
                <div class="col-md-6 mb-3">
                  <label>Clasificación Misional</label>

                  <div class="form-check" v-for="opcion in clasificacionesMisionales" :key="opcion.value">
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
                  <input v-model="equipo.fecha_adquisicion" class="form-control" />
                </div>

                <div class="col-md-4 mb-3">
                  <label>Fecha de fabricación</label>
                  <input v-model="equipo.fecha_fabricacion" class="form-control" />
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
                  <input v-model="equipo.fecha_fin_garantia" class="form-control" />
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
              <label>Dimensiones</label>
              <input 
                type="float" 
                v-model.float="equipo.dimensiones" 
                class="form-control" 
              />
            </div>
            
            <div class="col-md-4 mb-3">
              <label>Peso (Kg)</label>
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
import { ref, onMounted } from "vue";
import { useRoute, useRouter } from "vue-router";
import axios from "axios";

const route = useRoute();
const router = useRouter();

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
  "LIME","LIME - Hematología","Fotodermatología","Resonador","Oftalmología",
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
</style>
