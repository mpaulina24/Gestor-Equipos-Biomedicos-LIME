<template>
  <div class="login-container">
    <div class="login-card">
      <div class="login-header">
        <img src="@/assets/LIME.png" alt="LIME" class="login-logo" />
        <h2 class="login-title">Sistema de Gestión de Equipos</h2>
        <p class="login-subtitle">Iniciar Sesión</p>
      </div>

      <form @submit.prevent="login" class="login-form">
        <div class="form-group">
          <label for="usuario">Usuario</label>
          <input
            type="text"
            id="usuario"
            v-model="credenciales.nombreusuario"
            class="form-control"
            placeholder="Ingrese su usuario"
            required
          />
        </div>

        <div class="form-group">
          <label for="password">Contraseña</label>
          <input
            type="password"
            id="password"
            v-model="credenciales.contraseña"
            class="form-control"
            placeholder="Ingrese su contraseña"
            required
          />
        </div>

        <button type="submit" class="btn-login" :disabled="cargando">
          <span v-if="cargando">Iniciando...</span>
          <span v-else>Iniciar Sesión</span>
        </button>

        <div v-if="error" class="alert alert-error">
          {{ error }}
        </div>
      </form>

      <div class="login-footer">
        <p>Sistema de Gestión de Equipos Médicos - LIME</p>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import { useRouter } from 'vue-router'
import axios from 'axios'
import { useAuthStore } from '@/stores/auth'

const router = useRouter()
const authStore = useAuthStore()
const cargando = ref(false)
const error = ref('')

const credenciales = ref({
  nombreusuario: '',
  contraseña: ''
})

// Redirigir si ya está autenticado
onMounted(() => {
  if (authStore.isAuthenticated) {
    router.push('/home')
  }
})

const login = async () => {
  cargando.value = true
  error.value = ''

  try {
    const response = await axios.post('http://127.0.0.1:8000/api/auth/login/', credenciales.value)
    
    if (response.data.success) {
      console.log('Login exitoso:', response.data.usuario)
      authStore.login(response.data.usuario)
      
      // Pequeño delay para asegurar que el store se actualice
      setTimeout(() => {
        router.push('/home')
      }, 100)
    } else {
      error.value = response.data.error
    }
  } catch (err) {
    console.error('Error en login:', err)
    if (err.response?.data?.error) {
      error.value = err.response.data.error
    } else {
      error.value = 'Error de conexión. Intente nuevamente.'
    }
  } finally {
    cargando.value = false
  }
}
</script>

<style scoped>
.login-container {
  min-height: 100vh;
  display: flex;
  align-items: center;
  justify-content: center;
  background: linear-gradient(135deg, #1B5E20 0%, #388E3C 100%);
  padding: 20px;
}

.login-card {
  background: white;
  border-radius: 12px;
  box-shadow: 0 10px 30px rgba(0, 0, 0, 0.2);
  padding: 40px;
  width: 100%;
  max-width: 400px;
}

.login-header {
  text-align: center;
  margin-bottom: 30px;
}

.login-logo {
  height: 60px;
  margin-bottom: 15px;
}

.login-title {
  color: #1B5E20;
  font-weight: 700;
  margin-bottom: 5px;
  font-size: 1.5rem;
}

.login-subtitle {
  color: #666;
  margin: 0;
}

.form-group {
  margin-bottom: 20px;
}

.form-group label {
  display: block;
  margin-bottom: 5px;
  font-weight: 600;
  color: #333;
}

.form-control {
  width: 100%;
  padding: 12px 15px;
  border: 2px solid #e2e8f0;
  border-radius: 8px;
  font-size: 1rem;
  transition: border-color 0.3s ease;
}

.form-control:focus {
  outline: none;
  border-color: #1B5E20;
}

.btn-login {
  width: 100%;
  padding: 12px;
  background-color: #1B5E20;
  color: white;
  border: none;
  border-radius: 8px;
  font-size: 1rem;
  font-weight: 600;
  cursor: pointer;
  transition: background-color 0.3s ease;
}

.btn-login:hover:not(:disabled) {
  background-color: #388E3C;
}

.btn-login:disabled {
  background-color: #a5d6a7;
  cursor: not-allowed;
}

.alert-error {
  background-color: #ffebee;
  color: #c62828;
  padding: 12px;
  border-radius: 6px;
  margin-top: 15px;
  text-align: center;
  border-left: 4px solid #c62828;
}

.login-footer {
  text-align: center;
  margin-top: 20px;
  padding-top: 20px;
  border-top: 1px solid #e2e8f0;
  color: #666;
  font-size: 0.9rem;
}
</style>