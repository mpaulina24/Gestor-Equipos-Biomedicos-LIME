<template>
  <div class="min-vh-100 py-5 bg-light">
    <!-- 🔹 Descripción principal -->
    <section class="hero-section d-flex align-items-center justify-content-center text-center text-white mb-5">
      <div class="overlay"></div>
      <div class="container position-relative z-2 px-4">
        <h1 class="display-5 fw-bold mb-3">Sistema de Gestión de Equipos Médicos</h1>
        <p class="lead mx-auto" style="max-width: 800px;">
          El <strong>Sistema de Gestión de Equipos Médicos</strong> del Laboratorio Integrado de Medicina Especializada (LIME),
          desarrollado en el curso de <strong>Ingeniería de Software de la Universidad de Antioquia</strong>, permite
          registrar y monitorear los equipos biomédicos de las distintas sedes.
          Garantiza trazabilidad, seguridad y eficiencia en la gestión tecnológica de los dispositivos médicos institucionales.
        </p>
      </div>
    </section>

    <!-- 🔹 Contenido dividido -->
    <div class="container-fluid px-4">
      <div class="row g-4">
        <!-- 🔸 Columna izquierda: sedes -->
        <div class="col-lg-8">
          <div class="row g-4">
            <div
              v-for="(sede, index) in sedes"
              :key="index"
              class="col-12"
            >
              <div class="card h-100 shadow-sm border-0 hover-shadow">
                <div class="card-body d-flex align-items-start">
                  <div
                    class="flex-shrink-0 bg-success bg-opacity-10 text-success rounded-circle d-flex align-items-center justify-content-center me-3"
                    style="width:60px; height:60px; font-size:1.5rem;"
                  >
                    <i :class="sede.icono"></i>
                  </div>
                  <div>
                    <h5 class="titulo-secundario">{{ sede.nombre }}</h5>
                    <p class="text-muted mb-2"><i class="bi bi-geo-alt-fill me-1"></i>{{ sede.direccion }}</p>
                    <p class="card-text text-justify">{{ sede.descripcion }}</p>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>

        <!-- Columna derecha: imágenes institucionales -->
        <div class="col-lg-4">
  <div class="card contacto-card shadow-sm border-0 p-4 text-center">

    <!-- Imagen institucional -->
    <div class="contacto-imagen mb-3">
      <img src="/src/assets/Logos.png"
           alt="LIME Logos"
           class="img-fluid contacto-logo">
    </div>

    <!-- Texto principal -->
    <h5 class="fw-bold text-success mb-2">
      Laboratorio Integrado de Medicina Especializada
    </h5>

    <p class="contacto-descripcion mb-4">
      Procedimientos especializados, precisos y oportunos 
      para mejorar y salvar vidas.
      <br>
      <strong>Agenda tu cita o consulta nuestros servicios:</strong>
    </p>

    <!-- Botón Linktree -->
    <a href="https://linktr.ee/lime.udea"
       target="_blank"
       class="btn btn-success w-100 py-2 fw-semibold shadow-sm contacto-boton">
      Contáctanos aquí
    </a>

  </div>
</div>

      </div>
    </div>
  </div>
</template>

<script setup>
const sedes = [
  {
    nombre: "Sede Prado – Hospital Alma Máter, Sede Ambulatoria",
    direccion: " Calle 64 #51 - 31. Bloque B, piso 2. Medellín , Antioquia.",
    descripcion:
      "Servicios: LIME, Centro de resonancia, Fotodermatología, Resonador, Oftalmología",
      icono: "bi bi-hospital",
  },
  {
    nombre: "Sede SIU – Sede de Investigación Universitaria",
    direccion: "Cl. 62 #52-59, Medellín",
    descripcion:
      "Servicios: Transplantes GICIG, Inmunodeficiencias primarias, Grupo Reproducción",
    icono: "bi bi-hospital",
  },
  {
    nombre: "Sede San Vicente",
    direccion: "Cl. 64 #51D - 154, Medellín",
    descripcion:
      "Servicios: Patología, Dermatopatología",
    icono: "bi bi-hospital",
  },
];
</script>

<style scoped>
.hover-shadow:hover {
  transform: translateY(-5px);
  box-shadow: 0 10px 25px rgba(0, 0, 0, 0.15);
  transition: all 0.3s ease;
}

.card-title {
  font-weight: 600;
  font-size: 0.88rem;
}

.card-text {
  font-size: 0.88rem;
}

.contacto-card {
  border-radius: 14px;
  background-color: #ffffff;
}

.contacto-logo {
  width: 85%;
  max-height: 130px;
  object-fit: contain;
  filter: drop-shadow(0px 3px 5px rgba(0,0,0,0.1));
}

.contacto-descripcion {
  font-size: 0.95rem;
  color: #475569;
  line-height: 1.5;
}

.contacto-boton {
  border-radius: 8px;
  font-size: 1rem;
}

.contacto-boton:hover {
  transform: translateY(-2px);
  transition: all 0.2s ease;
}

</style>
