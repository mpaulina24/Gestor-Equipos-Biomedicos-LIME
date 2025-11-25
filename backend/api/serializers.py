from rest_framework import serializers
from .models import Equipo, EdicionEquipo

class EdicionEquipoSerializer(serializers.ModelSerializer):
    class Meta:
        model = EdicionEquipo
        fields = '__all__'

class EquipoCreateSerializer(serializers.ModelSerializer):
    class Meta:
        model = Equipo
        fields = '__all__'
        

class EquipoListSerializer(serializers.ModelSerializer):
    # Campos agrupados (Mantener como están)
    equipo = serializers.SerializerMethodField()
    codigos = serializers.SerializerMethodField()
    responsable_ubicacion = serializers.SerializerMethodField()
    clasificacion = serializers.SerializerMethodField()

    class Meta:
        model = Equipo
        # Incluir todos los campos esenciales para la tabla
        fields = [
            'id',
            'proceso',
            'sede',                  
            'equipo',
            'codigos',
            'responsable_ubicacion',
            'clasificacion',
            'registro_invima',
            'activo'
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
