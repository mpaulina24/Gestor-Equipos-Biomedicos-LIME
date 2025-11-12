from django.shortcuts import render
from rest_framework.response import Response

from rest_framework import generics, status
from .models import Equipo
from .serializers import EquipoListSerializer, EquipoCreateSerializer

class EquipoListAPIView(generics.ListAPIView):
    queryset = Equipo.objects.all()
    serializer_class = EquipoListSerializer

class EquipoDetailAPIView(generics.RetrieveAPIView):
    queryset = Equipo.objects.all()
    serializer_class = EquipoListSerializer

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

