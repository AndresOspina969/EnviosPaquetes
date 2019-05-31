/*
Navicat MySQL Data Transfer

Source Server         : MySQL
Source Server Version : 50505
Source Host           : localhost:3306
Source Database       : envios

Target Server Type    : MYSQL
Target Server Version : 50505
File Encoding         : 65001

Date: 2019-05-30 19:45:08
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for ciudad
-- ----------------------------
DROP TABLE IF EXISTS `ciudad`;
CREATE TABLE `ciudad` (
  `Id_Ciudad` int(11) NOT NULL AUTO_INCREMENT,
  `Nombre_Ciudad` varchar(150) NOT NULL,
  PRIMARY KEY (`Id_Ciudad`),
  UNIQUE KEY `Nombre_Ciudad` (`Nombre_Ciudad`)
) ENGINE=InnoDB AUTO_INCREMENT=51 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ciudad
-- ----------------------------
INSERT INTO `ciudad` VALUES ('34', 'ABEJORRAL');
INSERT INTO `ciudad` VALUES ('35', 'ABREGO');
INSERT INTO `ciudad` VALUES ('36', 'ABRIAQUI');
INSERT INTO `ciudad` VALUES ('40', 'ACACIAS');
INSERT INTO `ciudad` VALUES ('38', 'ACANDI');
INSERT INTO `ciudad` VALUES ('39', 'ACEVEDO');
INSERT INTO `ciudad` VALUES ('37', 'ACHI');
INSERT INTO `ciudad` VALUES ('45', 'AGRADO');
INSERT INTO `ciudad` VALUES ('11', 'AGUA DE DIOS');
INSERT INTO `ciudad` VALUES ('42', 'AGUACHICA');
INSERT INTO `ciudad` VALUES ('46', 'AGUADA');
INSERT INTO `ciudad` VALUES ('43', 'AGUADAS');
INSERT INTO `ciudad` VALUES ('41', 'AGUAZUL');
INSERT INTO `ciudad` VALUES ('44', 'AGUSTIN CODAZZI');
INSERT INTO `ciudad` VALUES ('49', 'AIPE');
INSERT INTO `ciudad` VALUES ('50', 'ALBAN');
INSERT INTO `ciudad` VALUES ('25', 'ARAUCA');
INSERT INTO `ciudad` VALUES ('19', 'ARMENIA');
INSERT INTO `ciudad` VALUES ('2', 'BARRANQUILLA');
INSERT INTO `ciudad` VALUES ('1', 'BOGOTA');
INSERT INTO `ciudad` VALUES ('21', 'BUCARAMANGA');
INSERT INTO `ciudad` VALUES ('48', 'CALAMAR');
INSERT INTO `ciudad` VALUES ('24', 'CALI');
INSERT INTO `ciudad` VALUES ('4', 'CARTAGENA');
INSERT INTO `ciudad` VALUES ('47', 'CHAMEZA');
INSERT INTO `ciudad` VALUES ('18', 'CUCUTA');
INSERT INTO `ciudad` VALUES ('7', 'FLORENCIA');
INSERT INTO `ciudad` VALUES ('23', 'IBAGUE');
INSERT INTO `ciudad` VALUES ('30', 'INIRIDA');
INSERT INTO `ciudad` VALUES ('29', 'LETICIA');
INSERT INTO `ciudad` VALUES ('6', 'MANIZALES');
INSERT INTO `ciudad` VALUES ('3', 'MEDELLIN');
INSERT INTO `ciudad` VALUES ('32', 'MITU');
INSERT INTO `ciudad` VALUES ('27', 'MOCOA');
INSERT INTO `ciudad` VALUES ('10', 'MONTERIA');
INSERT INTO `ciudad` VALUES ('13', 'NEIVA');
INSERT INTO `ciudad` VALUES ('17', 'PASTO');
INSERT INTO `ciudad` VALUES ('20', 'PEREIRA');
INSERT INTO `ciudad` VALUES ('8', 'POPAYAN');
INSERT INTO `ciudad` VALUES ('33', 'PUERTO CARRENO');
INSERT INTO `ciudad` VALUES ('12', 'QUIBDO');
INSERT INTO `ciudad` VALUES ('14', 'RIOHACHA');
INSERT INTO `ciudad` VALUES ('28', 'SAN ANDRES');
INSERT INTO `ciudad` VALUES ('31', 'SAN JOSE DEL GUAVIARE');
INSERT INTO `ciudad` VALUES ('15', 'SANTA MARTA');
INSERT INTO `ciudad` VALUES ('22', 'SINCELEJO');
INSERT INTO `ciudad` VALUES ('5', 'TUNJA');
INSERT INTO `ciudad` VALUES ('9', 'VALLEDUPAR');
INSERT INTO `ciudad` VALUES ('16', 'VILLAVICENCIO');
INSERT INTO `ciudad` VALUES ('26', 'YOPAL');

-- ----------------------------
-- Table structure for cliente
-- ----------------------------
DROP TABLE IF EXISTS `cliente`;
CREATE TABLE `cliente` (
  `Id_Cliente` int(11) NOT NULL AUTO_INCREMENT,
  `Nombres_Cliente` varchar(150) NOT NULL,
  `Apellidos_Cliente` varchar(150) NOT NULL,
  `Documento_Cliente` varchar(25) NOT NULL,
  `Telefono_Cliente` bigint(20) DEFAULT NULL,
  `Direccion_Cliente` varchar(250) NOT NULL,
  PRIMARY KEY (`Id_Cliente`),
  UNIQUE KEY `Documento_Cliente` (`Documento_Cliente`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of cliente
-- ----------------------------
INSERT INTO `cliente` VALUES ('1', 'Pepito', 'Perez', '123456', '11333254', '');
INSERT INTO `cliente` VALUES ('2', 'Jane', 'Doe', '234567', '556565', 'fsafsagf');
INSERT INTO `cliente` VALUES ('3', 'Jhon', 'Dow', '345678', '554844554', 'dsafsafg');
INSERT INTO `cliente` VALUES ('6', 'Pepito', 'Perez', '241412512', null, 'AAAAAAAAAAAAAAA');
INSERT INTO `cliente` VALUES ('29', 'Juan Andres', 'Villabona Ospina', '1031167004', '0', 'Cll 123 # 456');
INSERT INTO `cliente` VALUES ('30', 'Prueba', 'ioyoiy', '13124067', '0', 'idsaohd');

-- ----------------------------
-- Table structure for estadopaquete
-- ----------------------------
DROP TABLE IF EXISTS `estadopaquete`;
CREATE TABLE `estadopaquete` (
  `Id_EstadoPaquete` int(11) NOT NULL AUTO_INCREMENT,
  `Nombre_EstadoPaquete` varchar(50) NOT NULL,
  `Tipo_EstadoPaquete` int(11) NOT NULL,
  PRIMARY KEY (`Id_EstadoPaquete`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of estadopaquete
-- ----------------------------
INSERT INTO `estadopaquete` VALUES ('1', 'Recepción', '1');
INSERT INTO `estadopaquete` VALUES ('2', 'Bodega', '1');
INSERT INTO `estadopaquete` VALUES ('3', 'Desplazamiento', '1');
INSERT INTO `estadopaquete` VALUES ('5', 'Distribución', '1');
INSERT INTO `estadopaquete` VALUES ('6', 'Entrega', '1');
INSERT INTO `estadopaquete` VALUES ('7', 'Devuelto', '2');
INSERT INTO `estadopaquete` VALUES ('8', 'Perdido', '2');
INSERT INTO `estadopaquete` VALUES ('9', 'Dañado', '2');

-- ----------------------------
-- Table structure for estadousuario
-- ----------------------------
DROP TABLE IF EXISTS `estadousuario`;
CREATE TABLE `estadousuario` (
  `Id_Estado` int(11) NOT NULL AUTO_INCREMENT,
  `Nombre_Estado` varchar(150) NOT NULL,
  PRIMARY KEY (`Id_Estado`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of estadousuario
-- ----------------------------
INSERT INTO `estadousuario` VALUES ('1', 'Activo');
INSERT INTO `estadousuario` VALUES ('2', 'Inactivo');

-- ----------------------------
-- Table structure for paquete
-- ----------------------------
DROP TABLE IF EXISTS `paquete`;
CREATE TABLE `paquete` (
  `Id_Paquete` int(11) NOT NULL AUTO_INCREMENT,
  `Id_ClienteEnvia` int(11) NOT NULL,
  `Id_ClienteRecibe` int(11) NOT NULL,
  `Id_UsuarioRegistro` int(11) NOT NULL,
  `Descripcion_Paquete` varchar(250) NOT NULL,
  `FechaRegistro_Paquete` datetime NOT NULL,
  `FechaEntrega` datetime DEFAULT NULL,
  `IdTarifa_Paquete` int(11) NOT NULL,
  `Id_EstadoPaquete` int(11) NOT NULL,
  `Id_UsuarioMensajero` int(11) DEFAULT NULL,
  PRIMARY KEY (`Id_Paquete`),
  KEY `Id_ClienteEnvia` (`Id_ClienteEnvia`),
  KEY `Id_ClienteRecibe` (`Id_ClienteRecibe`),
  KEY `Id_UsuarioRegistro` (`Id_UsuarioRegistro`),
  KEY `IdTarifa_Paquete` (`IdTarifa_Paquete`),
  KEY `Id_EstadoPaquete` (`Id_EstadoPaquete`),
  KEY `Id_UsuarioMensajero` (`Id_UsuarioMensajero`),
  CONSTRAINT `paquete_ibfk_1` FOREIGN KEY (`Id_ClienteEnvia`) REFERENCES `cliente` (`Id_Cliente`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `paquete_ibfk_2` FOREIGN KEY (`Id_ClienteRecibe`) REFERENCES `cliente` (`Id_Cliente`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `paquete_ibfk_3` FOREIGN KEY (`Id_UsuarioRegistro`) REFERENCES `usuario` (`Id_Usuario`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `paquete_ibfk_4` FOREIGN KEY (`IdTarifa_Paquete`) REFERENCES `tarifa` (`Id_Tarifa`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `paquete_ibfk_5` FOREIGN KEY (`Id_EstadoPaquete`) REFERENCES `estadopaquete` (`Id_EstadoPaquete`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `paquete_ibfk_6` FOREIGN KEY (`Id_UsuarioMensajero`) REFERENCES `usuario` (`Id_Usuario`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of paquete
-- ----------------------------
INSERT INTO `paquete` VALUES ('15', '2', '29', '12', 'Prueba', '2019-05-29 21:01:47', '2019-05-30 19:42:31', '4', '6', '13');

-- ----------------------------
-- Table structure for rol
-- ----------------------------
DROP TABLE IF EXISTS `rol`;
CREATE TABLE `rol` (
  `Id_Rol` int(11) NOT NULL AUTO_INCREMENT,
  `Nombre_Rol` varchar(150) NOT NULL,
  PRIMARY KEY (`Id_Rol`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of rol
-- ----------------------------
INSERT INTO `rol` VALUES ('1', 'Administrador');
INSERT INTO `rol` VALUES ('2', 'Operador');
INSERT INTO `rol` VALUES ('3', 'Mensajero');

-- ----------------------------
-- Table structure for tarifa
-- ----------------------------
DROP TABLE IF EXISTS `tarifa`;
CREATE TABLE `tarifa` (
  `Id_Tarifa` int(11) NOT NULL AUTO_INCREMENT,
  `CiudadOrigen_Tarifa` int(11) NOT NULL,
  `CiudadDestino_Tarifa` int(11) NOT NULL,
  `Valor_Tarifa` double NOT NULL,
  PRIMARY KEY (`Id_Tarifa`),
  KEY `CiudadOrigen_Tarifa` (`CiudadOrigen_Tarifa`),
  KEY `CiudadDestino_Tarifa` (`CiudadDestino_Tarifa`),
  CONSTRAINT `tarifa_ibfk_1` FOREIGN KEY (`CiudadOrigen_Tarifa`) REFERENCES `ciudad` (`Id_Ciudad`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `tarifa_ibfk_2` FOREIGN KEY (`CiudadDestino_Tarifa`) REFERENCES `ciudad` (`Id_Ciudad`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=242 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tarifa
-- ----------------------------
INSERT INTO `tarifa` VALUES ('1', '1', '1', '50000');
INSERT INTO `tarifa` VALUES ('3', '3', '3', '50000');
INSERT INTO `tarifa` VALUES ('4', '4', '4', '50000');
INSERT INTO `tarifa` VALUES ('5', '5', '5', '50000');
INSERT INTO `tarifa` VALUES ('6', '6', '6', '50000');
INSERT INTO `tarifa` VALUES ('7', '7', '7', '50000');
INSERT INTO `tarifa` VALUES ('8', '8', '8', '50000');
INSERT INTO `tarifa` VALUES ('9', '9', '9', '50000');
INSERT INTO `tarifa` VALUES ('10', '10', '10', '50000');
INSERT INTO `tarifa` VALUES ('11', '11', '11', '50000');
INSERT INTO `tarifa` VALUES ('12', '12', '12', '50000');
INSERT INTO `tarifa` VALUES ('13', '13', '13', '50000');
INSERT INTO `tarifa` VALUES ('14', '14', '14', '50000');
INSERT INTO `tarifa` VALUES ('15', '15', '15', '50000');
INSERT INTO `tarifa` VALUES ('16', '16', '16', '50000');
INSERT INTO `tarifa` VALUES ('17', '17', '17', '50000');
INSERT INTO `tarifa` VALUES ('18', '18', '18', '50000');
INSERT INTO `tarifa` VALUES ('19', '19', '19', '50000');
INSERT INTO `tarifa` VALUES ('20', '20', '20', '50000');
INSERT INTO `tarifa` VALUES ('21', '21', '21', '50000');
INSERT INTO `tarifa` VALUES ('22', '22', '22', '50000');
INSERT INTO `tarifa` VALUES ('23', '23', '23', '50000');
INSERT INTO `tarifa` VALUES ('24', '24', '24', '50000');
INSERT INTO `tarifa` VALUES ('25', '25', '25', '50000');
INSERT INTO `tarifa` VALUES ('26', '26', '26', '50000');
INSERT INTO `tarifa` VALUES ('27', '27', '27', '50000');
INSERT INTO `tarifa` VALUES ('28', '28', '28', '50000');
INSERT INTO `tarifa` VALUES ('29', '29', '29', '50000');
INSERT INTO `tarifa` VALUES ('30', '30', '30', '50000');
INSERT INTO `tarifa` VALUES ('31', '31', '31', '50000');
INSERT INTO `tarifa` VALUES ('32', '32', '32', '50000');
INSERT INTO `tarifa` VALUES ('33', '33', '33', '50000');
INSERT INTO `tarifa` VALUES ('37', '37', '37', '50000');
INSERT INTO `tarifa` VALUES ('38', '38', '38', '50000');
INSERT INTO `tarifa` VALUES ('39', '39', '39', '50000');
INSERT INTO `tarifa` VALUES ('40', '40', '40', '50000');
INSERT INTO `tarifa` VALUES ('41', '41', '41', '50000');
INSERT INTO `tarifa` VALUES ('42', '42', '42', '50000');
INSERT INTO `tarifa` VALUES ('43', '43', '43', '50000');
INSERT INTO `tarifa` VALUES ('44', '44', '44', '50000');
INSERT INTO `tarifa` VALUES ('46', '46', '46', '50000');
INSERT INTO `tarifa` VALUES ('47', '47', '47', '50000');
INSERT INTO `tarifa` VALUES ('48', '48', '48', '50000');
INSERT INTO `tarifa` VALUES ('49', '49', '49', '50000');
INSERT INTO `tarifa` VALUES ('50', '50', '50', '50000');
INSERT INTO `tarifa` VALUES ('51', '1', '2', '109650');
INSERT INTO `tarifa` VALUES ('52', '1', '3', '91370');
INSERT INTO `tarifa` VALUES ('53', '1', '4', '118100');
INSERT INTO `tarifa` VALUES ('54', '1', '5', '75580');
INSERT INTO `tarifa` VALUES ('55', '1', '6', '69930');
INSERT INTO `tarifa` VALUES ('56', '1', '7', '63100');
INSERT INTO `tarifa` VALUES ('57', '1', '8', '102300');
INSERT INTO `tarifa` VALUES ('58', '1', '9', '73670');
INSERT INTO `tarifa` VALUES ('59', '1', '10', '95540');
INSERT INTO `tarifa` VALUES ('60', '1', '11', '86030');
INSERT INTO `tarifa` VALUES ('61', '1', '12', '144200');
INSERT INTO `tarifa` VALUES ('62', '1', '13', '105160');
INSERT INTO `tarifa` VALUES ('63', '1', '14', '79640');
INSERT INTO `tarifa` VALUES ('64', '1', '15', '52730');
INSERT INTO `tarifa` VALUES ('65', '1', '16', '114850');
INSERT INTO `tarifa` VALUES ('66', '1', '17', '50350');
INSERT INTO `tarifa` VALUES ('67', '1', '18', '131790');
INSERT INTO `tarifa` VALUES ('68', '1', '19', '55570');
INSERT INTO `tarifa` VALUES ('69', '1', '20', '107510');
INSERT INTO `tarifa` VALUES ('70', '1', '21', '72990');
INSERT INTO `tarifa` VALUES ('71', '1', '22', '113690');
INSERT INTO `tarifa` VALUES ('72', '1', '23', '64720');
INSERT INTO `tarifa` VALUES ('73', '1', '24', '116080');
INSERT INTO `tarifa` VALUES ('74', '1', '25', '78810');
INSERT INTO `tarifa` VALUES ('75', '1', '26', '61620');
INSERT INTO `tarifa` VALUES ('76', '1', '27', '130450');
INSERT INTO `tarifa` VALUES ('77', '1', '28', '137620');
INSERT INTO `tarifa` VALUES ('78', '1', '29', '74470');
INSERT INTO `tarifa` VALUES ('79', '1', '30', '92630');
INSERT INTO `tarifa` VALUES ('80', '1', '31', '59380');
INSERT INTO `tarifa` VALUES ('81', '1', '32', '70120');
INSERT INTO `tarifa` VALUES ('82', '1', '33', '96500');
INSERT INTO `tarifa` VALUES ('83', '1', '34', '84010');
INSERT INTO `tarifa` VALUES ('84', '1', '35', '95820');
INSERT INTO `tarifa` VALUES ('85', '1', '36', '138700');
INSERT INTO `tarifa` VALUES ('86', '1', '37', '78000');
INSERT INTO `tarifa` VALUES ('87', '1', '38', '92620');
INSERT INTO `tarifa` VALUES ('88', '1', '39', '105770');
INSERT INTO `tarifa` VALUES ('89', '1', '40', '98110');
INSERT INTO `tarifa` VALUES ('90', '1', '41', '127340');
INSERT INTO `tarifa` VALUES ('91', '1', '42', '73410');
INSERT INTO `tarifa` VALUES ('92', '1', '43', '115900');
INSERT INTO `tarifa` VALUES ('93', '1', '44', '90720');
INSERT INTO `tarifa` VALUES ('94', '1', '45', '66700');
INSERT INTO `tarifa` VALUES ('95', '1', '46', '91450');
INSERT INTO `tarifa` VALUES ('96', '1', '47', '126570');
INSERT INTO `tarifa` VALUES ('97', '1', '48', '79350');
INSERT INTO `tarifa` VALUES ('98', '1', '49', '109030');
INSERT INTO `tarifa` VALUES ('99', '1', '50', '129050');
INSERT INTO `tarifa` VALUES ('100', '2', '3', '71770');
INSERT INTO `tarifa` VALUES ('101', '2', '4', '103560');
INSERT INTO `tarifa` VALUES ('102', '2', '5', '81360');
INSERT INTO `tarifa` VALUES ('103', '2', '6', '70370');
INSERT INTO `tarifa` VALUES ('104', '2', '7', '55670');
INSERT INTO `tarifa` VALUES ('105', '2', '8', '122590');
INSERT INTO `tarifa` VALUES ('106', '2', '9', '65140');
INSERT INTO `tarifa` VALUES ('107', '2', '10', '130930');
INSERT INTO `tarifa` VALUES ('108', '2', '11', '74930');
INSERT INTO `tarifa` VALUES ('109', '2', '12', '74880');
INSERT INTO `tarifa` VALUES ('110', '2', '13', '85670');
INSERT INTO `tarifa` VALUES ('111', '2', '14', '75790');
INSERT INTO `tarifa` VALUES ('112', '2', '15', '107380');
INSERT INTO `tarifa` VALUES ('113', '2', '16', '52400');
INSERT INTO `tarifa` VALUES ('114', '2', '17', '94500');
INSERT INTO `tarifa` VALUES ('115', '2', '18', '107000');
INSERT INTO `tarifa` VALUES ('116', '2', '19', '73240');
INSERT INTO `tarifa` VALUES ('117', '2', '20', '94550');
INSERT INTO `tarifa` VALUES ('118', '2', '21', '97460');
INSERT INTO `tarifa` VALUES ('119', '2', '22', '84990');
INSERT INTO `tarifa` VALUES ('120', '2', '23', '106770');
INSERT INTO `tarifa` VALUES ('121', '2', '24', '122700');
INSERT INTO `tarifa` VALUES ('122', '2', '25', '95180');
INSERT INTO `tarifa` VALUES ('123', '2', '26', '53050');
INSERT INTO `tarifa` VALUES ('124', '2', '27', '50130');
INSERT INTO `tarifa` VALUES ('125', '2', '28', '104650');
INSERT INTO `tarifa` VALUES ('126', '2', '29', '107440');
INSERT INTO `tarifa` VALUES ('127', '2', '30', '52110');
INSERT INTO `tarifa` VALUES ('128', '2', '31', '99850');
INSERT INTO `tarifa` VALUES ('129', '2', '32', '70780');
INSERT INTO `tarifa` VALUES ('130', '2', '33', '109960');
INSERT INTO `tarifa` VALUES ('131', '2', '34', '82080');
INSERT INTO `tarifa` VALUES ('132', '2', '35', '125360');
INSERT INTO `tarifa` VALUES ('133', '2', '36', '75870');
INSERT INTO `tarifa` VALUES ('134', '2', '37', '89000');
INSERT INTO `tarifa` VALUES ('135', '2', '38', '102690');
INSERT INTO `tarifa` VALUES ('136', '2', '39', '72340');
INSERT INTO `tarifa` VALUES ('137', '2', '40', '83580');
INSERT INTO `tarifa` VALUES ('138', '2', '41', '100640');
INSERT INTO `tarifa` VALUES ('139', '2', '42', '102620');
INSERT INTO `tarifa` VALUES ('140', '2', '43', '83990');
INSERT INTO `tarifa` VALUES ('141', '2', '44', '96350');
INSERT INTO `tarifa` VALUES ('142', '2', '45', '89580');
INSERT INTO `tarifa` VALUES ('143', '2', '46', '110840');
INSERT INTO `tarifa` VALUES ('144', '2', '47', '107960');
INSERT INTO `tarifa` VALUES ('145', '2', '48', '105020');
INSERT INTO `tarifa` VALUES ('146', '2', '49', '87810');
INSERT INTO `tarifa` VALUES ('147', '2', '50', '88970');
INSERT INTO `tarifa` VALUES ('148', '3', '4', '72540');
INSERT INTO `tarifa` VALUES ('149', '3', '5', '98820');
INSERT INTO `tarifa` VALUES ('150', '3', '6', '78380');
INSERT INTO `tarifa` VALUES ('151', '3', '7', '124460');
INSERT INTO `tarifa` VALUES ('152', '3', '8', '67430');
INSERT INTO `tarifa` VALUES ('153', '3', '9', '94770');
INSERT INTO `tarifa` VALUES ('154', '3', '10', '82690');
INSERT INTO `tarifa` VALUES ('155', '3', '11', '141000');
INSERT INTO `tarifa` VALUES ('156', '3', '12', '54340');
INSERT INTO `tarifa` VALUES ('157', '3', '13', '83240');
INSERT INTO `tarifa` VALUES ('158', '3', '14', '72440');
INSERT INTO `tarifa` VALUES ('159', '3', '15', '58000');
INSERT INTO `tarifa` VALUES ('160', '3', '16', '87460');
INSERT INTO `tarifa` VALUES ('161', '3', '17', '60130');
INSERT INTO `tarifa` VALUES ('162', '3', '18', '95800');
INSERT INTO `tarifa` VALUES ('163', '3', '19', '83190');
INSERT INTO `tarifa` VALUES ('164', '3', '20', '138580');
INSERT INTO `tarifa` VALUES ('165', '3', '21', '146960');
INSERT INTO `tarifa` VALUES ('166', '3', '22', '136600');
INSERT INTO `tarifa` VALUES ('167', '3', '23', '92480');
INSERT INTO `tarifa` VALUES ('168', '3', '24', '56490');
INSERT INTO `tarifa` VALUES ('169', '3', '25', '77070');
INSERT INTO `tarifa` VALUES ('170', '3', '26', '94020');
INSERT INTO `tarifa` VALUES ('171', '3', '27', '86690');
INSERT INTO `tarifa` VALUES ('172', '3', '28', '76400');
INSERT INTO `tarifa` VALUES ('173', '3', '29', '80560');
INSERT INTO `tarifa` VALUES ('174', '3', '30', '67390');
INSERT INTO `tarifa` VALUES ('175', '3', '31', '88340');
INSERT INTO `tarifa` VALUES ('176', '3', '32', '52370');
INSERT INTO `tarifa` VALUES ('177', '3', '33', '111680');
INSERT INTO `tarifa` VALUES ('178', '3', '34', '57480');
INSERT INTO `tarifa` VALUES ('179', '3', '35', '118950');
INSERT INTO `tarifa` VALUES ('180', '3', '36', '79550');
INSERT INTO `tarifa` VALUES ('181', '3', '37', '99870');
INSERT INTO `tarifa` VALUES ('182', '3', '38', '96730');
INSERT INTO `tarifa` VALUES ('183', '3', '39', '79710');
INSERT INTO `tarifa` VALUES ('184', '3', '40', '68020');
INSERT INTO `tarifa` VALUES ('185', '3', '41', '50390');
INSERT INTO `tarifa` VALUES ('186', '3', '42', '77970');
INSERT INTO `tarifa` VALUES ('187', '3', '43', '76420');
INSERT INTO `tarifa` VALUES ('188', '3', '44', '117270');
INSERT INTO `tarifa` VALUES ('189', '3', '45', '77440');
INSERT INTO `tarifa` VALUES ('190', '3', '46', '73640');
INSERT INTO `tarifa` VALUES ('191', '3', '47', '117820');
INSERT INTO `tarifa` VALUES ('192', '3', '48', '99940');
INSERT INTO `tarifa` VALUES ('193', '3', '49', '111790');
INSERT INTO `tarifa` VALUES ('194', '3', '50', '53750');
INSERT INTO `tarifa` VALUES ('195', '4', '5', '123520');
INSERT INTO `tarifa` VALUES ('196', '4', '6', '53530');
INSERT INTO `tarifa` VALUES ('197', '4', '7', '121130');
INSERT INTO `tarifa` VALUES ('198', '4', '8', '80350');
INSERT INTO `tarifa` VALUES ('199', '4', '9', '102570');
INSERT INTO `tarifa` VALUES ('200', '4', '10', '123710');
INSERT INTO `tarifa` VALUES ('201', '4', '11', '145060');
INSERT INTO `tarifa` VALUES ('202', '4', '12', '92210');
INSERT INTO `tarifa` VALUES ('203', '4', '13', '99370');
INSERT INTO `tarifa` VALUES ('204', '4', '14', '79640');
INSERT INTO `tarifa` VALUES ('205', '4', '15', '91860');
INSERT INTO `tarifa` VALUES ('206', '4', '16', '81730');
INSERT INTO `tarifa` VALUES ('207', '4', '17', '75120');
INSERT INTO `tarifa` VALUES ('208', '4', '18', '105100');
INSERT INTO `tarifa` VALUES ('209', '4', '19', '106580');
INSERT INTO `tarifa` VALUES ('210', '4', '20', '146210');
INSERT INTO `tarifa` VALUES ('211', '4', '21', '82590');
INSERT INTO `tarifa` VALUES ('212', '4', '22', '95610');
INSERT INTO `tarifa` VALUES ('213', '4', '23', '103510');
INSERT INTO `tarifa` VALUES ('214', '4', '24', '94300');
INSERT INTO `tarifa` VALUES ('215', '4', '25', '126370');
INSERT INTO `tarifa` VALUES ('216', '4', '26', '54350');
INSERT INTO `tarifa` VALUES ('217', '4', '27', '69280');
INSERT INTO `tarifa` VALUES ('218', '4', '28', '130960');
INSERT INTO `tarifa` VALUES ('219', '4', '29', '51170');
INSERT INTO `tarifa` VALUES ('220', '4', '30', '90480');
INSERT INTO `tarifa` VALUES ('221', '4', '31', '70130');
INSERT INTO `tarifa` VALUES ('222', '4', '32', '82350');
INSERT INTO `tarifa` VALUES ('223', '4', '33', '82410');
INSERT INTO `tarifa` VALUES ('224', '4', '34', '108310');
INSERT INTO `tarifa` VALUES ('225', '4', '35', '148380');
INSERT INTO `tarifa` VALUES ('226', '4', '36', '62750');
INSERT INTO `tarifa` VALUES ('227', '4', '37', '77530');
INSERT INTO `tarifa` VALUES ('228', '4', '38', '124130');
INSERT INTO `tarifa` VALUES ('229', '4', '39', '101150');
INSERT INTO `tarifa` VALUES ('230', '4', '40', '89870');
INSERT INTO `tarifa` VALUES ('231', '4', '41', '51450');
INSERT INTO `tarifa` VALUES ('232', '4', '42', '130300');
INSERT INTO `tarifa` VALUES ('233', '4', '43', '103540');
INSERT INTO `tarifa` VALUES ('234', '4', '44', '92970');
INSERT INTO `tarifa` VALUES ('235', '4', '45', '97000');
INSERT INTO `tarifa` VALUES ('236', '4', '46', '60670');
INSERT INTO `tarifa` VALUES ('237', '4', '47', '90830');
INSERT INTO `tarifa` VALUES ('238', '4', '48', '136080');
INSERT INTO `tarifa` VALUES ('239', '4', '49', '97820');
INSERT INTO `tarifa` VALUES ('240', '4', '50', '128580');

-- ----------------------------
-- Table structure for usuario
-- ----------------------------
DROP TABLE IF EXISTS `usuario`;
CREATE TABLE `usuario` (
  `Id_Usuario` int(11) NOT NULL AUTO_INCREMENT,
  `Nombres_Usuario` varchar(250) NOT NULL,
  `Apellidos_Usuario` varchar(250) NOT NULL,
  `Documento_Usuario` bigint(20) NOT NULL,
  `correoelectronico_usuario` varchar(150) NOT NULL,
  `Contrasenia_Usuario` text NOT NULL,
  `Telefono_Usuario` bigint(20) DEFAULT NULL,
  `Rol_Usuario` int(11) NOT NULL,
  `Estado_Usuario` int(11) NOT NULL,
  `LlaveContrasenia_Usuario` text,
  PRIMARY KEY (`Id_Usuario`),
  UNIQUE KEY `correoelectronico_usuario` (`correoelectronico_usuario`),
  KEY `Rol_Usuario` (`Rol_Usuario`),
  KEY `Estado_Usuario` (`Estado_Usuario`),
  CONSTRAINT `usuario_ibfk_1` FOREIGN KEY (`Rol_Usuario`) REFERENCES `rol` (`Id_Rol`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `usuario_ibfk_2` FOREIGN KEY (`Estado_Usuario`) REFERENCES `estadousuario` (`Id_Estado`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of usuario
-- ----------------------------
INSERT INTO `usuario` VALUES ('1', 'Juan Andres', 'Villabona Ospina', '1031167004', 'jabo41@hotmail.com', 'hDQqrIX8rHjPTP5w8gcfZQ==', '3125460181', '1', '1', '4akjzDqjvDsEOBos4SY?_JnzssnR=MFoPE9wRuL867mSBqt3Npyq¡bXu%0!hpWs8_d#jQ?ZJh!kqwS-c');
INSERT INTO `usuario` VALUES ('12', 'Andres ', 'Ospina', '1031167004', 'operador@hotmail.com', 'SmoYBhq6jaeMjcA4eFCH2g==', '0', '2', '1', 'x1Y4nioD3y4JFJ9XU9h=dkUK$WTBpIEzp7FSUb7?ahUZlQtAG¡u@_eunfn!PM&nu¡EtWdqcTbp=@N¿zw');
INSERT INTO `usuario` VALUES ('13', 'Jhon', 'Doe', '23124124', 'mensajero@hotmail.com', '8kOrDuag2TIP8gimj6QXwQ==', '2415124', '3', '1', 'zek3lEv_eZd4QCQctf-I5RtX1Cyz_eK.pxXFg*hwcp=4W=Tko8=k*Ic69Lb7f.*aphNt4k@t_ZGO1Oa0');

-- ----------------------------
-- Procedure structure for ChangePassword
-- ----------------------------
DROP PROCEDURE IF EXISTS `ChangePassword`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `ChangePassword`(
	IN IdUsuario INT (11),
	IN PasswordUser TEXT,
	IN HashKey TEXT
)
BEGIN
	UPDATE 
	usuario	
	SET
	Contrasenia_Usuario = PasswordUser,
	LlaveContrasenia_Usuario = HashKey
	WHERE Id_Usuario = IdUsuario;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for DeleteEnvio
-- ----------------------------
DROP PROCEDURE IF EXISTS `DeleteEnvio`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `DeleteEnvio`(
	IN IdEnvio int(11) 
)
BEGIN
	DELETE FROM paquete WHERE Id_Paquete = IdEnvio;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for DeleteTarifa
-- ----------------------------
DROP PROCEDURE IF EXISTS `DeleteTarifa`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `DeleteTarifa`(
	IN IdTarifa int(11)
)
BEGIN
	DELETE FROM tarifa WHERE Id_Tarifa = IdTarifa;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for DeleteUser
-- ----------------------------
DROP PROCEDURE IF EXISTS `DeleteUser`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `DeleteUser`(
	IN IdUsuario int(11)
)
BEGIN
	DELETE FROM usuario WHERE Id_Usuario = IdUsuario;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for EntregaPaquete
-- ----------------------------
DROP PROCEDURE IF EXISTS `EntregaPaquete`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `EntregaPaquete`( IN IdPaquete int(11))
BEGIN
	UPDATE paquete 
	SET Id_EstadoPaquete = 6,
	FechaEntrega = NOW()
	WHERE Id_Paquete = IdPaquete;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for GetAllPacks
-- ----------------------------
DROP PROCEDURE IF EXISTS `GetAllPacks`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetAllPacks`()
BEGIN 
	SELECT
	pack.Id_Paquete AS IdPaquete,
	pack.Descripcion_Paquete AS Descripcion,
	EstPack.Nombre_EstadoPaquete AS Estado,
	CONCAT(cl_envia.Nombres_Cliente, ' ', cl_envia.Apellidos_Cliente) AS NombreRemitente,
	CONCAT(cl_recibe.Nombres_Cliente, ' ', cl_recibe.Apellidos_Cliente) AS NombreDestinatario,
	pack.FechaRegistro_Paquete AS Fecha_Registro
	FROM paquete pack
	INNER JOIN cliente cl_envia 
	ON pack.Id_ClienteEnvia = cl_envia.Id_Cliente
	INNER JOIN cliente cl_recibe
	ON pack.Id_ClienteRecibe = cl_recibe.Id_Cliente
	INNER JOIN estadopaquete EstPack
	ON pack.Id_EstadoPaquete = EstPack.Id_EstadoPaquete;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for GetAllPacksByDelivery
-- ----------------------------
DROP PROCEDURE IF EXISTS `GetAllPacksByDelivery`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetAllPacksByDelivery`(
	IN IdMensajero int(11)
)
BEGIN 
	SELECT
	pack.Id_Paquete AS IdPaquete,
	pack.Descripcion_Paquete AS Descripcion,
	CONCAT(cl_envia.Nombres_Cliente, ' ', cl_envia.Apellidos_Cliente) AS NombreRemitente,
	CONCAT(cl_recibe.Nombres_Cliente, ' ', cl_recibe.Apellidos_Cliente) AS NombreDestinatario,
	pack.FechaRegistro_Paquete AS Fecha_Registro,
	CONCAT(CIU_OR.Nombre_Ciudad, ' - ' ,CIU_DES.Nombre_Ciudad) AS CiudadOrigenDestino
	FROM paquete pack
	INNER JOIN cliente cl_envia 
	ON pack.Id_ClienteEnvia = cl_envia.Id_Cliente
	INNER JOIN cliente cl_recibe
	ON pack.Id_ClienteRecibe = cl_recibe.Id_Cliente
	INNER JOIN estadopaquete EstPack
	ON pack.Id_EstadoPaquete = EstPack.Id_EstadoPaquete
	INNER JOIN tarifa TRF
	ON TRF.Id_Tarifa = pack.IdTarifa_Paquete
	INNER JOIN ciudad CIU_OR
	ON CIU_OR.Id_Ciudad = TRF.CiudadOrigen_Tarifa 
	INNER JOIN ciudad CIU_DES
	ON CIU_DES.Id_Ciudad = TRF.CiudadDestino_Tarifa 
	WHERE pack.Id_UsuarioMensajero = IdMensajero
	AND pack.Id_EstadoPaquete = 3;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for GetCiudadesList
-- ----------------------------
DROP PROCEDURE IF EXISTS `GetCiudadesList`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetCiudadesList`()
BEGIN
	SELECT 
	CIU.Id_Ciudad AS Id,
	CIU.Nombre_Ciudad AS Nombre
	FROM
	ciudad CIU
	ORDER BY CIU.Nombre_Ciudad ASC;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for GetDeliveryUser
-- ----------------------------
DROP PROCEDURE IF EXISTS `GetDeliveryUser`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetDeliveryUser`()
BEGIN
	SELECT 
	USR.Id_Usuario AS Id,
	CONCAT(USR.Nombres_Usuario , ' ' , USR.Apellidos_Usuario) AS NombreUsuario 
	FROM 
	usuario USR
	WHERE USR.Rol_Usuario = 3;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for GetEnvioInfoById
-- ----------------------------
DROP PROCEDURE IF EXISTS `GetEnvioInfoById`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetEnvioInfoById`(
	IN IdEnvio int(11)
)
BEGIN
	SELECT
	PCK.Id_Paquete AS Id,
	CONCAT(CL_REM.Nombres_Cliente,' ', CL_REM.Apellidos_Cliente) AS NombreRemitente,
	CL_REM.Documento_Cliente AS DocumentoRemitente,
	CONCAT(CL_DES.Nombres_Cliente,' ', CL_DES.Apellidos_Cliente) AS NombreDestinatario,
	CL_DES.Documento_Cliente AS DocumentoDestinatario,
	PCK.IdTarifa_Paquete AS IdTarifa,
	PCK.Descripcion_Paquete AS Descripcion,
	PCK.Id_EstadoPaquete AS IdEstado,
	IFNULL(PCK.FechaEntrega,'NO-VALUE') AS FechaEntrega,
	IFNULL(CONCAT(USR.Nombres_Usuario,' ', USR.Apellidos_Usuario),'NO-VALUE') AS UsuarioMensajero,
	IFNULL(USR.Id_Usuario,'NO-VALUE') AS IdMensajero
	FROM paquete PCK
	INNER JOIN cliente CL_REM 
	ON CL_REM.Id_Cliente = PCK.Id_ClienteEnvia 
	INNER JOIN cliente CL_DES 
	ON CL_DES.Id_Cliente = PCK.Id_ClienteRecibe
	LEFT JOIN usuario USR 
	ON USR.Id_Usuario = PCK.Id_UsuarioMensajero
	WHERE PCK.Id_Paquete = IdEnvio;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for GetInfoPack
-- ----------------------------
DROP PROCEDURE IF EXISTS `GetInfoPack`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetInfoPack`(
	IN IdEnvio int(11)
)
BEGIN 
	SELECT
	pack.Id_Paquete AS IdPaquete,
	pack.Descripcion_Paquete AS Descripcion,
	EstPack.Nombre_EstadoPaquete AS Estado,
	CONCAT(cl_envia.Nombres_Cliente, ' ', cl_envia.Apellidos_Cliente) AS NombreRemitente,
	CONCAT(cl_recibe.Nombres_Cliente, ' ', cl_recibe.Apellidos_Cliente) AS NombreDestinatario,
	TRF.Valor_Tarifa AS Valor,
	pack.FechaRegistro_Paquete AS Fecha_Registro,
	IFNULL (pack.FechaEntrega , ' ') As Fecha_Entrega,
	CityOrigen.Nombre_Ciudad As CiudadOrigen,
	CityDestino.Nombre_Ciudad As CiudadDestino,
	IFNULL(CONCAT(USR.Nombres_usuario , ' ' , USR.Apellidos_Usuario), ' ') AS Mensajero
	FROM paquete pack
	INNER JOIN cliente cl_envia 
	ON pack.Id_ClienteEnvia = cl_envia.Id_Cliente
	INNER JOIN cliente cl_recibe
	ON pack.Id_ClienteRecibe = cl_recibe.Id_Cliente
	INNER JOIN estadopaquete EstPack
	ON pack.Id_EstadoPaquete = EstPack.Id_EstadoPaquete
	INNER JOIN tarifa TRF 
	ON pack.IdTarifa_Paquete = TRF.Id_Tarifa 
	INNER JOIN ciudad CityOrigen
	ON TRF.CiudadOrigen_Tarifa = CityOrigen.Id_Ciudad
	INNER JOIN ciudad CityDestino
	ON TRF.CiudadDestino_Tarifa = CityDestino.Id_Ciudad
	LEFT JOIN usuario USR
	ON USR.Id_Usuario = pack.Id_UsuarioMensajero
	WHERE 
	pack.Id_Paquete = IdEnvio;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for GetInfoUserLogin
-- ----------------------------
DROP PROCEDURE IF EXISTS `GetInfoUserLogin`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetInfoUserLogin`(
   In UserName varchar(150)
)
BEGIN 
	SELECT
	us.Id_Usuario AS Id,
	CONCAT(us.Nombres_Usuario, ' ', us.Apellidos_Usuario) AS Nombre,
  us.Documento_Usuario AS Documento,
	us.LlaveContrasenia_Usuario AS HashKey,
	us.Contrasenia_Usuario As PasswordUser,
	rol.Nombre_Rol As RolName,
	rol.Id_Rol as Rol,
	EsUs.Nombre_Estado As EstadoUsuario,
	EsUs.Id_Estado As IdEstadoUsuario
	FROM usuario us
	INNER JOIN rol 
	ON rol.Id_Rol = us.Rol_Usuario
	INNER JOIN estadousuario as EsUs
	ON EsUs.Id_Estado = us.Estado_Usuario
	WHERE 
	us.CorreoElectronico_Usuario = UserName;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for GetInfoUserSession
-- ----------------------------
DROP PROCEDURE IF EXISTS `GetInfoUserSession`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetInfoUserSession`( IN IdUser INT(11))
BEGIN
	SELECT
	Id_Usuario AS Id,
	Contrasenia_Usuario AS PasswordUser,
	LlaveContrasenia_Usuario AS HashKey
	FROM	
	usuario
	WHERE 
	Id_Usuario = IdUser;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for GetListClients
-- ----------------------------
DROP PROCEDURE IF EXISTS `GetListClients`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetListClients`()
BEGIN
	SELECT 
	Id_Cliente AS IdCliente,
	CONCAT(Nombres_Cliente, ' ', Apellidos_Cliente) AS NombresCliente,
	Documento_Cliente As Documento	
	FROM cliente;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for GetListEstadosPack
-- ----------------------------
DROP PROCEDURE IF EXISTS `GetListEstadosPack`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetListEstadosPack`()
BEGIN
	SELECT 
	EST.Id_EstadoPaquete AS Id,
	EST.Nombre_EstadoPaquete AS NombresEstado 
	FROM 
	estadopaquete EST;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for GetPacksByClient
-- ----------------------------
DROP PROCEDURE IF EXISTS `GetPacksByClient`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetPacksByClient`( In DocumentoCliente varchar(25) )
BEGIN 
	SELECT
	pack.Id_Paquete AS IdPaquete,
	pack.Descripcion_Paquete AS Descripcion,
	EstPack.Nombre_EstadoPaquete AS Estado,
	CONCAT(cl_envia.Nombres_Cliente, ' ', cl_envia.Apellidos_Cliente) AS NombreRemitente,
	CONCAT(cl_recibe.Nombres_Cliente, ' ', cl_recibe.Apellidos_Cliente) AS NombreDestinatario,
	TRF.Valor_Tarifa AS Valor,
	pack.FechaRegistro_Paquete AS Fecha_Registro,
	IFNULL (pack.FechaEntrega , ' ') As Fecha_Entrega,
	CityOrigen.Nombre_Ciudad As CiudadOrigen,
	CityDestino.Nombre_Ciudad As CiudadDestino
	FROM paquete pack
	INNER JOIN cliente cl_envia 
	ON pack.Id_ClienteEnvia = cl_envia.Id_Cliente
	INNER JOIN cliente cl_recibe
	ON pack.Id_ClienteRecibe = cl_recibe.Id_Cliente
	INNER JOIN estadopaquete EstPack
	ON pack.Id_EstadoPaquete = EstPack.Id_EstadoPaquete
	INNER JOIN tarifa TRF 
	ON pack.IdTarifa_Paquete = TRF.Id_Tarifa 
	INNER JOIN ciudad CityOrigen
	ON TRF.CiudadOrigen_Tarifa = CityOrigen.Id_Ciudad
	INNER JOIN ciudad CityDestino
	ON TRF.CiudadDestino_Tarifa = CityDestino.Id_Ciudad
	WHERE 
	cl_envia.Documento_Cliente = DocumentoCliente OR 
  cl_recibe.Documento_Cliente = DocumentoCliente ;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for GetStatusList
-- ----------------------------
DROP PROCEDURE IF EXISTS `GetStatusList`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetStatusList`()
BEGIN
	SELECT
	Id_Estado AS ID,
	Nombre_Estado AS Nombre
	FROM
	estadousuario;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for GetTarifaById
-- ----------------------------
DROP PROCEDURE IF EXISTS `GetTarifaById`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetTarifaById`(
	IN TarifaId int(11)
)
BEGIN
	SELECT
	Id_Tarifa AS Id,
	CiudadOrigen_Tarifa AS CiudadOrigen,
	CiudadDestino_Tarifa AS CiudadDestino,
	Valor_Tarifa AS ValorTarifa
	FROM tarifa 
	WHERE Id_Tarifa = TarifaId;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for GetTarifasList
-- ----------------------------
DROP PROCEDURE IF EXISTS `GetTarifasList`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetTarifasList`()
BEGIN
	SELECT 
	Tar.Id_Tarifa AS Id,
	CIU_OR.Nombre_Ciudad AS CiudadOrigen,
	CIU_DE.Nombre_Ciudad AS CiudadDestino,
	Tar.Valor_Tarifa AS Costo
	FROM	
	tarifa Tar
	INNER JOIN ciudad AS CIU_OR
	ON Tar.CiudadOrigen_Tarifa = CIU_OR.Id_Ciudad 
	INNER JOIN ciudad AS CIU_DE
	ON Tar.CiudadDestino_Tarifa = CIU_DE.Id_Ciudad
	ORDER BY CIU_OR.Nombre_Ciudad ASC, CIU_DE.Nombre_Ciudad ASC;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for GetUserRoles
-- ----------------------------
DROP PROCEDURE IF EXISTS `GetUserRoles`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetUserRoles`()
BEGIN
	SELECT 
	Id_Rol AS Id,
	Nombre_Rol AS Nombre
	FROM rol;	
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for GetUsersById
-- ----------------------------
DROP PROCEDURE IF EXISTS `GetUsersById`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetUsersById`( IN UserId INT(11))
BEGIN
	SELECT
	usr.Id_Usuario AS Id,
	usr.Nombres_Usuario AS NombreUsuario,
  usr.Apellidos_Usuario AS ApellidoUsuario,
	usr.Documento_Usuario AS Documento,
	usr.CorreoElectronico_Usuario AS Email,
	IF(usr.Telefono_Usuario = 0 , '' , usr.Telefono_Usuario)AS Telefono,
	rol.Id_Rol AS Rol,
	usr.Estado_Usuario AS IdEstado
  FROM usuario usr
	INNER JOIN rol 
	ON rol.Id_Rol = usr.Rol_Usuario
	INNER JOIN estadousuario EstUsr
	ON usr.Estado_Usuario = EstUsr.Id_Estado
	WHERE Id_Usuario = UserId;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for GetUsersList
-- ----------------------------
DROP PROCEDURE IF EXISTS `GetUsersList`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetUsersList`(IN IdUser int(11))
BEGIN 
	SELECT
	usr.Id_Usuario AS Id,
	CONCAT(usr.Nombres_Usuario, ' ', usr.Apellidos_Usuario) AS NombreUsuario,
	usr.Documento_Usuario AS Documento,
	usr.CorreoElectronico_Usuario AS Email,
	rol.Nombre_Rol AS Rol,
	usr.Estado_Usuario AS IdEstado,
	EstUsr.Nombre_Estado AS Estado
  FROM usuario usr
	INNER JOIN rol 
	ON rol.Id_Rol = usr.Rol_Usuario
	INNER JOIN estadousuario EstUsr
	ON usr.Estado_Usuario = EstUsr.Id_Estado
	WHERE Id_Usuario <> IdUser;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for InsertCliente
-- ----------------------------
DROP PROCEDURE IF EXISTS `InsertCliente`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `InsertCliente`(
	IN NombreCliente varchar(150),
	IN ApellidosCliente varchar(150),
	IN Documento varchar(25),
	IN TelefonoCliente BIGINT(20),
	IN DireccionCliente varchar(250),
	OUT IdCliente int(11)
)
BEGIN
	INSERT INTO cliente 
	(
		Nombres_Cliente,
		Apellidos_Cliente,
		Documento_Cliente,
		Telefono_Cliente,
		Direccion_Cliente
	)
	VALUES
	(
		NombreCliente, 
		ApellidosCliente,
		Documento,
		TelefonoCliente,
		DireccionCliente
	);

	SET IdCliente = LAST_INSERT_ID();
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for InsertEnvio
-- ----------------------------
DROP PROCEDURE IF EXISTS `InsertEnvio`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `InsertEnvio`(
	IN Remitente int(11),
	IN Destinatario int(11),
	IN UsuarioRegistra int(11),
	IN Descripcion varchar(250),
	IN Tarifa int(11)
)
BEGIN
	INSERT INTO paquete 
	(
		Id_ClienteEnvia,
		Id_ClienteRecibe,
		Id_UsuarioRegistro,
		Descripcion_Paquete,
		FechaRegistro_Paquete,
		IdTarifa_Paquete,
		Id_EstadoPaquete
	) 
	VALUES 
	(
		Remitente,
		Destinatario,
		UsuarioRegistra,
		Descripcion,
		NOW(),
		Tarifa,
		1
	);
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for InsertTarifa
-- ----------------------------
DROP PROCEDURE IF EXISTS `InsertTarifa`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `InsertTarifa`(
	IN CiudadOrigen int(11),
	IN CiudadDestino int(11),
	IN ValorTarifa double 
)
BEGIN
	INSERT INTO tarifa
  (
		CiudadOrigen_Tarifa,
		CiudadDestino_Tarifa,
		Valor_Tarifa
	)
	VALUES
	(
		CiudadOrigen,
		CiudadDestino,
		ValorTarifa
	);
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for InsertUser
-- ----------------------------
DROP PROCEDURE IF EXISTS `InsertUser`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `InsertUser`(
	IN NombreUsuario VARCHAR(25),
	IN ApellidoUsuario VARCHAR(25),
	IN Documento bigint(20),
	IN EmailUsuario VARCHAR(150),
	IN Contrasenia TEXT,
	IN TelefonoUsuario bigint(20),
	IN RolUsuario INT(11),
	IN HashKey TEXT
)
BEGIN
	INSERT INTO USUARIO
	(
		Nombres_Usuario ,
		Apellidos_Usuario ,
		Documento_Usuario ,
		CorreoElectronico_Usuario ,
		Contrasenia_Usuario ,
		Telefono_Usuario ,
		Rol_Usuario ,
		Estado_Usuario ,
		LlaveContrasenia_Usuario 
	)
	VALUES 
	(
		NombreUsuario, 
		ApellidoUsuario, 
		Documento, 
		EmailUsuario, 
		Contrasenia, 
		TelefonoUsuario, 
		RolUsuario, 
		1, 
		HashKey
	);
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for UpdateEnvio
-- ----------------------------
DROP PROCEDURE IF EXISTS `UpdateEnvio`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `UpdateEnvio`(
	IN IdEnvio int(11),
	IN Descripcion varchar(250),
	IN Tarifa int(11),
	IN EstadoPaquete int(11),
	IN Mensajero int(11)
)
BEGIN	
	DECLARE FECHA_ENTREGA DATETIME DEFAULT NULL;

	SET FECHA_ENTREGA = IF(EstadoPaquete = 6, NOW(), NULL);

	UPDATE paquete 
	SET 
	Descripcion_Paquete = Descripcion,
	IdTarifa_Paquete = Tarifa,
	Id_EstadoPaquete = EstadoPaquete,
	FechaEntrega = FECHA_ENTREGA,
	Id_UsuarioMensajero = Mensajero
	WHERE 
	Id_Paquete = IdEnvio;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for UpdateTarifa
-- ----------------------------
DROP PROCEDURE IF EXISTS `UpdateTarifa`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `UpdateTarifa`(
	IN IdTarifa int(11),
	IN CiudadOrigen int(11),
	IN CiudadDestino int(11),
	IN ValorTarifa double
)
BEGIN
	UPDATE tarifa 
	SET 
	CiudadOrigen_Tarifa = CiudadOrigen,
	CiudadDestino_Tarifa = CiudadDestino,
	Valor_Tarifa = ValorTarifa
	WHERE Id_Tarifa = IdTarifa;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for UpdateUser
-- ----------------------------
DROP PROCEDURE IF EXISTS `UpdateUser`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `UpdateUser`(IN `IdUsuario` INT(11), IN `NombreUsuario` VARCHAR(250), IN `ApellidoUsuario` VARCHAR(250), IN `Documento` BIGINT(20), IN `EmailUsuario` TEXT, IN `TelefonoUsuario` BIGINT(20), IN `RolUsuario` INT(11), IN `EstadoUsuario` INT(11))
    NO SQL
UPDATE
	usuario 
	SET
	Nombres_Usuario           = NombreUsuario,
	Apellidos_Usuario         = ApellidoUsuario,
	Documento_Usuario         = Documento,
	CorreoElectronico_Usuario = EmailUsuario,
	Telefono_Usuario          = TelefonoUsuario,
	Rol_Usuario               = RolUsuario,
	Estado_Usuario            = EstadoUsuario
	WHERE Id_Usuario = IdUsuario
;;
DELIMITER ;
