# 💻 Gestor de Equipos Biomédicos - LIME

Proyecto final del curso **Ingeniería de Software** – Programa de **Bioingeniería, Universidad de Antioquia** 🧠💚

---

## 💡 Resumen del Proyecto

Este sistema permite la **gestión de equipos biomédicos** del **Laboratorio Integrado de Medicina Especializada (LIME)**, distribuidos en distintas **sedes** y **servicios**.  
El sistema centraliza la información sobre los equipos, su ubicación, responsables, estado y mantenimiento, ofreciendo una plataforma escalable y segura para la administración tecnológica del laboratorio.

---

## 🧩 Arquitectura del Sistema

El proyecto sigue una arquitectura **cliente-servidor** con separación entre frontend y backend:

| Componente | Tecnología | Descripción |
|-------------|-------------|--------------|
| **Backend (API REST)** | Django (Python) | Lógica de negocio y conexión con la base de datos |
| **Base de Datos** | MySQL | Almacenamiento relacional de los datos |
| **Frontend** | Vue.js + Bootstrap | Interfaz de usuario interactiva y responsiva |
| **Comunicación** | Axios | Comunicación entre frontend y backend |
| **Control de Acceso (CORS)** | django-cors-headers | Permite solicitudes seguras entre dominios |


---

## 🗂️ Estructura del Proyecto


Gestor-Equipos-Biomedicos/
│
├─ backend/ → API REST con Django y MySQL
│ ├─ core/ → Configuración general del proyecto
│ ├─ api/ → Endpoints y vistas del sistema
│ └─ venv/ → Entorno virtual de Python
│
├─ frontend/ → Interfaz desarrollada con Vue.js
│ ├─ src/ → Componentes, layouts y servicios
│ ├─ public/ → Archivos estáticos
│ └─ package.json → Dependencias del frontend
│
└─ README.md → Documentación general



👩‍💻 Equipo de Desarrollo

Desarrollado por estudiantes del curso Ingeniería de Software:

María Paulina Arias Castillo

[Agrega tus compañeros si aplica]

Docente:

Angelower Santana Velásquez


📜 Licencia y Uso

Proyecto desarrollado únicamente con fines académicos.
