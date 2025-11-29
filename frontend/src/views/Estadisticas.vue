<template>
  <div class="container py-4">

    <!-- HEADER -->
    <header class="dashboard-header rounded-4 mb-5 p-4 d-flex flex-column flex-md-row align-items-center gap-3">
      <div class="header-left text-center text-md-start">
        <h2 class="mb-1 titulo-principal">Estadísticas del Inventario</h2>
        <p class="mb-0 text-muted small">Visualización del estado actual del inventario del Laboratorio Integrado de Medicina</p>
      </div>

    </header>

    <section class="row g-4 mb-5 align-items-stretch">

      <!-- TARJETAS -->
      <div class="col-lg-8">
        <div class="row g-3">
          <div class="col-6" v-for="card in resumen" :key="card.titulo">
            <div class="stat-card d-flex flex-column justify-content-between p-3 h-100">
              <div>
                <div class="stat-title text-muted small">{{ card.titulo }}</div>
              </div>
              <div class="d-flex align-items-end justify-content-between mt-2">
                <div>
                  <div class="stat-value">{{ card.valor }}</div>
                  <div class="stat-sub small text-muted">registros</div>
                </div>
                <i class="bi bi-bar-chart-fill stat-icon"></i>
              </div>
            </div>
          </div>
        </div>
      </div>

      <!-- DOUGHNUT -->
      <div class="col-lg-4">
        <div class="card card-chart p-3 h-100 d-flex flex-column">
          <div class="d-flex justify-content-between align-items-center mb-2">
            <h6 class="mb-0 fw-bold">Distribución por sede</h6>
            <small class="text-muted">En tiempo real</small>
          </div>

          <div class="chart-box chart-sede mx-auto mb-1">
            <Doughnut :data="chartDataSede" :options="chartOptionsSede" />
          </div>

          <div class="d-flex justify-content-center mt-2">
            <small class="text-muted">Sedes con equipos operativos</small>
          </div>
        </div>
      </div>

    </section>

    <!-- CLASIFICACIONES - CONTENEDOR ÚNICO -->
    <section class="card classifications-card border-0 shadow-sm rounded-4 p-4 mb-5">
      <div class="d-flex justify-content-between align-items-center mb-3">
        <h5 class="mb-0 fw-bold">Clasificaciones</h5>
        <div>
        </div>
      </div>

      <div class="row g-4 align-items-stretch">
        <!-- MISIONAL -->
        <div class="col-md-4">
          <div class="mini-card p-3 h-100 d-flex flex-column">
            <div class="chart-box mx-auto">
              <Doughnut :data="chartDataMisional" :options="chartOptionsMisional" />
            </div>
          </div>
        </div>

        <!-- IPS -->
        <div class="col-md-4">
          <div class="mini-card p-3 h-100 d-flex flex-column">
            <div class="chart-box mx-auto">
              <Doughnut :data="chartDataIPS" :options="chartOptionsIPS" />
            </div>
          </div>
        </div>

        <!-- RIESGO -->
        <div class="col-md-4">
          <div class="mini-card p-3 h-100 d-flex flex-column">
            <div class="chart-box mx-auto">
              <Doughnut :data="chartDataRiesgo" :options="chartOptionsRiesgo" />
            </div>
          </div>
        </div>
      </div>
    </section>

  </div>
</template>


<script setup>

import { Doughnut } from 'vue-chartjs'
import {
  Chart as ChartJS,
  Title,
  Tooltip,
  Legend,
  ArcElement
} from 'chart.js'

ChartJS.register(Title, Tooltip, Legend, ArcElement)

import { ref, computed, onMounted } from "vue";
import axios from "axios";

const equiposRaw = ref([]);
const inactivosRaw = ref([]);

const azulPalette = [
  "#2563EB",  // Azul medio
  "#3B82F6",  // Azul claro
  "#60A5FA",  // Celeste
  "#93C5FD",  // Celeste muy claro
  "#BFDBFE"   // Azul pastel
];

const normalize = (eq) => {
  const sede = (eq.sede || eq.location || "").toString().trim();
  let misional = (eq.clasificacion_misional || "").toString().trim();
  let ips = (eq.clasificacion_ips || "").toString().trim();
  let riesgo = (eq.clasificacion_riesgo || "").toString().trim();

  if ((!misional && !ips && !riesgo) && eq.clasificacion) {
    const parts = eq.clasificacion.toString().split("/").map(s => s.trim()).filter(Boolean);
    misional = parts[0] || misional;
    ips = parts[1] || ips;
    riesgo = parts[2] || riesgo;
  }

  const normalizeValue = (v) => v ? v.replace(/\s+/g, " ").trim() : "";

  return {
    id: eq.id,
    sede: normalizeValue(sede),
    misional: normalizeValue(misional),
    ips: normalizeValue(ips),
    riesgo: normalizeValue(riesgo),
    proceso: (eq.proceso || eq.servicio || "").toString().trim(),
  };
};

const cargarDatos = async () => {
  try {
    const [actRes, inactRes] = await Promise.all([
      axios.get("http://127.0.0.1:8000/api/equipos/"),
      axios.get("http://127.0.0.1:8000/api/equipos/inactivos/"),
    ]);
    equiposRaw.value = (actRes.data || []).map(normalize);
    inactivosRaw.value = (inactRes.data || []).map(normalize);
  } catch (error) {
    console.error("Error cargando datos para estadísticas:", error);
    equiposRaw.value = [];
    inactivosRaw.value = [];
  }
};

onMounted(cargarDatos);

const resumen = computed(() => {
  const activos = equiposRaw.value.length;
  const inactivos = inactivosRaw.value.length;
  const total = activos + inactivos;
  const procesosUnicos = new Set(
    equiposRaw.value.map(e => (e.proceso || "").trim()).filter(Boolean)
  ).size;

  return [
    { titulo: "Total equipos registrados", valor: total },
    { titulo: "Equipos operativos", valor: activos },
    { titulo: "Equipos dados de baja", valor: inactivos },
    { titulo: "Total de servicios", valor: procesosUnicos }
  ];
});

const porSede = computed(() => {
  const result = { Prado: 0, SIU: 0, "San Vicente": 0 };

  equiposRaw.value.forEach(eq => {
    const s = (eq.sede || "").trim();
    if (!s) return;
    if (/prado/i.test(s)) result.Prado += 1;
    else if (/siu/i.test(s)) result.SIU += 1;
    else if (/san vicente/i.test(s)) result["San Vicente"] += 1;
    else result[s] = (result[s] || 0) + 1;
  });

  return result;
});

const chartDataSede = computed(() => ({
  labels: Object.keys(porSede.value),
  datasets: [
    { data: Object.values(porSede.value),
    backgroundColor: azulPalette,
    borderColor: "#ffffff",
    borderWidth: 2
    }
  ]
}));

const chartOptionsSede = {
  responsive: true,
  plugins: {
    legend: { display: true, position: "bottom" },
    title: { display: true, text: "Equipos por sede" }
  }
};

const porMisional = computed(() => {
  const keys = ["Docencia", "Investigación", "Extensión"];
  const result = {};
  keys.forEach(k => (result[k] = 0));

  equiposRaw.value.forEach(eq => {
    const v = (eq.misional || "").trim();
    if (!v) return;
    if (/docen/i.test(v)) result["Docencia"] += 1;
    else if (/investig/i.test(v)) result["Investigación"] += 1;
    else if (/exten/i.test(v)) result["Extensión"] += 1;
    else result[v] = (result[v] || 0) + 1;
  });

  return result;
});

const porIPS = computed(() => {
  const result = { IND: 0, BIO: 0, Gases: 0 };

  equiposRaw.value.forEach(eq => {
    const v = (eq.ips || "").toUpperCase().trim();
    if (!v) return;
    if (v === "IND") result.IND += 1;
    else if (v === "BIO") result.BIO += 1;
    else if (/GAS/i.test(v)) result.Gases += 1;
    else result[v] = (result[v] || 0) + 1;
  });

  return result;
});

const porRiesgo = computed(() => {
  const result = {
    "Clase I": 0,
    "Clase IIa": 0,
    "Clase IIb": 0,
    "Clase III": 0,
    "NI": 0
  };

  equiposRaw.value.forEach(eq => {
    let v = (eq.riesgo || "").toString().toLowerCase().replace(/\s+/g, "");

    // Normalización avanzada
    if (!v || v === "na" || v === "noaplica" || v === "noinformado") {
      result["NI"] += 1;
    } 
    else if (v === "i" || v === "clasei") {
      result["Clase I"] += 1;
    }
    else if (v === "iia" || v === "claseiia") {
      result["Clase IIa"] += 1;
    }
    else if (v === "iib" || v === "claseiib") {
      result["Clase IIb"] += 1;
    }
    else if (v === "iii" || v === "claseiii") {
      result["Clase III"] += 1;
    }
    else {
      // Si llega un dato raro, lo enviamos a NI
      result["NI"] += 1;
    }
  });

  return result;
});


const chartDataMisional = computed(() => ({
  labels: Object.keys(porMisional.value),
  datasets: [
    { data: Object.values(porMisional.value),
    backgroundColor: azulPalette,
    borderColor: "#ffffff",
    borderWidth: 2 }
  ]
}));

const chartOptionsMisional = {
  responsive: true,
  plugins: {
    legend: { display: true, position: "bottom" },
    title: { display: true, text: "Clasificación misional" }
  }
};

const chartDataIPS = computed(() => ({
  labels: Object.keys(porIPS.value),
  datasets: [
    { data: Object.values(porIPS.value),
    backgroundColor: azulPalette,
    borderColor: "#ffffff",
    borderWidth: 2 }
  ]
}));

const chartOptionsIPS = {
  responsive: true,
  plugins: {
    legend: { display: true, position: "bottom" },
    title: { display: true, text: "Clasificación IPS" }
  }
};

const chartDataRiesgo = computed(() => ({
  labels: Object.keys(porRiesgo.value),
  datasets: [
    { data: Object.values(porRiesgo.value),
    backgroundColor: azulPalette,
    borderColor: "#ffffff",
    borderWidth: 2 }
  ]
}));

const chartOptionsRiesgo = {
  responsive: true,
  plugins: {
    legend: { display: true, position: "bottom" },
    title: { display: true, text: "Clasificación por riesgo" }
  }
};
</script>

<style scoped>
.titulo-principal {
  color: var(--gris-oscuro);
}
.chart-sede {
  max-width: 200px !important;   
  height: 180px !important;      
}


:root {
  --brand-50: #eff6ff;
  --brand-100: #dbeafe;
  --brand-500: #2563eb;
  --brand-600: #1d4ed8;
  --muted: #6b7280;
  --card-radius: 12px;

  --alto-charts: 300px;
}

/* Header / banner */
.dashboard-header {
  background: linear-gradient(90deg, rgba(37,99,235,0.10), rgba(59,130,246,0.06));
  border-radius: var(--card-radius);
  box-shadow: 0 6px 18px rgba(15,23,42,0.04);
}

/* Stat cards */
.stat-card {
  background: linear-gradient(180deg, white 0%, var(--brand-50) 100%);
  border-radius: 10px;
  box-shadow: 0 6px 18px rgba(15,23,42,0.04);
  min-height: 110px;
  transition: transform .15s ease, box-shadow .15s ease;
}
.stat-card:hover {
  transform: translateY(-4px);
  box-shadow: 0 10px 30px rgba(15,23,42,0.08);
}
.stat-title {
  letter-spacing: .2px;
}
.stat-value {
  font-size: 1.6rem;
  font-weight: 700;
  color: var(--brand-600);
}
.stat-sub {
  color: var(--muted);
  font-size: .78rem;
}
.stat-icon {
  font-size: 1.6rem;
  color: rgba(37,99,235,0.15);
}

/* Card for main pie */
.card-chart {
  border-radius: var(--card-radius);
  background: linear-gradient(180deg, #ffffff, #fbfdff);
  box-shadow: 0 6px 26px rgba(15,23,42,0.04);
  display: flex;
}

/* Container where each chart sits */
.chart-box {
  width: 100%;
  max-width: 320px;
  height: var(--alto-charts);
  display: flex;
  align-items: center;
  justify-content: center;
}

/* Classifications container */
.classifications-card {
  background: linear-gradient(180deg, #ffffff, #f8fbff);
  border-radius: var(--card-radius);
  box-shadow: 0 8px 28px rgba(15,23,42,0.04);
}

/* mini cards inside classifications */
.mini-card {
  background: rgba(255,255,255,0.9);
  border-radius: 10px;
  box-shadow: 0 6px 18px rgba(15,23,42,0.03);
  min-height: calc(var(--alto-charts) + 40px);
  display: flex;
  flex-direction: column;
  justify-content: flex-start;
}

/* small title inside mini card */
.mini-title {
  font-size: .95rem;
  color: var(--brand-600);
}

/* Responsive tweaks */
@media (max-width: 991px) {
  .chart-box { max-width: 260px; --alto-charts: 250px; }
  .stat-card { min-height: 100px; }
}
</style>
