from django.shortcuts import get_object_or_404
from rest_framework.response import Response

from rest_framework import generics, status
from .models import Equipo, EdicionEquipo
from .serializers import EquipoListSerializer, EquipoCreateSerializer, EdicionEquipoSerializer

class EquipoListAPIView(generics.ListAPIView):
    queryset = Equipo.objects.all()
    serializer_class = EquipoListSerializer

class EquipoDetailAPIView(generics.RetrieveAPIView):
    queryset = Equipo.objects.all()
    serializer_class = EquipoCreateSerializer

class EquipoCreateAPIView(generics.CreateAPIView):
    queryset = Equipo.objects.all()
    serializer_class = EquipoCreateSerializer

    def create(self, request, *args, **kwargs):
        serializer = self.get_serializer(data=request.data)

        if serializer.is_valid():
            serializer.save()
            return Response(
                {"message": "Equipo creado correctamente", "data": serializer.data},
                status=status.HTTP_201_CREATED
            )
        else:
            return Response(
                {"errors": serializer.errors},
                status=status.HTTP_400_BAD_REQUEST
            )

class EquipoActivoListAPIView(generics.ListAPIView):
    """Lista solo los equipos que están activos (para el menú principal)."""
    # Filtra el queryset para incluir solo equipos donde activo=True
    queryset = Equipo.objects.exclude(activo=False)
    serializer_class = EquipoListSerializer

class EquipoInactivoListAPIView(generics.ListAPIView):
    """Lista solo los equipos que están inactivos (para la nueva pestaña)."""
    # Filtra el queryset para incluir solo equipos donde activo=False
    queryset = Equipo.objects.filter(activo=False)
    serializer_class = EquipoListSerializer # Puedes crear un Serializer más simple si quieres

class DesactivarEquipoAPIView(generics.UpdateAPIView):
    """Cambia el campo 'activo' a False para un equipo específico."""
    queryset = Equipo.objects.all()
    serializer_class = EquipoCreateSerializer # Usamos EquipoCreateSerializer solo para validar/PUT
    
    def post(self, request, pk):
        equipo = get_object_or_404(self.get_queryset(), pk=pk)
        equipo.activo = False
        equipo.save()
        return Response({"status": f"Equipo {pk} desactivado."}, status=status.HTTP_200_OK)

class ActivarEquipoAPIView(generics.UpdateAPIView):
    """Cambia el campo 'activo' a True para un equipo específico (Reactivación)."""
    queryset = Equipo.objects.all()
    serializer_class = EquipoCreateSerializer
    
    def post(self, request, pk):
        equipo = get_object_or_404(self.get_queryset(), pk=pk)
        equipo.activo = True
        equipo.save()
        return Response({"status": f"Equipo {pk} activado."}, status=status.HTTP_200_OK)


class EditarEquipoAPIView(generics.UpdateAPIView):
    queryset = Equipo.objects.all()
    serializer_class = EquipoCreateSerializer

    def put(self, request, pk):
        equipo = get_object_or_404(Equipo, pk=pk)
        equipo.proceso = request.data.get('proceso', equipo.proceso)
        equipo.responsable = request.data.get('responsable', equipo.responsable)
        equipo.save()

        # Registrar histórico de edición
        EdicionEquipo.objects.create(
            equipo=equipo,
            fecha=request.data.get('fecha_edicion'),
            justificacion=request.data.get('justificacion'),
            responsable_actualizado=equipo.responsable,
            servicio_actualizado=equipo.proceso,
        )

        return Response(
            {"message": "Cambios guardados correctamente"},
            status=status.HTTP_200_OK
        )

def normalize_date(value):
    """Convierte string vacío en None para campos de fecha."""
    return None if value in ["", None] else value


class ActualizarEquipoCompletoAPIView(generics.UpdateAPIView):
    queryset = Equipo.objects.all()

    def put(self, request, pk, *args, **kwargs):
        equipo = get_object_or_404(Equipo, pk=pk)

        # Actualizar todos los campos del modelo
        equipo.nombre_equipo = request.data.get('nombre_equipo', equipo.nombre_equipo)
        equipo.sede = request.data.get('sede', equipo.sede)
        equipo.proceso = request.data.get('proceso', equipo.proceso)
        equipo.responsable = request.data.get('responsable', equipo.responsable)
        equipo.ubicacion = request.data.get('ubicacion', equipo.ubicacion)
        equipo.marca = request.data.get('marca', equipo.marca)
        equipo.codigo_interno = request.data.get('codigo_interno', equipo.codigo_interno)
        equipo.codigo_ips = request.data.get('codigo_ips', equipo.codigo_ips)
        equipo.codigo_ecri = request.data.get('codigo_ecri', equipo.codigo_ecri)
        equipo.modelo = request.data.get('modelo', equipo.modelo)
        equipo.serie = request.data.get('serie', equipo.serie)
        equipo.clasificacion_misional = request.data.get('clasificacion_misional', equipo.clasificacion_misional)
        equipo.clasificacion_ips = request.data.get('clasificacion_ips', equipo.clasificacion_ips)
        equipo.clasificacion_riesgo = request.data.get('clasificacion_riesgo', equipo.clasificacion_riesgo)
        #equipo.requiere_invima = request.data.get('requiere_invima', equipo.requiere_invima)
        equipo.registro_invima = request.data.get('registro_invima', equipo.registro_invima)

        # Registro histórico
        equipo.tiempo_vida_util = request.data.get('tiempo_vida_util', equipo.tiempo_vida_util)
        equipo.fecha_adquisicion = normalize_date(request.data.get('fecha_adquisicion', equipo.fecha_adquisicion))
        equipo.fecha_fabricacion = normalize_date(request.data.get('fecha_fabricacion', equipo.fecha_fabricacion))
        equipo.fecha_fin_garantia = normalize_date(request.data.get('fecha_fin_garantia', equipo.fecha_fin_garantia))
        equipo.tipo_documento = request.data.get('tipo_documento', equipo.tipo_documento)
        equipo.numero_documento = request.data.get('numero_documento', equipo.numero_documento)
        equipo.propietario = request.data.get('propietario', equipo.propietario)
        equipo.proveedor = request.data.get('proveedor', equipo.proveedor)
        equipo.nit = request.data.get('nit', equipo.nit)
        equipo.en_garantia = request.data.get('en_garantia', equipo.en_garantia)

        # Documentos
        equipo.hoja_vida = request.data.get('hoja_vida', equipo.hoja_vida)
        equipo.registro_importacion = request.data.get('registro_importacion', equipo.registro_importacion)
        equipo.manual_operacion = request.data.get('manual_operacion', equipo.manual_operacion)
        equipo.manual_mantenimiento = request.data.get('manual_mantenimiento', equipo.manual_mantenimiento)
        equipo.guia_rapida = request.data.get('guia_rapida', equipo.guia_rapida)
        equipo.instructivo = request.data.get('instructivo', equipo.instructivo)
        equipo.protocolo_mto = request.data.get('protocolo_mto', equipo.protocolo_mto)

        # Información metrológica
        equipo.magnitud = request.data.get('magnitud', equipo.magnitud)
        equipo.rango = request.data.get('rango', equipo.rango)
        equipo.resolucion = request.data.get('resolucion', equipo.resolucion)
        equipo.rango_trabajo = request.data.get('rango_trabajo', equipo.rango_trabajo)
        equipo.mantenimiento = request.data.get('mantenimiento', equipo.mantenimiento)
        equipo.frecuencia_mantenimiento = request.data.get('frecuencia_mantenimiento', equipo.frecuencia_mantenimiento)
        equipo.calibracion = request.data.get('calibracion', equipo.calibracion)
        equipo.frecuencia_calibracion = request.data.get('frecuencia_calibracion', equipo.frecuencia_calibracion)

        # Condiciones de funcionamiento
        equipo.voltaje = request.data.get('voltaje', equipo.voltaje)
        equipo.corriente = request.data.get('corriente', equipo.corriente)
        equipo.humedad = request.data.get('humedad', equipo.humedad)
        equipo.temperatura = request.data.get('temperatura', equipo.temperatura)
        equipo.dimensiones_alto = request.data.get('dimensiones_alto', equipo.dimensiones_alto)
        equipo.dimensiones_ancho = request.data.get('dimensiones_ancho', equipo.dimensiones_ancho)
        equipo.dimensiones_profundidad = request.data.get('dimensiones_profundidad', equipo.dimensiones_profundidad)
        equipo.peso = request.data.get('peso', equipo.peso)
        equipo.otros = request.data.get('otros', equipo.otros)

        equipo.save()

        return Response({"message": "Equipo actualizado correctamente"}, status=status.HTTP_200_OK)

class EdicionesPorEquipoAPIView(generics.ListAPIView):
    serializer_class = EdicionEquipoSerializer

    def get_queryset(self):
        pk = self.kwargs['pk']
        return EdicionEquipo.objects.filter(equipo_id=pk).order_by('-fecha')
