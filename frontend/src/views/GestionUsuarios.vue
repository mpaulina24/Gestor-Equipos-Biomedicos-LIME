<template>
  <div class="container py-4 contenido-usuarios">
    <h4 class="titulo-principal text-center fw-bold mb-4">
      Gestión de Usuarios
    </h4>

    <!-- Solo mostrar si es admin -->
    <div v-if="authStore.isAdmin" class="card border-0 shadow-sm rounded-4 p-4 mb-4">
      <h6 class="fw-bold mb-3">Agregar Nuevo Usuario</h6>
      <form @submit.prevent="agregarUsuario" class="row g-3">
        <div class="col-md-4">
          <label class="form-label">Nombre de Usuario</label>
          <input v-model="nuevoUsuario.nombreusuario" type="text" class="form-control" required>
        </div>
        <div class="col-md-4">
          <label class="form-label">Contraseña</label>
          <input v-model="nuevoUsuario.contraseña" type="password" class="form-control" required>
        </div>
        <div class="col-md-4">
          <label class="form-label">Rol</label>
          <select v-model="nuevoUsuario.rol" class="form-select" required>
            <option value="viewer">Visualizador</option>
            <option value="admin">Administrador</option>
          </select>
        </div>
        <div class="col-12">
          <button type="submit" class="btn btn-success" :disabled="cargando">
            <i class="bi bi-person-plus me-2"></i>
            Agregar Usuario
          </button>
        </div>
      </form>
    </div>

    <div class="card border-0 shadow-sm rounded-4 p-4">
      <div class="d-flex justify-content-between align-items-center mb-3">
        <h6 class="fw-bold mb-0">Usuarios del Sistema</h6>
        <div class="btn-group">
          <button 
            class="btn btn-outline-secondary btn-sm" 
            @click="filtroActivos = 'todos'"
            :class="{ 'active': filtroActivos === 'todos' }"
          >
            Todos
          </button>
          <button 
            class="btn btn-outline-success btn-sm" 
            @click="filtroActivos = 'activos'"
            :class="{ 'active': filtroActivos === 'activos' }"
          >
            Activos
          </button>
          <button 
            class="btn btn-outline-secondary btn-sm" 
            @click="filtroActivos = 'inactivos'"
            :class="{ 'active': filtroActivos === 'inactivos' }"
          >
            Inactivos
          </button>
        </div>
      </div>

      <div class="table-scroll shadow-sm rounded">
        <table class="table align-middle table-hover">
          <thead class="table-light encabezado-pequeno">
            <tr>
              <th>USUARIO</th>
              <th>ROL</th>
              <th>FECHA CREACIÓN</th>
              <th>ESTADO</th>
              <th v-if="authStore.isAdmin">ACCIONES</th>
            </tr>
          </thead>
          <tbody>
            <tr v-for="usuario in usuariosFiltrados" :key="usuario.id">
              <td>{{ usuario.nombreusuario }}</td>
              <td>
                <span class="badge" :class="usuario.rol === 'admin' ? 'admin-badge' : 'viewer-badge'">
                  {{ usuario.rol === 'admin' ? 'Administrador' : 'Visualizador' }}
                </span>
              </td>
              <td>{{ new Date(usuario.fecha_creacion).toLocaleDateString() }}</td>
              <td>
                <span v-if="usuario.activo" class="badge bg-success">Activo</span>
                <span v-else class="badge bg-secondary">Inactivo</span>
              </td>
              <td v-if="authStore.isAdmin">
                <!-- Acciones para usuarios ACTIVOS -->
                <div v-if="usuario.activo">
                  <!-- Botón para desactivar usuarios viewer -->
                  <button 
                    v-if="usuario.rol === 'viewer'"
                    class="btn btn-warning btn-sm"
                    @click="desactivarUsuario(usuario)"
                    :disabled="cargandoDesactivar === usuario.id"
                  >
                    <i class="bi bi-person-dash me-1"></i>
                    <span v-if="cargandoDesactivar === usuario.id">Desactivando...</span>
                    <span v-else>Desactivar</span>
                  </button>
                  
                  <!-- Mensaje para admins activos -->
                  <span v-else class="text-muted small">
                    Admin (no se puede desactivar)
                  </span>
                </div>
                
                <!-- Acciones para usuarios INACTIVOS -->
                <div v-else>
                  <!-- Botón para reactivar usuarios viewer -->
                  <button 
                    v-if="usuario.rol === 'viewer'"
                    class="btn btn-success btn-sm me-2"
                    @click="activarUsuario(usuario)"
                    :disabled="cargandoActivar === usuario.id"
                  >
                    <i class="bi bi-person-check me-1"></i>
                    <span v-if="cargandoActivar === usuario.id">Reactivando...</span>
                    <span v-else>Reactivar</span>
                  </button>
                  
                  <!-- Mensaje para admins inactivos -->
                  <span v-else class="text-muted small">
                    Admin inactivo
                  </span>
                </div>
              </td>
            </tr>
          </tbody>
        </table>
        
        <div v-if="usuariosFiltrados.length === 0" class="text-center text-muted py-3">
          No hay usuarios que coincidan con el filtro seleccionado.
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, onMounted, computed } from 'vue'
import axios from 'axios'
import { useAuthStore } from '@/stores/auth'

const authStore = useAuthStore()
const usuarios = ref([])
const cargando = ref(false)
const cargandoDesactivar = ref(null)
const cargandoActivar = ref(null)
const filtroActivos = ref('activos')

const nuevoUsuario = ref({
  nombreusuario: '',
  contraseña: '',
  rol: 'viewer'
})

// Computed para filtrar usuarios
const usuariosFiltrados = computed(() => {
  if (filtroActivos.value === 'todos') {
    return usuarios.value
  } else if (filtroActivos.value === 'activos') {
    return usuarios.value.filter(u => u.activo == 1)
  } else {
    return usuarios.value.filter(u => u.activo == 0)
  }
})

const cargarUsuarios = async () => {
  try {
    const response = await axios.get('http://127.0.0.1:8000/api/auth/usuarios/lista/')
    usuarios.value = response.data
    console.log('Usuarios cargados:', response.data)

  } catch (error) {
    console.error('Error cargando usuarios:', error)
    alert('Error al cargar usuarios')
  }
}

const agregarUsuario = async () => {
  if (!authStore.isAdmin) {
    alert('No tienes permisos para agregar usuarios')
    return
  }

  cargando.value = true
  try {
    await axios.post('http://127.0.0.1:8000/api/auth/usuarios/', nuevoUsuario.value)
    
    // Limpiar formulario y recargar lista
    nuevoUsuario.value = { nombreusuario: '', contraseña: '', rol: 'viewer' }
    await cargarUsuarios()
    alert('Usuario agregado correctamente')
  } catch (error) {
    console.error('Error agregando usuario:', error)
    alert('Error al agregar usuario: ' + (error.response?.data?.error || error.message))
  } finally {
    cargando.value = false
  }
}

const desactivarUsuario = async (usuario) => {
  if (!authStore.isAdmin) {
    alert('No tienes permisos para desactivar usuarios')
    return
  }

  if (!confirm(`¿Estás seguro de que deseas desactivar al usuario "${usuario.nombreusuario}"?\n\nEl usuario ya no podrá iniciar sesión hasta que sea reactivado.`)) {
    return
  }

  cargandoDesactivar.value = usuario.id
  
  try {
    const response = await axios.patch(`http://127.0.0.1:8000/api/auth/usuarios/${usuario.id}/desactivar/`)
    
    if (response.data.success) {
      alert(response.data.message)
      await cargarUsuarios() // Recargar la lista
    } else {
      alert('Error al desactivar usuario: ' + response.data.error)
    }
  } catch (error) {
    console.error('Error desactivando usuario:', error)
    if (error.response?.data?.error) {
      alert('Error al desactivar usuario: ' + error.response.data.error)
    } else {
      alert('Error de conexión al desactivar usuario')
    }
  } finally {
    cargandoDesactivar.value = null
  }
}

const activarUsuario = async (usuario) => {
  if (!authStore.isAdmin) {
    alert('No tienes permisos para reactivar usuarios')
    return
  }

  if (!confirm(`¿Estás seguro de que deseas reactivar al usuario "${usuario.nombreusuario}"?\n\nEl usuario podrá iniciar sesión nuevamente.`)) {
    return
  }

  cargandoActivar.value = usuario.id
  
  try {
    const response = await axios.patch(`http://127.0.0.1:8000/api/auth/usuarios/${usuario.id}/activar/`)
    
    if (response.data.success) {
      alert(response.data.message)
      await cargarUsuarios() // Recargar la lista
    } else {
      alert('Error al reactivar usuario: ' + response.data.error)
    }
  } catch (error) {
    console.error('Error reactivando usuario:', error)
    if (error.response?.status === 404) {
      alert('El endpoint para reactivar usuarios no está disponible. Verifica que hayas creado la vista en el backend.')
    } else if (error.response?.data?.error) {
      alert('Error al reactivar usuario: ' + error.response.data.error)
    } else {
      alert('Error de conexión al reactivar usuario')
    }
  } finally {
    cargandoActivar.value = null
  }
}

onMounted(() => {
  cargarUsuarios()
})
</script>

<style scoped>
.btn-group .btn.active {
  background-color: #1B5E20;
  color: white;
  border-color: #1B5E20;
}

.table th {
  border-top: none;
  font-weight: 600;
  color: #1B5E20;
}

.btn-warning {
  background-color: #eb0606;
  border-color: #ea0505;
  color: #212529;
  font-size: 0.875rem;
}

.btn-warning:hover:not(:disabled) {
  background-color: #eb0606;
  border-color: #ea0505;
}

.contenido-usuarios {
  font-size: 0.88rem;
}

.table-scroll {
  max-height: 200px;
  max-width: 1200px;
  overflow-y: auto;
  overflow-x: auto;
  border-radius: var(--radio-base);
}

.table-scroll {
  overflow-y: auto;
  overflow-x: hidden;
}

</style>
