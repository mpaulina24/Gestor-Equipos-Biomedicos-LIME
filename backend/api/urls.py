# backend/api/urls.py
from django.urls import path
from . import views
from .views import LoginAPIView, UsuarioListCreateAPIView, UsuarioListAPIView, UsuarioDesactivarAPIView

urlpatterns = [
    path('equipos/', views.EquipoActivoListAPIView.as_view(), name='api_equipos_list'), 
    #  
    path('equipos/inactivos/', views.EquipoInactivoListAPIView.as_view(), name='equipo-inactivo-list'),
    path('equipos/<int:pk>/desactivar/', views.DesactivarEquipoAPIView.as_view(), name='equipo-desactivar'),
    path('equipos/<int:pk>/activar/', views.ActivarEquipoAPIView.as_view(), name='equipo-activar'),
    # 
    path('equipos/<int:pk>/', views.EquipoDetailAPIView.as_view(), name='api_equipo_detail'),
    path('equipos/agregarEquipo/', views.EquipoCreateAPIView.as_view(), name='equipo-create'),
    path('equipos/<int:pk>/editar/', views.EditarEquipoAPIView.as_view(), name='editar-equipo'),
    path('equipos/<int:pk>/modificar/', views.ActualizarEquipoCompletoAPIView.as_view(), name='mofidicar-equipo'),
    path('equipos/<int:pk>/ediciones/', views.EdicionesPorEquipoAPIView.as_view(), name='ediciones-equipo'),
    path('equipos/<int:pk>/desactivar-detalle/', views.DesactivacionEquipoDetailAPIView.as_view(), name='desactivacion-equipo-detail'),
    path('auth/login/', LoginAPIView.as_view(), name='login'),
    path('auth/usuarios/', UsuarioListCreateAPIView.as_view(), name='usuarios-list-create'),
    path('auth/usuarios/lista/', UsuarioListAPIView.as_view(), name='usuarios-list'),
    path('auth/usuarios/<int:pk>/desactivar/', UsuarioDesactivarAPIView.as_view(), name='usuario-desactivar'),
    path('auth/usuarios/<int:pk>/activar/', views.UsuarioActivarAPIView.as_view(), name='usuario-activar'),
]
