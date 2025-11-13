from django.db import models

class Equipo(models.Model):
    # --- Información general ---
    proceso = models.CharField(max_length=100)
    nombre_equipo = models.CharField(max_length=100)
    codigo_interno = models.CharField(max_length=50, blank=True, null=True)
    codigo_ips = models.CharField(max_length=50, blank=True, null=True)
    codigo_ecri = models.CharField(max_length=50, blank=True, null=True)
    responsable = models.CharField(max_length=100, blank=True, null=True)
    ubicacion = models.CharField(max_length=100, blank=True, null=True)
    marca = models.CharField(max_length=50, blank=True, null=True)
    modelo = models.CharField(max_length=50, blank=True, null=True)
    serie = models.CharField(max_length=50, blank=True, null=True)
    clasificacion_misional = models.CharField(max_length=50, blank=True, null=True)
    clasificacion_ips = models.CharField(max_length=50, blank=True, null=True)
    clasificacion_riesgo = models.CharField(max_length=50, blank=True, null=True)
    registro_invima = models.CharField(max_length=50, blank=True, null=True)

    # --- Registro histórico ---
    tiempo_vida_util = models.CharField(max_length=50, blank=True, null=True)
    fecha_adquisicion = models.DateField(blank=True, null=True)
    propietario = models.CharField(max_length=50, blank=True, null=True)
    fecha_fabricacion = models.CharField(max_length=50, blank=True, null=True)
    nit = models.CharField(max_length=50, blank=True, null=True)
    proveedor = models.CharField(max_length=100, blank=True, null=True)
    en_garantia = models.BooleanField(default=False)
    fecha_fin_garantia = models.DateField(blank=True, null=True)
    forma_adquisicion = models.CharField(max_length=50, blank=True, null=True)
    tipo_documento = models.CharField(max_length=50, blank=True, null=True)
    numero_documento = models.CharField(max_length=50, blank=True, null=True)

    # --- Inventario de documentos ---
    hoja_vida = models.BooleanField(default=False)
    registro_importacion = models.BooleanField(default=False)
    manual_operacion = models.BooleanField(default=False)
    manual_mantenimiento = models.TextField(blank=True, null=True)
    guia_rapida = models.BooleanField(default=False)
    instructivo = models.BooleanField(default=False)
    protocolo_mto = models.TextField(blank=True, null=True)
    frecuencia_metrologica = models.CharField(max_length=50, blank=True, null=True)

    # --- Información metrológica administrativa ---
    mantenimiento = models.BooleanField(default=False)
    frecuencia_mantenimiento = models.IntegerField(blank=True, null=True)
    calibracion = models.BooleanField(default=False)
    frecuencia_calibracion = models.IntegerField(blank=True, null=True)

    # --- Información metrológica técnica ---
    magnitud = models.CharField(max_length=50, blank=True, null=True)
    rango = models.CharField(max_length=100, blank=True, null=True)
    resolucion = models.CharField(max_length=50, blank=True, null=True)
    rango_trabajo = models.CharField(max_length=50, blank=True, null=True)
    error_maximo = models.CharField(max_length=50, blank=True, null=True)

    # --- Condiciones de funcionamiento ---
    voltaje = models.CharField(max_length=50, blank=True, null=True)
    corriente = models.CharField(max_length=50, blank=True, null=True)
    humedad = models.CharField(max_length=50, blank=True, null=True)
    temperatura = models.CharField(max_length=50, blank=True, null=True)
    dimensiones = models.CharField(max_length=100, blank=True, null=True)
    peso = models.CharField(max_length=50, blank=True, null=True)
    otros = models.TextField(blank=True, null=True)

    def __str__(self):
        return f"{self.nombre_equipo} ({self.proceso})"

class EdicionEquipo(models.Model):
    equipo = models.ForeignKey(Equipo, on_delete=models.CASCADE)
    fecha = models.DateField(auto_now_add=True)
    justificacion = models.TextField()
    responsable_actualizado = models.TextField(max_length=100)
    servicio_actualizado = models.TextField(max_length=100)
