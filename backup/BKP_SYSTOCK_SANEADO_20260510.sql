--
-- PostgreSQL database dump
--

\restrict 4quBi9awX3DSxB1WwA57zJ0FVN93pilZcr3ZgeriiXBSTslHlXAAd1Ro1sud4kz

-- Dumped from database version 17.7 (Ubuntu 17.7-0ubuntu0.25.04.1)
-- Dumped by pg_dump version 17.7 (Ubuntu 17.7-0ubuntu0.25.04.1)

-- Started on 2026-05-13 23:05:53 -04

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 224 (class 1255 OID 16569)
-- Name: fn_vincular_fornecedor_auto(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.fn_vincular_fornecedor_auto() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    -- Extrai apenas os dígitos numéricos da string do fornecedor
    -- Exemplo: 'F10' vira 10
    NEW.idfornecedor_num := (substring(NEW.idfornecedor FROM '[0-9]+'))::INTEGER;
    RETURN NEW;
END;
$$;


ALTER FUNCTION public.fn_vincular_fornecedor_auto() OWNER TO postgres;

--
-- TOC entry 223 (class 1255 OID 16517)
-- Name: func_gera_id(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.func_gera_id() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    -- Corrigindo de idfonecedor para idfornecedor
    NEW.idfornecedor = nextval('seq_id_fornecedor');
    RETURN NEW;
END;
$$;


ALTER FUNCTION public.func_gera_id() OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 221 (class 1259 OID 16491)
-- Name: entradas_mercadoria; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.entradas_mercadoria (
    data_entrada date,
    nro_nfe character varying(255) NOT NULL,
    item double precision NOT NULL,
    produto_id character varying(25) NOT NULL,
    descricao_produto character varying(255),
    qtde_recebida double precision,
    filial_id integer,
    custo_unitario numeric(12,4) DEFAULT 0 NOT NULL,
    ordem_compra double precision NOT NULL
);


ALTER TABLE public.entradas_mercadoria OWNER TO postgres;

--
-- TOC entry 217 (class 1259 OID 16445)
-- Name: fornecedor; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.fornecedor (
    idfornecedor character varying(25) NOT NULL,
    razao_social character varying(255) NOT NULL
);


ALTER TABLE public.fornecedor OWNER TO postgres;

--
-- TOC entry 220 (class 1259 OID 16478)
-- Name: pedido_compra; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.pedido_compra (
    pedido_id double precision NOT NULL,
    data_pedido date,
    item double precision NOT NULL,
    produto_id character varying(25) NOT NULL,
    descricao_produto character varying(255),
    ordem_compra double precision NOT NULL,
    qtde_pedida double precision,
    filial_id integer,
    data_entrega date,
    qtde_entregue double precision DEFAULT 0 NOT NULL,
    qtde_pendente double precision DEFAULT 0 NOT NULL,
    preco_compra double precision DEFAULT 0,
    fornecedor_id character varying(25)
);


ALTER TABLE public.pedido_compra OWNER TO postgres;

--
-- TOC entry 218 (class 1259 OID 16450)
-- Name: produtos_filial; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.produtos_filial (
    filial_id integer NOT NULL,
    produto_id character varying(25) NOT NULL,
    descricao character varying(255) NOT NULL,
    estoque double precision DEFAULT 0 NOT NULL,
    preco_unitario double precision DEFAULT 0 NOT NULL,
    preco_compra double precision DEFAULT 0 NOT NULL,
    preco_venda double precision DEFAULT 0 NOT NULL,
    idfornecedor character varying(25),
    idfornecedor_num integer
);


ALTER TABLE public.produtos_filial OWNER TO postgres;

--
-- TOC entry 222 (class 1259 OID 16516)
-- Name: seq_id_fornecedor; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seq_id_fornecedor
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.seq_id_fornecedor OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 16464)
-- Name: venda; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.venda (
    venda_id bigint NOT NULL,
    data_emissao date NOT NULL,
    horariomov character varying(8) DEFAULT '00:00:00'::character varying NOT NULL,
    produto_id character varying(25) NOT NULL,
    qtde_vendida double precision,
    valor_unitario numeric(12,4) DEFAULT 0 NOT NULL,
    filial_id integer DEFAULT 1 NOT NULL,
    item integer DEFAULT 0 NOT NULL,
    unidade_medida character varying(3)
);


ALTER TABLE public.venda OWNER TO postgres;

--
-- TOC entry 3505 (class 0 OID 16491)
-- Dependencies: 221
-- Data for Name: entradas_mercadoria; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.entradas_mercadoria (data_entrada, nro_nfe, item, produto_id, descricao_produto, qtde_recebida, filial_id, custo_unitario, ordem_compra) FROM stdin;
2025-02-27	NFE1	1	P1	Produto 1	77	1	8435.0000	1
2025-01-20	NFE2	1	P2	Produto 2	64	1	1666.0000	2
2025-02-18	NFE3	1	P3	Produto 3	88	1	9036.0000	3
2025-02-12	NFE4	1	P4	Produto 4	4	1	8468.0000	4
2025-02-19	NFE5	1	P5	Produto 5	95	1	9899.0000	5
2025-02-08	NFE6	1	P6	Produto 6	41	1	9029.0000	6
2025-01-03	NFE7	1	P7	Produto 7	75	1	2722.0000	7
2025-02-21	NFE8	1	P8	Produto 8	25	1	711.0000	8
2025-02-13	NFE9	1	P9	Produto 9	57	1	1955.0000	9
2025-03-01	NFE10	1	P10	Produto 10	7	1	5439.0000	10
2025-01-23	NFE11	1	P11	Produto 11	85	1	9189.0000	11
2025-01-02	NFE12	1	P12	Produto 12	12	1	3853.0000	12
2025-02-20	NFE13	1	P13	Produto 13	7	1	6086.0000	13
2025-01-10	NFE14	1	P14	Produto 14	92	1	3848.0000	14
2025-01-13	NFE15	1	P15	Produto 15	68	1	9558.0000	15
2025-01-22	NFE16	1	P16	Produto 16	89	1	3946.0000	16
2025-02-24	NFE17	1	P17	Produto 17	10	1	1032.0000	17
2025-01-31	NFE18	1	P18	Produto 18	48	1	6256.0000	18
2025-02-13	NFE19	1	P19	Produto 19	64	1	8454.0000	19
2025-01-01	NFE20	1	P20	Produto 20	6	1	657.0000	20
\.


--
-- TOC entry 3501 (class 0 OID 16445)
-- Dependencies: 217
-- Data for Name: fornecedor; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.fornecedor (idfornecedor, razao_social) FROM stdin;
F1	Fornecedor 1 LTDA
F2	Fornecedor 2 LTDA
F3	Fornecedor 3 LTDA
F4	Fornecedor 4 LTDA
F5	Fornecedor 5 LTDA
F6	Fornecedor 6 LTDA
F7	Fornecedor 7 LTDA
F8	Fornecedor 8 LTDA
F9	Fornecedor 9 LTDA
F10	Fornecedor 10 LTDA
F11	Fornecedor 11 LTDA
F12	Fornecedor 12 LTDA
F13	Fornecedor 13 LTDA
F14	Fornecedor 14 LTDA
F15	Fornecedor 15 LTDA
F16	Fornecedor 16 LTDA
F17	Fornecedor 17 LTDA
F18	Fornecedor 18 LTDA
F19	Fornecedor 19 LTDA
F20	Fornecedor 20 LTDA
\.


--
-- TOC entry 3504 (class 0 OID 16478)
-- Dependencies: 220
-- Data for Name: pedido_compra; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.pedido_compra (pedido_id, data_pedido, item, produto_id, descricao_produto, ordem_compra, qtde_pedida, filial_id, data_entrega, qtde_entregue, qtde_pendente, preco_compra, fornecedor_id) FROM stdin;
1	2025-01-02	1	P1	Produto 1	1	96	1	2025-02-27	10	0	4667	1
2	2025-01-07	1	P2	Produto 2	2	14	1	2025-01-07	7	0	7732	2
3	2025-01-05	1	P3	Produto 3	3	12	1	2025-01-03	2	0	4782	3
4	2025-01-22	1	P4	Produto 4	4	27	1	2025-01-28	3	0	4957	4
5	2025-01-28	1	P5	Produto 5	5	35	1	2025-02-28	12	0	5718	5
6	2025-02-22	1	P6	Produto 6	6	98	1	2025-01-05	55	0	5996	6
7	2025-03-01	1	P7	Produto 7	7	34	1	2025-02-01	29	0	4922	7
8	2025-02-02	1	P8	Produto 8	8	29	1	2025-02-14	24	0	3588	8
9	2025-01-15	1	P9	Produto 9	9	57	1	2025-01-28	34	0	2848	9
10	2025-01-09	1	P10	Produto 10	10	49	1	2025-02-09	4	0	4286	10
11	2025-02-22	1	P11	Produto 11	11	24	1	2025-01-08	12	0	1482	11
12	2025-02-25	1	P12	Produto 12	12	91	1	2025-02-20	48	0	692	12
13	2025-02-23	1	P13	Produto 13	13	99	1	2025-02-02	91	0	6544	13
14	2025-01-21	1	P14	Produto 14	14	96	1	2025-01-01	27	0	2191	14
15	2025-02-04	1	P15	Produto 15	15	45	1	2025-01-04	1	0	8504	15
16	2025-02-27	1	P16	Produto 16	16	84	1	2025-01-14	51	0	6417	16
17	2025-01-08	1	P17	Produto 17	17	22	1	2025-01-19	7	0	7455	17
18	2025-02-17	1	P18	Produto 18	18	63	1	2025-01-02	17	0	2494	18
19	2025-02-19	1	P19	Produto 19	0	20	1	2025-01-08	0	0	2221	19
20	2025-02-10	1	P20	Produto 20	0	25	1	2025-01-15	0	0	3851	20
21	2025-02-25	1	P12	Produto 12	0	12	1	2025-02-20	0	0	692	12
22	2025-02-23	1	P13	Produto 13	0	4	1	2025-02-02	0	0	6544	13
23	2025-01-21	1	P14	Produto 14	0	6	1	2025-01-01	0	0	2191	14
24	2025-02-04	1	P15	Produto 15	0	8	1	2025-01-04	0	0	8504	15
25	2025-02-27	1	P16	Produto 16	0	9	1	2025-01-14	0	0	6417	16
26	2025-01-08	1	P17	Produto 17	0	4	1	2025-01-19	0	0	7455	17
27	2025-02-17	1	P18	Produto 18	0	3	1	2025-01-02	0	0	2494	18
28	2025-02-19	1	P19	Produto 19	0	3	1	2025-01-08	0	0	2221	19
29	2025-02-10	1	P20	Produto 20	0	2	1	2025-01-15	0	0	3851	20
\.


--
-- TOC entry 3502 (class 0 OID 16450)
-- Dependencies: 218
-- Data for Name: produtos_filial; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.produtos_filial (filial_id, produto_id, descricao, estoque, preco_unitario, preco_compra, preco_venda, idfornecedor, idfornecedor_num) FROM stdin;
1	P1	Produto 1	88	4265	14413	4079	F8	8
1	P2	Produto 2	28	7952	10356	17418	F9	9
1	P3	Produto 3	40	1195	2414	6069	F10	10
1	P4	Produto 4	73	8967	775	2265	F11	11
1	P5	Produto 5	97	13599	3618	8992	F12	12
1	P6	Produto 6	38	16131	5537	956	F13	13
1	P7	Produto 7	131	15382	1404	4664	F7	7
1	P8	Produto 8	71	14057	1495	9528	F17	17
1	P9	Produto 9	2	3088	137	16432	F18	18
1	P10	Produto 10	38	11571	2777	877	F19	19
1	P11	Produto 11	154	14799	2939	4495	F1	1
1	P12	Produto 12	78	3247	6463	27658	F2	2
1	P13	Produto 13	79	19404	583	9905	F3	3
1	P14	Produto 14	9	19956	568	8074	F4	4
1	P15	Produto 15	131	10115	1076	2924	F5	5
1	P16	Produto 16	177	2464	7594	27888	F6	6
1	P17	Produto 17	105	19563	12625	18392	F7	7
1	P18	Produto 18	198	1622	13412	10561	F18	18
1	P19	Produto 19	148	18436	12169	23458	F19	19
1	P20	Produto 20	196	5204	12487	15793	F20	20
\.


--
-- TOC entry 3503 (class 0 OID 16464)
-- Dependencies: 219
-- Data for Name: venda; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.venda (venda_id, data_emissao, horariomov, produto_id, qtde_vendida, valor_unitario, filial_id, item, unidade_medida) FROM stdin;
4	2025-01-10	08:00:00	P4	3.86	139.7100	1	1	UN
8	2025-01-26	08:00:00	P8	20.04	51.3700	1	1	UN
12	2025-01-21	08:00:00	P12	2.86	13.6400	1	1	UN
16	2025-02-17	08:00:00	P16	37.11	14.4100	1	1	UN
26	2025-02-18	08:00:00	P26	3.11	185.2300	1	1	UN
1	2025-01-11	08:00:00	P1	0.5	78.9300	1	1	UN
2	2025-03-02	08:00:00	P2	0.7000000000000001	92.9600	1	1	UN
3	2025-01-28	08:00:00	P3	0.8999999999999999	197.6100	1	1	UN
5	2025-01-11	08:00:00	P5	0.3	126.7900	1	1	UN
6	2025-01-24	08:00:00	P6	0.2	36.8300	1	1	UN
7	2025-02-22	08:00:00	P7	0.5	40.7500	1	1	UN
9	2025-01-17	08:00:00	P9	0.6	172.5500	1	1	UN
10	2025-01-03	08:00:00	P10	9	44.2200	1	1	UN
11	2025-01-08	08:00:00	P11	0.6	190.3700	1	1	UN
13	2025-01-24	08:00:00	P13	1.3	61.8500	1	1	UN
14	2025-02-07	08:00:00	P14	5.300000000000001	10.6300	1	1	UN
15	2025-02-20	08:00:00	P15	2.7	4.3400	1	1	UN
17	2025-02-22	08:00:00	P17	0.3	13.9800	1	1	UN
18	2025-02-18	08:00:00	P18	0.5	185.2300	1	1	UN
19	2025-02-20	08:00:00	P19	1	182.5100	1	1	UN
20	2025-02-28	08:00:00	P20	0.2	68.5400	1	1	UN
21	2025-01-24	08:00:00	P21	2.5	61.8500	1	1	UN
22	2025-02-07	08:00:00	P22	0.6	10.6300	1	1	UN
23	2025-02-20	08:00:00	P23	0.7000000000000001	4.3400	1	1	UN
24	2025-02-17	08:00:00	P24	0.4	14.4100	1	1	UN
25	2025-02-22	08:00:00	P25	0.8	13.9800	1	1	UN
27	2025-02-20	08:00:00	P27	0.3	182.5100	2	1	UN
28	2025-03-28	08:00:00	P28	0.6	68.5400	3	1	UN
29	2025-03-17	08:00:00	P24	0.5	14.4100	1	1	UN
30	2025-03-22	08:00:00	P25	0.3	13.9800	1	1	UN
31	2025-03-18	08:00:00	P26	0.4	185.2300	1	1	UN
32	2025-03-20	08:00:00	P27	0.2	182.5100	2	1	UN
33	2025-03-28	08:00:00	P28	0.1	68.5400	3	1	UN
\.


--
-- TOC entry 3512 (class 0 OID 0)
-- Dependencies: 222
-- Name: seq_id_fornecedor; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seq_id_fornecedor', 6, true);


--
-- TOC entry 3351 (class 2606 OID 16498)
-- Name: entradas_mercadoria entradas_mercadoria_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.entradas_mercadoria
    ADD CONSTRAINT entradas_mercadoria_pkey PRIMARY KEY (ordem_compra, item, produto_id, nro_nfe);


--
-- TOC entry 3343 (class 2606 OID 16449)
-- Name: fornecedor fornecedor_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fornecedor
    ADD CONSTRAINT fornecedor_pkey PRIMARY KEY (idfornecedor);


--
-- TOC entry 3349 (class 2606 OID 16485)
-- Name: pedido_compra pedido_compra_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pedido_compra
    ADD CONSTRAINT pedido_compra_pkey PRIMARY KEY (pedido_id, produto_id, item);


--
-- TOC entry 3347 (class 2606 OID 16472)
-- Name: venda pk_consumo; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.venda
    ADD CONSTRAINT pk_consumo PRIMARY KEY (filial_id, venda_id, data_emissao, produto_id, item, horariomov);


--
-- TOC entry 3345 (class 2606 OID 16458)
-- Name: produtos_filial produtos_filial_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.produtos_filial
    ADD CONSTRAINT produtos_filial_pkey PRIMARY KEY (filial_id, produto_id);


--
-- TOC entry 3354 (class 2620 OID 16518)
-- Name: produtos_filial trg_auto_id; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER trg_auto_id BEFORE INSERT ON public.produtos_filial FOR EACH ROW EXECUTE FUNCTION public.func_gera_id();


--
-- TOC entry 3355 (class 2620 OID 16570)
-- Name: produtos_filial trg_limpar_id_fornecedor; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER trg_limpar_id_fornecedor BEFORE INSERT OR UPDATE ON public.produtos_filial FOR EACH ROW EXECUTE FUNCTION public.fn_vincular_fornecedor_auto();


--
-- TOC entry 3353 (class 2606 OID 16486)
-- Name: pedido_compra fk_fornecedor_pedido; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pedido_compra
    ADD CONSTRAINT fk_fornecedor_pedido FOREIGN KEY (fornecedor_id) REFERENCES public.fornecedor(idfornecedor);


--
-- TOC entry 3352 (class 2606 OID 16473)
-- Name: venda fk_produto_venda; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.venda
    ADD CONSTRAINT fk_produto_venda FOREIGN KEY (filial_id, produto_id) REFERENCES public.produtos_filial(filial_id, produto_id);


-- Completed on 2026-05-13 23:05:54 -04

--
-- PostgreSQL database dump complete
--

\unrestrict 4quBi9awX3DSxB1WwA57zJ0FVN93pilZcr3ZgeriiXBSTslHlXAAd1Ro1sud4kz

