-- phpMyAdmin SQL Dump
-- version 4.7.3
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Jul 30, 2019 at 07:31 PM
-- Server version: 5.6.40-84.0-log
-- PHP Version: 5.6.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `casacult_casa_cultural`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`casacult`@`localhost` PROCEDURE `actualizar_matricula` (IN `id` INT, IN `estado` VARCHAR(50), IN `comentario` VARCHAR(1000))  NO SQL
UPDATE `Matricula` SET `estado` = estado, `comentario` = comentario  WHERE `Matricula`.`id` = id$$

CREATE DEFINER=`casacult`@`localhost` PROCEDURE `actualizar_periodo` (IN `fecha` VARCHAR(40), IN `id` INT)  NO SQL
UPDATE Periodo
SET fecha_final=fecha
WHERE idPeriodo=id$$

CREATE DEFINER=`casacult`@`localhost` PROCEDURE `agregar_factura` (IN `in_id_matricula` INT(40), IN `in_num_factura` INT(50))  NO SQL
UPDATE `Matricula` SET `numero_factura_electronica` = in_num_factura WHERE `Matricula`.`id` = in_id_matricula$$

CREATE DEFINER=`casacult`@`localhost` PROCEDURE `cerrar_curso` (IN `idCurso_X_Periodo_in` INT(11))  NO SQL
BEGIN

UPDATE Curso_X_Periodo

SET Curso_X_Periodo.estado = "cerrado" 
WHERE Curso_X_Periodo.id = idCurso_X_Periodo_in;

END$$

CREATE DEFINER=`casacult`@`localhost` PROCEDURE `desactivar_administrador` (IN `id_admin_in` INT(11))  NO SQL
BEGIN

UPDATE Administrador

SET Administrador.estado = "inactivo" 
WHERE Administrador.idAdministrador = id_admin_in;

END$$

CREATE DEFINER=`casacult`@`localhost` PROCEDURE `editar_profesor` (IN `cedula_in` INT(10) UNSIGNED, IN `nombre_in` VARCHAR(45), IN `primer_apellido_in` VARCHAR(45), IN `segundo_apellido_in` VARCHAR(45), IN `telefono_in` VARCHAR(45), IN `telefono_2_in` VARCHAR(45), IN `correo_in` VARCHAR(45), IN `provincia_in` VARCHAR(45), IN `canton_in` VARCHAR(45), IN `distrito_in` VARCHAR(45), IN `sennas_in` VARCHAR(240), IN `identificacion_in` VARCHAR(12), IN `nombre_completo_in` VARCHAR(65), IN `razon_social_in` VARCHAR(45), IN `estado_tributario_in` TINYINT(1), IN `nombre_actividad_in` VARCHAR(45), IN `codigo_actividad_in` VARCHAR(45), IN `id_profesor_in` INT(10))  BEGIN

UPDATE Usuario 
SET nombre = nombre_in,
	primer_apellido = primer_apellido_in,
    segundo_apellido = segundo_apellido_in,
    telefono = telefono_in,
    telefono2 = telefono_2_in,
    correo = correo_in
WHERE cedula = cedula_in;

UPDATE Direccion
SET provincia = provincia_in,
	canton = canton_in,
    distrito = distrito_in,
    sennas = sennas_in
WHERE id_profesor = id_profesor_in;

UPDATE Facturacion
SET nombre = nombre_completo_in,
	codigo_actividad = codigo_actividad_in,
    estado_tributario = estado_tributario_in,
    razon_social = razon_social_in,
    nombre_actividad = nombre_actividad_in
WHERE id_profesor = id_profesor_in;


END$$

CREATE DEFINER=`casacult`@`localhost` PROCEDURE `editar_usuario` (IN `cedula_in` INT(11), IN `nombre_in` VARCHAR(25), IN `primer_apellido_in` VARCHAR(45), IN `segundo_apellido_in` VARCHAR(45), IN `telefono_in` VARCHAR(45), IN `telefono2_in` VARCHAR(45), IN `correo_in` VARCHAR(45))  NO SQL
    COMMENT 'Procedimiento para actualizar los datos de los usuarios'
BEGIN

	UPDATE Usuario
    
    SET nombre = nombre_in,
		primer_apellido = primer_apellido_in,
		segundo_apellido = segundo_apellido_in,
        telefono = telefono_in,
        telefono2 = telefono2_in,
        correo = correo_in

    WHERE cedula = cedula_in;

END$$

CREATE DEFINER=`casacult`@`localhost` PROCEDURE `matricular` (IN `input_cedula` INT, IN `input_curXper` INT, IN `input_num_compro` VARCHAR(50), IN `input_comprobante` VARCHAR(400))  NO SQL
BEGIN
INSERT INTO Matricula(cedula_estudiante, id_Curso_X_Periodo, numero_comprobante, comprobante)
VALUES (input_cedula, input_curXper, input_num_compro, input_comprobante);

UPDATE Curso
SET Curso.cupo = Curso.cupo - 1
WHERE Curso.idCurso = (SELECT Curso_X_Periodo.idCurso FROM Curso_X_Periodo WHERE Curso_X_Periodo.id = input_curXper);

END$$

CREATE DEFINER=`casacult`@`localhost` PROCEDURE `modificar_curso_matricula` (IN `in_id_cursoxperiodo` INT(40), IN `in_id_matricula` INT(40))  NO SQL
UPDATE `Matricula` SET `id_Curso_X_Periodo` = in_id_cursoxperiodo WHERE `Matricula`.`id` = in_id_matricula$$

CREATE DEFINER=`casacult`@`localhost` PROCEDURE `obtener_administradores_activos` ()  NO SQL
BEGIN

SELECT Administrador.idAdministrador, Usuario.cedula, CONCAT(Usuario.nombre," ", Usuario.primer_apellido, " ", Usuario.segundo_apellido) AS nombre, Administrador.tipoAdministrador 
FROM Usuario 
INNER JOIN Administrador ON Usuario.cedula = Administrador.cedula_admin WHERE Administrador.estado = "activo";

END$$

CREATE DEFINER=`casacult`@`localhost` PROCEDURE `obtener_correos_admins` ()  NO SQL
BEGIN
	SELECT DISTINCT Usuario.nombre, Usuario.primer_apellido, Usuario.segundo_apellido, Usuario.correo
    FROM Usuario
	INNER JOIN Administrador ON Administrador.cedula_admin = Usuario.cedula
    WHERE Usuario.nombre <>'' AND Usuario.primer_apellido <>''
    AND Usuario.segundo_apellido <>'' AND Usuario.correo <>''
    AND Administrador.estado = "activo";
END$$

CREATE DEFINER=`casacult`@`localhost` PROCEDURE `obtener_correos_matriculados` ()  NO SQL
BEGIN
	SELECT DISTINCT Usuario.nombre, Usuario.primer_apellido, Usuario.segundo_apellido, Usuario.correo
    FROM Usuario
	LEFT JOIN Matricula ON Matricula.cedula_estudiante = Usuario.cedula
    WHERE Usuario.nombre <>'' AND Usuario.primer_apellido <>''
    AND Usuario.segundo_apellido <>'' AND Usuario.correo <>'';
END$$

CREATE DEFINER=`casacult`@`localhost` PROCEDURE `obtener_correos_profesores` ()  NO SQL
BEGIN
	SELECT DISTINCT Usuario.nombre, Usuario.primer_apellido, Usuario.segundo_apellido, Usuario.correo
	FROM Usuario
	INNER JOIN Profesor ON Profesor.cedula_profesor = Usuario.cedula
    WHERE Usuario.nombre <>'' AND Usuario.primer_apellido <>''
    AND Usuario.segundo_apellido <>'' AND Usuario.correo <>'';
END$$

CREATE DEFINER=`casacult`@`localhost` PROCEDURE `obtener_correos_x_tipo_usuario` (`tipo_in` INT(13))  NO SQL
BEGIN
    IF tipo_in = 1 THEN
		CALL obtener_correos_admins();
	ELSEIF tipo_in = 2 THEN
		CALL obtener_correos_profesores();
	ELSEIF tipo_in = 3 THEN 
		CALL obtener_correos_matriculados();
	ELSEIF tipo_in = 4 THEN 
		CALL obtener_todos_correos_usuarios();
	END IF;
END$$

CREATE DEFINER=`casacult`@`localhost` PROCEDURE `obtener_cursos` ()  NO SQL
SELECT Curso_X_Periodo.id as idCurso,Curso.nombre as nombre,Curso.horario as horario FROM Curso, Curso_X_Periodo  WHERE Curso_X_Periodo.idCurso = Curso.idCurso and Curso.cupo>0 and Curso_X_Periodo.idPeriodo =(
 SELECT 
            MAX(Curso_X_Periodo.idPeriodo)
        FROM
            Curso_X_Periodo)$$

CREATE DEFINER=`casacult`@`localhost` PROCEDURE `obtener_cursos_x_periodo` (IN `idPeriodo_in` INT(11))  NO SQL
BEGIN

SELECT Curso.idCurso, Curso.nombre, Curso.cupo, Curso.horario, Curso.informacion, Curso_X_Periodo.id AS idCXP, Curso_X_Periodo.estado, Curso_X_Periodo.idPeriodo, CONCAT(Usuario.nombre," ", Usuario.primer_apellido, " ", Usuario.segundo_apellido) AS nombreProfesor  from Curso_X_Periodo

INNER JOIN Curso ON Curso.idCurso = Curso_X_Periodo.idCurso
INNER JOIN Profesor ON Profesor.idProfesor = Curso_X_Periodo.idProfesorAsignado
INNER JOIN Usuario ON Usuario.cedula = Profesor.cedula_profesor
WHERE Curso_X_Periodo.idPeriodo = idPeriodo_in
AND Curso_X_Periodo.estado = "disponible";

END$$

CREATE DEFINER=`casacult`@`localhost` PROCEDURE `obtener_datos_curso` (IN `idCursoXPeriodo_in` INT(5))  NO SQL
SELECT nombre, horario
from Curso 
inner join Curso_X_Periodo on Curso_X_Periodo.idCurso = Curso.idCurso
where Curso_X_Periodo.id = idCursoXPeriodo_in$$

CREATE DEFINER=`casacult`@`localhost` PROCEDURE `obtener_datos_matricula` (IN `idMatricula_in` INT(10))  NO SQL
SELECT Matricula.cedula_estudiante, Matricula.id_Curso_X_Periodo
FROM Matricula
WHERE Matricula.id = idMatricula_in$$

CREATE DEFINER=`casacult`@`localhost` PROCEDURE `obtener_datos_usuario` (IN `cedula_in` INT(11))  NO SQL
Select Usuario.nombre, Usuario.correo
from Usuario
where Usuario.cedula = cedula_in$$

CREATE DEFINER=`casacult`@`localhost` PROCEDURE `obtener_estudiantes_x_curso` (IN `idPeriodo_in` INT(11))  NO SQL
    COMMENT 'Obtiene la lista de estudiantes matriculados en un curso '
SELECT * FROM Usuario usuarios
INNER JOIN Matricula matriculas ON matriculas.cedula_estudiante = usuarios.cedula
where matriculas.id_Curso_X_Periodo = idPeriodo_in$$

CREATE DEFINER=`casacult`@`localhost` PROCEDURE `obtener_estudiantes_x_periodo` (IN `in_id_periodo` INT(40))  NO SQL
SELECT Matricula.id, Matricula.cedula_estudiante, Usuarios.nombre, Usuarios.primer_apellido, 
  Usuarios.segundo_apellido, Usuarios.correo, Matricula.numero_comprobante, Matricula.estado, 
  Matricula.comentario, Curso.nombre as 'Curso' FROM Matricula 
  LEFT JOIN Usuarios ON Matricula.cedula_estudiante = Usuarios.cedula 
  INNER JOIN Curso_X_Periodo ON Matricula.id_Curso_X_Periodo = Curso_X_Periodo.id 
  INNER JOIN Periodo ON Curso_X_Periodo.idPeriodo = Periodo.idPeriodo 
  LEFT JOIN Curso ON Curso_X_Periodo.idCurso = Curso.idCurso 
WHERE Periodo.idPeriodo = in_id_periodo$$

CREATE DEFINER=`casacult`@`localhost` PROCEDURE `obtener_historial_x_estudiante` (IN `input_cedula` VARCHAR(40))  NO SQL
SELECT
  Matricula.id,
  Matricula.cedula_estudiante,
  Curso.nombre AS nombreCurso,
  Periodo.nombre AS nombrePeriodo,
  Usuario.nombre AS nombreProfesor,
  Usuario.primer_apellido,
  Curso.horario
FROM Curso_X_Periodo
       INNER JOIN Curso
         ON Curso_X_Periodo.idCurso = Curso.idCurso
       INNER JOIN Periodo
         ON Curso_X_Periodo.idPeriodo = Periodo.idPeriodo
       INNER JOIN Matricula
         ON Curso_X_Periodo.id = Matricula.id_Curso_X_Periodo,
     Profesor
       INNER JOIN Usuario
         ON Profesor.cedula_profesor = Usuario.cedula
WHERE Matricula.cedula_estudiante = input_cedula
AND Curso_X_Periodo.idProfesorAsignado = Profesor.idProfesor$$

CREATE DEFINER=`casacult`@`localhost` PROCEDURE `obtener_listaPagos` ()  NO SQL
SELECT `Periodo`.`fecha_inicio`, `Curso`.`nombre`, `Periodo`.`nombre`, `Usuario`.`nombre`, `Usuario`.`primer_apellido` FROM `Periodo`, `Curso`, `Usuario`, `Matricula`, `Curso_X_Periodo`  WHERE `Usuario`.`cedula` = `Matricula`.`cedula_estudiante` AND `Periodo`.`idPeriodo` = `Curso_X_Periodo`.`idPeriodo` AND `Matricula`.`id_Curso_X_Periodo` = `Curso_X_Periodo`.`id` AND `Curso`.`idCurso` = `Curso_X_Periodo`.`idCurso` AND `Matricula`.`estado` = "Aceptado"$$

CREATE DEFINER=`casacult`@`localhost` PROCEDURE `obtener_listaPeriodos` ()  NO SQL
SELECT nombre, idPeriodo From Periodo$$

CREATE DEFINER=`casacult`@`localhost` PROCEDURE `obtener_lista_curso` (IN `idPeriodo_in` INT(11))  NO SQL
SELECT Usuario.cedula, CONCAT(Usuario.nombre," ", Usuario.primer_apellido, " ", Usuario.segundo_apellido) AS nombre, Usuario.correo, Usuario.telefono, Usuario.telefono2, Usuario.fecha_nacimiento, Matricula.estado, Matricula.numero_comprobante, Matricula.numero_factura_electronica, Matricula.comentario

FROM Usuario
INNER JOIN Matricula ON Matricula.cedula_estudiante = Usuario.cedula
where Matricula.id_Curso_X_Periodo = idPeriodo_in$$

CREATE DEFINER=`casacult`@`localhost` PROCEDURE `obtener_matricula_x_estudiante` (IN `input_cedula` VARCHAR(40))  NO SQL
SELECT
  Matricula.id,
  Matricula.cedula_estudiante,
  Curso.nombre AS nombreCurso,
  Periodo.nombre AS nombrePeriodo,
  Curso.horario,
  Matricula.estado,
  Matricula.comentario
FROM Curso_X_Periodo
       INNER JOIN Curso
         ON Curso_X_Periodo.idCurso = Curso.idCurso
       INNER JOIN Periodo
         ON Curso_X_Periodo.idPeriodo = Periodo.idPeriodo
       INNER JOIN Matricula
         ON Curso_X_Periodo.id = Matricula.id_Curso_X_Periodo,
     Profesor
       INNER JOIN Usuario
         ON Profesor.cedula_Profesor = Usuario.cedula
WHERE Matricula.cedula_estudiante = input_cedula
AND Curso_X_Periodo.idProfesorAsignado = Profesor.idProfesor$$

CREATE DEFINER=`casacult`@`localhost` PROCEDURE `obtener_periodos_actuales` ()  NO SQL
BEGIN

SET @HOY = CURDATE();

SELECT Periodo.nombre, Periodo.idPeriodo from Periodo
WHERE Periodo.fecha_final > @HOY
ORDER BY Periodo.fecha_final ASC;

END$$

CREATE DEFINER=`casacult`@`localhost` PROCEDURE `obtener_periodos_fecha` ()  NO SQL
SELECT * FROM `Periodo` WHERE `fecha_final` >= CURDATE()$$

CREATE DEFINER=`casacult`@`localhost` PROCEDURE `obtener_profesor` (IN `id_matricula` INT)  NO SQL
    COMMENT 'Utilizado para generar informe de matrícula'
SELECT Usuario.nombre, Usuario.primer_apellido, Usuario.segundo_apellido
FROM Usuario
  Inner join Profesor on Usuario.cedula = Profesor.cedula_profesor
  INNER JOIN Curso_X_Periodo ON Curso_X_Periodo.idProfesorAsignado = Profesor.idProfesor
  INNER JOIN Matricula ON Matricula.id_Curso_X_Periodo = Curso_X_Periodo.id
WHERE Matricula.id = id_matricula$$

CREATE DEFINER=`casacult`@`localhost` PROCEDURE `obtener_profesor_x_cedula` (IN `cedula_in` INT(13))  NO SQL
BEGIN

	SELECT Usuario.nombre, Usuario.primer_apellido, Usuario.segundo_apellido, 
    Usuario.telefono, Usuario.telefono2, Usuario.correo, Usuario.fecha_nacimiento,provincia, 
    canton, distrito, sennas, Facturacion.nombre as 'fnombre', identificacion, 
    razon_social, estado_tributario, nombre_actividad, 
    codigo_actividad, Profesor.idProfesor
    FROM Usuario
    INNER JOIN Profesor ON Profesor.cedula_profesor = Usuario.cedula
    LEFT JOIN Direccion ON Direccion.id_profesor = Profesor.idProfesor
    LEFT JOIN Facturacion ON Facturacion.id_profesor = Profesor.idProfesor
    WHERE Usuario.cedula = cedula_in ;
END$$

CREATE DEFINER=`casacult`@`localhost` PROCEDURE `obtener_tipo_usuario` (IN `cedula` INT)  NO SQL
SELECT `tipoAdministrador`, `estado` FROM `Administrador` WHERE `cedula_admin` = cedula$$

CREATE DEFINER=`casacult`@`localhost` PROCEDURE `obtener_todos_correos_usuarios` ()  NO SQL
BEGIN
	SELECT DISTINCT Usuario.nombre, Usuario.primer_apellido, Usuario.segundo_apellido, Usuario.correo
    FROM Usuario
    WHERE Usuario.nombre <>'' AND Usuario.primer_apellido <>''
    AND Usuario.segundo_apellido <>'' AND Usuario.correo <>'';
END$$

CREATE DEFINER=`casacult`@`localhost` PROCEDURE `obtener_todos_cursos_x_periodo` (IN `idPeriodo_in` INT(11))  NO SQL
SELECT Curso.idCurso, Curso.nombre, Curso.horario, CONCAT(Usuario.nombre," ", Usuario.primer_apellido, " ", Usuario.segundo_apellido) AS nombreProfesor, Curso.cupo,  Curso_X_Periodo.id AS idCXP, Curso_X_Periodo.estado, Curso_X_Periodo.observaciones, Curso_X_Periodo.idPeriodo, CONCAT((SELECT COUNT(*) from Matricula where Matricula.id_Curso_X_Periodo = Curso_X_Periodo.id), "/", Curso.cupo) as total

from Curso_X_Periodo

INNER JOIN Curso ON Curso.idCurso = Curso_X_Periodo.idCurso
INNER JOIN Profesor ON Profesor.idProfesor = Curso_X_Periodo.idProfesorAsignado
INNER JOIN Usuario ON Usuario.cedula = Profesor.cedula_profesor

WHERE Curso_X_Periodo.idPeriodo = idPeriodo_in$$

CREATE DEFINER=`casacult`@`localhost` PROCEDURE `obtener_usuario` (IN `pUsuario` INT(45), IN `pPassword` INT(45))  BEGIN   
	select * from Usuario where
            cedula = pUsuario and pin = pPassword;
END$$

CREATE DEFINER=`casacult`@`localhost` PROCEDURE `obtener_usuariosMat` (IN `identificador` INT(11))  NO SQL
SELECT `Usuario`.`nombre`, `Usuario`.`primer_apellido`, `Usuario`.`cedula`, `Curso`.`nombre`, `Matricula`.`id`, `Matricula`.`numero_comprobante`, `Matricula`.`comprobante`  FROM `Usuario`, `Matricula`, `Curso`, `Curso_X_Periodo` WHERE `Usuario`.`cedula` = `Matricula`.`cedula_estudiante` AND `Curso`.`idCurso` = `Curso_X_Periodo`.`idCurso` AND `Matricula`.`id_Curso_X_Periodo` = `Curso_X_Periodo`.`id` AND `Matricula`.`estado` IS NULL AND `Matricula`.`id` = identificador$$

CREATE DEFINER=`casacult`@`localhost` PROCEDURE `obtener_usuariosMatricula` ()  NO SQL
SELECT `Usuario`.`nombre`, `Usuario`.`primer_apellido`, `Usuario`.`cedula`, `Curso`.`nombre`, `Matricula`.`id`, `Matricula`.`numero_comprobante` FROM `Usuario`, `Matricula`, `Curso`, `Curso_X_Periodo` WHERE `Usuario`.`cedula` = `Matricula`.`cedula_estudiante` AND `Curso`.`idCurso` = `Curso_X_Periodo`.`idCurso` AND `Matricula`.`id_Curso_X_Periodo` = `Curso_X_Periodo`.`id` AND `Matricula`.`estado` IS NULL$$

CREATE DEFINER=`casacult`@`localhost` PROCEDURE `recuperar_contra` (IN `pcorreo` VARCHAR(40))  NO SQL
SELECT `cedula`, `pin`, `nombre`, `primer_apellido` FROM `Usuario` WHERE `correo` = pcorreo$$

CREATE DEFINER=`casacult`@`localhost` PROCEDURE `registrar_administrador` (IN `cedula_in` INT(10), IN `nombre_in` VARCHAR(40), IN `primer_apellido_in` VARCHAR(40), IN `segundo_apellido_in` VARCHAR(40), IN `tipo_identificacion_in` VARCHAR(20), IN `telefono_in` VARCHAR(10), IN `telefono2_in` VARCHAR(10), IN `correo_in` VARCHAR(25), IN `fecha_in` DATE, IN `clave_in` SMALLINT(5), IN `tipo_admin_in` VARCHAR(40))  NO SQL
    COMMENT 'Proceso almacenado para registrar administrador'
BEGIN

DECLARE Cedula INT(8);

SET Cedula = 0;

SELECT Usuario.cedula INTO Cedula
FROM Usuario WHERE cedula_in = Usuario.cedula;

IF Cedula = 0 THEN

INSERT INTO Usuario
VALUES(cedula_in,nombre_in,primer_apellido_in,
       segundo_apellido_in,tipo_identificacion_in,
       telefono_in,telefono2_in,correo_in,fecha_in,clave_in);
       
END IF;

UPDATE Usuario
    
    SET nombre = nombre_in,
		primer_apellido = primer_apellido_in,
		segundo_apellido = segundo_apellido_in,
        telefono = telefono_in,
        telefono2 = telefono2_in,
        correo = correo_in

    WHERE cedula_in = Usuario.cedula;
    
INSERT INTO Administrador
VALUES (NULL, cedula_in, tipo_admin_in, "activo");

END$$

CREATE DEFINER=`casacult`@`localhost` PROCEDURE `registrar_curso` (IN `in_nombre` VARCHAR(45), IN `in_cupo` INT(11), IN `in_horario` VARCHAR(45), IN `in_informacion` TEXT)  NO SQL
    COMMENT 'Procedimiento para agregar un curso'
INSERT INTO Curso(nombre, cupo, horario, informacion)
VALUES (in_nombre, in_cupo, in_horario, in_informacion)$$

CREATE DEFINER=`casacult`@`localhost` PROCEDURE `registrar_curso_X_Periodo` (IN `idCurso_in` INT, IN `idPeriodo_in` INT, IN `idProfesor_in` INT)  NO SQL
INSERT INTO Curso_X_Periodo (idCurso, idPeriodo, idProfesorAsignado)
VALUES (idCurso_in,idPeriodo_in,idProfesor_in)$$

CREATE DEFINER=`casacult`@`localhost` PROCEDURE `registrar_periodo` (IN `in_nombre` VARCHAR(40), IN `in_fecha_inicio` DATE, IN `in_fecha_final` DATE)  NO SQL
INSERT INTO Periodo (nombre,fecha_inicio,fecha_final)
VALUES (in_nombre, in_fecha_inicio, in_fecha_final)$$

CREATE DEFINER=`casacult`@`localhost` PROCEDURE `registrar_profesor` (IN `cedula_in` INT(10) UNSIGNED, IN `nombre_in` VARCHAR(45), IN `primer_apellido_in` VARCHAR(45), IN `segundo_apellido_in` VARCHAR(45), IN `telefono_in` VARCHAR(45), IN `telefono_2_in` VARCHAR(45), IN `correo_in` VARCHAR(45), IN `fecha_in` DATE, IN `pin_in` SMALLINT(6), IN `provincia_in` VARCHAR(45), IN `canton_in` VARCHAR(45), IN `distrito_in` VARCHAR(45), IN `sennas_in` VARCHAR(240), IN `identificacion_in` VARCHAR(12), IN `nombre_completo_in` VARCHAR(65), IN `razon_social_in` VARCHAR(45), IN `estado_tributario_in` TINYINT(1), IN `nombre_actividad_in` VARCHAR(45), IN `codigo_actividad_in` VARCHAR(45), IN `tipo_identificacion_in` VARCHAR(45))  BEGIN
INSERT INTO Usuario (cedula, nombre, primer_apellido, segundo_apellido, telefono,telefono2,correo,fecha_nacimiento,pin,tipo_identificacion)
VALUES(cedula_in,nombre_in,primer_apellido_in,segundo_apellido_in,telefono_in,telefono_2_in,correo_in,fecha_in,pin_in,tipo_identificacion_in);
       
INSERT INTO Profesor (cedula_profesor) VALUES (cedula_in);
SELECT @ULTIMO_ID := LAST_INSERT_ID();
INSERT INTO Direccion (id_profesor, provincia, canton, distrito, sennas) VALUES (@ULTIMO_ID, provincia_in, canton_in, distrito_in, sennas_in);
INSERT INTO Facturacion (id_profesor, nombre, identificacion, razon_social, estado_tributario, nombre_actividad, codigo_actividad) VALUES (@ULTIMO_ID, nombre_completo_in, identificacion_in, razon_social_in, estado_tributario_in, nombre_actividad_in, codigo_actividad_in);

END$$

CREATE DEFINER=`casacult`@`localhost` PROCEDURE `registrar_usuario` (IN `cedula_in` INT(10), IN `nombre_in` VARCHAR(70), IN `primer_apellido_in` VARCHAR(70), IN `segundo_apellido_in` VARCHAR(70), IN `tipo_identificacion_in` VARCHAR(20), IN `telefono_in` VARCHAR(15), IN `telefono2_in` VARCHAR(40), IN `correo_in` VARCHAR(50), IN `fecha_in` DATE, IN `clave_in` SMALLINT(5))  NO SQL
    COMMENT 'Procedimiento para agregar un usuario común'
INSERT INTO Usuario
VALUES(cedula_in,nombre_in,primer_apellido_in,
       segundo_apellido_in,tipo_identificacion_in,
       telefono_in,telefono2_in,correo_in,fecha_in,clave_in)$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `Administrador`
--

CREATE TABLE `Administrador` (
  `idAdministrador` int(11) NOT NULL,
  `cedula_admin` int(11) DEFAULT NULL,
  `tipoAdministrador` varchar(40) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Super, Editor, Gestor',
  `estado` varchar(20) COLLATE utf8_unicode_ci NOT NULL COMMENT 'activo/inactivo'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `Administrador`
--

INSERT INTO `Administrador` (`idAdministrador`, `cedula_admin`, `tipoAdministrador`, `estado`) VALUES
(33, 205270338, 'Super', 'activo'),
(34, 402010226, 'Editor', 'activo'),
(35, 114630181, 'Gestor', 'activo'),
(36, 115870378, 'Editor', 'activo'),
(37, 402410617, 'Gestor', 'activo'),
(38, 116720693, 'Gerstor', 'activo'),
(39, 117750791, 'Gestor', 'activo'),
(40, 116980794, 'Gestor', 'activo'),
(41, 116510025, 'Gestor', 'activo'),
(42, 117180272, 'Gestor', 'activo'),
(43, 116990897, 'Gestor', 'activo'),
(44, 2147483647, 'Gestor', 'activo'),
(45, 116330081, 'Editor', 'activo'),
(46, 115720812, 'Gestor', 'activo'),
(47, 114280346, 'Gestor', 'activo'),
(48, 117160186, 'Gestor', 'activo'),
(49, 113500431, 'Gestor', 'activo'),
(50, 2147483647, 'Gestor', 'inactivo'),
(51, 117300136, 'Gestor', 'activo'),
(52, 901100802, 'Gestor', 'activo'),
(53, 401770967, 'Gestor', 'activo'),
(54, 702420427, 'Gestor', 'activo'),
(55, 114650489, 'Gestor', 'activo'),
(56, 305050180, 'Gestor', 'activo'),
(57, 117200790, 'Gestor', 'activo'),
(58, 115210215, 'Gestor', 'activo'),
(59, 116360234, 'Gestor', 'activo'),
(60, 116360234, 'Gestor', 'inactivo'),
(61, 304790416, 'Gestor', 'activo'),
(62, 116640632, 'Gestor', 'activo'),
(63, 117300010, 'Gestor', 'activo'),
(64, 115780015, 'Gestor', 'activo');

-- --------------------------------------------------------

--
-- Table structure for table `Comprobante`
--

CREATE TABLE `Comprobante` (
  `id` int(40) NOT NULL COMMENT 'Número que se despliega en comprobante',
  `id_matricula` int(40) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `Curso`
--

CREATE TABLE `Curso` (
  `idCurso` int(11) NOT NULL,
  `nombre` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  `cupo` int(11) NOT NULL,
  `horario` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `informacion` text COLLATE utf8_unicode_ci
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `Curso`
--

INSERT INTO `Curso` (`idCurso`, `nombre`, `cupo`, `horario`, `informacion`) VALUES
(21, 'Taller de canto ', 7, 'Martes 15:00 - 17:00 ', ''),
(22, 'Taller de canto ', 20, 'Martes 17:00 - 19:00 ', ''),
(23, 'Taller de guitarra avanzado', 19, 'Sábado 11:00 - 13:00 ', ''),
(24, 'Taller de guitarra básico', 19, 'Sábado 13.00 - 15.00 ', ''),
(25, 'Taller de canto ', 20, 'Sábado 15:00 - 17:00 ', ''),
(26, 'Taller de guitarra intermedio', 18, 'Sábado 15:00 - 17:00 ', ''),
(27, 'Encuadernación artística ', 18, 'Miércoles 12:00 - 14:00 ', ''),
(28, 'Acuarela', 18, 'Miércoles 14:00 - 16:00 ', ''),
(29, 'Pintura y dibujo', 16, 'jueves 12:00 - 14:00 ', ''),
(30, 'Dibujo de retratos ', 20, 'jueves 14:00 - 16:00 ', ''),
(31, 'Dibujo básico ', 17, 'Jueves 16:00 - 18:00', ''),
(32, 'Fotografía digital ', 13, 'Jueves 18:00 - 20:00 ', ''),
(33, 'Cine de anime japonés ', 19, 'sábado 10:00 - 12:00 ', ''),
(34, 'Fotografía con tu celular', 19, 'Sábado 8:00 - 10:00', ''),
(35, 'Restauración y tratamiento de muebles', 18, 'Lunes 9:00 - 11:00 ', ''),
(36, 'Labrado y repujado en cuero', 16, 'Lunes 10:00 - 12:00', ''),
(37, 'Grabado en vidrio ', 19, 'Lunes 11:00 - 13:00', ''),
(38, 'Labrado y repujado en cuero', 20, 'Lunes 13.00 - 15:00 ', ''),
(39, 'Pirograbado ', 20, 'Lunes 13:00 - 15:00 ', ''),
(40, 'Vitrales y mosaicos básico ', 17, 'Martes 13:00 - 15:00', ''),
(41, 'Creación de bufandas y prendas en telar', 20, 'Martes 13:00 - 15:00', ''),
(42, 'Vitrales y mosaicos intermedio y avanzado', 19, 'Martes 15:00 - 17:00 ', ''),
(43, 'Elaboración de atrapasueños y mandalas ', 20, 'Jueves 09:00 - 11:00', ''),
(44, 'Creación de bufandas y prendas en telar', 20, 'Jueves 13:00 - 15:00', ''),
(45, 'Mosaicos con vidrio', 19, 'Sábado 8:30 - 10:30', ''),
(46, 'Bisutería técnicas innovadoras', 13, 'Sábado 10:30 - 12:30 ', ''),
(47, 'Introducción a las plantas medicinales', 18, 'Jueves 09:00 - 11:00', ''),
(48, 'Hathayoga Relajación y respiración ', 20, 'Miércoles 9:30 - 11:30', ''),
(49, 'Aromaterapia ', 19, 'Sábado 8:30 - 10:30', ''),
(50, 'Computación para adultos mayores', 17, 'Viernes 17:30 - 19:30', ''),
(51, 'Teatro de improvisación ', 15, 'sábado 10:00 - 12:00 ', ''),
(52, 'Danza del vientre', 19, 'Viernes 17:00 - 19:00', ''),
(53, 'Teatro de improvisación ', 20, 'Viernes 19:00 - 21:00', ''),
(54, 'Danza del vientre', 19, 'Sábado 13:00 - 15:00', ''),
(55, 'Danza del vientre', 20, 'Sábado 15:00 - 17:00 ', ''),
(56, 'LESCO I', 19, 'Lunes 17:00 - 21:00', ''),
(57, 'Fundamentos de administración para emprendedo', 20, 'Lunes 18:00 - 20:00', ''),
(58, 'Inglés para adultos mayores II', 19, 'Martes 12:30 - 14:30', ''),
(59, 'Inglés para adultos mayores I', 19, 'Miércoles 9:00 - 11:00', ''),
(61, 'Agricultura Urbana orgánica ', 20, 'Viernes 9:00 - 11:00', ''),
(62, 'Marketing para PYMES y microPYMES', 20, 'Miércoles 18:00 - 20:00 ', ''),
(63, 'Inglés para adultos mayores III', 20, 'Viernes 9:00 - 11:00', ''),
(64, 'LESCO I', 20, 'sábado 08:00 - 12:00 ', ''),
(65, 'Taller básico de producción audiovisual ', 17, 'Martes 18:00 - 20:00 ', ''),
(66, 'Taller intermedio de producción audiovisual ', 20, 'Jueves 18:00 - 20:00 ', ''),
(67, ' LESCO II', 20, 'Sábado 13:00 - 16:30', ''),
(68, 'LESCO III', 19, 'Sábado 8.00 - 12:00 ', ''),
(69, 'LESCO VI ', 20, 'Sábado  8:00 - 12:00', '');

-- --------------------------------------------------------

--
-- Table structure for table `Curso_X_Periodo`
--

CREATE TABLE `Curso_X_Periodo` (
  `id` int(40) NOT NULL,
  `idCurso` int(40) NOT NULL,
  `idPeriodo` int(40) NOT NULL,
  `idProfesorAsignado` int(40) NOT NULL,
  `estado` varchar(25) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'disponible',
  `observaciones` varchar(300) COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `Curso_X_Periodo`
--

INSERT INTO `Curso_X_Periodo` (`id`, `idCurso`, `idPeriodo`, `idProfesorAsignado`, `estado`, `observaciones`) VALUES
(1, 21, 1, 38, 'disponible', ''),
(2, 22, 1, 38, 'disponible', ''),
(3, 23, 1, 49, 'disponible', ''),
(4, 24, 1, 49, 'disponible', ''),
(5, 25, 1, 38, 'disponible', ''),
(6, 26, 1, 49, 'disponible', ''),
(7, 27, 1, 40, 'disponible', ''),
(8, 28, 1, 40, 'disponible', ''),
(9, 29, 1, 46, 'disponible', ''),
(10, 30, 1, 46, 'disponible', ''),
(11, 31, 1, 46, 'disponible', ''),
(12, 32, 1, 50, 'disponible', ''),
(13, 33, 1, 44, 'disponible', ''),
(14, 34, 1, 44, 'disponible', ''),
(15, 35, 1, 45, 'disponible', ''),
(16, 36, 1, 41, 'disponible', ''),
(17, 37, 1, 45, 'disponible', ''),
(18, 38, 1, 41, 'disponible', ''),
(19, 39, 1, 45, 'disponible', ''),
(20, 40, 1, 48, 'disponible', ''),
(21, 41, 1, 59, 'disponible', ''),
(22, 42, 1, 48, 'disponible', ''),
(23, 43, 1, 57, 'disponible', ''),
(24, 44, 1, 59, 'disponible', ''),
(25, 45, 1, 48, 'disponible', ''),
(26, 46, 1, 52, 'disponible', ''),
(27, 47, 1, 55, 'disponible', ''),
(28, 48, 1, 43, 'disponible', ''),
(29, 49, 1, 58, 'disponible', ''),
(30, 50, 1, 44, 'disponible', ''),
(31, 51, 1, 59, 'disponible', ''),
(32, 52, 1, 42, 'disponible', ''),
(33, 53, 1, 0, 'disponible', ''),
(34, 54, 1, 42, 'disponible', ''),
(35, 55, 1, 47, 'disponible', ''),
(36, 56, 1, 54, 'disponible', ''),
(37, 57, 1, 53, 'disponible', ''),
(38, 58, 1, 56, 'disponible', ''),
(39, 59, 1, 56, 'disponible', ''),
(40, 61, 1, 55, 'disponible', ''),
(41, 62, 1, 53, 'disponible', ''),
(42, 63, 1, 56, 'disponible', ''),
(43, 64, 1, 54, 'disponible', ''),
(44, 65, 1, 51, 'disponible', ''),
(45, 66, 1, 51, 'disponible', ''),
(46, 67, 1, 54, 'disponible', ''),
(47, 68, 1, 54, 'disponible', ''),
(48, 69, 1, 54, 'disponible', '');

-- --------------------------------------------------------

--
-- Table structure for table `Direccion`
--

CREATE TABLE `Direccion` (
  `iddireccion` int(11) NOT NULL,
  `provincia` varchar(45) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `canton` varchar(45) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `distrito` varchar(45) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `sennas` varchar(240) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `id_profesor` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `Direccion`
--

INSERT INTO `Direccion` (`iddireccion`, `provincia`, `canton`, `distrito`, `sennas`, `id_profesor`) VALUES
(19, 'San José', 'San José', 'Carmen', '', 38),
(21, 'San José', 'San José', 'Carmen', '', 40),
(22, 'San José', 'San José', 'Carmen', '', 41),
(23, 'San José', 'San José', 'Carmen', '', 42),
(24, 'San José', 'San José', 'Carmen', '', 43),
(25, 'San José', 'San José', 'Carmen', '', 44),
(26, 'San José', 'San José', 'Carmen', '', 45),
(27, 'San José', 'San José', 'Carmen', '', 46),
(28, 'San José', 'San José', 'Carmen', '', 47),
(29, 'San José', 'San José', 'Carmen', '', 48),
(30, 'San José', 'San José', 'Carmen', '', 49),
(31, 'San José', 'San José', 'Carmen', '', 50),
(32, 'San José', 'San José', 'Carmen', '', 51),
(33, 'San José', 'San José', 'Carmen', '', 52),
(34, 'San José', 'San José', 'Carmen', '', 53),
(35, 'San José', 'San José', 'Carmen', '', 54),
(36, 'San José', 'San José', 'Carmen', '', 55),
(37, 'San José', 'San José', 'Carmen', '', 56),
(38, 'San José', 'San José', 'Carmen', '', 57),
(39, 'San José', 'San José', 'Carmen', '', 58),
(40, 'San José', 'San José', 'Carmen', '', 59);

-- --------------------------------------------------------

--
-- Table structure for table `Facturacion`
--

CREATE TABLE `Facturacion` (
  `idFacturacion` int(11) NOT NULL,
  `nombre` varchar(45) COLLATE utf8_bin DEFAULT NULL,
  `identificacion` varchar(45) COLLATE utf8_bin DEFAULT NULL,
  `razon_social` varchar(45) COLLATE utf8_bin DEFAULT NULL,
  `estado_tributario` tinyint(4) DEFAULT NULL,
  `nombre_actividad` varchar(45) COLLATE utf8_bin DEFAULT NULL,
  `codigo_actividad` varchar(45) COLLATE utf8_bin DEFAULT NULL,
  `id_profesor` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- Dumping data for table `Facturacion`
--

INSERT INTO `Facturacion` (`idFacturacion`, `nombre`, `identificacion`, `razon_social`, `estado_tributario`, `nombre_actividad`, `codigo_actividad`, `id_profesor`) VALUES
(18, 'Elena  Castillo  Ulate', '112660249', '', 0, '', '', 38),
(20, 'Francella  Artavia  Hernández', '206860437', '', 1, '', '', 40),
(21, 'Alejandra  Araya  Céspedes', '302520976', '', 1, '', '', 41),
(22, 'Cleo Jane  Solano  Rodríguez', '109210797', '', 1, '', '', 42),
(23, 'María Eugenia  Chaves Pochet', '104130484', '', 1, '', '', 43),
(24, 'José Gabriel  Masís  Morales', '303890230', '', 1, '', '', 44),
(25, 'Guisela       Morice  Haeberle ', '302180863', '', 1, '', '', 45),
(26, 'Greivin  Ureña  Ramírez ', '111160232', '', 1, '', '', 46),
(27, 'Alyssa Catalina  Arce  Matamoros ', '114340210', '', 1, '', '', 47),
(28, 'José Francisco  Soto  Ballestero ', '202010058', '', 1, '', '', 48),
(29, 'Felipe  Vega  Cordero ', '114360252', '', 1, '', '', 49),
(30, 'Ruth  Garita  Flores ', '112340408', '', 1, '', '', 50),
(31, 'Petronio  Marcenaro  Romero', '800790644 ', '', 1, '', '', 51),
(32, 'Amanda  Álvarez  Cordero  ', '123030904', '', 1, '', '', 52),
(33, 'Adriana  Rodríguez  Cisneros', '110350902', '', 1, '', '', 53),
(34, 'Centro  Especializado  de LESCO S.A', '3101662969', '', 1, '', '', 54),
(35, 'Silvia  Astorga  Monestel', '112640915', '', 1, '', '', 55),
(36, 'Leonardo  Gómez  Guzmán', ' 303230426', '', 1, '', '', 56),
(37, 'Johanna  Ríos  Madrigal', '111090052', '', 1, '', '', 57),
(38, 'Nathalie  Castro  Montero', '701680514', '', 1, '', '', 58),
(39, 'Carlos  Cordero  Calvo', '111111111', '', 1, '', '', 59);

-- --------------------------------------------------------

--
-- Table structure for table `Matricula`
--

CREATE TABLE `Matricula` (
  `id` int(11) NOT NULL,
  `estado` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `cedula_estudiante` int(11) NOT NULL,
  `id_Curso_X_Periodo` int(11) NOT NULL,
  `numero_comprobante` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `comprobante` varchar(400) COLLATE utf8_unicode_ci NOT NULL,
  `comentario` varchar(1000) COLLATE utf8_unicode_ci NOT NULL,
  `numero_factura_electronica` int(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `Matricula`
--

INSERT INTO `Matricula` (`id`, `estado`, `cedula_estudiante`, `id_Curso_X_Periodo`, `numero_comprobante`, `comprobante`, `comentario`, `numero_factura_electronica`) VALUES
(1, NULL, 105360348, 26, 'TT1918944679', 'comprobantes/1563208372 = 2019-07-15 11:32:52CCAmon Bisuteria Agosto 2019 SFS.pdf', '', 0),
(2, NULL, 112420803, 26, 'SINPE 10100487', 'comprobantes/1563212213 = 2019-07-15 12:36:53Bisuteria III B 2019 Alejandra Anchía.pdf', '', 0),
(3, NULL, 112990412, 13, 'FT/19194/CBMNV', 'comprobantes/1563215132 = 2019-07-15 13:25:32cineanime III B 2019 Jinnette Solano.png', '', 0),
(4, NULL, 115870378, 14, 'Asistente ', 'comprobantes/1563288224 = 2019-07-16 09:43:44Manual Cursos II P 2019.png', '', 0),
(5, NULL, 115040702, 12, '2019071615122400547445708', 'comprobantes/1563461218 = 2019-07-18 09:46:58comprobanteadrián.png', '', 0),
(6, NULL, 207560446, 12, 'Descongela', 'comprobantes/1563463020 = 2019-07-18 10:17:00Comprobanteroy.pdf', '', 0),
(7, NULL, 400720925, 7, 'TT1919713835', 'comprobantes/1563471772 = 2019-07-18 12:42:52comprobantesrosariomayela.jpg', '', 0),
(8, NULL, 400720925, 16, 'TT1919713835', 'comprobantes/1563471905 = 2019-07-18 12:45:05comprobantesrosariomayela.jpg', '', 0),
(9, NULL, 401380038, 1, 'TT1919770812', 'comprobantes/1563472411 = 2019-07-18 12:53:31comprobantesrosariomayela.jpg', '', 0),
(10, NULL, 401380038, 7, 'TT1919770812', 'comprobantes/1563472613 = 2019-07-18 12:56:53comprobantesrosariomayela.jpg', '', 0),
(11, NULL, 401380038, 18, 'TT1919770812', 'comprobantes/1563472693 = 2019-07-18 12:58:13comprobantesrosariomayela.jpg', '', 0),
(12, NULL, 111320092, 20, 'TT19199023003229', 'comprobantes/1563474904 = 2019-07-18 13:35:04comprobanteandrea.pdf', '', 0),
(13, NULL, 1804300, 16, 'TT1919920697', 'comprobantes/1563485768 = 2019-07-18 16:36:08comprobantesteban.jpg', '', 0),
(14, NULL, 304380215, 20, 'TT19199383461550', 'comprobantes/1563558603 = 2019-07-19 12:50:03VALERIA.jpg', '', 0),
(15, NULL, 119730089, 44, 'tt19203389722722', 'comprobantes/1563817322 = 2019-07-22 12:42:02WhatsApp Image 2019-07-22 at 11.39.19 AM.jpeg', '', 0),
(16, NULL, 119730089, 44, 'tt19203389722722', 'comprobantes/1563818077 = 2019-07-22 12:54:37WhatsApp Image 2019-07-22 at 11.39.19 AM.jpeg', '', 0),
(17, NULL, 2, 12, 'descongelado', 'comprobantes/1563831518 = 2019-07-22 16:38:38Comprobante (1).pdf', '', 0),
(18, NULL, 105670472, 30, 'descongela ', 'comprobantes/1563915122 = 2019-07-23 15:52:021.pdf', '', 0),
(19, NULL, 105670472, 30, 'descongela ', 'comprobantes/1563915123 = 2019-07-23 15:52:031.pdf', '', 0),
(20, NULL, 116320392, 31, 'TT1919891771', 'comprobantes/1563980132 = 2019-07-24 09:55:3220190719_190014.jpg', '', 0),
(21, NULL, 116320392, 34, 'TT1919891771', 'comprobantes/1563980302 = 2019-07-24 09:58:2220190719_190014.jpg', '', 0),
(22, NULL, 112730670, 12, 'FT/19203/KXH9K', 'comprobantes/1563983645 = 2019-07-24 10:54:05image001 (1).jpg', '', 0),
(23, NULL, 206780527, 26, '43008735', 'comprobantes/1563984762 = 2019-07-24 11:12:42BNCR20190724.pdf', '', 0),
(24, NULL, 1040054003, 36, 'tt19198323794285', 'comprobantes/1564000339 = 2019-07-24 15:32:19aaaaaaa.jpg', '', 0),
(25, NULL, 1040054003, 30, 'TT19128641092730', 'comprobantes/1564000601 = 2019-07-24 15:36:41AYUDA DIOS.jpg', '', 0),
(26, NULL, 11256, 26, 'TT19200727493749', 'comprobantes/1564151714 = 2019-07-26 09:35:14CBISUTERIA.jpg', '', 0),
(27, NULL, 20379, 26, 'TT19200610003749', 'comprobantes/1564152207 = 2019-07-26 09:43:27bisuteria.jpg', '', 0),
(28, NULL, 116110902, 31, '950501226', 'comprobantes/1564153066 = 2019-07-26 09:57:46Banca en Línea.pdf', '', 0),
(29, NULL, 110300211, 8, '13173311', 'comprobantes/1564153280 = 2019-07-26 10:01:20Comprobante636997261903102376.pdf', '', 0),
(30, NULL, 801130631, 6, 'TT1920502198377', 'comprobantes/1564159803 = 2019-07-26 11:50:03PAGO TALLER.pdf', '', 0),
(31, NULL, 2147483647, 27, 'TT1920502198377', 'comprobantes/1564159900 = 2019-07-26 11:51:40PAGO TALLER.pdf', '', 0),
(32, NULL, 11404, 15, 'TT19207041621851', 'comprobantes/1564160815 = 2019-07-26 12:06:55comprobante.jpg', '', 0),
(33, NULL, 116620082, 11, 'TT1920764926', 'comprobantes/1564174584 = 2019-07-26 15:56:24cesar calero.pdf', '', 0),
(34, NULL, 574861239, 1, '548745123', 'comprobantes/1564244924 = 2019-07-27 11:28:44cesar calero.pdf', '', 0),
(35, NULL, 117990081, 47, 'TT1920354322', 'comprobantes/1564245449 = 2019-07-27 11:37:29Scan10001.pdf', '', 0),
(36, NULL, 603120315, 34, '950485006 ', 'comprobantes/1564247038 = 2019-07-27 12:03:58captura 2.JPG', '', 0),
(37, NULL, 112560038, 26, 'tt1920072749', 'comprobantes/1564256447 = 2019-07-27 14:40:4720190719_142804 (1).jpg', '', 0),
(38, NULL, 203790174, 26, 'tt19200610', 'comprobantes/1564256991 = 2019-07-27 14:49:5120190719_142810.jpg', '', 0),
(39, NULL, 603120315, 1, '950485006 ', 'comprobantes/1564258429 = 2019-07-27 15:13:49Captura.JPG', '', 0),
(40, NULL, 117230455, 1, 'tt1920408035', 'comprobantes/1564260876 = 2019-07-27 15:54:36image1 (2).jpeg', '', 0),
(41, NULL, 302730207, 10, 'tt1920723470', 'comprobantes/1564261699 = 2019-07-27 16:08:19IMG_20190726_141146.jpg', '', 0),
(42, NULL, 702760148, 9, 'tt1920761380', 'comprobantes/1564263610 = 2019-07-27 16:40:10Deposoto - Tayra Gomez (1).jpg', '', 0),
(43, NULL, 602790901, 44, 'tt1920553058', 'comprobantes/1564264173 = 2019-07-27 16:49:33IMG-4104.JPG', '', 0),
(44, NULL, 114590187, 48, 'tt1920750977', 'comprobantes/1564265287 = 2019-07-27 17:08:07IMG_20190726_151519.jpg', '', 0),
(45, NULL, 701920052, 31, '13410090', 'comprobantes/1564410320 = 2019-07-29 09:25:20comprobante TC.JPG', '', 0),
(46, NULL, 304380215, 25, 'TT1919938346', 'comprobantes/1564411612 = 2019-07-29 09:46:52Comprobante mosaico.jpg', '', 0),
(47, NULL, 702390296, 11, 'TT1920560806', 'comprobantes/1564412755 = 2019-07-29 10:05:55comprobante dibujo b.jpg', '', 0),
(48, NULL, 116110902, 31, '950501226', 'comprobantes/1564414189 = 2019-07-29 10:29:49comprobante teatro.JPG', '', 0),
(49, NULL, 110300211, 8, '13173311', 'comprobantes/1564414739 = 2019-07-29 10:38:59Comprobante monica.JPG', '', 0),
(50, NULL, 601500292, 16, 'TT1920796002', 'comprobantes/1564415285 = 2019-07-29 10:48:05Comprobante labrado y repujado cuero.jpg', '', 0),
(51, NULL, 801130631, 6, 'TT1920502198', 'comprobantes/1564415980 = 2019-07-29 10:59:40Pago taller.JPG', '', 0),
(52, NULL, 155808770, 27, 'TT1920502198', 'comprobantes/1564416482 = 2019-07-29 11:08:02Pago taller.JPG', '', 0),
(53, NULL, 114040173, 15, 'TT1920704162', 'comprobantes/1564416835 = 2019-07-29 11:13:55Comprobante restauración muebles.jpg', '', 0),
(54, NULL, 107540971, 1, 'TT1919611763', 'comprobantes/1564497913 = 2019-07-30 09:45:13Rocio Cubero Valerio.jpg', '', 0),
(55, NULL, 103991449, 39, 'tt1921046057', 'comprobantes/1564503932 = 2019-07-30 11:25:32Scan10002.pdf', '', 0),
(56, NULL, 114520288, 12, '950465170', 'comprobantes/1564506403 = 2019-07-30 12:06:43Scan10003.pdf', '', 0),
(57, NULL, 302120293, 12, 'tt1920531261', 'comprobantes/1564506927 = 2019-07-30 12:15:27escaneado.pdf', '', 0),
(58, NULL, 602070407, 26, 'TT1920094791', 'comprobantes/1564507602 = 2019-07-30 12:26:42FAC Aurora Baltodano.jpg', '', 0),
(59, NULL, 111320092, 20, 'tt1919902300', 'comprobantes/1564509361 = 2019-07-30 12:56:01reb.pdf', '', 0),
(60, NULL, 116620082, 11, 'tt1920764926', 'comprobantes/1564510189 = 2019-07-30 13:09:49fac2.JPG', '', 0),
(61, NULL, 105770032, 17, '13457026', 'comprobantes/1564511124 = 2019-07-30 13:25:241.pdf', '', 0),
(62, NULL, 107640605, 29, '950402992', 'comprobantes/1564513173 = 2019-07-30 13:59:33liz.JPG', '', 0),
(63, NULL, 115040702, 12, '2019071615122400547445708', 'comprobantes/1564513759 = 2019-07-30 14:09:19adrian.png', '', 0),
(64, NULL, 117330031, 31, '900446414', 'comprobantes/1564514277 = 2019-07-30 14:17:57Julian comprobante.pdf', '', 0),
(65, NULL, 117330031, 1, '900446414', 'comprobantes/1564514549 = 2019-07-30 14:22:29Julian comprobante.pdf', '', 0),
(66, NULL, 107540971, 9, 'tt19196117330821', 'comprobantes/1564515862 = 2019-07-30 14:44:22Rocio.jpg', '', 0),
(67, NULL, 700360859, 9, 'tt19207928663236', 'comprobantes/1564516489 = 2019-07-30 14:54:49eduardo.jpg', '', 0),
(68, NULL, 502980013, 3, 'TT1921070300', 'comprobantes/1564517715 = 2019-07-30 15:15:15RO COMPROBANTE.jpg', '', 0),
(69, NULL, 107410148, 26, '2019072681421010068108599', 'comprobantes/1564519729 = 2019-07-30 15:48:49jenny.pdf', '', 0),
(70, NULL, 120380981, 26, '2019072681421010068108599', 'comprobantes/1564519834 = 2019-07-30 15:50:34jenny.pdf', '', 0),
(71, NULL, 109630150, 44, 'tt1921083238', 'comprobantes/1564520650 = 2019-07-30 16:04:10silvia.jpg', '', 0),
(72, NULL, 106430729, 38, '2019073015231010122821022', 'comprobantes/1564526182 = 2019-07-30 17:36:22bernardita.png', '', 0),
(73, NULL, 106430729, 22, '2019073015231010122821022', 'comprobantes/1564526519 = 2019-07-30 17:41:59bernardita.png', '', 0),
(74, NULL, 106430729, 4, '2019073015231010122821022', 'comprobantes/1564526621 = 2019-07-30 17:43:41bernardita.png', '', 0),
(75, NULL, 114860891, 9, 'tt1921107034', 'comprobantes/1564531148 = 2019-07-30 18:59:08comproante ericka.jpeg', '', 0),
(76, NULL, 114860891, 9, 'tt1921107034', 'comprobantes/1564532000 = 2019-07-30 19:13:20comproante ericka.jpeg', '', 0);

-- --------------------------------------------------------

--
-- Table structure for table `Noticia`
--

CREATE TABLE `Noticia` (
  `idNoticia` int(11) NOT NULL,
  `titulo` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  `cuerpo` mediumtext COLLATE utf8_unicode_ci NOT NULL,
  `fecha` datetime NOT NULL,
  `id_administrador` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `Periodo`
--

CREATE TABLE `Periodo` (
  `idPeriodo` int(11) NOT NULL,
  `nombre` varchar(40) COLLATE utf8_unicode_ci DEFAULT NULL,
  `fecha_inicio` date NOT NULL,
  `fecha_final` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `Periodo`
--

INSERT INTO `Periodo` (`idPeriodo`, `nombre`, `fecha_inicio`, `fecha_final`) VALUES
(1, 'III Periodo 2019', '2019-08-05', '2019-09-28');

-- --------------------------------------------------------

--
-- Table structure for table `Profesor`
--

CREATE TABLE `Profesor` (
  `idProfesor` int(11) NOT NULL,
  `cedula_profesor` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `Profesor`
--

INSERT INTO `Profesor` (`idProfesor`, `cedula_profesor`) VALUES
(54, -1193304327),
(43, 104130484),
(42, 109210797),
(53, 110350902),
(57, 111090052),
(59, 111111111),
(46, 111160232),
(50, 112340408),
(55, 112640915),
(38, 112660249),
(47, 114340210),
(49, 114360252),
(52, 123030904),
(48, 202010058),
(40, 206860437),
(45, 302180863),
(41, 302520976),
(56, 303230426),
(44, 303890230),
(58, 701680514),
(51, 800790644);

-- --------------------------------------------------------

--
-- Table structure for table `Usuario`
--

CREATE TABLE `Usuario` (
  `cedula` int(11) NOT NULL,
  `nombre` varchar(70) COLLATE utf8_unicode_ci NOT NULL,
  `primer_apellido` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  `segundo_apellido` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  `tipo_identificacion` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  `telefono` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `telefono2` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  `correo` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `fecha_nacimiento` date NOT NULL,
  `pin` smallint(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `Usuario`
--

INSERT INTO `Usuario` (`cedula`, `nombre`, `primer_apellido`, `segundo_apellido`, `tipo_identificacion`, `telefono`, `telefono2`, `correo`, `fecha_nacimiento`, `pin`) VALUES
(-1193304327, 'Centro ', 'Especializado ', 'de LESCO S.A', 'DIMEX', '83080123', '', 'ccamon@gmail.com', '1990-07-23', 1990),
(2, 'Roy', 'Muñoz', 'Miranda', 'Cédula Indentidad', '84040976', '24442937', 'royamunoz@gmail.com', '1996-08-20', 1996),
(4177967, 'Luis Alberto', 'Bojorge', 'Murillo', 'Cédula Indentidad', '87231948', '83475015', 'bojorge3@yahoo.com', '1982-08-05', 1982),
(103991449, 'Sandra', 'Araya', 'Montero', 'Cédula Indentidad', '88332381', '22291743', 'sanroman29@yahoo.com', '1951-12-22', 1951),
(104130484, 'María Eugenia ', 'Chaves', 'Pochet', 'Cédula Identidad', '84664509', '', 'nenachp@gmail.com', '1949-01-12', 1949),
(105360348, 'Silvia', 'Fernández', 'Sáenz', 'Cédula Indentidad', '88338392', '', 'silviafersa@gmail.com', '1969-12-31', 1969),
(105670472, 'Rodolfo', 'Salazar', 'Aguilar', 'Cédula Indentidad', '83286781', '', 'rosagui2@gmail.com', '1961-11-03', 1961),
(105770032, 'Carlos Luis ', 'Cambronero ', 'Valverde', 'Cédula Indentidad', '89901904', '89901904', 'calucava@hotmail.com', '1955-12-30', 1955),
(106430729, 'Bernardita ', 'Sancho', 'Gómez', 'Cédula Indentidad', '83967302', '', 'bernasanchog@gmail.com', '1958-04-12', 1958),
(107410148, 'Jenny Georgina', 'Fallas', 'Ureña', 'Cédula Indentidad', '87086548', '87086548', 'jennyfallas69@yahoo.com', '1969-02-24', 1969),
(107540971, 'Rocío', 'Cubero', 'Valerio', 'Cédula Indentidad', '87720972', '', 'rocicubero@gmail.com', '1969-12-31', 1969),
(107640605, 'Liz', 'Aguilar', 'Castro', 'Cédula Indentidad', '88472255', '88472255', 'princesamelannie@gmail.com', '1970-02-02', 1970),
(109210797, 'Cleo Jane ', 'Solano ', 'Rodríguez', 'Cédula Identidad', '88267072', '', 'cleogirasol@gmail.com', '1975-10-20', 1975),
(109630150, 'Silvia', 'Meza', 'Fuentes', 'Cédula Indentidad', '85366221', '85366221', 'silmezza@gmail.com', '1977-02-27', 1977),
(110300211, 'Mónica ', 'Monge ', 'Mora', 'Cédula Indentidad', '83465388', '', 'monica.monge.mora@gmail.com', '1969-12-31', 1969),
(110350902, 'Adriana ', 'Rodríguez ', 'Cisneros', 'Cédula Identidad', '88308026', '', 'arodriguezcisneros@gmail.com', '1979-05-23', 1979),
(111090052, 'Johanna ', 'Ríos ', 'Madrigal', 'Cédula Identidad', '87033450', '', 'ccamon@gmail.com', '1981-07-04', 1981),
(111111111, 'Carlos ', 'Cordero ', 'Calvo', 'Cédula Identidad', '83418981', '', 'cpuyolcordero@gmail.com', '1989-01-10', 1989),
(111160232, 'Greivin ', 'Ureña ', 'Ramírez ', 'Cédula Identidad', '89142646', '', 'ccamon@gmail.com', '1981-09-18', 1981),
(111320092, 'Andrea', 'Chaves', 'Villalobos', 'Cédula Indentidad', '85168432', '', 'achavesv03@hotmail.com', '1982-03-12', 1982),
(112340408, 'Ruth ', 'Garita ', 'Flores ', 'Cédula Identidad', '88812441', '', 'ruffarte@gmail.com', '1985-03-06', 1985),
(112420803, 'Ena Alejandra', 'Anchía', 'Gabuardi', 'Cédula Indentidad', '87079707', '', 'alejandraanchia@gmail.com', '1982-10-04', 1982),
(112560038, 'Kendy Juleth', 'Alvarado', 'Cambronero', 'Cédula Indentidad', '72089925', '87644126', 'julieth467@gmail.com', '1985-09-12', 1985),
(112640915, 'Silvia ', 'Astorga ', 'Monestel', 'Cédula Identidad', '88030650', '', 'ccamon@gmail.com', '1985-12-19', 1985),
(112660249, 'Elena ', 'Castillo ', 'Ulate', 'Cédula Identidad', '85044957', '', 'elenacastillou@gmail.com', '1985-12-27', 1985),
(112730670, 'Jonathan', 'Guzman', 'Jimenez', 'Cédula Indentidad', '88804599', '', 'jonathan.guzman.jimenez@gmail.com', '1986-03-14', 1986),
(112990412, 'Jinnette', 'Solano', 'Rodríguez', 'Cédula Indentidad', '87051560', '', 'jisolano1986@gmail.com', '1986-12-02', 1986),
(113500431, 'Diana Mary', 'Rojas ', 'Ugalde', 'Cédula Identidad', '72439890', '72439890', 'dirojasugalde@gmail.com', '1988-04-28', 1988),
(114040173, ' Liz Dayana ', 'Sánchez ', 'Rojas ', 'Cédula Indentidad', '70189863', '', 'liz.sanchezrojas@gmail.com', '1969-12-31', 1969),
(114280346, 'Carolina ', 'Levano ', 'Calvo ', 'Cédula Identidad', '84719316', '84719316', 'carolevano90@gmail.com', '1990-03-17', 1990),
(114340210, 'Alyssa Catalina ', 'Arce ', 'Matamoros ', 'Cédula Identidad', '86227426', '', 'cat8913@gmail.com', '1990-07-23', 1990),
(114360252, 'Felipe ', 'Vega ', 'Cordero ', 'Cédula Identidad', '87250839', '', 'ccamon@gmail.com', '1990-07-17', 1990),
(114520288, 'Carlos Andrés ', 'Guardian ', 'Solorzano', 'Cédula Indentidad', '85674038', '85674038', 'c.andgs90@gmail.com', '2025-06-29', 2025),
(114590187, 'Elsebeth Xiomara', 'Roman', 'Morales', 'Cédula Indentidad', '86476436', '', 'tracekattalakis.12@gmail.com', '1991-03-09', 1991),
(114630181, 'Henry Luis ', 'Alpizar ', 'Rodríguez ', 'Cédula Identidad', '88679807', '88679807', 'henry_alprod@hotmail.com', '1991-04-23', 1991),
(114650489, 'Rodolfo José ', 'Fallas ', 'Madrigal ', 'Cédula Identidad', '83768399', '83768399', 'rjfm13@gmail.com', '1991-05-13', 1991),
(114860891, 'Ericka ', 'Díaz', 'Cubero', 'Cédula Indentidad', '84948447', '', 'erickadaz@gmail.com', '1991-12-30', 1991),
(115040702, 'Adrián', 'Marín', 'Chévez', 'Cédula Indentidad', '85359393', '85359393', 'adrianjmch@gmail.com', '1992-05-10', 1992),
(115210215, 'Estefany ', 'Navas ', 'Hernández', 'Cédula Identidad', '23389851', '23389851', 'estefanynh@gmail.com', '1992-11-29', 1992),
(115720812, 'Andrés ', 'Castro ', 'Sáenz', 'Cédula Identidad', '87184720', '87184720', 'scsaenz94@gmail.com', '1994-06-07', 1994),
(115780015, 'Gabriel Dagoberto ', 'Acuña ', 'López ', 'Cédula Indentidad', '57080912', '57080912', 'gabrielnfs94@gmail.com', '1994-08-04', 1994),
(115870378, 'Jorge Fabian', 'Mora ', 'Jara', 'Cédula Identidad', '89098990', '', 'jorgefabianm@gmail.com', '1994-10-27', 1994),
(116110902, 'Mario ', 'Chinchilla ', 'Toruño', 'Cédula Indentidad', '86295925', '', 'chmario07@gmail.com', '1969-12-31', 1969),
(116320392, 'Rebeca María', 'Barquero', 'Sánchez', 'Cédula Indentidad', '83679370', '', 'rb_k96@hotmail.com', '1996-02-06', 1996),
(116330081, 'Adrian ', 'Zuñiga', 'Sáenz', 'Cédula Identidad', '87125295', '87125295', 'adzuniga96@gmail.com', '1996-02-14', 1996),
(116360234, 'Giannina ', 'Morera', 'Solano', 'Cédula Identidad', '87048233', '87048233', 'gianims96@gmail.com', '1996-03-19', 1996),
(116510025, 'Natalia ', 'Angulo', 'Salazar', 'Cédula Indentidad', '88001839', '', 'natsnani24@gmail.com', '1996-08-24', 1996),
(116600302, 'Yader Francisco', 'Blanco', 'Zúñiga', 'Cédula Indentidad', '85803682', '', 'yaderblancozuniga@gmail.com', '1996-11-23', 1996),
(116620082, 'César ', 'Calero ', 'Sequeira', 'Cédula Indentidad', '72896750', '72896750', 'ceca1938@hotmail.com', '1996-12-12', 1996),
(116640632, 'Michell Gabriela', 'Cordero', 'Pereira', 'Cédula Identidad', '83777126', '83777126', 'gabcp97@gmail.com', '1997-01-08', 1997),
(116720693, 'Carolina ', 'Mora ', 'Hidalgo', 'Cédula Indentidad', '87253137', '', 'caromh84@gmail.com', '1997-04-08', 1997),
(116980794, 'Mariela', 'Gamboa', 'Oviedo', 'Cédula Indentidad', '60367940', '', 'paumariela2312@gmail.com', '1997-12-23', 1997),
(116990897, 'Sofia', 'Molina', 'Brenes', 'Cédula Indentidad', '83011819', '83011819', 'sofimoli65cs@hotmail.com', '1998-02-05', 1998),
(117160186, 'Dayana Melissa ', 'Mora ', 'Castillo', 'Cédula Identidad', '85084753', '85084753', 'dayanamora2598@gmail.com', '1998-07-25', 1998),
(117180272, 'Silvia', 'Aguilar', 'Ulloa', 'Cédula Indentidad', '86741496', '22961058', 'silvia.aguilarulloa@gmail.com', '1998-08-15', 1998),
(117200790, 'Sofía Daniela', 'Campos', 'Alfaro', 'Cédula Identidad', '873262711', '873262711', 'daniatvm@gmail.com', '1998-09-14', 1998),
(117230455, 'Nicole', 'Vargas', 'Jarquín', 'Cédula Indentidad', '87108275', '', 'nicole.vj98@gmail.com', '1998-10-15', 1998),
(117300010, 'angie', 'rojas', 'aguilar', 'Cédula Indentidad', '60549033', '60549033', 'angievanessa12@gmail.com', '1998-12-29', 1998),
(117300136, 'Juan Manuel ', 'Jácamo ', 'Céspedes ', 'Cédula Identidad', '87806375', '87806375', 'juanmanueljacamo@gmail.co', '1998-12-23', 1998),
(117330031, 'Julian ', 'Gatjens ', 'Corrales', 'Cédula Indentidad', '85004785', '', 'yayan2301@gmail.com', '1999-01-23', 1999),
(117750791, 'Mariana', 'Segura', 'Méndez', 'Cédula Indentidad', '85822084', '22443410', 'marijesus28@hotmail.com', '2000-04-28', 2000),
(117990081, 'Cristina de Los Ángeles ', 'Jiménez ', 'Chinchilla ', 'Cédula Indentidad', '63250440', '22897484', 'crisjich22@gmail.com', '2000-12-22', 2000),
(120380981, 'Mariángel', 'Fallas', 'Ureña', 'Cédula Indentidad', '87086548', '83204495', 'jennyfallas69@yahoo.com', '2008-10-28', 2008),
(123030904, 'Amanda ', 'Álvarez ', 'Cordero  ', 'Cédula Identidad', '88121458', '', 'ccamon@gmail.com', '1984-08-05', 1984),
(155808770, 'Martha ', 'Suarez ', 'Chavarria ', 'Cédula Indentidad', '85898805', '', 'a.sure.16@gmail.com', '1969-12-31', 1969),
(202010058, 'José Francisco ', 'Soto ', 'Ballestero ', 'Cédula Identidad', '88720061', '88720061', 'soto.josef@gmail.com', '1939-06-20', 1939),
(203790174, 'María Iris del Rocío', 'Cambronero', 'Leiton', 'Cédula Indentidad', '87644126', '72089925', 'julieth467@gmail.com', '1963-01-18', 1963),
(205270338, 'Mariela', 'Hernández', 'Ramírez', 'Cédula Identidad', '88311525', '25509447', 'marielahernandez@tec.ac.cr', '1978-02-24', 2402),
(206780527, 'Karol', 'Jimenez', 'Sanchez', 'Cédula Indentidad', '83100411', '', 'karoljs26@hotmail.com', '1990-10-26', 1990),
(206860437, 'Francella ', 'Artavia ', 'Hernández', 'Cédula Identidad', '85034296', '', 'francella.ucr@gmail.com', '1991-05-10', 1991),
(207770129, 'Astrid Andrea', 'Solano', 'Mora', 'Cédula Indentidad', '60321046', '', 'mora3family@gmail.com', '1998-03-13', 1998),
(302120293, 'Heriberto', 'Cedeño', 'Ceciliano', 'Cédula Indentidad', '83896159', '83896159', 'heri_cedeno@hotmail.com', '1956-01-11', 1956),
(302180863, 'Guisela      ', 'Morice ', 'Haeberle ', 'Cédula Identidad', '83236042', '', 'ccamon@gmail.com', '1950-07-01', 1950),
(302520976, 'Alejandra ', 'Araya ', 'Céspedes', 'Cédula Identidad', '86807200', '25738321', 'alejaraya16@gmail.com', '1961-11-16', 1961),
(302730207, 'Nidia Mayela del Socorro', 'Solano', 'Obando', 'Cédula Indentidad', '84002372', '', 'nydia.solano@yahoo.com', '1965-01-20', 1965),
(303230426, 'Leonardo ', 'Gómez ', 'Guzmán', 'Cédula Identidad', '89320676', '', 'ccamon@gmail.com', '1972-08-15', 1972),
(303890230, 'José Gabriel ', 'Masís ', 'Morales', 'Cédula Identidad', '85071609', '', 'gmasis@tec.ac.cr', '1983-08-04', 1983),
(304380215, 'Valeria ', 'Marín ', 'Chacón', 'Cédula Indentidad', '83352867', '', 'valemarincr@gmail.com', '1969-12-31', 1969),
(304790416, 'José David', 'Palacios ', 'Leandro', 'Cédula Identidad', '86296588', '86296588', 'gatopalacios6@gmail.com', '1994-06-07', 1994),
(305050180, 'Sabrina ', 'Izabá ', 'Aguilar ', 'Cédula Identidad', '88280083', '88280083', 'sizaba17@gmail.com', '1997-09-27', 1997),
(401770967, 'Luis ', 'Bojorge', 'Murillo', 'Cédula Identidad', '87231948', '87231948', 'luisbojorgemurillo@gmail.', '1982-05-08', 1982),
(402010226, 'Carlos ', 'Cordero ', 'Calvo', 'Cédula Identidad', '83418981', '', 'cpuyolcordero@gmail.com', '1989-01-10', 1989),
(402410617, 'Geovanny Francisco', 'Arce', 'Hernández', 'Cédula Indentidad', '85219165', '', 'geovanny860@gmail.com', '1999-01-29', 1999),
(502980013, ' Rolando', ' Pérez ', 'Sequeira', 'Cédula Indentidad', '88914222', '', 'rlndprz@gmail.com', '1977-02-28', 1977),
(601500292, 'Anabelle ', 'Castillo ', 'Morales', 'Cédula Indentidad', '88619972', '', 'anacastillo2260@hotmail.com', '1960-02-02', 1960),
(602070407, 'Aurora ', 'Baltodano ', 'Cordero', 'Cédula Indentidad', '85182008', '27675206', 'abaltodanocordero@gmail.com', '1967-06-09', 1967),
(602790901, 'Viviana', 'Lopez', 'Estrada', 'Cédula Indentidad', '83358866', '', 'lopezvivi@gmail.com', '1977-01-18', 1977),
(603120315, 'Angie', 'Ureña', 'Salazar', 'Cédula Indentidad', '88336734', '', 'angieliliett@gmail.com', '1981-03-04', 1981),
(700360859, 'Eduardo', 'García', 'Quesada', 'Cédula Indentidad', '84182780', '84182780', 'edua.gar.45@gmail.com', '1945-06-10', 1945),
(701680514, 'Nathalie ', 'Castro ', 'Montero', 'Cédula Identidad', '88605073', '', 'fisioterapiaymasaje@gmail.com', '1985-12-08', 1985),
(701920052, 'Andrea ', 'Alfaro ', 'Jimenez', 'Cédula Indentidad', '83100045', '', 'alfaro.andrea89@gmail.com', '1969-12-31', 1969),
(702390296, 'Berny Gerardo ', 'Carmona ', 'Umaña', 'Cédula Indentidad', '85533560', '', 'ber510@hotmail.com', '1995-06-16', 1995),
(702420427, 'Marcos ', 'Rodríguez ', 'Arguedas', 'Cédula Identidad', '72925663', '72925663', 'marcos.razz@gmail.com', '1995-11-22', 1995),
(702760148, 'Tayra Alejandra', 'Gomez', 'Perez', 'Cédula Indentidad', '63203700', '', 'taygomezperez@gmail.com', '2000-04-16', 2000),
(800790644, 'Petronio', ' Marcenaro ', 'Romero', 'Cédula Identidad', '88204381', '', 'ccamon@gmail.com', '1964-08-05', 1964),
(801130631, 'Amparo', ' Reyes', ' Suarez', 'Cédula Indentidad', '85777914', '', 'a.sure.16@gmail.com', '1969-12-31', 1969),
(901080045, 'Jimena', 'Álvarez ', 'Campos', 'Cédula Indentidad', '83094044', '22735196', 'jimee.alvarez@gmail.com', '1997-04-25', 1997),
(901100802, 'Karen ', 'Sandoval ', 'Campos', 'Cédula Identidad', '62199001', '62199001', 'krnsncafer@gmail.com', '1999-02-15', 1999),
(2147483647, 'Jinsui', 'He', '.-', 'DIMEX', '71554094', '71554094', 'linlin0712jh@gmail.com', '1997-08-27', 1997);

-- --------------------------------------------------------

--
-- Stand-in structure for view `usuarios`
-- (See below for the actual view)
--
CREATE TABLE `usuarios` (
`cedula` int(11)
,`nombre` varchar(70)
,`primer_apellido` varchar(45)
,`segundo_apellido` varchar(45)
,`correo` varchar(45)
,`telefono` varchar(45)
,`telefono2` varchar(45)
,`fecha_nacimiento` date
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `Usuarios`
-- (See below for the actual view)
--
CREATE TABLE `Usuarios` (
`cedula` int(11)
,`nombre` varchar(70)
,`primer_apellido` varchar(45)
,`segundo_apellido` varchar(45)
,`correo` varchar(45)
,`telefono` varchar(45)
,`telefono2` varchar(45)
,`fecha_nacimiento` date
);

-- --------------------------------------------------------

--
-- Structure for view `usuarios`
--
DROP TABLE IF EXISTS `usuarios`;

CREATE ALGORITHM=UNDEFINED DEFINER=`casacult`@`localhost` SQL SECURITY DEFINER VIEW `usuarios`  AS  select `Usuario`.`cedula` AS `cedula`,`Usuario`.`nombre` AS `nombre`,`Usuario`.`primer_apellido` AS `primer_apellido`,`Usuario`.`segundo_apellido` AS `segundo_apellido`,`Usuario`.`correo` AS `correo`,`Usuario`.`telefono` AS `telefono`,`Usuario`.`telefono2` AS `telefono2`,`Usuario`.`fecha_nacimiento` AS `fecha_nacimiento` from `Usuario` ;

-- --------------------------------------------------------

--
-- Structure for view `Usuarios`
--
DROP TABLE IF EXISTS `Usuarios`;

CREATE ALGORITHM=UNDEFINED DEFINER=`casacult`@`localhost` SQL SECURITY DEFINER VIEW `Usuarios`  AS  select `Usuario`.`cedula` AS `cedula`,`Usuario`.`nombre` AS `nombre`,`Usuario`.`primer_apellido` AS `primer_apellido`,`Usuario`.`segundo_apellido` AS `segundo_apellido`,`Usuario`.`correo` AS `correo`,`Usuario`.`telefono` AS `telefono`,`Usuario`.`telefono2` AS `telefono2`,`Usuario`.`fecha_nacimiento` AS `fecha_nacimiento` from `Usuario` ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `Administrador`
--
ALTER TABLE `Administrador`
  ADD PRIMARY KEY (`idAdministrador`),
  ADD KEY `fk_administrador_idx` (`cedula_admin`);

--
-- Indexes for table `Comprobante`
--
ALTER TABLE `Comprobante`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_id_matricula` (`id_matricula`);

--
-- Indexes for table `Curso`
--
ALTER TABLE `Curso`
  ADD PRIMARY KEY (`idCurso`);

--
-- Indexes for table `Curso_X_Periodo`
--
ALTER TABLE `Curso_X_Periodo`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_id_curso_idx` (`idCurso`) USING BTREE,
  ADD KEY `fk_id_periodo_idx` (`idPeriodo`) USING BTREE,
  ADD KEY `fk_id_profesor_idx` (`idProfesorAsignado`) USING BTREE;

--
-- Indexes for table `Direccion`
--
ALTER TABLE `Direccion`
  ADD PRIMARY KEY (`iddireccion`),
  ADD UNIQUE KEY `iddireccion` (`iddireccion`),
  ADD KEY `fk_id_profesor_idx` (`id_profesor`);

--
-- Indexes for table `Facturacion`
--
ALTER TABLE `Facturacion`
  ADD PRIMARY KEY (`idFacturacion`),
  ADD UNIQUE KEY `idfacturacion` (`idFacturacion`),
  ADD KEY `fk_id_profesor_idx` (`id_profesor`) USING BTREE;

--
-- Indexes for table `Matricula`
--
ALTER TABLE `Matricula`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `Noticia`
--
ALTER TABLE `Noticia`
  ADD PRIMARY KEY (`idNoticia`),
  ADD UNIQUE KEY `idNoticia_UNIQUE` (`idNoticia`),
  ADD UNIQUE KEY `titulo_UNIQUE` (`titulo`),
  ADD KEY `fk_id_administrador_idx` (`id_administrador`);

--
-- Indexes for table `Periodo`
--
ALTER TABLE `Periodo`
  ADD PRIMARY KEY (`idPeriodo`);

--
-- Indexes for table `Profesor`
--
ALTER TABLE `Profesor`
  ADD PRIMARY KEY (`idProfesor`),
  ADD KEY `fk_cedula_idx` (`cedula_profesor`);

--
-- Indexes for table `Usuario`
--
ALTER TABLE `Usuario`
  ADD PRIMARY KEY (`cedula`),
  ADD UNIQUE KEY `cedula_UNIQUE` (`cedula`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `Administrador`
--
ALTER TABLE `Administrador`
  MODIFY `idAdministrador` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=65;
--
-- AUTO_INCREMENT for table `Comprobante`
--
ALTER TABLE `Comprobante`
  MODIFY `id` int(40) NOT NULL AUTO_INCREMENT COMMENT 'Número que se despliega en comprobante';
--
-- AUTO_INCREMENT for table `Curso`
--
ALTER TABLE `Curso`
  MODIFY `idCurso` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=71;
--
-- AUTO_INCREMENT for table `Curso_X_Periodo`
--
ALTER TABLE `Curso_X_Periodo`
  MODIFY `id` int(40) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=49;
--
-- AUTO_INCREMENT for table `Direccion`
--
ALTER TABLE `Direccion`
  MODIFY `iddireccion` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=41;
--
-- AUTO_INCREMENT for table `Facturacion`
--
ALTER TABLE `Facturacion`
  MODIFY `idFacturacion` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=40;
--
-- AUTO_INCREMENT for table `Matricula`
--
ALTER TABLE `Matricula`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=77;
--
-- AUTO_INCREMENT for table `Noticia`
--
ALTER TABLE `Noticia`
  MODIFY `idNoticia` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `Periodo`
--
ALTER TABLE `Periodo`
  MODIFY `idPeriodo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `Profesor`
--
ALTER TABLE `Profesor`
  MODIFY `idProfesor` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=60;
--
-- Constraints for dumped tables
--

--
-- Constraints for table `Administrador`
--
ALTER TABLE `Administrador`
  ADD CONSTRAINT `fk_administrador` FOREIGN KEY (`cedula_admin`) REFERENCES `Usuario` (`cedula`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `Direccion`
--
ALTER TABLE `Direccion`
  ADD CONSTRAINT `fk_id_profesor_direccion` FOREIGN KEY (`id_profesor`) REFERENCES `Profesor` (`idProfesor`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `Facturacion`
--
ALTER TABLE `Facturacion`
  ADD CONSTRAINT `fk_id_profesor_facturacion` FOREIGN KEY (`id_profesor`) REFERENCES `Profesor` (`idProfesor`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `Noticia`
--
ALTER TABLE `Noticia`
  ADD CONSTRAINT `fk_id_administrador` FOREIGN KEY (`id_administrador`) REFERENCES `Administrador` (`idAdministrador`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `Profesor`
--
ALTER TABLE `Profesor`
  ADD CONSTRAINT `fk_cedula` FOREIGN KEY (`cedula_profesor`) REFERENCES `Usuario` (`cedula`) ON DELETE NO ACTION ON UPDATE NO ACTION;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
