# backend/api/urls.py
from django.urls import path
from . import views

urlpatterns = [
    path('equipos/', views.EquipoListAPIView.as_view(), name='api_equipos_list'),
    path('equipos/<int:pk>/', views.EquipoDetailAPIView.as_view(), name='api_equipo_detail'),
     path('equipos/agregarEquipo/', views.EquipoCreateAPIView.as_view(), name='equipo-create'),
]
