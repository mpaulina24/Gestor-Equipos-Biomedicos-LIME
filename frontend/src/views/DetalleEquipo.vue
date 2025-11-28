<template>
  <div class="min-vh-100 bg-light py-4">
    <div class="container">

      <!-- Título central -->
      <h4 class="titulo-principal text-center fw-bold mb-4">
        Detalle del Equipo Médico
      </h4>

      <div v-if="equipo" class="card border-0 shadow-sm p-3 rounded-3">

        <!-- Información General -->
        <section class="mb-4">
          <h6 class="bloque-titulo">
            <i class="bi bi-info-circle me-2"></i> Información General
          </h6>
          
          <div class="row">
            <div v-for="campo in infoGeneral" :key="campo.key" class="col-md-4 mb-2">
              <div class="campo-box">
                <span class="campo-label">{{ campo.label }}</span>
                <span class="campo-valor">{{ equipo[campo.key] || '—' }}</span>
              </div>
            </div>
          </div>
        </section>

        <!-- Registro Histórico -->
        <section class="mb-4">
          <h6 class="bloque-titulo">
            <i class="bi bi-clock-history me-2"></i> Registro Histórico
          </h6>
          <div class="row">
            <div v-for="campo in registroHistorico" :key="campo.key" class="col-md-4 mb-2">
              <div class="campo-box">
                <span class="campo-label">{{ campo.label }}</span>
                <span class="campo-valor">{{ equipo[campo.key] || '—' }}</span>
              </div>
            </div>
          </div>
        </section>

        <!-- Inventario Documental -->
        <section class="mb-4">
          <h6 class="bloque-titulo">
            <i class="bi bi-folder-check me-2"></i> Inventario de Documentos
          </h6>
          <div class="row">
            <div v-for="campo in inventarioDocs" :key="campo.key" class="col-md-4 mb-2">
              <div class="campo-box">
                <span class="campo-label">{{ campo.label }}</span>
                <span class="campo-valor">{{ equipo[campo.key] || '—' }}</span>
              </div>
            </div>
          </div>
        </section>

        <!-- Información Metrológica Administrativa -->
        <section class="mb-4">
          <h6 class="bloque-titulo">
            <i class="bi bi-gear-wide-connected me-2"></i> Información Metrológica Administrativa
          </h6>
          <div class="row">
            <div v-for="campo in infoMetrologicaAdmin" :key="campo.key" class="col-md-4 mb-2">
              <div class="campo-box">
                <span class="campo-label">{{ campo.label }}</span>
                <span class="campo-valor">{{ equipo[campo.key] || '—' }}</span>
              </div>
            </div>
          </div>
        </section>

        <!-- Información Metrológica Técnica -->
        <section class="mb-4">
          <h6 class="bloque-titulo">
            <i class="bi bi-rulers me-2"></i> Información Metrológica Técnica
          </h6>
          <div class="row">
            <div v-for="campo in infoMetrologicaTec" :key="campo.key" class="col-md-4 mb-2">
              <div class="campo-box">
                <span class="campo-label">{{ campo.label }}</span>
                <span class="campo-valor">{{ equipo[campo.key] || '—' }}</span>
              </div>
            </div>
          </div>
        </section>

        <!-- Condiciones de Funcionamiento -->
        <section>
          <h6 class="bloque-titulo">
            <i class="bi bi-speedometer2 me-2"></i> Condiciones de Funcionamiento
          </h6>
          <div class="row">
            <div v-for="campo in condiciones" :key="campo.key" class="col-md-4 mb-2">
              <div class="campo-box">
                <span class="campo-label">{{ campo.label }}</span>
                <span class="campo-valor">{{ formatValue(equipo[campo.key]) }}</span>
              </div>
            </div>
          </div>
        </section>

      </div>

      <div class="d-flex justify-content-end mt-4">
        <router-link to="/equipos" class="btn btn btn-secondary px-4">
          ← Volver al Inventario
        </router-link>
      </div>

    </div>
  </div>
</template>


<script>
import axios from "axios";

export default {
  data() {
    return {
      equipo: null,
      infoGeneral: [
        { key: "sede", label: "Sede" },
        { key: "proceso", label: "Proceso" },
        { key: "nombre_equipo", label: "Nombre del Equipo" },
        { key: "codigo_interno", label: "Código Interno" },
        { key: "codigo_ips", label: "Código IPS" },
        { key: "codigo_ecri", label: "Código ECRI" },
        { key: "responsable", label: "Responsable" },
        { key: "ubicacion", label: "Ubicación" },
        { key: "marca", label: "Marca" },
        { key: "modelo", label: "Modelo" },
        { key: "serie", label: "Serie" },
        { key: "clasificacion_misional", label: "Clasificación Misional" },
        { key: "clasificacion_ips", label: "Clasificación IPS" },
        { key: "clasificacion_riesgo", label: "Clasificación de Riesgo" },
        { key: "registro_invima", label: "Registro Invima / Permiso Comercialización" },
      ],
      registroHistorico: [
        { key: "tiempo_vida_util", label: "Tiempo de Vida Útil" },
        { key: "fecha_adquisicion", label: "Fecha de Adquisición" },
        { key: "propietario", label: "Propietario" },
        { key: "fecha_fabricacion", label: "Fecha de Fabricación" },
        { key: "nit", label: "NIT" },
        { key: "proveedor", label: "Proveedor" },
        { key: "en_garantia", label: "En Garantía" },
        { key: "fecha_fin_garantia", label: "Fin de Garantía" },
        { key: "forma_adquisicion", label: "Forma de Adquisición" },
        { key: "tipo_documento", label: "Tipo de Documento" },
        { key: "numero_documento", label: "Número de Documento" },
      ],
      inventarioDocs: [
        { key: "hoja_vida", label: "Hoja de Vida" },
        { key: "registro_importacion", label: "Registro de Importación" },
        { key: "manual_operacion", label: "Manual de Operación" },
        { key: "manual_mantenimiento", label: "Manual de Mantenimiento" },
        { key: "guia_rapida", label: "Guía Rápida" },
        { key: "instructivo", label: "Instructivo" },
        { key: "protocolo_mto", label: "Protocolo de Mantenimiento Preventivo" },
        { key: "frecuencia_metrologica", label: "Frecuencia Metrológica Fabricante" },
      ],
      infoMetrologicaAdmin: [
        { key: "mantenimiento", label: "Mantenimiento" },
        { key: "frecuencia_mantenimiento", label: "Frecuencia anual de Mantenimiento" },
        { key: "calibracion", label: "Calibración" },
        { key: "frecuencia_calibracion", label: "Frecuencia anual de Calibración" },
      ],
      infoMetrologicaTec: [
        { key: "magnitud", label: "Magnitud" },
        { key: "rango", label: "Rango" },
        { key: "resolucion", label: "Resolución" },
        { key: "rango_trabajo", label: "Rango de Trabajo" },
        { key: "error_maximo", label: "Error Máximo Permitido" },
      ],
      condiciones: [
        { key: "voltaje", label: "Voltaje" },
        { key: "corriente", label: "Corriente" },
        { key: "humedad", label: "Humedad relativa" },
        { key: "temperatura", label: "Temperatura" },
        { key: "dimensiones", label: "Dimensiones" },
        { key: "peso", label: "Peso" },
        { key: "otros", label: "Otros" },
      ],
    };
  },

  methods: {
    formatValue(value) {
      if (value === null || value === undefined || value === "") {
        return '—';
      }
      const num = parseFloat(value);
      if (isNaN(num)) {
        return value;
      }
      return num.toFixed(2).replace('.', ',');
    },
  },
  mounted() {
    const id = this.$route.params.id;
    axios
      .get(`http://127.0.0.1:8000/api/equipos/${id}/`)
      .then((response) => {
        this.equipo = response.data;
      })
      .catch((error) => {
        console.error("Error al obtener detalles del equipo:", error);
      });
  },
  

};
</script>

<style scoped>
.section-title {
  color: #4CAF50;
  border-bottom: 2px solid #4CAF50;
  display: inline-block;
  margin-bottom: 1rem;
}

.card {
  border-left: 4px solid #4CAF50;
}

.bloque-titulo {
  font-weight: bold;
  color: #1B5E20;
  padding-bottom: 6px;
  margin-bottom: 12px;
  border-bottom: 2px solid #4CAF50;
}

.campo-box {
  background: white;
  border: 1px solid #e2e8f0;
  border-radius: 8px;
  padding: 8px 12px;
  display: flex;
  justify-content: space-between;
  align-items: center;
  transition: background 0.2s ease;
}

.campo-box:hover {
  background: #f3fdf6;
}

.campo-label {
  font-size: 0.9rem;
  font-weight: 500;
  color: #444;
}

.campo-valor {
  font-weight: bold;
  color: #111;
  font-size: 0.8rem
}

</style>
