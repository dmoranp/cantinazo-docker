\connect cantinazo

CREATE TABLE public.cantina (
    id_cantina bigint NOT NULL,
    estado integer NOT NULL,
    fecha_fin_cantina timestamp without time zone,
    fecha_inicio_cantina timestamp without time zone,
    nombre_cantina character varying(255) NOT NULL,
    responsable bigint
);

CREATE TABLE public.catalogo (
    id_catalogo bigint NOT NULL,
    acronimo character varying(255),
    descripcion character varying(255) NOT NULL,
    estado integer NOT NULL,
    id_catalog_tipo bigint
);

CREATE TABLE public.catalogo_tipo (
    id_catalogo_tipo bigint NOT NULL,
    descripcion character varying(255) NOT NULL,
    estado integer NOT NULL
);

CREATE TABLE public.cliente (
    id_cliente bigint NOT NULL,
    apellido_materno character varying(100),
    apellido_paterno character varying(100),
    cedula character varying(10) NOT NULL,
    departamento character varying(255),
    email character varying(255),
    estado integer NOT NULL,
    primer_nombre character varying(100),
    segundo_nombre character varying(100),
    telefono character varying(255)
);

CREATE TABLE public.clientes_cantinas (
    id_cliente bigint NOT NULL,
    id_cantina bigint NOT NULL
);

CREATE TABLE public.existencia (
    id_existencia bigint NOT NULL,
    cantidad_inicial numeric(19,2) NOT NULL,
    comprometido numeric(19,2),
    costo_inicial double precision NOT NULL,
    costo_promedio double precision,
    estado character varying(255) NOT NULL,
    existencia numeric(19,0) NOT NULL,
    precio_costo double precision,
    precio_venta double precision,
    precio_venta_porc double precision,
    id_cantina bigint,
    id_producto bigint
);

CREATE TABLE public.imagen_cantina (
    id_imagen_cantina bigint NOT NULL,
    estado integer NOT NULL,
    fecha_subida timestamp without time zone,
    imagen_cantina bytea,
    nombre_archivo character varying(255),
    id_cantina bigint
);

CREATE TABLE public.imagen_perfil (
    id_imagen_perfil bigint NOT NULL,
    estado integer NOT NULL,
    fecha_subida timestamp without time zone,
    imagen_perfil bytea,
    nombre_archivo character varying(255),
    id_usuario bigint
);

CREATE TABLE public.imagen_producto (
    id_imagen_producto bigint NOT NULL,
    estado integer NOT NULL,
    fecha_creacion timestamp without time zone,
    imagen bytea,
    producto bigint
);

CREATE TABLE public.menu (
    id_menu bigint NOT NULL,
    estado integer NOT NULL,
    icono character varying(255),
    nombre character varying(255) NOT NULL,
    url character varying(255),
    id_modulo bigint,
    parent bigint
);

CREATE TABLE public.modulo (
    id_modulo bigint NOT NULL,
    descripcion character varying(255) NOT NULL,
    estado integer NOT NULL,
    icono character varying(255),
    nombre character varying(255) NOT NULL
);

CREATE TABLE public.movimiento (
    id_movimiento bigint NOT NULL,
    cambio double precision,
    concepto character varying(255) NOT NULL,
    efectivo double precision,
    facturador character varying(255) NOT NULL,
    fecha timestamp without time zone,
    observacion character varying(255),
    saldo double precision,
    tipo integer NOT NULL,
    valor double precision NOT NULL,
    id_cantina bigint,
    id_cliente bigint,
    id_responsable bigint
);

CREATE TABLE public.notificacion (
    id_notificacion bigint NOT NULL,
    detalle character varying(255),
    fecha timestamp without time zone,
    leido boolean,
    tipo integer NOT NULL,
    titulo character varying(255),
    id_cantina bigint,
    leido_por bigint,
    originado_por bigint
);

CREATE TABLE public.parametros_cantina (
    id_parametros_cantina bigint NOT NULL,
    ganancia_porcentaje character varying(255),
    ganancia_valor double precision,
    iva_porcentaje character varying(255),
    iva_valor double precision,
    redondear_multiplo_cinco boolean,
    id_cantina bigint
);

CREATE TABLE public.producto (
    id_producto bigint NOT NULL,
    codigo_barras character varying(255) NOT NULL,
    codigo_producto character varying(255) NOT NULL,
    estado integer NOT NULL,
    nombre_producto character varying(255) NOT NULL,
    id_cantina bigint
);

CREATE TABLE public.rol (
    id_rol bigint NOT NULL,
    descripcion character varying(255) NOT NULL,
    estado integer NOT NULL,
    nombre character varying(255) NOT NULL
);

CREATE TABLE public.roles_menus (
    id_menu bigint NOT NULL,
    id_rol bigint NOT NULL,
    create_permission boolean NOT NULL,
    delete_permission boolean NOT NULL,
    estado integer NOT NULL,
    print_permission boolean NOT NULL,
    read_permission boolean NOT NULL,
    update_permission boolean NOT NULL
);--

CREATE SEQUENCE public.seq_cantina
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

CREATE SEQUENCE public.seq_catalogo
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

CREATE SEQUENCE public.seq_catalogo_tipo
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

CREATE SEQUENCE public.seq_cliente
    START WITH 2
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

CREATE SEQUENCE public.seq_existencia
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

CREATE SEQUENCE public.seq_imagen_cantina
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

CREATE SEQUENCE public.seq_imagen_perfil
    START WITH 2
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

CREATE SEQUENCE public.seq_imagen_producto
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

CREATE SEQUENCE public.seq_menu
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

CREATE SEQUENCE public.seq_modulo
    START WITH 3
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

CREATE SEQUENCE public.seq_movimiento
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

CREATE SEQUENCE public.seq_notificacion
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

CREATE SEQUENCE public.seq_parametros_cantina
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

CREATE SEQUENCE public.seq_producto
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

CREATE SEQUENCE public.seq_rol
    START WITH 4
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

CREATE SEQUENCE public.seq_transaccion
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

CREATE SEQUENCE public.seq_transaccion_detalle
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

CREATE SEQUENCE public.seq_usuario
    START WITH 2
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

CREATE SEQUENCE public.seq_verificacion_token
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

CREATE TABLE public.transaccion (
    id_transaccion bigint NOT NULL,
    total double precision,
    total_descuento double precision,
    encargado character varying(255),
    estado integer,
    facturador character varying(255),
    fecha timestamp without time zone,
    fecha_factura timestamp without time zone,
    numero numeric(19,0),
    numero_factura character varying(255),
    observacion character varying(255),
    proveedor character varying(255),
    tipo integer,
    total_abono double precision,
    total_general double precision,
    total_iva double precision,
    total_saldo double precision,
    id_cantina bigint,
    id_cliente bigint
);


CREATE TABLE public.transaccion_detalle (
    id_transaccion_detalle bigint NOT NULL,
    abono double precision,
    cantidad_egreso numeric(19,0),
    cantidad_ingreso numeric(19,0),
    costo_egreso double precision,
    costo_ingreso double precision,
    costo_ingreso_unitario double precision,
    costo_promedio double precision,
    descuento character varying(255),
    descuento_porcentaje double precision,
    estado integer NOT NULL,
    existencia_detalle numeric(19,0),
    iva_porcentaje character varying(255),
    saldo double precision,
    si_iva boolean,
    sub_total double precision,
    total double precision,
    valor_descuento double precision,
    valor_iva double precision,
    id_existencia bigint,
    transaccion bigint
);

CREATE TABLE public.usuario (
    id_usuario bigint NOT NULL,
    estado integer NOT NULL,
    nombres character varying(150) NOT NULL,
    password character varying(50) NOT NULL,
    usuario character varying(50) NOT NULL,
    id_cliente bigint
);

CREATE TABLE public.usuarios_roles (
    id_cantina bigint NOT NULL,
    id_rol bigint NOT NULL,
    id_usuario bigint NOT NULL,
    estado integer NOT NULL
);

CREATE TABLE public.verificacion_token (
    id_verificacion_token bigint NOT NULL,
    codigo_generado character varying(255),
    fecha_caducidad timestamp without time zone,
    fecha_confirmacion timestamp without time zone,
    fecha_solicitud timestamp without time zone,
    mail_to character varying(255),
    verificado boolean,
    id_usuario bigint
);

INSERT INTO public.cantina (id_cantina, estado, fecha_fin_cantina, fecha_inicio_cantina, nombre_cantina, responsable) VALUES (1, 1, '2020-01-01 00:00:00', '2100-12-31 00:00:00', 'Cantina Máster', 1);



INSERT INTO public.cliente (id_cliente, apellido_materno, apellido_paterno, cedula, departamento, email, estado, primer_nombre, segundo_nombre, telefono) VALUES (1, '', 'System', '9999999999', '', 'noreply@cantinazo.app', 1, 'Admin', '', '1234567890');
INSERT INTO public.cliente (id_cliente, apellido_materno, apellido_paterno, cedula, departamento, email, estado, primer_nombre, segundo_nombre, telefono) VALUES (2, '', 'Final', '0000000000', '', 'noreply@cantinazo.app', 1, 'Consumidor', '', '000000000');


INSERT INTO public.clientes_cantinas (id_cliente, id_cantina) VALUES (1, 1);

INSERT INTO public.imagen_cantina (id_imagen_cantina, estado, fecha_subida, imagen_cantina, nombre_archivo, id_cantina) VALUES (1, 1, '2020-01-01 00:00:00', '\x696d616765626c6f62', 'image.ext', 1);

INSERT INTO public.imagen_perfil (id_imagen_perfil, estado, fecha_subida, imagen_perfil, nombre_archivo, id_usuario) VALUES (1, 1, '2020-01-01 00:00:00', '\x696d616765626c6f62', 'image.ext', 1);

INSERT INTO public.menu (id_menu, estado, icono, nombre, url, id_modulo, parent) VALUES (1, 1, 'security', 'Administración', NULL, 1, NULL);
INSERT INTO public.menu (id_menu, estado, icono, nombre, url, id_modulo, parent) VALUES (5, 1, 'settings_applications', 'Mantenimiento', NULL, 2, NULL);
INSERT INTO public.menu (id_menu, estado, icono, nombre, url, id_modulo, parent) VALUES (10, 1, 'list', 'Movimientos', NULL, 2, NULL);
INSERT INTO public.menu (id_menu, estado, icono, nombre, url, id_modulo, parent) VALUES (16, 1, 'picture_as_pdf', 'Reportes', NULL, 2, NULL);
INSERT INTO public.menu (id_menu, estado, icono, nombre, url, id_modulo, parent) VALUES (18, 1, 'shopping_cart', 'Mi cuenta', NULL, 2, NULL);
INSERT INTO public.menu (id_menu, estado, icono, nombre, url, id_modulo, parent) VALUES (2, 1, 'store', 'Cantinas', '/paginas/administracion/seguridad/cantinas.xhtml', 1, 1);
INSERT INTO public.menu (id_menu, estado, icono, nombre, url, id_modulo, parent) VALUES (3, 1, 'people', 'Usuarios', '/paginas/administracion/seguridad/usuarios.xhtml', 1, 1);
INSERT INTO public.menu (id_menu, estado, icono, nombre, url, id_modulo, parent) VALUES (4, 1, 'list', 'Catálogo', '/paginas/administracion/seguridad/catalogo.xhtml', 1, 1);
INSERT INTO public.menu (id_menu, estado, icono, nombre, url, id_modulo, parent) VALUES (6, 1, 'store', 'Mi Cantina', '/paginas/cantina/mantenimiento/cantina.xhtml', 2, 5);
INSERT INTO public.menu (id_menu, estado, icono, nombre, url, id_modulo, parent) VALUES (7, 1, 'assignment_ind', 'Clientes', '/paginas/cantina/mantenimiento/clientes.xhtml', 2, 5);
INSERT INTO public.menu (id_menu, estado, icono, nombre, url, id_modulo, parent) VALUES (8, 1, 'local_grocery_store', 'Productos', '/paginas/cantina/mantenimiento/productos.xhtml', 2, 5);
INSERT INTO public.menu (id_menu, estado, icono, nombre, url, id_modulo, parent) VALUES (9, 1, 'apps', 'Existencias', '/paginas/cantina/mantenimiento/existencias.xhtml', 2, 5);
INSERT INTO public.menu (id_menu, estado, icono, nombre, url, id_modulo, parent) VALUES (11, 1, 'add_shopping_cart', 'Punto de Venta', '/paginas/cantina/ventas/venta.xhtml', 2, 10);
INSERT INTO public.menu (id_menu, estado, icono, nombre, url, id_modulo, parent) VALUES (12, 1, 'monetization_on', 'Cobro de Créditos', '/paginas/cantina/cobros/cobros.xhtml', 2, 10);
INSERT INTO public.menu (id_menu, estado, icono, nombre, url, id_modulo, parent) VALUES (13, 1, 'import_export', 'Caja', '/paginas/cantina/movimientos/caja.xhtml', 2, 10);
INSERT INTO public.menu (id_menu, estado, icono, nombre, url, id_modulo, parent) VALUES (14, 1, 'input', 'Ingreso de Compra', '/paginas/cantina/movimientos/ingreso.factura.xhtml', 2, 10);
INSERT INTO public.menu (id_menu, estado, icono, nombre, url, id_modulo, parent) VALUES (15, 1, 'transfer_within_a_station', 'Despacho de Productos', '/paginas/cantina/movimientos/despacho.productos.xhtml', 2, 10);
INSERT INTO public.menu (id_menu, estado, icono, nombre, url, id_modulo, parent) VALUES (17, 1, 'web', 'Cobros', '/paginas/cantina/reportes/cobros.xhtml', 2, 16);
INSERT INTO public.menu (id_menu, estado, icono, nombre, url, id_modulo, parent) VALUES (19, 1, 'transfer_within_a_station', 'Mis consumos', '/paginas/cantina/ventas/mis.consumos.xhtml', 2, 18);

INSERT INTO public.modulo (id_modulo, descripcion, estado, icono, nombre) VALUES (1, 'Administración', 1, 'business_center', 'ADMI');
INSERT INTO public.modulo (id_modulo, descripcion, estado, icono, nombre) VALUES (2, 'Cantina', 1, 'shopping_cart', 'CANT');


INSERT INTO public.parametros_cantina (id_parametros_cantina, ganancia_porcentaje, ganancia_valor, iva_porcentaje, iva_valor, redondear_multiplo_cinco, id_cantina) VALUES (1, '0%', 0, '0%', 0, false, 1);

INSERT INTO public.rol (id_rol, descripcion, estado, nombre) VALUES (1, 'Devloper', 1, 'DEV');
INSERT INTO public.rol (id_rol, descripcion, estado, nombre) VALUES (2, 'Cantinero', 1, 'CAN');
INSERT INTO public.rol (id_rol, descripcion, estado, nombre) VALUES (3, 'Cliente', 1, 'CLI');

INSERT INTO public.roles_menus (id_menu, id_rol, create_permission, delete_permission, estado, print_permission, read_permission, update_permission) VALUES (2, 1, true, true, 1, true, true, true);
INSERT INTO public.roles_menus (id_menu, id_rol, create_permission, delete_permission, estado, print_permission, read_permission, update_permission) VALUES (3, 1, true, true, 1, true, true, true);
INSERT INTO public.roles_menus (id_menu, id_rol, create_permission, delete_permission, estado, print_permission, read_permission, update_permission) VALUES (4, 1, true, true, 1, true, true, true);
INSERT INTO public.roles_menus (id_menu, id_rol, create_permission, delete_permission, estado, print_permission, read_permission, update_permission) VALUES (6, 2, true, true, 1, true, true, true);
INSERT INTO public.roles_menus (id_menu, id_rol, create_permission, delete_permission, estado, print_permission, read_permission, update_permission) VALUES (7, 2, true, true, 1, true, true, true);
INSERT INTO public.roles_menus (id_menu, id_rol, create_permission, delete_permission, estado, print_permission, read_permission, update_permission) VALUES (8, 2, true, true, 1, true, true, true);
INSERT INTO public.roles_menus (id_menu, id_rol, create_permission, delete_permission, estado, print_permission, read_permission, update_permission) VALUES (9, 2, true, true, 1, true, true, true);
INSERT INTO public.roles_menus (id_menu, id_rol, create_permission, delete_permission, estado, print_permission, read_permission, update_permission) VALUES (11, 2, true, true, 1, true, true, true);
INSERT INTO public.roles_menus (id_menu, id_rol, create_permission, delete_permission, estado, print_permission, read_permission, update_permission) VALUES (12, 2, true, true, 1, true, true, true);
INSERT INTO public.roles_menus (id_menu, id_rol, create_permission, delete_permission, estado, print_permission, read_permission, update_permission) VALUES (13, 2, true, true, 1, true, true, true);
INSERT INTO public.roles_menus (id_menu, id_rol, create_permission, delete_permission, estado, print_permission, read_permission, update_permission) VALUES (14, 2, true, true, 1, true, true, true);
INSERT INTO public.roles_menus (id_menu, id_rol, create_permission, delete_permission, estado, print_permission, read_permission, update_permission) VALUES (15, 2, true, true, 1, true, true, true);
INSERT INTO public.roles_menus (id_menu, id_rol, create_permission, delete_permission, estado, print_permission, read_permission, update_permission) VALUES (17, 2, true, true, 1, true, true, true);
INSERT INTO public.roles_menus (id_menu, id_rol, create_permission, delete_permission, estado, print_permission, read_permission, update_permission) VALUES (19, 3, true, true, 1, true, true, true);


INSERT INTO public.usuario (id_usuario, estado, nombres, password, usuario, id_cliente) VALUES (1, 1, 'Administrador', 'ICy5YqxZB1uWSwcVLSNLcA==', 'admin', 1);
INSERT INTO public.usuario (id_usuario, estado, nombres, password, usuario, id_cliente) VALUES (2, 0, 'Consumidor Final', 'nopassword', 'nouser', 2);

INSERT INTO public.usuarios_roles (id_cantina, id_rol, id_usuario, estado) VALUES (1, 1, 1, 1);

SELECT pg_catalog.setval('public.seq_cantina', 2, true);


SELECT pg_catalog.setval('public.seq_catalogo', 1, false);

SELECT pg_catalog.setval('public.seq_catalogo_tipo', 1, false);


SELECT pg_catalog.setval('public.seq_cliente', 2, true);


SELECT pg_catalog.setval('public.seq_existencia', 1, true);


SELECT pg_catalog.setval('public.seq_imagen_cantina', 2, true);


SELECT pg_catalog.setval('public.seq_imagen_perfil', 2, true);

SELECT pg_catalog.setval('public.seq_imagen_producto', 1, true);

SELECT pg_catalog.setval('public.seq_menu', 1, false);

SELECT pg_catalog.setval('public.seq_modulo', 3, false);

SELECT pg_catalog.setval('public.seq_movimiento', 1, false);

SELECT pg_catalog.setval('public.seq_notificacion', 1, false);


SELECT pg_catalog.setval('public.seq_parametros_cantina', 1, true);


SELECT pg_catalog.setval('public.seq_producto', 1, true);


SELECT pg_catalog.setval('public.seq_rol', 4, false);


SELECT pg_catalog.setval('public.seq_transaccion', 1, false);


SELECT pg_catalog.setval('public.seq_transaccion_detalle', 1, false);


SELECT pg_catalog.setval('public.seq_usuario', 2, true);

SELECT pg_catalog.setval('public.seq_verificacion_token', 1, false);

ALTER TABLE ONLY public.cantina
    ADD CONSTRAINT cantina_pkey PRIMARY KEY (id_cantina);


--
-- TOC entry 3215 (class 2606 OID 27782)
-- Name: catalogo catalogo_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.catalogo
    ADD CONSTRAINT catalogo_pkey PRIMARY KEY (id_catalogo);


--
-- TOC entry 3217 (class 2606 OID 27787)
-- Name: catalogo_tipo catalogo_tipo_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.catalogo_tipo
    ADD CONSTRAINT catalogo_tipo_pkey PRIMARY KEY (id_catalogo_tipo);


--
-- TOC entry 3195 (class 2606 OID 27708)
-- Name: cliente cliente_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cliente
    ADD CONSTRAINT cliente_pkey PRIMARY KEY (id_cliente);


--
-- TOC entry 3197 (class 2606 OID 27713)
-- Name: existencia existencia_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.existencia
    ADD CONSTRAINT existencia_pkey PRIMARY KEY (id_existencia);


--
-- TOC entry 3219 (class 2606 OID 27798)
-- Name: imagen_cantina imagen_cantina_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.imagen_cantina
    ADD CONSTRAINT imagen_cantina_pkey PRIMARY KEY (id_imagen_cantina);


--
-- TOC entry 3221 (class 2606 OID 27806)
-- Name: imagen_perfil imagen_perfil_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.imagen_perfil
    ADD CONSTRAINT imagen_perfil_pkey PRIMARY KEY (id_imagen_perfil);


--
-- TOC entry 3223 (class 2606 OID 27814)
-- Name: imagen_producto imagen_producto_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.imagen_producto
    ADD CONSTRAINT imagen_producto_pkey PRIMARY KEY (id_imagen_producto);


--
-- TOC entry 3225 (class 2606 OID 27822)
-- Name: menu menu_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.menu
    ADD CONSTRAINT menu_pkey PRIMARY KEY (id_menu);


--
-- TOC entry 3227 (class 2606 OID 27830)
-- Name: modulo modulo_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.modulo
    ADD CONSTRAINT modulo_pkey PRIMARY KEY (id_modulo);


--
-- TOC entry 3199 (class 2606 OID 27721)
-- Name: movimiento movimiento_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.movimiento
    ADD CONSTRAINT movimiento_pkey PRIMARY KEY (id_movimiento);


--
-- TOC entry 3201 (class 2606 OID 27729)
-- Name: notificacion notificacion_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.notificacion
    ADD CONSTRAINT notificacion_pkey PRIMARY KEY (id_notificacion);


--
-- TOC entry 3203 (class 2606 OID 27737)
-- Name: parametros_cantina parametros_cantina_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.parametros_cantina
    ADD CONSTRAINT parametros_cantina_pkey PRIMARY KEY (id_parametros_cantina);


--
-- TOC entry 3205 (class 2606 OID 27745)
-- Name: producto producto_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.producto
    ADD CONSTRAINT producto_pkey PRIMARY KEY (id_producto);


--
-- TOC entry 3229 (class 2606 OID 27838)
-- Name: rol rol_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.rol
    ADD CONSTRAINT rol_pkey PRIMARY KEY (id_rol);


--
-- TOC entry 3231 (class 2606 OID 27843)
-- Name: roles_menus roles_menus_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.roles_menus
    ADD CONSTRAINT roles_menus_pkey PRIMARY KEY (id_menu, id_rol);


--
-- TOC entry 3209 (class 2606 OID 27761)
-- Name: transaccion_detalle transaccion_detalle_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.transaccion_detalle
    ADD CONSTRAINT transaccion_detalle_pkey PRIMARY KEY (id_transaccion_detalle);


--
-- TOC entry 3207 (class 2606 OID 27753)
-- Name: transaccion transaccion_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.transaccion
    ADD CONSTRAINT transaccion_pkey PRIMARY KEY (id_transaccion);


--
-- TOC entry 3211 (class 2606 OID 27766)
-- Name: usuario usuario_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.usuario
    ADD CONSTRAINT usuario_pkey PRIMARY KEY (id_usuario);


--
-- TOC entry 3233 (class 2606 OID 27848)
-- Name: usuarios_roles usuarios_roles_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.usuarios_roles
    ADD CONSTRAINT usuarios_roles_pkey PRIMARY KEY (id_cantina, id_rol, id_usuario);


--
-- TOC entry 3213 (class 2606 OID 27774)
-- Name: verificacion_token verificacion_token_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.verificacion_token
    ADD CONSTRAINT verificacion_token_pkey PRIMARY KEY (id_verificacion_token);


--
-- TOC entry 3262 (class 2606 OID 28027)
-- Name: usuarios_roles fk16t9ctari5blsr2tlyv0mbh4n; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.usuarios_roles
    ADD CONSTRAINT fk16t9ctari5blsr2tlyv0mbh4n FOREIGN KEY (id_rol) REFERENCES public.rol(id_rol);


--
-- TOC entry 3247 (class 2606 OID 27952)
-- Name: transaccion_detalle fk2oss7e1c020kig8rqjks1yuu8; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.transaccion_detalle
    ADD CONSTRAINT fk2oss7e1c020kig8rqjks1yuu8 FOREIGN KEY (id_existencia) REFERENCES public.existencia(id_existencia);


--
-- TOC entry 3254 (class 2606 OID 27987)
-- Name: imagen_cantina fk3lm5c0bf8ir5yp5nmtrm0p7k4; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.imagen_cantina
    ADD CONSTRAINT fk3lm5c0bf8ir5yp5nmtrm0p7k4 FOREIGN KEY (id_cantina) REFERENCES public.cantina(id_cantina);


--
-- TOC entry 3258 (class 2606 OID 28007)
-- Name: menu fk7pl0e1gmqbk4hy5wm4a7e9xvn; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.menu
    ADD CONSTRAINT fk7pl0e1gmqbk4hy5wm4a7e9xvn FOREIGN KEY (parent) REFERENCES public.menu(id_menu);


--
-- TOC entry 3261 (class 2606 OID 28022)
-- Name: usuarios_roles fk8h53cx0ccoot0j77j7g6nki3k; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.usuarios_roles
    ADD CONSTRAINT fk8h53cx0ccoot0j77j7g6nki3k FOREIGN KEY (id_cantina) REFERENCES public.cantina(id_cantina);


--
-- TOC entry 3251 (class 2606 OID 27972)
-- Name: catalogo fk_catalogo_tipo; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.catalogo
    ADD CONSTRAINT fk_catalogo_tipo FOREIGN KEY (id_catalog_tipo) REFERENCES public.catalogo_tipo(id_catalogo_tipo);


--
-- TOC entry 3235 (class 2606 OID 27892)
-- Name: existencia fk_existencia_cantina; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.existencia
    ADD CONSTRAINT fk_existencia_cantina FOREIGN KEY (id_cantina) REFERENCES public.cantina(id_cantina);


--
-- TOC entry 3244 (class 2606 OID 27937)
-- Name: producto fk_existencia_cantina; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.producto
    ADD CONSTRAINT fk_existencia_cantina FOREIGN KEY (id_cantina) REFERENCES public.cantina(id_cantina);


--
-- TOC entry 3236 (class 2606 OID 27897)
-- Name: existencia fk_existencia_producto; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.existencia
    ADD CONSTRAINT fk_existencia_producto FOREIGN KEY (id_producto) REFERENCES public.producto(id_producto);


--
-- TOC entry 3257 (class 2606 OID 28002)
-- Name: menu fk_modulo_menu; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.menu
    ADD CONSTRAINT fk_modulo_menu FOREIGN KEY (id_modulo) REFERENCES public.modulo(id_modulo);


--
-- TOC entry 3237 (class 2606 OID 27902)
-- Name: movimiento fk_movimiento_cantina; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.movimiento
    ADD CONSTRAINT fk_movimiento_cantina FOREIGN KEY (id_cantina) REFERENCES public.cantina(id_cantina);


--
-- TOC entry 3238 (class 2606 OID 27907)
-- Name: movimiento fk_movimiento_cliente; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.movimiento
    ADD CONSTRAINT fk_movimiento_cliente FOREIGN KEY (id_cliente) REFERENCES public.cliente(id_cliente);


--
-- TOC entry 3239 (class 2606 OID 27912)
-- Name: movimiento fk_movimiento_responsable; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.movimiento
    ADD CONSTRAINT fk_movimiento_responsable FOREIGN KEY (id_responsable) REFERENCES public.cliente(id_cliente);


--
-- TOC entry 3240 (class 2606 OID 27917)
-- Name: notificacion fk_notificacion_cantina; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.notificacion
    ADD CONSTRAINT fk_notificacion_cantina FOREIGN KEY (id_cantina) REFERENCES public.cantina(id_cantina);


--
-- TOC entry 3241 (class 2606 OID 27922)
-- Name: notificacion fk_notificacion_leido_usuario; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.notificacion
    ADD CONSTRAINT fk_notificacion_leido_usuario FOREIGN KEY (leido_por) REFERENCES public.usuario(id_usuario);


--
-- TOC entry 3242 (class 2606 OID 27927)
-- Name: notificacion fk_notificacion_originado_usuario; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.notificacion
    ADD CONSTRAINT fk_notificacion_originado_usuario FOREIGN KEY (originado_por) REFERENCES public.usuario(id_usuario);


--
-- TOC entry 3256 (class 2606 OID 27997)
-- Name: imagen_producto fk_producto; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.imagen_producto
    ADD CONSTRAINT fk_producto FOREIGN KEY (producto) REFERENCES public.producto(id_producto);


--
-- TOC entry 3234 (class 2606 OID 27887)
-- Name: cantina fk_responsable; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cantina
    ADD CONSTRAINT fk_responsable FOREIGN KEY (responsable) REFERENCES public.cliente(id_cliente);


--
-- TOC entry 3248 (class 2606 OID 27957)
-- Name: transaccion_detalle fk_transaccion; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.transaccion_detalle
    ADD CONSTRAINT fk_transaccion FOREIGN KEY (transaccion) REFERENCES public.transaccion(id_transaccion);


--
-- TOC entry 3245 (class 2606 OID 27942)
-- Name: transaccion fk_transaccion_cantina; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.transaccion
    ADD CONSTRAINT fk_transaccion_cantina FOREIGN KEY (id_cantina) REFERENCES public.cantina(id_cantina);


--
-- TOC entry 3246 (class 2606 OID 27947)
-- Name: transaccion fk_transaccion_cliente; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.transaccion
    ADD CONSTRAINT fk_transaccion_cliente FOREIGN KEY (id_cliente) REFERENCES public.cliente(id_cliente);


--
-- TOC entry 3263 (class 2606 OID 28032)
-- Name: usuarios_roles fkdmgx7atyhfl7fku8egpmx65cw; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.usuarios_roles
    ADD CONSTRAINT fkdmgx7atyhfl7fku8egpmx65cw FOREIGN KEY (id_usuario) REFERENCES public.usuario(id_usuario);


--
-- TOC entry 3243 (class 2606 OID 27932)
-- Name: parametros_cantina fke5rgghmdpc63xbhiokvanca3g; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.parametros_cantina
    ADD CONSTRAINT fke5rgghmdpc63xbhiokvanca3g FOREIGN KEY (id_cantina) REFERENCES public.cantina(id_cantina);


--
-- TOC entry 3252 (class 2606 OID 27977)
-- Name: clientes_cantinas fkggy3ae040q07cpd84549qbk1j; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.clientes_cantinas
    ADD CONSTRAINT fkggy3ae040q07cpd84549qbk1j FOREIGN KEY (id_cantina) REFERENCES public.cantina(id_cantina);


--
-- TOC entry 3259 (class 2606 OID 28012)
-- Name: roles_menus fkh3glirtv2bx4ck8b5j1al8tdn; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.roles_menus
    ADD CONSTRAINT fkh3glirtv2bx4ck8b5j1al8tdn FOREIGN KEY (id_menu) REFERENCES public.menu(id_menu);


--
-- TOC entry 3255 (class 2606 OID 27992)
-- Name: imagen_perfil fkhic3clv4su02btaxeqrjq5ahd; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.imagen_perfil
    ADD CONSTRAINT fkhic3clv4su02btaxeqrjq5ahd FOREIGN KEY (id_usuario) REFERENCES public.usuario(id_usuario);


--
-- TOC entry 3250 (class 2606 OID 27967)
-- Name: verificacion_token fkhmysrujnoawvqfc87ye5msyrp; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.verificacion_token
    ADD CONSTRAINT fkhmysrujnoawvqfc87ye5msyrp FOREIGN KEY (id_usuario) REFERENCES public.usuario(id_usuario);


--
-- TOC entry 3249 (class 2606 OID 27962)
-- Name: usuario fkhnhbeu7rhg1k2lip1jxomdwhs; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.usuario
    ADD CONSTRAINT fkhnhbeu7rhg1k2lip1jxomdwhs FOREIGN KEY (id_cliente) REFERENCES public.cliente(id_cliente);


--
-- TOC entry 3260 (class 2606 OID 28017)
-- Name: roles_menus fkntdhnw60kx7x8pmgukdu4032t; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.roles_menus
    ADD CONSTRAINT fkntdhnw60kx7x8pmgukdu4032t FOREIGN KEY (id_rol) REFERENCES public.rol(id_rol);


--
-- TOC entry 3253 (class 2606 OID 27982)
-- Name: clientes_cantinas fks83bvuea8gdgvqsceol8mu7j9; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.clientes_cantinas
    ADD CONSTRAINT fks83bvuea8gdgvqsceol8mu7j9 FOREIGN KEY (id_cliente) REFERENCES public.cliente(id_cliente);

