-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Versión del servidor:         11.7.2-MariaDB - mariadb.org binary distribution
-- SO del servidor:              Win64
-- HeidiSQL Versión:             12.10.0.7000
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Volcando estructura de base de datos para gestorlimebd
CREATE DATABASE IF NOT EXISTS `gestorlimebd` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci */;
USE `gestorlimebd`;

-- Volcando estructura para tabla gestorlimebd.api_desactivacionequipo
CREATE TABLE IF NOT EXISTS `api_desactivacionequipo` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `fecha_desactivacion` date NOT NULL,
  `responsable_desactivacion` varchar(100) NOT NULL,
  `justificacion` longtext NOT NULL,
  `equipo_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `api_desactivacionequipo_equipo_id_6a23bc16_fk_api_equipo_id` (`equipo_id`),
  CONSTRAINT `api_desactivacionequipo_equipo_id_6a23bc16_fk_api_equipo_id` FOREIGN KEY (`equipo_id`) REFERENCES `api_equipo` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Volcando datos para la tabla gestorlimebd.api_desactivacionequipo: ~1 rows (aproximadamente)
INSERT INTO `api_desactivacionequipo` (`id`, `fecha_desactivacion`, `responsable_desactivacion`, `justificacion`, `equipo_id`) VALUES
	(1, '2025-11-30', 'María Paulina', 'Prueba 1', 279);

-- Volcando estructura para tabla gestorlimebd.api_edicionequipo
CREATE TABLE IF NOT EXISTS `api_edicionequipo` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `fecha` date NOT NULL,
  `justificacion` longtext NOT NULL,
  `equipo_id` bigint(20) NOT NULL,
  `responsable_anterior` varchar(100) DEFAULT NULL,
  `responsable_nuevo` varchar(100) DEFAULT NULL,
  `sede_anterior` varchar(100) DEFAULT NULL,
  `sede_nueva` varchar(100) DEFAULT NULL,
  `servicio_anterior` varchar(100) DEFAULT NULL,
  `servicio_nuevo` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `api_edicionequipo_equipo_id_672f6218_fk_api_equipo_id` (`equipo_id`),
  CONSTRAINT `api_edicionequipo_equipo_id_672f6218_fk_api_equipo_id` FOREIGN KEY (`equipo_id`) REFERENCES `api_equipo` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Volcando datos para la tabla gestorlimebd.api_edicionequipo: ~5 rows (aproximadamente)
INSERT INTO `api_edicionequipo` (`id`, `fecha`, `justificacion`, `equipo_id`, `responsable_anterior`, `responsable_nuevo`, `sede_anterior`, `sede_nueva`, `servicio_anterior`, `servicio_nuevo`) VALUES
	(11, '2025-11-27', 'a', 276, 'María Paulina', 'María Paulina', 'SIU', 'SIU', 'Patología', 'Patología'),
	(12, '2025-11-27', '2', 276, 'María Paulina', 'Gloria Zapata', 'SIU', 'Prado', 'Patología', 'LIME'),
	(13, '2025-11-27', 's', 276, 'Gloria Zapata / Gloria', 'Gloria Zapata / Gloria', 'Prado', 'Prado', 'LIME ', 'LIME '),
	(14, '2025-11-27', 'aaa', 276, 'Gloria Zapata / Gloria', 'Gloria Zapata / Gloria Zapata', 'Prado', 'Prado', 'LIME ', 'LIME '),
	(15, '2025-11-27', 'n', 277, 'Gloria Zapata / Gloria Zapata', 'Gloria Zapata', 'Prado', 'Prado', 'LIME', 'LIME');

-- Volcando estructura para tabla gestorlimebd.api_equipo
CREATE TABLE IF NOT EXISTS `api_equipo` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `proceso` varchar(100) NOT NULL,
  `nombre_equipo` longtext NOT NULL,
  `codigo_interno` varchar(40) DEFAULT NULL,
  `codigo_ips` varchar(15) DEFAULT NULL,
  `codigo_ecri` varchar(15) DEFAULT NULL,
  `responsable` longtext DEFAULT NULL,
  `ubicacion` longtext DEFAULT NULL,
  `marca` longtext DEFAULT NULL,
  `modelo` longtext DEFAULT NULL,
  `serie` longtext DEFAULT NULL,
  `clasificacion_misional` longtext DEFAULT NULL,
  `clasificacion_ips` varchar(10) DEFAULT NULL,
  `clasificacion_riesgo` varchar(10) DEFAULT NULL,
  `registro_invima` longtext DEFAULT NULL,
  `tiempo_vida_util` longtext DEFAULT NULL,
  `fecha_adquisicion` longtext DEFAULT NULL,
  `propietario` varchar(40) DEFAULT NULL,
  `fecha_fabricacion` varchar(20) DEFAULT NULL,
  `nit` varchar(30) DEFAULT NULL,
  `proveedor` longtext DEFAULT NULL,
  `en_garantia` varchar(20) DEFAULT NULL,
  `fecha_fin_garantia` varchar(20) DEFAULT NULL,
  `forma_adquisicion` varchar(30) DEFAULT NULL,
  `tipo_documento` longtext DEFAULT NULL,
  `numero_documento` varchar(30) DEFAULT NULL,
  `hoja_vida` varchar(20) DEFAULT NULL,
  `registro_importacion` longtext DEFAULT NULL,
  `manual_operacion` varchar(30) DEFAULT NULL,
  `manual_mantenimiento` longtext DEFAULT NULL,
  `guia_rapida` varchar(20) DEFAULT NULL,
  `instructivo` varchar(30) DEFAULT NULL,
  `protocolo_mto` longtext DEFAULT NULL,
  `frecuencia_metrologica` varchar(30) DEFAULT NULL,
  `mantenimiento` varchar(20) DEFAULT NULL,
  `frecuencia_mantenimiento` varchar(10) DEFAULT NULL,
  `calibracion` varchar(20) DEFAULT NULL,
  `frecuencia_calibracion` varchar(30) DEFAULT NULL,
  `magnitud` longtext DEFAULT NULL,
  `rango` longtext DEFAULT NULL,
  `resolucion` longtext DEFAULT NULL,
  `rango_trabajo` longtext DEFAULT NULL,
  `error_maximo` longtext DEFAULT NULL,
  `voltaje` longtext DEFAULT NULL,
  `corriente` varchar(100) DEFAULT NULL,
  `humedad` longtext DEFAULT NULL,
  `temperatura` varchar(50) DEFAULT NULL,
  `peso` longtext DEFAULT NULL,
  `otros` longtext DEFAULT NULL,
  `sede` varchar(20) DEFAULT NULL,
  `activo` tinyint(1) NOT NULL,
  `dimensiones` longtext DEFAULT NULL,
  `valor_compra` varchar(40) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=340 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Volcando datos para la tabla gestorlimebd.api_equipo: ~54 rows (aproximadamente)
INSERT INTO `api_equipo` (`id`, `proceso`, `nombre_equipo`, `codigo_interno`, `codigo_ips`, `codigo_ecri`, `responsable`, `ubicacion`, `marca`, `modelo`, `serie`, `clasificacion_misional`, `clasificacion_ips`, `clasificacion_riesgo`, `registro_invima`, `tiempo_vida_util`, `fecha_adquisicion`, `propietario`, `fecha_fabricacion`, `nit`, `proveedor`, `en_garantia`, `fecha_fin_garantia`, `forma_adquisicion`, `tipo_documento`, `numero_documento`, `hoja_vida`, `registro_importacion`, `manual_operacion`, `manual_mantenimiento`, `guia_rapida`, `instructivo`, `protocolo_mto`, `frecuencia_metrologica`, `mantenimiento`, `frecuencia_mantenimiento`, `calibracion`, `frecuencia_calibracion`, `magnitud`, `rango`, `resolucion`, `rango_trabajo`, `error_maximo`, `voltaje`, `corriente`, `humedad`, `temperatura`, `peso`, `otros`, `sede`, `activo`, `dimensiones`, `valor_compra`) VALUES
	(276, 'LIME ', 'Congelador', '135306', 'Pendiente', '15 - 583', 'Gloria Zapata / Gloria Zapata', 'Procesamiento Seccion C', 'Challenger', 'CV430', '9053127', 'Extensión', 'IND', 'NI', 'NI', 'NI', '10/12/2009', 'UdeA', 'NI', '890.934.939-8', 'Almacén Navarro Ospina S.A.', 'No', 'NI', 'Compra', 'Factura', '47736', 'SI', 'NI', 'SI', 'NI', 'NI', 'NI', 'NI', 'NI', 'Si', '1', 'Si', '1 (Calificación)', 'Temperatura', 'T -18', 'NI', '0 a - 33 ° C', 'NI', '115 VAC', 'NI', 'NI', 'Max 38°C', '55,5 kg', 'NI', 'Prado', 1, '53,5 x 53 x 142 cm', 'NI'),
	(277, 'LIME', 'Agregometro', '119325', 'BIO-12183', 'NI', 'Gloria Zapata', 'Procesamiento Seccion A', 'Helena Laboratories', 'AGGRAM', '630604801', 'Extensión', 'BIO', 'Clase IIa', 'INVIMA 2019DM-0019614', 'NI', '30/03/2006', 'UdeA', 'NI', '830.064.712-1', 'Helena Laboratories INC. (exportador)                  Labtronics S.A.S    ', 'No', 'NI', 'Compra', 'Factura', '96442', 'SI', 'SI', 'SI (ing)', 'Carta de proveedor de no entrega de manual', 'SI', 'SI', 'NI', 'NI', 'Si', '1', 'No', 'NI', 'Absorbancia', '0 - 2 DE ', 'NI', '0 - 2 DE ', 'NI', '110 VAC', 'NI', 'NI', '15 - 30 °C', '6,75 Kg', 'Frecuencia 50/60 Hz', 'Prado', 1, '15,24 cm x 25,40 cm x 43,18 cm (alto x ancho x profundidad)', 'NI'),
	(278, 'LIME', 'Centrífuga refrigerada', '130937', 'BIO-12186', '10 - 780', 'Gloria Zapata / Gloria Zapata', 'Área centrífugas', 'BOECO - HETTICH', 'U-320R', '0000189', 'Extensión', 'BIO', 'Clase IIa', 'INVIMA 2014DM-0011507', 'NI', '2/12/2008', 'UdeA', '2008', '811.033.098-5', 'Importecnical Ltda.', 'No', 'NI', 'Compra', 'Factura', '006093', 'SI', 'NI', 'NI', 'NI', 'SI', 'SI', 'NI', 'NI', 'Si', '2', 'Si', '2', 'vacio', 'Max. 15000 rpm (según folleto)               Max. 5000 rpm (evidencia)                             T -20 a 40°C', '10 rpm                    1°C                                                                                                                 ', '1000 - 4500 rpm', 'NI', '200 - 240 V', '4:00 a. m.', 'NI', 'NI', '53 kg', 'NI', 'Prado', 1, '346 x 401 x 695 mm', 'NI'),
	(279, 'LIME', 'Analizador de coagulación automatizado - Equipo de Hemostasia', 'LIME 378', 'BIO-16281', '15 - 098', 'Gloria Zapata / Andres Zuluaga', 'Procesamiento Seccion A', 'SYSMEX', 'CS2500', '25407', 'Extensión', 'BIO', 'Clase IIa', 'INVIMA 2016DM-0015107', 'NI', '28/06/2021 (Facturado) 16/07/2021 (Instalado)', 'UT LIME', 'NI', '900.931.305-0', 'SIEMENS', 'No', '15/07/2022', 'Compra', 'Factura', 'TE57569', 'SI', 'SI', 'SI', 'SI (CAP)', 'SI', 'SI', 'SI', 'Semestral', 'Si', '2', 'No', 'NI', 'NI', 'NI', 'NI', 'NI', 'NI', '100 - 240 VAC', 'NI', '30 - 85 %HR', '15 - 30 °C', 'Unidad principal                           110 kg                                                    Unidad neumática                             17 kg', 'NI', 'Prado', 0, 'Unidad principal                           775 x 895 x 685 mm                        Unidad neumática                             280 x 355 x 400 mm', 'NI'),
	(280, 'LIME', 'Micropipeta ', '160517', 'BIO-12193', '15 - 166', 'Gloria Zapata / Gloria Zapata', 'Procesamiento Seccion A', 'Thermo Scientific', 'Finnpipette F1', 'MH12168', 'Extensión', 'BIO', 'Clase I', 'ACTA No. 09 Septiembre 17 de 2014', 'NI', '19/01/2016', 'UdeA', 'NI', '900.355.024-5', 'Equipos y Laboratorio', 'No', 'NI', 'Compra', 'Factura', 'C7206', 'SI', 'NI', 'SI', 'SI (CAP)', 'SI', 'NI', 'SI', 'Trimestral', 'Si', '1', 'Si', '1', 'Volumen', '100 - 1000 uL', '1 uL', '100 - 1000 ul', 'NI', 'NI', 'NI', 'NI', 'NI', 'NI', 'NI', 'Prado', 1, 'NI', 'NI'),
	(281, 'LIME', 'Micropipeta ', '160516', 'BIO-12194', '15 - 166', 'Gloria Zapata / Gloria Zapata', 'Procesamiento Seccion A', 'Thermo Scientific', 'Finnpipette F1', 'MH12173', 'Extensión', 'BIO', 'Clase I', 'ACTA No. 09 Septiembre 17 de 2014', 'NI', '19/01/2016', 'UdeA', 'NI', '900.355.024-5', 'Equipos y Laboratorio', 'No', 'NI', 'Compra', 'Factura', 'C7206', 'SI', 'NI', 'SI', 'SI (CAP)', 'SI', 'NI', 'SI', 'Trimestral', 'Si', '1', 'Si', '1', 'Volumen', '100 - 1000 uL', '1 uL', '100 - 1000 ul', 'NI', 'NI', 'NI', 'NI', 'NI', 'NI', 'NI', 'Prado', 1, 'NI', 'NI'),
	(282, 'LIME', 'Micropipeta ', '160515', 'BIO-12198', '15 - 166', 'Gloria Zapata / Gloria Zapata', 'Procesamiento Seccion A', 'Thermo Scientific', 'Finnpipette F1', 'MH12148', 'Extensión', 'BIO', 'Clase I', 'ACTA No. 09 Septiembre 17 de 2014', 'NI', '19/01/2016', 'UdeA', 'NI', '900.355.024-5', 'Equipos y Laboratorio', 'No', 'NI', 'Compra', 'Factura', 'C7206', 'SI', 'NI', 'SI', 'SI (CAP)', 'SI', 'NI', 'SI', 'Trimestral', 'Si', '1', 'Si', '1', 'Volumen', '20 - 200 uL', '0,2 uL', '20 - 200 ul', 'NI', 'NI', 'NI', 'NI', 'NI', 'NI', 'NI', 'Prado', 1, 'NI', 'NI'),
	(283, 'LIME', 'Agitador Vórtex', '150955', 'BIO-12129', '15 - 651', 'Gloria Zapata / Vanessa Santiago (Patologa)', 'Procesamiento Seccion A', 'Boeco', 'Vortex V1 Plus', '1,02031E+12', 'Extensión', 'BIO', 'NI', 'ACTA No. 07 Junio 10 de 2009 indica que no requiere registro sanitario, y se rectifica en ACTA No. 03 Abril 10 de 2013 ', 'NI', '3/02/2014', 'UdeA', 'NI', '890.912.308-6', 'Laboratorios Ltda.', 'No', 'NI', 'Compra', 'Factura', 'CR 00080017', 'SI', 'NI', 'SI', 'NI', 'SI', 'SI', 'NI', 'NI', 'Si', '1', 'No', 'NI', 'Velocidad', '750 - 3000 rpm', 'Perilla sin indicación', '750 - 3000 rpm', 'NI', '100 - 240 VAC', 'NI', '80% max. con T hasta 31°C     50% con T hasta 40°C ', '4 - 40 °C', '0,8 kg', 'NI', 'Prado', 1, '90 x 150 x 80 mm', 'NI'),
	(284, 'LIME', 'Baño María', '150712', 'BIO-12130', '16 - 861', 'Gloria Zapata / Vanessa Santiago (Patologa)', 'Procesamiento Seccion B', 'Indulab', '09-A', '13834', 'Extensión', 'BIO', 'Clase I', 'ACTA No. 07 Junio 10 de 2009 indica que no requiere registro sanitario, y se rectifica en ACTA No. 03 Abril 10 de 2013 ', 'NI', '24/01/2014', 'UdeA', 'NI', '811.013.926-3', 'Indulab S.A.', 'No', 'NI', 'Compra', 'Factura', '6142', 'SI', 'SI (Registro de nacionalización)', 'SI', 'SI', 'SI', 'SI', 'NI', 'Semestral', 'Si', '2', 'Si', '2', 'Temperatura', '37 - 90°C', '0,1 °C', '37 - 90 °C', 'Rango error +/- 1°C', '110 VAC', 'NI', 'NI', 'NI', 'NI', 'NI', 'Prado', 1, 'NI', 'NI'),
	(285, 'LIME', 'Centrífuga', '151362', 'BIO-12131', '10 - 778', 'Gloria Zapata / Vanessa Santiago (Patologa)', 'Área centrífugas', 'Hettich', 'Rotofix 32A', '006965-04', 'Extensión', 'BIO', 'Clase I', 'INVIMA 2013DM-0010231', 'NI', '18/03/2014', 'UdeA', 'NI', '890.912.308-6', 'Laboratorios Ltda.', 'No', 'NI', 'Compra', 'Factura', 'CR 00081028', 'SI', 'SI', 'SI', 'NI', 'SI', 'SI', 'NI', 'NI', 'Si', '1', 'Si', '1', 'Velocidad', '500rpm - maximo hasta 6000 rpm (depende del rotor)\n1 - 99 minutos', '100 rpm\n1 min', 'NI', 'NI', '100 - 127 V', '3:00 a. m.', '80% max. con T hasta 31°C     50% con T hasta 40°C ', '2 - 40 °C', '23 kg', 'NI', 'Prado', 1, '366 x 430 x 257 mm', 'NI'),
	(286, 'LIME', 'Microcentrifuga refrigerada', 'LIME 360', 'BIO-16289', '17 - 452', 'Estefania Vasco', 'Área centrífugas', 'HERMLE', 'Z 216 MK', '61165050', 'Extensión', 'BIO', 'Clase I', 'INVIMA 2015DM-0013425', 'NI', '31/03/2020', 'UT LIME', '2016', '811.026.956-0', 'MR y Cia S.A.S', 'No', 'mar-21', 'Compra', 'Factura', 'MRE 10890', 'SI', 'NI', 'SI (ING)', 'NI', 'NI', 'NI', 'NI', 'Semestral', 'Si', '2', 'Si', '2', 'Velocidad/ Tiempo / Temperatura', 'Velocidad: 200 - 15000 rpm (la velocidad maxima varia dependindo del rotor 13500, 14500 o 15000)\nTiempo: 10 seg hasta 99 horas 59 min.\nTemperatura: -20°C a +40°C.', 'Temperatura : 1°C', 'NI', 'NI', 'NI', 'NI', 'NI', 'NI', 'NI', 'NI', 'Prado', 1, 'NI', '$ 29.155.000'),
	(287, 'LIME', 'Congelador', 'LIME 642', 'Pendiente', '15 - 583', 'Duvan Gallego', 'Hospital Alma Mater de antioquia, sede ambulatoria Prado, Bloque B, segundo piso, Almacen', 'Infrico', 'LTF40SD', '3000957831', 'Extensión', 'BIO', 'Clase IIa', 'INVIMA 2023DM-0026731', 'NI', 'Entrega 13/12/2024 \nInstalación  16/12/2024', 'UT LIME', 'NI', '800.154.351-3', 'BLAMIS DOTACIONES LABORATORIO S.A.S', 'Si', '11/12/2025', 'Compra', 'Factura', 'E 160790', 'SI', 'NI', 'NI', 'NI', 'NI', 'NI', 'NI', 'NI', 'Si', '2', 'Si', '2 (Calificación)', 'Temperatura', '2 - 8 °C', '1 °C', '2 - 8 °C', 'NI', 'NI', 'NI', 'NI', 'NI', 'NI', 'NI', 'Prado', 1, 'NI', '$ 18.203.002'),
	(288, 'LIME', 'Fonendoscopio', 'LIME 121', 'BIO-16800', '13 - 750', 'Medicos / Andres Zuluaga', 'Recepcion', 'GMD', 'GMD30-DCK', 'IMP-1163', 'Extensión', 'BIO', 'Clase I', 'INVIMA 2015DM-0014070', 'NI', '18/01/2023', 'UT LIME', 'NI', '717890804', 'MILTON VLADIMIR MARIN JARAMILLO Top medicos', 'No', 'NI', 'Compra', 'Factura', 'FE-7405', 'SI', 'NI', 'NI', 'NI', 'NI', 'NI', 'NI', 'NI', 'Si', '1', 'No', 'NI', 'NI', 'NI', 'NI', 'NI', 'NI', 'NI', 'NI', 'NI', 'NI', 'NI', 'NI', 'Prado', 1, 'NI', '$ 104.000'),
	(289, 'LIME', 'Centrífuga refrigerada', '117104', 'BIO-12250', '18 - 270', 'Gloria Ramírez / Carlos Muñeton', 'Biologia Molecular (Extraccion)', 'Sigma', '3-16K', '110639', 'Extensión', 'BIO', 'Clase I', 'INVIMA 2015DM-0012550', 'NI', '16/06/2005', 'UdeA', '2005', '800.240.039-8', 'Sigma Laborzentrifugen                                            Anditécnica', 'No', 'NI', 'Compra', 'Factura', '2005-32874', 'SI', 'SI', 'SI', 'NI', 'SI', 'SI', 'NI', 'NI', 'Si', '2', 'Si', '2', 'Temperatura                                           Tiempo                                                Velocidad', 'T -10 a 40°C                                             0 - 30 min/funcionamiento continuo/\noperación de corta duración                                        100 - 15300 rpm', '1°C                                                                                                     1min                                                                                            100 rpm', '18 a 22°C                                                          15 a 25 min                                                                     1200 a 14000 rpm', 'NI', 'NI', 'NI', 'NI', 'NI', 'NI', 'NI', 'Prado', 1, 'NI', 'NI'),
	(290, 'LIME', 'Balanza Analítica', '189604', 'BIO-16749', '18 - 449', 'Ivone Jimenez / Andres Zuluaga', 'BSL3 (Procesamiento)', 'ViBRA', 'HT224CEN', '215022050', 'Extensión, Investigación', 'BIO', 'Clase I', 'ACTA No. 07 Junio 10 de 2009', 'NI', '18/11/2021', 'UdeA', 'NI', '811.026.956-0', 'MR Y CIA S.A.S', 'No', 'NI', 'Compra', 'Factura', 'MRE14352', 'SI', 'SI', 'SI (físico inglés)', 'NI', 'NI', 'NI', 'NI', 'NI', 'Si', '1', 'Si', '1', 'Peso', '0,01 - 220 g', 'NI', 'NI', 'NI', 'Adaptador entreda            100 - 240 VAC                      salida 12VDC', 'NI', 'Máx. 80%HR', '10 - 30 °C', '2,5kg', 'Frecuencia 50 - 60 Hz', 'Prado', 1, '213 x 314 x 395,3 mm (Ancho x Alto x Profundo)', 'NI'),
	(291, 'LIME', 'Incubadora', '134788', 'BIO-12256', '18 - 013', 'Gloria Garcia / Gloria Ramírez', 'Citogenomica (PreaNIlitica)', 'Binder', 'BD53-UL', '908707', 'Extensión', 'BIO', 'NI', 'Certificación de No Requiere 2014010943', 'NI', '24/11/2009', 'UdeA', 'NI', '890.912.308-6', 'Laboratorios Ltda.', 'No', 'NI', 'Compra', 'Factura', 'CR 00049421', 'SI', 'NI', 'SI', 'NI', 'SI', 'SI', 'Anual', 'NI', 'Si', '1', 'Si', '1 (Calificación)', 'Temperatura', '5 °C por \nencima de la temperatura ambiente - 100 °C', '0,1 °C', '36,5°C-37,5°C', 'NI', 'NI', 'NI', 'NI', 'NI', 'NI', 'NI', 'Prado', 1, 'NI', 'NI'),
	(292, 'LIME', 'Filmarray', '187250', 'BIO-16698', 'NI', 'Enith Knuth / Andres Zuluaga', 'Microbiología 1', 'BIOFIRE', 'FilmArray Torch (ref: HTFA-ASY-0104)', 'TB03545', 'Extensión', 'BIO', 'Clase IIa', 'INVIMA 2014DM-0011912', 'NI', 'Factura 22/07/2021 Reporte de instalación 05/08/2021', 'UdeA', 'mar-21', '830.023.844-1', 'Biomérieux', 'No tiene garantía', 'NI', 'Compra', 'Factura                        Reporte de instalación', 'FE23094 00728988', 'SI', 'SI', 'SI', 'Carta de no requiere', 'SI (proveedor)', 'NI', 'NI', 'NI', 'No', 'NI', 'No', 'NI', 'NI', 'NI', 'NI', 'NI', 'NI', '120 VAC', '3,2 A (2 modulos)', '20 - 80 %HR', '15 - 30 °C', '29,9 kg', 'Frecuencia 50 - 60 Hz', 'Prado', 1, '458 x 737 x 292 mm', 'NI'),
	(293, 'LIME', 'Maglumi', 'A-LIME-003', 'BIO-16303', 'NI', 'Juan Carlos Herrera / MyM Diagnostics', 'Procesamiento Seccion B', 'SNIBE', 'MAGLUMI 600', '0101010003022000165', 'Extensión', 'BIO', 'Clase IIa', 'INVIMA 2012DM-0009229	', 'NI', '31/08/2021', 'Arriendo MYM', '14/12/2020', '900.228.842-1', 'MyMDiagnostics', 'NI', 'NI', 'Apoyo tecnológico', 'Acta de entrega', '2930', 'SI', 'SI', 'NI', 'NI', 'NI', 'NI', 'NI', 'NI', 'Si', '2', 'No', 'NI', 'NI', 'NI', 'NI', 'NI', 'NI', '100 - 240 VAC', 'NI', 'NI', 'NI', 'NI', 'Frecuencia 50/60 Hz Potencia 350 VA', 'Prado', 1, 'NI', 'NI'),
	(294, 'LIME', 'Micropipeta', 'LIME 001', 'BIO-12177', '15 - 166', 'Andres Hincapie', 'Procesamiento Seccion C', 'Corning', 'Lambda Plus', '658220168', 'Extensión', 'BIO', 'Clase I', 'ACTA No. 09 Septiembre 17 de 2014', 'NI', '12/10/2016', 'UdeA', 'NI', '811.026.956-0', 'MR Y Cia S.A.S', 'No', 'NI', 'Compra', 'Factura', 'MRC2303', 'SI', 'NI', 'SI (ING)', 'NI', 'SI', 'SI', 'NI', 'NI', 'Si', '1', 'Si', '1', 'Volumen', '0,5 - 10 ul', '0,02 uL', '0,5- 10 µl', 'NI', 'NI', 'NI', 'NI', 'NI', 'NI', 'NI', 'Prado', 1, 'NI', '$ 788.800'),
	(295, 'Centro de resonancia', 'Resonador magnetico', '207255', 'BIO-15348', 'NT', 'Pablo Patiño Grajales /Isabella Ariza', 'Hospital Alma Mater de Antioquia, Bloque B, primer piso, Centro de resonancia', 'PHILIPS', 'INGENIA ELITION X', '45555', 'Extensión, Investigación', 'BIO', 'Clase IIa', 'INVIMA 2018EBC-0017485', '10 años', '23/09/2022', 'UdeA', 'NI', '860.005.396-4', 'PHILIPS COLOMBIANI S.A.S', 'No', '23/09/2024', 'Compra', 'Contrato y Acta de entrega del bien mueble', 'LATAM_109371', 'SI', 'SI', 'SI', 'Carta de proveedor de no entrega de manual', 'NI', 'NI', 'NI', 'Semestral', 'Si', '2', 'No', 'NI', 'NI', 'NI', 'NI', 'NI', 'NI', 'NI', 'NI', 'NI', 'NI', 'NI', 'NI', 'Prado', 1, 'NI', '$1.957.500 USD más IVA'),
	(296, 'Fotodermatología', 'CAMARA DE FOTOTERAPIA', '128568', 'BIO-100561', '13-037', 'Jhon Frank Villa', 'Hospital Alma Mater de Antioquia, Bloque A, segundo piso, FOTOTERAPIA', 'DAAVLIN', 'P3251-SNBPC-0048', '3SERIES PC31148', 'Extensión', 'BIO', 'Clase I', 'INVIMA 2009EBC-0003822', 'NI', 'NI', 'UdeA', 'NI', 'NI', 'NI', 'No', 'NI', 'Compra', 'NI', 'NI', 'NI', 'NI', 'NI', 'NI', 'NI', 'NI', 'NI', 'NI', 'Si', '4', 'Si', '1 Timer', 'NI', 'NI', 'NI', 'NI', 'NI', 'NI', 'NI', 'NI', 'NI', 'NI', 'NI', 'Prado', 1, 'NI', 'NI'),
	(297, 'Fotodermatología', 'CAMARA DE FOTOTERAPIA', '151197', 'BIO-102003', '13-037', 'Jhon Frank Villa', 'Hospital Alma Mater de Antioquia, Bloque A, segundo piso, FOTOTERAPIA', 'DAAVLIN', 'P3526A1X4800', '3SERIES X350-48', 'Extensión', 'BIO', 'Clase I', 'INVIMA 2009EBC-0003822', 'NI', 'NI', 'UdeA', 'NI', 'NI', 'NI', 'No', 'NI', 'Compra', 'NI', 'NI', 'NI', 'NI', 'NI', 'NI', 'NI', 'NI', 'NI', 'NI', 'Si', '4', 'Si', '1 Timer', 'NI', 'NI', 'NI', 'NI', 'NI', 'NI', 'NI', 'NI', 'NI', 'NI', 'NI', 'Prado', 1, 'NI', 'NI'),
	(298, 'Trasplantes GICIG', 'Agitador vortex', '116989 / 008819', 'BIO-16857', '15-651', 'Juan Jose Serrano / Gloria Vasquez', 'SIU - Laboratorio trasplantes - Torre 1, Lab 410', 'SCIENTIFIC INDUSTRIES /GENIE 2', 'G-560', '2-374976', 'Extensión', 'BIO', 'NI', 'Antes de 2007', 'NI', '12/05/2005', 'UdeA', 'NI', '811.033.098-5', 'Importecnical Ltda.', 'No', 'NI', 'Compra', 'Factura', '001807', 'SI', 'NI', 'SI (ING)', 'NI', 'SI', 'SI', 'NI', 'NI', 'Si', '1', 'No', 'NI', 'Velocidad', 'Perilla de posiciones (1 a 10)', 'NI', 'NI', 'NI', '120 VAC', '0,65 A', 'Máx. 95%HR', '0 - 38 °C', '4 kg', 'Frecuencia 60 Hz', 'SIU', 1, '165 x 122 x 165 mm (profundo x ancho x alto)', '$ 1.276.000'),
	(299, 'Trasplantes GICIG', 'Balanza analítica', '164386', 'BIO-16858', '18-449', 'Juan Jose Serrano / Cristiam Alvarez', 'SIU - Laboratorio trasplantes - Torre 1, Lab 410', 'PRECISA', 'LS220A', '7001460', 'Extensión', 'BIO', 'Clase I', 'ACTA No. 03 Abril 10 de 2013', 'NI', '1/08/2016', 'UdeA', 'NI', '860.536.024-8', 'Wacol S.A.', 'No', '1/08/2018', 'Compra', 'Factura', '144593', 'SI', 'NI', 'SI (ING)', 'SI (ING - CAP)', 'SI (Fabricante)', 'SI', 'NI', 'NI', 'Si', '1', 'Si', '1', 'Masa', 'Máx. 220 g', '0,1 mg', 'NI', 'NI', 'Entrada adaptador 90 - 264 VAC Entrada equipo desde adaptador 12 VDC', 'Entrada equipo desde adaptador 1,5 A', '25% a 85% (sin condensar)', '0°C a 40°C', '6,6 kg', 'Frecuencia de entrada a adaptador 47 - 63 Hz   ', 'SIU', 1, '228 x 381 x 345 mm (ancho x largox alto)', 'NI'),
	(300, 'Trasplantes GICIG', 'Cabina de extracción', 'C481 (E-20702301-2-004)', 'BIO-16859', 'NI', 'Juan Jose Serrano', 'SIU - Laboratorio trasplantes - Torre 1, Lab 410', 'C4', 'CEX 120', '100406', 'Extensión', 'BIO', 'NI', 'No requiere, Adquirido antes de 2007', 'NI', '2005', 'UdeA', 'NI', '805.016.686-2', 'C4 Pascal', 'No', 'NI', 'Compra', 'Histórico de reportes de mantenimiento', 'NI', 'SI', 'NI', 'SI', 'SI (CAP)', 'SI', 'SI', 'Se describe en capitulo de servicio', 'Semestral', 'Si', '1', 'Si', '1 (calificación)', 'NI', 'NI', 'NI', 'NI', 'NI', '110 VAC', 'NI', 'NI', 'NI', 'NI', 'Frecuencia 50 / 60 Hz', 'SIU', 1, '1200 X 1800 X 1519 cm \n(ancho x fondo x alto)', 'NI'),
	(301, 'Trasplantes GICIG', 'Calentador seco', '108942 / 008843', 'BIO-16860', 'NI', 'Juan Jose Serrano / Gloria Vasquez', 'SIU - Laboratorio trasplantes - Torre 1, Lab 410', 'BOEKEL', '113002', '0233 12871', 'Extensión', 'BIO', 'Clase I ', 'Antes de 2007', 'NI', 'oct-02', 'UdeA', 'NI', 'NI ', 'BIOLOGIA MOLECULAR', 'No', 'NI', 'Compra', 'Histórico de reportes de mantenimiento y hojas de vida anteriores', 'NI', 'SI', 'NI', 'NI', 'NI', 'SI', 'SI', 'NI', 'NI', 'Si', '1', 'No', 'NI', 'Temperatura', '5 - 120 °C', '5 - 120 °C', 'NI', 'NI', '115 VAC', '1,75 A', 'NI', 'NI', 'NI', 'Potencia 200 W Frecuencia 60 Hz', 'SIU', 1, 'NI', 'NI'),
	(302, 'Trasplantes GICIG', 'Incubadora', '34022 / 008808', 'BIO-16868', '18-013', 'Juan Jose Serrano / Gloria Vasquez', 'SIU - Laboratorio trasplantes - Torre 1, Lab 410', 'MEMMERT', 'TV10', '599033', 'Extensión', 'BIO', 'NI', 'Adquirido antes de 2007', '10 años', 'Antes de 2003', 'UdeA', 'NI', 'NI', 'NI', 'No', 'NI', 'Compra', 'Histórico de reportes de mantenimiento', 'NI', 'SI', 'NI', 'NI', 'NI', 'SI', 'SI', 'NI', 'NI', 'Si', '1', 'Si', '1 (calificación)', 'Temperatura', 'NI', 'NI', 'NI', 'NI', '120 VAC', 'NI', 'NI', 'NI', 'NI', 'Potencia 1400 W', 'SIU', 1, 'NI', 'NI'),
	(303, 'Trasplantes GICIG', 'Luminex', '180235 / 008811', 'BIO-16869', 'NI', 'Juan Jose Serrano / Cristiam Alvarez', 'SIU - Laboratorio trasplantes - Torre 1, Lab 410', 'LUMINEX', 'Luminex LX 100/ 200', 'LX10017065423', 'Extensión', 'BIO', 'Clase IIa', 'INVIMA 2020DM-0022003', '10 años', 'Fecha de compra: 29/09/2016\nFecha de cambio 2 por garantía: 16/03/2018 (equipo que se tiene actualmente).', 'UdeA', '6/03/2017', '900.222.640-1', 'BIOSCIENCES S.A.S.', 'No', 'NI', 'Compra', 'Factura', '5220', 'SI', 'SI', 'SI', 'SI (CAP)', 'SI', 'SI', 'NI', 'Semestral', 'Si', '2', 'No', 'NI', 'Longitud de onda', 'laser reportero 532nm y laser clasficador 635nm', 'NI', 'NI', 'NI', '100 - 120 VAC / 200 - 240 VAC', '1,4 A / 0,8 A', '20 % A 80% HR, sin condensación', '15 - 30 °C', '25 kg', 'Frecuencia 47 - 63 Hz', 'SIU', 1, '43 x 50,5 x 24,5 cm (ancho x profundidad x alto)', '$ 292.320.000'),
	(304, 'Trasplantes GICIG', 'Micropipeta', '12 / 3 - 058976 - 02', 'BIO-16875', '15-166', 'Juan Jose Serrano ', 'SIU - Laboratorio trasplantes - Torre 1, Lab 410 - (Post-PCR) ', 'GILSON', 'P-1000', 'Y51513C', 'Extensión', 'BIO', 'Clase I', 'ACTA No. 09 17 de Septiembre de 2014', 'NI', '2003', 'UdeA', 'NI', '811.026.956-0', 'MR Y CIA S.A.S', 'No', 'NI', 'Compra', 'Hojas de vida anteriores', 'NI', 'SI', 'NI', 'SI (ING)', 'NI', 'SI', 'NI', 'NI', 'NI', 'Si', '1', 'Si', '1', 'Volumen', '200 - 1000 ul', '2 uL', '200 - 1000 ul', 'NI', 'NI', 'NI', 'NI', 'NI', 'NI', 'NI', 'SIU', 1, 'NI', 'NI'),
	(305, 'Trasplantes GICIG', 'Micropipeta', '18 / 59470', 'BIO-16876', '15-166', 'Juan Jose Serrano ', 'SIU - Laboratorio trasplantes - Torre 1, Lab 410 - (PRE-PCR) Backup1', 'GILSON', 'P-1000', 'X63933E', 'Extensión', 'BIO', 'Clase I', 'ACTA No. 09 17 de Septiembre de 2014', 'NI', 'Antes de 2005', 'UdeA', 'NI', '	800.160.884-1', 'FILTRACIÓN Y ANÁLISIS', 'No', 'NI', 'Compra', 'Histórico de reportes de mantenimiento', 'NI', 'SI', 'NI', 'SI (ING)', 'NI', 'SI', 'NI', 'NI', 'NI', 'Si', '1', 'Si', '1', 'Volumen', '200 - 1000 ul', '2 uL', '200 - 1000 ul', 'NI', 'NI', 'NI', 'NI', 'NI', 'NI', 'NI', 'SIU', 1, 'NI', 'NI'),
	(306, 'Trasplantes GICIG', 'Micropipeta', '8 / 3.060881.00', 'BIO-16877', '15-166', 'Juan Jose Serrano / Gloria Vasquez', 'SIU - Laboratorio trasplantes - Torre 1, Lab 410 - (PRE-PCR) Backup2', 'GILSON', 'P-1000', 'CB63839', 'Extensión', 'BIO', 'Clase I', 'ACTA No. 09 17 de Septiembre de 2014', 'NI', 'Antes de 2018', 'UdeA', 'NI', 'NI', 'ND', 'No', 'NI', 'Compra', 'Histórico de reportes de mantenimiento', 'NI', 'SI', 'NI', 'SI (ING)', 'NI', 'SI', 'NI', 'NI', 'NI', 'Si', '1', 'Si', '1', 'Volumen', '200 - 1000 ul', '2 uL', '200 - 1000 ul', 'NI', 'NI', 'NI', 'NI', 'NI', 'NI', 'NI', 'SIU', 1, 'NI', 'NI'),
	(307, 'Trasplantes GICIG', 'Micropipeta', '4 / 3 - 059471 - 00 / 011919', 'BIO-16878', '15-166', 'Juan Jose Serrano ', 'SIU - Laboratorio trasplantes - Torre 1, Lab 410 -  (PRE-PCR)', 'GILSON', 'P-1000', 'X62492E', 'Extensión', 'BIO', 'Clase I', 'ACTA No. 09 17 de Septiembre de 2014', 'NI', 'NI', 'UdeA', 'NI', '	800.160.884-1', 'FILTRACIÓN Y ANÁLISIS', 'No', 'NI', 'Compra', 'NI', 'NI', 'SI', 'NI', 'SI (ING)', 'NI', 'SI', 'NI', 'NI', 'NI', 'Si', '1', 'Si', '1', 'Volumen', '200 - 1000 ul', '2 uL', '200 - 1000 ul', 'NI', 'NI', 'NI', 'NI', 'NI', 'NI', 'NI', 'SIU', 1, 'NI', 'NI'),
	(308, 'Inmunodeficiencias Primarias', 'Refrigerador', '132496 / 008721', 'Pendiente', '17-157', 'Diana Arboleda / Claudia Milena Trujillo Vargas', 'SIU - Laboratorio de Inmunodeficiencias primarias - Torre 2, Lab 530', 'FAGOR', 'AFP701', '06060075M', 'Extensión', 'IND', 'NI', 'NI', 'NI', '31/07/2009', 'UdeA', 'NI', '811.014.137-3', 'Fagor Industrial S.A.', 'No', 'Julio de 2010', 'Compra', 'Factura', '010190', 'SI', 'NI', 'SI (Ficha tecnica)', 'NI', 'NI', 'NI', 'NI', 'NI', 'SI', '1', 'SI', '1 (calificación)', 'Temperatura', 'T - 2 a 8 °C', 'NI', 'NI', 'NI', '220 VAC', 'NI', 'NI', 'Máx. 43°C', '110 kg', 'Potencia 208 W Frecuencia 50/60 Hz', 'SIU', 1, '693 x 726 x 2067 mm', 'NI'),
	(309, 'Inmunodeficiencias Primarias', 'Lector de platos ELISA', '146231', 'BIO-16759', '16-979', 'Diana Arboleda / Juan Álvaro López Quintero', 'SIU - Laboratorio de Inmunodeficiencias primarias - Torre 2, Lab 530', 'BioRad', 'iMark', '15486', 'Extensión', 'BIO', 'Clase IIa', 'Comprado en Febrero de 2013 y el INVIMA lo clasificó como dispositivo médico en Acta No. 08 septiembre 11 de  2013', 'NI', '6/02/2013', 'UdeA', 'NI', '830.034.233-7', 'AM LTDA.', 'No', 'Febrero de 2014', 'Compra', 'Factura', '12-065', 'SI', 'NI', 'SI', 'SI', 'NI', 'NI', 'SI', 'Anual', 'SI', '1', 'NO', 'NI', 'Longitud de onda', '400 - 750 nm', 'NI', 'NI', 'NI', '120 VAC', 'NI', 'Máx. 90%HR', '15 - 40 °C', '5,5 kg', 'Frecuencia 50/60 Hz Potencia 100 VA', 'SIU', 1, '346 mm x 377 mm x 164 mm (ancho x profundidad x altura)', 'NI'),
	(310, 'Inmunodeficiencias Primarias', 'Lavador de platos de ELISA', '140119 / 008685', 'BIO-16760', '17-489', 'Diana Arboleda /Monica Lucia Giraldo Restrepo', 'SIU - Laboratorio de Inmunodeficiencias primarias - Torre 2, Lab 530', 'Awareness Technology', 'Stat Fax 2600', '2600-7447', 'Extensión', 'BIO', 'Clase IIa', 'INVIMA 2018DM-0018956', 'NI', '6/07/2011', 'UdeA', 'NI', '830.025.281-2', 'ANNIR', 'No', 'Julio de 2012', 'Compra', 'Factura', 'SAS-144963', 'SI', 'NI', 'SI', 'SI (CAP MANT)', 'NI', 'NI', 'SI (parcial)', 'Semestral', 'SI', '1', 'NO', 'NI', 'NI', 'NI', 'NI', 'NI', 'NI', '110-120 / 220-240 VAC', 'NI', '80%HR para temperaturas de hasta 31 ° C, disminuyendo linealmente a 50%HR a 40°C', '5 - 40 °C', '10 kg', 'Potencia 70 W Frecuencia 50/60 Hz', 'SIU', 1, '34,3 cm x 40,6 cm x 19 cm', 'NI'),
	(311, 'Inmunodeficiencias Primarias', 'Microscopio', '132498 / 040037', 'BIO-16761', '12-536', 'Diana Arboleda / Claudia Milena Trujillo Vargas', 'SIU - Laboratorio de Inmunodeficiencias primarias - Torre 2, Lab 530', 'OLYMPUS', 'CX21FS1', ' 8D07016', 'Extensión', 'BIO', 'Clase I', 'ACTA No. 07 Junio 10 de 2009, en esta acta el Invima indica que los microscopios no requieren registro sanitario, hasta el ACTA No. 09 Octubre 17 de 2012 donde indica que ya si lo requiere.', 'NI', 'Factura 24/07/2009            Carta de garantía 31/07/2002', 'UdeA', 'NI', '811.033.098-5', 'Importecnical', 'No', '31/07/2010', 'Compra', 'Factura', '006823', 'SI', 'NI', 'SI (ING)', 'SI (ING)', 'SI', 'NI', 'SI', 'Anual', 'SI', '1', 'NO', 'NI', 'NI', 'NI', 'NI', 'NI', 'NI', '100-120/220-240 VAC', '0,42/0,25 A', '80%HR para temperaturas de hasta 31 ° C, disminuyendo linealmente a 50%HR a 40°C', '5 - 40 °C', '5,9 kg', 'Frecuencia 50/60 Hz', 'SIU', 1, '154 x 391 x 238 mm', 'NI'),
	(312, 'Inmunodeficiencias Primarias', 'Microscopio', '132499 / 008680', 'BIO-16811', '12-536', 'Diana Arboleda / Claudia Milena Trujillo Vargas', 'SIU - Cuarto de cultivo', 'OLYMPUS', 'CX21FS1', ' 8F11617', 'Extensión, Investigación', 'BIO', 'Clase I', 'ACTA No. 07 Junio 10 de 2009, en esta acta el Invima indica que los microscopios no requieren registro sanitario, hasta el ACTA No. 09 Octubre 17 de 2012 donde indica que ya si lo requiere.', 'NI', 'Factura 24/07/2009            Carta de garantía 31/07/2002', 'UdeA', 'NI', '811.033.098-5', 'Importecnical', 'No', '31/07/2010', 'Compra', 'Factura', '006823', 'SI', 'NI', 'SI (ING)', 'SI (ING)', 'SI', 'NI', 'SI', 'Anual', 'SI', '1', 'NO', 'NI', 'NI', 'NI', 'NI', 'NI', 'NI', '100-120/220-240 VAC', '0,42/0,25 A', '80%HR para temperaturas de hasta 31 ° C, disminuyendo linealmente a 50%HR a 40°C', '5 - 40 °C', '5,9 kg', 'Frecuencia 50/60 Hz', 'SIU', 1, '154 x 391 x 238 mm', 'NI'),
	(313, 'Inmunodeficiencias Primarias', 'Baño María', '143436 / 008689', 'BIO-16307', '16-861', 'Diana Arboleda / Claudia Milena Trujillo Vargas', 'SIU - Laboratorio de Inmunodeficiencias primarias - Torre 2, Lab 530', 'Memmert', 'WNB 7', 'L211.1357', 'Extensión  ', 'BIO', 'Clase I', 'ACTA No. 07 Junio 10 de 2009 indica que no requiere registro sanitario, y se rectifica en ACTA No. 09 Octubre 17 de 2012', 'NI', '22/05/2012', 'UdeA', 'NI', '811.033.098-5', 'Importecnical', 'No', 'Mayo de 2013', 'Compra', 'Factura', 'IM011571', 'SI', 'NO', 'SI', 'SI (CAP MANT)', 'SI', 'SI', 'SI', 'NI', 'SI', '1', 'SI', '1', 'Temperatura         Tiempo', '10 - 95 °C         99:59 hrs:min', '0,1 °C', 'NI', 'FLUCTUACION DE CONTROL/VARIACION DE TEMPERATURA: +/-0.1 ºC /+/-0.25 ºC', '115 VAC', '10,4 A', 'Máx. 80% HR', '5 - 40 °C', '11 kg', 'Potencia 1200 W                                                                              Frecuencia 50/60 Hz', 'SIU', 1, 'Altura 337 mm X  Largo 468 mm X Ancho 356 mm', '$ 2.648.280'),
	(314, 'Inmunodeficiencias Primarias', 'Baño María', '143437 / 040042', 'BIO-16755', '16-861', 'Diana Arboleda / Claudia Milena Trujillo Vargas', 'SIU - Laboratorio de Inmunodeficiencias primarias - Torre 2, Lab 530', 'Memmert', 'WNB 7', 'L211.1359', 'Extensión, Investigación', 'BIO', 'Clase I', 'ACTA No. 07 Junio 10 de 2009 indica que no requiere registro sanitario, y se rectifica en ACTA No. 09 Octubre 17 de 2012', 'NI', '22/05/2012', 'UdeA', 'NI', '811.033.098-5', 'Importecnical', 'No', 'Mayo de 2013', 'Compra', 'Factura', 'IM011571', 'SI', 'NO', 'SI', 'SI (CAP MANT)', 'SI', 'SI', 'SI', 'NI', 'SI', '1', 'SI', '1', 'Temperatura         Tiempo', '10 - 95 °C         99:59 hrs:min', '0,1 °C', 'NI', 'FLUCTUACION DE CONTROL/VARIACION DE TEMPERATURA: +/-0.1 ºC /+/-0.25 ºC', '115 VAC', '10,4 A', 'Máx. 80% HR', '5 - 40 °C', '11 kg', 'Potencia 1200 W                                                                              Frecuencia 50/60 Hz', 'SIU', 1, 'Altura 337 mm X  Largo 468 mm X Ancho 356 mm', '$ 2.648.280'),
	(315, 'Inmunodeficiencias Primarias', 'Incubadora CO2', 'No tiene', 'BIO-16311', '18-013', 'Diana Arboleda / Claudia Milena Trujillo Vargas', 'SIU - Cuarto de cultivo', 'Thermo Scientific', 'Series 8000 WJ 3428', '181988-102', 'Extensión, Investigación', 'BIO', 'Clase IIa', 'INVIMA 2017DM-0016578', 'NI', '29/10/2013', 'Comprado por fundación', '8/08/2013', '860.072.122-9', 'G&G Sucesores', 'No', 'Octubre de 2014', 'Donación', 'Factura', 'F-8502', 'SI', 'NO', 'SI (ING Y TRADUCIDO)', 'SI (CAP MANT ING Y TRADUCIDO)', 'SI', 'SI', 'NO', 'Anual', 'SI', '1', 'SI', '1 (calificación)', 'Temperatura         %CO2', '5ºC sobre la temperatura ambiente hasta 55ºC                             0 - 20 %CO2', '0,1 °C / 0,1 %CO2', 'NI', 'NI', '115 VAC', '3,60 A', '80 %HR hasta 31 °C, decreciendo linealmente hasta 50 %HR a 40°C', '5 - 40 °C', '120,2 kg', 'Frecuencia 50/60 Hz', 'SIU', 1, '66,8cm x 100,3cm x 635cm', '$ 17.933.600'),
	(316, 'Inmunodeficiencias Primarias', 'Agitador Vortex', '151664', 'BIO-16308', '15-651', 'Diana Arboleda / Jose Luis Franco', 'SIU - Laboratorio de Inmunodeficiencias primarias - Torre 2, Lab 530 ', 'Labnet', 'S0200', 'Z3121820', 'Extensión  ', 'BIO', 'NI', 'ACTA No. 07 Junio 10 de 2009 indica que no requiere registro sanitario, y se rectifica en ACTA No. 03 Abril 10 de 2013 ', 'NI', '22/04/2014', 'UdeA', 'NI', '860.521.570-2', 'Biodiagnóstica Ltda', 'No', 'Abril de 2015', 'Compra', 'Factura', '16028', 'SI', 'NO', 'SI', 'SI (CAP MANT)', 'SI', 'SI', 'NO', 'NI', 'SI', '1', 'NO', 'NI', 'Velocidad               ', 'Máx. 3400 rpm (60 Hz) / 2850 rpm (50 Hz)', 'NI', 'NI', 'NI', '120 VAC', '0,6 A', 'NI', '4 - 65 °C', '2,2 kg', 'Frecuencia 60 Hz', 'SIU', 1, '14 x 16 x 12 cm', '$ 501.120'),
	(317, 'Inmunodeficiencias Primarias', 'Centrífuga refrigerada', '119807 / 000791', 'BIO-16756', '18-265', 'Diana Arboleda / Jose Luis Franco', 'SIU - Cuarto de cultivo', 'Eppendorf', ' 5810R ', '0033896', 'Extensión, Investigación', 'BIO', 'Clase I', 'INVIMA 2014DM-0011801', 'NI', '2006', 'UdeA', '2005', '811.033.098-5', 'Importecnical', 'No', 'Mayo de 2007', 'Compra', 'NI', 'NI', 'SI', 'NO', 'SI', 'SI (CAP MANT)', 'SI', 'SI', 'NO', 'Anual', 'SI', '1', 'SI', '1', 'Velocidad         Temperatura      Tiempo', '200 - 14000 rpm                                                T -9 - 40 °C                                                    1 - 99 min', '10 rpm hasta 5000 rpm, en adelante 100 rpm                                           1°C                                                                                                     1 min', 'NI', 'NI', '120 VAC', '12:00 a. m.', 'Máx. 75 %HR', '10 - 35 °C', '99 kg', 'Frecuencia 60 Hz  Potencia 1300 W', 'SIU', 1, '700 x 608 x 345 mm', 'NI'),
	(318, 'Grupo Reproducción', 'Balanza Analitica', '038547', 'BIO-16846', '10-261', 'Carolina Navarro', 'SIU - Laboratorio Reproducción - Torre 2, Lab 534', 'Adam Equipment', 'NBL 124e', 'AE9UT335', 'Extensión', 'BIO', 'Clase I', 'ACTA No. 07 Junio 10 de 2009', 'NI', 'NI', 'UdeA', 'NI', '900.355.024-5', 'Equipos y laboratorio', 'No', 'NI', 'Compra', 'Factura', 'NI', 'SI', 'NI', 'NI', 'NI', 'NI', 'NI', 'NI', 'NI', 'Si', '1', 'Si', '1', 'Peso', 'carga max. 120 g', '0,0001 g', 'NI', 'NI', 'NI', 'NI', 'NI', 'NI', 'NI', 'NI', 'SIU', 1, 'NI', 'NI'),
	(319, 'Grupo Reproducción', 'Micropipeta', '023117', 'BIO-17234', '15-166', 'Carolina Navarro', 'SIU - Laboratorio Reproducción - Torre 2, Lab 534', 'Nichirio', 'Nichipet Explus', 'H38014182', 'Extensión', 'BIO', 'Clase I', 'ACTA No. 09 17 de Septiembre de 2014', 'NI', 'NI', 'UdeA', 'NI', 'NI', 'GENTECH', 'No', 'NI', 'Compra', 'Factura', 'NI', 'SI', 'NI', 'NI', 'NI', 'NI', 'NI', 'NI', 'NI', 'Si', '1', 'Si', '1', 'Volumen', '2 - 20 uL', 'NI', 'NI', 'NI', 'NI', 'NI', 'NI', 'NI', 'NI', 'NI', 'SIU', 1, 'NI', 'NI'),
	(320, 'Patología', 'Micropipeta', 'LIME 541', 'BIO-16512', '15-166', 'Martha Londoño', 'Inmunohistoquímica', 'Sartorius', 'Tacta', '42186226', 'Extensión, Investigación', 'BIO', 'Clase I', 'Certificación No requiere N° 2016020596', 'NI', 'Factura 08/09/2023', 'UdeA', 'NI', '860.001.911-1', 'Kaika', 'Si', '8/09/2024', 'Compra', 'Factura', '00KK1915', 'SI', 'NI', 'NI', 'NI', 'NI', 'NI', 'NI', 'NI', 'Si', '1', 'Si', '1', 'Volumen', '10 - 100 uL', '0,1 uL', '10 - 100 uL', 'NI', 'NI', 'NI', 'NI', 'NI', 'NI', 'NI', 'San Vicente', 1, 'NI', 'NI'),
	(321, 'Patología', 'Procesador de tejidos', '119420', 'BIO-16504', '15-190', 'Juliana', 'Histotécnica', 'Leica', 'TP1020-1-1', '42231412', 'Extensión, Investigación', 'BIO', 'Clase I', 'INVIMA 2015DM-0013758', 'NI', '2006', 'UdeA', 'NI', '860.000.648-2', 'Sanitas', 'No', 'NI', 'Compra', 'NI', 'NI', 'SI', 'NI', 'NI', 'NI', 'NI', 'NI', 'NI', 'Semestral', 'Si', '2', 'Si', '2', 'Temperatura', '45 - 65 °C', '1 °C', 'NI', 'NI', '100 -120 VAC', 'NI', '20 - 80 %HR', '5 - 40 °C', '60 kg', 'NI', 'San Vicente', 1, 'Altura 595 - 780 mm            Diametro tapa 820 mm', 'NI'),
	(322, 'Patología', 'Criostato', '187701', 'BIO-16464', '15-157', 'Juliana', 'Cuarto criostato', 'Leica', 'CM1860 UV', '00000005299', 'Extensión, Investigación', 'BIO', 'Clase I', 'INVIMA 2015DM-0013759', 'NI', '12/02/2021', 'UdeA', 'dic-20', '860.000.648-2', 'Sanitas ', 'No', '12/02/2022', 'Compra', 'Factura', 'FE 46070', 'SI', 'SI', 'SI', 'SI (ING)', 'SI (PROV)', 'NI', 'NI', 'Semestral', 'Si', '2', 'No', 'NI', 'Temperatura', '0 a -35 °C', '1 °C', 'T -20 a -22 °C', 'NI', '120 - 127 VAC', 'NI', '20 - 60 %HR', '18 - 35 °C', '135 kg', 'Frecuencia: 60 Hz  Potencia: 1440 VA ', 'San Vicente', 1, '730 x 730 x 1140 mm', 'NI'),
	(323, 'Patología', 'Estación de Corte Macro', '189565', 'BIO-16466', 'NI', 'Juliana', 'Corte macro', 'Kugel Medical', 'GP 1500', '20.206422.01', 'Extensión, Investigación', 'BIO', 'NI', 'Certificación No requiere N° 2018003889', 'NI', '5/04/2021', 'UdeA', 'NI', '860.000.648-2', 'Sanitas ', 'No', '5/04/2022', 'Compra', 'Acta de entrega', 'NT', 'SI', 'SI', 'SI (ING)', 'NI', 'NI', 'NI', 'NI', 'Anual', 'Si', '1', 'No', 'NI', 'NI', 'NI', 'NI', 'NI', 'NI', '110 VAC', 'NI', 'Menor 75 %HR', 'Menor a 25 °C', 'NI', 'NI', 'San Vicente', 1, '1500 x 800 x 850/1950 mm', 'NI'),
	(324, 'Patología', 'Estación de inclusión', '178684 / 061551', 'BIO-16467', 'NI', 'Juliana', 'Histotécnica', 'Leica', 'HistoCore Arcadia H / Arcadia C', '1671 / 2048', 'Extensión, Investigación', 'BIO', 'NI', 'No requiere INVIMA', 'NI', 'NI', 'UdeA', 'dic-17', '860.000.648-2', 'Sanitas', 'No', '6/02/2019', 'Compra', 'NI', 'NI', 'SI', 'NI', 'NI', 'NI', 'NI', 'NI', 'NI', 'Semestral', 'Si', '2', 'No', 'NI', 'Temperatura', 'Arcadia H: 50 - 75°C                                            Arcadia C: - 6°C', 'Arcadia H: 1 °C', 'Arcadia H: 54 - 60°C                                           Arcadia C: - 6°C', 'Arcadia H: 1,2 °C', '100 - 120 VAC', 'Arcadia H: 10 A máx.                         Arcadia C: 5 A  máx.', '20 - 80 %HR', '20 - 30 °C', 'Arcadia H: 27 kg Arcadia C: 32 kg', 'NI', 'San Vicente', 1, 'Arcadia H: 384 x 560 x 636 mm Arcadia C: 384 x 400 x 636 mm (Alto x Ancho x Profundo)', 'NI'),
	(325, 'Dermatopatología', 'Refrigerador-congelador mixto', '209912', 'Pendiente', 'NI', 'Diana Meneses', 'Hospital Universitario San Vicente Fundación, Bloque 7, Laboratorio de Dermatopatología, Área de procesamiento - Baño de flotación', 'MELING BIOMEDICAL', 'YCD-EL450', '220702139', 'Extensión, Investigación', 'BIO', 'Clase IIa', 'INVIMA 2022DM-0025849', 'NI', '12/07/2024', 'UdeA ', 'jul-22', '900355024-5', 'Equipos y laboratorio', 'No', '12/07/2025', 'Compra', 'Factura', 'FE13533', 'NI', 'NI', 'NI', 'NI', 'NI', 'NI', 'NI', 'NI', 'Si', '1', 'Si', '1', 'Temperatura', 'Refrigeración \n2 a 8 °C\nCongelación\n- 10 a -26 °C', 'NI', 'NI', 'NI', '110 VAC', '3,23 A', 'NI', 'NI', '144 Kg', 'Frecuencia  60Hz\nVolumen 450 L', 'San Vicente', 1, 'NI', '$ 16.592.631'),
	(326, 'Dermatopatología', 'Baño de flotación', '209557', 'BIO-16666', '15 - 107', 'Diana Meneses', 'Hospital Universitario San Vicente Fundación, Bloque 7, Laboratorio de Dermatopatología, Área de procesamiento - Baño de flotación', 'KEDEE', 'KD-P', '51A638', 'Extensión, Investigación', 'BIO', 'NI', 'No requiere INVIMA', '7 Años', '19/07/2024', 'UdeA ', 'abr-24', '901.633.213-7', 'Mercilab S.A.S', 'Si', 'jul-25', 'Compra', 'Factura', 'NI', 'SI', 'NI', 'NI', 'NI', 'NI', 'NI', 'NI', 'NI', 'Si', '1', 'Si', '1', 'NI', 'NI', 'NI', 'NI', 'NI', '110 VAC', 'NI', 'NI', 'NI', 'NI', 'Frecuencia  60Hz\nPotencia 200 W', 'San Vicente', 1, 'NI', 'NI'),
	(327, 'Dermatopatología', 'Termohigrómetro digital', '2 (TH-DP-01)', 'BIO-16685', 'NI', 'Diana Meneses', 'Hospital Universitario San Vicente Fundación, Bloque 7, Laboratorio de Dermatopatología, Cuarto de inmunofluorecencia', 'Clock-Humidity', 'HTC-2', 'NI', 'Extensión, Investigación', 'BIO', 'Clase I', 'ACTA No. 03 Abril 10 de 2013', 'NI', 'NI', 'UdeA ', 'NI', 'NI', 'NI', 'No', 'NI', 'Compra', 'NI', 'NI', 'Si', 'NI', 'NI', 'NI', 'NI', 'NI', 'NI', 'NI', 'No', 'NI', 'Si', '1', 'Temperatura/Humedad', 'T -10 - 50 °C / 10 - 99 %HR', '0,1 °C / 1% HR', '18°C a 25°C / 40% a 67%.', '0,01 °C / -0,4 %HR', 'NI', 'NI', 'NI', 'NI', 'NI', 'NI', 'San Vicente', 1, 'NI', 'NI'),
	(328, 'Dermatopatología', 'Termohigrómetro digital', '1 (01A10)', 'BIO-16686', 'NI', 'Diana Meneses', 'Hospital Universitario San Vicente Fundación, Bloque 7, Laboratorio de Dermatopatología, Área de procesamiento', 'BOECO Germany', 'BOE330', 'NI', 'Extensión, Investigación', 'BIO', 'Clase I', 'ACTA No. 03 Abril 10 de 2013', 'NI', 'NI', 'UdeA ', 'NI', 'NI', 'NI', 'No', 'NI', 'Compra', 'NI', 'NI', 'Si', 'NI', 'NI', 'NI', 'NI', 'NI', 'NI', 'NI', 'No', 'NI', 'Si', '1', 'Temperatura/Humedad', '0 - 50 °C / 25 - 95 %HR', '1 °C / 1%HR', '18 a 25 °C / 40 a 67 %HR', '0,24 °C / -0,7 %HR', 'NI', 'NI', 'NI', 'NI', 'NI', 'NI', 'San Vicente', 1, 'NI', 'NI'),
	(329, 'Dermatopatología', 'Microscopio y Cámara Leica', '164367', 'BIO-16681', '15 - 156', 'Diana Meneses', 'Hospital Universitario San Vicente Fundación, Bloque 7, Laboratorio de Dermatopatología, Cuarto de inmunofluorecencia', 'Leica', 'DM500', 'C540242931LS0390', 'Investigación, Docencia, Extensión', 'BIO', 'Clase I', 'INVIMA 2014DM-0011844', 'NI', '2016', 'UdeA ', 'may-16', '860.000.648-2', 'Sanitas S.A.S', 'No', 'NI', 'Compra', 'NI', 'NI', 'Si', 'NI', 'Si', 'Si', 'NI', 'NI', 'NI', 'NI', 'Si', '2', 'No', 'NI', 'NI', 'NI', 'NI', 'NI', 'NI', '100 - 240 VAC', 'NI', 'NI', 'NI', 'NI', 'Frecuenia 50/60 Hz\nPotencia 17W', 'San Vicente', 1, 'NI', 'NI');

-- Volcando estructura para tabla gestorlimebd.api_usuario
CREATE TABLE IF NOT EXISTS `api_usuario` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `nombreusuario` varchar(100) NOT NULL,
  `contraseña` varchar(255) NOT NULL,
  `rol` varchar(10) NOT NULL,
  `activo` tinyint(1) NOT NULL,
  `fecha_creacion` date NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `nombreusuario` (`nombreusuario`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Volcando datos para la tabla gestorlimebd.api_usuario: ~2 rows (aproximadamente)
INSERT INTO `api_usuario` (`id`, `nombreusuario`, `contraseña`, `rol`, `activo`, `fecha_creacion`) VALUES
	(1, 'mpaulina', '12345', 'admin', 1, '2025-11-30'),
	(2, 'mpaulinaariasviewer', '12345', 'viewer', 1, '2025-11-30');

-- Volcando estructura para tabla gestorlimebd.auth_group
CREATE TABLE IF NOT EXISTS `auth_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(150) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Volcando datos para la tabla gestorlimebd.auth_group: ~0 rows (aproximadamente)

-- Volcando estructura para tabla gestorlimebd.auth_group_permissions
CREATE TABLE IF NOT EXISTS `auth_group_permissions` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Volcando datos para la tabla gestorlimebd.auth_group_permissions: ~0 rows (aproximadamente)

-- Volcando estructura para tabla gestorlimebd.auth_permission
CREATE TABLE IF NOT EXISTS `auth_permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Volcando datos para la tabla gestorlimebd.auth_permission: ~40 rows (aproximadamente)
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
	(1, 'Can add log entry', 1, 'add_logentry'),
	(2, 'Can change log entry', 1, 'change_logentry'),
	(3, 'Can delete log entry', 1, 'delete_logentry'),
	(4, 'Can view log entry', 1, 'view_logentry'),
	(5, 'Can add permission', 2, 'add_permission'),
	(6, 'Can change permission', 2, 'change_permission'),
	(7, 'Can delete permission', 2, 'delete_permission'),
	(8, 'Can view permission', 2, 'view_permission'),
	(9, 'Can add group', 3, 'add_group'),
	(10, 'Can change group', 3, 'change_group'),
	(11, 'Can delete group', 3, 'delete_group'),
	(12, 'Can view group', 3, 'view_group'),
	(13, 'Can add user', 4, 'add_user'),
	(14, 'Can change user', 4, 'change_user'),
	(15, 'Can delete user', 4, 'delete_user'),
	(16, 'Can view user', 4, 'view_user'),
	(17, 'Can add content type', 5, 'add_contenttype'),
	(18, 'Can change content type', 5, 'change_contenttype'),
	(19, 'Can delete content type', 5, 'delete_contenttype'),
	(20, 'Can view content type', 5, 'view_contenttype'),
	(21, 'Can add session', 6, 'add_session'),
	(22, 'Can change session', 6, 'change_session'),
	(23, 'Can delete session', 6, 'delete_session'),
	(24, 'Can view session', 6, 'view_session'),
	(25, 'Can add equipo', 7, 'add_equipo'),
	(26, 'Can change equipo', 7, 'change_equipo'),
	(27, 'Can delete equipo', 7, 'delete_equipo'),
	(28, 'Can view equipo', 7, 'view_equipo'),
	(29, 'Can add edicion equipo', 8, 'add_edicionequipo'),
	(30, 'Can change edicion equipo', 8, 'change_edicionequipo'),
	(31, 'Can delete edicion equipo', 8, 'delete_edicionequipo'),
	(32, 'Can view edicion equipo', 8, 'view_edicionequipo'),
	(33, 'Can add usuario', 9, 'add_usuario'),
	(34, 'Can change usuario', 9, 'change_usuario'),
	(35, 'Can delete usuario', 9, 'delete_usuario'),
	(36, 'Can view usuario', 9, 'view_usuario'),
	(37, 'Can add desactivacion equipo', 10, 'add_desactivacionequipo'),
	(38, 'Can change desactivacion equipo', 10, 'change_desactivacionequipo'),
	(39, 'Can delete desactivacion equipo', 10, 'delete_desactivacionequipo'),
	(40, 'Can view desactivacion equipo', 10, 'view_desactivacionequipo');

-- Volcando estructura para tabla gestorlimebd.auth_user
CREATE TABLE IF NOT EXISTS `auth_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(150) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Volcando datos para la tabla gestorlimebd.auth_user: ~0 rows (aproximadamente)

-- Volcando estructura para tabla gestorlimebd.auth_user_groups
CREATE TABLE IF NOT EXISTS `auth_user_groups` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`),
  KEY `auth_user_groups_group_id_97559544_fk_auth_group_id` (`group_id`),
  CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Volcando datos para la tabla gestorlimebd.auth_user_groups: ~0 rows (aproximadamente)

-- Volcando estructura para tabla gestorlimebd.auth_user_user_permissions
CREATE TABLE IF NOT EXISTS `auth_user_user_permissions` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`),
  KEY `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Volcando datos para la tabla gestorlimebd.auth_user_user_permissions: ~0 rows (aproximadamente)

-- Volcando estructura para tabla gestorlimebd.django_admin_log
CREATE TABLE IF NOT EXISTS `django_admin_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext DEFAULT NULL,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint(5) unsigned NOT NULL CHECK (`action_flag` >= 0),
  `change_message` longtext NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk_auth_user_id` (`user_id`),
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Volcando datos para la tabla gestorlimebd.django_admin_log: ~0 rows (aproximadamente)

-- Volcando estructura para tabla gestorlimebd.django_content_type
CREATE TABLE IF NOT EXISTS `django_content_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Volcando datos para la tabla gestorlimebd.django_content_type: ~10 rows (aproximadamente)
INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES
	(1, 'admin', 'logentry'),
	(10, 'api', 'desactivacionequipo'),
	(8, 'api', 'edicionequipo'),
	(7, 'api', 'equipo'),
	(9, 'api', 'usuario'),
	(3, 'auth', 'group'),
	(2, 'auth', 'permission'),
	(4, 'auth', 'user'),
	(5, 'contenttypes', 'contenttype'),
	(6, 'sessions', 'session');

-- Volcando estructura para tabla gestorlimebd.django_migrations
CREATE TABLE IF NOT EXISTS `django_migrations` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=53 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Volcando datos para la tabla gestorlimebd.django_migrations: ~52 rows (aproximadamente)
INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES
	(1, 'contenttypes', '0001_initial', '2025-11-12 14:26:08.564039'),
	(2, 'auth', '0001_initial', '2025-11-12 14:26:08.770215'),
	(3, 'admin', '0001_initial', '2025-11-12 14:26:08.820150'),
	(4, 'admin', '0002_logentry_remove_auto_add', '2025-11-12 14:26:08.824727'),
	(5, 'admin', '0003_logentry_add_action_flag_choices', '2025-11-12 14:26:08.828638'),
	(6, 'contenttypes', '0002_remove_content_type_name', '2025-11-12 14:26:08.866983'),
	(7, 'auth', '0002_alter_permission_name_max_length', '2025-11-12 14:26:08.894738'),
	(8, 'auth', '0003_alter_user_email_max_length', '2025-11-12 14:26:08.908897'),
	(9, 'auth', '0004_alter_user_username_opts', '2025-11-12 14:26:08.914745'),
	(10, 'auth', '0005_alter_user_last_login_null', '2025-11-12 14:26:08.937992'),
	(11, 'auth', '0006_require_contenttypes_0002', '2025-11-12 14:26:08.939608'),
	(12, 'auth', '0007_alter_validators_add_error_messages', '2025-11-12 14:26:08.944249'),
	(13, 'auth', '0008_alter_user_username_max_length', '2025-11-12 14:26:08.959467'),
	(14, 'auth', '0009_alter_user_last_name_max_length', '2025-11-12 14:26:08.974323'),
	(15, 'auth', '0010_alter_group_name_max_length', '2025-11-12 14:26:08.988878'),
	(16, 'auth', '0011_update_proxy_permissions', '2025-11-12 14:26:08.994239'),
	(17, 'auth', '0012_alter_user_first_name_max_length', '2025-11-12 14:26:09.009011'),
	(18, 'sessions', '0001_initial', '2025-11-12 14:26:09.027665'),
	(19, 'api', '0001_initial', '2025-11-12 20:20:24.660787'),
	(20, 'api', '0002_edicionequipo', '2025-11-13 02:19:34.376325'),
	(21, 'api', '0003_edicionequipo_responsable_actualizado_and_more', '2025-11-13 02:31:01.628481'),
	(22, 'api', '0004_alter_edicionequipo_responsable_actualizado_and_more', '2025-11-13 02:33:29.774955'),
	(23, 'api', '0005_alter_equipo_clasificacion_ips_and_more', '2025-11-20 17:21:04.935721'),
	(24, 'api', '0006_remove_equipo_dimensiones_equipo_dimensiones_alto_and_more', '2025-11-20 17:30:57.171905'),
	(25, 'api', '0007_remove_equipo_dimensiones_equipo_dimensiones_alto_and_more', '2025-11-20 17:33:56.924627'),
	(26, 'api', '0007_alter_equipo_dimensiones_alto_and_more', '2025-11-21 01:55:21.178959'),
	(27, 'api', '0008_alter_equipo_sede', '2025-11-21 01:55:21.182764'),
	(28, 'api', '0009_equipo_activo_alter_equipo_sede', '2025-11-26 23:04:16.771081'),
	(29, 'api', '0010_alter_equipo_fecha_adquisicion_and_more', '2025-11-27 00:30:44.744643'),
	(30, 'api', '0011_remove_equipo_dimensiones_alto_and_more', '2025-11-27 00:37:18.637930'),
	(31, 'api', '0012_alter_equipo_clasificacion_misional', '2025-11-27 00:44:55.464481'),
	(32, 'api', '0013_alter_equipo_clasificacion_misional_and_more', '2025-11-27 15:08:47.451705'),
	(33, 'api', '0014_equipo_valor_compra', '2025-11-27 15:09:40.448470'),
	(34, 'api', '0015_alter_equipo_clasificacion_ips_and_more', '2025-11-27 16:33:57.479259'),
	(35, 'api', '0016_alter_equipo_frecuencia_calibracion_and_more', '2025-11-27 16:36:31.689971'),
	(36, 'api', '0017_alter_equipo_guia_rapida_alter_equipo_protocolo_mto_and_more', '2025-11-27 16:39:37.126028'),
	(37, 'api', '0018_alter_equipo_tiempo_vida_util', '2025-11-27 16:40:39.963645'),
	(38, 'api', '0019_alter_equipo_tiempo_vida_util', '2025-11-27 16:41:37.475120'),
	(39, 'api', '0020_alter_equipo_frecuencia_calibracion', '2025-11-27 16:52:28.148411'),
	(40, 'api', '0021_alter_equipo_humedad_alter_equipo_magnitud_and_more', '2025-11-27 16:53:58.312317'),
	(41, 'api', '0022_alter_equipo_peso', '2025-11-27 16:54:13.774818'),
	(42, 'api', '0023_alter_equipo_rango_trabajo', '2025-11-27 16:54:30.534883'),
	(43, 'api', '0024_alter_equipo_clasificacion_misional', '2025-11-27 16:54:48.107279'),
	(44, 'api', '0025_alter_equipo_registro_importacion', '2025-11-27 17:01:17.628977'),
	(45, 'api', '0026_alter_equipo_protocolo_mto', '2025-11-27 17:01:38.159288'),
	(46, 'api', '0027_alter_equipo_error_maximo', '2025-11-27 17:01:55.031096'),
	(47, 'api', '0028_alter_equipo_corriente', '2025-11-27 17:02:08.330312'),
	(48, 'api', '0016_alter_equipo_calibracion_and_more', '2025-11-27 20:41:38.518622'),
	(49, 'api', '0017_remove_edicionequipo_responsable_actualizado_and_more', '2025-11-27 21:04:43.746863'),
	(50, 'api', '0018_alter_edicionequipo_fecha', '2025-11-27 21:25:14.299359'),
	(51, 'api', '0019_usuario_alter_equipo_clasificacion_misional_and_more', '2025-11-30 13:57:06.153082'),
	(52, 'api', '0020_alter_usuario_fecha_creacion', '2025-11-30 13:59:58.250802');

-- Volcando estructura para tabla gestorlimebd.django_session
CREATE TABLE IF NOT EXISTS `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Volcando datos para la tabla gestorlimebd.django_session: ~0 rows (aproximadamente)

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
