# backend/api/urls.py
from django.urls import path
from . import views

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
]