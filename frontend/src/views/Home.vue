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
        <div class="col-lg-4 d-flex flex-column gap-4">
          <!-- Card UdeA 
          <div class="card shadow-sm" style="height: 250px;">
            <img src="/src/assets/FotoUdeA.png" class="card-img-top" alt="UdeA" style="height: 180px; object-fit: cover;">
            <div class="card-body text-center position-relative pt-4">
              <div class="position-absolute top-0 start-50 translate-middle" style="margin-top: 0px; width: 150px; height: 70px;">
                <img src="/src/assets/UdeA.png" class="img-fluid" style="width: 100%; height: 100%; object-fit: contain;" alt="UdeA Foto">
              </div>
              <h5 class="titulo-principal-gris">Universidad de Antioquia</h5>
            </div>
          </div>
          -->

          <!-- Card LIME -->
          <div class="card shadow-sm" style="height: 250px;">
            <img src="/src/assets/LIME.png" class="card-img-top" alt="LIME" style="height: 170px; object-fit: cover;">
            <div class="card-body text-center position-relative pt-4">
              <div class="position-absolute top-0 start-50 translate-middle" style="margin-top: -10px; width: 150px; height: 70px;">
                <img src="/src/assets/LIME.png" class="img-fluid"  style="width: 100%; height: 100%; object-fit: contain;" alt="LIME Foto">
              </div>
              <h5 class="titulo-principal-gris">Laboratorio Integrado de Medicina Especializada</h5>
            </div>
          </div>

          <!-- Card Alma Mater 
          <div class="card shadow-sm" style="height: 250px;">
            <img src="/src/assets/FotoAlmaMater.png" class="card-img-top" alt="Alma Mater" style="height: 180px; object-fit: cover;">
            <div class="card-body text-center position-relative pt-4">
              <div class="position-absolute top-0 start-50 translate-middle" style="margin-top: 0px; width: 150px; height: 70px;">
                <img src="/src/assets/AlmaMater.png" class="img-fluid" style="width: 100%; height: 100%; object-fit: contain;" alt="Alma Mater Foto">
              </div>
              <h5 class="titulo-principal-gris">Hospital Alma Máter de Antioquia</h5>
            </div>
          </div>
          -->
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
      "Cuenta con los servicios LIME, Centro de resonancia, Fotodermatología, Resonador, Oftalmología...",
      icono: "bi bi-hospital",
  },
  {
    nombre: "Sede SIU",
    direccion: "Cl. 62 #52-59, Medellín",
    descripcion:
      "Cuenta con los servicios Transplantes GICIG, Inmunodeficiencias primarias, Grupo Reproducción...",
    icono: "bi bi-hospital",
  },
  {
    nombre: "Sede San Vicente",
    direccion: "Especificar dirección",
    descripcion:
      "Cuenta con los servicios Patología, Dermatopatología",
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
}

.card-text {
  font-size: 0.95rem;
}
</style>
