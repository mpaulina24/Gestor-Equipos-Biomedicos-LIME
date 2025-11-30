from django.db import models
from django.core.exceptions import ValidationError

CLASIFICACION_MISIONAL_CHOICES = [ 
    ('Docencia', 'Docencia'), 
    ('Investigación', 'Investigación'), 
    ('Extensión', 'Extensión'), 
]

CLASIFICACION_IPS_CHOICES = [
    ('BIO', 'BIO'),
    ('IND', 'IND'),
    ('GASES', 'Gases'),
]

RIESGO_CHOICES = [
    ('I', 'Clase I'),
    ('IIA', 'Clase IIa'),
    ('IIB', 'Clase IIb'),
    ('III', 'Clase III'),
]

SEDE_CHOICES = [
    ('Prado', 'Prado'),
    ('SIU', 'SIU'),
    ('San Vicente', 'San Vicente'),
]

def validar_clasificacion_misional(valor):
    """
    Valida que el valor sea una cadena vacía o una combinación de las opciones separadas por comas.
    Cada opción debe ser una de las opciones válidas.
    """
    if valor is None or valor == "":
        return
    
    opciones_validas = ['Docencia', 'Investigación', 'Extensión']
    # Separar por comas y eliminar espacios
    opciones = [opcion.strip() for opcion in valor.split(',')]
    
    for opcion in opciones:
        if opcion not in opciones_validas:
            raise ValidationError(f"'{opcion}' no es una opción válida. Las opciones válidas son: {', '.join(opciones_validas)}")

class Equipo(models.Model):

    activo = models.BooleanField(default=True)

    # --- Información general ---
    sede = models.CharField(
            max_length=20, 
            choices=SEDE_CHOICES,
            blank=True, 
            null=True
        )
    
    proceso = models.CharField(max_length=100)
    nombre_equipo = models.TextField(max_length=100)
    codigo_interno = models.CharField(max_length=40, blank=True, null=True)    
    codigo_ips = models.CharField(max_length=15, blank=True, null=True)
    codigo_ecri = models.CharField(max_length=15, blank=True, null=True)
    responsable = models.TextField(blank=True, null=True)
    ubicacion = models.TextField(blank=True, null=True)
    marca = models.TextField(blank=True, null=True)
    modelo = models.TextField(blank=True, null=True)
    serie = models.TextField(blank=True, null=True)

    clasificacion_misional = models.TextField(
        blank=True, 
        null=True,
        validators=[validar_clasificacion_misional]  # Agregar validador
    )

    clasificacion_ips = models.CharField(
    max_length=10, 
    choices=CLASIFICACION_IPS_CHOICES, 
    blank=True, 
    null=True
    )

    clasificacion_riesgo = models.CharField(
    max_length=10, 
    choices=RIESGO_CHOICES,
    blank=True, 
    null=True
    )

    registro_invima = models.TextField(blank=True, null=True)


    # --- Registro histórico ---
    tiempo_vida_util = models.TextField(blank=True, null=True)
    fecha_adquisicion = models.TextField(blank=True, null=True) ###
    propietario = models.CharField(max_length=40, blank=True, null=True)
    fecha_fabricacion = models.CharField(max_length=20, blank=True, null=True)
    nit = models.CharField(max_length=30, blank=True, null=True)
    proveedor = models.TextField(blank=True, null=True)
    en_garantia = models.CharField(max_length=20, blank=True, null=True)
    fecha_fin_garantia = models.CharField(max_length=20, blank=True, null=True) ###
    forma_adquisicion = models.CharField(max_length=30, blank=True, null=True)
    tipo_documento = models.TextField(blank=True, null=True)
    numero_documento = models.CharField(max_length=30, blank=True, null=True)
    valor_compra = models.CharField(max_length=40, blank=True, null=True)

    # --- Inventario de documentos ---
    hoja_vida = models.CharField(max_length=20, blank=True, null=True)
    registro_importacion = models.TextField(blank=True, null=True)
    manual_operacion = models.CharField(max_length=30, blank=True, null=True)
    manual_mantenimiento = models.TextField(blank=True, null=True)
    guia_rapida = models.CharField(max_length=20, blank=True, null=True)
    instructivo = models.CharField(max_length=30, blank=True, null=True)
    protocolo_mto = models.TextField(blank=True, null=True)
    frecuencia_metrologica = models.CharField(max_length=30, blank=True, null=True)

    # --- Información metrológica administrativa ---
    mantenimiento = models.CharField(max_length=20, blank=True, null=True)
    frecuencia_mantenimiento = models.CharField(max_length=10, blank=True, null=True)
    calibracion = models.CharField(max_length=20, blank=True, null=True)
    frecuencia_calibracion = models.CharField(max_length=30, blank=True, null=True)

    # --- Información metrológica técnica ---
    magnitud = models.TextField(blank=True, null=True)
    rango = models.TextField(blank=True, null=True)
    resolucion = models.TextField(blank=True, null=True)
    rango_trabajo = models.TextField(blank=True, null=True)
    error_maximo = models.TextField(blank=True, null=True)

    # --- Condiciones de funcionamiento ---
    voltaje = models.TextField(blank=True, null=True)
    corriente = models.CharField(max_length=100, blank=True, null=True)
    humedad = models.TextField(blank=True, null=True)
    temperatura = models.CharField(max_length=50, blank=True, null=True)
    dimensiones = models.TextField(blank=True, null=True)
    peso = models.TextField(blank=True, null=True)
    otros = models.TextField(blank=True, null=True)

def __str__(self):
    return f"{self.nombre_equipo} ({self.proceso})"

# class EdicionEquipo(models.Model):
#     equipo = models.ForeignKey(Equipo, on_delete=models.CASCADE)
#     fecha = models.DateField(auto_now_add=True)
#     justificacion = models.TextField()
#     responsable_actualizado = models.TextField(max_length=100)
#     servicio_actualizado = models.TextField(max_length=100)

class EdicionEquipo(models.Model):
    equipo = models.ForeignKey(Equipo, on_delete=models.CASCADE)
    fecha = models.DateField(auto_now_add=True)

    justificacion = models.TextField()

    # Antes vs después
    responsable_anterior = models.CharField(max_length=100, null=True, blank=True)
    responsable_nuevo = models.CharField(max_length=100, null=True, blank=True)

    servicio_anterior = models.CharField(max_length=100, null=True, blank=True)
    servicio_nuevo = models.CharField(max_length=100, null=True, blank=True)

    sede_anterior = models.CharField(max_length=100, null=True, blank=True)
    sede_nueva = models.CharField(max_length=100, null=True, blank=True)

    def __str__(self):
        return f"Edición de {self.equipo.nombre_equipo} — {self.fecha}"

class DesactivacionEquipo(models.Model):
    equipo = models.ForeignKey(Equipo, on_delete=models.CASCADE)
    fecha_desactivacion = models.DateField(auto_now_add=True)
    responsable_desactivacion = models.CharField(max_length=100)
    justificacion = models.TextField()

    def __str__(self):
        return f"Desactivación de {self.equipo.nombre_equipo} - {self.fecha_desactivacion}"
    

class Usuario(models.Model):
    ROLES = (
        ('admin', 'Administrador'),
        ('viewer', 'Solo lectura'),
    )
    nombreusuario = models.CharField(max_length=100, unique=True)
    contraseña = models.CharField(max_length=255)  # Texto plano temporalmente
    rol = models.CharField(max_length=10, choices=ROLES)
    activo = models.BooleanField(default=True)
    fecha_creacion = models.DateField(auto_now_add=True)

    def __str__(self):
        return f"{self.nombreusuario} ({self.rol})"
