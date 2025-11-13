<template>
  <div class="container mt-5">
    <h3 class="text-success mb-4 text-center">
      Detalle del Equipo Médico
    </h3>

    <div v-if="equipo" class="card shadow-sm p-4">
      <!-- 🧾 Información General -->
      <section class="mb-4">
        <h5 class="section-title">Información General</h5>
        <div class="row">
          <div v-for="campo in infoGeneral" :key="campo.key" class="col-md-4 mb-2">
            <strong>{{ campo.label }}:</strong> {{ equipo[campo.key] || '—' }}
          </div>
        </div>
      </section>

      <!-- 📜 Registro Histórico -->
      <section class="mb-4">
        <h5 class="section-title">Registro Histórico</h5>
        <div class="row">
          <div v-for="campo in registroHistorico" :key="campo.key" class="col-md-4 mb-2">
            <strong>{{ campo.label }}:</strong> {{ equipo[campo.key] || '—' }}
          </div>
        </div>
      </section>

      <!-- 📂 Inventario de Documentos -->
      <section class="mb-4">
        <h5 class="section-title">Inventario de Documentos</h5>
        <div class="row">
          <div v-for="campo in inventarioDocs" :key="campo.key" class="col-md-4 mb-2">
            <strong>{{ campo.label }}:</strong>
            <span :class="{'text-success fw-bold': equipo[campo.key], 'text-danger': !equipo[campo.key]}">
              {{ equipo[campo.key] ? 'Sí' : 'No' }}
            </span>
          </div>
        </div>
      </section>

      <!-- ⚙️ Información Metrológica Administrativa -->
      <section class="mb-4">
        <h5 class="section-title">Información Metrológica Administrativa</h5>
        <div class="row">
          <div v-for="campo in infoMetrologicaAdmin" :key="campo.key" class="col-md-4 mb-2">
            <strong>{{ campo.label }}:</strong> {{ equipo[campo.key] || '—' }}
          </div>
        </div>
      </section>

      <!-- 🔬 Información Metrológica Técnica -->
      <section class="mb-4">
        <h5 class="section-title">Información Metrológica Técnica</h5>
        <div class="row">
          <div v-for="campo in infoMetrologicaTec" :key="campo.key" class="col-md-4 mb-2">
            <strong>{{ campo.label }}:</strong> {{ equipo[campo.key] || '—' }}
          </div>
        </div>
      </section>

      <!-- 🌡️ Condiciones de Funcionamiento -->
      <section>
        <h5 class="section-title">Condiciones de Funcionamiento</h5>
        <div class="row">
          <div v-for="campo in condiciones" :key="campo.key" class="col-md-4 mb-2">
            <strong>{{ campo.label }}:</strong> {{ equipo[campo.key] || '—' }}
          </div>
        </div>
      </section>
    </div>

    <div class="d-flex justify-content-end mt-4">
      <router-link to="/equipos" class="btn btn-outline-success">
        <i class="bi bi-arrow-left"></i> Volver al Inventario
      </router-link>
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
</style>
