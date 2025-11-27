<template>
  <footer class="footer">
    <div class="footer-content">

      <div class="logos">
        <img src="@/assets/UdeA.png" alt="UdeA" class="logo" />
        <img src="@/assets/AlmaMater.png" alt="Alma Mater" class="logo" />
        <img src="@/assets/LIME.png" alt="LIME" class="logo" />
      </div>

      <p class="footer-text">
        UNIÓN TEMPORAL LIME (Laboratorios Integrados de Medicina Especializada)
        unión temporal conformada en 2019 por la 
        <strong>Facultad de Medicina de la Universidad de Antioquia</strong>
        y el <strong>Hospital Alma Máter de Antioquia</strong>.
      </p>

    </div>
  </footer>
</template>

<style scoped>
.footer {
  background-color: #fff;
  padding: 20px 40px;
  border-top: 1px solid #e2e8f0;
  text-align: center;
}

.footer-content {
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 15px;
}

.logos {
  display: flex;
  gap: 30px;
  align-items: center;
}

.logo {
  height: 35px;
  object-fit: contain;
}

.footer-text {
  max-width: 900px;
  font-size: 12px;
  color: #475569;
  line-height: 1.4;
}
</style>
