from rest_framework import serializers
from .models import Equipo

class EquipoCreateSerializer(serializers.ModelSerializer):
    class Meta:
        model = Equipo
        fields = '__all__'
        

class EquipoListSerializer(serializers.ModelSerializer):
    # Campos agrupados
    equipo = serializers.SerializerMethodField()
    codigos = serializers.SerializerMethodField()
    responsable_ubicacion = serializers.SerializerMethodField()
    clasificacion = serializers.SerializerMethodField()

    class Meta:
        model = Equipo
        # Solo los campos relevantes para la tabla principal
        fields = [
            'id',
            'proceso',
            'equipo',
            'codigos',
            'responsable_ubicacion',
            'clasificacion',
            'registro_invima',
        ]


    def get_equipo(self, obj):
        # Agrupa nombre, marca, modelo
        partes = filter(None, [obj.nombre_equipo, obj.marca, obj.modelo])
        return " / ".join(partes)
    
    def get_codigos(self, obj):
        # Agrupa códigos internos, IPS y ECRI
        partes = filter(None, [obj.codigo_interno, obj.codigo_ips, obj.codigo_ecri])
        return " / ".join(partes)

    def get_responsable_ubicacion(self, obj):
        partes = filter(None, [obj.responsable, obj.ubicacion])
        return " / ".join(partes)

    def get_clasificacion(self, obj):
        partes = filter(None, [obj.clasificacion_misional, obj.clasificacion_ips, obj.clasificacion_riesgo])
        return " / ".join(partes)
