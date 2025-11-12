from django.contrib import admin
from django.urls import path, include
from django.http import HttpResponse

# 👇 Vista simple para la raíz
def home(request):
    return HttpResponse("Bienvenido al Sistema de Gestión de Equipos Médicos")

urlpatterns = [
    path('admin/', admin.site.urls),
    path('', home),  # Ruta raíz
    path('api/', include('api.urls')),  # Todas las rutas de tu API
]
