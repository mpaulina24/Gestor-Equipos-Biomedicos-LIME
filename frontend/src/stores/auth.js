import { ref, computed } from 'vue'
import { defineStore } from 'pinia'

export const useAuthStore = defineStore('auth', () => {
  // Estado - cargar desde localStorage
  const usuario = ref(null)
  
  // Inicializar desde localStorage
  const loadFromStorage = () => {
    const stored = localStorage.getItem('usuario')
    if (stored) {
      usuario.value = JSON.parse(stored)
    }
  }
  
  // Cargar al inicializar
  loadFromStorage()
  
  // Getters
  const isAuthenticated = computed(() => !!usuario.value)
  const isAdmin = computed(() => usuario.value?.rol === 'admin')
  const isViewer = computed(() => usuario.value?.rol === 'viewer')
  const userRole = computed(() => usuario.value?.rol || '')
  const userName = computed(() => usuario.value?.nombreusuario || '')
  
  // Actions
  const login = (userData) => {
    usuario.value = userData
    localStorage.setItem('usuario', JSON.stringify(userData))
  }
  
  const logout = () => {
    usuario.value = null
    localStorage.removeItem('usuario')
    // Forzar recarga para limpiar el estado
    window.location.href = '/login'
  }
  
  return {
    usuario,
    isAuthenticated,
    isAdmin,
    isViewer,
    userRole,
    userName,
    login,
    logout,
    loadFromStorage
  }
})