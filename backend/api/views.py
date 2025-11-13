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


class EdicionesPorEquipoAPIView(generics.ListAPIView):
    serializer_class = EdicionEquipoSerializer

    def get_queryset(self):
        pk = self.kwargs['pk']
        return EdicionEquipo.objects.filter(equipo_id=pk).order_by('-fecha')