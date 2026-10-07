--
-- PostgreSQL database cluster dump
--

\restrict b2HHzV9QAeao0ZeKVxO3KSkn8eSAzn1IEROMnyDcyyTIeQxLOH8oQiZzBm5ZLKp

SET default_transaction_read_only = off;

SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;

--
-- Roles
--

CREATE ROLE postgres;
ALTER ROLE postgres WITH SUPERUSER INHERIT CREATEROLE CREATEDB LOGIN REPLICATION BYPASSRLS PASSWORD 'SCRAM-SHA-256$4096:83gZu45D88rXnSy2ToaqHg==$t2g+zizuIqWLhCjM+ob5vLwpfdecldjRe48o9SOMduo=:z5mtIWLOPf8PrO2SQ85CuhF+Z5vFOMCcAlpnhir0NvQ=';

--
-- User Configurations
--








\unrestrict b2HHzV9QAeao0ZeKVxO3KSkn8eSAzn1IEROMnyDcyyTIeQxLOH8oQiZzBm5ZLKp

--
-- Databases
--

--
-- Database "template1" dump
--

\connect template1

--
-- PostgreSQL database dump
--

\restrict 2a9tAJJy2jarNkxF8T0bqUwUHarMzP8KE7qZ1TJTxRgbKrS8LahVWK0XR2nVog4

-- Dumped from database version 15.14 (Debian 15.14-1.pgdg13+1)
-- Dumped by pg_dump version 15.14 (Debian 15.14-1.pgdg13+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- PostgreSQL database dump complete
--

\unrestrict 2a9tAJJy2jarNkxF8T0bqUwUHarMzP8KE7qZ1TJTxRgbKrS8LahVWK0XR2nVog4

--
-- Database "postgres" dump
--

\connect postgres

--
-- PostgreSQL database dump
--

\restrict DCo1dctfVP3kIa8V8oRTITBpdqopvVMqTromKfr7PZIBhgA1X7EIKugstMdlmko

-- Dumped from database version 15.14 (Debian 15.14-1.pgdg13+1)
-- Dumped by pg_dump version 15.14 (Debian 15.14-1.pgdg13+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: companies; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.companies (
    id integer NOT NULL,
    name character varying NOT NULL,
    login character varying(100) NOT NULL,
    password character varying(255) NOT NULL
);


ALTER TABLE public.companies OWNER TO postgres;

--
-- Name: companies_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.companies_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.companies_id_seq OWNER TO postgres;

--
-- Name: companies_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.companies_id_seq OWNED BY public.companies.id;


--
-- Name: errors; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.errors (
    id integer NOT NULL,
    machine_id integer NOT NULL,
    error_code character varying NOT NULL,
    description character varying,
    created_at timestamp without time zone DEFAULT now()
);


ALTER TABLE public.errors OWNER TO postgres;

--
-- Name: errors_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.errors_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.errors_id_seq OWNER TO postgres;

--
-- Name: errors_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.errors_id_seq OWNED BY public.errors.id;


--
-- Name: machine_data; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.machine_data (
    id integer NOT NULL,
    machine_id integer NOT NULL,
    "timestamp" timestamp without time zone DEFAULT now(),
    is_running boolean NOT NULL,
    has_error boolean NOT NULL,
    cycle_completed integer NOT NULL,
    tag1 double precision,
    tag2 double precision,
    tag3 double precision,
    tag4 double precision
);


ALTER TABLE public.machine_data OWNER TO postgres;

--
-- Name: machine_data_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.machine_data_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.machine_data_id_seq OWNER TO postgres;

--
-- Name: machine_data_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.machine_data_id_seq OWNED BY public.machine_data.id;


--
-- Name: machine_part_error_occurrences; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.machine_part_error_occurrences (
    id integer NOT NULL,
    error_id integer NOT NULL,
    part_id integer NOT NULL,
    occurred_at timestamp without time zone DEFAULT now(),
    error_code character varying NOT NULL,
    description character varying
);


ALTER TABLE public.machine_part_error_occurrences OWNER TO postgres;

--
-- Name: machine_part_error_occurrences_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.machine_part_error_occurrences_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.machine_part_error_occurrences_id_seq OWNER TO postgres;

--
-- Name: machine_part_error_occurrences_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.machine_part_error_occurrences_id_seq OWNED BY public.machine_part_error_occurrences.id;


--
-- Name: machine_part_errors; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.machine_part_errors (
    id integer NOT NULL,
    part_id integer NOT NULL,
    error_code character varying(50),
    description character varying
);


ALTER TABLE public.machine_part_errors OWNER TO postgres;

--
-- Name: machine_part_errors_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.machine_part_errors_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.machine_part_errors_id_seq OWNER TO postgres;

--
-- Name: machine_part_errors_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.machine_part_errors_id_seq OWNED BY public.machine_part_errors.id;


--
-- Name: machine_part_stats; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.machine_part_stats (
    id integer NOT NULL,
    name character varying NOT NULL,
    counter integer DEFAULT 0 NOT NULL,
    is_empty boolean DEFAULT false NOT NULL,
    part_id integer NOT NULL
);


ALTER TABLE public.machine_part_stats OWNER TO postgres;

--
-- Name: machine_part_stats_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.machine_part_stats_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.machine_part_stats_id_seq OWNER TO postgres;

--
-- Name: machine_part_stats_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.machine_part_stats_id_seq OWNED BY public.machine_part_stats.id;


--
-- Name: machine_parts; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.machine_parts (
    id integer NOT NULL,
    machine_id integer NOT NULL,
    name character varying NOT NULL,
    x double precision DEFAULT 0.0 NOT NULL,
    y double precision DEFAULT 0.0 NOT NULL,
    its_working boolean DEFAULT true NOT NULL
);


ALTER TABLE public.machine_parts OWNER TO postgres;

--
-- Name: machine_parts_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.machine_parts_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.machine_parts_id_seq OWNER TO postgres;

--
-- Name: machine_parts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.machine_parts_id_seq OWNED BY public.machine_parts.id;


--
-- Name: machines; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.machines (
    id integer NOT NULL,
    company_id integer NOT NULL,
    name character varying NOT NULL,
    config jsonb DEFAULT '{}'::jsonb
);


ALTER TABLE public.machines OWNER TO postgres;

--
-- Name: machines_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.machines_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.machines_id_seq OWNER TO postgres;

--
-- Name: machines_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.machines_id_seq OWNED BY public.machines.id;


--
-- Name: companies id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.companies ALTER COLUMN id SET DEFAULT nextval('public.companies_id_seq'::regclass);


--
-- Name: errors id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.errors ALTER COLUMN id SET DEFAULT nextval('public.errors_id_seq'::regclass);


--
-- Name: machine_data id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.machine_data ALTER COLUMN id SET DEFAULT nextval('public.machine_data_id_seq'::regclass);


--
-- Name: machine_part_error_occurrences id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.machine_part_error_occurrences ALTER COLUMN id SET DEFAULT nextval('public.machine_part_error_occurrences_id_seq'::regclass);


--
-- Name: machine_part_errors id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.machine_part_errors ALTER COLUMN id SET DEFAULT nextval('public.machine_part_errors_id_seq'::regclass);


--
-- Name: machine_part_stats id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.machine_part_stats ALTER COLUMN id SET DEFAULT nextval('public.machine_part_stats_id_seq'::regclass);


--
-- Name: machine_parts id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.machine_parts ALTER COLUMN id SET DEFAULT nextval('public.machine_parts_id_seq'::regclass);


--
-- Name: machines id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.machines ALTER COLUMN id SET DEFAULT nextval('public.machines_id_seq'::regclass);


--
-- Data for Name: companies; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.companies (id, name, login, password) FROM stdin;
1	TechNova	tech1	1234
2	GreenCore	green2	abcd
3	SkyLogix	sky3	pass
4	BlueOrbit	blue4	1111
5	NeoGenics	neo5	qwerty
\.


--
-- Data for Name: errors; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.errors (id, machine_id, error_code, description, created_at) FROM stdin;
1	1	E101	Overheating detected	2025-09-17 12:22:36.191989
2	1	E102	Low pressure warning	2025-09-17 12:22:36.191989
3	2	E201	Unexpected shutdown	2025-09-17 12:22:36.191989
4	2	E202	High vibration level	2025-09-17 12:22:36.191989
11	1	E101	Overheating detected	2025-09-17 12:23:02.082829
12	1	E102	Low pressure warning	2025-09-17 12:23:02.082829
13	2	E201	Unexpected shutdown	2025-09-17 12:23:02.082829
14	2	E202	High vibration level	2025-09-17 12:23:02.082829
21	1	E101	Overheating detected	2025-09-17 12:23:03.990715
22	1	E102	Low pressure warning	2025-09-17 12:23:03.990715
23	2	E201	Unexpected shutdown	2025-09-17 12:23:03.990715
24	2	E202	High vibration level	2025-09-17 12:23:03.990715
31	1	E101	Overheating detected	2025-09-17 12:23:05.28879
32	1	E102	Low pressure warning	2025-09-17 12:23:05.28879
33	2	E201	Unexpected shutdown	2025-09-17 12:23:05.28879
34	2	E202	High vibration level	2025-09-17 12:23:05.28879
41	1	E101	Overheating detected	2025-09-17 12:23:06.438052
42	1	E102	Low pressure warning	2025-09-17 12:23:06.438052
43	2	E201	Unexpected shutdown	2025-09-17 12:23:06.438052
44	2	E202	High vibration level	2025-09-17 12:23:06.438052
51	1	E101	Overheating detected	2025-09-18 10:21:00.978129
52	1	E101	Overheating detected	2025-09-18 10:21:04.046469
53	1	E101	Overheating detected	2025-09-18 10:21:04.847137
54	1	E101	Overheating detected	2025-09-18 10:22:20.432279
55	1	E101	Overheating detected	2025-09-18 10:22:21.494346
56	1	E002	STOP pres	2025-09-18 10:22:44.803801
\.


--
-- Data for Name: machine_data; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.machine_data (id, machine_id, "timestamp", is_running, has_error, cycle_completed, tag1, tag2, tag3, tag4) FROM stdin;
1	1	2025-06-25 08:14:56.106384	t	f	34	12.45	65.32	88.01	43.76
21	1	2025-06-25 08:14:56.106384	t	t	12	17.32	65.23	89.77	47.65
41	1	2025-06-25 08:14:56.106384	t	f	13	13.1	66.8	90.8	45.9
\.


--
-- Data for Name: machine_part_error_occurrences; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.machine_part_error_occurrences (id, error_id, part_id, occurred_at, error_code, description) FROM stdin;
1	309	39	2026-10-05 05:23:02.250525	A309	Błąd Lini Niverplst - Easy Plast
2	310	41	2026-10-05 05:23:02.250525	A310	Alarm Lini Niverplast - Transport System
3	311	41	2026-10-05 05:23:02.250525	A311	Błąd Lini Niverplst - Transport System
4	309	39	2026-10-05 05:24:02.641253	A309	Błąd Lini Niverplst - Easy Plast
5	310	41	2026-10-05 05:24:02.641253	A310	Alarm Lini Niverplast - Transport System
6	311	41	2026-10-05 05:24:02.641253	A311	Błąd Lini Niverplst - Transport System
7	309	39	2026-10-05 05:25:02.881245	A309	Błąd Lini Niverplst - Easy Plast
8	310	41	2026-10-05 05:25:02.881245	A310	Alarm Lini Niverplast - Transport System
9	311	41	2026-10-05 05:25:02.881245	A311	Błąd Lini Niverplst - Transport System
10	309	39	2026-10-05 05:26:03.219454	A309	Błąd Lini Niverplst - Easy Plast
11	310	41	2026-10-05 05:26:03.219454	A310	Alarm Lini Niverplast - Transport System
12	311	41	2026-10-05 05:26:03.219454	A311	Błąd Lini Niverplst - Transport System
13	309	39	2026-10-05 05:27:03.460527	A309	Błąd Lini Niverplst - Easy Plast
14	310	41	2026-10-05 05:27:03.460527	A310	Alarm Lini Niverplast - Transport System
15	311	41	2026-10-05 05:27:03.460527	A311	Błąd Lini Niverplst - Transport System
16	309	39	2026-10-05 05:28:03.743692	A309	Błąd Lini Niverplst - Easy Plast
17	310	41	2026-10-05 05:28:03.743692	A310	Alarm Lini Niverplast - Transport System
18	311	41	2026-10-05 05:28:03.743692	A311	Błąd Lini Niverplst - Transport System
19	309	39	2026-10-05 05:29:04.025104	A309	Błąd Lini Niverplst - Easy Plast
20	310	41	2026-10-05 05:29:04.025104	A310	Alarm Lini Niverplast - Transport System
21	311	41	2026-10-05 05:29:04.025104	A311	Błąd Lini Niverplst - Transport System
22	309	39	2026-10-05 05:30:02.369949	A309	Błąd Lini Niverplst - Easy Plast
23	310	41	2026-10-05 05:30:02.369949	A310	Alarm Lini Niverplast - Transport System
24	311	41	2026-10-05 05:30:02.369949	A311	Błąd Lini Niverplst - Transport System
25	309	39	2026-10-05 05:31:02.70577	A309	Błąd Lini Niverplst - Easy Plast
26	310	41	2026-10-05 05:31:02.70577	A310	Alarm Lini Niverplast - Transport System
27	311	41	2026-10-05 05:31:02.70577	A311	Błąd Lini Niverplst - Transport System
28	309	39	2026-10-05 05:32:02.962356	A309	Błąd Lini Niverplst - Easy Plast
29	310	41	2026-10-05 05:32:02.962356	A310	Alarm Lini Niverplast - Transport System
30	311	41	2026-10-05 05:32:02.962356	A311	Błąd Lini Niverplst - Transport System
31	309	39	2026-10-05 05:33:03.263103	A309	Błąd Lini Niverplst - Easy Plast
32	310	41	2026-10-05 05:33:03.263103	A310	Alarm Lini Niverplast - Transport System
33	311	41	2026-10-05 05:33:03.263103	A311	Błąd Lini Niverplst - Transport System
34	309	39	2026-10-05 05:34:03.548036	A309	Błąd Lini Niverplst - Easy Plast
35	310	41	2026-10-05 05:34:03.548036	A310	Alarm Lini Niverplast - Transport System
36	311	41	2026-10-05 05:34:03.548036	A311	Błąd Lini Niverplst - Transport System
37	309	39	2026-10-05 05:35:03.938477	A309	Błąd Lini Niverplst - Easy Plast
38	310	41	2026-10-05 05:35:03.938477	A310	Alarm Lini Niverplast - Transport System
39	311	41	2026-10-05 05:35:03.938477	A311	Błąd Lini Niverplst - Transport System
40	309	39	2026-10-05 05:36:04.108974	A309	Błąd Lini Niverplst - Easy Plast
41	310	41	2026-10-05 05:36:04.108974	A310	Alarm Lini Niverplast - Transport System
42	311	41	2026-10-05 05:36:04.108974	A311	Błąd Lini Niverplst - Transport System
43	309	39	2026-10-05 05:37:04.371392	A309	Błąd Lini Niverplst - Easy Plast
44	310	41	2026-10-05 05:37:04.371392	A310	Alarm Lini Niverplast - Transport System
45	311	41	2026-10-05 05:37:04.371392	A311	Błąd Lini Niverplst - Transport System
46	309	39	2026-10-05 05:38:04.637894	A309	Błąd Lini Niverplst - Easy Plast
47	310	41	2026-10-05 05:38:04.637894	A310	Alarm Lini Niverplast - Transport System
48	311	41	2026-10-05 05:38:04.637894	A311	Błąd Lini Niverplst - Transport System
49	309	39	2026-10-05 05:39:03.027617	A309	Błąd Lini Niverplst - Easy Plast
50	310	41	2026-10-05 05:39:03.027617	A310	Alarm Lini Niverplast - Transport System
51	311	41	2026-10-05 05:39:03.027617	A311	Błąd Lini Niverplst - Transport System
52	309	39	2026-10-05 05:40:03.315053	A309	Błąd Lini Niverplst - Easy Plast
53	310	41	2026-10-05 05:40:03.315053	A310	Alarm Lini Niverplast - Transport System
54	311	41	2026-10-05 05:40:03.315053	A311	Błąd Lini Niverplst - Transport System
55	309	39	2026-10-05 05:41:03.600963	A309	Błąd Lini Niverplst - Easy Plast
56	310	41	2026-10-05 05:41:03.600963	A310	Alarm Lini Niverplast - Transport System
57	311	41	2026-10-05 05:41:03.600963	A311	Błąd Lini Niverplst - Transport System
58	309	39	2026-10-05 05:42:03.92384	A309	Błąd Lini Niverplst - Easy Plast
59	310	41	2026-10-05 05:42:03.92384	A310	Alarm Lini Niverplast - Transport System
60	311	41	2026-10-05 05:42:03.92384	A311	Błąd Lini Niverplst - Transport System
61	309	39	2026-10-05 05:43:04.162338	A309	Błąd Lini Niverplst - Easy Plast
62	310	41	2026-10-05 05:43:04.162338	A310	Alarm Lini Niverplast - Transport System
63	311	41	2026-10-05 05:43:04.162338	A311	Błąd Lini Niverplst - Transport System
64	309	39	2026-10-05 05:44:04.446672	A309	Błąd Lini Niverplst - Easy Plast
65	310	41	2026-10-05 05:44:04.446672	A310	Alarm Lini Niverplast - Transport System
66	311	41	2026-10-05 05:44:04.446672	A311	Błąd Lini Niverplst - Transport System
67	309	39	2026-10-05 05:45:04.716164	A309	Błąd Lini Niverplst - Easy Plast
68	310	41	2026-10-05 05:45:04.716164	A310	Alarm Lini Niverplast - Transport System
69	311	41	2026-10-05 05:45:04.716164	A311	Błąd Lini Niverplst - Transport System
70	309	39	2026-10-05 05:46:05.051743	A309	Błąd Lini Niverplst - Easy Plast
71	310	41	2026-10-05 05:46:05.051743	A310	Alarm Lini Niverplast - Transport System
72	311	41	2026-10-05 05:46:05.051743	A311	Błąd Lini Niverplst - Transport System
73	309	39	2026-10-05 05:47:03.413329	A309	Błąd Lini Niverplst - Easy Plast
74	310	41	2026-10-05 05:47:03.413329	A310	Alarm Lini Niverplast - Transport System
75	311	41	2026-10-05 05:47:03.413329	A311	Błąd Lini Niverplst - Transport System
76	309	39	2026-10-05 05:48:03.607982	A309	Błąd Lini Niverplst - Easy Plast
77	310	41	2026-10-05 05:48:03.607982	A310	Alarm Lini Niverplast - Transport System
78	311	41	2026-10-05 05:48:03.607982	A311	Błąd Lini Niverplst - Transport System
79	309	39	2026-10-05 05:49:03.946986	A309	Błąd Lini Niverplst - Easy Plast
80	310	41	2026-10-05 05:49:03.946986	A310	Alarm Lini Niverplast - Transport System
81	311	41	2026-10-05 05:49:03.946986	A311	Błąd Lini Niverplst - Transport System
82	309	39	2026-10-05 05:50:04.20898	A309	Błąd Lini Niverplst - Easy Plast
83	310	41	2026-10-05 05:50:04.20898	A310	Alarm Lini Niverplast - Transport System
1228	182	40	2026-10-05 11:58:26.594286	A182	\N
84	311	41	2026-10-05 05:50:04.20898	A311	Błąd Lini Niverplst - Transport System
85	309	39	2026-10-05 05:51:04.520014	A309	Błąd Lini Niverplst - Easy Plast
86	310	41	2026-10-05 05:51:04.520014	A310	Alarm Lini Niverplast - Transport System
87	311	41	2026-10-05 05:51:04.520014	A311	Błąd Lini Niverplst - Transport System
88	309	39	2026-10-05 05:52:04.775657	A309	Błąd Lini Niverplst - Easy Plast
89	310	41	2026-10-05 05:52:04.775657	A310	Alarm Lini Niverplast - Transport System
90	311	41	2026-10-05 05:52:04.775657	A311	Błąd Lini Niverplst - Transport System
91	309	39	2026-10-05 05:53:05.067354	A309	Błąd Lini Niverplst - Easy Plast
92	310	41	2026-10-05 05:53:05.067354	A310	Alarm Lini Niverplast - Transport System
93	311	41	2026-10-05 05:53:05.067354	A311	Błąd Lini Niverplst - Transport System
94	309	39	2026-10-05 05:54:05.36415	A309	Błąd Lini Niverplst - Easy Plast
95	310	41	2026-10-05 05:54:05.36415	A310	Alarm Lini Niverplast - Transport System
96	311	41	2026-10-05 05:54:05.36415	A311	Błąd Lini Niverplst - Transport System
97	309	39	2026-10-05 05:55:03.687921	A309	Błąd Lini Niverplst - Easy Plast
98	310	41	2026-10-05 05:55:03.687921	A310	Alarm Lini Niverplast - Transport System
99	311	41	2026-10-05 05:55:03.687921	A311	Błąd Lini Niverplst - Transport System
100	309	39	2026-10-05 05:56:04.017806	A309	Błąd Lini Niverplst - Easy Plast
101	310	41	2026-10-05 05:56:04.017806	A310	Alarm Lini Niverplast - Transport System
102	311	41	2026-10-05 05:56:04.017806	A311	Błąd Lini Niverplst - Transport System
103	309	39	2026-10-05 05:57:04.256472	A309	Błąd Lini Niverplst - Easy Plast
104	310	41	2026-10-05 05:57:04.256472	A310	Alarm Lini Niverplast - Transport System
105	311	41	2026-10-05 05:57:04.256472	A311	Błąd Lini Niverplst - Transport System
106	309	39	2026-10-05 05:58:04.593431	A309	Błąd Lini Niverplst - Easy Plast
107	310	41	2026-10-05 05:58:04.593431	A310	Alarm Lini Niverplast - Transport System
108	311	41	2026-10-05 05:58:04.593431	A311	Błąd Lini Niverplst - Transport System
109	309	39	2026-10-05 05:59:04.85846	A309	Błąd Lini Niverplst - Easy Plast
110	310	41	2026-10-05 05:59:04.85846	A310	Alarm Lini Niverplast - Transport System
111	311	41	2026-10-05 05:59:04.85846	A311	Błąd Lini Niverplst - Transport System
112	309	39	2026-10-05 06:00:05.169043	A309	Błąd Lini Niverplst - Easy Plast
113	310	41	2026-10-05 06:00:05.169043	A310	Alarm Lini Niverplast - Transport System
114	311	41	2026-10-05 06:00:05.169043	A311	Błąd Lini Niverplst - Transport System
115	309	39	2026-10-05 06:01:05.447661	A309	Błąd Lini Niverplst - Easy Plast
116	310	41	2026-10-05 06:01:05.447661	A310	Alarm Lini Niverplast - Transport System
117	311	41	2026-10-05 06:01:05.447661	A311	Błąd Lini Niverplst - Transport System
118	106	2	2026-10-05 06:01:05.447661	A106	Błąd pudełko zostało odrzucone
119	309	39	2026-10-05 06:02:05.728753	A309	Błąd Lini Niverplst - Easy Plast
120	310	41	2026-10-05 06:02:05.728753	A310	Alarm Lini Niverplast - Transport System
121	311	41	2026-10-05 06:02:05.728753	A311	Błąd Lini Niverplst - Transport System
122	309	39	2026-10-05 06:03:06.018629	A309	Błąd Lini Niverplst - Easy Plast
123	310	41	2026-10-05 06:03:06.018629	A310	Alarm Lini Niverplast - Transport System
124	311	41	2026-10-05 06:03:06.018629	A311	Błąd Lini Niverplst - Transport System
125	106	2	2026-10-05 06:03:06.018629	A106	Błąd pudełko zostało odrzucone
126	309	39	2026-10-05 06:04:04.345666	A309	Błąd Lini Niverplst - Easy Plast
127	310	41	2026-10-05 06:04:04.345666	A310	Alarm Lini Niverplast - Transport System
128	311	41	2026-10-05 06:04:04.345666	A311	Błąd Lini Niverplst - Transport System
129	309	39	2026-10-05 06:05:04.648105	A309	Błąd Lini Niverplst - Easy Plast
130	310	41	2026-10-05 06:05:04.648105	A310	Alarm Lini Niverplast - Transport System
131	311	41	2026-10-05 06:05:04.648105	A311	Błąd Lini Niverplst - Transport System
132	309	39	2026-10-05 06:06:04.923173	A309	Błąd Lini Niverplst - Easy Plast
133	310	41	2026-10-05 06:06:04.923173	A310	Alarm Lini Niverplast - Transport System
134	311	41	2026-10-05 06:06:04.923173	A311	Błąd Lini Niverplst - Transport System
135	309	39	2026-10-05 06:07:05.24623	A309	Błąd Lini Niverplst - Easy Plast
136	310	41	2026-10-05 06:07:05.24623	A310	Alarm Lini Niverplast - Transport System
137	311	41	2026-10-05 06:07:05.24623	A311	Błąd Lini Niverplst - Transport System
138	309	39	2026-10-05 06:08:05.517172	A309	Błąd Lini Niverplst - Easy Plast
139	310	41	2026-10-05 06:08:05.517172	A310	Alarm Lini Niverplast - Transport System
140	311	41	2026-10-05 06:08:05.517172	A311	Błąd Lini Niverplst - Transport System
141	309	39	2026-10-05 06:09:05.831692	A309	Błąd Lini Niverplst - Easy Plast
142	310	41	2026-10-05 06:09:05.831692	A310	Alarm Lini Niverplast - Transport System
143	311	41	2026-10-05 06:09:05.831692	A311	Błąd Lini Niverplst - Transport System
144	309	39	2026-10-05 06:10:06.093322	A309	Błąd Lini Niverplst - Easy Plast
145	310	41	2026-10-05 06:10:06.093322	A310	Alarm Lini Niverplast - Transport System
146	311	41	2026-10-05 06:10:06.093322	A311	Błąd Lini Niverplst - Transport System
147	309	39	2026-10-05 06:11:06.428548	A309	Błąd Lini Niverplst - Easy Plast
148	310	41	2026-10-05 06:11:06.428548	A310	Alarm Lini Niverplast - Transport System
149	311	41	2026-10-05 06:11:06.428548	A311	Błąd Lini Niverplst - Transport System
150	309	39	2026-10-05 06:12:04.77269	A309	Błąd Lini Niverplst - Easy Plast
151	310	41	2026-10-05 06:12:04.77269	A310	Alarm Lini Niverplast - Transport System
152	311	41	2026-10-05 06:12:04.77269	A311	Błąd Lini Niverplst - Transport System
153	309	39	2026-10-05 06:13:04.980344	A309	Błąd Lini Niverplst - Easy Plast
154	310	41	2026-10-05 06:13:04.980344	A310	Alarm Lini Niverplast - Transport System
155	311	41	2026-10-05 06:13:04.980344	A311	Błąd Lini Niverplst - Transport System
156	309	39	2026-10-05 06:14:05.344291	A309	Błąd Lini Niverplst - Easy Plast
157	310	41	2026-10-05 06:14:05.344291	A310	Alarm Lini Niverplast - Transport System
158	311	41	2026-10-05 06:14:05.344291	A311	Błąd Lini Niverplst - Transport System
159	309	39	2026-10-05 06:15:05.581263	A309	Błąd Lini Niverplst - Easy Plast
160	310	41	2026-10-05 06:15:05.581263	A310	Alarm Lini Niverplast - Transport System
161	311	41	2026-10-05 06:15:05.581263	A311	Błąd Lini Niverplst - Transport System
162	309	39	2026-10-05 06:16:05.915409	A309	Błąd Lini Niverplst - Easy Plast
163	310	41	2026-10-05 06:16:05.915409	A310	Alarm Lini Niverplast - Transport System
164	311	41	2026-10-05 06:16:05.915409	A311	Błąd Lini Niverplst - Transport System
165	309	39	2026-10-05 06:17:06.19472	A309	Błąd Lini Niverplst - Easy Plast
166	310	41	2026-10-05 06:17:06.19472	A310	Alarm Lini Niverplast - Transport System
167	311	41	2026-10-05 06:17:06.19472	A311	Błąd Lini Niverplst - Transport System
168	309	39	2026-10-05 06:18:06.490762	A309	Błąd Lini Niverplst - Easy Plast
169	310	41	2026-10-05 06:18:06.490762	A310	Alarm Lini Niverplast - Transport System
170	311	41	2026-10-05 06:18:06.490762	A311	Błąd Lini Niverplst - Transport System
171	309	39	2026-10-05 06:19:06.764631	A309	Błąd Lini Niverplst - Easy Plast
172	310	41	2026-10-05 06:19:06.764631	A310	Alarm Lini Niverplast - Transport System
173	311	41	2026-10-05 06:19:06.764631	A311	Błąd Lini Niverplst - Transport System
174	309	39	2026-10-05 06:20:07.05189	A309	Błąd Lini Niverplst - Easy Plast
175	310	41	2026-10-05 06:20:07.05189	A310	Alarm Lini Niverplast - Transport System
176	311	41	2026-10-05 06:20:07.05189	A311	Błąd Lini Niverplst - Transport System
177	309	39	2026-10-05 06:21:05.450256	A309	Błąd Lini Niverplst - Easy Plast
178	310	41	2026-10-05 06:21:05.450256	A310	Alarm Lini Niverplast - Transport System
179	311	41	2026-10-05 06:21:05.450256	A311	Błąd Lini Niverplst - Transport System
180	309	39	2026-10-05 06:22:06.12673	A309	Błąd Lini Niverplst - Easy Plast
181	310	41	2026-10-05 06:22:06.12673	A310	Alarm Lini Niverplast - Transport System
182	311	41	2026-10-05 06:22:06.12673	A311	Błąd Lini Niverplst - Transport System
183	309	39	2026-10-05 06:23:06.017426	A309	Błąd Lini Niverplst - Easy Plast
184	310	41	2026-10-05 06:23:06.017426	A310	Alarm Lini Niverplast - Transport System
185	311	41	2026-10-05 06:23:06.017426	A311	Błąd Lini Niverplst - Transport System
186	309	39	2026-10-05 06:24:06.276271	A309	Błąd Lini Niverplst - Easy Plast
187	310	41	2026-10-05 06:24:06.276271	A310	Alarm Lini Niverplast - Transport System
188	311	41	2026-10-05 06:24:06.276271	A311	Błąd Lini Niverplst - Transport System
189	309	39	2026-10-05 06:25:06.594298	A309	Błąd Lini Niverplst - Easy Plast
190	310	41	2026-10-05 06:25:06.594298	A310	Alarm Lini Niverplast - Transport System
191	311	41	2026-10-05 06:25:06.594298	A311	Błąd Lini Niverplst - Transport System
192	309	39	2026-10-05 06:26:06.87453	A309	Błąd Lini Niverplst - Easy Plast
193	310	41	2026-10-05 06:26:06.87453	A310	Alarm Lini Niverplast - Transport System
194	311	41	2026-10-05 06:26:06.87453	A311	Błąd Lini Niverplst - Transport System
195	309	39	2026-10-05 06:27:08.110568	A309	Błąd Lini Niverplst - Easy Plast
196	310	41	2026-10-05 06:27:08.110568	A310	Alarm Lini Niverplast - Transport System
197	311	41	2026-10-05 06:27:08.110568	A311	Błąd Lini Niverplst - Transport System
198	309	39	2026-10-05 06:28:07.472269	A309	Błąd Lini Niverplst - Easy Plast
199	310	41	2026-10-05 06:28:07.472269	A310	Alarm Lini Niverplast - Transport System
200	311	41	2026-10-05 06:28:07.472269	A311	Błąd Lini Niverplst - Transport System
201	309	39	2026-10-05 06:29:05.813129	A309	Błąd Lini Niverplst - Easy Plast
202	310	41	2026-10-05 06:29:05.813129	A310	Alarm Lini Niverplast - Transport System
203	311	41	2026-10-05 06:29:05.813129	A311	Błąd Lini Niverplst - Transport System
204	309	39	2026-10-05 06:30:06.080134	A309	Błąd Lini Niverplst - Easy Plast
205	310	41	2026-10-05 06:30:06.080134	A310	Alarm Lini Niverplast - Transport System
206	311	41	2026-10-05 06:30:06.080134	A311	Błąd Lini Niverplst - Transport System
207	309	39	2026-10-05 06:31:06.0275	A309	Błąd Lini Niverplst - Easy Plast
208	310	41	2026-10-05 06:31:06.0275	A310	Alarm Lini Niverplast - Transport System
209	311	41	2026-10-05 06:31:06.0275	A311	Błąd Lini Niverplst - Transport System
210	309	39	2026-10-05 06:32:06.828878	A309	Błąd Lini Niverplst - Easy Plast
211	310	41	2026-10-05 06:32:06.828878	A310	Alarm Lini Niverplast - Transport System
212	311	41	2026-10-05 06:32:06.828878	A311	Błąd Lini Niverplst - Transport System
213	309	39	2026-10-05 06:33:07.017266	A309	Błąd Lini Niverplst - Easy Plast
214	310	41	2026-10-05 06:33:07.017266	A310	Alarm Lini Niverplast - Transport System
215	311	41	2026-10-05 06:33:07.017266	A311	Błąd Lini Niverplst - Transport System
216	309	39	2026-10-05 06:34:07.278208	A309	Błąd Lini Niverplst - Easy Plast
217	310	41	2026-10-05 06:34:07.278208	A310	Alarm Lini Niverplast - Transport System
218	311	41	2026-10-05 06:34:07.278208	A311	Błąd Lini Niverplst - Transport System
219	309	39	2026-10-05 06:35:07.575985	A309	Błąd Lini Niverplst - Easy Plast
220	310	41	2026-10-05 06:35:07.575985	A310	Alarm Lini Niverplast - Transport System
221	311	41	2026-10-05 06:35:07.575985	A311	Błąd Lini Niverplst - Transport System
222	309	39	2026-10-05 06:36:07.74864	A309	Błąd Lini Niverplst - Easy Plast
223	310	41	2026-10-05 06:36:07.74864	A310	Alarm Lini Niverplast - Transport System
224	311	41	2026-10-05 06:36:07.74864	A311	Błąd Lini Niverplst - Transport System
225	309	39	2026-10-05 06:37:08.025253	A309	Błąd Lini Niverplst - Easy Plast
226	310	41	2026-10-05 06:37:08.025253	A310	Alarm Lini Niverplast - Transport System
227	311	41	2026-10-05 06:37:08.025253	A311	Błąd Lini Niverplst - Transport System
228	309	39	2026-10-05 06:38:06.463211	A309	Błąd Lini Niverplst - Easy Plast
229	310	41	2026-10-05 06:38:06.463211	A310	Alarm Lini Niverplast - Transport System
230	311	41	2026-10-05 06:38:06.463211	A311	Błąd Lini Niverplst - Transport System
231	309	39	2026-10-05 06:39:06.750006	A309	Błąd Lini Niverplst - Easy Plast
232	310	41	2026-10-05 06:39:06.750006	A310	Alarm Lini Niverplast - Transport System
233	311	41	2026-10-05 06:39:06.750006	A311	Błąd Lini Niverplst - Transport System
234	309	39	2026-10-05 06:40:06.967418	A309	Błąd Lini Niverplst - Easy Plast
235	310	41	2026-10-05 06:40:06.967418	A310	Alarm Lini Niverplast - Transport System
236	311	41	2026-10-05 06:40:06.967418	A311	Błąd Lini Niverplst - Transport System
237	187	40	2026-10-05 06:41:07.249592	A187	Otwarta Bramka Bezpieczeństwa 
238	129	40	2026-10-05 06:41:07.249592	A129	Niskie ciśnienie pneumatyczne - strefa 1
239	309	39	2026-10-05 06:41:07.249592	A309	Błąd Lini Niverplst - Easy Plast
240	310	41	2026-10-05 06:41:07.249592	A310	Alarm Lini Niverplast - Transport System
241	311	41	2026-10-05 06:41:07.249592	A311	Błąd Lini Niverplst - Transport System
242	188	40	2026-10-05 06:41:07.249592	A188	Nieryglowany zamek bramki bezpieszeństwa
243	309	39	2026-10-05 06:42:07.495659	A309	Błąd Lini Niverplst - Easy Plast
244	310	41	2026-10-05 06:42:07.495659	A310	Alarm Lini Niverplast - Transport System
245	311	41	2026-10-05 06:42:07.495659	A311	Błąd Lini Niverplst - Transport System
246	309	39	2026-10-05 06:43:07.730761	A309	Błąd Lini Niverplst - Easy Plast
247	310	41	2026-10-05 06:43:07.730761	A310	Alarm Lini Niverplast - Transport System
248	311	41	2026-10-05 06:43:07.730761	A311	Błąd Lini Niverplst - Transport System
249	309	39	2026-10-05 06:44:08.035787	A309	Błąd Lini Niverplst - Easy Plast
250	310	41	2026-10-05 06:44:08.035787	A310	Alarm Lini Niverplast - Transport System
1234	182	40	2026-10-05 11:59:24.834403	A182	\N
251	311	41	2026-10-05 06:44:08.035787	A311	Błąd Lini Niverplst - Transport System
252	309	39	2026-10-05 06:45:08.293284	A309	Błąd Lini Niverplst - Easy Plast
253	310	41	2026-10-05 06:45:08.293284	A310	Alarm Lini Niverplast - Transport System
254	311	41	2026-10-05 06:45:08.293284	A311	Błąd Lini Niverplst - Transport System
255	309	39	2026-10-05 06:46:08.581469	A309	Błąd Lini Niverplst - Easy Plast
256	310	41	2026-10-05 06:46:08.581469	A310	Alarm Lini Niverplast - Transport System
257	311	41	2026-10-05 06:46:08.581469	A311	Błąd Lini Niverplst - Transport System
258	309	39	2026-10-05 06:47:06.985767	A309	Błąd Lini Niverplst - Easy Plast
259	310	41	2026-10-05 06:47:06.985767	A310	Alarm Lini Niverplast - Transport System
260	311	41	2026-10-05 06:47:06.985767	A311	Błąd Lini Niverplst - Transport System
261	309	39	2026-10-05 06:48:07.241789	A309	Błąd Lini Niverplst - Easy Plast
262	310	41	2026-10-05 06:48:07.241789	A310	Alarm Lini Niverplast - Transport System
263	311	41	2026-10-05 06:48:07.241789	A311	Błąd Lini Niverplst - Transport System
264	309	39	2026-10-05 06:49:07.524775	A309	Błąd Lini Niverplst - Easy Plast
265	310	41	2026-10-05 06:49:07.524775	A310	Alarm Lini Niverplast - Transport System
266	311	41	2026-10-05 06:49:07.524775	A311	Błąd Lini Niverplst - Transport System
267	309	39	2026-10-05 06:50:07.789338	A309	Błąd Lini Niverplst - Easy Plast
268	310	41	2026-10-05 06:50:07.789338	A310	Alarm Lini Niverplast - Transport System
269	311	41	2026-10-05 06:50:07.789338	A311	Błąd Lini Niverplst - Transport System
270	309	39	2026-10-05 06:51:08.089501	A309	Błąd Lini Niverplst - Easy Plast
271	310	41	2026-10-05 06:51:08.089501	A310	Alarm Lini Niverplast - Transport System
272	311	41	2026-10-05 06:51:08.089501	A311	Błąd Lini Niverplst - Transport System
273	309	39	2026-10-05 06:52:08.337766	A309	Błąd Lini Niverplst - Easy Plast
274	310	41	2026-10-05 06:52:08.337766	A310	Alarm Lini Niverplast - Transport System
275	311	41	2026-10-05 06:52:08.337766	A311	Błąd Lini Niverplst - Transport System
276	309	39	2026-10-05 06:53:08.622169	A309	Błąd Lini Niverplst - Easy Plast
277	310	41	2026-10-05 06:53:08.622169	A310	Alarm Lini Niverplast - Transport System
278	311	41	2026-10-05 06:53:08.622169	A311	Błąd Lini Niverplst - Transport System
279	309	39	2026-10-05 06:54:08.884759	A309	Błąd Lini Niverplst - Easy Plast
280	310	41	2026-10-05 06:54:08.884759	A310	Alarm Lini Niverplast - Transport System
281	311	41	2026-10-05 06:54:08.884759	A311	Błąd Lini Niverplst - Transport System
282	309	39	2026-10-05 06:55:07.284888	A309	Błąd Lini Niverplst - Easy Plast
283	310	41	2026-10-05 06:55:07.284888	A310	Alarm Lini Niverplast - Transport System
284	311	41	2026-10-05 06:55:07.284888	A311	Błąd Lini Niverplst - Transport System
285	309	39	2026-10-05 06:56:07.521164	A309	Błąd Lini Niverplst - Easy Plast
286	310	41	2026-10-05 06:56:07.521164	A310	Alarm Lini Niverplast - Transport System
287	311	41	2026-10-05 06:56:07.521164	A311	Błąd Lini Niverplst - Transport System
288	309	39	2026-10-05 06:57:07.844596	A309	Błąd Lini Niverplst - Easy Plast
289	310	41	2026-10-05 06:57:07.844596	A310	Alarm Lini Niverplast - Transport System
290	311	41	2026-10-05 06:57:07.844596	A311	Błąd Lini Niverplst - Transport System
291	309	39	2026-10-05 06:58:08.068481	A309	Błąd Lini Niverplst - Easy Plast
292	310	41	2026-10-05 06:58:08.068481	A310	Alarm Lini Niverplast - Transport System
293	311	41	2026-10-05 06:58:08.068481	A311	Błąd Lini Niverplst - Transport System
294	309	39	2026-10-05 06:59:08.414443	A309	Błąd Lini Niverplst - Easy Plast
295	310	41	2026-10-05 06:59:08.414443	A310	Alarm Lini Niverplast - Transport System
296	311	41	2026-10-05 06:59:08.414443	A311	Błąd Lini Niverplst - Transport System
297	309	39	2026-10-05 07:00:08.714158	A309	Błąd Lini Niverplst - Easy Plast
298	310	41	2026-10-05 07:00:08.714158	A310	Alarm Lini Niverplast - Transport System
299	311	41	2026-10-05 07:00:08.714158	A311	Błąd Lini Niverplst - Transport System
300	309	39	2026-10-05 07:01:08.985162	A309	Błąd Lini Niverplst - Easy Plast
301	310	41	2026-10-05 07:01:08.985162	A310	Alarm Lini Niverplast - Transport System
302	311	41	2026-10-05 07:01:08.985162	A311	Błąd Lini Niverplst - Transport System
303	309	39	2026-10-05 07:02:09.271732	A309	Błąd Lini Niverplst - Easy Plast
304	310	41	2026-10-05 07:02:09.271732	A310	Alarm Lini Niverplast - Transport System
305	311	41	2026-10-05 07:02:09.271732	A311	Błąd Lini Niverplst - Transport System
306	309	39	2026-10-05 07:03:09.5571	A309	Błąd Lini Niverplst - Easy Plast
307	310	41	2026-10-05 07:03:09.5571	A310	Alarm Lini Niverplast - Transport System
308	311	41	2026-10-05 07:03:09.5571	A311	Błąd Lini Niverplst - Transport System
309	309	39	2026-10-05 07:04:07.895008	A309	Błąd Lini Niverplst - Easy Plast
310	310	41	2026-10-05 07:04:07.895008	A310	Alarm Lini Niverplast - Transport System
311	311	41	2026-10-05 07:04:07.895008	A311	Błąd Lini Niverplst - Transport System
312	309	39	2026-10-05 07:05:08.228591	A309	Błąd Lini Niverplst - Easy Plast
313	310	41	2026-10-05 07:05:08.228591	A310	Alarm Lini Niverplast - Transport System
314	311	41	2026-10-05 07:05:08.228591	A311	Błąd Lini Niverplst - Transport System
315	309	39	2026-10-05 07:06:08.474695	A309	Błąd Lini Niverplst - Easy Plast
316	310	41	2026-10-05 07:06:08.474695	A310	Alarm Lini Niverplast - Transport System
317	311	41	2026-10-05 07:06:08.474695	A311	Błąd Lini Niverplst - Transport System
318	309	39	2026-10-05 07:07:08.785598	A309	Błąd Lini Niverplst - Easy Plast
319	310	41	2026-10-05 07:07:08.785598	A310	Alarm Lini Niverplast - Transport System
320	311	41	2026-10-05 07:07:08.785598	A311	Błąd Lini Niverplst - Transport System
321	309	39	2026-10-05 07:08:09.060244	A309	Błąd Lini Niverplst - Easy Plast
322	310	41	2026-10-05 07:08:09.060244	A310	Alarm Lini Niverplast - Transport System
323	311	41	2026-10-05 07:08:09.060244	A311	Błąd Lini Niverplst - Transport System
324	309	39	2026-10-05 07:09:09.365491	A309	Błąd Lini Niverplst - Easy Plast
325	310	41	2026-10-05 07:09:09.365491	A310	Alarm Lini Niverplast - Transport System
326	311	41	2026-10-05 07:09:09.365491	A311	Błąd Lini Niverplst - Transport System
327	309	39	2026-10-05 07:10:09.628277	A309	Błąd Lini Niverplst - Easy Plast
328	310	41	2026-10-05 07:10:09.628277	A310	Alarm Lini Niverplast - Transport System
329	311	41	2026-10-05 07:10:09.628277	A311	Błąd Lini Niverplst - Transport System
330	309	39	2026-10-05 07:11:09.91857	A309	Błąd Lini Niverplst - Easy Plast
331	310	41	2026-10-05 07:11:09.91857	A310	Alarm Lini Niverplast - Transport System
332	311	41	2026-10-05 07:11:09.91857	A311	Błąd Lini Niverplst - Transport System
333	309	39	2026-10-05 07:12:08.320925	A309	Błąd Lini Niverplst - Easy Plast
1240	182	40	2026-10-05 12:00:25.072209	A182	\N
334	310	41	2026-10-05 07:12:08.320925	A310	Alarm Lini Niverplast - Transport System
335	311	41	2026-10-05 07:12:08.320925	A311	Błąd Lini Niverplst - Transport System
336	309	39	2026-10-05 07:13:08.555925	A309	Błąd Lini Niverplst - Easy Plast
337	310	41	2026-10-05 07:13:08.555925	A310	Alarm Lini Niverplast - Transport System
338	311	41	2026-10-05 07:13:08.555925	A311	Błąd Lini Niverplst - Transport System
339	309	39	2026-10-05 07:14:08.889504	A309	Błąd Lini Niverplst - Easy Plast
340	310	41	2026-10-05 07:14:08.889504	A310	Alarm Lini Niverplast - Transport System
341	311	41	2026-10-05 07:14:08.889504	A311	Błąd Lini Niverplst - Transport System
342	309	39	2026-10-05 07:15:09.131449	A309	Błąd Lini Niverplst - Easy Plast
343	310	41	2026-10-05 07:15:09.131449	A310	Alarm Lini Niverplast - Transport System
344	311	41	2026-10-05 07:15:09.131449	A311	Błąd Lini Niverplst - Transport System
345	309	39	2026-10-05 07:16:09.459315	A309	Błąd Lini Niverplst - Easy Plast
346	310	41	2026-10-05 07:16:09.459315	A310	Alarm Lini Niverplast - Transport System
347	311	41	2026-10-05 07:16:09.459315	A311	Błąd Lini Niverplst - Transport System
348	309	39	2026-10-05 07:17:09.738428	A309	Błąd Lini Niverplst - Easy Plast
349	310	41	2026-10-05 07:17:09.738428	A310	Alarm Lini Niverplast - Transport System
350	311	41	2026-10-05 07:17:09.738428	A311	Błąd Lini Niverplst - Transport System
351	309	39	2026-10-05 07:18:10.062921	A309	Błąd Lini Niverplst - Easy Plast
352	310	41	2026-10-05 07:18:10.062921	A310	Alarm Lini Niverplast - Transport System
353	311	41	2026-10-05 07:18:10.062921	A311	Błąd Lini Niverplst - Transport System
354	309	39	2026-10-05 07:19:10.298323	A309	Błąd Lini Niverplst - Easy Plast
355	310	41	2026-10-05 07:19:10.298323	A310	Alarm Lini Niverplast - Transport System
356	311	41	2026-10-05 07:19:10.298323	A311	Błąd Lini Niverplst - Transport System
357	309	39	2026-10-05 07:20:08.653394	A309	Błąd Lini Niverplst - Easy Plast
358	310	41	2026-10-05 07:20:08.653394	A310	Alarm Lini Niverplast - Transport System
359	311	41	2026-10-05 07:20:08.653394	A311	Błąd Lini Niverplst - Transport System
360	309	39	2026-10-05 07:21:08.911289	A309	Błąd Lini Niverplst - Easy Plast
361	310	41	2026-10-05 07:21:08.911289	A310	Alarm Lini Niverplast - Transport System
362	311	41	2026-10-05 07:21:08.911289	A311	Błąd Lini Niverplst - Transport System
363	309	39	2026-10-05 07:22:09.240739	A309	Błąd Lini Niverplst - Easy Plast
364	310	41	2026-10-05 07:22:09.240739	A310	Alarm Lini Niverplast - Transport System
365	311	41	2026-10-05 07:22:09.240739	A311	Błąd Lini Niverplst - Transport System
366	309	39	2026-10-05 07:23:09.483596	A309	Błąd Lini Niverplst - Easy Plast
367	310	41	2026-10-05 07:23:09.483596	A310	Alarm Lini Niverplast - Transport System
368	311	41	2026-10-05 07:23:09.483596	A311	Błąd Lini Niverplst - Transport System
369	309	39	2026-10-05 07:24:09.823683	A309	Błąd Lini Niverplst - Easy Plast
370	310	41	2026-10-05 07:24:09.823683	A310	Alarm Lini Niverplast - Transport System
371	311	41	2026-10-05 07:24:09.823683	A311	Błąd Lini Niverplst - Transport System
372	309	39	2026-10-05 07:25:10.122368	A309	Błąd Lini Niverplst - Easy Plast
373	310	41	2026-10-05 07:25:10.122368	A310	Alarm Lini Niverplast - Transport System
374	311	41	2026-10-05 07:25:10.122368	A311	Błąd Lini Niverplst - Transport System
375	309	39	2026-10-05 07:26:10.427014	A309	Błąd Lini Niverplst - Easy Plast
376	310	41	2026-10-05 07:26:10.427014	A310	Alarm Lini Niverplast - Transport System
377	311	41	2026-10-05 07:26:10.427014	A311	Błąd Lini Niverplst - Transport System
378	309	39	2026-10-05 07:27:10.701237	A309	Błąd Lini Niverplst - Easy Plast
379	310	41	2026-10-05 07:27:10.701237	A310	Alarm Lini Niverplast - Transport System
380	311	41	2026-10-05 07:27:10.701237	A311	Błąd Lini Niverplst - Transport System
381	309	39	2026-10-05 07:28:10.990534	A309	Błąd Lini Niverplst - Easy Plast
382	310	41	2026-10-05 07:28:10.990534	A310	Alarm Lini Niverplast - Transport System
383	311	41	2026-10-05 07:28:10.990534	A311	Błąd Lini Niverplst - Transport System
384	309	39	2026-10-05 07:29:09.310811	A309	Błąd Lini Niverplst - Easy Plast
385	310	41	2026-10-05 07:29:09.310811	A310	Alarm Lini Niverplast - Transport System
386	311	41	2026-10-05 07:29:09.310811	A311	Błąd Lini Niverplst - Transport System
387	309	39	2026-10-05 07:30:09.650029	A309	Błąd Lini Niverplst - Easy Plast
388	310	41	2026-10-05 07:30:09.650029	A310	Alarm Lini Niverplast - Transport System
389	311	41	2026-10-05 07:30:09.650029	A311	Błąd Lini Niverplst - Transport System
390	309	39	2026-10-05 07:31:09.898474	A309	Błąd Lini Niverplst - Easy Plast
391	310	41	2026-10-05 07:31:09.898474	A310	Alarm Lini Niverplast - Transport System
392	311	41	2026-10-05 07:31:09.898474	A311	Błąd Lini Niverplst - Transport System
393	309	39	2026-10-05 07:32:10.250346	A309	Błąd Lini Niverplst - Easy Plast
394	310	41	2026-10-05 07:32:10.250346	A310	Alarm Lini Niverplast - Transport System
395	311	41	2026-10-05 07:32:10.250346	A311	Błąd Lini Niverplst - Transport System
396	309	39	2026-10-05 07:33:10.529428	A309	Błąd Lini Niverplst - Easy Plast
397	310	41	2026-10-05 07:33:10.529428	A310	Alarm Lini Niverplast - Transport System
398	311	41	2026-10-05 07:33:10.529428	A311	Błąd Lini Niverplst - Transport System
399	309	39	2026-10-05 07:34:10.832119	A309	Błąd Lini Niverplst - Easy Plast
400	310	41	2026-10-05 07:34:10.832119	A310	Alarm Lini Niverplast - Transport System
401	311	41	2026-10-05 07:34:10.832119	A311	Błąd Lini Niverplst - Transport System
402	309	39	2026-10-05 07:35:11.106709	A309	Błąd Lini Niverplst - Easy Plast
403	310	41	2026-10-05 07:35:11.106709	A310	Alarm Lini Niverplast - Transport System
404	311	41	2026-10-05 07:35:11.106709	A311	Błąd Lini Niverplst - Transport System
405	309	39	2026-10-05 07:36:11.379568	A309	Błąd Lini Niverplst - Easy Plast
406	310	41	2026-10-05 07:36:11.379568	A310	Alarm Lini Niverplast - Transport System
407	311	41	2026-10-05 07:36:11.379568	A311	Błąd Lini Niverplst - Transport System
408	309	39	2026-10-05 07:37:09.79228	A309	Błąd Lini Niverplst - Easy Plast
409	310	41	2026-10-05 07:37:09.79228	A310	Alarm Lini Niverplast - Transport System
410	311	41	2026-10-05 07:37:09.79228	A311	Błąd Lini Niverplst - Transport System
411	309	39	2026-10-05 07:38:09.996779	A309	Błąd Lini Niverplst - Easy Plast
412	310	41	2026-10-05 07:38:09.996779	A310	Alarm Lini Niverplast - Transport System
413	311	41	2026-10-05 07:38:09.996779	A311	Błąd Lini Niverplst - Transport System
414	309	39	2026-10-05 07:39:11.182456	A309	Błąd Lini Niverplst - Easy Plast
415	310	41	2026-10-05 07:39:11.182456	A310	Alarm Lini Niverplast - Transport System
416	311	41	2026-10-05 07:39:11.182456	A311	Błąd Lini Niverplst - Transport System
1246	182	40	2026-10-05 12:01:25.485018	A182	\N
417	309	39	2026-10-05 07:40:10.629572	A309	Błąd Lini Niverplst - Easy Plast
418	310	41	2026-10-05 07:40:10.629572	A310	Alarm Lini Niverplast - Transport System
419	311	41	2026-10-05 07:40:10.629572	A311	Błąd Lini Niverplst - Transport System
420	309	39	2026-10-05 07:41:10.949793	A309	Błąd Lini Niverplst - Easy Plast
421	310	41	2026-10-05 07:41:10.949793	A310	Alarm Lini Niverplast - Transport System
422	311	41	2026-10-05 07:41:10.949793	A311	Błąd Lini Niverplst - Transport System
423	309	39	2026-10-05 07:42:11.221323	A309	Błąd Lini Niverplst - Easy Plast
424	310	41	2026-10-05 07:42:11.221323	A310	Alarm Lini Niverplast - Transport System
425	311	41	2026-10-05 07:42:11.221323	A311	Błąd Lini Niverplst - Transport System
426	309	39	2026-10-05 07:43:11.521822	A309	Błąd Lini Niverplst - Easy Plast
427	310	41	2026-10-05 07:43:11.521822	A310	Alarm Lini Niverplast - Transport System
428	311	41	2026-10-05 07:43:11.521822	A311	Błąd Lini Niverplst - Transport System
429	309	39	2026-10-05 07:44:11.822485	A309	Błąd Lini Niverplst - Easy Plast
430	310	41	2026-10-05 07:44:11.822485	A310	Alarm Lini Niverplast - Transport System
431	311	41	2026-10-05 07:44:11.822485	A311	Błąd Lini Niverplst - Transport System
432	309	39	2026-10-05 07:45:10.121638	A309	Błąd Lini Niverplst - Easy Plast
433	310	41	2026-10-05 07:45:10.121638	A310	Alarm Lini Niverplast - Transport System
434	311	41	2026-10-05 07:45:10.121638	A311	Błąd Lini Niverplst - Transport System
435	309	39	2026-10-05 07:46:10.371127	A309	Błąd Lini Niverplst - Easy Plast
436	310	41	2026-10-05 07:46:10.371127	A310	Alarm Lini Niverplast - Transport System
437	311	41	2026-10-05 07:46:10.371127	A311	Błąd Lini Niverplst - Transport System
438	309	39	2026-10-05 07:47:10.741491	A309	Błąd Lini Niverplst - Easy Plast
439	310	41	2026-10-05 07:47:10.741491	A310	Alarm Lini Niverplast - Transport System
440	311	41	2026-10-05 07:47:10.741491	A311	Błąd Lini Niverplst - Transport System
441	309	39	2026-10-05 07:48:11.020255	A309	Błąd Lini Niverplst - Easy Plast
442	310	41	2026-10-05 07:48:11.020255	A310	Alarm Lini Niverplast - Transport System
443	311	41	2026-10-05 07:48:11.020255	A311	Błąd Lini Niverplst - Transport System
444	309	39	2026-10-05 07:49:11.359974	A309	Błąd Lini Niverplst - Easy Plast
445	310	41	2026-10-05 07:49:11.359974	A310	Alarm Lini Niverplast - Transport System
446	311	41	2026-10-05 07:49:11.359974	A311	Błąd Lini Niverplst - Transport System
447	309	39	2026-10-05 07:50:11.669346	A309	Błąd Lini Niverplst - Easy Plast
448	310	41	2026-10-05 07:50:11.669346	A310	Alarm Lini Niverplast - Transport System
449	311	41	2026-10-05 07:50:11.669346	A311	Błąd Lini Niverplst - Transport System
450	187	40	2026-10-05 07:51:11.966755	A187	Otwarta Bramka Bezpieczeństwa 
451	129	40	2026-10-05 07:51:11.966755	A129	Niskie ciśnienie pneumatyczne - strefa 1
452	309	39	2026-10-05 07:51:11.966755	A309	Błąd Lini Niverplst - Easy Plast
453	310	41	2026-10-05 07:51:11.966755	A310	Alarm Lini Niverplast - Transport System
454	311	41	2026-10-05 07:51:11.966755	A311	Błąd Lini Niverplst - Transport System
455	188	40	2026-10-05 07:51:11.966755	A188	Nieryglowany zamek bramki bezpieszeństwa
456	309	39	2026-10-05 07:52:12.242566	A309	Błąd Lini Niverplst - Easy Plast
457	310	41	2026-10-05 07:52:12.242566	A310	Alarm Lini Niverplast - Transport System
458	311	41	2026-10-05 07:52:12.242566	A311	Błąd Lini Niverplst - Transport System
459	309	39	2026-10-05 07:53:10.603553	A309	Błąd Lini Niverplst - Easy Plast
460	310	41	2026-10-05 07:53:10.603553	A310	Alarm Lini Niverplast - Transport System
461	311	41	2026-10-05 07:53:10.603553	A311	Błąd Lini Niverplst - Transport System
462	309	39	2026-10-05 07:54:10.845588	A309	Błąd Lini Niverplst - Easy Plast
463	310	41	2026-10-05 07:54:10.845588	A310	Alarm Lini Niverplast - Transport System
464	311	41	2026-10-05 07:54:10.845588	A311	Błąd Lini Niverplst - Transport System
465	309	39	2026-10-05 07:55:11.196707	A309	Błąd Lini Niverplst - Easy Plast
466	310	41	2026-10-05 07:55:11.196707	A310	Alarm Lini Niverplast - Transport System
467	311	41	2026-10-05 07:55:11.196707	A311	Błąd Lini Niverplst - Transport System
468	309	39	2026-10-05 07:56:11.46014	A309	Błąd Lini Niverplst - Easy Plast
469	310	41	2026-10-05 07:56:11.46014	A310	Alarm Lini Niverplast - Transport System
470	311	41	2026-10-05 07:56:11.46014	A311	Błąd Lini Niverplst - Transport System
471	309	39	2026-10-05 07:57:11.781637	A309	Błąd Lini Niverplst - Easy Plast
472	310	41	2026-10-05 07:57:11.781637	A310	Alarm Lini Niverplast - Transport System
473	311	41	2026-10-05 07:57:11.781637	A311	Błąd Lini Niverplst - Transport System
474	309	39	2026-10-05 07:58:12.075068	A309	Błąd Lini Niverplst - Easy Plast
475	310	41	2026-10-05 07:58:12.075068	A310	Alarm Lini Niverplast - Transport System
476	311	41	2026-10-05 07:58:12.075068	A311	Błąd Lini Niverplst - Transport System
477	309	39	2026-10-05 07:59:12.384675	A309	Błąd Lini Niverplst - Easy Plast
478	310	41	2026-10-05 07:59:12.384675	A310	Alarm Lini Niverplast - Transport System
479	311	41	2026-10-05 07:59:12.384675	A311	Błąd Lini Niverplst - Transport System
480	309	39	2026-10-05 08:00:12.67361	A309	Błąd Lini Niverplst - Easy Plast
481	310	41	2026-10-05 08:00:12.67361	A310	Alarm Lini Niverplast - Transport System
482	311	41	2026-10-05 08:00:12.67361	A311	Błąd Lini Niverplst - Transport System
483	309	39	2026-10-05 08:01:10.979776	A309	Błąd Lini Niverplst - Easy Plast
484	310	41	2026-10-05 08:01:10.979776	A310	Alarm Lini Niverplast - Transport System
485	311	41	2026-10-05 08:01:10.979776	A311	Błąd Lini Niverplst - Transport System
486	309	39	2026-10-05 08:02:11.359128	A309	Błąd Lini Niverplst - Easy Plast
487	310	41	2026-10-05 08:02:11.359128	A310	Alarm Lini Niverplast - Transport System
488	311	41	2026-10-05 08:02:11.359128	A311	Błąd Lini Niverplst - Transport System
489	309	39	2026-10-05 08:03:11.598404	A309	Błąd Lini Niverplst - Easy Plast
490	310	41	2026-10-05 08:03:11.598404	A310	Alarm Lini Niverplast - Transport System
491	311	41	2026-10-05 08:03:11.598404	A311	Błąd Lini Niverplst - Transport System
492	309	39	2026-10-05 08:04:11.857118	A309	Błąd Lini Niverplst - Easy Plast
493	310	41	2026-10-05 08:04:11.857118	A310	Alarm Lini Niverplast - Transport System
494	311	41	2026-10-05 08:04:11.857118	A311	Błąd Lini Niverplst - Transport System
495	309	39	2026-10-05 08:05:12.262269	A309	Błąd Lini Niverplst - Easy Plast
496	310	41	2026-10-05 08:05:12.262269	A310	Alarm Lini Niverplast - Transport System
497	311	41	2026-10-05 08:05:12.262269	A311	Błąd Lini Niverplst - Transport System
498	309	39	2026-10-05 08:06:12.518014	A309	Błąd Lini Niverplst - Easy Plast
499	310	41	2026-10-05 08:06:12.518014	A310	Alarm Lini Niverplast - Transport System
1252	182	40	2026-10-05 12:02:25.773512	A182	\N
500	311	41	2026-10-05 08:06:12.518014	A311	Błąd Lini Niverplst - Transport System
501	309	39	2026-10-05 08:07:12.85134	A309	Błąd Lini Niverplst - Easy Plast
502	310	41	2026-10-05 08:07:12.85134	A310	Alarm Lini Niverplast - Transport System
503	311	41	2026-10-05 08:07:12.85134	A311	Błąd Lini Niverplst - Transport System
504	309	39	2026-10-05 08:08:13.141686	A309	Błąd Lini Niverplst - Easy Plast
505	310	41	2026-10-05 08:08:13.141686	A310	Alarm Lini Niverplast - Transport System
506	311	41	2026-10-05 08:08:13.141686	A311	Błąd Lini Niverplst - Transport System
507	309	39	2026-10-05 08:09:11.407421	A309	Błąd Lini Niverplst - Easy Plast
508	310	41	2026-10-05 08:09:11.407421	A310	Alarm Lini Niverplast - Transport System
509	311	41	2026-10-05 08:09:11.407421	A311	Błąd Lini Niverplst - Transport System
510	309	39	2026-10-05 08:10:11.758226	A309	Błąd Lini Niverplst - Easy Plast
511	310	41	2026-10-05 08:10:11.758226	A310	Alarm Lini Niverplast - Transport System
512	311	41	2026-10-05 08:10:11.758226	A311	Błąd Lini Niverplst - Transport System
513	309	39	2026-10-05 08:11:12.016537	A309	Błąd Lini Niverplst - Easy Plast
514	310	41	2026-10-05 08:11:12.016537	A310	Alarm Lini Niverplast - Transport System
515	311	41	2026-10-05 08:11:12.016537	A311	Błąd Lini Niverplst - Transport System
516	309	39	2026-10-05 08:12:12.360014	A309	Błąd Lini Niverplst - Easy Plast
517	310	41	2026-10-05 08:12:12.360014	A310	Alarm Lini Niverplast - Transport System
518	311	41	2026-10-05 08:12:12.360014	A311	Błąd Lini Niverplst - Transport System
519	309	39	2026-10-05 08:13:12.660518	A309	Błąd Lini Niverplst - Easy Plast
520	310	41	2026-10-05 08:13:12.660518	A310	Alarm Lini Niverplast - Transport System
521	311	41	2026-10-05 08:13:12.660518	A311	Błąd Lini Niverplst - Transport System
522	309	39	2026-10-05 08:14:12.997776	A309	Błąd Lini Niverplst - Easy Plast
523	310	41	2026-10-05 08:14:12.997776	A310	Alarm Lini Niverplast - Transport System
524	311	41	2026-10-05 08:14:12.997776	A311	Błąd Lini Niverplst - Transport System
525	309	39	2026-10-05 08:15:13.276106	A309	Błąd Lini Niverplst - Easy Plast
526	310	41	2026-10-05 08:15:13.276106	A310	Alarm Lini Niverplast - Transport System
527	311	41	2026-10-05 08:15:13.276106	A311	Błąd Lini Niverplst - Transport System
528	309	39	2026-10-05 08:16:13.580313	A309	Błąd Lini Niverplst - Easy Plast
529	310	41	2026-10-05 08:16:13.580313	A310	Alarm Lini Niverplast - Transport System
530	311	41	2026-10-05 08:16:13.580313	A311	Błąd Lini Niverplst - Transport System
531	309	39	2026-10-05 08:17:13.861982	A309	Błąd Lini Niverplst - Easy Plast
532	310	41	2026-10-05 08:17:13.861982	A310	Alarm Lini Niverplast - Transport System
533	311	41	2026-10-05 08:17:13.861982	A311	Błąd Lini Niverplst - Transport System
534	309	39	2026-10-05 08:18:12.1976	A309	Błąd Lini Niverplst - Easy Plast
535	310	41	2026-10-05 08:18:12.1976	A310	Alarm Lini Niverplast - Transport System
536	311	41	2026-10-05 08:18:12.1976	A311	Błąd Lini Niverplst - Transport System
537	309	39	2026-10-05 08:19:12.468424	A309	Błąd Lini Niverplst - Easy Plast
538	310	41	2026-10-05 08:19:12.468424	A310	Alarm Lini Niverplast - Transport System
539	311	41	2026-10-05 08:19:12.468424	A311	Błąd Lini Niverplst - Transport System
540	309	39	2026-10-05 08:20:12.766358	A309	Błąd Lini Niverplst - Easy Plast
541	310	41	2026-10-05 08:20:12.766358	A310	Alarm Lini Niverplast - Transport System
542	311	41	2026-10-05 08:20:12.766358	A311	Błąd Lini Niverplst - Transport System
543	309	39	2026-10-05 08:21:13.10599	A309	Błąd Lini Niverplst - Easy Plast
544	310	41	2026-10-05 08:21:13.10599	A310	Alarm Lini Niverplast - Transport System
545	311	41	2026-10-05 08:21:13.10599	A311	Błąd Lini Niverplst - Transport System
546	309	39	2026-10-05 08:22:13.409384	A309	Błąd Lini Niverplst - Easy Plast
547	310	41	2026-10-05 08:22:13.409384	A310	Alarm Lini Niverplast - Transport System
548	311	41	2026-10-05 08:22:13.409384	A311	Błąd Lini Niverplst - Transport System
549	309	39	2026-10-05 08:23:13.705389	A309	Błąd Lini Niverplst - Easy Plast
550	310	41	2026-10-05 08:23:13.705389	A310	Alarm Lini Niverplast - Transport System
551	311	41	2026-10-05 08:23:13.705389	A311	Błąd Lini Niverplst - Transport System
552	309	39	2026-10-05 08:24:13.999591	A309	Błąd Lini Niverplst - Easy Plast
553	310	41	2026-10-05 08:24:13.999591	A310	Alarm Lini Niverplast - Transport System
554	311	41	2026-10-05 08:24:13.999591	A311	Błąd Lini Niverplst - Transport System
555	309	39	2026-10-05 08:25:14.301908	A309	Błąd Lini Niverplst - Easy Plast
556	310	41	2026-10-05 08:25:14.301908	A310	Alarm Lini Niverplast - Transport System
557	311	41	2026-10-05 08:25:14.301908	A311	Błąd Lini Niverplst - Transport System
558	309	39	2026-10-05 08:26:12.595102	A309	Błąd Lini Niverplst - Easy Plast
559	310	41	2026-10-05 08:26:12.595102	A310	Alarm Lini Niverplast - Transport System
560	311	41	2026-10-05 08:26:12.595102	A311	Błąd Lini Niverplst - Transport System
561	309	39	2026-10-05 08:27:12.808184	A309	Błąd Lini Niverplst - Easy Plast
562	310	41	2026-10-05 08:27:12.808184	A310	Alarm Lini Niverplast - Transport System
563	311	41	2026-10-05 08:27:12.808184	A311	Błąd Lini Niverplst - Transport System
564	309	39	2026-10-05 08:28:13.272368	A309	Błąd Lini Niverplst - Easy Plast
565	310	41	2026-10-05 08:28:13.272368	A310	Alarm Lini Niverplast - Transport System
566	311	41	2026-10-05 08:28:13.272368	A311	Błąd Lini Niverplst - Transport System
567	309	39	2026-10-05 08:29:13.501408	A309	Błąd Lini Niverplst - Easy Plast
568	310	41	2026-10-05 08:29:13.501408	A310	Alarm Lini Niverplast - Transport System
569	311	41	2026-10-05 08:29:13.501408	A311	Błąd Lini Niverplst - Transport System
570	309	39	2026-10-05 08:30:13.865317	A309	Błąd Lini Niverplst - Easy Plast
571	310	41	2026-10-05 08:30:13.865317	A310	Alarm Lini Niverplast - Transport System
572	311	41	2026-10-05 08:30:13.865317	A311	Błąd Lini Niverplst - Transport System
573	309	39	2026-10-05 08:31:14.143229	A309	Błąd Lini Niverplst - Easy Plast
574	310	41	2026-10-05 08:31:14.143229	A310	Alarm Lini Niverplast - Transport System
575	311	41	2026-10-05 08:31:14.143229	A311	Błąd Lini Niverplst - Transport System
576	309	39	2026-10-05 08:32:14.460714	A309	Błąd Lini Niverplst - Easy Plast
577	310	41	2026-10-05 08:32:14.460714	A310	Alarm Lini Niverplast - Transport System
578	311	41	2026-10-05 08:32:14.460714	A311	Błąd Lini Niverplst - Transport System
579	309	39	2026-10-05 08:33:14.755146	A309	Błąd Lini Niverplst - Easy Plast
580	310	41	2026-10-05 08:33:14.755146	A310	Alarm Lini Niverplast - Transport System
581	311	41	2026-10-05 08:33:14.755146	A311	Błąd Lini Niverplst - Transport System
582	309	39	2026-10-05 08:34:13.023167	A309	Błąd Lini Niverplst - Easy Plast
1258	182	40	2026-10-05 12:03:26.130785	A182	\N
583	310	41	2026-10-05 08:34:13.023167	A310	Alarm Lini Niverplast - Transport System
584	311	41	2026-10-05 08:34:13.023167	A311	Błąd Lini Niverplst - Transport System
585	309	39	2026-10-05 08:35:13.375365	A309	Błąd Lini Niverplst - Easy Plast
586	310	41	2026-10-05 08:35:13.375365	A310	Alarm Lini Niverplast - Transport System
587	311	41	2026-10-05 08:35:13.375365	A311	Błąd Lini Niverplst - Transport System
588	309	39	2026-10-05 08:36:13.638589	A309	Błąd Lini Niverplst - Easy Plast
589	310	41	2026-10-05 08:36:13.638589	A310	Alarm Lini Niverplast - Transport System
590	311	41	2026-10-05 08:36:13.638589	A311	Błąd Lini Niverplst - Transport System
591	309	39	2026-10-05 08:37:13.992101	A309	Błąd Lini Niverplst - Easy Plast
592	310	41	2026-10-05 08:37:13.992101	A310	Alarm Lini Niverplast - Transport System
593	311	41	2026-10-05 08:37:13.992101	A311	Błąd Lini Niverplst - Transport System
594	309	39	2026-10-05 08:38:14.281614	A309	Błąd Lini Niverplst - Easy Plast
595	310	41	2026-10-05 08:38:14.281614	A310	Alarm Lini Niverplast - Transport System
596	311	41	2026-10-05 08:38:14.281614	A311	Błąd Lini Niverplst - Transport System
597	309	39	2026-10-05 08:39:14.595887	A309	Błąd Lini Niverplst - Easy Plast
598	310	41	2026-10-05 08:39:14.595887	A310	Alarm Lini Niverplast - Transport System
599	311	41	2026-10-05 08:39:14.595887	A311	Błąd Lini Niverplst - Transport System
600	309	39	2026-10-05 08:40:14.876943	A309	Błąd Lini Niverplst - Easy Plast
601	310	41	2026-10-05 08:40:14.876943	A310	Alarm Lini Niverplast - Transport System
602	311	41	2026-10-05 08:40:14.876943	A311	Błąd Lini Niverplst - Transport System
603	309	39	2026-10-05 08:41:15.182119	A309	Błąd Lini Niverplst - Easy Plast
604	310	41	2026-10-05 08:41:15.182119	A310	Alarm Lini Niverplast - Transport System
605	311	41	2026-10-05 08:41:15.182119	A311	Błąd Lini Niverplst - Transport System
606	309	39	2026-10-05 08:42:13.463554	A309	Błąd Lini Niverplst - Easy Plast
607	310	41	2026-10-05 08:42:13.463554	A310	Alarm Lini Niverplast - Transport System
608	311	41	2026-10-05 08:42:13.463554	A311	Błąd Lini Niverplst - Transport System
609	309	39	2026-10-05 08:43:13.732468	A309	Błąd Lini Niverplst - Easy Plast
610	310	41	2026-10-05 08:43:13.732468	A310	Alarm Lini Niverplast - Transport System
611	311	41	2026-10-05 08:43:13.732468	A311	Błąd Lini Niverplst - Transport System
612	309	39	2026-10-05 08:44:14.064441	A309	Błąd Lini Niverplst - Easy Plast
613	310	41	2026-10-05 08:44:14.064441	A310	Alarm Lini Niverplast - Transport System
614	311	41	2026-10-05 08:44:14.064441	A311	Błąd Lini Niverplst - Transport System
615	309	39	2026-10-05 08:45:14.393556	A309	Błąd Lini Niverplst - Easy Plast
616	310	41	2026-10-05 08:45:14.393556	A310	Alarm Lini Niverplast - Transport System
617	311	41	2026-10-05 08:45:14.393556	A311	Błąd Lini Niverplst - Transport System
618	309	39	2026-10-05 08:46:14.696355	A309	Błąd Lini Niverplst - Easy Plast
619	310	41	2026-10-05 08:46:14.696355	A310	Alarm Lini Niverplast - Transport System
620	311	41	2026-10-05 08:46:14.696355	A311	Błąd Lini Niverplst - Transport System
621	309	39	2026-10-05 08:47:15.029876	A309	Błąd Lini Niverplst - Easy Plast
622	310	41	2026-10-05 08:47:15.029876	A310	Alarm Lini Niverplast - Transport System
623	311	41	2026-10-05 08:47:15.029876	A311	Błąd Lini Niverplst - Transport System
624	309	39	2026-10-05 08:48:15.321015	A309	Błąd Lini Niverplst - Easy Plast
625	310	41	2026-10-05 08:48:15.321015	A310	Alarm Lini Niverplast - Transport System
626	311	41	2026-10-05 08:48:15.321015	A311	Błąd Lini Niverplst - Transport System
627	309	39	2026-10-05 08:49:15.60784	A309	Błąd Lini Niverplst - Easy Plast
628	310	41	2026-10-05 08:49:15.60784	A310	Alarm Lini Niverplast - Transport System
629	311	41	2026-10-05 08:49:15.60784	A311	Błąd Lini Niverplst - Transport System
630	309	39	2026-10-05 08:50:13.840875	A309	Błąd Lini Niverplst - Easy Plast
631	310	41	2026-10-05 08:50:13.840875	A310	Alarm Lini Niverplast - Transport System
632	311	41	2026-10-05 08:50:13.840875	A311	Błąd Lini Niverplst - Transport System
633	309	39	2026-10-05 08:51:14.248464	A309	Błąd Lini Niverplst - Easy Plast
634	310	41	2026-10-05 08:51:14.248464	A310	Alarm Lini Niverplast - Transport System
635	311	41	2026-10-05 08:51:14.248464	A311	Błąd Lini Niverplst - Transport System
636	309	39	2026-10-05 08:52:14.464117	A309	Błąd Lini Niverplst - Easy Plast
637	310	41	2026-10-05 08:52:14.464117	A310	Alarm Lini Niverplast - Transport System
638	311	41	2026-10-05 08:52:14.464117	A311	Błąd Lini Niverplst - Transport System
639	309	39	2026-10-05 08:53:14.868446	A309	Błąd Lini Niverplst - Easy Plast
640	310	41	2026-10-05 08:53:14.868446	A310	Alarm Lini Niverplast - Transport System
641	311	41	2026-10-05 08:53:14.868446	A311	Błąd Lini Niverplst - Transport System
642	309	39	2026-10-05 08:54:14.057652	A309	Błąd Lini Niverplst - Easy Plast
643	310	41	2026-10-05 08:54:14.057652	A310	Alarm Lini Niverplast - Transport System
644	311	41	2026-10-05 08:54:14.057652	A311	Błąd Lini Niverplst - Transport System
645	309	39	2026-10-05 08:55:15.503765	A309	Błąd Lini Niverplst - Easy Plast
646	310	41	2026-10-05 08:55:15.503765	A310	Alarm Lini Niverplast - Transport System
647	311	41	2026-10-05 08:55:15.503765	A311	Błąd Lini Niverplst - Transport System
648	309	39	2026-10-05 08:56:15.774675	A309	Błąd Lini Niverplst - Easy Plast
649	310	41	2026-10-05 08:56:15.774675	A310	Alarm Lini Niverplast - Transport System
650	311	41	2026-10-05 08:56:15.774675	A311	Błąd Lini Niverplst - Transport System
651	309	39	2026-10-05 08:57:16.099863	A309	Błąd Lini Niverplst - Easy Plast
652	310	41	2026-10-05 08:57:16.099863	A310	Alarm Lini Niverplast - Transport System
653	311	41	2026-10-05 08:57:16.099863	A311	Błąd Lini Niverplst - Transport System
654	309	39	2026-10-05 08:58:14.444586	A309	Błąd Lini Niverplst - Easy Plast
655	310	41	2026-10-05 08:58:14.444586	A310	Alarm Lini Niverplast - Transport System
656	311	41	2026-10-05 08:58:14.444586	A311	Błąd Lini Niverplst - Transport System
657	309	39	2026-10-05 08:59:14.604743	A309	Błąd Lini Niverplst - Easy Plast
658	310	41	2026-10-05 08:59:14.604743	A310	Alarm Lini Niverplast - Transport System
659	311	41	2026-10-05 08:59:14.604743	A311	Błąd Lini Niverplst - Transport System
660	309	39	2026-10-05 09:00:14.988092	A309	Błąd Lini Niverplst - Easy Plast
661	310	41	2026-10-05 09:00:14.988092	A310	Alarm Lini Niverplast - Transport System
662	311	41	2026-10-05 09:00:14.988092	A311	Błąd Lini Niverplst - Transport System
663	309	39	2026-10-05 09:01:15.245546	A309	Błąd Lini Niverplst - Easy Plast
664	310	41	2026-10-05 09:01:15.245546	A310	Alarm Lini Niverplast - Transport System
665	311	41	2026-10-05 09:01:15.245546	A311	Błąd Lini Niverplst - Transport System
1264	182	40	2026-10-05 12:04:26.424822	A182	\N
666	309	39	2026-10-05 09:02:15.620652	A309	Błąd Lini Niverplst - Easy Plast
667	310	41	2026-10-05 09:02:15.620652	A310	Alarm Lini Niverplast - Transport System
668	311	41	2026-10-05 09:02:15.620652	A311	Błąd Lini Niverplst - Transport System
669	309	39	2026-10-05 09:03:15.909267	A309	Błąd Lini Niverplst - Easy Plast
670	310	41	2026-10-05 09:03:15.909267	A310	Alarm Lini Niverplast - Transport System
671	311	41	2026-10-05 09:03:15.909267	A311	Błąd Lini Niverplst - Transport System
672	309	39	2026-10-05 09:04:16.218393	A309	Błąd Lini Niverplst - Easy Plast
673	310	41	2026-10-05 09:04:16.218393	A310	Alarm Lini Niverplast - Transport System
674	311	41	2026-10-05 09:04:16.218393	A311	Błąd Lini Niverplst - Transport System
675	309	39	2026-10-05 09:05:16.511863	A309	Błąd Lini Niverplst - Easy Plast
676	310	41	2026-10-05 09:05:16.511863	A310	Alarm Lini Niverplast - Transport System
677	311	41	2026-10-05 09:05:16.511863	A311	Błąd Lini Niverplst - Transport System
678	309	39	2026-10-05 09:06:14.75784	A309	Błąd Lini Niverplst - Easy Plast
679	310	41	2026-10-05 09:06:14.75784	A310	Alarm Lini Niverplast - Transport System
680	311	41	2026-10-05 09:06:14.75784	A311	Błąd Lini Niverplst - Transport System
681	309	39	2026-10-05 09:07:15.070523	A309	Błąd Lini Niverplst - Easy Plast
682	310	41	2026-10-05 09:07:15.070523	A310	Alarm Lini Niverplast - Transport System
683	311	41	2026-10-05 09:07:15.070523	A311	Błąd Lini Niverplst - Transport System
684	309	39	2026-10-05 09:08:15.363123	A309	Błąd Lini Niverplst - Easy Plast
685	310	41	2026-10-05 09:08:15.363123	A310	Alarm Lini Niverplast - Transport System
686	311	41	2026-10-05 09:08:15.363123	A311	Błąd Lini Niverplst - Transport System
687	309	39	2026-10-05 09:09:15.712107	A309	Błąd Lini Niverplst - Easy Plast
688	310	41	2026-10-05 09:09:15.712107	A310	Alarm Lini Niverplast - Transport System
689	311	41	2026-10-05 09:09:15.712107	A311	Błąd Lini Niverplst - Transport System
690	309	39	2026-10-05 09:10:16.031128	A309	Błąd Lini Niverplst - Easy Plast
691	310	41	2026-10-05 09:10:16.031128	A310	Alarm Lini Niverplast - Transport System
692	311	41	2026-10-05 09:10:16.031128	A311	Błąd Lini Niverplst - Transport System
693	309	39	2026-10-05 09:11:16.401373	A309	Błąd Lini Niverplst - Easy Plast
694	310	41	2026-10-05 09:11:16.401373	A310	Alarm Lini Niverplast - Transport System
695	311	41	2026-10-05 09:11:16.401373	A311	Błąd Lini Niverplst - Transport System
696	309	39	2026-10-05 09:12:16.661071	A309	Błąd Lini Niverplst - Easy Plast
697	310	41	2026-10-05 09:12:16.661071	A310	Alarm Lini Niverplast - Transport System
698	311	41	2026-10-05 09:12:16.661071	A311	Błąd Lini Niverplst - Transport System
699	309	39	2026-10-05 09:13:16.971003	A309	Błąd Lini Niverplst - Easy Plast
700	310	41	2026-10-05 09:13:16.971003	A310	Alarm Lini Niverplast - Transport System
701	311	41	2026-10-05 09:13:16.971003	A311	Błąd Lini Niverplst - Transport System
702	309	39	2026-10-05 09:14:15.289726	A309	Błąd Lini Niverplst - Easy Plast
703	310	41	2026-10-05 09:14:15.289726	A310	Alarm Lini Niverplast - Transport System
704	311	41	2026-10-05 09:14:15.289726	A311	Błąd Lini Niverplst - Transport System
705	309	39	2026-10-05 09:15:15.498522	A309	Błąd Lini Niverplst - Easy Plast
706	310	41	2026-10-05 09:15:15.498522	A310	Alarm Lini Niverplast - Transport System
707	311	41	2026-10-05 09:15:15.498522	A311	Błąd Lini Niverplst - Transport System
708	309	39	2026-10-05 09:16:15.894569	A309	Błąd Lini Niverplst - Easy Plast
709	310	41	2026-10-05 09:16:15.894569	A310	Alarm Lini Niverplast - Transport System
710	311	41	2026-10-05 09:16:15.894569	A311	Błąd Lini Niverplst - Transport System
711	309	39	2026-10-05 09:17:16.160825	A309	Błąd Lini Niverplst - Easy Plast
712	310	41	2026-10-05 09:17:16.160825	A310	Alarm Lini Niverplast - Transport System
713	311	41	2026-10-05 09:17:16.160825	A311	Błąd Lini Niverplst - Transport System
714	309	39	2026-10-05 09:18:16.524615	A309	Błąd Lini Niverplst - Easy Plast
715	310	41	2026-10-05 09:18:16.524615	A310	Alarm Lini Niverplast - Transport System
716	311	41	2026-10-05 09:18:16.524615	A311	Błąd Lini Niverplst - Transport System
717	309	39	2026-10-05 09:19:16.799575	A309	Błąd Lini Niverplst - Easy Plast
718	310	41	2026-10-05 09:19:16.799575	A310	Alarm Lini Niverplast - Transport System
719	311	41	2026-10-05 09:19:16.799575	A311	Błąd Lini Niverplst - Transport System
720	309	39	2026-10-05 09:20:17.124172	A309	Błąd Lini Niverplst - Easy Plast
721	310	41	2026-10-05 09:20:17.124172	A310	Alarm Lini Niverplast - Transport System
722	311	41	2026-10-05 09:20:17.124172	A311	Błąd Lini Niverplst - Transport System
723	309	39	2026-10-05 09:21:17.415821	A309	Błąd Lini Niverplst - Easy Plast
724	310	41	2026-10-05 09:21:17.415821	A310	Alarm Lini Niverplast - Transport System
725	311	41	2026-10-05 09:21:17.415821	A311	Błąd Lini Niverplst - Transport System
726	309	39	2026-10-05 09:22:15.658766	A309	Błąd Lini Niverplst - Easy Plast
727	310	41	2026-10-05 09:22:15.658766	A310	Alarm Lini Niverplast - Transport System
728	311	41	2026-10-05 09:22:15.658766	A311	Błąd Lini Niverplst - Transport System
729	309	39	2026-10-05 09:23:16.052212	A309	Błąd Lini Niverplst - Easy Plast
730	310	41	2026-10-05 09:23:16.052212	A310	Alarm Lini Niverplast - Transport System
731	311	41	2026-10-05 09:23:16.052212	A311	Błąd Lini Niverplst - Transport System
732	309	39	2026-10-05 09:24:16.296091	A309	Błąd Lini Niverplst - Easy Plast
733	310	41	2026-10-05 09:24:16.296091	A310	Alarm Lini Niverplast - Transport System
734	311	41	2026-10-05 09:24:16.296091	A311	Błąd Lini Niverplst - Transport System
735	309	39	2026-10-05 09:25:16.662015	A309	Błąd Lini Niverplst - Easy Plast
736	310	41	2026-10-05 09:25:16.662015	A310	Alarm Lini Niverplast - Transport System
737	311	41	2026-10-05 09:25:16.662015	A311	Błąd Lini Niverplst - Transport System
738	309	39	2026-10-05 09:26:16.951333	A309	Błąd Lini Niverplst - Easy Plast
739	310	41	2026-10-05 09:26:16.951333	A310	Alarm Lini Niverplast - Transport System
740	311	41	2026-10-05 09:26:16.951333	A311	Błąd Lini Niverplst - Transport System
741	309	39	2026-10-05 09:27:17.297718	A309	Błąd Lini Niverplst - Easy Plast
742	310	41	2026-10-05 09:27:17.297718	A310	Alarm Lini Niverplast - Transport System
743	311	41	2026-10-05 09:27:17.297718	A311	Błąd Lini Niverplst - Transport System
744	309	39	2026-10-05 09:28:17.564264	A309	Błąd Lini Niverplst - Easy Plast
745	310	41	2026-10-05 09:28:17.564264	A310	Alarm Lini Niverplast - Transport System
746	311	41	2026-10-05 09:28:17.564264	A311	Błąd Lini Niverplst - Transport System
747	309	39	2026-10-05 09:29:17.873853	A309	Błąd Lini Niverplst - Easy Plast
748	310	41	2026-10-05 09:29:17.873853	A310	Alarm Lini Niverplast - Transport System
1270	182	40	2026-10-05 12:05:26.769497	A182	\N
749	311	41	2026-10-05 09:29:17.873853	A311	Błąd Lini Niverplst - Transport System
750	193	40	2026-10-05 09:30:16.146224	A193	Niskie ciśnienie pneumatyczne - strefa 2
751	241	40	2026-10-05 09:30:16.146224	A241	Niskie ciśnienie pneumatyczne - strefa 3
752	309	39	2026-10-05 09:30:16.146224	A309	Błąd Lini Niverplst - Easy Plast
753	310	41	2026-10-05 09:30:16.146224	A310	Alarm Lini Niverplast - Transport System
754	311	41	2026-10-05 09:30:16.146224	A311	Błąd Lini Niverplst - Transport System
755	225	8	2026-10-05 09:30:16.146224	A225	Otwarta Bramka Bezpieczeństwa
756	226	9	2026-10-05 09:30:16.146224	A226	Niezaryglowany zamek bramki bezpieczenstwa 
757	193	40	2026-10-05 09:31:16.39894	A193	Niskie ciśnienie pneumatyczne - strefa 2
758	241	40	2026-10-05 09:31:16.39894	A241	Niskie ciśnienie pneumatyczne - strefa 3
759	309	39	2026-10-05 09:31:16.39894	A309	Błąd Lini Niverplst - Easy Plast
760	310	41	2026-10-05 09:31:16.39894	A310	Alarm Lini Niverplast - Transport System
761	311	41	2026-10-05 09:31:16.39894	A311	Błąd Lini Niverplst - Transport System
762	225	8	2026-10-05 09:31:16.39894	A225	Otwarta Bramka Bezpieczeństwa
763	226	9	2026-10-05 09:31:16.39894	A226	Niezaryglowany zamek bramki bezpieczenstwa 
764	193	40	2026-10-05 09:32:16.745379	A193	Niskie ciśnienie pneumatyczne - strefa 2
765	241	40	2026-10-05 09:32:16.745379	A241	Niskie ciśnienie pneumatyczne - strefa 3
766	309	39	2026-10-05 09:32:16.745379	A309	Błąd Lini Niverplst - Easy Plast
767	310	41	2026-10-05 09:32:16.745379	A310	Alarm Lini Niverplast - Transport System
768	311	41	2026-10-05 09:32:16.745379	A311	Błąd Lini Niverplst - Transport System
769	225	8	2026-10-05 09:32:16.745379	A225	Otwarta Bramka Bezpieczeństwa
770	226	9	2026-10-05 09:32:16.745379	A226	Niezaryglowany zamek bramki bezpieczenstwa 
771	193	40	2026-10-05 09:33:17.075618	A193	Niskie ciśnienie pneumatyczne - strefa 2
772	241	40	2026-10-05 09:33:17.075618	A241	Niskie ciśnienie pneumatyczne - strefa 3
773	309	39	2026-10-05 09:33:17.075618	A309	Błąd Lini Niverplst - Easy Plast
774	310	41	2026-10-05 09:33:17.075618	A310	Alarm Lini Niverplast - Transport System
775	311	41	2026-10-05 09:33:17.075618	A311	Błąd Lini Niverplst - Transport System
776	225	8	2026-10-05 09:33:17.075618	A225	Otwarta Bramka Bezpieczeństwa
777	226	9	2026-10-05 09:33:17.075618	A226	Niezaryglowany zamek bramki bezpieczenstwa 
778	193	40	2026-10-05 09:34:17.331876	A193	Niskie ciśnienie pneumatyczne - strefa 2
779	241	40	2026-10-05 09:34:17.331876	A241	Niskie ciśnienie pneumatyczne - strefa 3
780	309	39	2026-10-05 09:34:17.331876	A309	Błąd Lini Niverplst - Easy Plast
781	310	41	2026-10-05 09:34:17.331876	A310	Alarm Lini Niverplast - Transport System
782	311	41	2026-10-05 09:34:17.331876	A311	Błąd Lini Niverplst - Transport System
783	225	8	2026-10-05 09:34:17.331876	A225	Otwarta Bramka Bezpieczeństwa
784	226	9	2026-10-05 09:34:17.331876	A226	Niezaryglowany zamek bramki bezpieczenstwa 
785	193	40	2026-10-05 09:35:17.731806	A193	Niskie ciśnienie pneumatyczne - strefa 2
786	241	40	2026-10-05 09:35:17.731806	A241	Niskie ciśnienie pneumatyczne - strefa 3
787	309	39	2026-10-05 09:35:17.731806	A309	Błąd Lini Niverplst - Easy Plast
788	310	41	2026-10-05 09:35:17.731806	A310	Alarm Lini Niverplast - Transport System
789	311	41	2026-10-05 09:35:17.731806	A311	Błąd Lini Niverplst - Transport System
790	225	8	2026-10-05 09:35:17.731806	A225	Otwarta Bramka Bezpieczeństwa
791	226	9	2026-10-05 09:35:17.731806	A226	Niezaryglowany zamek bramki bezpieczenstwa 
792	193	40	2026-10-05 09:36:18.079954	A193	Niskie ciśnienie pneumatyczne - strefa 2
793	241	40	2026-10-05 09:36:18.079954	A241	Niskie ciśnienie pneumatyczne - strefa 3
794	309	39	2026-10-05 09:36:18.079954	A309	Błąd Lini Niverplst - Easy Plast
795	310	41	2026-10-05 09:36:18.079954	A310	Alarm Lini Niverplast - Transport System
796	311	41	2026-10-05 09:36:18.079954	A311	Błąd Lini Niverplst - Transport System
797	225	8	2026-10-05 09:36:18.079954	A225	Otwarta Bramka Bezpieczeństwa
798	226	9	2026-10-05 09:36:18.079954	A226	Niezaryglowany zamek bramki bezpieczenstwa 
799	309	39	2026-10-05 09:37:18.345596	A309	Błąd Lini Niverplst - Easy Plast
800	310	41	2026-10-05 09:37:18.345596	A310	Alarm Lini Niverplast - Transport System
801	311	41	2026-10-05 09:37:18.345596	A311	Błąd Lini Niverplst - Transport System
802	309	39	2026-10-05 09:38:16.575733	A309	Błąd Lini Niverplst - Easy Plast
803	310	41	2026-10-05 09:38:16.575733	A310	Alarm Lini Niverplast - Transport System
804	311	41	2026-10-05 09:38:16.575733	A311	Błąd Lini Niverplst - Transport System
805	309	39	2026-10-05 09:39:16.964671	A309	Błąd Lini Niverplst - Easy Plast
806	310	41	2026-10-05 09:39:16.964671	A310	Alarm Lini Niverplast - Transport System
807	311	41	2026-10-05 09:39:16.964671	A311	Błąd Lini Niverplst - Transport System
808	309	39	2026-10-05 09:40:17.20626	A309	Błąd Lini Niverplst - Easy Plast
809	310	41	2026-10-05 09:40:17.20626	A310	Alarm Lini Niverplast - Transport System
810	311	41	2026-10-05 09:40:17.20626	A311	Błąd Lini Niverplst - Transport System
811	309	39	2026-10-05 09:41:17.628001	A309	Błąd Lini Niverplst - Easy Plast
812	310	41	2026-10-05 09:41:17.628001	A310	Alarm Lini Niverplast - Transport System
813	311	41	2026-10-05 09:41:17.628001	A311	Błąd Lini Niverplst - Transport System
814	309	39	2026-10-05 09:42:17.872872	A309	Błąd Lini Niverplst - Easy Plast
815	310	41	2026-10-05 09:42:17.872872	A310	Alarm Lini Niverplast - Transport System
816	311	41	2026-10-05 09:42:17.872872	A311	Błąd Lini Niverplst - Transport System
817	309	39	2026-10-05 09:43:18.23691	A309	Błąd Lini Niverplst - Easy Plast
818	310	41	2026-10-05 09:43:18.23691	A310	Alarm Lini Niverplast - Transport System
819	311	41	2026-10-05 09:43:18.23691	A311	Błąd Lini Niverplst - Transport System
820	309	39	2026-10-05 09:44:18.522963	A309	Błąd Lini Niverplst - Easy Plast
821	310	41	2026-10-05 09:44:18.522963	A310	Alarm Lini Niverplast - Transport System
822	311	41	2026-10-05 09:44:18.522963	A311	Błąd Lini Niverplst - Transport System
823	309	39	2026-10-05 09:45:18.839468	A309	Błąd Lini Niverplst - Easy Plast
824	310	41	2026-10-05 09:45:18.839468	A310	Alarm Lini Niverplast - Transport System
825	311	41	2026-10-05 09:45:18.839468	A311	Błąd Lini Niverplst - Transport System
826	309	39	2026-10-05 09:46:17.144873	A309	Błąd Lini Niverplst - Easy Plast
827	310	41	2026-10-05 09:46:17.144873	A310	Alarm Lini Niverplast - Transport System
828	311	41	2026-10-05 09:46:17.144873	A311	Błąd Lini Niverplst - Transport System
829	309	39	2026-10-05 09:47:17.37584	A309	Błąd Lini Niverplst - Easy Plast
830	310	41	2026-10-05 09:47:17.37584	A310	Alarm Lini Niverplast - Transport System
831	311	41	2026-10-05 09:47:17.37584	A311	Błąd Lini Niverplst - Transport System
832	309	39	2026-10-05 09:48:17.792322	A309	Błąd Lini Niverplst - Easy Plast
833	310	41	2026-10-05 09:48:17.792322	A310	Alarm Lini Niverplast - Transport System
834	311	41	2026-10-05 09:48:17.792322	A311	Błąd Lini Niverplst - Transport System
835	309	39	2026-10-05 09:49:18.026815	A309	Błąd Lini Niverplst - Easy Plast
836	310	41	2026-10-05 09:49:18.026815	A310	Alarm Lini Niverplast - Transport System
837	311	41	2026-10-05 09:49:18.026815	A311	Błąd Lini Niverplst - Transport System
838	309	39	2026-10-05 09:50:18.407081	A309	Błąd Lini Niverplst - Easy Plast
839	310	41	2026-10-05 09:50:18.407081	A310	Alarm Lini Niverplast - Transport System
840	311	41	2026-10-05 09:50:18.407081	A311	Błąd Lini Niverplst - Transport System
841	309	39	2026-10-05 09:51:18.687821	A309	Błąd Lini Niverplst - Easy Plast
842	310	41	2026-10-05 09:51:18.687821	A310	Alarm Lini Niverplast - Transport System
843	311	41	2026-10-05 09:51:18.687821	A311	Błąd Lini Niverplst - Transport System
844	309	39	2026-10-05 09:52:19.031237	A309	Błąd Lini Niverplst - Easy Plast
845	310	41	2026-10-05 09:52:19.031237	A310	Alarm Lini Niverplast - Transport System
846	311	41	2026-10-05 09:52:19.031237	A311	Błąd Lini Niverplst - Transport System
847	309	39	2026-10-05 09:53:19.30654	A309	Błąd Lini Niverplst - Easy Plast
848	310	41	2026-10-05 09:53:19.30654	A310	Alarm Lini Niverplast - Transport System
849	311	41	2026-10-05 09:53:19.30654	A311	Błąd Lini Niverplst - Transport System
850	309	39	2026-10-05 09:54:17.51485	A309	Błąd Lini Niverplst - Easy Plast
851	310	41	2026-10-05 09:54:17.51485	A310	Alarm Lini Niverplast - Transport System
852	311	41	2026-10-05 09:54:17.51485	A311	Błąd Lini Niverplst - Transport System
853	309	39	2026-10-05 09:55:17.848366	A309	Błąd Lini Niverplst - Easy Plast
854	310	41	2026-10-05 09:55:17.848366	A310	Alarm Lini Niverplast - Transport System
855	311	41	2026-10-05 09:55:17.848366	A311	Błąd Lini Niverplst - Transport System
856	309	39	2026-10-05 09:56:18.156148	A309	Błąd Lini Niverplst - Easy Plast
857	310	41	2026-10-05 09:56:18.156148	A310	Alarm Lini Niverplast - Transport System
858	311	41	2026-10-05 09:56:18.156148	A311	Błąd Lini Niverplst - Transport System
859	309	39	2026-10-05 09:57:18.46248	A309	Błąd Lini Niverplst - Easy Plast
860	310	41	2026-10-05 09:57:18.46248	A310	Alarm Lini Niverplast - Transport System
861	311	41	2026-10-05 09:57:18.46248	A311	Błąd Lini Niverplst - Transport System
862	309	39	2026-10-05 09:58:18.84766	A309	Błąd Lini Niverplst - Easy Plast
863	310	41	2026-10-05 09:58:18.84766	A310	Alarm Lini Niverplast - Transport System
864	311	41	2026-10-05 09:58:18.84766	A311	Błąd Lini Niverplst - Transport System
865	309	39	2026-10-05 09:59:19.184808	A309	Błąd Lini Niverplst - Easy Plast
866	310	41	2026-10-05 09:59:19.184808	A310	Alarm Lini Niverplast - Transport System
867	311	41	2026-10-05 09:59:19.184808	A311	Błąd Lini Niverplst - Transport System
868	309	39	2026-10-05 10:00:19.46516	A309	Błąd Lini Niverplst - Easy Plast
869	310	41	2026-10-05 10:00:19.46516	A310	Alarm Lini Niverplast - Transport System
870	311	41	2026-10-05 10:00:19.46516	A311	Błąd Lini Niverplst - Transport System
871	309	39	2026-10-05 10:01:19.803708	A309	Błąd Lini Niverplst - Easy Plast
872	310	41	2026-10-05 10:01:19.803708	A310	Alarm Lini Niverplast - Transport System
873	311	41	2026-10-05 10:01:19.803708	A311	Błąd Lini Niverplst - Transport System
874	309	39	2026-10-05 10:02:18.083973	A309	Błąd Lini Niverplst - Easy Plast
875	310	41	2026-10-05 10:02:18.083973	A310	Alarm Lini Niverplast - Transport System
876	311	41	2026-10-05 10:02:18.083973	A311	Błąd Lini Niverplst - Transport System
877	309	39	2026-10-05 10:03:18.333327	A309	Błąd Lini Niverplst - Easy Plast
878	310	41	2026-10-05 10:03:18.333327	A310	Alarm Lini Niverplast - Transport System
879	311	41	2026-10-05 10:03:18.333327	A311	Błąd Lini Niverplst - Transport System
880	309	39	2026-10-05 10:04:18.720366	A309	Błąd Lini Niverplst - Easy Plast
881	310	41	2026-10-05 10:04:18.720366	A310	Alarm Lini Niverplast - Transport System
882	311	41	2026-10-05 10:04:18.720366	A311	Błąd Lini Niverplst - Transport System
883	309	39	2026-10-05 10:05:18.993261	A309	Błąd Lini Niverplst - Easy Plast
884	310	41	2026-10-05 10:05:18.993261	A310	Alarm Lini Niverplast - Transport System
885	311	41	2026-10-05 10:05:18.993261	A311	Błąd Lini Niverplst - Transport System
886	309	39	2026-10-05 10:06:19.384856	A309	Błąd Lini Niverplst - Easy Plast
887	310	41	2026-10-05 10:06:19.384856	A310	Alarm Lini Niverplast - Transport System
888	311	41	2026-10-05 10:06:19.384856	A311	Błąd Lini Niverplst - Transport System
889	309	39	2026-10-05 10:07:19.652291	A309	Błąd Lini Niverplst - Easy Plast
890	310	41	2026-10-05 10:07:19.652291	A310	Alarm Lini Niverplast - Transport System
891	311	41	2026-10-05 10:07:19.652291	A311	Błąd Lini Niverplst - Transport System
892	309	39	2026-10-05 10:08:19.977174	A309	Błąd Lini Niverplst - Easy Plast
893	310	41	2026-10-05 10:08:19.977174	A310	Alarm Lini Niverplast - Transport System
894	311	41	2026-10-05 10:08:19.977174	A311	Błąd Lini Niverplst - Transport System
895	309	39	2026-10-05 10:09:20.271157	A309	Błąd Lini Niverplst - Easy Plast
896	310	41	2026-10-05 10:09:20.271157	A310	Alarm Lini Niverplast - Transport System
897	311	41	2026-10-05 10:09:20.271157	A311	Błąd Lini Niverplst - Transport System
898	309	39	2026-10-05 10:10:18.523502	A309	Błąd Lini Niverplst - Easy Plast
899	310	41	2026-10-05 10:10:18.523502	A310	Alarm Lini Niverplast - Transport System
900	311	41	2026-10-05 10:10:18.523502	A311	Błąd Lini Niverplst - Transport System
901	309	39	2026-10-05 10:11:18.91533	A309	Błąd Lini Niverplst - Easy Plast
902	310	41	2026-10-05 10:11:18.91533	A310	Alarm Lini Niverplast - Transport System
903	311	41	2026-10-05 10:11:18.91533	A311	Błąd Lini Niverplst - Transport System
904	309	39	2026-10-05 10:12:19.17468	A309	Błąd Lini Niverplst - Easy Plast
905	310	41	2026-10-05 10:12:19.17468	A310	Alarm Lini Niverplast - Transport System
906	311	41	2026-10-05 10:12:19.17468	A311	Błąd Lini Niverplst - Transport System
907	309	39	2026-10-05 10:13:19.560164	A309	Błąd Lini Niverplst - Easy Plast
908	310	41	2026-10-05 10:13:19.560164	A310	Alarm Lini Niverplast - Transport System
909	311	41	2026-10-05 10:13:19.560164	A311	Błąd Lini Niverplst - Transport System
910	309	39	2026-10-05 10:14:19.82502	A309	Błąd Lini Niverplst - Easy Plast
911	310	41	2026-10-05 10:14:19.82502	A310	Alarm Lini Niverplast - Transport System
912	311	41	2026-10-05 10:14:19.82502	A311	Błąd Lini Niverplst - Transport System
913	309	39	2026-10-05 10:15:20.184996	A309	Błąd Lini Niverplst - Easy Plast
914	310	41	2026-10-05 10:15:20.184996	A310	Alarm Lini Niverplast - Transport System
1276	182	40	2026-10-05 12:06:27.070306	A182	\N
915	311	41	2026-10-05 10:15:20.184996	A311	Błąd Lini Niverplst - Transport System
916	309	39	2026-10-05 10:16:20.465782	A309	Błąd Lini Niverplst - Easy Plast
917	310	41	2026-10-05 10:16:20.465782	A310	Alarm Lini Niverplast - Transport System
918	311	41	2026-10-05 10:16:20.465782	A311	Błąd Lini Niverplst - Transport System
919	309	39	2026-10-05 10:17:20.767766	A309	Błąd Lini Niverplst - Easy Plast
920	310	41	2026-10-05 10:17:20.767766	A310	Alarm Lini Niverplast - Transport System
921	311	41	2026-10-05 10:17:20.767766	A311	Błąd Lini Niverplst - Transport System
922	309	39	2026-10-05 10:18:19.007289	A309	Błąd Lini Niverplst - Easy Plast
923	310	41	2026-10-05 10:18:19.007289	A310	Alarm Lini Niverplast - Transport System
924	311	41	2026-10-05 10:18:19.007289	A311	Błąd Lini Niverplst - Transport System
925	309	39	2026-10-05 10:19:19.308034	A309	Błąd Lini Niverplst - Easy Plast
926	310	41	2026-10-05 10:19:19.308034	A310	Alarm Lini Niverplast - Transport System
927	311	41	2026-10-05 10:19:19.308034	A311	Błąd Lini Niverplst - Transport System
928	309	39	2026-10-05 10:20:19.608267	A309	Błąd Lini Niverplst - Easy Plast
929	310	41	2026-10-05 10:20:19.608267	A310	Alarm Lini Niverplast - Transport System
930	311	41	2026-10-05 10:20:19.608267	A311	Błąd Lini Niverplst - Transport System
931	309	39	2026-10-05 10:21:19.969252	A309	Błąd Lini Niverplst - Easy Plast
932	310	41	2026-10-05 10:21:19.969252	A310	Alarm Lini Niverplast - Transport System
933	311	41	2026-10-05 10:21:19.969252	A311	Błąd Lini Niverplst - Transport System
934	309	39	2026-10-05 10:22:20.271736	A309	Błąd Lini Niverplst - Easy Plast
935	310	41	2026-10-05 10:22:20.271736	A310	Alarm Lini Niverplast - Transport System
936	311	41	2026-10-05 10:22:20.271736	A311	Błąd Lini Niverplst - Transport System
937	309	39	2026-10-05 10:23:20.615963	A309	Błąd Lini Niverplst - Easy Plast
938	310	41	2026-10-05 10:23:20.615963	A310	Alarm Lini Niverplast - Transport System
939	311	41	2026-10-05 10:23:20.615963	A311	Błąd Lini Niverplst - Transport System
940	309	39	2026-10-05 10:24:20.963456	A309	Błąd Lini Niverplst - Easy Plast
941	310	41	2026-10-05 10:24:20.963456	A310	Alarm Lini Niverplast - Transport System
942	311	41	2026-10-05 10:24:20.963456	A311	Błąd Lini Niverplst - Transport System
943	309	39	2026-10-05 10:25:21.269652	A309	Błąd Lini Niverplst - Easy Plast
944	310	41	2026-10-05 10:25:21.269652	A310	Alarm Lini Niverplast - Transport System
945	311	41	2026-10-05 10:25:21.269652	A311	Błąd Lini Niverplst - Transport System
946	309	39	2026-10-05 10:26:19.467853	A309	Błąd Lini Niverplst - Easy Plast
947	310	41	2026-10-05 10:26:19.467853	A310	Alarm Lini Niverplast - Transport System
948	311	41	2026-10-05 10:26:19.467853	A311	Błąd Lini Niverplst - Transport System
949	309	39	2026-10-05 10:27:19.854517	A309	Błąd Lini Niverplst - Easy Plast
950	310	41	2026-10-05 10:27:19.854517	A310	Alarm Lini Niverplast - Transport System
951	311	41	2026-10-05 10:27:19.854517	A311	Błąd Lini Niverplst - Transport System
952	309	39	2026-10-05 10:28:20.134835	A309	Błąd Lini Niverplst - Easy Plast
953	310	41	2026-10-05 10:28:20.134835	A310	Alarm Lini Niverplast - Transport System
954	311	41	2026-10-05 10:28:20.134835	A311	Błąd Lini Niverplst - Transport System
955	309	39	2026-10-05 10:29:20.500357	A309	Błąd Lini Niverplst - Easy Plast
956	310	41	2026-10-05 10:29:20.500357	A310	Alarm Lini Niverplast - Transport System
957	311	41	2026-10-05 10:29:20.500357	A311	Błąd Lini Niverplst - Transport System
958	309	39	2026-10-05 10:30:20.790359	A309	Błąd Lini Niverplst - Easy Plast
959	310	41	2026-10-05 10:30:20.790359	A310	Alarm Lini Niverplast - Transport System
960	311	41	2026-10-05 10:30:20.790359	A311	Błąd Lini Niverplst - Transport System
961	309	39	2026-10-05 10:31:21.162621	A309	Błąd Lini Niverplst - Easy Plast
962	310	41	2026-10-05 10:31:21.162621	A310	Alarm Lini Niverplast - Transport System
963	311	41	2026-10-05 10:31:21.162621	A311	Błąd Lini Niverplst - Transport System
964	309	39	2026-10-05 10:32:21.452697	A309	Błąd Lini Niverplst - Easy Plast
965	310	41	2026-10-05 10:32:21.452697	A310	Alarm Lini Niverplast - Transport System
966	311	41	2026-10-05 10:32:21.452697	A311	Błąd Lini Niverplst - Transport System
967	309	39	2026-10-05 10:33:21.764961	A309	Błąd Lini Niverplst - Easy Plast
968	310	41	2026-10-05 10:33:21.764961	A310	Alarm Lini Niverplast - Transport System
969	311	41	2026-10-05 10:33:21.764961	A311	Błąd Lini Niverplst - Transport System
970	309	39	2026-10-05 10:34:20.070835	A309	Błąd Lini Niverplst - Easy Plast
971	310	41	2026-10-05 10:34:20.070835	A310	Alarm Lini Niverplast - Transport System
972	311	41	2026-10-05 10:34:20.070835	A311	Błąd Lini Niverplst - Transport System
973	309	39	2026-10-05 10:35:20.317273	A309	Błąd Lini Niverplst - Easy Plast
974	310	41	2026-10-05 10:35:20.317273	A310	Alarm Lini Niverplast - Transport System
975	311	41	2026-10-05 10:35:20.317273	A311	Błąd Lini Niverplst - Transport System
976	309	39	2026-10-05 10:36:20.739486	A309	Błąd Lini Niverplst - Easy Plast
977	310	41	2026-10-05 10:36:20.739486	A310	Alarm Lini Niverplast - Transport System
978	311	41	2026-10-05 10:36:20.739486	A311	Błąd Lini Niverplst - Transport System
979	309	39	2026-10-05 10:37:20.968805	A309	Błąd Lini Niverplst - Easy Plast
980	310	41	2026-10-05 10:37:20.968805	A310	Alarm Lini Niverplast - Transport System
981	311	41	2026-10-05 10:37:20.968805	A311	Błąd Lini Niverplst - Transport System
982	309	39	2026-10-05 10:38:20.191591	A309	Błąd Lini Niverplst - Easy Plast
983	310	41	2026-10-05 10:38:20.191591	A310	Alarm Lini Niverplast - Transport System
984	311	41	2026-10-05 10:38:20.191591	A311	Błąd Lini Niverplst - Transport System
985	309	39	2026-10-05 10:39:21.654365	A309	Błąd Lini Niverplst - Easy Plast
986	310	41	2026-10-05 10:39:21.654365	A310	Alarm Lini Niverplast - Transport System
987	311	41	2026-10-05 10:39:21.654365	A311	Błąd Lini Niverplst - Transport System
988	309	39	2026-10-05 10:40:21.955117	A309	Błąd Lini Niverplst - Easy Plast
989	310	41	2026-10-05 10:40:21.955117	A310	Alarm Lini Niverplast - Transport System
990	311	41	2026-10-05 10:40:21.955117	A311	Błąd Lini Niverplst - Transport System
991	309	39	2026-10-05 10:41:22.254157	A309	Błąd Lini Niverplst - Easy Plast
992	310	41	2026-10-05 10:41:22.254157	A310	Alarm Lini Niverplast - Transport System
993	311	41	2026-10-05 10:41:22.254157	A311	Błąd Lini Niverplst - Transport System
994	309	39	2026-10-05 10:42:20.490771	A309	Błąd Lini Niverplst - Easy Plast
995	310	41	2026-10-05 10:42:20.490771	A310	Alarm Lini Niverplast - Transport System
996	311	41	2026-10-05 10:42:20.490771	A311	Błąd Lini Niverplst - Transport System
997	309	39	2026-10-05 10:43:20.80134	A309	Błąd Lini Niverplst - Easy Plast
1282	182	40	2026-10-05 12:07:25.28899	A182	\N
998	310	41	2026-10-05 10:43:20.80134	A310	Alarm Lini Niverplast - Transport System
999	311	41	2026-10-05 10:43:20.80134	A311	Błąd Lini Niverplst - Transport System
1000	309	39	2026-10-05 10:44:21.15354	A309	Błąd Lini Niverplst - Easy Plast
1001	310	41	2026-10-05 10:44:21.15354	A310	Alarm Lini Niverplast - Transport System
1002	311	41	2026-10-05 10:44:21.15354	A311	Błąd Lini Niverplst - Transport System
1003	309	39	2026-10-05 10:45:21.435593	A309	Błąd Lini Niverplst - Easy Plast
1004	310	41	2026-10-05 10:45:21.435593	A310	Alarm Lini Niverplast - Transport System
1005	311	41	2026-10-05 10:45:21.435593	A311	Błąd Lini Niverplst - Transport System
1006	309	39	2026-10-05 10:46:21.811761	A309	Błąd Lini Niverplst - Easy Plast
1007	310	41	2026-10-05 10:46:21.811761	A310	Alarm Lini Niverplast - Transport System
1008	311	41	2026-10-05 10:46:21.811761	A311	Błąd Lini Niverplst - Transport System
1009	309	39	2026-10-05 10:47:22.146026	A309	Błąd Lini Niverplst - Easy Plast
1010	310	41	2026-10-05 10:47:22.146026	A310	Alarm Lini Niverplast - Transport System
1011	311	41	2026-10-05 10:47:22.146026	A311	Błąd Lini Niverplst - Transport System
1012	309	39	2026-10-05 10:48:22.451912	A309	Błąd Lini Niverplst - Easy Plast
1013	310	41	2026-10-05 10:48:22.451912	A310	Alarm Lini Niverplast - Transport System
1014	311	41	2026-10-05 10:48:22.451912	A311	Błąd Lini Niverplst - Transport System
1015	309	39	2026-10-05 10:49:20.664644	A309	Błąd Lini Niverplst - Easy Plast
1016	310	41	2026-10-05 10:49:20.664644	A310	Alarm Lini Niverplast - Transport System
1017	311	41	2026-10-05 10:49:20.664644	A311	Błąd Lini Niverplst - Transport System
1018	309	39	2026-10-05 10:50:21.042961	A309	Błąd Lini Niverplst - Easy Plast
1019	310	41	2026-10-05 10:50:21.042961	A310	Alarm Lini Niverplast - Transport System
1020	311	41	2026-10-05 10:50:21.042961	A311	Błąd Lini Niverplst - Transport System
1021	309	39	2026-10-05 10:51:21.29934	A309	Błąd Lini Niverplst - Easy Plast
1022	310	41	2026-10-05 10:51:21.29934	A310	Alarm Lini Niverplast - Transport System
1023	311	41	2026-10-05 10:51:21.29934	A311	Błąd Lini Niverplst - Transport System
1024	309	39	2026-10-05 10:52:21.656509	A309	Błąd Lini Niverplst - Easy Plast
1025	310	41	2026-10-05 10:52:21.656509	A310	Alarm Lini Niverplast - Transport System
1026	311	41	2026-10-05 10:52:21.656509	A311	Błąd Lini Niverplst - Transport System
1027	309	39	2026-10-05 10:53:21.983418	A309	Błąd Lini Niverplst - Easy Plast
1028	310	41	2026-10-05 10:53:21.983418	A310	Alarm Lini Niverplast - Transport System
1029	311	41	2026-10-05 10:53:21.983418	A311	Błąd Lini Niverplst - Transport System
1030	309	39	2026-10-05 10:54:22.364295	A309	Błąd Lini Niverplst - Easy Plast
1031	310	41	2026-10-05 10:54:22.364295	A310	Alarm Lini Niverplast - Transport System
1032	311	41	2026-10-05 10:54:22.364295	A311	Błąd Lini Niverplst - Transport System
1033	309	39	2026-10-05 10:55:22.635139	A309	Błąd Lini Niverplst - Easy Plast
1034	310	41	2026-10-05 10:55:22.635139	A310	Alarm Lini Niverplast - Transport System
1035	311	41	2026-10-05 10:55:22.635139	A311	Błąd Lini Niverplst - Transport System
1036	309	39	2026-10-05 10:56:22.967845	A309	Błąd Lini Niverplst - Easy Plast
1037	310	41	2026-10-05 10:56:22.967845	A310	Alarm Lini Niverplast - Transport System
1038	311	41	2026-10-05 10:56:22.967845	A311	Błąd Lini Niverplst - Transport System
1039	309	39	2026-10-05 10:57:21.282534	A309	Błąd Lini Niverplst - Easy Plast
1040	310	41	2026-10-05 10:57:21.282534	A310	Alarm Lini Niverplast - Transport System
1041	311	41	2026-10-05 10:57:21.282534	A311	Błąd Lini Niverplst - Transport System
1042	309	39	2026-10-05 10:58:21.502168	A309	Błąd Lini Niverplst - Easy Plast
1043	310	41	2026-10-05 10:58:21.502168	A310	Alarm Lini Niverplast - Transport System
1044	311	41	2026-10-05 10:58:21.502168	A311	Błąd Lini Niverplst - Transport System
1045	309	39	2026-10-05 10:59:21.938903	A309	Błąd Lini Niverplst - Easy Plast
1046	310	41	2026-10-05 10:59:21.938903	A310	Alarm Lini Niverplast - Transport System
1047	311	41	2026-10-05 10:59:21.938903	A311	Błąd Lini Niverplst - Transport System
1048	309	39	2026-10-05 11:00:22.167497	A309	Błąd Lini Niverplst - Easy Plast
1049	310	41	2026-10-05 11:00:22.167497	A310	Alarm Lini Niverplast - Transport System
1050	311	41	2026-10-05 11:00:22.167497	A311	Błąd Lini Niverplst - Transport System
1051	309	39	2026-10-05 11:01:22.565491	A309	Błąd Lini Niverplst - Easy Plast
1052	310	41	2026-10-05 11:01:22.565491	A310	Alarm Lini Niverplast - Transport System
1053	311	41	2026-10-05 11:01:22.565491	A311	Błąd Lini Niverplst - Transport System
1054	309	39	2026-10-05 11:02:22.843969	A309	Błąd Lini Niverplst - Easy Plast
1055	310	41	2026-10-05 11:02:22.843969	A310	Alarm Lini Niverplast - Transport System
1056	311	41	2026-10-05 11:02:22.843969	A311	Błąd Lini Niverplst - Transport System
1057	309	39	2026-10-05 11:03:23.183333	A309	Błąd Lini Niverplst - Easy Plast
1058	310	41	2026-10-05 11:03:23.183333	A310	Alarm Lini Niverplast - Transport System
1059	311	41	2026-10-05 11:03:23.183333	A311	Błąd Lini Niverplst - Transport System
1060	309	39	2026-10-05 11:04:23.471273	A309	Błąd Lini Niverplst - Easy Plast
1061	310	41	2026-10-05 11:04:23.471273	A310	Alarm Lini Niverplast - Transport System
1062	311	41	2026-10-05 11:04:23.471273	A311	Błąd Lini Niverplst - Transport System
1063	309	39	2026-10-05 11:05:21.706669	A309	Błąd Lini Niverplst - Easy Plast
1064	310	41	2026-10-05 11:05:21.706669	A310	Alarm Lini Niverplast - Transport System
1065	311	41	2026-10-05 11:05:21.706669	A311	Błąd Lini Niverplst - Transport System
1066	309	39	2026-10-05 11:06:21.995082	A309	Błąd Lini Niverplst - Easy Plast
1067	310	41	2026-10-05 11:06:21.995082	A310	Alarm Lini Niverplast - Transport System
1068	311	41	2026-10-05 11:06:21.995082	A311	Błąd Lini Niverplst - Transport System
1069	309	39	2026-10-05 11:07:22.337535	A309	Błąd Lini Niverplst - Easy Plast
1070	310	41	2026-10-05 11:07:22.337535	A310	Alarm Lini Niverplast - Transport System
1071	311	41	2026-10-05 11:07:22.337535	A311	Błąd Lini Niverplst - Transport System
1072	309	39	2026-10-05 11:08:22.618394	A309	Błąd Lini Niverplst - Easy Plast
1073	310	41	2026-10-05 11:08:22.618394	A310	Alarm Lini Niverplast - Transport System
1074	311	41	2026-10-05 11:08:22.618394	A311	Błąd Lini Niverplst - Transport System
1075	309	39	2026-10-05 11:09:23.026334	A309	Błąd Lini Niverplst - Easy Plast
1076	310	41	2026-10-05 11:09:23.026334	A310	Alarm Lini Niverplast - Transport System
1077	311	41	2026-10-05 11:09:23.026334	A311	Błąd Lini Niverplst - Transport System
1078	309	39	2026-10-05 11:10:23.367839	A309	Błąd Lini Niverplst - Easy Plast
1079	310	41	2026-10-05 11:10:23.367839	A310	Alarm Lini Niverplast - Transport System
1080	311	41	2026-10-05 11:10:23.367839	A311	Błąd Lini Niverplst - Transport System
1288	182	40	2026-10-05 12:08:25.625994	A182	\N
1081	309	39	2026-10-05 11:11:23.668045	A309	Błąd Lini Niverplst - Easy Plast
1082	310	41	2026-10-05 11:11:23.668045	A310	Alarm Lini Niverplast - Transport System
1083	311	41	2026-10-05 11:11:23.668045	A311	Błąd Lini Niverplst - Transport System
1084	309	39	2026-10-05 11:12:23.981907	A309	Błąd Lini Niverplst - Easy Plast
1085	310	41	2026-10-05 11:12:23.981907	A310	Alarm Lini Niverplast - Transport System
1086	311	41	2026-10-05 11:12:23.981907	A311	Błąd Lini Niverplst - Transport System
1087	309	39	2026-10-05 11:13:22.254484	A309	Błąd Lini Niverplst - Easy Plast
1088	310	41	2026-10-05 11:13:22.254484	A310	Alarm Lini Niverplast - Transport System
1089	311	41	2026-10-05 11:13:22.254484	A311	Błąd Lini Niverplst - Transport System
1090	309	39	2026-10-05 11:14:22.503189	A309	Błąd Lini Niverplst - Easy Plast
1091	310	41	2026-10-05 11:14:22.503189	A310	Alarm Lini Niverplast - Transport System
1092	311	41	2026-10-05 11:14:22.503189	A311	Błąd Lini Niverplst - Transport System
1093	309	39	2026-10-05 11:15:22.874691	A309	Błąd Lini Niverplst - Easy Plast
1094	310	41	2026-10-05 11:15:22.874691	A310	Alarm Lini Niverplast - Transport System
1095	311	41	2026-10-05 11:15:22.874691	A311	Błąd Lini Niverplst - Transport System
1096	309	39	2026-10-05 11:16:24.229468	A309	Błąd Lini Niverplst - Easy Plast
1097	310	41	2026-10-05 11:16:24.229468	A310	Alarm Lini Niverplast - Transport System
1098	311	41	2026-10-05 11:16:24.229468	A311	Błąd Lini Niverplst - Transport System
1099	309	39	2026-10-05 11:17:23.584304	A309	Błąd Lini Niverplst - Easy Plast
1100	310	41	2026-10-05 11:17:23.584304	A310	Alarm Lini Niverplast - Transport System
1101	311	41	2026-10-05 11:17:23.584304	A311	Błąd Lini Niverplst - Transport System
1102	309	39	2026-10-05 11:18:23.854396	A309	Błąd Lini Niverplst - Easy Plast
1103	310	41	2026-10-05 11:18:23.854396	A310	Alarm Lini Niverplast - Transport System
1104	311	41	2026-10-05 11:18:23.854396	A311	Błąd Lini Niverplst - Transport System
1105	309	39	2026-10-05 11:19:24.173887	A309	Błąd Lini Niverplst - Easy Plast
1106	310	41	2026-10-05 11:19:24.173887	A310	Alarm Lini Niverplast - Transport System
1107	311	41	2026-10-05 11:19:24.173887	A311	Błąd Lini Niverplst - Transport System
1108	309	39	2026-10-05 11:20:24.486908	A309	Błąd Lini Niverplst - Easy Plast
1109	310	41	2026-10-05 11:20:24.486908	A310	Alarm Lini Niverplast - Transport System
1110	311	41	2026-10-05 11:20:24.486908	A311	Błąd Lini Niverplst - Transport System
1111	309	39	2026-10-05 11:21:22.719707	A309	Błąd Lini Niverplst - Easy Plast
1112	310	41	2026-10-05 11:21:22.719707	A310	Alarm Lini Niverplast - Transport System
1113	311	41	2026-10-05 11:21:22.719707	A311	Błąd Lini Niverplst - Transport System
1114	309	39	2026-10-05 11:22:23.159261	A309	Błąd Lini Niverplst - Easy Plast
1115	310	41	2026-10-05 11:22:23.159261	A310	Alarm Lini Niverplast - Transport System
1116	311	41	2026-10-05 11:22:23.159261	A311	Błąd Lini Niverplst - Transport System
1117	309	39	2026-10-05 11:23:23.370274	A309	Błąd Lini Niverplst - Easy Plast
1118	310	41	2026-10-05 11:23:23.370274	A310	Alarm Lini Niverplast - Transport System
1119	311	41	2026-10-05 11:23:23.370274	A311	Błąd Lini Niverplst - Transport System
1120	309	39	2026-10-05 11:24:23.796018	A309	Błąd Lini Niverplst - Easy Plast
1121	310	41	2026-10-05 11:24:23.796018	A310	Alarm Lini Niverplast - Transport System
1122	311	41	2026-10-05 11:24:23.796018	A311	Błąd Lini Niverplst - Transport System
1123	309	39	2026-10-05 11:25:24.077407	A309	Błąd Lini Niverplst - Easy Plast
1124	310	41	2026-10-05 11:25:24.077407	A310	Alarm Lini Niverplast - Transport System
1125	311	41	2026-10-05 11:25:24.077407	A311	Błąd Lini Niverplst - Transport System
1126	309	39	2026-10-05 11:26:24.432344	A309	Błąd Lini Niverplst - Easy Plast
1127	310	41	2026-10-05 11:26:24.432344	A310	Alarm Lini Niverplast - Transport System
1128	311	41	2026-10-05 11:26:24.432344	A311	Błąd Lini Niverplst - Transport System
1129	309	39	2026-10-05 11:27:24.726769	A309	Błąd Lini Niverplst - Easy Plast
1130	310	41	2026-10-05 11:27:24.726769	A310	Alarm Lini Niverplast - Transport System
1131	311	41	2026-10-05 11:27:24.726769	A311	Błąd Lini Niverplst - Transport System
1132	309	39	2026-10-05 11:28:22.943391	A309	Błąd Lini Niverplst - Easy Plast
1133	310	41	2026-10-05 11:28:22.943391	A310	Alarm Lini Niverplast - Transport System
1134	311	41	2026-10-05 11:28:22.943391	A311	Błąd Lini Niverplst - Transport System
1135	309	39	2026-10-05 11:29:23.232807	A309	Błąd Lini Niverplst - Easy Plast
1136	310	41	2026-10-05 11:29:23.232807	A310	Alarm Lini Niverplast - Transport System
1137	311	41	2026-10-05 11:29:23.232807	A311	Błąd Lini Niverplst - Transport System
1138	309	39	2026-10-05 11:30:23.591871	A309	Błąd Lini Niverplst - Easy Plast
1139	310	41	2026-10-05 11:30:23.591871	A310	Alarm Lini Niverplast - Transport System
1140	311	41	2026-10-05 11:30:23.591871	A311	Błąd Lini Niverplst - Transport System
1141	309	39	2026-10-05 11:31:23.863427	A309	Błąd Lini Niverplst - Easy Plast
1142	310	41	2026-10-05 11:31:23.863427	A310	Alarm Lini Niverplast - Transport System
1143	311	41	2026-10-05 11:31:23.863427	A311	Błąd Lini Niverplst - Transport System
1144	309	39	2026-10-05 11:32:24.261949	A309	Błąd Lini Niverplst - Easy Plast
1145	310	41	2026-10-05 11:32:24.261949	A310	Alarm Lini Niverplast - Transport System
1146	311	41	2026-10-05 11:32:24.261949	A311	Błąd Lini Niverplst - Transport System
1147	309	39	2026-10-05 11:33:24.606538	A309	Błąd Lini Niverplst - Easy Plast
1148	310	41	2026-10-05 11:33:24.606538	A310	Alarm Lini Niverplast - Transport System
1149	311	41	2026-10-05 11:33:24.606538	A311	Błąd Lini Niverplst - Transport System
1150	309	39	2026-10-05 11:34:24.91606	A309	Błąd Lini Niverplst - Easy Plast
1151	310	41	2026-10-05 11:34:24.91606	A310	Alarm Lini Niverplast - Transport System
1152	311	41	2026-10-05 11:34:24.91606	A311	Błąd Lini Niverplst - Transport System
1153	309	39	2026-10-05 11:35:25.246401	A309	Błąd Lini Niverplst - Easy Plast
1154	310	41	2026-10-05 11:35:25.246401	A310	Alarm Lini Niverplast - Transport System
1155	311	41	2026-10-05 11:35:25.246401	A311	Błąd Lini Niverplst - Transport System
1156	309	39	2026-10-05 11:36:23.497317	A309	Błąd Lini Niverplst - Easy Plast
1157	310	41	2026-10-05 11:36:23.497317	A310	Alarm Lini Niverplast - Transport System
1158	311	41	2026-10-05 11:36:23.497317	A311	Błąd Lini Niverplst - Transport System
1159	309	39	2026-10-05 11:37:23.76922	A309	Błąd Lini Niverplst - Easy Plast
1160	310	41	2026-10-05 11:37:23.76922	A310	Alarm Lini Niverplast - Transport System
1161	311	41	2026-10-05 11:37:23.76922	A311	Błąd Lini Niverplst - Transport System
1162	309	39	2026-10-05 11:38:24.146005	A309	Błąd Lini Niverplst - Easy Plast
1163	310	41	2026-10-05 11:38:24.146005	A310	Alarm Lini Niverplast - Transport System
1164	311	41	2026-10-05 11:38:24.146005	A311	Błąd Lini Niverplst - Transport System
1165	309	39	2026-10-05 11:39:24.454187	A309	Błąd Lini Niverplst - Easy Plast
1166	310	41	2026-10-05 11:39:24.454187	A310	Alarm Lini Niverplast - Transport System
1167	311	41	2026-10-05 11:39:24.454187	A311	Błąd Lini Niverplst - Transport System
1168	309	39	2026-10-05 11:40:24.830046	A309	Błąd Lini Niverplst - Easy Plast
1169	310	41	2026-10-05 11:40:24.830046	A310	Alarm Lini Niverplast - Transport System
1170	311	41	2026-10-05 11:40:24.830046	A311	Błąd Lini Niverplst - Transport System
1171	309	39	2026-10-05 11:41:25.129718	A309	Błąd Lini Niverplst - Easy Plast
1172	310	41	2026-10-05 11:41:25.129718	A310	Alarm Lini Niverplast - Transport System
1173	311	41	2026-10-05 11:41:25.129718	A311	Błąd Lini Niverplst - Transport System
1174	309	39	2026-10-05 11:42:25.455285	A309	Błąd Lini Niverplst - Easy Plast
1175	310	41	2026-10-05 11:42:25.455285	A310	Alarm Lini Niverplast - Transport System
1176	311	41	2026-10-05 11:42:25.455285	A311	Błąd Lini Niverplst - Transport System
1177	309	39	2026-10-05 11:43:25.7655	A309	Błąd Lini Niverplst - Easy Plast
1178	310	41	2026-10-05 11:43:25.7655	A310	Alarm Lini Niverplast - Transport System
1179	311	41	2026-10-05 11:43:25.7655	A311	Błąd Lini Niverplst - Transport System
1180	309	39	2026-10-05 11:44:23.972627	A309	Błąd Lini Niverplst - Easy Plast
1181	310	41	2026-10-05 11:44:23.972627	A310	Alarm Lini Niverplast - Transport System
1182	311	41	2026-10-05 11:44:23.972627	A311	Błąd Lini Niverplst - Transport System
1183	309	39	2026-10-05 11:45:24.412017	A309	Błąd Lini Niverplst - Easy Plast
1184	310	41	2026-10-05 11:45:24.412017	A310	Alarm Lini Niverplast - Transport System
1185	311	41	2026-10-05 11:45:24.412017	A311	Błąd Lini Niverplst - Transport System
1186	309	39	2026-10-05 11:46:24.629322	A309	Błąd Lini Niverplst - Easy Plast
1187	310	41	2026-10-05 11:46:24.629322	A310	Alarm Lini Niverplast - Transport System
1188	311	41	2026-10-05 11:46:24.629322	A311	Błąd Lini Niverplst - Transport System
1189	309	39	2026-10-05 11:47:25.065914	A309	Błąd Lini Niverplst - Easy Plast
1190	310	41	2026-10-05 11:47:25.065914	A310	Alarm Lini Niverplast - Transport System
1191	311	41	2026-10-05 11:47:25.065914	A311	Błąd Lini Niverplst - Transport System
1192	309	39	2026-10-05 11:48:25.317349	A309	Błąd Lini Niverplst - Easy Plast
1193	310	41	2026-10-05 11:48:25.317349	A310	Alarm Lini Niverplast - Transport System
1194	311	41	2026-10-05 11:48:25.317349	A311	Błąd Lini Niverplst - Transport System
1195	309	39	2026-10-05 11:49:25.703409	A309	Błąd Lini Niverplst - Easy Plast
1196	310	41	2026-10-05 11:49:25.703409	A310	Alarm Lini Niverplast - Transport System
1197	311	41	2026-10-05 11:49:25.703409	A311	Błąd Lini Niverplst - Transport System
1198	309	39	2026-10-05 11:50:25.982923	A309	Błąd Lini Niverplst - Easy Plast
1199	310	41	2026-10-05 11:50:25.982923	A310	Alarm Lini Niverplast - Transport System
1200	311	41	2026-10-05 11:50:25.982923	A311	Błąd Lini Niverplst - Transport System
1201	309	39	2026-10-05 11:51:26.284266	A309	Błąd Lini Niverplst - Easy Plast
1202	310	41	2026-10-05 11:51:26.284266	A310	Alarm Lini Niverplast - Transport System
1203	311	41	2026-10-05 11:51:26.284266	A311	Błąd Lini Niverplst - Transport System
1204	309	39	2026-10-05 11:52:25.934658	A309	Błąd Lini Niverplst - Easy Plast
1205	310	41	2026-10-05 11:52:25.934658	A310	Alarm Lini Niverplast - Transport System
1206	311	41	2026-10-05 11:52:25.934658	A311	Błąd Lini Niverplst - Transport System
1207	309	39	2026-10-05 11:53:24.849097	A309	Błąd Lini Niverplst - Easy Plast
1208	310	41	2026-10-05 11:53:24.849097	A310	Alarm Lini Niverplast - Transport System
1209	311	41	2026-10-05 11:53:24.849097	A311	Błąd Lini Niverplst - Transport System
1210	309	39	2026-10-05 11:54:25.120894	A309	Błąd Lini Niverplst - Easy Plast
1211	310	41	2026-10-05 11:54:25.120894	A310	Alarm Lini Niverplast - Transport System
1212	311	41	2026-10-05 11:54:25.120894	A311	Błąd Lini Niverplst - Transport System
1213	309	39	2026-10-05 11:55:24.970666	A309	Błąd Lini Niverplst - Easy Plast
1214	310	41	2026-10-05 11:55:24.970666	A310	Alarm Lini Niverplast - Transport System
1215	311	41	2026-10-05 11:55:24.970666	A311	Błąd Lini Niverplst - Transport System
1216	182	40	2026-10-05 11:56:25.914143	A182	\N
1217	129	40	2026-10-05 11:56:25.914143	A129	Niskie ciśnienie pneumatyczne - strefa 1
1218	164	40	2026-10-05 11:56:25.914143	A164	\N
1219	309	39	2026-10-05 11:56:25.914143	A309	Błąd Lini Niverplst - Easy Plast
1220	310	41	2026-10-05 11:56:25.914143	A310	Alarm Lini Niverplast - Transport System
1221	311	41	2026-10-05 11:56:25.914143	A311	Błąd Lini Niverplst - Transport System
1222	182	40	2026-10-05 11:57:26.234065	A182	\N
1223	129	40	2026-10-05 11:57:26.234065	A129	Niskie ciśnienie pneumatyczne - strefa 1
1224	164	40	2026-10-05 11:57:26.234065	A164	\N
1225	309	39	2026-10-05 11:57:26.234065	A309	Błąd Lini Niverplst - Easy Plast
1226	310	41	2026-10-05 11:57:26.234065	A310	Alarm Lini Niverplast - Transport System
1227	311	41	2026-10-05 11:57:26.234065	A311	Błąd Lini Niverplst - Transport System
1229	129	40	2026-10-05 11:58:26.594286	A129	Niskie ciśnienie pneumatyczne - strefa 1
1230	164	40	2026-10-05 11:58:26.594286	A164	\N
1231	309	39	2026-10-05 11:58:26.594286	A309	Błąd Lini Niverplst - Easy Plast
1232	310	41	2026-10-05 11:58:26.594286	A310	Alarm Lini Niverplast - Transport System
1233	311	41	2026-10-05 11:58:26.594286	A311	Błąd Lini Niverplst - Transport System
1235	129	40	2026-10-05 11:59:24.834403	A129	Niskie ciśnienie pneumatyczne - strefa 1
1236	164	40	2026-10-05 11:59:24.834403	A164	\N
1237	309	39	2026-10-05 11:59:24.834403	A309	Błąd Lini Niverplst - Easy Plast
1238	310	41	2026-10-05 11:59:24.834403	A310	Alarm Lini Niverplast - Transport System
1239	311	41	2026-10-05 11:59:24.834403	A311	Błąd Lini Niverplst - Transport System
1241	129	40	2026-10-05 12:00:25.072209	A129	Niskie ciśnienie pneumatyczne - strefa 1
1242	164	40	2026-10-05 12:00:25.072209	A164	\N
1243	309	39	2026-10-05 12:00:25.072209	A309	Błąd Lini Niverplst - Easy Plast
1244	310	41	2026-10-05 12:00:25.072209	A310	Alarm Lini Niverplast - Transport System
1245	311	41	2026-10-05 12:00:25.072209	A311	Błąd Lini Niverplst - Transport System
1247	129	40	2026-10-05 12:01:25.485018	A129	Niskie ciśnienie pneumatyczne - strefa 1
1248	164	40	2026-10-05 12:01:25.485018	A164	\N
1249	309	39	2026-10-05 12:01:25.485018	A309	Błąd Lini Niverplst - Easy Plast
1250	310	41	2026-10-05 12:01:25.485018	A310	Alarm Lini Niverplast - Transport System
1251	311	41	2026-10-05 12:01:25.485018	A311	Błąd Lini Niverplst - Transport System
1253	129	40	2026-10-05 12:02:25.773512	A129	Niskie ciśnienie pneumatyczne - strefa 1
1254	164	40	2026-10-05 12:02:25.773512	A164	\N
1255	309	39	2026-10-05 12:02:25.773512	A309	Błąd Lini Niverplst - Easy Plast
1256	310	41	2026-10-05 12:02:25.773512	A310	Alarm Lini Niverplast - Transport System
1257	311	41	2026-10-05 12:02:25.773512	A311	Błąd Lini Niverplst - Transport System
2766	309	39	2026-10-05 20:07:55.058079	A309	Błąd Lini Niverplst - Easy Plast
2767	310	41	2026-10-05 20:07:55.058079	A310	Alarm Lini Niverplast - Transport System
2768	311	41	2026-10-05 20:07:55.058079	A311	Błąd Lini Niverplst - Transport System
2787	309	39	2026-10-05 20:14:55.448659	A309	Błąd Lini Niverplst - Easy Plast
2788	310	41	2026-10-05 20:14:55.448659	A310	Alarm Lini Niverplast - Transport System
2789	311	41	2026-10-05 20:14:55.448659	A311	Błąd Lini Niverplst - Transport System
2808	309	39	2026-10-05 20:21:55.858898	A309	Błąd Lini Niverplst - Easy Plast
2809	310	41	2026-10-05 20:21:55.858898	A310	Alarm Lini Niverplast - Transport System
2810	311	41	2026-10-05 20:21:55.858898	A311	Błąd Lini Niverplst - Transport System
2829	309	39	2026-10-05 20:28:56.267833	A309	Błąd Lini Niverplst - Easy Plast
2830	310	41	2026-10-05 20:28:56.267833	A310	Alarm Lini Niverplast - Transport System
2831	311	41	2026-10-05 20:28:56.267833	A311	Błąd Lini Niverplst - Transport System
2850	309	39	2026-10-05 20:35:56.672214	A309	Błąd Lini Niverplst - Easy Plast
2851	310	41	2026-10-05 20:35:56.672214	A310	Alarm Lini Niverplast - Transport System
2852	311	41	2026-10-05 20:35:56.672214	A311	Błąd Lini Niverplst - Transport System
2871	309	39	2026-10-05 20:42:57.09113	A309	Błąd Lini Niverplst - Easy Plast
2872	310	41	2026-10-05 20:42:57.09113	A310	Alarm Lini Niverplast - Transport System
2873	311	41	2026-10-05 20:42:57.09113	A311	Błąd Lini Niverplst - Transport System
2892	309	39	2026-10-05 20:50:01.148389	A309	Błąd Lini Niverplst - Easy Plast
2893	310	41	2026-10-05 20:50:01.148389	A310	Alarm Lini Niverplast - Transport System
2894	311	41	2026-10-05 20:50:01.148389	A311	Błąd Lini Niverplst - Transport System
2911	310	41	2026-10-05 20:55:57.826192	A310	Alarm Lini Niverplast - Transport System
2912	311	41	2026-10-05 20:55:57.826192	A311	Błąd Lini Niverplst - Transport System
2928	309	39	2026-10-05 21:01:58.182978	A309	Błąd Lini Niverplst - Easy Plast
2929	310	41	2026-10-05 21:01:58.182978	A310	Alarm Lini Niverplast - Transport System
2930	311	41	2026-10-05 21:01:58.182978	A311	Błąd Lini Niverplst - Transport System
2946	309	39	2026-10-05 21:07:58.523548	A309	Błąd Lini Niverplst - Easy Plast
2947	310	41	2026-10-05 21:07:58.523548	A310	Alarm Lini Niverplast - Transport System
2948	311	41	2026-10-05 21:07:58.523548	A311	Błąd Lini Niverplst - Transport System
2964	309	39	2026-10-05 21:13:58.836932	A309	Błąd Lini Niverplst - Easy Plast
2965	310	41	2026-10-05 21:13:58.836932	A310	Alarm Lini Niverplast - Transport System
2966	311	41	2026-10-05 21:13:58.836932	A311	Błąd Lini Niverplst - Transport System
2982	309	39	2026-10-05 21:19:59.215377	A309	Błąd Lini Niverplst - Easy Plast
2983	310	41	2026-10-05 21:19:59.215377	A310	Alarm Lini Niverplast - Transport System
2984	311	41	2026-10-05 21:19:59.215377	A311	Błąd Lini Niverplst - Transport System
3000	309	39	2026-10-05 21:25:59.561645	A309	Błąd Lini Niverplst - Easy Plast
3001	310	41	2026-10-05 21:25:59.561645	A310	Alarm Lini Niverplast - Transport System
3002	311	41	2026-10-05 21:25:59.561645	A311	Błąd Lini Niverplst - Transport System
3018	309	39	2026-10-05 21:31:59.903852	A309	Błąd Lini Niverplst - Easy Plast
3019	310	41	2026-10-05 21:31:59.903852	A310	Alarm Lini Niverplast - Transport System
3020	311	41	2026-10-05 21:31:59.903852	A311	Błąd Lini Niverplst - Transport System
3036	309	39	2026-10-05 21:38:00.251609	A309	Błąd Lini Niverplst - Easy Plast
3037	310	41	2026-10-05 21:38:00.251609	A310	Alarm Lini Niverplast - Transport System
3038	311	41	2026-10-05 21:38:00.251609	A311	Błąd Lini Niverplst - Transport System
3054	309	39	2026-10-05 21:44:00.613853	A309	Błąd Lini Niverplst - Easy Plast
3055	310	41	2026-10-05 21:44:00.613853	A310	Alarm Lini Niverplast - Transport System
3056	311	41	2026-10-05 21:44:00.613853	A311	Błąd Lini Niverplst - Transport System
3072	309	39	2026-10-05 21:50:00.962107	A309	Błąd Lini Niverplst - Easy Plast
3073	310	41	2026-10-05 21:50:00.962107	A310	Alarm Lini Niverplast - Transport System
3074	311	41	2026-10-05 21:50:00.962107	A311	Błąd Lini Niverplst - Transport System
3090	309	39	2026-10-05 21:56:01.301829	A309	Błąd Lini Niverplst - Easy Plast
3091	310	41	2026-10-05 21:56:01.301829	A310	Alarm Lini Niverplast - Transport System
3092	311	41	2026-10-05 21:56:01.301829	A311	Błąd Lini Niverplst - Transport System
3108	309	39	2026-10-05 22:02:01.644514	A309	Błąd Lini Niverplst - Easy Plast
3109	310	41	2026-10-05 22:02:01.644514	A310	Alarm Lini Niverplast - Transport System
3110	311	41	2026-10-05 22:02:01.644514	A311	Błąd Lini Niverplst - Transport System
3126	309	39	2026-10-05 22:08:01.98877	A309	Błąd Lini Niverplst - Easy Plast
3127	310	41	2026-10-05 22:08:01.98877	A310	Alarm Lini Niverplast - Transport System
3128	311	41	2026-10-05 22:08:01.98877	A311	Błąd Lini Niverplst - Transport System
3144	309	39	2026-10-05 22:14:02.334794	A309	Błąd Lini Niverplst - Easy Plast
3145	310	41	2026-10-05 22:14:02.334794	A310	Alarm Lini Niverplast - Transport System
3146	311	41	2026-10-05 22:14:02.334794	A311	Błąd Lini Niverplst - Transport System
3162	309	39	2026-10-05 22:20:02.660598	A309	Błąd Lini Niverplst - Easy Plast
3163	310	41	2026-10-05 22:20:02.660598	A310	Alarm Lini Niverplast - Transport System
3164	311	41	2026-10-05 22:20:02.660598	A311	Błąd Lini Niverplst - Transport System
3180	309	39	2026-10-05 22:26:03.01529	A309	Błąd Lini Niverplst - Easy Plast
3181	310	41	2026-10-05 22:26:03.01529	A310	Alarm Lini Niverplast - Transport System
3182	311	41	2026-10-05 22:26:03.01529	A311	Błąd Lini Niverplst - Transport System
3198	309	39	2026-10-05 22:32:03.352428	A309	Błąd Lini Niverplst - Easy Plast
3199	310	41	2026-10-05 22:32:03.352428	A310	Alarm Lini Niverplast - Transport System
3200	311	41	2026-10-05 22:32:03.352428	A311	Błąd Lini Niverplst - Transport System
3216	309	39	2026-10-05 22:38:03.671857	A309	Błąd Lini Niverplst - Easy Plast
3217	310	41	2026-10-05 22:38:03.671857	A310	Alarm Lini Niverplast - Transport System
3218	311	41	2026-10-05 22:38:03.671857	A311	Błąd Lini Niverplst - Transport System
3234	309	39	2026-10-05 22:44:03.927328	A309	Błąd Lini Niverplst - Easy Plast
3235	310	41	2026-10-05 22:44:03.927328	A310	Alarm Lini Niverplast - Transport System
3236	311	41	2026-10-05 22:44:03.927328	A311	Błąd Lini Niverplst - Transport System
3252	309	39	2026-10-05 22:50:04.264241	A309	Błąd Lini Niverplst - Easy Plast
3253	310	41	2026-10-05 22:50:04.264241	A310	Alarm Lini Niverplast - Transport System
3254	311	41	2026-10-05 22:50:04.264241	A311	Błąd Lini Niverplst - Transport System
3260	311	41	2026-10-05 22:52:04.383681	A311	Błąd Lini Niverplst - Transport System
1259	129	40	2026-10-05 12:03:26.130785	A129	Niskie ciśnienie pneumatyczne - strefa 1
1260	164	40	2026-10-05 12:03:26.130785	A164	\N
1261	309	39	2026-10-05 12:03:26.130785	A309	Błąd Lini Niverplst - Easy Plast
1262	310	41	2026-10-05 12:03:26.130785	A310	Alarm Lini Niverplast - Transport System
1263	311	41	2026-10-05 12:03:26.130785	A311	Błąd Lini Niverplst - Transport System
2769	309	39	2026-10-05 20:08:55.119789	A309	Błąd Lini Niverplst - Easy Plast
2770	310	41	2026-10-05 20:08:55.119789	A310	Alarm Lini Niverplast - Transport System
2771	311	41	2026-10-05 20:08:55.119789	A311	Błąd Lini Niverplst - Transport System
2790	309	39	2026-10-05 20:15:55.511121	A309	Błąd Lini Niverplst - Easy Plast
2791	310	41	2026-10-05 20:15:55.511121	A310	Alarm Lini Niverplast - Transport System
2792	311	41	2026-10-05 20:15:55.511121	A311	Błąd Lini Niverplst - Transport System
2811	309	39	2026-10-05 20:22:55.925549	A309	Błąd Lini Niverplst - Easy Plast
2812	310	41	2026-10-05 20:22:55.925549	A310	Alarm Lini Niverplast - Transport System
2813	311	41	2026-10-05 20:22:55.925549	A311	Błąd Lini Niverplst - Transport System
2832	309	39	2026-10-05 20:29:56.323435	A309	Błąd Lini Niverplst - Easy Plast
2833	310	41	2026-10-05 20:29:56.323435	A310	Alarm Lini Niverplast - Transport System
2834	311	41	2026-10-05 20:29:56.323435	A311	Błąd Lini Niverplst - Transport System
2853	309	39	2026-10-05 20:36:56.73713	A309	Błąd Lini Niverplst - Easy Plast
2854	310	41	2026-10-05 20:36:56.73713	A310	Alarm Lini Niverplast - Transport System
2855	311	41	2026-10-05 20:36:56.73713	A311	Błąd Lini Niverplst - Transport System
2874	309	39	2026-10-05 20:43:57.163685	A309	Błąd Lini Niverplst - Easy Plast
2875	310	41	2026-10-05 20:43:57.163685	A310	Alarm Lini Niverplast - Transport System
2876	311	41	2026-10-05 20:43:57.163685	A311	Błąd Lini Niverplst - Transport System
2895	309	39	2026-10-05 20:50:57.533363	A309	Błąd Lini Niverplst - Easy Plast
2896	310	41	2026-10-05 20:50:57.533363	A310	Alarm Lini Niverplast - Transport System
2897	311	41	2026-10-05 20:50:57.533363	A311	Błąd Lini Niverplst - Transport System
2913	309	39	2026-10-05 20:56:57.899323	A309	Błąd Lini Niverplst - Easy Plast
2914	310	41	2026-10-05 20:56:57.899323	A310	Alarm Lini Niverplast - Transport System
2915	311	41	2026-10-05 20:56:57.899323	A311	Błąd Lini Niverplst - Transport System
2931	309	39	2026-10-05 21:02:58.230002	A309	Błąd Lini Niverplst - Easy Plast
2932	310	41	2026-10-05 21:02:58.230002	A310	Alarm Lini Niverplast - Transport System
2933	311	41	2026-10-05 21:02:58.230002	A311	Błąd Lini Niverplst - Transport System
2949	309	39	2026-10-05 21:08:58.589776	A309	Błąd Lini Niverplst - Easy Plast
2950	310	41	2026-10-05 21:08:58.589776	A310	Alarm Lini Niverplast - Transport System
2951	311	41	2026-10-05 21:08:58.589776	A311	Błąd Lini Niverplst - Transport System
2967	309	39	2026-10-05 21:14:58.959358	A309	Błąd Lini Niverplst - Easy Plast
2968	310	41	2026-10-05 21:14:58.959358	A310	Alarm Lini Niverplast - Transport System
2969	311	41	2026-10-05 21:14:58.959358	A311	Błąd Lini Niverplst - Transport System
2985	309	39	2026-10-05 21:20:59.291185	A309	Błąd Lini Niverplst - Easy Plast
2986	310	41	2026-10-05 21:20:59.291185	A310	Alarm Lini Niverplast - Transport System
2987	311	41	2026-10-05 21:20:59.291185	A311	Błąd Lini Niverplst - Transport System
3003	309	39	2026-10-05 21:26:59.628992	A309	Błąd Lini Niverplst - Easy Plast
3004	310	41	2026-10-05 21:26:59.628992	A310	Alarm Lini Niverplast - Transport System
3005	311	41	2026-10-05 21:26:59.628992	A311	Błąd Lini Niverplst - Transport System
3021	309	39	2026-10-05 21:32:59.977385	A309	Błąd Lini Niverplst - Easy Plast
3022	310	41	2026-10-05 21:32:59.977385	A310	Alarm Lini Niverplast - Transport System
3023	311	41	2026-10-05 21:32:59.977385	A311	Błąd Lini Niverplst - Transport System
3039	309	39	2026-10-05 21:39:00.317942	A309	Błąd Lini Niverplst - Easy Plast
3040	310	41	2026-10-05 21:39:00.317942	A310	Alarm Lini Niverplast - Transport System
3041	311	41	2026-10-05 21:39:00.317942	A311	Błąd Lini Niverplst - Transport System
3057	309	39	2026-10-05 21:45:00.676207	A309	Błąd Lini Niverplst - Easy Plast
3058	310	41	2026-10-05 21:45:00.676207	A310	Alarm Lini Niverplast - Transport System
3059	311	41	2026-10-05 21:45:00.676207	A311	Błąd Lini Niverplst - Transport System
3075	309	39	2026-10-05 21:51:01.016112	A309	Błąd Lini Niverplst - Easy Plast
3076	310	41	2026-10-05 21:51:01.016112	A310	Alarm Lini Niverplast - Transport System
3077	311	41	2026-10-05 21:51:01.016112	A311	Błąd Lini Niverplst - Transport System
3093	309	39	2026-10-05 21:57:01.366062	A309	Błąd Lini Niverplst - Easy Plast
3094	310	41	2026-10-05 21:57:01.366062	A310	Alarm Lini Niverplast - Transport System
3095	311	41	2026-10-05 21:57:01.366062	A311	Błąd Lini Niverplst - Transport System
3111	309	39	2026-10-05 22:03:01.688121	A309	Błąd Lini Niverplst - Easy Plast
3112	310	41	2026-10-05 22:03:01.688121	A310	Alarm Lini Niverplast - Transport System
3113	311	41	2026-10-05 22:03:01.688121	A311	Błąd Lini Niverplst - Transport System
3129	309	39	2026-10-05 22:09:02.038171	A309	Błąd Lini Niverplst - Easy Plast
3130	310	41	2026-10-05 22:09:02.038171	A310	Alarm Lini Niverplast - Transport System
3131	311	41	2026-10-05 22:09:02.038171	A311	Błąd Lini Niverplst - Transport System
3147	309	39	2026-10-05 22:15:02.381348	A309	Błąd Lini Niverplst - Easy Plast
3148	310	41	2026-10-05 22:15:02.381348	A310	Alarm Lini Niverplast - Transport System
3149	311	41	2026-10-05 22:15:02.381348	A311	Błąd Lini Niverplst - Transport System
3165	309	39	2026-10-05 22:21:02.727187	A309	Błąd Lini Niverplst - Easy Plast
3166	310	41	2026-10-05 22:21:02.727187	A310	Alarm Lini Niverplast - Transport System
3167	311	41	2026-10-05 22:21:02.727187	A311	Błąd Lini Niverplst - Transport System
3183	309	39	2026-10-05 22:27:03.069857	A309	Błąd Lini Niverplst - Easy Plast
3184	310	41	2026-10-05 22:27:03.069857	A310	Alarm Lini Niverplast - Transport System
3185	311	41	2026-10-05 22:27:03.069857	A311	Błąd Lini Niverplst - Transport System
3201	309	39	2026-10-05 22:33:03.412049	A309	Błąd Lini Niverplst - Easy Plast
3202	310	41	2026-10-05 22:33:03.412049	A310	Alarm Lini Niverplast - Transport System
3203	311	41	2026-10-05 22:33:03.412049	A311	Błąd Lini Niverplst - Transport System
3219	309	39	2026-10-05 22:39:03.628822	A309	Błąd Lini Niverplst - Easy Plast
3220	310	41	2026-10-05 22:39:03.628822	A310	Alarm Lini Niverplast - Transport System
3221	311	41	2026-10-05 22:39:03.628822	A311	Błąd Lini Niverplst - Transport System
3237	309	39	2026-10-05 22:45:03.972766	A309	Błąd Lini Niverplst - Easy Plast
3238	310	41	2026-10-05 22:45:03.972766	A310	Alarm Lini Niverplast - Transport System
3239	311	41	2026-10-05 22:45:03.972766	A311	Błąd Lini Niverplst - Transport System
3255	309	39	2026-10-05 22:51:04.317751	A309	Błąd Lini Niverplst - Easy Plast
1265	129	40	2026-10-05 12:04:26.424822	A129	Niskie ciśnienie pneumatyczne - strefa 1
1266	164	40	2026-10-05 12:04:26.424822	A164	\N
1267	309	39	2026-10-05 12:04:26.424822	A309	Błąd Lini Niverplst - Easy Plast
1268	310	41	2026-10-05 12:04:26.424822	A310	Alarm Lini Niverplast - Transport System
1269	311	41	2026-10-05 12:04:26.424822	A311	Błąd Lini Niverplst - Transport System
2772	309	39	2026-10-05 20:09:55.173189	A309	Błąd Lini Niverplst - Easy Plast
2773	310	41	2026-10-05 20:09:55.173189	A310	Alarm Lini Niverplast - Transport System
2774	311	41	2026-10-05 20:09:55.173189	A311	Błąd Lini Niverplst - Transport System
2793	309	39	2026-10-05 20:16:55.569513	A309	Błąd Lini Niverplst - Easy Plast
2794	310	41	2026-10-05 20:16:55.569513	A310	Alarm Lini Niverplast - Transport System
2795	311	41	2026-10-05 20:16:55.569513	A311	Błąd Lini Niverplst - Transport System
2814	309	39	2026-10-05 20:23:55.992322	A309	Błąd Lini Niverplst - Easy Plast
2815	310	41	2026-10-05 20:23:55.992322	A310	Alarm Lini Niverplast - Transport System
2816	311	41	2026-10-05 20:23:55.992322	A311	Błąd Lini Niverplst - Transport System
2835	309	39	2026-10-05 20:30:56.372406	A309	Błąd Lini Niverplst - Easy Plast
2836	310	41	2026-10-05 20:30:56.372406	A310	Alarm Lini Niverplast - Transport System
2837	311	41	2026-10-05 20:30:56.372406	A311	Błąd Lini Niverplst - Transport System
2856	309	39	2026-10-05 20:37:56.789105	A309	Błąd Lini Niverplst - Easy Plast
2857	310	41	2026-10-05 20:37:56.789105	A310	Alarm Lini Niverplast - Transport System
2858	311	41	2026-10-05 20:37:56.789105	A311	Błąd Lini Niverplst - Transport System
2877	309	39	2026-10-05 20:44:57.194343	A309	Błąd Lini Niverplst - Easy Plast
2878	310	41	2026-10-05 20:44:57.194343	A310	Alarm Lini Niverplast - Transport System
2879	311	41	2026-10-05 20:44:57.194343	A311	Błąd Lini Niverplst - Transport System
2898	309	39	2026-10-05 20:51:57.595715	A309	Błąd Lini Niverplst - Easy Plast
2899	310	41	2026-10-05 20:51:57.595715	A310	Alarm Lini Niverplast - Transport System
2900	311	41	2026-10-05 20:51:57.595715	A311	Błąd Lini Niverplst - Transport System
2916	309	39	2026-10-05 20:57:57.948833	A309	Błąd Lini Niverplst - Easy Plast
2917	310	41	2026-10-05 20:57:57.948833	A310	Alarm Lini Niverplast - Transport System
2918	311	41	2026-10-05 20:57:57.948833	A311	Błąd Lini Niverplst - Transport System
2934	309	39	2026-10-05 21:03:58.290968	A309	Błąd Lini Niverplst - Easy Plast
2935	310	41	2026-10-05 21:03:58.290968	A310	Alarm Lini Niverplast - Transport System
2936	311	41	2026-10-05 21:03:58.290968	A311	Błąd Lini Niverplst - Transport System
2952	309	39	2026-10-05 21:09:58.646528	A309	Błąd Lini Niverplst - Easy Plast
2953	310	41	2026-10-05 21:09:58.646528	A310	Alarm Lini Niverplast - Transport System
2954	311	41	2026-10-05 21:09:58.646528	A311	Błąd Lini Niverplst - Transport System
2970	309	39	2026-10-05 21:15:59.008948	A309	Błąd Lini Niverplst - Easy Plast
2971	310	41	2026-10-05 21:15:59.008948	A310	Alarm Lini Niverplast - Transport System
2972	311	41	2026-10-05 21:15:59.008948	A311	Błąd Lini Niverplst - Transport System
2988	309	39	2026-10-05 21:21:59.341106	A309	Błąd Lini Niverplst - Easy Plast
2989	310	41	2026-10-05 21:21:59.341106	A310	Alarm Lini Niverplast - Transport System
2990	311	41	2026-10-05 21:21:59.341106	A311	Błąd Lini Niverplst - Transport System
3006	309	39	2026-10-05 21:27:59.723889	A309	Błąd Lini Niverplst - Easy Plast
3007	310	41	2026-10-05 21:27:59.723889	A310	Alarm Lini Niverplast - Transport System
3008	311	41	2026-10-05 21:27:59.723889	A311	Błąd Lini Niverplst - Transport System
3024	309	39	2026-10-05 21:34:00.04407	A309	Błąd Lini Niverplst - Easy Plast
3025	310	41	2026-10-05 21:34:00.04407	A310	Alarm Lini Niverplast - Transport System
3026	311	41	2026-10-05 21:34:00.04407	A311	Błąd Lini Niverplst - Transport System
3042	309	39	2026-10-05 21:40:00.372499	A309	Błąd Lini Niverplst - Easy Plast
3043	310	41	2026-10-05 21:40:00.372499	A310	Alarm Lini Niverplast - Transport System
3044	311	41	2026-10-05 21:40:00.372499	A311	Błąd Lini Niverplst - Transport System
3060	309	39	2026-10-05 21:46:00.729995	A309	Błąd Lini Niverplst - Easy Plast
3061	310	41	2026-10-05 21:46:00.729995	A310	Alarm Lini Niverplast - Transport System
3062	311	41	2026-10-05 21:46:00.729995	A311	Błąd Lini Niverplst - Transport System
3078	309	39	2026-10-05 21:52:01.089683	A309	Błąd Lini Niverplst - Easy Plast
3079	310	41	2026-10-05 21:52:01.089683	A310	Alarm Lini Niverplast - Transport System
3080	311	41	2026-10-05 21:52:01.089683	A311	Błąd Lini Niverplst - Transport System
3096	309	39	2026-10-05 21:58:01.434254	A309	Błąd Lini Niverplst - Easy Plast
3097	310	41	2026-10-05 21:58:01.434254	A310	Alarm Lini Niverplast - Transport System
3098	311	41	2026-10-05 21:58:01.434254	A311	Błąd Lini Niverplst - Transport System
3114	309	39	2026-10-05 22:04:01.749468	A309	Błąd Lini Niverplst - Easy Plast
3115	310	41	2026-10-05 22:04:01.749468	A310	Alarm Lini Niverplast - Transport System
3116	311	41	2026-10-05 22:04:01.749468	A311	Błąd Lini Niverplst - Transport System
3132	309	39	2026-10-05 22:10:02.103019	A309	Błąd Lini Niverplst - Easy Plast
3133	310	41	2026-10-05 22:10:02.103019	A310	Alarm Lini Niverplast - Transport System
3134	311	41	2026-10-05 22:10:02.103019	A311	Błąd Lini Niverplst - Transport System
3150	309	39	2026-10-05 22:16:02.459031	A309	Błąd Lini Niverplst - Easy Plast
3151	310	41	2026-10-05 22:16:02.459031	A310	Alarm Lini Niverplast - Transport System
3152	311	41	2026-10-05 22:16:02.459031	A311	Błąd Lini Niverplst - Transport System
3168	309	39	2026-10-05 22:22:02.805645	A309	Błąd Lini Niverplst - Easy Plast
3169	310	41	2026-10-05 22:22:02.805645	A310	Alarm Lini Niverplast - Transport System
3170	311	41	2026-10-05 22:22:02.805645	A311	Błąd Lini Niverplst - Transport System
3186	309	39	2026-10-05 22:28:03.13034	A309	Błąd Lini Niverplst - Easy Plast
3187	310	41	2026-10-05 22:28:03.13034	A310	Alarm Lini Niverplast - Transport System
3188	311	41	2026-10-05 22:28:03.13034	A311	Błąd Lini Niverplst - Transport System
3204	309	39	2026-10-05 22:34:03.447833	A309	Błąd Lini Niverplst - Easy Plast
3205	310	41	2026-10-05 22:34:03.447833	A310	Alarm Lini Niverplast - Transport System
3206	311	41	2026-10-05 22:34:03.447833	A311	Błąd Lini Niverplst - Transport System
3222	309	39	2026-10-05 22:40:03.683387	A309	Błąd Lini Niverplst - Easy Plast
3223	310	41	2026-10-05 22:40:03.683387	A310	Alarm Lini Niverplast - Transport System
3224	311	41	2026-10-05 22:40:03.683387	A311	Błąd Lini Niverplst - Transport System
3240	309	39	2026-10-05 22:46:04.030006	A309	Błąd Lini Niverplst - Easy Plast
3241	310	41	2026-10-05 22:46:04.030006	A310	Alarm Lini Niverplast - Transport System
3242	311	41	2026-10-05 22:46:04.030006	A311	Błąd Lini Niverplst - Transport System
3256	310	41	2026-10-05 22:51:04.317751	A310	Alarm Lini Niverplast - Transport System
1271	129	40	2026-10-05 12:05:26.769497	A129	Niskie ciśnienie pneumatyczne - strefa 1
1272	164	40	2026-10-05 12:05:26.769497	A164	\N
1273	309	39	2026-10-05 12:05:26.769497	A309	Błąd Lini Niverplst - Easy Plast
1274	310	41	2026-10-05 12:05:26.769497	A310	Alarm Lini Niverplast - Transport System
1275	311	41	2026-10-05 12:05:26.769497	A311	Błąd Lini Niverplst - Transport System
2775	309	39	2026-10-05 20:10:55.234251	A309	Błąd Lini Niverplst - Easy Plast
2776	310	41	2026-10-05 20:10:55.234251	A310	Alarm Lini Niverplast - Transport System
2777	311	41	2026-10-05 20:10:55.234251	A311	Błąd Lini Niverplst - Transport System
2796	309	39	2026-10-05 20:17:55.643574	A309	Błąd Lini Niverplst - Easy Plast
2797	310	41	2026-10-05 20:17:55.643574	A310	Alarm Lini Niverplast - Transport System
2798	311	41	2026-10-05 20:17:55.643574	A311	Błąd Lini Niverplst - Transport System
2817	309	39	2026-10-05 20:24:56.041621	A309	Błąd Lini Niverplst - Easy Plast
2818	310	41	2026-10-05 20:24:56.041621	A310	Alarm Lini Niverplast - Transport System
2819	311	41	2026-10-05 20:24:56.041621	A311	Błąd Lini Niverplst - Transport System
2838	309	39	2026-10-05 20:31:56.428401	A309	Błąd Lini Niverplst - Easy Plast
2839	310	41	2026-10-05 20:31:56.428401	A310	Alarm Lini Niverplast - Transport System
2840	311	41	2026-10-05 20:31:56.428401	A311	Błąd Lini Niverplst - Transport System
2859	309	39	2026-10-05 20:38:56.856002	A309	Błąd Lini Niverplst - Easy Plast
2860	310	41	2026-10-05 20:38:56.856002	A310	Alarm Lini Niverplast - Transport System
2861	311	41	2026-10-05 20:38:56.856002	A311	Błąd Lini Niverplst - Transport System
2880	309	39	2026-10-05 20:45:57.236449	A309	Błąd Lini Niverplst - Easy Plast
2881	310	41	2026-10-05 20:45:57.236449	A310	Alarm Lini Niverplast - Transport System
2882	311	41	2026-10-05 20:45:57.236449	A311	Błąd Lini Niverplst - Transport System
2901	309	39	2026-10-05 20:52:57.646213	A309	Błąd Lini Niverplst - Easy Plast
2902	310	41	2026-10-05 20:52:57.646213	A310	Alarm Lini Niverplast - Transport System
2903	311	41	2026-10-05 20:52:57.646213	A311	Błąd Lini Niverplst - Transport System
2919	309	39	2026-10-05 20:58:57.9972	A309	Błąd Lini Niverplst - Easy Plast
2920	310	41	2026-10-05 20:58:57.9972	A310	Alarm Lini Niverplast - Transport System
2921	311	41	2026-10-05 20:58:57.9972	A311	Błąd Lini Niverplst - Transport System
2937	309	39	2026-10-05 21:04:58.349287	A309	Błąd Lini Niverplst - Easy Plast
2938	310	41	2026-10-05 21:04:58.349287	A310	Alarm Lini Niverplast - Transport System
2939	311	41	2026-10-05 21:04:58.349287	A311	Błąd Lini Niverplst - Transport System
2955	309	39	2026-10-05 21:10:58.698147	A309	Błąd Lini Niverplst - Easy Plast
2956	310	41	2026-10-05 21:10:58.698147	A310	Alarm Lini Niverplast - Transport System
2957	311	41	2026-10-05 21:10:58.698147	A311	Błąd Lini Niverplst - Transport System
2973	309	39	2026-10-05 21:16:59.069651	A309	Błąd Lini Niverplst - Easy Plast
2974	310	41	2026-10-05 21:16:59.069651	A310	Alarm Lini Niverplast - Transport System
2975	311	41	2026-10-05 21:16:59.069651	A311	Błąd Lini Niverplst - Transport System
2991	309	39	2026-10-05 21:22:59.393374	A309	Błąd Lini Niverplst - Easy Plast
2992	310	41	2026-10-05 21:22:59.393374	A310	Alarm Lini Niverplast - Transport System
2993	311	41	2026-10-05 21:22:59.393374	A311	Błąd Lini Niverplst - Transport System
3009	309	39	2026-10-05 21:28:59.735063	A309	Błąd Lini Niverplst - Easy Plast
3010	310	41	2026-10-05 21:28:59.735063	A310	Alarm Lini Niverplast - Transport System
3011	311	41	2026-10-05 21:28:59.735063	A311	Błąd Lini Niverplst - Transport System
3027	309	39	2026-10-05 21:35:00.081872	A309	Błąd Lini Niverplst - Easy Plast
3028	310	41	2026-10-05 21:35:00.081872	A310	Alarm Lini Niverplast - Transport System
3029	311	41	2026-10-05 21:35:00.081872	A311	Błąd Lini Niverplst - Transport System
3045	309	39	2026-10-05 21:41:00.450589	A309	Błąd Lini Niverplst - Easy Plast
3046	310	41	2026-10-05 21:41:00.450589	A310	Alarm Lini Niverplast - Transport System
3047	311	41	2026-10-05 21:41:00.450589	A311	Błąd Lini Niverplst - Transport System
3063	309	39	2026-10-05 21:47:00.788353	A309	Błąd Lini Niverplst - Easy Plast
3064	310	41	2026-10-05 21:47:00.788353	A310	Alarm Lini Niverplast - Transport System
3065	311	41	2026-10-05 21:47:00.788353	A311	Błąd Lini Niverplst - Transport System
3081	309	39	2026-10-05 21:53:01.13387	A309	Błąd Lini Niverplst - Easy Plast
3082	310	41	2026-10-05 21:53:01.13387	A310	Alarm Lini Niverplast - Transport System
3083	311	41	2026-10-05 21:53:01.13387	A311	Błąd Lini Niverplst - Transport System
3099	309	39	2026-10-05 21:59:01.468993	A309	Błąd Lini Niverplst - Easy Plast
3100	310	41	2026-10-05 21:59:01.468993	A310	Alarm Lini Niverplast - Transport System
3101	311	41	2026-10-05 21:59:01.468993	A311	Błąd Lini Niverplst - Transport System
3117	309	39	2026-10-05 22:05:01.808247	A309	Błąd Lini Niverplst - Easy Plast
3118	310	41	2026-10-05 22:05:01.808247	A310	Alarm Lini Niverplast - Transport System
3119	311	41	2026-10-05 22:05:01.808247	A311	Błąd Lini Niverplst - Transport System
3135	309	39	2026-10-05 22:11:02.169341	A309	Błąd Lini Niverplst - Easy Plast
3136	310	41	2026-10-05 22:11:02.169341	A310	Alarm Lini Niverplast - Transport System
3137	311	41	2026-10-05 22:11:02.169341	A311	Błąd Lini Niverplst - Transport System
3153	309	39	2026-10-05 22:17:02.510898	A309	Błąd Lini Niverplst - Easy Plast
3154	310	41	2026-10-05 22:17:02.510898	A310	Alarm Lini Niverplast - Transport System
3155	311	41	2026-10-05 22:17:02.510898	A311	Błąd Lini Niverplst - Transport System
3171	309	39	2026-10-05 22:23:02.867789	A309	Błąd Lini Niverplst - Easy Plast
3172	310	41	2026-10-05 22:23:02.867789	A310	Alarm Lini Niverplast - Transport System
3173	311	41	2026-10-05 22:23:02.867789	A311	Błąd Lini Niverplst - Transport System
3189	309	39	2026-10-05 22:29:03.187118	A309	Błąd Lini Niverplst - Easy Plast
3190	310	41	2026-10-05 22:29:03.187118	A310	Alarm Lini Niverplast - Transport System
3191	311	41	2026-10-05 22:29:03.187118	A311	Błąd Lini Niverplst - Transport System
3207	309	39	2026-10-05 22:35:03.471158	A309	Błąd Lini Niverplst - Easy Plast
3208	310	41	2026-10-05 22:35:03.471158	A310	Alarm Lini Niverplast - Transport System
3209	311	41	2026-10-05 22:35:03.471158	A311	Błąd Lini Niverplst - Transport System
3225	309	39	2026-10-05 22:41:03.741296	A309	Błąd Lini Niverplst - Easy Plast
3226	310	41	2026-10-05 22:41:03.741296	A310	Alarm Lini Niverplast - Transport System
3227	311	41	2026-10-05 22:41:03.741296	A311	Błąd Lini Niverplst - Transport System
3243	309	39	2026-10-05 22:47:04.096186	A309	Błąd Lini Niverplst - Easy Plast
3244	310	41	2026-10-05 22:47:04.096186	A310	Alarm Lini Niverplast - Transport System
3245	311	41	2026-10-05 22:47:04.096186	A311	Błąd Lini Niverplst - Transport System
3257	311	41	2026-10-05 22:51:04.317751	A311	Błąd Lini Niverplst - Transport System
1277	129	40	2026-10-05 12:06:27.070306	A129	Niskie ciśnienie pneumatyczne - strefa 1
1278	164	40	2026-10-05 12:06:27.070306	A164	\N
1279	309	39	2026-10-05 12:06:27.070306	A309	Błąd Lini Niverplst - Easy Plast
1280	310	41	2026-10-05 12:06:27.070306	A310	Alarm Lini Niverplast - Transport System
1281	311	41	2026-10-05 12:06:27.070306	A311	Błąd Lini Niverplst - Transport System
2778	309	39	2026-10-05 20:11:55.293317	A309	Błąd Lini Niverplst - Easy Plast
2779	310	41	2026-10-05 20:11:55.293317	A310	Alarm Lini Niverplast - Transport System
2780	311	41	2026-10-05 20:11:55.293317	A311	Błąd Lini Niverplst - Transport System
2799	309	39	2026-10-05 20:18:55.687371	A309	Błąd Lini Niverplst - Easy Plast
2800	310	41	2026-10-05 20:18:55.687371	A310	Alarm Lini Niverplast - Transport System
2801	311	41	2026-10-05 20:18:55.687371	A311	Błąd Lini Niverplst - Transport System
2820	309	39	2026-10-05 20:25:56.107233	A309	Błąd Lini Niverplst - Easy Plast
2821	310	41	2026-10-05 20:25:56.107233	A310	Alarm Lini Niverplast - Transport System
2822	311	41	2026-10-05 20:25:56.107233	A311	Błąd Lini Niverplst - Transport System
2841	309	39	2026-10-05 20:32:56.494392	A309	Błąd Lini Niverplst - Easy Plast
2842	310	41	2026-10-05 20:32:56.494392	A310	Alarm Lini Niverplast - Transport System
2843	311	41	2026-10-05 20:32:56.494392	A311	Błąd Lini Niverplst - Transport System
2862	309	39	2026-10-05 20:39:56.902836	A309	Błąd Lini Niverplst - Easy Plast
2863	310	41	2026-10-05 20:39:56.902836	A310	Alarm Lini Niverplast - Transport System
2864	311	41	2026-10-05 20:39:56.902836	A311	Błąd Lini Niverplst - Transport System
2883	309	39	2026-10-05 20:46:57.297262	A309	Błąd Lini Niverplst - Easy Plast
2884	310	41	2026-10-05 20:46:57.297262	A310	Alarm Lini Niverplast - Transport System
2885	311	41	2026-10-05 20:46:57.297262	A311	Błąd Lini Niverplst - Transport System
2904	309	39	2026-10-05 20:53:57.712406	A309	Błąd Lini Niverplst - Easy Plast
2905	310	41	2026-10-05 20:53:57.712406	A310	Alarm Lini Niverplast - Transport System
2906	311	41	2026-10-05 20:53:57.712406	A311	Błąd Lini Niverplst - Transport System
2922	309	39	2026-10-05 20:59:58.056345	A309	Błąd Lini Niverplst - Easy Plast
2923	310	41	2026-10-05 20:59:58.056345	A310	Alarm Lini Niverplast - Transport System
2924	311	41	2026-10-05 20:59:58.056345	A311	Błąd Lini Niverplst - Transport System
2940	309	39	2026-10-05 21:05:58.407341	A309	Błąd Lini Niverplst - Easy Plast
2941	310	41	2026-10-05 21:05:58.407341	A310	Alarm Lini Niverplast - Transport System
2942	311	41	2026-10-05 21:05:58.407341	A311	Błąd Lini Niverplst - Transport System
2958	309	39	2026-10-05 21:11:58.763237	A309	Błąd Lini Niverplst - Easy Plast
2959	310	41	2026-10-05 21:11:58.763237	A310	Alarm Lini Niverplast - Transport System
2960	311	41	2026-10-05 21:11:58.763237	A311	Błąd Lini Niverplst - Transport System
2976	309	39	2026-10-05 21:17:59.103045	A309	Błąd Lini Niverplst - Easy Plast
2977	310	41	2026-10-05 21:17:59.103045	A310	Alarm Lini Niverplast - Transport System
2978	311	41	2026-10-05 21:17:59.103045	A311	Błąd Lini Niverplst - Transport System
2994	309	39	2026-10-05 21:23:59.446138	A309	Błąd Lini Niverplst - Easy Plast
2995	310	41	2026-10-05 21:23:59.446138	A310	Alarm Lini Niverplast - Transport System
2996	311	41	2026-10-05 21:23:59.446138	A311	Błąd Lini Niverplst - Transport System
3012	309	39	2026-10-05 21:29:59.796556	A309	Błąd Lini Niverplst - Easy Plast
3013	310	41	2026-10-05 21:29:59.796556	A310	Alarm Lini Niverplast - Transport System
3014	311	41	2026-10-05 21:29:59.796556	A311	Błąd Lini Niverplst - Transport System
3030	309	39	2026-10-05 21:36:00.15715	A309	Błąd Lini Niverplst - Easy Plast
3031	310	41	2026-10-05 21:36:00.15715	A310	Alarm Lini Niverplast - Transport System
3032	311	41	2026-10-05 21:36:00.15715	A311	Błąd Lini Niverplst - Transport System
3048	309	39	2026-10-05 21:42:00.489464	A309	Błąd Lini Niverplst - Easy Plast
3049	310	41	2026-10-05 21:42:00.489464	A310	Alarm Lini Niverplast - Transport System
3050	311	41	2026-10-05 21:42:00.489464	A311	Błąd Lini Niverplst - Transport System
3066	309	39	2026-10-05 21:48:00.849549	A309	Błąd Lini Niverplst - Easy Plast
3067	310	41	2026-10-05 21:48:00.849549	A310	Alarm Lini Niverplast - Transport System
3068	311	41	2026-10-05 21:48:00.849549	A311	Błąd Lini Niverplst - Transport System
3084	309	39	2026-10-05 21:54:01.179318	A309	Błąd Lini Niverplst - Easy Plast
3085	310	41	2026-10-05 21:54:01.179318	A310	Alarm Lini Niverplast - Transport System
3086	311	41	2026-10-05 21:54:01.179318	A311	Błąd Lini Niverplst - Transport System
3102	309	39	2026-10-05 22:00:01.549254	A309	Błąd Lini Niverplst - Easy Plast
3103	310	41	2026-10-05 22:00:01.549254	A310	Alarm Lini Niverplast - Transport System
3104	311	41	2026-10-05 22:00:01.549254	A311	Błąd Lini Niverplst - Transport System
3120	309	39	2026-10-05 22:06:01.863651	A309	Błąd Lini Niverplst - Easy Plast
3121	310	41	2026-10-05 22:06:01.863651	A310	Alarm Lini Niverplast - Transport System
3122	311	41	2026-10-05 22:06:01.863651	A311	Błąd Lini Niverplst - Transport System
3138	309	39	2026-10-05 22:12:02.21097	A309	Błąd Lini Niverplst - Easy Plast
3139	310	41	2026-10-05 22:12:02.21097	A310	Alarm Lini Niverplast - Transport System
3140	311	41	2026-10-05 22:12:02.21097	A311	Błąd Lini Niverplst - Transport System
3156	309	39	2026-10-05 22:18:02.560259	A309	Błąd Lini Niverplst - Easy Plast
3157	310	41	2026-10-05 22:18:02.560259	A310	Alarm Lini Niverplast - Transport System
3158	311	41	2026-10-05 22:18:02.560259	A311	Błąd Lini Niverplst - Transport System
3174	309	39	2026-10-05 22:24:02.89879	A309	Błąd Lini Niverplst - Easy Plast
3175	310	41	2026-10-05 22:24:02.89879	A310	Alarm Lini Niverplast - Transport System
3176	311	41	2026-10-05 22:24:02.89879	A311	Błąd Lini Niverplst - Transport System
3192	309	39	2026-10-05 22:30:03.230597	A309	Błąd Lini Niverplst - Easy Plast
3193	310	41	2026-10-05 22:30:03.230597	A310	Alarm Lini Niverplast - Transport System
3194	311	41	2026-10-05 22:30:03.230597	A311	Błąd Lini Niverplst - Transport System
3210	309	39	2026-10-05 22:36:03.507814	A309	Błąd Lini Niverplst - Easy Plast
3211	310	41	2026-10-05 22:36:03.507814	A310	Alarm Lini Niverplast - Transport System
3212	311	41	2026-10-05 22:36:03.507814	A311	Błąd Lini Niverplst - Transport System
3228	309	39	2026-10-05 22:42:03.806589	A309	Błąd Lini Niverplst - Easy Plast
3229	310	41	2026-10-05 22:42:03.806589	A310	Alarm Lini Niverplast - Transport System
3230	311	41	2026-10-05 22:42:03.806589	A311	Błąd Lini Niverplst - Transport System
3246	309	39	2026-10-05 22:48:04.321026	A309	Błąd Lini Niverplst - Easy Plast
3247	310	41	2026-10-05 22:48:04.321026	A310	Alarm Lini Niverplast - Transport System
3248	311	41	2026-10-05 22:48:04.321026	A311	Błąd Lini Niverplst - Transport System
3258	309	39	2026-10-05 22:52:04.383681	A309	Błąd Lini Niverplst - Easy Plast
1283	129	40	2026-10-05 12:07:25.28899	A129	Niskie ciśnienie pneumatyczne - strefa 1
1284	164	40	2026-10-05 12:07:25.28899	A164	\N
1285	309	39	2026-10-05 12:07:25.28899	A309	Błąd Lini Niverplst - Easy Plast
1286	310	41	2026-10-05 12:07:25.28899	A310	Alarm Lini Niverplast - Transport System
1287	311	41	2026-10-05 12:07:25.28899	A311	Błąd Lini Niverplst - Transport System
2781	309	39	2026-10-05 20:12:55.332311	A309	Błąd Lini Niverplst - Easy Plast
2782	310	41	2026-10-05 20:12:55.332311	A310	Alarm Lini Niverplast - Transport System
2783	311	41	2026-10-05 20:12:55.332311	A311	Błąd Lini Niverplst - Transport System
2802	309	39	2026-10-05 20:19:55.753731	A309	Błąd Lini Niverplst - Easy Plast
2803	310	41	2026-10-05 20:19:55.753731	A310	Alarm Lini Niverplast - Transport System
2804	311	41	2026-10-05 20:19:55.753731	A311	Błąd Lini Niverplst - Transport System
2823	309	39	2026-10-05 20:26:56.143503	A309	Błąd Lini Niverplst - Easy Plast
2824	310	41	2026-10-05 20:26:56.143503	A310	Alarm Lini Niverplast - Transport System
2825	311	41	2026-10-05 20:26:56.143503	A311	Błąd Lini Niverplst - Transport System
2844	309	39	2026-10-05 20:33:56.555436	A309	Błąd Lini Niverplst - Easy Plast
2845	310	41	2026-10-05 20:33:56.555436	A310	Alarm Lini Niverplast - Transport System
2846	311	41	2026-10-05 20:33:56.555436	A311	Błąd Lini Niverplst - Transport System
2865	309	39	2026-10-05 20:40:56.964668	A309	Błąd Lini Niverplst - Easy Plast
2866	310	41	2026-10-05 20:40:56.964668	A310	Alarm Lini Niverplast - Transport System
2867	311	41	2026-10-05 20:40:56.964668	A311	Błąd Lini Niverplst - Transport System
2886	309	39	2026-10-05 20:47:57.36437	A309	Błąd Lini Niverplst - Easy Plast
2887	310	41	2026-10-05 20:47:57.36437	A310	Alarm Lini Niverplast - Transport System
2888	311	41	2026-10-05 20:47:57.36437	A311	Błąd Lini Niverplst - Transport System
2907	309	39	2026-10-05 20:54:57.761686	A309	Błąd Lini Niverplst - Easy Plast
2908	310	41	2026-10-05 20:54:57.761686	A310	Alarm Lini Niverplast - Transport System
2909	311	41	2026-10-05 20:54:57.761686	A311	Błąd Lini Niverplst - Transport System
2925	309	39	2026-10-05 21:00:58.110893	A309	Błąd Lini Niverplst - Easy Plast
2926	310	41	2026-10-05 21:00:58.110893	A310	Alarm Lini Niverplast - Transport System
2927	311	41	2026-10-05 21:00:58.110893	A311	Błąd Lini Niverplst - Transport System
2943	309	39	2026-10-05 21:06:58.462337	A309	Błąd Lini Niverplst - Easy Plast
2944	310	41	2026-10-05 21:06:58.462337	A310	Alarm Lini Niverplast - Transport System
2945	311	41	2026-10-05 21:06:58.462337	A311	Błąd Lini Niverplst - Transport System
2961	309	39	2026-10-05 21:12:58.811349	A309	Błąd Lini Niverplst - Easy Plast
2962	310	41	2026-10-05 21:12:58.811349	A310	Alarm Lini Niverplast - Transport System
2963	311	41	2026-10-05 21:12:58.811349	A311	Błąd Lini Niverplst - Transport System
2979	309	39	2026-10-05 21:18:59.171455	A309	Błąd Lini Niverplst - Easy Plast
2980	310	41	2026-10-05 21:18:59.171455	A310	Alarm Lini Niverplast - Transport System
2981	311	41	2026-10-05 21:18:59.171455	A311	Błąd Lini Niverplst - Transport System
2997	309	39	2026-10-05 21:24:59.512824	A309	Błąd Lini Niverplst - Easy Plast
2998	310	41	2026-10-05 21:24:59.512824	A310	Alarm Lini Niverplast - Transport System
2999	311	41	2026-10-05 21:24:59.512824	A311	Błąd Lini Niverplst - Transport System
3015	309	39	2026-10-05 21:30:59.856932	A309	Błąd Lini Niverplst - Easy Plast
3016	310	41	2026-10-05 21:30:59.856932	A310	Alarm Lini Niverplast - Transport System
3017	311	41	2026-10-05 21:30:59.856932	A311	Błąd Lini Niverplst - Transport System
3033	309	39	2026-10-05 21:37:00.221405	A309	Błąd Lini Niverplst - Easy Plast
3034	310	41	2026-10-05 21:37:00.221405	A310	Alarm Lini Niverplast - Transport System
3035	311	41	2026-10-05 21:37:00.221405	A311	Błąd Lini Niverplst - Transport System
3051	309	39	2026-10-05 21:43:00.562883	A309	Błąd Lini Niverplst - Easy Plast
3052	310	41	2026-10-05 21:43:00.562883	A310	Alarm Lini Niverplast - Transport System
3053	311	41	2026-10-05 21:43:00.562883	A311	Błąd Lini Niverplst - Transport System
3069	309	39	2026-10-05 21:49:00.907687	A309	Błąd Lini Niverplst - Easy Plast
3070	310	41	2026-10-05 21:49:00.907687	A310	Alarm Lini Niverplast - Transport System
3071	311	41	2026-10-05 21:49:00.907687	A311	Błąd Lini Niverplst - Transport System
3087	309	39	2026-10-05 21:55:01.24087	A309	Błąd Lini Niverplst - Easy Plast
3088	310	41	2026-10-05 21:55:01.24087	A310	Alarm Lini Niverplast - Transport System
3089	311	41	2026-10-05 21:55:01.24087	A311	Błąd Lini Niverplst - Transport System
3105	309	39	2026-10-05 22:01:01.588651	A309	Błąd Lini Niverplst - Easy Plast
3106	310	41	2026-10-05 22:01:01.588651	A310	Alarm Lini Niverplast - Transport System
3107	311	41	2026-10-05 22:01:01.588651	A311	Błąd Lini Niverplst - Transport System
3123	309	39	2026-10-05 22:07:01.929879	A309	Błąd Lini Niverplst - Easy Plast
3124	310	41	2026-10-05 22:07:01.929879	A310	Alarm Lini Niverplast - Transport System
3125	311	41	2026-10-05 22:07:01.929879	A311	Błąd Lini Niverplst - Transport System
3141	309	39	2026-10-05 22:13:02.285218	A309	Błąd Lini Niverplst - Easy Plast
3142	310	41	2026-10-05 22:13:02.285218	A310	Alarm Lini Niverplast - Transport System
3143	311	41	2026-10-05 22:13:02.285218	A311	Błąd Lini Niverplst - Transport System
3159	309	39	2026-10-05 22:19:02.603737	A309	Błąd Lini Niverplst - Easy Plast
3160	310	41	2026-10-05 22:19:02.603737	A310	Alarm Lini Niverplast - Transport System
3161	311	41	2026-10-05 22:19:02.603737	A311	Błąd Lini Niverplst - Transport System
3177	309	39	2026-10-05 22:25:02.958103	A309	Błąd Lini Niverplst - Easy Plast
3178	310	41	2026-10-05 22:25:02.958103	A310	Alarm Lini Niverplast - Transport System
3179	311	41	2026-10-05 22:25:02.958103	A311	Błąd Lini Niverplst - Transport System
3195	309	39	2026-10-05 22:31:03.304409	A309	Błąd Lini Niverplst - Easy Plast
3196	310	41	2026-10-05 22:31:03.304409	A310	Alarm Lini Niverplast - Transport System
3197	311	41	2026-10-05 22:31:03.304409	A311	Błąd Lini Niverplst - Transport System
3213	309	39	2026-10-05 22:37:03.604391	A309	Błąd Lini Niverplst - Easy Plast
3214	310	41	2026-10-05 22:37:03.604391	A310	Alarm Lini Niverplast - Transport System
3215	311	41	2026-10-05 22:37:03.604391	A311	Błąd Lini Niverplst - Transport System
3231	309	39	2026-10-05 22:43:03.852848	A309	Błąd Lini Niverplst - Easy Plast
3232	310	41	2026-10-05 22:43:03.852848	A310	Alarm Lini Niverplast - Transport System
3233	311	41	2026-10-05 22:43:03.852848	A311	Błąd Lini Niverplst - Transport System
3249	309	39	2026-10-05 22:49:04.19827	A309	Błąd Lini Niverplst - Easy Plast
3250	310	41	2026-10-05 22:49:04.19827	A310	Alarm Lini Niverplast - Transport System
3251	311	41	2026-10-05 22:49:04.19827	A311	Błąd Lini Niverplst - Transport System
3259	310	41	2026-10-05 22:52:04.383681	A310	Alarm Lini Niverplast - Transport System
1289	129	40	2026-10-05 12:08:25.625994	A129	Niskie ciśnienie pneumatyczne - strefa 1
1290	164	40	2026-10-05 12:08:25.625994	A164	\N
1291	309	39	2026-10-05 12:08:25.625994	A309	Błąd Lini Niverplst - Easy Plast
1292	310	41	2026-10-05 12:08:25.625994	A310	Alarm Lini Niverplast - Transport System
1293	311	41	2026-10-05 12:08:25.625994	A311	Błąd Lini Niverplst - Transport System
1294	309	39	2026-10-05 12:09:25.951751	A309	Błąd Lini Niverplst - Easy Plast
1295	310	41	2026-10-05 12:09:25.951751	A310	Alarm Lini Niverplast - Transport System
1296	311	41	2026-10-05 12:09:25.951751	A311	Błąd Lini Niverplst - Transport System
1297	309	39	2026-10-05 12:10:26.368071	A309	Błąd Lini Niverplst - Easy Plast
1298	310	41	2026-10-05 12:10:26.368071	A310	Alarm Lini Niverplast - Transport System
1299	311	41	2026-10-05 12:10:26.368071	A311	Błąd Lini Niverplst - Transport System
1300	309	39	2026-10-05 12:11:26.651404	A309	Błąd Lini Niverplst - Easy Plast
1301	310	41	2026-10-05 12:11:26.651404	A310	Alarm Lini Niverplast - Transport System
1302	311	41	2026-10-05 12:11:26.651404	A311	Błąd Lini Niverplst - Transport System
1303	309	39	2026-10-05 12:12:26.98675	A309	Błąd Lini Niverplst - Easy Plast
1304	310	41	2026-10-05 12:12:26.98675	A310	Alarm Lini Niverplast - Transport System
1305	311	41	2026-10-05 12:12:26.98675	A311	Błąd Lini Niverplst - Transport System
1306	309	39	2026-10-05 12:13:27.301527	A309	Błąd Lini Niverplst - Easy Plast
1307	310	41	2026-10-05 12:13:27.301527	A310	Alarm Lini Niverplast - Transport System
1308	311	41	2026-10-05 12:13:27.301527	A311	Błąd Lini Niverplst - Transport System
1309	309	39	2026-10-05 12:14:27.607395	A309	Błąd Lini Niverplst - Easy Plast
1310	310	41	2026-10-05 12:14:27.607395	A310	Alarm Lini Niverplast - Transport System
1311	311	41	2026-10-05 12:14:27.607395	A311	Błąd Lini Niverplst - Transport System
1312	309	39	2026-10-05 12:15:25.818424	A309	Błąd Lini Niverplst - Easy Plast
1313	310	41	2026-10-05 12:15:25.818424	A310	Alarm Lini Niverplast - Transport System
1314	311	41	2026-10-05 12:15:25.818424	A311	Błąd Lini Niverplst - Transport System
1315	309	39	2026-10-05 12:16:26.151724	A309	Błąd Lini Niverplst - Easy Plast
1316	310	41	2026-10-05 12:16:26.151724	A310	Alarm Lini Niverplast - Transport System
1317	311	41	2026-10-05 12:16:26.151724	A311	Błąd Lini Niverplst - Transport System
1318	309	39	2026-10-05 12:17:26.413435	A309	Błąd Lini Niverplst - Easy Plast
1319	310	41	2026-10-05 12:17:26.413435	A310	Alarm Lini Niverplast - Transport System
1320	311	41	2026-10-05 12:17:26.413435	A311	Błąd Lini Niverplst - Transport System
1321	309	39	2026-10-05 12:18:26.852538	A309	Błąd Lini Niverplst - Easy Plast
1322	310	41	2026-10-05 12:18:26.852538	A310	Alarm Lini Niverplast - Transport System
1323	311	41	2026-10-05 12:18:26.852538	A311	Błąd Lini Niverplst - Transport System
1324	309	39	2026-10-05 12:19:27.176651	A309	Błąd Lini Niverplst - Easy Plast
1325	310	41	2026-10-05 12:19:27.176651	A310	Alarm Lini Niverplast - Transport System
1326	311	41	2026-10-05 12:19:27.176651	A311	Błąd Lini Niverplst - Transport System
1327	309	39	2026-10-05 12:20:27.498916	A309	Błąd Lini Niverplst - Easy Plast
1328	310	41	2026-10-05 12:20:27.498916	A310	Alarm Lini Niverplast - Transport System
1329	311	41	2026-10-05 12:20:27.498916	A311	Błąd Lini Niverplst - Transport System
1330	309	39	2026-10-05 12:21:27.833176	A309	Błąd Lini Niverplst - Easy Plast
1331	310	41	2026-10-05 12:21:27.833176	A310	Alarm Lini Niverplast - Transport System
1332	311	41	2026-10-05 12:21:27.833176	A311	Błąd Lini Niverplst - Transport System
1333	309	39	2026-10-05 12:22:26.063934	A309	Błąd Lini Niverplst - Easy Plast
1334	310	41	2026-10-05 12:22:26.063934	A310	Alarm Lini Niverplast - Transport System
1335	311	41	2026-10-05 12:22:26.063934	A311	Błąd Lini Niverplst - Transport System
1336	309	39	2026-10-05 12:23:26.352042	A309	Błąd Lini Niverplst - Easy Plast
1337	310	41	2026-10-05 12:23:26.352042	A310	Alarm Lini Niverplast - Transport System
1338	311	41	2026-10-05 12:23:26.352042	A311	Błąd Lini Niverplst - Transport System
1339	309	39	2026-10-05 12:24:26.70105	A309	Błąd Lini Niverplst - Easy Plast
1340	310	41	2026-10-05 12:24:26.70105	A310	Alarm Lini Niverplast - Transport System
1341	311	41	2026-10-05 12:24:26.70105	A311	Błąd Lini Niverplst - Transport System
1342	309	39	2026-10-05 12:25:27.034341	A309	Błąd Lini Niverplst - Easy Plast
1343	310	41	2026-10-05 12:25:27.034341	A310	Alarm Lini Niverplast - Transport System
1344	311	41	2026-10-05 12:25:27.034341	A311	Błąd Lini Niverplst - Transport System
1345	309	39	2026-10-05 12:26:27.410337	A309	Błąd Lini Niverplst - Easy Plast
1346	310	41	2026-10-05 12:26:27.410337	A310	Alarm Lini Niverplast - Transport System
1347	311	41	2026-10-05 12:26:27.410337	A311	Błąd Lini Niverplst - Transport System
1348	309	39	2026-10-05 12:27:27.712325	A309	Błąd Lini Niverplst - Easy Plast
1349	310	41	2026-10-05 12:27:27.712325	A310	Alarm Lini Niverplast - Transport System
1350	311	41	2026-10-05 12:27:27.712325	A311	Błąd Lini Niverplst - Transport System
1351	309	39	2026-10-05 12:28:28.054393	A309	Błąd Lini Niverplst - Easy Plast
1352	310	41	2026-10-05 12:28:28.054393	A310	Alarm Lini Niverplast - Transport System
1353	311	41	2026-10-05 12:28:28.054393	A311	Błąd Lini Niverplst - Transport System
1354	309	39	2026-10-05 12:29:28.3903	A309	Błąd Lini Niverplst - Easy Plast
1355	310	41	2026-10-05 12:29:28.3903	A310	Alarm Lini Niverplast - Transport System
1356	311	41	2026-10-05 12:29:28.3903	A311	Błąd Lini Niverplst - Transport System
1357	309	39	2026-10-05 12:30:26.569751	A309	Błąd Lini Niverplst - Easy Plast
1358	310	41	2026-10-05 12:30:26.569751	A310	Alarm Lini Niverplast - Transport System
1359	311	41	2026-10-05 12:30:26.569751	A311	Błąd Lini Niverplst - Transport System
1360	309	39	2026-10-05 12:31:27.000542	A309	Błąd Lini Niverplst - Easy Plast
1361	310	41	2026-10-05 12:31:27.000542	A310	Alarm Lini Niverplast - Transport System
1362	311	41	2026-10-05 12:31:27.000542	A311	Błąd Lini Niverplst - Transport System
1363	309	39	2026-10-05 12:32:27.227013	A309	Błąd Lini Niverplst - Easy Plast
1364	310	41	2026-10-05 12:32:27.227013	A310	Alarm Lini Niverplast - Transport System
1365	311	41	2026-10-05 12:32:27.227013	A311	Błąd Lini Niverplst - Transport System
1366	309	39	2026-10-05 12:33:27.728653	A309	Błąd Lini Niverplst - Easy Plast
1367	310	41	2026-10-05 12:33:27.728653	A310	Alarm Lini Niverplast - Transport System
1368	311	41	2026-10-05 12:33:27.728653	A311	Błąd Lini Niverplst - Transport System
1369	309	39	2026-10-05 12:34:27.930365	A309	Błąd Lini Niverplst - Easy Plast
1370	310	41	2026-10-05 12:34:27.930365	A310	Alarm Lini Niverplast - Transport System
1371	311	41	2026-10-05 12:34:27.930365	A311	Błąd Lini Niverplst - Transport System
1372	309	39	2026-10-05 12:35:28.280201	A309	Błąd Lini Niverplst - Easy Plast
1373	310	41	2026-10-05 12:35:28.280201	A310	Alarm Lini Niverplast - Transport System
1374	311	41	2026-10-05 12:35:28.280201	A311	Błąd Lini Niverplst - Transport System
1375	309	39	2026-10-05 12:36:28.628129	A309	Błąd Lini Niverplst - Easy Plast
1376	310	41	2026-10-05 12:36:28.628129	A310	Alarm Lini Niverplast - Transport System
1377	311	41	2026-10-05 12:36:28.628129	A311	Błąd Lini Niverplst - Transport System
1378	309	39	2026-10-05 12:37:28.941411	A309	Błąd Lini Niverplst - Easy Plast
1379	310	41	2026-10-05 12:37:28.941411	A310	Alarm Lini Niverplast - Transport System
1380	311	41	2026-10-05 12:37:28.941411	A311	Błąd Lini Niverplst - Transport System
1381	309	39	2026-10-05 12:38:27.139181	A309	Błąd Lini Niverplst - Easy Plast
1382	310	41	2026-10-05 12:38:27.139181	A310	Alarm Lini Niverplast - Transport System
1383	311	41	2026-10-05 12:38:27.139181	A311	Błąd Lini Niverplst - Transport System
1384	309	39	2026-10-05 12:39:27.477933	A309	Błąd Lini Niverplst - Easy Plast
1385	310	41	2026-10-05 12:39:27.477933	A310	Alarm Lini Niverplast - Transport System
1386	311	41	2026-10-05 12:39:27.477933	A311	Błąd Lini Niverplst - Transport System
1387	309	39	2026-10-05 12:40:27.734386	A309	Błąd Lini Niverplst - Easy Plast
1388	310	41	2026-10-05 12:40:27.734386	A310	Alarm Lini Niverplast - Transport System
1389	311	41	2026-10-05 12:40:27.734386	A311	Błąd Lini Niverplst - Transport System
1390	309	39	2026-10-05 12:41:28.170034	A309	Błąd Lini Niverplst - Easy Plast
1391	310	41	2026-10-05 12:41:28.170034	A310	Alarm Lini Niverplast - Transport System
1392	311	41	2026-10-05 12:41:28.170034	A311	Błąd Lini Niverplst - Transport System
1393	309	39	2026-10-05 12:42:28.500842	A309	Błąd Lini Niverplst - Easy Plast
1394	310	41	2026-10-05 12:42:28.500842	A310	Alarm Lini Niverplast - Transport System
1395	311	41	2026-10-05 12:42:28.500842	A311	Błąd Lini Niverplst - Transport System
1396	309	39	2026-10-05 12:43:28.8553	A309	Błąd Lini Niverplst - Easy Plast
1397	310	41	2026-10-05 12:43:28.8553	A310	Alarm Lini Niverplast - Transport System
1398	311	41	2026-10-05 12:43:28.8553	A311	Błąd Lini Niverplst - Transport System
1399	309	39	2026-10-05 12:44:29.180715	A309	Błąd Lini Niverplst - Easy Plast
1400	310	41	2026-10-05 12:44:29.180715	A310	Alarm Lini Niverplast - Transport System
1401	311	41	2026-10-05 12:44:29.180715	A311	Błąd Lini Niverplst - Transport System
1402	309	39	2026-10-05 12:45:27.384887	A309	Błąd Lini Niverplst - Easy Plast
1403	310	41	2026-10-05 12:45:27.384887	A310	Alarm Lini Niverplast - Transport System
1404	311	41	2026-10-05 12:45:27.384887	A311	Błąd Lini Niverplst - Transport System
1405	309	39	2026-10-05 12:46:27.667882	A309	Błąd Lini Niverplst - Easy Plast
1406	310	41	2026-10-05 12:46:27.667882	A310	Alarm Lini Niverplast - Transport System
1407	311	41	2026-10-05 12:46:27.667882	A311	Błąd Lini Niverplst - Transport System
1408	307	42	2026-10-05 12:47:28.032337	A376	Błąd Lini Niverplast - Crappe Tiper
1409	309	39	2026-10-05 12:47:28.032337	A309	Błąd Lini Niverplst - Easy Plast
1410	310	41	2026-10-05 12:47:28.032337	A310	Alarm Lini Niverplast - Transport System
1411	311	41	2026-10-05 12:47:28.032337	A311	Błąd Lini Niverplst - Transport System
1412	309	39	2026-10-05 12:48:28.379056	A309	Błąd Lini Niverplst - Easy Plast
1413	310	41	2026-10-05 12:48:28.379056	A310	Alarm Lini Niverplast - Transport System
1414	311	41	2026-10-05 12:48:28.379056	A311	Błąd Lini Niverplst - Transport System
1415	309	39	2026-10-05 12:49:28.738267	A309	Błąd Lini Niverplst - Easy Plast
1416	310	41	2026-10-05 12:49:28.738267	A310	Alarm Lini Niverplast - Transport System
1417	311	41	2026-10-05 12:49:28.738267	A311	Błąd Lini Niverplst - Transport System
1418	309	39	2026-10-05 12:50:29.076593	A309	Błąd Lini Niverplst - Easy Plast
1419	310	41	2026-10-05 12:50:29.076593	A310	Alarm Lini Niverplast - Transport System
1420	311	41	2026-10-05 12:50:29.076593	A311	Błąd Lini Niverplst - Transport System
1421	309	39	2026-10-05 12:51:29.401467	A309	Błąd Lini Niverplst - Easy Plast
1422	310	41	2026-10-05 12:51:29.401467	A310	Alarm Lini Niverplast - Transport System
1423	311	41	2026-10-05 12:51:29.401467	A311	Błąd Lini Niverplst - Transport System
1424	309	39	2026-10-05 12:52:29.739862	A309	Błąd Lini Niverplst - Easy Plast
1425	310	41	2026-10-05 12:52:29.739862	A310	Alarm Lini Niverplast - Transport System
1426	311	41	2026-10-05 12:52:29.739862	A311	Błąd Lini Niverplst - Transport System
1427	309	39	2026-10-05 12:53:27.900438	A309	Błąd Lini Niverplst - Easy Plast
1428	310	41	2026-10-05 12:53:27.900438	A310	Alarm Lini Niverplast - Transport System
1429	311	41	2026-10-05 12:53:27.900438	A311	Błąd Lini Niverplst - Transport System
1430	309	39	2026-10-05 12:54:29.35447	A309	Błąd Lini Niverplst - Easy Plast
1431	310	41	2026-10-05 12:54:29.35447	A310	Alarm Lini Niverplast - Transport System
1432	311	41	2026-10-05 12:54:29.35447	A311	Błąd Lini Niverplst - Transport System
1433	309	39	2026-10-05 12:55:28.611097	A309	Błąd Lini Niverplst - Easy Plast
1434	310	41	2026-10-05 12:55:28.611097	A310	Alarm Lini Niverplast - Transport System
1435	311	41	2026-10-05 12:55:28.611097	A311	Błąd Lini Niverplst - Transport System
1436	309	39	2026-10-05 12:56:28.996781	A309	Błąd Lini Niverplst - Easy Plast
1437	310	41	2026-10-05 12:56:28.996781	A310	Alarm Lini Niverplast - Transport System
1438	311	41	2026-10-05 12:56:28.996781	A311	Błąd Lini Niverplst - Transport System
1439	309	39	2026-10-05 12:57:29.292819	A309	Błąd Lini Niverplst - Easy Plast
1440	310	41	2026-10-05 12:57:29.292819	A310	Alarm Lini Niverplast - Transport System
1441	311	41	2026-10-05 12:57:29.292819	A311	Błąd Lini Niverplst - Transport System
1442	309	39	2026-10-05 12:58:29.624526	A309	Błąd Lini Niverplst - Easy Plast
1443	310	41	2026-10-05 12:58:29.624526	A310	Alarm Lini Niverplast - Transport System
1444	311	41	2026-10-05 12:58:29.624526	A311	Błąd Lini Niverplst - Transport System
1445	309	39	2026-10-05 12:59:29.996904	A309	Błąd Lini Niverplst - Easy Plast
1446	310	41	2026-10-05 12:59:29.996904	A310	Alarm Lini Niverplast - Transport System
1447	311	41	2026-10-05 12:59:29.996904	A311	Błąd Lini Niverplst - Transport System
1448	309	39	2026-10-05 13:00:30.293512	A309	Błąd Lini Niverplst - Easy Plast
1449	310	41	2026-10-05 13:00:30.293512	A310	Alarm Lini Niverplast - Transport System
1450	311	41	2026-10-05 13:00:30.293512	A311	Błąd Lini Niverplst - Transport System
1451	309	39	2026-10-05 13:01:28.475552	A309	Błąd Lini Niverplst - Easy Plast
1452	310	41	2026-10-05 13:01:28.475552	A310	Alarm Lini Niverplast - Transport System
1453	311	41	2026-10-05 13:01:28.475552	A311	Błąd Lini Niverplst - Transport System
1454	309	39	2026-10-05 13:02:28.843146	A309	Błąd Lini Niverplst - Easy Plast
1455	310	41	2026-10-05 13:02:28.843146	A310	Alarm Lini Niverplast - Transport System
4215	182	40	2026-10-06 04:06:22.586551	A182	\N
1456	311	41	2026-10-05 13:02:28.843146	A311	Błąd Lini Niverplst - Transport System
1457	309	39	2026-10-05 13:03:29.115889	A309	Błąd Lini Niverplst - Easy Plast
1458	310	41	2026-10-05 13:03:29.115889	A310	Alarm Lini Niverplast - Transport System
1459	311	41	2026-10-05 13:03:29.115889	A311	Błąd Lini Niverplst - Transport System
1460	309	39	2026-10-05 13:04:29.542277	A309	Błąd Lini Niverplst - Easy Plast
1461	310	41	2026-10-05 13:04:29.542277	A310	Alarm Lini Niverplast - Transport System
1462	311	41	2026-10-05 13:04:29.542277	A311	Błąd Lini Niverplst - Transport System
1463	309	39	2026-10-05 13:05:29.887643	A309	Błąd Lini Niverplst - Easy Plast
1464	310	41	2026-10-05 13:05:29.887643	A310	Alarm Lini Niverplast - Transport System
1465	311	41	2026-10-05 13:05:29.887643	A311	Błąd Lini Niverplst - Transport System
1466	309	39	2026-10-05 13:06:30.236521	A309	Błąd Lini Niverplst - Easy Plast
1467	310	41	2026-10-05 13:06:30.236521	A310	Alarm Lini Niverplast - Transport System
1468	311	41	2026-10-05 13:06:30.236521	A311	Błąd Lini Niverplst - Transport System
1469	309	39	2026-10-05 13:07:30.550739	A309	Błąd Lini Niverplst - Easy Plast
1470	310	41	2026-10-05 13:07:30.550739	A310	Alarm Lini Niverplast - Transport System
1471	311	41	2026-10-05 13:07:30.550739	A311	Błąd Lini Niverplst - Transport System
1472	309	39	2026-10-05 13:08:28.754655	A309	Błąd Lini Niverplst - Easy Plast
1473	310	41	2026-10-05 13:08:28.754655	A310	Alarm Lini Niverplast - Transport System
1474	311	41	2026-10-05 13:08:28.754655	A311	Błąd Lini Niverplst - Transport System
1475	309	39	2026-10-05 13:09:29.073204	A309	Błąd Lini Niverplst - Easy Plast
1476	310	41	2026-10-05 13:09:29.073204	A310	Alarm Lini Niverplast - Transport System
1477	311	41	2026-10-05 13:09:29.073204	A311	Błąd Lini Niverplst - Transport System
1478	309	39	2026-10-05 13:10:29.419968	A309	Błąd Lini Niverplst - Easy Plast
1479	310	41	2026-10-05 13:10:29.419968	A310	Alarm Lini Niverplast - Transport System
1480	311	41	2026-10-05 13:10:29.419968	A311	Błąd Lini Niverplst - Transport System
1481	309	39	2026-10-05 13:11:29.754635	A309	Błąd Lini Niverplst - Easy Plast
1482	310	41	2026-10-05 13:11:29.754635	A310	Alarm Lini Niverplast - Transport System
1483	311	41	2026-10-05 13:11:29.754635	A311	Błąd Lini Niverplst - Transport System
1484	309	39	2026-10-05 13:12:30.119865	A309	Błąd Lini Niverplst - Easy Plast
1485	310	41	2026-10-05 13:12:30.119865	A310	Alarm Lini Niverplast - Transport System
1486	311	41	2026-10-05 13:12:30.119865	A311	Błąd Lini Niverplst - Transport System
1487	309	39	2026-10-05 13:13:30.470117	A309	Błąd Lini Niverplst - Easy Plast
1488	310	41	2026-10-05 13:13:30.470117	A310	Alarm Lini Niverplast - Transport System
1489	311	41	2026-10-05 13:13:30.470117	A311	Błąd Lini Niverplst - Transport System
1490	309	39	2026-10-05 13:14:30.805681	A309	Błąd Lini Niverplst - Easy Plast
1491	310	41	2026-10-05 13:14:30.805681	A310	Alarm Lini Niverplast - Transport System
1492	311	41	2026-10-05 13:14:30.805681	A311	Błąd Lini Niverplst - Transport System
1493	309	39	2026-10-05 13:15:31.123966	A309	Błąd Lini Niverplst - Easy Plast
1494	310	41	2026-10-05 13:15:31.123966	A310	Alarm Lini Niverplast - Transport System
1495	311	41	2026-10-05 13:15:31.123966	A311	Błąd Lini Niverplst - Transport System
1496	309	39	2026-10-05 13:16:29.302341	A309	Błąd Lini Niverplst - Easy Plast
1497	310	41	2026-10-05 13:16:29.302341	A310	Alarm Lini Niverplast - Transport System
1498	311	41	2026-10-05 13:16:29.302341	A311	Błąd Lini Niverplst - Transport System
1499	309	39	2026-10-05 13:17:29.737851	A309	Błąd Lini Niverplst - Easy Plast
1500	310	41	2026-10-05 13:17:29.737851	A310	Alarm Lini Niverplast - Transport System
1501	311	41	2026-10-05 13:17:29.737851	A311	Błąd Lini Niverplst - Transport System
1502	309	39	2026-10-05 13:18:29.973535	A309	Błąd Lini Niverplst - Easy Plast
1503	310	41	2026-10-05 13:18:29.973535	A310	Alarm Lini Niverplast - Transport System
1504	311	41	2026-10-05 13:18:29.973535	A311	Błąd Lini Niverplst - Transport System
1505	309	39	2026-10-05 13:19:30.427332	A309	Błąd Lini Niverplst - Easy Plast
1506	310	41	2026-10-05 13:19:30.427332	A310	Alarm Lini Niverplast - Transport System
1507	311	41	2026-10-05 13:19:30.427332	A311	Błąd Lini Niverplst - Transport System
1508	309	39	2026-10-05 13:20:30.708695	A309	Błąd Lini Niverplst - Easy Plast
1509	310	41	2026-10-05 13:20:30.708695	A310	Alarm Lini Niverplast - Transport System
1510	311	41	2026-10-05 13:20:30.708695	A311	Błąd Lini Niverplst - Transport System
1511	309	39	2026-10-05 13:21:31.036046	A309	Błąd Lini Niverplst - Easy Plast
1512	310	41	2026-10-05 13:21:31.036046	A310	Alarm Lini Niverplast - Transport System
1513	311	41	2026-10-05 13:21:31.036046	A311	Błąd Lini Niverplst - Transport System
1514	309	39	2026-10-05 13:22:31.399675	A309	Błąd Lini Niverplst - Easy Plast
1515	310	41	2026-10-05 13:22:31.399675	A310	Alarm Lini Niverplast - Transport System
1516	311	41	2026-10-05 13:22:31.399675	A311	Błąd Lini Niverplst - Transport System
1517	309	39	2026-10-05 13:23:29.55676	A309	Błąd Lini Niverplst - Easy Plast
1518	310	41	2026-10-05 13:23:29.55676	A310	Alarm Lini Niverplast - Transport System
1519	311	41	2026-10-05 13:23:29.55676	A311	Błąd Lini Niverplst - Transport System
1520	309	39	2026-10-05 13:24:29.88217	A309	Błąd Lini Niverplst - Easy Plast
1521	310	41	2026-10-05 13:24:29.88217	A310	Alarm Lini Niverplast - Transport System
1522	311	41	2026-10-05 13:24:29.88217	A311	Błąd Lini Niverplst - Transport System
1523	309	39	2026-10-05 13:25:30.241815	A309	Błąd Lini Niverplst - Easy Plast
1524	310	41	2026-10-05 13:25:30.241815	A310	Alarm Lini Niverplast - Transport System
1525	311	41	2026-10-05 13:25:30.241815	A311	Błąd Lini Niverplst - Transport System
1526	309	39	2026-10-05 13:26:30.533059	A309	Błąd Lini Niverplst - Easy Plast
1527	310	41	2026-10-05 13:26:30.533059	A310	Alarm Lini Niverplast - Transport System
1528	311	41	2026-10-05 13:26:30.533059	A311	Błąd Lini Niverplst - Transport System
1529	309	39	2026-10-05 13:27:30.958377	A309	Błąd Lini Niverplst - Easy Plast
1530	310	41	2026-10-05 13:27:30.958377	A310	Alarm Lini Niverplast - Transport System
1531	311	41	2026-10-05 13:27:30.958377	A311	Błąd Lini Niverplst - Transport System
1532	309	39	2026-10-05 13:28:31.329106	A309	Błąd Lini Niverplst - Easy Plast
1533	310	41	2026-10-05 13:28:31.329106	A310	Alarm Lini Niverplast - Transport System
1534	311	41	2026-10-05 13:28:31.329106	A311	Błąd Lini Niverplst - Transport System
1535	309	39	2026-10-05 13:29:31.625154	A309	Błąd Lini Niverplst - Easy Plast
1536	310	41	2026-10-05 13:29:31.625154	A310	Alarm Lini Niverplast - Transport System
1537	311	41	2026-10-05 13:29:31.625154	A311	Błąd Lini Niverplst - Transport System
1538	309	39	2026-10-05 13:30:31.958048	A309	Błąd Lini Niverplst - Easy Plast
4297	319	40	2026-10-06 04:31:23.992525	A319	\N
1539	310	41	2026-10-05 13:30:31.958048	A310	Alarm Lini Niverplast - Transport System
1540	311	41	2026-10-05 13:30:31.958048	A311	Błąd Lini Niverplst - Transport System
1541	309	39	2026-10-05 13:31:30.160167	A309	Błąd Lini Niverplst - Easy Plast
1542	310	41	2026-10-05 13:31:30.160167	A310	Alarm Lini Niverplast - Transport System
1543	311	41	2026-10-05 13:31:30.160167	A311	Błąd Lini Niverplst - Transport System
1544	309	39	2026-10-05 13:32:30.450071	A309	Błąd Lini Niverplst - Easy Plast
1545	310	41	2026-10-05 13:32:30.450071	A310	Alarm Lini Niverplast - Transport System
1546	311	41	2026-10-05 13:32:30.450071	A311	Błąd Lini Niverplst - Transport System
1547	309	39	2026-10-05 13:33:30.800893	A309	Błąd Lini Niverplst - Easy Plast
1548	310	41	2026-10-05 13:33:30.800893	A310	Alarm Lini Niverplast - Transport System
1549	311	41	2026-10-05 13:33:30.800893	A311	Błąd Lini Niverplst - Transport System
1550	309	39	2026-10-05 13:34:31.163129	A309	Błąd Lini Niverplst - Easy Plast
1551	310	41	2026-10-05 13:34:31.163129	A310	Alarm Lini Niverplast - Transport System
1552	311	41	2026-10-05 13:34:31.163129	A311	Błąd Lini Niverplst - Transport System
1553	309	39	2026-10-05 13:35:31.551571	A309	Błąd Lini Niverplst - Easy Plast
1554	310	41	2026-10-05 13:35:31.551571	A310	Alarm Lini Niverplast - Transport System
1555	311	41	2026-10-05 13:35:31.551571	A311	Błąd Lini Niverplst - Transport System
1556	309	39	2026-10-05 13:36:31.879012	A309	Błąd Lini Niverplst - Easy Plast
1557	310	41	2026-10-05 13:36:31.879012	A310	Alarm Lini Niverplast - Transport System
1558	311	41	2026-10-05 13:36:31.879012	A311	Błąd Lini Niverplst - Transport System
1559	309	39	2026-10-05 13:37:32.201865	A309	Błąd Lini Niverplst - Easy Plast
1560	310	41	2026-10-05 13:37:32.201865	A310	Alarm Lini Niverplast - Transport System
1561	311	41	2026-10-05 13:37:32.201865	A311	Błąd Lini Niverplst - Transport System
1562	309	39	2026-10-05 13:38:32.532917	A309	Błąd Lini Niverplst - Easy Plast
1563	310	41	2026-10-05 13:38:32.532917	A310	Alarm Lini Niverplast - Transport System
1564	311	41	2026-10-05 13:38:32.532917	A311	Błąd Lini Niverplst - Transport System
1565	309	39	2026-10-05 13:39:30.692308	A309	Błąd Lini Niverplst - Easy Plast
1566	310	41	2026-10-05 13:39:30.692308	A310	Alarm Lini Niverplast - Transport System
1567	311	41	2026-10-05 13:39:30.692308	A311	Błąd Lini Niverplst - Transport System
1568	309	39	2026-10-05 13:40:31.138247	A309	Błąd Lini Niverplst - Easy Plast
1569	310	41	2026-10-05 13:40:31.138247	A310	Alarm Lini Niverplast - Transport System
1570	311	41	2026-10-05 13:40:31.138247	A311	Błąd Lini Niverplst - Transport System
1571	309	39	2026-10-05 13:41:31.379484	A309	Błąd Lini Niverplst - Easy Plast
1572	310	41	2026-10-05 13:41:31.379484	A310	Alarm Lini Niverplast - Transport System
1573	311	41	2026-10-05 13:41:31.379484	A311	Błąd Lini Niverplst - Transport System
1574	309	39	2026-10-05 13:42:31.762664	A309	Błąd Lini Niverplst - Easy Plast
1575	310	41	2026-10-05 13:42:31.762664	A310	Alarm Lini Niverplast - Transport System
1576	311	41	2026-10-05 13:42:31.762664	A311	Błąd Lini Niverplst - Transport System
1577	309	39	2026-10-05 13:43:32.147337	A309	Błąd Lini Niverplst - Easy Plast
1578	310	41	2026-10-05 13:43:32.147337	A310	Alarm Lini Niverplast - Transport System
1579	311	41	2026-10-05 13:43:32.147337	A311	Błąd Lini Niverplst - Transport System
1580	309	39	2026-10-05 13:44:32.497458	A309	Błąd Lini Niverplst - Easy Plast
1581	310	41	2026-10-05 13:44:32.497458	A310	Alarm Lini Niverplast - Transport System
1582	311	41	2026-10-05 13:44:32.497458	A311	Błąd Lini Niverplst - Transport System
1583	309	39	2026-10-05 13:45:31.545752	A309	Błąd Lini Niverplst - Easy Plast
1584	310	41	2026-10-05 13:45:31.545752	A310	Alarm Lini Niverplast - Transport System
1585	311	41	2026-10-05 13:45:31.545752	A311	Błąd Lini Niverplst - Transport System
1586	309	39	2026-10-05 13:46:30.632009	A309	Błąd Lini Niverplst - Easy Plast
1587	310	41	2026-10-05 13:46:30.632009	A310	Alarm Lini Niverplast - Transport System
1588	311	41	2026-10-05 13:46:30.632009	A311	Błąd Lini Niverplst - Transport System
1589	309	39	2026-10-05 13:47:31.367486	A309	Błąd Lini Niverplst - Easy Plast
1590	310	41	2026-10-05 13:47:31.367486	A310	Alarm Lini Niverplast - Transport System
1591	311	41	2026-10-05 13:47:31.367486	A311	Błąd Lini Niverplst - Transport System
1592	309	39	2026-10-05 13:48:31.676626	A309	Błąd Lini Niverplst - Easy Plast
1593	310	41	2026-10-05 13:48:31.676626	A310	Alarm Lini Niverplast - Transport System
1594	311	41	2026-10-05 13:48:31.676626	A311	Błąd Lini Niverplst - Transport System
1595	309	39	2026-10-05 13:49:32.06474	A309	Błąd Lini Niverplst - Easy Plast
1596	310	41	2026-10-05 13:49:32.06474	A310	Alarm Lini Niverplast - Transport System
1597	311	41	2026-10-05 13:49:32.06474	A311	Błąd Lini Niverplst - Transport System
1598	309	39	2026-10-05 13:50:32.448274	A309	Błąd Lini Niverplst - Easy Plast
1599	310	41	2026-10-05 13:50:32.448274	A310	Alarm Lini Niverplast - Transport System
1600	311	41	2026-10-05 13:50:32.448274	A311	Błąd Lini Niverplst - Transport System
1601	309	39	2026-10-05 13:51:32.8501	A309	Błąd Lini Niverplst - Easy Plast
1602	310	41	2026-10-05 13:51:32.8501	A310	Alarm Lini Niverplast - Transport System
1603	311	41	2026-10-05 13:51:32.8501	A311	Błąd Lini Niverplst - Transport System
1604	309	39	2026-10-05 13:52:33.144479	A309	Błąd Lini Niverplst - Easy Plast
1605	310	41	2026-10-05 13:52:33.144479	A310	Alarm Lini Niverplast - Transport System
1606	311	41	2026-10-05 13:52:33.144479	A311	Błąd Lini Niverplst - Transport System
1607	309	39	2026-10-05 13:53:31.297449	A309	Błąd Lini Niverplst - Easy Plast
1608	310	41	2026-10-05 13:53:31.297449	A310	Alarm Lini Niverplast - Transport System
1609	311	41	2026-10-05 13:53:31.297449	A311	Błąd Lini Niverplst - Transport System
1610	309	39	2026-10-05 13:54:31.678197	A309	Błąd Lini Niverplst - Easy Plast
1611	310	41	2026-10-05 13:54:31.678197	A310	Alarm Lini Niverplast - Transport System
1612	311	41	2026-10-05 13:54:31.678197	A311	Błąd Lini Niverplst - Transport System
1613	309	39	2026-10-05 13:55:31.989648	A309	Błąd Lini Niverplst - Easy Plast
1614	310	41	2026-10-05 13:55:31.989648	A310	Alarm Lini Niverplast - Transport System
1615	311	41	2026-10-05 13:55:31.989648	A311	Błąd Lini Niverplst - Transport System
1616	309	39	2026-10-05 13:56:32.33071	A309	Błąd Lini Niverplst - Easy Plast
1617	310	41	2026-10-05 13:56:32.33071	A310	Alarm Lini Niverplast - Transport System
1618	311	41	2026-10-05 13:56:32.33071	A311	Błąd Lini Niverplst - Transport System
1619	309	39	2026-10-05 13:57:32.733008	A309	Błąd Lini Niverplst - Easy Plast
1620	310	41	2026-10-05 13:57:32.733008	A310	Alarm Lini Niverplast - Transport System
1621	311	41	2026-10-05 13:57:32.733008	A311	Błąd Lini Niverplst - Transport System
4301	319	40	2026-10-06 04:32:24.032289	A319	\N
1622	309	39	2026-10-05 13:58:33.144788	A309	Błąd Lini Niverplst - Easy Plast
1623	310	41	2026-10-05 13:58:33.144788	A310	Alarm Lini Niverplast - Transport System
1624	311	41	2026-10-05 13:58:33.144788	A311	Błąd Lini Niverplst - Transport System
1625	309	39	2026-10-05 13:59:33.471379	A309	Błąd Lini Niverplst - Easy Plast
1626	310	41	2026-10-05 13:59:33.471379	A310	Alarm Lini Niverplast - Transport System
1627	311	41	2026-10-05 13:59:33.471379	A311	Błąd Lini Niverplst - Transport System
1628	309	39	2026-10-05 14:00:33.806325	A309	Błąd Lini Niverplst - Easy Plast
1629	310	41	2026-10-05 14:00:33.806325	A310	Alarm Lini Niverplast - Transport System
1630	311	41	2026-10-05 14:00:33.806325	A311	Błąd Lini Niverplst - Transport System
1631	309	39	2026-10-05 14:01:32.029092	A309	Błąd Lini Niverplst - Easy Plast
1632	310	41	2026-10-05 14:01:32.029092	A310	Alarm Lini Niverplast - Transport System
1633	311	41	2026-10-05 14:01:32.029092	A311	Błąd Lini Niverplst - Transport System
1634	309	39	2026-10-05 14:02:32.266817	A309	Błąd Lini Niverplst - Easy Plast
1635	310	41	2026-10-05 14:02:32.266817	A310	Alarm Lini Niverplast - Transport System
1636	311	41	2026-10-05 14:02:32.266817	A311	Błąd Lini Niverplst - Transport System
1637	309	39	2026-10-05 14:03:32.749392	A309	Błąd Lini Niverplst - Easy Plast
1638	310	41	2026-10-05 14:03:32.749392	A310	Alarm Lini Niverplast - Transport System
1639	311	41	2026-10-05 14:03:32.749392	A311	Błąd Lini Niverplst - Transport System
1640	309	39	2026-10-05 14:04:33.006678	A309	Błąd Lini Niverplst - Easy Plast
1641	310	41	2026-10-05 14:04:33.006678	A310	Alarm Lini Niverplast - Transport System
1642	311	41	2026-10-05 14:04:33.006678	A311	Błąd Lini Niverplst - Transport System
1643	309	39	2026-10-05 14:05:33.426532	A309	Błąd Lini Niverplst - Easy Plast
1644	310	41	2026-10-05 14:05:33.426532	A310	Alarm Lini Niverplast - Transport System
1645	311	41	2026-10-05 14:05:33.426532	A311	Błąd Lini Niverplst - Transport System
1646	309	39	2026-10-05 14:06:33.772619	A309	Błąd Lini Niverplst - Easy Plast
1647	310	41	2026-10-05 14:06:33.772619	A310	Alarm Lini Niverplast - Transport System
1648	311	41	2026-10-05 14:06:33.772619	A311	Błąd Lini Niverplst - Transport System
1649	309	39	2026-10-05 14:07:34.112127	A309	Błąd Lini Niverplst - Easy Plast
1650	310	41	2026-10-05 14:07:34.112127	A310	Alarm Lini Niverplast - Transport System
1651	311	41	2026-10-05 14:07:34.112127	A311	Błąd Lini Niverplst - Transport System
1652	309	39	2026-10-05 14:08:32.239906	A309	Błąd Lini Niverplst - Easy Plast
1653	310	41	2026-10-05 14:08:32.239906	A310	Alarm Lini Niverplast - Transport System
1654	311	41	2026-10-05 14:08:32.239906	A311	Błąd Lini Niverplst - Transport System
1655	309	39	2026-10-05 14:09:32.585206	A309	Błąd Lini Niverplst - Easy Plast
1656	310	41	2026-10-05 14:09:32.585206	A310	Alarm Lini Niverplast - Transport System
1657	311	41	2026-10-05 14:09:32.585206	A311	Błąd Lini Niverplst - Transport System
1658	309	39	2026-10-05 14:10:32.908313	A309	Błąd Lini Niverplst - Easy Plast
1659	310	41	2026-10-05 14:10:32.908313	A310	Alarm Lini Niverplast - Transport System
1660	311	41	2026-10-05 14:10:32.908313	A311	Błąd Lini Niverplst - Transport System
1661	309	39	2026-10-05 14:11:33.34962	A309	Błąd Lini Niverplst - Easy Plast
1662	310	41	2026-10-05 14:11:33.34962	A310	Alarm Lini Niverplast - Transport System
1663	311	41	2026-10-05 14:11:33.34962	A311	Błąd Lini Niverplst - Transport System
1664	309	39	2026-10-05 14:12:33.684873	A309	Błąd Lini Niverplst - Easy Plast
1665	310	41	2026-10-05 14:12:33.684873	A310	Alarm Lini Niverplast - Transport System
1666	311	41	2026-10-05 14:12:33.684873	A311	Błąd Lini Niverplst - Transport System
1667	309	39	2026-10-05 14:13:34.053841	A309	Błąd Lini Niverplst - Easy Plast
1668	310	41	2026-10-05 14:13:34.053841	A310	Alarm Lini Niverplast - Transport System
1669	311	41	2026-10-05 14:13:34.053841	A311	Błąd Lini Niverplst - Transport System
1670	309	39	2026-10-05 14:14:34.407175	A309	Błąd Lini Niverplst - Easy Plast
1671	310	41	2026-10-05 14:14:34.407175	A310	Alarm Lini Niverplast - Transport System
1672	311	41	2026-10-05 14:14:34.407175	A311	Błąd Lini Niverplst - Transport System
1673	309	39	2026-10-05 14:15:32.589676	A309	Błąd Lini Niverplst - Easy Plast
1674	310	41	2026-10-05 14:15:32.589676	A310	Alarm Lini Niverplast - Transport System
1675	311	41	2026-10-05 14:15:32.589676	A311	Błąd Lini Niverplst - Transport System
1676	309	39	2026-10-05 14:16:32.858971	A309	Błąd Lini Niverplst - Easy Plast
1677	310	41	2026-10-05 14:16:32.858971	A310	Alarm Lini Niverplast - Transport System
1678	311	41	2026-10-05 14:16:32.858971	A311	Błąd Lini Niverplst - Transport System
1679	309	39	2026-10-05 14:17:33.226983	A309	Błąd Lini Niverplst - Easy Plast
1680	310	41	2026-10-05 14:17:33.226983	A310	Alarm Lini Niverplast - Transport System
1681	311	41	2026-10-05 14:17:33.226983	A311	Błąd Lini Niverplst - Transport System
1682	309	39	2026-10-05 14:18:33.592536	A309	Błąd Lini Niverplst - Easy Plast
1683	310	41	2026-10-05 14:18:33.592536	A310	Alarm Lini Niverplast - Transport System
1684	311	41	2026-10-05 14:18:33.592536	A311	Błąd Lini Niverplst - Transport System
1685	309	39	2026-10-05 14:19:33.971364	A309	Błąd Lini Niverplst - Easy Plast
1686	310	41	2026-10-05 14:19:33.971364	A310	Alarm Lini Niverplast - Transport System
1687	311	41	2026-10-05 14:19:33.971364	A311	Błąd Lini Niverplst - Transport System
1688	309	39	2026-10-05 14:20:34.335793	A309	Błąd Lini Niverplst - Easy Plast
1689	310	41	2026-10-05 14:20:34.335793	A310	Alarm Lini Niverplast - Transport System
1690	311	41	2026-10-05 14:20:34.335793	A311	Błąd Lini Niverplst - Transport System
1691	309	39	2026-10-05 14:21:34.703976	A309	Błąd Lini Niverplst - Easy Plast
1692	310	41	2026-10-05 14:21:34.703976	A310	Alarm Lini Niverplast - Transport System
1693	311	41	2026-10-05 14:21:34.703976	A311	Błąd Lini Niverplst - Transport System
1694	309	39	2026-10-05 14:22:35.029647	A309	Błąd Lini Niverplst - Easy Plast
1695	310	41	2026-10-05 14:22:35.029647	A310	Alarm Lini Niverplast - Transport System
1696	311	41	2026-10-05 14:22:35.029647	A311	Błąd Lini Niverplst - Transport System
1697	309	39	2026-10-05 14:23:33.148317	A309	Błąd Lini Niverplst - Easy Plast
1698	310	41	2026-10-05 14:23:33.148317	A310	Alarm Lini Niverplast - Transport System
1699	311	41	2026-10-05 14:23:33.148317	A311	Błąd Lini Niverplst - Transport System
1700	309	39	2026-10-05 14:24:33.580925	A309	Błąd Lini Niverplst - Easy Plast
1701	310	41	2026-10-05 14:24:33.580925	A310	Alarm Lini Niverplast - Transport System
1702	311	41	2026-10-05 14:24:33.580925	A311	Błąd Lini Niverplst - Transport System
1703	309	39	2026-10-05 14:25:33.822346	A309	Błąd Lini Niverplst - Easy Plast
1704	310	41	2026-10-05 14:25:33.822346	A310	Alarm Lini Niverplast - Transport System
4470	190	40	2026-10-06 05:28:27.251924	A190	\N
1705	311	41	2026-10-05 14:25:33.822346	A311	Błąd Lini Niverplst - Transport System
1706	309	39	2026-10-05 14:26:34.324222	A309	Błąd Lini Niverplst - Easy Plast
1707	310	41	2026-10-05 14:26:34.324222	A310	Alarm Lini Niverplast - Transport System
1708	311	41	2026-10-05 14:26:34.324222	A311	Błąd Lini Niverplst - Transport System
1709	309	39	2026-10-05 14:27:34.608639	A309	Błąd Lini Niverplst - Easy Plast
1710	310	41	2026-10-05 14:27:34.608639	A310	Alarm Lini Niverplast - Transport System
1711	311	41	2026-10-05 14:27:34.608639	A311	Błąd Lini Niverplst - Transport System
1712	309	39	2026-10-05 14:28:34.960505	A309	Błąd Lini Niverplst - Easy Plast
1713	310	41	2026-10-05 14:28:34.960505	A310	Alarm Lini Niverplast - Transport System
1714	311	41	2026-10-05 14:28:34.960505	A311	Błąd Lini Niverplst - Transport System
1715	309	39	2026-10-05 14:29:35.316642	A309	Błąd Lini Niverplst - Easy Plast
1716	310	41	2026-10-05 14:29:35.316642	A310	Alarm Lini Niverplast - Transport System
1717	311	41	2026-10-05 14:29:35.316642	A311	Błąd Lini Niverplst - Transport System
1718	309	39	2026-10-05 14:30:33.450951	A309	Błąd Lini Niverplst - Easy Plast
1719	310	41	2026-10-05 14:30:33.450951	A310	Alarm Lini Niverplast - Transport System
1720	311	41	2026-10-05 14:30:33.450951	A311	Błąd Lini Niverplst - Transport System
1721	309	39	2026-10-05 14:31:33.760021	A309	Błąd Lini Niverplst - Easy Plast
1722	310	41	2026-10-05 14:31:33.760021	A310	Alarm Lini Niverplast - Transport System
1723	311	41	2026-10-05 14:31:33.760021	A311	Błąd Lini Niverplst - Transport System
1724	309	39	2026-10-05 14:32:34.138269	A309	Błąd Lini Niverplst - Easy Plast
1725	310	41	2026-10-05 14:32:34.138269	A310	Alarm Lini Niverplast - Transport System
1726	311	41	2026-10-05 14:32:34.138269	A311	Błąd Lini Niverplst - Transport System
1727	309	39	2026-10-05 14:33:34.434845	A309	Błąd Lini Niverplst - Easy Plast
1728	310	41	2026-10-05 14:33:34.434845	A310	Alarm Lini Niverplast - Transport System
1729	311	41	2026-10-05 14:33:34.434845	A311	Błąd Lini Niverplst - Transport System
1730	309	39	2026-10-05 14:34:34.88964	A309	Błąd Lini Niverplst - Easy Plast
1731	310	41	2026-10-05 14:34:34.88964	A310	Alarm Lini Niverplast - Transport System
1732	311	41	2026-10-05 14:34:34.88964	A311	Błąd Lini Niverplst - Transport System
1733	309	39	2026-10-05 14:35:35.287904	A309	Błąd Lini Niverplst - Easy Plast
1734	310	41	2026-10-05 14:35:35.287904	A310	Alarm Lini Niverplast - Transport System
1735	311	41	2026-10-05 14:35:35.287904	A311	Błąd Lini Niverplst - Transport System
1736	309	39	2026-10-05 14:36:35.596762	A309	Błąd Lini Niverplst - Easy Plast
1737	310	41	2026-10-05 14:36:35.596762	A310	Alarm Lini Niverplast - Transport System
1738	311	41	2026-10-05 14:36:35.596762	A311	Błąd Lini Niverplst - Transport System
1739	309	39	2026-10-05 14:37:35.923531	A309	Błąd Lini Niverplst - Easy Plast
1740	310	41	2026-10-05 14:37:35.923531	A310	Alarm Lini Niverplast - Transport System
1741	311	41	2026-10-05 14:37:35.923531	A311	Błąd Lini Niverplst - Transport System
1742	309	39	2026-10-05 14:38:34.086923	A309	Błąd Lini Niverplst - Easy Plast
1743	310	41	2026-10-05 14:38:34.086923	A310	Alarm Lini Niverplast - Transport System
1744	311	41	2026-10-05 14:38:34.086923	A311	Błąd Lini Niverplst - Transport System
1745	309	39	2026-10-05 14:39:34.387586	A309	Błąd Lini Niverplst - Easy Plast
1746	310	41	2026-10-05 14:39:34.387586	A310	Alarm Lini Niverplast - Transport System
1747	311	41	2026-10-05 14:39:34.387586	A311	Błąd Lini Niverplst - Transport System
1748	309	39	2026-10-05 14:40:34.749818	A309	Błąd Lini Niverplst - Easy Plast
1749	310	41	2026-10-05 14:40:34.749818	A310	Alarm Lini Niverplast - Transport System
1750	311	41	2026-10-05 14:40:34.749818	A311	Błąd Lini Niverplst - Transport System
1751	309	39	2026-10-05 14:41:35.153683	A309	Błąd Lini Niverplst - Easy Plast
1752	310	41	2026-10-05 14:41:35.153683	A310	Alarm Lini Niverplast - Transport System
1753	311	41	2026-10-05 14:41:35.153683	A311	Błąd Lini Niverplst - Transport System
1754	309	39	2026-10-05 14:42:35.54308	A309	Błąd Lini Niverplst - Easy Plast
1755	310	41	2026-10-05 14:42:35.54308	A310	Alarm Lini Niverplast - Transport System
1756	311	41	2026-10-05 14:42:35.54308	A311	Błąd Lini Niverplst - Transport System
1757	309	39	2026-10-05 14:43:35.87557	A309	Błąd Lini Niverplst - Easy Plast
1758	310	41	2026-10-05 14:43:35.87557	A310	Alarm Lini Niverplast - Transport System
1759	311	41	2026-10-05 14:43:35.87557	A311	Błąd Lini Niverplst - Transport System
1760	309	39	2026-10-05 14:44:36.600267	A309	Błąd Lini Niverplst - Easy Plast
1761	310	41	2026-10-05 14:44:36.600267	A310	Alarm Lini Niverplast - Transport System
1762	311	41	2026-10-05 14:44:36.600267	A311	Błąd Lini Niverplst - Transport System
1763	309	39	2026-10-05 14:45:34.385029	A309	Błąd Lini Niverplst - Easy Plast
1764	310	41	2026-10-05 14:45:34.385029	A310	Alarm Lini Niverplast - Transport System
1765	311	41	2026-10-05 14:45:34.385029	A311	Błąd Lini Niverplst - Transport System
1766	309	39	2026-10-05 14:46:34.675905	A309	Błąd Lini Niverplst - Easy Plast
1767	310	41	2026-10-05 14:46:34.675905	A310	Alarm Lini Niverplast - Transport System
1768	311	41	2026-10-05 14:46:34.675905	A311	Błąd Lini Niverplst - Transport System
1769	309	39	2026-10-05 14:47:35.083618	A309	Błąd Lini Niverplst - Easy Plast
1770	310	41	2026-10-05 14:47:35.083618	A310	Alarm Lini Niverplast - Transport System
1771	311	41	2026-10-05 14:47:35.083618	A311	Błąd Lini Niverplst - Transport System
1772	309	39	2026-10-05 14:48:35.372016	A309	Błąd Lini Niverplst - Easy Plast
1773	310	41	2026-10-05 14:48:35.372016	A310	Alarm Lini Niverplast - Transport System
1774	311	41	2026-10-05 14:48:35.372016	A311	Błąd Lini Niverplst - Transport System
1775	309	39	2026-10-05 14:49:35.767838	A309	Błąd Lini Niverplst - Easy Plast
1776	310	41	2026-10-05 14:49:35.767838	A310	Alarm Lini Niverplast - Transport System
1777	311	41	2026-10-05 14:49:35.767838	A311	Błąd Lini Niverplst - Transport System
1778	309	39	2026-10-05 14:50:36.16567	A309	Błąd Lini Niverplst - Easy Plast
1779	310	41	2026-10-05 14:50:36.16567	A310	Alarm Lini Niverplast - Transport System
1780	311	41	2026-10-05 14:50:36.16567	A311	Błąd Lini Niverplst - Transport System
1781	309	39	2026-10-05 14:51:36.496427	A309	Błąd Lini Niverplst - Easy Plast
1782	310	41	2026-10-05 14:51:36.496427	A310	Alarm Lini Niverplast - Transport System
1783	311	41	2026-10-05 14:51:36.496427	A311	Błąd Lini Niverplst - Transport System
1784	309	39	2026-10-05 14:52:36.832258	A309	Błąd Lini Niverplst - Easy Plast
1785	310	41	2026-10-05 14:52:36.832258	A310	Alarm Lini Niverplast - Transport System
1786	311	41	2026-10-05 14:52:36.832258	A311	Błąd Lini Niverplst - Transport System
1787	309	39	2026-10-05 14:53:34.981981	A309	Błąd Lini Niverplst - Easy Plast
1788	310	41	2026-10-05 14:53:34.981981	A310	Alarm Lini Niverplast - Transport System
1789	311	41	2026-10-05 14:53:34.981981	A311	Błąd Lini Niverplst - Transport System
1790	309	39	2026-10-05 14:54:35.279464	A309	Błąd Lini Niverplst - Easy Plast
1791	310	41	2026-10-05 14:54:35.279464	A310	Alarm Lini Niverplast - Transport System
1792	311	41	2026-10-05 14:54:35.279464	A311	Błąd Lini Niverplst - Transport System
1793	309	39	2026-10-05 14:55:35.711328	A309	Błąd Lini Niverplst - Easy Plast
1794	310	41	2026-10-05 14:55:35.711328	A310	Alarm Lini Niverplast - Transport System
1795	311	41	2026-10-05 14:55:35.711328	A311	Błąd Lini Niverplst - Transport System
1796	309	39	2026-10-05 14:56:36.006559	A309	Błąd Lini Niverplst - Easy Plast
1797	310	41	2026-10-05 14:56:36.006559	A310	Alarm Lini Niverplast - Transport System
1798	311	41	2026-10-05 14:56:36.006559	A311	Błąd Lini Niverplst - Transport System
1799	309	39	2026-10-05 14:57:36.446153	A309	Błąd Lini Niverplst - Easy Plast
1800	310	41	2026-10-05 14:57:36.446153	A310	Alarm Lini Niverplast - Transport System
1801	311	41	2026-10-05 14:57:36.446153	A311	Błąd Lini Niverplst - Transport System
1802	309	39	2026-10-05 14:58:36.812477	A309	Błąd Lini Niverplst - Easy Plast
1803	310	41	2026-10-05 14:58:36.812477	A310	Alarm Lini Niverplast - Transport System
1804	311	41	2026-10-05 14:58:36.812477	A311	Błąd Lini Niverplst - Transport System
1805	309	39	2026-10-05 14:59:37.126097	A309	Błąd Lini Niverplst - Easy Plast
1806	310	41	2026-10-05 14:59:37.126097	A310	Alarm Lini Niverplast - Transport System
1807	311	41	2026-10-05 14:59:37.126097	A311	Błąd Lini Niverplst - Transport System
1808	309	39	2026-10-05 15:00:35.248586	A309	Błąd Lini Niverplst - Easy Plast
1809	310	41	2026-10-05 15:00:35.248586	A310	Alarm Lini Niverplast - Transport System
1810	311	41	2026-10-05 15:00:35.248586	A311	Błąd Lini Niverplst - Transport System
1811	309	39	2026-10-05 15:01:35.604025	A309	Błąd Lini Niverplst - Easy Plast
1812	310	41	2026-10-05 15:01:35.604025	A310	Alarm Lini Niverplast - Transport System
1813	311	41	2026-10-05 15:01:35.604025	A311	Błąd Lini Niverplst - Transport System
1814	309	39	2026-10-05 15:02:35.960771	A309	Błąd Lini Niverplst - Easy Plast
1815	310	41	2026-10-05 15:02:35.960771	A310	Alarm Lini Niverplast - Transport System
1816	311	41	2026-10-05 15:02:35.960771	A311	Błąd Lini Niverplst - Transport System
1817	309	39	2026-10-05 15:03:36.302989	A309	Błąd Lini Niverplst - Easy Plast
1818	310	41	2026-10-05 15:03:36.302989	A310	Alarm Lini Niverplast - Transport System
1819	311	41	2026-10-05 15:03:36.302989	A311	Błąd Lini Niverplst - Transport System
1820	309	39	2026-10-05 15:04:36.705654	A309	Błąd Lini Niverplst - Easy Plast
1821	310	41	2026-10-05 15:04:36.705654	A310	Alarm Lini Niverplast - Transport System
1822	311	41	2026-10-05 15:04:36.705654	A311	Błąd Lini Niverplst - Transport System
1823	309	39	2026-10-05 15:05:37.086886	A309	Błąd Lini Niverplst - Easy Plast
1824	310	41	2026-10-05 15:05:37.086886	A310	Alarm Lini Niverplast - Transport System
1825	311	41	2026-10-05 15:05:37.086886	A311	Błąd Lini Niverplst - Transport System
1826	309	39	2026-10-05 15:06:37.417903	A309	Błąd Lini Niverplst - Easy Plast
1827	310	41	2026-10-05 15:06:37.417903	A310	Alarm Lini Niverplast - Transport System
1828	311	41	2026-10-05 15:06:37.417903	A311	Błąd Lini Niverplst - Transport System
1829	309	39	2026-10-05 15:07:37.710596	A309	Błąd Lini Niverplst - Easy Plast
1830	310	41	2026-10-05 15:07:37.710596	A310	Alarm Lini Niverplast - Transport System
1831	311	41	2026-10-05 15:07:37.710596	A311	Błąd Lini Niverplst - Transport System
1832	309	39	2026-10-05 15:08:36.778092	A309	Błąd Lini Niverplst - Easy Plast
1833	310	41	2026-10-05 15:08:36.778092	A310	Alarm Lini Niverplast - Transport System
1834	311	41	2026-10-05 15:08:36.778092	A311	Błąd Lini Niverplst - Transport System
1835	309	39	2026-10-05 15:09:37.103274	A309	Błąd Lini Niverplst - Easy Plast
1836	310	41	2026-10-05 15:09:37.103274	A310	Alarm Lini Niverplast - Transport System
1837	311	41	2026-10-05 15:09:37.103274	A311	Błąd Lini Niverplst - Transport System
1838	309	39	2026-10-05 15:10:37.455795	A309	Błąd Lini Niverplst - Easy Plast
1839	310	41	2026-10-05 15:10:37.455795	A310	Alarm Lini Niverplast - Transport System
1840	311	41	2026-10-05 15:10:37.455795	A311	Błąd Lini Niverplst - Transport System
1841	309	39	2026-10-05 15:11:37.480884	A309	Błąd Lini Niverplst - Easy Plast
1842	310	41	2026-10-05 15:11:37.480884	A310	Alarm Lini Niverplast - Transport System
1843	311	41	2026-10-05 15:11:37.480884	A311	Błąd Lini Niverplst - Transport System
1844	309	39	2026-10-05 15:12:37.549284	A309	Błąd Lini Niverplst - Easy Plast
1845	310	41	2026-10-05 15:12:37.549284	A310	Alarm Lini Niverplast - Transport System
1846	311	41	2026-10-05 15:12:37.549284	A311	Błąd Lini Niverplst - Transport System
1847	309	39	2026-10-05 15:13:37.631205	A309	Błąd Lini Niverplst - Easy Plast
1848	310	41	2026-10-05 15:13:37.631205	A310	Alarm Lini Niverplast - Transport System
1849	311	41	2026-10-05 15:13:37.631205	A311	Błąd Lini Niverplst - Transport System
1850	309	39	2026-10-05 15:14:37.857245	A309	Błąd Lini Niverplst - Easy Plast
1851	310	41	2026-10-05 15:14:37.857245	A310	Alarm Lini Niverplast - Transport System
1852	311	41	2026-10-05 15:14:37.857245	A311	Błąd Lini Niverplst - Transport System
1853	309	39	2026-10-05 15:15:37.865131	A309	Błąd Lini Niverplst - Easy Plast
1854	310	41	2026-10-05 15:15:37.865131	A310	Alarm Lini Niverplast - Transport System
1855	311	41	2026-10-05 15:15:37.865131	A311	Błąd Lini Niverplst - Transport System
1856	309	39	2026-10-05 15:16:38.104521	A309	Błąd Lini Niverplst - Easy Plast
1857	310	41	2026-10-05 15:16:38.104521	A310	Alarm Lini Niverplast - Transport System
1858	311	41	2026-10-05 15:16:38.104521	A311	Błąd Lini Niverplst - Transport System
1859	309	39	2026-10-05 15:17:38.187543	A309	Błąd Lini Niverplst - Easy Plast
1860	310	41	2026-10-05 15:17:38.187543	A310	Alarm Lini Niverplast - Transport System
1861	311	41	2026-10-05 15:17:38.187543	A311	Błąd Lini Niverplst - Transport System
1862	309	39	2026-10-05 15:18:38.295426	A309	Błąd Lini Niverplst - Easy Plast
1863	310	41	2026-10-05 15:18:38.295426	A310	Alarm Lini Niverplast - Transport System
1864	311	41	2026-10-05 15:18:38.295426	A311	Błąd Lini Niverplst - Transport System
1865	309	39	2026-10-05 15:19:38.372255	A309	Błąd Lini Niverplst - Easy Plast
1866	310	41	2026-10-05 15:19:38.372255	A310	Alarm Lini Niverplast - Transport System
1867	311	41	2026-10-05 15:19:38.372255	A311	Błąd Lini Niverplst - Transport System
1868	309	39	2026-10-05 15:20:38.438843	A309	Błąd Lini Niverplst - Easy Plast
1869	310	41	2026-10-05 15:20:38.438843	A310	Alarm Lini Niverplast - Transport System
1870	311	41	2026-10-05 15:20:38.438843	A311	Błąd Lini Niverplst - Transport System
1871	309	39	2026-10-05 15:21:38.520782	A309	Błąd Lini Niverplst - Easy Plast
1872	310	41	2026-10-05 15:21:38.520782	A310	Alarm Lini Niverplast - Transport System
1873	311	41	2026-10-05 15:21:38.520782	A311	Błąd Lini Niverplst - Transport System
1874	309	39	2026-10-05 15:22:38.625104	A309	Błąd Lini Niverplst - Easy Plast
1875	310	41	2026-10-05 15:22:38.625104	A310	Alarm Lini Niverplast - Transport System
1876	311	41	2026-10-05 15:22:38.625104	A311	Błąd Lini Niverplst - Transport System
1877	309	39	2026-10-05 15:23:38.656943	A309	Błąd Lini Niverplst - Easy Plast
1878	310	41	2026-10-05 15:23:38.656943	A310	Alarm Lini Niverplast - Transport System
1879	311	41	2026-10-05 15:23:38.656943	A311	Błąd Lini Niverplst - Transport System
1880	309	39	2026-10-05 15:24:38.722599	A309	Błąd Lini Niverplst - Easy Plast
1881	310	41	2026-10-05 15:24:38.722599	A310	Alarm Lini Niverplast - Transport System
1882	311	41	2026-10-05 15:24:38.722599	A311	Błąd Lini Niverplst - Transport System
1883	309	39	2026-10-05 15:25:38.772082	A309	Błąd Lini Niverplst - Easy Plast
1884	310	41	2026-10-05 15:25:38.772082	A310	Alarm Lini Niverplast - Transport System
1885	311	41	2026-10-05 15:25:38.772082	A311	Błąd Lini Niverplst - Transport System
1886	309	39	2026-10-05 15:26:38.836022	A309	Błąd Lini Niverplst - Easy Plast
1887	310	41	2026-10-05 15:26:38.836022	A310	Alarm Lini Niverplast - Transport System
1888	311	41	2026-10-05 15:26:38.836022	A311	Błąd Lini Niverplst - Transport System
1889	309	39	2026-10-05 15:27:38.906635	A309	Błąd Lini Niverplst - Easy Plast
1890	310	41	2026-10-05 15:27:38.906635	A310	Alarm Lini Niverplast - Transport System
1891	311	41	2026-10-05 15:27:38.906635	A311	Błąd Lini Niverplst - Transport System
1892	309	39	2026-10-05 15:28:38.968629	A309	Błąd Lini Niverplst - Easy Plast
1893	310	41	2026-10-05 15:28:38.968629	A310	Alarm Lini Niverplast - Transport System
1894	311	41	2026-10-05 15:28:38.968629	A311	Błąd Lini Niverplst - Transport System
1895	309	39	2026-10-05 15:29:39.00535	A309	Błąd Lini Niverplst - Easy Plast
1896	310	41	2026-10-05 15:29:39.00535	A310	Alarm Lini Niverplast - Transport System
1897	311	41	2026-10-05 15:29:39.00535	A311	Błąd Lini Niverplst - Transport System
1898	309	39	2026-10-05 15:30:39.085015	A309	Błąd Lini Niverplst - Easy Plast
1899	310	41	2026-10-05 15:30:39.085015	A310	Alarm Lini Niverplast - Transport System
1900	311	41	2026-10-05 15:30:39.085015	A311	Błąd Lini Niverplst - Transport System
1901	309	39	2026-10-05 15:31:39.130831	A309	Błąd Lini Niverplst - Easy Plast
1902	310	41	2026-10-05 15:31:39.130831	A310	Alarm Lini Niverplast - Transport System
1903	311	41	2026-10-05 15:31:39.130831	A311	Błąd Lini Niverplst - Transport System
1904	309	39	2026-10-05 15:32:39.18555	A309	Błąd Lini Niverplst - Easy Plast
1905	310	41	2026-10-05 15:32:39.18555	A310	Alarm Lini Niverplast - Transport System
1906	311	41	2026-10-05 15:32:39.18555	A311	Błąd Lini Niverplst - Transport System
1907	309	39	2026-10-05 15:33:39.241183	A309	Błąd Lini Niverplst - Easy Plast
1908	310	41	2026-10-05 15:33:39.241183	A310	Alarm Lini Niverplast - Transport System
1909	311	41	2026-10-05 15:33:39.241183	A311	Błąd Lini Niverplst - Transport System
1910	309	39	2026-10-05 15:34:39.315485	A309	Błąd Lini Niverplst - Easy Plast
1911	310	41	2026-10-05 15:34:39.315485	A310	Alarm Lini Niverplast - Transport System
1912	311	41	2026-10-05 15:34:39.315485	A311	Błąd Lini Niverplst - Transport System
1913	309	39	2026-10-05 15:35:39.35895	A309	Błąd Lini Niverplst - Easy Plast
1914	310	41	2026-10-05 15:35:39.35895	A310	Alarm Lini Niverplast - Transport System
1915	311	41	2026-10-05 15:35:39.35895	A311	Błąd Lini Niverplst - Transport System
1916	309	39	2026-10-05 15:36:39.434594	A309	Błąd Lini Niverplst - Easy Plast
1917	310	41	2026-10-05 15:36:39.434594	A310	Alarm Lini Niverplast - Transport System
1918	311	41	2026-10-05 15:36:39.434594	A311	Błąd Lini Niverplst - Transport System
1919	309	39	2026-10-05 15:37:39.491176	A309	Błąd Lini Niverplst - Easy Plast
1920	310	41	2026-10-05 15:37:39.491176	A310	Alarm Lini Niverplast - Transport System
1921	311	41	2026-10-05 15:37:39.491176	A311	Błąd Lini Niverplst - Transport System
1922	309	39	2026-10-05 15:38:39.528601	A309	Błąd Lini Niverplst - Easy Plast
1923	310	41	2026-10-05 15:38:39.528601	A310	Alarm Lini Niverplast - Transport System
1924	311	41	2026-10-05 15:38:39.528601	A311	Błąd Lini Niverplst - Transport System
1925	309	39	2026-10-05 15:39:39.588194	A309	Błąd Lini Niverplst - Easy Plast
1926	310	41	2026-10-05 15:39:39.588194	A310	Alarm Lini Niverplast - Transport System
1927	311	41	2026-10-05 15:39:39.588194	A311	Błąd Lini Niverplst - Transport System
1928	309	39	2026-10-05 15:40:39.66825	A309	Błąd Lini Niverplst - Easy Plast
1929	310	41	2026-10-05 15:40:39.66825	A310	Alarm Lini Niverplast - Transport System
1930	311	41	2026-10-05 15:40:39.66825	A311	Błąd Lini Niverplst - Transport System
1931	309	39	2026-10-05 15:41:39.714294	A309	Błąd Lini Niverplst - Easy Plast
1932	310	41	2026-10-05 15:41:39.714294	A310	Alarm Lini Niverplast - Transport System
1933	311	41	2026-10-05 15:41:39.714294	A311	Błąd Lini Niverplst - Transport System
1934	309	39	2026-10-05 15:42:39.760954	A309	Błąd Lini Niverplst - Easy Plast
1935	310	41	2026-10-05 15:42:39.760954	A310	Alarm Lini Niverplast - Transport System
1936	311	41	2026-10-05 15:42:39.760954	A311	Błąd Lini Niverplst - Transport System
1937	309	39	2026-10-05 15:43:39.820801	A309	Błąd Lini Niverplst - Easy Plast
1938	310	41	2026-10-05 15:43:39.820801	A310	Alarm Lini Niverplast - Transport System
1939	311	41	2026-10-05 15:43:39.820801	A311	Błąd Lini Niverplst - Transport System
1940	309	39	2026-10-05 15:44:39.879704	A309	Błąd Lini Niverplst - Easy Plast
1941	310	41	2026-10-05 15:44:39.879704	A310	Alarm Lini Niverplast - Transport System
1942	311	41	2026-10-05 15:44:39.879704	A311	Błąd Lini Niverplst - Transport System
1943	309	39	2026-10-05 15:45:39.94732	A309	Błąd Lini Niverplst - Easy Plast
1944	310	41	2026-10-05 15:45:39.94732	A310	Alarm Lini Niverplast - Transport System
1945	311	41	2026-10-05 15:45:39.94732	A311	Błąd Lini Niverplst - Transport System
1946	309	39	2026-10-05 15:46:40.005052	A309	Błąd Lini Niverplst - Easy Plast
1947	310	41	2026-10-05 15:46:40.005052	A310	Alarm Lini Niverplast - Transport System
1948	311	41	2026-10-05 15:46:40.005052	A311	Błąd Lini Niverplst - Transport System
1949	309	39	2026-10-05 15:47:40.058943	A309	Błąd Lini Niverplst - Easy Plast
1950	310	41	2026-10-05 15:47:40.058943	A310	Alarm Lini Niverplast - Transport System
1951	311	41	2026-10-05 15:47:40.058943	A311	Błąd Lini Niverplst - Transport System
1952	309	39	2026-10-05 15:48:40.120747	A309	Błąd Lini Niverplst - Easy Plast
1953	310	41	2026-10-05 15:48:40.120747	A310	Alarm Lini Niverplast - Transport System
1954	311	41	2026-10-05 15:48:40.120747	A311	Błąd Lini Niverplst - Transport System
1955	309	39	2026-10-05 15:49:40.180701	A309	Błąd Lini Niverplst - Easy Plast
1956	310	41	2026-10-05 15:49:40.180701	A310	Alarm Lini Niverplast - Transport System
1957	311	41	2026-10-05 15:49:40.180701	A311	Błąd Lini Niverplst - Transport System
1958	309	39	2026-10-05 15:50:40.24282	A309	Błąd Lini Niverplst - Easy Plast
1959	310	41	2026-10-05 15:50:40.24282	A310	Alarm Lini Niverplast - Transport System
1960	311	41	2026-10-05 15:50:40.24282	A311	Błąd Lini Niverplst - Transport System
1961	309	39	2026-10-05 15:51:40.296583	A309	Błąd Lini Niverplst - Easy Plast
1962	310	41	2026-10-05 15:51:40.296583	A310	Alarm Lini Niverplast - Transport System
1963	311	41	2026-10-05 15:51:40.296583	A311	Błąd Lini Niverplst - Transport System
1964	309	39	2026-10-05 15:52:40.357241	A309	Błąd Lini Niverplst - Easy Plast
1965	310	41	2026-10-05 15:52:40.357241	A310	Alarm Lini Niverplast - Transport System
1966	311	41	2026-10-05 15:52:40.357241	A311	Błąd Lini Niverplst - Transport System
1967	309	39	2026-10-05 15:53:40.405198	A309	Błąd Lini Niverplst - Easy Plast
1968	310	41	2026-10-05 15:53:40.405198	A310	Alarm Lini Niverplast - Transport System
1969	311	41	2026-10-05 15:53:40.405198	A311	Błąd Lini Niverplst - Transport System
1970	309	39	2026-10-05 15:54:40.458884	A309	Błąd Lini Niverplst - Easy Plast
1971	310	41	2026-10-05 15:54:40.458884	A310	Alarm Lini Niverplast - Transport System
1972	311	41	2026-10-05 15:54:40.458884	A311	Błąd Lini Niverplst - Transport System
1973	309	39	2026-10-05 15:55:40.539835	A309	Błąd Lini Niverplst - Easy Plast
1974	310	41	2026-10-05 15:55:40.539835	A310	Alarm Lini Niverplast - Transport System
1975	311	41	2026-10-05 15:55:40.539835	A311	Błąd Lini Niverplst - Transport System
1976	309	39	2026-10-05 15:56:40.581431	A309	Błąd Lini Niverplst - Easy Plast
1977	310	41	2026-10-05 15:56:40.581431	A310	Alarm Lini Niverplast - Transport System
1978	311	41	2026-10-05 15:56:40.581431	A311	Błąd Lini Niverplst - Transport System
1979	309	39	2026-10-05 15:57:40.663513	A309	Błąd Lini Niverplst - Easy Plast
1980	310	41	2026-10-05 15:57:40.663513	A310	Alarm Lini Niverplast - Transport System
1981	311	41	2026-10-05 15:57:40.663513	A311	Błąd Lini Niverplst - Transport System
1982	309	39	2026-10-05 15:58:40.718707	A309	Błąd Lini Niverplst - Easy Plast
1983	310	41	2026-10-05 15:58:40.718707	A310	Alarm Lini Niverplast - Transport System
1984	311	41	2026-10-05 15:58:40.718707	A311	Błąd Lini Niverplst - Transport System
1985	309	39	2026-10-05 15:59:40.761366	A309	Błąd Lini Niverplst - Easy Plast
1986	310	41	2026-10-05 15:59:40.761366	A310	Alarm Lini Niverplast - Transport System
1987	311	41	2026-10-05 15:59:40.761366	A311	Błąd Lini Niverplst - Transport System
1988	309	39	2026-10-05 16:00:40.839128	A309	Błąd Lini Niverplst - Easy Plast
1989	310	41	2026-10-05 16:00:40.839128	A310	Alarm Lini Niverplast - Transport System
1990	311	41	2026-10-05 16:00:40.839128	A311	Błąd Lini Niverplst - Transport System
1991	309	39	2026-10-05 16:01:40.89707	A309	Błąd Lini Niverplst - Easy Plast
1992	310	41	2026-10-05 16:01:40.89707	A310	Alarm Lini Niverplast - Transport System
1993	311	41	2026-10-05 16:01:40.89707	A311	Błąd Lini Niverplst - Transport System
1994	309	39	2026-10-05 16:02:40.938945	A309	Błąd Lini Niverplst - Easy Plast
1995	310	41	2026-10-05 16:02:40.938945	A310	Alarm Lini Niverplast - Transport System
1996	311	41	2026-10-05 16:02:40.938945	A311	Błąd Lini Niverplst - Transport System
1997	309	39	2026-10-05 16:03:41.00258	A309	Błąd Lini Niverplst - Easy Plast
1998	310	41	2026-10-05 16:03:41.00258	A310	Alarm Lini Niverplast - Transport System
1999	311	41	2026-10-05 16:03:41.00258	A311	Błąd Lini Niverplst - Transport System
2000	309	39	2026-10-05 16:04:41.055209	A309	Błąd Lini Niverplst - Easy Plast
2001	310	41	2026-10-05 16:04:41.055209	A310	Alarm Lini Niverplast - Transport System
2002	311	41	2026-10-05 16:04:41.055209	A311	Błąd Lini Niverplst - Transport System
2003	309	39	2026-10-05 16:05:41.125268	A309	Błąd Lini Niverplst - Easy Plast
2004	310	41	2026-10-05 16:05:41.125268	A310	Alarm Lini Niverplast - Transport System
2005	311	41	2026-10-05 16:05:41.125268	A311	Błąd Lini Niverplst - Transport System
2006	309	39	2026-10-05 16:06:41.180748	A309	Błąd Lini Niverplst - Easy Plast
2007	310	41	2026-10-05 16:06:41.180748	A310	Alarm Lini Niverplast - Transport System
2008	311	41	2026-10-05 16:06:41.180748	A311	Błąd Lini Niverplst - Transport System
2009	309	39	2026-10-05 16:07:41.22687	A309	Błąd Lini Niverplst - Easy Plast
2010	310	41	2026-10-05 16:07:41.22687	A310	Alarm Lini Niverplast - Transport System
2011	311	41	2026-10-05 16:07:41.22687	A311	Błąd Lini Niverplst - Transport System
2012	309	39	2026-10-05 16:08:41.294323	A309	Błąd Lini Niverplst - Easy Plast
2013	310	41	2026-10-05 16:08:41.294323	A310	Alarm Lini Niverplast - Transport System
2014	311	41	2026-10-05 16:08:41.294323	A311	Błąd Lini Niverplst - Transport System
2015	309	39	2026-10-05 16:09:41.340659	A309	Błąd Lini Niverplst - Easy Plast
2016	310	41	2026-10-05 16:09:41.340659	A310	Alarm Lini Niverplast - Transport System
2017	311	41	2026-10-05 16:09:41.340659	A311	Błąd Lini Niverplst - Transport System
2018	309	39	2026-10-05 16:10:41.39363	A309	Błąd Lini Niverplst - Easy Plast
2019	310	41	2026-10-05 16:10:41.39363	A310	Alarm Lini Niverplast - Transport System
2020	311	41	2026-10-05 16:10:41.39363	A311	Błąd Lini Niverplst - Transport System
2021	309	39	2026-10-05 16:11:41.442414	A309	Błąd Lini Niverplst - Easy Plast
2022	310	41	2026-10-05 16:11:41.442414	A310	Alarm Lini Niverplast - Transport System
2023	311	41	2026-10-05 16:11:41.442414	A311	Błąd Lini Niverplst - Transport System
2024	309	39	2026-10-05 16:12:41.505065	A309	Błąd Lini Niverplst - Easy Plast
2025	310	41	2026-10-05 16:12:41.505065	A310	Alarm Lini Niverplast - Transport System
2026	311	41	2026-10-05 16:12:41.505065	A311	Błąd Lini Niverplst - Transport System
2027	309	39	2026-10-05 16:13:41.570629	A309	Błąd Lini Niverplst - Easy Plast
2028	310	41	2026-10-05 16:13:41.570629	A310	Alarm Lini Niverplast - Transport System
2029	311	41	2026-10-05 16:13:41.570629	A311	Błąd Lini Niverplst - Transport System
2030	309	39	2026-10-05 16:14:41.620226	A309	Błąd Lini Niverplst - Easy Plast
2031	310	41	2026-10-05 16:14:41.620226	A310	Alarm Lini Niverplast - Transport System
2032	311	41	2026-10-05 16:14:41.620226	A311	Błąd Lini Niverplst - Transport System
2033	309	39	2026-10-05 16:15:41.680201	A309	Błąd Lini Niverplst - Easy Plast
2034	310	41	2026-10-05 16:15:41.680201	A310	Alarm Lini Niverplast - Transport System
2035	311	41	2026-10-05 16:15:41.680201	A311	Błąd Lini Niverplst - Transport System
2036	309	39	2026-10-05 16:16:41.734452	A309	Błąd Lini Niverplst - Easy Plast
2037	310	41	2026-10-05 16:16:41.734452	A310	Alarm Lini Niverplast - Transport System
2038	311	41	2026-10-05 16:16:41.734452	A311	Błąd Lini Niverplst - Transport System
2039	309	39	2026-10-05 16:17:41.804828	A309	Błąd Lini Niverplst - Easy Plast
2040	310	41	2026-10-05 16:17:41.804828	A310	Alarm Lini Niverplast - Transport System
2041	311	41	2026-10-05 16:17:41.804828	A311	Błąd Lini Niverplst - Transport System
2042	309	39	2026-10-05 16:18:41.865085	A309	Błąd Lini Niverplst - Easy Plast
2043	310	41	2026-10-05 16:18:41.865085	A310	Alarm Lini Niverplast - Transport System
2044	311	41	2026-10-05 16:18:41.865085	A311	Błąd Lini Niverplst - Transport System
2045	106	2	2026-10-05 16:18:41.865085	A106	Błąd pudełko zostało odrzucone
2046	309	39	2026-10-05 16:19:41.907578	A309	Błąd Lini Niverplst - Easy Plast
2047	310	41	2026-10-05 16:19:41.907578	A310	Alarm Lini Niverplast - Transport System
2048	311	41	2026-10-05 16:19:41.907578	A311	Błąd Lini Niverplst - Transport System
2049	309	39	2026-10-05 16:20:41.970756	A309	Błąd Lini Niverplst - Easy Plast
2050	310	41	2026-10-05 16:20:41.970756	A310	Alarm Lini Niverplast - Transport System
2051	311	41	2026-10-05 16:20:41.970756	A311	Błąd Lini Niverplst - Transport System
2052	309	39	2026-10-05 16:21:42.023736	A309	Błąd Lini Niverplst - Easy Plast
2053	310	41	2026-10-05 16:21:42.023736	A310	Alarm Lini Niverplast - Transport System
2054	311	41	2026-10-05 16:21:42.023736	A311	Błąd Lini Niverplst - Transport System
2055	309	39	2026-10-05 16:22:42.079045	A309	Błąd Lini Niverplst - Easy Plast
2056	310	41	2026-10-05 16:22:42.079045	A310	Alarm Lini Niverplast - Transport System
2057	311	41	2026-10-05 16:22:42.079045	A311	Błąd Lini Niverplst - Transport System
2058	309	39	2026-10-05 16:23:42.133041	A309	Błąd Lini Niverplst - Easy Plast
2059	310	41	2026-10-05 16:23:42.133041	A310	Alarm Lini Niverplast - Transport System
2060	311	41	2026-10-05 16:23:42.133041	A311	Błąd Lini Niverplst - Transport System
2061	309	39	2026-10-05 16:24:42.189162	A309	Błąd Lini Niverplst - Easy Plast
2062	310	41	2026-10-05 16:24:42.189162	A310	Alarm Lini Niverplast - Transport System
2063	311	41	2026-10-05 16:24:42.189162	A311	Błąd Lini Niverplst - Transport System
2064	309	39	2026-10-05 16:25:42.241829	A309	Błąd Lini Niverplst - Easy Plast
2065	310	41	2026-10-05 16:25:42.241829	A310	Alarm Lini Niverplast - Transport System
2066	311	41	2026-10-05 16:25:42.241829	A311	Błąd Lini Niverplst - Transport System
2067	309	39	2026-10-05 16:26:42.309466	A309	Błąd Lini Niverplst - Easy Plast
2068	310	41	2026-10-05 16:26:42.309466	A310	Alarm Lini Niverplast - Transport System
2069	311	41	2026-10-05 16:26:42.309466	A311	Błąd Lini Niverplst - Transport System
2070	309	39	2026-10-05 16:27:42.357077	A309	Błąd Lini Niverplst - Easy Plast
2071	310	41	2026-10-05 16:27:42.357077	A310	Alarm Lini Niverplast - Transport System
2072	311	41	2026-10-05 16:27:42.357077	A311	Błąd Lini Niverplst - Transport System
2073	309	39	2026-10-05 16:28:42.431137	A309	Błąd Lini Niverplst - Easy Plast
2074	310	41	2026-10-05 16:28:42.431137	A310	Alarm Lini Niverplast - Transport System
2075	311	41	2026-10-05 16:28:42.431137	A311	Błąd Lini Niverplst - Transport System
2076	309	39	2026-10-05 16:29:42.493733	A309	Błąd Lini Niverplst - Easy Plast
2077	310	41	2026-10-05 16:29:42.493733	A310	Alarm Lini Niverplast - Transport System
2078	311	41	2026-10-05 16:29:42.493733	A311	Błąd Lini Niverplst - Transport System
2079	309	39	2026-10-05 16:30:42.552654	A309	Błąd Lini Niverplst - Easy Plast
2080	310	41	2026-10-05 16:30:42.552654	A310	Alarm Lini Niverplast - Transport System
2081	311	41	2026-10-05 16:30:42.552654	A311	Błąd Lini Niverplst - Transport System
2082	309	39	2026-10-05 16:31:42.593757	A309	Błąd Lini Niverplst - Easy Plast
2083	310	41	2026-10-05 16:31:42.593757	A310	Alarm Lini Niverplast - Transport System
2084	311	41	2026-10-05 16:31:42.593757	A311	Błąd Lini Niverplst - Transport System
2085	309	39	2026-10-05 16:32:42.65057	A309	Błąd Lini Niverplst - Easy Plast
2086	310	41	2026-10-05 16:32:42.65057	A310	Alarm Lini Niverplast - Transport System
2087	311	41	2026-10-05 16:32:42.65057	A311	Błąd Lini Niverplst - Transport System
2088	309	39	2026-10-05 16:33:42.711791	A309	Błąd Lini Niverplst - Easy Plast
2089	310	41	2026-10-05 16:33:42.711791	A310	Alarm Lini Niverplast - Transport System
2090	311	41	2026-10-05 16:33:42.711791	A311	Błąd Lini Niverplst - Transport System
2091	309	39	2026-10-05 16:34:42.786058	A309	Błąd Lini Niverplst - Easy Plast
2092	310	41	2026-10-05 16:34:42.786058	A310	Alarm Lini Niverplast - Transport System
2093	311	41	2026-10-05 16:34:42.786058	A311	Błąd Lini Niverplst - Transport System
2094	309	39	2026-10-05 16:35:42.827034	A309	Błąd Lini Niverplst - Easy Plast
2095	310	41	2026-10-05 16:35:42.827034	A310	Alarm Lini Niverplast - Transport System
2096	311	41	2026-10-05 16:35:42.827034	A311	Błąd Lini Niverplst - Transport System
2097	309	39	2026-10-05 16:36:42.893972	A309	Błąd Lini Niverplst - Easy Plast
2098	310	41	2026-10-05 16:36:42.893972	A310	Alarm Lini Niverplast - Transport System
2099	311	41	2026-10-05 16:36:42.893972	A311	Błąd Lini Niverplst - Transport System
2100	309	39	2026-10-05 16:37:42.937249	A309	Błąd Lini Niverplst - Easy Plast
2101	310	41	2026-10-05 16:37:42.937249	A310	Alarm Lini Niverplast - Transport System
2102	311	41	2026-10-05 16:37:42.937249	A311	Błąd Lini Niverplst - Transport System
2103	309	39	2026-10-05 16:38:42.99918	A309	Błąd Lini Niverplst - Easy Plast
2104	310	41	2026-10-05 16:38:42.99918	A310	Alarm Lini Niverplast - Transport System
2105	311	41	2026-10-05 16:38:42.99918	A311	Błąd Lini Niverplst - Transport System
2106	187	40	2026-10-05 16:39:43.066289	A187	Otwarta Bramka Bezpieczeństwa 
2107	129	40	2026-10-05 16:39:43.066289	A129	Niskie ciśnienie pneumatyczne - strefa 1
2108	309	39	2026-10-05 16:39:43.066289	A309	Błąd Lini Niverplst - Easy Plast
2109	310	41	2026-10-05 16:39:43.066289	A310	Alarm Lini Niverplast - Transport System
2110	311	41	2026-10-05 16:39:43.066289	A311	Błąd Lini Niverplst - Transport System
2111	188	40	2026-10-05 16:39:43.066289	A188	Nieryglowany zamek bramki bezpieszeństwa
2112	187	40	2026-10-05 16:40:43.111358	A187	Otwarta Bramka Bezpieczeństwa 
2113	129	40	2026-10-05 16:40:43.111358	A129	Niskie ciśnienie pneumatyczne - strefa 1
2114	309	39	2026-10-05 16:40:43.111358	A309	Błąd Lini Niverplst - Easy Plast
2115	310	41	2026-10-05 16:40:43.111358	A310	Alarm Lini Niverplast - Transport System
2116	311	41	2026-10-05 16:40:43.111358	A311	Błąd Lini Niverplst - Transport System
2117	188	40	2026-10-05 16:40:43.111358	A188	Nieryglowany zamek bramki bezpieszeństwa
2118	187	40	2026-10-05 16:41:43.167906	A187	Otwarta Bramka Bezpieczeństwa 
2119	129	40	2026-10-05 16:41:43.167906	A129	Niskie ciśnienie pneumatyczne - strefa 1
2120	309	39	2026-10-05 16:41:43.167906	A309	Błąd Lini Niverplst - Easy Plast
2121	310	41	2026-10-05 16:41:43.167906	A310	Alarm Lini Niverplast - Transport System
2122	311	41	2026-10-05 16:41:43.167906	A311	Błąd Lini Niverplst - Transport System
2123	188	40	2026-10-05 16:41:43.167906	A188	Nieryglowany zamek bramki bezpieszeństwa
2124	187	40	2026-10-05 16:42:43.235036	A187	Otwarta Bramka Bezpieczeństwa 
2125	129	40	2026-10-05 16:42:43.235036	A129	Niskie ciśnienie pneumatyczne - strefa 1
2126	309	39	2026-10-05 16:42:43.235036	A309	Błąd Lini Niverplst - Easy Plast
2127	310	41	2026-10-05 16:42:43.235036	A310	Alarm Lini Niverplast - Transport System
2128	311	41	2026-10-05 16:42:43.235036	A311	Błąd Lini Niverplst - Transport System
2129	188	40	2026-10-05 16:42:43.235036	A188	Nieryglowany zamek bramki bezpieszeństwa
2130	187	40	2026-10-05 16:43:43.284286	A187	Otwarta Bramka Bezpieczeństwa 
2131	129	40	2026-10-05 16:43:43.284286	A129	Niskie ciśnienie pneumatyczne - strefa 1
2132	309	39	2026-10-05 16:43:43.284286	A309	Błąd Lini Niverplst - Easy Plast
2133	310	41	2026-10-05 16:43:43.284286	A310	Alarm Lini Niverplast - Transport System
2134	311	41	2026-10-05 16:43:43.284286	A311	Błąd Lini Niverplst - Transport System
2135	188	40	2026-10-05 16:43:43.284286	A188	Nieryglowany zamek bramki bezpieszeństwa
2136	187	40	2026-10-05 16:44:43.343571	A187	Otwarta Bramka Bezpieczeństwa 
2137	129	40	2026-10-05 16:44:43.343571	A129	Niskie ciśnienie pneumatyczne - strefa 1
2138	309	39	2026-10-05 16:44:43.343571	A309	Błąd Lini Niverplst - Easy Plast
2139	310	41	2026-10-05 16:44:43.343571	A310	Alarm Lini Niverplast - Transport System
2140	311	41	2026-10-05 16:44:43.343571	A311	Błąd Lini Niverplst - Transport System
2141	188	40	2026-10-05 16:44:43.343571	A188	Nieryglowany zamek bramki bezpieszeństwa
2142	187	40	2026-10-05 16:45:43.399482	A187	Otwarta Bramka Bezpieczeństwa 
2143	129	40	2026-10-05 16:45:43.399482	A129	Niskie ciśnienie pneumatyczne - strefa 1
2144	309	39	2026-10-05 16:45:43.399482	A309	Błąd Lini Niverplst - Easy Plast
2145	310	41	2026-10-05 16:45:43.399482	A310	Alarm Lini Niverplast - Transport System
2146	311	41	2026-10-05 16:45:43.399482	A311	Błąd Lini Niverplst - Transport System
2147	188	40	2026-10-05 16:45:43.399482	A188	Nieryglowany zamek bramki bezpieszeństwa
2148	187	40	2026-10-05 16:46:43.217681	A187	Otwarta Bramka Bezpieczeństwa 
2149	129	40	2026-10-05 16:46:43.217681	A129	Niskie ciśnienie pneumatyczne - strefa 1
2150	309	39	2026-10-05 16:46:43.217681	A309	Błąd Lini Niverplst - Easy Plast
2151	310	41	2026-10-05 16:46:43.217681	A310	Alarm Lini Niverplast - Transport System
2152	311	41	2026-10-05 16:46:43.217681	A311	Błąd Lini Niverplst - Transport System
2153	188	40	2026-10-05 16:46:43.217681	A188	Nieryglowany zamek bramki bezpieszeństwa
2154	187	40	2026-10-05 16:47:43.537342	A187	Otwarta Bramka Bezpieczeństwa 
2155	129	40	2026-10-05 16:47:43.537342	A129	Niskie ciśnienie pneumatyczne - strefa 1
2156	309	39	2026-10-05 16:47:43.537342	A309	Błąd Lini Niverplst - Easy Plast
2157	310	41	2026-10-05 16:47:43.537342	A310	Alarm Lini Niverplast - Transport System
2158	311	41	2026-10-05 16:47:43.537342	A311	Błąd Lini Niverplst - Transport System
2159	188	40	2026-10-05 16:47:43.537342	A188	Nieryglowany zamek bramki bezpieszeństwa
2160	187	40	2026-10-05 16:48:43.586808	A187	Otwarta Bramka Bezpieczeństwa 
2161	129	40	2026-10-05 16:48:43.586808	A129	Niskie ciśnienie pneumatyczne - strefa 1
2162	309	39	2026-10-05 16:48:43.586808	A309	Błąd Lini Niverplst - Easy Plast
2163	310	41	2026-10-05 16:48:43.586808	A310	Alarm Lini Niverplast - Transport System
2164	311	41	2026-10-05 16:48:43.586808	A311	Błąd Lini Niverplst - Transport System
2165	188	40	2026-10-05 16:48:43.586808	A188	Nieryglowany zamek bramki bezpieszeństwa
2166	187	40	2026-10-05 16:49:43.639835	A187	Otwarta Bramka Bezpieczeństwa 
2167	129	40	2026-10-05 16:49:43.639835	A129	Niskie ciśnienie pneumatyczne - strefa 1
2168	309	39	2026-10-05 16:49:43.639835	A309	Błąd Lini Niverplst - Easy Plast
2169	310	41	2026-10-05 16:49:43.639835	A310	Alarm Lini Niverplast - Transport System
2170	311	41	2026-10-05 16:49:43.639835	A311	Błąd Lini Niverplst - Transport System
2171	188	40	2026-10-05 16:49:43.639835	A188	Nieryglowany zamek bramki bezpieszeństwa
2172	187	40	2026-10-05 16:50:43.71117	A187	Otwarta Bramka Bezpieczeństwa 
2173	129	40	2026-10-05 16:50:43.71117	A129	Niskie ciśnienie pneumatyczne - strefa 1
2174	309	39	2026-10-05 16:50:43.71117	A309	Błąd Lini Niverplst - Easy Plast
2175	310	41	2026-10-05 16:50:43.71117	A310	Alarm Lini Niverplast - Transport System
2176	311	41	2026-10-05 16:50:43.71117	A311	Błąd Lini Niverplst - Transport System
2177	188	40	2026-10-05 16:50:43.71117	A188	Nieryglowany zamek bramki bezpieszeństwa
2178	309	39	2026-10-05 16:51:43.762182	A309	Błąd Lini Niverplst - Easy Plast
2179	310	41	2026-10-05 16:51:43.762182	A310	Alarm Lini Niverplast - Transport System
2180	311	41	2026-10-05 16:51:43.762182	A311	Błąd Lini Niverplst - Transport System
2181	309	39	2026-10-05 16:52:43.808553	A309	Błąd Lini Niverplst - Easy Plast
2182	310	41	2026-10-05 16:52:43.808553	A310	Alarm Lini Niverplast - Transport System
2183	311	41	2026-10-05 16:52:43.808553	A311	Błąd Lini Niverplst - Transport System
2184	309	39	2026-10-05 16:53:43.885046	A309	Błąd Lini Niverplst - Easy Plast
2185	310	41	2026-10-05 16:53:43.885046	A310	Alarm Lini Niverplast - Transport System
2186	311	41	2026-10-05 16:53:43.885046	A311	Błąd Lini Niverplst - Transport System
2187	309	39	2026-10-05 16:54:43.919583	A309	Błąd Lini Niverplst - Easy Plast
2188	310	41	2026-10-05 16:54:43.919583	A310	Alarm Lini Niverplast - Transport System
2189	311	41	2026-10-05 16:54:43.919583	A311	Błąd Lini Niverplst - Transport System
2190	309	39	2026-10-05 16:55:43.998865	A309	Błąd Lini Niverplst - Easy Plast
2191	310	41	2026-10-05 16:55:43.998865	A310	Alarm Lini Niverplast - Transport System
2192	311	41	2026-10-05 16:55:43.998865	A311	Błąd Lini Niverplst - Transport System
2193	309	39	2026-10-05 16:56:44.061763	A309	Błąd Lini Niverplst - Easy Plast
2194	310	41	2026-10-05 16:56:44.061763	A310	Alarm Lini Niverplast - Transport System
2195	311	41	2026-10-05 16:56:44.061763	A311	Błąd Lini Niverplst - Transport System
2196	309	39	2026-10-05 16:57:44.120777	A309	Błąd Lini Niverplst - Easy Plast
2197	310	41	2026-10-05 16:57:44.120777	A310	Alarm Lini Niverplast - Transport System
2198	311	41	2026-10-05 16:57:44.120777	A311	Błąd Lini Niverplst - Transport System
2199	309	39	2026-10-05 16:58:44.158971	A309	Błąd Lini Niverplst - Easy Plast
2200	310	41	2026-10-05 16:58:44.158971	A310	Alarm Lini Niverplast - Transport System
2201	311	41	2026-10-05 16:58:44.158971	A311	Błąd Lini Niverplst - Transport System
2202	309	39	2026-10-05 16:59:44.21342	A309	Błąd Lini Niverplst - Easy Plast
2203	310	41	2026-10-05 16:59:44.21342	A310	Alarm Lini Niverplast - Transport System
2204	311	41	2026-10-05 16:59:44.21342	A311	Błąd Lini Niverplst - Transport System
2205	309	39	2026-10-05 17:00:44.273992	A309	Błąd Lini Niverplst - Easy Plast
2206	310	41	2026-10-05 17:00:44.273992	A310	Alarm Lini Niverplast - Transport System
2207	311	41	2026-10-05 17:00:44.273992	A311	Błąd Lini Niverplst - Transport System
2208	309	39	2026-10-05 17:01:44.340826	A309	Błąd Lini Niverplst - Easy Plast
2209	310	41	2026-10-05 17:01:44.340826	A310	Alarm Lini Niverplast - Transport System
2210	311	41	2026-10-05 17:01:44.340826	A311	Błąd Lini Niverplst - Transport System
2211	309	39	2026-10-05 17:02:44.389884	A309	Błąd Lini Niverplst - Easy Plast
2212	310	41	2026-10-05 17:02:44.389884	A310	Alarm Lini Niverplast - Transport System
2213	311	41	2026-10-05 17:02:44.389884	A311	Błąd Lini Niverplst - Transport System
2214	309	39	2026-10-05 17:03:44.44502	A309	Błąd Lini Niverplst - Easy Plast
2215	310	41	2026-10-05 17:03:44.44502	A310	Alarm Lini Niverplast - Transport System
2216	311	41	2026-10-05 17:03:44.44502	A311	Błąd Lini Niverplst - Transport System
2217	309	39	2026-10-05 17:04:44.50893	A309	Błąd Lini Niverplst - Easy Plast
2218	310	41	2026-10-05 17:04:44.50893	A310	Alarm Lini Niverplast - Transport System
2219	311	41	2026-10-05 17:04:44.50893	A311	Błąd Lini Niverplst - Transport System
2220	309	39	2026-10-05 17:05:44.562872	A309	Błąd Lini Niverplst - Easy Plast
2221	310	41	2026-10-05 17:05:44.562872	A310	Alarm Lini Niverplast - Transport System
2222	311	41	2026-10-05 17:05:44.562872	A311	Błąd Lini Niverplst - Transport System
2223	309	39	2026-10-05 17:06:44.635694	A309	Błąd Lini Niverplst - Easy Plast
2224	310	41	2026-10-05 17:06:44.635694	A310	Alarm Lini Niverplast - Transport System
2225	311	41	2026-10-05 17:06:44.635694	A311	Błąd Lini Niverplst - Transport System
2226	309	39	2026-10-05 17:07:44.680697	A309	Błąd Lini Niverplst - Easy Plast
2227	310	41	2026-10-05 17:07:44.680697	A310	Alarm Lini Niverplast - Transport System
2228	311	41	2026-10-05 17:07:44.680697	A311	Błąd Lini Niverplst - Transport System
2229	309	39	2026-10-05 17:08:44.73404	A309	Błąd Lini Niverplst - Easy Plast
2230	310	41	2026-10-05 17:08:44.73404	A310	Alarm Lini Niverplast - Transport System
2231	311	41	2026-10-05 17:08:44.73404	A311	Błąd Lini Niverplst - Transport System
2232	309	39	2026-10-05 17:09:44.849031	A309	Błąd Lini Niverplst - Easy Plast
2233	310	41	2026-10-05 17:09:44.849031	A310	Alarm Lini Niverplast - Transport System
2234	311	41	2026-10-05 17:09:44.849031	A311	Błąd Lini Niverplst - Transport System
2235	309	39	2026-10-05 17:10:44.856825	A309	Błąd Lini Niverplst - Easy Plast
2236	310	41	2026-10-05 17:10:44.856825	A310	Alarm Lini Niverplast - Transport System
2237	311	41	2026-10-05 17:10:44.856825	A311	Błąd Lini Niverplst - Transport System
2238	309	39	2026-10-05 17:11:44.915112	A309	Błąd Lini Niverplst - Easy Plast
2239	310	41	2026-10-05 17:11:44.915112	A310	Alarm Lini Niverplast - Transport System
2240	311	41	2026-10-05 17:11:44.915112	A311	Błąd Lini Niverplst - Transport System
2241	309	39	2026-10-05 17:12:44.980194	A309	Błąd Lini Niverplst - Easy Plast
2242	310	41	2026-10-05 17:12:44.980194	A310	Alarm Lini Niverplast - Transport System
2243	311	41	2026-10-05 17:12:44.980194	A311	Błąd Lini Niverplst - Transport System
2244	309	39	2026-10-05 17:13:45.031835	A309	Błąd Lini Niverplst - Easy Plast
2245	310	41	2026-10-05 17:13:45.031835	A310	Alarm Lini Niverplast - Transport System
2246	311	41	2026-10-05 17:13:45.031835	A311	Błąd Lini Niverplst - Transport System
2247	309	39	2026-10-05 17:14:45.078162	A309	Błąd Lini Niverplst - Easy Plast
2248	310	41	2026-10-05 17:14:45.078162	A310	Alarm Lini Niverplast - Transport System
2249	311	41	2026-10-05 17:14:45.078162	A311	Błąd Lini Niverplst - Transport System
2250	309	39	2026-10-05 17:15:45.155929	A309	Błąd Lini Niverplst - Easy Plast
2251	310	41	2026-10-05 17:15:45.155929	A310	Alarm Lini Niverplast - Transport System
2252	311	41	2026-10-05 17:15:45.155929	A311	Błąd Lini Niverplst - Transport System
2253	309	39	2026-10-05 17:16:45.198443	A309	Błąd Lini Niverplst - Easy Plast
2254	310	41	2026-10-05 17:16:45.198443	A310	Alarm Lini Niverplast - Transport System
2255	311	41	2026-10-05 17:16:45.198443	A311	Błąd Lini Niverplst - Transport System
2256	309	39	2026-10-05 17:17:45.263815	A309	Błąd Lini Niverplst - Easy Plast
2257	310	41	2026-10-05 17:17:45.263815	A310	Alarm Lini Niverplast - Transport System
2258	311	41	2026-10-05 17:17:45.263815	A311	Błąd Lini Niverplst - Transport System
2259	309	39	2026-10-05 17:18:45.318971	A309	Błąd Lini Niverplst - Easy Plast
2260	310	41	2026-10-05 17:18:45.318971	A310	Alarm Lini Niverplast - Transport System
2261	311	41	2026-10-05 17:18:45.318971	A311	Błąd Lini Niverplst - Transport System
2262	309	39	2026-10-05 17:19:45.368638	A309	Błąd Lini Niverplst - Easy Plast
2263	310	41	2026-10-05 17:19:45.368638	A310	Alarm Lini Niverplast - Transport System
2264	311	41	2026-10-05 17:19:45.368638	A311	Błąd Lini Niverplst - Transport System
2265	309	39	2026-10-05 17:20:45.43785	A309	Błąd Lini Niverplst - Easy Plast
2266	310	41	2026-10-05 17:20:45.43785	A310	Alarm Lini Niverplast - Transport System
2267	311	41	2026-10-05 17:20:45.43785	A311	Błąd Lini Niverplst - Transport System
2268	309	39	2026-10-05 17:21:45.491602	A309	Błąd Lini Niverplst - Easy Plast
2269	310	41	2026-10-05 17:21:45.491602	A310	Alarm Lini Niverplast - Transport System
2270	311	41	2026-10-05 17:21:45.491602	A311	Błąd Lini Niverplst - Transport System
2271	309	39	2026-10-05 17:22:45.540401	A309	Błąd Lini Niverplst - Easy Plast
2272	310	41	2026-10-05 17:22:45.540401	A310	Alarm Lini Niverplast - Transport System
2273	311	41	2026-10-05 17:22:45.540401	A311	Błąd Lini Niverplst - Transport System
2274	309	39	2026-10-05 17:23:45.612537	A309	Błąd Lini Niverplst - Easy Plast
2275	310	41	2026-10-05 17:23:45.612537	A310	Alarm Lini Niverplast - Transport System
2276	311	41	2026-10-05 17:23:45.612537	A311	Błąd Lini Niverplst - Transport System
2277	309	39	2026-10-05 17:24:45.670724	A309	Błąd Lini Niverplst - Easy Plast
2278	310	41	2026-10-05 17:24:45.670724	A310	Alarm Lini Niverplast - Transport System
2279	311	41	2026-10-05 17:24:45.670724	A311	Błąd Lini Niverplst - Transport System
2280	309	39	2026-10-05 17:25:45.723915	A309	Błąd Lini Niverplst - Easy Plast
2281	310	41	2026-10-05 17:25:45.723915	A310	Alarm Lini Niverplast - Transport System
2282	311	41	2026-10-05 17:25:45.723915	A311	Błąd Lini Niverplst - Transport System
2283	309	39	2026-10-05 17:26:45.770699	A309	Błąd Lini Niverplst - Easy Plast
2284	310	41	2026-10-05 17:26:45.770699	A310	Alarm Lini Niverplast - Transport System
2285	311	41	2026-10-05 17:26:45.770699	A311	Błąd Lini Niverplst - Transport System
2286	309	39	2026-10-05 17:27:45.825941	A309	Błąd Lini Niverplst - Easy Plast
2287	310	41	2026-10-05 17:27:45.825941	A310	Alarm Lini Niverplast - Transport System
2288	311	41	2026-10-05 17:27:45.825941	A311	Błąd Lini Niverplst - Transport System
2289	309	39	2026-10-05 17:28:45.883792	A309	Błąd Lini Niverplst - Easy Plast
2290	310	41	2026-10-05 17:28:45.883792	A310	Alarm Lini Niverplast - Transport System
2291	311	41	2026-10-05 17:28:45.883792	A311	Błąd Lini Niverplst - Transport System
2292	309	39	2026-10-05 17:29:45.951111	A309	Błąd Lini Niverplst - Easy Plast
2293	310	41	2026-10-05 17:29:45.951111	A310	Alarm Lini Niverplast - Transport System
2294	311	41	2026-10-05 17:29:45.951111	A311	Błąd Lini Niverplst - Transport System
2295	309	39	2026-10-05 17:30:46.007737	A309	Błąd Lini Niverplst - Easy Plast
2296	310	41	2026-10-05 17:30:46.007737	A310	Alarm Lini Niverplast - Transport System
2297	311	41	2026-10-05 17:30:46.007737	A311	Błąd Lini Niverplst - Transport System
2298	309	39	2026-10-05 17:31:46.050314	A309	Błąd Lini Niverplst - Easy Plast
2299	310	41	2026-10-05 17:31:46.050314	A310	Alarm Lini Niverplast - Transport System
2300	311	41	2026-10-05 17:31:46.050314	A311	Błąd Lini Niverplst - Transport System
2301	309	39	2026-10-05 17:32:46.128166	A309	Błąd Lini Niverplst - Easy Plast
2302	310	41	2026-10-05 17:32:46.128166	A310	Alarm Lini Niverplast - Transport System
2303	311	41	2026-10-05 17:32:46.128166	A311	Błąd Lini Niverplst - Transport System
2304	309	39	2026-10-05 17:33:46.164078	A309	Błąd Lini Niverplst - Easy Plast
2305	310	41	2026-10-05 17:33:46.164078	A310	Alarm Lini Niverplast - Transport System
2306	311	41	2026-10-05 17:33:46.164078	A311	Błąd Lini Niverplst - Transport System
2307	309	39	2026-10-05 17:34:46.224941	A309	Błąd Lini Niverplst - Easy Plast
2308	310	41	2026-10-05 17:34:46.224941	A310	Alarm Lini Niverplast - Transport System
2309	311	41	2026-10-05 17:34:46.224941	A311	Błąd Lini Niverplst - Transport System
2310	309	39	2026-10-05 17:35:46.293246	A309	Błąd Lini Niverplst - Easy Plast
2311	310	41	2026-10-05 17:35:46.293246	A310	Alarm Lini Niverplast - Transport System
2312	311	41	2026-10-05 17:35:46.293246	A311	Błąd Lini Niverplst - Transport System
2313	309	39	2026-10-05 17:36:46.343807	A309	Błąd Lini Niverplst - Easy Plast
2314	310	41	2026-10-05 17:36:46.343807	A310	Alarm Lini Niverplast - Transport System
2315	311	41	2026-10-05 17:36:46.343807	A311	Błąd Lini Niverplst - Transport System
2316	309	39	2026-10-05 17:37:46.387914	A309	Błąd Lini Niverplst - Easy Plast
2317	310	41	2026-10-05 17:37:46.387914	A310	Alarm Lini Niverplast - Transport System
2318	311	41	2026-10-05 17:37:46.387914	A311	Błąd Lini Niverplst - Transport System
2319	309	39	2026-10-05 17:38:46.453682	A309	Błąd Lini Niverplst - Easy Plast
2320	310	41	2026-10-05 17:38:46.453682	A310	Alarm Lini Niverplast - Transport System
2321	311	41	2026-10-05 17:38:46.453682	A311	Błąd Lini Niverplst - Transport System
2322	309	39	2026-10-05 17:39:46.515334	A309	Błąd Lini Niverplst - Easy Plast
2323	310	41	2026-10-05 17:39:46.515334	A310	Alarm Lini Niverplast - Transport System
2324	311	41	2026-10-05 17:39:46.515334	A311	Błąd Lini Niverplst - Transport System
2325	309	39	2026-10-05 17:40:46.565458	A309	Błąd Lini Niverplst - Easy Plast
2326	310	41	2026-10-05 17:40:46.565458	A310	Alarm Lini Niverplast - Transport System
2327	311	41	2026-10-05 17:40:46.565458	A311	Błąd Lini Niverplst - Transport System
2328	309	39	2026-10-05 17:41:46.630451	A309	Błąd Lini Niverplst - Easy Plast
2329	310	41	2026-10-05 17:41:46.630451	A310	Alarm Lini Niverplast - Transport System
2330	311	41	2026-10-05 17:41:46.630451	A311	Błąd Lini Niverplst - Transport System
2331	309	39	2026-10-05 17:42:46.686958	A309	Błąd Lini Niverplst - Easy Plast
2332	310	41	2026-10-05 17:42:46.686958	A310	Alarm Lini Niverplast - Transport System
2333	311	41	2026-10-05 17:42:46.686958	A311	Błąd Lini Niverplst - Transport System
2334	309	39	2026-10-05 17:43:46.733773	A309	Błąd Lini Niverplst - Easy Plast
2335	310	41	2026-10-05 17:43:46.733773	A310	Alarm Lini Niverplast - Transport System
2336	311	41	2026-10-05 17:43:46.733773	A311	Błąd Lini Niverplst - Transport System
2337	309	39	2026-10-05 17:44:46.806747	A309	Błąd Lini Niverplst - Easy Plast
2338	310	41	2026-10-05 17:44:46.806747	A310	Alarm Lini Niverplast - Transport System
2339	311	41	2026-10-05 17:44:46.806747	A311	Błąd Lini Niverplst - Transport System
2340	309	39	2026-10-05 17:45:46.857802	A309	Błąd Lini Niverplst - Easy Plast
2341	310	41	2026-10-05 17:45:46.857802	A310	Alarm Lini Niverplast - Transport System
2342	311	41	2026-10-05 17:45:46.857802	A311	Błąd Lini Niverplst - Transport System
2343	309	39	2026-10-05 17:46:46.903459	A309	Błąd Lini Niverplst - Easy Plast
2344	310	41	2026-10-05 17:46:46.903459	A310	Alarm Lini Niverplast - Transport System
2345	311	41	2026-10-05 17:46:46.903459	A311	Błąd Lini Niverplst - Transport System
2346	309	39	2026-10-05 17:47:46.966796	A309	Błąd Lini Niverplst - Easy Plast
2347	310	41	2026-10-05 17:47:46.966796	A310	Alarm Lini Niverplast - Transport System
2348	311	41	2026-10-05 17:47:46.966796	A311	Błąd Lini Niverplst - Transport System
2349	309	39	2026-10-05 17:48:47.021998	A309	Błąd Lini Niverplst - Easy Plast
2350	310	41	2026-10-05 17:48:47.021998	A310	Alarm Lini Niverplast - Transport System
2351	311	41	2026-10-05 17:48:47.021998	A311	Błąd Lini Niverplst - Transport System
2352	309	39	2026-10-05 17:49:47.07862	A309	Błąd Lini Niverplst - Easy Plast
2353	310	41	2026-10-05 17:49:47.07862	A310	Alarm Lini Niverplast - Transport System
2354	311	41	2026-10-05 17:49:47.07862	A311	Błąd Lini Niverplst - Transport System
2355	309	39	2026-10-05 17:50:47.136151	A309	Błąd Lini Niverplst - Easy Plast
2356	310	41	2026-10-05 17:50:47.136151	A310	Alarm Lini Niverplast - Transport System
2357	311	41	2026-10-05 17:50:47.136151	A311	Błąd Lini Niverplst - Transport System
2358	309	39	2026-10-05 17:51:47.192044	A309	Błąd Lini Niverplst - Easy Plast
2359	310	41	2026-10-05 17:51:47.192044	A310	Alarm Lini Niverplast - Transport System
2360	311	41	2026-10-05 17:51:47.192044	A311	Błąd Lini Niverplst - Transport System
2361	309	39	2026-10-05 17:52:47.254755	A309	Błąd Lini Niverplst - Easy Plast
2362	310	41	2026-10-05 17:52:47.254755	A310	Alarm Lini Niverplast - Transport System
2363	311	41	2026-10-05 17:52:47.254755	A311	Błąd Lini Niverplst - Transport System
2364	309	39	2026-10-05 17:53:47.307866	A309	Błąd Lini Niverplst - Easy Plast
2365	310	41	2026-10-05 17:53:47.307866	A310	Alarm Lini Niverplast - Transport System
2366	311	41	2026-10-05 17:53:47.307866	A311	Błąd Lini Niverplst - Transport System
2367	309	39	2026-10-05 17:54:47.372787	A309	Błąd Lini Niverplst - Easy Plast
2368	310	41	2026-10-05 17:54:47.372787	A310	Alarm Lini Niverplast - Transport System
2369	311	41	2026-10-05 17:54:47.372787	A311	Błąd Lini Niverplst - Transport System
2370	309	39	2026-10-05 17:55:47.41736	A309	Błąd Lini Niverplst - Easy Plast
2371	310	41	2026-10-05 17:55:47.41736	A310	Alarm Lini Niverplast - Transport System
2372	311	41	2026-10-05 17:55:47.41736	A311	Błąd Lini Niverplst - Transport System
2373	309	39	2026-10-05 17:56:47.476897	A309	Błąd Lini Niverplst - Easy Plast
2374	310	41	2026-10-05 17:56:47.476897	A310	Alarm Lini Niverplast - Transport System
2375	311	41	2026-10-05 17:56:47.476897	A311	Błąd Lini Niverplst - Transport System
2376	309	39	2026-10-05 17:57:47.550673	A309	Błąd Lini Niverplst - Easy Plast
2377	310	41	2026-10-05 17:57:47.550673	A310	Alarm Lini Niverplast - Transport System
2378	311	41	2026-10-05 17:57:47.550673	A311	Błąd Lini Niverplst - Transport System
2379	309	39	2026-10-05 17:58:47.595602	A309	Błąd Lini Niverplst - Easy Plast
2380	310	41	2026-10-05 17:58:47.595602	A310	Alarm Lini Niverplast - Transport System
2381	311	41	2026-10-05 17:58:47.595602	A311	Błąd Lini Niverplst - Transport System
2382	309	39	2026-10-05 17:59:47.651117	A309	Błąd Lini Niverplst - Easy Plast
2383	310	41	2026-10-05 17:59:47.651117	A310	Alarm Lini Niverplast - Transport System
2384	311	41	2026-10-05 17:59:47.651117	A311	Błąd Lini Niverplst - Transport System
2385	309	39	2026-10-05 18:00:47.706352	A309	Błąd Lini Niverplst - Easy Plast
2386	310	41	2026-10-05 18:00:47.706352	A310	Alarm Lini Niverplast - Transport System
2387	311	41	2026-10-05 18:00:47.706352	A311	Błąd Lini Niverplst - Transport System
2388	309	39	2026-10-05 18:01:47.760839	A309	Błąd Lini Niverplst - Easy Plast
2389	310	41	2026-10-05 18:01:47.760839	A310	Alarm Lini Niverplast - Transport System
2390	311	41	2026-10-05 18:01:47.760839	A311	Błąd Lini Niverplst - Transport System
2391	309	39	2026-10-05 18:02:47.819907	A309	Błąd Lini Niverplst - Easy Plast
2392	310	41	2026-10-05 18:02:47.819907	A310	Alarm Lini Niverplast - Transport System
2393	311	41	2026-10-05 18:02:47.819907	A311	Błąd Lini Niverplst - Transport System
2394	309	39	2026-10-05 18:03:47.875168	A309	Błąd Lini Niverplst - Easy Plast
2395	310	41	2026-10-05 18:03:47.875168	A310	Alarm Lini Niverplast - Transport System
2396	311	41	2026-10-05 18:03:47.875168	A311	Błąd Lini Niverplst - Transport System
2397	309	39	2026-10-05 18:04:47.938379	A309	Błąd Lini Niverplst - Easy Plast
2398	310	41	2026-10-05 18:04:47.938379	A310	Alarm Lini Niverplast - Transport System
2399	311	41	2026-10-05 18:04:47.938379	A311	Błąd Lini Niverplst - Transport System
2400	309	39	2026-10-05 18:05:47.990276	A309	Błąd Lini Niverplst - Easy Plast
2401	310	41	2026-10-05 18:05:47.990276	A310	Alarm Lini Niverplast - Transport System
2402	311	41	2026-10-05 18:05:47.990276	A311	Błąd Lini Niverplst - Transport System
2403	309	39	2026-10-05 18:06:48.050125	A309	Błąd Lini Niverplst - Easy Plast
2404	310	41	2026-10-05 18:06:48.050125	A310	Alarm Lini Niverplast - Transport System
2405	311	41	2026-10-05 18:06:48.050125	A311	Błąd Lini Niverplst - Transport System
2406	309	39	2026-10-05 18:07:48.105383	A309	Błąd Lini Niverplst - Easy Plast
2407	310	41	2026-10-05 18:07:48.105383	A310	Alarm Lini Niverplast - Transport System
2408	311	41	2026-10-05 18:07:48.105383	A311	Błąd Lini Niverplst - Transport System
2409	309	39	2026-10-05 18:08:48.167877	A309	Błąd Lini Niverplst - Easy Plast
2410	310	41	2026-10-05 18:08:48.167877	A310	Alarm Lini Niverplast - Transport System
2411	311	41	2026-10-05 18:08:48.167877	A311	Błąd Lini Niverplst - Transport System
2412	309	39	2026-10-05 18:09:48.222369	A309	Błąd Lini Niverplst - Easy Plast
2413	310	41	2026-10-05 18:09:48.222369	A310	Alarm Lini Niverplast - Transport System
2414	311	41	2026-10-05 18:09:48.222369	A311	Błąd Lini Niverplst - Transport System
2415	309	39	2026-10-05 18:10:48.2992	A309	Błąd Lini Niverplst - Easy Plast
2416	310	41	2026-10-05 18:10:48.2992	A310	Alarm Lini Niverplast - Transport System
2417	311	41	2026-10-05 18:10:48.2992	A311	Błąd Lini Niverplst - Transport System
2418	309	39	2026-10-05 18:11:48.355742	A309	Błąd Lini Niverplst - Easy Plast
2419	310	41	2026-10-05 18:11:48.355742	A310	Alarm Lini Niverplast - Transport System
2420	311	41	2026-10-05 18:11:48.355742	A311	Błąd Lini Niverplst - Transport System
2421	309	39	2026-10-05 18:12:48.395705	A309	Błąd Lini Niverplst - Easy Plast
2422	310	41	2026-10-05 18:12:48.395705	A310	Alarm Lini Niverplast - Transport System
2423	311	41	2026-10-05 18:12:48.395705	A311	Błąd Lini Niverplst - Transport System
2424	309	39	2026-10-05 18:13:48.455024	A309	Błąd Lini Niverplst - Easy Plast
2425	310	41	2026-10-05 18:13:48.455024	A310	Alarm Lini Niverplast - Transport System
2426	311	41	2026-10-05 18:13:48.455024	A311	Błąd Lini Niverplst - Transport System
2427	309	39	2026-10-05 18:14:48.512185	A309	Błąd Lini Niverplst - Easy Plast
2428	310	41	2026-10-05 18:14:48.512185	A310	Alarm Lini Niverplast - Transport System
2429	311	41	2026-10-05 18:14:48.512185	A311	Błąd Lini Niverplst - Transport System
2430	309	39	2026-10-05 18:15:48.578969	A309	Błąd Lini Niverplst - Easy Plast
2431	310	41	2026-10-05 18:15:48.578969	A310	Alarm Lini Niverplast - Transport System
2432	311	41	2026-10-05 18:15:48.578969	A311	Błąd Lini Niverplst - Transport System
2433	309	39	2026-10-05 18:16:48.652699	A309	Błąd Lini Niverplst - Easy Plast
2434	310	41	2026-10-05 18:16:48.652699	A310	Alarm Lini Niverplast - Transport System
2435	311	41	2026-10-05 18:16:48.652699	A311	Błąd Lini Niverplst - Transport System
2436	309	39	2026-10-05 18:17:48.685968	A309	Błąd Lini Niverplst - Easy Plast
2437	310	41	2026-10-05 18:17:48.685968	A310	Alarm Lini Niverplast - Transport System
2438	311	41	2026-10-05 18:17:48.685968	A311	Błąd Lini Niverplst - Transport System
2439	309	39	2026-10-05 18:18:48.757943	A309	Błąd Lini Niverplst - Easy Plast
2440	310	41	2026-10-05 18:18:48.757943	A310	Alarm Lini Niverplast - Transport System
2441	311	41	2026-10-05 18:18:48.757943	A311	Błąd Lini Niverplst - Transport System
2442	309	39	2026-10-05 18:19:48.809838	A309	Błąd Lini Niverplst - Easy Plast
2443	310	41	2026-10-05 18:19:48.809838	A310	Alarm Lini Niverplast - Transport System
2444	311	41	2026-10-05 18:19:48.809838	A311	Błąd Lini Niverplst - Transport System
2445	309	39	2026-10-05 18:20:48.861155	A309	Błąd Lini Niverplst - Easy Plast
2446	310	41	2026-10-05 18:20:48.861155	A310	Alarm Lini Niverplast - Transport System
2447	311	41	2026-10-05 18:20:48.861155	A311	Błąd Lini Niverplst - Transport System
2448	309	39	2026-10-05 18:21:48.922807	A309	Błąd Lini Niverplst - Easy Plast
2449	310	41	2026-10-05 18:21:48.922807	A310	Alarm Lini Niverplast - Transport System
2450	311	41	2026-10-05 18:21:48.922807	A311	Błąd Lini Niverplst - Transport System
2451	309	39	2026-10-05 18:22:48.97728	A309	Błąd Lini Niverplst - Easy Plast
2452	310	41	2026-10-05 18:22:48.97728	A310	Alarm Lini Niverplast - Transport System
2453	311	41	2026-10-05 18:22:48.97728	A311	Błąd Lini Niverplst - Transport System
2454	309	39	2026-10-05 18:23:49.03849	A309	Błąd Lini Niverplst - Easy Plast
2455	310	41	2026-10-05 18:23:49.03849	A310	Alarm Lini Niverplast - Transport System
2456	311	41	2026-10-05 18:23:49.03849	A311	Błąd Lini Niverplst - Transport System
2457	309	39	2026-10-05 18:24:49.09938	A309	Błąd Lini Niverplst - Easy Plast
2458	310	41	2026-10-05 18:24:49.09938	A310	Alarm Lini Niverplast - Transport System
2459	311	41	2026-10-05 18:24:49.09938	A311	Błąd Lini Niverplst - Transport System
2460	309	39	2026-10-05 18:25:49.15349	A309	Błąd Lini Niverplst - Easy Plast
2461	310	41	2026-10-05 18:25:49.15349	A310	Alarm Lini Niverplast - Transport System
2462	311	41	2026-10-05 18:25:49.15349	A311	Błąd Lini Niverplst - Transport System
2463	309	39	2026-10-05 18:26:49.218522	A309	Błąd Lini Niverplst - Easy Plast
2464	310	41	2026-10-05 18:26:49.218522	A310	Alarm Lini Niverplast - Transport System
2465	311	41	2026-10-05 18:26:49.218522	A311	Błąd Lini Niverplst - Transport System
2466	309	39	2026-10-05 18:27:49.282476	A309	Błąd Lini Niverplst - Easy Plast
2467	310	41	2026-10-05 18:27:49.282476	A310	Alarm Lini Niverplast - Transport System
2468	311	41	2026-10-05 18:27:49.282476	A311	Błąd Lini Niverplst - Transport System
2469	309	39	2026-10-05 18:28:49.340655	A309	Błąd Lini Niverplst - Easy Plast
2470	310	41	2026-10-05 18:28:49.340655	A310	Alarm Lini Niverplast - Transport System
2471	311	41	2026-10-05 18:28:49.340655	A311	Błąd Lini Niverplst - Transport System
2472	309	39	2026-10-05 18:29:49.374307	A309	Błąd Lini Niverplst - Easy Plast
2473	310	41	2026-10-05 18:29:49.374307	A310	Alarm Lini Niverplast - Transport System
2474	311	41	2026-10-05 18:29:49.374307	A311	Błąd Lini Niverplst - Transport System
2475	309	39	2026-10-05 18:30:49.454275	A309	Błąd Lini Niverplst - Easy Plast
2476	310	41	2026-10-05 18:30:49.454275	A310	Alarm Lini Niverplast - Transport System
2477	311	41	2026-10-05 18:30:49.454275	A311	Błąd Lini Niverplst - Transport System
2478	309	39	2026-10-05 18:31:49.505659	A309	Błąd Lini Niverplst - Easy Plast
2479	310	41	2026-10-05 18:31:49.505659	A310	Alarm Lini Niverplast - Transport System
2480	311	41	2026-10-05 18:31:49.505659	A311	Błąd Lini Niverplst - Transport System
2481	309	39	2026-10-05 18:32:49.556239	A309	Błąd Lini Niverplst - Easy Plast
2482	310	41	2026-10-05 18:32:49.556239	A310	Alarm Lini Niverplast - Transport System
2483	311	41	2026-10-05 18:32:49.556239	A311	Błąd Lini Niverplst - Transport System
2484	309	39	2026-10-05 18:33:49.607535	A309	Błąd Lini Niverplst - Easy Plast
2485	310	41	2026-10-05 18:33:49.607535	A310	Alarm Lini Niverplast - Transport System
2486	311	41	2026-10-05 18:33:49.607535	A311	Błąd Lini Niverplst - Transport System
2487	309	39	2026-10-05 18:34:49.670438	A309	Błąd Lini Niverplst - Easy Plast
2488	310	41	2026-10-05 18:34:49.670438	A310	Alarm Lini Niverplast - Transport System
2489	311	41	2026-10-05 18:34:49.670438	A311	Błąd Lini Niverplst - Transport System
2490	309	39	2026-10-05 18:35:49.724846	A309	Błąd Lini Niverplst - Easy Plast
2491	310	41	2026-10-05 18:35:49.724846	A310	Alarm Lini Niverplast - Transport System
2492	311	41	2026-10-05 18:35:49.724846	A311	Błąd Lini Niverplst - Transport System
2493	309	39	2026-10-05 18:36:49.796614	A309	Błąd Lini Niverplst - Easy Plast
2494	310	41	2026-10-05 18:36:49.796614	A310	Alarm Lini Niverplast - Transport System
2495	311	41	2026-10-05 18:36:49.796614	A311	Błąd Lini Niverplst - Transport System
2496	309	39	2026-10-05 18:37:49.850993	A309	Błąd Lini Niverplst - Easy Plast
2497	310	41	2026-10-05 18:37:49.850993	A310	Alarm Lini Niverplast - Transport System
2498	311	41	2026-10-05 18:37:49.850993	A311	Błąd Lini Niverplst - Transport System
2499	309	39	2026-10-05 18:38:49.895181	A309	Błąd Lini Niverplst - Easy Plast
2500	310	41	2026-10-05 18:38:49.895181	A310	Alarm Lini Niverplast - Transport System
2501	311	41	2026-10-05 18:38:49.895181	A311	Błąd Lini Niverplst - Transport System
2502	309	39	2026-10-05 18:39:49.967096	A309	Błąd Lini Niverplst - Easy Plast
2503	310	41	2026-10-05 18:39:49.967096	A310	Alarm Lini Niverplast - Transport System
2504	311	41	2026-10-05 18:39:49.967096	A311	Błąd Lini Niverplst - Transport System
2505	309	39	2026-10-05 18:40:50.025266	A309	Błąd Lini Niverplst - Easy Plast
2506	310	41	2026-10-05 18:40:50.025266	A310	Alarm Lini Niverplast - Transport System
2507	311	41	2026-10-05 18:40:50.025266	A311	Błąd Lini Niverplst - Transport System
2508	309	39	2026-10-05 18:41:50.080343	A309	Błąd Lini Niverplst - Easy Plast
2509	310	41	2026-10-05 18:41:50.080343	A310	Alarm Lini Niverplast - Transport System
2510	311	41	2026-10-05 18:41:50.080343	A311	Błąd Lini Niverplst - Transport System
2511	309	39	2026-10-05 18:42:50.120886	A309	Błąd Lini Niverplst - Easy Plast
2512	310	41	2026-10-05 18:42:50.120886	A310	Alarm Lini Niverplast - Transport System
2513	311	41	2026-10-05 18:42:50.120886	A311	Błąd Lini Niverplst - Transport System
2514	309	39	2026-10-05 18:43:50.196798	A309	Błąd Lini Niverplst - Easy Plast
2515	310	41	2026-10-05 18:43:50.196798	A310	Alarm Lini Niverplast - Transport System
2516	311	41	2026-10-05 18:43:50.196798	A311	Błąd Lini Niverplst - Transport System
2517	309	39	2026-10-05 18:44:50.244481	A309	Błąd Lini Niverplst - Easy Plast
2518	310	41	2026-10-05 18:44:50.244481	A310	Alarm Lini Niverplast - Transport System
2519	311	41	2026-10-05 18:44:50.244481	A311	Błąd Lini Niverplst - Transport System
2520	309	39	2026-10-05 18:45:50.330428	A309	Błąd Lini Niverplst - Easy Plast
2521	310	41	2026-10-05 18:45:50.330428	A310	Alarm Lini Niverplast - Transport System
2522	311	41	2026-10-05 18:45:50.330428	A311	Błąd Lini Niverplst - Transport System
2523	309	39	2026-10-05 18:46:50.38515	A309	Błąd Lini Niverplst - Easy Plast
2524	310	41	2026-10-05 18:46:50.38515	A310	Alarm Lini Niverplast - Transport System
2525	311	41	2026-10-05 18:46:50.38515	A311	Błąd Lini Niverplst - Transport System
2526	309	39	2026-10-05 18:47:50.435232	A309	Błąd Lini Niverplst - Easy Plast
2527	310	41	2026-10-05 18:47:50.435232	A310	Alarm Lini Niverplast - Transport System
2528	311	41	2026-10-05 18:47:50.435232	A311	Błąd Lini Niverplst - Transport System
2529	309	39	2026-10-05 18:48:50.487252	A309	Błąd Lini Niverplst - Easy Plast
2530	310	41	2026-10-05 18:48:50.487252	A310	Alarm Lini Niverplast - Transport System
2531	311	41	2026-10-05 18:48:50.487252	A311	Błąd Lini Niverplst - Transport System
2532	309	39	2026-10-05 18:49:50.550959	A309	Błąd Lini Niverplst - Easy Plast
2533	310	41	2026-10-05 18:49:50.550959	A310	Alarm Lini Niverplast - Transport System
2534	311	41	2026-10-05 18:49:50.550959	A311	Błąd Lini Niverplst - Transport System
2535	309	39	2026-10-05 18:50:50.592661	A309	Błąd Lini Niverplst - Easy Plast
2536	310	41	2026-10-05 18:50:50.592661	A310	Alarm Lini Niverplast - Transport System
2537	311	41	2026-10-05 18:50:50.592661	A311	Błąd Lini Niverplst - Transport System
2538	309	39	2026-10-05 18:51:50.653002	A309	Błąd Lini Niverplst - Easy Plast
2539	310	41	2026-10-05 18:51:50.653002	A310	Alarm Lini Niverplast - Transport System
2540	311	41	2026-10-05 18:51:50.653002	A311	Błąd Lini Niverplst - Transport System
2541	309	39	2026-10-05 18:52:50.721283	A309	Błąd Lini Niverplst - Easy Plast
2542	310	41	2026-10-05 18:52:50.721283	A310	Alarm Lini Niverplast - Transport System
2543	311	41	2026-10-05 18:52:50.721283	A311	Błąd Lini Niverplst - Transport System
2544	309	39	2026-10-05 18:53:50.783963	A309	Błąd Lini Niverplst - Easy Plast
2545	310	41	2026-10-05 18:53:50.783963	A310	Alarm Lini Niverplast - Transport System
2546	311	41	2026-10-05 18:53:50.783963	A311	Błąd Lini Niverplst - Transport System
2547	309	39	2026-10-05 18:54:50.834742	A309	Błąd Lini Niverplst - Easy Plast
2548	310	41	2026-10-05 18:54:50.834742	A310	Alarm Lini Niverplast - Transport System
2549	311	41	2026-10-05 18:54:50.834742	A311	Błąd Lini Niverplst - Transport System
2550	309	39	2026-10-05 18:55:50.907148	A309	Błąd Lini Niverplst - Easy Plast
2551	310	41	2026-10-05 18:55:50.907148	A310	Alarm Lini Niverplast - Transport System
2552	311	41	2026-10-05 18:55:50.907148	A311	Błąd Lini Niverplst - Transport System
2553	309	39	2026-10-05 18:56:50.947767	A309	Błąd Lini Niverplst - Easy Plast
2554	310	41	2026-10-05 18:56:50.947767	A310	Alarm Lini Niverplast - Transport System
2555	311	41	2026-10-05 18:56:50.947767	A311	Błąd Lini Niverplst - Transport System
2556	309	39	2026-10-05 18:57:51.013785	A309	Błąd Lini Niverplst - Easy Plast
2557	310	41	2026-10-05 18:57:51.013785	A310	Alarm Lini Niverplast - Transport System
2558	311	41	2026-10-05 18:57:51.013785	A311	Błąd Lini Niverplst - Transport System
2559	309	39	2026-10-05 18:58:51.064168	A309	Błąd Lini Niverplst - Easy Plast
2560	310	41	2026-10-05 18:58:51.064168	A310	Alarm Lini Niverplast - Transport System
2561	311	41	2026-10-05 18:58:51.064168	A311	Błąd Lini Niverplst - Transport System
2562	309	39	2026-10-05 18:59:51.125194	A309	Błąd Lini Niverplst - Easy Plast
2563	310	41	2026-10-05 18:59:51.125194	A310	Alarm Lini Niverplast - Transport System
2564	311	41	2026-10-05 18:59:51.125194	A311	Błąd Lini Niverplst - Transport System
2565	309	39	2026-10-05 19:00:51.190482	A309	Błąd Lini Niverplst - Easy Plast
2566	310	41	2026-10-05 19:00:51.190482	A310	Alarm Lini Niverplast - Transport System
2567	311	41	2026-10-05 19:00:51.190482	A311	Błąd Lini Niverplst - Transport System
2568	309	39	2026-10-05 19:01:51.256027	A309	Błąd Lini Niverplst - Easy Plast
2569	310	41	2026-10-05 19:01:51.256027	A310	Alarm Lini Niverplast - Transport System
2570	311	41	2026-10-05 19:01:51.256027	A311	Błąd Lini Niverplst - Transport System
2571	309	39	2026-10-05 19:02:51.307899	A309	Błąd Lini Niverplst - Easy Plast
2572	310	41	2026-10-05 19:02:51.307899	A310	Alarm Lini Niverplast - Transport System
2573	311	41	2026-10-05 19:02:51.307899	A311	Błąd Lini Niverplst - Transport System
2574	309	39	2026-10-05 19:03:51.364859	A309	Błąd Lini Niverplst - Easy Plast
2575	310	41	2026-10-05 19:03:51.364859	A310	Alarm Lini Niverplast - Transport System
2576	311	41	2026-10-05 19:03:51.364859	A311	Błąd Lini Niverplst - Transport System
2577	309	39	2026-10-05 19:04:51.411644	A309	Błąd Lini Niverplst - Easy Plast
2578	310	41	2026-10-05 19:04:51.411644	A310	Alarm Lini Niverplast - Transport System
2579	311	41	2026-10-05 19:04:51.411644	A311	Błąd Lini Niverplst - Transport System
2580	309	39	2026-10-05 19:05:51.466484	A309	Błąd Lini Niverplst - Easy Plast
2581	310	41	2026-10-05 19:05:51.466484	A310	Alarm Lini Niverplast - Transport System
2582	311	41	2026-10-05 19:05:51.466484	A311	Błąd Lini Niverplst - Transport System
2583	309	39	2026-10-05 19:06:51.530571	A309	Błąd Lini Niverplst - Easy Plast
2584	310	41	2026-10-05 19:06:51.530571	A310	Alarm Lini Niverplast - Transport System
2585	311	41	2026-10-05 19:06:51.530571	A311	Błąd Lini Niverplst - Transport System
2586	309	39	2026-10-05 19:07:51.5886	A309	Błąd Lini Niverplst - Easy Plast
2587	310	41	2026-10-05 19:07:51.5886	A310	Alarm Lini Niverplast - Transport System
2588	311	41	2026-10-05 19:07:51.5886	A311	Błąd Lini Niverplst - Transport System
2589	309	39	2026-10-05 19:08:51.653308	A309	Błąd Lini Niverplst - Easy Plast
2590	310	41	2026-10-05 19:08:51.653308	A310	Alarm Lini Niverplast - Transport System
2591	311	41	2026-10-05 19:08:51.653308	A311	Błąd Lini Niverplst - Transport System
2592	309	39	2026-10-05 19:09:51.6988	A309	Błąd Lini Niverplst - Easy Plast
2593	310	41	2026-10-05 19:09:51.6988	A310	Alarm Lini Niverplast - Transport System
2594	311	41	2026-10-05 19:09:51.6988	A311	Błąd Lini Niverplst - Transport System
2595	309	39	2026-10-05 19:10:51.774141	A309	Błąd Lini Niverplst - Easy Plast
2596	310	41	2026-10-05 19:10:51.774141	A310	Alarm Lini Niverplast - Transport System
2597	311	41	2026-10-05 19:10:51.774141	A311	Błąd Lini Niverplst - Transport System
2598	309	39	2026-10-05 19:11:51.818093	A309	Błąd Lini Niverplst - Easy Plast
2599	310	41	2026-10-05 19:11:51.818093	A310	Alarm Lini Niverplast - Transport System
2600	311	41	2026-10-05 19:11:51.818093	A311	Błąd Lini Niverplst - Transport System
2601	309	39	2026-10-05 19:12:51.89118	A309	Błąd Lini Niverplst - Easy Plast
2602	310	41	2026-10-05 19:12:51.89118	A310	Alarm Lini Niverplast - Transport System
2603	311	41	2026-10-05 19:12:51.89118	A311	Błąd Lini Niverplst - Transport System
2604	309	39	2026-10-05 19:13:51.932001	A309	Błąd Lini Niverplst - Easy Plast
2605	310	41	2026-10-05 19:13:51.932001	A310	Alarm Lini Niverplast - Transport System
2606	311	41	2026-10-05 19:13:51.932001	A311	Błąd Lini Niverplst - Transport System
2607	309	39	2026-10-05 19:14:51.987632	A309	Błąd Lini Niverplst - Easy Plast
2608	310	41	2026-10-05 19:14:51.987632	A310	Alarm Lini Niverplast - Transport System
2609	311	41	2026-10-05 19:14:51.987632	A311	Błąd Lini Niverplst - Transport System
2610	309	39	2026-10-05 19:15:52.053736	A309	Błąd Lini Niverplst - Easy Plast
2611	310	41	2026-10-05 19:15:52.053736	A310	Alarm Lini Niverplast - Transport System
2612	311	41	2026-10-05 19:15:52.053736	A311	Błąd Lini Niverplst - Transport System
2613	309	39	2026-10-05 19:16:52.103677	A309	Błąd Lini Niverplst - Easy Plast
2614	310	41	2026-10-05 19:16:52.103677	A310	Alarm Lini Niverplast - Transport System
2615	311	41	2026-10-05 19:16:52.103677	A311	Błąd Lini Niverplst - Transport System
2616	309	39	2026-10-05 19:17:52.184494	A309	Błąd Lini Niverplst - Easy Plast
2617	310	41	2026-10-05 19:17:52.184494	A310	Alarm Lini Niverplast - Transport System
2618	311	41	2026-10-05 19:17:52.184494	A311	Błąd Lini Niverplst - Transport System
2619	309	39	2026-10-05 19:18:52.218033	A309	Błąd Lini Niverplst - Easy Plast
2620	310	41	2026-10-05 19:18:52.218033	A310	Alarm Lini Niverplast - Transport System
2621	311	41	2026-10-05 19:18:52.218033	A311	Błąd Lini Niverplst - Transport System
2622	309	39	2026-10-05 19:19:52.282928	A309	Błąd Lini Niverplst - Easy Plast
2623	310	41	2026-10-05 19:19:52.282928	A310	Alarm Lini Niverplast - Transport System
2624	311	41	2026-10-05 19:19:52.282928	A311	Błąd Lini Niverplst - Transport System
2625	309	39	2026-10-05 19:20:52.351554	A309	Błąd Lini Niverplst - Easy Plast
2626	310	41	2026-10-05 19:20:52.351554	A310	Alarm Lini Niverplast - Transport System
2627	311	41	2026-10-05 19:20:52.351554	A311	Błąd Lini Niverplst - Transport System
2628	309	39	2026-10-05 19:21:52.41379	A309	Błąd Lini Niverplst - Easy Plast
2629	310	41	2026-10-05 19:21:52.41379	A310	Alarm Lini Niverplast - Transport System
2630	311	41	2026-10-05 19:21:52.41379	A311	Błąd Lini Niverplst - Transport System
2631	309	39	2026-10-05 19:22:52.446279	A309	Błąd Lini Niverplst - Easy Plast
2632	310	41	2026-10-05 19:22:52.446279	A310	Alarm Lini Niverplast - Transport System
2633	311	41	2026-10-05 19:22:52.446279	A311	Błąd Lini Niverplst - Transport System
2634	309	39	2026-10-05 19:23:52.511219	A309	Błąd Lini Niverplst - Easy Plast
2635	310	41	2026-10-05 19:23:52.511219	A310	Alarm Lini Niverplast - Transport System
2636	311	41	2026-10-05 19:23:52.511219	A311	Błąd Lini Niverplst - Transport System
2637	309	39	2026-10-05 19:24:52.572014	A309	Błąd Lini Niverplst - Easy Plast
2638	310	41	2026-10-05 19:24:52.572014	A310	Alarm Lini Niverplast - Transport System
2639	311	41	2026-10-05 19:24:52.572014	A311	Błąd Lini Niverplst - Transport System
2640	309	39	2026-10-05 19:25:52.636887	A309	Błąd Lini Niverplst - Easy Plast
2641	310	41	2026-10-05 19:25:52.636887	A310	Alarm Lini Niverplast - Transport System
2642	311	41	2026-10-05 19:25:52.636887	A311	Błąd Lini Niverplst - Transport System
2643	309	39	2026-10-05 19:26:52.679845	A309	Błąd Lini Niverplst - Easy Plast
2644	310	41	2026-10-05 19:26:52.679845	A310	Alarm Lini Niverplast - Transport System
2645	311	41	2026-10-05 19:26:52.679845	A311	Błąd Lini Niverplst - Transport System
2646	309	39	2026-10-05 19:27:52.745219	A309	Błąd Lini Niverplst - Easy Plast
2647	310	41	2026-10-05 19:27:52.745219	A310	Alarm Lini Niverplast - Transport System
2648	311	41	2026-10-05 19:27:52.745219	A311	Błąd Lini Niverplst - Transport System
2649	309	39	2026-10-05 19:28:52.815993	A309	Błąd Lini Niverplst - Easy Plast
2650	310	41	2026-10-05 19:28:52.815993	A310	Alarm Lini Niverplast - Transport System
2651	311	41	2026-10-05 19:28:52.815993	A311	Błąd Lini Niverplst - Transport System
2652	309	39	2026-10-05 19:29:52.874452	A309	Błąd Lini Niverplst - Easy Plast
2653	310	41	2026-10-05 19:29:52.874452	A310	Alarm Lini Niverplast - Transport System
2654	311	41	2026-10-05 19:29:52.874452	A311	Błąd Lini Niverplst - Transport System
2655	309	39	2026-10-05 19:30:52.921935	A309	Błąd Lini Niverplst - Easy Plast
2656	310	41	2026-10-05 19:30:52.921935	A310	Alarm Lini Niverplast - Transport System
2657	311	41	2026-10-05 19:30:52.921935	A311	Błąd Lini Niverplst - Transport System
2658	309	39	2026-10-05 19:31:53.008872	A309	Błąd Lini Niverplst - Easy Plast
2659	310	41	2026-10-05 19:31:53.008872	A310	Alarm Lini Niverplast - Transport System
2660	311	41	2026-10-05 19:31:53.008872	A311	Błąd Lini Niverplst - Transport System
2661	309	39	2026-10-05 19:32:53.037039	A309	Błąd Lini Niverplst - Easy Plast
2662	310	41	2026-10-05 19:32:53.037039	A310	Alarm Lini Niverplast - Transport System
2663	311	41	2026-10-05 19:32:53.037039	A311	Błąd Lini Niverplst - Transport System
2664	309	39	2026-10-05 19:33:53.084189	A309	Błąd Lini Niverplst - Easy Plast
2665	310	41	2026-10-05 19:33:53.084189	A310	Alarm Lini Niverplast - Transport System
2666	311	41	2026-10-05 19:33:53.084189	A311	Błąd Lini Niverplst - Transport System
2667	309	39	2026-10-05 19:34:53.157258	A309	Błąd Lini Niverplst - Easy Plast
2668	310	41	2026-10-05 19:34:53.157258	A310	Alarm Lini Niverplast - Transport System
2669	311	41	2026-10-05 19:34:53.157258	A311	Błąd Lini Niverplst - Transport System
2670	309	39	2026-10-05 19:35:53.197484	A309	Błąd Lini Niverplst - Easy Plast
2671	310	41	2026-10-05 19:35:53.197484	A310	Alarm Lini Niverplast - Transport System
2672	311	41	2026-10-05 19:35:53.197484	A311	Błąd Lini Niverplst - Transport System
2673	309	39	2026-10-05 19:36:53.269832	A309	Błąd Lini Niverplst - Easy Plast
2674	310	41	2026-10-05 19:36:53.269832	A310	Alarm Lini Niverplast - Transport System
2675	311	41	2026-10-05 19:36:53.269832	A311	Błąd Lini Niverplst - Transport System
2676	309	39	2026-10-05 19:37:53.305793	A309	Błąd Lini Niverplst - Easy Plast
2677	310	41	2026-10-05 19:37:53.305793	A310	Alarm Lini Niverplast - Transport System
2678	311	41	2026-10-05 19:37:53.305793	A311	Błąd Lini Niverplst - Transport System
2679	309	39	2026-10-05 19:38:53.362675	A309	Błąd Lini Niverplst - Easy Plast
2680	310	41	2026-10-05 19:38:53.362675	A310	Alarm Lini Niverplast - Transport System
2681	311	41	2026-10-05 19:38:53.362675	A311	Błąd Lini Niverplst - Transport System
2682	309	39	2026-10-05 19:39:53.428426	A309	Błąd Lini Niverplst - Easy Plast
2683	310	41	2026-10-05 19:39:53.428426	A310	Alarm Lini Niverplast - Transport System
2684	311	41	2026-10-05 19:39:53.428426	A311	Błąd Lini Niverplst - Transport System
2685	309	39	2026-10-05 19:40:53.48656	A309	Błąd Lini Niverplst - Easy Plast
2686	310	41	2026-10-05 19:40:53.48656	A310	Alarm Lini Niverplast - Transport System
2687	311	41	2026-10-05 19:40:53.48656	A311	Błąd Lini Niverplst - Transport System
2688	309	39	2026-10-05 19:41:53.556527	A309	Błąd Lini Niverplst - Easy Plast
2689	310	41	2026-10-05 19:41:53.556527	A310	Alarm Lini Niverplast - Transport System
2690	311	41	2026-10-05 19:41:53.556527	A311	Błąd Lini Niverplst - Transport System
2691	309	39	2026-10-05 19:42:53.606711	A309	Błąd Lini Niverplst - Easy Plast
2692	310	41	2026-10-05 19:42:53.606711	A310	Alarm Lini Niverplast - Transport System
2693	311	41	2026-10-05 19:42:53.606711	A311	Błąd Lini Niverplst - Transport System
2694	309	39	2026-10-05 19:43:53.678858	A309	Błąd Lini Niverplst - Easy Plast
2695	310	41	2026-10-05 19:43:53.678858	A310	Alarm Lini Niverplast - Transport System
2696	311	41	2026-10-05 19:43:53.678858	A311	Błąd Lini Niverplst - Transport System
2697	309	39	2026-10-05 19:44:53.732054	A309	Błąd Lini Niverplst - Easy Plast
2698	310	41	2026-10-05 19:44:53.732054	A310	Alarm Lini Niverplast - Transport System
2699	311	41	2026-10-05 19:44:53.732054	A311	Błąd Lini Niverplst - Transport System
2700	309	39	2026-10-05 19:45:53.780354	A309	Błąd Lini Niverplst - Easy Plast
2701	310	41	2026-10-05 19:45:53.780354	A310	Alarm Lini Niverplast - Transport System
2702	311	41	2026-10-05 19:45:53.780354	A311	Błąd Lini Niverplst - Transport System
2703	309	39	2026-10-05 19:46:53.846002	A309	Błąd Lini Niverplst - Easy Plast
2704	310	41	2026-10-05 19:46:53.846002	A310	Alarm Lini Niverplast - Transport System
2705	311	41	2026-10-05 19:46:53.846002	A311	Błąd Lini Niverplst - Transport System
2706	309	39	2026-10-05 19:47:53.897098	A309	Błąd Lini Niverplst - Easy Plast
2707	310	41	2026-10-05 19:47:53.897098	A310	Alarm Lini Niverplast - Transport System
2708	311	41	2026-10-05 19:47:53.897098	A311	Błąd Lini Niverplst - Transport System
2709	309	39	2026-10-05 19:48:53.948325	A309	Błąd Lini Niverplst - Easy Plast
2710	310	41	2026-10-05 19:48:53.948325	A310	Alarm Lini Niverplast - Transport System
2711	311	41	2026-10-05 19:48:53.948325	A311	Błąd Lini Niverplst - Transport System
2712	309	39	2026-10-05 19:49:54.016606	A309	Błąd Lini Niverplst - Easy Plast
2713	310	41	2026-10-05 19:49:54.016606	A310	Alarm Lini Niverplast - Transport System
2714	311	41	2026-10-05 19:49:54.016606	A311	Błąd Lini Niverplst - Transport System
2715	309	39	2026-10-05 19:50:54.064572	A309	Błąd Lini Niverplst - Easy Plast
2716	310	41	2026-10-05 19:50:54.064572	A310	Alarm Lini Niverplast - Transport System
2717	311	41	2026-10-05 19:50:54.064572	A311	Błąd Lini Niverplst - Transport System
2718	309	39	2026-10-05 19:51:54.127295	A309	Błąd Lini Niverplst - Easy Plast
2719	310	41	2026-10-05 19:51:54.127295	A310	Alarm Lini Niverplast - Transport System
2720	311	41	2026-10-05 19:51:54.127295	A311	Błąd Lini Niverplst - Transport System
2721	309	39	2026-10-05 19:52:54.197619	A309	Błąd Lini Niverplst - Easy Plast
2722	310	41	2026-10-05 19:52:54.197619	A310	Alarm Lini Niverplast - Transport System
2723	311	41	2026-10-05 19:52:54.197619	A311	Błąd Lini Niverplst - Transport System
2724	309	39	2026-10-05 19:53:54.247999	A309	Błąd Lini Niverplst - Easy Plast
2725	310	41	2026-10-05 19:53:54.247999	A310	Alarm Lini Niverplast - Transport System
2726	311	41	2026-10-05 19:53:54.247999	A311	Błąd Lini Niverplst - Transport System
2727	309	39	2026-10-05 19:54:54.308599	A309	Błąd Lini Niverplst - Easy Plast
2728	310	41	2026-10-05 19:54:54.308599	A310	Alarm Lini Niverplast - Transport System
2729	311	41	2026-10-05 19:54:54.308599	A311	Błąd Lini Niverplst - Transport System
2730	309	39	2026-10-05 19:55:54.364605	A309	Błąd Lini Niverplst - Easy Plast
2731	310	41	2026-10-05 19:55:54.364605	A310	Alarm Lini Niverplast - Transport System
2732	311	41	2026-10-05 19:55:54.364605	A311	Błąd Lini Niverplst - Transport System
2733	309	39	2026-10-05 19:56:54.435718	A309	Błąd Lini Niverplst - Easy Plast
2734	310	41	2026-10-05 19:56:54.435718	A310	Alarm Lini Niverplast - Transport System
2735	311	41	2026-10-05 19:56:54.435718	A311	Błąd Lini Niverplst - Transport System
2736	309	39	2026-10-05 19:57:54.481191	A309	Błąd Lini Niverplst - Easy Plast
2737	310	41	2026-10-05 19:57:54.481191	A310	Alarm Lini Niverplast - Transport System
2738	311	41	2026-10-05 19:57:54.481191	A311	Błąd Lini Niverplst - Transport System
2739	309	39	2026-10-05 19:58:54.537426	A309	Błąd Lini Niverplst - Easy Plast
2740	310	41	2026-10-05 19:58:54.537426	A310	Alarm Lini Niverplast - Transport System
2741	311	41	2026-10-05 19:58:54.537426	A311	Błąd Lini Niverplst - Transport System
2742	309	39	2026-10-05 19:59:54.597007	A309	Błąd Lini Niverplst - Easy Plast
2743	310	41	2026-10-05 19:59:54.597007	A310	Alarm Lini Niverplast - Transport System
2744	311	41	2026-10-05 19:59:54.597007	A311	Błąd Lini Niverplst - Transport System
2745	309	39	2026-10-05 20:00:54.661297	A309	Błąd Lini Niverplst - Easy Plast
2746	310	41	2026-10-05 20:00:54.661297	A310	Alarm Lini Niverplast - Transport System
2747	311	41	2026-10-05 20:00:54.661297	A311	Błąd Lini Niverplst - Transport System
2748	309	39	2026-10-05 20:01:54.723039	A309	Błąd Lini Niverplst - Easy Plast
2749	310	41	2026-10-05 20:01:54.723039	A310	Alarm Lini Niverplast - Transport System
2750	311	41	2026-10-05 20:01:54.723039	A311	Błąd Lini Niverplst - Transport System
2751	309	39	2026-10-05 20:02:54.766221	A309	Błąd Lini Niverplst - Easy Plast
2752	310	41	2026-10-05 20:02:54.766221	A310	Alarm Lini Niverplast - Transport System
2753	311	41	2026-10-05 20:02:54.766221	A311	Błąd Lini Niverplst - Transport System
2754	309	39	2026-10-05 20:03:54.833381	A309	Błąd Lini Niverplst - Easy Plast
2755	310	41	2026-10-05 20:03:54.833381	A310	Alarm Lini Niverplast - Transport System
2756	311	41	2026-10-05 20:03:54.833381	A311	Błąd Lini Niverplst - Transport System
2757	309	39	2026-10-05 20:04:54.899379	A309	Błąd Lini Niverplst - Easy Plast
2758	310	41	2026-10-05 20:04:54.899379	A310	Alarm Lini Niverplast - Transport System
2759	311	41	2026-10-05 20:04:54.899379	A311	Błąd Lini Niverplst - Transport System
2760	309	39	2026-10-05 20:05:54.945399	A309	Błąd Lini Niverplst - Easy Plast
2761	310	41	2026-10-05 20:05:54.945399	A310	Alarm Lini Niverplast - Transport System
2762	311	41	2026-10-05 20:05:54.945399	A311	Błąd Lini Niverplst - Transport System
2763	309	39	2026-10-05 20:06:54.998993	A309	Błąd Lini Niverplst - Easy Plast
2764	310	41	2026-10-05 20:06:54.998993	A310	Alarm Lini Niverplast - Transport System
2765	311	41	2026-10-05 20:06:54.998993	A311	Błąd Lini Niverplst - Transport System
2784	309	39	2026-10-05 20:13:55.406101	A309	Błąd Lini Niverplst - Easy Plast
2785	310	41	2026-10-05 20:13:55.406101	A310	Alarm Lini Niverplast - Transport System
2786	311	41	2026-10-05 20:13:55.406101	A311	Błąd Lini Niverplst - Transport System
2805	309	39	2026-10-05 20:20:55.821257	A309	Błąd Lini Niverplst - Easy Plast
2806	310	41	2026-10-05 20:20:55.821257	A310	Alarm Lini Niverplast - Transport System
2807	311	41	2026-10-05 20:20:55.821257	A311	Błąd Lini Niverplst - Transport System
2826	309	39	2026-10-05 20:27:56.197776	A309	Błąd Lini Niverplst - Easy Plast
2827	310	41	2026-10-05 20:27:56.197776	A310	Alarm Lini Niverplast - Transport System
2828	311	41	2026-10-05 20:27:56.197776	A311	Błąd Lini Niverplst - Transport System
2847	309	39	2026-10-05 20:34:56.619237	A309	Błąd Lini Niverplst - Easy Plast
2848	310	41	2026-10-05 20:34:56.619237	A310	Alarm Lini Niverplast - Transport System
2849	311	41	2026-10-05 20:34:56.619237	A311	Błąd Lini Niverplst - Transport System
2868	309	39	2026-10-05 20:41:57.014433	A309	Błąd Lini Niverplst - Easy Plast
2869	310	41	2026-10-05 20:41:57.014433	A310	Alarm Lini Niverplast - Transport System
2870	311	41	2026-10-05 20:41:57.014433	A311	Błąd Lini Niverplst - Transport System
2889	309	39	2026-10-05 20:48:57.41954	A309	Błąd Lini Niverplst - Easy Plast
2890	310	41	2026-10-05 20:48:57.41954	A310	Alarm Lini Niverplast - Transport System
2891	311	41	2026-10-05 20:48:57.41954	A311	Błąd Lini Niverplst - Transport System
2910	309	39	2026-10-05 20:55:57.826192	A309	Błąd Lini Niverplst - Easy Plast
3261	309	39	2026-10-05 22:53:04.456677	A309	Błąd Lini Niverplst - Easy Plast
3262	310	41	2026-10-05 22:53:04.456677	A310	Alarm Lini Niverplast - Transport System
3263	311	41	2026-10-05 22:53:04.456677	A311	Błąd Lini Niverplst - Transport System
3264	309	39	2026-10-05 22:54:04.518699	A309	Błąd Lini Niverplst - Easy Plast
3265	310	41	2026-10-05 22:54:04.518699	A310	Alarm Lini Niverplast - Transport System
3266	311	41	2026-10-05 22:54:04.518699	A311	Błąd Lini Niverplst - Transport System
3267	309	39	2026-10-05 22:55:04.577287	A309	Błąd Lini Niverplst - Easy Plast
3268	310	41	2026-10-05 22:55:04.577287	A310	Alarm Lini Niverplast - Transport System
3269	311	41	2026-10-05 22:55:04.577287	A311	Błąd Lini Niverplst - Transport System
3270	309	39	2026-10-05 22:56:04.618336	A309	Błąd Lini Niverplst - Easy Plast
3271	310	41	2026-10-05 22:56:04.618336	A310	Alarm Lini Niverplast - Transport System
3272	311	41	2026-10-05 22:56:04.618336	A311	Błąd Lini Niverplst - Transport System
3273	309	39	2026-10-05 22:57:04.701536	A309	Błąd Lini Niverplst - Easy Plast
3274	310	41	2026-10-05 22:57:04.701536	A310	Alarm Lini Niverplast - Transport System
3275	311	41	2026-10-05 22:57:04.701536	A311	Błąd Lini Niverplst - Transport System
3276	309	39	2026-10-05 22:58:04.760721	A309	Błąd Lini Niverplst - Easy Plast
3277	310	41	2026-10-05 22:58:04.760721	A310	Alarm Lini Niverplast - Transport System
3278	311	41	2026-10-05 22:58:04.760721	A311	Błąd Lini Niverplst - Transport System
3279	309	39	2026-10-05 22:59:04.804757	A309	Błąd Lini Niverplst - Easy Plast
3280	310	41	2026-10-05 22:59:04.804757	A310	Alarm Lini Niverplast - Transport System
3281	311	41	2026-10-05 22:59:04.804757	A311	Błąd Lini Niverplst - Transport System
3282	309	39	2026-10-05 23:00:04.879453	A309	Błąd Lini Niverplst - Easy Plast
3283	310	41	2026-10-05 23:00:04.879453	A310	Alarm Lini Niverplast - Transport System
3284	311	41	2026-10-05 23:00:04.879453	A311	Błąd Lini Niverplst - Transport System
3285	106	2	2026-10-05 23:00:04.879453	A106	Błąd pudełko zostało odrzucone
3286	309	39	2026-10-05 23:01:04.935987	A309	Błąd Lini Niverplst - Easy Plast
3287	310	41	2026-10-05 23:01:04.935987	A310	Alarm Lini Niverplast - Transport System
3288	311	41	2026-10-05 23:01:04.935987	A311	Błąd Lini Niverplst - Transport System
3289	106	2	2026-10-05 23:01:04.935987	A106	Błąd pudełko zostało odrzucone
3290	309	39	2026-10-05 23:02:04.997653	A309	Błąd Lini Niverplst - Easy Plast
3291	310	41	2026-10-05 23:02:04.997653	A310	Alarm Lini Niverplast - Transport System
3292	311	41	2026-10-05 23:02:04.997653	A311	Błąd Lini Niverplst - Transport System
3293	309	39	2026-10-05 23:03:05.054027	A309	Błąd Lini Niverplst - Easy Plast
3294	310	41	2026-10-05 23:03:05.054027	A310	Alarm Lini Niverplast - Transport System
3295	311	41	2026-10-05 23:03:05.054027	A311	Błąd Lini Niverplst - Transport System
3296	106	2	2026-10-05 23:03:05.054027	A106	Błąd pudełko zostało odrzucone
3297	309	39	2026-10-05 23:04:05.106263	A309	Błąd Lini Niverplst - Easy Plast
3298	310	41	2026-10-05 23:04:05.106263	A310	Alarm Lini Niverplast - Transport System
3299	311	41	2026-10-05 23:04:05.106263	A311	Błąd Lini Niverplst - Transport System
3300	309	39	2026-10-05 23:05:05.173479	A309	Błąd Lini Niverplst - Easy Plast
3301	310	41	2026-10-05 23:05:05.173479	A310	Alarm Lini Niverplast - Transport System
3302	311	41	2026-10-05 23:05:05.173479	A311	Błąd Lini Niverplst - Transport System
3303	309	39	2026-10-05 23:06:05.22833	A309	Błąd Lini Niverplst - Easy Plast
3304	310	41	2026-10-05 23:06:05.22833	A310	Alarm Lini Niverplast - Transport System
3305	311	41	2026-10-05 23:06:05.22833	A311	Błąd Lini Niverplst - Transport System
3306	309	39	2026-10-05 23:07:05.286947	A309	Błąd Lini Niverplst - Easy Plast
3307	310	41	2026-10-05 23:07:05.286947	A310	Alarm Lini Niverplast - Transport System
3308	311	41	2026-10-05 23:07:05.286947	A311	Błąd Lini Niverplst - Transport System
3309	309	39	2026-10-05 23:08:05.351086	A309	Błąd Lini Niverplst - Easy Plast
3310	310	41	2026-10-05 23:08:05.351086	A310	Alarm Lini Niverplast - Transport System
3311	311	41	2026-10-05 23:08:05.351086	A311	Błąd Lini Niverplst - Transport System
3312	309	39	2026-10-05 23:09:05.404697	A309	Błąd Lini Niverplst - Easy Plast
3313	310	41	2026-10-05 23:09:05.404697	A310	Alarm Lini Niverplast - Transport System
3314	311	41	2026-10-05 23:09:05.404697	A311	Błąd Lini Niverplst - Transport System
3315	309	39	2026-10-05 23:10:05.45858	A309	Błąd Lini Niverplst - Easy Plast
3316	310	41	2026-10-05 23:10:05.45858	A310	Alarm Lini Niverplast - Transport System
3317	311	41	2026-10-05 23:10:05.45858	A311	Błąd Lini Niverplst - Transport System
3318	309	39	2026-10-05 23:11:05.525001	A309	Błąd Lini Niverplst - Easy Plast
3319	310	41	2026-10-05 23:11:05.525001	A310	Alarm Lini Niverplast - Transport System
3320	311	41	2026-10-05 23:11:05.525001	A311	Błąd Lini Niverplst - Transport System
3321	309	39	2026-10-05 23:12:05.581106	A309	Błąd Lini Niverplst - Easy Plast
3322	310	41	2026-10-05 23:12:05.581106	A310	Alarm Lini Niverplast - Transport System
3323	311	41	2026-10-05 23:12:05.581106	A311	Błąd Lini Niverplst - Transport System
3324	309	39	2026-10-05 23:13:05.652776	A309	Błąd Lini Niverplst - Easy Plast
3325	310	41	2026-10-05 23:13:05.652776	A310	Alarm Lini Niverplast - Transport System
3326	311	41	2026-10-05 23:13:05.652776	A311	Błąd Lini Niverplst - Transport System
3327	309	39	2026-10-05 23:14:05.708481	A309	Błąd Lini Niverplst - Easy Plast
3328	310	41	2026-10-05 23:14:05.708481	A310	Alarm Lini Niverplast - Transport System
3329	311	41	2026-10-05 23:14:05.708481	A311	Błąd Lini Niverplst - Transport System
3330	309	39	2026-10-05 23:15:05.770836	A309	Błąd Lini Niverplst - Easy Plast
3331	310	41	2026-10-05 23:15:05.770836	A310	Alarm Lini Niverplast - Transport System
3332	311	41	2026-10-05 23:15:05.770836	A311	Błąd Lini Niverplst - Transport System
3333	309	39	2026-10-05 23:16:05.830826	A309	Błąd Lini Niverplst - Easy Plast
3334	310	41	2026-10-05 23:16:05.830826	A310	Alarm Lini Niverplast - Transport System
3335	311	41	2026-10-05 23:16:05.830826	A311	Błąd Lini Niverplst - Transport System
3336	309	39	2026-10-05 23:17:05.914376	A309	Błąd Lini Niverplst - Easy Plast
3337	310	41	2026-10-05 23:17:05.914376	A310	Alarm Lini Niverplast - Transport System
3338	311	41	2026-10-05 23:17:05.914376	A311	Błąd Lini Niverplst - Transport System
3339	309	39	2026-10-05 23:18:05.951916	A309	Błąd Lini Niverplst - Easy Plast
3340	310	41	2026-10-05 23:18:05.951916	A310	Alarm Lini Niverplast - Transport System
3341	311	41	2026-10-05 23:18:05.951916	A311	Błąd Lini Niverplst - Transport System
3342	309	39	2026-10-05 23:19:06.010258	A309	Błąd Lini Niverplst - Easy Plast
3343	310	41	2026-10-05 23:19:06.010258	A310	Alarm Lini Niverplast - Transport System
3344	311	41	2026-10-05 23:19:06.010258	A311	Błąd Lini Niverplst - Transport System
3345	309	39	2026-10-05 23:20:06.074257	A309	Błąd Lini Niverplst - Easy Plast
3346	310	41	2026-10-05 23:20:06.074257	A310	Alarm Lini Niverplast - Transport System
3347	311	41	2026-10-05 23:20:06.074257	A311	Błąd Lini Niverplst - Transport System
3348	309	39	2026-10-05 23:21:06.137325	A309	Błąd Lini Niverplst - Easy Plast
3349	310	41	2026-10-05 23:21:06.137325	A310	Alarm Lini Niverplast - Transport System
3350	311	41	2026-10-05 23:21:06.137325	A311	Błąd Lini Niverplst - Transport System
3351	309	39	2026-10-05 23:22:06.192706	A309	Błąd Lini Niverplst - Easy Plast
3352	310	41	2026-10-05 23:22:06.192706	A310	Alarm Lini Niverplast - Transport System
3353	311	41	2026-10-05 23:22:06.192706	A311	Błąd Lini Niverplst - Transport System
3354	309	39	2026-10-05 23:23:06.26485	A309	Błąd Lini Niverplst - Easy Plast
3355	310	41	2026-10-05 23:23:06.26485	A310	Alarm Lini Niverplast - Transport System
3356	311	41	2026-10-05 23:23:06.26485	A311	Błąd Lini Niverplst - Transport System
3357	309	39	2026-10-05 23:24:06.325397	A309	Błąd Lini Niverplst - Easy Plast
3358	310	41	2026-10-05 23:24:06.325397	A310	Alarm Lini Niverplast - Transport System
3359	311	41	2026-10-05 23:24:06.325397	A311	Błąd Lini Niverplst - Transport System
3360	309	39	2026-10-05 23:25:06.369558	A309	Błąd Lini Niverplst - Easy Plast
3361	310	41	2026-10-05 23:25:06.369558	A310	Alarm Lini Niverplast - Transport System
3362	311	41	2026-10-05 23:25:06.369558	A311	Błąd Lini Niverplst - Transport System
3363	309	39	2026-10-05 23:26:06.425355	A309	Błąd Lini Niverplst - Easy Plast
3364	310	41	2026-10-05 23:26:06.425355	A310	Alarm Lini Niverplast - Transport System
3365	311	41	2026-10-05 23:26:06.425355	A311	Błąd Lini Niverplst - Transport System
3366	309	39	2026-10-05 23:27:06.492794	A309	Błąd Lini Niverplst - Easy Plast
3367	310	41	2026-10-05 23:27:06.492794	A310	Alarm Lini Niverplast - Transport System
3368	311	41	2026-10-05 23:27:06.492794	A311	Błąd Lini Niverplst - Transport System
3369	309	39	2026-10-05 23:28:06.544126	A309	Błąd Lini Niverplst - Easy Plast
3370	310	41	2026-10-05 23:28:06.544126	A310	Alarm Lini Niverplast - Transport System
3371	311	41	2026-10-05 23:28:06.544126	A311	Błąd Lini Niverplst - Transport System
3372	309	39	2026-10-05 23:29:05.06425	A309	Błąd Lini Niverplst - Easy Plast
3373	310	41	2026-10-05 23:29:05.06425	A310	Alarm Lini Niverplast - Transport System
3374	311	41	2026-10-05 23:29:05.06425	A311	Błąd Lini Niverplst - Transport System
3375	309	39	2026-10-05 23:30:06.606077	A309	Błąd Lini Niverplst - Easy Plast
3376	310	41	2026-10-05 23:30:06.606077	A310	Alarm Lini Niverplast - Transport System
3377	311	41	2026-10-05 23:30:06.606077	A311	Błąd Lini Niverplst - Transport System
3378	309	39	2026-10-05 23:31:06.739236	A309	Błąd Lini Niverplst - Easy Plast
3379	310	41	2026-10-05 23:31:06.739236	A310	Alarm Lini Niverplast - Transport System
3380	311	41	2026-10-05 23:31:06.739236	A311	Błąd Lini Niverplst - Transport System
3381	309	39	2026-10-05 23:32:06.760036	A309	Błąd Lini Niverplst - Easy Plast
3382	310	41	2026-10-05 23:32:06.760036	A310	Alarm Lini Niverplast - Transport System
3383	311	41	2026-10-05 23:32:06.760036	A311	Błąd Lini Niverplst - Transport System
3384	309	39	2026-10-05 23:33:06.868615	A309	Błąd Lini Niverplst - Easy Plast
3385	310	41	2026-10-05 23:33:06.868615	A310	Alarm Lini Niverplast - Transport System
3386	311	41	2026-10-05 23:33:06.868615	A311	Błąd Lini Niverplst - Transport System
3387	309	39	2026-10-05 23:34:06.897545	A309	Błąd Lini Niverplst - Easy Plast
3388	310	41	2026-10-05 23:34:06.897545	A310	Alarm Lini Niverplast - Transport System
3389	311	41	2026-10-05 23:34:06.897545	A311	Błąd Lini Niverplst - Transport System
3390	309	39	2026-10-05 23:35:06.988548	A309	Błąd Lini Niverplst - Easy Plast
3391	310	41	2026-10-05 23:35:06.988548	A310	Alarm Lini Niverplast - Transport System
3392	311	41	2026-10-05 23:35:06.988548	A311	Błąd Lini Niverplst - Transport System
3393	309	39	2026-10-05 23:36:07.048549	A309	Błąd Lini Niverplst - Easy Plast
3394	310	41	2026-10-05 23:36:07.048549	A310	Alarm Lini Niverplast - Transport System
3395	311	41	2026-10-05 23:36:07.048549	A311	Błąd Lini Niverplst - Transport System
3396	309	39	2026-10-05 23:37:07.106753	A309	Błąd Lini Niverplst - Easy Plast
3397	310	41	2026-10-05 23:37:07.106753	A310	Alarm Lini Niverplast - Transport System
3398	311	41	2026-10-05 23:37:07.106753	A311	Błąd Lini Niverplst - Transport System
3399	309	39	2026-10-05 23:38:07.145374	A309	Błąd Lini Niverplst - Easy Plast
3400	310	41	2026-10-05 23:38:07.145374	A310	Alarm Lini Niverplast - Transport System
3401	311	41	2026-10-05 23:38:07.145374	A311	Błąd Lini Niverplst - Transport System
3402	309	39	2026-10-05 23:39:07.205912	A309	Błąd Lini Niverplst - Easy Plast
3403	310	41	2026-10-05 23:39:07.205912	A310	Alarm Lini Niverplast - Transport System
3404	311	41	2026-10-05 23:39:07.205912	A311	Błąd Lini Niverplst - Transport System
3405	309	39	2026-10-05 23:40:07.279678	A309	Błąd Lini Niverplst - Easy Plast
3406	310	41	2026-10-05 23:40:07.279678	A310	Alarm Lini Niverplast - Transport System
3407	311	41	2026-10-05 23:40:07.279678	A311	Błąd Lini Niverplst - Transport System
3408	309	39	2026-10-05 23:41:07.320459	A309	Błąd Lini Niverplst - Easy Plast
3409	310	41	2026-10-05 23:41:07.320459	A310	Alarm Lini Niverplast - Transport System
3410	311	41	2026-10-05 23:41:07.320459	A311	Błąd Lini Niverplst - Transport System
3411	309	39	2026-10-05 23:42:07.386591	A309	Błąd Lini Niverplst - Easy Plast
3412	310	41	2026-10-05 23:42:07.386591	A310	Alarm Lini Niverplast - Transport System
3413	311	41	2026-10-05 23:42:07.386591	A311	Błąd Lini Niverplst - Transport System
3414	309	39	2026-10-05 23:43:07.467816	A309	Błąd Lini Niverplst - Easy Plast
3415	310	41	2026-10-05 23:43:07.467816	A310	Alarm Lini Niverplast - Transport System
3416	311	41	2026-10-05 23:43:07.467816	A311	Błąd Lini Niverplst - Transport System
3417	309	39	2026-10-05 23:44:07.526723	A309	Błąd Lini Niverplst - Easy Plast
3418	310	41	2026-10-05 23:44:07.526723	A310	Alarm Lini Niverplast - Transport System
3419	311	41	2026-10-05 23:44:07.526723	A311	Błąd Lini Niverplst - Transport System
3420	309	39	2026-10-05 23:45:07.588003	A309	Błąd Lini Niverplst - Easy Plast
3421	310	41	2026-10-05 23:45:07.588003	A310	Alarm Lini Niverplast - Transport System
3422	311	41	2026-10-05 23:45:07.588003	A311	Błąd Lini Niverplst - Transport System
3423	309	39	2026-10-05 23:46:07.635245	A309	Błąd Lini Niverplst - Easy Plast
3424	310	41	2026-10-05 23:46:07.635245	A310	Alarm Lini Niverplast - Transport System
3425	311	41	2026-10-05 23:46:07.635245	A311	Błąd Lini Niverplst - Transport System
3426	309	39	2026-10-05 23:47:07.705776	A309	Błąd Lini Niverplst - Easy Plast
3427	310	41	2026-10-05 23:47:07.705776	A310	Alarm Lini Niverplast - Transport System
3428	311	41	2026-10-05 23:47:07.705776	A311	Błąd Lini Niverplst - Transport System
3429	309	39	2026-10-05 23:48:07.759437	A309	Błąd Lini Niverplst - Easy Plast
3430	310	41	2026-10-05 23:48:07.759437	A310	Alarm Lini Niverplast - Transport System
3431	311	41	2026-10-05 23:48:07.759437	A311	Błąd Lini Niverplst - Transport System
3432	309	39	2026-10-05 23:49:07.824234	A309	Błąd Lini Niverplst - Easy Plast
3433	310	41	2026-10-05 23:49:07.824234	A310	Alarm Lini Niverplast - Transport System
3434	311	41	2026-10-05 23:49:07.824234	A311	Błąd Lini Niverplst - Transport System
3435	309	39	2026-10-05 23:50:07.85617	A309	Błąd Lini Niverplst - Easy Plast
3436	310	41	2026-10-05 23:50:07.85617	A310	Alarm Lini Niverplast - Transport System
3437	311	41	2026-10-05 23:50:07.85617	A311	Błąd Lini Niverplst - Transport System
3438	309	39	2026-10-05 23:51:07.919207	A309	Błąd Lini Niverplst - Easy Plast
3439	310	41	2026-10-05 23:51:07.919207	A310	Alarm Lini Niverplast - Transport System
3440	311	41	2026-10-05 23:51:07.919207	A311	Błąd Lini Niverplst - Transport System
3441	309	39	2026-10-05 23:52:07.977232	A309	Błąd Lini Niverplst - Easy Plast
3442	310	41	2026-10-05 23:52:07.977232	A310	Alarm Lini Niverplast - Transport System
3443	311	41	2026-10-05 23:52:07.977232	A311	Błąd Lini Niverplst - Transport System
3444	309	39	2026-10-05 23:53:08.048189	A309	Błąd Lini Niverplst - Easy Plast
3445	310	41	2026-10-05 23:53:08.048189	A310	Alarm Lini Niverplast - Transport System
3446	311	41	2026-10-05 23:53:08.048189	A311	Błąd Lini Niverplst - Transport System
3447	309	39	2026-10-05 23:54:08.101289	A309	Błąd Lini Niverplst - Easy Plast
3448	310	41	2026-10-05 23:54:08.101289	A310	Alarm Lini Niverplast - Transport System
3449	311	41	2026-10-05 23:54:08.101289	A311	Błąd Lini Niverplst - Transport System
3450	309	39	2026-10-05 23:55:08.159794	A309	Błąd Lini Niverplst - Easy Plast
3451	310	41	2026-10-05 23:55:08.159794	A310	Alarm Lini Niverplast - Transport System
3452	311	41	2026-10-05 23:55:08.159794	A311	Błąd Lini Niverplst - Transport System
3453	309	39	2026-10-05 23:56:08.203087	A309	Błąd Lini Niverplst - Easy Plast
3454	310	41	2026-10-05 23:56:08.203087	A310	Alarm Lini Niverplast - Transport System
3455	311	41	2026-10-05 23:56:08.203087	A311	Błąd Lini Niverplst - Transport System
3456	309	39	2026-10-05 23:57:08.261991	A309	Błąd Lini Niverplst - Easy Plast
3457	310	41	2026-10-05 23:57:08.261991	A310	Alarm Lini Niverplast - Transport System
3458	311	41	2026-10-05 23:57:08.261991	A311	Błąd Lini Niverplst - Transport System
3459	309	39	2026-10-05 23:58:08.327158	A309	Błąd Lini Niverplst - Easy Plast
3460	310	41	2026-10-05 23:58:08.327158	A310	Alarm Lini Niverplast - Transport System
3461	311	41	2026-10-05 23:58:08.327158	A311	Błąd Lini Niverplst - Transport System
3462	309	39	2026-10-05 23:59:08.392854	A309	Błąd Lini Niverplst - Easy Plast
3463	310	41	2026-10-05 23:59:08.392854	A310	Alarm Lini Niverplast - Transport System
3464	311	41	2026-10-05 23:59:08.392854	A311	Błąd Lini Niverplst - Transport System
3465	309	39	2026-10-06 00:00:08.445467	A309	Błąd Lini Niverplst - Easy Plast
3466	310	41	2026-10-06 00:00:08.445467	A310	Alarm Lini Niverplast - Transport System
3467	311	41	2026-10-06 00:00:08.445467	A311	Błąd Lini Niverplst - Transport System
3468	309	39	2026-10-06 00:01:08.505668	A309	Błąd Lini Niverplst - Easy Plast
3469	310	41	2026-10-06 00:01:08.505668	A310	Alarm Lini Niverplast - Transport System
3470	311	41	2026-10-06 00:01:08.505668	A311	Błąd Lini Niverplst - Transport System
3471	309	39	2026-10-06 00:02:08.559424	A309	Błąd Lini Niverplst - Easy Plast
3472	310	41	2026-10-06 00:02:08.559424	A310	Alarm Lini Niverplast - Transport System
3473	311	41	2026-10-06 00:02:08.559424	A311	Błąd Lini Niverplst - Transport System
3474	309	39	2026-10-06 00:03:08.616323	A309	Błąd Lini Niverplst - Easy Plast
3475	310	41	2026-10-06 00:03:08.616323	A310	Alarm Lini Niverplast - Transport System
3476	311	41	2026-10-06 00:03:08.616323	A311	Błąd Lini Niverplst - Transport System
3477	309	39	2026-10-06 00:04:08.682439	A309	Błąd Lini Niverplst - Easy Plast
3478	310	41	2026-10-06 00:04:08.682439	A310	Alarm Lini Niverplast - Transport System
3479	311	41	2026-10-06 00:04:08.682439	A311	Błąd Lini Niverplst - Transport System
3480	309	39	2026-10-06 00:05:08.739612	A309	Błąd Lini Niverplst - Easy Plast
3481	310	41	2026-10-06 00:05:08.739612	A310	Alarm Lini Niverplast - Transport System
3482	311	41	2026-10-06 00:05:08.739612	A311	Błąd Lini Niverplst - Transport System
3483	309	39	2026-10-06 00:06:08.787915	A309	Błąd Lini Niverplst - Easy Plast
3484	310	41	2026-10-06 00:06:08.787915	A310	Alarm Lini Niverplast - Transport System
3485	311	41	2026-10-06 00:06:08.787915	A311	Błąd Lini Niverplst - Transport System
3486	309	39	2026-10-06 00:07:08.841818	A309	Błąd Lini Niverplst - Easy Plast
3487	310	41	2026-10-06 00:07:08.841818	A310	Alarm Lini Niverplast - Transport System
3488	311	41	2026-10-06 00:07:08.841818	A311	Błąd Lini Niverplst - Transport System
3489	309	39	2026-10-06 00:08:08.915516	A309	Błąd Lini Niverplst - Easy Plast
3490	310	41	2026-10-06 00:08:08.915516	A310	Alarm Lini Niverplast - Transport System
3491	311	41	2026-10-06 00:08:08.915516	A311	Błąd Lini Niverplst - Transport System
3492	309	39	2026-10-06 00:09:08.960995	A309	Błąd Lini Niverplst - Easy Plast
3493	310	41	2026-10-06 00:09:08.960995	A310	Alarm Lini Niverplast - Transport System
3494	311	41	2026-10-06 00:09:08.960995	A311	Błąd Lini Niverplst - Transport System
3495	193	40	2026-10-06 00:10:09.001742	A193	Niskie ciśnienie pneumatyczne - strefa 2
3496	241	40	2026-10-06 00:10:09.001742	A241	Niskie ciśnienie pneumatyczne - strefa 3
3497	309	39	2026-10-06 00:10:09.001742	A309	Błąd Lini Niverplst - Easy Plast
3498	310	41	2026-10-06 00:10:09.001742	A310	Alarm Lini Niverplast - Transport System
3499	311	41	2026-10-06 00:10:09.001742	A311	Błąd Lini Niverplst - Transport System
3500	225	8	2026-10-06 00:10:09.001742	A225	Otwarta Bramka Bezpieczeństwa
3501	226	9	2026-10-06 00:10:09.001742	A226	Niezaryglowany zamek bramki bezpieczenstwa 
3502	309	39	2026-10-06 00:11:09.057601	A309	Błąd Lini Niverplst - Easy Plast
3503	310	41	2026-10-06 00:11:09.057601	A310	Alarm Lini Niverplast - Transport System
3504	311	41	2026-10-06 00:11:09.057601	A311	Błąd Lini Niverplst - Transport System
3505	309	39	2026-10-06 00:12:09.124075	A309	Błąd Lini Niverplst - Easy Plast
3506	310	41	2026-10-06 00:12:09.124075	A310	Alarm Lini Niverplast - Transport System
3507	311	41	2026-10-06 00:12:09.124075	A311	Błąd Lini Niverplst - Transport System
3508	309	39	2026-10-06 00:13:09.17155	A309	Błąd Lini Niverplst - Easy Plast
3509	310	41	2026-10-06 00:13:09.17155	A310	Alarm Lini Niverplast - Transport System
3510	311	41	2026-10-06 00:13:09.17155	A311	Błąd Lini Niverplst - Transport System
3511	309	39	2026-10-06 00:14:09.218878	A309	Błąd Lini Niverplst - Easy Plast
3512	310	41	2026-10-06 00:14:09.218878	A310	Alarm Lini Niverplast - Transport System
3513	311	41	2026-10-06 00:14:09.218878	A311	Błąd Lini Niverplst - Transport System
3514	309	39	2026-10-06 00:15:09.278155	A309	Błąd Lini Niverplst - Easy Plast
3515	310	41	2026-10-06 00:15:09.278155	A310	Alarm Lini Niverplast - Transport System
3516	311	41	2026-10-06 00:15:09.278155	A311	Błąd Lini Niverplst - Transport System
3517	309	39	2026-10-06 00:16:09.354743	A309	Błąd Lini Niverplst - Easy Plast
3518	310	41	2026-10-06 00:16:09.354743	A310	Alarm Lini Niverplast - Transport System
3519	311	41	2026-10-06 00:16:09.354743	A311	Błąd Lini Niverplst - Transport System
3520	309	39	2026-10-06 00:17:09.394758	A309	Błąd Lini Niverplst - Easy Plast
3521	310	41	2026-10-06 00:17:09.394758	A310	Alarm Lini Niverplast - Transport System
3522	311	41	2026-10-06 00:17:09.394758	A311	Błąd Lini Niverplst - Transport System
3523	309	39	2026-10-06 00:18:09.438299	A309	Błąd Lini Niverplst - Easy Plast
3524	310	41	2026-10-06 00:18:09.438299	A310	Alarm Lini Niverplast - Transport System
3525	311	41	2026-10-06 00:18:09.438299	A311	Błąd Lini Niverplst - Transport System
3526	309	39	2026-10-06 00:19:09.526076	A309	Błąd Lini Niverplst - Easy Plast
3527	310	41	2026-10-06 00:19:09.526076	A310	Alarm Lini Niverplast - Transport System
3528	311	41	2026-10-06 00:19:09.526076	A311	Błąd Lini Niverplst - Transport System
3529	309	39	2026-10-06 00:20:09.555671	A309	Błąd Lini Niverplst - Easy Plast
3530	310	41	2026-10-06 00:20:09.555671	A310	Alarm Lini Niverplast - Transport System
3531	311	41	2026-10-06 00:20:09.555671	A311	Błąd Lini Niverplst - Transport System
3532	309	39	2026-10-06 00:21:09.615432	A309	Błąd Lini Niverplst - Easy Plast
3533	310	41	2026-10-06 00:21:09.615432	A310	Alarm Lini Niverplast - Transport System
3534	311	41	2026-10-06 00:21:09.615432	A311	Błąd Lini Niverplst - Transport System
3535	309	39	2026-10-06 00:22:09.686564	A309	Błąd Lini Niverplst - Easy Plast
3536	310	41	2026-10-06 00:22:09.686564	A310	Alarm Lini Niverplast - Transport System
3537	311	41	2026-10-06 00:22:09.686564	A311	Błąd Lini Niverplst - Transport System
3538	309	39	2026-10-06 00:23:09.733579	A309	Błąd Lini Niverplst - Easy Plast
3539	310	41	2026-10-06 00:23:09.733579	A310	Alarm Lini Niverplast - Transport System
3540	311	41	2026-10-06 00:23:09.733579	A311	Błąd Lini Niverplst - Transport System
3541	309	39	2026-10-06 00:24:09.761777	A309	Błąd Lini Niverplst - Easy Plast
3542	310	41	2026-10-06 00:24:09.761777	A310	Alarm Lini Niverplast - Transport System
3543	311	41	2026-10-06 00:24:09.761777	A311	Błąd Lini Niverplst - Transport System
3544	309	39	2026-10-06 00:25:09.821604	A309	Błąd Lini Niverplst - Easy Plast
3545	310	41	2026-10-06 00:25:09.821604	A310	Alarm Lini Niverplast - Transport System
3546	311	41	2026-10-06 00:25:09.821604	A311	Błąd Lini Niverplst - Transport System
3547	309	39	2026-10-06 00:26:09.890528	A309	Błąd Lini Niverplst - Easy Plast
3548	310	41	2026-10-06 00:26:09.890528	A310	Alarm Lini Niverplast - Transport System
3549	311	41	2026-10-06 00:26:09.890528	A311	Błąd Lini Niverplst - Transport System
3550	309	39	2026-10-06 00:27:09.910368	A309	Błąd Lini Niverplst - Easy Plast
3551	310	41	2026-10-06 00:27:09.910368	A310	Alarm Lini Niverplast - Transport System
3552	311	41	2026-10-06 00:27:09.910368	A311	Błąd Lini Niverplst - Transport System
3553	309	39	2026-10-06 00:28:09.995689	A309	Błąd Lini Niverplst - Easy Plast
3554	310	41	2026-10-06 00:28:09.995689	A310	Alarm Lini Niverplast - Transport System
3555	311	41	2026-10-06 00:28:09.995689	A311	Błąd Lini Niverplst - Transport System
3556	309	39	2026-10-06 00:29:10.036716	A309	Błąd Lini Niverplst - Easy Plast
3557	310	41	2026-10-06 00:29:10.036716	A310	Alarm Lini Niverplast - Transport System
3558	311	41	2026-10-06 00:29:10.036716	A311	Błąd Lini Niverplst - Transport System
3559	309	39	2026-10-06 00:30:10.115422	A309	Błąd Lini Niverplst - Easy Plast
3560	310	41	2026-10-06 00:30:10.115422	A310	Alarm Lini Niverplast - Transport System
3561	311	41	2026-10-06 00:30:10.115422	A311	Błąd Lini Niverplst - Transport System
3562	309	39	2026-10-06 00:31:10.171559	A309	Błąd Lini Niverplst - Easy Plast
3563	310	41	2026-10-06 00:31:10.171559	A310	Alarm Lini Niverplast - Transport System
3564	311	41	2026-10-06 00:31:10.171559	A311	Błąd Lini Niverplst - Transport System
3565	309	39	2026-10-06 00:32:10.098274	A309	Błąd Lini Niverplst - Easy Plast
3566	310	41	2026-10-06 00:32:10.098274	A310	Alarm Lini Niverplast - Transport System
3567	311	41	2026-10-06 00:32:10.098274	A311	Błąd Lini Niverplst - Transport System
3568	309	39	2026-10-06 00:33:10.140324	A309	Błąd Lini Niverplst - Easy Plast
3569	310	41	2026-10-06 00:33:10.140324	A310	Alarm Lini Niverplast - Transport System
3570	311	41	2026-10-06 00:33:10.140324	A311	Błąd Lini Niverplst - Transport System
3571	309	39	2026-10-06 00:34:10.20686	A309	Błąd Lini Niverplst - Easy Plast
3572	310	41	2026-10-06 00:34:10.20686	A310	Alarm Lini Niverplast - Transport System
3573	311	41	2026-10-06 00:34:10.20686	A311	Błąd Lini Niverplst - Transport System
3574	309	39	2026-10-06 00:35:10.273169	A309	Błąd Lini Niverplst - Easy Plast
3575	310	41	2026-10-06 00:35:10.273169	A310	Alarm Lini Niverplast - Transport System
3576	311	41	2026-10-06 00:35:10.273169	A311	Błąd Lini Niverplst - Transport System
3577	309	39	2026-10-06 00:36:10.334433	A309	Błąd Lini Niverplst - Easy Plast
3578	310	41	2026-10-06 00:36:10.334433	A310	Alarm Lini Niverplast - Transport System
3579	311	41	2026-10-06 00:36:10.334433	A311	Błąd Lini Niverplst - Transport System
3580	309	39	2026-10-06 00:37:10.391989	A309	Błąd Lini Niverplst - Easy Plast
3581	310	41	2026-10-06 00:37:10.391989	A310	Alarm Lini Niverplast - Transport System
3582	311	41	2026-10-06 00:37:10.391989	A311	Błąd Lini Niverplst - Transport System
3583	309	39	2026-10-06 00:38:10.46041	A309	Błąd Lini Niverplst - Easy Plast
3584	310	41	2026-10-06 00:38:10.46041	A310	Alarm Lini Niverplast - Transport System
3585	311	41	2026-10-06 00:38:10.46041	A311	Błąd Lini Niverplst - Transport System
3586	309	39	2026-10-06 00:39:10.518561	A309	Błąd Lini Niverplst - Easy Plast
3587	310	41	2026-10-06 00:39:10.518561	A310	Alarm Lini Niverplast - Transport System
3588	311	41	2026-10-06 00:39:10.518561	A311	Błąd Lini Niverplst - Transport System
3589	309	39	2026-10-06 00:40:10.5889	A309	Błąd Lini Niverplst - Easy Plast
3590	310	41	2026-10-06 00:40:10.5889	A310	Alarm Lini Niverplast - Transport System
3591	311	41	2026-10-06 00:40:10.5889	A311	Błąd Lini Niverplst - Transport System
3592	309	39	2026-10-06 00:41:10.639266	A309	Błąd Lini Niverplst - Easy Plast
3593	310	41	2026-10-06 00:41:10.639266	A310	Alarm Lini Niverplast - Transport System
3594	311	41	2026-10-06 00:41:10.639266	A311	Błąd Lini Niverplst - Transport System
3595	309	39	2026-10-06 00:42:10.695769	A309	Błąd Lini Niverplst - Easy Plast
3596	310	41	2026-10-06 00:42:10.695769	A310	Alarm Lini Niverplast - Transport System
3597	311	41	2026-10-06 00:42:10.695769	A311	Błąd Lini Niverplst - Transport System
3598	309	39	2026-10-06 00:43:10.75039	A309	Błąd Lini Niverplst - Easy Plast
3599	310	41	2026-10-06 00:43:10.75039	A310	Alarm Lini Niverplast - Transport System
3600	311	41	2026-10-06 00:43:10.75039	A311	Błąd Lini Niverplst - Transport System
3601	309	39	2026-10-06 00:44:10.833258	A309	Błąd Lini Niverplst - Easy Plast
3602	310	41	2026-10-06 00:44:10.833258	A310	Alarm Lini Niverplast - Transport System
3603	311	41	2026-10-06 00:44:10.833258	A311	Błąd Lini Niverplst - Transport System
3604	309	39	2026-10-06 00:45:10.877329	A309	Błąd Lini Niverplst - Easy Plast
3605	310	41	2026-10-06 00:45:10.877329	A310	Alarm Lini Niverplast - Transport System
3606	311	41	2026-10-06 00:45:10.877329	A311	Błąd Lini Niverplst - Transport System
3607	309	39	2026-10-06 00:46:10.934075	A309	Błąd Lini Niverplst - Easy Plast
3608	310	41	2026-10-06 00:46:10.934075	A310	Alarm Lini Niverplast - Transport System
3609	311	41	2026-10-06 00:46:10.934075	A311	Błąd Lini Niverplst - Transport System
3610	309	39	2026-10-06 00:47:11.01096	A309	Błąd Lini Niverplst - Easy Plast
3611	310	41	2026-10-06 00:47:11.01096	A310	Alarm Lini Niverplast - Transport System
3612	311	41	2026-10-06 00:47:11.01096	A311	Błąd Lini Niverplst - Transport System
3613	309	39	2026-10-06 00:48:11.053781	A309	Błąd Lini Niverplst - Easy Plast
3614	310	41	2026-10-06 00:48:11.053781	A310	Alarm Lini Niverplast - Transport System
3615	311	41	2026-10-06 00:48:11.053781	A311	Błąd Lini Niverplst - Transport System
3616	309	39	2026-10-06 00:49:11.118512	A309	Błąd Lini Niverplst - Easy Plast
3617	310	41	2026-10-06 00:49:11.118512	A310	Alarm Lini Niverplast - Transport System
3618	311	41	2026-10-06 00:49:11.118512	A311	Błąd Lini Niverplst - Transport System
3619	309	39	2026-10-06 00:50:11.176631	A309	Błąd Lini Niverplst - Easy Plast
3620	310	41	2026-10-06 00:50:11.176631	A310	Alarm Lini Niverplast - Transport System
3621	311	41	2026-10-06 00:50:11.176631	A311	Błąd Lini Niverplst - Transport System
3622	309	39	2026-10-06 00:51:11.247744	A309	Błąd Lini Niverplst - Easy Plast
3623	310	41	2026-10-06 00:51:11.247744	A310	Alarm Lini Niverplast - Transport System
3624	311	41	2026-10-06 00:51:11.247744	A311	Błąd Lini Niverplst - Transport System
3625	309	39	2026-10-06 00:52:11.294811	A309	Błąd Lini Niverplst - Easy Plast
3626	310	41	2026-10-06 00:52:11.294811	A310	Alarm Lini Niverplast - Transport System
3627	311	41	2026-10-06 00:52:11.294811	A311	Błąd Lini Niverplst - Transport System
3628	309	39	2026-10-06 00:53:11.36346	A309	Błąd Lini Niverplst - Easy Plast
3629	310	41	2026-10-06 00:53:11.36346	A310	Alarm Lini Niverplast - Transport System
3630	311	41	2026-10-06 00:53:11.36346	A311	Błąd Lini Niverplst - Transport System
3631	309	39	2026-10-06 00:54:11.433847	A309	Błąd Lini Niverplst - Easy Plast
3632	310	41	2026-10-06 00:54:11.433847	A310	Alarm Lini Niverplast - Transport System
3633	311	41	2026-10-06 00:54:11.433847	A311	Błąd Lini Niverplst - Transport System
3634	309	39	2026-10-06 00:55:11.495566	A309	Błąd Lini Niverplst - Easy Plast
3635	310	41	2026-10-06 00:55:11.495566	A310	Alarm Lini Niverplast - Transport System
3636	311	41	2026-10-06 00:55:11.495566	A311	Błąd Lini Niverplst - Transport System
3637	309	39	2026-10-06 00:56:11.563116	A309	Błąd Lini Niverplst - Easy Plast
3638	310	41	2026-10-06 00:56:11.563116	A310	Alarm Lini Niverplast - Transport System
3639	311	41	2026-10-06 00:56:11.563116	A311	Błąd Lini Niverplst - Transport System
3640	309	39	2026-10-06 00:57:11.600391	A309	Błąd Lini Niverplst - Easy Plast
3641	310	41	2026-10-06 00:57:11.600391	A310	Alarm Lini Niverplast - Transport System
3642	311	41	2026-10-06 00:57:11.600391	A311	Błąd Lini Niverplst - Transport System
3643	309	39	2026-10-06 00:58:11.663457	A309	Błąd Lini Niverplst - Easy Plast
3644	310	41	2026-10-06 00:58:11.663457	A310	Alarm Lini Niverplast - Transport System
3645	311	41	2026-10-06 00:58:11.663457	A311	Błąd Lini Niverplst - Transport System
3646	309	39	2026-10-06 00:59:11.728069	A309	Błąd Lini Niverplst - Easy Plast
3647	310	41	2026-10-06 00:59:11.728069	A310	Alarm Lini Niverplast - Transport System
3648	311	41	2026-10-06 00:59:11.728069	A311	Błąd Lini Niverplst - Transport System
3649	309	39	2026-10-06 01:00:11.784256	A309	Błąd Lini Niverplst - Easy Plast
3650	310	41	2026-10-06 01:00:11.784256	A310	Alarm Lini Niverplast - Transport System
3651	311	41	2026-10-06 01:00:11.784256	A311	Błąd Lini Niverplst - Transport System
3652	309	39	2026-10-06 01:01:11.850242	A309	Błąd Lini Niverplst - Easy Plast
3653	310	41	2026-10-06 01:01:11.850242	A310	Alarm Lini Niverplast - Transport System
3654	311	41	2026-10-06 01:01:11.850242	A311	Błąd Lini Niverplst - Transport System
3655	309	39	2026-10-06 01:02:11.909457	A309	Błąd Lini Niverplst - Easy Plast
3656	310	41	2026-10-06 01:02:11.909457	A310	Alarm Lini Niverplast - Transport System
3657	311	41	2026-10-06 01:02:11.909457	A311	Błąd Lini Niverplst - Transport System
3658	309	39	2026-10-06 01:03:11.954758	A309	Błąd Lini Niverplst - Easy Plast
3659	310	41	2026-10-06 01:03:11.954758	A310	Alarm Lini Niverplast - Transport System
3660	311	41	2026-10-06 01:03:11.954758	A311	Błąd Lini Niverplst - Transport System
3661	309	39	2026-10-06 01:04:12.034981	A309	Błąd Lini Niverplst - Easy Plast
3662	310	41	2026-10-06 01:04:12.034981	A310	Alarm Lini Niverplast - Transport System
3663	311	41	2026-10-06 01:04:12.034981	A311	Błąd Lini Niverplst - Transport System
3664	309	39	2026-10-06 01:05:12.094003	A309	Błąd Lini Niverplst - Easy Plast
3665	310	41	2026-10-06 01:05:12.094003	A310	Alarm Lini Niverplast - Transport System
3666	311	41	2026-10-06 01:05:12.094003	A311	Błąd Lini Niverplst - Transport System
3667	309	39	2026-10-06 01:06:12.146402	A309	Błąd Lini Niverplst - Easy Plast
3668	310	41	2026-10-06 01:06:12.146402	A310	Alarm Lini Niverplast - Transport System
3669	311	41	2026-10-06 01:06:12.146402	A311	Błąd Lini Niverplst - Transport System
3670	309	39	2026-10-06 01:07:12.211504	A309	Błąd Lini Niverplst - Easy Plast
3671	310	41	2026-10-06 01:07:12.211504	A310	Alarm Lini Niverplast - Transport System
3672	311	41	2026-10-06 01:07:12.211504	A311	Błąd Lini Niverplst - Transport System
3673	309	39	2026-10-06 01:08:12.267335	A309	Błąd Lini Niverplst - Easy Plast
3674	310	41	2026-10-06 01:08:12.267335	A310	Alarm Lini Niverplast - Transport System
3675	311	41	2026-10-06 01:08:12.267335	A311	Błąd Lini Niverplst - Transport System
3676	309	39	2026-10-06 01:09:12.330263	A309	Błąd Lini Niverplst - Easy Plast
3677	310	41	2026-10-06 01:09:12.330263	A310	Alarm Lini Niverplast - Transport System
3678	311	41	2026-10-06 01:09:12.330263	A311	Błąd Lini Niverplst - Transport System
3679	309	39	2026-10-06 01:10:12.403315	A309	Błąd Lini Niverplst - Easy Plast
3680	310	41	2026-10-06 01:10:12.403315	A310	Alarm Lini Niverplast - Transport System
3681	311	41	2026-10-06 01:10:12.403315	A311	Błąd Lini Niverplst - Transport System
3682	309	39	2026-10-06 01:11:12.4628	A309	Błąd Lini Niverplst - Easy Plast
3683	310	41	2026-10-06 01:11:12.4628	A310	Alarm Lini Niverplast - Transport System
3684	311	41	2026-10-06 01:11:12.4628	A311	Błąd Lini Niverplst - Transport System
3685	309	39	2026-10-06 01:12:13.115787	A309	Błąd Lini Niverplst - Easy Plast
3686	310	41	2026-10-06 01:12:13.115787	A310	Alarm Lini Niverplast - Transport System
3687	311	41	2026-10-06 01:12:13.115787	A311	Błąd Lini Niverplst - Transport System
3688	309	39	2026-10-06 01:13:12.580937	A309	Błąd Lini Niverplst - Easy Plast
3689	310	41	2026-10-06 01:13:12.580937	A310	Alarm Lini Niverplast - Transport System
3690	311	41	2026-10-06 01:13:12.580937	A311	Błąd Lini Niverplst - Transport System
3691	309	39	2026-10-06 01:14:12.644111	A309	Błąd Lini Niverplst - Easy Plast
3692	310	41	2026-10-06 01:14:12.644111	A310	Alarm Lini Niverplast - Transport System
3693	311	41	2026-10-06 01:14:12.644111	A311	Błąd Lini Niverplst - Transport System
3694	309	39	2026-10-06 01:15:12.716592	A309	Błąd Lini Niverplst - Easy Plast
3695	310	41	2026-10-06 01:15:12.716592	A310	Alarm Lini Niverplast - Transport System
3696	311	41	2026-10-06 01:15:12.716592	A311	Błąd Lini Niverplst - Transport System
3697	309	39	2026-10-06 01:16:12.758286	A309	Błąd Lini Niverplst - Easy Plast
3698	310	41	2026-10-06 01:16:12.758286	A310	Alarm Lini Niverplast - Transport System
3699	311	41	2026-10-06 01:16:12.758286	A311	Błąd Lini Niverplst - Transport System
3700	309	39	2026-10-06 01:17:12.810744	A309	Błąd Lini Niverplst - Easy Plast
3701	310	41	2026-10-06 01:17:12.810744	A310	Alarm Lini Niverplast - Transport System
3702	311	41	2026-10-06 01:17:12.810744	A311	Błąd Lini Niverplst - Transport System
3703	309	39	2026-10-06 01:18:12.867759	A309	Błąd Lini Niverplst - Easy Plast
3704	310	41	2026-10-06 01:18:12.867759	A310	Alarm Lini Niverplast - Transport System
3705	311	41	2026-10-06 01:18:12.867759	A311	Błąd Lini Niverplst - Transport System
3706	309	39	2026-10-06 01:19:12.931801	A309	Błąd Lini Niverplst - Easy Plast
3707	310	41	2026-10-06 01:19:12.931801	A310	Alarm Lini Niverplast - Transport System
3708	311	41	2026-10-06 01:19:12.931801	A311	Błąd Lini Niverplst - Transport System
3709	309	39	2026-10-06 01:20:12.982834	A309	Błąd Lini Niverplst - Easy Plast
3710	310	41	2026-10-06 01:20:12.982834	A310	Alarm Lini Niverplast - Transport System
3711	311	41	2026-10-06 01:20:12.982834	A311	Błąd Lini Niverplst - Transport System
3712	309	39	2026-10-06 01:21:13.046753	A309	Błąd Lini Niverplst - Easy Plast
3713	310	41	2026-10-06 01:21:13.046753	A310	Alarm Lini Niverplast - Transport System
3714	311	41	2026-10-06 01:21:13.046753	A311	Błąd Lini Niverplst - Transport System
3715	309	39	2026-10-06 01:22:13.110708	A309	Błąd Lini Niverplst - Easy Plast
3716	310	41	2026-10-06 01:22:13.110708	A310	Alarm Lini Niverplast - Transport System
3717	311	41	2026-10-06 01:22:13.110708	A311	Błąd Lini Niverplst - Transport System
3718	309	39	2026-10-06 01:23:13.172035	A309	Błąd Lini Niverplst - Easy Plast
3719	310	41	2026-10-06 01:23:13.172035	A310	Alarm Lini Niverplast - Transport System
3720	311	41	2026-10-06 01:23:13.172035	A311	Błąd Lini Niverplst - Transport System
3721	309	39	2026-10-06 01:24:13.223862	A309	Błąd Lini Niverplst - Easy Plast
3722	310	41	2026-10-06 01:24:13.223862	A310	Alarm Lini Niverplast - Transport System
3723	311	41	2026-10-06 01:24:13.223862	A311	Błąd Lini Niverplst - Transport System
3724	309	39	2026-10-06 01:25:13.284756	A309	Błąd Lini Niverplst - Easy Plast
3725	310	41	2026-10-06 01:25:13.284756	A310	Alarm Lini Niverplast - Transport System
3726	311	41	2026-10-06 01:25:13.284756	A311	Błąd Lini Niverplst - Transport System
3727	309	39	2026-10-06 01:26:13.34096	A309	Błąd Lini Niverplst - Easy Plast
3728	310	41	2026-10-06 01:26:13.34096	A310	Alarm Lini Niverplast - Transport System
3729	311	41	2026-10-06 01:26:13.34096	A311	Błąd Lini Niverplst - Transport System
3730	309	39	2026-10-06 01:27:13.406644	A309	Błąd Lini Niverplst - Easy Plast
3731	310	41	2026-10-06 01:27:13.406644	A310	Alarm Lini Niverplast - Transport System
3732	311	41	2026-10-06 01:27:13.406644	A311	Błąd Lini Niverplst - Transport System
3733	309	39	2026-10-06 01:28:13.466923	A309	Błąd Lini Niverplst - Easy Plast
3734	310	41	2026-10-06 01:28:13.466923	A310	Alarm Lini Niverplast - Transport System
3735	311	41	2026-10-06 01:28:13.466923	A311	Błąd Lini Niverplst - Transport System
3736	309	39	2026-10-06 01:29:13.537113	A309	Błąd Lini Niverplst - Easy Plast
3737	310	41	2026-10-06 01:29:13.537113	A310	Alarm Lini Niverplast - Transport System
3738	311	41	2026-10-06 01:29:13.537113	A311	Błąd Lini Niverplst - Transport System
3739	309	39	2026-10-06 01:30:13.575566	A309	Błąd Lini Niverplst - Easy Plast
3740	310	41	2026-10-06 01:30:13.575566	A310	Alarm Lini Niverplast - Transport System
3741	311	41	2026-10-06 01:30:13.575566	A311	Błąd Lini Niverplst - Transport System
3742	309	39	2026-10-06 01:31:13.659375	A309	Błąd Lini Niverplst - Easy Plast
3743	310	41	2026-10-06 01:31:13.659375	A310	Alarm Lini Niverplast - Transport System
3744	311	41	2026-10-06 01:31:13.659375	A311	Błąd Lini Niverplst - Transport System
3745	309	39	2026-10-06 01:32:13.712906	A309	Błąd Lini Niverplst - Easy Plast
3746	310	41	2026-10-06 01:32:13.712906	A310	Alarm Lini Niverplast - Transport System
3747	311	41	2026-10-06 01:32:13.712906	A311	Błąd Lini Niverplst - Transport System
3748	309	39	2026-10-06 01:33:13.763824	A309	Błąd Lini Niverplst - Easy Plast
3749	310	41	2026-10-06 01:33:13.763824	A310	Alarm Lini Niverplast - Transport System
3750	311	41	2026-10-06 01:33:13.763824	A311	Błąd Lini Niverplst - Transport System
3751	309	39	2026-10-06 01:34:13.840847	A309	Błąd Lini Niverplst - Easy Plast
3752	310	41	2026-10-06 01:34:13.840847	A310	Alarm Lini Niverplast - Transport System
3753	311	41	2026-10-06 01:34:13.840847	A311	Błąd Lini Niverplst - Transport System
3754	309	39	2026-10-06 01:35:13.88124	A309	Błąd Lini Niverplst - Easy Plast
3755	310	41	2026-10-06 01:35:13.88124	A310	Alarm Lini Niverplast - Transport System
3756	311	41	2026-10-06 01:35:13.88124	A311	Błąd Lini Niverplst - Transport System
3757	309	39	2026-10-06 01:36:13.94464	A309	Błąd Lini Niverplst - Easy Plast
3758	310	41	2026-10-06 01:36:13.94464	A310	Alarm Lini Niverplast - Transport System
3759	311	41	2026-10-06 01:36:13.94464	A311	Błąd Lini Niverplst - Transport System
3760	309	39	2026-10-06 01:37:14.01255	A309	Błąd Lini Niverplst - Easy Plast
3761	310	41	2026-10-06 01:37:14.01255	A310	Alarm Lini Niverplast - Transport System
3762	311	41	2026-10-06 01:37:14.01255	A311	Błąd Lini Niverplst - Transport System
3763	309	39	2026-10-06 01:38:14.066419	A309	Błąd Lini Niverplst - Easy Plast
3764	310	41	2026-10-06 01:38:14.066419	A310	Alarm Lini Niverplast - Transport System
3765	311	41	2026-10-06 01:38:14.066419	A311	Błąd Lini Niverplst - Transport System
3766	309	39	2026-10-06 01:39:14.234882	A309	Błąd Lini Niverplst - Easy Plast
3767	310	41	2026-10-06 01:39:14.234882	A310	Alarm Lini Niverplast - Transport System
3768	311	41	2026-10-06 01:39:14.234882	A311	Błąd Lini Niverplst - Transport System
3769	309	39	2026-10-06 01:40:14.195998	A309	Błąd Lini Niverplst - Easy Plast
3770	310	41	2026-10-06 01:40:14.195998	A310	Alarm Lini Niverplast - Transport System
3771	311	41	2026-10-06 01:40:14.195998	A311	Błąd Lini Niverplst - Transport System
3772	309	39	2026-10-06 01:41:14.251849	A309	Błąd Lini Niverplst - Easy Plast
3773	310	41	2026-10-06 01:41:14.251849	A310	Alarm Lini Niverplast - Transport System
3774	311	41	2026-10-06 01:41:14.251849	A311	Błąd Lini Niverplst - Transport System
3775	309	39	2026-10-06 01:42:14.311557	A309	Błąd Lini Niverplst - Easy Plast
3776	310	41	2026-10-06 01:42:14.311557	A310	Alarm Lini Niverplast - Transport System
3777	311	41	2026-10-06 01:42:14.311557	A311	Błąd Lini Niverplst - Transport System
3778	309	39	2026-10-06 01:43:14.356364	A309	Błąd Lini Niverplst - Easy Plast
3779	310	41	2026-10-06 01:43:14.356364	A310	Alarm Lini Niverplast - Transport System
3780	311	41	2026-10-06 01:43:14.356364	A311	Błąd Lini Niverplst - Transport System
3781	309	39	2026-10-06 01:44:14.410591	A309	Błąd Lini Niverplst - Easy Plast
3782	310	41	2026-10-06 01:44:14.410591	A310	Alarm Lini Niverplast - Transport System
3783	311	41	2026-10-06 01:44:14.410591	A311	Błąd Lini Niverplst - Transport System
3784	309	39	2026-10-06 01:45:14.483871	A309	Błąd Lini Niverplst - Easy Plast
3785	310	41	2026-10-06 01:45:14.483871	A310	Alarm Lini Niverplast - Transport System
3786	311	41	2026-10-06 01:45:14.483871	A311	Błąd Lini Niverplst - Transport System
3787	309	39	2026-10-06 01:46:14.559208	A309	Błąd Lini Niverplst - Easy Plast
3788	310	41	2026-10-06 01:46:14.559208	A310	Alarm Lini Niverplast - Transport System
3789	311	41	2026-10-06 01:46:14.559208	A311	Błąd Lini Niverplst - Transport System
3790	309	39	2026-10-06 01:47:14.602273	A309	Błąd Lini Niverplst - Easy Plast
3791	310	41	2026-10-06 01:47:14.602273	A310	Alarm Lini Niverplast - Transport System
3792	311	41	2026-10-06 01:47:14.602273	A311	Błąd Lini Niverplst - Transport System
3793	309	39	2026-10-06 01:48:14.68184	A309	Błąd Lini Niverplst - Easy Plast
3794	310	41	2026-10-06 01:48:14.68184	A310	Alarm Lini Niverplast - Transport System
3795	311	41	2026-10-06 01:48:14.68184	A311	Błąd Lini Niverplst - Transport System
3796	309	39	2026-10-06 01:49:14.725736	A309	Błąd Lini Niverplst - Easy Plast
3797	310	41	2026-10-06 01:49:14.725736	A310	Alarm Lini Niverplast - Transport System
3798	311	41	2026-10-06 01:49:14.725736	A311	Błąd Lini Niverplst - Transport System
3799	309	39	2026-10-06 01:50:14.810972	A309	Błąd Lini Niverplst - Easy Plast
3800	310	41	2026-10-06 01:50:14.810972	A310	Alarm Lini Niverplast - Transport System
3801	311	41	2026-10-06 01:50:14.810972	A311	Błąd Lini Niverplst - Transport System
3802	309	39	2026-10-06 01:51:14.855559	A309	Błąd Lini Niverplst - Easy Plast
3803	310	41	2026-10-06 01:51:14.855559	A310	Alarm Lini Niverplast - Transport System
3804	311	41	2026-10-06 01:51:14.855559	A311	Błąd Lini Niverplst - Transport System
3805	309	39	2026-10-06 01:52:14.91179	A309	Błąd Lini Niverplst - Easy Plast
3806	310	41	2026-10-06 01:52:14.91179	A310	Alarm Lini Niverplast - Transport System
3807	311	41	2026-10-06 01:52:14.91179	A311	Błąd Lini Niverplst - Transport System
3808	309	39	2026-10-06 01:53:14.960419	A309	Błąd Lini Niverplst - Easy Plast
3809	310	41	2026-10-06 01:53:14.960419	A310	Alarm Lini Niverplast - Transport System
3810	311	41	2026-10-06 01:53:14.960419	A311	Błąd Lini Niverplst - Transport System
3811	309	39	2026-10-06 01:54:15.033945	A309	Błąd Lini Niverplst - Easy Plast
3812	310	41	2026-10-06 01:54:15.033945	A310	Alarm Lini Niverplast - Transport System
3813	311	41	2026-10-06 01:54:15.033945	A311	Błąd Lini Niverplst - Transport System
3814	309	39	2026-10-06 01:55:15.080585	A309	Błąd Lini Niverplst - Easy Plast
3815	310	41	2026-10-06 01:55:15.080585	A310	Alarm Lini Niverplast - Transport System
3816	311	41	2026-10-06 01:55:15.080585	A311	Błąd Lini Niverplst - Transport System
3817	309	39	2026-10-06 01:56:15.134276	A309	Błąd Lini Niverplst - Easy Plast
3818	310	41	2026-10-06 01:56:15.134276	A310	Alarm Lini Niverplast - Transport System
3819	311	41	2026-10-06 01:56:15.134276	A311	Błąd Lini Niverplst - Transport System
3820	309	39	2026-10-06 01:57:15.206051	A309	Błąd Lini Niverplst - Easy Plast
3821	310	41	2026-10-06 01:57:15.206051	A310	Alarm Lini Niverplast - Transport System
3822	311	41	2026-10-06 01:57:15.206051	A311	Błąd Lini Niverplst - Transport System
3823	309	39	2026-10-06 01:58:15.272399	A309	Błąd Lini Niverplst - Easy Plast
3824	310	41	2026-10-06 01:58:15.272399	A310	Alarm Lini Niverplast - Transport System
3825	311	41	2026-10-06 01:58:15.272399	A311	Błąd Lini Niverplst - Transport System
3826	309	39	2026-10-06 01:59:15.321549	A309	Błąd Lini Niverplst - Easy Plast
3827	310	41	2026-10-06 01:59:15.321549	A310	Alarm Lini Niverplast - Transport System
3828	311	41	2026-10-06 01:59:15.321549	A311	Błąd Lini Niverplst - Transport System
3829	309	39	2026-10-06 02:00:15.380218	A309	Błąd Lini Niverplst - Easy Plast
3830	310	41	2026-10-06 02:00:15.380218	A310	Alarm Lini Niverplast - Transport System
3831	311	41	2026-10-06 02:00:15.380218	A311	Błąd Lini Niverplst - Transport System
3832	309	39	2026-10-06 02:01:15.437973	A309	Błąd Lini Niverplst - Easy Plast
3833	310	41	2026-10-06 02:01:15.437973	A310	Alarm Lini Niverplast - Transport System
3834	311	41	2026-10-06 02:01:15.437973	A311	Błąd Lini Niverplst - Transport System
3835	309	39	2026-10-06 02:02:15.502412	A309	Błąd Lini Niverplst - Easy Plast
3836	310	41	2026-10-06 02:02:15.502412	A310	Alarm Lini Niverplast - Transport System
3837	311	41	2026-10-06 02:02:15.502412	A311	Błąd Lini Niverplst - Transport System
3838	309	39	2026-10-06 02:03:15.553697	A309	Błąd Lini Niverplst - Easy Plast
3839	310	41	2026-10-06 02:03:15.553697	A310	Alarm Lini Niverplast - Transport System
3840	311	41	2026-10-06 02:03:15.553697	A311	Błąd Lini Niverplst - Transport System
3841	309	39	2026-10-06 02:04:15.848257	A309	Błąd Lini Niverplst - Easy Plast
3842	310	41	2026-10-06 02:04:15.848257	A310	Alarm Lini Niverplast - Transport System
3843	311	41	2026-10-06 02:04:15.848257	A311	Błąd Lini Niverplst - Transport System
3844	309	39	2026-10-06 02:05:15.702758	A309	Błąd Lini Niverplst - Easy Plast
3845	310	41	2026-10-06 02:05:15.702758	A310	Alarm Lini Niverplast - Transport System
3846	311	41	2026-10-06 02:05:15.702758	A311	Błąd Lini Niverplst - Transport System
3847	309	39	2026-10-06 02:06:15.728483	A309	Błąd Lini Niverplst - Easy Plast
3848	310	41	2026-10-06 02:06:15.728483	A310	Alarm Lini Niverplast - Transport System
3849	311	41	2026-10-06 02:06:15.728483	A311	Błąd Lini Niverplst - Transport System
3850	309	39	2026-10-06 02:07:16.396434	A309	Błąd Lini Niverplst - Easy Plast
3851	310	41	2026-10-06 02:07:16.396434	A310	Alarm Lini Niverplast - Transport System
3852	311	41	2026-10-06 02:07:16.396434	A311	Błąd Lini Niverplst - Transport System
3853	309	39	2026-10-06 02:08:15.834516	A309	Błąd Lini Niverplst - Easy Plast
3854	310	41	2026-10-06 02:08:15.834516	A310	Alarm Lini Niverplast - Transport System
3855	311	41	2026-10-06 02:08:15.834516	A311	Błąd Lini Niverplst - Transport System
3856	309	39	2026-10-06 02:09:15.903175	A309	Błąd Lini Niverplst - Easy Plast
3857	310	41	2026-10-06 02:09:15.903175	A310	Alarm Lini Niverplast - Transport System
3858	311	41	2026-10-06 02:09:15.903175	A311	Błąd Lini Niverplst - Transport System
3859	309	39	2026-10-06 02:10:15.9502	A309	Błąd Lini Niverplst - Easy Plast
3860	310	41	2026-10-06 02:10:15.9502	A310	Alarm Lini Niverplast - Transport System
3861	311	41	2026-10-06 02:10:15.9502	A311	Błąd Lini Niverplst - Transport System
3862	309	39	2026-10-06 02:11:16.008991	A309	Błąd Lini Niverplst - Easy Plast
3863	310	41	2026-10-06 02:11:16.008991	A310	Alarm Lini Niverplast - Transport System
3864	311	41	2026-10-06 02:11:16.008991	A311	Błąd Lini Niverplst - Transport System
3865	309	39	2026-10-06 02:12:16.093118	A309	Błąd Lini Niverplst - Easy Plast
3866	310	41	2026-10-06 02:12:16.093118	A310	Alarm Lini Niverplast - Transport System
3867	311	41	2026-10-06 02:12:16.093118	A311	Błąd Lini Niverplst - Transport System
3868	309	39	2026-10-06 02:13:16.11656	A309	Błąd Lini Niverplst - Easy Plast
3869	310	41	2026-10-06 02:13:16.11656	A310	Alarm Lini Niverplast - Transport System
3870	311	41	2026-10-06 02:13:16.11656	A311	Błąd Lini Niverplst - Transport System
3871	309	39	2026-10-06 02:14:16.172023	A309	Błąd Lini Niverplst - Easy Plast
3872	310	41	2026-10-06 02:14:16.172023	A310	Alarm Lini Niverplast - Transport System
3873	311	41	2026-10-06 02:14:16.172023	A311	Błąd Lini Niverplst - Transport System
3874	309	39	2026-10-06 02:15:16.245225	A309	Błąd Lini Niverplst - Easy Plast
3875	310	41	2026-10-06 02:15:16.245225	A310	Alarm Lini Niverplast - Transport System
3876	311	41	2026-10-06 02:15:16.245225	A311	Błąd Lini Niverplst - Transport System
3877	309	39	2026-10-06 02:16:16.296707	A309	Błąd Lini Niverplst - Easy Plast
3878	310	41	2026-10-06 02:16:16.296707	A310	Alarm Lini Niverplast - Transport System
3879	311	41	2026-10-06 02:16:16.296707	A311	Błąd Lini Niverplst - Transport System
3880	309	39	2026-10-06 02:17:16.352696	A309	Błąd Lini Niverplst - Easy Plast
3881	310	41	2026-10-06 02:17:16.352696	A310	Alarm Lini Niverplast - Transport System
3882	311	41	2026-10-06 02:17:16.352696	A311	Błąd Lini Niverplst - Transport System
3883	309	39	2026-10-06 02:18:16.414395	A309	Błąd Lini Niverplst - Easy Plast
3884	310	41	2026-10-06 02:18:16.414395	A310	Alarm Lini Niverplast - Transport System
3885	311	41	2026-10-06 02:18:16.414395	A311	Błąd Lini Niverplst - Transport System
3886	309	39	2026-10-06 02:19:16.256572	A309	Błąd Lini Niverplst - Easy Plast
3887	310	41	2026-10-06 02:19:16.256572	A310	Alarm Lini Niverplast - Transport System
3888	311	41	2026-10-06 02:19:16.256572	A311	Błąd Lini Niverplst - Transport System
3889	309	39	2026-10-06 02:20:16.491642	A309	Błąd Lini Niverplst - Easy Plast
3890	310	41	2026-10-06 02:20:16.491642	A310	Alarm Lini Niverplast - Transport System
3891	311	41	2026-10-06 02:20:16.491642	A311	Błąd Lini Niverplst - Transport System
3892	309	39	2026-10-06 02:21:16.560959	A309	Błąd Lini Niverplst - Easy Plast
3893	310	41	2026-10-06 02:21:16.560959	A310	Alarm Lini Niverplast - Transport System
3894	311	41	2026-10-06 02:21:16.560959	A311	Błąd Lini Niverplst - Transport System
3895	309	39	2026-10-06 02:22:16.617505	A309	Błąd Lini Niverplst - Easy Plast
3896	310	41	2026-10-06 02:22:16.617505	A310	Alarm Lini Niverplast - Transport System
3897	311	41	2026-10-06 02:22:16.617505	A311	Błąd Lini Niverplst - Transport System
3898	309	39	2026-10-06 02:23:16.659349	A309	Błąd Lini Niverplst - Easy Plast
3899	310	41	2026-10-06 02:23:16.659349	A310	Alarm Lini Niverplast - Transport System
3900	311	41	2026-10-06 02:23:16.659349	A311	Błąd Lini Niverplst - Transport System
3901	309	39	2026-10-06 02:24:16.707169	A309	Błąd Lini Niverplst - Easy Plast
3902	310	41	2026-10-06 02:24:16.707169	A310	Alarm Lini Niverplast - Transport System
3903	311	41	2026-10-06 02:24:16.707169	A311	Błąd Lini Niverplst - Transport System
3904	309	39	2026-10-06 02:25:16.786115	A309	Błąd Lini Niverplst - Easy Plast
3905	310	41	2026-10-06 02:25:16.786115	A310	Alarm Lini Niverplast - Transport System
3906	311	41	2026-10-06 02:25:16.786115	A311	Błąd Lini Niverplst - Transport System
3907	309	39	2026-10-06 02:26:16.805183	A309	Błąd Lini Niverplst - Easy Plast
3908	310	41	2026-10-06 02:26:16.805183	A310	Alarm Lini Niverplast - Transport System
3909	311	41	2026-10-06 02:26:16.805183	A311	Błąd Lini Niverplst - Transport System
3910	309	39	2026-10-06 02:27:16.866687	A309	Błąd Lini Niverplst - Easy Plast
3911	310	41	2026-10-06 02:27:16.866687	A310	Alarm Lini Niverplast - Transport System
3912	311	41	2026-10-06 02:27:16.866687	A311	Błąd Lini Niverplst - Transport System
3913	309	39	2026-10-06 02:28:16.883169	A309	Błąd Lini Niverplst - Easy Plast
3914	310	41	2026-10-06 02:28:16.883169	A310	Alarm Lini Niverplast - Transport System
3915	311	41	2026-10-06 02:28:16.883169	A311	Błąd Lini Niverplst - Transport System
3916	309	39	2026-10-06 02:29:16.951693	A309	Błąd Lini Niverplst - Easy Plast
3917	310	41	2026-10-06 02:29:16.951693	A310	Alarm Lini Niverplast - Transport System
3918	311	41	2026-10-06 02:29:16.951693	A311	Błąd Lini Niverplst - Transport System
3919	309	39	2026-10-06 02:30:17.017094	A309	Błąd Lini Niverplst - Easy Plast
3920	310	41	2026-10-06 02:30:17.017094	A310	Alarm Lini Niverplast - Transport System
3921	311	41	2026-10-06 02:30:17.017094	A311	Błąd Lini Niverplst - Transport System
3922	309	39	2026-10-06 02:31:17.100895	A309	Błąd Lini Niverplst - Easy Plast
3923	310	41	2026-10-06 02:31:17.100895	A310	Alarm Lini Niverplast - Transport System
3924	311	41	2026-10-06 02:31:17.100895	A311	Błąd Lini Niverplst - Transport System
3925	309	39	2026-10-06 02:32:17.00256	A309	Błąd Lini Niverplst - Easy Plast
3926	310	41	2026-10-06 02:32:17.00256	A310	Alarm Lini Niverplast - Transport System
3927	311	41	2026-10-06 02:32:17.00256	A311	Błąd Lini Niverplst - Transport System
3928	193	40	2026-10-06 02:33:17.063107	A193	Niskie ciśnienie pneumatyczne - strefa 2
3929	241	40	2026-10-06 02:33:17.063107	A241	Niskie ciśnienie pneumatyczne - strefa 3
3930	309	39	2026-10-06 02:33:17.063107	A309	Błąd Lini Niverplst - Easy Plast
3931	310	41	2026-10-06 02:33:17.063107	A310	Alarm Lini Niverplast - Transport System
3932	311	41	2026-10-06 02:33:17.063107	A311	Błąd Lini Niverplst - Transport System
3933	225	8	2026-10-06 02:33:17.063107	A225	Otwarta Bramka Bezpieczeństwa
3934	226	9	2026-10-06 02:33:17.063107	A226	Niezaryglowany zamek bramki bezpieczenstwa 
3935	309	39	2026-10-06 02:34:17.115794	A309	Błąd Lini Niverplst - Easy Plast
3936	310	41	2026-10-06 02:34:17.115794	A310	Alarm Lini Niverplast - Transport System
3937	311	41	2026-10-06 02:34:17.115794	A311	Błąd Lini Niverplst - Transport System
3938	309	39	2026-10-06 02:35:17.17971	A309	Błąd Lini Niverplst - Easy Plast
3939	310	41	2026-10-06 02:35:17.17971	A310	Alarm Lini Niverplast - Transport System
3940	311	41	2026-10-06 02:35:17.17971	A311	Błąd Lini Niverplst - Transport System
3941	309	39	2026-10-06 02:36:17.233831	A309	Błąd Lini Niverplst - Easy Plast
3942	310	41	2026-10-06 02:36:17.233831	A310	Alarm Lini Niverplast - Transport System
3943	311	41	2026-10-06 02:36:17.233831	A311	Błąd Lini Niverplst - Transport System
3944	309	39	2026-10-06 02:37:17.28017	A309	Błąd Lini Niverplst - Easy Plast
3945	310	41	2026-10-06 02:37:17.28017	A310	Alarm Lini Niverplast - Transport System
3946	311	41	2026-10-06 02:37:17.28017	A311	Błąd Lini Niverplst - Transport System
3947	309	39	2026-10-06 02:38:17.355645	A309	Błąd Lini Niverplst - Easy Plast
3948	310	41	2026-10-06 02:38:17.355645	A310	Alarm Lini Niverplast - Transport System
3949	311	41	2026-10-06 02:38:17.355645	A311	Błąd Lini Niverplst - Transport System
3950	309	39	2026-10-06 02:39:17.442328	A309	Błąd Lini Niverplst - Easy Plast
3951	310	41	2026-10-06 02:39:17.442328	A310	Alarm Lini Niverplast - Transport System
3952	311	41	2026-10-06 02:39:17.442328	A311	Błąd Lini Niverplst - Transport System
3953	309	39	2026-10-06 02:40:17.476736	A309	Błąd Lini Niverplst - Easy Plast
3954	310	41	2026-10-06 02:40:17.476736	A310	Alarm Lini Niverplast - Transport System
3955	311	41	2026-10-06 02:40:17.476736	A311	Błąd Lini Niverplst - Transport System
3956	309	39	2026-10-06 02:41:17.440305	A309	Błąd Lini Niverplst - Easy Plast
3957	310	41	2026-10-06 02:41:17.440305	A310	Alarm Lini Niverplast - Transport System
3958	311	41	2026-10-06 02:41:17.440305	A311	Błąd Lini Niverplst - Transport System
3959	309	39	2026-10-06 02:42:17.466922	A309	Błąd Lini Niverplst - Easy Plast
3960	310	41	2026-10-06 02:42:17.466922	A310	Alarm Lini Niverplast - Transport System
3961	311	41	2026-10-06 02:42:17.466922	A311	Błąd Lini Niverplst - Transport System
3962	309	39	2026-10-06 02:43:17.642463	A309	Błąd Lini Niverplst - Easy Plast
3963	310	41	2026-10-06 02:43:17.642463	A310	Alarm Lini Niverplast - Transport System
3964	311	41	2026-10-06 02:43:17.642463	A311	Błąd Lini Niverplst - Transport System
3965	309	39	2026-10-06 02:44:17.691885	A309	Błąd Lini Niverplst - Easy Plast
3966	310	41	2026-10-06 02:44:17.691885	A310	Alarm Lini Niverplast - Transport System
3967	311	41	2026-10-06 02:44:17.691885	A311	Błąd Lini Niverplst - Transport System
3968	309	39	2026-10-06 02:45:17.794312	A309	Błąd Lini Niverplst - Easy Plast
3969	310	41	2026-10-06 02:45:17.794312	A310	Alarm Lini Niverplast - Transport System
3970	311	41	2026-10-06 02:45:17.794312	A311	Błąd Lini Niverplst - Transport System
3971	309	39	2026-10-06 02:46:17.864109	A309	Błąd Lini Niverplst - Easy Plast
3972	310	41	2026-10-06 02:46:17.864109	A310	Alarm Lini Niverplast - Transport System
3973	311	41	2026-10-06 02:46:17.864109	A311	Błąd Lini Niverplst - Transport System
3974	309	39	2026-10-06 02:47:18.053617	A309	Błąd Lini Niverplst - Easy Plast
3975	310	41	2026-10-06 02:47:18.053617	A310	Alarm Lini Niverplast - Transport System
3976	311	41	2026-10-06 02:47:18.053617	A311	Błąd Lini Niverplst - Transport System
3977	309	39	2026-10-06 02:48:17.965563	A309	Błąd Lini Niverplst - Easy Plast
3978	310	41	2026-10-06 02:48:17.965563	A310	Alarm Lini Niverplast - Transport System
3979	311	41	2026-10-06 02:48:17.965563	A311	Błąd Lini Niverplst - Transport System
3980	309	39	2026-10-06 02:49:18.033938	A309	Błąd Lini Niverplst - Easy Plast
3981	310	41	2026-10-06 02:49:18.033938	A310	Alarm Lini Niverplast - Transport System
3982	311	41	2026-10-06 02:49:18.033938	A311	Błąd Lini Niverplst - Transport System
3983	309	39	2026-10-06 02:50:18.072005	A309	Błąd Lini Niverplst - Easy Plast
3984	310	41	2026-10-06 02:50:18.072005	A310	Alarm Lini Niverplast - Transport System
3985	311	41	2026-10-06 02:50:18.072005	A311	Błąd Lini Niverplst - Transport System
3986	309	39	2026-10-06 02:51:18.150111	A309	Błąd Lini Niverplst - Easy Plast
3987	310	41	2026-10-06 02:51:18.150111	A310	Alarm Lini Niverplast - Transport System
3988	311	41	2026-10-06 02:51:18.150111	A311	Błąd Lini Niverplst - Transport System
3989	309	39	2026-10-06 02:52:18.217375	A309	Błąd Lini Niverplst - Easy Plast
3990	310	41	2026-10-06 02:52:18.217375	A310	Alarm Lini Niverplast - Transport System
3991	311	41	2026-10-06 02:52:18.217375	A311	Błąd Lini Niverplst - Transport System
3992	309	39	2026-10-06 02:53:18.281833	A309	Błąd Lini Niverplst - Easy Plast
3993	310	41	2026-10-06 02:53:18.281833	A310	Alarm Lini Niverplast - Transport System
3994	311	41	2026-10-06 02:53:18.281833	A311	Błąd Lini Niverplst - Transport System
3995	309	39	2026-10-06 02:54:18.356304	A309	Błąd Lini Niverplst - Easy Plast
3996	310	41	2026-10-06 02:54:18.356304	A310	Alarm Lini Niverplast - Transport System
3997	311	41	2026-10-06 02:54:18.356304	A311	Błąd Lini Niverplst - Transport System
3998	309	39	2026-10-06 02:55:18.403074	A309	Błąd Lini Niverplst - Easy Plast
3999	310	41	2026-10-06 02:55:18.403074	A310	Alarm Lini Niverplast - Transport System
4000	311	41	2026-10-06 02:55:18.403074	A311	Błąd Lini Niverplst - Transport System
4001	309	39	2026-10-06 02:56:18.479566	A309	Błąd Lini Niverplst - Easy Plast
4002	310	41	2026-10-06 02:56:18.479566	A310	Alarm Lini Niverplast - Transport System
4003	311	41	2026-10-06 02:56:18.479566	A311	Błąd Lini Niverplst - Transport System
4004	309	39	2026-10-06 02:57:18.524975	A309	Błąd Lini Niverplst - Easy Plast
4005	310	41	2026-10-06 02:57:18.524975	A310	Alarm Lini Niverplast - Transport System
4006	311	41	2026-10-06 02:57:18.524975	A311	Błąd Lini Niverplst - Transport System
4007	309	39	2026-10-06 02:58:18.596173	A309	Błąd Lini Niverplst - Easy Plast
4008	310	41	2026-10-06 02:58:18.596173	A310	Alarm Lini Niverplast - Transport System
4009	311	41	2026-10-06 02:58:18.596173	A311	Błąd Lini Niverplst - Transport System
4010	309	39	2026-10-06 02:59:18.645061	A309	Błąd Lini Niverplst - Easy Plast
4011	310	41	2026-10-06 02:59:18.645061	A310	Alarm Lini Niverplast - Transport System
4012	311	41	2026-10-06 02:59:18.645061	A311	Błąd Lini Niverplst - Transport System
4013	309	39	2026-10-06 03:00:18.70755	A309	Błąd Lini Niverplst - Easy Plast
4014	310	41	2026-10-06 03:00:18.70755	A310	Alarm Lini Niverplast - Transport System
4015	311	41	2026-10-06 03:00:18.70755	A311	Błąd Lini Niverplst - Transport System
4016	309	39	2026-10-06 03:01:18.763991	A309	Błąd Lini Niverplst - Easy Plast
4017	310	41	2026-10-06 03:01:18.763991	A310	Alarm Lini Niverplast - Transport System
4018	311	41	2026-10-06 03:01:18.763991	A311	Błąd Lini Niverplst - Transport System
4019	106	2	2026-10-06 03:01:18.763991	A106	Błąd pudełko zostało odrzucone
4020	309	39	2026-10-06 03:02:18.835953	A309	Błąd Lini Niverplst - Easy Plast
4021	310	41	2026-10-06 03:02:18.835953	A310	Alarm Lini Niverplast - Transport System
4022	311	41	2026-10-06 03:02:18.835953	A311	Błąd Lini Niverplst - Transport System
4023	309	39	2026-10-06 03:03:18.90316	A309	Błąd Lini Niverplst - Easy Plast
4024	310	41	2026-10-06 03:03:18.90316	A310	Alarm Lini Niverplast - Transport System
4025	311	41	2026-10-06 03:03:18.90316	A311	Błąd Lini Niverplst - Transport System
4026	309	39	2026-10-06 03:04:18.984516	A309	Błąd Lini Niverplst - Easy Plast
4027	310	41	2026-10-06 03:04:18.984516	A310	Alarm Lini Niverplast - Transport System
4028	311	41	2026-10-06 03:04:18.984516	A311	Błąd Lini Niverplst - Transport System
4029	309	39	2026-10-06 03:05:19.016906	A309	Błąd Lini Niverplst - Easy Plast
4030	310	41	2026-10-06 03:05:19.016906	A310	Alarm Lini Niverplast - Transport System
4031	311	41	2026-10-06 03:05:19.016906	A311	Błąd Lini Niverplst - Transport System
4032	309	39	2026-10-06 03:06:19.08139	A309	Błąd Lini Niverplst - Easy Plast
4033	310	41	2026-10-06 03:06:19.08139	A310	Alarm Lini Niverplast - Transport System
4034	311	41	2026-10-06 03:06:19.08139	A311	Błąd Lini Niverplst - Transport System
4035	309	39	2026-10-06 03:07:19.139507	A309	Błąd Lini Niverplst - Easy Plast
4036	310	41	2026-10-06 03:07:19.139507	A310	Alarm Lini Niverplast - Transport System
4037	311	41	2026-10-06 03:07:19.139507	A311	Błąd Lini Niverplst - Transport System
4038	309	39	2026-10-06 03:08:19.219861	A309	Błąd Lini Niverplst - Easy Plast
4039	310	41	2026-10-06 03:08:19.219861	A310	Alarm Lini Niverplast - Transport System
4040	311	41	2026-10-06 03:08:19.219861	A311	Błąd Lini Niverplst - Transport System
4041	309	39	2026-10-06 03:09:19.262029	A309	Błąd Lini Niverplst - Easy Plast
4042	310	41	2026-10-06 03:09:19.262029	A310	Alarm Lini Niverplast - Transport System
4043	311	41	2026-10-06 03:09:19.262029	A311	Błąd Lini Niverplst - Transport System
4044	309	39	2026-10-06 03:10:19.320728	A309	Błąd Lini Niverplst - Easy Plast
4045	310	41	2026-10-06 03:10:19.320728	A310	Alarm Lini Niverplast - Transport System
4046	311	41	2026-10-06 03:10:19.320728	A311	Błąd Lini Niverplst - Transport System
4047	309	39	2026-10-06 03:11:19.392323	A309	Błąd Lini Niverplst - Easy Plast
4048	310	41	2026-10-06 03:11:19.392323	A310	Alarm Lini Niverplast - Transport System
4049	311	41	2026-10-06 03:11:19.392323	A311	Błąd Lini Niverplst - Transport System
4050	309	39	2026-10-06 03:12:19.44176	A309	Błąd Lini Niverplst - Easy Plast
4051	310	41	2026-10-06 03:12:19.44176	A310	Alarm Lini Niverplast - Transport System
4052	311	41	2026-10-06 03:12:19.44176	A311	Błąd Lini Niverplst - Transport System
4053	309	39	2026-10-06 03:13:19.511976	A309	Błąd Lini Niverplst - Easy Plast
4054	310	41	2026-10-06 03:13:19.511976	A310	Alarm Lini Niverplast - Transport System
4055	311	41	2026-10-06 03:13:19.511976	A311	Błąd Lini Niverplst - Transport System
4056	309	39	2026-10-06 03:14:19.558916	A309	Błąd Lini Niverplst - Easy Plast
4057	310	41	2026-10-06 03:14:19.558916	A310	Alarm Lini Niverplast - Transport System
4058	311	41	2026-10-06 03:14:19.558916	A311	Błąd Lini Niverplst - Transport System
4059	309	39	2026-10-06 03:15:19.62998	A309	Błąd Lini Niverplst - Easy Plast
4060	310	41	2026-10-06 03:15:19.62998	A310	Alarm Lini Niverplast - Transport System
4061	311	41	2026-10-06 03:15:19.62998	A311	Błąd Lini Niverplst - Transport System
4062	309	39	2026-10-06 03:16:19.68062	A309	Błąd Lini Niverplst - Easy Plast
4063	310	41	2026-10-06 03:16:19.68062	A310	Alarm Lini Niverplast - Transport System
4064	311	41	2026-10-06 03:16:19.68062	A311	Błąd Lini Niverplst - Transport System
4065	309	39	2026-10-06 03:17:19.818829	A309	Błąd Lini Niverplst - Easy Plast
4066	310	41	2026-10-06 03:17:19.818829	A310	Alarm Lini Niverplast - Transport System
4067	311	41	2026-10-06 03:17:19.818829	A311	Błąd Lini Niverplst - Transport System
4068	309	39	2026-10-06 03:18:19.829705	A309	Błąd Lini Niverplst - Easy Plast
4069	310	41	2026-10-06 03:18:19.829705	A310	Alarm Lini Niverplast - Transport System
4070	311	41	2026-10-06 03:18:19.829705	A311	Błąd Lini Niverplst - Transport System
4071	309	39	2026-10-06 03:19:19.899224	A309	Błąd Lini Niverplst - Easy Plast
4072	310	41	2026-10-06 03:19:19.899224	A310	Alarm Lini Niverplast - Transport System
4073	311	41	2026-10-06 03:19:19.899224	A311	Błąd Lini Niverplst - Transport System
4074	309	39	2026-10-06 03:20:19.928202	A309	Błąd Lini Niverplst - Easy Plast
4075	310	41	2026-10-06 03:20:19.928202	A310	Alarm Lini Niverplast - Transport System
4076	311	41	2026-10-06 03:20:19.928202	A311	Błąd Lini Niverplst - Transport System
4077	309	39	2026-10-06 03:21:20.01772	A309	Błąd Lini Niverplst - Easy Plast
4078	310	41	2026-10-06 03:21:20.01772	A310	Alarm Lini Niverplast - Transport System
4079	311	41	2026-10-06 03:21:20.01772	A311	Błąd Lini Niverplst - Transport System
4080	309	39	2026-10-06 03:22:20.056075	A309	Błąd Lini Niverplst - Easy Plast
4081	310	41	2026-10-06 03:22:20.056075	A310	Alarm Lini Niverplast - Transport System
4082	311	41	2026-10-06 03:22:20.056075	A311	Błąd Lini Niverplst - Transport System
4083	309	39	2026-10-06 03:23:20.120516	A309	Błąd Lini Niverplst - Easy Plast
4084	310	41	2026-10-06 03:23:20.120516	A310	Alarm Lini Niverplast - Transport System
4085	311	41	2026-10-06 03:23:20.120516	A311	Błąd Lini Niverplst - Transport System
4086	309	39	2026-10-06 03:24:17.452254	A309	Błąd Lini Niverplst - Easy Plast
4087	310	41	2026-10-06 03:24:17.452254	A310	Alarm Lini Niverplast - Transport System
4088	311	41	2026-10-06 03:24:17.452254	A311	Błąd Lini Niverplst - Transport System
4089	309	39	2026-10-06 03:25:19.406377	A309	Błąd Lini Niverplst - Easy Plast
4090	310	41	2026-10-06 03:25:19.406377	A310	Alarm Lini Niverplast - Transport System
4091	311	41	2026-10-06 03:25:19.406377	A311	Błąd Lini Niverplst - Transport System
4092	309	39	2026-10-06 03:26:20.249773	A309	Błąd Lini Niverplst - Easy Plast
4093	310	41	2026-10-06 03:26:20.249773	A310	Alarm Lini Niverplast - Transport System
4094	311	41	2026-10-06 03:26:20.249773	A311	Błąd Lini Niverplst - Transport System
4095	309	39	2026-10-06 03:27:20.382291	A309	Błąd Lini Niverplst - Easy Plast
4096	310	41	2026-10-06 03:27:20.382291	A310	Alarm Lini Niverplast - Transport System
4097	311	41	2026-10-06 03:27:20.382291	A311	Błąd Lini Niverplst - Transport System
4098	309	39	2026-10-06 03:28:20.428238	A309	Błąd Lini Niverplst - Easy Plast
4099	310	41	2026-10-06 03:28:20.428238	A310	Alarm Lini Niverplast - Transport System
4100	311	41	2026-10-06 03:28:20.428238	A311	Błąd Lini Niverplst - Transport System
4101	106	2	2026-10-06 03:28:20.428238	A106	Błąd pudełko zostało odrzucone
4102	309	39	2026-10-06 03:29:20.484677	A309	Błąd Lini Niverplst - Easy Plast
4103	310	41	2026-10-06 03:29:20.484677	A310	Alarm Lini Niverplast - Transport System
4104	311	41	2026-10-06 03:29:20.484677	A311	Błąd Lini Niverplst - Transport System
4105	106	2	2026-10-06 03:29:20.484677	A106	Błąd pudełko zostało odrzucone
4106	309	39	2026-10-06 03:30:20.555528	A309	Błąd Lini Niverplst - Easy Plast
4107	310	41	2026-10-06 03:30:20.555528	A310	Alarm Lini Niverplast - Transport System
4108	311	41	2026-10-06 03:30:20.555528	A311	Błąd Lini Niverplst - Transport System
4109	106	2	2026-10-06 03:30:20.555528	A106	Błąd pudełko zostało odrzucone
4110	309	39	2026-10-06 03:31:20.813381	A309	Błąd Lini Niverplst - Easy Plast
4111	310	41	2026-10-06 03:31:20.813381	A310	Alarm Lini Niverplast - Transport System
4112	311	41	2026-10-06 03:31:20.813381	A311	Błąd Lini Niverplst - Transport System
4113	309	39	2026-10-06 03:32:20.687092	A309	Błąd Lini Niverplst - Easy Plast
4114	310	41	2026-10-06 03:32:20.687092	A310	Alarm Lini Niverplast - Transport System
4115	311	41	2026-10-06 03:32:20.687092	A311	Błąd Lini Niverplst - Transport System
4116	309	39	2026-10-06 03:33:20.775209	A309	Błąd Lini Niverplst - Easy Plast
4117	310	41	2026-10-06 03:33:20.775209	A310	Alarm Lini Niverplast - Transport System
4118	311	41	2026-10-06 03:33:20.775209	A311	Błąd Lini Niverplst - Transport System
4119	309	39	2026-10-06 03:34:20.728424	A309	Błąd Lini Niverplst - Easy Plast
4120	310	41	2026-10-06 03:34:20.728424	A310	Alarm Lini Niverplast - Transport System
4121	311	41	2026-10-06 03:34:20.728424	A311	Błąd Lini Niverplst - Transport System
4122	309	39	2026-10-06 03:35:21.022204	A309	Błąd Lini Niverplst - Easy Plast
4123	310	41	2026-10-06 03:35:21.022204	A310	Alarm Lini Niverplast - Transport System
4124	311	41	2026-10-06 03:35:21.022204	A311	Błąd Lini Niverplst - Transport System
4125	309	39	2026-10-06 03:36:20.914799	A309	Błąd Lini Niverplst - Easy Plast
4126	310	41	2026-10-06 03:36:20.914799	A310	Alarm Lini Niverplast - Transport System
4127	311	41	2026-10-06 03:36:20.914799	A311	Błąd Lini Niverplst - Transport System
4128	309	39	2026-10-06 03:37:20.947106	A309	Błąd Lini Niverplst - Easy Plast
4129	310	41	2026-10-06 03:37:20.947106	A310	Alarm Lini Niverplast - Transport System
4130	311	41	2026-10-06 03:37:20.947106	A311	Błąd Lini Niverplst - Transport System
4131	309	39	2026-10-06 03:38:21.026123	A309	Błąd Lini Niverplst - Easy Plast
4132	310	41	2026-10-06 03:38:21.026123	A310	Alarm Lini Niverplast - Transport System
4133	311	41	2026-10-06 03:38:21.026123	A311	Błąd Lini Niverplst - Transport System
4134	309	39	2026-10-06 03:39:21.080339	A309	Błąd Lini Niverplst - Easy Plast
4135	310	41	2026-10-06 03:39:21.080339	A310	Alarm Lini Niverplast - Transport System
4136	311	41	2026-10-06 03:39:21.080339	A311	Błąd Lini Niverplst - Transport System
4137	309	39	2026-10-06 03:40:21.168715	A309	Błąd Lini Niverplst - Easy Plast
4138	310	41	2026-10-06 03:40:21.168715	A310	Alarm Lini Niverplast - Transport System
4139	311	41	2026-10-06 03:40:21.168715	A311	Błąd Lini Niverplst - Transport System
4140	309	39	2026-10-06 03:41:21.203092	A309	Błąd Lini Niverplst - Easy Plast
4141	310	41	2026-10-06 03:41:21.203092	A310	Alarm Lini Niverplast - Transport System
4142	311	41	2026-10-06 03:41:21.203092	A311	Błąd Lini Niverplst - Transport System
4143	309	39	2026-10-06 03:42:21.273262	A309	Błąd Lini Niverplst - Easy Plast
4144	310	41	2026-10-06 03:42:21.273262	A310	Alarm Lini Niverplast - Transport System
4145	311	41	2026-10-06 03:42:21.273262	A311	Błąd Lini Niverplst - Transport System
4146	309	39	2026-10-06 03:43:21.339547	A309	Błąd Lini Niverplst - Easy Plast
4147	310	41	2026-10-06 03:43:21.339547	A310	Alarm Lini Niverplast - Transport System
4148	311	41	2026-10-06 03:43:21.339547	A311	Błąd Lini Niverplst - Transport System
4149	309	39	2026-10-06 03:44:21.396346	A309	Błąd Lini Niverplst - Easy Plast
4150	310	41	2026-10-06 03:44:21.396346	A310	Alarm Lini Niverplast - Transport System
4151	311	41	2026-10-06 03:44:21.396346	A311	Błąd Lini Niverplst - Transport System
4152	309	39	2026-10-06 03:45:21.460183	A309	Błąd Lini Niverplst - Easy Plast
4153	310	41	2026-10-06 03:45:21.460183	A310	Alarm Lini Niverplast - Transport System
4154	311	41	2026-10-06 03:45:21.460183	A311	Błąd Lini Niverplst - Transport System
4155	309	39	2026-10-06 03:46:21.515791	A309	Błąd Lini Niverplst - Easy Plast
4156	310	41	2026-10-06 03:46:21.515791	A310	Alarm Lini Niverplast - Transport System
4157	311	41	2026-10-06 03:46:21.515791	A311	Błąd Lini Niverplst - Transport System
4158	309	39	2026-10-06 03:47:21.560996	A309	Błąd Lini Niverplst - Easy Plast
4159	310	41	2026-10-06 03:47:21.560996	A310	Alarm Lini Niverplast - Transport System
4160	311	41	2026-10-06 03:47:21.560996	A311	Błąd Lini Niverplst - Transport System
4161	309	39	2026-10-06 03:48:21.614664	A309	Błąd Lini Niverplst - Easy Plast
4162	310	41	2026-10-06 03:48:21.614664	A310	Alarm Lini Niverplast - Transport System
4163	311	41	2026-10-06 03:48:21.614664	A311	Błąd Lini Niverplst - Transport System
4164	309	39	2026-10-06 03:49:21.686161	A309	Błąd Lini Niverplst - Easy Plast
4165	310	41	2026-10-06 03:49:21.686161	A310	Alarm Lini Niverplast - Transport System
4166	311	41	2026-10-06 03:49:21.686161	A311	Błąd Lini Niverplst - Transport System
4167	309	39	2026-10-06 03:50:21.733697	A309	Błąd Lini Niverplst - Easy Plast
4168	310	41	2026-10-06 03:50:21.733697	A310	Alarm Lini Niverplast - Transport System
4169	311	41	2026-10-06 03:50:21.733697	A311	Błąd Lini Niverplst - Transport System
4170	309	39	2026-10-06 03:51:21.805176	A309	Błąd Lini Niverplst - Easy Plast
4171	310	41	2026-10-06 03:51:21.805176	A310	Alarm Lini Niverplast - Transport System
4172	311	41	2026-10-06 03:51:21.805176	A311	Błąd Lini Niverplst - Transport System
4173	309	39	2026-10-06 03:52:21.812826	A309	Błąd Lini Niverplst - Easy Plast
4174	310	41	2026-10-06 03:52:21.812826	A310	Alarm Lini Niverplast - Transport System
4175	311	41	2026-10-06 03:52:21.812826	A311	Błąd Lini Niverplst - Transport System
4176	309	39	2026-10-06 03:53:21.898939	A309	Błąd Lini Niverplst - Easy Plast
4177	310	41	2026-10-06 03:53:21.898939	A310	Alarm Lini Niverplast - Transport System
4178	311	41	2026-10-06 03:53:21.898939	A311	Błąd Lini Niverplst - Transport System
4179	309	39	2026-10-06 03:54:21.964737	A309	Błąd Lini Niverplst - Easy Plast
4180	310	41	2026-10-06 03:54:21.964737	A310	Alarm Lini Niverplast - Transport System
4181	311	41	2026-10-06 03:54:21.964737	A311	Błąd Lini Niverplst - Transport System
4182	309	39	2026-10-06 03:55:22.011879	A309	Błąd Lini Niverplst - Easy Plast
4183	310	41	2026-10-06 03:55:22.011879	A310	Alarm Lini Niverplast - Transport System
4184	311	41	2026-10-06 03:55:22.011879	A311	Błąd Lini Niverplst - Transport System
4185	309	39	2026-10-06 03:56:22.061553	A309	Błąd Lini Niverplst - Easy Plast
4186	310	41	2026-10-06 03:56:22.061553	A310	Alarm Lini Niverplast - Transport System
4187	311	41	2026-10-06 03:56:22.061553	A311	Błąd Lini Niverplst - Transport System
4188	309	39	2026-10-06 03:57:22.102886	A309	Błąd Lini Niverplst - Easy Plast
4189	310	41	2026-10-06 03:57:22.102886	A310	Alarm Lini Niverplast - Transport System
4190	311	41	2026-10-06 03:57:22.102886	A311	Błąd Lini Niverplst - Transport System
4191	309	39	2026-10-06 03:58:22.165185	A309	Błąd Lini Niverplst - Easy Plast
4192	310	41	2026-10-06 03:58:22.165185	A310	Alarm Lini Niverplast - Transport System
4193	311	41	2026-10-06 03:58:22.165185	A311	Błąd Lini Niverplst - Transport System
4194	309	39	2026-10-06 03:59:22.250035	A309	Błąd Lini Niverplst - Easy Plast
4195	310	41	2026-10-06 03:59:22.250035	A310	Alarm Lini Niverplast - Transport System
4196	311	41	2026-10-06 03:59:22.250035	A311	Błąd Lini Niverplst - Transport System
4197	309	39	2026-10-06 04:00:22.263905	A309	Błąd Lini Niverplst - Easy Plast
4198	310	41	2026-10-06 04:00:22.263905	A310	Alarm Lini Niverplast - Transport System
4199	311	41	2026-10-06 04:00:22.263905	A311	Błąd Lini Niverplst - Transport System
4200	309	39	2026-10-06 04:01:22.325086	A309	Błąd Lini Niverplst - Easy Plast
4201	310	41	2026-10-06 04:01:22.325086	A310	Alarm Lini Niverplast - Transport System
4202	311	41	2026-10-06 04:01:22.325086	A311	Błąd Lini Niverplst - Transport System
4203	309	39	2026-10-06 04:02:22.360862	A309	Błąd Lini Niverplst - Easy Plast
4204	310	41	2026-10-06 04:02:22.360862	A310	Alarm Lini Niverplast - Transport System
4205	311	41	2026-10-06 04:02:22.360862	A311	Błąd Lini Niverplst - Transport System
4206	309	39	2026-10-06 04:03:22.430195	A309	Błąd Lini Niverplst - Easy Plast
4207	310	41	2026-10-06 04:03:22.430195	A310	Alarm Lini Niverplast - Transport System
4208	311	41	2026-10-06 04:03:22.430195	A311	Błąd Lini Niverplst - Transport System
4209	309	39	2026-10-06 04:04:22.45986	A309	Błąd Lini Niverplst - Easy Plast
4210	310	41	2026-10-06 04:04:22.45986	A310	Alarm Lini Niverplast - Transport System
4211	311	41	2026-10-06 04:04:22.45986	A311	Błąd Lini Niverplst - Transport System
4212	309	39	2026-10-06 04:05:22.522492	A309	Błąd Lini Niverplst - Easy Plast
4213	310	41	2026-10-06 04:05:22.522492	A310	Alarm Lini Niverplast - Transport System
4214	311	41	2026-10-06 04:05:22.522492	A311	Błąd Lini Niverplst - Transport System
4603	309	39	2026-10-06 06:03:29.551106	A309	Błąd Lini Niverplst - Easy Plast
4604	310	41	2026-10-06 06:03:29.551106	A310	Alarm Lini Niverplast - Transport System
4605	311	41	2026-10-06 06:03:29.551106	A311	Błąd Lini Niverplst - Transport System
4606	317	40	2026-10-06 06:03:29.551106	A317	Alarm lini Niverplast
4619	309	39	2026-10-06 06:07:29.924856	A309	Błąd Lini Niverplst - Easy Plast
4620	310	41	2026-10-06 06:07:29.924856	A310	Alarm Lini Niverplast - Transport System
4621	311	41	2026-10-06 06:07:29.924856	A311	Błąd Lini Niverplst - Transport System
4622	317	40	2026-10-06 06:07:29.924856	A317	Alarm lini Niverplast
4635	309	39	2026-10-06 06:11:29.539833	A309	Błąd Lini Niverplst - Easy Plast
4636	310	41	2026-10-06 06:11:29.539833	A310	Alarm Lini Niverplast - Transport System
4637	311	41	2026-10-06 06:11:29.539833	A311	Błąd Lini Niverplst - Transport System
4638	317	40	2026-10-06 06:11:29.539833	A317	Alarm lini Niverplast
4651	309	39	2026-10-06 06:15:29.906922	A309	Błąd Lini Niverplst - Easy Plast
4652	310	41	2026-10-06 06:15:29.906922	A310	Alarm Lini Niverplast - Transport System
4653	311	41	2026-10-06 06:15:29.906922	A311	Błąd Lini Niverplst - Transport System
4654	317	40	2026-10-06 06:15:29.906922	A317	Alarm lini Niverplast
4667	309	39	2026-10-06 06:19:30.269942	A309	Błąd Lini Niverplst - Easy Plast
4668	310	41	2026-10-06 06:19:30.269942	A310	Alarm Lini Niverplast - Transport System
4669	311	41	2026-10-06 06:19:30.269942	A311	Błąd Lini Niverplst - Transport System
4670	317	40	2026-10-06 06:19:30.269942	A317	Alarm lini Niverplast
4683	309	39	2026-10-06 06:23:30.661505	A309	Błąd Lini Niverplst - Easy Plast
4684	310	41	2026-10-06 06:23:30.661505	A310	Alarm Lini Niverplast - Transport System
4685	311	41	2026-10-06 06:23:30.661505	A311	Błąd Lini Niverplst - Transport System
4686	317	40	2026-10-06 06:23:30.661505	A317	Alarm lini Niverplast
4699	309	39	2026-10-06 06:27:31.018599	A309	Błąd Lini Niverplst - Easy Plast
4700	310	41	2026-10-06 06:27:31.018599	A310	Alarm Lini Niverplast - Transport System
4701	311	41	2026-10-06 06:27:31.018599	A311	Błąd Lini Niverplst - Transport System
4702	317	40	2026-10-06 06:27:31.018599	A317	Alarm lini Niverplast
4715	309	39	2026-10-06 06:31:30.638479	A309	Błąd Lini Niverplst - Easy Plast
4716	310	41	2026-10-06 06:31:30.638479	A310	Alarm Lini Niverplast - Transport System
4717	311	41	2026-10-06 06:31:30.638479	A311	Błąd Lini Niverplst - Transport System
4718	317	40	2026-10-06 06:31:30.638479	A317	Alarm lini Niverplast
4731	309	39	2026-10-06 06:35:31.012947	A309	Błąd Lini Niverplst - Easy Plast
4732	310	41	2026-10-06 06:35:31.012947	A310	Alarm Lini Niverplast - Transport System
4733	311	41	2026-10-06 06:35:31.012947	A311	Błąd Lini Niverplst - Transport System
4734	317	40	2026-10-06 06:35:31.012947	A317	Alarm lini Niverplast
4747	309	39	2026-10-06 06:39:31.407458	A309	Błąd Lini Niverplst - Easy Plast
4748	310	41	2026-10-06 06:39:31.407458	A310	Alarm Lini Niverplast - Transport System
4749	311	41	2026-10-06 06:39:31.407458	A311	Błąd Lini Niverplst - Transport System
4750	317	40	2026-10-06 06:39:31.407458	A317	Alarm lini Niverplast
4760	310	41	2026-10-06 06:42:31.670767	A310	Alarm Lini Niverplast - Transport System
4761	311	41	2026-10-06 06:42:31.670767	A311	Błąd Lini Niverplst - Transport System
4762	317	40	2026-10-06 06:42:31.670767	A317	Alarm lini Niverplast
4771	309	39	2026-10-06 06:45:31.964419	A309	Błąd Lini Niverplst - Easy Plast
4772	310	41	2026-10-06 06:45:31.964419	A310	Alarm Lini Niverplast - Transport System
4773	311	41	2026-10-06 06:45:31.964419	A311	Błąd Lini Niverplst - Transport System
4774	317	40	2026-10-06 06:45:31.964419	A317	Alarm lini Niverplast
4216	129	40	2026-10-06 04:06:22.586551	A129	Niskie ciśnienie pneumatyczne - strefa 1
4217	164	40	2026-10-06 04:06:22.586551	A164	\N
4218	309	39	2026-10-06 04:06:22.586551	A309	Błąd Lini Niverplst - Easy Plast
4219	310	41	2026-10-06 04:06:22.586551	A310	Alarm Lini Niverplast - Transport System
4220	311	41	2026-10-06 04:06:22.586551	A311	Błąd Lini Niverplst - Transport System
4221	129	40	2026-10-06 04:07:22.62254	A129	Niskie ciśnienie pneumatyczne - strefa 1
4222	164	40	2026-10-06 04:07:22.62254	A164	\N
4223	309	39	2026-10-06 04:07:22.62254	A309	Błąd Lini Niverplst - Easy Plast
4224	310	41	2026-10-06 04:07:22.62254	A310	Alarm Lini Niverplast - Transport System
4225	311	41	2026-10-06 04:07:22.62254	A311	Błąd Lini Niverplst - Transport System
4226	129	40	2026-10-06 04:08:22.684877	A129	Niskie ciśnienie pneumatyczne - strefa 1
4227	309	39	2026-10-06 04:08:22.684877	A309	Błąd Lini Niverplst - Easy Plast
4228	310	41	2026-10-06 04:08:22.684877	A310	Alarm Lini Niverplast - Transport System
4229	311	41	2026-10-06 04:08:22.684877	A311	Błąd Lini Niverplst - Transport System
4230	188	40	2026-10-06 04:08:22.684877	A188	Nieryglowany zamek bramki bezpieszeństwa
4231	309	39	2026-10-06 04:09:22.569839	A309	Błąd Lini Niverplst - Easy Plast
4232	310	41	2026-10-06 04:09:22.569839	A310	Alarm Lini Niverplast - Transport System
4233	311	41	2026-10-06 04:09:22.569839	A311	Błąd Lini Niverplst - Transport System
4234	309	39	2026-10-06 04:10:22.622302	A309	Błąd Lini Niverplst - Easy Plast
4235	310	41	2026-10-06 04:10:22.622302	A310	Alarm Lini Niverplast - Transport System
4236	311	41	2026-10-06 04:10:22.622302	A311	Błąd Lini Niverplst - Transport System
4237	309	39	2026-10-06 04:11:22.686345	A309	Błąd Lini Niverplst - Easy Plast
4238	310	41	2026-10-06 04:11:22.686345	A310	Alarm Lini Niverplast - Transport System
4239	311	41	2026-10-06 04:11:22.686345	A311	Błąd Lini Niverplst - Transport System
4240	309	39	2026-10-06 04:12:22.744904	A309	Błąd Lini Niverplst - Easy Plast
4241	310	41	2026-10-06 04:12:22.744904	A310	Alarm Lini Niverplast - Transport System
4242	311	41	2026-10-06 04:12:22.744904	A311	Błąd Lini Niverplst - Transport System
4243	309	39	2026-10-06 04:13:22.839581	A309	Błąd Lini Niverplst - Easy Plast
4244	310	41	2026-10-06 04:13:22.839581	A310	Alarm Lini Niverplast - Transport System
4245	311	41	2026-10-06 04:13:22.839581	A311	Błąd Lini Niverplst - Transport System
4246	309	39	2026-10-06 04:14:22.887344	A309	Błąd Lini Niverplst - Easy Plast
4247	310	41	2026-10-06 04:14:22.887344	A310	Alarm Lini Niverplast - Transport System
4248	311	41	2026-10-06 04:14:22.887344	A311	Błąd Lini Niverplst - Transport System
4249	309	39	2026-10-06 04:15:22.944529	A309	Błąd Lini Niverplst - Easy Plast
4250	310	41	2026-10-06 04:15:22.944529	A310	Alarm Lini Niverplast - Transport System
4251	311	41	2026-10-06 04:15:22.944529	A311	Błąd Lini Niverplst - Transport System
4252	309	39	2026-10-06 04:16:23.01443	A309	Błąd Lini Niverplst - Easy Plast
4253	310	41	2026-10-06 04:16:23.01443	A310	Alarm Lini Niverplast - Transport System
4254	311	41	2026-10-06 04:16:23.01443	A311	Błąd Lini Niverplst - Transport System
4255	309	39	2026-10-06 04:17:23.454389	A309	Błąd Lini Niverplst - Easy Plast
4256	310	41	2026-10-06 04:17:23.454389	A310	Alarm Lini Niverplast - Transport System
4257	311	41	2026-10-06 04:17:23.454389	A311	Błąd Lini Niverplst - Transport System
4258	309	39	2026-10-06 04:18:23.142893	A309	Błąd Lini Niverplst - Easy Plast
4259	310	41	2026-10-06 04:18:23.142893	A310	Alarm Lini Niverplast - Transport System
4260	311	41	2026-10-06 04:18:23.142893	A311	Błąd Lini Niverplst - Transport System
4261	309	39	2026-10-06 04:19:23.218164	A309	Błąd Lini Niverplst - Easy Plast
4262	310	41	2026-10-06 04:19:23.218164	A310	Alarm Lini Niverplast - Transport System
4263	311	41	2026-10-06 04:19:23.218164	A311	Błąd Lini Niverplst - Transport System
4264	309	39	2026-10-06 04:20:23.269902	A309	Błąd Lini Niverplst - Easy Plast
4265	310	41	2026-10-06 04:20:23.269902	A310	Alarm Lini Niverplast - Transport System
4266	311	41	2026-10-06 04:20:23.269902	A311	Błąd Lini Niverplst - Transport System
4267	309	39	2026-10-06 04:21:23.335534	A309	Błąd Lini Niverplst - Easy Plast
4268	310	41	2026-10-06 04:21:23.335534	A310	Alarm Lini Niverplast - Transport System
4269	311	41	2026-10-06 04:21:23.335534	A311	Błąd Lini Niverplst - Transport System
4270	309	39	2026-10-06 04:22:23.404207	A309	Błąd Lini Niverplst - Easy Plast
4271	310	41	2026-10-06 04:22:23.404207	A310	Alarm Lini Niverplast - Transport System
4272	311	41	2026-10-06 04:22:23.404207	A311	Błąd Lini Niverplst - Transport System
4273	309	39	2026-10-06 04:23:23.447396	A309	Błąd Lini Niverplst - Easy Plast
4274	310	41	2026-10-06 04:23:23.447396	A310	Alarm Lini Niverplast - Transport System
4275	311	41	2026-10-06 04:23:23.447396	A311	Błąd Lini Niverplst - Transport System
4276	309	39	2026-10-06 04:24:23.511869	A309	Błąd Lini Niverplst - Easy Plast
4277	310	41	2026-10-06 04:24:23.511869	A310	Alarm Lini Niverplast - Transport System
4278	311	41	2026-10-06 04:24:23.511869	A311	Błąd Lini Niverplst - Transport System
4279	309	39	2026-10-06 04:25:23.688495	A309	Błąd Lini Niverplst - Easy Plast
4280	310	41	2026-10-06 04:25:23.688495	A310	Alarm Lini Niverplast - Transport System
4281	311	41	2026-10-06 04:25:23.688495	A311	Błąd Lini Niverplst - Transport System
4282	309	39	2026-10-06 04:26:23.646997	A309	Błąd Lini Niverplst - Easy Plast
4283	310	41	2026-10-06 04:26:23.646997	A310	Alarm Lini Niverplast - Transport System
4284	311	41	2026-10-06 04:26:23.646997	A311	Błąd Lini Niverplst - Transport System
4285	309	39	2026-10-06 04:27:23.706823	A309	Błąd Lini Niverplst - Easy Plast
4286	310	41	2026-10-06 04:27:23.706823	A310	Alarm Lini Niverplast - Transport System
4287	311	41	2026-10-06 04:27:23.706823	A311	Błąd Lini Niverplst - Transport System
4288	309	39	2026-10-06 04:28:24.085266	A309	Błąd Lini Niverplst - Easy Plast
4289	310	41	2026-10-06 04:28:24.085266	A310	Alarm Lini Niverplast - Transport System
4290	311	41	2026-10-06 04:28:24.085266	A311	Błąd Lini Niverplst - Transport System
4291	309	39	2026-10-06 04:29:23.852494	A309	Błąd Lini Niverplst - Easy Plast
4292	310	41	2026-10-06 04:29:23.852494	A310	Alarm Lini Niverplast - Transport System
4293	311	41	2026-10-06 04:29:23.852494	A311	Błąd Lini Niverplst - Transport System
4294	309	39	2026-10-06 04:30:23.916713	A309	Błąd Lini Niverplst - Easy Plast
4295	310	41	2026-10-06 04:30:23.916713	A310	Alarm Lini Niverplast - Transport System
4296	311	41	2026-10-06 04:30:23.916713	A311	Błąd Lini Niverplst - Transport System
4607	309	39	2026-10-06 06:04:29.644231	A309	Błąd Lini Niverplst - Easy Plast
4608	310	41	2026-10-06 06:04:29.644231	A310	Alarm Lini Niverplast - Transport System
4609	311	41	2026-10-06 06:04:29.644231	A311	Błąd Lini Niverplst - Transport System
4298	309	39	2026-10-06 04:31:23.992525	A309	Błąd Lini Niverplst - Easy Plast
4299	310	41	2026-10-06 04:31:23.992525	A310	Alarm Lini Niverplast - Transport System
4300	311	41	2026-10-06 04:31:23.992525	A311	Błąd Lini Niverplst - Transport System
4610	317	40	2026-10-06 06:04:29.644231	A317	Alarm lini Niverplast
4623	309	39	2026-10-06 06:08:30.006203	A309	Błąd Lini Niverplst - Easy Plast
4624	310	41	2026-10-06 06:08:30.006203	A310	Alarm Lini Niverplast - Transport System
4625	311	41	2026-10-06 06:08:30.006203	A311	Błąd Lini Niverplst - Transport System
4626	317	40	2026-10-06 06:08:30.006203	A317	Alarm lini Niverplast
4639	309	39	2026-10-06 06:12:29.632862	A309	Błąd Lini Niverplst - Easy Plast
4640	310	41	2026-10-06 06:12:29.632862	A310	Alarm Lini Niverplast - Transport System
4641	311	41	2026-10-06 06:12:29.632862	A311	Błąd Lini Niverplst - Transport System
4642	317	40	2026-10-06 06:12:29.632862	A317	Alarm lini Niverplast
4655	309	39	2026-10-06 06:16:29.995885	A309	Błąd Lini Niverplst - Easy Plast
4656	310	41	2026-10-06 06:16:29.995885	A310	Alarm Lini Niverplast - Transport System
4657	311	41	2026-10-06 06:16:29.995885	A311	Błąd Lini Niverplst - Transport System
4658	317	40	2026-10-06 06:16:29.995885	A317	Alarm lini Niverplast
4671	309	39	2026-10-06 06:20:30.358234	A309	Błąd Lini Niverplst - Easy Plast
4672	310	41	2026-10-06 06:20:30.358234	A310	Alarm Lini Niverplast - Transport System
4673	311	41	2026-10-06 06:20:30.358234	A311	Błąd Lini Niverplst - Transport System
4674	317	40	2026-10-06 06:20:30.358234	A317	Alarm lini Niverplast
4687	309	39	2026-10-06 06:24:30.725243	A309	Błąd Lini Niverplst - Easy Plast
4688	310	41	2026-10-06 06:24:30.725243	A310	Alarm Lini Niverplast - Transport System
4689	311	41	2026-10-06 06:24:30.725243	A311	Błąd Lini Niverplst - Transport System
4690	317	40	2026-10-06 06:24:30.725243	A317	Alarm lini Niverplast
4703	309	39	2026-10-06 06:28:31.106232	A309	Błąd Lini Niverplst - Easy Plast
4704	310	41	2026-10-06 06:28:31.106232	A310	Alarm Lini Niverplast - Transport System
4705	311	41	2026-10-06 06:28:31.106232	A311	Błąd Lini Niverplst - Transport System
4706	317	40	2026-10-06 06:28:31.106232	A317	Alarm lini Niverplast
4719	309	39	2026-10-06 06:32:30.733879	A309	Błąd Lini Niverplst - Easy Plast
4720	310	41	2026-10-06 06:32:30.733879	A310	Alarm Lini Niverplast - Transport System
4721	311	41	2026-10-06 06:32:30.733879	A311	Błąd Lini Niverplst - Transport System
4722	317	40	2026-10-06 06:32:30.733879	A317	Alarm lini Niverplast
4735	309	39	2026-10-06 06:36:31.118902	A309	Błąd Lini Niverplst - Easy Plast
4736	310	41	2026-10-06 06:36:31.118902	A310	Alarm Lini Niverplast - Transport System
4737	311	41	2026-10-06 06:36:31.118902	A311	Błąd Lini Niverplst - Transport System
4738	317	40	2026-10-06 06:36:31.118902	A317	Alarm lini Niverplast
4751	309	39	2026-10-06 06:40:31.474421	A309	Błąd Lini Niverplst - Easy Plast
4752	310	41	2026-10-06 06:40:31.474421	A310	Alarm Lini Niverplast - Transport System
4753	311	41	2026-10-06 06:40:31.474421	A311	Błąd Lini Niverplst - Transport System
4754	317	40	2026-10-06 06:40:31.474421	A317	Alarm lini Niverplast
4763	309	39	2026-10-06 06:43:31.771318	A309	Błąd Lini Niverplst - Easy Plast
4764	310	41	2026-10-06 06:43:31.771318	A310	Alarm Lini Niverplast - Transport System
4765	311	41	2026-10-06 06:43:31.771318	A311	Błąd Lini Niverplst - Transport System
4766	317	40	2026-10-06 06:43:31.771318	A317	Alarm lini Niverplast
4775	309	39	2026-10-06 06:46:32.058469	A309	Błąd Lini Niverplst - Easy Plast
4776	310	41	2026-10-06 06:46:32.058469	A310	Alarm Lini Niverplast - Transport System
4777	311	41	2026-10-06 06:46:32.058469	A311	Błąd Lini Niverplst - Transport System
4778	317	40	2026-10-06 06:46:32.058469	A317	Alarm lini Niverplast
4783	309	39	2026-10-06 06:48:32.262159	A309	Błąd Lini Niverplst - Easy Plast
4784	310	41	2026-10-06 06:48:32.262159	A310	Alarm Lini Niverplast - Transport System
4785	311	41	2026-10-06 06:48:32.262159	A311	Błąd Lini Niverplst - Transport System
4786	317	40	2026-10-06 06:48:32.262159	A317	Alarm lini Niverplast
4791	309	39	2026-10-06 06:50:32.460026	A309	Błąd Lini Niverplst - Easy Plast
4792	310	41	2026-10-06 06:50:32.460026	A310	Alarm Lini Niverplast - Transport System
4793	311	41	2026-10-06 06:50:32.460026	A311	Błąd Lini Niverplst - Transport System
4794	317	40	2026-10-06 06:50:32.460026	A317	Alarm lini Niverplast
4799	309	39	2026-10-06 06:52:31.854568	A309	Błąd Lini Niverplst - Easy Plast
4800	310	41	2026-10-06 06:52:31.854568	A310	Alarm Lini Niverplast - Transport System
4801	311	41	2026-10-06 06:52:31.854568	A311	Błąd Lini Niverplst - Transport System
4802	317	40	2026-10-06 06:52:31.854568	A317	Alarm lini Niverplast
4807	309	39	2026-10-06 06:54:32.04709	A309	Błąd Lini Niverplst - Easy Plast
4808	310	41	2026-10-06 06:54:32.04709	A310	Alarm Lini Niverplast - Transport System
4809	311	41	2026-10-06 06:54:32.04709	A311	Błąd Lini Niverplst - Transport System
4810	317	40	2026-10-06 06:54:32.04709	A317	Alarm lini Niverplast
4815	309	39	2026-10-06 06:56:32.23985	A309	Błąd Lini Niverplst - Easy Plast
4816	310	41	2026-10-06 06:56:32.23985	A310	Alarm Lini Niverplast - Transport System
4817	311	41	2026-10-06 06:56:32.23985	A311	Błąd Lini Niverplst - Transport System
4818	317	40	2026-10-06 06:56:32.23985	A317	Alarm lini Niverplast
4823	309	39	2026-10-06 06:58:32.458228	A309	Błąd Lini Niverplst - Easy Plast
4824	310	41	2026-10-06 06:58:32.458228	A310	Alarm Lini Niverplast - Transport System
4825	311	41	2026-10-06 06:58:32.458228	A311	Błąd Lini Niverplst - Transport System
4826	317	40	2026-10-06 06:58:32.458228	A317	Alarm lini Niverplast
4831	309	39	2026-10-06 07:00:32.622798	A309	Błąd Lini Niverplst - Easy Plast
4832	310	41	2026-10-06 07:00:32.622798	A310	Alarm Lini Niverplast - Transport System
4833	311	41	2026-10-06 07:00:32.622798	A311	Błąd Lini Niverplst - Transport System
4834	317	40	2026-10-06 07:00:32.622798	A317	Alarm lini Niverplast
4839	309	39	2026-10-06 07:02:32.812502	A309	Błąd Lini Niverplst - Easy Plast
4840	310	41	2026-10-06 07:02:32.812502	A310	Alarm Lini Niverplast - Transport System
4841	311	41	2026-10-06 07:02:32.812502	A311	Błąd Lini Niverplst - Transport System
4842	317	40	2026-10-06 07:02:32.812502	A317	Alarm lini Niverplast
4847	309	39	2026-10-06 07:04:33.015487	A309	Błąd Lini Niverplst - Easy Plast
4848	310	41	2026-10-06 07:04:33.015487	A310	Alarm Lini Niverplast - Transport System
4849	311	41	2026-10-06 07:04:33.015487	A311	Błąd Lini Niverplst - Transport System
4850	317	40	2026-10-06 07:04:33.015487	A317	Alarm lini Niverplast
4855	309	39	2026-10-06 07:06:33.211163	A309	Błąd Lini Niverplst - Easy Plast
4856	310	41	2026-10-06 07:06:33.211163	A310	Alarm Lini Niverplast - Transport System
4302	309	39	2026-10-06 04:32:24.032289	A309	Błąd Lini Niverplst - Easy Plast
4303	310	41	2026-10-06 04:32:24.032289	A310	Alarm Lini Niverplast - Transport System
4304	311	41	2026-10-06 04:32:24.032289	A311	Błąd Lini Niverplst - Transport System
4305	309	39	2026-10-06 04:33:24.102534	A309	Błąd Lini Niverplst - Easy Plast
4306	310	41	2026-10-06 04:33:24.102534	A310	Alarm Lini Niverplast - Transport System
4307	311	41	2026-10-06 04:33:24.102534	A311	Błąd Lini Niverplst - Transport System
4308	309	39	2026-10-06 04:34:24.15944	A309	Błąd Lini Niverplst - Easy Plast
4309	310	41	2026-10-06 04:34:24.15944	A310	Alarm Lini Niverplast - Transport System
4310	311	41	2026-10-06 04:34:24.15944	A311	Błąd Lini Niverplst - Transport System
4311	309	39	2026-10-06 04:35:24.213853	A309	Błąd Lini Niverplst - Easy Plast
4312	310	41	2026-10-06 04:35:24.213853	A310	Alarm Lini Niverplast - Transport System
4313	311	41	2026-10-06 04:35:24.213853	A311	Błąd Lini Niverplst - Transport System
4314	309	39	2026-10-06 04:36:24.282887	A309	Błąd Lini Niverplst - Easy Plast
4315	310	41	2026-10-06 04:36:24.282887	A310	Alarm Lini Niverplast - Transport System
4316	311	41	2026-10-06 04:36:24.282887	A311	Błąd Lini Niverplst - Transport System
4317	309	39	2026-10-06 04:37:24.343626	A309	Błąd Lini Niverplst - Easy Plast
4318	310	41	2026-10-06 04:37:24.343626	A310	Alarm Lini Niverplast - Transport System
4319	311	41	2026-10-06 04:37:24.343626	A311	Błąd Lini Niverplst - Transport System
4320	309	39	2026-10-06 04:38:24.408825	A309	Błąd Lini Niverplst - Easy Plast
4321	310	41	2026-10-06 04:38:24.408825	A310	Alarm Lini Niverplast - Transport System
4322	311	41	2026-10-06 04:38:24.408825	A311	Błąd Lini Niverplst - Transport System
4323	309	39	2026-10-06 04:39:24.476922	A309	Błąd Lini Niverplst - Easy Plast
4324	310	41	2026-10-06 04:39:24.476922	A310	Alarm Lini Niverplast - Transport System
4325	311	41	2026-10-06 04:39:24.476922	A311	Błąd Lini Niverplst - Transport System
4326	309	39	2026-10-06 04:40:24.538413	A309	Błąd Lini Niverplst - Easy Plast
4327	310	41	2026-10-06 04:40:24.538413	A310	Alarm Lini Niverplast - Transport System
4328	311	41	2026-10-06 04:40:24.538413	A311	Błąd Lini Niverplst - Transport System
4329	309	39	2026-10-06 04:41:24.594362	A309	Błąd Lini Niverplst - Easy Plast
4330	310	41	2026-10-06 04:41:24.594362	A310	Alarm Lini Niverplast - Transport System
4331	311	41	2026-10-06 04:41:24.594362	A311	Błąd Lini Niverplst - Transport System
4332	309	39	2026-10-06 04:42:24.665319	A309	Błąd Lini Niverplst - Easy Plast
4333	310	41	2026-10-06 04:42:24.665319	A310	Alarm Lini Niverplast - Transport System
4334	311	41	2026-10-06 04:42:24.665319	A311	Błąd Lini Niverplst - Transport System
4335	309	39	2026-10-06 04:43:24.74449	A309	Błąd Lini Niverplst - Easy Plast
4336	310	41	2026-10-06 04:43:24.74449	A310	Alarm Lini Niverplast - Transport System
4337	311	41	2026-10-06 04:43:24.74449	A311	Błąd Lini Niverplst - Transport System
4338	309	39	2026-10-06 04:44:24.777105	A309	Błąd Lini Niverplst - Easy Plast
4339	310	41	2026-10-06 04:44:24.777105	A310	Alarm Lini Niverplast - Transport System
4340	311	41	2026-10-06 04:44:24.777105	A311	Błąd Lini Niverplst - Transport System
4341	309	39	2026-10-06 04:45:24.858233	A309	Błąd Lini Niverplst - Easy Plast
4342	310	41	2026-10-06 04:45:24.858233	A310	Alarm Lini Niverplast - Transport System
4343	311	41	2026-10-06 04:45:24.858233	A311	Błąd Lini Niverplst - Transport System
4344	309	39	2026-10-06 04:46:24.927101	A309	Błąd Lini Niverplst - Easy Plast
4345	310	41	2026-10-06 04:46:24.927101	A310	Alarm Lini Niverplast - Transport System
4346	311	41	2026-10-06 04:46:24.927101	A311	Błąd Lini Niverplst - Transport System
4347	309	39	2026-10-06 04:47:25.066688	A309	Błąd Lini Niverplst - Easy Plast
4348	310	41	2026-10-06 04:47:25.066688	A310	Alarm Lini Niverplast - Transport System
4349	311	41	2026-10-06 04:47:25.066688	A311	Błąd Lini Niverplst - Transport System
4350	309	39	2026-10-06 04:48:25.050682	A309	Błąd Lini Niverplst - Easy Plast
4351	310	41	2026-10-06 04:48:25.050682	A310	Alarm Lini Niverplast - Transport System
4352	311	41	2026-10-06 04:48:25.050682	A311	Błąd Lini Niverplst - Transport System
4353	309	39	2026-10-06 04:49:25.101824	A309	Błąd Lini Niverplst - Easy Plast
4354	310	41	2026-10-06 04:49:25.101824	A310	Alarm Lini Niverplast - Transport System
4355	311	41	2026-10-06 04:49:25.101824	A311	Błąd Lini Niverplst - Transport System
4356	309	39	2026-10-06 04:50:25.177798	A309	Błąd Lini Niverplst - Easy Plast
4357	310	41	2026-10-06 04:50:25.177798	A310	Alarm Lini Niverplast - Transport System
4358	311	41	2026-10-06 04:50:25.177798	A311	Błąd Lini Niverplst - Transport System
4359	309	39	2026-10-06 04:51:25.233602	A309	Błąd Lini Niverplst - Easy Plast
4360	310	41	2026-10-06 04:51:25.233602	A310	Alarm Lini Niverplast - Transport System
4361	311	41	2026-10-06 04:51:25.233602	A311	Błąd Lini Niverplst - Transport System
4362	309	39	2026-10-06 04:52:25.312713	A309	Błąd Lini Niverplst - Easy Plast
4363	310	41	2026-10-06 04:52:25.312713	A310	Alarm Lini Niverplast - Transport System
4364	311	41	2026-10-06 04:52:25.312713	A311	Błąd Lini Niverplst - Transport System
4365	309	39	2026-10-06 04:53:25.366901	A309	Błąd Lini Niverplst - Easy Plast
4366	310	41	2026-10-06 04:53:25.366901	A310	Alarm Lini Niverplast - Transport System
4367	311	41	2026-10-06 04:53:25.366901	A311	Błąd Lini Niverplst - Transport System
4368	309	39	2026-10-06 04:54:25.517394	A309	Błąd Lini Niverplst - Easy Plast
4369	310	41	2026-10-06 04:54:25.517394	A310	Alarm Lini Niverplast - Transport System
4370	311	41	2026-10-06 04:54:25.517394	A311	Błąd Lini Niverplst - Transport System
4371	309	39	2026-10-06 04:55:25.470267	A309	Błąd Lini Niverplst - Easy Plast
4372	310	41	2026-10-06 04:55:25.470267	A310	Alarm Lini Niverplast - Transport System
4373	311	41	2026-10-06 04:55:25.470267	A311	Błąd Lini Niverplst - Transport System
4374	309	39	2026-10-06 04:56:25.664338	A309	Błąd Lini Niverplst - Easy Plast
4375	310	41	2026-10-06 04:56:25.664338	A310	Alarm Lini Niverplast - Transport System
4376	311	41	2026-10-06 04:56:25.664338	A311	Błąd Lini Niverplst - Transport System
4377	309	39	2026-10-06 04:57:25.737254	A309	Błąd Lini Niverplst - Easy Plast
4378	310	41	2026-10-06 04:57:25.737254	A310	Alarm Lini Niverplast - Transport System
4379	311	41	2026-10-06 04:57:25.737254	A311	Błąd Lini Niverplst - Transport System
4380	309	39	2026-10-06 04:58:25.656304	A309	Błąd Lini Niverplst - Easy Plast
4381	310	41	2026-10-06 04:58:25.656304	A310	Alarm Lini Niverplast - Transport System
4382	311	41	2026-10-06 04:58:25.656304	A311	Błąd Lini Niverplst - Transport System
4383	309	39	2026-10-06 04:59:25.720432	A309	Błąd Lini Niverplst - Easy Plast
4384	310	41	2026-10-06 04:59:25.720432	A310	Alarm Lini Niverplast - Transport System
4385	311	41	2026-10-06 04:59:25.720432	A311	Błąd Lini Niverplst - Transport System
4386	309	39	2026-10-06 05:00:25.796929	A309	Błąd Lini Niverplst - Easy Plast
4387	310	41	2026-10-06 05:00:25.796929	A310	Alarm Lini Niverplast - Transport System
4388	311	41	2026-10-06 05:00:25.796929	A311	Błąd Lini Niverplst - Transport System
4389	309	39	2026-10-06 05:01:25.583137	A309	Błąd Lini Niverplst - Easy Plast
4390	310	41	2026-10-06 05:01:25.583137	A310	Alarm Lini Niverplast - Transport System
4391	311	41	2026-10-06 05:01:25.583137	A311	Błąd Lini Niverplst - Transport System
4392	309	39	2026-10-06 05:02:25.886464	A309	Błąd Lini Niverplst - Easy Plast
4393	310	41	2026-10-06 05:02:25.886464	A310	Alarm Lini Niverplast - Transport System
4394	311	41	2026-10-06 05:02:25.886464	A311	Błąd Lini Niverplst - Transport System
4395	309	39	2026-10-06 05:03:25.961473	A309	Błąd Lini Niverplst - Easy Plast
4396	310	41	2026-10-06 05:03:25.961473	A310	Alarm Lini Niverplast - Transport System
4397	311	41	2026-10-06 05:03:25.961473	A311	Błąd Lini Niverplst - Transport System
4398	309	39	2026-10-06 05:04:26.013483	A309	Błąd Lini Niverplst - Easy Plast
4399	310	41	2026-10-06 05:04:26.013483	A310	Alarm Lini Niverplast - Transport System
4400	311	41	2026-10-06 05:04:26.013483	A311	Błąd Lini Niverplst - Transport System
4401	309	39	2026-10-06 05:05:26.065139	A309	Błąd Lini Niverplst - Easy Plast
4402	310	41	2026-10-06 05:05:26.065139	A310	Alarm Lini Niverplast - Transport System
4403	311	41	2026-10-06 05:05:26.065139	A311	Błąd Lini Niverplst - Transport System
4404	309	39	2026-10-06 05:06:26.097137	A309	Błąd Lini Niverplst - Easy Plast
4405	310	41	2026-10-06 05:06:26.097137	A310	Alarm Lini Niverplast - Transport System
4406	311	41	2026-10-06 05:06:26.097137	A311	Błąd Lini Niverplst - Transport System
4407	309	39	2026-10-06 05:07:26.147396	A309	Błąd Lini Niverplst - Easy Plast
4408	310	41	2026-10-06 05:07:26.147396	A310	Alarm Lini Niverplast - Transport System
4409	311	41	2026-10-06 05:07:26.147396	A311	Błąd Lini Niverplst - Transport System
4410	309	39	2026-10-06 05:08:26.222449	A309	Błąd Lini Niverplst - Easy Plast
4411	310	41	2026-10-06 05:08:26.222449	A310	Alarm Lini Niverplast - Transport System
4412	311	41	2026-10-06 05:08:26.222449	A311	Błąd Lini Niverplst - Transport System
4413	309	39	2026-10-06 05:09:26.256397	A309	Błąd Lini Niverplst - Easy Plast
4414	310	41	2026-10-06 05:09:26.256397	A310	Alarm Lini Niverplast - Transport System
4415	311	41	2026-10-06 05:09:26.256397	A311	Błąd Lini Niverplst - Transport System
4416	309	39	2026-10-06 05:10:26.343187	A309	Błąd Lini Niverplst - Easy Plast
4417	310	41	2026-10-06 05:10:26.343187	A310	Alarm Lini Niverplast - Transport System
4418	311	41	2026-10-06 05:10:26.343187	A311	Błąd Lini Niverplst - Transport System
4419	309	39	2026-10-06 05:11:26.389926	A309	Błąd Lini Niverplst - Easy Plast
4420	310	41	2026-10-06 05:11:26.389926	A310	Alarm Lini Niverplast - Transport System
4421	311	41	2026-10-06 05:11:26.389926	A311	Błąd Lini Niverplst - Transport System
4422	309	39	2026-10-06 05:12:26.426726	A309	Błąd Lini Niverplst - Easy Plast
4423	310	41	2026-10-06 05:12:26.426726	A310	Alarm Lini Niverplast - Transport System
4424	311	41	2026-10-06 05:12:26.426726	A311	Błąd Lini Niverplst - Transport System
4425	309	39	2026-10-06 05:13:26.472809	A309	Błąd Lini Niverplst - Easy Plast
4426	310	41	2026-10-06 05:13:26.472809	A310	Alarm Lini Niverplast - Transport System
4427	311	41	2026-10-06 05:13:26.472809	A311	Błąd Lini Niverplst - Transport System
4428	309	39	2026-10-06 05:14:26.479106	A309	Błąd Lini Niverplst - Easy Plast
4429	310	41	2026-10-06 05:14:26.479106	A310	Alarm Lini Niverplast - Transport System
4430	311	41	2026-10-06 05:14:26.479106	A311	Błąd Lini Niverplst - Transport System
4431	309	39	2026-10-06 05:15:26.55313	A309	Błąd Lini Niverplst - Easy Plast
4432	310	41	2026-10-06 05:15:26.55313	A310	Alarm Lini Niverplast - Transport System
4433	311	41	2026-10-06 05:15:26.55313	A311	Błąd Lini Niverplst - Transport System
4434	309	39	2026-10-06 05:16:26.609312	A309	Błąd Lini Niverplst - Easy Plast
4435	310	41	2026-10-06 05:16:26.609312	A310	Alarm Lini Niverplast - Transport System
4436	311	41	2026-10-06 05:16:26.609312	A311	Błąd Lini Niverplst - Transport System
4437	309	39	2026-10-06 05:17:26.657692	A309	Błąd Lini Niverplst - Easy Plast
4438	310	41	2026-10-06 05:17:26.657692	A310	Alarm Lini Niverplast - Transport System
4439	311	41	2026-10-06 05:17:26.657692	A311	Błąd Lini Niverplst - Transport System
4440	309	39	2026-10-06 05:18:26.546361	A309	Błąd Lini Niverplst - Easy Plast
4441	310	41	2026-10-06 05:18:26.546361	A310	Alarm Lini Niverplast - Transport System
4442	311	41	2026-10-06 05:18:26.546361	A311	Błąd Lini Niverplst - Transport System
4443	309	39	2026-10-06 05:19:26.703492	A309	Błąd Lini Niverplst - Easy Plast
4444	310	41	2026-10-06 05:19:26.703492	A310	Alarm Lini Niverplast - Transport System
4445	311	41	2026-10-06 05:19:26.703492	A311	Błąd Lini Niverplst - Transport System
4446	309	39	2026-10-06 05:20:26.66952	A309	Błąd Lini Niverplst - Easy Plast
4447	310	41	2026-10-06 05:20:26.66952	A310	Alarm Lini Niverplast - Transport System
4448	311	41	2026-10-06 05:20:26.66952	A311	Błąd Lini Niverplst - Transport System
4449	309	39	2026-10-06 05:21:26.707611	A309	Błąd Lini Niverplst - Easy Plast
4450	310	41	2026-10-06 05:21:26.707611	A310	Alarm Lini Niverplast - Transport System
4451	311	41	2026-10-06 05:21:26.707611	A311	Błąd Lini Niverplst - Transport System
4452	309	39	2026-10-06 05:22:26.805245	A309	Błąd Lini Niverplst - Easy Plast
4453	310	41	2026-10-06 05:22:26.805245	A310	Alarm Lini Niverplast - Transport System
4454	311	41	2026-10-06 05:22:26.805245	A311	Błąd Lini Niverplst - Transport System
4455	309	39	2026-10-06 05:23:26.854897	A309	Błąd Lini Niverplst - Easy Plast
4456	310	41	2026-10-06 05:23:26.854897	A310	Alarm Lini Niverplast - Transport System
4457	311	41	2026-10-06 05:23:26.854897	A311	Błąd Lini Niverplst - Transport System
4458	309	39	2026-10-06 05:24:26.947806	A309	Błąd Lini Niverplst - Easy Plast
4459	310	41	2026-10-06 05:24:26.947806	A310	Alarm Lini Niverplast - Transport System
4460	311	41	2026-10-06 05:24:26.947806	A311	Błąd Lini Niverplst - Transport System
4461	309	39	2026-10-06 05:25:27.034782	A309	Błąd Lini Niverplst - Easy Plast
4462	310	41	2026-10-06 05:25:27.034782	A310	Alarm Lini Niverplast - Transport System
4463	311	41	2026-10-06 05:25:27.034782	A311	Błąd Lini Niverplst - Transport System
4464	309	39	2026-10-06 05:26:27.081146	A309	Błąd Lini Niverplst - Easy Plast
4465	310	41	2026-10-06 05:26:27.081146	A310	Alarm Lini Niverplast - Transport System
4466	311	41	2026-10-06 05:26:27.081146	A311	Błąd Lini Niverplst - Transport System
4467	309	39	2026-10-06 05:27:27.093218	A309	Błąd Lini Niverplst - Easy Plast
4468	310	41	2026-10-06 05:27:27.093218	A310	Alarm Lini Niverplast - Transport System
4469	311	41	2026-10-06 05:27:27.093218	A311	Błąd Lini Niverplst - Transport System
4611	309	39	2026-10-06 06:05:29.735227	A309	Błąd Lini Niverplst - Easy Plast
4612	310	41	2026-10-06 06:05:29.735227	A310	Alarm Lini Niverplast - Transport System
4613	311	41	2026-10-06 06:05:29.735227	A311	Błąd Lini Niverplst - Transport System
4614	317	40	2026-10-06 06:05:29.735227	A317	Alarm lini Niverplast
4627	309	39	2026-10-06 06:09:29.343783	A309	Błąd Lini Niverplst - Easy Plast
4628	310	41	2026-10-06 06:09:29.343783	A310	Alarm Lini Niverplast - Transport System
4629	311	41	2026-10-06 06:09:29.343783	A311	Błąd Lini Niverplst - Transport System
4630	317	40	2026-10-06 06:09:29.343783	A317	Alarm lini Niverplast
4643	309	39	2026-10-06 06:13:29.722056	A309	Błąd Lini Niverplst - Easy Plast
4644	310	41	2026-10-06 06:13:29.722056	A310	Alarm Lini Niverplast - Transport System
4645	311	41	2026-10-06 06:13:29.722056	A311	Błąd Lini Niverplst - Transport System
4646	317	40	2026-10-06 06:13:29.722056	A317	Alarm lini Niverplast
4659	309	39	2026-10-06 06:17:30.098222	A309	Błąd Lini Niverplst - Easy Plast
4660	310	41	2026-10-06 06:17:30.098222	A310	Alarm Lini Niverplast - Transport System
4661	311	41	2026-10-06 06:17:30.098222	A311	Błąd Lini Niverplst - Transport System
4662	317	40	2026-10-06 06:17:30.098222	A317	Alarm lini Niverplast
4675	309	39	2026-10-06 06:21:30.501978	A309	Błąd Lini Niverplst - Easy Plast
4676	310	41	2026-10-06 06:21:30.501978	A310	Alarm Lini Niverplast - Transport System
4677	311	41	2026-10-06 06:21:30.501978	A311	Błąd Lini Niverplst - Transport System
4678	317	40	2026-10-06 06:21:30.501978	A317	Alarm lini Niverplast
4691	309	39	2026-10-06 06:25:30.817977	A309	Błąd Lini Niverplst - Easy Plast
4692	310	41	2026-10-06 06:25:30.817977	A310	Alarm Lini Niverplast - Transport System
4693	311	41	2026-10-06 06:25:30.817977	A311	Błąd Lini Niverplst - Transport System
4694	317	40	2026-10-06 06:25:30.817977	A317	Alarm lini Niverplast
4707	309	39	2026-10-06 06:29:31.196817	A309	Błąd Lini Niverplst - Easy Plast
4708	310	41	2026-10-06 06:29:31.196817	A310	Alarm Lini Niverplast - Transport System
4709	311	41	2026-10-06 06:29:31.196817	A311	Błąd Lini Niverplst - Transport System
4710	317	40	2026-10-06 06:29:31.196817	A317	Alarm lini Niverplast
4723	309	39	2026-10-06 06:33:30.819496	A309	Błąd Lini Niverplst - Easy Plast
4724	310	41	2026-10-06 06:33:30.819496	A310	Alarm Lini Niverplast - Transport System
4725	311	41	2026-10-06 06:33:30.819496	A311	Błąd Lini Niverplst - Transport System
4726	317	40	2026-10-06 06:33:30.819496	A317	Alarm lini Niverplast
4739	309	39	2026-10-06 06:37:31.202653	A309	Błąd Lini Niverplst - Easy Plast
4740	310	41	2026-10-06 06:37:31.202653	A310	Alarm Lini Niverplast - Transport System
4741	311	41	2026-10-06 06:37:31.202653	A311	Błąd Lini Niverplst - Transport System
4742	317	40	2026-10-06 06:37:31.202653	A317	Alarm lini Niverplast
4755	309	39	2026-10-06 06:41:31.59896	A309	Błąd Lini Niverplst - Easy Plast
4756	310	41	2026-10-06 06:41:31.59896	A310	Alarm Lini Niverplast - Transport System
4757	311	41	2026-10-06 06:41:31.59896	A311	Błąd Lini Niverplst - Transport System
4758	317	40	2026-10-06 06:41:31.59896	A317	Alarm lini Niverplast
4767	309	39	2026-10-06 06:44:31.862778	A309	Błąd Lini Niverplst - Easy Plast
4768	310	41	2026-10-06 06:44:31.862778	A310	Alarm Lini Niverplast - Transport System
4769	311	41	2026-10-06 06:44:31.862778	A311	Błąd Lini Niverplst - Transport System
4770	317	40	2026-10-06 06:44:31.862778	A317	Alarm lini Niverplast
4779	309	39	2026-10-06 06:47:32.166743	A309	Błąd Lini Niverplst - Easy Plast
4780	310	41	2026-10-06 06:47:32.166743	A310	Alarm Lini Niverplast - Transport System
4781	311	41	2026-10-06 06:47:32.166743	A311	Błąd Lini Niverplst - Transport System
4782	317	40	2026-10-06 06:47:32.166743	A317	Alarm lini Niverplast
4787	309	39	2026-10-06 06:49:32.347096	A309	Błąd Lini Niverplst - Easy Plast
4788	310	41	2026-10-06 06:49:32.347096	A310	Alarm Lini Niverplast - Transport System
4789	311	41	2026-10-06 06:49:32.347096	A311	Błąd Lini Niverplst - Transport System
4790	317	40	2026-10-06 06:49:32.347096	A317	Alarm lini Niverplast
4795	309	39	2026-10-06 06:51:31.754917	A309	Błąd Lini Niverplst - Easy Plast
4796	310	41	2026-10-06 06:51:31.754917	A310	Alarm Lini Niverplast - Transport System
4797	311	41	2026-10-06 06:51:31.754917	A311	Błąd Lini Niverplst - Transport System
4798	317	40	2026-10-06 06:51:31.754917	A317	Alarm lini Niverplast
4803	309	39	2026-10-06 06:53:31.948958	A309	Błąd Lini Niverplst - Easy Plast
4804	310	41	2026-10-06 06:53:31.948958	A310	Alarm Lini Niverplast - Transport System
4805	311	41	2026-10-06 06:53:31.948958	A311	Błąd Lini Niverplst - Transport System
4806	317	40	2026-10-06 06:53:31.948958	A317	Alarm lini Niverplast
4811	309	39	2026-10-06 06:55:32.132195	A309	Błąd Lini Niverplst - Easy Plast
4812	310	41	2026-10-06 06:55:32.132195	A310	Alarm Lini Niverplast - Transport System
4813	311	41	2026-10-06 06:55:32.132195	A311	Błąd Lini Niverplst - Transport System
4814	317	40	2026-10-06 06:55:32.132195	A317	Alarm lini Niverplast
4819	309	39	2026-10-06 06:57:32.347136	A309	Błąd Lini Niverplst - Easy Plast
4820	310	41	2026-10-06 06:57:32.347136	A310	Alarm Lini Niverplast - Transport System
4821	311	41	2026-10-06 06:57:32.347136	A311	Błąd Lini Niverplst - Transport System
4822	317	40	2026-10-06 06:57:32.347136	A317	Alarm lini Niverplast
4827	309	39	2026-10-06 06:59:32.523346	A309	Błąd Lini Niverplst - Easy Plast
4828	310	41	2026-10-06 06:59:32.523346	A310	Alarm Lini Niverplast - Transport System
4829	311	41	2026-10-06 06:59:32.523346	A311	Błąd Lini Niverplst - Transport System
4830	317	40	2026-10-06 06:59:32.523346	A317	Alarm lini Niverplast
4835	309	39	2026-10-06 07:01:32.732989	A309	Błąd Lini Niverplst - Easy Plast
4836	310	41	2026-10-06 07:01:32.732989	A310	Alarm Lini Niverplast - Transport System
4837	311	41	2026-10-06 07:01:32.732989	A311	Błąd Lini Niverplst - Transport System
4838	317	40	2026-10-06 07:01:32.732989	A317	Alarm lini Niverplast
4843	309	39	2026-10-06 07:03:32.93008	A309	Błąd Lini Niverplst - Easy Plast
4844	310	41	2026-10-06 07:03:32.93008	A310	Alarm Lini Niverplast - Transport System
4845	311	41	2026-10-06 07:03:32.93008	A311	Błąd Lini Niverplst - Transport System
4846	317	40	2026-10-06 07:03:32.93008	A317	Alarm lini Niverplast
4851	309	39	2026-10-06 07:05:33.12092	A309	Błąd Lini Niverplst - Easy Plast
4852	310	41	2026-10-06 07:05:33.12092	A310	Alarm Lini Niverplast - Transport System
4853	311	41	2026-10-06 07:05:33.12092	A311	Błąd Lini Niverplst - Transport System
4854	317	40	2026-10-06 07:05:33.12092	A317	Alarm lini Niverplast
4471	193	40	2026-10-06 05:28:27.251924	A193	Niskie ciśnienie pneumatyczne - strefa 2
4472	113	40	2026-10-06 05:28:27.251924	A113	Niskie ciśnienie pneumatyczne strefa E-Stop
4473	129	40	2026-10-06 05:28:27.251924	A129	Niskie ciśnienie pneumatyczne - strefa 1
4474	241	40	2026-10-06 05:28:27.251924	A241	Niskie ciśnienie pneumatyczne - strefa 3
4475	309	39	2026-10-06 05:28:27.251924	A309	Błąd Lini Niverplst - Easy Plast
4476	310	41	2026-10-06 05:28:27.251924	A310	Alarm Lini Niverplast - Transport System
4477	311	41	2026-10-06 05:28:27.251924	A311	Błąd Lini Niverplst - Transport System
4478	188	40	2026-10-06 05:28:27.251924	A188	Nieryglowany zamek bramki bezpieszeństwa
4479	226	9	2026-10-06 05:28:27.251924	A226	Niezaryglowany zamek bramki bezpieczenstwa 
4480	129	40	2026-10-06 05:29:27.304133	A129	Niskie ciśnienie pneumatyczne - strefa 1
4481	309	39	2026-10-06 05:29:27.304133	A309	Błąd Lini Niverplst - Easy Plast
4482	310	41	2026-10-06 05:29:27.304133	A310	Alarm Lini Niverplast - Transport System
4483	311	41	2026-10-06 05:29:27.304133	A311	Błąd Lini Niverplst - Transport System
4484	188	40	2026-10-06 05:29:27.304133	A188	Nieryglowany zamek bramki bezpieszeństwa
4485	309	39	2026-10-06 05:30:27.403868	A309	Błąd Lini Niverplst - Easy Plast
4486	310	41	2026-10-06 05:30:27.403868	A310	Alarm Lini Niverplast - Transport System
4487	311	41	2026-10-06 05:30:27.403868	A311	Błąd Lini Niverplst - Transport System
4488	338	7	2026-10-06 05:31:27.368848	A338	Robot Kawasaki - zbyt wysoki numer rzędu
4489	309	39	2026-10-06 05:31:27.368848	A309	Błąd Lini Niverplst - Easy Plast
4490	310	41	2026-10-06 05:31:27.368848	A310	Alarm Lini Niverplast - Transport System
4491	311	41	2026-10-06 05:31:27.368848	A311	Błąd Lini Niverplst - Transport System
4492	338	7	2026-10-06 05:32:27.563376	A338	Robot Kawasaki - zbyt wysoki numer rzędu
4493	309	39	2026-10-06 05:32:27.563376	A309	Błąd Lini Niverplst - Easy Plast
4494	310	41	2026-10-06 05:32:27.563376	A310	Alarm Lini Niverplast - Transport System
4495	311	41	2026-10-06 05:32:27.563376	A311	Błąd Lini Niverplst - Transport System
4496	338	7	2026-10-06 05:33:27.626401	A338	Robot Kawasaki - zbyt wysoki numer rzędu
4497	309	39	2026-10-06 05:33:27.626401	A309	Błąd Lini Niverplst - Easy Plast
4498	310	41	2026-10-06 05:33:27.626401	A310	Alarm Lini Niverplast - Transport System
4499	311	41	2026-10-06 05:33:27.626401	A311	Błąd Lini Niverplst - Transport System
4500	338	7	2026-10-06 05:34:27.746995	A338	Robot Kawasaki - zbyt wysoki numer rzędu
4501	309	39	2026-10-06 05:34:27.746995	A309	Błąd Lini Niverplst - Easy Plast
4502	310	41	2026-10-06 05:34:27.746995	A310	Alarm Lini Niverplast - Transport System
4503	311	41	2026-10-06 05:34:27.746995	A311	Błąd Lini Niverplst - Transport System
4504	338	7	2026-10-06 05:35:27.823803	A338	Robot Kawasaki - zbyt wysoki numer rzędu
4505	309	39	2026-10-06 05:35:27.823803	A309	Błąd Lini Niverplst - Easy Plast
4506	310	41	2026-10-06 05:35:27.823803	A310	Alarm Lini Niverplast - Transport System
4507	311	41	2026-10-06 05:35:27.823803	A311	Błąd Lini Niverplst - Transport System
4508	309	39	2026-10-06 05:36:27.900555	A309	Błąd Lini Niverplst - Easy Plast
4509	310	41	2026-10-06 05:36:27.900555	A310	Alarm Lini Niverplast - Transport System
4510	311	41	2026-10-06 05:36:27.900555	A311	Błąd Lini Niverplst - Transport System
4511	338	7	2026-10-06 05:37:27.986832	A338	Robot Kawasaki - zbyt wysoki numer rzędu
4512	309	39	2026-10-06 05:37:27.986832	A309	Błąd Lini Niverplst - Easy Plast
4513	310	41	2026-10-06 05:37:27.986832	A310	Alarm Lini Niverplast - Transport System
4514	311	41	2026-10-06 05:37:27.986832	A311	Błąd Lini Niverplst - Transport System
4515	309	39	2026-10-06 05:38:28.068008	A309	Błąd Lini Niverplst - Easy Plast
4516	310	41	2026-10-06 05:38:28.068008	A310	Alarm Lini Niverplast - Transport System
4517	311	41	2026-10-06 05:38:28.068008	A311	Błąd Lini Niverplst - Transport System
4518	309	39	2026-10-06 05:39:28.144097	A309	Błąd Lini Niverplst - Easy Plast
4519	310	41	2026-10-06 05:39:28.144097	A310	Alarm Lini Niverplast - Transport System
4520	311	41	2026-10-06 05:39:28.144097	A311	Błąd Lini Niverplst - Transport System
4521	309	39	2026-10-06 05:40:28.2218	A309	Błąd Lini Niverplst - Easy Plast
4522	310	41	2026-10-06 05:40:28.2218	A310	Alarm Lini Niverplast - Transport System
4523	311	41	2026-10-06 05:40:28.2218	A311	Błąd Lini Niverplst - Transport System
4524	309	39	2026-10-06 05:41:28.416834	A309	Błąd Lini Niverplst - Easy Plast
4525	310	41	2026-10-06 05:41:28.416834	A310	Alarm Lini Niverplast - Transport System
4526	311	41	2026-10-06 05:41:28.416834	A311	Błąd Lini Niverplst - Transport System
4527	309	39	2026-10-06 05:42:28.395295	A309	Błąd Lini Niverplst - Easy Plast
4528	310	41	2026-10-06 05:42:28.395295	A310	Alarm Lini Niverplast - Transport System
4529	311	41	2026-10-06 05:42:28.395295	A311	Błąd Lini Niverplst - Transport System
4530	309	39	2026-10-06 05:43:28.485038	A309	Błąd Lini Niverplst - Easy Plast
4531	310	41	2026-10-06 05:43:28.485038	A310	Alarm Lini Niverplast - Transport System
4532	311	41	2026-10-06 05:43:28.485038	A311	Błąd Lini Niverplst - Transport System
4533	309	39	2026-10-06 05:44:28.572897	A309	Błąd Lini Niverplst - Easy Plast
4534	310	41	2026-10-06 05:44:28.572897	A310	Alarm Lini Niverplast - Transport System
4535	311	41	2026-10-06 05:44:28.572897	A311	Błąd Lini Niverplst - Transport System
4536	309	39	2026-10-06 05:45:28.66895	A309	Błąd Lini Niverplst - Easy Plast
4537	310	41	2026-10-06 05:45:28.66895	A310	Alarm Lini Niverplast - Transport System
4538	311	41	2026-10-06 05:45:28.66895	A311	Błąd Lini Niverplst - Transport System
4539	309	39	2026-10-06 05:46:28.076724	A309	Błąd Lini Niverplst - Easy Plast
4540	310	41	2026-10-06 05:46:28.076724	A310	Alarm Lini Niverplast - Transport System
4541	311	41	2026-10-06 05:46:28.076724	A311	Błąd Lini Niverplst - Transport System
4542	309	39	2026-10-06 05:47:28.112457	A309	Błąd Lini Niverplst - Easy Plast
4543	310	41	2026-10-06 05:47:28.112457	A310	Alarm Lini Niverplast - Transport System
4544	311	41	2026-10-06 05:47:28.112457	A311	Błąd Lini Niverplst - Transport System
4545	309	39	2026-10-06 05:48:28.246523	A309	Błąd Lini Niverplst - Easy Plast
4546	310	41	2026-10-06 05:48:28.246523	A310	Alarm Lini Niverplast - Transport System
4547	311	41	2026-10-06 05:48:28.246523	A311	Błąd Lini Niverplst - Transport System
4548	309	39	2026-10-06 05:49:28.2966	A309	Błąd Lini Niverplst - Easy Plast
4549	310	41	2026-10-06 05:49:28.2966	A310	Alarm Lini Niverplast - Transport System
4550	311	41	2026-10-06 05:49:28.2966	A311	Błąd Lini Niverplst - Transport System
4551	309	39	2026-10-06 05:50:28.353423	A309	Błąd Lini Niverplst - Easy Plast
4552	310	41	2026-10-06 05:50:28.353423	A310	Alarm Lini Niverplast - Transport System
4553	311	41	2026-10-06 05:50:28.353423	A311	Błąd Lini Niverplst - Transport System
4554	317	40	2026-10-06 05:50:28.353423	A317	Alarm lini Niverplast
4555	309	39	2026-10-06 05:51:28.452354	A309	Błąd Lini Niverplst - Easy Plast
4556	310	41	2026-10-06 05:51:28.452354	A310	Alarm Lini Niverplast - Transport System
4557	311	41	2026-10-06 05:51:28.452354	A311	Błąd Lini Niverplst - Transport System
4558	317	40	2026-10-06 05:51:28.452354	A317	Alarm lini Niverplast
4559	309	39	2026-10-06 05:52:28.571099	A309	Błąd Lini Niverplst - Easy Plast
4560	310	41	2026-10-06 05:52:28.571099	A310	Alarm Lini Niverplast - Transport System
4561	311	41	2026-10-06 05:52:28.571099	A311	Błąd Lini Niverplst - Transport System
4562	317	40	2026-10-06 05:52:28.571099	A317	Alarm lini Niverplast
4563	309	39	2026-10-06 05:53:28.659912	A309	Błąd Lini Niverplst - Easy Plast
4564	310	41	2026-10-06 05:53:28.659912	A310	Alarm Lini Niverplast - Transport System
4565	311	41	2026-10-06 05:53:28.659912	A311	Błąd Lini Niverplst - Transport System
4566	317	40	2026-10-06 05:53:28.659912	A317	Alarm lini Niverplast
4567	309	39	2026-10-06 05:54:28.753664	A309	Błąd Lini Niverplst - Easy Plast
4568	310	41	2026-10-06 05:54:28.753664	A310	Alarm Lini Niverplast - Transport System
4569	311	41	2026-10-06 05:54:28.753664	A311	Błąd Lini Niverplst - Transport System
4570	317	40	2026-10-06 05:54:28.753664	A317	Alarm lini Niverplast
4571	309	39	2026-10-06 05:55:28.831144	A309	Błąd Lini Niverplst - Easy Plast
4572	310	41	2026-10-06 05:55:28.831144	A310	Alarm Lini Niverplast - Transport System
4573	311	41	2026-10-06 05:55:28.831144	A311	Błąd Lini Niverplst - Transport System
4574	317	40	2026-10-06 05:55:28.831144	A317	Alarm lini Niverplast
4575	309	39	2026-10-06 05:56:28.926076	A309	Błąd Lini Niverplst - Easy Plast
4576	310	41	2026-10-06 05:56:28.926076	A310	Alarm Lini Niverplast - Transport System
4577	311	41	2026-10-06 05:56:28.926076	A311	Błąd Lini Niverplst - Transport System
4578	317	40	2026-10-06 05:56:28.926076	A317	Alarm lini Niverplast
4579	309	39	2026-10-06 05:57:29.01242	A309	Błąd Lini Niverplst - Easy Plast
4580	310	41	2026-10-06 05:57:29.01242	A310	Alarm Lini Niverplast - Transport System
4581	311	41	2026-10-06 05:57:29.01242	A311	Błąd Lini Niverplst - Transport System
4582	317	40	2026-10-06 05:57:29.01242	A317	Alarm lini Niverplast
4583	309	39	2026-10-06 05:58:29.106465	A309	Błąd Lini Niverplst - Easy Plast
4584	310	41	2026-10-06 05:58:29.106465	A310	Alarm Lini Niverplast - Transport System
4585	311	41	2026-10-06 05:58:29.106465	A311	Błąd Lini Niverplst - Transport System
4586	317	40	2026-10-06 05:58:29.106465	A317	Alarm lini Niverplast
4587	309	39	2026-10-06 05:59:29.189618	A309	Błąd Lini Niverplst - Easy Plast
4588	310	41	2026-10-06 05:59:29.189618	A310	Alarm Lini Niverplast - Transport System
4589	311	41	2026-10-06 05:59:29.189618	A311	Błąd Lini Niverplst - Transport System
4590	317	40	2026-10-06 05:59:29.189618	A317	Alarm lini Niverplast
4591	309	39	2026-10-06 06:00:29.311476	A309	Błąd Lini Niverplst - Easy Plast
4592	310	41	2026-10-06 06:00:29.311476	A310	Alarm Lini Niverplast - Transport System
4593	311	41	2026-10-06 06:00:29.311476	A311	Błąd Lini Niverplst - Transport System
4594	317	40	2026-10-06 06:00:29.311476	A317	Alarm lini Niverplast
4595	309	39	2026-10-06 06:01:29.379432	A309	Błąd Lini Niverplst - Easy Plast
4596	310	41	2026-10-06 06:01:29.379432	A310	Alarm Lini Niverplast - Transport System
4597	311	41	2026-10-06 06:01:29.379432	A311	Błąd Lini Niverplst - Transport System
4598	317	40	2026-10-06 06:01:29.379432	A317	Alarm lini Niverplast
4599	309	39	2026-10-06 06:02:29.450264	A309	Błąd Lini Niverplst - Easy Plast
4600	310	41	2026-10-06 06:02:29.450264	A310	Alarm Lini Niverplast - Transport System
4601	311	41	2026-10-06 06:02:29.450264	A311	Błąd Lini Niverplst - Transport System
4602	317	40	2026-10-06 06:02:29.450264	A317	Alarm lini Niverplast
4615	309	39	2026-10-06 06:06:29.822092	A309	Błąd Lini Niverplst - Easy Plast
4616	310	41	2026-10-06 06:06:29.822092	A310	Alarm Lini Niverplast - Transport System
4617	311	41	2026-10-06 06:06:29.822092	A311	Błąd Lini Niverplst - Transport System
4618	317	40	2026-10-06 06:06:29.822092	A317	Alarm lini Niverplast
4631	309	39	2026-10-06 06:10:29.46102	A309	Błąd Lini Niverplst - Easy Plast
4632	310	41	2026-10-06 06:10:29.46102	A310	Alarm Lini Niverplast - Transport System
4633	311	41	2026-10-06 06:10:29.46102	A311	Błąd Lini Niverplst - Transport System
4634	317	40	2026-10-06 06:10:29.46102	A317	Alarm lini Niverplast
4647	309	39	2026-10-06 06:14:29.81438	A309	Błąd Lini Niverplst - Easy Plast
4648	310	41	2026-10-06 06:14:29.81438	A310	Alarm Lini Niverplast - Transport System
4649	311	41	2026-10-06 06:14:29.81438	A311	Błąd Lini Niverplst - Transport System
4650	317	40	2026-10-06 06:14:29.81438	A317	Alarm lini Niverplast
4663	309	39	2026-10-06 06:18:30.196495	A309	Błąd Lini Niverplst - Easy Plast
4664	310	41	2026-10-06 06:18:30.196495	A310	Alarm Lini Niverplast - Transport System
4665	311	41	2026-10-06 06:18:30.196495	A311	Błąd Lini Niverplst - Transport System
4666	317	40	2026-10-06 06:18:30.196495	A317	Alarm lini Niverplast
4679	309	39	2026-10-06 06:22:30.546947	A309	Błąd Lini Niverplst - Easy Plast
4680	310	41	2026-10-06 06:22:30.546947	A310	Alarm Lini Niverplast - Transport System
4681	311	41	2026-10-06 06:22:30.546947	A311	Błąd Lini Niverplst - Transport System
4682	317	40	2026-10-06 06:22:30.546947	A317	Alarm lini Niverplast
4695	309	39	2026-10-06 06:26:30.91598	A309	Błąd Lini Niverplst - Easy Plast
4696	310	41	2026-10-06 06:26:30.91598	A310	Alarm Lini Niverplast - Transport System
4697	311	41	2026-10-06 06:26:30.91598	A311	Błąd Lini Niverplst - Transport System
4698	317	40	2026-10-06 06:26:30.91598	A317	Alarm lini Niverplast
4711	309	39	2026-10-06 06:30:30.541557	A309	Błąd Lini Niverplst - Easy Plast
4712	310	41	2026-10-06 06:30:30.541557	A310	Alarm Lini Niverplast - Transport System
4713	311	41	2026-10-06 06:30:30.541557	A311	Błąd Lini Niverplst - Transport System
4714	317	40	2026-10-06 06:30:30.541557	A317	Alarm lini Niverplast
4727	309	39	2026-10-06 06:34:30.927492	A309	Błąd Lini Niverplst - Easy Plast
4728	310	41	2026-10-06 06:34:30.927492	A310	Alarm Lini Niverplast - Transport System
4729	311	41	2026-10-06 06:34:30.927492	A311	Błąd Lini Niverplst - Transport System
4730	317	40	2026-10-06 06:34:30.927492	A317	Alarm lini Niverplast
4743	309	39	2026-10-06 06:38:31.320777	A309	Błąd Lini Niverplst - Easy Plast
4744	310	41	2026-10-06 06:38:31.320777	A310	Alarm Lini Niverplast - Transport System
4745	311	41	2026-10-06 06:38:31.320777	A311	Błąd Lini Niverplst - Transport System
4746	317	40	2026-10-06 06:38:31.320777	A317	Alarm lini Niverplast
4759	309	39	2026-10-06 06:42:31.670767	A309	Błąd Lini Niverplst - Easy Plast
4857	311	41	2026-10-06 07:06:33.211163	A311	Błąd Lini Niverplst - Transport System
4858	317	40	2026-10-06 07:06:33.211163	A317	Alarm lini Niverplast
4859	309	39	2026-10-06 07:07:33.300006	A309	Błąd Lini Niverplst - Easy Plast
4860	310	41	2026-10-06 07:07:33.300006	A310	Alarm Lini Niverplast - Transport System
4861	311	41	2026-10-06 07:07:33.300006	A311	Błąd Lini Niverplst - Transport System
4862	317	40	2026-10-06 07:07:33.300006	A317	Alarm lini Niverplast
4863	309	39	2026-10-06 07:08:33.424113	A309	Błąd Lini Niverplst - Easy Plast
4864	310	41	2026-10-06 07:08:33.424113	A310	Alarm Lini Niverplast - Transport System
4865	311	41	2026-10-06 07:08:33.424113	A311	Błąd Lini Niverplst - Transport System
4866	317	40	2026-10-06 07:08:33.424113	A317	Alarm lini Niverplast
4867	309	39	2026-10-06 07:09:33.520625	A309	Błąd Lini Niverplst - Easy Plast
4868	310	41	2026-10-06 07:09:33.520625	A310	Alarm Lini Niverplast - Transport System
4869	311	41	2026-10-06 07:09:33.520625	A311	Błąd Lini Niverplst - Transport System
4870	317	40	2026-10-06 07:09:33.520625	A317	Alarm lini Niverplast
4871	309	39	2026-10-06 07:10:33.607715	A309	Błąd Lini Niverplst - Easy Plast
4872	310	41	2026-10-06 07:10:33.607715	A310	Alarm Lini Niverplast - Transport System
4873	311	41	2026-10-06 07:10:33.607715	A311	Błąd Lini Niverplst - Transport System
4874	317	40	2026-10-06 07:10:33.607715	A317	Alarm lini Niverplast
4875	309	39	2026-10-06 07:11:32.876684	A309	Błąd Lini Niverplst - Easy Plast
4876	310	41	2026-10-06 07:11:32.876684	A310	Alarm Lini Niverplast - Transport System
4877	311	41	2026-10-06 07:11:32.876684	A311	Błąd Lini Niverplst - Transport System
4878	317	40	2026-10-06 07:11:32.876684	A317	Alarm lini Niverplast
4879	309	39	2026-10-06 07:12:32.993133	A309	Błąd Lini Niverplst - Easy Plast
4880	310	41	2026-10-06 07:12:32.993133	A310	Alarm Lini Niverplast - Transport System
4881	311	41	2026-10-06 07:12:32.993133	A311	Błąd Lini Niverplst - Transport System
4882	317	40	2026-10-06 07:12:32.993133	A317	Alarm lini Niverplast
4883	309	39	2026-10-06 07:13:33.083145	A309	Błąd Lini Niverplst - Easy Plast
4884	310	41	2026-10-06 07:13:33.083145	A310	Alarm Lini Niverplast - Transport System
4885	311	41	2026-10-06 07:13:33.083145	A311	Błąd Lini Niverplst - Transport System
4886	317	40	2026-10-06 07:13:33.083145	A317	Alarm lini Niverplast
4887	309	39	2026-10-06 07:14:33.189045	A309	Błąd Lini Niverplst - Easy Plast
4888	310	41	2026-10-06 07:14:33.189045	A310	Alarm Lini Niverplast - Transport System
4889	311	41	2026-10-06 07:14:33.189045	A311	Błąd Lini Niverplst - Transport System
4890	317	40	2026-10-06 07:14:33.189045	A317	Alarm lini Niverplast
4891	309	39	2026-10-06 07:15:33.282677	A309	Błąd Lini Niverplst - Easy Plast
4892	310	41	2026-10-06 07:15:33.282677	A310	Alarm Lini Niverplast - Transport System
4893	311	41	2026-10-06 07:15:33.282677	A311	Błąd Lini Niverplst - Transport System
4894	317	40	2026-10-06 07:15:33.282677	A317	Alarm lini Niverplast
4895	309	39	2026-10-06 07:16:33.388384	A309	Błąd Lini Niverplst - Easy Plast
4896	310	41	2026-10-06 07:16:33.388384	A310	Alarm Lini Niverplast - Transport System
4897	311	41	2026-10-06 07:16:33.388384	A311	Błąd Lini Niverplst - Transport System
4898	317	40	2026-10-06 07:16:33.388384	A317	Alarm lini Niverplast
4899	309	39	2026-10-06 07:17:33.491328	A309	Błąd Lini Niverplst - Easy Plast
4900	310	41	2026-10-06 07:17:33.491328	A310	Alarm Lini Niverplast - Transport System
4901	311	41	2026-10-06 07:17:33.491328	A311	Błąd Lini Niverplst - Transport System
4902	317	40	2026-10-06 07:17:33.491328	A317	Alarm lini Niverplast
4903	309	39	2026-10-06 07:18:33.590282	A309	Błąd Lini Niverplst - Easy Plast
4904	310	41	2026-10-06 07:18:33.590282	A310	Alarm Lini Niverplast - Transport System
4905	311	41	2026-10-06 07:18:33.590282	A311	Błąd Lini Niverplst - Transport System
4906	317	40	2026-10-06 07:18:33.590282	A317	Alarm lini Niverplast
4907	309	39	2026-10-06 07:19:33.673142	A309	Błąd Lini Niverplst - Easy Plast
4908	310	41	2026-10-06 07:19:33.673142	A310	Alarm Lini Niverplast - Transport System
4909	311	41	2026-10-06 07:19:33.673142	A311	Błąd Lini Niverplst - Transport System
4910	317	40	2026-10-06 07:19:33.673142	A317	Alarm lini Niverplast
4911	309	39	2026-10-06 07:20:33.794005	A309	Błąd Lini Niverplst - Easy Plast
4912	310	41	2026-10-06 07:20:33.794005	A310	Alarm Lini Niverplast - Transport System
4913	311	41	2026-10-06 07:20:33.794005	A311	Błąd Lini Niverplst - Transport System
4914	317	40	2026-10-06 07:20:33.794005	A317	Alarm lini Niverplast
4915	309	39	2026-10-06 07:21:33.885746	A309	Błąd Lini Niverplst - Easy Plast
4916	310	41	2026-10-06 07:21:33.885746	A310	Alarm Lini Niverplast - Transport System
4917	311	41	2026-10-06 07:21:33.885746	A311	Błąd Lini Niverplst - Transport System
4918	317	40	2026-10-06 07:21:33.885746	A317	Alarm lini Niverplast
4919	309	39	2026-10-06 07:22:33.974753	A309	Błąd Lini Niverplst - Easy Plast
4920	310	41	2026-10-06 07:22:33.974753	A310	Alarm Lini Niverplast - Transport System
4921	311	41	2026-10-06 07:22:33.974753	A311	Błąd Lini Niverplst - Transport System
4922	317	40	2026-10-06 07:22:33.974753	A317	Alarm lini Niverplast
4923	309	39	2026-10-06 07:23:34.084675	A309	Błąd Lini Niverplst - Easy Plast
4924	310	41	2026-10-06 07:23:34.084675	A310	Alarm Lini Niverplast - Transport System
4925	311	41	2026-10-06 07:23:34.084675	A311	Błąd Lini Niverplst - Transport System
4926	309	39	2026-10-06 07:24:34.184438	A309	Błąd Lini Niverplst - Easy Plast
4927	310	41	2026-10-06 07:24:34.184438	A310	Alarm Lini Niverplast - Transport System
4928	311	41	2026-10-06 07:24:34.184438	A311	Błąd Lini Niverplst - Transport System
4929	309	39	2026-10-06 07:25:34.288339	A309	Błąd Lini Niverplst - Easy Plast
4930	310	41	2026-10-06 07:25:34.288339	A310	Alarm Lini Niverplast - Transport System
4931	311	41	2026-10-06 07:25:34.288339	A311	Błąd Lini Niverplst - Transport System
4932	309	39	2026-10-06 07:26:34.383653	A309	Błąd Lini Niverplst - Easy Plast
4933	310	41	2026-10-06 07:26:34.383653	A310	Alarm Lini Niverplast - Transport System
4934	311	41	2026-10-06 07:26:34.383653	A311	Błąd Lini Niverplst - Transport System
4935	309	39	2026-10-06 07:27:34.487666	A309	Błąd Lini Niverplst - Easy Plast
4936	310	41	2026-10-06 07:27:34.487666	A310	Alarm Lini Niverplast - Transport System
4937	311	41	2026-10-06 07:27:34.487666	A311	Błąd Lini Niverplst - Transport System
4938	309	39	2026-10-06 07:28:34.602848	A309	Błąd Lini Niverplst - Easy Plast
4939	310	41	2026-10-06 07:28:34.602848	A310	Alarm Lini Niverplast - Transport System
4940	311	41	2026-10-06 07:28:34.602848	A311	Błąd Lini Niverplst - Transport System
4941	309	39	2026-10-06 07:29:34.68752	A309	Błąd Lini Niverplst - Easy Plast
4942	310	41	2026-10-06 07:29:34.68752	A310	Alarm Lini Niverplast - Transport System
4943	311	41	2026-10-06 07:29:34.68752	A311	Błąd Lini Niverplst - Transport System
4944	309	39	2026-10-06 07:30:33.968066	A309	Błąd Lini Niverplst - Easy Plast
4945	310	41	2026-10-06 07:30:33.968066	A310	Alarm Lini Niverplast - Transport System
4946	311	41	2026-10-06 07:30:33.968066	A311	Błąd Lini Niverplst - Transport System
4947	309	39	2026-10-06 07:31:34.048973	A309	Błąd Lini Niverplst - Easy Plast
4948	310	41	2026-10-06 07:31:34.048973	A310	Alarm Lini Niverplast - Transport System
4949	311	41	2026-10-06 07:31:34.048973	A311	Błąd Lini Niverplst - Transport System
4950	309	39	2026-10-06 07:32:34.172488	A309	Błąd Lini Niverplst - Easy Plast
4951	310	41	2026-10-06 07:32:34.172488	A310	Alarm Lini Niverplast - Transport System
4952	311	41	2026-10-06 07:32:34.172488	A311	Błąd Lini Niverplst - Transport System
4953	309	39	2026-10-06 07:33:34.259569	A309	Błąd Lini Niverplst - Easy Plast
4954	310	41	2026-10-06 07:33:34.259569	A310	Alarm Lini Niverplast - Transport System
4955	311	41	2026-10-06 07:33:34.259569	A311	Błąd Lini Niverplst - Transport System
4956	309	39	2026-10-06 07:34:34.376014	A309	Błąd Lini Niverplst - Easy Plast
4957	310	41	2026-10-06 07:34:34.376014	A310	Alarm Lini Niverplast - Transport System
4958	311	41	2026-10-06 07:34:34.376014	A311	Błąd Lini Niverplst - Transport System
4959	309	39	2026-10-06 07:35:34.467377	A309	Błąd Lini Niverplst - Easy Plast
4960	310	41	2026-10-06 07:35:34.467377	A310	Alarm Lini Niverplast - Transport System
4961	311	41	2026-10-06 07:35:34.467377	A311	Błąd Lini Niverplst - Transport System
4962	309	39	2026-10-06 07:36:34.572008	A309	Błąd Lini Niverplst - Easy Plast
4963	310	41	2026-10-06 07:36:34.572008	A310	Alarm Lini Niverplast - Transport System
4964	311	41	2026-10-06 07:36:34.572008	A311	Błąd Lini Niverplst - Transport System
4965	309	39	2026-10-06 07:37:34.679804	A309	Błąd Lini Niverplst - Easy Plast
4966	310	41	2026-10-06 07:37:34.679804	A310	Alarm Lini Niverplast - Transport System
4967	311	41	2026-10-06 07:37:34.679804	A311	Błąd Lini Niverplst - Transport System
4968	309	39	2026-10-06 07:38:34.784045	A309	Błąd Lini Niverplst - Easy Plast
4969	310	41	2026-10-06 07:38:34.784045	A310	Alarm Lini Niverplast - Transport System
4970	311	41	2026-10-06 07:38:34.784045	A311	Błąd Lini Niverplst - Transport System
4971	309	39	2026-10-06 07:39:34.871745	A309	Błąd Lini Niverplst - Easy Plast
4972	310	41	2026-10-06 07:39:34.871745	A310	Alarm Lini Niverplast - Transport System
4973	311	41	2026-10-06 07:39:34.871745	A311	Błąd Lini Niverplst - Transport System
4974	309	39	2026-10-06 07:40:35.004428	A309	Błąd Lini Niverplst - Easy Plast
4975	310	41	2026-10-06 07:40:35.004428	A310	Alarm Lini Niverplast - Transport System
4976	311	41	2026-10-06 07:40:35.004428	A311	Błąd Lini Niverplst - Transport System
4977	309	39	2026-10-06 07:41:35.079474	A309	Błąd Lini Niverplst - Easy Plast
4978	310	41	2026-10-06 07:41:35.079474	A310	Alarm Lini Niverplast - Transport System
4979	311	41	2026-10-06 07:41:35.079474	A311	Błąd Lini Niverplst - Transport System
4980	309	39	2026-10-06 07:42:36.508849	A309	Błąd Lini Niverplst - Easy Plast
4981	310	41	2026-10-06 07:42:36.508849	A310	Alarm Lini Niverplast - Transport System
4982	311	41	2026-10-06 07:42:36.508849	A311	Błąd Lini Niverplst - Transport System
4983	309	39	2026-10-06 07:43:35.282782	A309	Błąd Lini Niverplst - Easy Plast
4984	310	41	2026-10-06 07:43:35.282782	A310	Alarm Lini Niverplast - Transport System
4985	311	41	2026-10-06 07:43:35.282782	A311	Błąd Lini Niverplst - Transport System
4986	309	39	2026-10-06 07:44:35.393108	A309	Błąd Lini Niverplst - Easy Plast
4987	310	41	2026-10-06 07:44:35.393108	A310	Alarm Lini Niverplast - Transport System
4988	311	41	2026-10-06 07:44:35.393108	A311	Błąd Lini Niverplst - Transport System
4989	309	39	2026-10-06 07:45:35.507369	A309	Błąd Lini Niverplst - Easy Plast
4990	310	41	2026-10-06 07:45:35.507369	A310	Alarm Lini Niverplast - Transport System
4991	311	41	2026-10-06 07:45:35.507369	A311	Błąd Lini Niverplst - Transport System
4992	309	39	2026-10-06 07:46:35.602569	A309	Błąd Lini Niverplst - Easy Plast
4993	310	41	2026-10-06 07:46:35.602569	A310	Alarm Lini Niverplast - Transport System
4994	311	41	2026-10-06 07:46:35.602569	A311	Błąd Lini Niverplst - Transport System
4995	309	39	2026-10-06 07:47:35.715776	A309	Błąd Lini Niverplst - Easy Plast
4996	310	41	2026-10-06 07:47:35.715776	A310	Alarm Lini Niverplast - Transport System
4997	311	41	2026-10-06 07:47:35.715776	A311	Błąd Lini Niverplst - Transport System
4998	309	39	2026-10-06 07:48:35.821449	A309	Błąd Lini Niverplst - Easy Plast
4999	310	41	2026-10-06 07:48:35.821449	A310	Alarm Lini Niverplast - Transport System
5000	311	41	2026-10-06 07:48:35.821449	A311	Błąd Lini Niverplst - Transport System
5001	309	39	2026-10-06 07:49:35.052878	A309	Błąd Lini Niverplst - Easy Plast
5002	310	41	2026-10-06 07:49:35.052878	A310	Alarm Lini Niverplast - Transport System
5003	311	41	2026-10-06 07:49:35.052878	A311	Błąd Lini Niverplst - Transport System
5004	309	39	2026-10-06 07:50:35.165164	A309	Błąd Lini Niverplst - Easy Plast
5005	310	41	2026-10-06 07:50:35.165164	A310	Alarm Lini Niverplast - Transport System
5006	311	41	2026-10-06 07:50:35.165164	A311	Błąd Lini Niverplst - Transport System
5007	309	39	2026-10-06 07:51:35.258405	A309	Błąd Lini Niverplst - Easy Plast
5008	310	41	2026-10-06 07:51:35.258405	A310	Alarm Lini Niverplast - Transport System
5009	311	41	2026-10-06 07:51:35.258405	A311	Błąd Lini Niverplst - Transport System
5010	309	39	2026-10-06 07:52:35.379652	A309	Błąd Lini Niverplst - Easy Plast
5011	310	41	2026-10-06 07:52:35.379652	A310	Alarm Lini Niverplast - Transport System
5012	311	41	2026-10-06 07:52:35.379652	A311	Błąd Lini Niverplst - Transport System
5013	309	39	2026-10-06 07:53:35.476083	A309	Błąd Lini Niverplst - Easy Plast
5014	310	41	2026-10-06 07:53:35.476083	A310	Alarm Lini Niverplast - Transport System
5015	311	41	2026-10-06 07:53:35.476083	A311	Błąd Lini Niverplst - Transport System
5016	309	39	2026-10-06 07:54:35.582295	A309	Błąd Lini Niverplst - Easy Plast
5017	310	41	2026-10-06 07:54:35.582295	A310	Alarm Lini Niverplast - Transport System
5018	311	41	2026-10-06 07:54:35.582295	A311	Błąd Lini Niverplst - Transport System
5019	309	39	2026-10-06 07:55:35.67366	A309	Błąd Lini Niverplst - Easy Plast
5020	310	41	2026-10-06 07:55:35.67366	A310	Alarm Lini Niverplast - Transport System
5021	311	41	2026-10-06 07:55:35.67366	A311	Błąd Lini Niverplst - Transport System
5022	309	39	2026-10-06 07:56:35.8059	A309	Błąd Lini Niverplst - Easy Plast
5023	310	41	2026-10-06 07:56:35.8059	A310	Alarm Lini Niverplast - Transport System
5024	311	41	2026-10-06 07:56:35.8059	A311	Błąd Lini Niverplst - Transport System
5025	309	39	2026-10-06 07:57:35.89257	A309	Błąd Lini Niverplst - Easy Plast
5026	310	41	2026-10-06 07:57:35.89257	A310	Alarm Lini Niverplast - Transport System
5027	311	41	2026-10-06 07:57:35.89257	A311	Błąd Lini Niverplst - Transport System
5028	309	39	2026-10-06 07:58:35.991262	A309	Błąd Lini Niverplst - Easy Plast
5029	310	41	2026-10-06 07:58:35.991262	A310	Alarm Lini Niverplast - Transport System
5030	311	41	2026-10-06 07:58:35.991262	A311	Błąd Lini Niverplst - Transport System
5031	309	39	2026-10-06 07:59:36.104181	A309	Błąd Lini Niverplst - Easy Plast
5032	310	41	2026-10-06 07:59:36.104181	A310	Alarm Lini Niverplast - Transport System
5033	311	41	2026-10-06 07:59:36.104181	A311	Błąd Lini Niverplst - Transport System
5034	309	39	2026-10-06 08:00:36.21079	A309	Błąd Lini Niverplst - Easy Plast
5035	310	41	2026-10-06 08:00:36.21079	A310	Alarm Lini Niverplast - Transport System
5036	311	41	2026-10-06 08:00:36.21079	A311	Błąd Lini Niverplst - Transport System
5037	309	39	2026-10-06 08:01:36.313047	A309	Błąd Lini Niverplst - Easy Plast
5038	310	41	2026-10-06 08:01:36.313047	A310	Alarm Lini Niverplast - Transport System
5039	311	41	2026-10-06 08:01:36.313047	A311	Błąd Lini Niverplst - Transport System
5040	309	39	2026-10-06 08:02:36.402645	A309	Błąd Lini Niverplst - Easy Plast
5041	310	41	2026-10-06 08:02:36.402645	A310	Alarm Lini Niverplast - Transport System
5042	311	41	2026-10-06 08:02:36.402645	A311	Błąd Lini Niverplst - Transport System
5043	309	39	2026-10-06 08:03:36.514671	A309	Błąd Lini Niverplst - Easy Plast
5044	310	41	2026-10-06 08:03:36.514671	A310	Alarm Lini Niverplast - Transport System
5045	311	41	2026-10-06 08:03:36.514671	A311	Błąd Lini Niverplst - Transport System
5046	309	39	2026-10-06 08:04:36.617199	A309	Błąd Lini Niverplst - Easy Plast
5047	310	41	2026-10-06 08:04:36.617199	A310	Alarm Lini Niverplast - Transport System
5048	311	41	2026-10-06 08:04:36.617199	A311	Błąd Lini Niverplst - Transport System
5049	309	39	2026-10-06 08:05:36.720964	A309	Błąd Lini Niverplst - Easy Plast
5050	310	41	2026-10-06 08:05:36.720964	A310	Alarm Lini Niverplast - Transport System
5051	311	41	2026-10-06 08:05:36.720964	A311	Błąd Lini Niverplst - Transport System
5052	309	39	2026-10-06 08:06:36.828651	A309	Błąd Lini Niverplst - Easy Plast
5053	310	41	2026-10-06 08:06:36.828651	A310	Alarm Lini Niverplast - Transport System
5054	311	41	2026-10-06 08:06:36.828651	A311	Błąd Lini Niverplst - Transport System
5055	309	39	2026-10-06 08:07:36.045212	A309	Błąd Lini Niverplst - Easy Plast
5056	310	41	2026-10-06 08:07:36.045212	A310	Alarm Lini Niverplast - Transport System
5057	311	41	2026-10-06 08:07:36.045212	A311	Błąd Lini Niverplst - Transport System
5058	309	39	2026-10-06 08:08:36.17577	A309	Błąd Lini Niverplst - Easy Plast
5059	310	41	2026-10-06 08:08:36.17577	A310	Alarm Lini Niverplast - Transport System
5060	311	41	2026-10-06 08:08:36.17577	A311	Błąd Lini Niverplst - Transport System
5061	309	39	2026-10-06 08:09:36.257828	A309	Błąd Lini Niverplst - Easy Plast
5062	310	41	2026-10-06 08:09:36.257828	A310	Alarm Lini Niverplast - Transport System
5063	311	41	2026-10-06 08:09:36.257828	A311	Błąd Lini Niverplst - Transport System
5064	309	39	2026-10-06 08:10:36.377475	A309	Błąd Lini Niverplst - Easy Plast
5065	310	41	2026-10-06 08:10:36.377475	A310	Alarm Lini Niverplast - Transport System
5066	311	41	2026-10-06 08:10:36.377475	A311	Błąd Lini Niverplst - Transport System
5067	309	39	2026-10-06 08:11:36.468353	A309	Błąd Lini Niverplst - Easy Plast
5068	310	41	2026-10-06 08:11:36.468353	A310	Alarm Lini Niverplast - Transport System
5069	311	41	2026-10-06 08:11:36.468353	A311	Błąd Lini Niverplst - Transport System
5070	309	39	2026-10-06 08:12:36.592697	A309	Błąd Lini Niverplst - Easy Plast
5071	310	41	2026-10-06 08:12:36.592697	A310	Alarm Lini Niverplast - Transport System
5072	311	41	2026-10-06 08:12:36.592697	A311	Błąd Lini Niverplst - Transport System
5073	309	39	2026-10-06 08:13:36.694397	A309	Błąd Lini Niverplst - Easy Plast
5074	310	41	2026-10-06 08:13:36.694397	A310	Alarm Lini Niverplast - Transport System
5075	311	41	2026-10-06 08:13:36.694397	A311	Błąd Lini Niverplst - Transport System
5076	309	39	2026-10-06 08:14:36.801636	A309	Błąd Lini Niverplst - Easy Plast
5077	310	41	2026-10-06 08:14:36.801636	A310	Alarm Lini Niverplast - Transport System
5078	311	41	2026-10-06 08:14:36.801636	A311	Błąd Lini Niverplst - Transport System
5079	309	39	2026-10-06 08:15:36.924927	A309	Błąd Lini Niverplst - Easy Plast
5080	310	41	2026-10-06 08:15:36.924927	A310	Alarm Lini Niverplast - Transport System
5081	311	41	2026-10-06 08:15:36.924927	A311	Błąd Lini Niverplst - Transport System
5082	309	39	2026-10-06 08:16:37.030449	A309	Błąd Lini Niverplst - Easy Plast
5083	310	41	2026-10-06 08:16:37.030449	A310	Alarm Lini Niverplast - Transport System
5084	311	41	2026-10-06 08:16:37.030449	A311	Błąd Lini Niverplst - Transport System
5085	309	39	2026-10-06 08:17:37.130628	A309	Błąd Lini Niverplst - Easy Plast
5086	310	41	2026-10-06 08:17:37.130628	A310	Alarm Lini Niverplast - Transport System
5087	311	41	2026-10-06 08:17:37.130628	A311	Błąd Lini Niverplst - Transport System
5088	309	39	2026-10-06 08:18:37.277027	A309	Błąd Lini Niverplst - Easy Plast
5089	310	41	2026-10-06 08:18:37.277027	A310	Alarm Lini Niverplast - Transport System
5090	311	41	2026-10-06 08:18:37.277027	A311	Błąd Lini Niverplst - Transport System
5091	309	39	2026-10-06 08:19:37.341326	A309	Błąd Lini Niverplst - Easy Plast
5092	310	41	2026-10-06 08:19:37.341326	A310	Alarm Lini Niverplast - Transport System
5093	311	41	2026-10-06 08:19:37.341326	A311	Błąd Lini Niverplst - Transport System
5094	309	39	2026-10-06 08:20:37.45646	A309	Błąd Lini Niverplst - Easy Plast
5095	310	41	2026-10-06 08:20:37.45646	A310	Alarm Lini Niverplast - Transport System
5096	311	41	2026-10-06 08:20:37.45646	A311	Błąd Lini Niverplst - Transport System
5097	309	39	2026-10-06 08:21:37.546391	A309	Błąd Lini Niverplst - Easy Plast
5098	310	41	2026-10-06 08:21:37.546391	A310	Alarm Lini Niverplast - Transport System
5099	311	41	2026-10-06 08:21:37.546391	A311	Błąd Lini Niverplst - Transport System
5100	309	39	2026-10-06 08:22:37.669674	A309	Błąd Lini Niverplst - Easy Plast
5101	310	41	2026-10-06 08:22:37.669674	A310	Alarm Lini Niverplast - Transport System
5102	311	41	2026-10-06 08:22:37.669674	A311	Błąd Lini Niverplst - Transport System
5103	309	39	2026-10-06 08:23:37.7674	A309	Błąd Lini Niverplst - Easy Plast
5104	310	41	2026-10-06 08:23:37.7674	A310	Alarm Lini Niverplast - Transport System
5105	311	41	2026-10-06 08:23:37.7674	A311	Błąd Lini Niverplst - Transport System
5106	309	39	2026-10-06 08:24:37.869808	A309	Błąd Lini Niverplst - Easy Plast
5107	310	41	2026-10-06 08:24:37.869808	A310	Alarm Lini Niverplast - Transport System
5108	311	41	2026-10-06 08:24:37.869808	A311	Błąd Lini Niverplst - Transport System
5109	309	39	2026-10-06 08:25:37.081884	A309	Błąd Lini Niverplst - Easy Plast
5110	310	41	2026-10-06 08:25:37.081884	A310	Alarm Lini Niverplast - Transport System
5111	311	41	2026-10-06 08:25:37.081884	A311	Błąd Lini Niverplst - Transport System
5112	309	39	2026-10-06 08:26:37.199985	A309	Błąd Lini Niverplst - Easy Plast
5113	310	41	2026-10-06 08:26:37.199985	A310	Alarm Lini Niverplast - Transport System
5114	311	41	2026-10-06 08:26:37.199985	A311	Błąd Lini Niverplst - Transport System
5115	309	39	2026-10-06 08:27:37.290437	A309	Błąd Lini Niverplst - Easy Plast
5116	310	41	2026-10-06 08:27:37.290437	A310	Alarm Lini Niverplast - Transport System
5117	311	41	2026-10-06 08:27:37.290437	A311	Błąd Lini Niverplst - Transport System
5118	309	39	2026-10-06 08:28:37.403238	A309	Błąd Lini Niverplst - Easy Plast
5119	310	41	2026-10-06 08:28:37.403238	A310	Alarm Lini Niverplast - Transport System
5120	311	41	2026-10-06 08:28:37.403238	A311	Błąd Lini Niverplst - Transport System
5121	309	39	2026-10-06 08:29:37.501315	A309	Błąd Lini Niverplst - Easy Plast
5122	310	41	2026-10-06 08:29:37.501315	A310	Alarm Lini Niverplast - Transport System
5123	311	41	2026-10-06 08:29:37.501315	A311	Błąd Lini Niverplst - Transport System
5124	309	39	2026-10-06 08:30:37.628992	A309	Błąd Lini Niverplst - Easy Plast
5125	310	41	2026-10-06 08:30:37.628992	A310	Alarm Lini Niverplast - Transport System
5126	311	41	2026-10-06 08:30:37.628992	A311	Błąd Lini Niverplst - Transport System
5127	309	39	2026-10-06 08:31:37.727362	A309	Błąd Lini Niverplst - Easy Plast
5128	310	41	2026-10-06 08:31:37.727362	A310	Alarm Lini Niverplast - Transport System
5129	311	41	2026-10-06 08:31:37.727362	A311	Błąd Lini Niverplst - Transport System
5130	309	39	2026-10-06 08:32:37.846882	A309	Błąd Lini Niverplst - Easy Plast
5131	310	41	2026-10-06 08:32:37.846882	A310	Alarm Lini Niverplast - Transport System
5132	311	41	2026-10-06 08:32:37.846882	A311	Błąd Lini Niverplst - Transport System
5133	309	39	2026-10-06 08:33:37.946392	A309	Błąd Lini Niverplst - Easy Plast
5134	310	41	2026-10-06 08:33:37.946392	A310	Alarm Lini Niverplast - Transport System
5135	311	41	2026-10-06 08:33:37.946392	A311	Błąd Lini Niverplst - Transport System
5136	309	39	2026-10-06 08:34:38.064542	A309	Błąd Lini Niverplst - Easy Plast
5137	310	41	2026-10-06 08:34:38.064542	A310	Alarm Lini Niverplast - Transport System
5138	311	41	2026-10-06 08:34:38.064542	A311	Błąd Lini Niverplst - Transport System
5139	309	39	2026-10-06 08:35:38.176221	A309	Błąd Lini Niverplst - Easy Plast
5140	310	41	2026-10-06 08:35:38.176221	A310	Alarm Lini Niverplast - Transport System
5141	311	41	2026-10-06 08:35:38.176221	A311	Błąd Lini Niverplst - Transport System
5142	309	39	2026-10-06 08:36:38.293587	A309	Błąd Lini Niverplst - Easy Plast
5143	310	41	2026-10-06 08:36:38.293587	A310	Alarm Lini Niverplast - Transport System
5144	311	41	2026-10-06 08:36:38.293587	A311	Błąd Lini Niverplst - Transport System
5145	187	40	2026-10-06 08:37:38.374925	A187	Otwarta Bramka Bezpieczeństwa 
5146	129	40	2026-10-06 08:37:38.374925	A129	Niskie ciśnienie pneumatyczne - strefa 1
5147	309	39	2026-10-06 08:37:38.374925	A309	Błąd Lini Niverplst - Easy Plast
5148	310	41	2026-10-06 08:37:38.374925	A310	Alarm Lini Niverplast - Transport System
5149	311	41	2026-10-06 08:37:38.374925	A311	Błąd Lini Niverplst - Transport System
5150	188	40	2026-10-06 08:37:38.374925	A188	Nieryglowany zamek bramki bezpieszeństwa
5151	187	40	2026-10-06 08:38:38.504734	A187	Otwarta Bramka Bezpieczeństwa 
5152	129	40	2026-10-06 08:38:38.504734	A129	Niskie ciśnienie pneumatyczne - strefa 1
5153	309	39	2026-10-06 08:38:38.504734	A309	Błąd Lini Niverplst - Easy Plast
5154	310	41	2026-10-06 08:38:38.504734	A310	Alarm Lini Niverplast - Transport System
5155	311	41	2026-10-06 08:38:38.504734	A311	Błąd Lini Niverplst - Transport System
5156	188	40	2026-10-06 08:38:38.504734	A188	Nieryglowany zamek bramki bezpieszeństwa
5157	187	40	2026-10-06 08:39:38.589025	A187	Otwarta Bramka Bezpieczeństwa 
5158	129	40	2026-10-06 08:39:38.589025	A129	Niskie ciśnienie pneumatyczne - strefa 1
5159	309	39	2026-10-06 08:39:38.589025	A309	Błąd Lini Niverplst - Easy Plast
5160	310	41	2026-10-06 08:39:38.589025	A310	Alarm Lini Niverplast - Transport System
5161	311	41	2026-10-06 08:39:38.589025	A311	Błąd Lini Niverplst - Transport System
5162	188	40	2026-10-06 08:39:38.589025	A188	Nieryglowany zamek bramki bezpieszeństwa
5163	187	40	2026-10-06 08:40:38.722912	A187	Otwarta Bramka Bezpieczeństwa 
5164	129	40	2026-10-06 08:40:38.722912	A129	Niskie ciśnienie pneumatyczne - strefa 1
5165	309	39	2026-10-06 08:40:38.722912	A309	Błąd Lini Niverplst - Easy Plast
5166	310	41	2026-10-06 08:40:38.722912	A310	Alarm Lini Niverplast - Transport System
5167	311	41	2026-10-06 08:40:38.722912	A311	Błąd Lini Niverplst - Transport System
5168	188	40	2026-10-06 08:40:38.722912	A188	Nieryglowany zamek bramki bezpieszeństwa
5169	309	39	2026-10-06 08:41:38.807987	A309	Błąd Lini Niverplst - Easy Plast
5170	310	41	2026-10-06 08:41:38.807987	A310	Alarm Lini Niverplast - Transport System
5171	311	41	2026-10-06 08:41:38.807987	A311	Błąd Lini Niverplst - Transport System
5172	309	39	2026-10-06 08:42:38.920379	A309	Błąd Lini Niverplst - Easy Plast
5173	310	41	2026-10-06 08:42:38.920379	A310	Alarm Lini Niverplast - Transport System
5174	311	41	2026-10-06 08:42:38.920379	A311	Błąd Lini Niverplst - Transport System
5175	309	39	2026-10-06 08:43:38.132433	A309	Błąd Lini Niverplst - Easy Plast
5176	310	41	2026-10-06 08:43:38.132433	A310	Alarm Lini Niverplast - Transport System
5177	311	41	2026-10-06 08:43:38.132433	A311	Błąd Lini Niverplst - Transport System
5178	309	39	2026-10-06 08:44:38.238099	A309	Błąd Lini Niverplst - Easy Plast
5179	310	41	2026-10-06 08:44:38.238099	A310	Alarm Lini Niverplast - Transport System
5180	311	41	2026-10-06 08:44:38.238099	A311	Błąd Lini Niverplst - Transport System
5181	309	39	2026-10-06 08:45:38.34518	A309	Błąd Lini Niverplst - Easy Plast
5182	310	41	2026-10-06 08:45:38.34518	A310	Alarm Lini Niverplast - Transport System
5183	311	41	2026-10-06 08:45:38.34518	A311	Błąd Lini Niverplst - Transport System
5184	309	39	2026-10-06 08:46:38.448713	A309	Błąd Lini Niverplst - Easy Plast
5185	310	41	2026-10-06 08:46:38.448713	A310	Alarm Lini Niverplast - Transport System
5186	311	41	2026-10-06 08:46:38.448713	A311	Błąd Lini Niverplst - Transport System
5187	309	39	2026-10-06 08:47:38.548602	A309	Błąd Lini Niverplst - Easy Plast
5188	310	41	2026-10-06 08:47:38.548602	A310	Alarm Lini Niverplast - Transport System
5189	311	41	2026-10-06 08:47:38.548602	A311	Błąd Lini Niverplst - Transport System
5190	309	39	2026-10-06 08:48:38.682768	A309	Błąd Lini Niverplst - Easy Plast
5191	310	41	2026-10-06 08:48:38.682768	A310	Alarm Lini Niverplast - Transport System
5192	311	41	2026-10-06 08:48:38.682768	A311	Błąd Lini Niverplst - Transport System
5193	309	39	2026-10-06 08:49:38.804234	A309	Błąd Lini Niverplst - Easy Plast
5194	310	41	2026-10-06 08:49:38.804234	A310	Alarm Lini Niverplast - Transport System
5195	311	41	2026-10-06 08:49:38.804234	A311	Błąd Lini Niverplst - Transport System
5196	309	39	2026-10-06 08:50:38.90012	A309	Błąd Lini Niverplst - Easy Plast
5197	310	41	2026-10-06 08:50:38.90012	A310	Alarm Lini Niverplast - Transport System
5198	311	41	2026-10-06 08:50:38.90012	A311	Błąd Lini Niverplst - Transport System
5199	309	39	2026-10-06 08:51:39.010352	A309	Błąd Lini Niverplst - Easy Plast
5200	310	41	2026-10-06 08:51:39.010352	A310	Alarm Lini Niverplast - Transport System
5201	311	41	2026-10-06 08:51:39.010352	A311	Błąd Lini Niverplst - Transport System
5202	309	39	2026-10-06 08:52:39.113883	A309	Błąd Lini Niverplst - Easy Plast
5203	310	41	2026-10-06 08:52:39.113883	A310	Alarm Lini Niverplast - Transport System
5204	311	41	2026-10-06 08:52:39.113883	A311	Błąd Lini Niverplst - Transport System
5205	309	39	2026-10-06 08:53:39.226779	A309	Błąd Lini Niverplst - Easy Plast
5206	310	41	2026-10-06 08:53:39.226779	A310	Alarm Lini Niverplast - Transport System
5207	311	41	2026-10-06 08:53:39.226779	A311	Błąd Lini Niverplst - Transport System
5208	309	39	2026-10-06 08:54:39.336031	A309	Błąd Lini Niverplst - Easy Plast
5209	310	41	2026-10-06 08:54:39.336031	A310	Alarm Lini Niverplast - Transport System
5210	311	41	2026-10-06 08:54:39.336031	A311	Błąd Lini Niverplst - Transport System
5211	309	39	2026-10-06 08:55:39.461254	A309	Błąd Lini Niverplst - Easy Plast
5212	310	41	2026-10-06 08:55:39.461254	A310	Alarm Lini Niverplast - Transport System
5213	311	41	2026-10-06 08:55:39.461254	A311	Błąd Lini Niverplst - Transport System
5214	309	39	2026-10-06 08:56:42.670199	A309	Błąd Lini Niverplst - Easy Plast
5215	310	41	2026-10-06 08:56:42.670199	A310	Alarm Lini Niverplast - Transport System
5216	311	41	2026-10-06 08:56:42.670199	A311	Błąd Lini Niverplst - Transport System
5217	309	39	2026-10-06 08:57:40.043505	A309	Błąd Lini Niverplst - Easy Plast
5218	310	41	2026-10-06 08:57:40.043505	A310	Alarm Lini Niverplast - Transport System
5219	311	41	2026-10-06 08:57:40.043505	A311	Błąd Lini Niverplst - Transport System
5220	309	39	2026-10-06 08:58:39.947536	A309	Błąd Lini Niverplst - Easy Plast
5221	310	41	2026-10-06 08:58:39.947536	A310	Alarm Lini Niverplast - Transport System
5222	311	41	2026-10-06 08:58:39.947536	A311	Błąd Lini Niverplst - Transport System
5223	309	39	2026-10-06 08:59:39.922422	A309	Błąd Lini Niverplst - Easy Plast
5224	310	41	2026-10-06 08:59:39.922422	A310	Alarm Lini Niverplast - Transport System
5225	311	41	2026-10-06 08:59:39.922422	A311	Błąd Lini Niverplst - Transport System
5226	309	39	2026-10-06 09:00:39.167621	A309	Błąd Lini Niverplst - Easy Plast
5227	310	41	2026-10-06 09:00:39.167621	A310	Alarm Lini Niverplast - Transport System
5228	311	41	2026-10-06 09:00:39.167621	A311	Błąd Lini Niverplst - Transport System
5229	309	39	2026-10-06 09:01:39.228296	A309	Błąd Lini Niverplst - Easy Plast
5230	310	41	2026-10-06 09:01:39.228296	A310	Alarm Lini Niverplast - Transport System
5231	311	41	2026-10-06 09:01:39.228296	A311	Błąd Lini Niverplst - Transport System
5232	309	39	2026-10-06 09:02:39.188311	A309	Błąd Lini Niverplst - Easy Plast
5233	310	41	2026-10-06 09:02:39.188311	A310	Alarm Lini Niverplast - Transport System
5234	311	41	2026-10-06 09:02:39.188311	A311	Błąd Lini Niverplst - Transport System
5235	309	39	2026-10-06 09:03:39.432957	A309	Błąd Lini Niverplst - Easy Plast
5236	310	41	2026-10-06 09:03:39.432957	A310	Alarm Lini Niverplast - Transport System
5237	311	41	2026-10-06 09:03:39.432957	A311	Błąd Lini Niverplst - Transport System
5238	309	39	2026-10-06 09:04:39.486319	A309	Błąd Lini Niverplst - Easy Plast
5239	310	41	2026-10-06 09:04:39.486319	A310	Alarm Lini Niverplast - Transport System
5240	311	41	2026-10-06 09:04:39.486319	A311	Błąd Lini Niverplst - Transport System
5241	309	39	2026-10-06 09:05:39.659562	A309	Błąd Lini Niverplst - Easy Plast
5242	310	41	2026-10-06 09:05:39.659562	A310	Alarm Lini Niverplast - Transport System
5243	311	41	2026-10-06 09:05:39.659562	A311	Błąd Lini Niverplst - Transport System
5244	309	39	2026-10-06 09:06:39.7533	A309	Błąd Lini Niverplst - Easy Plast
5245	310	41	2026-10-06 09:06:39.7533	A310	Alarm Lini Niverplast - Transport System
5246	311	41	2026-10-06 09:06:39.7533	A311	Błąd Lini Niverplst - Transport System
5247	309	39	2026-10-06 09:07:39.883877	A309	Błąd Lini Niverplst - Easy Plast
5248	310	41	2026-10-06 09:07:39.883877	A310	Alarm Lini Niverplast - Transport System
5249	311	41	2026-10-06 09:07:39.883877	A311	Błąd Lini Niverplst - Transport System
5250	309	39	2026-10-06 09:08:40.007562	A309	Błąd Lini Niverplst - Easy Plast
5251	310	41	2026-10-06 09:08:40.007562	A310	Alarm Lini Niverplast - Transport System
5252	311	41	2026-10-06 09:08:40.007562	A311	Błąd Lini Niverplst - Transport System
5253	309	39	2026-10-06 09:09:40.087546	A309	Błąd Lini Niverplst - Easy Plast
5254	310	41	2026-10-06 09:09:40.087546	A310	Alarm Lini Niverplast - Transport System
5255	311	41	2026-10-06 09:09:40.087546	A311	Błąd Lini Niverplst - Transport System
5256	309	39	2026-10-06 09:10:40.210321	A309	Błąd Lini Niverplst - Easy Plast
5257	310	41	2026-10-06 09:10:40.210321	A310	Alarm Lini Niverplast - Transport System
5258	311	41	2026-10-06 09:10:40.210321	A311	Błąd Lini Niverplst - Transport System
5259	309	39	2026-10-06 09:11:40.342587	A309	Błąd Lini Niverplst - Easy Plast
5260	310	41	2026-10-06 09:11:40.342587	A310	Alarm Lini Niverplast - Transport System
5261	311	41	2026-10-06 09:11:40.342587	A311	Błąd Lini Niverplst - Transport System
5262	309	39	2026-10-06 09:12:40.428571	A309	Błąd Lini Niverplst - Easy Plast
5263	310	41	2026-10-06 09:12:40.428571	A310	Alarm Lini Niverplast - Transport System
5264	311	41	2026-10-06 09:12:40.428571	A311	Błąd Lini Niverplst - Transport System
5265	309	39	2026-10-06 09:13:40.547468	A309	Błąd Lini Niverplst - Easy Plast
5266	310	41	2026-10-06 09:13:40.547468	A310	Alarm Lini Niverplast - Transport System
5267	311	41	2026-10-06 09:13:40.547468	A311	Błąd Lini Niverplst - Transport System
5268	309	39	2026-10-06 09:14:40.646684	A309	Błąd Lini Niverplst - Easy Plast
5269	310	41	2026-10-06 09:14:40.646684	A310	Alarm Lini Niverplast - Transport System
5270	311	41	2026-10-06 09:14:40.646684	A311	Błąd Lini Niverplst - Transport System
5271	309	39	2026-10-06 09:15:40.771611	A309	Błąd Lini Niverplst - Easy Plast
5272	310	41	2026-10-06 09:15:40.771611	A310	Alarm Lini Niverplast - Transport System
5273	311	41	2026-10-06 09:15:40.771611	A311	Błąd Lini Niverplst - Transport System
5274	309	39	2026-10-06 09:16:40.881717	A309	Błąd Lini Niverplst - Easy Plast
5275	310	41	2026-10-06 09:16:40.881717	A310	Alarm Lini Niverplast - Transport System
5276	311	41	2026-10-06 09:16:40.881717	A311	Błąd Lini Niverplst - Transport System
5277	309	39	2026-10-06 09:17:41.00863	A309	Błąd Lini Niverplst - Easy Plast
5278	310	41	2026-10-06 09:17:41.00863	A310	Alarm Lini Niverplast - Transport System
5279	311	41	2026-10-06 09:17:41.00863	A311	Błąd Lini Niverplst - Transport System
5280	309	39	2026-10-06 09:18:40.184814	A309	Błąd Lini Niverplst - Easy Plast
5281	310	41	2026-10-06 09:18:40.184814	A310	Alarm Lini Niverplast - Transport System
5282	311	41	2026-10-06 09:18:40.184814	A311	Błąd Lini Niverplst - Transport System
5283	309	39	2026-10-06 09:19:40.287854	A309	Błąd Lini Niverplst - Easy Plast
5284	310	41	2026-10-06 09:19:40.287854	A310	Alarm Lini Niverplast - Transport System
5285	311	41	2026-10-06 09:19:40.287854	A311	Błąd Lini Niverplst - Transport System
5286	309	39	2026-10-06 09:20:40.402678	A309	Błąd Lini Niverplst - Easy Plast
5287	310	41	2026-10-06 09:20:40.402678	A310	Alarm Lini Niverplast - Transport System
5288	311	41	2026-10-06 09:20:40.402678	A311	Błąd Lini Niverplst - Transport System
5289	309	39	2026-10-06 09:21:40.521821	A309	Błąd Lini Niverplst - Easy Plast
5290	310	41	2026-10-06 09:21:40.521821	A310	Alarm Lini Niverplast - Transport System
5291	311	41	2026-10-06 09:21:40.521821	A311	Błąd Lini Niverplst - Transport System
5292	309	39	2026-10-06 09:22:40.642267	A309	Błąd Lini Niverplst - Easy Plast
5293	310	41	2026-10-06 09:22:40.642267	A310	Alarm Lini Niverplast - Transport System
5294	311	41	2026-10-06 09:22:40.642267	A311	Błąd Lini Niverplst - Transport System
5295	309	39	2026-10-06 09:23:40.739183	A309	Błąd Lini Niverplst - Easy Plast
5296	310	41	2026-10-06 09:23:40.739183	A310	Alarm Lini Niverplast - Transport System
5297	311	41	2026-10-06 09:23:40.739183	A311	Błąd Lini Niverplst - Transport System
5298	309	39	2026-10-06 09:24:40.810836	A309	Błąd Lini Niverplst - Easy Plast
5299	310	41	2026-10-06 09:24:40.810836	A310	Alarm Lini Niverplast - Transport System
5300	311	41	2026-10-06 09:24:40.810836	A311	Błąd Lini Niverplst - Transport System
5301	309	39	2026-10-06 09:25:40.988302	A309	Błąd Lini Niverplst - Easy Plast
5302	310	41	2026-10-06 09:25:40.988302	A310	Alarm Lini Niverplast - Transport System
5303	311	41	2026-10-06 09:25:40.988302	A311	Błąd Lini Niverplst - Transport System
5304	309	39	2026-10-06 09:26:41.087234	A309	Błąd Lini Niverplst - Easy Plast
5305	310	41	2026-10-06 09:26:41.087234	A310	Alarm Lini Niverplast - Transport System
5306	311	41	2026-10-06 09:26:41.087234	A311	Błąd Lini Niverplst - Transport System
5307	309	39	2026-10-06 09:27:41.188842	A309	Błąd Lini Niverplst - Easy Plast
5308	310	41	2026-10-06 09:27:41.188842	A310	Alarm Lini Niverplast - Transport System
5309	311	41	2026-10-06 09:27:41.188842	A311	Błąd Lini Niverplst - Transport System
5310	309	39	2026-10-06 09:28:41.299858	A309	Błąd Lini Niverplst - Easy Plast
5311	310	41	2026-10-06 09:28:41.299858	A310	Alarm Lini Niverplast - Transport System
5312	311	41	2026-10-06 09:28:41.299858	A311	Błąd Lini Niverplst - Transport System
5313	309	39	2026-10-06 09:29:41.72005	A309	Błąd Lini Niverplst - Easy Plast
5314	310	41	2026-10-06 09:29:41.72005	A310	Alarm Lini Niverplast - Transport System
5315	311	41	2026-10-06 09:29:41.72005	A311	Błąd Lini Niverplst - Transport System
5316	309	39	2026-10-06 09:30:41.548218	A309	Błąd Lini Niverplst - Easy Plast
5317	310	41	2026-10-06 09:30:41.548218	A310	Alarm Lini Niverplast - Transport System
5318	311	41	2026-10-06 09:30:41.548218	A311	Błąd Lini Niverplst - Transport System
5319	309	39	2026-10-06 09:31:41.665933	A309	Błąd Lini Niverplst - Easy Plast
5320	310	41	2026-10-06 09:31:41.665933	A310	Alarm Lini Niverplast - Transport System
5321	311	41	2026-10-06 09:31:41.665933	A311	Błąd Lini Niverplst - Transport System
5322	309	39	2026-10-06 09:32:41.75078	A309	Błąd Lini Niverplst - Easy Plast
5323	310	41	2026-10-06 09:32:41.75078	A310	Alarm Lini Niverplast - Transport System
5324	311	41	2026-10-06 09:32:41.75078	A311	Błąd Lini Niverplst - Transport System
5325	309	39	2026-10-06 09:33:41.876592	A309	Błąd Lini Niverplst - Easy Plast
5326	310	41	2026-10-06 09:33:41.876592	A310	Alarm Lini Niverplast - Transport System
5327	311	41	2026-10-06 09:33:41.876592	A311	Błąd Lini Niverplst - Transport System
5328	309	39	2026-10-06 09:34:41.474204	A309	Błąd Lini Niverplst - Easy Plast
5329	310	41	2026-10-06 09:34:41.474204	A310	Alarm Lini Niverplast - Transport System
5330	311	41	2026-10-06 09:34:41.474204	A311	Błąd Lini Niverplst - Transport System
5331	309	39	2026-10-06 09:35:41.138331	A309	Błąd Lini Niverplst - Easy Plast
5332	310	41	2026-10-06 09:35:41.138331	A310	Alarm Lini Niverplast - Transport System
5333	311	41	2026-10-06 09:35:41.138331	A311	Błąd Lini Niverplst - Transport System
5334	309	39	2026-10-06 09:36:41.288451	A309	Błąd Lini Niverplst - Easy Plast
5335	310	41	2026-10-06 09:36:41.288451	A310	Alarm Lini Niverplast - Transport System
5336	311	41	2026-10-06 09:36:41.288451	A311	Błąd Lini Niverplst - Transport System
5337	309	39	2026-10-06 09:37:41.370583	A309	Błąd Lini Niverplst - Easy Plast
5338	310	41	2026-10-06 09:37:41.370583	A310	Alarm Lini Niverplast - Transport System
5339	311	41	2026-10-06 09:37:41.370583	A311	Błąd Lini Niverplst - Transport System
5340	309	39	2026-10-06 09:38:41.506645	A309	Błąd Lini Niverplst - Easy Plast
5341	310	41	2026-10-06 09:38:41.506645	A310	Alarm Lini Niverplast - Transport System
5342	311	41	2026-10-06 09:38:41.506645	A311	Błąd Lini Niverplst - Transport System
5343	309	39	2026-10-06 09:39:41.611613	A309	Błąd Lini Niverplst - Easy Plast
5344	310	41	2026-10-06 09:39:41.611613	A310	Alarm Lini Niverplast - Transport System
5345	311	41	2026-10-06 09:39:41.611613	A311	Błąd Lini Niverplst - Transport System
5346	309	39	2026-10-06 09:40:41.724016	A309	Błąd Lini Niverplst - Easy Plast
5347	310	41	2026-10-06 09:40:41.724016	A310	Alarm Lini Niverplast - Transport System
5348	311	41	2026-10-06 09:40:41.724016	A311	Błąd Lini Niverplst - Transport System
5349	309	39	2026-10-06 09:41:41.845087	A309	Błąd Lini Niverplst - Easy Plast
5350	310	41	2026-10-06 09:41:41.845087	A310	Alarm Lini Niverplast - Transport System
5351	311	41	2026-10-06 09:41:41.845087	A311	Błąd Lini Niverplst - Transport System
5352	309	39	2026-10-06 09:42:41.950413	A309	Błąd Lini Niverplst - Easy Plast
5353	310	41	2026-10-06 09:42:41.950413	A310	Alarm Lini Niverplast - Transport System
5354	311	41	2026-10-06 09:42:41.950413	A311	Błąd Lini Niverplst - Transport System
5355	309	39	2026-10-06 09:43:42.070866	A309	Błąd Lini Niverplst - Easy Plast
5356	310	41	2026-10-06 09:43:42.070866	A310	Alarm Lini Niverplast - Transport System
5357	311	41	2026-10-06 09:43:42.070866	A311	Błąd Lini Niverplst - Transport System
5358	309	39	2026-10-06 09:44:42.19657	A309	Błąd Lini Niverplst - Easy Plast
5359	310	41	2026-10-06 09:44:42.19657	A310	Alarm Lini Niverplast - Transport System
5360	311	41	2026-10-06 09:44:42.19657	A311	Błąd Lini Niverplst - Transport System
5361	309	39	2026-10-06 09:45:42.302105	A309	Błąd Lini Niverplst - Easy Plast
5362	310	41	2026-10-06 09:45:42.302105	A310	Alarm Lini Niverplast - Transport System
5363	311	41	2026-10-06 09:45:42.302105	A311	Błąd Lini Niverplst - Transport System
5364	309	39	2026-10-06 09:46:42.427866	A309	Błąd Lini Niverplst - Easy Plast
5365	310	41	2026-10-06 09:46:42.427866	A310	Alarm Lini Niverplast - Transport System
5366	311	41	2026-10-06 09:46:42.427866	A311	Błąd Lini Niverplst - Transport System
5367	309	39	2026-10-06 09:47:42.548599	A309	Błąd Lini Niverplst - Easy Plast
5368	310	41	2026-10-06 09:47:42.548599	A310	Alarm Lini Niverplast - Transport System
5369	311	41	2026-10-06 09:47:42.548599	A311	Błąd Lini Niverplst - Transport System
5370	309	39	2026-10-06 09:48:42.660217	A309	Błąd Lini Niverplst - Easy Plast
5371	310	41	2026-10-06 09:48:42.660217	A310	Alarm Lini Niverplast - Transport System
5372	311	41	2026-10-06 09:48:42.660217	A311	Błąd Lini Niverplst - Transport System
5373	309	39	2026-10-06 09:49:42.762705	A309	Błąd Lini Niverplst - Easy Plast
5374	310	41	2026-10-06 09:49:42.762705	A310	Alarm Lini Niverplast - Transport System
5375	311	41	2026-10-06 09:49:42.762705	A311	Błąd Lini Niverplst - Transport System
5376	309	39	2026-10-06 09:50:42.894169	A309	Błąd Lini Niverplst - Easy Plast
5377	310	41	2026-10-06 09:50:42.894169	A310	Alarm Lini Niverplast - Transport System
5378	311	41	2026-10-06 09:50:42.894169	A311	Błąd Lini Niverplst - Transport System
5379	309	39	2026-10-06 09:51:42.040923	A309	Błąd Lini Niverplst - Easy Plast
5380	310	41	2026-10-06 09:51:42.040923	A310	Alarm Lini Niverplast - Transport System
5381	311	41	2026-10-06 09:51:42.040923	A311	Błąd Lini Niverplst - Transport System
5382	309	39	2026-10-06 09:52:42.110174	A309	Błąd Lini Niverplst - Easy Plast
5383	310	41	2026-10-06 09:52:42.110174	A310	Alarm Lini Niverplast - Transport System
5384	311	41	2026-10-06 09:52:42.110174	A311	Błąd Lini Niverplst - Transport System
5385	309	39	2026-10-06 09:53:42.291855	A309	Błąd Lini Niverplst - Easy Plast
5386	310	41	2026-10-06 09:53:42.291855	A310	Alarm Lini Niverplast - Transport System
5387	311	41	2026-10-06 09:53:42.291855	A311	Błąd Lini Niverplst - Transport System
5388	309	39	2026-10-06 09:54:42.362728	A309	Błąd Lini Niverplst - Easy Plast
5389	310	41	2026-10-06 09:54:42.362728	A310	Alarm Lini Niverplast - Transport System
5390	311	41	2026-10-06 09:54:42.362728	A311	Błąd Lini Niverplst - Transport System
5391	309	39	2026-10-06 09:55:42.529263	A309	Błąd Lini Niverplst - Easy Plast
5392	310	41	2026-10-06 09:55:42.529263	A310	Alarm Lini Niverplast - Transport System
5393	311	41	2026-10-06 09:55:42.529263	A311	Błąd Lini Niverplst - Transport System
5394	309	39	2026-10-06 09:56:42.612278	A309	Błąd Lini Niverplst - Easy Plast
5395	310	41	2026-10-06 09:56:42.612278	A310	Alarm Lini Niverplast - Transport System
5396	311	41	2026-10-06 09:56:42.612278	A311	Błąd Lini Niverplst - Transport System
5397	309	39	2026-10-06 09:57:42.74329	A309	Błąd Lini Niverplst - Easy Plast
5398	310	41	2026-10-06 09:57:42.74329	A310	Alarm Lini Niverplast - Transport System
5399	311	41	2026-10-06 09:57:42.74329	A311	Błąd Lini Niverplst - Transport System
5400	309	39	2026-10-06 09:58:42.856992	A309	Błąd Lini Niverplst - Easy Plast
5401	310	41	2026-10-06 09:58:42.856992	A310	Alarm Lini Niverplast - Transport System
5402	311	41	2026-10-06 09:58:42.856992	A311	Błąd Lini Niverplst - Transport System
5403	309	39	2026-10-06 09:59:42.996874	A309	Błąd Lini Niverplst - Easy Plast
5404	310	41	2026-10-06 09:59:42.996874	A310	Alarm Lini Niverplast - Transport System
5405	311	41	2026-10-06 09:59:42.996874	A311	Błąd Lini Niverplst - Transport System
5406	309	39	2026-10-06 10:00:43.096438	A309	Błąd Lini Niverplst - Easy Plast
5407	310	41	2026-10-06 10:00:43.096438	A310	Alarm Lini Niverplast - Transport System
5408	311	41	2026-10-06 10:00:43.096438	A311	Błąd Lini Niverplst - Transport System
5409	309	39	2026-10-06 10:01:43.223378	A309	Błąd Lini Niverplst - Easy Plast
5410	310	41	2026-10-06 10:01:43.223378	A310	Alarm Lini Niverplast - Transport System
5411	311	41	2026-10-06 10:01:43.223378	A311	Błąd Lini Niverplst - Transport System
5412	309	39	2026-10-06 10:02:43.333987	A309	Błąd Lini Niverplst - Easy Plast
5413	310	41	2026-10-06 10:02:43.333987	A310	Alarm Lini Niverplast - Transport System
5414	311	41	2026-10-06 10:02:43.333987	A311	Błąd Lini Niverplst - Transport System
5415	309	39	2026-10-06 10:03:43.456964	A309	Błąd Lini Niverplst - Easy Plast
5416	310	41	2026-10-06 10:03:43.456964	A310	Alarm Lini Niverplast - Transport System
5417	311	41	2026-10-06 10:03:43.456964	A311	Błąd Lini Niverplst - Transport System
5418	309	39	2026-10-06 10:04:43.596347	A309	Błąd Lini Niverplst - Easy Plast
5419	310	41	2026-10-06 10:04:43.596347	A310	Alarm Lini Niverplast - Transport System
5420	311	41	2026-10-06 10:04:43.596347	A311	Błąd Lini Niverplst - Transport System
5421	309	39	2026-10-06 10:05:43.708757	A309	Błąd Lini Niverplst - Easy Plast
5422	310	41	2026-10-06 10:05:43.708757	A310	Alarm Lini Niverplast - Transport System
5423	311	41	2026-10-06 10:05:43.708757	A311	Błąd Lini Niverplst - Transport System
5424	309	39	2026-10-06 10:06:43.826652	A309	Błąd Lini Niverplst - Easy Plast
5425	310	41	2026-10-06 10:06:43.826652	A310	Alarm Lini Niverplast - Transport System
5426	311	41	2026-10-06 10:06:43.826652	A311	Błąd Lini Niverplst - Transport System
5427	309	39	2026-10-06 10:07:42.96011	A309	Błąd Lini Niverplst - Easy Plast
5428	310	41	2026-10-06 10:07:42.96011	A310	Alarm Lini Niverplast - Transport System
5429	311	41	2026-10-06 10:07:42.96011	A311	Błąd Lini Niverplst - Transport System
5430	309	39	2026-10-06 10:08:43.073669	A309	Błąd Lini Niverplst - Easy Plast
5431	310	41	2026-10-06 10:08:43.073669	A310	Alarm Lini Niverplast - Transport System
5432	311	41	2026-10-06 10:08:43.073669	A311	Błąd Lini Niverplst - Transport System
5433	309	39	2026-10-06 10:09:43.190221	A309	Błąd Lini Niverplst - Easy Plast
5434	310	41	2026-10-06 10:09:43.190221	A310	Alarm Lini Niverplast - Transport System
5435	311	41	2026-10-06 10:09:43.190221	A311	Błąd Lini Niverplst - Transport System
5436	309	39	2026-10-06 10:10:43.316955	A309	Błąd Lini Niverplst - Easy Plast
5437	310	41	2026-10-06 10:10:43.316955	A310	Alarm Lini Niverplast - Transport System
5438	311	41	2026-10-06 10:10:43.316955	A311	Błąd Lini Niverplst - Transport System
5439	309	39	2026-10-06 10:11:43.420934	A309	Błąd Lini Niverplst - Easy Plast
5440	310	41	2026-10-06 10:11:43.420934	A310	Alarm Lini Niverplast - Transport System
5441	311	41	2026-10-06 10:11:43.420934	A311	Błąd Lini Niverplst - Transport System
5442	309	39	2026-10-06 10:12:43.561137	A309	Błąd Lini Niverplst - Easy Plast
5443	310	41	2026-10-06 10:12:43.561137	A310	Alarm Lini Niverplast - Transport System
5444	311	41	2026-10-06 10:12:43.561137	A311	Błąd Lini Niverplst - Transport System
5445	309	39	2026-10-06 10:13:43.681101	A309	Błąd Lini Niverplst - Easy Plast
5446	310	41	2026-10-06 10:13:43.681101	A310	Alarm Lini Niverplast - Transport System
5447	311	41	2026-10-06 10:13:43.681101	A311	Błąd Lini Niverplst - Transport System
5448	309	39	2026-10-06 10:14:43.822733	A309	Błąd Lini Niverplst - Easy Plast
5449	310	41	2026-10-06 10:14:43.822733	A310	Alarm Lini Niverplast - Transport System
5450	311	41	2026-10-06 10:14:43.822733	A311	Błąd Lini Niverplst - Transport System
5451	309	39	2026-10-06 10:15:43.910873	A309	Błąd Lini Niverplst - Easy Plast
5452	310	41	2026-10-06 10:15:43.910873	A310	Alarm Lini Niverplast - Transport System
5453	311	41	2026-10-06 10:15:43.910873	A311	Błąd Lini Niverplst - Transport System
5454	309	39	2026-10-06 10:16:44.034189	A309	Błąd Lini Niverplst - Easy Plast
5455	310	41	2026-10-06 10:16:44.034189	A310	Alarm Lini Niverplast - Transport System
5456	311	41	2026-10-06 10:16:44.034189	A311	Błąd Lini Niverplst - Transport System
5457	309	39	2026-10-06 10:17:44.167357	A309	Błąd Lini Niverplst - Easy Plast
5458	310	41	2026-10-06 10:17:44.167357	A310	Alarm Lini Niverplast - Transport System
5459	311	41	2026-10-06 10:17:44.167357	A311	Błąd Lini Niverplst - Transport System
5460	309	39	2026-10-06 10:18:44.268041	A309	Błąd Lini Niverplst - Easy Plast
5461	310	41	2026-10-06 10:18:44.268041	A310	Alarm Lini Niverplast - Transport System
5462	311	41	2026-10-06 10:18:44.268041	A311	Błąd Lini Niverplst - Transport System
5463	309	39	2026-10-06 10:19:44.416234	A309	Błąd Lini Niverplst - Easy Plast
5464	310	41	2026-10-06 10:19:44.416234	A310	Alarm Lini Niverplast - Transport System
5465	311	41	2026-10-06 10:19:44.416234	A311	Błąd Lini Niverplst - Transport System
5466	309	39	2026-10-06 10:20:44.511656	A309	Błąd Lini Niverplst - Easy Plast
5467	310	41	2026-10-06 10:20:44.511656	A310	Alarm Lini Niverplast - Transport System
5468	311	41	2026-10-06 10:20:44.511656	A311	Błąd Lini Niverplst - Transport System
5469	309	39	2026-10-06 10:21:44.63253	A309	Błąd Lini Niverplst - Easy Plast
5470	310	41	2026-10-06 10:21:44.63253	A310	Alarm Lini Niverplast - Transport System
5471	311	41	2026-10-06 10:21:44.63253	A311	Błąd Lini Niverplst - Transport System
5472	309	39	2026-10-06 10:22:44.772592	A309	Błąd Lini Niverplst - Easy Plast
5473	310	41	2026-10-06 10:22:44.772592	A310	Alarm Lini Niverplast - Transport System
5474	311	41	2026-10-06 10:22:44.772592	A311	Błąd Lini Niverplst - Transport System
5475	309	39	2026-10-06 10:23:43.856707	A309	Błąd Lini Niverplst - Easy Plast
5476	310	41	2026-10-06 10:23:43.856707	A310	Alarm Lini Niverplast - Transport System
5477	311	41	2026-10-06 10:23:43.856707	A311	Błąd Lini Niverplst - Transport System
5478	309	39	2026-10-06 10:24:43.989538	A309	Błąd Lini Niverplst - Easy Plast
5479	310	41	2026-10-06 10:24:43.989538	A310	Alarm Lini Niverplast - Transport System
5480	311	41	2026-10-06 10:24:43.989538	A311	Błąd Lini Niverplst - Transport System
5481	309	39	2026-10-06 10:25:44.09529	A309	Błąd Lini Niverplst - Easy Plast
5482	310	41	2026-10-06 10:25:44.09529	A310	Alarm Lini Niverplast - Transport System
5483	311	41	2026-10-06 10:25:44.09529	A311	Błąd Lini Niverplst - Transport System
5484	309	39	2026-10-06 10:26:44.260351	A309	Błąd Lini Niverplst - Easy Plast
5485	310	41	2026-10-06 10:26:44.260351	A310	Alarm Lini Niverplast - Transport System
5486	311	41	2026-10-06 10:26:44.260351	A311	Błąd Lini Niverplst - Transport System
5487	309	39	2026-10-06 10:27:44.373622	A309	Błąd Lini Niverplst - Easy Plast
5488	310	41	2026-10-06 10:27:44.373622	A310	Alarm Lini Niverplast - Transport System
5489	311	41	2026-10-06 10:27:44.373622	A311	Błąd Lini Niverplst - Transport System
5490	309	39	2026-10-06 10:28:44.494606	A309	Błąd Lini Niverplst - Easy Plast
5491	310	41	2026-10-06 10:28:44.494606	A310	Alarm Lini Niverplast - Transport System
5492	311	41	2026-10-06 10:28:44.494606	A311	Błąd Lini Niverplst - Transport System
5493	309	39	2026-10-06 10:29:44.611826	A309	Błąd Lini Niverplst - Easy Plast
5494	310	41	2026-10-06 10:29:44.611826	A310	Alarm Lini Niverplast - Transport System
5495	311	41	2026-10-06 10:29:44.611826	A311	Błąd Lini Niverplst - Transport System
5496	309	39	2026-10-06 10:30:44.730474	A309	Błąd Lini Niverplst - Easy Plast
5497	310	41	2026-10-06 10:30:44.730474	A310	Alarm Lini Niverplast - Transport System
5498	311	41	2026-10-06 10:30:44.730474	A311	Błąd Lini Niverplst - Transport System
5499	309	39	2026-10-06 10:31:44.857361	A309	Błąd Lini Niverplst - Easy Plast
5500	310	41	2026-10-06 10:31:44.857361	A310	Alarm Lini Niverplast - Transport System
5501	311	41	2026-10-06 10:31:44.857361	A311	Błąd Lini Niverplst - Transport System
5502	309	39	2026-10-06 10:32:44.981702	A309	Błąd Lini Niverplst - Easy Plast
5503	310	41	2026-10-06 10:32:44.981702	A310	Alarm Lini Niverplast - Transport System
5504	311	41	2026-10-06 10:32:44.981702	A311	Błąd Lini Niverplst - Transport System
5505	309	39	2026-10-06 10:33:45.090905	A309	Błąd Lini Niverplst - Easy Plast
5506	310	41	2026-10-06 10:33:45.090905	A310	Alarm Lini Niverplast - Transport System
5507	311	41	2026-10-06 10:33:45.090905	A311	Błąd Lini Niverplst - Transport System
5508	309	39	2026-10-06 10:34:45.23477	A309	Błąd Lini Niverplst - Easy Plast
5509	310	41	2026-10-06 10:34:45.23477	A310	Alarm Lini Niverplast - Transport System
5510	311	41	2026-10-06 10:34:45.23477	A311	Błąd Lini Niverplst - Transport System
5511	309	39	2026-10-06 10:35:45.340871	A309	Błąd Lini Niverplst - Easy Plast
5512	310	41	2026-10-06 10:35:45.340871	A310	Alarm Lini Niverplast - Transport System
5513	311	41	2026-10-06 10:35:45.340871	A311	Błąd Lini Niverplst - Transport System
5514	309	39	2026-10-06 10:36:45.466677	A309	Błąd Lini Niverplst - Easy Plast
5515	310	41	2026-10-06 10:36:45.466677	A310	Alarm Lini Niverplast - Transport System
5516	311	41	2026-10-06 10:36:45.466677	A311	Błąd Lini Niverplst - Transport System
5517	309	39	2026-10-06 10:37:45.574835	A309	Błąd Lini Niverplst - Easy Plast
5518	310	41	2026-10-06 10:37:45.574835	A310	Alarm Lini Niverplast - Transport System
5519	311	41	2026-10-06 10:37:45.574835	A311	Błąd Lini Niverplst - Transport System
5520	309	39	2026-10-06 10:38:45.701495	A309	Błąd Lini Niverplst - Easy Plast
5521	310	41	2026-10-06 10:38:45.701495	A310	Alarm Lini Niverplast - Transport System
5522	311	41	2026-10-06 10:38:45.701495	A311	Błąd Lini Niverplst - Transport System
5523	309	39	2026-10-06 10:39:44.825711	A309	Błąd Lini Niverplst - Easy Plast
5524	310	41	2026-10-06 10:39:44.825711	A310	Alarm Lini Niverplast - Transport System
5525	311	41	2026-10-06 10:39:44.825711	A311	Błąd Lini Niverplst - Transport System
5526	309	39	2026-10-06 10:40:44.944822	A309	Błąd Lini Niverplst - Easy Plast
5527	310	41	2026-10-06 10:40:44.944822	A310	Alarm Lini Niverplast - Transport System
5528	311	41	2026-10-06 10:40:44.944822	A311	Błąd Lini Niverplst - Transport System
5529	309	39	2026-10-06 10:41:45.032176	A309	Błąd Lini Niverplst - Easy Plast
5530	310	41	2026-10-06 10:41:45.032176	A310	Alarm Lini Niverplast - Transport System
5531	311	41	2026-10-06 10:41:45.032176	A311	Błąd Lini Niverplst - Transport System
5532	309	39	2026-10-06 10:42:45.175905	A309	Błąd Lini Niverplst - Easy Plast
5533	310	41	2026-10-06 10:42:45.175905	A310	Alarm Lini Niverplast - Transport System
5534	311	41	2026-10-06 10:42:45.175905	A311	Błąd Lini Niverplst - Transport System
5535	309	39	2026-10-06 10:43:45.287799	A309	Błąd Lini Niverplst - Easy Plast
5536	310	41	2026-10-06 10:43:45.287799	A310	Alarm Lini Niverplast - Transport System
5537	311	41	2026-10-06 10:43:45.287799	A311	Błąd Lini Niverplst - Transport System
5538	309	39	2026-10-06 10:44:45.417696	A309	Błąd Lini Niverplst - Easy Plast
5539	310	41	2026-10-06 10:44:45.417696	A310	Alarm Lini Niverplast - Transport System
5540	311	41	2026-10-06 10:44:45.417696	A311	Błąd Lini Niverplst - Transport System
5541	309	39	2026-10-06 10:45:45.547145	A309	Błąd Lini Niverplst - Easy Plast
5542	310	41	2026-10-06 10:45:45.547145	A310	Alarm Lini Niverplast - Transport System
5543	311	41	2026-10-06 10:45:45.547145	A311	Błąd Lini Niverplst - Transport System
5544	309	39	2026-10-06 10:46:45.685471	A309	Błąd Lini Niverplst - Easy Plast
5545	310	41	2026-10-06 10:46:45.685471	A310	Alarm Lini Niverplast - Transport System
5546	311	41	2026-10-06 10:46:45.685471	A311	Błąd Lini Niverplst - Transport System
5547	309	39	2026-10-06 10:47:45.805547	A309	Błąd Lini Niverplst - Easy Plast
5548	310	41	2026-10-06 10:47:45.805547	A310	Alarm Lini Niverplast - Transport System
5549	311	41	2026-10-06 10:47:45.805547	A311	Błąd Lini Niverplst - Transport System
5550	309	39	2026-10-06 10:48:45.911775	A309	Błąd Lini Niverplst - Easy Plast
5551	310	41	2026-10-06 10:48:45.911775	A310	Alarm Lini Niverplast - Transport System
5552	311	41	2026-10-06 10:48:45.911775	A311	Błąd Lini Niverplst - Transport System
5553	309	39	2026-10-06 10:49:46.063158	A309	Błąd Lini Niverplst - Easy Plast
5554	310	41	2026-10-06 10:49:46.063158	A310	Alarm Lini Niverplast - Transport System
5555	311	41	2026-10-06 10:49:46.063158	A311	Błąd Lini Niverplst - Transport System
5556	309	39	2026-10-06 10:50:46.159592	A309	Błąd Lini Niverplst - Easy Plast
5557	310	41	2026-10-06 10:50:46.159592	A310	Alarm Lini Niverplast - Transport System
5558	311	41	2026-10-06 10:50:46.159592	A311	Błąd Lini Niverplst - Transport System
5559	309	39	2026-10-06 10:51:46.301745	A309	Błąd Lini Niverplst - Easy Plast
5560	310	41	2026-10-06 10:51:46.301745	A310	Alarm Lini Niverplast - Transport System
5561	311	41	2026-10-06 10:51:46.301745	A311	Błąd Lini Niverplst - Transport System
5562	309	39	2026-10-06 10:52:46.415893	A309	Błąd Lini Niverplst - Easy Plast
5563	310	41	2026-10-06 10:52:46.415893	A310	Alarm Lini Niverplast - Transport System
5564	311	41	2026-10-06 10:52:46.415893	A311	Błąd Lini Niverplst - Transport System
5565	309	39	2026-10-06 10:53:46.530766	A309	Błąd Lini Niverplst - Easy Plast
5566	310	41	2026-10-06 10:53:46.530766	A310	Alarm Lini Niverplast - Transport System
5567	311	41	2026-10-06 10:53:46.530766	A311	Błąd Lini Niverplst - Transport System
5568	309	39	2026-10-06 10:54:46.661828	A309	Błąd Lini Niverplst - Easy Plast
5569	310	41	2026-10-06 10:54:46.661828	A310	Alarm Lini Niverplast - Transport System
5570	311	41	2026-10-06 10:54:46.661828	A311	Błąd Lini Niverplst - Transport System
5571	309	39	2026-10-06 10:55:45.759233	A309	Błąd Lini Niverplst - Easy Plast
5572	310	41	2026-10-06 10:55:45.759233	A310	Alarm Lini Niverplast - Transport System
5573	311	41	2026-10-06 10:55:45.759233	A311	Błąd Lini Niverplst - Transport System
5574	309	39	2026-10-06 10:56:45.877126	A309	Błąd Lini Niverplst - Easy Plast
5575	310	41	2026-10-06 10:56:45.877126	A310	Alarm Lini Niverplast - Transport System
5576	311	41	2026-10-06 10:56:45.877126	A311	Błąd Lini Niverplst - Transport System
5577	309	39	2026-10-06 10:57:46.010171	A309	Błąd Lini Niverplst - Easy Plast
5578	310	41	2026-10-06 10:57:46.010171	A310	Alarm Lini Niverplast - Transport System
5579	311	41	2026-10-06 10:57:46.010171	A311	Błąd Lini Niverplst - Transport System
5580	309	39	2026-10-06 10:58:46.134163	A309	Błąd Lini Niverplst - Easy Plast
5581	310	41	2026-10-06 10:58:46.134163	A310	Alarm Lini Niverplast - Transport System
5582	311	41	2026-10-06 10:58:46.134163	A311	Błąd Lini Niverplst - Transport System
5583	309	39	2026-10-06 10:59:46.271607	A309	Błąd Lini Niverplst - Easy Plast
5584	310	41	2026-10-06 10:59:46.271607	A310	Alarm Lini Niverplast - Transport System
5585	311	41	2026-10-06 10:59:46.271607	A311	Błąd Lini Niverplst - Transport System
5586	309	39	2026-10-06 11:00:46.381488	A309	Błąd Lini Niverplst - Easy Plast
5587	310	41	2026-10-06 11:00:46.381488	A310	Alarm Lini Niverplast - Transport System
5588	311	41	2026-10-06 11:00:46.381488	A311	Błąd Lini Niverplst - Transport System
5589	309	39	2026-10-06 11:01:46.508285	A309	Błąd Lini Niverplst - Easy Plast
5590	310	41	2026-10-06 11:01:46.508285	A310	Alarm Lini Niverplast - Transport System
5591	311	41	2026-10-06 11:01:46.508285	A311	Błąd Lini Niverplst - Transport System
5592	309	39	2026-10-06 11:02:46.623029	A309	Błąd Lini Niverplst - Easy Plast
5593	310	41	2026-10-06 11:02:46.623029	A310	Alarm Lini Niverplast - Transport System
5594	311	41	2026-10-06 11:02:46.623029	A311	Błąd Lini Niverplst - Transport System
5595	309	39	2026-10-06 11:03:46.762515	A309	Błąd Lini Niverplst - Easy Plast
5596	310	41	2026-10-06 11:03:46.762515	A310	Alarm Lini Niverplast - Transport System
5597	311	41	2026-10-06 11:03:46.762515	A311	Błąd Lini Niverplst - Transport System
5598	309	39	2026-10-06 11:04:46.888008	A309	Błąd Lini Niverplst - Easy Plast
5599	310	41	2026-10-06 11:04:46.888008	A310	Alarm Lini Niverplast - Transport System
5600	311	41	2026-10-06 11:04:46.888008	A311	Błąd Lini Niverplst - Transport System
5601	309	39	2026-10-06 11:05:47.041914	A309	Błąd Lini Niverplst - Easy Plast
5602	310	41	2026-10-06 11:05:47.041914	A310	Alarm Lini Niverplast - Transport System
5603	311	41	2026-10-06 11:05:47.041914	A311	Błąd Lini Niverplst - Transport System
5604	309	39	2026-10-06 11:06:47.125844	A309	Błąd Lini Niverplst - Easy Plast
5605	310	41	2026-10-06 11:06:47.125844	A310	Alarm Lini Niverplast - Transport System
5606	311	41	2026-10-06 11:06:47.125844	A311	Błąd Lini Niverplst - Transport System
5607	309	39	2026-10-06 11:07:47.263282	A309	Błąd Lini Niverplst - Easy Plast
5608	310	41	2026-10-06 11:07:47.263282	A310	Alarm Lini Niverplast - Transport System
5609	311	41	2026-10-06 11:07:47.263282	A311	Błąd Lini Niverplst - Transport System
5610	309	39	2026-10-06 11:08:47.374636	A309	Błąd Lini Niverplst - Easy Plast
5611	310	41	2026-10-06 11:08:47.374636	A310	Alarm Lini Niverplast - Transport System
5612	311	41	2026-10-06 11:08:47.374636	A311	Błąd Lini Niverplst - Transport System
5613	309	39	2026-10-06 11:09:47.52121	A309	Błąd Lini Niverplst - Easy Plast
5614	310	41	2026-10-06 11:09:47.52121	A310	Alarm Lini Niverplast - Transport System
5615	311	41	2026-10-06 11:09:47.52121	A311	Błąd Lini Niverplst - Transport System
5616	309	39	2026-10-06 11:10:46.613538	A309	Błąd Lini Niverplst - Easy Plast
5617	310	41	2026-10-06 11:10:46.613538	A310	Alarm Lini Niverplast - Transport System
5618	311	41	2026-10-06 11:10:46.613538	A311	Błąd Lini Niverplst - Transport System
5619	309	39	2026-10-06 11:11:46.724892	A309	Błąd Lini Niverplst - Easy Plast
5620	310	41	2026-10-06 11:11:46.724892	A310	Alarm Lini Niverplast - Transport System
5621	311	41	2026-10-06 11:11:46.724892	A311	Błąd Lini Niverplst - Transport System
5622	309	39	2026-10-06 11:12:46.880743	A309	Błąd Lini Niverplst - Easy Plast
5623	310	41	2026-10-06 11:12:46.880743	A310	Alarm Lini Niverplast - Transport System
5624	311	41	2026-10-06 11:12:46.880743	A311	Błąd Lini Niverplst - Transport System
5625	309	39	2026-10-06 11:13:46.976109	A309	Błąd Lini Niverplst - Easy Plast
5626	310	41	2026-10-06 11:13:46.976109	A310	Alarm Lini Niverplast - Transport System
5627	311	41	2026-10-06 11:13:46.976109	A311	Błąd Lini Niverplst - Transport System
5628	309	39	2026-10-06 11:14:47.115958	A309	Błąd Lini Niverplst - Easy Plast
5629	310	41	2026-10-06 11:14:47.115958	A310	Alarm Lini Niverplast - Transport System
5630	311	41	2026-10-06 11:14:47.115958	A311	Błąd Lini Niverplst - Transport System
5631	309	39	2026-10-06 11:15:47.247959	A309	Błąd Lini Niverplst - Easy Plast
5632	310	41	2026-10-06 11:15:47.247959	A310	Alarm Lini Niverplast - Transport System
5633	311	41	2026-10-06 11:15:47.247959	A311	Błąd Lini Niverplst - Transport System
5634	309	39	2026-10-06 11:16:47.366587	A309	Błąd Lini Niverplst - Easy Plast
5635	310	41	2026-10-06 11:16:47.366587	A310	Alarm Lini Niverplast - Transport System
5636	311	41	2026-10-06 11:16:47.366587	A311	Błąd Lini Niverplst - Transport System
5637	309	39	2026-10-06 11:17:47.489503	A309	Błąd Lini Niverplst - Easy Plast
5638	310	41	2026-10-06 11:17:47.489503	A310	Alarm Lini Niverplast - Transport System
5639	311	41	2026-10-06 11:17:47.489503	A311	Błąd Lini Niverplst - Transport System
5640	309	39	2026-10-06 11:18:47.623997	A309	Błąd Lini Niverplst - Easy Plast
5641	310	41	2026-10-06 11:18:47.623997	A310	Alarm Lini Niverplast - Transport System
5642	311	41	2026-10-06 11:18:47.623997	A311	Błąd Lini Niverplst - Transport System
5643	309	39	2026-10-06 11:19:47.762987	A309	Błąd Lini Niverplst - Easy Plast
5644	310	41	2026-10-06 11:19:47.762987	A310	Alarm Lini Niverplast - Transport System
5645	311	41	2026-10-06 11:19:47.762987	A311	Błąd Lini Niverplst - Transport System
5646	309	39	2026-10-06 11:20:47.867802	A309	Błąd Lini Niverplst - Easy Plast
5647	310	41	2026-10-06 11:20:47.867802	A310	Alarm Lini Niverplast - Transport System
5648	311	41	2026-10-06 11:20:47.867802	A311	Błąd Lini Niverplst - Transport System
5649	309	39	2026-10-06 11:21:48.045824	A309	Błąd Lini Niverplst - Easy Plast
5650	310	41	2026-10-06 11:21:48.045824	A310	Alarm Lini Niverplast - Transport System
5651	311	41	2026-10-06 11:21:48.045824	A311	Błąd Lini Niverplst - Transport System
5652	309	39	2026-10-06 11:22:48.128258	A309	Błąd Lini Niverplst - Easy Plast
5653	310	41	2026-10-06 11:22:48.128258	A310	Alarm Lini Niverplast - Transport System
5654	311	41	2026-10-06 11:22:48.128258	A311	Błąd Lini Niverplst - Transport System
5655	309	39	2026-10-06 11:23:48.27396	A309	Błąd Lini Niverplst - Easy Plast
5656	310	41	2026-10-06 11:23:48.27396	A310	Alarm Lini Niverplast - Transport System
5657	311	41	2026-10-06 11:23:48.27396	A311	Błąd Lini Niverplst - Transport System
5658	309	39	2026-10-06 11:24:48.382215	A309	Błąd Lini Niverplst - Easy Plast
5659	310	41	2026-10-06 11:24:48.382215	A310	Alarm Lini Niverplast - Transport System
5660	311	41	2026-10-06 11:24:48.382215	A311	Błąd Lini Niverplst - Transport System
5661	309	39	2026-10-06 11:25:47.475949	A309	Błąd Lini Niverplst - Easy Plast
5662	310	41	2026-10-06 11:25:47.475949	A310	Alarm Lini Niverplast - Transport System
5663	311	41	2026-10-06 11:25:47.475949	A311	Błąd Lini Niverplst - Transport System
5664	309	39	2026-10-06 11:26:47.575631	A309	Błąd Lini Niverplst - Easy Plast
5665	310	41	2026-10-06 11:26:47.575631	A310	Alarm Lini Niverplast - Transport System
5666	311	41	2026-10-06 11:26:47.575631	A311	Błąd Lini Niverplst - Transport System
5667	309	39	2026-10-06 11:27:47.665958	A309	Błąd Lini Niverplst - Easy Plast
5668	310	41	2026-10-06 11:27:47.665958	A310	Alarm Lini Niverplast - Transport System
5669	311	41	2026-10-06 11:27:47.665958	A311	Błąd Lini Niverplst - Transport System
5670	309	39	2026-10-06 11:28:47.855659	A309	Błąd Lini Niverplst - Easy Plast
5671	310	41	2026-10-06 11:28:47.855659	A310	Alarm Lini Niverplast - Transport System
5672	311	41	2026-10-06 11:28:47.855659	A311	Błąd Lini Niverplst - Transport System
5673	309	39	2026-10-06 11:29:47.953012	A309	Błąd Lini Niverplst - Easy Plast
5674	310	41	2026-10-06 11:29:47.953012	A310	Alarm Lini Niverplast - Transport System
5675	311	41	2026-10-06 11:29:47.953012	A311	Błąd Lini Niverplst - Transport System
5676	309	39	2026-10-06 11:30:48.115081	A309	Błąd Lini Niverplst - Easy Plast
5677	310	41	2026-10-06 11:30:48.115081	A310	Alarm Lini Niverplast - Transport System
5678	311	41	2026-10-06 11:30:48.115081	A311	Błąd Lini Niverplst - Transport System
5679	309	39	2026-10-06 11:31:48.225856	A309	Błąd Lini Niverplst - Easy Plast
5680	310	41	2026-10-06 11:31:48.225856	A310	Alarm Lini Niverplast - Transport System
5681	311	41	2026-10-06 11:31:48.225856	A311	Błąd Lini Niverplst - Transport System
5682	309	39	2026-10-06 11:32:48.35658	A309	Błąd Lini Niverplst - Easy Plast
5683	310	41	2026-10-06 11:32:48.35658	A310	Alarm Lini Niverplast - Transport System
5684	311	41	2026-10-06 11:32:48.35658	A311	Błąd Lini Niverplst - Transport System
5685	309	39	2026-10-06 11:33:48.483205	A309	Błąd Lini Niverplst - Easy Plast
5686	310	41	2026-10-06 11:33:48.483205	A310	Alarm Lini Niverplast - Transport System
5687	311	41	2026-10-06 11:33:48.483205	A311	Błąd Lini Niverplst - Transport System
5688	309	39	2026-10-06 11:34:48.628878	A309	Błąd Lini Niverplst - Easy Plast
5689	310	41	2026-10-06 11:34:48.628878	A310	Alarm Lini Niverplast - Transport System
5690	311	41	2026-10-06 11:34:48.628878	A311	Błąd Lini Niverplst - Transport System
5691	309	39	2026-10-06 11:35:48.757039	A309	Błąd Lini Niverplst - Easy Plast
5692	310	41	2026-10-06 11:35:48.757039	A310	Alarm Lini Niverplast - Transport System
5693	311	41	2026-10-06 11:35:48.757039	A311	Błąd Lini Niverplst - Transport System
5694	309	39	2026-10-06 11:36:48.7186	A309	Błąd Lini Niverplst - Easy Plast
5695	310	41	2026-10-06 11:36:48.7186	A310	Alarm Lini Niverplast - Transport System
5696	311	41	2026-10-06 11:36:48.7186	A311	Błąd Lini Niverplst - Transport System
5697	309	39	2026-10-06 11:37:49.275758	A309	Błąd Lini Niverplst - Easy Plast
5698	310	41	2026-10-06 11:37:49.275758	A310	Alarm Lini Niverplast - Transport System
5699	311	41	2026-10-06 11:37:49.275758	A311	Błąd Lini Niverplst - Transport System
5700	309	39	2026-10-06 11:38:49.196988	A309	Błąd Lini Niverplst - Easy Plast
5701	310	41	2026-10-06 11:38:49.196988	A310	Alarm Lini Niverplast - Transport System
5702	311	41	2026-10-06 11:38:49.196988	A311	Błąd Lini Niverplst - Transport System
5703	309	39	2026-10-06 11:39:48.258508	A309	Błąd Lini Niverplst - Easy Plast
5704	310	41	2026-10-06 11:39:48.258508	A310	Alarm Lini Niverplast - Transport System
5705	311	41	2026-10-06 11:39:48.258508	A311	Błąd Lini Niverplst - Transport System
5706	309	39	2026-10-06 11:40:48.361634	A309	Błąd Lini Niverplst - Easy Plast
5707	310	41	2026-10-06 11:40:48.361634	A310	Alarm Lini Niverplast - Transport System
5708	311	41	2026-10-06 11:40:48.361634	A311	Błąd Lini Niverplst - Transport System
5709	309	39	2026-10-06 11:41:48.503277	A309	Błąd Lini Niverplst - Easy Plast
5710	310	41	2026-10-06 11:41:48.503277	A310	Alarm Lini Niverplast - Transport System
5711	311	41	2026-10-06 11:41:48.503277	A311	Błąd Lini Niverplst - Transport System
5712	309	39	2026-10-06 11:42:48.632531	A309	Błąd Lini Niverplst - Easy Plast
5713	310	41	2026-10-06 11:42:48.632531	A310	Alarm Lini Niverplast - Transport System
5714	311	41	2026-10-06 11:42:48.632531	A311	Błąd Lini Niverplst - Transport System
5715	309	39	2026-10-06 11:43:48.735968	A309	Błąd Lini Niverplst - Easy Plast
5716	310	41	2026-10-06 11:43:48.735968	A310	Alarm Lini Niverplast - Transport System
5717	311	41	2026-10-06 11:43:48.735968	A311	Błąd Lini Niverplst - Transport System
5718	309	39	2026-10-06 11:44:48.897837	A309	Błąd Lini Niverplst - Easy Plast
5719	310	41	2026-10-06 11:44:48.897837	A310	Alarm Lini Niverplast - Transport System
5720	311	41	2026-10-06 11:44:48.897837	A311	Błąd Lini Niverplst - Transport System
5721	309	39	2026-10-06 11:45:49.041849	A309	Błąd Lini Niverplst - Easy Plast
5722	310	41	2026-10-06 11:45:49.041849	A310	Alarm Lini Niverplast - Transport System
5723	311	41	2026-10-06 11:45:49.041849	A311	Błąd Lini Niverplst - Transport System
5724	309	39	2026-10-06 11:46:49.19134	A309	Błąd Lini Niverplst - Easy Plast
5725	310	41	2026-10-06 11:46:49.19134	A310	Alarm Lini Niverplast - Transport System
5726	311	41	2026-10-06 11:46:49.19134	A311	Błąd Lini Niverplst - Transport System
5727	309	39	2026-10-06 11:47:49.369749	A309	Błąd Lini Niverplst - Easy Plast
5728	310	41	2026-10-06 11:47:49.369749	A310	Alarm Lini Niverplast - Transport System
5729	311	41	2026-10-06 11:47:49.369749	A311	Błąd Lini Niverplst - Transport System
5730	309	39	2026-10-06 11:48:49.454704	A309	Błąd Lini Niverplst - Easy Plast
5731	310	41	2026-10-06 11:48:49.454704	A310	Alarm Lini Niverplast - Transport System
5732	311	41	2026-10-06 11:48:49.454704	A311	Błąd Lini Niverplst - Transport System
5733	309	39	2026-10-06 11:49:49.565782	A309	Błąd Lini Niverplst - Easy Plast
5734	310	41	2026-10-06 11:49:49.565782	A310	Alarm Lini Niverplast - Transport System
5735	311	41	2026-10-06 11:49:49.565782	A311	Błąd Lini Niverplst - Transport System
5736	309	39	2026-10-06 11:50:49.726417	A309	Błąd Lini Niverplst - Easy Plast
5737	310	41	2026-10-06 11:50:49.726417	A310	Alarm Lini Niverplast - Transport System
5738	311	41	2026-10-06 11:50:49.726417	A311	Błąd Lini Niverplst - Transport System
5739	309	39	2026-10-06 11:51:49.838076	A309	Błąd Lini Niverplst - Easy Plast
5740	310	41	2026-10-06 11:51:49.838076	A310	Alarm Lini Niverplast - Transport System
5741	311	41	2026-10-06 11:51:49.838076	A311	Błąd Lini Niverplst - Transport System
5742	309	39	2026-10-06 11:52:50.038211	A309	Błąd Lini Niverplst - Easy Plast
5743	310	41	2026-10-06 11:52:50.038211	A310	Alarm Lini Niverplast - Transport System
5744	311	41	2026-10-06 11:52:50.038211	A311	Błąd Lini Niverplst - Transport System
5745	309	39	2026-10-06 11:53:50.109466	A309	Błąd Lini Niverplst - Easy Plast
5746	310	41	2026-10-06 11:53:50.109466	A310	Alarm Lini Niverplast - Transport System
5747	311	41	2026-10-06 11:53:50.109466	A311	Błąd Lini Niverplst - Transport System
5748	309	39	2026-10-06 11:54:49.124802	A309	Błąd Lini Niverplst - Easy Plast
5749	310	41	2026-10-06 11:54:49.124802	A310	Alarm Lini Niverplast - Transport System
5750	311	41	2026-10-06 11:54:49.124802	A311	Błąd Lini Niverplst - Transport System
5751	309	39	2026-10-06 11:55:49.204667	A309	Błąd Lini Niverplst - Easy Plast
5752	310	41	2026-10-06 11:55:49.204667	A310	Alarm Lini Niverplast - Transport System
5753	311	41	2026-10-06 11:55:49.204667	A311	Błąd Lini Niverplst - Transport System
5754	309	39	2026-10-06 11:56:49.380732	A309	Błąd Lini Niverplst - Easy Plast
5755	310	41	2026-10-06 11:56:49.380732	A310	Alarm Lini Niverplast - Transport System
5756	311	41	2026-10-06 11:56:49.380732	A311	Błąd Lini Niverplst - Transport System
5757	309	39	2026-10-06 11:57:49.548043	A309	Błąd Lini Niverplst - Easy Plast
5758	310	41	2026-10-06 11:57:49.548043	A310	Alarm Lini Niverplast - Transport System
5759	311	41	2026-10-06 11:57:49.548043	A311	Błąd Lini Niverplst - Transport System
5760	309	39	2026-10-06 11:58:49.67633	A309	Błąd Lini Niverplst - Easy Plast
5761	310	41	2026-10-06 11:58:49.67633	A310	Alarm Lini Niverplast - Transport System
5762	311	41	2026-10-06 11:58:49.67633	A311	Błąd Lini Niverplst - Transport System
5763	309	39	2026-10-06 11:59:49.818747	A309	Błąd Lini Niverplst - Easy Plast
5764	310	41	2026-10-06 11:59:49.818747	A310	Alarm Lini Niverplast - Transport System
5765	311	41	2026-10-06 11:59:49.818747	A311	Błąd Lini Niverplst - Transport System
5766	309	39	2026-10-06 12:00:49.954295	A309	Błąd Lini Niverplst - Easy Plast
5767	310	41	2026-10-06 12:00:49.954295	A310	Alarm Lini Niverplast - Transport System
5768	311	41	2026-10-06 12:00:49.954295	A311	Błąd Lini Niverplst - Transport System
5769	309	39	2026-10-06 12:01:50.094893	A309	Błąd Lini Niverplst - Easy Plast
5770	310	41	2026-10-06 12:01:50.094893	A310	Alarm Lini Niverplast - Transport System
5771	311	41	2026-10-06 12:01:50.094893	A311	Błąd Lini Niverplst - Transport System
5772	309	39	2026-10-06 12:02:50.217749	A309	Błąd Lini Niverplst - Easy Plast
5773	310	41	2026-10-06 12:02:50.217749	A310	Alarm Lini Niverplast - Transport System
5774	311	41	2026-10-06 12:02:50.217749	A311	Błąd Lini Niverplst - Transport System
5775	309	39	2026-10-06 12:03:50.372753	A309	Błąd Lini Niverplst - Easy Plast
5776	310	41	2026-10-06 12:03:50.372753	A310	Alarm Lini Niverplast - Transport System
5777	311	41	2026-10-06 12:03:50.372753	A311	Błąd Lini Niverplst - Transport System
5778	309	39	2026-10-06 12:04:50.49823	A309	Błąd Lini Niverplst - Easy Plast
5779	310	41	2026-10-06 12:04:50.49823	A310	Alarm Lini Niverplast - Transport System
5780	311	41	2026-10-06 12:04:50.49823	A311	Błąd Lini Niverplst - Transport System
5781	309	39	2026-10-06 12:05:50.6607	A309	Błąd Lini Niverplst - Easy Plast
5782	310	41	2026-10-06 12:05:50.6607	A310	Alarm Lini Niverplast - Transport System
5783	311	41	2026-10-06 12:05:50.6607	A311	Błąd Lini Niverplst - Transport System
5784	309	39	2026-10-06 12:06:50.770714	A309	Błąd Lini Niverplst - Easy Plast
5785	310	41	2026-10-06 12:06:50.770714	A310	Alarm Lini Niverplast - Transport System
5786	311	41	2026-10-06 12:06:50.770714	A311	Błąd Lini Niverplst - Transport System
5787	309	39	2026-10-06 12:07:50.917187	A309	Błąd Lini Niverplst - Easy Plast
5788	310	41	2026-10-06 12:07:50.917187	A310	Alarm Lini Niverplast - Transport System
5789	311	41	2026-10-06 12:07:50.917187	A311	Błąd Lini Niverplst - Transport System
5790	309	39	2026-10-06 12:08:49.950033	A309	Błąd Lini Niverplst - Easy Plast
5791	310	41	2026-10-06 12:08:49.950033	A310	Alarm Lini Niverplast - Transport System
5792	311	41	2026-10-06 12:08:49.950033	A311	Błąd Lini Niverplst - Transport System
5793	309	39	2026-10-06 12:09:50.041545	A309	Błąd Lini Niverplst - Easy Plast
5794	310	41	2026-10-06 12:09:50.041545	A310	Alarm Lini Niverplast - Transport System
5795	311	41	2026-10-06 12:09:50.041545	A311	Błąd Lini Niverplst - Transport System
5796	309	39	2026-10-06 12:10:50.215548	A309	Błąd Lini Niverplst - Easy Plast
5797	310	41	2026-10-06 12:10:50.215548	A310	Alarm Lini Niverplast - Transport System
5798	311	41	2026-10-06 12:10:50.215548	A311	Błąd Lini Niverplst - Transport System
5799	309	39	2026-10-06 12:11:50.324388	A309	Błąd Lini Niverplst - Easy Plast
5800	310	41	2026-10-06 12:11:50.324388	A310	Alarm Lini Niverplast - Transport System
5801	311	41	2026-10-06 12:11:50.324388	A311	Błąd Lini Niverplst - Transport System
5802	309	39	2026-10-06 12:12:50.476273	A309	Błąd Lini Niverplst - Easy Plast
5803	310	41	2026-10-06 12:12:50.476273	A310	Alarm Lini Niverplast - Transport System
5804	311	41	2026-10-06 12:12:50.476273	A311	Błąd Lini Niverplst - Transport System
5805	309	39	2026-10-06 12:13:50.61704	A309	Błąd Lini Niverplst - Easy Plast
5806	310	41	2026-10-06 12:13:50.61704	A310	Alarm Lini Niverplast - Transport System
5807	311	41	2026-10-06 12:13:50.61704	A311	Błąd Lini Niverplst - Transport System
5808	309	39	2026-10-06 12:14:50.718311	A309	Błąd Lini Niverplst - Easy Plast
5809	310	41	2026-10-06 12:14:50.718311	A310	Alarm Lini Niverplast - Transport System
5810	311	41	2026-10-06 12:14:50.718311	A311	Błąd Lini Niverplst - Transport System
5811	309	39	2026-10-06 12:15:50.879596	A309	Błąd Lini Niverplst - Easy Plast
5812	310	41	2026-10-06 12:15:50.879596	A310	Alarm Lini Niverplast - Transport System
5813	311	41	2026-10-06 12:15:50.879596	A311	Błąd Lini Niverplst - Transport System
5814	309	39	2026-10-06 12:16:51.057095	A309	Błąd Lini Niverplst - Easy Plast
5815	310	41	2026-10-06 12:16:51.057095	A310	Alarm Lini Niverplast - Transport System
5816	311	41	2026-10-06 12:16:51.057095	A311	Błąd Lini Niverplst - Transport System
5817	309	39	2026-10-06 12:17:51.162032	A309	Błąd Lini Niverplst - Easy Plast
5818	310	41	2026-10-06 12:17:51.162032	A310	Alarm Lini Niverplast - Transport System
5819	311	41	2026-10-06 12:17:51.162032	A311	Błąd Lini Niverplst - Transport System
5820	309	39	2026-10-06 12:18:51.319642	A309	Błąd Lini Niverplst - Easy Plast
5821	310	41	2026-10-06 12:18:51.319642	A310	Alarm Lini Niverplast - Transport System
5822	311	41	2026-10-06 12:18:51.319642	A311	Błąd Lini Niverplst - Transport System
5823	309	39	2026-10-06 12:19:51.438064	A309	Błąd Lini Niverplst - Easy Plast
5824	310	41	2026-10-06 12:19:51.438064	A310	Alarm Lini Niverplast - Transport System
5825	311	41	2026-10-06 12:19:51.438064	A311	Błąd Lini Niverplst - Transport System
5826	309	39	2026-10-06 12:20:51.586088	A309	Błąd Lini Niverplst - Easy Plast
5827	310	41	2026-10-06 12:20:51.586088	A310	Alarm Lini Niverplast - Transport System
5828	311	41	2026-10-06 12:20:51.586088	A311	Błąd Lini Niverplst - Transport System
5829	309	39	2026-10-06 12:21:52.071613	A309	Błąd Lini Niverplst - Easy Plast
5830	310	41	2026-10-06 12:21:52.071613	A310	Alarm Lini Niverplast - Transport System
5831	311	41	2026-10-06 12:21:52.071613	A311	Błąd Lini Niverplst - Transport System
5832	309	39	2026-10-06 12:22:50.717569	A309	Błąd Lini Niverplst - Easy Plast
5833	310	41	2026-10-06 12:22:50.717569	A310	Alarm Lini Niverplast - Transport System
5834	311	41	2026-10-06 12:22:50.717569	A311	Błąd Lini Niverplst - Transport System
5835	309	39	2026-10-06 12:23:50.879373	A309	Błąd Lini Niverplst - Easy Plast
5836	310	41	2026-10-06 12:23:50.879373	A310	Alarm Lini Niverplast - Transport System
5837	311	41	2026-10-06 12:23:50.879373	A311	Błąd Lini Niverplst - Transport System
5838	309	39	2026-10-06 12:24:51.008068	A309	Błąd Lini Niverplst - Easy Plast
5839	310	41	2026-10-06 12:24:51.008068	A310	Alarm Lini Niverplast - Transport System
5840	311	41	2026-10-06 12:24:51.008068	A311	Błąd Lini Niverplst - Transport System
5841	309	39	2026-10-06 12:25:51.144803	A309	Błąd Lini Niverplst - Easy Plast
5842	310	41	2026-10-06 12:25:51.144803	A310	Alarm Lini Niverplast - Transport System
5843	311	41	2026-10-06 12:25:51.144803	A311	Błąd Lini Niverplst - Transport System
5844	309	39	2026-10-06 12:26:51.281429	A309	Błąd Lini Niverplst - Easy Plast
5845	310	41	2026-10-06 12:26:51.281429	A310	Alarm Lini Niverplast - Transport System
5846	311	41	2026-10-06 12:26:51.281429	A311	Błąd Lini Niverplst - Transport System
5847	309	39	2026-10-06 12:27:51.407388	A309	Błąd Lini Niverplst - Easy Plast
5848	310	41	2026-10-06 12:27:51.407388	A310	Alarm Lini Niverplast - Transport System
5849	311	41	2026-10-06 12:27:51.407388	A311	Błąd Lini Niverplst - Transport System
5850	309	39	2026-10-06 12:28:51.564954	A309	Błąd Lini Niverplst - Easy Plast
5851	310	41	2026-10-06 12:28:51.564954	A310	Alarm Lini Niverplast - Transport System
5852	311	41	2026-10-06 12:28:51.564954	A311	Błąd Lini Niverplst - Transport System
5853	309	39	2026-10-06 12:29:51.705598	A309	Błąd Lini Niverplst - Easy Plast
5854	310	41	2026-10-06 12:29:51.705598	A310	Alarm Lini Niverplast - Transport System
5855	311	41	2026-10-06 12:29:51.705598	A311	Błąd Lini Niverplst - Transport System
5856	309	39	2026-10-06 12:30:51.839432	A309	Błąd Lini Niverplst - Easy Plast
5857	310	41	2026-10-06 12:30:51.839432	A310	Alarm Lini Niverplast - Transport System
5858	311	41	2026-10-06 12:30:51.839432	A311	Błąd Lini Niverplst - Transport System
5859	309	39	2026-10-06 12:31:51.980539	A309	Błąd Lini Niverplst - Easy Plast
5860	310	41	2026-10-06 12:31:51.980539	A310	Alarm Lini Niverplast - Transport System
5861	311	41	2026-10-06 12:31:51.980539	A311	Błąd Lini Niverplst - Transport System
5862	309	39	2026-10-06 12:32:52.108966	A309	Błąd Lini Niverplst - Easy Plast
5863	310	41	2026-10-06 12:32:52.108966	A310	Alarm Lini Niverplast - Transport System
5864	311	41	2026-10-06 12:32:52.108966	A311	Błąd Lini Niverplst - Transport System
5865	309	39	2026-10-06 12:33:52.248513	A309	Błąd Lini Niverplst - Easy Plast
5866	310	41	2026-10-06 12:33:52.248513	A310	Alarm Lini Niverplast - Transport System
5867	311	41	2026-10-06 12:33:52.248513	A311	Błąd Lini Niverplst - Transport System
5868	309	39	2026-10-06 12:34:52.408013	A309	Błąd Lini Niverplst - Easy Plast
5869	310	41	2026-10-06 12:34:52.408013	A310	Alarm Lini Niverplast - Transport System
5870	311	41	2026-10-06 12:34:52.408013	A311	Błąd Lini Niverplst - Transport System
5871	309	39	2026-10-06 12:35:52.523976	A309	Błąd Lini Niverplst - Easy Plast
5872	310	41	2026-10-06 12:35:52.523976	A310	Alarm Lini Niverplast - Transport System
5873	311	41	2026-10-06 12:35:52.523976	A311	Błąd Lini Niverplst - Transport System
5874	309	39	2026-10-06 12:36:51.538927	A309	Błąd Lini Niverplst - Easy Plast
5875	310	41	2026-10-06 12:36:51.538927	A310	Alarm Lini Niverplast - Transport System
5876	311	41	2026-10-06 12:36:51.538927	A311	Błąd Lini Niverplst - Transport System
5877	309	39	2026-10-06 12:37:51.670506	A309	Błąd Lini Niverplst - Easy Plast
5878	310	41	2026-10-06 12:37:51.670506	A310	Alarm Lini Niverplast - Transport System
5879	311	41	2026-10-06 12:37:51.670506	A311	Błąd Lini Niverplst - Transport System
5880	309	39	2026-10-06 12:38:51.773614	A309	Błąd Lini Niverplst - Easy Plast
5881	310	41	2026-10-06 12:38:51.773614	A310	Alarm Lini Niverplast - Transport System
5882	311	41	2026-10-06 12:38:51.773614	A311	Błąd Lini Niverplst - Transport System
5883	309	39	2026-10-06 12:39:51.9711	A309	Błąd Lini Niverplst - Easy Plast
5884	310	41	2026-10-06 12:39:51.9711	A310	Alarm Lini Niverplast - Transport System
5885	311	41	2026-10-06 12:39:51.9711	A311	Błąd Lini Niverplst - Transport System
5886	309	39	2026-10-06 12:40:52.068832	A309	Błąd Lini Niverplst - Easy Plast
5887	310	41	2026-10-06 12:40:52.068832	A310	Alarm Lini Niverplast - Transport System
5888	311	41	2026-10-06 12:40:52.068832	A311	Błąd Lini Niverplst - Transport System
5889	309	39	2026-10-06 12:41:52.234328	A309	Błąd Lini Niverplst - Easy Plast
5890	310	41	2026-10-06 12:41:52.234328	A310	Alarm Lini Niverplast - Transport System
5891	311	41	2026-10-06 12:41:52.234328	A311	Błąd Lini Niverplst - Transport System
5892	309	39	2026-10-06 12:42:52.377363	A309	Błąd Lini Niverplst - Easy Plast
5893	310	41	2026-10-06 12:42:52.377363	A310	Alarm Lini Niverplast - Transport System
5894	311	41	2026-10-06 12:42:52.377363	A311	Błąd Lini Niverplst - Transport System
5895	309	39	2026-10-06 12:43:52.522986	A309	Błąd Lini Niverplst - Easy Plast
5896	310	41	2026-10-06 12:43:52.522986	A310	Alarm Lini Niverplast - Transport System
5897	311	41	2026-10-06 12:43:52.522986	A311	Błąd Lini Niverplst - Transport System
5898	309	39	2026-10-06 12:44:52.649508	A309	Błąd Lini Niverplst - Easy Plast
5899	310	41	2026-10-06 12:44:52.649508	A310	Alarm Lini Niverplast - Transport System
5900	311	41	2026-10-06 12:44:52.649508	A311	Błąd Lini Niverplst - Transport System
5901	309	39	2026-10-06 12:45:52.795153	A309	Błąd Lini Niverplst - Easy Plast
5902	310	41	2026-10-06 12:45:52.795153	A310	Alarm Lini Niverplast - Transport System
5903	311	41	2026-10-06 12:45:52.795153	A311	Błąd Lini Niverplst - Transport System
5904	309	39	2026-10-06 12:46:52.950757	A309	Błąd Lini Niverplst - Easy Plast
5905	310	41	2026-10-06 12:46:52.950757	A310	Alarm Lini Niverplast - Transport System
5906	311	41	2026-10-06 12:46:52.950757	A311	Błąd Lini Niverplst - Transport System
5907	309	39	2026-10-06 12:47:53.081162	A309	Błąd Lini Niverplst - Easy Plast
5908	310	41	2026-10-06 12:47:53.081162	A310	Alarm Lini Niverplast - Transport System
5909	311	41	2026-10-06 12:47:53.081162	A311	Błąd Lini Niverplst - Transport System
5910	309	39	2026-10-06 12:48:53.224585	A309	Błąd Lini Niverplst - Easy Plast
5911	310	41	2026-10-06 12:48:53.224585	A310	Alarm Lini Niverplast - Transport System
5912	311	41	2026-10-06 12:48:53.224585	A311	Błąd Lini Niverplst - Transport System
5913	309	39	2026-10-06 12:49:53.356861	A309	Błąd Lini Niverplst - Easy Plast
5914	310	41	2026-10-06 12:49:53.356861	A310	Alarm Lini Niverplast - Transport System
5915	311	41	2026-10-06 12:49:53.356861	A311	Błąd Lini Niverplst - Transport System
5916	309	39	2026-10-06 12:50:52.372223	A309	Błąd Lini Niverplst - Easy Plast
5917	310	41	2026-10-06 12:50:52.372223	A310	Alarm Lini Niverplast - Transport System
5918	311	41	2026-10-06 12:50:52.372223	A311	Błąd Lini Niverplst - Transport System
5919	309	39	2026-10-06 12:51:52.481607	A309	Błąd Lini Niverplst - Easy Plast
5920	310	41	2026-10-06 12:51:52.481607	A310	Alarm Lini Niverplast - Transport System
5921	311	41	2026-10-06 12:51:52.481607	A311	Błąd Lini Niverplst - Transport System
5922	309	39	2026-10-06 12:52:52.645846	A309	Błąd Lini Niverplst - Easy Plast
5923	310	41	2026-10-06 12:52:52.645846	A310	Alarm Lini Niverplast - Transport System
5924	311	41	2026-10-06 12:52:52.645846	A311	Błąd Lini Niverplst - Transport System
5925	309	39	2026-10-06 12:53:52.790046	A309	Błąd Lini Niverplst - Easy Plast
5926	310	41	2026-10-06 12:53:52.790046	A310	Alarm Lini Niverplast - Transport System
5927	311	41	2026-10-06 12:53:52.790046	A311	Błąd Lini Niverplst - Transport System
5928	309	39	2026-10-06 12:54:52.929496	A309	Błąd Lini Niverplst - Easy Plast
5929	310	41	2026-10-06 12:54:52.929496	A310	Alarm Lini Niverplast - Transport System
5930	311	41	2026-10-06 12:54:52.929496	A311	Błąd Lini Niverplst - Transport System
5931	309	39	2026-10-06 12:55:53.053656	A309	Błąd Lini Niverplst - Easy Plast
5932	310	41	2026-10-06 12:55:53.053656	A310	Alarm Lini Niverplast - Transport System
5933	311	41	2026-10-06 12:55:53.053656	A311	Błąd Lini Niverplst - Transport System
5934	309	39	2026-10-06 12:56:53.212282	A309	Błąd Lini Niverplst - Easy Plast
5935	310	41	2026-10-06 12:56:53.212282	A310	Alarm Lini Niverplast - Transport System
5936	311	41	2026-10-06 12:56:53.212282	A311	Błąd Lini Niverplst - Transport System
5937	309	39	2026-10-06 12:57:53.343941	A309	Błąd Lini Niverplst - Easy Plast
5938	310	41	2026-10-06 12:57:53.343941	A310	Alarm Lini Niverplast - Transport System
5939	311	41	2026-10-06 12:57:53.343941	A311	Błąd Lini Niverplst - Transport System
5940	309	39	2026-10-06 12:58:53.492629	A309	Błąd Lini Niverplst - Easy Plast
5941	310	41	2026-10-06 12:58:53.492629	A310	Alarm Lini Niverplast - Transport System
5942	311	41	2026-10-06 12:58:53.492629	A311	Błąd Lini Niverplst - Transport System
5943	309	39	2026-10-06 12:59:53.630595	A309	Błąd Lini Niverplst - Easy Plast
5944	310	41	2026-10-06 12:59:53.630595	A310	Alarm Lini Niverplast - Transport System
5945	311	41	2026-10-06 12:59:53.630595	A311	Błąd Lini Niverplst - Transport System
5946	309	39	2026-10-06 13:00:53.794511	A309	Błąd Lini Niverplst - Easy Plast
5947	310	41	2026-10-06 13:00:53.794511	A310	Alarm Lini Niverplast - Transport System
5948	311	41	2026-10-06 13:00:53.794511	A311	Błąd Lini Niverplst - Transport System
5949	309	39	2026-10-06 13:01:53.911786	A309	Błąd Lini Niverplst - Easy Plast
5950	310	41	2026-10-06 13:01:53.911786	A310	Alarm Lini Niverplast - Transport System
5951	311	41	2026-10-06 13:01:53.911786	A311	Błąd Lini Niverplst - Transport System
5952	309	39	2026-10-06 13:02:54.037475	A309	Błąd Lini Niverplst - Easy Plast
5953	310	41	2026-10-06 13:02:54.037475	A310	Alarm Lini Niverplast - Transport System
5954	311	41	2026-10-06 13:02:54.037475	A311	Błąd Lini Niverplst - Transport System
5955	309	39	2026-10-06 13:03:54.206924	A309	Błąd Lini Niverplst - Easy Plast
5956	310	41	2026-10-06 13:03:54.206924	A310	Alarm Lini Niverplast - Transport System
5957	311	41	2026-10-06 13:03:54.206924	A311	Błąd Lini Niverplst - Transport System
5958	309	39	2026-10-06 13:04:53.180388	A309	Błąd Lini Niverplst - Easy Plast
5959	310	41	2026-10-06 13:04:53.180388	A310	Alarm Lini Niverplast - Transport System
5960	311	41	2026-10-06 13:04:53.180388	A311	Błąd Lini Niverplst - Transport System
5961	309	39	2026-10-06 13:05:53.288287	A309	Błąd Lini Niverplst - Easy Plast
5962	310	41	2026-10-06 13:05:53.288287	A310	Alarm Lini Niverplast - Transport System
5963	311	41	2026-10-06 13:05:53.288287	A311	Błąd Lini Niverplst - Transport System
5964	309	39	2026-10-06 13:06:53.464095	A309	Błąd Lini Niverplst - Easy Plast
5965	310	41	2026-10-06 13:06:53.464095	A310	Alarm Lini Niverplast - Transport System
5966	311	41	2026-10-06 13:06:53.464095	A311	Błąd Lini Niverplst - Transport System
5967	309	39	2026-10-06 13:07:53.584277	A309	Błąd Lini Niverplst - Easy Plast
5968	310	41	2026-10-06 13:07:53.584277	A310	Alarm Lini Niverplast - Transport System
5969	311	41	2026-10-06 13:07:53.584277	A311	Błąd Lini Niverplst - Transport System
5970	309	39	2026-10-06 13:08:53.73171	A309	Błąd Lini Niverplst - Easy Plast
5971	310	41	2026-10-06 13:08:53.73171	A310	Alarm Lini Niverplast - Transport System
5972	311	41	2026-10-06 13:08:53.73171	A311	Błąd Lini Niverplst - Transport System
5973	309	39	2026-10-06 13:09:53.881117	A309	Błąd Lini Niverplst - Easy Plast
5974	310	41	2026-10-06 13:09:53.881117	A310	Alarm Lini Niverplast - Transport System
5975	311	41	2026-10-06 13:09:53.881117	A311	Błąd Lini Niverplst - Transport System
5976	309	39	2026-10-06 13:10:54.024637	A309	Błąd Lini Niverplst - Easy Plast
5977	310	41	2026-10-06 13:10:54.024637	A310	Alarm Lini Niverplast - Transport System
5978	311	41	2026-10-06 13:10:54.024637	A311	Błąd Lini Niverplst - Transport System
5979	309	39	2026-10-06 13:11:54.186358	A309	Błąd Lini Niverplst - Easy Plast
5980	310	41	2026-10-06 13:11:54.186358	A310	Alarm Lini Niverplast - Transport System
5981	311	41	2026-10-06 13:11:54.186358	A311	Błąd Lini Niverplst - Transport System
5982	309	39	2026-10-06 13:12:54.319667	A309	Błąd Lini Niverplst - Easy Plast
5983	310	41	2026-10-06 13:12:54.319667	A310	Alarm Lini Niverplast - Transport System
5984	311	41	2026-10-06 13:12:54.319667	A311	Błąd Lini Niverplst - Transport System
5985	309	39	2026-10-06 13:13:54.471858	A309	Błąd Lini Niverplst - Easy Plast
5986	310	41	2026-10-06 13:13:54.471858	A310	Alarm Lini Niverplast - Transport System
5987	311	41	2026-10-06 13:13:54.471858	A311	Błąd Lini Niverplst - Transport System
5988	309	39	2026-10-06 13:14:54.931132	A309	Błąd Lini Niverplst - Easy Plast
5989	310	41	2026-10-06 13:14:54.931132	A310	Alarm Lini Niverplast - Transport System
5990	311	41	2026-10-06 13:14:54.931132	A311	Błąd Lini Niverplst - Transport System
5991	309	39	2026-10-06 13:15:54.76156	A309	Błąd Lini Niverplst - Easy Plast
5992	310	41	2026-10-06 13:15:54.76156	A310	Alarm Lini Niverplast - Transport System
5993	311	41	2026-10-06 13:15:54.76156	A311	Błąd Lini Niverplst - Transport System
5994	309	39	2026-10-06 13:16:54.906544	A309	Błąd Lini Niverplst - Easy Plast
5995	310	41	2026-10-06 13:16:54.906544	A310	Alarm Lini Niverplast - Transport System
5996	311	41	2026-10-06 13:16:54.906544	A311	Błąd Lini Niverplst - Transport System
5997	309	39	2026-10-06 13:17:54.415714	A309	Błąd Lini Niverplst - Easy Plast
5998	310	41	2026-10-06 13:17:54.415714	A310	Alarm Lini Niverplast - Transport System
5999	311	41	2026-10-06 13:17:54.415714	A311	Błąd Lini Niverplst - Transport System
6000	309	39	2026-10-06 13:18:54.011295	A309	Błąd Lini Niverplst - Easy Plast
6001	310	41	2026-10-06 13:18:54.011295	A310	Alarm Lini Niverplast - Transport System
6002	311	41	2026-10-06 13:18:54.011295	A311	Błąd Lini Niverplst - Transport System
6003	309	39	2026-10-06 13:19:54.152192	A309	Błąd Lini Niverplst - Easy Plast
6004	310	41	2026-10-06 13:19:54.152192	A310	Alarm Lini Niverplast - Transport System
6005	311	41	2026-10-06 13:19:54.152192	A311	Błąd Lini Niverplst - Transport System
6006	309	39	2026-10-06 13:20:54.284152	A309	Błąd Lini Niverplst - Easy Plast
6007	310	41	2026-10-06 13:20:54.284152	A310	Alarm Lini Niverplast - Transport System
6008	311	41	2026-10-06 13:20:54.284152	A311	Błąd Lini Niverplst - Transport System
6009	309	39	2026-10-06 13:21:54.442327	A309	Błąd Lini Niverplst - Easy Plast
6010	310	41	2026-10-06 13:21:54.442327	A310	Alarm Lini Niverplast - Transport System
6011	311	41	2026-10-06 13:21:54.442327	A311	Błąd Lini Niverplst - Transport System
6012	309	39	2026-10-06 13:22:54.613472	A309	Błąd Lini Niverplst - Easy Plast
6013	310	41	2026-10-06 13:22:54.613472	A310	Alarm Lini Niverplast - Transport System
6014	311	41	2026-10-06 13:22:54.613472	A311	Błąd Lini Niverplst - Transport System
6015	309	39	2026-10-06 13:23:54.731988	A309	Błąd Lini Niverplst - Easy Plast
6016	310	41	2026-10-06 13:23:54.731988	A310	Alarm Lini Niverplast - Transport System
6017	311	41	2026-10-06 13:23:54.731988	A311	Błąd Lini Niverplst - Transport System
6018	309	39	2026-10-06 13:24:54.877889	A309	Błąd Lini Niverplst - Easy Plast
6019	310	41	2026-10-06 13:24:54.877889	A310	Alarm Lini Niverplast - Transport System
6020	311	41	2026-10-06 13:24:54.877889	A311	Błąd Lini Niverplst - Transport System
6021	309	39	2026-10-06 13:25:55.018619	A309	Błąd Lini Niverplst - Easy Plast
6022	310	41	2026-10-06 13:25:55.018619	A310	Alarm Lini Niverplast - Transport System
6023	311	41	2026-10-06 13:25:55.018619	A311	Błąd Lini Niverplst - Transport System
6024	309	39	2026-10-06 13:26:55.163008	A309	Błąd Lini Niverplst - Easy Plast
6025	310	41	2026-10-06 13:26:55.163008	A310	Alarm Lini Niverplast - Transport System
6026	311	41	2026-10-06 13:26:55.163008	A311	Błąd Lini Niverplst - Transport System
6027	309	39	2026-10-06 13:27:55.314446	A309	Błąd Lini Niverplst - Easy Plast
6028	310	41	2026-10-06 13:27:55.314446	A310	Alarm Lini Niverplast - Transport System
6029	311	41	2026-10-06 13:27:55.314446	A311	Błąd Lini Niverplst - Transport System
6030	309	39	2026-10-06 13:28:55.461526	A309	Błąd Lini Niverplst - Easy Plast
6031	310	41	2026-10-06 13:28:55.461526	A310	Alarm Lini Niverplast - Transport System
6032	311	41	2026-10-06 13:28:55.461526	A311	Błąd Lini Niverplst - Transport System
6033	309	39	2026-10-06 13:29:55.643403	A309	Błąd Lini Niverplst - Easy Plast
6034	310	41	2026-10-06 13:29:55.643403	A310	Alarm Lini Niverplast - Transport System
6035	311	41	2026-10-06 13:29:55.643403	A311	Błąd Lini Niverplst - Transport System
6036	309	39	2026-10-06 13:30:55.73425	A309	Błąd Lini Niverplst - Easy Plast
6037	310	41	2026-10-06 13:30:55.73425	A310	Alarm Lini Niverplast - Transport System
6038	311	41	2026-10-06 13:30:55.73425	A311	Błąd Lini Niverplst - Transport System
6039	309	39	2026-10-06 13:31:54.68345	A309	Błąd Lini Niverplst - Easy Plast
6040	310	41	2026-10-06 13:31:54.68345	A310	Alarm Lini Niverplast - Transport System
6041	311	41	2026-10-06 13:31:54.68345	A311	Błąd Lini Niverplst - Transport System
6042	309	39	2026-10-06 13:32:54.861153	A309	Błąd Lini Niverplst - Easy Plast
6043	310	41	2026-10-06 13:32:54.861153	A310	Alarm Lini Niverplast - Transport System
6044	311	41	2026-10-06 13:32:54.861153	A311	Błąd Lini Niverplst - Transport System
6045	309	39	2026-10-06 13:33:54.975005	A309	Błąd Lini Niverplst - Easy Plast
6046	310	41	2026-10-06 13:33:54.975005	A310	Alarm Lini Niverplast - Transport System
6047	311	41	2026-10-06 13:33:54.975005	A311	Błąd Lini Niverplst - Transport System
6048	309	39	2026-10-06 13:34:55.161233	A309	Błąd Lini Niverplst - Easy Plast
6049	310	41	2026-10-06 13:34:55.161233	A310	Alarm Lini Niverplast - Transport System
6050	311	41	2026-10-06 13:34:55.161233	A311	Błąd Lini Niverplst - Transport System
6051	309	39	2026-10-06 13:35:55.277434	A309	Błąd Lini Niverplst - Easy Plast
6052	310	41	2026-10-06 13:35:55.277434	A310	Alarm Lini Niverplast - Transport System
6053	311	41	2026-10-06 13:35:55.277434	A311	Błąd Lini Niverplst - Transport System
6054	309	39	2026-10-06 13:36:55.444072	A309	Błąd Lini Niverplst - Easy Plast
6055	310	41	2026-10-06 13:36:55.444072	A310	Alarm Lini Niverplast - Transport System
6056	311	41	2026-10-06 13:36:55.444072	A311	Błąd Lini Niverplst - Transport System
6057	309	39	2026-10-06 13:37:55.564878	A309	Błąd Lini Niverplst - Easy Plast
6058	310	41	2026-10-06 13:37:55.564878	A310	Alarm Lini Niverplast - Transport System
6059	311	41	2026-10-06 13:37:55.564878	A311	Błąd Lini Niverplst - Transport System
6060	309	39	2026-10-06 13:38:55.738519	A309	Błąd Lini Niverplst - Easy Plast
6061	310	41	2026-10-06 13:38:55.738519	A310	Alarm Lini Niverplast - Transport System
6062	311	41	2026-10-06 13:38:55.738519	A311	Błąd Lini Niverplst - Transport System
6063	309	39	2026-10-06 13:39:55.869104	A309	Błąd Lini Niverplst - Easy Plast
6064	310	41	2026-10-06 13:39:55.869104	A310	Alarm Lini Niverplast - Transport System
6065	311	41	2026-10-06 13:39:55.869104	A311	Błąd Lini Niverplst - Transport System
6066	309	39	2026-10-06 13:40:56.029549	A309	Błąd Lini Niverplst - Easy Plast
6067	310	41	2026-10-06 13:40:56.029549	A310	Alarm Lini Niverplast - Transport System
6068	311	41	2026-10-06 13:40:56.029549	A311	Błąd Lini Niverplst - Transport System
6069	309	39	2026-10-06 13:41:56.161207	A309	Błąd Lini Niverplst - Easy Plast
6070	310	41	2026-10-06 13:41:56.161207	A310	Alarm Lini Niverplast - Transport System
6071	311	41	2026-10-06 13:41:56.161207	A311	Błąd Lini Niverplst - Transport System
6072	309	39	2026-10-06 13:42:56.309482	A309	Błąd Lini Niverplst - Easy Plast
6073	310	41	2026-10-06 13:42:56.309482	A310	Alarm Lini Niverplast - Transport System
6074	311	41	2026-10-06 13:42:56.309482	A311	Błąd Lini Niverplst - Transport System
6075	309	39	2026-10-06 13:43:56.448651	A309	Błąd Lini Niverplst - Easy Plast
6076	310	41	2026-10-06 13:43:56.448651	A310	Alarm Lini Niverplast - Transport System
6077	311	41	2026-10-06 13:43:56.448651	A311	Błąd Lini Niverplst - Transport System
6078	309	39	2026-10-06 13:44:55.407644	A309	Błąd Lini Niverplst - Easy Plast
6079	310	41	2026-10-06 13:44:55.407644	A310	Alarm Lini Niverplast - Transport System
6080	311	41	2026-10-06 13:44:55.407644	A311	Błąd Lini Niverplst - Transport System
6081	309	39	2026-10-06 13:45:55.557699	A309	Błąd Lini Niverplst - Easy Plast
6082	310	41	2026-10-06 13:45:55.557699	A310	Alarm Lini Niverplast - Transport System
6083	311	41	2026-10-06 13:45:55.557699	A311	Błąd Lini Niverplst - Transport System
6084	309	39	2026-10-06 13:46:55.693762	A309	Błąd Lini Niverplst - Easy Plast
6085	310	41	2026-10-06 13:46:55.693762	A310	Alarm Lini Niverplast - Transport System
6086	311	41	2026-10-06 13:46:55.693762	A311	Błąd Lini Niverplst - Transport System
6087	309	39	2026-10-06 13:47:55.893469	A309	Błąd Lini Niverplst - Easy Plast
6088	310	41	2026-10-06 13:47:55.893469	A310	Alarm Lini Niverplast - Transport System
6089	311	41	2026-10-06 13:47:55.893469	A311	Błąd Lini Niverplst - Transport System
6090	309	39	2026-10-06 13:48:55.98705	A309	Błąd Lini Niverplst - Easy Plast
6091	310	41	2026-10-06 13:48:55.98705	A310	Alarm Lini Niverplast - Transport System
6092	311	41	2026-10-06 13:48:55.98705	A311	Błąd Lini Niverplst - Transport System
6093	309	39	2026-10-06 13:49:56.158321	A309	Błąd Lini Niverplst - Easy Plast
6094	310	41	2026-10-06 13:49:56.158321	A310	Alarm Lini Niverplast - Transport System
6095	311	41	2026-10-06 13:49:56.158321	A311	Błąd Lini Niverplst - Transport System
6096	309	39	2026-10-06 13:50:56.284296	A309	Błąd Lini Niverplst - Easy Plast
6097	310	41	2026-10-06 13:50:56.284296	A310	Alarm Lini Niverplast - Transport System
6098	311	41	2026-10-06 13:50:56.284296	A311	Błąd Lini Niverplst - Transport System
6099	309	39	2026-10-06 13:51:55.810435	A309	Błąd Lini Niverplst - Easy Plast
6100	310	41	2026-10-06 13:51:55.810435	A310	Alarm Lini Niverplast - Transport System
6101	311	41	2026-10-06 13:51:55.810435	A311	Błąd Lini Niverplst - Transport System
6102	309	39	2026-10-06 13:52:56.61271	A309	Błąd Lini Niverplst - Easy Plast
6103	310	41	2026-10-06 13:52:56.61271	A310	Alarm Lini Niverplast - Transport System
6104	311	41	2026-10-06 13:52:56.61271	A311	Błąd Lini Niverplst - Transport System
6105	309	39	2026-10-06 13:53:56.737677	A309	Błąd Lini Niverplst - Easy Plast
6106	310	41	2026-10-06 13:53:56.737677	A310	Alarm Lini Niverplast - Transport System
6107	311	41	2026-10-06 13:53:56.737677	A311	Błąd Lini Niverplst - Transport System
6108	309	39	2026-10-06 13:54:56.882221	A309	Błąd Lini Niverplst - Easy Plast
6109	310	41	2026-10-06 13:54:56.882221	A310	Alarm Lini Niverplast - Transport System
6110	311	41	2026-10-06 13:54:56.882221	A311	Błąd Lini Niverplst - Transport System
6111	309	39	2026-10-06 13:55:57.067982	A309	Błąd Lini Niverplst - Easy Plast
6112	310	41	2026-10-06 13:55:57.067982	A310	Alarm Lini Niverplast - Transport System
6113	311	41	2026-10-06 13:55:57.067982	A311	Błąd Lini Niverplst - Transport System
6114	309	39	2026-10-06 13:56:57.1919	A309	Błąd Lini Niverplst - Easy Plast
6115	310	41	2026-10-06 13:56:57.1919	A310	Alarm Lini Niverplast - Transport System
6116	311	41	2026-10-06 13:56:57.1919	A311	Błąd Lini Niverplst - Transport System
6117	309	39	2026-10-06 13:57:57.344415	A309	Błąd Lini Niverplst - Easy Plast
6118	310	41	2026-10-06 13:57:57.344415	A310	Alarm Lini Niverplast - Transport System
6119	311	41	2026-10-06 13:57:57.344415	A311	Błąd Lini Niverplst - Transport System
6120	309	39	2026-10-06 13:58:56.257723	A309	Błąd Lini Niverplst - Easy Plast
6121	310	41	2026-10-06 13:58:56.257723	A310	Alarm Lini Niverplast - Transport System
6122	311	41	2026-10-06 13:58:56.257723	A311	Błąd Lini Niverplst - Transport System
6123	309	39	2026-10-06 13:59:56.432232	A309	Błąd Lini Niverplst - Easy Plast
6124	310	41	2026-10-06 13:59:56.432232	A310	Alarm Lini Niverplast - Transport System
6125	311	41	2026-10-06 13:59:56.432232	A311	Błąd Lini Niverplst - Transport System
6126	309	39	2026-10-06 14:00:56.558689	A309	Błąd Lini Niverplst - Easy Plast
6127	310	41	2026-10-06 14:00:56.558689	A310	Alarm Lini Niverplast - Transport System
6128	311	41	2026-10-06 14:00:56.558689	A311	Błąd Lini Niverplst - Transport System
6129	309	39	2026-10-06 14:01:56.729883	A309	Błąd Lini Niverplst - Easy Plast
6130	310	41	2026-10-06 14:01:56.729883	A310	Alarm Lini Niverplast - Transport System
6131	311	41	2026-10-06 14:01:56.729883	A311	Błąd Lini Niverplst - Transport System
6132	309	39	2026-10-06 14:02:56.885948	A309	Błąd Lini Niverplst - Easy Plast
6133	310	41	2026-10-06 14:02:56.885948	A310	Alarm Lini Niverplast - Transport System
6134	311	41	2026-10-06 14:02:56.885948	A311	Błąd Lini Niverplst - Transport System
6135	309	39	2026-10-06 14:03:57.031686	A309	Błąd Lini Niverplst - Easy Plast
6136	310	41	2026-10-06 14:03:57.031686	A310	Alarm Lini Niverplast - Transport System
6137	311	41	2026-10-06 14:03:57.031686	A311	Błąd Lini Niverplst - Transport System
6138	309	39	2026-10-06 14:04:57.18069	A309	Błąd Lini Niverplst - Easy Plast
6139	310	41	2026-10-06 14:04:57.18069	A310	Alarm Lini Niverplast - Transport System
6140	311	41	2026-10-06 14:04:57.18069	A311	Błąd Lini Niverplst - Transport System
6141	309	39	2026-10-06 14:05:57.350199	A309	Błąd Lini Niverplst - Easy Plast
6142	310	41	2026-10-06 14:05:57.350199	A310	Alarm Lini Niverplast - Transport System
6143	311	41	2026-10-06 14:05:57.350199	A311	Błąd Lini Niverplst - Transport System
6144	309	39	2026-10-06 14:06:57.488893	A309	Błąd Lini Niverplst - Easy Plast
6145	310	41	2026-10-06 14:06:57.488893	A310	Alarm Lini Niverplast - Transport System
6146	311	41	2026-10-06 14:06:57.488893	A311	Błąd Lini Niverplst - Transport System
6147	309	39	2026-10-06 14:07:57.641001	A309	Błąd Lini Niverplst - Easy Plast
6148	310	41	2026-10-06 14:07:57.641001	A310	Alarm Lini Niverplast - Transport System
6149	311	41	2026-10-06 14:07:57.641001	A311	Błąd Lini Niverplst - Transport System
6150	309	39	2026-10-06 14:08:57.785182	A309	Błąd Lini Niverplst - Easy Plast
6151	310	41	2026-10-06 14:08:57.785182	A310	Alarm Lini Niverplast - Transport System
6152	311	41	2026-10-06 14:08:57.785182	A311	Błąd Lini Niverplst - Transport System
6153	309	39	2026-10-06 14:09:57.920577	A309	Błąd Lini Niverplst - Easy Plast
6154	310	41	2026-10-06 14:09:57.920577	A310	Alarm Lini Niverplast - Transport System
6155	311	41	2026-10-06 14:09:57.920577	A311	Błąd Lini Niverplst - Transport System
6156	309	39	2026-10-06 14:10:58.090227	A309	Błąd Lini Niverplst - Easy Plast
6157	310	41	2026-10-06 14:10:58.090227	A310	Alarm Lini Niverplast - Transport System
6158	311	41	2026-10-06 14:10:58.090227	A311	Błąd Lini Niverplst - Transport System
6159	309	39	2026-10-06 14:11:56.993833	A309	Błąd Lini Niverplst - Easy Plast
6160	310	41	2026-10-06 14:11:56.993833	A310	Alarm Lini Niverplast - Transport System
6161	311	41	2026-10-06 14:11:56.993833	A311	Błąd Lini Niverplst - Transport System
6162	309	39	2026-10-06 14:12:57.158338	A309	Błąd Lini Niverplst - Easy Plast
6163	310	41	2026-10-06 14:12:57.158338	A310	Alarm Lini Niverplast - Transport System
6164	311	41	2026-10-06 14:12:57.158338	A311	Błąd Lini Niverplst - Transport System
6165	309	39	2026-10-06 14:13:57.299538	A309	Błąd Lini Niverplst - Easy Plast
6166	310	41	2026-10-06 14:13:57.299538	A310	Alarm Lini Niverplast - Transport System
6167	311	41	2026-10-06 14:13:57.299538	A311	Błąd Lini Niverplst - Transport System
6168	309	39	2026-10-06 14:14:57.478497	A309	Błąd Lini Niverplst - Easy Plast
6169	310	41	2026-10-06 14:14:57.478497	A310	Alarm Lini Niverplast - Transport System
6170	311	41	2026-10-06 14:14:57.478497	A311	Błąd Lini Niverplst - Transport System
6171	309	39	2026-10-06 14:15:57.614251	A309	Błąd Lini Niverplst - Easy Plast
6172	310	41	2026-10-06 14:15:57.614251	A310	Alarm Lini Niverplast - Transport System
6173	311	41	2026-10-06 14:15:57.614251	A311	Błąd Lini Niverplst - Transport System
6174	309	39	2026-10-06 14:16:57.778605	A309	Błąd Lini Niverplst - Easy Plast
6175	310	41	2026-10-06 14:16:57.778605	A310	Alarm Lini Niverplast - Transport System
6176	311	41	2026-10-06 14:16:57.778605	A311	Błąd Lini Niverplst - Transport System
6177	309	39	2026-10-06 14:17:57.906901	A309	Błąd Lini Niverplst - Easy Plast
6178	310	41	2026-10-06 14:17:57.906901	A310	Alarm Lini Niverplast - Transport System
6179	311	41	2026-10-06 14:17:57.906901	A311	Błąd Lini Niverplst - Transport System
6180	309	39	2026-10-06 14:18:58.080842	A309	Błąd Lini Niverplst - Easy Plast
6181	310	41	2026-10-06 14:18:58.080842	A310	Alarm Lini Niverplast - Transport System
6182	311	41	2026-10-06 14:18:58.080842	A311	Błąd Lini Niverplst - Transport System
6183	309	39	2026-10-06 14:19:58.216148	A309	Błąd Lini Niverplst - Easy Plast
6184	310	41	2026-10-06 14:19:58.216148	A310	Alarm Lini Niverplast - Transport System
6185	311	41	2026-10-06 14:19:58.216148	A311	Błąd Lini Niverplst - Transport System
6186	309	39	2026-10-06 14:20:58.475996	A309	Błąd Lini Niverplst - Easy Plast
6187	310	41	2026-10-06 14:20:58.475996	A310	Alarm Lini Niverplast - Transport System
6188	311	41	2026-10-06 14:20:58.475996	A311	Błąd Lini Niverplst - Transport System
6189	309	39	2026-10-06 14:21:58.550618	A309	Błąd Lini Niverplst - Easy Plast
6190	310	41	2026-10-06 14:21:58.550618	A310	Alarm Lini Niverplast - Transport System
6191	311	41	2026-10-06 14:21:58.550618	A311	Błąd Lini Niverplst - Transport System
6192	309	39	2026-10-06 14:22:58.699741	A309	Błąd Lini Niverplst - Easy Plast
6193	310	41	2026-10-06 14:22:58.699741	A310	Alarm Lini Niverplast - Transport System
6194	311	41	2026-10-06 14:22:58.699741	A311	Błąd Lini Niverplst - Transport System
6195	309	39	2026-10-06 14:23:58.828531	A309	Błąd Lini Niverplst - Easy Plast
6196	310	41	2026-10-06 14:23:58.828531	A310	Alarm Lini Niverplast - Transport System
6197	311	41	2026-10-06 14:23:58.828531	A311	Błąd Lini Niverplst - Transport System
6198	309	39	2026-10-06 14:24:57.732623	A309	Błąd Lini Niverplst - Easy Plast
6199	310	41	2026-10-06 14:24:57.732623	A310	Alarm Lini Niverplast - Transport System
6200	311	41	2026-10-06 14:24:57.732623	A311	Błąd Lini Niverplst - Transport System
6201	309	39	2026-10-06 14:25:58.52453	A309	Błąd Lini Niverplst - Easy Plast
6202	310	41	2026-10-06 14:25:58.52453	A310	Alarm Lini Niverplast - Transport System
6203	311	41	2026-10-06 14:25:58.52453	A311	Błąd Lini Niverplst - Transport System
6204	309	39	2026-10-06 14:26:58.036774	A309	Błąd Lini Niverplst - Easy Plast
6205	310	41	2026-10-06 14:26:58.036774	A310	Alarm Lini Niverplast - Transport System
6206	311	41	2026-10-06 14:26:58.036774	A311	Błąd Lini Niverplst - Transport System
6207	309	39	2026-10-06 14:27:58.208719	A309	Błąd Lini Niverplst - Easy Plast
6208	310	41	2026-10-06 14:27:58.208719	A310	Alarm Lini Niverplast - Transport System
6209	311	41	2026-10-06 14:27:58.208719	A311	Błąd Lini Niverplst - Transport System
6210	309	39	2026-10-06 14:28:58.355971	A309	Błąd Lini Niverplst - Easy Plast
6211	310	41	2026-10-06 14:28:58.355971	A310	Alarm Lini Niverplast - Transport System
6212	311	41	2026-10-06 14:28:58.355971	A311	Błąd Lini Niverplst - Transport System
6213	309	39	2026-10-06 14:29:58.535151	A309	Błąd Lini Niverplst - Easy Plast
6214	310	41	2026-10-06 14:29:58.535151	A310	Alarm Lini Niverplast - Transport System
6215	311	41	2026-10-06 14:29:58.535151	A311	Błąd Lini Niverplst - Transport System
6216	309	39	2026-10-06 14:30:58.664732	A309	Błąd Lini Niverplst - Easy Plast
6217	310	41	2026-10-06 14:30:58.664732	A310	Alarm Lini Niverplast - Transport System
6218	311	41	2026-10-06 14:30:58.664732	A311	Błąd Lini Niverplst - Transport System
6219	309	39	2026-10-06 14:31:58.826803	A309	Błąd Lini Niverplst - Easy Plast
6220	310	41	2026-10-06 14:31:58.826803	A310	Alarm Lini Niverplast - Transport System
6221	311	41	2026-10-06 14:31:58.826803	A311	Błąd Lini Niverplst - Transport System
6222	309	39	2026-10-06 14:32:58.992522	A309	Błąd Lini Niverplst - Easy Plast
6223	310	41	2026-10-06 14:32:58.992522	A310	Alarm Lini Niverplast - Transport System
6224	311	41	2026-10-06 14:32:58.992522	A311	Błąd Lini Niverplst - Transport System
6225	309	39	2026-10-06 14:33:59.123788	A309	Błąd Lini Niverplst - Easy Plast
6226	310	41	2026-10-06 14:33:59.123788	A310	Alarm Lini Niverplast - Transport System
6227	311	41	2026-10-06 14:33:59.123788	A311	Błąd Lini Niverplst - Transport System
6228	309	39	2026-10-06 14:34:59.296585	A309	Błąd Lini Niverplst - Easy Plast
6229	310	41	2026-10-06 14:34:59.296585	A310	Alarm Lini Niverplast - Transport System
6230	311	41	2026-10-06 14:34:59.296585	A311	Błąd Lini Niverplst - Transport System
6231	309	39	2026-10-06 14:35:59.43311	A309	Błąd Lini Niverplst - Easy Plast
6232	310	41	2026-10-06 14:35:59.43311	A310	Alarm Lini Niverplast - Transport System
6233	311	41	2026-10-06 14:35:59.43311	A311	Błąd Lini Niverplst - Transport System
6234	309	39	2026-10-06 14:36:59.585936	A309	Błąd Lini Niverplst - Easy Plast
6235	310	41	2026-10-06 14:36:59.585936	A310	Alarm Lini Niverplast - Transport System
6236	311	41	2026-10-06 14:36:59.585936	A311	Błąd Lini Niverplst - Transport System
6237	309	39	2026-10-06 14:37:58.504764	A309	Błąd Lini Niverplst - Easy Plast
6238	310	41	2026-10-06 14:37:58.504764	A310	Alarm Lini Niverplast - Transport System
6239	311	41	2026-10-06 14:37:58.504764	A311	Błąd Lini Niverplst - Transport System
6240	309	39	2026-10-06 14:38:58.682056	A309	Błąd Lini Niverplst - Easy Plast
6241	310	41	2026-10-06 14:38:58.682056	A310	Alarm Lini Niverplast - Transport System
6242	311	41	2026-10-06 14:38:58.682056	A311	Błąd Lini Niverplst - Transport System
6243	309	39	2026-10-06 14:39:58.811296	A309	Błąd Lini Niverplst - Easy Plast
6244	310	41	2026-10-06 14:39:58.811296	A310	Alarm Lini Niverplast - Transport System
6245	311	41	2026-10-06 14:39:58.811296	A311	Błąd Lini Niverplst - Transport System
6246	309	39	2026-10-06 14:40:58.973574	A309	Błąd Lini Niverplst - Easy Plast
6247	310	41	2026-10-06 14:40:58.973574	A310	Alarm Lini Niverplast - Transport System
6248	311	41	2026-10-06 14:40:58.973574	A311	Błąd Lini Niverplst - Transport System
6249	309	39	2026-10-06 14:41:59.111066	A309	Błąd Lini Niverplst - Easy Plast
6250	310	41	2026-10-06 14:41:59.111066	A310	Alarm Lini Niverplast - Transport System
6251	311	41	2026-10-06 14:41:59.111066	A311	Błąd Lini Niverplst - Transport System
6252	309	39	2026-10-06 14:42:59.296859	A309	Błąd Lini Niverplst - Easy Plast
6253	310	41	2026-10-06 14:42:59.296859	A310	Alarm Lini Niverplast - Transport System
6254	311	41	2026-10-06 14:42:59.296859	A311	Błąd Lini Niverplst - Transport System
6255	309	39	2026-10-06 14:43:59.437058	A309	Błąd Lini Niverplst - Easy Plast
6256	310	41	2026-10-06 14:43:59.437058	A310	Alarm Lini Niverplast - Transport System
6257	311	41	2026-10-06 14:43:59.437058	A311	Błąd Lini Niverplst - Transport System
6258	309	39	2026-10-06 14:44:59.578292	A309	Błąd Lini Niverplst - Easy Plast
6259	310	41	2026-10-06 14:44:59.578292	A310	Alarm Lini Niverplast - Transport System
6260	311	41	2026-10-06 14:44:59.578292	A311	Błąd Lini Niverplst - Transport System
6261	309	39	2026-10-06 14:45:59.739835	A309	Błąd Lini Niverplst - Easy Plast
6262	310	41	2026-10-06 14:45:59.739835	A310	Alarm Lini Niverplast - Transport System
6263	311	41	2026-10-06 14:45:59.739835	A311	Błąd Lini Niverplst - Transport System
6264	309	39	2026-10-06 14:46:59.90692	A309	Błąd Lini Niverplst - Easy Plast
6265	310	41	2026-10-06 14:46:59.90692	A310	Alarm Lini Niverplast - Transport System
6266	311	41	2026-10-06 14:46:59.90692	A311	Błąd Lini Niverplst - Transport System
6267	309	39	2026-10-06 14:48:00.060686	A309	Błąd Lini Niverplst - Easy Plast
6268	310	41	2026-10-06 14:48:00.060686	A310	Alarm Lini Niverplast - Transport System
6269	311	41	2026-10-06 14:48:00.060686	A311	Błąd Lini Niverplst - Transport System
6270	309	39	2026-10-06 14:49:00.215948	A309	Błąd Lini Niverplst - Easy Plast
6271	310	41	2026-10-06 14:49:00.215948	A310	Alarm Lini Niverplast - Transport System
6272	311	41	2026-10-06 14:49:00.215948	A311	Błąd Lini Niverplst - Transport System
6273	309	39	2026-10-06 14:50:00.351848	A309	Błąd Lini Niverplst - Easy Plast
6274	310	41	2026-10-06 14:50:00.351848	A310	Alarm Lini Niverplast - Transport System
6275	311	41	2026-10-06 14:50:00.351848	A311	Błąd Lini Niverplst - Transport System
6276	309	39	2026-10-06 14:50:59.265374	A309	Błąd Lini Niverplst - Easy Plast
6277	310	41	2026-10-06 14:50:59.265374	A310	Alarm Lini Niverplast - Transport System
6278	311	41	2026-10-06 14:50:59.265374	A311	Błąd Lini Niverplst - Transport System
6279	309	39	2026-10-06 14:51:59.409496	A309	Błąd Lini Niverplst - Easy Plast
6280	310	41	2026-10-06 14:51:59.409496	A310	Alarm Lini Niverplast - Transport System
6281	311	41	2026-10-06 14:51:59.409496	A311	Błąd Lini Niverplst - Transport System
6282	309	39	2026-10-06 14:52:59.581668	A309	Błąd Lini Niverplst - Easy Plast
6283	310	41	2026-10-06 14:52:59.581668	A310	Alarm Lini Niverplast - Transport System
6284	311	41	2026-10-06 14:52:59.581668	A311	Błąd Lini Niverplst - Transport System
6285	309	39	2026-10-06 14:53:59.722233	A309	Błąd Lini Niverplst - Easy Plast
6286	310	41	2026-10-06 14:53:59.722233	A310	Alarm Lini Niverplast - Transport System
6287	311	41	2026-10-06 14:53:59.722233	A311	Błąd Lini Niverplst - Transport System
6288	309	39	2026-10-06 14:54:59.888384	A309	Błąd Lini Niverplst - Easy Plast
6289	310	41	2026-10-06 14:54:59.888384	A310	Alarm Lini Niverplast - Transport System
6290	311	41	2026-10-06 14:54:59.888384	A311	Błąd Lini Niverplst - Transport System
6291	309	39	2026-10-06 14:56:00.051014	A309	Błąd Lini Niverplst - Easy Plast
6292	310	41	2026-10-06 14:56:00.051014	A310	Alarm Lini Niverplast - Transport System
6293	311	41	2026-10-06 14:56:00.051014	A311	Błąd Lini Niverplst - Transport System
6294	309	39	2026-10-06 14:57:00.211736	A309	Błąd Lini Niverplst - Easy Plast
6295	310	41	2026-10-06 14:57:00.211736	A310	Alarm Lini Niverplast - Transport System
6296	311	41	2026-10-06 14:57:00.211736	A311	Błąd Lini Niverplst - Transport System
6297	309	39	2026-10-06 14:58:00.368209	A309	Błąd Lini Niverplst - Easy Plast
6298	310	41	2026-10-06 14:58:00.368209	A310	Alarm Lini Niverplast - Transport System
6299	311	41	2026-10-06 14:58:00.368209	A311	Błąd Lini Niverplst - Transport System
6300	309	39	2026-10-06 14:59:00.530749	A309	Błąd Lini Niverplst - Easy Plast
6301	310	41	2026-10-06 14:59:00.530749	A310	Alarm Lini Niverplast - Transport System
6302	311	41	2026-10-06 14:59:00.530749	A311	Błąd Lini Niverplst - Transport System
6303	309	39	2026-10-06 15:00:00.678458	A309	Błąd Lini Niverplst - Easy Plast
6304	310	41	2026-10-06 15:00:00.678458	A310	Alarm Lini Niverplast - Transport System
6305	311	41	2026-10-06 15:00:00.678458	A311	Błąd Lini Niverplst - Transport System
6306	309	39	2026-10-06 15:01:00.830815	A309	Błąd Lini Niverplst - Easy Plast
6307	310	41	2026-10-06 15:01:00.830815	A310	Alarm Lini Niverplast - Transport System
6308	311	41	2026-10-06 15:01:00.830815	A311	Błąd Lini Niverplst - Transport System
6309	309	39	2026-10-06 15:02:00.99474	A309	Błąd Lini Niverplst - Easy Plast
6310	310	41	2026-10-06 15:02:00.99474	A310	Alarm Lini Niverplast - Transport System
6311	311	41	2026-10-06 15:02:00.99474	A311	Błąd Lini Niverplst - Transport System
6312	309	39	2026-10-06 15:02:59.885105	A309	Błąd Lini Niverplst - Easy Plast
6313	310	41	2026-10-06 15:02:59.885105	A310	Alarm Lini Niverplast - Transport System
6314	311	41	2026-10-06 15:02:59.885105	A311	Błąd Lini Niverplst - Transport System
6315	309	39	2026-10-06 15:04:00.061714	A309	Błąd Lini Niverplst - Easy Plast
6316	310	41	2026-10-06 15:04:00.061714	A310	Alarm Lini Niverplast - Transport System
6317	311	41	2026-10-06 15:04:00.061714	A311	Błąd Lini Niverplst - Transport System
6318	309	39	2026-10-06 15:05:00.174745	A309	Błąd Lini Niverplst - Easy Plast
6319	310	41	2026-10-06 15:05:00.174745	A310	Alarm Lini Niverplast - Transport System
6320	311	41	2026-10-06 15:05:00.174745	A311	Błąd Lini Niverplst - Transport System
6321	309	39	2026-10-06 15:06:00.375893	A309	Błąd Lini Niverplst - Easy Plast
6322	310	41	2026-10-06 15:06:00.375893	A310	Alarm Lini Niverplast - Transport System
6323	311	41	2026-10-06 15:06:00.375893	A311	Błąd Lini Niverplst - Transport System
6324	309	39	2026-10-06 15:07:00.521184	A309	Błąd Lini Niverplst - Easy Plast
6325	310	41	2026-10-06 15:07:00.521184	A310	Alarm Lini Niverplast - Transport System
6326	311	41	2026-10-06 15:07:00.521184	A311	Błąd Lini Niverplst - Transport System
6327	309	39	2026-10-06 15:08:00.678336	A309	Błąd Lini Niverplst - Easy Plast
6328	310	41	2026-10-06 15:08:00.678336	A310	Alarm Lini Niverplast - Transport System
6329	311	41	2026-10-06 15:08:00.678336	A311	Błąd Lini Niverplst - Transport System
6330	309	39	2026-10-06 15:09:00.839902	A309	Błąd Lini Niverplst - Easy Plast
6331	310	41	2026-10-06 15:09:00.839902	A310	Alarm Lini Niverplast - Transport System
6332	311	41	2026-10-06 15:09:00.839902	A311	Błąd Lini Niverplst - Transport System
6333	309	39	2026-10-06 15:10:01.014021	A309	Błąd Lini Niverplst - Easy Plast
6334	310	41	2026-10-06 15:10:01.014021	A310	Alarm Lini Niverplast - Transport System
6335	311	41	2026-10-06 15:10:01.014021	A311	Błąd Lini Niverplst - Transport System
6336	309	39	2026-10-06 15:11:01.155332	A309	Błąd Lini Niverplst - Easy Plast
6337	310	41	2026-10-06 15:11:01.155332	A310	Alarm Lini Niverplast - Transport System
6338	311	41	2026-10-06 15:11:01.155332	A311	Błąd Lini Niverplst - Transport System
6339	309	39	2026-10-06 15:12:01.414009	A309	Błąd Lini Niverplst - Easy Plast
6340	310	41	2026-10-06 15:12:01.414009	A310	Alarm Lini Niverplast - Transport System
6341	311	41	2026-10-06 15:12:01.414009	A311	Błąd Lini Niverplst - Transport System
6342	309	39	2026-10-06 15:13:01.46257	A309	Błąd Lini Niverplst - Easy Plast
6343	310	41	2026-10-06 15:13:01.46257	A310	Alarm Lini Niverplast - Transport System
6344	311	41	2026-10-06 15:13:01.46257	A311	Błąd Lini Niverplst - Transport System
6345	309	39	2026-10-06 15:14:01.628574	A309	Błąd Lini Niverplst - Easy Plast
6346	310	41	2026-10-06 15:14:01.628574	A310	Alarm Lini Niverplast - Transport System
6347	311	41	2026-10-06 15:14:01.628574	A311	Błąd Lini Niverplst - Transport System
6348	309	39	2026-10-06 15:15:01.792998	A309	Błąd Lini Niverplst - Easy Plast
6349	310	41	2026-10-06 15:15:01.792998	A310	Alarm Lini Niverplast - Transport System
6350	311	41	2026-10-06 15:15:01.792998	A311	Błąd Lini Niverplst - Transport System
6351	309	39	2026-10-06 15:16:00.666592	A309	Błąd Lini Niverplst - Easy Plast
6352	310	41	2026-10-06 15:16:00.666592	A310	Alarm Lini Niverplast - Transport System
6353	311	41	2026-10-06 15:16:00.666592	A311	Błąd Lini Niverplst - Transport System
6354	309	39	2026-10-06 15:17:00.836749	A309	Błąd Lini Niverplst - Easy Plast
6355	310	41	2026-10-06 15:17:00.836749	A310	Alarm Lini Niverplast - Transport System
6356	311	41	2026-10-06 15:17:00.836749	A311	Błąd Lini Niverplst - Transport System
6357	309	39	2026-10-06 15:18:00.967913	A309	Błąd Lini Niverplst - Easy Plast
6358	310	41	2026-10-06 15:18:00.967913	A310	Alarm Lini Niverplast - Transport System
6359	311	41	2026-10-06 15:18:00.967913	A311	Błąd Lini Niverplst - Transport System
6360	309	39	2026-10-06 15:19:01.160699	A309	Błąd Lini Niverplst - Easy Plast
6361	310	41	2026-10-06 15:19:01.160699	A310	Alarm Lini Niverplast - Transport System
6362	311	41	2026-10-06 15:19:01.160699	A311	Błąd Lini Niverplst - Transport System
6363	309	39	2026-10-06 15:20:01.305708	A309	Błąd Lini Niverplst - Easy Plast
6364	310	41	2026-10-06 15:20:01.305708	A310	Alarm Lini Niverplast - Transport System
6365	311	41	2026-10-06 15:20:01.305708	A311	Błąd Lini Niverplst - Transport System
6366	309	39	2026-10-06 15:21:01.471218	A309	Błąd Lini Niverplst - Easy Plast
6367	310	41	2026-10-06 15:21:01.471218	A310	Alarm Lini Niverplast - Transport System
6368	311	41	2026-10-06 15:21:01.471218	A311	Błąd Lini Niverplst - Transport System
6369	309	39	2026-10-06 15:22:01.620771	A309	Błąd Lini Niverplst - Easy Plast
6370	310	41	2026-10-06 15:22:01.620771	A310	Alarm Lini Niverplast - Transport System
6371	311	41	2026-10-06 15:22:01.620771	A311	Błąd Lini Niverplst - Transport System
6372	309	39	2026-10-06 15:23:01.787902	A309	Błąd Lini Niverplst - Easy Plast
6373	310	41	2026-10-06 15:23:01.787902	A310	Alarm Lini Niverplast - Transport System
6374	311	41	2026-10-06 15:23:01.787902	A311	Błąd Lini Niverplst - Transport System
6375	309	39	2026-10-06 15:24:01.942799	A309	Błąd Lini Niverplst - Easy Plast
6376	310	41	2026-10-06 15:24:01.942799	A310	Alarm Lini Niverplast - Transport System
6377	311	41	2026-10-06 15:24:01.942799	A311	Błąd Lini Niverplst - Transport System
6378	309	39	2026-10-06 15:25:02.109674	A309	Błąd Lini Niverplst - Easy Plast
6379	310	41	2026-10-06 15:25:02.109674	A310	Alarm Lini Niverplast - Transport System
6380	311	41	2026-10-06 15:25:02.109674	A311	Błąd Lini Niverplst - Transport System
6381	309	39	2026-10-06 15:26:02.265579	A309	Błąd Lini Niverplst - Easy Plast
6382	310	41	2026-10-06 15:26:02.265579	A310	Alarm Lini Niverplast - Transport System
6383	311	41	2026-10-06 15:26:02.265579	A311	Błąd Lini Niverplst - Transport System
6384	309	39	2026-10-06 15:27:02.429027	A309	Błąd Lini Niverplst - Easy Plast
6385	310	41	2026-10-06 15:27:02.429027	A310	Alarm Lini Niverplast - Transport System
6386	311	41	2026-10-06 15:27:02.429027	A311	Błąd Lini Niverplst - Transport System
6387	309	39	2026-10-06 15:28:01.636871	A309	Błąd Lini Niverplst - Easy Plast
6388	310	41	2026-10-06 15:28:01.636871	A310	Alarm Lini Niverplast - Transport System
6389	311	41	2026-10-06 15:28:01.636871	A311	Błąd Lini Niverplst - Transport System
6390	309	39	2026-10-06 15:29:01.483013	A309	Błąd Lini Niverplst - Easy Plast
6391	310	41	2026-10-06 15:29:01.483013	A310	Alarm Lini Niverplast - Transport System
6392	311	41	2026-10-06 15:29:01.483013	A311	Błąd Lini Niverplst - Transport System
6393	309	39	2026-10-06 15:30:01.522108	A309	Błąd Lini Niverplst - Easy Plast
6394	310	41	2026-10-06 15:30:01.522108	A310	Alarm Lini Niverplast - Transport System
6395	311	41	2026-10-06 15:30:01.522108	A311	Błąd Lini Niverplst - Transport System
6396	309	39	2026-10-06 15:31:01.789495	A309	Błąd Lini Niverplst - Easy Plast
6397	310	41	2026-10-06 15:31:01.789495	A310	Alarm Lini Niverplast - Transport System
6398	311	41	2026-10-06 15:31:01.789495	A311	Błąd Lini Niverplst - Transport System
6399	309	39	2026-10-06 15:32:01.966869	A309	Błąd Lini Niverplst - Easy Plast
6400	310	41	2026-10-06 15:32:01.966869	A310	Alarm Lini Niverplast - Transport System
6401	311	41	2026-10-06 15:32:01.966869	A311	Błąd Lini Niverplst - Transport System
6402	309	39	2026-10-06 15:33:02.146694	A309	Błąd Lini Niverplst - Easy Plast
6403	310	41	2026-10-06 15:33:02.146694	A310	Alarm Lini Niverplast - Transport System
6404	311	41	2026-10-06 15:33:02.146694	A311	Błąd Lini Niverplst - Transport System
6405	309	39	2026-10-06 15:34:02.324859	A309	Błąd Lini Niverplst - Easy Plast
6406	310	41	2026-10-06 15:34:02.324859	A310	Alarm Lini Niverplast - Transport System
6407	311	41	2026-10-06 15:34:02.324859	A311	Błąd Lini Niverplst - Transport System
6408	309	39	2026-10-06 15:35:02.503295	A309	Błąd Lini Niverplst - Easy Plast
6409	310	41	2026-10-06 15:35:02.503295	A310	Alarm Lini Niverplast - Transport System
6410	311	41	2026-10-06 15:35:02.503295	A311	Błąd Lini Niverplst - Transport System
6411	309	39	2026-10-06 15:36:02.643558	A309	Błąd Lini Niverplst - Easy Plast
6412	310	41	2026-10-06 15:36:02.643558	A310	Alarm Lini Niverplast - Transport System
6413	311	41	2026-10-06 15:36:02.643558	A311	Błąd Lini Niverplst - Transport System
6414	309	39	2026-10-06 15:37:02.81192	A309	Błąd Lini Niverplst - Easy Plast
6415	310	41	2026-10-06 15:37:02.81192	A310	Alarm Lini Niverplast - Transport System
6416	311	41	2026-10-06 15:37:02.81192	A311	Błąd Lini Niverplst - Transport System
6417	309	39	2026-10-06 15:38:02.993482	A309	Błąd Lini Niverplst - Easy Plast
6418	310	41	2026-10-06 15:38:02.993482	A310	Alarm Lini Niverplast - Transport System
6419	311	41	2026-10-06 15:38:02.993482	A311	Błąd Lini Niverplst - Transport System
6420	309	39	2026-10-06 15:39:03.15787	A309	Błąd Lini Niverplst - Easy Plast
6421	310	41	2026-10-06 15:39:03.15787	A310	Alarm Lini Niverplast - Transport System
6422	311	41	2026-10-06 15:39:03.15787	A311	Błąd Lini Niverplst - Transport System
6423	309	39	2026-10-06 15:40:01.996724	A309	Błąd Lini Niverplst - Easy Plast
6424	310	41	2026-10-06 15:40:01.996724	A310	Alarm Lini Niverplast - Transport System
6425	311	41	2026-10-06 15:40:01.996724	A311	Błąd Lini Niverplst - Transport System
6426	309	39	2026-10-06 15:41:02.185638	A309	Błąd Lini Niverplst - Easy Plast
6427	310	41	2026-10-06 15:41:02.185638	A310	Alarm Lini Niverplast - Transport System
6428	311	41	2026-10-06 15:41:02.185638	A311	Błąd Lini Niverplst - Transport System
6429	309	39	2026-10-06 15:42:02.333347	A309	Błąd Lini Niverplst - Easy Plast
6430	310	41	2026-10-06 15:42:02.333347	A310	Alarm Lini Niverplast - Transport System
6431	311	41	2026-10-06 15:42:02.333347	A311	Błąd Lini Niverplst - Transport System
6432	309	39	2026-10-06 15:43:02.524569	A309	Błąd Lini Niverplst - Easy Plast
6433	310	41	2026-10-06 15:43:02.524569	A310	Alarm Lini Niverplast - Transport System
6434	311	41	2026-10-06 15:43:02.524569	A311	Błąd Lini Niverplst - Transport System
6435	309	39	2026-10-06 15:44:02.672931	A309	Błąd Lini Niverplst - Easy Plast
6436	310	41	2026-10-06 15:44:02.672931	A310	Alarm Lini Niverplast - Transport System
6437	311	41	2026-10-06 15:44:02.672931	A311	Błąd Lini Niverplst - Transport System
6438	309	39	2026-10-06 15:45:02.861239	A309	Błąd Lini Niverplst - Easy Plast
6439	310	41	2026-10-06 15:45:02.861239	A310	Alarm Lini Niverplast - Transport System
6440	311	41	2026-10-06 15:45:02.861239	A311	Błąd Lini Niverplst - Transport System
6441	309	39	2026-10-06 15:46:03.015675	A309	Błąd Lini Niverplst - Easy Plast
6442	310	41	2026-10-06 15:46:03.015675	A310	Alarm Lini Niverplast - Transport System
6443	311	41	2026-10-06 15:46:03.015675	A311	Błąd Lini Niverplst - Transport System
6444	309	39	2026-10-06 15:47:03.187167	A309	Błąd Lini Niverplst - Easy Plast
6445	310	41	2026-10-06 15:47:03.187167	A310	Alarm Lini Niverplast - Transport System
6446	311	41	2026-10-06 15:47:03.187167	A311	Błąd Lini Niverplst - Transport System
6447	309	39	2026-10-06 15:48:03.36828	A309	Błąd Lini Niverplst - Easy Plast
6448	310	41	2026-10-06 15:48:03.36828	A310	Alarm Lini Niverplast - Transport System
6449	311	41	2026-10-06 15:48:03.36828	A311	Błąd Lini Niverplst - Transport System
6450	309	39	2026-10-06 15:49:03.520296	A309	Błąd Lini Niverplst - Easy Plast
6451	310	41	2026-10-06 15:49:03.520296	A310	Alarm Lini Niverplast - Transport System
6452	311	41	2026-10-06 15:49:03.520296	A311	Błąd Lini Niverplst - Transport System
6453	309	39	2026-10-06 15:50:03.692663	A309	Błąd Lini Niverplst - Easy Plast
6454	310	41	2026-10-06 15:50:03.692663	A310	Alarm Lini Niverplast - Transport System
6455	311	41	2026-10-06 15:50:03.692663	A311	Błąd Lini Niverplst - Transport System
6456	309	39	2026-10-06 15:51:03.847056	A309	Błąd Lini Niverplst - Easy Plast
6457	310	41	2026-10-06 15:51:03.847056	A310	Alarm Lini Niverplast - Transport System
6458	311	41	2026-10-06 15:51:03.847056	A311	Błąd Lini Niverplst - Transport System
6459	309	39	2026-10-06 15:52:02.72322	A309	Błąd Lini Niverplst - Easy Plast
6460	310	41	2026-10-06 15:52:02.72322	A310	Alarm Lini Niverplast - Transport System
6461	311	41	2026-10-06 15:52:02.72322	A311	Błąd Lini Niverplst - Transport System
6462	309	39	2026-10-06 15:53:02.871435	A309	Błąd Lini Niverplst - Easy Plast
6463	310	41	2026-10-06 15:53:02.871435	A310	Alarm Lini Niverplast - Transport System
6464	311	41	2026-10-06 15:53:02.871435	A311	Błąd Lini Niverplst - Transport System
6465	309	39	2026-10-06 15:54:02.989004	A309	Błąd Lini Niverplst - Easy Plast
6466	310	41	2026-10-06 15:54:02.989004	A310	Alarm Lini Niverplast - Transport System
6467	311	41	2026-10-06 15:54:02.989004	A311	Błąd Lini Niverplst - Transport System
6468	309	39	2026-10-06 15:55:03.219621	A309	Błąd Lini Niverplst - Easy Plast
6469	310	41	2026-10-06 15:55:03.219621	A310	Alarm Lini Niverplast - Transport System
6470	311	41	2026-10-06 15:55:03.219621	A311	Błąd Lini Niverplst - Transport System
6471	309	39	2026-10-06 15:56:03.36646	A309	Błąd Lini Niverplst - Easy Plast
6472	310	41	2026-10-06 15:56:03.36646	A310	Alarm Lini Niverplast - Transport System
6473	311	41	2026-10-06 15:56:03.36646	A311	Błąd Lini Niverplst - Transport System
6474	309	39	2026-10-06 15:57:03.55236	A309	Błąd Lini Niverplst - Easy Plast
6475	310	41	2026-10-06 15:57:03.55236	A310	Alarm Lini Niverplast - Transport System
6476	311	41	2026-10-06 15:57:03.55236	A311	Błąd Lini Niverplst - Transport System
6477	309	39	2026-10-06 15:58:03.711375	A309	Błąd Lini Niverplst - Easy Plast
6478	310	41	2026-10-06 15:58:03.711375	A310	Alarm Lini Niverplast - Transport System
6479	311	41	2026-10-06 15:58:03.711375	A311	Błąd Lini Niverplst - Transport System
6480	309	39	2026-10-06 15:59:03.890255	A309	Błąd Lini Niverplst - Easy Plast
6481	310	41	2026-10-06 15:59:03.890255	A310	Alarm Lini Niverplast - Transport System
6482	311	41	2026-10-06 15:59:03.890255	A311	Błąd Lini Niverplst - Transport System
6483	309	39	2026-10-06 16:00:04.048973	A309	Błąd Lini Niverplst - Easy Plast
6484	310	41	2026-10-06 16:00:04.048973	A310	Alarm Lini Niverplast - Transport System
6485	311	41	2026-10-06 16:00:04.048973	A311	Błąd Lini Niverplst - Transport System
6486	309	39	2026-10-06 16:01:04.245338	A309	Błąd Lini Niverplst - Easy Plast
6487	310	41	2026-10-06 16:01:04.245338	A310	Alarm Lini Niverplast - Transport System
6488	311	41	2026-10-06 16:01:04.245338	A311	Błąd Lini Niverplst - Transport System
6489	309	39	2026-10-06 16:02:04.388102	A309	Błąd Lini Niverplst - Easy Plast
6490	310	41	2026-10-06 16:02:04.388102	A310	Alarm Lini Niverplast - Transport System
6491	311	41	2026-10-06 16:02:04.388102	A311	Błąd Lini Niverplst - Transport System
6492	309	39	2026-10-06 16:03:04.566208	A309	Błąd Lini Niverplst - Easy Plast
6493	310	41	2026-10-06 16:03:04.566208	A310	Alarm Lini Niverplast - Transport System
6494	311	41	2026-10-06 16:03:04.566208	A311	Błąd Lini Niverplst - Transport System
6495	309	39	2026-10-06 16:04:03.406824	A309	Błąd Lini Niverplst - Easy Plast
6496	310	41	2026-10-06 16:04:03.406824	A310	Alarm Lini Niverplast - Transport System
6497	311	41	2026-10-06 16:04:03.406824	A311	Błąd Lini Niverplst - Transport System
6498	309	39	2026-10-06 16:05:03.548946	A309	Błąd Lini Niverplst - Easy Plast
6499	310	41	2026-10-06 16:05:03.548946	A310	Alarm Lini Niverplast - Transport System
6500	311	41	2026-10-06 16:05:03.548946	A311	Błąd Lini Niverplst - Transport System
6501	309	39	2026-10-06 16:06:03.739047	A309	Błąd Lini Niverplst - Easy Plast
6502	310	41	2026-10-06 16:06:03.739047	A310	Alarm Lini Niverplast - Transport System
6503	311	41	2026-10-06 16:06:03.739047	A311	Błąd Lini Niverplst - Transport System
6504	309	39	2026-10-06 16:07:03.903515	A309	Błąd Lini Niverplst - Easy Plast
6505	310	41	2026-10-06 16:07:03.903515	A310	Alarm Lini Niverplast - Transport System
6506	311	41	2026-10-06 16:07:03.903515	A311	Błąd Lini Niverplst - Transport System
6507	309	39	2026-10-06 16:08:04.085232	A309	Błąd Lini Niverplst - Easy Plast
6508	310	41	2026-10-06 16:08:04.085232	A310	Alarm Lini Niverplast - Transport System
6509	311	41	2026-10-06 16:08:04.085232	A311	Błąd Lini Niverplst - Transport System
6510	309	39	2026-10-06 16:09:04.231748	A309	Błąd Lini Niverplst - Easy Plast
6511	310	41	2026-10-06 16:09:04.231748	A310	Alarm Lini Niverplast - Transport System
6512	311	41	2026-10-06 16:09:04.231748	A311	Błąd Lini Niverplst - Transport System
6513	309	39	2026-10-06 16:10:04.431623	A309	Błąd Lini Niverplst - Easy Plast
6514	310	41	2026-10-06 16:10:04.431623	A310	Alarm Lini Niverplast - Transport System
6515	311	41	2026-10-06 16:10:04.431623	A311	Błąd Lini Niverplst - Transport System
6516	309	39	2026-10-06 16:11:04.593406	A309	Błąd Lini Niverplst - Easy Plast
6517	310	41	2026-10-06 16:11:04.593406	A310	Alarm Lini Niverplast - Transport System
6518	311	41	2026-10-06 16:11:04.593406	A311	Błąd Lini Niverplst - Transport System
6519	309	39	2026-10-06 16:12:04.76265	A309	Błąd Lini Niverplst - Easy Plast
6520	310	41	2026-10-06 16:12:04.76265	A310	Alarm Lini Niverplast - Transport System
6521	311	41	2026-10-06 16:12:04.76265	A311	Błąd Lini Niverplst - Transport System
6522	309	39	2026-10-06 16:13:04.923802	A309	Błąd Lini Niverplst - Easy Plast
6523	310	41	2026-10-06 16:13:04.923802	A310	Alarm Lini Niverplast - Transport System
6524	311	41	2026-10-06 16:13:04.923802	A311	Błąd Lini Niverplst - Transport System
6525	309	39	2026-10-06 16:14:05.095511	A309	Błąd Lini Niverplst - Easy Plast
6526	310	41	2026-10-06 16:14:05.095511	A310	Alarm Lini Niverplast - Transport System
6527	311	41	2026-10-06 16:14:05.095511	A311	Błąd Lini Niverplst - Transport System
6528	309	39	2026-10-06 16:15:05.263864	A309	Błąd Lini Niverplst - Easy Plast
6529	310	41	2026-10-06 16:15:05.263864	A310	Alarm Lini Niverplast - Transport System
6530	311	41	2026-10-06 16:15:05.263864	A311	Błąd Lini Niverplst - Transport System
6531	309	39	2026-10-06 16:16:04.06885	A309	Błąd Lini Niverplst - Easy Plast
6532	310	41	2026-10-06 16:16:04.06885	A310	Alarm Lini Niverplast - Transport System
6533	311	41	2026-10-06 16:16:04.06885	A311	Błąd Lini Niverplst - Transport System
6534	309	39	2026-10-06 16:17:04.271231	A309	Błąd Lini Niverplst - Easy Plast
6535	310	41	2026-10-06 16:17:04.271231	A310	Alarm Lini Niverplast - Transport System
6536	311	41	2026-10-06 16:17:04.271231	A311	Błąd Lini Niverplst - Transport System
6537	309	39	2026-10-06 16:18:04.421926	A309	Błąd Lini Niverplst - Easy Plast
6538	310	41	2026-10-06 16:18:04.421926	A310	Alarm Lini Niverplast - Transport System
6539	311	41	2026-10-06 16:18:04.421926	A311	Błąd Lini Niverplst - Transport System
6540	309	39	2026-10-06 16:19:04.585641	A309	Błąd Lini Niverplst - Easy Plast
6541	310	41	2026-10-06 16:19:04.585641	A310	Alarm Lini Niverplast - Transport System
6542	311	41	2026-10-06 16:19:04.585641	A311	Błąd Lini Niverplst - Transport System
6543	309	39	2026-10-06 16:20:04.768472	A309	Błąd Lini Niverplst - Easy Plast
6544	310	41	2026-10-06 16:20:04.768472	A310	Alarm Lini Niverplast - Transport System
6545	311	41	2026-10-06 16:20:04.768472	A311	Błąd Lini Niverplst - Transport System
6546	309	39	2026-10-06 16:21:04.910341	A309	Błąd Lini Niverplst - Easy Plast
6547	310	41	2026-10-06 16:21:04.910341	A310	Alarm Lini Niverplast - Transport System
6548	311	41	2026-10-06 16:21:04.910341	A311	Błąd Lini Niverplst - Transport System
6549	309	39	2026-10-06 16:22:05.11049	A309	Błąd Lini Niverplst - Easy Plast
6550	310	41	2026-10-06 16:22:05.11049	A310	Alarm Lini Niverplast - Transport System
6551	311	41	2026-10-06 16:22:05.11049	A311	Błąd Lini Niverplst - Transport System
6552	309	39	2026-10-06 16:23:05.322505	A309	Błąd Lini Niverplst - Easy Plast
6553	310	41	2026-10-06 16:23:05.322505	A310	Alarm Lini Niverplast - Transport System
6554	311	41	2026-10-06 16:23:05.322505	A311	Błąd Lini Niverplst - Transport System
6555	309	39	2026-10-06 16:24:05.469279	A309	Błąd Lini Niverplst - Easy Plast
6556	310	41	2026-10-06 16:24:05.469279	A310	Alarm Lini Niverplast - Transport System
6557	311	41	2026-10-06 16:24:05.469279	A311	Błąd Lini Niverplst - Transport System
6558	309	39	2026-10-06 16:25:05.643326	A309	Błąd Lini Niverplst - Easy Plast
6559	310	41	2026-10-06 16:25:05.643326	A310	Alarm Lini Niverplast - Transport System
6560	311	41	2026-10-06 16:25:05.643326	A311	Błąd Lini Niverplst - Transport System
6561	309	39	2026-10-06 16:26:05.80656	A309	Błąd Lini Niverplst - Easy Plast
6562	310	41	2026-10-06 16:26:05.80656	A310	Alarm Lini Niverplast - Transport System
6563	311	41	2026-10-06 16:26:05.80656	A311	Błąd Lini Niverplst - Transport System
6564	309	39	2026-10-06 16:27:05.982715	A309	Błąd Lini Niverplst - Easy Plast
6565	310	41	2026-10-06 16:27:05.982715	A310	Alarm Lini Niverplast - Transport System
6566	311	41	2026-10-06 16:27:05.982715	A311	Błąd Lini Niverplst - Transport System
6567	309	39	2026-10-06 16:28:04.815481	A309	Błąd Lini Niverplst - Easy Plast
6568	310	41	2026-10-06 16:28:04.815481	A310	Alarm Lini Niverplast - Transport System
6569	311	41	2026-10-06 16:28:04.815481	A311	Błąd Lini Niverplst - Transport System
6570	309	39	2026-10-06 16:29:04.962972	A309	Błąd Lini Niverplst - Easy Plast
6571	310	41	2026-10-06 16:29:04.962972	A310	Alarm Lini Niverplast - Transport System
6572	311	41	2026-10-06 16:29:04.962972	A311	Błąd Lini Niverplst - Transport System
6573	309	39	2026-10-06 16:30:05.165628	A309	Błąd Lini Niverplst - Easy Plast
6574	310	41	2026-10-06 16:30:05.165628	A310	Alarm Lini Niverplast - Transport System
6575	311	41	2026-10-06 16:30:05.165628	A311	Błąd Lini Niverplst - Transport System
6576	309	39	2026-10-06 16:31:05.324329	A309	Błąd Lini Niverplst - Easy Plast
6577	310	41	2026-10-06 16:31:05.324329	A310	Alarm Lini Niverplast - Transport System
6578	311	41	2026-10-06 16:31:05.324329	A311	Błąd Lini Niverplst - Transport System
6579	309	39	2026-10-06 16:32:05.508376	A309	Błąd Lini Niverplst - Easy Plast
6580	310	41	2026-10-06 16:32:05.508376	A310	Alarm Lini Niverplast - Transport System
6581	311	41	2026-10-06 16:32:05.508376	A311	Błąd Lini Niverplst - Transport System
6582	309	39	2026-10-06 16:33:05.682237	A309	Błąd Lini Niverplst - Easy Plast
6583	310	41	2026-10-06 16:33:05.682237	A310	Alarm Lini Niverplast - Transport System
6584	311	41	2026-10-06 16:33:05.682237	A311	Błąd Lini Niverplst - Transport System
6585	309	39	2026-10-06 16:34:05.854175	A309	Błąd Lini Niverplst - Easy Plast
6586	310	41	2026-10-06 16:34:05.854175	A310	Alarm Lini Niverplast - Transport System
6587	311	41	2026-10-06 16:34:05.854175	A311	Błąd Lini Niverplst - Transport System
6588	309	39	2026-10-06 16:35:06.028162	A309	Błąd Lini Niverplst - Easy Plast
6589	310	41	2026-10-06 16:35:06.028162	A310	Alarm Lini Niverplast - Transport System
6590	311	41	2026-10-06 16:35:06.028162	A311	Błąd Lini Niverplst - Transport System
6591	309	39	2026-10-06 16:36:06.196115	A309	Błąd Lini Niverplst - Easy Plast
6592	310	41	2026-10-06 16:36:06.196115	A310	Alarm Lini Niverplast - Transport System
6593	311	41	2026-10-06 16:36:06.196115	A311	Błąd Lini Niverplst - Transport System
6594	309	39	2026-10-06 16:37:06.369605	A309	Błąd Lini Niverplst - Easy Plast
6595	310	41	2026-10-06 16:37:06.369605	A310	Alarm Lini Niverplast - Transport System
6596	311	41	2026-10-06 16:37:06.369605	A311	Błąd Lini Niverplst - Transport System
6597	309	39	2026-10-06 16:38:06.53915	A309	Błąd Lini Niverplst - Easy Plast
6598	310	41	2026-10-06 16:38:06.53915	A310	Alarm Lini Niverplast - Transport System
6599	311	41	2026-10-06 16:38:06.53915	A311	Błąd Lini Niverplst - Transport System
6600	309	39	2026-10-06 16:39:05.392034	A309	Błąd Lini Niverplst - Easy Plast
6601	310	41	2026-10-06 16:39:05.392034	A310	Alarm Lini Niverplast - Transport System
6602	311	41	2026-10-06 16:39:05.392034	A311	Błąd Lini Niverplst - Transport System
6603	309	39	2026-10-06 16:40:05.51859	A309	Błąd Lini Niverplst - Easy Plast
6604	310	41	2026-10-06 16:40:05.51859	A310	Alarm Lini Niverplast - Transport System
6605	311	41	2026-10-06 16:40:05.51859	A311	Błąd Lini Niverplst - Transport System
6606	309	39	2026-10-06 16:41:05.728762	A309	Błąd Lini Niverplst - Easy Plast
6607	310	41	2026-10-06 16:41:05.728762	A310	Alarm Lini Niverplast - Transport System
6608	311	41	2026-10-06 16:41:05.728762	A311	Błąd Lini Niverplst - Transport System
6609	309	39	2026-10-06 16:42:05.867298	A309	Błąd Lini Niverplst - Easy Plast
6610	310	41	2026-10-06 16:42:05.867298	A310	Alarm Lini Niverplast - Transport System
6611	311	41	2026-10-06 16:42:05.867298	A311	Błąd Lini Niverplst - Transport System
6612	309	39	2026-10-06 16:43:06.090142	A309	Błąd Lini Niverplst - Easy Plast
6613	310	41	2026-10-06 16:43:06.090142	A310	Alarm Lini Niverplast - Transport System
6614	311	41	2026-10-06 16:43:06.090142	A311	Błąd Lini Niverplst - Transport System
6615	309	39	2026-10-06 16:44:06.213319	A309	Błąd Lini Niverplst - Easy Plast
6616	310	41	2026-10-06 16:44:06.213319	A310	Alarm Lini Niverplast - Transport System
6617	311	41	2026-10-06 16:44:06.213319	A311	Błąd Lini Niverplst - Transport System
6618	309	39	2026-10-06 16:45:06.411659	A309	Błąd Lini Niverplst - Easy Plast
6619	310	41	2026-10-06 16:45:06.411659	A310	Alarm Lini Niverplast - Transport System
6620	311	41	2026-10-06 16:45:06.411659	A311	Błąd Lini Niverplst - Transport System
6621	309	39	2026-10-06 16:46:06.568797	A309	Błąd Lini Niverplst - Easy Plast
6622	310	41	2026-10-06 16:46:06.568797	A310	Alarm Lini Niverplast - Transport System
6623	311	41	2026-10-06 16:46:06.568797	A311	Błąd Lini Niverplst - Transport System
6624	309	39	2026-10-06 16:47:06.736317	A309	Błąd Lini Niverplst - Easy Plast
6625	310	41	2026-10-06 16:47:06.736317	A310	Alarm Lini Niverplast - Transport System
6626	311	41	2026-10-06 16:47:06.736317	A311	Błąd Lini Niverplst - Transport System
6627	309	39	2026-10-06 16:48:06.937473	A309	Błąd Lini Niverplst - Easy Plast
6628	310	41	2026-10-06 16:48:06.937473	A310	Alarm Lini Niverplast - Transport System
6629	311	41	2026-10-06 16:48:06.937473	A311	Błąd Lini Niverplst - Transport System
6630	309	39	2026-10-06 16:49:07.089527	A309	Błąd Lini Niverplst - Easy Plast
6631	310	41	2026-10-06 16:49:07.089527	A310	Alarm Lini Niverplast - Transport System
6632	311	41	2026-10-06 16:49:07.089527	A311	Błąd Lini Niverplst - Transport System
6633	309	39	2026-10-06 16:50:07.28448	A309	Błąd Lini Niverplst - Easy Plast
6634	310	41	2026-10-06 16:50:07.28448	A310	Alarm Lini Niverplast - Transport System
6635	311	41	2026-10-06 16:50:07.28448	A311	Błąd Lini Niverplst - Transport System
6636	309	39	2026-10-06 16:51:06.079453	A309	Błąd Lini Niverplst - Easy Plast
6637	310	41	2026-10-06 16:51:06.079453	A310	Alarm Lini Niverplast - Transport System
6638	311	41	2026-10-06 16:51:06.079453	A311	Błąd Lini Niverplst - Transport System
6639	309	39	2026-10-06 16:52:06.233221	A309	Błąd Lini Niverplst - Easy Plast
6640	310	41	2026-10-06 16:52:06.233221	A310	Alarm Lini Niverplast - Transport System
6641	311	41	2026-10-06 16:52:06.233221	A311	Błąd Lini Niverplst - Transport System
6642	309	39	2026-10-06 16:53:06.444884	A309	Błąd Lini Niverplst - Easy Plast
6643	310	41	2026-10-06 16:53:06.444884	A310	Alarm Lini Niverplast - Transport System
6644	311	41	2026-10-06 16:53:06.444884	A311	Błąd Lini Niverplst - Transport System
6645	309	39	2026-10-06 16:54:06.60195	A309	Błąd Lini Niverplst - Easy Plast
6646	310	41	2026-10-06 16:54:06.60195	A310	Alarm Lini Niverplast - Transport System
6647	311	41	2026-10-06 16:54:06.60195	A311	Błąd Lini Niverplst - Transport System
6648	309	39	2026-10-06 16:55:06.790032	A309	Błąd Lini Niverplst - Easy Plast
6649	310	41	2026-10-06 16:55:06.790032	A310	Alarm Lini Niverplast - Transport System
6650	311	41	2026-10-06 16:55:06.790032	A311	Błąd Lini Niverplst - Transport System
6651	309	39	2026-10-06 16:56:06.951434	A309	Błąd Lini Niverplst - Easy Plast
6652	310	41	2026-10-06 16:56:06.951434	A310	Alarm Lini Niverplast - Transport System
6653	311	41	2026-10-06 16:56:06.951434	A311	Błąd Lini Niverplst - Transport System
6654	309	39	2026-10-06 16:57:07.125601	A309	Błąd Lini Niverplst - Easy Plast
6655	310	41	2026-10-06 16:57:07.125601	A310	Alarm Lini Niverplast - Transport System
6656	311	41	2026-10-06 16:57:07.125601	A311	Błąd Lini Niverplst - Transport System
6657	309	39	2026-10-06 16:58:07.326896	A309	Błąd Lini Niverplst - Easy Plast
6658	310	41	2026-10-06 16:58:07.326896	A310	Alarm Lini Niverplast - Transport System
6659	311	41	2026-10-06 16:58:07.326896	A311	Błąd Lini Niverplst - Transport System
6660	309	39	2026-10-06 16:59:07.476093	A309	Błąd Lini Niverplst - Easy Plast
6661	310	41	2026-10-06 16:59:07.476093	A310	Alarm Lini Niverplast - Transport System
6662	311	41	2026-10-06 16:59:07.476093	A311	Błąd Lini Niverplst - Transport System
6663	309	39	2026-10-06 17:00:07.660265	A309	Błąd Lini Niverplst - Easy Plast
6664	310	41	2026-10-06 17:00:07.660265	A310	Alarm Lini Niverplast - Transport System
6665	311	41	2026-10-06 17:00:07.660265	A311	Błąd Lini Niverplst - Transport System
6666	309	39	2026-10-06 17:01:07.832836	A309	Błąd Lini Niverplst - Easy Plast
6667	310	41	2026-10-06 17:01:07.832836	A310	Alarm Lini Niverplast - Transport System
6668	311	41	2026-10-06 17:01:07.832836	A311	Błąd Lini Niverplst - Transport System
6669	309	39	2026-10-06 17:02:08.007477	A309	Błąd Lini Niverplst - Easy Plast
6670	310	41	2026-10-06 17:02:08.007477	A310	Alarm Lini Niverplast - Transport System
6671	311	41	2026-10-06 17:02:08.007477	A311	Błąd Lini Niverplst - Transport System
6672	309	39	2026-10-06 17:03:06.785069	A309	Błąd Lini Niverplst - Easy Plast
6673	310	41	2026-10-06 17:03:06.785069	A310	Alarm Lini Niverplast - Transport System
6674	311	41	2026-10-06 17:03:06.785069	A311	Błąd Lini Niverplst - Transport System
6675	309	39	2026-10-06 17:04:06.995433	A309	Błąd Lini Niverplst - Easy Plast
6676	310	41	2026-10-06 17:04:06.995433	A310	Alarm Lini Niverplast - Transport System
6677	311	41	2026-10-06 17:04:06.995433	A311	Błąd Lini Niverplst - Transport System
6678	309	39	2026-10-06 17:05:07.164063	A309	Błąd Lini Niverplst - Easy Plast
6679	310	41	2026-10-06 17:05:07.164063	A310	Alarm Lini Niverplast - Transport System
6680	311	41	2026-10-06 17:05:07.164063	A311	Błąd Lini Niverplst - Transport System
6681	309	39	2026-10-06 17:06:07.359337	A309	Błąd Lini Niverplst - Easy Plast
6682	310	41	2026-10-06 17:06:07.359337	A310	Alarm Lini Niverplast - Transport System
6683	311	41	2026-10-06 17:06:07.359337	A311	Błąd Lini Niverplst - Transport System
6684	309	39	2026-10-06 17:07:07.528465	A309	Błąd Lini Niverplst - Easy Plast
6685	310	41	2026-10-06 17:07:07.528465	A310	Alarm Lini Niverplast - Transport System
6686	311	41	2026-10-06 17:07:07.528465	A311	Błąd Lini Niverplst - Transport System
6687	309	39	2026-10-06 17:08:07.711038	A309	Błąd Lini Niverplst - Easy Plast
6688	310	41	2026-10-06 17:08:07.711038	A310	Alarm Lini Niverplast - Transport System
6689	311	41	2026-10-06 17:08:07.711038	A311	Błąd Lini Niverplst - Transport System
6690	309	39	2026-10-06 17:09:07.890725	A309	Błąd Lini Niverplst - Easy Plast
6691	310	41	2026-10-06 17:09:07.890725	A310	Alarm Lini Niverplast - Transport System
6692	311	41	2026-10-06 17:09:07.890725	A311	Błąd Lini Niverplst - Transport System
6693	309	39	2026-10-06 17:10:08.068469	A309	Błąd Lini Niverplst - Easy Plast
6694	310	41	2026-10-06 17:10:08.068469	A310	Alarm Lini Niverplast - Transport System
6695	311	41	2026-10-06 17:10:08.068469	A311	Błąd Lini Niverplst - Transport System
6696	309	39	2026-10-06 17:11:08.22943	A309	Błąd Lini Niverplst - Easy Plast
6697	310	41	2026-10-06 17:11:08.22943	A310	Alarm Lini Niverplast - Transport System
6698	311	41	2026-10-06 17:11:08.22943	A311	Błąd Lini Niverplst - Transport System
6699	309	39	2026-10-06 17:12:08.489487	A309	Błąd Lini Niverplst - Easy Plast
6700	310	41	2026-10-06 17:12:08.489487	A310	Alarm Lini Niverplast - Transport System
6701	311	41	2026-10-06 17:12:08.489487	A311	Błąd Lini Niverplst - Transport System
6702	309	39	2026-10-06 17:13:08.599605	A309	Błąd Lini Niverplst - Easy Plast
6703	310	41	2026-10-06 17:13:08.599605	A310	Alarm Lini Niverplast - Transport System
6704	311	41	2026-10-06 17:13:08.599605	A311	Błąd Lini Niverplst - Transport System
6705	309	39	2026-10-06 17:14:07.352689	A309	Błąd Lini Niverplst - Easy Plast
6706	310	41	2026-10-06 17:14:07.352689	A310	Alarm Lini Niverplast - Transport System
6707	311	41	2026-10-06 17:14:07.352689	A311	Błąd Lini Niverplst - Transport System
6708	309	39	2026-10-06 17:15:07.583572	A309	Błąd Lini Niverplst - Easy Plast
6709	310	41	2026-10-06 17:15:07.583572	A310	Alarm Lini Niverplast - Transport System
6710	311	41	2026-10-06 17:15:07.583572	A311	Błąd Lini Niverplst - Transport System
6711	309	39	2026-10-06 17:16:07.720952	A309	Błąd Lini Niverplst - Easy Plast
6712	310	41	2026-10-06 17:16:07.720952	A310	Alarm Lini Niverplast - Transport System
6713	311	41	2026-10-06 17:16:07.720952	A311	Błąd Lini Niverplst - Transport System
6714	309	39	2026-10-06 17:17:07.94778	A309	Błąd Lini Niverplst - Easy Plast
6715	310	41	2026-10-06 17:17:07.94778	A310	Alarm Lini Niverplast - Transport System
6716	311	41	2026-10-06 17:17:07.94778	A311	Błąd Lini Niverplst - Transport System
6717	309	39	2026-10-06 17:18:08.095972	A309	Błąd Lini Niverplst - Easy Plast
6718	310	41	2026-10-06 17:18:08.095972	A310	Alarm Lini Niverplast - Transport System
6719	311	41	2026-10-06 17:18:08.095972	A311	Błąd Lini Niverplst - Transport System
6720	309	39	2026-10-06 17:19:08.281705	A309	Błąd Lini Niverplst - Easy Plast
6721	310	41	2026-10-06 17:19:08.281705	A310	Alarm Lini Niverplast - Transport System
6722	311	41	2026-10-06 17:19:08.281705	A311	Błąd Lini Niverplst - Transport System
6723	309	39	2026-10-06 17:20:08.458995	A309	Błąd Lini Niverplst - Easy Plast
6724	310	41	2026-10-06 17:20:08.458995	A310	Alarm Lini Niverplast - Transport System
6725	311	41	2026-10-06 17:20:08.458995	A311	Błąd Lini Niverplst - Transport System
6726	309	39	2026-10-06 17:21:08.65603	A309	Błąd Lini Niverplst - Easy Plast
6727	310	41	2026-10-06 17:21:08.65603	A310	Alarm Lini Niverplast - Transport System
6728	311	41	2026-10-06 17:21:08.65603	A311	Błąd Lini Niverplst - Transport System
6729	309	39	2026-10-06 17:22:08.8217	A309	Błąd Lini Niverplst - Easy Plast
6730	310	41	2026-10-06 17:22:08.8217	A310	Alarm Lini Niverplast - Transport System
6731	311	41	2026-10-06 17:22:08.8217	A311	Błąd Lini Niverplst - Transport System
6732	309	39	2026-10-06 17:23:09.01056	A309	Błąd Lini Niverplst - Easy Plast
6733	310	41	2026-10-06 17:23:09.01056	A310	Alarm Lini Niverplast - Transport System
6734	311	41	2026-10-06 17:23:09.01056	A311	Błąd Lini Niverplst - Transport System
6735	309	39	2026-10-06 17:24:09.187818	A309	Błąd Lini Niverplst - Easy Plast
6736	310	41	2026-10-06 17:24:09.187818	A310	Alarm Lini Niverplast - Transport System
6737	311	41	2026-10-06 17:24:09.187818	A311	Błąd Lini Niverplst - Transport System
6738	309	39	2026-10-06 17:25:09.358336	A309	Błąd Lini Niverplst - Easy Plast
6739	310	41	2026-10-06 17:25:09.358336	A310	Alarm Lini Niverplast - Transport System
6740	311	41	2026-10-06 17:25:09.358336	A311	Błąd Lini Niverplst - Transport System
6741	309	39	2026-10-06 17:26:08.141822	A309	Błąd Lini Niverplst - Easy Plast
6742	310	41	2026-10-06 17:26:08.141822	A310	Alarm Lini Niverplast - Transport System
6743	311	41	2026-10-06 17:26:08.141822	A311	Błąd Lini Niverplst - Transport System
6744	309	39	2026-10-06 17:27:08.319162	A309	Błąd Lini Niverplst - Easy Plast
6745	310	41	2026-10-06 17:27:08.319162	A310	Alarm Lini Niverplast - Transport System
6746	311	41	2026-10-06 17:27:08.319162	A311	Błąd Lini Niverplst - Transport System
6747	309	39	2026-10-06 17:28:08.509116	A309	Błąd Lini Niverplst - Easy Plast
6748	310	41	2026-10-06 17:28:08.509116	A310	Alarm Lini Niverplast - Transport System
6749	311	41	2026-10-06 17:28:08.509116	A311	Błąd Lini Niverplst - Transport System
6750	309	39	2026-10-06 17:29:09.403028	A309	Błąd Lini Niverplst - Easy Plast
6751	310	41	2026-10-06 17:29:09.403028	A310	Alarm Lini Niverplast - Transport System
6752	311	41	2026-10-06 17:29:09.403028	A311	Błąd Lini Niverplst - Transport System
6753	309	39	2026-10-06 17:30:08.876087	A309	Błąd Lini Niverplst - Easy Plast
6754	310	41	2026-10-06 17:30:08.876087	A310	Alarm Lini Niverplast - Transport System
6755	311	41	2026-10-06 17:30:08.876087	A311	Błąd Lini Niverplst - Transport System
6756	309	39	2026-10-06 17:31:09.035913	A309	Błąd Lini Niverplst - Easy Plast
6757	310	41	2026-10-06 17:31:09.035913	A310	Alarm Lini Niverplast - Transport System
6758	311	41	2026-10-06 17:31:09.035913	A311	Błąd Lini Niverplst - Transport System
6759	309	39	2026-10-06 17:32:09.2546	A309	Błąd Lini Niverplst - Easy Plast
6760	310	41	2026-10-06 17:32:09.2546	A310	Alarm Lini Niverplast - Transport System
6761	311	41	2026-10-06 17:32:09.2546	A311	Błąd Lini Niverplst - Transport System
6762	309	39	2026-10-06 17:33:09.413	A309	Błąd Lini Niverplst - Easy Plast
6763	310	41	2026-10-06 17:33:09.413	A310	Alarm Lini Niverplast - Transport System
6764	311	41	2026-10-06 17:33:09.413	A311	Błąd Lini Niverplst - Transport System
6765	309	39	2026-10-06 17:34:09.622107	A309	Błąd Lini Niverplst - Easy Plast
6766	310	41	2026-10-06 17:34:09.622107	A310	Alarm Lini Niverplast - Transport System
6767	311	41	2026-10-06 17:34:09.622107	A311	Błąd Lini Niverplst - Transport System
6768	309	39	2026-10-06 17:35:09.786757	A309	Błąd Lini Niverplst - Easy Plast
6769	310	41	2026-10-06 17:35:09.786757	A310	Alarm Lini Niverplast - Transport System
6770	311	41	2026-10-06 17:35:09.786757	A311	Błąd Lini Niverplst - Transport System
6771	309	39	2026-10-06 17:36:09.963464	A309	Błąd Lini Niverplst - Easy Plast
6772	310	41	2026-10-06 17:36:09.963464	A310	Alarm Lini Niverplast - Transport System
6773	311	41	2026-10-06 17:36:09.963464	A311	Błąd Lini Niverplst - Transport System
6774	309	39	2026-10-06 17:37:08.737166	A309	Błąd Lini Niverplst - Easy Plast
6775	310	41	2026-10-06 17:37:08.737166	A310	Alarm Lini Niverplast - Transport System
6776	311	41	2026-10-06 17:37:08.737166	A311	Błąd Lini Niverplst - Transport System
6777	309	39	2026-10-06 17:38:08.925518	A309	Błąd Lini Niverplst - Easy Plast
6778	310	41	2026-10-06 17:38:08.925518	A310	Alarm Lini Niverplast - Transport System
6779	311	41	2026-10-06 17:38:08.925518	A311	Błąd Lini Niverplst - Transport System
6780	309	39	2026-10-06 17:39:09.070056	A309	Błąd Lini Niverplst - Easy Plast
6781	310	41	2026-10-06 17:39:09.070056	A310	Alarm Lini Niverplast - Transport System
6782	311	41	2026-10-06 17:39:09.070056	A311	Błąd Lini Niverplst - Transport System
6783	309	39	2026-10-06 17:40:09.265214	A309	Błąd Lini Niverplst - Easy Plast
6784	310	41	2026-10-06 17:40:09.265214	A310	Alarm Lini Niverplast - Transport System
6785	311	41	2026-10-06 17:40:09.265214	A311	Błąd Lini Niverplst - Transport System
6786	309	39	2026-10-06 17:41:11.485655	A309	Błąd Lini Niverplst - Easy Plast
6787	310	41	2026-10-06 17:41:11.485655	A310	Alarm Lini Niverplast - Transport System
6788	311	41	2026-10-06 17:41:11.485655	A311	Błąd Lini Niverplst - Transport System
6789	309	39	2026-10-06 17:42:09.63157	A309	Błąd Lini Niverplst - Easy Plast
6790	310	41	2026-10-06 17:42:09.63157	A310	Alarm Lini Niverplast - Transport System
6791	311	41	2026-10-06 17:42:09.63157	A311	Błąd Lini Niverplst - Transport System
6792	309	39	2026-10-06 17:43:09.83305	A309	Błąd Lini Niverplst - Easy Plast
6793	310	41	2026-10-06 17:43:09.83305	A310	Alarm Lini Niverplast - Transport System
6794	311	41	2026-10-06 17:43:09.83305	A311	Błąd Lini Niverplst - Transport System
6795	309	39	2026-10-06 17:44:10.004346	A309	Błąd Lini Niverplst - Easy Plast
6796	310	41	2026-10-06 17:44:10.004346	A310	Alarm Lini Niverplast - Transport System
6797	311	41	2026-10-06 17:44:10.004346	A311	Błąd Lini Niverplst - Transport System
6798	309	39	2026-10-06 17:45:10.195324	A309	Błąd Lini Niverplst - Easy Plast
6799	310	41	2026-10-06 17:45:10.195324	A310	Alarm Lini Niverplast - Transport System
6800	311	41	2026-10-06 17:45:10.195324	A311	Błąd Lini Niverplst - Transport System
6801	309	39	2026-10-06 17:46:10.384652	A309	Błąd Lini Niverplst - Easy Plast
6802	310	41	2026-10-06 17:46:10.384652	A310	Alarm Lini Niverplast - Transport System
6803	311	41	2026-10-06 17:46:10.384652	A311	Błąd Lini Niverplst - Transport System
6804	309	39	2026-10-06 17:47:10.543562	A309	Błąd Lini Niverplst - Easy Plast
6805	310	41	2026-10-06 17:47:10.543562	A310	Alarm Lini Niverplast - Transport System
6806	311	41	2026-10-06 17:47:10.543562	A311	Błąd Lini Niverplst - Transport System
6807	309	39	2026-10-06 17:48:09.989781	A309	Błąd Lini Niverplst - Easy Plast
6808	310	41	2026-10-06 17:48:09.989781	A310	Alarm Lini Niverplast - Transport System
6809	311	41	2026-10-06 17:48:09.989781	A311	Błąd Lini Niverplst - Transport System
6810	309	39	2026-10-06 17:49:09.49716	A309	Błąd Lini Niverplst - Easy Plast
6811	310	41	2026-10-06 17:49:09.49716	A310	Alarm Lini Niverplast - Transport System
6812	311	41	2026-10-06 17:49:09.49716	A311	Błąd Lini Niverplst - Transport System
6813	309	39	2026-10-06 17:50:09.732745	A309	Błąd Lini Niverplst - Easy Plast
6814	310	41	2026-10-06 17:50:09.732745	A310	Alarm Lini Niverplast - Transport System
6815	311	41	2026-10-06 17:50:09.732745	A311	Błąd Lini Niverplst - Transport System
6816	309	39	2026-10-06 17:51:09.849006	A309	Błąd Lini Niverplst - Easy Plast
6817	310	41	2026-10-06 17:51:09.849006	A310	Alarm Lini Niverplast - Transport System
6818	311	41	2026-10-06 17:51:09.849006	A311	Błąd Lini Niverplst - Transport System
6819	309	39	2026-10-06 17:52:10.041312	A309	Błąd Lini Niverplst - Easy Plast
6820	310	41	2026-10-06 17:52:10.041312	A310	Alarm Lini Niverplast - Transport System
6821	311	41	2026-10-06 17:52:10.041312	A311	Błąd Lini Niverplst - Transport System
6822	309	39	2026-10-06 17:53:10.249112	A309	Błąd Lini Niverplst - Easy Plast
6823	310	41	2026-10-06 17:53:10.249112	A310	Alarm Lini Niverplast - Transport System
6824	311	41	2026-10-06 17:53:10.249112	A311	Błąd Lini Niverplst - Transport System
6825	309	39	2026-10-06 17:54:10.432764	A309	Błąd Lini Niverplst - Easy Plast
6826	310	41	2026-10-06 17:54:10.432764	A310	Alarm Lini Niverplast - Transport System
6827	311	41	2026-10-06 17:54:10.432764	A311	Błąd Lini Niverplst - Transport System
6828	309	39	2026-10-06 17:55:10.610951	A309	Błąd Lini Niverplst - Easy Plast
6829	310	41	2026-10-06 17:55:10.610951	A310	Alarm Lini Niverplast - Transport System
6830	311	41	2026-10-06 17:55:10.610951	A311	Błąd Lini Niverplst - Transport System
6831	309	39	2026-10-06 17:56:10.783944	A309	Błąd Lini Niverplst - Easy Plast
6832	310	41	2026-10-06 17:56:10.783944	A310	Alarm Lini Niverplast - Transport System
6833	311	41	2026-10-06 17:56:10.783944	A311	Błąd Lini Niverplst - Transport System
6834	309	39	2026-10-06 17:57:11.041048	A309	Błąd Lini Niverplst - Easy Plast
6835	310	41	2026-10-06 17:57:11.041048	A310	Alarm Lini Niverplast - Transport System
6836	311	41	2026-10-06 17:57:11.041048	A311	Błąd Lini Niverplst - Transport System
6837	309	39	2026-10-06 17:58:11.155159	A309	Błąd Lini Niverplst - Easy Plast
6838	310	41	2026-10-06 17:58:11.155159	A310	Alarm Lini Niverplast - Transport System
6839	311	41	2026-10-06 17:58:11.155159	A311	Błąd Lini Niverplst - Transport System
6840	309	39	2026-10-06 17:59:11.340715	A309	Błąd Lini Niverplst - Easy Plast
6841	310	41	2026-10-06 17:59:11.340715	A310	Alarm Lini Niverplast - Transport System
6842	311	41	2026-10-06 17:59:11.340715	A311	Błąd Lini Niverplst - Transport System
6843	106	2	2026-10-06 17:59:11.340715	A106	Błąd pudełko zostało odrzucone
6844	309	39	2026-10-06 18:00:10.122874	A309	Błąd Lini Niverplst - Easy Plast
6845	310	41	2026-10-06 18:00:10.122874	A310	Alarm Lini Niverplast - Transport System
6846	311	41	2026-10-06 18:00:10.122874	A311	Błąd Lini Niverplst - Transport System
6847	106	2	2026-10-06 18:00:10.122874	A106	Błąd pudełko zostało odrzucone
6848	309	39	2026-10-06 18:01:10.265135	A309	Błąd Lini Niverplst - Easy Plast
6849	310	41	2026-10-06 18:01:10.265135	A310	Alarm Lini Niverplast - Transport System
6850	311	41	2026-10-06 18:01:10.265135	A311	Błąd Lini Niverplst - Transport System
6851	106	2	2026-10-06 18:01:10.265135	A106	Błąd pudełko zostało odrzucone
6852	309	39	2026-10-06 18:02:10.479393	A309	Błąd Lini Niverplst - Easy Plast
6853	310	41	2026-10-06 18:02:10.479393	A310	Alarm Lini Niverplast - Transport System
6854	311	41	2026-10-06 18:02:10.479393	A311	Błąd Lini Niverplst - Transport System
6855	106	2	2026-10-06 18:02:10.479393	A106	Błąd pudełko zostało odrzucone
6856	309	39	2026-10-06 18:03:10.673952	A309	Błąd Lini Niverplst - Easy Plast
6857	310	41	2026-10-06 18:03:10.673952	A310	Alarm Lini Niverplast - Transport System
6858	311	41	2026-10-06 18:03:10.673952	A311	Błąd Lini Niverplst - Transport System
6859	106	2	2026-10-06 18:03:10.673952	A106	Błąd pudełko zostało odrzucone
6860	309	39	2026-10-06 18:04:10.868143	A309	Błąd Lini Niverplst - Easy Plast
6861	310	41	2026-10-06 18:04:10.868143	A310	Alarm Lini Niverplast - Transport System
6862	311	41	2026-10-06 18:04:10.868143	A311	Błąd Lini Niverplst - Transport System
6863	106	2	2026-10-06 18:04:10.868143	A106	Błąd pudełko zostało odrzucone
6864	309	39	2026-10-06 18:05:11.033006	A309	Błąd Lini Niverplst - Easy Plast
6865	310	41	2026-10-06 18:05:11.033006	A310	Alarm Lini Niverplast - Transport System
6866	311	41	2026-10-06 18:05:11.033006	A311	Błąd Lini Niverplst - Transport System
6867	106	2	2026-10-06 18:05:11.033006	A106	Błąd pudełko zostało odrzucone
6868	309	39	2026-10-06 18:06:11.236625	A309	Błąd Lini Niverplst - Easy Plast
6869	310	41	2026-10-06 18:06:11.236625	A310	Alarm Lini Niverplast - Transport System
6870	311	41	2026-10-06 18:06:11.236625	A311	Błąd Lini Niverplst - Transport System
6871	106	2	2026-10-06 18:06:11.236625	A106	Błąd pudełko zostało odrzucone
6872	309	39	2026-10-06 18:07:11.416555	A309	Błąd Lini Niverplst - Easy Plast
6873	310	41	2026-10-06 18:07:11.416555	A310	Alarm Lini Niverplast - Transport System
6874	311	41	2026-10-06 18:07:11.416555	A311	Błąd Lini Niverplst - Transport System
6875	106	2	2026-10-06 18:07:11.416555	A106	Błąd pudełko zostało odrzucone
6876	309	39	2026-10-06 18:08:11.599731	A309	Błąd Lini Niverplst - Easy Plast
6877	310	41	2026-10-06 18:08:11.599731	A310	Alarm Lini Niverplast - Transport System
6878	311	41	2026-10-06 18:08:11.599731	A311	Błąd Lini Niverplst - Transport System
6879	106	2	2026-10-06 18:08:11.599731	A106	Błąd pudełko zostało odrzucone
6880	309	39	2026-10-06 18:09:11.774661	A309	Błąd Lini Niverplst - Easy Plast
6881	310	41	2026-10-06 18:09:11.774661	A310	Alarm Lini Niverplast - Transport System
6882	311	41	2026-10-06 18:09:11.774661	A311	Błąd Lini Niverplst - Transport System
6883	106	2	2026-10-06 18:09:11.774661	A106	Błąd pudełko zostało odrzucone
6884	309	39	2026-10-06 18:10:11.967052	A309	Błąd Lini Niverplst - Easy Plast
6885	310	41	2026-10-06 18:10:11.967052	A310	Alarm Lini Niverplast - Transport System
6886	311	41	2026-10-06 18:10:11.967052	A311	Błąd Lini Niverplst - Transport System
6887	106	2	2026-10-06 18:10:11.967052	A106	Błąd pudełko zostało odrzucone
6888	309	39	2026-10-06 18:11:10.729689	A309	Błąd Lini Niverplst - Easy Plast
6889	310	41	2026-10-06 18:11:10.729689	A310	Alarm Lini Niverplast - Transport System
6890	311	41	2026-10-06 18:11:10.729689	A311	Błąd Lini Niverplst - Transport System
6891	106	2	2026-10-06 18:11:10.729689	A106	Błąd pudełko zostało odrzucone
6892	309	39	2026-10-06 18:12:10.905283	A309	Błąd Lini Niverplst - Easy Plast
6893	310	41	2026-10-06 18:12:10.905283	A310	Alarm Lini Niverplast - Transport System
6894	311	41	2026-10-06 18:12:10.905283	A311	Błąd Lini Niverplst - Transport System
6895	106	2	2026-10-06 18:12:10.905283	A106	Błąd pudełko zostało odrzucone
6896	309	39	2026-10-06 18:13:11.113434	A309	Błąd Lini Niverplst - Easy Plast
6897	310	41	2026-10-06 18:13:11.113434	A310	Alarm Lini Niverplast - Transport System
6898	311	41	2026-10-06 18:13:11.113434	A311	Błąd Lini Niverplst - Transport System
6899	106	2	2026-10-06 18:13:11.113434	A106	Błąd pudełko zostało odrzucone
6900	309	39	2026-10-06 18:14:11.267793	A309	Błąd Lini Niverplst - Easy Plast
6901	310	41	2026-10-06 18:14:11.267793	A310	Alarm Lini Niverplast - Transport System
6902	311	41	2026-10-06 18:14:11.267793	A311	Błąd Lini Niverplst - Transport System
6903	106	2	2026-10-06 18:14:11.267793	A106	Błąd pudełko zostało odrzucone
6904	309	39	2026-10-06 18:15:11.501669	A309	Błąd Lini Niverplst - Easy Plast
6905	310	41	2026-10-06 18:15:11.501669	A310	Alarm Lini Niverplast - Transport System
6906	311	41	2026-10-06 18:15:11.501669	A311	Błąd Lini Niverplst - Transport System
6907	106	2	2026-10-06 18:15:11.501669	A106	Błąd pudełko zostało odrzucone
6908	309	39	2026-10-06 18:16:11.641625	A309	Błąd Lini Niverplst - Easy Plast
6909	310	41	2026-10-06 18:16:11.641625	A310	Alarm Lini Niverplast - Transport System
6910	311	41	2026-10-06 18:16:11.641625	A311	Błąd Lini Niverplst - Transport System
6911	106	2	2026-10-06 18:16:11.641625	A106	Błąd pudełko zostało odrzucone
6912	309	39	2026-10-06 18:17:11.873366	A309	Błąd Lini Niverplst - Easy Plast
6913	310	41	2026-10-06 18:17:11.873366	A310	Alarm Lini Niverplast - Transport System
6914	311	41	2026-10-06 18:17:11.873366	A311	Błąd Lini Niverplst - Transport System
6915	106	2	2026-10-06 18:17:11.873366	A106	Błąd pudełko zostało odrzucone
6916	309	39	2026-10-06 18:18:11.777413	A309	Błąd Lini Niverplst - Easy Plast
6917	310	41	2026-10-06 18:18:11.777413	A310	Alarm Lini Niverplast - Transport System
6918	311	41	2026-10-06 18:18:11.777413	A311	Błąd Lini Niverplst - Transport System
6919	106	2	2026-10-06 18:18:11.777413	A106	Błąd pudełko zostało odrzucone
6920	309	39	2026-10-06 18:19:12.224154	A309	Błąd Lini Niverplst - Easy Plast
6921	310	41	2026-10-06 18:19:12.224154	A310	Alarm Lini Niverplast - Transport System
6922	311	41	2026-10-06 18:19:12.224154	A311	Błąd Lini Niverplst - Transport System
6923	106	2	2026-10-06 18:19:12.224154	A106	Błąd pudełko zostało odrzucone
6924	309	39	2026-10-06 18:20:12.40681	A309	Błąd Lini Niverplst - Easy Plast
6925	310	41	2026-10-06 18:20:12.40681	A310	Alarm Lini Niverplast - Transport System
6926	311	41	2026-10-06 18:20:12.40681	A311	Błąd Lini Niverplst - Transport System
6927	106	2	2026-10-06 18:20:12.40681	A106	Błąd pudełko zostało odrzucone
6928	309	39	2026-10-06 18:21:12.592053	A309	Błąd Lini Niverplst - Easy Plast
6929	310	41	2026-10-06 18:21:12.592053	A310	Alarm Lini Niverplast - Transport System
6930	311	41	2026-10-06 18:21:12.592053	A311	Błąd Lini Niverplst - Transport System
6931	106	2	2026-10-06 18:21:12.592053	A106	Błąd pudełko zostało odrzucone
6932	309	39	2026-10-06 18:22:11.322811	A309	Błąd Lini Niverplst - Easy Plast
6933	310	41	2026-10-06 18:22:11.322811	A310	Alarm Lini Niverplast - Transport System
6934	311	41	2026-10-06 18:22:11.322811	A311	Błąd Lini Niverplst - Transport System
6935	106	2	2026-10-06 18:22:11.322811	A106	Błąd pudełko zostało odrzucone
6936	309	39	2026-10-06 18:23:11.521911	A309	Błąd Lini Niverplst - Easy Plast
6937	310	41	2026-10-06 18:23:11.521911	A310	Alarm Lini Niverplast - Transport System
6938	311	41	2026-10-06 18:23:11.521911	A311	Błąd Lini Niverplst - Transport System
6939	106	2	2026-10-06 18:23:11.521911	A106	Błąd pudełko zostało odrzucone
6940	309	39	2026-10-06 18:24:11.685436	A309	Błąd Lini Niverplst - Easy Plast
6941	310	41	2026-10-06 18:24:11.685436	A310	Alarm Lini Niverplast - Transport System
6942	311	41	2026-10-06 18:24:11.685436	A311	Błąd Lini Niverplst - Transport System
6943	106	2	2026-10-06 18:24:11.685436	A106	Błąd pudełko zostało odrzucone
6944	309	39	2026-10-06 18:25:11.898165	A309	Błąd Lini Niverplst - Easy Plast
6945	310	41	2026-10-06 18:25:11.898165	A310	Alarm Lini Niverplast - Transport System
6946	311	41	2026-10-06 18:25:11.898165	A311	Błąd Lini Niverplst - Transport System
6947	106	2	2026-10-06 18:25:11.898165	A106	Błąd pudełko zostało odrzucone
6948	309	39	2026-10-06 18:26:12.080758	A309	Błąd Lini Niverplst - Easy Plast
6949	310	41	2026-10-06 18:26:12.080758	A310	Alarm Lini Niverplast - Transport System
6950	311	41	2026-10-06 18:26:12.080758	A311	Błąd Lini Niverplst - Transport System
6951	106	2	2026-10-06 18:26:12.080758	A106	Błąd pudełko zostało odrzucone
6952	309	39	2026-10-06 18:27:12.27823	A309	Błąd Lini Niverplst - Easy Plast
6953	310	41	2026-10-06 18:27:12.27823	A310	Alarm Lini Niverplast - Transport System
6954	311	41	2026-10-06 18:27:12.27823	A311	Błąd Lini Niverplst - Transport System
6955	106	2	2026-10-06 18:27:12.27823	A106	Błąd pudełko zostało odrzucone
6956	309	39	2026-10-06 18:28:12.470584	A309	Błąd Lini Niverplst - Easy Plast
6957	310	41	2026-10-06 18:28:12.470584	A310	Alarm Lini Niverplast - Transport System
6958	311	41	2026-10-06 18:28:12.470584	A311	Błąd Lini Niverplst - Transport System
6959	106	2	2026-10-06 18:28:12.470584	A106	Błąd pudełko zostało odrzucone
6960	309	39	2026-10-06 18:29:12.667638	A309	Błąd Lini Niverplst - Easy Plast
6961	310	41	2026-10-06 18:29:12.667638	A310	Alarm Lini Niverplast - Transport System
6962	311	41	2026-10-06 18:29:12.667638	A311	Błąd Lini Niverplst - Transport System
6963	106	2	2026-10-06 18:29:12.667638	A106	Błąd pudełko zostało odrzucone
6964	309	39	2026-10-06 18:30:12.87922	A309	Błąd Lini Niverplst - Easy Plast
6965	310	41	2026-10-06 18:30:12.87922	A310	Alarm Lini Niverplast - Transport System
6966	311	41	2026-10-06 18:30:12.87922	A311	Błąd Lini Niverplst - Transport System
6967	106	2	2026-10-06 18:30:12.87922	A106	Błąd pudełko zostało odrzucone
6968	309	39	2026-10-06 18:31:13.044181	A309	Błąd Lini Niverplst - Easy Plast
6969	310	41	2026-10-06 18:31:13.044181	A310	Alarm Lini Niverplast - Transport System
6970	311	41	2026-10-06 18:31:13.044181	A311	Błąd Lini Niverplst - Transport System
6971	106	2	2026-10-06 18:31:13.044181	A106	Błąd pudełko zostało odrzucone
6972	309	39	2026-10-06 18:32:13.223258	A309	Błąd Lini Niverplst - Easy Plast
6973	310	41	2026-10-06 18:32:13.223258	A310	Alarm Lini Niverplast - Transport System
6974	311	41	2026-10-06 18:32:13.223258	A311	Błąd Lini Niverplst - Transport System
6975	106	2	2026-10-06 18:32:13.223258	A106	Błąd pudełko zostało odrzucone
6976	309	39	2026-10-06 18:33:11.973619	A309	Błąd Lini Niverplst - Easy Plast
6977	310	41	2026-10-06 18:33:11.973619	A310	Alarm Lini Niverplast - Transport System
6978	311	41	2026-10-06 18:33:11.973619	A311	Błąd Lini Niverplst - Transport System
6979	106	2	2026-10-06 18:33:11.973619	A106	Błąd pudełko zostało odrzucone
6980	309	39	2026-10-06 18:34:12.162325	A309	Błąd Lini Niverplst - Easy Plast
6981	310	41	2026-10-06 18:34:12.162325	A310	Alarm Lini Niverplast - Transport System
6982	311	41	2026-10-06 18:34:12.162325	A311	Błąd Lini Niverplst - Transport System
6983	106	2	2026-10-06 18:34:12.162325	A106	Błąd pudełko zostało odrzucone
6984	309	39	2026-10-06 18:35:12.358366	A309	Błąd Lini Niverplst - Easy Plast
6985	310	41	2026-10-06 18:35:12.358366	A310	Alarm Lini Niverplast - Transport System
6986	311	41	2026-10-06 18:35:12.358366	A311	Błąd Lini Niverplst - Transport System
6987	106	2	2026-10-06 18:35:12.358366	A106	Błąd pudełko zostało odrzucone
6988	309	39	2026-10-06 18:36:12.548636	A309	Błąd Lini Niverplst - Easy Plast
6989	310	41	2026-10-06 18:36:12.548636	A310	Alarm Lini Niverplast - Transport System
6990	311	41	2026-10-06 18:36:12.548636	A311	Błąd Lini Niverplst - Transport System
6991	106	2	2026-10-06 18:36:12.548636	A106	Błąd pudełko zostało odrzucone
6992	309	39	2026-10-06 18:37:12.738359	A309	Błąd Lini Niverplst - Easy Plast
6993	310	41	2026-10-06 18:37:12.738359	A310	Alarm Lini Niverplast - Transport System
6994	311	41	2026-10-06 18:37:12.738359	A311	Błąd Lini Niverplst - Transport System
6995	106	2	2026-10-06 18:37:12.738359	A106	Błąd pudełko zostało odrzucone
6996	309	39	2026-10-06 18:38:12.920273	A309	Błąd Lini Niverplst - Easy Plast
6997	310	41	2026-10-06 18:38:12.920273	A310	Alarm Lini Niverplast - Transport System
6998	311	41	2026-10-06 18:38:12.920273	A311	Błąd Lini Niverplst - Transport System
6999	106	2	2026-10-06 18:38:12.920273	A106	Błąd pudełko zostało odrzucone
7000	309	39	2026-10-06 18:39:13.120773	A309	Błąd Lini Niverplst - Easy Plast
7001	310	41	2026-10-06 18:39:13.120773	A310	Alarm Lini Niverplast - Transport System
7002	311	41	2026-10-06 18:39:13.120773	A311	Błąd Lini Niverplst - Transport System
7003	106	2	2026-10-06 18:39:13.120773	A106	Błąd pudełko zostało odrzucone
7004	309	39	2026-10-06 18:40:13.320342	A309	Błąd Lini Niverplst - Easy Plast
7005	310	41	2026-10-06 18:40:13.320342	A310	Alarm Lini Niverplast - Transport System
7006	311	41	2026-10-06 18:40:13.320342	A311	Błąd Lini Niverplst - Transport System
7007	106	2	2026-10-06 18:40:13.320342	A106	Błąd pudełko zostało odrzucone
7008	309	39	2026-10-06 18:41:13.492421	A309	Błąd Lini Niverplst - Easy Plast
7009	310	41	2026-10-06 18:41:13.492421	A310	Alarm Lini Niverplast - Transport System
7010	311	41	2026-10-06 18:41:13.492421	A311	Błąd Lini Niverplst - Transport System
7011	106	2	2026-10-06 18:41:13.492421	A106	Błąd pudełko zostało odrzucone
7012	309	39	2026-10-06 18:42:13.689873	A309	Błąd Lini Niverplst - Easy Plast
7013	310	41	2026-10-06 18:42:13.689873	A310	Alarm Lini Niverplast - Transport System
7014	311	41	2026-10-06 18:42:13.689873	A311	Błąd Lini Niverplst - Transport System
7015	106	2	2026-10-06 18:42:13.689873	A106	Błąd pudełko zostało odrzucone
7016	309	39	2026-10-06 18:43:13.879454	A309	Błąd Lini Niverplst - Easy Plast
7017	310	41	2026-10-06 18:43:13.879454	A310	Alarm Lini Niverplast - Transport System
7018	311	41	2026-10-06 18:43:13.879454	A311	Błąd Lini Niverplst - Transport System
7019	106	2	2026-10-06 18:43:13.879454	A106	Błąd pudełko zostało odrzucone
7020	309	39	2026-10-06 18:44:12.633462	A309	Błąd Lini Niverplst - Easy Plast
7021	310	41	2026-10-06 18:44:12.633462	A310	Alarm Lini Niverplast - Transport System
7022	311	41	2026-10-06 18:44:12.633462	A311	Błąd Lini Niverplst - Transport System
7023	106	2	2026-10-06 18:44:12.633462	A106	Błąd pudełko zostało odrzucone
7024	309	39	2026-10-06 18:45:12.782323	A309	Błąd Lini Niverplst - Easy Plast
7025	310	41	2026-10-06 18:45:12.782323	A310	Alarm Lini Niverplast - Transport System
7026	311	41	2026-10-06 18:45:12.782323	A311	Błąd Lini Niverplst - Transport System
7027	106	2	2026-10-06 18:45:12.782323	A106	Błąd pudełko zostało odrzucone
7028	309	39	2026-10-06 18:46:12.91391	A309	Błąd Lini Niverplst - Easy Plast
7029	310	41	2026-10-06 18:46:12.91391	A310	Alarm Lini Niverplast - Transport System
7030	311	41	2026-10-06 18:46:12.91391	A311	Błąd Lini Niverplst - Transport System
7031	106	2	2026-10-06 18:46:12.91391	A106	Błąd pudełko zostało odrzucone
7032	309	39	2026-10-06 18:47:13.184921	A309	Błąd Lini Niverplst - Easy Plast
7033	310	41	2026-10-06 18:47:13.184921	A310	Alarm Lini Niverplast - Transport System
7034	311	41	2026-10-06 18:47:13.184921	A311	Błąd Lini Niverplst - Transport System
7035	106	2	2026-10-06 18:47:13.184921	A106	Błąd pudełko zostało odrzucone
7036	309	39	2026-10-06 18:48:13.366572	A309	Błąd Lini Niverplst - Easy Plast
7037	310	41	2026-10-06 18:48:13.366572	A310	Alarm Lini Niverplast - Transport System
7038	311	41	2026-10-06 18:48:13.366572	A311	Błąd Lini Niverplst - Transport System
7039	106	2	2026-10-06 18:48:13.366572	A106	Błąd pudełko zostało odrzucone
7040	309	39	2026-10-06 18:49:13.571081	A309	Błąd Lini Niverplst - Easy Plast
7041	310	41	2026-10-06 18:49:13.571081	A310	Alarm Lini Niverplast - Transport System
7042	311	41	2026-10-06 18:49:13.571081	A311	Błąd Lini Niverplst - Transport System
7043	106	2	2026-10-06 18:49:13.571081	A106	Błąd pudełko zostało odrzucone
7044	309	39	2026-10-06 18:50:13.748264	A309	Błąd Lini Niverplst - Easy Plast
7045	310	41	2026-10-06 18:50:13.748264	A310	Alarm Lini Niverplast - Transport System
7046	311	41	2026-10-06 18:50:13.748264	A311	Błąd Lini Niverplst - Transport System
7047	106	2	2026-10-06 18:50:13.748264	A106	Błąd pudełko zostało odrzucone
7048	309	39	2026-10-06 18:51:13.937876	A309	Błąd Lini Niverplst - Easy Plast
7049	310	41	2026-10-06 18:51:13.937876	A310	Alarm Lini Niverplast - Transport System
7050	311	41	2026-10-06 18:51:13.937876	A311	Błąd Lini Niverplst - Transport System
7051	106	2	2026-10-06 18:51:13.937876	A106	Błąd pudełko zostało odrzucone
7052	309	39	2026-10-06 18:52:14.134658	A309	Błąd Lini Niverplst - Easy Plast
7053	310	41	2026-10-06 18:52:14.134658	A310	Alarm Lini Niverplast - Transport System
7054	311	41	2026-10-06 18:52:14.134658	A311	Błąd Lini Niverplst - Transport System
7055	309	39	2026-10-06 18:53:14.348989	A309	Błąd Lini Niverplst - Easy Plast
7056	310	41	2026-10-06 18:53:14.348989	A310	Alarm Lini Niverplast - Transport System
7057	311	41	2026-10-06 18:53:14.348989	A311	Błąd Lini Niverplst - Transport System
7058	309	39	2026-10-06 18:54:14.529204	A309	Błąd Lini Niverplst - Easy Plast
7059	310	41	2026-10-06 18:54:14.529204	A310	Alarm Lini Niverplast - Transport System
7060	311	41	2026-10-06 18:54:14.529204	A311	Błąd Lini Niverplst - Transport System
7061	309	39	2026-10-06 18:55:13.20615	A309	Błąd Lini Niverplst - Easy Plast
7062	310	41	2026-10-06 18:55:13.20615	A310	Alarm Lini Niverplast - Transport System
7063	311	41	2026-10-06 18:55:13.20615	A311	Błąd Lini Niverplst - Transport System
7064	309	39	2026-10-06 18:56:13.459518	A309	Błąd Lini Niverplst - Easy Plast
7065	310	41	2026-10-06 18:56:13.459518	A310	Alarm Lini Niverplast - Transport System
7066	311	41	2026-10-06 18:56:13.459518	A311	Błąd Lini Niverplst - Transport System
7067	309	39	2026-10-06 18:57:13.625324	A309	Błąd Lini Niverplst - Easy Plast
7068	310	41	2026-10-06 18:57:13.625324	A310	Alarm Lini Niverplast - Transport System
7069	311	41	2026-10-06 18:57:13.625324	A311	Błąd Lini Niverplst - Transport System
7070	309	39	2026-10-06 18:58:13.841826	A309	Błąd Lini Niverplst - Easy Plast
7071	310	41	2026-10-06 18:58:13.841826	A310	Alarm Lini Niverplast - Transport System
7072	311	41	2026-10-06 18:58:13.841826	A311	Błąd Lini Niverplst - Transport System
7073	309	39	2026-10-06 18:59:14.030548	A309	Błąd Lini Niverplst - Easy Plast
7074	310	41	2026-10-06 18:59:14.030548	A310	Alarm Lini Niverplast - Transport System
7075	311	41	2026-10-06 18:59:14.030548	A311	Błąd Lini Niverplst - Transport System
7076	309	39	2026-10-06 19:00:14.213049	A309	Błąd Lini Niverplst - Easy Plast
7077	310	41	2026-10-06 19:00:14.213049	A310	Alarm Lini Niverplast - Transport System
7078	311	41	2026-10-06 19:00:14.213049	A311	Błąd Lini Niverplst - Transport System
7079	309	39	2026-10-06 19:01:14.401432	A309	Błąd Lini Niverplst - Easy Plast
7080	310	41	2026-10-06 19:01:14.401432	A310	Alarm Lini Niverplast - Transport System
7081	311	41	2026-10-06 19:01:14.401432	A311	Błąd Lini Niverplst - Transport System
7082	309	39	2026-10-06 19:02:14.602196	A309	Błąd Lini Niverplst - Easy Plast
7083	310	41	2026-10-06 19:02:14.602196	A310	Alarm Lini Niverplast - Transport System
7084	311	41	2026-10-06 19:02:14.602196	A311	Błąd Lini Niverplst - Transport System
7085	309	39	2026-10-06 19:03:13.993861	A309	Błąd Lini Niverplst - Easy Plast
7086	310	41	2026-10-06 19:03:13.993861	A310	Alarm Lini Niverplast - Transport System
7087	311	41	2026-10-06 19:03:13.993861	A311	Błąd Lini Niverplst - Transport System
7088	309	39	2026-10-06 19:04:15.008138	A309	Błąd Lini Niverplst - Easy Plast
7089	310	41	2026-10-06 19:04:15.008138	A310	Alarm Lini Niverplast - Transport System
7090	311	41	2026-10-06 19:04:15.008138	A311	Błąd Lini Niverplst - Transport System
7091	309	39	2026-10-06 19:05:15.197039	A309	Błąd Lini Niverplst - Easy Plast
7092	310	41	2026-10-06 19:05:15.197039	A310	Alarm Lini Niverplast - Transport System
7093	311	41	2026-10-06 19:05:15.197039	A311	Błąd Lini Niverplst - Transport System
7094	309	39	2026-10-06 19:06:13.874103	A309	Błąd Lini Niverplst - Easy Plast
7095	310	41	2026-10-06 19:06:13.874103	A310	Alarm Lini Niverplast - Transport System
7096	311	41	2026-10-06 19:06:13.874103	A311	Błąd Lini Niverplst - Transport System
7097	309	39	2026-10-06 19:07:14.101796	A309	Błąd Lini Niverplst - Easy Plast
7098	310	41	2026-10-06 19:07:14.101796	A310	Alarm Lini Niverplast - Transport System
7099	311	41	2026-10-06 19:07:14.101796	A311	Błąd Lini Niverplst - Transport System
7100	309	39	2026-10-06 19:08:14.277625	A309	Błąd Lini Niverplst - Easy Plast
7101	310	41	2026-10-06 19:08:14.277625	A310	Alarm Lini Niverplast - Transport System
7102	311	41	2026-10-06 19:08:14.277625	A311	Błąd Lini Niverplst - Transport System
7103	309	39	2026-10-06 19:09:14.48582	A309	Błąd Lini Niverplst - Easy Plast
7104	310	41	2026-10-06 19:09:14.48582	A310	Alarm Lini Niverplast - Transport System
7105	311	41	2026-10-06 19:09:14.48582	A311	Błąd Lini Niverplst - Transport System
7106	309	39	2026-10-06 19:10:14.685237	A309	Błąd Lini Niverplst - Easy Plast
7107	310	41	2026-10-06 19:10:14.685237	A310	Alarm Lini Niverplast - Transport System
7108	311	41	2026-10-06 19:10:14.685237	A311	Błąd Lini Niverplst - Transport System
7109	309	39	2026-10-06 19:11:14.876889	A309	Błąd Lini Niverplst - Easy Plast
7110	310	41	2026-10-06 19:11:14.876889	A310	Alarm Lini Niverplast - Transport System
7111	311	41	2026-10-06 19:11:14.876889	A311	Błąd Lini Niverplst - Transport System
7112	309	39	2026-10-06 19:12:15.070008	A309	Błąd Lini Niverplst - Easy Plast
7113	310	41	2026-10-06 19:12:15.070008	A310	Alarm Lini Niverplast - Transport System
7114	311	41	2026-10-06 19:12:15.070008	A311	Błąd Lini Niverplst - Transport System
7115	309	39	2026-10-06 19:13:15.301461	A309	Błąd Lini Niverplst - Easy Plast
7116	310	41	2026-10-06 19:13:15.301461	A310	Alarm Lini Niverplast - Transport System
7117	311	41	2026-10-06 19:13:15.301461	A311	Błąd Lini Niverplst - Transport System
7118	309	39	2026-10-06 19:14:15.462829	A309	Błąd Lini Niverplst - Easy Plast
7119	310	41	2026-10-06 19:14:15.462829	A310	Alarm Lini Niverplast - Transport System
7120	311	41	2026-10-06 19:14:15.462829	A311	Błąd Lini Niverplst - Transport System
7121	309	39	2026-10-06 19:15:15.672964	A309	Błąd Lini Niverplst - Easy Plast
7122	310	41	2026-10-06 19:15:15.672964	A310	Alarm Lini Niverplast - Transport System
7123	311	41	2026-10-06 19:15:15.672964	A311	Błąd Lini Niverplst - Transport System
7124	309	39	2026-10-06 19:16:14.393791	A309	Błąd Lini Niverplst - Easy Plast
7125	310	41	2026-10-06 19:16:14.393791	A310	Alarm Lini Niverplast - Transport System
7126	311	41	2026-10-06 19:16:14.393791	A311	Błąd Lini Niverplst - Transport System
7127	309	39	2026-10-06 19:17:14.552097	A309	Błąd Lini Niverplst - Easy Plast
7128	310	41	2026-10-06 19:17:14.552097	A310	Alarm Lini Niverplast - Transport System
7129	311	41	2026-10-06 19:17:14.552097	A311	Błąd Lini Niverplst - Transport System
7130	309	39	2026-10-06 19:18:14.757523	A309	Błąd Lini Niverplst - Easy Plast
7131	310	41	2026-10-06 19:18:14.757523	A310	Alarm Lini Niverplast - Transport System
7132	311	41	2026-10-06 19:18:14.757523	A311	Błąd Lini Niverplst - Transport System
7133	309	39	2026-10-06 19:19:14.94881	A309	Błąd Lini Niverplst - Easy Plast
7134	310	41	2026-10-06 19:19:14.94881	A310	Alarm Lini Niverplast - Transport System
7135	311	41	2026-10-06 19:19:14.94881	A311	Błąd Lini Niverplst - Transport System
7136	309	39	2026-10-06 19:20:15.177069	A309	Błąd Lini Niverplst - Easy Plast
7137	310	41	2026-10-06 19:20:15.177069	A310	Alarm Lini Niverplast - Transport System
7138	311	41	2026-10-06 19:20:15.177069	A311	Błąd Lini Niverplst - Transport System
7139	309	39	2026-10-06 19:21:15.360526	A309	Błąd Lini Niverplst - Easy Plast
7140	310	41	2026-10-06 19:21:15.360526	A310	Alarm Lini Niverplast - Transport System
7141	311	41	2026-10-06 19:21:15.360526	A311	Błąd Lini Niverplst - Transport System
7142	309	39	2026-10-06 19:22:15.568977	A309	Błąd Lini Niverplst - Easy Plast
7143	310	41	2026-10-06 19:22:15.568977	A310	Alarm Lini Niverplast - Transport System
7144	311	41	2026-10-06 19:22:15.568977	A311	Błąd Lini Niverplst - Transport System
7145	309	39	2026-10-06 19:23:15.765549	A309	Błąd Lini Niverplst - Easy Plast
7146	310	41	2026-10-06 19:23:15.765549	A310	Alarm Lini Niverplast - Transport System
7147	311	41	2026-10-06 19:23:15.765549	A311	Błąd Lini Niverplst - Transport System
7148	309	39	2026-10-06 19:24:15.944511	A309	Błąd Lini Niverplst - Easy Plast
7149	310	41	2026-10-06 19:24:15.944511	A310	Alarm Lini Niverplast - Transport System
7150	311	41	2026-10-06 19:24:15.944511	A311	Błąd Lini Niverplst - Transport System
7151	309	39	2026-10-06 19:25:16.13841	A309	Błąd Lini Niverplst - Easy Plast
7152	310	41	2026-10-06 19:25:16.13841	A310	Alarm Lini Niverplast - Transport System
7153	311	41	2026-10-06 19:25:16.13841	A311	Błąd Lini Niverplst - Transport System
7154	309	39	2026-10-06 19:26:16.352084	A309	Błąd Lini Niverplst - Easy Plast
7155	310	41	2026-10-06 19:26:16.352084	A310	Alarm Lini Niverplast - Transport System
7156	311	41	2026-10-06 19:26:16.352084	A311	Błąd Lini Niverplst - Transport System
7157	309	39	2026-10-06 19:27:15.037824	A309	Błąd Lini Niverplst - Easy Plast
7158	310	41	2026-10-06 19:27:15.037824	A310	Alarm Lini Niverplast - Transport System
7159	311	41	2026-10-06 19:27:15.037824	A311	Błąd Lini Niverplst - Transport System
7160	309	39	2026-10-06 19:28:15.222097	A309	Błąd Lini Niverplst - Easy Plast
7161	310	41	2026-10-06 19:28:15.222097	A310	Alarm Lini Niverplast - Transport System
7162	311	41	2026-10-06 19:28:15.222097	A311	Błąd Lini Niverplst - Transport System
7163	309	39	2026-10-06 19:29:15.447088	A309	Błąd Lini Niverplst - Easy Plast
7164	310	41	2026-10-06 19:29:15.447088	A310	Alarm Lini Niverplast - Transport System
7165	311	41	2026-10-06 19:29:15.447088	A311	Błąd Lini Niverplst - Transport System
7166	309	39	2026-10-06 19:30:15.632123	A309	Błąd Lini Niverplst - Easy Plast
7167	310	41	2026-10-06 19:30:15.632123	A310	Alarm Lini Niverplast - Transport System
7168	311	41	2026-10-06 19:30:15.632123	A311	Błąd Lini Niverplst - Transport System
7169	309	39	2026-10-06 19:31:15.870184	A309	Błąd Lini Niverplst - Easy Plast
7170	310	41	2026-10-06 19:31:15.870184	A310	Alarm Lini Niverplast - Transport System
7171	311	41	2026-10-06 19:31:15.870184	A311	Błąd Lini Niverplst - Transport System
7172	309	39	2026-10-06 19:32:16.035979	A309	Błąd Lini Niverplst - Easy Plast
7173	310	41	2026-10-06 19:32:16.035979	A310	Alarm Lini Niverplast - Transport System
7174	311	41	2026-10-06 19:32:16.035979	A311	Błąd Lini Niverplst - Transport System
7175	309	39	2026-10-06 19:33:16.219943	A309	Błąd Lini Niverplst - Easy Plast
7176	310	41	2026-10-06 19:33:16.219943	A310	Alarm Lini Niverplast - Transport System
7177	311	41	2026-10-06 19:33:16.219943	A311	Błąd Lini Niverplst - Transport System
7178	309	39	2026-10-06 19:34:16.46664	A309	Błąd Lini Niverplst - Easy Plast
7179	310	41	2026-10-06 19:34:16.46664	A310	Alarm Lini Niverplast - Transport System
7180	311	41	2026-10-06 19:34:16.46664	A311	Błąd Lini Niverplst - Transport System
7181	309	39	2026-10-06 19:35:16.643945	A309	Błąd Lini Niverplst - Easy Plast
7182	310	41	2026-10-06 19:35:16.643945	A310	Alarm Lini Niverplast - Transport System
7183	311	41	2026-10-06 19:35:16.643945	A311	Błąd Lini Niverplst - Transport System
7184	309	39	2026-10-06 19:36:16.857643	A309	Błąd Lini Niverplst - Easy Plast
7185	310	41	2026-10-06 19:36:16.857643	A310	Alarm Lini Niverplast - Transport System
7186	311	41	2026-10-06 19:36:16.857643	A311	Błąd Lini Niverplst - Transport System
7187	309	39	2026-10-06 19:37:17.046387	A309	Błąd Lini Niverplst - Easy Plast
7188	310	41	2026-10-06 19:37:17.046387	A310	Alarm Lini Niverplast - Transport System
7189	311	41	2026-10-06 19:37:17.046387	A311	Błąd Lini Niverplst - Transport System
7190	309	39	2026-10-06 19:38:15.693832	A309	Błąd Lini Niverplst - Easy Plast
7191	310	41	2026-10-06 19:38:15.693832	A310	Alarm Lini Niverplast - Transport System
7192	311	41	2026-10-06 19:38:15.693832	A311	Błąd Lini Niverplst - Transport System
7193	309	39	2026-10-06 19:39:15.931967	A309	Błąd Lini Niverplst - Easy Plast
7194	310	41	2026-10-06 19:39:15.931967	A310	Alarm Lini Niverplast - Transport System
7195	311	41	2026-10-06 19:39:15.931967	A311	Błąd Lini Niverplst - Transport System
7196	309	39	2026-10-06 19:40:16.116432	A309	Błąd Lini Niverplst - Easy Plast
7197	310	41	2026-10-06 19:40:16.116432	A310	Alarm Lini Niverplast - Transport System
7198	311	41	2026-10-06 19:40:16.116432	A311	Błąd Lini Niverplst - Transport System
7199	309	39	2026-10-06 19:41:16.353159	A309	Błąd Lini Niverplst - Easy Plast
7200	310	41	2026-10-06 19:41:16.353159	A310	Alarm Lini Niverplast - Transport System
7201	311	41	2026-10-06 19:41:16.353159	A311	Błąd Lini Niverplst - Transport System
7202	309	39	2026-10-06 19:42:16.540281	A309	Błąd Lini Niverplst - Easy Plast
7203	310	41	2026-10-06 19:42:16.540281	A310	Alarm Lini Niverplast - Transport System
7204	311	41	2026-10-06 19:42:16.540281	A311	Błąd Lini Niverplst - Transport System
7205	309	39	2026-10-06 19:43:16.734674	A309	Błąd Lini Niverplst - Easy Plast
7206	310	41	2026-10-06 19:43:16.734674	A310	Alarm Lini Niverplast - Transport System
7207	311	41	2026-10-06 19:43:16.734674	A311	Błąd Lini Niverplst - Transport System
7208	309	39	2026-10-06 19:44:16.954521	A309	Błąd Lini Niverplst - Easy Plast
7209	310	41	2026-10-06 19:44:16.954521	A310	Alarm Lini Niverplast - Transport System
7210	311	41	2026-10-06 19:44:16.954521	A311	Błąd Lini Niverplst - Transport System
7211	309	39	2026-10-06 19:45:17.156424	A309	Błąd Lini Niverplst - Easy Plast
7212	310	41	2026-10-06 19:45:17.156424	A310	Alarm Lini Niverplast - Transport System
7213	311	41	2026-10-06 19:45:17.156424	A311	Błąd Lini Niverplst - Transport System
7214	309	39	2026-10-06 19:46:17.362132	A309	Błąd Lini Niverplst - Easy Plast
7215	310	41	2026-10-06 19:46:17.362132	A310	Alarm Lini Niverplast - Transport System
7216	311	41	2026-10-06 19:46:17.362132	A311	Błąd Lini Niverplst - Transport System
7217	309	39	2026-10-06 19:47:17.556056	A309	Błąd Lini Niverplst - Easy Plast
7218	310	41	2026-10-06 19:47:17.556056	A310	Alarm Lini Niverplast - Transport System
7219	311	41	2026-10-06 19:47:17.556056	A311	Błąd Lini Niverplst - Transport System
7220	309	39	2026-10-06 19:48:16.237488	A309	Błąd Lini Niverplst - Easy Plast
7221	310	41	2026-10-06 19:48:16.237488	A310	Alarm Lini Niverplast - Transport System
7222	311	41	2026-10-06 19:48:16.237488	A311	Błąd Lini Niverplst - Transport System
7223	309	39	2026-10-06 19:49:16.431759	A309	Błąd Lini Niverplst - Easy Plast
7224	310	41	2026-10-06 19:49:16.431759	A310	Alarm Lini Niverplast - Transport System
7225	311	41	2026-10-06 19:49:16.431759	A311	Błąd Lini Niverplst - Transport System
7226	309	39	2026-10-06 19:50:16.644125	A309	Błąd Lini Niverplst - Easy Plast
7227	310	41	2026-10-06 19:50:16.644125	A310	Alarm Lini Niverplast - Transport System
7228	311	41	2026-10-06 19:50:16.644125	A311	Błąd Lini Niverplst - Transport System
7229	309	39	2026-10-06 19:51:16.851812	A309	Błąd Lini Niverplst - Easy Plast
7230	310	41	2026-10-06 19:51:16.851812	A310	Alarm Lini Niverplast - Transport System
7231	311	41	2026-10-06 19:51:16.851812	A311	Błąd Lini Niverplst - Transport System
7232	309	39	2026-10-06 19:52:17.049944	A309	Błąd Lini Niverplst - Easy Plast
7233	310	41	2026-10-06 19:52:17.049944	A310	Alarm Lini Niverplast - Transport System
7234	311	41	2026-10-06 19:52:17.049944	A311	Błąd Lini Niverplst - Transport System
7235	309	39	2026-10-06 19:53:17.252034	A309	Błąd Lini Niverplst - Easy Plast
7236	310	41	2026-10-06 19:53:17.252034	A310	Alarm Lini Niverplast - Transport System
7237	311	41	2026-10-06 19:53:17.252034	A311	Błąd Lini Niverplst - Transport System
7238	309	39	2026-10-06 19:54:17.463419	A309	Błąd Lini Niverplst - Easy Plast
7239	310	41	2026-10-06 19:54:17.463419	A310	Alarm Lini Niverplast - Transport System
7240	311	41	2026-10-06 19:54:17.463419	A311	Błąd Lini Niverplst - Transport System
7241	309	39	2026-10-06 19:55:17.674423	A309	Błąd Lini Niverplst - Easy Plast
7242	310	41	2026-10-06 19:55:17.674423	A310	Alarm Lini Niverplast - Transport System
7243	311	41	2026-10-06 19:55:17.674423	A311	Błąd Lini Niverplst - Transport System
7244	309	39	2026-10-06 19:56:17.871437	A309	Błąd Lini Niverplst - Easy Plast
7245	310	41	2026-10-06 19:56:17.871437	A310	Alarm Lini Niverplast - Transport System
7246	311	41	2026-10-06 19:56:17.871437	A311	Błąd Lini Niverplst - Transport System
7247	309	39	2026-10-06 19:57:18.063698	A309	Błąd Lini Niverplst - Easy Plast
7248	310	41	2026-10-06 19:57:18.063698	A310	Alarm Lini Niverplast - Transport System
7249	311	41	2026-10-06 19:57:18.063698	A311	Błąd Lini Niverplst - Transport System
7250	309	39	2026-10-06 19:58:16.67044	A309	Błąd Lini Niverplst - Easy Plast
7251	310	41	2026-10-06 19:58:16.67044	A310	Alarm Lini Niverplast - Transport System
7252	311	41	2026-10-06 19:58:16.67044	A311	Błąd Lini Niverplst - Transport System
7253	309	39	2026-10-06 19:59:16.9674	A309	Błąd Lini Niverplst - Easy Plast
7254	310	41	2026-10-06 19:59:16.9674	A310	Alarm Lini Niverplast - Transport System
7255	311	41	2026-10-06 19:59:16.9674	A311	Błąd Lini Niverplst - Transport System
7256	309	39	2026-10-06 20:00:17.109535	A309	Błąd Lini Niverplst - Easy Plast
7257	310	41	2026-10-06 20:00:17.109535	A310	Alarm Lini Niverplast - Transport System
7258	311	41	2026-10-06 20:00:17.109535	A311	Błąd Lini Niverplst - Transport System
7259	309	39	2026-10-06 20:01:17.372022	A309	Błąd Lini Niverplst - Easy Plast
7260	310	41	2026-10-06 20:01:17.372022	A310	Alarm Lini Niverplast - Transport System
7261	311	41	2026-10-06 20:01:17.372022	A311	Błąd Lini Niverplst - Transport System
7262	309	39	2026-10-06 20:02:17.546544	A309	Błąd Lini Niverplst - Easy Plast
7263	310	41	2026-10-06 20:02:17.546544	A310	Alarm Lini Niverplast - Transport System
7264	311	41	2026-10-06 20:02:17.546544	A311	Błąd Lini Niverplst - Transport System
7265	309	39	2026-10-06 20:03:17.782902	A309	Błąd Lini Niverplst - Easy Plast
7266	310	41	2026-10-06 20:03:17.782902	A310	Alarm Lini Niverplast - Transport System
7267	311	41	2026-10-06 20:03:17.782902	A311	Błąd Lini Niverplst - Transport System
7268	309	39	2026-10-06 20:04:17.978379	A309	Błąd Lini Niverplst - Easy Plast
7269	310	41	2026-10-06 20:04:17.978379	A310	Alarm Lini Niverplast - Transport System
7270	311	41	2026-10-06 20:04:17.978379	A311	Błąd Lini Niverplst - Transport System
7271	309	39	2026-10-06 20:05:18.183067	A309	Błąd Lini Niverplst - Easy Plast
7272	310	41	2026-10-06 20:05:18.183067	A310	Alarm Lini Niverplast - Transport System
7273	311	41	2026-10-06 20:05:18.183067	A311	Błąd Lini Niverplst - Transport System
7274	309	39	2026-10-06 20:06:18.396241	A309	Błąd Lini Niverplst - Easy Plast
7275	310	41	2026-10-06 20:06:18.396241	A310	Alarm Lini Niverplast - Transport System
7276	311	41	2026-10-06 20:06:18.396241	A311	Błąd Lini Niverplst - Transport System
7277	309	39	2026-10-06 20:07:18.593545	A309	Błąd Lini Niverplst - Easy Plast
7278	310	41	2026-10-06 20:07:18.593545	A310	Alarm Lini Niverplast - Transport System
7279	311	41	2026-10-06 20:07:18.593545	A311	Błąd Lini Niverplst - Transport System
7280	309	39	2026-10-06 20:08:18.802922	A309	Błąd Lini Niverplst - Easy Plast
7281	310	41	2026-10-06 20:08:18.802922	A310	Alarm Lini Niverplast - Transport System
7282	311	41	2026-10-06 20:08:18.802922	A311	Błąd Lini Niverplst - Transport System
7283	309	39	2026-10-06 20:09:17.431853	A309	Błąd Lini Niverplst - Easy Plast
7284	310	41	2026-10-06 20:09:17.431853	A310	Alarm Lini Niverplast - Transport System
7285	311	41	2026-10-06 20:09:17.431853	A311	Błąd Lini Niverplst - Transport System
7286	309	39	2026-10-06 20:10:17.669857	A309	Błąd Lini Niverplst - Easy Plast
7287	310	41	2026-10-06 20:10:17.669857	A310	Alarm Lini Niverplast - Transport System
7288	311	41	2026-10-06 20:10:17.669857	A311	Błąd Lini Niverplst - Transport System
7289	309	39	2026-10-06 20:11:17.866986	A309	Błąd Lini Niverplst - Easy Plast
7290	310	41	2026-10-06 20:11:17.866986	A310	Alarm Lini Niverplast - Transport System
7291	311	41	2026-10-06 20:11:17.866986	A311	Błąd Lini Niverplst - Transport System
7292	309	39	2026-10-06 20:12:18.081317	A309	Błąd Lini Niverplst - Easy Plast
7293	310	41	2026-10-06 20:12:18.081317	A310	Alarm Lini Niverplast - Transport System
7294	311	41	2026-10-06 20:12:18.081317	A311	Błąd Lini Niverplst - Transport System
7295	309	39	2026-10-06 20:13:18.282572	A309	Błąd Lini Niverplst - Easy Plast
7296	310	41	2026-10-06 20:13:18.282572	A310	Alarm Lini Niverplast - Transport System
7297	311	41	2026-10-06 20:13:18.282572	A311	Błąd Lini Niverplst - Transport System
7298	309	39	2026-10-06 20:14:18.501469	A309	Błąd Lini Niverplst - Easy Plast
7299	310	41	2026-10-06 20:14:18.501469	A310	Alarm Lini Niverplast - Transport System
7300	311	41	2026-10-06 20:14:18.501469	A311	Błąd Lini Niverplst - Transport System
7301	309	39	2026-10-06 20:15:18.720795	A309	Błąd Lini Niverplst - Easy Plast
7302	310	41	2026-10-06 20:15:18.720795	A310	Alarm Lini Niverplast - Transport System
7303	311	41	2026-10-06 20:15:18.720795	A311	Błąd Lini Niverplst - Transport System
7304	309	39	2026-10-06 20:16:18.908235	A309	Błąd Lini Niverplst - Easy Plast
7305	310	41	2026-10-06 20:16:18.908235	A310	Alarm Lini Niverplast - Transport System
7306	311	41	2026-10-06 20:16:18.908235	A311	Błąd Lini Niverplst - Transport System
7307	309	39	2026-10-06 20:17:19.124873	A309	Błąd Lini Niverplst - Easy Plast
7308	310	41	2026-10-06 20:17:19.124873	A310	Alarm Lini Niverplast - Transport System
7309	311	41	2026-10-06 20:17:19.124873	A311	Błąd Lini Niverplst - Transport System
7310	309	39	2026-10-06 20:18:19.32297	A309	Błąd Lini Niverplst - Easy Plast
7311	310	41	2026-10-06 20:18:19.32297	A310	Alarm Lini Niverplast - Transport System
7312	311	41	2026-10-06 20:18:19.32297	A311	Błąd Lini Niverplst - Transport System
7313	309	39	2026-10-06 20:19:17.982361	A309	Błąd Lini Niverplst - Easy Plast
7314	310	41	2026-10-06 20:19:17.982361	A310	Alarm Lini Niverplast - Transport System
7315	311	41	2026-10-06 20:19:17.982361	A311	Błąd Lini Niverplst - Transport System
7316	309	39	2026-10-06 20:20:18.166212	A309	Błąd Lini Niverplst - Easy Plast
7317	310	41	2026-10-06 20:20:18.166212	A310	Alarm Lini Niverplast - Transport System
7318	311	41	2026-10-06 20:20:18.166212	A311	Błąd Lini Niverplst - Transport System
7319	309	39	2026-10-06 20:21:18.414667	A309	Błąd Lini Niverplst - Easy Plast
7320	310	41	2026-10-06 20:21:18.414667	A310	Alarm Lini Niverplast - Transport System
7321	311	41	2026-10-06 20:21:18.414667	A311	Błąd Lini Niverplst - Transport System
7322	309	39	2026-10-06 20:22:18.608677	A309	Błąd Lini Niverplst - Easy Plast
7323	310	41	2026-10-06 20:22:18.608677	A310	Alarm Lini Niverplast - Transport System
7324	311	41	2026-10-06 20:22:18.608677	A311	Błąd Lini Niverplst - Transport System
7325	309	39	2026-10-06 20:23:18.792473	A309	Błąd Lini Niverplst - Easy Plast
7326	310	41	2026-10-06 20:23:18.792473	A310	Alarm Lini Niverplast - Transport System
7327	311	41	2026-10-06 20:23:18.792473	A311	Błąd Lini Niverplst - Transport System
7328	309	39	2026-10-06 20:24:19.018944	A309	Błąd Lini Niverplst - Easy Plast
7329	310	41	2026-10-06 20:24:19.018944	A310	Alarm Lini Niverplast - Transport System
7330	311	41	2026-10-06 20:24:19.018944	A311	Błąd Lini Niverplst - Transport System
7331	309	39	2026-10-06 20:25:19.264469	A309	Błąd Lini Niverplst - Easy Plast
7332	310	41	2026-10-06 20:25:19.264469	A310	Alarm Lini Niverplast - Transport System
7333	311	41	2026-10-06 20:25:19.264469	A311	Błąd Lini Niverplst - Transport System
7334	309	39	2026-10-06 20:26:19.463823	A309	Błąd Lini Niverplst - Easy Plast
7335	310	41	2026-10-06 20:26:19.463823	A310	Alarm Lini Niverplast - Transport System
7336	311	41	2026-10-06 20:26:19.463823	A311	Błąd Lini Niverplst - Transport System
7337	309	39	2026-10-06 20:27:19.678589	A309	Błąd Lini Niverplst - Easy Plast
7338	310	41	2026-10-06 20:27:19.678589	A310	Alarm Lini Niverplast - Transport System
7339	311	41	2026-10-06 20:27:19.678589	A311	Błąd Lini Niverplst - Transport System
7340	309	39	2026-10-06 20:28:19.860295	A309	Błąd Lini Niverplst - Easy Plast
7341	310	41	2026-10-06 20:28:19.860295	A310	Alarm Lini Niverplast - Transport System
7342	311	41	2026-10-06 20:28:19.860295	A311	Błąd Lini Niverplst - Transport System
7343	309	39	2026-10-06 20:29:18.50809	A309	Błąd Lini Niverplst - Easy Plast
7344	310	41	2026-10-06 20:29:18.50809	A310	Alarm Lini Niverplast - Transport System
7345	311	41	2026-10-06 20:29:18.50809	A311	Błąd Lini Niverplst - Transport System
7346	309	39	2026-10-06 20:30:18.755145	A309	Błąd Lini Niverplst - Easy Plast
7347	310	41	2026-10-06 20:30:18.755145	A310	Alarm Lini Niverplast - Transport System
7348	311	41	2026-10-06 20:30:18.755145	A311	Błąd Lini Niverplst - Transport System
7349	309	39	2026-10-06 20:31:18.924638	A309	Błąd Lini Niverplst - Easy Plast
7350	310	41	2026-10-06 20:31:18.924638	A310	Alarm Lini Niverplast - Transport System
7351	311	41	2026-10-06 20:31:18.924638	A311	Błąd Lini Niverplst - Transport System
7352	309	39	2026-10-06 20:32:19.158791	A309	Błąd Lini Niverplst - Easy Plast
7353	310	41	2026-10-06 20:32:19.158791	A310	Alarm Lini Niverplast - Transport System
7354	311	41	2026-10-06 20:32:19.158791	A311	Błąd Lini Niverplst - Transport System
7355	309	39	2026-10-06 20:33:19.357507	A309	Błąd Lini Niverplst - Easy Plast
7356	310	41	2026-10-06 20:33:19.357507	A310	Alarm Lini Niverplast - Transport System
7357	311	41	2026-10-06 20:33:19.357507	A311	Błąd Lini Niverplst - Transport System
7358	309	39	2026-10-06 20:34:19.592406	A309	Błąd Lini Niverplst - Easy Plast
7359	310	41	2026-10-06 20:34:19.592406	A310	Alarm Lini Niverplast - Transport System
7360	311	41	2026-10-06 20:34:19.592406	A311	Błąd Lini Niverplst - Transport System
7361	309	39	2026-10-06 20:35:19.734313	A309	Błąd Lini Niverplst - Easy Plast
7362	310	41	2026-10-06 20:35:19.734313	A310	Alarm Lini Niverplast - Transport System
7363	311	41	2026-10-06 20:35:19.734313	A311	Błąd Lini Niverplst - Transport System
7364	309	39	2026-10-06 20:36:20.751367	A309	Błąd Lini Niverplst - Easy Plast
7365	310	41	2026-10-06 20:36:20.751367	A310	Alarm Lini Niverplast - Transport System
7366	311	41	2026-10-06 20:36:20.751367	A311	Błąd Lini Niverplst - Transport System
7367	309	39	2026-10-06 20:37:20.214578	A309	Błąd Lini Niverplst - Easy Plast
7368	310	41	2026-10-06 20:37:20.214578	A310	Alarm Lini Niverplast - Transport System
7369	311	41	2026-10-06 20:37:20.214578	A311	Błąd Lini Niverplst - Transport System
7370	309	39	2026-10-06 20:38:20.407929	A309	Błąd Lini Niverplst - Easy Plast
7371	310	41	2026-10-06 20:38:20.407929	A310	Alarm Lini Niverplast - Transport System
7372	311	41	2026-10-06 20:38:20.407929	A311	Błąd Lini Niverplst - Transport System
7373	309	39	2026-10-06 20:39:20.646977	A309	Błąd Lini Niverplst - Easy Plast
7374	310	41	2026-10-06 20:39:20.646977	A310	Alarm Lini Niverplast - Transport System
7375	311	41	2026-10-06 20:39:20.646977	A311	Błąd Lini Niverplst - Transport System
7376	309	39	2026-10-06 20:40:19.254918	A309	Błąd Lini Niverplst - Easy Plast
7377	310	41	2026-10-06 20:40:19.254918	A310	Alarm Lini Niverplast - Transport System
7378	311	41	2026-10-06 20:40:19.254918	A311	Błąd Lini Niverplst - Transport System
7379	309	39	2026-10-06 20:41:19.497111	A309	Błąd Lini Niverplst - Easy Plast
7380	310	41	2026-10-06 20:41:19.497111	A310	Alarm Lini Niverplast - Transport System
7381	311	41	2026-10-06 20:41:19.497111	A311	Błąd Lini Niverplst - Transport System
7382	309	39	2026-10-06 20:42:19.703968	A309	Błąd Lini Niverplst - Easy Plast
7383	310	41	2026-10-06 20:42:19.703968	A310	Alarm Lini Niverplast - Transport System
7384	311	41	2026-10-06 20:42:19.703968	A311	Błąd Lini Niverplst - Transport System
7385	309	39	2026-10-06 20:43:19.937242	A309	Błąd Lini Niverplst - Easy Plast
7386	310	41	2026-10-06 20:43:19.937242	A310	Alarm Lini Niverplast - Transport System
7387	311	41	2026-10-06 20:43:19.937242	A311	Błąd Lini Niverplst - Transport System
7388	309	39	2026-10-06 20:44:20.12799	A309	Błąd Lini Niverplst - Easy Plast
7389	310	41	2026-10-06 20:44:20.12799	A310	Alarm Lini Niverplast - Transport System
7390	311	41	2026-10-06 20:44:20.12799	A311	Błąd Lini Niverplst - Transport System
7391	309	39	2026-10-06 20:45:20.360364	A309	Błąd Lini Niverplst - Easy Plast
7392	310	41	2026-10-06 20:45:20.360364	A310	Alarm Lini Niverplast - Transport System
7393	311	41	2026-10-06 20:45:20.360364	A311	Błąd Lini Niverplst - Transport System
7394	309	39	2026-10-06 20:46:20.565116	A309	Błąd Lini Niverplst - Easy Plast
7395	310	41	2026-10-06 20:46:20.565116	A310	Alarm Lini Niverplast - Transport System
7396	311	41	2026-10-06 20:46:20.565116	A311	Błąd Lini Niverplst - Transport System
7397	309	39	2026-10-06 20:47:20.766727	A309	Błąd Lini Niverplst - Easy Plast
7398	310	41	2026-10-06 20:47:20.766727	A310	Alarm Lini Niverplast - Transport System
7399	311	41	2026-10-06 20:47:20.766727	A311	Błąd Lini Niverplst - Transport System
7400	309	39	2026-10-06 20:48:20.980234	A309	Błąd Lini Niverplst - Easy Plast
7401	310	41	2026-10-06 20:48:20.980234	A310	Alarm Lini Niverplast - Transport System
7402	311	41	2026-10-06 20:48:20.980234	A311	Błąd Lini Niverplst - Transport System
7403	309	39	2026-10-06 20:49:21.198728	A309	Błąd Lini Niverplst - Easy Plast
7404	310	41	2026-10-06 20:49:21.198728	A310	Alarm Lini Niverplast - Transport System
7405	311	41	2026-10-06 20:49:21.198728	A311	Błąd Lini Niverplst - Transport System
7406	309	39	2026-10-06 20:50:19.7904	A309	Błąd Lini Niverplst - Easy Plast
7407	310	41	2026-10-06 20:50:19.7904	A310	Alarm Lini Niverplast - Transport System
7408	311	41	2026-10-06 20:50:19.7904	A311	Błąd Lini Niverplst - Transport System
7409	309	39	2026-10-06 20:51:20.051986	A309	Błąd Lini Niverplst - Easy Plast
7410	310	41	2026-10-06 20:51:20.051986	A310	Alarm Lini Niverplast - Transport System
7411	311	41	2026-10-06 20:51:20.051986	A311	Błąd Lini Niverplst - Transport System
7412	309	39	2026-10-06 20:52:20.244325	A309	Błąd Lini Niverplst - Easy Plast
7413	310	41	2026-10-06 20:52:20.244325	A310	Alarm Lini Niverplast - Transport System
7414	311	41	2026-10-06 20:52:20.244325	A311	Błąd Lini Niverplst - Transport System
7415	309	39	2026-10-06 20:53:20.471249	A309	Błąd Lini Niverplst - Easy Plast
7416	310	41	2026-10-06 20:53:20.471249	A310	Alarm Lini Niverplast - Transport System
7417	311	41	2026-10-06 20:53:20.471249	A311	Błąd Lini Niverplst - Transport System
7418	309	39	2026-10-06 20:54:20.688643	A309	Błąd Lini Niverplst - Easy Plast
7419	310	41	2026-10-06 20:54:20.688643	A310	Alarm Lini Niverplast - Transport System
7420	311	41	2026-10-06 20:54:20.688643	A311	Błąd Lini Niverplst - Transport System
7421	309	39	2026-10-06 20:55:20.91085	A309	Błąd Lini Niverplst - Easy Plast
7422	310	41	2026-10-06 20:55:20.91085	A310	Alarm Lini Niverplast - Transport System
7423	311	41	2026-10-06 20:55:20.91085	A311	Błąd Lini Niverplst - Transport System
7424	309	39	2026-10-06 20:56:21.144858	A309	Błąd Lini Niverplst - Easy Plast
7425	310	41	2026-10-06 20:56:21.144858	A310	Alarm Lini Niverplast - Transport System
7426	311	41	2026-10-06 20:56:21.144858	A311	Błąd Lini Niverplst - Transport System
7427	309	39	2026-10-06 20:57:21.338227	A309	Błąd Lini Niverplst - Easy Plast
7428	310	41	2026-10-06 20:57:21.338227	A310	Alarm Lini Niverplast - Transport System
7429	311	41	2026-10-06 20:57:21.338227	A311	Błąd Lini Niverplst - Transport System
7430	309	39	2026-10-06 20:58:21.563872	A309	Błąd Lini Niverplst - Easy Plast
7431	310	41	2026-10-06 20:58:21.563872	A310	Alarm Lini Niverplast - Transport System
7432	311	41	2026-10-06 20:58:21.563872	A311	Błąd Lini Niverplst - Transport System
7433	309	39	2026-10-06 20:59:21.760046	A309	Błąd Lini Niverplst - Easy Plast
7434	310	41	2026-10-06 20:59:21.760046	A310	Alarm Lini Niverplast - Transport System
7435	311	41	2026-10-06 20:59:21.760046	A311	Błąd Lini Niverplst - Transport System
7436	309	39	2026-10-06 21:00:20.403626	A309	Błąd Lini Niverplst - Easy Plast
7437	310	41	2026-10-06 21:00:20.403626	A310	Alarm Lini Niverplast - Transport System
7438	311	41	2026-10-06 21:00:20.403626	A311	Błąd Lini Niverplst - Transport System
7439	309	39	2026-10-06 21:01:20.598777	A309	Błąd Lini Niverplst - Easy Plast
7440	310	41	2026-10-06 21:01:20.598777	A310	Alarm Lini Niverplast - Transport System
7441	311	41	2026-10-06 21:01:20.598777	A311	Błąd Lini Niverplst - Transport System
7442	309	39	2026-10-06 21:02:20.836918	A309	Błąd Lini Niverplst - Easy Plast
7443	310	41	2026-10-06 21:02:20.836918	A310	Alarm Lini Niverplast - Transport System
7444	311	41	2026-10-06 21:02:20.836918	A311	Błąd Lini Niverplst - Transport System
7445	309	39	2026-10-06 21:03:21.061353	A309	Błąd Lini Niverplst - Easy Plast
7446	310	41	2026-10-06 21:03:21.061353	A310	Alarm Lini Niverplast - Transport System
7447	311	41	2026-10-06 21:03:21.061353	A311	Błąd Lini Niverplst - Transport System
7448	309	39	2026-10-06 21:04:21.277086	A309	Błąd Lini Niverplst - Easy Plast
7449	310	41	2026-10-06 21:04:21.277086	A310	Alarm Lini Niverplast - Transport System
7450	311	41	2026-10-06 21:04:21.277086	A311	Błąd Lini Niverplst - Transport System
7451	309	39	2026-10-06 21:05:21.472598	A309	Błąd Lini Niverplst - Easy Plast
7452	310	41	2026-10-06 21:05:21.472598	A310	Alarm Lini Niverplast - Transport System
7453	311	41	2026-10-06 21:05:21.472598	A311	Błąd Lini Niverplst - Transport System
7454	309	39	2026-10-06 21:06:21.714564	A309	Błąd Lini Niverplst - Easy Plast
7455	310	41	2026-10-06 21:06:21.714564	A310	Alarm Lini Niverplast - Transport System
7456	311	41	2026-10-06 21:06:21.714564	A311	Błąd Lini Niverplst - Transport System
7457	309	39	2026-10-06 21:07:21.904694	A309	Błąd Lini Niverplst - Easy Plast
7458	310	41	2026-10-06 21:07:21.904694	A310	Alarm Lini Niverplast - Transport System
7459	311	41	2026-10-06 21:07:21.904694	A311	Błąd Lini Niverplst - Transport System
7460	309	39	2026-10-06 21:08:22.12727	A309	Błąd Lini Niverplst - Easy Plast
7461	310	41	2026-10-06 21:08:22.12727	A310	Alarm Lini Niverplast - Transport System
7462	311	41	2026-10-06 21:08:22.12727	A311	Błąd Lini Niverplst - Transport System
7463	309	39	2026-10-06 21:09:22.341456	A309	Błąd Lini Niverplst - Easy Plast
7464	310	41	2026-10-06 21:09:22.341456	A310	Alarm Lini Niverplast - Transport System
7465	311	41	2026-10-06 21:09:22.341456	A311	Błąd Lini Niverplst - Transport System
7466	309	39	2026-10-06 21:10:20.88473	A309	Błąd Lini Niverplst - Easy Plast
7467	310	41	2026-10-06 21:10:20.88473	A310	Alarm Lini Niverplast - Transport System
7468	311	41	2026-10-06 21:10:20.88473	A311	Błąd Lini Niverplst - Transport System
7469	309	39	2026-10-06 21:11:21.18988	A309	Błąd Lini Niverplst - Easy Plast
7470	310	41	2026-10-06 21:11:21.18988	A310	Alarm Lini Niverplast - Transport System
7471	311	41	2026-10-06 21:11:21.18988	A311	Błąd Lini Niverplst - Transport System
7472	309	39	2026-10-06 21:12:21.377062	A309	Błąd Lini Niverplst - Easy Plast
7473	310	41	2026-10-06 21:12:21.377062	A310	Alarm Lini Niverplast - Transport System
7474	311	41	2026-10-06 21:12:21.377062	A311	Błąd Lini Niverplst - Transport System
7475	309	39	2026-10-06 21:13:21.620379	A309	Błąd Lini Niverplst - Easy Plast
7476	310	41	2026-10-06 21:13:21.620379	A310	Alarm Lini Niverplast - Transport System
7477	311	41	2026-10-06 21:13:21.620379	A311	Błąd Lini Niverplst - Transport System
7478	309	39	2026-10-06 21:14:21.829507	A309	Błąd Lini Niverplst - Easy Plast
7479	310	41	2026-10-06 21:14:21.829507	A310	Alarm Lini Niverplast - Transport System
7480	311	41	2026-10-06 21:14:21.829507	A311	Błąd Lini Niverplst - Transport System
7481	309	39	2026-10-06 21:15:22.048241	A309	Błąd Lini Niverplst - Easy Plast
7482	310	41	2026-10-06 21:15:22.048241	A310	Alarm Lini Niverplast - Transport System
7483	311	41	2026-10-06 21:15:22.048241	A311	Błąd Lini Niverplst - Transport System
7484	309	39	2026-10-06 21:16:22.271725	A309	Błąd Lini Niverplst - Easy Plast
7485	310	41	2026-10-06 21:16:22.271725	A310	Alarm Lini Niverplast - Transport System
7486	311	41	2026-10-06 21:16:22.271725	A311	Błąd Lini Niverplst - Transport System
7487	309	39	2026-10-06 21:17:22.48727	A309	Błąd Lini Niverplst - Easy Plast
7488	310	41	2026-10-06 21:17:22.48727	A310	Alarm Lini Niverplast - Transport System
7489	311	41	2026-10-06 21:17:22.48727	A311	Błąd Lini Niverplst - Transport System
7490	309	39	2026-10-06 21:18:22.715219	A309	Błąd Lini Niverplst - Easy Plast
7491	310	41	2026-10-06 21:18:22.715219	A310	Alarm Lini Niverplast - Transport System
7492	311	41	2026-10-06 21:18:22.715219	A311	Błąd Lini Niverplst - Transport System
7493	309	39	2026-10-06 21:19:22.925473	A309	Błąd Lini Niverplst - Easy Plast
7494	310	41	2026-10-06 21:19:22.925473	A310	Alarm Lini Niverplast - Transport System
7495	311	41	2026-10-06 21:19:22.925473	A311	Błąd Lini Niverplst - Transport System
7496	309	39	2026-10-06 21:20:21.542363	A309	Błąd Lini Niverplst - Easy Plast
7497	310	41	2026-10-06 21:20:21.542363	A310	Alarm Lini Niverplast - Transport System
7498	311	41	2026-10-06 21:20:21.542363	A311	Błąd Lini Niverplst - Transport System
7499	309	39	2026-10-06 21:21:21.721954	A309	Błąd Lini Niverplst - Easy Plast
7500	310	41	2026-10-06 21:21:21.721954	A310	Alarm Lini Niverplast - Transport System
7501	311	41	2026-10-06 21:21:21.721954	A311	Błąd Lini Niverplst - Transport System
7502	309	39	2026-10-06 21:22:21.990552	A309	Błąd Lini Niverplst - Easy Plast
7503	310	41	2026-10-06 21:22:21.990552	A310	Alarm Lini Niverplast - Transport System
7504	311	41	2026-10-06 21:22:21.990552	A311	Błąd Lini Niverplst - Transport System
7505	309	39	2026-10-06 21:23:22.176423	A309	Błąd Lini Niverplst - Easy Plast
7506	310	41	2026-10-06 21:23:22.176423	A310	Alarm Lini Niverplast - Transport System
7507	311	41	2026-10-06 21:23:22.176423	A311	Błąd Lini Niverplst - Transport System
7508	309	39	2026-10-06 21:24:22.407517	A309	Błąd Lini Niverplst - Easy Plast
7509	310	41	2026-10-06 21:24:22.407517	A310	Alarm Lini Niverplast - Transport System
7510	311	41	2026-10-06 21:24:22.407517	A311	Błąd Lini Niverplst - Transport System
7511	309	39	2026-10-06 21:25:22.640725	A309	Błąd Lini Niverplst - Easy Plast
7512	310	41	2026-10-06 21:25:22.640725	A310	Alarm Lini Niverplast - Transport System
7513	311	41	2026-10-06 21:25:22.640725	A311	Błąd Lini Niverplst - Transport System
7514	309	39	2026-10-06 21:26:22.842856	A309	Błąd Lini Niverplst - Easy Plast
7515	310	41	2026-10-06 21:26:22.842856	A310	Alarm Lini Niverplast - Transport System
7516	311	41	2026-10-06 21:26:22.842856	A311	Błąd Lini Niverplst - Transport System
7517	309	39	2026-10-06 21:27:23.072095	A309	Błąd Lini Niverplst - Easy Plast
7518	310	41	2026-10-06 21:27:23.072095	A310	Alarm Lini Niverplast - Transport System
7519	311	41	2026-10-06 21:27:23.072095	A311	Błąd Lini Niverplst - Transport System
7520	309	39	2026-10-06 21:28:23.307115	A309	Błąd Lini Niverplst - Easy Plast
7521	310	41	2026-10-06 21:28:23.307115	A310	Alarm Lini Niverplast - Transport System
7522	311	41	2026-10-06 21:28:23.307115	A311	Błąd Lini Niverplst - Transport System
7523	309	39	2026-10-06 21:29:23.505865	A309	Błąd Lini Niverplst - Easy Plast
7524	310	41	2026-10-06 21:29:23.505865	A310	Alarm Lini Niverplast - Transport System
7525	311	41	2026-10-06 21:29:23.505865	A311	Błąd Lini Niverplst - Transport System
7526	309	39	2026-10-06 21:30:22.106833	A309	Błąd Lini Niverplst - Easy Plast
7527	310	41	2026-10-06 21:30:22.106833	A310	Alarm Lini Niverplast - Transport System
7528	311	41	2026-10-06 21:30:22.106833	A311	Błąd Lini Niverplst - Transport System
7529	309	39	2026-10-06 21:31:22.33227	A309	Błąd Lini Niverplst - Easy Plast
7530	310	41	2026-10-06 21:31:22.33227	A310	Alarm Lini Niverplast - Transport System
7531	311	41	2026-10-06 21:31:22.33227	A311	Błąd Lini Niverplst - Transport System
7532	309	39	2026-10-06 21:32:22.561696	A309	Błąd Lini Niverplst - Easy Plast
7533	310	41	2026-10-06 21:32:22.561696	A310	Alarm Lini Niverplast - Transport System
7534	311	41	2026-10-06 21:32:22.561696	A311	Błąd Lini Niverplst - Transport System
7535	309	39	2026-10-06 21:33:22.768125	A309	Błąd Lini Niverplst - Easy Plast
7536	310	41	2026-10-06 21:33:22.768125	A310	Alarm Lini Niverplast - Transport System
7537	311	41	2026-10-06 21:33:22.768125	A311	Błąd Lini Niverplst - Transport System
7538	309	39	2026-10-06 21:34:22.996409	A309	Błąd Lini Niverplst - Easy Plast
7539	310	41	2026-10-06 21:34:22.996409	A310	Alarm Lini Niverplast - Transport System
7540	311	41	2026-10-06 21:34:22.996409	A311	Błąd Lini Niverplst - Transport System
7541	309	39	2026-10-06 21:35:23.256316	A309	Błąd Lini Niverplst - Easy Plast
7542	310	41	2026-10-06 21:35:23.256316	A310	Alarm Lini Niverplast - Transport System
7543	311	41	2026-10-06 21:35:23.256316	A311	Błąd Lini Niverplst - Transport System
7544	309	39	2026-10-06 21:36:23.467937	A309	Błąd Lini Niverplst - Easy Plast
7545	310	41	2026-10-06 21:36:23.467937	A310	Alarm Lini Niverplast - Transport System
7546	311	41	2026-10-06 21:36:23.467937	A311	Błąd Lini Niverplst - Transport System
7547	309	39	2026-10-06 21:37:24.662094	A309	Błąd Lini Niverplst - Easy Plast
7548	310	41	2026-10-06 21:37:24.662094	A310	Alarm Lini Niverplast - Transport System
7549	311	41	2026-10-06 21:37:24.662094	A311	Błąd Lini Niverplst - Transport System
7550	309	39	2026-10-06 21:38:23.890333	A309	Błąd Lini Niverplst - Easy Plast
7551	310	41	2026-10-06 21:38:23.890333	A310	Alarm Lini Niverplast - Transport System
7552	311	41	2026-10-06 21:38:23.890333	A311	Błąd Lini Niverplst - Transport System
7553	309	39	2026-10-06 21:39:24.114133	A309	Błąd Lini Niverplst - Easy Plast
7554	310	41	2026-10-06 21:39:24.114133	A310	Alarm Lini Niverplast - Transport System
7555	311	41	2026-10-06 21:39:24.114133	A311	Błąd Lini Niverplst - Transport System
7556	309	39	2026-10-06 21:40:22.664072	A309	Błąd Lini Niverplst - Easy Plast
7557	310	41	2026-10-06 21:40:22.664072	A310	Alarm Lini Niverplast - Transport System
7558	311	41	2026-10-06 21:40:22.664072	A311	Błąd Lini Niverplst - Transport System
7559	309	39	2026-10-06 21:41:22.927849	A309	Błąd Lini Niverplst - Easy Plast
7560	310	41	2026-10-06 21:41:22.927849	A310	Alarm Lini Niverplast - Transport System
7561	311	41	2026-10-06 21:41:22.927849	A311	Błąd Lini Niverplst - Transport System
7562	309	39	2026-10-06 21:42:23.142758	A309	Błąd Lini Niverplst - Easy Plast
7563	310	41	2026-10-06 21:42:23.142758	A310	Alarm Lini Niverplast - Transport System
7564	311	41	2026-10-06 21:42:23.142758	A311	Błąd Lini Niverplst - Transport System
7565	309	39	2026-10-06 21:43:23.378576	A309	Błąd Lini Niverplst - Easy Plast
7566	310	41	2026-10-06 21:43:23.378576	A310	Alarm Lini Niverplast - Transport System
7567	311	41	2026-10-06 21:43:23.378576	A311	Błąd Lini Niverplst - Transport System
7568	309	39	2026-10-06 21:44:23.607014	A309	Błąd Lini Niverplst - Easy Plast
7569	310	41	2026-10-06 21:44:23.607014	A310	Alarm Lini Niverplast - Transport System
7570	311	41	2026-10-06 21:44:23.607014	A311	Błąd Lini Niverplst - Transport System
7571	309	39	2026-10-06 21:45:23.83935	A309	Błąd Lini Niverplst - Easy Plast
7572	310	41	2026-10-06 21:45:23.83935	A310	Alarm Lini Niverplast - Transport System
7573	311	41	2026-10-06 21:45:23.83935	A311	Błąd Lini Niverplst - Transport System
7574	309	39	2026-10-06 21:46:25.667916	A309	Błąd Lini Niverplst - Easy Plast
7575	310	41	2026-10-06 21:46:25.667916	A310	Alarm Lini Niverplast - Transport System
7576	311	41	2026-10-06 21:46:25.667916	A311	Błąd Lini Niverplst - Transport System
7577	309	39	2026-10-06 21:47:24.288288	A309	Błąd Lini Niverplst - Easy Plast
7578	310	41	2026-10-06 21:47:24.288288	A310	Alarm Lini Niverplast - Transport System
7579	311	41	2026-10-06 21:47:24.288288	A311	Błąd Lini Niverplst - Transport System
7580	309	39	2026-10-06 21:48:24.507324	A309	Błąd Lini Niverplst - Easy Plast
7581	310	41	2026-10-06 21:48:24.507324	A310	Alarm Lini Niverplast - Transport System
7582	311	41	2026-10-06 21:48:24.507324	A311	Błąd Lini Niverplst - Transport System
7583	309	39	2026-10-06 21:49:23.070045	A309	Błąd Lini Niverplst - Easy Plast
7584	310	41	2026-10-06 21:49:23.070045	A310	Alarm Lini Niverplast - Transport System
7585	311	41	2026-10-06 21:49:23.070045	A311	Błąd Lini Niverplst - Transport System
7586	309	39	2026-10-06 21:50:23.340494	A309	Błąd Lini Niverplst - Easy Plast
7587	310	41	2026-10-06 21:50:23.340494	A310	Alarm Lini Niverplast - Transport System
7588	311	41	2026-10-06 21:50:23.340494	A311	Błąd Lini Niverplst - Transport System
7589	309	39	2026-10-06 21:51:23.525734	A309	Błąd Lini Niverplst - Easy Plast
7590	310	41	2026-10-06 21:51:23.525734	A310	Alarm Lini Niverplast - Transport System
7591	311	41	2026-10-06 21:51:23.525734	A311	Błąd Lini Niverplst - Transport System
7592	309	39	2026-10-06 21:52:23.815338	A309	Błąd Lini Niverplst - Easy Plast
7593	310	41	2026-10-06 21:52:23.815338	A310	Alarm Lini Niverplast - Transport System
7594	311	41	2026-10-06 21:52:23.815338	A311	Błąd Lini Niverplst - Transport System
7595	309	39	2026-10-06 21:53:23.991951	A309	Błąd Lini Niverplst - Easy Plast
7596	310	41	2026-10-06 21:53:23.991951	A310	Alarm Lini Niverplast - Transport System
7597	311	41	2026-10-06 21:53:23.991951	A311	Błąd Lini Niverplst - Transport System
7598	309	39	2026-10-06 21:54:24.248782	A309	Błąd Lini Niverplst - Easy Plast
7599	310	41	2026-10-06 21:54:24.248782	A310	Alarm Lini Niverplast - Transport System
7600	311	41	2026-10-06 21:54:24.248782	A311	Błąd Lini Niverplst - Transport System
7601	309	39	2026-10-06 21:55:24.463147	A309	Błąd Lini Niverplst - Easy Plast
7602	310	41	2026-10-06 21:55:24.463147	A310	Alarm Lini Niverplast - Transport System
7603	311	41	2026-10-06 21:55:24.463147	A311	Błąd Lini Niverplst - Transport System
7604	193	40	2026-10-06 21:56:24.700224	A193	Niskie ciśnienie pneumatyczne - strefa 2
7605	241	40	2026-10-06 21:56:24.700224	A241	Niskie ciśnienie pneumatyczne - strefa 3
7606	309	39	2026-10-06 21:56:24.700224	A309	Błąd Lini Niverplst - Easy Plast
7607	310	41	2026-10-06 21:56:24.700224	A310	Alarm Lini Niverplast - Transport System
7608	311	41	2026-10-06 21:56:24.700224	A311	Błąd Lini Niverplst - Transport System
7609	225	8	2026-10-06 21:56:24.700224	A225	Otwarta Bramka Bezpieczeństwa
7610	226	9	2026-10-06 21:56:24.700224	A226	Niezaryglowany zamek bramki bezpieczenstwa 
7611	309	39	2026-10-06 21:57:24.911635	A309	Błąd Lini Niverplst - Easy Plast
7612	310	41	2026-10-06 21:57:24.911635	A310	Alarm Lini Niverplast - Transport System
7613	311	41	2026-10-06 21:57:24.911635	A311	Błąd Lini Niverplst - Transport System
7614	309	39	2026-10-06 21:58:25.157246	A309	Błąd Lini Niverplst - Easy Plast
7615	310	41	2026-10-06 21:58:25.157246	A310	Alarm Lini Niverplast - Transport System
7616	311	41	2026-10-06 21:58:25.157246	A311	Błąd Lini Niverplst - Transport System
7617	309	39	2026-10-06 21:59:23.742161	A309	Błąd Lini Niverplst - Easy Plast
7618	310	41	2026-10-06 21:59:23.742161	A310	Alarm Lini Niverplast - Transport System
7619	311	41	2026-10-06 21:59:23.742161	A311	Błąd Lini Niverplst - Transport System
7620	309	39	2026-10-06 22:00:23.953873	A309	Błąd Lini Niverplst - Easy Plast
7621	310	41	2026-10-06 22:00:23.953873	A310	Alarm Lini Niverplast - Transport System
7622	311	41	2026-10-06 22:00:23.953873	A311	Błąd Lini Niverplst - Transport System
7623	309	39	2026-10-06 22:01:24.187282	A309	Błąd Lini Niverplst - Easy Plast
7624	310	41	2026-10-06 22:01:24.187282	A310	Alarm Lini Niverplast - Transport System
7625	311	41	2026-10-06 22:01:24.187282	A311	Błąd Lini Niverplst - Transport System
7626	309	39	2026-10-06 22:02:24.408465	A309	Błąd Lini Niverplst - Easy Plast
7627	310	41	2026-10-06 22:02:24.408465	A310	Alarm Lini Niverplast - Transport System
7628	311	41	2026-10-06 22:02:24.408465	A311	Błąd Lini Niverplst - Transport System
7629	309	39	2026-10-06 22:03:24.646834	A309	Błąd Lini Niverplst - Easy Plast
7630	310	41	2026-10-06 22:03:24.646834	A310	Alarm Lini Niverplast - Transport System
7631	311	41	2026-10-06 22:03:24.646834	A311	Błąd Lini Niverplst - Transport System
7632	309	39	2026-10-06 22:04:24.876619	A309	Błąd Lini Niverplst - Easy Plast
7633	310	41	2026-10-06 22:04:24.876619	A310	Alarm Lini Niverplast - Transport System
7634	311	41	2026-10-06 22:04:24.876619	A311	Błąd Lini Niverplst - Transport System
7635	309	39	2026-10-06 22:05:25.102827	A309	Błąd Lini Niverplst - Easy Plast
7636	310	41	2026-10-06 22:05:25.102827	A310	Alarm Lini Niverplast - Transport System
7637	311	41	2026-10-06 22:05:25.102827	A311	Błąd Lini Niverplst - Transport System
7638	309	39	2026-10-06 22:06:25.322693	A309	Błąd Lini Niverplst - Easy Plast
7639	310	41	2026-10-06 22:06:25.322693	A310	Alarm Lini Niverplast - Transport System
7640	311	41	2026-10-06 22:06:25.322693	A311	Błąd Lini Niverplst - Transport System
7641	309	39	2026-10-06 22:07:25.563577	A309	Błąd Lini Niverplst - Easy Plast
7642	310	41	2026-10-06 22:07:25.563577	A310	Alarm Lini Niverplast - Transport System
7643	311	41	2026-10-06 22:07:25.563577	A311	Błąd Lini Niverplst - Transport System
7644	309	39	2026-10-06 22:08:25.766313	A309	Błąd Lini Niverplst - Easy Plast
7645	310	41	2026-10-06 22:08:25.766313	A310	Alarm Lini Niverplast - Transport System
7646	311	41	2026-10-06 22:08:25.766313	A311	Błąd Lini Niverplst - Transport System
7647	309	39	2026-10-06 22:09:24.345226	A309	Błąd Lini Niverplst - Easy Plast
7648	310	41	2026-10-06 22:09:24.345226	A310	Alarm Lini Niverplast - Transport System
7649	311	41	2026-10-06 22:09:24.345226	A311	Błąd Lini Niverplst - Transport System
7650	309	39	2026-10-06 22:10:24.540766	A309	Błąd Lini Niverplst - Easy Plast
7651	310	41	2026-10-06 22:10:24.540766	A310	Alarm Lini Niverplast - Transport System
7652	311	41	2026-10-06 22:10:24.540766	A311	Błąd Lini Niverplst - Transport System
7653	309	39	2026-10-06 22:11:24.796702	A309	Błąd Lini Niverplst - Easy Plast
7654	310	41	2026-10-06 22:11:24.796702	A310	Alarm Lini Niverplast - Transport System
7655	311	41	2026-10-06 22:11:24.796702	A311	Błąd Lini Niverplst - Transport System
7656	309	39	2026-10-06 22:12:25.012038	A309	Błąd Lini Niverplst - Easy Plast
7657	310	41	2026-10-06 22:12:25.012038	A310	Alarm Lini Niverplast - Transport System
7658	311	41	2026-10-06 22:12:25.012038	A311	Błąd Lini Niverplst - Transport System
7659	309	39	2026-10-06 22:13:25.254211	A309	Błąd Lini Niverplst - Easy Plast
7660	310	41	2026-10-06 22:13:25.254211	A310	Alarm Lini Niverplast - Transport System
7661	311	41	2026-10-06 22:13:25.254211	A311	Błąd Lini Niverplst - Transport System
7662	309	39	2026-10-06 22:14:25.412671	A309	Błąd Lini Niverplst - Easy Plast
7663	310	41	2026-10-06 22:14:25.412671	A310	Alarm Lini Niverplast - Transport System
7664	311	41	2026-10-06 22:14:25.412671	A311	Błąd Lini Niverplst - Transport System
7665	309	39	2026-10-06 22:15:25.731643	A309	Błąd Lini Niverplst - Easy Plast
7666	310	41	2026-10-06 22:15:25.731643	A310	Alarm Lini Niverplast - Transport System
7667	311	41	2026-10-06 22:15:25.731643	A311	Błąd Lini Niverplst - Transport System
7668	309	39	2026-10-06 22:16:25.96322	A309	Błąd Lini Niverplst - Easy Plast
7669	310	41	2026-10-06 22:16:25.96322	A310	Alarm Lini Niverplast - Transport System
7670	311	41	2026-10-06 22:16:25.96322	A311	Błąd Lini Niverplst - Transport System
7671	309	39	2026-10-06 22:17:26.190836	A309	Błąd Lini Niverplst - Easy Plast
7672	310	41	2026-10-06 22:17:26.190836	A310	Alarm Lini Niverplast - Transport System
7673	311	41	2026-10-06 22:17:26.190836	A311	Błąd Lini Niverplst - Transport System
7674	309	39	2026-10-06 22:18:26.420143	A309	Błąd Lini Niverplst - Easy Plast
7675	310	41	2026-10-06 22:18:26.420143	A310	Alarm Lini Niverplast - Transport System
7676	311	41	2026-10-06 22:18:26.420143	A311	Błąd Lini Niverplst - Transport System
7677	309	39	2026-10-06 22:19:25.001792	A309	Błąd Lini Niverplst - Easy Plast
7678	310	41	2026-10-06 22:19:25.001792	A310	Alarm Lini Niverplast - Transport System
7679	311	41	2026-10-06 22:19:25.001792	A311	Błąd Lini Niverplst - Transport System
7680	309	39	2026-10-06 22:20:25.221707	A309	Błąd Lini Niverplst - Easy Plast
7681	310	41	2026-10-06 22:20:25.221707	A310	Alarm Lini Niverplast - Transport System
7682	311	41	2026-10-06 22:20:25.221707	A311	Błąd Lini Niverplst - Transport System
7683	309	39	2026-10-06 22:21:25.473614	A309	Błąd Lini Niverplst - Easy Plast
7684	310	41	2026-10-06 22:21:25.473614	A310	Alarm Lini Niverplast - Transport System
7685	311	41	2026-10-06 22:21:25.473614	A311	Błąd Lini Niverplst - Transport System
7686	309	39	2026-10-06 22:22:25.689496	A309	Błąd Lini Niverplst - Easy Plast
7687	310	41	2026-10-06 22:22:25.689496	A310	Alarm Lini Niverplast - Transport System
7688	311	41	2026-10-06 22:22:25.689496	A311	Błąd Lini Niverplst - Transport System
7689	309	39	2026-10-06 22:23:25.889712	A309	Błąd Lini Niverplst - Easy Plast
7690	310	41	2026-10-06 22:23:25.889712	A310	Alarm Lini Niverplast - Transport System
7691	311	41	2026-10-06 22:23:25.889712	A311	Błąd Lini Niverplst - Transport System
7692	309	39	2026-10-06 22:24:26.13458	A309	Błąd Lini Niverplst - Easy Plast
7693	310	41	2026-10-06 22:24:26.13458	A310	Alarm Lini Niverplast - Transport System
7694	311	41	2026-10-06 22:24:26.13458	A311	Błąd Lini Niverplst - Transport System
7695	309	39	2026-10-06 22:25:26.37201	A309	Błąd Lini Niverplst - Easy Plast
7696	310	41	2026-10-06 22:25:26.37201	A310	Alarm Lini Niverplast - Transport System
7697	311	41	2026-10-06 22:25:26.37201	A311	Błąd Lini Niverplst - Transport System
7698	309	39	2026-10-06 22:26:26.60336	A309	Błąd Lini Niverplst - Easy Plast
7699	310	41	2026-10-06 22:26:26.60336	A310	Alarm Lini Niverplast - Transport System
7700	311	41	2026-10-06 22:26:26.60336	A311	Błąd Lini Niverplst - Transport System
7701	309	39	2026-10-06 22:27:26.809397	A309	Błąd Lini Niverplst - Easy Plast
7702	310	41	2026-10-06 22:27:26.809397	A310	Alarm Lini Niverplast - Transport System
7703	311	41	2026-10-06 22:27:26.809397	A311	Błąd Lini Niverplst - Transport System
7704	309	39	2026-10-06 22:28:25.422957	A309	Błąd Lini Niverplst - Easy Plast
7705	310	41	2026-10-06 22:28:25.422957	A310	Alarm Lini Niverplast - Transport System
7706	311	41	2026-10-06 22:28:25.422957	A311	Błąd Lini Niverplst - Transport System
7707	309	39	2026-10-06 22:29:25.60754	A309	Błąd Lini Niverplst - Easy Plast
7708	310	41	2026-10-06 22:29:25.60754	A310	Alarm Lini Niverplast - Transport System
7709	311	41	2026-10-06 22:29:25.60754	A311	Błąd Lini Niverplst - Transport System
7710	309	39	2026-10-06 22:30:25.890415	A309	Błąd Lini Niverplst - Easy Plast
7711	310	41	2026-10-06 22:30:25.890415	A310	Alarm Lini Niverplast - Transport System
7712	311	41	2026-10-06 22:30:25.890415	A311	Błąd Lini Niverplst - Transport System
7713	309	39	2026-10-06 22:31:26.396541	A309	Błąd Lini Niverplst - Easy Plast
7714	310	41	2026-10-06 22:31:26.396541	A310	Alarm Lini Niverplast - Transport System
7715	311	41	2026-10-06 22:31:26.396541	A311	Błąd Lini Niverplst - Transport System
7716	309	39	2026-10-06 22:32:26.267969	A309	Błąd Lini Niverplst - Easy Plast
7717	310	41	2026-10-06 22:32:26.267969	A310	Alarm Lini Niverplast - Transport System
7718	311	41	2026-10-06 22:32:26.267969	A311	Błąd Lini Niverplst - Transport System
7719	309	39	2026-10-06 22:33:26.56368	A309	Błąd Lini Niverplst - Easy Plast
7720	310	41	2026-10-06 22:33:26.56368	A310	Alarm Lini Niverplast - Transport System
7721	311	41	2026-10-06 22:33:26.56368	A311	Błąd Lini Niverplst - Transport System
7722	309	39	2026-10-06 22:34:26.77853	A309	Błąd Lini Niverplst - Easy Plast
7723	310	41	2026-10-06 22:34:26.77853	A310	Alarm Lini Niverplast - Transport System
7724	311	41	2026-10-06 22:34:26.77853	A311	Błąd Lini Niverplst - Transport System
7725	309	39	2026-10-06 22:35:27.015414	A309	Błąd Lini Niverplst - Easy Plast
7726	310	41	2026-10-06 22:35:27.015414	A310	Alarm Lini Niverplast - Transport System
7727	311	41	2026-10-06 22:35:27.015414	A311	Błąd Lini Niverplst - Transport System
7728	309	39	2026-10-06 22:36:27.240424	A309	Błąd Lini Niverplst - Easy Plast
7729	310	41	2026-10-06 22:36:27.240424	A310	Alarm Lini Niverplast - Transport System
7730	311	41	2026-10-06 22:36:27.240424	A311	Błąd Lini Niverplst - Transport System
7731	309	39	2026-10-06 22:37:27.47653	A309	Błąd Lini Niverplst - Easy Plast
7732	310	41	2026-10-06 22:37:27.47653	A310	Alarm Lini Niverplast - Transport System
7733	311	41	2026-10-06 22:37:27.47653	A311	Błąd Lini Niverplst - Transport System
7734	309	39	2026-10-06 22:38:26.029382	A309	Błąd Lini Niverplst - Easy Plast
7735	310	41	2026-10-06 22:38:26.029382	A310	Alarm Lini Niverplast - Transport System
7736	311	41	2026-10-06 22:38:26.029382	A311	Błąd Lini Niverplst - Transport System
7737	309	39	2026-10-06 22:39:26.242111	A309	Błąd Lini Niverplst - Easy Plast
7738	310	41	2026-10-06 22:39:26.242111	A310	Alarm Lini Niverplast - Transport System
7739	311	41	2026-10-06 22:39:26.242111	A311	Błąd Lini Niverplst - Transport System
7740	309	39	2026-10-06 22:40:26.516226	A309	Błąd Lini Niverplst - Easy Plast
7741	310	41	2026-10-06 22:40:26.516226	A310	Alarm Lini Niverplast - Transport System
7742	311	41	2026-10-06 22:40:26.516226	A311	Błąd Lini Niverplst - Transport System
7743	309	39	2026-10-06 22:41:26.725575	A309	Błąd Lini Niverplst - Easy Plast
7744	310	41	2026-10-06 22:41:26.725575	A310	Alarm Lini Niverplast - Transport System
7745	311	41	2026-10-06 22:41:26.725575	A311	Błąd Lini Niverplst - Transport System
7746	309	39	2026-10-06 22:42:26.993958	A309	Błąd Lini Niverplst - Easy Plast
7747	310	41	2026-10-06 22:42:26.993958	A310	Alarm Lini Niverplast - Transport System
7748	311	41	2026-10-06 22:42:26.993958	A311	Błąd Lini Niverplst - Transport System
7749	309	39	2026-10-06 22:43:27.214421	A309	Błąd Lini Niverplst - Easy Plast
7750	310	41	2026-10-06 22:43:27.214421	A310	Alarm Lini Niverplast - Transport System
7751	311	41	2026-10-06 22:43:27.214421	A311	Błąd Lini Niverplst - Transport System
7752	309	39	2026-10-06 22:44:27.447571	A309	Błąd Lini Niverplst - Easy Plast
7753	310	41	2026-10-06 22:44:27.447571	A310	Alarm Lini Niverplast - Transport System
7754	311	41	2026-10-06 22:44:27.447571	A311	Błąd Lini Niverplst - Transport System
7755	309	39	2026-10-06 22:45:27.671415	A309	Błąd Lini Niverplst - Easy Plast
7756	310	41	2026-10-06 22:45:27.671415	A310	Alarm Lini Niverplast - Transport System
7757	311	41	2026-10-06 22:45:27.671415	A311	Błąd Lini Niverplst - Transport System
7758	309	39	2026-10-06 22:46:27.930108	A309	Błąd Lini Niverplst - Easy Plast
7759	310	41	2026-10-06 22:46:27.930108	A310	Alarm Lini Niverplast - Transport System
7760	311	41	2026-10-06 22:46:27.930108	A311	Błąd Lini Niverplst - Transport System
7761	309	39	2026-10-06 22:47:26.465742	A309	Błąd Lini Niverplst - Easy Plast
7762	310	41	2026-10-06 22:47:26.465742	A310	Alarm Lini Niverplast - Transport System
7763	311	41	2026-10-06 22:47:26.465742	A311	Błąd Lini Niverplst - Transport System
7764	309	39	2026-10-06 22:48:26.644503	A309	Błąd Lini Niverplst - Easy Plast
7765	310	41	2026-10-06 22:48:26.644503	A310	Alarm Lini Niverplast - Transport System
7766	311	41	2026-10-06 22:48:26.644503	A311	Błąd Lini Niverplst - Transport System
7767	309	39	2026-10-06 22:49:26.921382	A309	Błąd Lini Niverplst - Easy Plast
7768	310	41	2026-10-06 22:49:26.921382	A310	Alarm Lini Niverplast - Transport System
7769	311	41	2026-10-06 22:49:26.921382	A311	Błąd Lini Niverplst - Transport System
7770	309	39	2026-10-06 22:50:27.147226	A309	Błąd Lini Niverplst - Easy Plast
7771	310	41	2026-10-06 22:50:27.147226	A310	Alarm Lini Niverplast - Transport System
7772	311	41	2026-10-06 22:50:27.147226	A311	Błąd Lini Niverplst - Transport System
7773	309	39	2026-10-06 22:51:27.394724	A309	Błąd Lini Niverplst - Easy Plast
7774	310	41	2026-10-06 22:51:27.394724	A310	Alarm Lini Niverplast - Transport System
7775	311	41	2026-10-06 22:51:27.394724	A311	Błąd Lini Niverplst - Transport System
7776	309	39	2026-10-06 22:52:27.646137	A309	Błąd Lini Niverplst - Easy Plast
7777	310	41	2026-10-06 22:52:27.646137	A310	Alarm Lini Niverplast - Transport System
7778	311	41	2026-10-06 22:52:27.646137	A311	Błąd Lini Niverplst - Transport System
7779	309	39	2026-10-06 22:53:27.878177	A309	Błąd Lini Niverplst - Easy Plast
7780	310	41	2026-10-06 22:53:27.878177	A310	Alarm Lini Niverplast - Transport System
7781	311	41	2026-10-06 22:53:27.878177	A311	Błąd Lini Niverplst - Transport System
7782	309	39	2026-10-06 22:54:28.094655	A309	Błąd Lini Niverplst - Easy Plast
7783	310	41	2026-10-06 22:54:28.094655	A310	Alarm Lini Niverplast - Transport System
7784	311	41	2026-10-06 22:54:28.094655	A311	Błąd Lini Niverplst - Transport System
7785	309	39	2026-10-06 22:55:28.385855	A309	Błąd Lini Niverplst - Easy Plast
7786	310	41	2026-10-06 22:55:28.385855	A310	Alarm Lini Niverplast - Transport System
7787	311	41	2026-10-06 22:55:28.385855	A311	Błąd Lini Niverplst - Transport System
7788	309	39	2026-10-06 22:56:28.562786	A309	Błąd Lini Niverplst - Easy Plast
7789	310	41	2026-10-06 22:56:28.562786	A310	Alarm Lini Niverplast - Transport System
7790	311	41	2026-10-06 22:56:28.562786	A311	Błąd Lini Niverplst - Transport System
7791	309	39	2026-10-06 22:57:27.086412	A309	Błąd Lini Niverplst - Easy Plast
7792	310	41	2026-10-06 22:57:27.086412	A310	Alarm Lini Niverplast - Transport System
7793	311	41	2026-10-06 22:57:27.086412	A311	Błąd Lini Niverplst - Transport System
7794	309	39	2026-10-06 22:58:27.358762	A309	Błąd Lini Niverplst - Easy Plast
7795	310	41	2026-10-06 22:58:27.358762	A310	Alarm Lini Niverplast - Transport System
7796	311	41	2026-10-06 22:58:27.358762	A311	Błąd Lini Niverplst - Transport System
7797	309	39	2026-10-06 22:59:27.571703	A309	Błąd Lini Niverplst - Easy Plast
7798	310	41	2026-10-06 22:59:27.571703	A310	Alarm Lini Niverplast - Transport System
7799	311	41	2026-10-06 22:59:27.571703	A311	Błąd Lini Niverplst - Transport System
7800	309	39	2026-10-06 23:00:27.82876	A309	Błąd Lini Niverplst - Easy Plast
7801	310	41	2026-10-06 23:00:27.82876	A310	Alarm Lini Niverplast - Transport System
7802	311	41	2026-10-06 23:00:27.82876	A311	Błąd Lini Niverplst - Transport System
7803	309	39	2026-10-06 23:01:28.050573	A309	Błąd Lini Niverplst - Easy Plast
7804	310	41	2026-10-06 23:01:28.050573	A310	Alarm Lini Niverplast - Transport System
7805	311	41	2026-10-06 23:01:28.050573	A311	Błąd Lini Niverplst - Transport System
7806	309	39	2026-10-06 23:02:28.313706	A309	Błąd Lini Niverplst - Easy Plast
7807	310	41	2026-10-06 23:02:28.313706	A310	Alarm Lini Niverplast - Transport System
7808	311	41	2026-10-06 23:02:28.313706	A311	Błąd Lini Niverplst - Transport System
7809	309	39	2026-10-06 23:03:28.522379	A309	Błąd Lini Niverplst - Easy Plast
7810	310	41	2026-10-06 23:03:28.522379	A310	Alarm Lini Niverplast - Transport System
7811	311	41	2026-10-06 23:03:28.522379	A311	Błąd Lini Niverplst - Transport System
7812	309	39	2026-10-06 23:04:28.775314	A309	Błąd Lini Niverplst - Easy Plast
7813	310	41	2026-10-06 23:04:28.775314	A310	Alarm Lini Niverplast - Transport System
7814	311	41	2026-10-06 23:04:28.775314	A311	Błąd Lini Niverplst - Transport System
7815	309	39	2026-10-06 23:05:29.009477	A309	Błąd Lini Niverplst - Easy Plast
7816	310	41	2026-10-06 23:05:29.009477	A310	Alarm Lini Niverplast - Transport System
7817	311	41	2026-10-06 23:05:29.009477	A311	Błąd Lini Niverplst - Transport System
7818	309	39	2026-10-06 23:06:27.52362	A309	Błąd Lini Niverplst - Easy Plast
7819	310	41	2026-10-06 23:06:27.52362	A310	Alarm Lini Niverplast - Transport System
7820	311	41	2026-10-06 23:06:27.52362	A311	Błąd Lini Niverplst - Transport System
7821	309	39	2026-10-06 23:07:27.78459	A309	Błąd Lini Niverplst - Easy Plast
7822	310	41	2026-10-06 23:07:27.78459	A310	Alarm Lini Niverplast - Transport System
7823	311	41	2026-10-06 23:07:27.78459	A311	Błąd Lini Niverplst - Transport System
7824	309	39	2026-10-06 23:08:28.018654	A309	Błąd Lini Niverplst - Easy Plast
7825	310	41	2026-10-06 23:08:28.018654	A310	Alarm Lini Niverplast - Transport System
7826	311	41	2026-10-06 23:08:28.018654	A311	Błąd Lini Niverplst - Transport System
7827	309	39	2026-10-06 23:09:28.267514	A309	Błąd Lini Niverplst - Easy Plast
7828	310	41	2026-10-06 23:09:28.267514	A310	Alarm Lini Niverplast - Transport System
7829	311	41	2026-10-06 23:09:28.267514	A311	Błąd Lini Niverplst - Transport System
7830	309	39	2026-10-06 23:10:28.515711	A309	Błąd Lini Niverplst - Easy Plast
7831	310	41	2026-10-06 23:10:28.515711	A310	Alarm Lini Niverplast - Transport System
7832	311	41	2026-10-06 23:10:28.515711	A311	Błąd Lini Niverplst - Transport System
7833	309	39	2026-10-06 23:11:28.741116	A309	Błąd Lini Niverplst - Easy Plast
7834	310	41	2026-10-06 23:11:28.741116	A310	Alarm Lini Niverplast - Transport System
7835	311	41	2026-10-06 23:11:28.741116	A311	Błąd Lini Niverplst - Transport System
7836	309	39	2026-10-06 23:12:28.96929	A309	Błąd Lini Niverplst - Easy Plast
7837	310	41	2026-10-06 23:12:28.96929	A310	Alarm Lini Niverplast - Transport System
7838	311	41	2026-10-06 23:12:28.96929	A311	Błąd Lini Niverplst - Transport System
7839	309	39	2026-10-06 23:13:29.230358	A309	Błąd Lini Niverplst - Easy Plast
7840	310	41	2026-10-06 23:13:29.230358	A310	Alarm Lini Niverplast - Transport System
7841	311	41	2026-10-06 23:13:29.230358	A311	Błąd Lini Niverplst - Transport System
7842	309	39	2026-10-06 23:14:29.446313	A309	Błąd Lini Niverplst - Easy Plast
7843	310	41	2026-10-06 23:14:29.446313	A310	Alarm Lini Niverplast - Transport System
7844	311	41	2026-10-06 23:14:29.446313	A311	Błąd Lini Niverplst - Transport System
7845	309	39	2026-10-06 23:15:29.672393	A309	Błąd Lini Niverplst - Easy Plast
7846	310	41	2026-10-06 23:15:29.672393	A310	Alarm Lini Niverplast - Transport System
7847	311	41	2026-10-06 23:15:29.672393	A311	Błąd Lini Niverplst - Transport System
7848	309	39	2026-10-06 23:16:28.219048	A309	Błąd Lini Niverplst - Easy Plast
7849	310	41	2026-10-06 23:16:28.219048	A310	Alarm Lini Niverplast - Transport System
7850	311	41	2026-10-06 23:16:28.219048	A311	Błąd Lini Niverplst - Transport System
7851	309	39	2026-10-06 23:17:28.442165	A309	Błąd Lini Niverplst - Easy Plast
7852	310	41	2026-10-06 23:17:28.442165	A310	Alarm Lini Niverplast - Transport System
7853	311	41	2026-10-06 23:17:28.442165	A311	Błąd Lini Niverplst - Transport System
7854	309	39	2026-10-06 23:18:28.658243	A309	Błąd Lini Niverplst - Easy Plast
7855	310	41	2026-10-06 23:18:28.658243	A310	Alarm Lini Niverplast - Transport System
7856	311	41	2026-10-06 23:18:28.658243	A311	Błąd Lini Niverplst - Transport System
7857	309	39	2026-10-06 23:19:28.92272	A309	Błąd Lini Niverplst - Easy Plast
7858	310	41	2026-10-06 23:19:28.92272	A310	Alarm Lini Niverplast - Transport System
7859	311	41	2026-10-06 23:19:28.92272	A311	Błąd Lini Niverplst - Transport System
7860	309	39	2026-10-06 23:20:29.160826	A309	Błąd Lini Niverplst - Easy Plast
7861	310	41	2026-10-06 23:20:29.160826	A310	Alarm Lini Niverplast - Transport System
7862	311	41	2026-10-06 23:20:29.160826	A311	Błąd Lini Niverplst - Transport System
7863	309	39	2026-10-06 23:21:29.404979	A309	Błąd Lini Niverplst - Easy Plast
7864	310	41	2026-10-06 23:21:29.404979	A310	Alarm Lini Niverplast - Transport System
7865	311	41	2026-10-06 23:21:29.404979	A311	Błąd Lini Niverplst - Transport System
7866	309	39	2026-10-06 23:22:29.671593	A309	Błąd Lini Niverplst - Easy Plast
7867	310	41	2026-10-06 23:22:29.671593	A310	Alarm Lini Niverplast - Transport System
7868	311	41	2026-10-06 23:22:29.671593	A311	Błąd Lini Niverplst - Transport System
7869	309	39	2026-10-06 23:23:29.895427	A309	Błąd Lini Niverplst - Easy Plast
7870	310	41	2026-10-06 23:23:29.895427	A310	Alarm Lini Niverplast - Transport System
7871	311	41	2026-10-06 23:23:29.895427	A311	Błąd Lini Niverplst - Transport System
7872	309	39	2026-10-06 23:24:30.128059	A309	Błąd Lini Niverplst - Easy Plast
7873	310	41	2026-10-06 23:24:30.128059	A310	Alarm Lini Niverplast - Transport System
7874	311	41	2026-10-06 23:24:30.128059	A311	Błąd Lini Niverplst - Transport System
7875	309	39	2026-10-06 23:25:29.60483	A309	Błąd Lini Niverplst - Easy Plast
7876	310	41	2026-10-06 23:25:29.60483	A310	Alarm Lini Niverplast - Transport System
7877	311	41	2026-10-06 23:25:29.60483	A311	Błąd Lini Niverplst - Transport System
7878	309	39	2026-10-06 23:26:28.83789	A309	Błąd Lini Niverplst - Easy Plast
7879	310	41	2026-10-06 23:26:28.83789	A310	Alarm Lini Niverplast - Transport System
7880	311	41	2026-10-06 23:26:28.83789	A311	Błąd Lini Niverplst - Transport System
7881	309	39	2026-10-06 23:27:29.168747	A309	Błąd Lini Niverplst - Easy Plast
7882	310	41	2026-10-06 23:27:29.168747	A310	Alarm Lini Niverplast - Transport System
7883	311	41	2026-10-06 23:27:29.168747	A311	Błąd Lini Niverplst - Transport System
7884	309	39	2026-10-06 23:28:29.380607	A309	Błąd Lini Niverplst - Easy Plast
7885	310	41	2026-10-06 23:28:29.380607	A310	Alarm Lini Niverplast - Transport System
7886	311	41	2026-10-06 23:28:29.380607	A311	Błąd Lini Niverplst - Transport System
7887	309	39	2026-10-06 23:29:29.647577	A309	Błąd Lini Niverplst - Easy Plast
7888	310	41	2026-10-06 23:29:29.647577	A310	Alarm Lini Niverplast - Transport System
7889	311	41	2026-10-06 23:29:29.647577	A311	Błąd Lini Niverplst - Transport System
7890	309	39	2026-10-06 23:30:29.884113	A309	Błąd Lini Niverplst - Easy Plast
7891	310	41	2026-10-06 23:30:29.884113	A310	Alarm Lini Niverplast - Transport System
7892	311	41	2026-10-06 23:30:29.884113	A311	Błąd Lini Niverplst - Transport System
7893	309	39	2026-10-06 23:31:30.143294	A309	Błąd Lini Niverplst - Easy Plast
7894	310	41	2026-10-06 23:31:30.143294	A310	Alarm Lini Niverplast - Transport System
7895	311	41	2026-10-06 23:31:30.143294	A311	Błąd Lini Niverplst - Transport System
7896	309	39	2026-10-06 23:32:30.363539	A309	Błąd Lini Niverplst - Easy Plast
7897	310	41	2026-10-06 23:32:30.363539	A310	Alarm Lini Niverplast - Transport System
7898	311	41	2026-10-06 23:32:30.363539	A311	Błąd Lini Niverplst - Transport System
7899	309	39	2026-10-06 23:33:30.593167	A309	Błąd Lini Niverplst - Easy Plast
7900	310	41	2026-10-06 23:33:30.593167	A310	Alarm Lini Niverplast - Transport System
7901	311	41	2026-10-06 23:33:30.593167	A311	Błąd Lini Niverplst - Transport System
7902	309	39	2026-10-06 23:34:30.831945	A309	Błąd Lini Niverplst - Easy Plast
7903	310	41	2026-10-06 23:34:30.831945	A310	Alarm Lini Niverplast - Transport System
7904	311	41	2026-10-06 23:34:30.831945	A311	Błąd Lini Niverplst - Transport System
7905	309	39	2026-10-06 23:35:29.344553	A309	Błąd Lini Niverplst - Easy Plast
7906	310	41	2026-10-06 23:35:29.344553	A310	Alarm Lini Niverplast - Transport System
7907	311	41	2026-10-06 23:35:29.344553	A311	Błąd Lini Niverplst - Transport System
7908	309	39	2026-10-06 23:36:29.670128	A309	Błąd Lini Niverplst - Easy Plast
7909	310	41	2026-10-06 23:36:29.670128	A310	Alarm Lini Niverplast - Transport System
7910	311	41	2026-10-06 23:36:29.670128	A311	Błąd Lini Niverplst - Transport System
7911	309	39	2026-10-06 23:37:29.836752	A309	Błąd Lini Niverplst - Easy Plast
7912	310	41	2026-10-06 23:37:29.836752	A310	Alarm Lini Niverplast - Transport System
7913	311	41	2026-10-06 23:37:29.836752	A311	Błąd Lini Niverplst - Transport System
7914	309	39	2026-10-06 23:38:30.126464	A309	Błąd Lini Niverplst - Easy Plast
7915	310	41	2026-10-06 23:38:30.126464	A310	Alarm Lini Niverplast - Transport System
7916	311	41	2026-10-06 23:38:30.126464	A311	Błąd Lini Niverplst - Transport System
7917	309	39	2026-10-06 23:39:30.324968	A309	Błąd Lini Niverplst - Easy Plast
7918	310	41	2026-10-06 23:39:30.324968	A310	Alarm Lini Niverplast - Transport System
7919	311	41	2026-10-06 23:39:30.324968	A311	Błąd Lini Niverplst - Transport System
7920	309	39	2026-10-06 23:40:30.605616	A309	Błąd Lini Niverplst - Easy Plast
7921	310	41	2026-10-06 23:40:30.605616	A310	Alarm Lini Niverplast - Transport System
7922	311	41	2026-10-06 23:40:30.605616	A311	Błąd Lini Niverplst - Transport System
7923	309	39	2026-10-06 23:41:30.831558	A309	Błąd Lini Niverplst - Easy Plast
7924	310	41	2026-10-06 23:41:30.831558	A310	Alarm Lini Niverplast - Transport System
7925	311	41	2026-10-06 23:41:30.831558	A311	Błąd Lini Niverplst - Transport System
7926	309	39	2026-10-06 23:42:31.063766	A309	Błąd Lini Niverplst - Easy Plast
7927	310	41	2026-10-06 23:42:31.063766	A310	Alarm Lini Niverplast - Transport System
7928	311	41	2026-10-06 23:42:31.063766	A311	Błąd Lini Niverplst - Transport System
7929	309	39	2026-10-06 23:43:31.309467	A309	Błąd Lini Niverplst - Easy Plast
7930	310	41	2026-10-06 23:43:31.309467	A310	Alarm Lini Niverplast - Transport System
7931	311	41	2026-10-06 23:43:31.309467	A311	Błąd Lini Niverplst - Transport System
7932	309	39	2026-10-06 23:44:29.808209	A309	Błąd Lini Niverplst - Easy Plast
7933	310	41	2026-10-06 23:44:29.808209	A310	Alarm Lini Niverplast - Transport System
7934	311	41	2026-10-06 23:44:29.808209	A311	Błąd Lini Niverplst - Transport System
7935	309	39	2026-10-06 23:45:30.008694	A309	Błąd Lini Niverplst - Easy Plast
7936	310	41	2026-10-06 23:45:30.008694	A310	Alarm Lini Niverplast - Transport System
7937	311	41	2026-10-06 23:45:30.008694	A311	Błąd Lini Niverplst - Transport System
7938	309	39	2026-10-06 23:46:30.310552	A309	Błąd Lini Niverplst - Easy Plast
7939	310	41	2026-10-06 23:46:30.310552	A310	Alarm Lini Niverplast - Transport System
7940	311	41	2026-10-06 23:46:30.310552	A311	Błąd Lini Niverplst - Transport System
7941	309	39	2026-10-06 23:47:30.537488	A309	Błąd Lini Niverplst - Easy Plast
7942	310	41	2026-10-06 23:47:30.537488	A310	Alarm Lini Niverplast - Transport System
7943	311	41	2026-10-06 23:47:30.537488	A311	Błąd Lini Niverplst - Transport System
7944	309	39	2026-10-06 23:48:30.809774	A309	Błąd Lini Niverplst - Easy Plast
7945	310	41	2026-10-06 23:48:30.809774	A310	Alarm Lini Niverplast - Transport System
7946	311	41	2026-10-06 23:48:30.809774	A311	Błąd Lini Niverplst - Transport System
7947	309	39	2026-10-06 23:49:31.055433	A309	Błąd Lini Niverplst - Easy Plast
7948	310	41	2026-10-06 23:49:31.055433	A310	Alarm Lini Niverplast - Transport System
7949	311	41	2026-10-06 23:49:31.055433	A311	Błąd Lini Niverplst - Transport System
7950	309	39	2026-10-06 23:50:31.293601	A309	Błąd Lini Niverplst - Easy Plast
7951	310	41	2026-10-06 23:50:31.293601	A310	Alarm Lini Niverplast - Transport System
7952	311	41	2026-10-06 23:50:31.293601	A311	Błąd Lini Niverplst - Transport System
7953	309	39	2026-10-06 23:51:31.536611	A309	Błąd Lini Niverplst - Easy Plast
7954	310	41	2026-10-06 23:51:31.536611	A310	Alarm Lini Niverplast - Transport System
7955	311	41	2026-10-06 23:51:31.536611	A311	Błąd Lini Niverplst - Transport System
7956	309	39	2026-10-06 23:52:31.769398	A309	Błąd Lini Niverplst - Easy Plast
7957	310	41	2026-10-06 23:52:31.769398	A310	Alarm Lini Niverplast - Transport System
7958	311	41	2026-10-06 23:52:31.769398	A311	Błąd Lini Niverplst - Transport System
7959	309	39	2026-10-06 23:53:30.276859	A309	Błąd Lini Niverplst - Easy Plast
7960	310	41	2026-10-06 23:53:30.276859	A310	Alarm Lini Niverplast - Transport System
7961	311	41	2026-10-06 23:53:30.276859	A311	Błąd Lini Niverplst - Transport System
7962	309	39	2026-10-06 23:54:30.5384	A309	Błąd Lini Niverplst - Easy Plast
7963	310	41	2026-10-06 23:54:30.5384	A310	Alarm Lini Niverplast - Transport System
7964	311	41	2026-10-06 23:54:30.5384	A311	Błąd Lini Niverplst - Transport System
7965	309	39	2026-10-06 23:55:30.771337	A309	Błąd Lini Niverplst - Easy Plast
7966	310	41	2026-10-06 23:55:30.771337	A310	Alarm Lini Niverplast - Transport System
7967	311	41	2026-10-06 23:55:30.771337	A311	Błąd Lini Niverplst - Transport System
7968	309	39	2026-10-06 23:56:31.017048	A309	Błąd Lini Niverplst - Easy Plast
7969	310	41	2026-10-06 23:56:31.017048	A310	Alarm Lini Niverplast - Transport System
7970	311	41	2026-10-06 23:56:31.017048	A311	Błąd Lini Niverplst - Transport System
7971	309	39	2026-10-06 23:57:31.28583	A309	Błąd Lini Niverplst - Easy Plast
7972	310	41	2026-10-06 23:57:31.28583	A310	Alarm Lini Niverplast - Transport System
7973	311	41	2026-10-06 23:57:31.28583	A311	Błąd Lini Niverplst - Transport System
7974	309	39	2026-10-06 23:58:31.526813	A309	Błąd Lini Niverplst - Easy Plast
7975	310	41	2026-10-06 23:58:31.526813	A310	Alarm Lini Niverplast - Transport System
7976	311	41	2026-10-06 23:58:31.526813	A311	Błąd Lini Niverplst - Transport System
7977	309	39	2026-10-06 23:59:31.792392	A309	Błąd Lini Niverplst - Easy Plast
7978	310	41	2026-10-06 23:59:31.792392	A310	Alarm Lini Niverplast - Transport System
7979	311	41	2026-10-06 23:59:31.792392	A311	Błąd Lini Niverplst - Transport System
7980	309	39	2026-10-07 00:00:32.010878	A309	Błąd Lini Niverplst - Easy Plast
7981	310	41	2026-10-07 00:00:32.010878	A310	Alarm Lini Niverplast - Transport System
7982	311	41	2026-10-07 00:00:32.010878	A311	Błąd Lini Niverplst - Transport System
7983	309	39	2026-10-07 00:01:32.264085	A309	Błąd Lini Niverplst - Easy Plast
7984	310	41	2026-10-07 00:01:32.264085	A310	Alarm Lini Niverplast - Transport System
7985	311	41	2026-10-07 00:01:32.264085	A311	Błąd Lini Niverplst - Transport System
7986	309	39	2026-10-07 00:02:30.765351	A309	Błąd Lini Niverplst - Easy Plast
7987	310	41	2026-10-07 00:02:30.765351	A310	Alarm Lini Niverplast - Transport System
7988	311	41	2026-10-07 00:02:30.765351	A311	Błąd Lini Niverplst - Transport System
7989	309	39	2026-10-07 00:03:31.031379	A309	Błąd Lini Niverplst - Easy Plast
7990	310	41	2026-10-07 00:03:31.031379	A310	Alarm Lini Niverplast - Transport System
7991	311	41	2026-10-07 00:03:31.031379	A311	Błąd Lini Niverplst - Transport System
7992	309	39	2026-10-07 00:04:31.193252	A309	Błąd Lini Niverplst - Easy Plast
7993	310	41	2026-10-07 00:04:31.193252	A310	Alarm Lini Niverplast - Transport System
7994	311	41	2026-10-07 00:04:31.193252	A311	Błąd Lini Niverplst - Transport System
7995	309	39	2026-10-07 00:05:31.477685	A309	Błąd Lini Niverplst - Easy Plast
7996	310	41	2026-10-07 00:05:31.477685	A310	Alarm Lini Niverplast - Transport System
7997	311	41	2026-10-07 00:05:31.477685	A311	Błąd Lini Niverplst - Transport System
7998	309	39	2026-10-07 00:06:31.745937	A309	Błąd Lini Niverplst - Easy Plast
7999	310	41	2026-10-07 00:06:31.745937	A310	Alarm Lini Niverplast - Transport System
8000	311	41	2026-10-07 00:06:31.745937	A311	Błąd Lini Niverplst - Transport System
8001	309	39	2026-10-07 00:07:32.000919	A309	Błąd Lini Niverplst - Easy Plast
8002	310	41	2026-10-07 00:07:32.000919	A310	Alarm Lini Niverplast - Transport System
8003	311	41	2026-10-07 00:07:32.000919	A311	Błąd Lini Niverplst - Transport System
8004	309	39	2026-10-07 00:08:32.363087	A309	Błąd Lini Niverplst - Easy Plast
8005	310	41	2026-10-07 00:08:32.363087	A310	Alarm Lini Niverplast - Transport System
8006	311	41	2026-10-07 00:08:32.363087	A311	Błąd Lini Niverplst - Transport System
8007	309	39	2026-10-07 00:09:32.501116	A309	Błąd Lini Niverplst - Easy Plast
8008	310	41	2026-10-07 00:09:32.501116	A310	Alarm Lini Niverplast - Transport System
8009	311	41	2026-10-07 00:09:32.501116	A311	Błąd Lini Niverplst - Transport System
8010	309	39	2026-10-07 00:10:32.751179	A309	Błąd Lini Niverplst - Easy Plast
8011	310	41	2026-10-07 00:10:32.751179	A310	Alarm Lini Niverplast - Transport System
8012	311	41	2026-10-07 00:10:32.751179	A311	Błąd Lini Niverplst - Transport System
8013	309	39	2026-10-07 00:11:31.178217	A309	Błąd Lini Niverplst - Easy Plast
8014	310	41	2026-10-07 00:11:31.178217	A310	Alarm Lini Niverplast - Transport System
8015	311	41	2026-10-07 00:11:31.178217	A311	Błąd Lini Niverplst - Transport System
8016	309	39	2026-10-07 00:12:31.517048	A309	Błąd Lini Niverplst - Easy Plast
8017	310	41	2026-10-07 00:12:31.517048	A310	Alarm Lini Niverplast - Transport System
8018	311	41	2026-10-07 00:12:31.517048	A311	Błąd Lini Niverplst - Transport System
8019	309	39	2026-10-07 00:13:31.679947	A309	Błąd Lini Niverplst - Easy Plast
8020	310	41	2026-10-07 00:13:31.679947	A310	Alarm Lini Niverplast - Transport System
8021	311	41	2026-10-07 00:13:31.679947	A311	Błąd Lini Niverplst - Transport System
8022	309	39	2026-10-07 00:14:32.009302	A309	Błąd Lini Niverplst - Easy Plast
8023	310	41	2026-10-07 00:14:32.009302	A310	Alarm Lini Niverplast - Transport System
8024	311	41	2026-10-07 00:14:32.009302	A311	Błąd Lini Niverplst - Transport System
8025	309	39	2026-10-07 00:15:32.230311	A309	Błąd Lini Niverplst - Easy Plast
8026	310	41	2026-10-07 00:15:32.230311	A310	Alarm Lini Niverplast - Transport System
8027	311	41	2026-10-07 00:15:32.230311	A311	Błąd Lini Niverplst - Transport System
8028	309	39	2026-10-07 00:16:32.509415	A309	Błąd Lini Niverplst - Easy Plast
8029	310	41	2026-10-07 00:16:32.509415	A310	Alarm Lini Niverplast - Transport System
8030	311	41	2026-10-07 00:16:32.509415	A311	Błąd Lini Niverplst - Transport System
8031	309	39	2026-10-07 00:17:32.767852	A309	Błąd Lini Niverplst - Easy Plast
8032	310	41	2026-10-07 00:17:32.767852	A310	Alarm Lini Niverplast - Transport System
8033	311	41	2026-10-07 00:17:32.767852	A311	Błąd Lini Niverplst - Transport System
8034	309	39	2026-10-07 00:18:32.793475	A309	Błąd Lini Niverplst - Easy Plast
8035	310	41	2026-10-07 00:18:32.793475	A310	Alarm Lini Niverplast - Transport System
8036	311	41	2026-10-07 00:18:32.793475	A311	Błąd Lini Niverplst - Transport System
8037	309	39	2026-10-07 00:19:33.354825	A309	Błąd Lini Niverplst - Easy Plast
8038	310	41	2026-10-07 00:19:33.354825	A310	Alarm Lini Niverplast - Transport System
8039	311	41	2026-10-07 00:19:33.354825	A311	Błąd Lini Niverplst - Transport System
8040	309	39	2026-10-07 00:20:31.733848	A309	Błąd Lini Niverplst - Easy Plast
8041	310	41	2026-10-07 00:20:31.733848	A310	Alarm Lini Niverplast - Transport System
8042	311	41	2026-10-07 00:20:31.733848	A311	Błąd Lini Niverplst - Transport System
8043	309	39	2026-10-07 00:21:31.959894	A309	Błąd Lini Niverplst - Easy Plast
8044	310	41	2026-10-07 00:21:31.959894	A310	Alarm Lini Niverplast - Transport System
8045	311	41	2026-10-07 00:21:31.959894	A311	Błąd Lini Niverplst - Transport System
8046	309	39	2026-10-07 00:22:31.643306	A309	Błąd Lini Niverplst - Easy Plast
8047	310	41	2026-10-07 00:22:31.643306	A310	Alarm Lini Niverplast - Transport System
8048	311	41	2026-10-07 00:22:31.643306	A311	Błąd Lini Niverplst - Transport System
8049	309	39	2026-10-07 00:23:32.553827	A309	Błąd Lini Niverplst - Easy Plast
8050	310	41	2026-10-07 00:23:32.553827	A310	Alarm Lini Niverplast - Transport System
8051	311	41	2026-10-07 00:23:32.553827	A311	Błąd Lini Niverplst - Transport System
8052	309	39	2026-10-07 00:24:32.9499	A309	Błąd Lini Niverplst - Easy Plast
8053	310	41	2026-10-07 00:24:32.9499	A310	Alarm Lini Niverplast - Transport System
8054	311	41	2026-10-07 00:24:32.9499	A311	Błąd Lini Niverplst - Transport System
8055	309	39	2026-10-07 00:25:33.229843	A309	Błąd Lini Niverplst - Easy Plast
8056	310	41	2026-10-07 00:25:33.229843	A310	Alarm Lini Niverplast - Transport System
8057	311	41	2026-10-07 00:25:33.229843	A311	Błąd Lini Niverplst - Transport System
8058	309	39	2026-10-07 00:26:33.548921	A309	Błąd Lini Niverplst - Easy Plast
8059	310	41	2026-10-07 00:26:33.548921	A310	Alarm Lini Niverplast - Transport System
8060	311	41	2026-10-07 00:26:33.548921	A311	Błąd Lini Niverplst - Transport System
8061	309	39	2026-10-07 00:27:33.835827	A309	Błąd Lini Niverplst - Easy Plast
8062	310	41	2026-10-07 00:27:33.835827	A310	Alarm Lini Niverplast - Transport System
8063	311	41	2026-10-07 00:27:33.835827	A311	Błąd Lini Niverplst - Transport System
8064	309	39	2026-10-07 00:28:32.191364	A309	Błąd Lini Niverplst - Easy Plast
8065	310	41	2026-10-07 00:28:32.191364	A310	Alarm Lini Niverplast - Transport System
8066	311	41	2026-10-07 00:28:32.191364	A311	Błąd Lini Niverplst - Transport System
8067	309	39	2026-10-07 00:29:32.440491	A309	Błąd Lini Niverplst - Easy Plast
8068	310	41	2026-10-07 00:29:32.440491	A310	Alarm Lini Niverplast - Transport System
8069	311	41	2026-10-07 00:29:32.440491	A311	Błąd Lini Niverplst - Transport System
8070	309	39	2026-10-07 00:30:33.270118	A309	Błąd Lini Niverplst - Easy Plast
8071	310	41	2026-10-07 00:30:33.270118	A310	Alarm Lini Niverplast - Transport System
8072	311	41	2026-10-07 00:30:33.270118	A311	Błąd Lini Niverplst - Transport System
8073	309	39	2026-10-07 00:31:33.054316	A309	Błąd Lini Niverplst - Easy Plast
8074	310	41	2026-10-07 00:31:33.054316	A310	Alarm Lini Niverplast - Transport System
8075	311	41	2026-10-07 00:31:33.054316	A311	Błąd Lini Niverplst - Transport System
8076	309	39	2026-10-07 00:32:33.315742	A309	Błąd Lini Niverplst - Easy Plast
8077	310	41	2026-10-07 00:32:33.315742	A310	Alarm Lini Niverplast - Transport System
8078	311	41	2026-10-07 00:32:33.315742	A311	Błąd Lini Niverplst - Transport System
8079	309	39	2026-10-07 00:33:33.669071	A309	Błąd Lini Niverplst - Easy Plast
8080	310	41	2026-10-07 00:33:33.669071	A310	Alarm Lini Niverplast - Transport System
8081	311	41	2026-10-07 00:33:33.669071	A311	Błąd Lini Niverplst - Transport System
8082	309	39	2026-10-07 00:34:33.995793	A309	Błąd Lini Niverplst - Easy Plast
8083	310	41	2026-10-07 00:34:33.995793	A310	Alarm Lini Niverplast - Transport System
8084	311	41	2026-10-07 00:34:33.995793	A311	Błąd Lini Niverplst - Transport System
8085	309	39	2026-10-07 00:35:34.258013	A309	Błąd Lini Niverplst - Easy Plast
8086	310	41	2026-10-07 00:35:34.258013	A310	Alarm Lini Niverplast - Transport System
8087	311	41	2026-10-07 00:35:34.258013	A311	Błąd Lini Niverplst - Transport System
8088	309	39	2026-10-07 00:36:32.575404	A309	Błąd Lini Niverplst - Easy Plast
8089	310	41	2026-10-07 00:36:32.575404	A310	Alarm Lini Niverplast - Transport System
8090	311	41	2026-10-07 00:36:32.575404	A311	Błąd Lini Niverplst - Transport System
8091	309	39	2026-10-07 00:37:32.908871	A309	Błąd Lini Niverplst - Easy Plast
8092	310	41	2026-10-07 00:37:32.908871	A310	Alarm Lini Niverplast - Transport System
8093	311	41	2026-10-07 00:37:32.908871	A311	Błąd Lini Niverplst - Transport System
8094	309	39	2026-10-07 00:38:33.160841	A309	Błąd Lini Niverplst - Easy Plast
8095	310	41	2026-10-07 00:38:33.160841	A310	Alarm Lini Niverplast - Transport System
8096	311	41	2026-10-07 00:38:33.160841	A311	Błąd Lini Niverplst - Transport System
8097	309	39	2026-10-07 00:39:33.46658	A309	Błąd Lini Niverplst - Easy Plast
8098	310	41	2026-10-07 00:39:33.46658	A310	Alarm Lini Niverplast - Transport System
8099	311	41	2026-10-07 00:39:33.46658	A311	Błąd Lini Niverplst - Transport System
8100	309	39	2026-10-07 00:40:33.751161	A309	Błąd Lini Niverplst - Easy Plast
8101	310	41	2026-10-07 00:40:33.751161	A310	Alarm Lini Niverplast - Transport System
8102	311	41	2026-10-07 00:40:33.751161	A311	Błąd Lini Niverplst - Transport System
8103	309	39	2026-10-07 00:41:34.079673	A309	Błąd Lini Niverplst - Easy Plast
8104	310	41	2026-10-07 00:41:34.079673	A310	Alarm Lini Niverplast - Transport System
8105	311	41	2026-10-07 00:41:34.079673	A311	Błąd Lini Niverplst - Transport System
8106	309	39	2026-10-07 00:42:34.355522	A309	Błąd Lini Niverplst - Easy Plast
8107	310	41	2026-10-07 00:42:34.355522	A310	Alarm Lini Niverplast - Transport System
8108	311	41	2026-10-07 00:42:34.355522	A311	Błąd Lini Niverplst - Transport System
8109	309	39	2026-10-07 00:43:34.637537	A309	Błąd Lini Niverplst - Easy Plast
8110	310	41	2026-10-07 00:43:34.637537	A310	Alarm Lini Niverplast - Transport System
8111	311	41	2026-10-07 00:43:34.637537	A311	Błąd Lini Niverplst - Transport System
8112	309	39	2026-10-07 00:44:34.894608	A309	Błąd Lini Niverplst - Easy Plast
8113	310	41	2026-10-07 00:44:34.894608	A310	Alarm Lini Niverplast - Transport System
8114	311	41	2026-10-07 00:44:34.894608	A311	Błąd Lini Niverplst - Transport System
8115	309	39	2026-10-07 00:45:33.251248	A309	Błąd Lini Niverplst - Easy Plast
8116	310	41	2026-10-07 00:45:33.251248	A310	Alarm Lini Niverplast - Transport System
8117	311	41	2026-10-07 00:45:33.251248	A311	Błąd Lini Niverplst - Transport System
8118	309	39	2026-10-07 00:46:33.484353	A309	Błąd Lini Niverplst - Easy Plast
8119	310	41	2026-10-07 00:46:33.484353	A310	Alarm Lini Niverplast - Transport System
8120	311	41	2026-10-07 00:46:33.484353	A311	Błąd Lini Niverplst - Transport System
8121	309	39	2026-10-07 00:47:33.896842	A309	Błąd Lini Niverplst - Easy Plast
8122	310	41	2026-10-07 00:47:33.896842	A310	Alarm Lini Niverplast - Transport System
8123	311	41	2026-10-07 00:47:33.896842	A311	Błąd Lini Niverplst - Transport System
8124	309	39	2026-10-07 00:48:34.103611	A309	Błąd Lini Niverplst - Easy Plast
8125	310	41	2026-10-07 00:48:34.103611	A310	Alarm Lini Niverplast - Transport System
8126	311	41	2026-10-07 00:48:34.103611	A311	Błąd Lini Niverplst - Transport System
8127	309	39	2026-10-07 00:49:34.462822	A309	Błąd Lini Niverplst - Easy Plast
8128	310	41	2026-10-07 00:49:34.462822	A310	Alarm Lini Niverplast - Transport System
8129	311	41	2026-10-07 00:49:34.462822	A311	Błąd Lini Niverplst - Transport System
8130	309	39	2026-10-07 00:50:34.689662	A309	Błąd Lini Niverplst - Easy Plast
8131	310	41	2026-10-07 00:50:34.689662	A310	Alarm Lini Niverplast - Transport System
8132	311	41	2026-10-07 00:50:34.689662	A311	Błąd Lini Niverplst - Transport System
8133	309	39	2026-10-07 00:51:34.965007	A309	Błąd Lini Niverplst - Easy Plast
8134	310	41	2026-10-07 00:51:34.965007	A310	Alarm Lini Niverplast - Transport System
8135	311	41	2026-10-07 00:51:34.965007	A311	Błąd Lini Niverplst - Transport System
8136	309	39	2026-10-07 00:52:35.222792	A309	Błąd Lini Niverplst - Easy Plast
8137	310	41	2026-10-07 00:52:35.222792	A310	Alarm Lini Niverplast - Transport System
8138	311	41	2026-10-07 00:52:35.222792	A311	Błąd Lini Niverplst - Transport System
8139	309	39	2026-10-07 00:53:33.63689	A309	Błąd Lini Niverplst - Easy Plast
8140	310	41	2026-10-07 00:53:33.63689	A310	Alarm Lini Niverplast - Transport System
8141	311	41	2026-10-07 00:53:33.63689	A311	Błąd Lini Niverplst - Transport System
8142	309	39	2026-10-07 00:54:33.922348	A309	Błąd Lini Niverplst - Easy Plast
8143	310	41	2026-10-07 00:54:33.922348	A310	Alarm Lini Niverplast - Transport System
8144	311	41	2026-10-07 00:54:33.922348	A311	Błąd Lini Niverplst - Transport System
8145	309	39	2026-10-07 00:55:34.164768	A309	Błąd Lini Niverplst - Easy Plast
8146	310	41	2026-10-07 00:55:34.164768	A310	Alarm Lini Niverplast - Transport System
8147	311	41	2026-10-07 00:55:34.164768	A311	Błąd Lini Niverplst - Transport System
8148	309	39	2026-10-07 00:56:34.491474	A309	Błąd Lini Niverplst - Easy Plast
8149	310	41	2026-10-07 00:56:34.491474	A310	Alarm Lini Niverplast - Transport System
8150	311	41	2026-10-07 00:56:34.491474	A311	Błąd Lini Niverplst - Transport System
8151	309	39	2026-10-07 00:57:34.733765	A309	Błąd Lini Niverplst - Easy Plast
8152	310	41	2026-10-07 00:57:34.733765	A310	Alarm Lini Niverplast - Transport System
8153	311	41	2026-10-07 00:57:34.733765	A311	Błąd Lini Niverplst - Transport System
8154	309	39	2026-10-07 00:58:35.01963	A309	Błąd Lini Niverplst - Easy Plast
8155	310	41	2026-10-07 00:58:35.01963	A310	Alarm Lini Niverplast - Transport System
8156	311	41	2026-10-07 00:58:35.01963	A311	Błąd Lini Niverplst - Transport System
8157	309	39	2026-10-07 00:59:35.28013	A309	Błąd Lini Niverplst - Easy Plast
8158	310	41	2026-10-07 00:59:35.28013	A310	Alarm Lini Niverplast - Transport System
8159	311	41	2026-10-07 00:59:35.28013	A311	Błąd Lini Niverplst - Transport System
8160	309	39	2026-10-07 01:00:35.543387	A309	Błąd Lini Niverplst - Easy Plast
8161	310	41	2026-10-07 01:00:35.543387	A310	Alarm Lini Niverplast - Transport System
8162	311	41	2026-10-07 01:00:35.543387	A311	Błąd Lini Niverplst - Transport System
8163	309	39	2026-10-07 01:01:35.778806	A309	Błąd Lini Niverplst - Easy Plast
8164	310	41	2026-10-07 01:01:35.778806	A310	Alarm Lini Niverplast - Transport System
8165	311	41	2026-10-07 01:01:35.778806	A311	Błąd Lini Niverplst - Transport System
8166	309	39	2026-10-07 01:02:34.17249	A309	Błąd Lini Niverplst - Easy Plast
8167	310	41	2026-10-07 01:02:34.17249	A310	Alarm Lini Niverplast - Transport System
8168	311	41	2026-10-07 01:02:34.17249	A311	Błąd Lini Niverplst - Transport System
8169	309	39	2026-10-07 01:03:34.498696	A309	Błąd Lini Niverplst - Easy Plast
8170	310	41	2026-10-07 01:03:34.498696	A310	Alarm Lini Niverplast - Transport System
8171	311	41	2026-10-07 01:03:34.498696	A311	Błąd Lini Niverplst - Transport System
8172	309	39	2026-10-07 01:04:34.729041	A309	Błąd Lini Niverplst - Easy Plast
8173	310	41	2026-10-07 01:04:34.729041	A310	Alarm Lini Niverplast - Transport System
8174	311	41	2026-10-07 01:04:34.729041	A311	Błąd Lini Niverplst - Transport System
8175	309	39	2026-10-07 01:05:35.014102	A309	Błąd Lini Niverplst - Easy Plast
8176	310	41	2026-10-07 01:05:35.014102	A310	Alarm Lini Niverplast - Transport System
8177	311	41	2026-10-07 01:05:35.014102	A311	Błąd Lini Niverplst - Transport System
8178	309	39	2026-10-07 01:06:36.434563	A309	Błąd Lini Niverplst - Easy Plast
8179	310	41	2026-10-07 01:06:36.434563	A310	Alarm Lini Niverplast - Transport System
8180	311	41	2026-10-07 01:06:36.434563	A311	Błąd Lini Niverplst - Transport System
8181	309	39	2026-10-07 01:07:35.573854	A309	Błąd Lini Niverplst - Easy Plast
8182	310	41	2026-10-07 01:07:35.573854	A310	Alarm Lini Niverplast - Transport System
8183	311	41	2026-10-07 01:07:35.573854	A311	Błąd Lini Niverplst - Transport System
8184	309	39	2026-10-07 01:08:35.826007	A309	Błąd Lini Niverplst - Easy Plast
8185	310	41	2026-10-07 01:08:35.826007	A310	Alarm Lini Niverplast - Transport System
8186	311	41	2026-10-07 01:08:35.826007	A311	Błąd Lini Niverplst - Transport System
8187	309	39	2026-10-07 01:09:36.12226	A309	Błąd Lini Niverplst - Easy Plast
8188	310	41	2026-10-07 01:09:36.12226	A310	Alarm Lini Niverplast - Transport System
8189	311	41	2026-10-07 01:09:36.12226	A311	Błąd Lini Niverplst - Transport System
8190	309	39	2026-10-07 01:10:36.33775	A309	Błąd Lini Niverplst - Easy Plast
8191	310	41	2026-10-07 01:10:36.33775	A310	Alarm Lini Niverplast - Transport System
8192	311	41	2026-10-07 01:10:36.33775	A311	Błąd Lini Niverplst - Transport System
8193	309	39	2026-10-07 01:11:34.744779	A309	Błąd Lini Niverplst - Easy Plast
8194	310	41	2026-10-07 01:11:34.744779	A310	Alarm Lini Niverplast - Transport System
8195	311	41	2026-10-07 01:11:34.744779	A311	Błąd Lini Niverplst - Transport System
8196	309	39	2026-10-07 01:12:35.075835	A309	Błąd Lini Niverplst - Easy Plast
8197	310	41	2026-10-07 01:12:35.075835	A310	Alarm Lini Niverplast - Transport System
8198	311	41	2026-10-07 01:12:35.075835	A311	Błąd Lini Niverplst - Transport System
8199	309	39	2026-10-07 01:13:35.29353	A309	Błąd Lini Niverplst - Easy Plast
8200	310	41	2026-10-07 01:13:35.29353	A310	Alarm Lini Niverplast - Transport System
8201	311	41	2026-10-07 01:13:35.29353	A311	Błąd Lini Niverplst - Transport System
8202	309	39	2026-10-07 01:14:35.598807	A309	Błąd Lini Niverplst - Easy Plast
8203	310	41	2026-10-07 01:14:35.598807	A310	Alarm Lini Niverplast - Transport System
8204	311	41	2026-10-07 01:14:35.598807	A311	Błąd Lini Niverplst - Transport System
8205	309	39	2026-10-07 01:15:35.856872	A309	Błąd Lini Niverplst - Easy Plast
8206	310	41	2026-10-07 01:15:35.856872	A310	Alarm Lini Niverplast - Transport System
8207	311	41	2026-10-07 01:15:35.856872	A311	Błąd Lini Niverplst - Transport System
8208	309	39	2026-10-07 01:16:36.148549	A309	Błąd Lini Niverplst - Easy Plast
8209	310	41	2026-10-07 01:16:36.148549	A310	Alarm Lini Niverplast - Transport System
8210	311	41	2026-10-07 01:16:36.148549	A311	Błąd Lini Niverplst - Transport System
8211	309	39	2026-10-07 01:17:36.384824	A309	Błąd Lini Niverplst - Easy Plast
8212	310	41	2026-10-07 01:17:36.384824	A310	Alarm Lini Niverplast - Transport System
8213	311	41	2026-10-07 01:17:36.384824	A311	Błąd Lini Niverplst - Transport System
8214	309	39	2026-10-07 01:18:36.652862	A309	Błąd Lini Niverplst - Easy Plast
8215	310	41	2026-10-07 01:18:36.652862	A310	Alarm Lini Niverplast - Transport System
8216	311	41	2026-10-07 01:18:36.652862	A311	Błąd Lini Niverplst - Transport System
8217	309	39	2026-10-07 01:19:36.91505	A309	Błąd Lini Niverplst - Easy Plast
8218	310	41	2026-10-07 01:19:36.91505	A310	Alarm Lini Niverplast - Transport System
8219	311	41	2026-10-07 01:19:36.91505	A311	Błąd Lini Niverplst - Transport System
8220	309	39	2026-10-07 01:20:35.336077	A309	Błąd Lini Niverplst - Easy Plast
8221	310	41	2026-10-07 01:20:35.336077	A310	Alarm Lini Niverplast - Transport System
8222	311	41	2026-10-07 01:20:35.336077	A311	Błąd Lini Niverplst - Transport System
8223	309	39	2026-10-07 01:21:35.644459	A309	Błąd Lini Niverplst - Easy Plast
8224	310	41	2026-10-07 01:21:35.644459	A310	Alarm Lini Niverplast - Transport System
8225	311	41	2026-10-07 01:21:35.644459	A311	Błąd Lini Niverplst - Transport System
8226	309	39	2026-10-07 01:22:35.880255	A309	Błąd Lini Niverplst - Easy Plast
8227	310	41	2026-10-07 01:22:35.880255	A310	Alarm Lini Niverplast - Transport System
8228	311	41	2026-10-07 01:22:35.880255	A311	Błąd Lini Niverplst - Transport System
8229	309	39	2026-10-07 01:23:36.176294	A309	Błąd Lini Niverplst - Easy Plast
8230	310	41	2026-10-07 01:23:36.176294	A310	Alarm Lini Niverplast - Transport System
8231	311	41	2026-10-07 01:23:36.176294	A311	Błąd Lini Niverplst - Transport System
8232	309	39	2026-10-07 01:24:36.412462	A309	Błąd Lini Niverplst - Easy Plast
8233	310	41	2026-10-07 01:24:36.412462	A310	Alarm Lini Niverplast - Transport System
8234	311	41	2026-10-07 01:24:36.412462	A311	Błąd Lini Niverplst - Transport System
8235	309	39	2026-10-07 01:25:36.701813	A309	Błąd Lini Niverplst - Easy Plast
8236	310	41	2026-10-07 01:25:36.701813	A310	Alarm Lini Niverplast - Transport System
8237	311	41	2026-10-07 01:25:36.701813	A311	Błąd Lini Niverplst - Transport System
8238	309	39	2026-10-07 01:26:36.941019	A309	Błąd Lini Niverplst - Easy Plast
8239	310	41	2026-10-07 01:26:36.941019	A310	Alarm Lini Niverplast - Transport System
8240	311	41	2026-10-07 01:26:36.941019	A311	Błąd Lini Niverplst - Transport System
8241	309	39	2026-10-07 01:27:37.229957	A309	Błąd Lini Niverplst - Easy Plast
8242	310	41	2026-10-07 01:27:37.229957	A310	Alarm Lini Niverplast - Transport System
8243	311	41	2026-10-07 01:27:37.229957	A311	Błąd Lini Niverplst - Transport System
8244	309	39	2026-10-07 01:28:37.481301	A309	Błąd Lini Niverplst - Easy Plast
8245	310	41	2026-10-07 01:28:37.481301	A310	Alarm Lini Niverplast - Transport System
8246	311	41	2026-10-07 01:28:37.481301	A311	Błąd Lini Niverplst - Transport System
8247	309	39	2026-10-07 01:29:35.905338	A309	Błąd Lini Niverplst - Easy Plast
8248	310	41	2026-10-07 01:29:35.905338	A310	Alarm Lini Niverplast - Transport System
8249	311	41	2026-10-07 01:29:35.905338	A311	Błąd Lini Niverplst - Transport System
8250	309	39	2026-10-07 01:30:36.139092	A309	Błąd Lini Niverplst - Easy Plast
8251	310	41	2026-10-07 01:30:36.139092	A310	Alarm Lini Niverplast - Transport System
8252	311	41	2026-10-07 01:30:36.139092	A311	Błąd Lini Niverplst - Transport System
8253	309	39	2026-10-07 01:31:36.440926	A309	Błąd Lini Niverplst - Easy Plast
8254	310	41	2026-10-07 01:31:36.440926	A310	Alarm Lini Niverplast - Transport System
8255	311	41	2026-10-07 01:31:36.440926	A311	Błąd Lini Niverplst - Transport System
8256	309	39	2026-10-07 01:32:36.695249	A309	Błąd Lini Niverplst - Easy Plast
8257	310	41	2026-10-07 01:32:36.695249	A310	Alarm Lini Niverplast - Transport System
8258	311	41	2026-10-07 01:32:36.695249	A311	Błąd Lini Niverplst - Transport System
8259	309	39	2026-10-07 01:33:36.988659	A309	Błąd Lini Niverplst - Easy Plast
8260	310	41	2026-10-07 01:33:36.988659	A310	Alarm Lini Niverplast - Transport System
8261	311	41	2026-10-07 01:33:36.988659	A311	Błąd Lini Niverplst - Transport System
8262	309	39	2026-10-07 01:34:37.27181	A309	Błąd Lini Niverplst - Easy Plast
8263	310	41	2026-10-07 01:34:37.27181	A310	Alarm Lini Niverplast - Transport System
8264	311	41	2026-10-07 01:34:37.27181	A311	Błąd Lini Niverplst - Transport System
8265	309	39	2026-10-07 01:35:37.509036	A309	Błąd Lini Niverplst - Easy Plast
8266	310	41	2026-10-07 01:35:37.509036	A310	Alarm Lini Niverplast - Transport System
8267	311	41	2026-10-07 01:35:37.509036	A311	Błąd Lini Niverplst - Transport System
8268	309	39	2026-10-07 01:36:37.769382	A309	Błąd Lini Niverplst - Easy Plast
8269	310	41	2026-10-07 01:36:37.769382	A310	Alarm Lini Niverplast - Transport System
8270	311	41	2026-10-07 01:36:37.769382	A311	Błąd Lini Niverplst - Transport System
8271	309	39	2026-10-07 01:37:41.10559	A309	Błąd Lini Niverplst - Easy Plast
8272	310	41	2026-10-07 01:37:41.10559	A310	Alarm Lini Niverplast - Transport System
8273	311	41	2026-10-07 01:37:41.10559	A311	Błąd Lini Niverplst - Transport System
8274	309	39	2026-10-07 01:38:36.457608	A309	Błąd Lini Niverplst - Easy Plast
8275	310	41	2026-10-07 01:38:36.457608	A310	Alarm Lini Niverplast - Transport System
8276	311	41	2026-10-07 01:38:36.457608	A311	Błąd Lini Niverplst - Transport System
8277	309	39	2026-10-07 01:39:36.714746	A309	Błąd Lini Niverplst - Easy Plast
8278	310	41	2026-10-07 01:39:36.714746	A310	Alarm Lini Niverplast - Transport System
8279	311	41	2026-10-07 01:39:36.714746	A311	Błąd Lini Niverplst - Transport System
8280	309	39	2026-10-07 01:40:37.01391	A309	Błąd Lini Niverplst - Easy Plast
8281	310	41	2026-10-07 01:40:37.01391	A310	Alarm Lini Niverplast - Transport System
8282	311	41	2026-10-07 01:40:37.01391	A311	Błąd Lini Niverplst - Transport System
8283	309	39	2026-10-07 01:41:37.271599	A309	Błąd Lini Niverplst - Easy Plast
8284	310	41	2026-10-07 01:41:37.271599	A310	Alarm Lini Niverplast - Transport System
8285	311	41	2026-10-07 01:41:37.271599	A311	Błąd Lini Niverplst - Transport System
8286	309	39	2026-10-07 01:42:37.554053	A309	Błąd Lini Niverplst - Easy Plast
8287	310	41	2026-10-07 01:42:37.554053	A310	Alarm Lini Niverplast - Transport System
8288	311	41	2026-10-07 01:42:37.554053	A311	Błąd Lini Niverplst - Transport System
8289	309	39	2026-10-07 01:43:37.804671	A309	Błąd Lini Niverplst - Easy Plast
8290	310	41	2026-10-07 01:43:37.804671	A310	Alarm Lini Niverplast - Transport System
8291	311	41	2026-10-07 01:43:37.804671	A311	Błąd Lini Niverplst - Transport System
8292	309	39	2026-10-07 01:44:38.081617	A309	Błąd Lini Niverplst - Easy Plast
8293	310	41	2026-10-07 01:44:38.081617	A310	Alarm Lini Niverplast - Transport System
8294	311	41	2026-10-07 01:44:38.081617	A311	Błąd Lini Niverplst - Transport System
8295	309	39	2026-10-07 01:45:38.343486	A309	Błąd Lini Niverplst - Easy Plast
8296	310	41	2026-10-07 01:45:38.343486	A310	Alarm Lini Niverplast - Transport System
8297	311	41	2026-10-07 01:45:38.343486	A311	Błąd Lini Niverplst - Transport System
8298	309	39	2026-10-07 01:46:36.793382	A309	Błąd Lini Niverplst - Easy Plast
8299	310	41	2026-10-07 01:46:36.793382	A310	Alarm Lini Niverplast - Transport System
8300	311	41	2026-10-07 01:46:36.793382	A311	Błąd Lini Niverplst - Transport System
8301	309	39	2026-10-07 01:47:37.037231	A309	Błąd Lini Niverplst - Easy Plast
8302	310	41	2026-10-07 01:47:37.037231	A310	Alarm Lini Niverplast - Transport System
8303	311	41	2026-10-07 01:47:37.037231	A311	Błąd Lini Niverplst - Transport System
8304	309	39	2026-10-07 01:48:37.280923	A309	Błąd Lini Niverplst - Easy Plast
8305	310	41	2026-10-07 01:48:37.280923	A310	Alarm Lini Niverplast - Transport System
8306	311	41	2026-10-07 01:48:37.280923	A311	Błąd Lini Niverplst - Transport System
8307	309	39	2026-10-07 01:49:37.583695	A309	Błąd Lini Niverplst - Easy Plast
8308	310	41	2026-10-07 01:49:37.583695	A310	Alarm Lini Niverplast - Transport System
8309	311	41	2026-10-07 01:49:37.583695	A311	Błąd Lini Niverplst - Transport System
8310	309	39	2026-10-07 01:50:37.8422	A309	Błąd Lini Niverplst - Easy Plast
8311	310	41	2026-10-07 01:50:37.8422	A310	Alarm Lini Niverplast - Transport System
8312	311	41	2026-10-07 01:50:37.8422	A311	Błąd Lini Niverplst - Transport System
8313	309	39	2026-10-07 01:51:38.124212	A309	Błąd Lini Niverplst - Easy Plast
8314	310	41	2026-10-07 01:51:38.124212	A310	Alarm Lini Niverplast - Transport System
8315	311	41	2026-10-07 01:51:38.124212	A311	Błąd Lini Niverplst - Transport System
8316	309	39	2026-10-07 01:52:38.385058	A309	Błąd Lini Niverplst - Easy Plast
8317	310	41	2026-10-07 01:52:38.385058	A310	Alarm Lini Niverplast - Transport System
8318	311	41	2026-10-07 01:52:38.385058	A311	Błąd Lini Niverplst - Transport System
8319	309	39	2026-10-07 01:53:38.659155	A309	Błąd Lini Niverplst - Easy Plast
8320	310	41	2026-10-07 01:53:38.659155	A310	Alarm Lini Niverplast - Transport System
8321	311	41	2026-10-07 01:53:38.659155	A311	Błąd Lini Niverplst - Transport System
8322	309	39	2026-10-07 01:54:38.918546	A309	Błąd Lini Niverplst - Easy Plast
8323	310	41	2026-10-07 01:54:38.918546	A310	Alarm Lini Niverplast - Transport System
8324	311	41	2026-10-07 01:54:38.918546	A311	Błąd Lini Niverplst - Transport System
8325	309	39	2026-10-07 01:55:37.290768	A309	Błąd Lini Niverplst - Easy Plast
8326	310	41	2026-10-07 01:55:37.290768	A310	Alarm Lini Niverplast - Transport System
8327	311	41	2026-10-07 01:55:37.290768	A311	Błąd Lini Niverplst - Transport System
8328	309	39	2026-10-07 01:56:37.616664	A309	Błąd Lini Niverplst - Easy Plast
8329	310	41	2026-10-07 01:56:37.616664	A310	Alarm Lini Niverplast - Transport System
8330	311	41	2026-10-07 01:56:37.616664	A311	Błąd Lini Niverplst - Transport System
8331	309	39	2026-10-07 01:57:37.870852	A309	Błąd Lini Niverplst - Easy Plast
8332	310	41	2026-10-07 01:57:37.870852	A310	Alarm Lini Niverplast - Transport System
8333	311	41	2026-10-07 01:57:37.870852	A311	Błąd Lini Niverplst - Transport System
8334	309	39	2026-10-07 01:58:38.175829	A309	Błąd Lini Niverplst - Easy Plast
8335	310	41	2026-10-07 01:58:38.175829	A310	Alarm Lini Niverplast - Transport System
8336	311	41	2026-10-07 01:58:38.175829	A311	Błąd Lini Niverplst - Transport System
8337	309	39	2026-10-07 01:59:38.443323	A309	Błąd Lini Niverplst - Easy Plast
8338	310	41	2026-10-07 01:59:38.443323	A310	Alarm Lini Niverplast - Transport System
8339	311	41	2026-10-07 01:59:38.443323	A311	Błąd Lini Niverplst - Transport System
8340	309	39	2026-10-07 02:00:38.712485	A309	Błąd Lini Niverplst - Easy Plast
8341	310	41	2026-10-07 02:00:38.712485	A310	Alarm Lini Niverplast - Transport System
8342	311	41	2026-10-07 02:00:38.712485	A311	Błąd Lini Niverplst - Transport System
8343	309	39	2026-10-07 02:01:38.962702	A309	Błąd Lini Niverplst - Easy Plast
8344	310	41	2026-10-07 02:01:38.962702	A310	Alarm Lini Niverplast - Transport System
8345	311	41	2026-10-07 02:01:38.962702	A311	Błąd Lini Niverplst - Transport System
8346	309	39	2026-10-07 02:02:39.299011	A309	Błąd Lini Niverplst - Easy Plast
8347	310	41	2026-10-07 02:02:39.299011	A310	Alarm Lini Niverplast - Transport System
8348	311	41	2026-10-07 02:02:39.299011	A311	Błąd Lini Niverplst - Transport System
8349	309	39	2026-10-07 02:03:38.522473	A309	Błąd Lini Niverplst - Easy Plast
8350	310	41	2026-10-07 02:03:38.522473	A310	Alarm Lini Niverplast - Transport System
8351	311	41	2026-10-07 02:03:38.522473	A311	Błąd Lini Niverplst - Transport System
8352	309	39	2026-10-07 02:04:37.868471	A309	Błąd Lini Niverplst - Easy Plast
8353	310	41	2026-10-07 02:04:37.868471	A310	Alarm Lini Niverplast - Transport System
8354	311	41	2026-10-07 02:04:37.868471	A311	Błąd Lini Niverplst - Transport System
8355	309	39	2026-10-07 02:05:38.210087	A309	Błąd Lini Niverplst - Easy Plast
8356	310	41	2026-10-07 02:05:38.210087	A310	Alarm Lini Niverplast - Transport System
8357	311	41	2026-10-07 02:05:38.210087	A311	Błąd Lini Niverplst - Transport System
8358	309	39	2026-10-07 02:06:38.45384	A309	Błąd Lini Niverplst - Easy Plast
8359	310	41	2026-10-07 02:06:38.45384	A310	Alarm Lini Niverplast - Transport System
8360	311	41	2026-10-07 02:06:38.45384	A311	Błąd Lini Niverplst - Transport System
8361	309	39	2026-10-07 02:07:38.751747	A309	Błąd Lini Niverplst - Easy Plast
8362	310	41	2026-10-07 02:07:38.751747	A310	Alarm Lini Niverplast - Transport System
8363	311	41	2026-10-07 02:07:38.751747	A311	Błąd Lini Niverplst - Transport System
8364	309	39	2026-10-07 02:08:39.016004	A309	Błąd Lini Niverplst - Easy Plast
8365	310	41	2026-10-07 02:08:39.016004	A310	Alarm Lini Niverplast - Transport System
8366	311	41	2026-10-07 02:08:39.016004	A311	Błąd Lini Niverplst - Transport System
8367	309	39	2026-10-07 02:09:39.24103	A309	Błąd Lini Niverplst - Easy Plast
8368	310	41	2026-10-07 02:09:39.24103	A310	Alarm Lini Niverplast - Transport System
8369	311	41	2026-10-07 02:09:39.24103	A311	Błąd Lini Niverplst - Transport System
8370	309	39	2026-10-07 02:10:39.947659	A309	Błąd Lini Niverplst - Easy Plast
8371	310	41	2026-10-07 02:10:39.947659	A310	Alarm Lini Niverplast - Transport System
8372	311	41	2026-10-07 02:10:39.947659	A311	Błąd Lini Niverplst - Transport System
8373	309	39	2026-10-07 02:11:39.906316	A309	Błąd Lini Niverplst - Easy Plast
8374	310	41	2026-10-07 02:11:39.906316	A310	Alarm Lini Niverplast - Transport System
8375	311	41	2026-10-07 02:11:39.906316	A311	Błąd Lini Niverplst - Transport System
8376	309	39	2026-10-07 02:12:38.331921	A309	Błąd Lini Niverplst - Easy Plast
8377	310	41	2026-10-07 02:12:38.331921	A310	Alarm Lini Niverplast - Transport System
8378	311	41	2026-10-07 02:12:38.331921	A311	Błąd Lini Niverplst - Transport System
8379	309	39	2026-10-07 02:13:38.599926	A309	Błąd Lini Niverplst - Easy Plast
8380	310	41	2026-10-07 02:13:38.599926	A310	Alarm Lini Niverplast - Transport System
8381	311	41	2026-10-07 02:13:38.599926	A311	Błąd Lini Niverplst - Transport System
8382	309	39	2026-10-07 02:14:38.866941	A309	Błąd Lini Niverplst - Easy Plast
8383	310	41	2026-10-07 02:14:38.866941	A310	Alarm Lini Niverplast - Transport System
8384	311	41	2026-10-07 02:14:38.866941	A311	Błąd Lini Niverplst - Transport System
8385	309	39	2026-10-07 02:15:39.126977	A309	Błąd Lini Niverplst - Easy Plast
8386	310	41	2026-10-07 02:15:39.126977	A310	Alarm Lini Niverplast - Transport System
8387	311	41	2026-10-07 02:15:39.126977	A311	Błąd Lini Niverplst - Transport System
8388	309	39	2026-10-07 02:16:39.400903	A309	Błąd Lini Niverplst - Easy Plast
8389	310	41	2026-10-07 02:16:39.400903	A310	Alarm Lini Niverplast - Transport System
8390	311	41	2026-10-07 02:16:39.400903	A311	Błąd Lini Niverplst - Transport System
8391	309	39	2026-10-07 02:17:39.665409	A309	Błąd Lini Niverplst - Easy Plast
8392	310	41	2026-10-07 02:17:39.665409	A310	Alarm Lini Niverplast - Transport System
8393	311	41	2026-10-07 02:17:39.665409	A311	Błąd Lini Niverplst - Transport System
8394	309	39	2026-10-07 02:18:39.935688	A309	Błąd Lini Niverplst - Easy Plast
8395	310	41	2026-10-07 02:18:39.935688	A310	Alarm Lini Niverplast - Transport System
8396	311	41	2026-10-07 02:18:39.935688	A311	Błąd Lini Niverplst - Transport System
8397	309	39	2026-10-07 02:19:40.20034	A309	Błąd Lini Niverplst - Easy Plast
8398	310	41	2026-10-07 02:19:40.20034	A310	Alarm Lini Niverplast - Transport System
8399	311	41	2026-10-07 02:19:40.20034	A311	Błąd Lini Niverplst - Transport System
8400	309	39	2026-10-07 02:20:40.487734	A309	Błąd Lini Niverplst - Easy Plast
8401	310	41	2026-10-07 02:20:40.487734	A310	Alarm Lini Niverplast - Transport System
8402	311	41	2026-10-07 02:20:40.487734	A311	Błąd Lini Niverplst - Transport System
8403	309	39	2026-10-07 02:21:39.858012	A309	Błąd Lini Niverplst - Easy Plast
8404	310	41	2026-10-07 02:21:39.858012	A310	Alarm Lini Niverplast - Transport System
8405	311	41	2026-10-07 02:21:39.858012	A311	Błąd Lini Niverplst - Transport System
8406	309	39	2026-10-07 02:22:39.171608	A309	Błąd Lini Niverplst - Easy Plast
8407	310	41	2026-10-07 02:22:39.171608	A310	Alarm Lini Niverplast - Transport System
8408	311	41	2026-10-07 02:22:39.171608	A311	Błąd Lini Niverplst - Transport System
8409	309	39	2026-10-07 02:23:39.398157	A309	Błąd Lini Niverplst - Easy Plast
8410	310	41	2026-10-07 02:23:39.398157	A310	Alarm Lini Niverplast - Transport System
8411	311	41	2026-10-07 02:23:39.398157	A311	Błąd Lini Niverplst - Transport System
8412	309	39	2026-10-07 02:24:39.720069	A309	Błąd Lini Niverplst - Easy Plast
8413	310	41	2026-10-07 02:24:39.720069	A310	Alarm Lini Niverplast - Transport System
8414	311	41	2026-10-07 02:24:39.720069	A311	Błąd Lini Niverplst - Transport System
8415	309	39	2026-10-07 02:25:39.983138	A309	Błąd Lini Niverplst - Easy Plast
8416	310	41	2026-10-07 02:25:39.983138	A310	Alarm Lini Niverplast - Transport System
8417	311	41	2026-10-07 02:25:39.983138	A311	Błąd Lini Niverplst - Transport System
8418	309	39	2026-10-07 02:26:40.265581	A309	Błąd Lini Niverplst - Easy Plast
8419	310	41	2026-10-07 02:26:40.265581	A310	Alarm Lini Niverplast - Transport System
8420	311	41	2026-10-07 02:26:40.265581	A311	Błąd Lini Niverplst - Transport System
8421	309	39	2026-10-07 02:27:40.533685	A309	Błąd Lini Niverplst - Easy Plast
8422	310	41	2026-10-07 02:27:40.533685	A310	Alarm Lini Niverplast - Transport System
8423	311	41	2026-10-07 02:27:40.533685	A311	Błąd Lini Niverplst - Transport System
8424	309	39	2026-10-07 02:28:40.789629	A309	Błąd Lini Niverplst - Easy Plast
8425	310	41	2026-10-07 02:28:40.789629	A310	Alarm Lini Niverplast - Transport System
8426	311	41	2026-10-07 02:28:40.789629	A311	Błąd Lini Niverplst - Transport System
8427	309	39	2026-10-07 02:29:39.194729	A309	Błąd Lini Niverplst - Easy Plast
8428	310	41	2026-10-07 02:29:39.194729	A310	Alarm Lini Niverplast - Transport System
8429	311	41	2026-10-07 02:29:39.194729	A311	Błąd Lini Niverplst - Transport System
8430	309	39	2026-10-07 02:30:39.52458	A309	Błąd Lini Niverplst - Easy Plast
8431	310	41	2026-10-07 02:30:39.52458	A310	Alarm Lini Niverplast - Transport System
8432	311	41	2026-10-07 02:30:39.52458	A311	Błąd Lini Niverplst - Transport System
8433	309	39	2026-10-07 02:31:39.754636	A309	Błąd Lini Niverplst - Easy Plast
8434	310	41	2026-10-07 02:31:39.754636	A310	Alarm Lini Niverplast - Transport System
8435	311	41	2026-10-07 02:31:39.754636	A311	Błąd Lini Niverplst - Transport System
8436	309	39	2026-10-07 02:32:40.049041	A309	Błąd Lini Niverplst - Easy Plast
8437	310	41	2026-10-07 02:32:40.049041	A310	Alarm Lini Niverplast - Transport System
8438	311	41	2026-10-07 02:32:40.049041	A311	Błąd Lini Niverplst - Transport System
8439	309	39	2026-10-07 02:33:40.304333	A309	Błąd Lini Niverplst - Easy Plast
8440	310	41	2026-10-07 02:33:40.304333	A310	Alarm Lini Niverplast - Transport System
8441	311	41	2026-10-07 02:33:40.304333	A311	Błąd Lini Niverplst - Transport System
8442	309	39	2026-10-07 02:34:40.58693	A309	Błąd Lini Niverplst - Easy Plast
8443	310	41	2026-10-07 02:34:40.58693	A310	Alarm Lini Niverplast - Transport System
8444	311	41	2026-10-07 02:34:40.58693	A311	Błąd Lini Niverplst - Transport System
8445	309	39	2026-10-07 02:35:40.841956	A309	Błąd Lini Niverplst - Easy Plast
8446	310	41	2026-10-07 02:35:40.841956	A310	Alarm Lini Niverplast - Transport System
8447	311	41	2026-10-07 02:35:40.841956	A311	Błąd Lini Niverplst - Transport System
8448	309	39	2026-10-07 02:36:41.130637	A309	Błąd Lini Niverplst - Easy Plast
8449	310	41	2026-10-07 02:36:41.130637	A310	Alarm Lini Niverplast - Transport System
8450	311	41	2026-10-07 02:36:41.130637	A311	Błąd Lini Niverplst - Transport System
8451	309	39	2026-10-07 02:37:41.385082	A309	Błąd Lini Niverplst - Easy Plast
8452	310	41	2026-10-07 02:37:41.385082	A310	Alarm Lini Niverplast - Transport System
8453	311	41	2026-10-07 02:37:41.385082	A311	Błąd Lini Niverplst - Transport System
8454	309	39	2026-10-07 02:38:39.791786	A309	Błąd Lini Niverplst - Easy Plast
8455	310	41	2026-10-07 02:38:39.791786	A310	Alarm Lini Niverplast - Transport System
8456	311	41	2026-10-07 02:38:39.791786	A311	Błąd Lini Niverplst - Transport System
8457	309	39	2026-10-07 02:39:40.133365	A309	Błąd Lini Niverplst - Easy Plast
8458	310	41	2026-10-07 02:39:40.133365	A310	Alarm Lini Niverplast - Transport System
8459	311	41	2026-10-07 02:39:40.133365	A311	Błąd Lini Niverplst - Transport System
8460	309	39	2026-10-07 02:40:40.350253	A309	Błąd Lini Niverplst - Easy Plast
8461	310	41	2026-10-07 02:40:40.350253	A310	Alarm Lini Niverplast - Transport System
8462	311	41	2026-10-07 02:40:40.350253	A311	Błąd Lini Niverplst - Transport System
8463	309	39	2026-10-07 02:41:40.655456	A309	Błąd Lini Niverplst - Easy Plast
8464	310	41	2026-10-07 02:41:40.655456	A310	Alarm Lini Niverplast - Transport System
8465	311	41	2026-10-07 02:41:40.655456	A311	Błąd Lini Niverplst - Transport System
8466	309	39	2026-10-07 02:42:40.887929	A309	Błąd Lini Niverplst - Easy Plast
8467	310	41	2026-10-07 02:42:40.887929	A310	Alarm Lini Niverplast - Transport System
8468	311	41	2026-10-07 02:42:40.887929	A311	Błąd Lini Niverplst - Transport System
8469	309	39	2026-10-07 02:43:41.208294	A309	Błąd Lini Niverplst - Easy Plast
8470	310	41	2026-10-07 02:43:41.208294	A310	Alarm Lini Niverplast - Transport System
8471	311	41	2026-10-07 02:43:41.208294	A311	Błąd Lini Niverplst - Transport System
8472	309	39	2026-10-07 02:44:41.453801	A309	Błąd Lini Niverplst - Easy Plast
8473	310	41	2026-10-07 02:44:41.453801	A310	Alarm Lini Niverplast - Transport System
8474	311	41	2026-10-07 02:44:41.453801	A311	Błąd Lini Niverplst - Transport System
8475	309	39	2026-10-07 02:45:41.726046	A309	Błąd Lini Niverplst - Easy Plast
8476	310	41	2026-10-07 02:45:41.726046	A310	Alarm Lini Niverplast - Transport System
8477	311	41	2026-10-07 02:45:41.726046	A311	Błąd Lini Niverplst - Transport System
8478	309	39	2026-10-07 02:46:41.993628	A309	Błąd Lini Niverplst - Easy Plast
8479	310	41	2026-10-07 02:46:41.993628	A310	Alarm Lini Niverplast - Transport System
8480	311	41	2026-10-07 02:46:41.993628	A311	Błąd Lini Niverplst - Transport System
8481	309	39	2026-10-07 02:47:40.396442	A309	Błąd Lini Niverplst - Easy Plast
8482	310	41	2026-10-07 02:47:40.396442	A310	Alarm Lini Niverplast - Transport System
8483	311	41	2026-10-07 02:47:40.396442	A311	Błąd Lini Niverplst - Transport System
8484	309	39	2026-10-07 02:48:40.635356	A309	Błąd Lini Niverplst - Easy Plast
8485	310	41	2026-10-07 02:48:40.635356	A310	Alarm Lini Niverplast - Transport System
8486	311	41	2026-10-07 02:48:40.635356	A311	Błąd Lini Niverplst - Transport System
8487	309	39	2026-10-07 02:49:40.95163	A309	Błąd Lini Niverplst - Easy Plast
8488	310	41	2026-10-07 02:49:40.95163	A310	Alarm Lini Niverplast - Transport System
8489	311	41	2026-10-07 02:49:40.95163	A311	Błąd Lini Niverplst - Transport System
8490	309	39	2026-10-07 02:50:41.22134	A309	Błąd Lini Niverplst - Easy Plast
8491	310	41	2026-10-07 02:50:41.22134	A310	Alarm Lini Niverplast - Transport System
8492	311	41	2026-10-07 02:50:41.22134	A311	Błąd Lini Niverplst - Transport System
8493	309	39	2026-10-07 02:51:41.514781	A309	Błąd Lini Niverplst - Easy Plast
8494	310	41	2026-10-07 02:51:41.514781	A310	Alarm Lini Niverplast - Transport System
8495	311	41	2026-10-07 02:51:41.514781	A311	Błąd Lini Niverplst - Transport System
8496	309	39	2026-10-07 02:52:41.807324	A309	Błąd Lini Niverplst - Easy Plast
8497	310	41	2026-10-07 02:52:41.807324	A310	Alarm Lini Niverplast - Transport System
8498	311	41	2026-10-07 02:52:41.807324	A311	Błąd Lini Niverplst - Transport System
8499	309	39	2026-10-07 02:53:42.075734	A309	Błąd Lini Niverplst - Easy Plast
8500	310	41	2026-10-07 02:53:42.075734	A310	Alarm Lini Niverplast - Transport System
8501	311	41	2026-10-07 02:53:42.075734	A311	Błąd Lini Niverplst - Transport System
8502	309	39	2026-10-07 02:54:42.343773	A309	Błąd Lini Niverplst - Easy Plast
8503	310	41	2026-10-07 02:54:42.343773	A310	Alarm Lini Niverplast - Transport System
8504	311	41	2026-10-07 02:54:42.343773	A311	Błąd Lini Niverplst - Transport System
8505	309	39	2026-10-07 02:55:40.750468	A309	Błąd Lini Niverplst - Easy Plast
8506	310	41	2026-10-07 02:55:40.750468	A310	Alarm Lini Niverplast - Transport System
8507	311	41	2026-10-07 02:55:40.750468	A311	Błąd Lini Niverplst - Transport System
8508	309	39	2026-10-07 02:56:41.003959	A309	Błąd Lini Niverplst - Easy Plast
8509	310	41	2026-10-07 02:56:41.003959	A310	Alarm Lini Niverplast - Transport System
8510	311	41	2026-10-07 02:56:41.003959	A311	Błąd Lini Niverplst - Transport System
8511	309	39	2026-10-07 02:57:41.30765	A309	Błąd Lini Niverplst - Easy Plast
8512	310	41	2026-10-07 02:57:41.30765	A310	Alarm Lini Niverplast - Transport System
8513	311	41	2026-10-07 02:57:41.30765	A311	Błąd Lini Niverplst - Transport System
8514	309	39	2026-10-07 02:58:41.57315	A309	Błąd Lini Niverplst - Easy Plast
8515	310	41	2026-10-07 02:58:41.57315	A310	Alarm Lini Niverplast - Transport System
8516	311	41	2026-10-07 02:58:41.57315	A311	Błąd Lini Niverplst - Transport System
8517	309	39	2026-10-07 02:59:41.850004	A309	Błąd Lini Niverplst - Easy Plast
8518	310	41	2026-10-07 02:59:41.850004	A310	Alarm Lini Niverplast - Transport System
8519	311	41	2026-10-07 02:59:41.850004	A311	Błąd Lini Niverplst - Transport System
8520	309	39	2026-10-07 03:00:42.119602	A309	Błąd Lini Niverplst - Easy Plast
8521	310	41	2026-10-07 03:00:42.119602	A310	Alarm Lini Niverplast - Transport System
8522	311	41	2026-10-07 03:00:42.119602	A311	Błąd Lini Niverplst - Transport System
8523	309	39	2026-10-07 03:01:42.398027	A309	Błąd Lini Niverplst - Easy Plast
8524	310	41	2026-10-07 03:01:42.398027	A310	Alarm Lini Niverplast - Transport System
8525	311	41	2026-10-07 03:01:42.398027	A311	Błąd Lini Niverplst - Transport System
8526	309	39	2026-10-07 03:02:42.672303	A309	Błąd Lini Niverplst - Easy Plast
8527	310	41	2026-10-07 03:02:42.672303	A310	Alarm Lini Niverplast - Transport System
8528	311	41	2026-10-07 03:02:42.672303	A311	Błąd Lini Niverplst - Transport System
8529	309	39	2026-10-07 03:03:42.952506	A309	Błąd Lini Niverplst - Easy Plast
8530	310	41	2026-10-07 03:03:42.952506	A310	Alarm Lini Niverplast - Transport System
8531	311	41	2026-10-07 03:03:42.952506	A311	Błąd Lini Niverplst - Transport System
8532	309	39	2026-10-07 03:04:41.364556	A309	Błąd Lini Niverplst - Easy Plast
8533	310	41	2026-10-07 03:04:41.364556	A310	Alarm Lini Niverplast - Transport System
8534	311	41	2026-10-07 03:04:41.364556	A311	Błąd Lini Niverplst - Transport System
8535	106	2	2026-10-07 03:04:41.364556	A106	Błąd pudełko zostało odrzucone
8536	309	39	2026-10-07 03:05:41.606432	A309	Błąd Lini Niverplst - Easy Plast
8537	310	41	2026-10-07 03:05:41.606432	A310	Alarm Lini Niverplast - Transport System
8538	311	41	2026-10-07 03:05:41.606432	A311	Błąd Lini Niverplst - Transport System
8539	309	39	2026-10-07 03:06:41.943329	A309	Błąd Lini Niverplst - Easy Plast
8540	310	41	2026-10-07 03:06:41.943329	A310	Alarm Lini Niverplast - Transport System
8541	311	41	2026-10-07 03:06:41.943329	A311	Błąd Lini Niverplst - Transport System
8542	309	39	2026-10-07 03:07:42.178408	A309	Błąd Lini Niverplst - Easy Plast
8543	310	41	2026-10-07 03:07:42.178408	A310	Alarm Lini Niverplast - Transport System
8544	311	41	2026-10-07 03:07:42.178408	A311	Błąd Lini Niverplst - Transport System
8545	309	39	2026-10-07 03:08:42.445323	A309	Błąd Lini Niverplst - Easy Plast
8546	310	41	2026-10-07 03:08:42.445323	A310	Alarm Lini Niverplast - Transport System
8547	311	41	2026-10-07 03:08:42.445323	A311	Błąd Lini Niverplst - Transport System
8548	309	39	2026-10-07 03:09:42.754755	A309	Błąd Lini Niverplst - Easy Plast
8549	310	41	2026-10-07 03:09:42.754755	A310	Alarm Lini Niverplast - Transport System
8550	311	41	2026-10-07 03:09:42.754755	A311	Błąd Lini Niverplst - Transport System
8551	309	39	2026-10-07 03:10:43.01058	A309	Błąd Lini Niverplst - Easy Plast
8552	310	41	2026-10-07 03:10:43.01058	A310	Alarm Lini Niverplast - Transport System
8553	311	41	2026-10-07 03:10:43.01058	A311	Błąd Lini Niverplst - Transport System
8554	309	39	2026-10-07 03:11:43.304312	A309	Błąd Lini Niverplst - Easy Plast
8555	310	41	2026-10-07 03:11:43.304312	A310	Alarm Lini Niverplast - Transport System
8556	311	41	2026-10-07 03:11:43.304312	A311	Błąd Lini Niverplst - Transport System
8557	309	39	2026-10-07 03:12:41.674056	A309	Błąd Lini Niverplst - Easy Plast
8558	310	41	2026-10-07 03:12:41.674056	A310	Alarm Lini Niverplast - Transport System
8559	311	41	2026-10-07 03:12:41.674056	A311	Błąd Lini Niverplst - Transport System
8560	309	39	2026-10-07 03:13:41.921697	A309	Błąd Lini Niverplst - Easy Plast
8561	310	41	2026-10-07 03:13:41.921697	A310	Alarm Lini Niverplast - Transport System
8562	311	41	2026-10-07 03:13:41.921697	A311	Błąd Lini Niverplst - Transport System
8563	309	39	2026-10-07 03:14:42.234536	A309	Błąd Lini Niverplst - Easy Plast
8564	310	41	2026-10-07 03:14:42.234536	A310	Alarm Lini Niverplast - Transport System
8565	311	41	2026-10-07 03:14:42.234536	A311	Błąd Lini Niverplst - Transport System
8566	309	39	2026-10-07 03:15:42.507884	A309	Błąd Lini Niverplst - Easy Plast
8567	310	41	2026-10-07 03:15:42.507884	A310	Alarm Lini Niverplast - Transport System
8568	311	41	2026-10-07 03:15:42.507884	A311	Błąd Lini Niverplst - Transport System
8569	309	39	2026-10-07 03:16:42.362673	A309	Błąd Lini Niverplst - Easy Plast
8570	310	41	2026-10-07 03:16:42.362673	A310	Alarm Lini Niverplast - Transport System
8571	311	41	2026-10-07 03:16:42.362673	A311	Błąd Lini Niverplst - Transport System
8572	309	39	2026-10-07 03:17:43.169786	A309	Błąd Lini Niverplst - Easy Plast
8573	310	41	2026-10-07 03:17:43.169786	A310	Alarm Lini Niverplast - Transport System
8574	311	41	2026-10-07 03:17:43.169786	A311	Błąd Lini Niverplst - Transport System
8575	309	39	2026-10-07 03:18:43.420448	A309	Błąd Lini Niverplst - Easy Plast
8576	310	41	2026-10-07 03:18:43.420448	A310	Alarm Lini Niverplast - Transport System
8577	311	41	2026-10-07 03:18:43.420448	A311	Błąd Lini Niverplst - Transport System
8578	309	39	2026-10-07 03:19:43.705863	A309	Błąd Lini Niverplst - Easy Plast
8579	310	41	2026-10-07 03:19:43.705863	A310	Alarm Lini Niverplast - Transport System
8580	311	41	2026-10-07 03:19:43.705863	A311	Błąd Lini Niverplst - Transport System
8581	309	39	2026-10-07 03:20:42.098209	A309	Błąd Lini Niverplst - Easy Plast
8582	310	41	2026-10-07 03:20:42.098209	A310	Alarm Lini Niverplast - Transport System
8583	311	41	2026-10-07 03:20:42.098209	A311	Błąd Lini Niverplst - Transport System
8584	309	39	2026-10-07 03:21:42.339447	A309	Błąd Lini Niverplst - Easy Plast
8585	310	41	2026-10-07 03:21:42.339447	A310	Alarm Lini Niverplast - Transport System
8586	311	41	2026-10-07 03:21:42.339447	A311	Błąd Lini Niverplst - Transport System
8587	106	2	2026-10-07 03:21:42.339447	A106	Błąd pudełko zostało odrzucone
8588	309	39	2026-10-07 03:22:42.632115	A309	Błąd Lini Niverplst - Easy Plast
8589	310	41	2026-10-07 03:22:42.632115	A310	Alarm Lini Niverplast - Transport System
8590	311	41	2026-10-07 03:22:42.632115	A311	Błąd Lini Niverplst - Transport System
8591	309	39	2026-10-07 03:23:42.929849	A309	Błąd Lini Niverplst - Easy Plast
8592	310	41	2026-10-07 03:23:42.929849	A310	Alarm Lini Niverplast - Transport System
8593	311	41	2026-10-07 03:23:42.929849	A311	Błąd Lini Niverplst - Transport System
8594	309	39	2026-10-07 03:24:43.214344	A309	Błąd Lini Niverplst - Easy Plast
8595	310	41	2026-10-07 03:24:43.214344	A310	Alarm Lini Niverplast - Transport System
8596	311	41	2026-10-07 03:24:43.214344	A311	Błąd Lini Niverplst - Transport System
8597	309	39	2026-10-07 03:25:43.475362	A309	Błąd Lini Niverplst - Easy Plast
8598	310	41	2026-10-07 03:25:43.475362	A310	Alarm Lini Niverplast - Transport System
8599	311	41	2026-10-07 03:25:43.475362	A311	Błąd Lini Niverplst - Transport System
8600	309	39	2026-10-07 03:26:43.797238	A309	Błąd Lini Niverplst - Easy Plast
8601	310	41	2026-10-07 03:26:43.797238	A310	Alarm Lini Niverplast - Transport System
8602	311	41	2026-10-07 03:26:43.797238	A311	Błąd Lini Niverplst - Transport System
8603	309	39	2026-10-07 03:27:44.108567	A309	Błąd Lini Niverplst - Easy Plast
8604	310	41	2026-10-07 03:27:44.108567	A310	Alarm Lini Niverplast - Transport System
8605	311	41	2026-10-07 03:27:44.108567	A311	Błąd Lini Niverplst - Transport System
8606	309	39	2026-10-07 03:28:44.366247	A309	Błąd Lini Niverplst - Easy Plast
8607	310	41	2026-10-07 03:28:44.366247	A310	Alarm Lini Niverplast - Transport System
8608	311	41	2026-10-07 03:28:44.366247	A311	Błąd Lini Niverplst - Transport System
8609	309	39	2026-10-07 03:29:42.759252	A309	Błąd Lini Niverplst - Easy Plast
8610	310	41	2026-10-07 03:29:42.759252	A310	Alarm Lini Niverplast - Transport System
8611	311	41	2026-10-07 03:29:42.759252	A311	Błąd Lini Niverplst - Transport System
8612	309	39	2026-10-07 03:30:43.008795	A309	Błąd Lini Niverplst - Easy Plast
8613	310	41	2026-10-07 03:30:43.008795	A310	Alarm Lini Niverplast - Transport System
8614	311	41	2026-10-07 03:30:43.008795	A311	Błąd Lini Niverplst - Transport System
8615	309	39	2026-10-07 03:31:43.264072	A309	Błąd Lini Niverplst - Easy Plast
8616	310	41	2026-10-07 03:31:43.264072	A310	Alarm Lini Niverplast - Transport System
8617	311	41	2026-10-07 03:31:43.264072	A311	Błąd Lini Niverplst - Transport System
8618	309	39	2026-10-07 03:32:43.612023	A309	Błąd Lini Niverplst - Easy Plast
8619	310	41	2026-10-07 03:32:43.612023	A310	Alarm Lini Niverplast - Transport System
8620	311	41	2026-10-07 03:32:43.612023	A311	Błąd Lini Niverplst - Transport System
8621	309	39	2026-10-07 03:33:43.882186	A309	Błąd Lini Niverplst - Easy Plast
8622	310	41	2026-10-07 03:33:43.882186	A310	Alarm Lini Niverplast - Transport System
8623	311	41	2026-10-07 03:33:43.882186	A311	Błąd Lini Niverplst - Transport System
8624	309	39	2026-10-07 03:34:44.224197	A309	Błąd Lini Niverplst - Easy Plast
8625	310	41	2026-10-07 03:34:44.224197	A310	Alarm Lini Niverplast - Transport System
8626	311	41	2026-10-07 03:34:44.224197	A311	Błąd Lini Niverplst - Transport System
8627	309	39	2026-10-07 03:35:44.466687	A309	Błąd Lini Niverplst - Easy Plast
8628	310	41	2026-10-07 03:35:44.466687	A310	Alarm Lini Niverplast - Transport System
8629	311	41	2026-10-07 03:35:44.466687	A311	Błąd Lini Niverplst - Transport System
8630	309	39	2026-10-07 03:36:44.77101	A309	Błąd Lini Niverplst - Easy Plast
8631	310	41	2026-10-07 03:36:44.77101	A310	Alarm Lini Niverplast - Transport System
8632	311	41	2026-10-07 03:36:44.77101	A311	Błąd Lini Niverplst - Transport System
8633	309	39	2026-10-07 03:37:43.12243	A309	Błąd Lini Niverplst - Easy Plast
8634	310	41	2026-10-07 03:37:43.12243	A310	Alarm Lini Niverplast - Transport System
8635	311	41	2026-10-07 03:37:43.12243	A311	Błąd Lini Niverplst - Transport System
8636	309	39	2026-10-07 03:38:43.380762	A309	Błąd Lini Niverplst - Easy Plast
8637	310	41	2026-10-07 03:38:43.380762	A310	Alarm Lini Niverplast - Transport System
8638	311	41	2026-10-07 03:38:43.380762	A311	Błąd Lini Niverplst - Transport System
8639	309	39	2026-10-07 03:39:43.703969	A309	Błąd Lini Niverplst - Easy Plast
8640	310	41	2026-10-07 03:39:43.703969	A310	Alarm Lini Niverplast - Transport System
8641	311	41	2026-10-07 03:39:43.703969	A311	Błąd Lini Niverplst - Transport System
8642	309	39	2026-10-07 03:40:43.974829	A309	Błąd Lini Niverplst - Easy Plast
8643	310	41	2026-10-07 03:40:43.974829	A310	Alarm Lini Niverplast - Transport System
8644	311	41	2026-10-07 03:40:43.974829	A311	Błąd Lini Niverplst - Transport System
8645	309	39	2026-10-07 03:41:44.294338	A309	Błąd Lini Niverplst - Easy Plast
8646	310	41	2026-10-07 03:41:44.294338	A310	Alarm Lini Niverplast - Transport System
8647	311	41	2026-10-07 03:41:44.294338	A311	Błąd Lini Niverplst - Transport System
8648	309	39	2026-10-07 03:42:44.586735	A309	Błąd Lini Niverplst - Easy Plast
8649	310	41	2026-10-07 03:42:44.586735	A310	Alarm Lini Niverplast - Transport System
8650	311	41	2026-10-07 03:42:44.586735	A311	Błąd Lini Niverplst - Transport System
8651	309	39	2026-10-07 03:43:44.860865	A309	Błąd Lini Niverplst - Easy Plast
8652	310	41	2026-10-07 03:43:44.860865	A310	Alarm Lini Niverplast - Transport System
8653	311	41	2026-10-07 03:43:44.860865	A311	Błąd Lini Niverplst - Transport System
8654	309	39	2026-10-07 03:44:45.137944	A309	Błąd Lini Niverplst - Easy Plast
8655	310	41	2026-10-07 03:44:45.137944	A310	Alarm Lini Niverplast - Transport System
8656	311	41	2026-10-07 03:44:45.137944	A311	Błąd Lini Niverplst - Transport System
8657	309	39	2026-10-07 03:45:43.470682	A309	Błąd Lini Niverplst - Easy Plast
8658	310	41	2026-10-07 03:45:43.470682	A310	Alarm Lini Niverplast - Transport System
8659	311	41	2026-10-07 03:45:43.470682	A311	Błąd Lini Niverplst - Transport System
8660	309	39	2026-10-07 03:46:43.785883	A309	Błąd Lini Niverplst - Easy Plast
8661	310	41	2026-10-07 03:46:43.785883	A310	Alarm Lini Niverplast - Transport System
8662	311	41	2026-10-07 03:46:43.785883	A311	Błąd Lini Niverplst - Transport System
8663	309	39	2026-10-07 03:47:44.060876	A309	Błąd Lini Niverplst - Easy Plast
8664	310	41	2026-10-07 03:47:44.060876	A310	Alarm Lini Niverplast - Transport System
8665	311	41	2026-10-07 03:47:44.060876	A311	Błąd Lini Niverplst - Transport System
8666	309	39	2026-10-07 03:48:44.371819	A309	Błąd Lini Niverplst - Easy Plast
8667	310	41	2026-10-07 03:48:44.371819	A310	Alarm Lini Niverplast - Transport System
8668	311	41	2026-10-07 03:48:44.371819	A311	Błąd Lini Niverplst - Transport System
8669	309	39	2026-10-07 03:49:44.653251	A309	Błąd Lini Niverplst - Easy Plast
8670	310	41	2026-10-07 03:49:44.653251	A310	Alarm Lini Niverplast - Transport System
8671	311	41	2026-10-07 03:49:44.653251	A311	Błąd Lini Niverplst - Transport System
8672	309	39	2026-10-07 03:50:44.96181	A309	Błąd Lini Niverplst - Easy Plast
8673	310	41	2026-10-07 03:50:44.96181	A310	Alarm Lini Niverplast - Transport System
8674	311	41	2026-10-07 03:50:44.96181	A311	Błąd Lini Niverplst - Transport System
8675	309	39	2026-10-07 03:51:45.243489	A309	Błąd Lini Niverplst - Easy Plast
8676	310	41	2026-10-07 03:51:45.243489	A310	Alarm Lini Niverplast - Transport System
8677	311	41	2026-10-07 03:51:45.243489	A311	Błąd Lini Niverplst - Transport System
8678	309	39	2026-10-07 03:52:45.562877	A309	Błąd Lini Niverplst - Easy Plast
8679	310	41	2026-10-07 03:52:45.562877	A310	Alarm Lini Niverplast - Transport System
8680	311	41	2026-10-07 03:52:45.562877	A311	Błąd Lini Niverplst - Transport System
8681	309	39	2026-10-07 03:53:45.823845	A309	Błąd Lini Niverplst - Easy Plast
8682	310	41	2026-10-07 03:53:45.823845	A310	Alarm Lini Niverplast - Transport System
8683	311	41	2026-10-07 03:53:45.823845	A311	Błąd Lini Niverplst - Transport System
8684	309	39	2026-10-07 03:54:44.108728	A309	Błąd Lini Niverplst - Easy Plast
8685	310	41	2026-10-07 03:54:44.108728	A310	Alarm Lini Niverplast - Transport System
8686	311	41	2026-10-07 03:54:44.108728	A311	Błąd Lini Niverplst - Transport System
8687	309	39	2026-10-07 03:55:44.492545	A309	Błąd Lini Niverplst - Easy Plast
8688	310	41	2026-10-07 03:55:44.492545	A310	Alarm Lini Niverplast - Transport System
8689	311	41	2026-10-07 03:55:44.492545	A311	Błąd Lini Niverplst - Transport System
8690	309	39	2026-10-07 03:56:44.735854	A309	Błąd Lini Niverplst - Easy Plast
8691	310	41	2026-10-07 03:56:44.735854	A310	Alarm Lini Niverplast - Transport System
8692	311	41	2026-10-07 03:56:44.735854	A311	Błąd Lini Niverplst - Transport System
8693	309	39	2026-10-07 03:57:45.080499	A309	Błąd Lini Niverplst - Easy Plast
8694	310	41	2026-10-07 03:57:45.080499	A310	Alarm Lini Niverplast - Transport System
8695	311	41	2026-10-07 03:57:45.080499	A311	Błąd Lini Niverplst - Transport System
8696	309	39	2026-10-07 03:58:45.339025	A309	Błąd Lini Niverplst - Easy Plast
8697	310	41	2026-10-07 03:58:45.339025	A310	Alarm Lini Niverplast - Transport System
8698	311	41	2026-10-07 03:58:45.339025	A311	Błąd Lini Niverplst - Transport System
8699	309	39	2026-10-07 03:59:45.65092	A309	Błąd Lini Niverplst - Easy Plast
8700	310	41	2026-10-07 03:59:45.65092	A310	Alarm Lini Niverplast - Transport System
8701	311	41	2026-10-07 03:59:45.65092	A311	Błąd Lini Niverplst - Transport System
8702	309	39	2026-10-07 04:00:45.936296	A309	Błąd Lini Niverplst - Easy Plast
8703	310	41	2026-10-07 04:00:45.936296	A310	Alarm Lini Niverplast - Transport System
8704	311	41	2026-10-07 04:00:45.936296	A311	Błąd Lini Niverplst - Transport System
8705	309	39	2026-10-07 04:01:46.238533	A309	Błąd Lini Niverplst - Easy Plast
8706	310	41	2026-10-07 04:01:46.238533	A310	Alarm Lini Niverplast - Transport System
8707	311	41	2026-10-07 04:01:46.238533	A311	Błąd Lini Niverplst - Transport System
8708	309	39	2026-10-07 04:02:44.587991	A309	Błąd Lini Niverplst - Easy Plast
8709	310	41	2026-10-07 04:02:44.587991	A310	Alarm Lini Niverplast - Transport System
8710	311	41	2026-10-07 04:02:44.587991	A311	Błąd Lini Niverplst - Transport System
8711	309	39	2026-10-07 04:03:44.832578	A309	Błąd Lini Niverplst - Easy Plast
8712	310	41	2026-10-07 04:03:44.832578	A310	Alarm Lini Niverplast - Transport System
8713	311	41	2026-10-07 04:03:44.832578	A311	Błąd Lini Niverplst - Transport System
8714	309	39	2026-10-07 04:04:45.170429	A309	Błąd Lini Niverplst - Easy Plast
8715	310	41	2026-10-07 04:04:45.170429	A310	Alarm Lini Niverplast - Transport System
8716	311	41	2026-10-07 04:04:45.170429	A311	Błąd Lini Niverplst - Transport System
8717	309	39	2026-10-07 04:05:45.454436	A309	Błąd Lini Niverplst - Easy Plast
8718	310	41	2026-10-07 04:05:45.454436	A310	Alarm Lini Niverplast - Transport System
8719	311	41	2026-10-07 04:05:45.454436	A311	Błąd Lini Niverplst - Transport System
8720	309	39	2026-10-07 04:06:45.760695	A309	Błąd Lini Niverplst - Easy Plast
8721	310	41	2026-10-07 04:06:45.760695	A310	Alarm Lini Niverplast - Transport System
8722	311	41	2026-10-07 04:06:45.760695	A311	Błąd Lini Niverplst - Transport System
8723	309	39	2026-10-07 04:07:46.041731	A309	Błąd Lini Niverplst - Easy Plast
8724	310	41	2026-10-07 04:07:46.041731	A310	Alarm Lini Niverplast - Transport System
8725	311	41	2026-10-07 04:07:46.041731	A311	Błąd Lini Niverplst - Transport System
8726	309	39	2026-10-07 04:08:46.360924	A309	Błąd Lini Niverplst - Easy Plast
8727	310	41	2026-10-07 04:08:46.360924	A310	Alarm Lini Niverplast - Transport System
8728	311	41	2026-10-07 04:08:46.360924	A311	Błąd Lini Niverplst - Transport System
8729	309	39	2026-10-07 04:09:46.635839	A309	Błąd Lini Niverplst - Easy Plast
8730	310	41	2026-10-07 04:09:46.635839	A310	Alarm Lini Niverplast - Transport System
8731	311	41	2026-10-07 04:09:46.635839	A311	Błąd Lini Niverplst - Transport System
8732	309	39	2026-10-07 04:10:44.919639	A309	Błąd Lini Niverplst - Easy Plast
8733	310	41	2026-10-07 04:10:44.919639	A310	Alarm Lini Niverplast - Transport System
8734	311	41	2026-10-07 04:10:44.919639	A311	Błąd Lini Niverplst - Transport System
8735	309	39	2026-10-07 04:11:45.28128	A309	Błąd Lini Niverplst - Easy Plast
8736	310	41	2026-10-07 04:11:45.28128	A310	Alarm Lini Niverplast - Transport System
8737	311	41	2026-10-07 04:11:45.28128	A311	Błąd Lini Niverplst - Transport System
8738	309	39	2026-10-07 04:12:45.531126	A309	Błąd Lini Niverplst - Easy Plast
8739	310	41	2026-10-07 04:12:45.531126	A310	Alarm Lini Niverplast - Transport System
8740	311	41	2026-10-07 04:12:45.531126	A311	Błąd Lini Niverplst - Transport System
8741	309	39	2026-10-07 04:13:45.871746	A309	Błąd Lini Niverplst - Easy Plast
8742	310	41	2026-10-07 04:13:45.871746	A310	Alarm Lini Niverplast - Transport System
8743	311	41	2026-10-07 04:13:45.871746	A311	Błąd Lini Niverplst - Transport System
8744	309	39	2026-10-07 04:14:46.156851	A309	Błąd Lini Niverplst - Easy Plast
8745	310	41	2026-10-07 04:14:46.156851	A310	Alarm Lini Niverplast - Transport System
8746	311	41	2026-10-07 04:14:46.156851	A311	Błąd Lini Niverplst - Transport System
8747	309	39	2026-10-07 04:15:46.45634	A309	Błąd Lini Niverplst - Easy Plast
8748	310	41	2026-10-07 04:15:46.45634	A310	Alarm Lini Niverplast - Transport System
8749	311	41	2026-10-07 04:15:46.45634	A311	Błąd Lini Niverplst - Transport System
8750	309	39	2026-10-07 04:16:46.732183	A309	Błąd Lini Niverplst - Easy Plast
8751	310	41	2026-10-07 04:16:46.732183	A310	Alarm Lini Niverplast - Transport System
8752	311	41	2026-10-07 04:16:46.732183	A311	Błąd Lini Niverplst - Transport System
8753	309	39	2026-10-07 04:17:47.098173	A309	Błąd Lini Niverplst - Easy Plast
8754	310	41	2026-10-07 04:17:47.098173	A310	Alarm Lini Niverplast - Transport System
8755	311	41	2026-10-07 04:17:47.098173	A311	Błąd Lini Niverplst - Transport System
8756	309	39	2026-10-07 04:18:47.324009	A309	Błąd Lini Niverplst - Easy Plast
8757	310	41	2026-10-07 04:18:47.324009	A310	Alarm Lini Niverplast - Transport System
8758	311	41	2026-10-07 04:18:47.324009	A311	Błąd Lini Niverplst - Transport System
8759	309	39	2026-10-07 04:19:45.611874	A309	Błąd Lini Niverplst - Easy Plast
8760	310	41	2026-10-07 04:19:45.611874	A310	Alarm Lini Niverplast - Transport System
8761	311	41	2026-10-07 04:19:45.611874	A311	Błąd Lini Niverplst - Transport System
8762	309	39	2026-10-07 04:20:45.978388	A309	Błąd Lini Niverplst - Easy Plast
8763	310	41	2026-10-07 04:20:45.978388	A310	Alarm Lini Niverplast - Transport System
8764	311	41	2026-10-07 04:20:45.978388	A311	Błąd Lini Niverplst - Transport System
8765	309	39	2026-10-07 04:21:46.229192	A309	Błąd Lini Niverplst - Easy Plast
8766	310	41	2026-10-07 04:21:46.229192	A310	Alarm Lini Niverplast - Transport System
8767	311	41	2026-10-07 04:21:46.229192	A311	Błąd Lini Niverplst - Transport System
8768	309	39	2026-10-07 04:22:46.572194	A309	Błąd Lini Niverplst - Easy Plast
8769	310	41	2026-10-07 04:22:46.572194	A310	Alarm Lini Niverplast - Transport System
8770	311	41	2026-10-07 04:22:46.572194	A311	Błąd Lini Niverplst - Transport System
8771	309	39	2026-10-07 04:23:46.851743	A309	Błąd Lini Niverplst - Easy Plast
8772	310	41	2026-10-07 04:23:46.851743	A310	Alarm Lini Niverplast - Transport System
8773	311	41	2026-10-07 04:23:46.851743	A311	Błąd Lini Niverplst - Transport System
8774	309	39	2026-10-07 04:24:47.152462	A309	Błąd Lini Niverplst - Easy Plast
8775	310	41	2026-10-07 04:24:47.152462	A310	Alarm Lini Niverplast - Transport System
8776	311	41	2026-10-07 04:24:47.152462	A311	Błąd Lini Niverplst - Transport System
8777	309	39	2026-10-07 04:25:47.435539	A309	Błąd Lini Niverplst - Easy Plast
8778	310	41	2026-10-07 04:25:47.435539	A310	Alarm Lini Niverplast - Transport System
8779	311	41	2026-10-07 04:25:47.435539	A311	Błąd Lini Niverplst - Transport System
8780	309	39	2026-10-07 04:26:47.754624	A309	Błąd Lini Niverplst - Easy Plast
8781	310	41	2026-10-07 04:26:47.754624	A310	Alarm Lini Niverplast - Transport System
8782	311	41	2026-10-07 04:26:47.754624	A311	Błąd Lini Niverplst - Transport System
8783	309	39	2026-10-07 04:27:46.095117	A309	Błąd Lini Niverplst - Easy Plast
8784	310	41	2026-10-07 04:27:46.095117	A310	Alarm Lini Niverplast - Transport System
8785	311	41	2026-10-07 04:27:46.095117	A311	Błąd Lini Niverplst - Transport System
8786	309	39	2026-10-07 04:28:46.340019	A309	Błąd Lini Niverplst - Easy Plast
8787	310	41	2026-10-07 04:28:46.340019	A310	Alarm Lini Niverplast - Transport System
8788	311	41	2026-10-07 04:28:46.340019	A311	Błąd Lini Niverplst - Transport System
8789	309	39	2026-10-07 04:29:46.699612	A309	Błąd Lini Niverplst - Easy Plast
8790	310	41	2026-10-07 04:29:46.699612	A310	Alarm Lini Niverplast - Transport System
8791	311	41	2026-10-07 04:29:46.699612	A311	Błąd Lini Niverplst - Transport System
8792	309	39	2026-10-07 04:30:46.962174	A309	Błąd Lini Niverplst - Easy Plast
8793	310	41	2026-10-07 04:30:46.962174	A310	Alarm Lini Niverplast - Transport System
8794	311	41	2026-10-07 04:30:46.962174	A311	Błąd Lini Niverplst - Transport System
8795	309	39	2026-10-07 04:31:47.273802	A309	Błąd Lini Niverplst - Easy Plast
8796	310	41	2026-10-07 04:31:47.273802	A310	Alarm Lini Niverplast - Transport System
8797	311	41	2026-10-07 04:31:47.273802	A311	Błąd Lini Niverplst - Transport System
8798	309	39	2026-10-07 04:32:47.546972	A309	Błąd Lini Niverplst - Easy Plast
8799	310	41	2026-10-07 04:32:47.546972	A310	Alarm Lini Niverplast - Transport System
8800	311	41	2026-10-07 04:32:47.546972	A311	Błąd Lini Niverplst - Transport System
8801	309	39	2026-10-07 04:33:47.856375	A309	Błąd Lini Niverplst - Easy Plast
8802	310	41	2026-10-07 04:33:47.856375	A310	Alarm Lini Niverplast - Transport System
8803	311	41	2026-10-07 04:33:47.856375	A311	Błąd Lini Niverplst - Transport System
8804	309	39	2026-10-07 04:34:48.138542	A309	Błąd Lini Niverplst - Easy Plast
8805	310	41	2026-10-07 04:34:48.138542	A310	Alarm Lini Niverplast - Transport System
8806	311	41	2026-10-07 04:34:48.138542	A311	Błąd Lini Niverplst - Transport System
8807	309	39	2026-10-07 04:35:46.417187	A309	Błąd Lini Niverplst - Easy Plast
8808	310	41	2026-10-07 04:35:46.417187	A310	Alarm Lini Niverplast - Transport System
8809	311	41	2026-10-07 04:35:46.417187	A311	Błąd Lini Niverplst - Transport System
8810	309	39	2026-10-07 04:36:46.761868	A309	Błąd Lini Niverplst - Easy Plast
8811	310	41	2026-10-07 04:36:46.761868	A310	Alarm Lini Niverplast - Transport System
8812	311	41	2026-10-07 04:36:46.761868	A311	Błąd Lini Niverplst - Transport System
8813	309	39	2026-10-07 04:37:47.045319	A309	Błąd Lini Niverplst - Easy Plast
8814	310	41	2026-10-07 04:37:47.045319	A310	Alarm Lini Niverplast - Transport System
8815	311	41	2026-10-07 04:37:47.045319	A311	Błąd Lini Niverplst - Transport System
8816	309	39	2026-10-07 04:38:47.321383	A309	Błąd Lini Niverplst - Easy Plast
8817	310	41	2026-10-07 04:38:47.321383	A310	Alarm Lini Niverplast - Transport System
8818	311	41	2026-10-07 04:38:47.321383	A311	Błąd Lini Niverplst - Transport System
8819	309	39	2026-10-07 04:39:47.683146	A309	Błąd Lini Niverplst - Easy Plast
8820	310	41	2026-10-07 04:39:47.683146	A310	Alarm Lini Niverplast - Transport System
8821	311	41	2026-10-07 04:39:47.683146	A311	Błąd Lini Niverplst - Transport System
8822	309	39	2026-10-07 04:40:47.991289	A309	Błąd Lini Niverplst - Easy Plast
8823	310	41	2026-10-07 04:40:47.991289	A310	Alarm Lini Niverplast - Transport System
8824	311	41	2026-10-07 04:40:47.991289	A311	Błąd Lini Niverplst - Transport System
8825	309	39	2026-10-07 04:41:48.266226	A309	Błąd Lini Niverplst - Easy Plast
8826	310	41	2026-10-07 04:41:48.266226	A310	Alarm Lini Niverplast - Transport System
8827	311	41	2026-10-07 04:41:48.266226	A311	Błąd Lini Niverplst - Transport System
8828	309	39	2026-10-07 04:42:48.570296	A309	Błąd Lini Niverplst - Easy Plast
8829	310	41	2026-10-07 04:42:48.570296	A310	Alarm Lini Niverplast - Transport System
8830	311	41	2026-10-07 04:42:48.570296	A311	Błąd Lini Niverplst - Transport System
8831	309	39	2026-10-07 04:43:46.912122	A309	Błąd Lini Niverplst - Easy Plast
8832	310	41	2026-10-07 04:43:46.912122	A310	Alarm Lini Niverplast - Transport System
8833	311	41	2026-10-07 04:43:46.912122	A311	Błąd Lini Niverplst - Transport System
8834	309	39	2026-10-07 04:44:47.14651	A309	Błąd Lini Niverplst - Easy Plast
8835	310	41	2026-10-07 04:44:47.14651	A310	Alarm Lini Niverplast - Transport System
8836	311	41	2026-10-07 04:44:47.14651	A311	Błąd Lini Niverplst - Transport System
8837	309	39	2026-10-07 04:45:47.49736	A309	Błąd Lini Niverplst - Easy Plast
8838	310	41	2026-10-07 04:45:47.49736	A310	Alarm Lini Niverplast - Transport System
8839	311	41	2026-10-07 04:45:47.49736	A311	Błąd Lini Niverplst - Transport System
8840	309	39	2026-10-07 04:46:47.771304	A309	Błąd Lini Niverplst - Easy Plast
8841	310	41	2026-10-07 04:46:47.771304	A310	Alarm Lini Niverplast - Transport System
8842	311	41	2026-10-07 04:46:47.771304	A311	Błąd Lini Niverplst - Transport System
8843	309	39	2026-10-07 04:47:48.123841	A309	Błąd Lini Niverplst - Easy Plast
8844	310	41	2026-10-07 04:47:48.123841	A310	Alarm Lini Niverplast - Transport System
8845	311	41	2026-10-07 04:47:48.123841	A311	Błąd Lini Niverplst - Transport System
8846	309	39	2026-10-07 04:48:48.378956	A309	Błąd Lini Niverplst - Easy Plast
8847	310	41	2026-10-07 04:48:48.378956	A310	Alarm Lini Niverplast - Transport System
8848	311	41	2026-10-07 04:48:48.378956	A311	Błąd Lini Niverplst - Transport System
8849	309	39	2026-10-07 04:49:48.705106	A309	Błąd Lini Niverplst - Easy Plast
8850	310	41	2026-10-07 04:49:48.705106	A310	Alarm Lini Niverplast - Transport System
8851	311	41	2026-10-07 04:49:48.705106	A311	Błąd Lini Niverplst - Transport System
8852	309	39	2026-10-07 04:50:48.977837	A309	Błąd Lini Niverplst - Easy Plast
8853	310	41	2026-10-07 04:50:48.977837	A310	Alarm Lini Niverplast - Transport System
8854	311	41	2026-10-07 04:50:48.977837	A311	Błąd Lini Niverplst - Transport System
8855	309	39	2026-10-07 04:51:49.272568	A309	Błąd Lini Niverplst - Easy Plast
8856	310	41	2026-10-07 04:51:49.272568	A310	Alarm Lini Niverplast - Transport System
8857	311	41	2026-10-07 04:51:49.272568	A311	Błąd Lini Niverplst - Transport System
8858	309	39	2026-10-07 04:52:47.646121	A309	Błąd Lini Niverplst - Easy Plast
8859	310	41	2026-10-07 04:52:47.646121	A310	Alarm Lini Niverplast - Transport System
8860	311	41	2026-10-07 04:52:47.646121	A311	Błąd Lini Niverplst - Transport System
8861	309	39	2026-10-07 04:53:47.884675	A309	Błąd Lini Niverplst - Easy Plast
8862	310	41	2026-10-07 04:53:47.884675	A310	Alarm Lini Niverplast - Transport System
8863	311	41	2026-10-07 04:53:47.884675	A311	Błąd Lini Niverplst - Transport System
8864	309	39	2026-10-07 04:54:48.236187	A309	Błąd Lini Niverplst - Easy Plast
8865	310	41	2026-10-07 04:54:48.236187	A310	Alarm Lini Niverplast - Transport System
8866	311	41	2026-10-07 04:54:48.236187	A311	Błąd Lini Niverplst - Transport System
8867	309	39	2026-10-07 04:55:48.485442	A309	Błąd Lini Niverplst - Easy Plast
8868	310	41	2026-10-07 04:55:48.485442	A310	Alarm Lini Niverplast - Transport System
8869	311	41	2026-10-07 04:55:48.485442	A311	Błąd Lini Niverplst - Transport System
8870	309	39	2026-10-07 04:56:48.818676	A309	Błąd Lini Niverplst - Easy Plast
8871	310	41	2026-10-07 04:56:48.818676	A310	Alarm Lini Niverplast - Transport System
8872	311	41	2026-10-07 04:56:48.818676	A311	Błąd Lini Niverplst - Transport System
8873	309	39	2026-10-07 04:57:49.106208	A309	Błąd Lini Niverplst - Easy Plast
8874	310	41	2026-10-07 04:57:49.106208	A310	Alarm Lini Niverplast - Transport System
8875	311	41	2026-10-07 04:57:49.106208	A311	Błąd Lini Niverplst - Transport System
8876	309	39	2026-10-07 04:58:49.399378	A309	Błąd Lini Niverplst - Easy Plast
8877	310	41	2026-10-07 04:58:49.399378	A310	Alarm Lini Niverplast - Transport System
8878	311	41	2026-10-07 04:58:49.399378	A311	Błąd Lini Niverplst - Transport System
8879	309	39	2026-10-07 04:59:49.67304	A309	Błąd Lini Niverplst - Easy Plast
8880	310	41	2026-10-07 04:59:49.67304	A310	Alarm Lini Niverplast - Transport System
8881	311	41	2026-10-07 04:59:49.67304	A311	Błąd Lini Niverplst - Transport System
8882	309	39	2026-10-07 05:00:47.970248	A309	Błąd Lini Niverplst - Easy Plast
8883	310	41	2026-10-07 05:00:47.970248	A310	Alarm Lini Niverplast - Transport System
8884	311	41	2026-10-07 05:00:47.970248	A311	Błąd Lini Niverplst - Transport System
8885	309	39	2026-10-07 05:01:48.269304	A309	Błąd Lini Niverplst - Easy Plast
8886	310	41	2026-10-07 05:01:48.269304	A310	Alarm Lini Niverplast - Transport System
8887	311	41	2026-10-07 05:01:48.269304	A311	Błąd Lini Niverplst - Transport System
8888	309	39	2026-10-07 05:02:48.61231	A309	Błąd Lini Niverplst - Easy Plast
8889	310	41	2026-10-07 05:02:48.61231	A310	Alarm Lini Niverplast - Transport System
8890	311	41	2026-10-07 05:02:48.61231	A311	Błąd Lini Niverplst - Transport System
8891	309	39	2026-10-07 05:03:48.879827	A309	Błąd Lini Niverplst - Easy Plast
8892	310	41	2026-10-07 05:03:48.879827	A310	Alarm Lini Niverplast - Transport System
8893	311	41	2026-10-07 05:03:48.879827	A311	Błąd Lini Niverplst - Transport System
8894	309	39	2026-10-07 05:04:49.211817	A309	Błąd Lini Niverplst - Easy Plast
8895	310	41	2026-10-07 05:04:49.211817	A310	Alarm Lini Niverplast - Transport System
8896	311	41	2026-10-07 05:04:49.211817	A311	Błąd Lini Niverplst - Transport System
8897	309	39	2026-10-07 05:05:49.555701	A309	Błąd Lini Niverplst - Easy Plast
8898	310	41	2026-10-07 05:05:49.555701	A310	Alarm Lini Niverplast - Transport System
8899	311	41	2026-10-07 05:05:49.555701	A311	Błąd Lini Niverplst - Transport System
8900	309	39	2026-10-07 05:06:49.82599	A309	Błąd Lini Niverplst - Easy Plast
8901	310	41	2026-10-07 05:06:49.82599	A310	Alarm Lini Niverplast - Transport System
8902	311	41	2026-10-07 05:06:49.82599	A311	Błąd Lini Niverplst - Transport System
8903	309	39	2026-10-07 05:07:50.130468	A309	Błąd Lini Niverplst - Easy Plast
8904	310	41	2026-10-07 05:07:50.130468	A310	Alarm Lini Niverplast - Transport System
8905	311	41	2026-10-07 05:07:50.130468	A311	Błąd Lini Niverplst - Transport System
8906	309	39	2026-10-07 05:08:48.483253	A309	Błąd Lini Niverplst - Easy Plast
8907	310	41	2026-10-07 05:08:48.483253	A310	Alarm Lini Niverplast - Transport System
8908	311	41	2026-10-07 05:08:48.483253	A311	Błąd Lini Niverplst - Transport System
8909	309	39	2026-10-07 05:09:48.704444	A309	Błąd Lini Niverplst - Easy Plast
8910	310	41	2026-10-07 05:09:48.704444	A310	Alarm Lini Niverplast - Transport System
8911	311	41	2026-10-07 05:09:48.704444	A311	Błąd Lini Niverplst - Transport System
8912	309	39	2026-10-07 05:10:49.088828	A309	Błąd Lini Niverplst - Easy Plast
8913	310	41	2026-10-07 05:10:49.088828	A310	Alarm Lini Niverplast - Transport System
8914	311	41	2026-10-07 05:10:49.088828	A311	Błąd Lini Niverplst - Transport System
8915	309	39	2026-10-07 05:11:49.332699	A309	Błąd Lini Niverplst - Easy Plast
8916	310	41	2026-10-07 05:11:49.332699	A310	Alarm Lini Niverplast - Transport System
8917	311	41	2026-10-07 05:11:49.332699	A311	Błąd Lini Niverplst - Transport System
8918	309	39	2026-10-07 05:12:49.666947	A309	Błąd Lini Niverplst - Easy Plast
8919	310	41	2026-10-07 05:12:49.666947	A310	Alarm Lini Niverplast - Transport System
8920	311	41	2026-10-07 05:12:49.666947	A311	Błąd Lini Niverplst - Transport System
8921	309	39	2026-10-07 05:13:49.948275	A309	Błąd Lini Niverplst - Easy Plast
8922	310	41	2026-10-07 05:13:49.948275	A310	Alarm Lini Niverplast - Transport System
8923	311	41	2026-10-07 05:13:49.948275	A311	Błąd Lini Niverplst - Transport System
8924	309	39	2026-10-07 05:14:50.270231	A309	Błąd Lini Niverplst - Easy Plast
8925	310	41	2026-10-07 05:14:50.270231	A310	Alarm Lini Niverplast - Transport System
8926	311	41	2026-10-07 05:14:50.270231	A311	Błąd Lini Niverplst - Transport System
8927	309	39	2026-10-07 05:15:50.559213	A309	Błąd Lini Niverplst - Easy Plast
8928	310	41	2026-10-07 05:15:50.559213	A310	Alarm Lini Niverplast - Transport System
8929	311	41	2026-10-07 05:15:50.559213	A311	Błąd Lini Niverplst - Transport System
8930	309	39	2026-10-07 05:16:48.864751	A309	Błąd Lini Niverplst - Easy Plast
8931	310	41	2026-10-07 05:16:48.864751	A310	Alarm Lini Niverplast - Transport System
8932	311	41	2026-10-07 05:16:48.864751	A311	Błąd Lini Niverplst - Transport System
8933	309	39	2026-10-07 05:17:49.2149	A309	Błąd Lini Niverplst - Easy Plast
8934	310	41	2026-10-07 05:17:49.2149	A310	Alarm Lini Niverplast - Transport System
8935	311	41	2026-10-07 05:17:49.2149	A311	Błąd Lini Niverplst - Transport System
8936	187	40	2026-10-07 05:18:49.449493	A187	Otwarta Bramka Bezpieczeństwa 
8937	129	40	2026-10-07 05:18:49.449493	A129	Niskie ciśnienie pneumatyczne - strefa 1
8938	309	39	2026-10-07 05:18:49.449493	A309	Błąd Lini Niverplst - Easy Plast
8939	310	41	2026-10-07 05:18:49.449493	A310	Alarm Lini Niverplast - Transport System
8940	311	41	2026-10-07 05:18:49.449493	A311	Błąd Lini Niverplst - Transport System
8941	188	40	2026-10-07 05:18:49.449493	A188	Nieryglowany zamek bramki bezpieszeństwa
8942	309	39	2026-10-07 05:19:49.805531	A309	Błąd Lini Niverplst - Easy Plast
8943	310	41	2026-10-07 05:19:49.805531	A310	Alarm Lini Niverplast - Transport System
8944	311	41	2026-10-07 05:19:49.805531	A311	Błąd Lini Niverplst - Transport System
8945	309	39	2026-10-07 05:20:50.090346	A309	Błąd Lini Niverplst - Easy Plast
8946	310	41	2026-10-07 05:20:50.090346	A310	Alarm Lini Niverplast - Transport System
8947	311	41	2026-10-07 05:20:50.090346	A311	Błąd Lini Niverplst - Transport System
8948	309	39	2026-10-07 05:21:50.396786	A309	Błąd Lini Niverplst - Easy Plast
8949	310	41	2026-10-07 05:21:50.396786	A310	Alarm Lini Niverplast - Transport System
8950	311	41	2026-10-07 05:21:50.396786	A311	Błąd Lini Niverplst - Transport System
8951	309	39	2026-10-07 05:22:50.670629	A309	Błąd Lini Niverplst - Easy Plast
8952	310	41	2026-10-07 05:22:50.670629	A310	Alarm Lini Niverplast - Transport System
8953	311	41	2026-10-07 05:22:50.670629	A311	Błąd Lini Niverplst - Transport System
8954	309	39	2026-10-07 05:23:50.982359	A309	Błąd Lini Niverplst - Easy Plast
8955	310	41	2026-10-07 05:23:50.982359	A310	Alarm Lini Niverplast - Transport System
8956	311	41	2026-10-07 05:23:50.982359	A311	Błąd Lini Niverplst - Transport System
8957	309	39	2026-10-07 05:24:49.268817	A309	Błąd Lini Niverplst - Easy Plast
8958	310	41	2026-10-07 05:24:49.268817	A310	Alarm Lini Niverplast - Transport System
8959	311	41	2026-10-07 05:24:49.268817	A311	Błąd Lini Niverplst - Transport System
8960	309	39	2026-10-07 05:25:49.589608	A309	Błąd Lini Niverplst - Easy Plast
8961	310	41	2026-10-07 05:25:49.589608	A310	Alarm Lini Niverplast - Transport System
8962	311	41	2026-10-07 05:25:49.589608	A311	Błąd Lini Niverplst - Transport System
8963	309	39	2026-10-07 05:26:49.852467	A309	Błąd Lini Niverplst - Easy Plast
8964	310	41	2026-10-07 05:26:49.852467	A310	Alarm Lini Niverplast - Transport System
8965	311	41	2026-10-07 05:26:49.852467	A311	Błąd Lini Niverplst - Transport System
8966	309	39	2026-10-07 05:27:50.201368	A309	Błąd Lini Niverplst - Easy Plast
8967	310	41	2026-10-07 05:27:50.201368	A310	Alarm Lini Niverplast - Transport System
8968	311	41	2026-10-07 05:27:50.201368	A311	Błąd Lini Niverplst - Transport System
8969	309	39	2026-10-07 05:28:50.514022	A309	Błąd Lini Niverplst - Easy Plast
8970	310	41	2026-10-07 05:28:50.514022	A310	Alarm Lini Niverplast - Transport System
8971	311	41	2026-10-07 05:28:50.514022	A311	Błąd Lini Niverplst - Transport System
8972	309	39	2026-10-07 05:29:50.811989	A309	Błąd Lini Niverplst - Easy Plast
8973	310	41	2026-10-07 05:29:50.811989	A310	Alarm Lini Niverplast - Transport System
8974	311	41	2026-10-07 05:29:50.811989	A311	Błąd Lini Niverplst - Transport System
8975	309	39	2026-10-07 05:30:51.125834	A309	Błąd Lini Niverplst - Easy Plast
8976	310	41	2026-10-07 05:30:51.125834	A310	Alarm Lini Niverplast - Transport System
8977	311	41	2026-10-07 05:30:51.125834	A311	Błąd Lini Niverplst - Transport System
8978	309	39	2026-10-07 05:31:51.402831	A309	Błąd Lini Niverplst - Easy Plast
8979	310	41	2026-10-07 05:31:51.402831	A310	Alarm Lini Niverplast - Transport System
8980	311	41	2026-10-07 05:31:51.402831	A311	Błąd Lini Niverplst - Transport System
8981	309	39	2026-10-07 05:32:49.694002	A309	Błąd Lini Niverplst - Easy Plast
8982	310	41	2026-10-07 05:32:49.694002	A310	Alarm Lini Niverplast - Transport System
8983	311	41	2026-10-07 05:32:49.694002	A311	Błąd Lini Niverplst - Transport System
8984	309	39	2026-10-07 05:33:50.050966	A309	Błąd Lini Niverplst - Easy Plast
8985	310	41	2026-10-07 05:33:50.050966	A310	Alarm Lini Niverplast - Transport System
8986	311	41	2026-10-07 05:33:50.050966	A311	Błąd Lini Niverplst - Transport System
8987	309	39	2026-10-07 05:34:50.313266	A309	Błąd Lini Niverplst - Easy Plast
8988	310	41	2026-10-07 05:34:50.313266	A310	Alarm Lini Niverplast - Transport System
8989	311	41	2026-10-07 05:34:50.313266	A311	Błąd Lini Niverplst - Transport System
8990	309	39	2026-10-07 05:35:50.661342	A309	Błąd Lini Niverplst - Easy Plast
8991	310	41	2026-10-07 05:35:50.661342	A310	Alarm Lini Niverplast - Transport System
8992	311	41	2026-10-07 05:35:50.661342	A311	Błąd Lini Niverplst - Transport System
8993	309	39	2026-10-07 05:36:50.939831	A309	Błąd Lini Niverplst - Easy Plast
8994	310	41	2026-10-07 05:36:50.939831	A310	Alarm Lini Niverplast - Transport System
8995	311	41	2026-10-07 05:36:50.939831	A311	Błąd Lini Niverplst - Transport System
8996	309	39	2026-10-07 05:37:51.249129	A309	Błąd Lini Niverplst - Easy Plast
8997	310	41	2026-10-07 05:37:51.249129	A310	Alarm Lini Niverplast - Transport System
8998	311	41	2026-10-07 05:37:51.249129	A311	Błąd Lini Niverplst - Transport System
8999	309	39	2026-10-07 05:38:51.555993	A309	Błąd Lini Niverplst - Easy Plast
9000	310	41	2026-10-07 05:38:51.555993	A310	Alarm Lini Niverplast - Transport System
9001	311	41	2026-10-07 05:38:51.555993	A311	Błąd Lini Niverplst - Transport System
9002	309	39	2026-10-07 05:39:51.83343	A309	Błąd Lini Niverplst - Easy Plast
9003	310	41	2026-10-07 05:39:51.83343	A310	Alarm Lini Niverplast - Transport System
9004	311	41	2026-10-07 05:39:51.83343	A311	Błąd Lini Niverplst - Transport System
9005	309	39	2026-10-07 05:40:50.192313	A309	Błąd Lini Niverplst - Easy Plast
9006	310	41	2026-10-07 05:40:50.192313	A310	Alarm Lini Niverplast - Transport System
9007	311	41	2026-10-07 05:40:50.192313	A311	Błąd Lini Niverplst - Transport System
9008	309	39	2026-10-07 05:41:50.426089	A309	Błąd Lini Niverplst - Easy Plast
9009	310	41	2026-10-07 05:41:50.426089	A310	Alarm Lini Niverplast - Transport System
9010	311	41	2026-10-07 05:41:50.426089	A311	Błąd Lini Niverplst - Transport System
9011	309	39	2026-10-07 05:42:50.806724	A309	Błąd Lini Niverplst - Easy Plast
9012	310	41	2026-10-07 05:42:50.806724	A310	Alarm Lini Niverplast - Transport System
9013	311	41	2026-10-07 05:42:50.806724	A311	Błąd Lini Niverplst - Transport System
9014	309	39	2026-10-07 05:43:51.059314	A309	Błąd Lini Niverplst - Easy Plast
9015	310	41	2026-10-07 05:43:51.059314	A310	Alarm Lini Niverplast - Transport System
9016	311	41	2026-10-07 05:43:51.059314	A311	Błąd Lini Niverplst - Transport System
9017	309	39	2026-10-07 05:44:51.400456	A309	Błąd Lini Niverplst - Easy Plast
9018	310	41	2026-10-07 05:44:51.400456	A310	Alarm Lini Niverplast - Transport System
9019	311	41	2026-10-07 05:44:51.400456	A311	Błąd Lini Niverplst - Transport System
9020	309	39	2026-10-07 05:45:51.681768	A309	Błąd Lini Niverplst - Easy Plast
9021	310	41	2026-10-07 05:45:51.681768	A310	Alarm Lini Niverplast - Transport System
9022	311	41	2026-10-07 05:45:51.681768	A311	Błąd Lini Niverplst - Transport System
9023	309	39	2026-10-07 05:46:52.009625	A309	Błąd Lini Niverplst - Easy Plast
9024	310	41	2026-10-07 05:46:52.009625	A310	Alarm Lini Niverplast - Transport System
9025	311	41	2026-10-07 05:46:52.009625	A311	Błąd Lini Niverplst - Transport System
9026	309	39	2026-10-07 05:47:52.282956	A309	Błąd Lini Niverplst - Easy Plast
9027	310	41	2026-10-07 05:47:52.282956	A310	Alarm Lini Niverplast - Transport System
9028	311	41	2026-10-07 05:47:52.282956	A311	Błąd Lini Niverplst - Transport System
9029	309	39	2026-10-07 05:48:52.575334	A309	Błąd Lini Niverplst - Easy Plast
9030	310	41	2026-10-07 05:48:52.575334	A310	Alarm Lini Niverplast - Transport System
9031	311	41	2026-10-07 05:48:52.575334	A311	Błąd Lini Niverplst - Transport System
9032	309	39	2026-10-07 05:49:50.858155	A309	Błąd Lini Niverplst - Easy Plast
9033	310	41	2026-10-07 05:49:50.858155	A310	Alarm Lini Niverplast - Transport System
9034	311	41	2026-10-07 05:49:50.858155	A311	Błąd Lini Niverplst - Transport System
9035	309	39	2026-10-07 05:50:51.194023	A309	Błąd Lini Niverplst - Easy Plast
9036	310	41	2026-10-07 05:50:51.194023	A310	Alarm Lini Niverplast - Transport System
9037	311	41	2026-10-07 05:50:51.194023	A311	Błąd Lini Niverplst - Transport System
9038	309	39	2026-10-07 05:51:51.445305	A309	Błąd Lini Niverplst - Easy Plast
9039	310	41	2026-10-07 05:51:51.445305	A310	Alarm Lini Niverplast - Transport System
9040	311	41	2026-10-07 05:51:51.445305	A311	Błąd Lini Niverplst - Transport System
9041	309	39	2026-10-07 05:52:51.80229	A309	Błąd Lini Niverplst - Easy Plast
9042	310	41	2026-10-07 05:52:51.80229	A310	Alarm Lini Niverplast - Transport System
9043	311	41	2026-10-07 05:52:51.80229	A311	Błąd Lini Niverplst - Transport System
9044	309	39	2026-10-07 05:53:52.135749	A309	Błąd Lini Niverplst - Easy Plast
9045	310	41	2026-10-07 05:53:52.135749	A310	Alarm Lini Niverplast - Transport System
9046	311	41	2026-10-07 05:53:52.135749	A311	Błąd Lini Niverplst - Transport System
9047	309	39	2026-10-07 05:54:52.425231	A309	Błąd Lini Niverplst - Easy Plast
9048	310	41	2026-10-07 05:54:52.425231	A310	Alarm Lini Niverplast - Transport System
9049	311	41	2026-10-07 05:54:52.425231	A311	Błąd Lini Niverplst - Transport System
9050	309	39	2026-10-07 05:55:52.728846	A309	Błąd Lini Niverplst - Easy Plast
9051	310	41	2026-10-07 05:55:52.728846	A310	Alarm Lini Niverplast - Transport System
9052	311	41	2026-10-07 05:55:52.728846	A311	Błąd Lini Niverplst - Transport System
9053	309	39	2026-10-07 05:56:53.018384	A309	Błąd Lini Niverplst - Easy Plast
9054	310	41	2026-10-07 05:56:53.018384	A310	Alarm Lini Niverplast - Transport System
9055	311	41	2026-10-07 05:56:53.018384	A311	Błąd Lini Niverplst - Transport System
9056	309	39	2026-10-07 05:57:51.395581	A309	Błąd Lini Niverplst - Easy Plast
9057	310	41	2026-10-07 05:57:51.395581	A310	Alarm Lini Niverplast - Transport System
9058	311	41	2026-10-07 05:57:51.395581	A311	Błąd Lini Niverplst - Transport System
9059	309	39	2026-10-07 05:58:51.671912	A309	Błąd Lini Niverplst - Easy Plast
9060	310	41	2026-10-07 05:58:51.671912	A310	Alarm Lini Niverplast - Transport System
9061	311	41	2026-10-07 05:58:51.671912	A311	Błąd Lini Niverplst - Transport System
9062	309	39	2026-10-07 05:59:51.934382	A309	Błąd Lini Niverplst - Easy Plast
9063	310	41	2026-10-07 05:59:51.934382	A310	Alarm Lini Niverplast - Transport System
9064	311	41	2026-10-07 05:59:51.934382	A311	Błąd Lini Niverplst - Transport System
9065	309	39	2026-10-07 06:00:52.304219	A309	Błąd Lini Niverplst - Easy Plast
9066	310	41	2026-10-07 06:00:52.304219	A310	Alarm Lini Niverplast - Transport System
9067	311	41	2026-10-07 06:00:52.304219	A311	Błąd Lini Niverplst - Transport System
9068	309	39	2026-10-07 06:01:52.570311	A309	Błąd Lini Niverplst - Easy Plast
9069	310	41	2026-10-07 06:01:52.570311	A310	Alarm Lini Niverplast - Transport System
9070	311	41	2026-10-07 06:01:52.570311	A311	Błąd Lini Niverplst - Transport System
9071	309	39	2026-10-07 06:02:52.87222	A309	Błąd Lini Niverplst - Easy Plast
9072	310	41	2026-10-07 06:02:52.87222	A310	Alarm Lini Niverplast - Transport System
9073	311	41	2026-10-07 06:02:52.87222	A311	Błąd Lini Niverplst - Transport System
9074	309	39	2026-10-07 06:03:53.177736	A309	Błąd Lini Niverplst - Easy Plast
9075	310	41	2026-10-07 06:03:53.177736	A310	Alarm Lini Niverplast - Transport System
9076	311	41	2026-10-07 06:03:53.177736	A311	Błąd Lini Niverplst - Transport System
9077	309	39	2026-10-07 06:04:53.487523	A309	Błąd Lini Niverplst - Easy Plast
9078	310	41	2026-10-07 06:04:53.487523	A310	Alarm Lini Niverplast - Transport System
9079	311	41	2026-10-07 06:04:53.487523	A311	Błąd Lini Niverplst - Transport System
9080	309	39	2026-10-07 06:05:51.856337	A309	Błąd Lini Niverplst - Easy Plast
9081	310	41	2026-10-07 06:05:51.856337	A310	Alarm Lini Niverplast - Transport System
9082	311	41	2026-10-07 06:05:51.856337	A311	Błąd Lini Niverplst - Transport System
9083	309	39	2026-10-07 06:06:52.071576	A309	Błąd Lini Niverplst - Easy Plast
9084	310	41	2026-10-07 06:06:52.071576	A310	Alarm Lini Niverplast - Transport System
9085	311	41	2026-10-07 06:06:52.071576	A311	Błąd Lini Niverplst - Transport System
9086	309	39	2026-10-07 06:07:52.450424	A309	Błąd Lini Niverplst - Easy Plast
9087	310	41	2026-10-07 06:07:52.450424	A310	Alarm Lini Niverplast - Transport System
9088	311	41	2026-10-07 06:07:52.450424	A311	Błąd Lini Niverplst - Transport System
9089	309	39	2026-10-07 06:08:52.715261	A309	Błąd Lini Niverplst - Easy Plast
9090	310	41	2026-10-07 06:08:52.715261	A310	Alarm Lini Niverplast - Transport System
9091	311	41	2026-10-07 06:08:52.715261	A311	Błąd Lini Niverplst - Transport System
9092	309	39	2026-10-07 06:09:53.065536	A309	Błąd Lini Niverplst - Easy Plast
9093	310	41	2026-10-07 06:09:53.065536	A310	Alarm Lini Niverplast - Transport System
9094	311	41	2026-10-07 06:09:53.065536	A311	Błąd Lini Niverplst - Transport System
9095	309	39	2026-10-07 06:10:53.34607	A309	Błąd Lini Niverplst - Easy Plast
9096	310	41	2026-10-07 06:10:53.34607	A310	Alarm Lini Niverplast - Transport System
9097	311	41	2026-10-07 06:10:53.34607	A311	Błąd Lini Niverplst - Transport System
9098	309	39	2026-10-07 06:11:53.637185	A309	Błąd Lini Niverplst - Easy Plast
9099	310	41	2026-10-07 06:11:53.637185	A310	Alarm Lini Niverplast - Transport System
9100	311	41	2026-10-07 06:11:53.637185	A311	Błąd Lini Niverplst - Transport System
9101	309	39	2026-10-07 06:12:53.955191	A309	Błąd Lini Niverplst - Easy Plast
9102	310	41	2026-10-07 06:12:53.955191	A310	Alarm Lini Niverplast - Transport System
9103	311	41	2026-10-07 06:12:53.955191	A311	Błąd Lini Niverplst - Transport System
9104	309	39	2026-10-07 06:13:52.233269	A309	Błąd Lini Niverplst - Easy Plast
9105	310	41	2026-10-07 06:13:52.233269	A310	Alarm Lini Niverplast - Transport System
9106	311	41	2026-10-07 06:13:52.233269	A311	Błąd Lini Niverplst - Transport System
9107	309	39	2026-10-07 06:14:52.489738	A309	Błąd Lini Niverplst - Easy Plast
9108	310	41	2026-10-07 06:14:52.489738	A310	Alarm Lini Niverplast - Transport System
9109	311	41	2026-10-07 06:14:52.489738	A311	Błąd Lini Niverplst - Transport System
9110	309	39	2026-10-07 06:15:52.84015	A309	Błąd Lini Niverplst - Easy Plast
9111	310	41	2026-10-07 06:15:52.84015	A310	Alarm Lini Niverplast - Transport System
9112	311	41	2026-10-07 06:15:52.84015	A311	Błąd Lini Niverplst - Transport System
9113	309	39	2026-10-07 06:16:53.15585	A309	Błąd Lini Niverplst - Easy Plast
9114	310	41	2026-10-07 06:16:53.15585	A310	Alarm Lini Niverplast - Transport System
9115	311	41	2026-10-07 06:16:53.15585	A311	Błąd Lini Niverplst - Transport System
9116	309	39	2026-10-07 06:17:53.476652	A309	Błąd Lini Niverplst - Easy Plast
9117	310	41	2026-10-07 06:17:53.476652	A310	Alarm Lini Niverplast - Transport System
9118	311	41	2026-10-07 06:17:53.476652	A311	Błąd Lini Niverplst - Transport System
9119	309	39	2026-10-07 06:18:53.79747	A309	Błąd Lini Niverplst - Easy Plast
9120	310	41	2026-10-07 06:18:53.79747	A310	Alarm Lini Niverplast - Transport System
9121	311	41	2026-10-07 06:18:53.79747	A311	Błąd Lini Niverplst - Transport System
9122	193	40	2026-10-07 06:19:54.095622	A193	Niskie ciśnienie pneumatyczne - strefa 2
9123	241	40	2026-10-07 06:19:54.095622	A241	Niskie ciśnienie pneumatyczne - strefa 3
9124	309	39	2026-10-07 06:19:54.095622	A309	Błąd Lini Niverplst - Easy Plast
9125	310	41	2026-10-07 06:19:54.095622	A310	Alarm Lini Niverplast - Transport System
9126	311	41	2026-10-07 06:19:54.095622	A311	Błąd Lini Niverplst - Transport System
9127	225	8	2026-10-07 06:19:54.095622	A225	Otwarta Bramka Bezpieczeństwa
9128	226	9	2026-10-07 06:19:54.095622	A226	Niezaryglowany zamek bramki bezpieczenstwa 
9129	193	40	2026-10-07 06:20:54.405044	A193	Niskie ciśnienie pneumatyczne - strefa 2
9130	241	40	2026-10-07 06:20:54.405044	A241	Niskie ciśnienie pneumatyczne - strefa 3
9131	309	39	2026-10-07 06:20:54.405044	A309	Błąd Lini Niverplst - Easy Plast
9132	310	41	2026-10-07 06:20:54.405044	A310	Alarm Lini Niverplast - Transport System
9133	311	41	2026-10-07 06:20:54.405044	A311	Błąd Lini Niverplst - Transport System
9134	225	8	2026-10-07 06:20:54.405044	A225	Otwarta Bramka Bezpieczeństwa
9135	226	9	2026-10-07 06:20:54.405044	A226	Niezaryglowany zamek bramki bezpieczenstwa 
9136	193	40	2026-10-07 06:21:52.718256	A193	Niskie ciśnienie pneumatyczne - strefa 2
9137	241	40	2026-10-07 06:21:52.718256	A241	Niskie ciśnienie pneumatyczne - strefa 3
9138	309	39	2026-10-07 06:21:52.718256	A309	Błąd Lini Niverplst - Easy Plast
9139	310	41	2026-10-07 06:21:52.718256	A310	Alarm Lini Niverplast - Transport System
9140	311	41	2026-10-07 06:21:52.718256	A311	Błąd Lini Niverplst - Transport System
9141	225	8	2026-10-07 06:21:52.718256	A225	Otwarta Bramka Bezpieczeństwa
9142	226	9	2026-10-07 06:21:52.718256	A226	Niezaryglowany zamek bramki bezpieczenstwa 
9143	309	39	2026-10-07 06:22:52.966656	A309	Błąd Lini Niverplst - Easy Plast
9144	310	41	2026-10-07 06:22:52.966656	A310	Alarm Lini Niverplast - Transport System
9145	311	41	2026-10-07 06:22:52.966656	A311	Błąd Lini Niverplst - Transport System
9146	309	39	2026-10-07 06:23:53.353943	A309	Błąd Lini Niverplst - Easy Plast
9147	310	41	2026-10-07 06:23:53.353943	A310	Alarm Lini Niverplast - Transport System
9148	311	41	2026-10-07 06:23:53.353943	A311	Błąd Lini Niverplst - Transport System
9149	309	39	2026-10-07 06:24:53.595332	A309	Błąd Lini Niverplst - Easy Plast
9150	310	41	2026-10-07 06:24:53.595332	A310	Alarm Lini Niverplast - Transport System
9151	311	41	2026-10-07 06:24:53.595332	A311	Błąd Lini Niverplst - Transport System
9152	309	39	2026-10-07 06:25:53.945643	A309	Błąd Lini Niverplst - Easy Plast
9153	310	41	2026-10-07 06:25:53.945643	A310	Alarm Lini Niverplast - Transport System
9154	311	41	2026-10-07 06:25:53.945643	A311	Błąd Lini Niverplst - Transport System
9155	309	39	2026-10-07 06:26:54.239843	A309	Błąd Lini Niverplst - Easy Plast
9156	310	41	2026-10-07 06:26:54.239843	A310	Alarm Lini Niverplast - Transport System
9157	311	41	2026-10-07 06:26:54.239843	A311	Błąd Lini Niverplst - Transport System
9158	309	39	2026-10-07 06:27:54.537133	A309	Błąd Lini Niverplst - Easy Plast
9159	310	41	2026-10-07 06:27:54.537133	A310	Alarm Lini Niverplast - Transport System
9160	311	41	2026-10-07 06:27:54.537133	A311	Błąd Lini Niverplst - Transport System
9161	309	39	2026-10-07 06:28:54.857178	A309	Błąd Lini Niverplst - Easy Plast
9162	310	41	2026-10-07 06:28:54.857178	A310	Alarm Lini Niverplast - Transport System
9163	311	41	2026-10-07 06:28:54.857178	A311	Błąd Lini Niverplst - Transport System
9164	309	39	2026-10-07 06:29:53.13947	A309	Błąd Lini Niverplst - Easy Plast
9165	310	41	2026-10-07 06:29:53.13947	A310	Alarm Lini Niverplast - Transport System
9166	311	41	2026-10-07 06:29:53.13947	A311	Błąd Lini Niverplst - Transport System
9167	309	39	2026-10-07 06:30:53.373216	A309	Błąd Lini Niverplst - Easy Plast
9168	310	41	2026-10-07 06:30:53.373216	A310	Alarm Lini Niverplast - Transport System
9169	311	41	2026-10-07 06:30:53.373216	A311	Błąd Lini Niverplst - Transport System
9170	309	39	2026-10-07 06:31:53.812724	A309	Błąd Lini Niverplst - Easy Plast
9171	310	41	2026-10-07 06:31:53.812724	A310	Alarm Lini Niverplast - Transport System
9172	311	41	2026-10-07 06:31:53.812724	A311	Błąd Lini Niverplst - Transport System
9173	309	39	2026-10-07 06:32:54.115809	A309	Błąd Lini Niverplst - Easy Plast
9174	310	41	2026-10-07 06:32:54.115809	A310	Alarm Lini Niverplast - Transport System
9175	311	41	2026-10-07 06:32:54.115809	A311	Błąd Lini Niverplst - Transport System
9176	309	39	2026-10-07 06:33:54.401998	A309	Błąd Lini Niverplst - Easy Plast
9177	310	41	2026-10-07 06:33:54.401998	A310	Alarm Lini Niverplast - Transport System
9178	311	41	2026-10-07 06:33:54.401998	A311	Błąd Lini Niverplst - Transport System
9179	309	39	2026-10-07 06:34:54.760838	A309	Błąd Lini Niverplst - Easy Plast
9180	310	41	2026-10-07 06:34:54.760838	A310	Alarm Lini Niverplast - Transport System
9181	311	41	2026-10-07 06:34:54.760838	A311	Błąd Lini Niverplst - Transport System
9182	309	39	2026-10-07 06:35:55.055899	A309	Błąd Lini Niverplst - Easy Plast
9183	310	41	2026-10-07 06:35:55.055899	A310	Alarm Lini Niverplast - Transport System
9184	311	41	2026-10-07 06:35:55.055899	A311	Błąd Lini Niverplst - Transport System
9185	309	39	2026-10-07 06:36:54.269387	A309	Błąd Lini Niverplst - Easy Plast
9186	310	41	2026-10-07 06:36:54.269387	A310	Alarm Lini Niverplast - Transport System
9187	311	41	2026-10-07 06:36:54.269387	A311	Błąd Lini Niverplst - Transport System
9188	309	39	2026-10-07 06:37:53.703387	A309	Błąd Lini Niverplst - Easy Plast
9189	310	41	2026-10-07 06:37:53.703387	A310	Alarm Lini Niverplast - Transport System
9190	311	41	2026-10-07 06:37:53.703387	A311	Błąd Lini Niverplst - Transport System
9191	309	39	2026-10-07 06:38:53.964248	A309	Błąd Lini Niverplst - Easy Plast
9192	310	41	2026-10-07 06:38:53.964248	A310	Alarm Lini Niverplast - Transport System
9193	311	41	2026-10-07 06:38:53.964248	A311	Błąd Lini Niverplst - Transport System
9194	309	39	2026-10-07 06:39:54.27732	A309	Błąd Lini Niverplst - Easy Plast
9195	310	41	2026-10-07 06:39:54.27732	A310	Alarm Lini Niverplast - Transport System
9196	311	41	2026-10-07 06:39:54.27732	A311	Błąd Lini Niverplst - Transport System
9197	309	39	2026-10-07 06:40:54.666872	A309	Błąd Lini Niverplst - Easy Plast
9198	310	41	2026-10-07 06:40:54.666872	A310	Alarm Lini Niverplast - Transport System
9199	311	41	2026-10-07 06:40:54.666872	A311	Błąd Lini Niverplst - Transport System
9200	309	39	2026-10-07 06:41:54.955692	A309	Błąd Lini Niverplst - Easy Plast
9201	310	41	2026-10-07 06:41:54.955692	A310	Alarm Lini Niverplast - Transport System
9202	311	41	2026-10-07 06:41:54.955692	A311	Błąd Lini Niverplst - Transport System
9203	309	39	2026-10-07 06:42:55.251684	A309	Błąd Lini Niverplst - Easy Plast
9204	310	41	2026-10-07 06:42:55.251684	A310	Alarm Lini Niverplast - Transport System
9205	311	41	2026-10-07 06:42:55.251684	A311	Błąd Lini Niverplst - Transport System
9206	309	39	2026-10-07 06:43:55.56931	A309	Błąd Lini Niverplst - Easy Plast
9207	310	41	2026-10-07 06:43:55.56931	A310	Alarm Lini Niverplast - Transport System
9208	311	41	2026-10-07 06:43:55.56931	A311	Błąd Lini Niverplst - Transport System
9209	309	39	2026-10-07 06:44:53.826232	A309	Błąd Lini Niverplst - Easy Plast
9210	310	41	2026-10-07 06:44:53.826232	A310	Alarm Lini Niverplast - Transport System
9211	311	41	2026-10-07 06:44:53.826232	A311	Błąd Lini Niverplst - Transport System
9212	309	39	2026-10-07 06:45:54.083406	A309	Błąd Lini Niverplst - Easy Plast
9213	310	41	2026-10-07 06:45:54.083406	A310	Alarm Lini Niverplast - Transport System
9214	311	41	2026-10-07 06:45:54.083406	A311	Błąd Lini Niverplst - Transport System
9215	309	39	2026-10-07 06:46:54.409202	A309	Błąd Lini Niverplst - Easy Plast
9216	310	41	2026-10-07 06:46:54.409202	A310	Alarm Lini Niverplast - Transport System
9217	311	41	2026-10-07 06:46:54.409202	A311	Błąd Lini Niverplst - Transport System
9218	309	39	2026-10-07 06:47:54.767538	A309	Błąd Lini Niverplst - Easy Plast
9219	310	41	2026-10-07 06:47:54.767538	A310	Alarm Lini Niverplast - Transport System
9220	311	41	2026-10-07 06:47:54.767538	A311	Błąd Lini Niverplst - Transport System
9221	309	39	2026-10-07 06:48:55.130639	A309	Błąd Lini Niverplst - Easy Plast
9222	310	41	2026-10-07 06:48:55.130639	A310	Alarm Lini Niverplast - Transport System
9223	311	41	2026-10-07 06:48:55.130639	A311	Błąd Lini Niverplst - Transport System
9224	309	39	2026-10-07 06:49:55.41752	A309	Błąd Lini Niverplst - Easy Plast
9225	310	41	2026-10-07 06:49:55.41752	A310	Alarm Lini Niverplast - Transport System
9226	311	41	2026-10-07 06:49:55.41752	A311	Błąd Lini Niverplst - Transport System
9227	309	39	2026-10-07 06:50:55.732881	A309	Błąd Lini Niverplst - Easy Plast
9228	310	41	2026-10-07 06:50:55.732881	A310	Alarm Lini Niverplast - Transport System
9229	311	41	2026-10-07 06:50:55.732881	A311	Błąd Lini Niverplst - Transport System
9230	309	39	2026-10-07 06:51:56.038228	A309	Błąd Lini Niverplst - Easy Plast
9231	310	41	2026-10-07 06:51:56.038228	A310	Alarm Lini Niverplast - Transport System
9232	311	41	2026-10-07 06:51:56.038228	A311	Błąd Lini Niverplst - Transport System
9233	309	39	2026-10-07 06:52:54.287072	A309	Błąd Lini Niverplst - Easy Plast
9234	310	41	2026-10-07 06:52:54.287072	A310	Alarm Lini Niverplast - Transport System
9235	311	41	2026-10-07 06:52:54.287072	A311	Błąd Lini Niverplst - Transport System
9236	309	39	2026-10-07 06:53:54.719635	A309	Błąd Lini Niverplst - Easy Plast
9237	310	41	2026-10-07 06:53:54.719635	A310	Alarm Lini Niverplast - Transport System
9238	311	41	2026-10-07 06:53:54.719635	A311	Błąd Lini Niverplst - Transport System
9239	309	39	2026-10-07 06:54:54.931278	A309	Błąd Lini Niverplst - Easy Plast
9240	310	41	2026-10-07 06:54:54.931278	A310	Alarm Lini Niverplast - Transport System
9241	311	41	2026-10-07 06:54:54.931278	A311	Błąd Lini Niverplst - Transport System
9242	309	39	2026-10-07 06:55:55.299248	A309	Błąd Lini Niverplst - Easy Plast
9243	310	41	2026-10-07 06:55:55.299248	A310	Alarm Lini Niverplast - Transport System
9244	311	41	2026-10-07 06:55:55.299248	A311	Błąd Lini Niverplst - Transport System
9245	106	2	2026-10-07 06:55:55.299248	A106	Błąd pudełko zostało odrzucone
9246	309	39	2026-10-07 06:56:55.554128	A309	Błąd Lini Niverplst - Easy Plast
9247	310	41	2026-10-07 06:56:55.554128	A310	Alarm Lini Niverplast - Transport System
9248	311	41	2026-10-07 06:56:55.554128	A311	Błąd Lini Niverplst - Transport System
9249	106	2	2026-10-07 06:56:55.554128	A106	Błąd pudełko zostało odrzucone
9250	309	39	2026-10-07 06:57:55.926399	A309	Błąd Lini Niverplst - Easy Plast
9251	310	41	2026-10-07 06:57:55.926399	A310	Alarm Lini Niverplast - Transport System
9252	311	41	2026-10-07 06:57:55.926399	A311	Błąd Lini Niverplst - Transport System
9253	309	39	2026-10-07 06:58:56.203205	A309	Błąd Lini Niverplst - Easy Plast
9254	310	41	2026-10-07 06:58:56.203205	A310	Alarm Lini Niverplast - Transport System
9255	311	41	2026-10-07 06:58:56.203205	A311	Błąd Lini Niverplst - Transport System
9256	309	39	2026-10-07 06:59:56.502961	A309	Błąd Lini Niverplst - Easy Plast
9257	310	41	2026-10-07 06:59:56.502961	A310	Alarm Lini Niverplast - Transport System
9258	311	41	2026-10-07 06:59:56.502961	A311	Błąd Lini Niverplst - Transport System
9259	309	39	2026-10-07 07:00:54.773645	A309	Błąd Lini Niverplst - Easy Plast
9260	310	41	2026-10-07 07:00:54.773645	A310	Alarm Lini Niverplast - Transport System
9261	311	41	2026-10-07 07:00:54.773645	A311	Błąd Lini Niverplst - Transport System
9262	309	39	2026-10-07 07:01:55.087124	A309	Błąd Lini Niverplst - Easy Plast
9263	310	41	2026-10-07 07:01:55.087124	A310	Alarm Lini Niverplast - Transport System
9264	311	41	2026-10-07 07:01:55.087124	A311	Błąd Lini Niverplst - Transport System
9265	309	39	2026-10-07 07:02:55.345324	A309	Błąd Lini Niverplst - Easy Plast
9266	310	41	2026-10-07 07:02:55.345324	A310	Alarm Lini Niverplast - Transport System
9267	311	41	2026-10-07 07:02:55.345324	A311	Błąd Lini Niverplst - Transport System
9268	309	39	2026-10-07 07:03:55.733666	A309	Błąd Lini Niverplst - Easy Plast
9269	310	41	2026-10-07 07:03:55.733666	A310	Alarm Lini Niverplast - Transport System
9270	311	41	2026-10-07 07:03:55.733666	A311	Błąd Lini Niverplst - Transport System
9271	309	39	2026-10-07 07:04:56.025549	A309	Błąd Lini Niverplst - Easy Plast
9272	310	41	2026-10-07 07:04:56.025549	A310	Alarm Lini Niverplast - Transport System
9273	311	41	2026-10-07 07:04:56.025549	A311	Błąd Lini Niverplst - Transport System
9274	309	39	2026-10-07 07:05:56.366234	A309	Błąd Lini Niverplst - Easy Plast
9275	310	41	2026-10-07 07:05:56.366234	A310	Alarm Lini Niverplast - Transport System
9276	311	41	2026-10-07 07:05:56.366234	A311	Błąd Lini Niverplst - Transport System
9277	309	39	2026-10-07 07:06:56.698596	A309	Błąd Lini Niverplst - Easy Plast
9278	310	41	2026-10-07 07:06:56.698596	A310	Alarm Lini Niverplast - Transport System
9279	311	41	2026-10-07 07:06:56.698596	A311	Błąd Lini Niverplst - Transport System
9280	309	39	2026-10-07 07:07:56.992056	A309	Błąd Lini Niverplst - Easy Plast
9281	310	41	2026-10-07 07:07:56.992056	A310	Alarm Lini Niverplast - Transport System
9282	311	41	2026-10-07 07:07:56.992056	A311	Błąd Lini Niverplst - Transport System
9283	309	39	2026-10-07 07:08:55.244727	A309	Błąd Lini Niverplst - Easy Plast
9284	310	41	2026-10-07 07:08:55.244727	A310	Alarm Lini Niverplast - Transport System
9285	311	41	2026-10-07 07:08:55.244727	A311	Błąd Lini Niverplst - Transport System
9286	309	39	2026-10-07 07:09:55.600549	A309	Błąd Lini Niverplst - Easy Plast
9287	310	41	2026-10-07 07:09:55.600549	A310	Alarm Lini Niverplast - Transport System
9288	311	41	2026-10-07 07:09:55.600549	A311	Błąd Lini Niverplst - Transport System
9289	309	39	2026-10-07 07:10:55.864935	A309	Błąd Lini Niverplst - Easy Plast
9290	310	41	2026-10-07 07:10:55.864935	A310	Alarm Lini Niverplast - Transport System
9291	311	41	2026-10-07 07:10:55.864935	A311	Błąd Lini Niverplst - Transport System
9292	309	39	2026-10-07 07:11:56.238402	A309	Błąd Lini Niverplst - Easy Plast
9293	310	41	2026-10-07 07:11:56.238402	A310	Alarm Lini Niverplast - Transport System
9294	311	41	2026-10-07 07:11:56.238402	A311	Błąd Lini Niverplst - Transport System
9295	309	39	2026-10-07 07:12:56.522196	A309	Błąd Lini Niverplst - Easy Plast
9296	310	41	2026-10-07 07:12:56.522196	A310	Alarm Lini Niverplast - Transport System
9297	311	41	2026-10-07 07:12:56.522196	A311	Błąd Lini Niverplst - Transport System
9298	309	39	2026-10-07 07:13:56.884712	A309	Błąd Lini Niverplst - Easy Plast
9299	310	41	2026-10-07 07:13:56.884712	A310	Alarm Lini Niverplast - Transport System
9300	311	41	2026-10-07 07:13:56.884712	A311	Błąd Lini Niverplst - Transport System
9301	309	39	2026-10-07 07:14:57.166651	A309	Błąd Lini Niverplst - Easy Plast
9302	310	41	2026-10-07 07:14:57.166651	A310	Alarm Lini Niverplast - Transport System
9303	311	41	2026-10-07 07:14:57.166651	A311	Błąd Lini Niverplst - Transport System
9304	309	39	2026-10-07 07:15:57.46606	A309	Błąd Lini Niverplst - Easy Plast
9305	310	41	2026-10-07 07:15:57.46606	A310	Alarm Lini Niverplast - Transport System
9306	311	41	2026-10-07 07:15:57.46606	A311	Błąd Lini Niverplst - Transport System
9307	309	39	2026-10-07 07:16:55.815057	A309	Błąd Lini Niverplst - Easy Plast
9308	310	41	2026-10-07 07:16:55.815057	A310	Alarm Lini Niverplast - Transport System
9309	311	41	2026-10-07 07:16:55.815057	A311	Błąd Lini Niverplst - Transport System
9310	309	39	2026-10-07 07:17:56.030205	A309	Błąd Lini Niverplst - Easy Plast
9311	310	41	2026-10-07 07:17:56.030205	A310	Alarm Lini Niverplast - Transport System
9312	311	41	2026-10-07 07:17:56.030205	A311	Błąd Lini Niverplst - Transport System
9313	309	39	2026-10-07 07:18:56.451313	A309	Błąd Lini Niverplst - Easy Plast
9314	310	41	2026-10-07 07:18:56.451313	A310	Alarm Lini Niverplast - Transport System
9315	311	41	2026-10-07 07:18:56.451313	A311	Błąd Lini Niverplst - Transport System
9316	309	39	2026-10-07 07:19:56.681923	A309	Błąd Lini Niverplst - Easy Plast
9317	310	41	2026-10-07 07:19:56.681923	A310	Alarm Lini Niverplast - Transport System
9318	311	41	2026-10-07 07:19:56.681923	A311	Błąd Lini Niverplst - Transport System
9319	309	39	2026-10-07 07:20:57.073818	A309	Błąd Lini Niverplst - Easy Plast
9320	310	41	2026-10-07 07:20:57.073818	A310	Alarm Lini Niverplast - Transport System
9321	311	41	2026-10-07 07:20:57.073818	A311	Błąd Lini Niverplst - Transport System
9322	309	39	2026-10-07 07:21:57.350111	A309	Błąd Lini Niverplst - Easy Plast
9323	310	41	2026-10-07 07:21:57.350111	A310	Alarm Lini Niverplast - Transport System
9324	311	41	2026-10-07 07:21:57.350111	A311	Błąd Lini Niverplst - Transport System
9325	309	39	2026-10-07 07:22:57.684629	A309	Błąd Lini Niverplst - Easy Plast
9326	310	41	2026-10-07 07:22:57.684629	A310	Alarm Lini Niverplast - Transport System
9327	311	41	2026-10-07 07:22:57.684629	A311	Błąd Lini Niverplst - Transport System
9328	309	39	2026-10-07 07:23:58.058262	A309	Błąd Lini Niverplst - Easy Plast
9329	310	41	2026-10-07 07:23:58.058262	A310	Alarm Lini Niverplast - Transport System
9330	311	41	2026-10-07 07:23:58.058262	A311	Błąd Lini Niverplst - Transport System
9331	309	39	2026-10-07 07:24:56.201105	A309	Błąd Lini Niverplst - Easy Plast
9332	310	41	2026-10-07 07:24:56.201105	A310	Alarm Lini Niverplast - Transport System
9333	311	41	2026-10-07 07:24:56.201105	A311	Błąd Lini Niverplst - Transport System
9334	309	39	2026-10-07 07:25:56.503287	A309	Błąd Lini Niverplst - Easy Plast
9335	310	41	2026-10-07 07:25:56.503287	A310	Alarm Lini Niverplast - Transport System
9336	311	41	2026-10-07 07:25:56.503287	A311	Błąd Lini Niverplst - Transport System
9337	309	39	2026-10-07 07:26:56.84291	A309	Błąd Lini Niverplst - Easy Plast
9338	310	41	2026-10-07 07:26:56.84291	A310	Alarm Lini Niverplast - Transport System
9339	311	41	2026-10-07 07:26:56.84291	A311	Błąd Lini Niverplst - Transport System
9340	309	39	2026-10-07 07:27:57.12226	A309	Błąd Lini Niverplst - Easy Plast
9341	310	41	2026-10-07 07:27:57.12226	A310	Alarm Lini Niverplast - Transport System
9342	311	41	2026-10-07 07:27:57.12226	A311	Błąd Lini Niverplst - Transport System
9343	309	39	2026-10-07 07:28:57.516972	A309	Błąd Lini Niverplst - Easy Plast
9344	310	41	2026-10-07 07:28:57.516972	A310	Alarm Lini Niverplast - Transport System
9345	311	41	2026-10-07 07:28:57.516972	A311	Błąd Lini Niverplst - Transport System
9346	309	39	2026-10-07 07:29:57.845248	A309	Błąd Lini Niverplst - Easy Plast
9347	310	41	2026-10-07 07:29:57.845248	A310	Alarm Lini Niverplast - Transport System
9348	311	41	2026-10-07 07:29:57.845248	A311	Błąd Lini Niverplst - Transport System
9349	309	39	2026-10-07 07:30:58.15725	A309	Błąd Lini Niverplst - Easy Plast
9350	310	41	2026-10-07 07:30:58.15725	A310	Alarm Lini Niverplast - Transport System
9351	311	41	2026-10-07 07:30:58.15725	A311	Błąd Lini Niverplst - Transport System
9352	309	39	2026-10-07 07:31:58.47629	A309	Błąd Lini Niverplst - Easy Plast
9353	310	41	2026-10-07 07:31:58.47629	A310	Alarm Lini Niverplast - Transport System
9354	311	41	2026-10-07 07:31:58.47629	A311	Błąd Lini Niverplst - Transport System
9355	309	39	2026-10-07 07:32:57.539114	A309	Błąd Lini Niverplst - Easy Plast
9356	310	41	2026-10-07 07:32:57.539114	A310	Alarm Lini Niverplast - Transport System
9357	311	41	2026-10-07 07:32:57.539114	A311	Błąd Lini Niverplst - Transport System
9358	309	39	2026-10-07 07:33:56.977067	A309	Błąd Lini Niverplst - Easy Plast
9359	310	41	2026-10-07 07:33:56.977067	A310	Alarm Lini Niverplast - Transport System
9360	311	41	2026-10-07 07:33:56.977067	A311	Błąd Lini Niverplst - Transport System
9361	309	39	2026-10-07 07:34:57.410826	A309	Błąd Lini Niverplst - Easy Plast
9362	310	41	2026-10-07 07:34:57.410826	A310	Alarm Lini Niverplast - Transport System
9363	311	41	2026-10-07 07:34:57.410826	A311	Błąd Lini Niverplst - Transport System
9364	309	39	2026-10-07 07:35:57.673753	A309	Błąd Lini Niverplst - Easy Plast
9365	310	41	2026-10-07 07:35:57.673753	A310	Alarm Lini Niverplast - Transport System
9366	311	41	2026-10-07 07:35:57.673753	A311	Błąd Lini Niverplst - Transport System
9367	309	39	2026-10-07 07:36:58.05856	A309	Błąd Lini Niverplst - Easy Plast
9368	310	41	2026-10-07 07:36:58.05856	A310	Alarm Lini Niverplast - Transport System
9369	311	41	2026-10-07 07:36:58.05856	A311	Błąd Lini Niverplst - Transport System
\.


--
-- Data for Name: machine_part_errors; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.machine_part_errors (id, part_id, error_code, description) FROM stdin;
168	40	A168	\N
169	40	A169	\N
170	40	A170	\N
171	40	A171	\N
172	40	A172	\N
173	40	A173	\N
174	40	A174	\N
175	40	A175	\N
176	40	A176	\N
177	40	A177	\N
178	40	A178	\N
179	40	A179	\N
180	40	A180	\N
181	40	A181	\N
182	40	A182	\N
183	40	A183	\N
184	40	A184	\N
185	40	A185	\N
186	40	A186	\N
189	40	A189	\N
190	40	A190	\N
191	40	A191	\N
192	40	A192	\N
193	40	A193	Niskie ciśnienie pneumatyczne - strefa 2
12	40	A12	Wciśnięty E-Stop - bramka bezpieczeństwa 11.B4
16	40	A16	\N
48	40	A48	Błąd komunikacji Profinet - moduł 67.A1
49	40	A49	Błąd komunikacji Profinet - moduł 67.A2
51	40	A51	Błąd komunikacji Profinet - moduł 11.B1
52	40	A52	\N
53	40	A53	\N
54	40	A54	\N
55	40	A55	\N
56	40	A56	\N
57	40	A57	\N
58	40	A58	\N
59	40	A59	\N
60	40	A60	\N
61	40	A61	\N
62	40	A62	\N
63	40	A63	\N
64	40	A64	\N
65	40	A65	\N
66	40	A66	\N
67	40	A67	\N
68	40	A68	\N
69	40	A69	\N
70	40	A70	\N
71	40	A71	\N
72	40	A72	\N
73	40	A73	\N
74	40	A74	\N
75	40	A75	\N
76	40	A76	\N
77	40	A77	\N
78	40	A78	\N
79	40	A79	\N
80	40	A80	\N
409	40	A409	\N
97	40	A97	Brak zgodności kodu na przenośniku z detektorem metalu - zabierz karton z przenośnika
98	40	A98	Brak zgodności kodu na przenośniku obrotu kartonu - zabierz karton z przenośnika
99	40	A99	\N
100	40	A100	\N
101	40	A101	\N
102	40	A102	\N
103	40	A103	\N
104	40	A104	\N
105	40	A105	\N
107	40	A107	\N
194	33	A194	Błąd wysunięcia siłownika U9 - blokada przekładek góra
195	33	A195	Błąd wsunięcia siłownika U9 - blokada przekładek góra
196	33	A196	Błąd wysunięcia siłownika U10 - blokada przekładek środek
197	33	A197	Błąd wsunięcia siłownika U10 - blokada przekładek środek
198	33	A198	Błąd wysunięcia siłownika U11 - blokada przekładek dół
199	33	A199	Błąd wsunięcia siłownika U11 - blokada przekładek dół
200	33	A200	Błąd wysunięcia siłownika U12.1 - blokada tył przekładek
201	33	A201	Błąd wysunięcia siłownika U12.2 - blokada tył przekładek
202	33	A202	Błąd wysunięcia siłownika U12.3 - blokada tył przekładek
203	33	A203	Błąd wysunięcia siłownika U12.4 - blokada tył przekładek
204	33	A204	Błąd wsunięcia siłownika U12.1 - blokada tył przekładek
205	33	A205	Błąd wsunięcia siłownika U12.2 - blokada tył przekładek
206	33	A206	Błąd wsunięcia siłownika U12.3 - blokada tył przekładek
207	33	A207	Błąd wsunięcia siłownika U12.4 - blokada tył przekładek
208	29	A208	Zbyt długi czas wjazdu palety na przenośnik odbioru pustych kartonów
209	30	A209	Zbyt długi czas przejazdu palety do czujnika wjazdowego przenośnika buforowego niepełnych palet 1
210	30	A210	Zbyt długi czas przejazdu palety do czujnika wyjazdowego przenośnika buforowego niepełnych palet 1
211	30	A211	Zbyt długi czas przejazdu palety z przenośnika buforowego niepełnych palet 1 na przenośnik buforowy 2
212	30	A212	Zbyt długi czas przejazdu palety z przenośnika buforowego niepełnych palet 1 na wózek transportowy
213	31	A213	Zbyt długi czas wjazdu palety na przenośnik buforowy niepełnych palet 2
108	40	A108	\N
109	40	A109	\N
110	40	A110	\N
111	40	A111	\N
112	40	A112	\N
113	40	A113	Niskie ciśnienie pneumatyczne strefa E-Stop
1	40	A1	Wciśnięty E-Stop - elewacja szafy
2	40	A2	Wciśnięty E-Stop - szafka HMI
3	40	A3	Wciśnięty E-Stop - kasetka kurtyna 1
4	40	A4	Wciśnięty E-Stop - kasetka kurtyna 2
5	40	A5	Wciśnięty E-Stop - kasetka kurtyna 3
6	40	A6	Wciśnięty E-Stop - kasetka kurtyna 4
7	40	A7	Wciśnięty E-Stop - kasetka kurtyna 5
13	7	A13	Brak zasilania robota Kawasaki
15	7	A15	Brak komunikacji z robotem Kawasaki
17	10	A17	Błąd komunikacji Profinet - falownik 30.T1 - przenośnik wyjazdowy palety 2
18	9	A18	Błąd komunikacji Profinet - falownik 31.T2 - przenośnik wyjazdowy palety 1
19	8	A19	Błąd komunikacji Profinet - falownik 32.T3 - przenośnik paletyzacji
20	36	A20	Błąd komunikacji Profinet - falownik 33.T4 - przenośnik buforowy palet 1200x1000
21	37	A21	Błąd komunikacji Profinet - falownik 34.T5 - przenośnik pobrania palet 1200x1000
22	34	A22	Błąd komunikacji Profinet - falownik 35.T6 - przenośnik buforowy palet 1200x800
23	35	A23	Błąd komunikacji Profinet - falownik 36.T7 - przenośnik pobrania palet 1200x800
24	32	A24	Błąd komunikacji Profinet - falownik 37.T8 - przenośnik buforowy przekładek 1200x800
25	33	A25	Błąd komunikacji Profinet - falownik 38.T9 - przenośnik pobrania przekładek 1200x800
187	40	A187	Otwarta Bramka Bezpieczeństwa 
26	30	A26	Błąd komunikacji Profinet - falownik 39.T10 - przenośnik buforowy nieukończonych palet 1
27	31	A27	Błąd komunikacji Profinet - falownik 40.T11 - przenośnik buforowy nieukończonych palet 2
28	29	A28	Błąd komunikacji Profinet - falownik 41.T12 - przenośnik odbioru pakietu pustych kartonów
29	17	A29	Błąd komunikacji Profinet - falownik 42.T13 - przenośnik buforowy europalet
30	16	A30	Błąd komunikacji Profinet - falownik 43.T14 - przenośnik z folią do owijarki
31	15	A31	Błąd komunikacji Profinet - falownik 44.T15 - przenośnik z akcesoriami do etykieciarki
32	20	A32	Błąd komunikacji Profinet - falownik 45.T16 - przenośnik wyjazdowy rząd palet 1200x800
33	19	A33	Błąd komunikacji Profinet - falownik 46.T17 - przenośnik środkowy rząd palet 1200x800
34	18	A34	Błąd komunikacji Profinet - falownik 47.T18 - przenośnik wjazdowy rząd palet 1200x800
35	23	A35	Błąd komunikacji Profinet - falownik 48.T19 - przenośnik wyjazdowy rząd dostarczania elementów paletyzacji
36	22	A36	Błąd komunikacji Profinet - falownik 49.T20 - przenośnik środkowy rząd dostarczania elementów paletyzacji
37	21	A37	Błąd komunikacji Profinet - falownik 50.T21 - przenośnik wjazdowy rząd dostarczania elementów paletyzacji
38	26	A38	Błąd komunikacji Profinet - falownik 51.T22 - przenośnik wyjazdowy rząd pustych kartonów do kartoniarki
39	25	A39	Błąd komunikacji Profinet - falownik 52.T23 - przenośnik środkowy rząd pustych kartonów do kartoniarki
40	24	A40	Błąd komunikacji Profinet - falownik 53.T24 - przenośnik końcowy rząd pustych kartonów do kartoniarki
41	14	A41	Błąd komunikacji Profinet - falownik 54.T25 - przenośnik odbioru gotowej palety
42	11	A42	Błąd komunikacji Profinet - falownik 55.T26 - ruch po torze jezdnym - zapasowy T-Car
43	11	A43	Błąd komunikacji Profinet - falownik 56.T27 - przenośnik łańcuchowy - zapasowy T-Car
44	12	A44	Błąd komunikacji Profinet - falownik 57.T28 - ruch po torze jezdnym - podstawowy T-Car
45	12	A45	Błąd komunikacji Profinet - falownik 58.T29 - przenośnik łańcuchowy - podstawowy T-Car
46	1	A46	Błąd komunikacji Profinet - falownik 59.T30 - przenośnik z detektorem metalu
47	6	A47	Błąd komunikacji Profinet - falownik 60.T31 - przenośnik pobranie pakietu kartonów
50	7	A50	Błąd komunikacji Profinet - robot Kawasaki
8	40	A8	Wciśnięty E-Stop - kasetka kurtyna 6
9	40	A9	Wciśnięty E-Stop - kasetka kurtyna 7
10	40	A10	Wciśnięty E-Stop - bramka bezpieczeństwa 11.B2
11	40	A11	Wciśnięty E-Stop - bramka bezpieczeństwa 11.B3
81	1	A81	Błąd podczas skanowania kodu kartonu przenośnik pod detektorem metali
82	1	A82	Zabierz karton z końca przenośnika pasowego pod detektorem metali
83	1	A83	Zbyt długi czas przejazdu kartonu na koniec przenośnika pod detektorem metali
84	1	A84	Zbyt długi czas wyjazdu kartonu z przenośnika pod detektorem metali
85	1	A85	Brak gotowości detektora metali
86	2	A86	Zabierz karton z przenośnika odrzutu kartonu
87	2	A87	Zbyt długi czas wjazdu kartonu na przenośnik z odrzutem kartonu
88	2	A88	Zbyt długi czas wyjazdu kartonu z przenośnika z odrzutem kartonu
89	3	A89	Zbyt długi czas przejazdu kartonu na koniec 1 przenośnika buforowego kartonu
90	3	A90	Zbyt długi czas wyjazdu kartonu z 1 przenośnika buforowego kartonu
91	4	A91	Zbyt długi czas przejazdu kartonu na koniec 2 przenośnika buforowego kartonu
92	4	A92	Zbyt długi czas wyjazdu kartonu z 2 przenośnika buforowego kartonu
93	5	A93	Błąd podczas skanowania kartonu przenośnik obrotu kartonu
94	5	A94	Zbyt długi czas wjazdu kartonu na przenośnik z obrotem kartonu
95	5	A95	Zbyt długi czas wyjazdu kartonu z przenośnika z obrotem kartonu
96	6	A96	Zbyt długi czas wjazdu kartonu na przenośnik pobrania przez robota
114	2	A114	Błąd wysunięcia siłownika U14 - odrzut kartonu
115	2	A115	Błąd wsunięcia siłownika U14 - odrzut kartonu
116	5	A116	Błąd wysunięcia siłownika U15 - przytrzymanie kartonu
117	5	A117	Błąd wsunięcia siłownika U15 - przytrzymanie kartonu
118	5	A118	Błąd wysunięcia siłownika U16 - obrót kartonu
119	5	A119	Błąd wsunięcia siłownika U16 - obrót kartonu
120	38	A120	Błąd aplikatora etykiet 1
121	39	A121	Błąd aplikatora etykiet 2
130	13	A130	Błąd wysunięcia siłownika U6 - wysuwanie etykiety
131	13	A131	Błąd wsunięcia siłownika U6 - wsuwanie etykiety
132	26	A132	Zbyt długi czas przejazdu palety do czujnika wjazdowego przenośnik 1 rząd 1
133	26	A133	Zbyt długi czas przejazdu palety do czujnika wyjazdowego przenośnik 1 rząd 1
134	26	A134	Zbyt długi czas wyjazdu palety z przenośnika 1 na przenośnik 2 rząd 1
135	26	A135	Zbyt długi czas wyjazdu palety z przenośnika 1 rząd 1 na T-Car 1
136	26	A136	Zbyt długi czas wyjazdu palety z przenośnika 1 rząd 2 na T-Car 2
137	25	A137	Zbyt długi czas przejazdu palety do czujnika wjazdowego przenośnik 2 rząd 1
138	25	A138	Zbyt długi czas przejazdu palety do czujnika wyjazdowego przenośnik 2 rząd 1
139	25	A139	Zbyt długi czas przejazd palety z przenośnika 2 na przenośnik 1 rząd 1
140	25	A140	Zbyt długi czas przejazdu palety z przenośnika 2 na przenośnik 3 rząd 1
141	24	A141	Zbyt długi czas przejazdu na koniec przenośnika 3 rząd 1
142	24	A142	Zbyt długi czas przejazdu palety z przenośnika 3 na przenośnik 2 rząd 1
143	21	A143	Zbyt długi czas przejazdu palety na koniec przenośnika 1 rząd 2
144	21	A144	Zbyt długi czas wyjazdu palety z przenośnika 1 rząd 2
145	22	A145	Zbyt długi czas przejazdu palety na koniec przenośnika 2 rząd 2
146	22	A146	Zbyt długi czas wyjazdu palety z przenośnika 2 rząd 2
147	23	A147	Zbyt długi czas przejazdu palety na koniec przenośnika 3 rząd 2
148	23	A148	Zbyt długi czas wyjazdu palety z przenośnika 3 rząd 2
149	18	A149	Zbyt długi czas przejazdu palety na koniec przenośnika 1 rząd palet 1200x800
150	18	A150	Zbyt długi czas wyjazdu palety z przenośnika 1 rząd palet 1200x800
151	19	A151	Zbyt długi czas przejazdu palety na koniec przenośnika 2 rząd palet 1200x800
152	19	A152	Zbyt długi czas wyjazdu palety z przenośnika 2 rząd palet 1200x800
153	20	A153	Zbyt długi czas przejazdu palety na koniec przenośnika 3 rząd palet 1200x800
154	20	A154	Zbyt długi czas wyjazdu palety z przenośnika 3 rząd palet 1200x800
155	17	A155	Zbyt długi czas przejazdu palety na koniec przenośnika buforowego europalet
156	17	A156	Zbyt długi czas wyjazdu palety z przenośnika buforowego europalet na przenośnik z foliami do owijarki
157	17	A157	Zbyt długi czas wyjazdu palety z przenośnika buforowego europalet na T-Car 1
158	17	A158	Zbyt długi czas wyjazdu palety z przenośnika buforowego europalet na T-Car 2
159	16	A159	Zbyt długi czas przejazdu palety na koniec przenośnika z foliami do owijarki
160	16	A160	Zbyt długi czas wyjazdu palety z przenośnika z foliami do owijarki
161	15	A161	Brak bezpieczeństwa kurtyny 1 - stanowisko odbioru gotowej palety
214	31	A214	Zbyt długi czas przejazdu palety z przenośnika buforowego niepełnych palet 2 na przenośnik buforowy 1
215	32	A215	Zbyt długi czas przejazdu palety do czujnika wjazdowego przenośnika buforowego przekładek 1200x800
216	32	A216	Zbyt długi czas przejazdu palety do czujnika wyjazdowego przenośnika buforowego przekładek 1200x800
217	32	A217	Zbyt długi czas przejazdu palety z przenośnika buforowego przekładek 1200x800 na wózek transportowy 1
218	32	A218	Zbyt długi czas przejazdu palety z przenośnika buforowego przekładek 1200x800 na wózek transportowy 2
219	32	A219	Zbyt długi czas wjazdu palety na przenośnik pobierania przekładek 1200x800
220	33	A220	\N
242	8	A242	Błąd wysuwania siłownika U13 - pozycjoner palety
243	8	A243	Błąd wsuwania siłownika U13 - pozycjoner palety
244	34	A244	Zbyt długi czas przejazdu palety na początek przenośnika buforowego palet 1200x800
245	34	A245	Zbyt długi czas przejazdu palety na koniec przenośnika buforowego palet 1200x800
246	34	A246	Zbyt długi czas przejazdu palety z przenośnika buforowego palet 1200x800 na przenośnik pobrania palet 1200x800
247	34	A247	Zbyt długi czas przejazdu palety z przenośnika buforowego palet 1200x800 na wózek transportowy 1
248	34	A248	Zbyt długi czas przejazdu palety z przenośnika buforowego palet 1200x800 na wózek transportowy 2
249	35	A249	Zbyt długi czas wjazdu palety na przenośnik pobrania palet 1200x800
250	35	A250	Zbyt długi czas wyjazdu palety z przenośnika pobrania palet 1200x800 na przenośnik buforowy palet 1200x800
251	36	A251	Zbyt długi czas wjazdu palety na koniec przenośnika buforowego palet 1200x1000
252	36	A252	Zbyt długi czas wyjazdu palety z przenośnika buforowego palet 1200x1000
253	36	A253	Zbyt długi czas wjazdu palety na przenośnik pobrania palet 1200x1000
254	37	A254	Zbyt długi czas przejazdu palety na początek przenośnika paletyzacji kartonów
255	8	A255	Zbyt długi czas przejazdu palety z przenośnika paletyzacji kartonów na przenośnik buforowy spakowanych palet 1
256	8	A256	Zbyt długi czas wjazdu palety na przenośnik buforowy spakowanych palet 1
257	9	A257	Zbyt długi czas przejazdu palety z przenośnika buforowego spakowanych palet 1 na przenośnik buforowy 2
258	10	A258	Zbyt długi czas wjazdu palety na przenośnik buforowy spakowanych palet 2
259	10	A259	Zbyt długi czas przejazdu palety z przenośnika buforowego spakowanych palet 2 na wózek transportowy 2
14	7	A14	Błąd robota Kawasaki - sprawdź treść błędu na Teach Pendancie
321	7	A321	Błąd wsunięcia wideł palet - chwytak robota
221	40	A221	\N
322	7	A322	Błąd wysunięcia wideł palet - chwytak robota
323	7	A323	Błąd wsunięcia docisku - chwytak robota
324	7	A324	Bład wysunięcia docisku - chwytak robota
325	7	A325	Błąd wsunięcia wideł - chwytak robota
326	7	A326	\N
327	7	A327	Błąd wysunięcia wideł chwytaka
328	7	A328	Błąd wsunięcia siłownika przekładek - chwytak robota
329	7	A329	Błąd wysunięcia siłownika przekładek - chwytak robota
330	7	A330	Brak podciśnienia przy pobraniu przekładki - chwytak robota
331	7	A331	Brak podciśnienia przy odłożeniu przekładki - chwytak robota
332	7	A332	Robot Kawasaki - zbyt niski numer programu
333	7	A333	Robot Kawasaki - zbyt wysoki numer programu
334	7	A334	Robot Kawasaki - zbyt niski numer palety
335	7	A335	Robot Kawasaki - zbyt wysoki numer palety
337	7	A337	Robot Kawasaki - zbyt niski numer rzędu
338	7	A338	Robot Kawasaki - zbyt wysoki numer rzędu
339	7	A339	Robot Kawasaki - zbyt niski numer warstwy
340	7	A340	Robot Kawasaki - zbyt wysoki numer warstwy
341	7	A341	Robot Kawasaki - błąd pomiaru palety
353	28	A353	Zbyt długi czas pozycjonowania do przodu szybko - T-Car 1
354	28	A354	Zbyt długi czas pozycjonowania do przodu wolno - T-Car 1
355	28	A355	Zbyt długi czas pozycjonowania do tyłu szybko - T-Car 1
356	28	A356	Zbyt długi czas pozycjonowania do tyłu wolno - T-Car 1
357	28	A357	Błąd pozycji T-Car 1 na torze jezdnym - możliwe wyjechanie poza tor
358	28	A358	Zbyt długi czas przejazdu - rząd 1 (palet z kartonami do kartoniarki) => T-Car 1
359	28	A359	Zbyt długi czas przejazdu - rząd 2 (palety z elementami paletyzacji) => T-Car 1
360	28	A360	Zbyt długi czas przejazdu - rząd 3 (bufor palet 1200x800) => T-Car 1
361	28	A361	Zbyt długi czas przejazdu - rząd 4 (palety z akcesoriami do owijarki i etykieciarki) => T-Car 1
362	28	A362	Zbyt długi czas przejazdu - rząd 5 (miejsce pobierania kartonów do kartoniarki) => T-Car 1
363	28	A363	Zbyt długi czas przejazdu - rząd 6 (rząd buforowy niepełnych palet) => T-Car 1
364	28	A364	Zbyt długi czas przejazdu - rząd 7 (rząd przekładek 1200x800) => T-Car 1
365	28	A365	Zbyt długi czas przejazdu - rząd 8 (rząd palet 1200x800) => T-Car 1
366	28	A366	Zbyt długi czas przejazdu - rząd 9 (rząd palet 1200x1000) => T-Car 1
367	28	A367	Zbyt długi czas przejazdu - T-Car 1 => rząd 1 (palety z pustymi kartonami)
368	28	A368	Zbyt długi czas przejazdu - T-Car 1 => rząd 4 (palety z akcesoriami do owijarki i etykieciarki)
369	28	A369	Zbyt długi czas przejazdu - T-Car 1 => rząd 5 (miejsce pobrania kartonów do kartoniarki)
370	28	A370	Zbyt długi czas przejazdu - T-Car 1 => rząd 6 (rząd buforowy niepełnych palet)
371	28	A371	Zbyt długi czas przejazdu - T-Car 1 => rząd 7 (rząd przekładek 1200x800)
372	28	A372	Zbyt długi czas przejazdu - T-Car 1 => rząd 8 (rząd palet 1200x800)
373	28	A373	Zbyt długi czas przejazdu - T-Car 1 => rząd 9 (rząd palet 1200x1000)
385	11	A385	Zbyt długi czas pozycjonowania do przodu szybko - T-Car 2
386	11	A386	Zbyt długi czas pozycjonowania do przodu wolno - T-Car 2
387	11	A387	Zbyt długi czas pozycjonowania do tyłu szybko - T-Car 2
388	11	A388	Zbyt długi czas pozycjonowania do tyłu wolno - T-Car 2
389	11	A389	Błąd pozycji T-Car 2 na torze jezdnym - możliwe wyjechanie poza tor
390	11	A390	Zbyt długi czas przejazdu - rząd paletyzacji kartonów => T-Car 2
391	11	A391	Zbyt długi czas przejazdu - rząd 1 (palet z pustymi kartonami) => T-Car 2
392	11	A392	Zbyt długi czas przejazdu - rząd 2 (palety z elementami paletyzacji) => T-Car 2
393	11	A393	Zbyt długi czas przejazdu - rząd 3 (bufor palet 1200x800) => T-Car 2
394	11	A394	Zbyt długi czas przejazdu - rząd 4 (palety z akcesoriami do owijarki i etykieciarki) => T-Car 2
395	11	A395	Zbyt długi czas przejazdu - rząd 5 (paleta z kartonami do kartoniarki) => T-Car 2
396	11	A396	Zbyt długi czas przejazdu - rząd 6 (rząd buforowy niepełnych palet) => T-Car 2
397	11	A397	Zbyt dług czas przejazdu - rząd 7 (rząd przekładek 1200x800) => T-Car 2
398	11	A398	Zbyt długi czas przejazdu - rząd 8 (rząd palet 1200x800) => T-Car 2
399	11	A399	Zbyt długi czas przejazdu - rząd 9 (rząd palet 1200x1000) => T-Car 2
400	11	A400	Zbyt długi czas przejazdu - rząd 1 (palety z kartonami do kartoniarki) => T-Car 2
401	11	A401	Zbyt długi czas przejazdu - rząd 4 (palety z akcesoriami do owijarki i etykieciarki) => T-Car 2
402	11	A402	Zbyt długi czas przejazdu - rząd 5 (paleta z kartonami do kartoniarki) => T-Car 2
403	11	A403	Zbyt długi czas przejazdu - rząd 6 (rząd buforowy niepełnych palet) => T-Car 2
404	11	A404	Zbyt długi czas przejazdu - rząd 7 (rząd przekładek 1200x800) => T-Car 2
405	11	A405	Zbyt długi czas przejazdu - rząd 8 (rząd palet 1200x800) => T-Car 2
406	11	A406	Zbyt długi czas przejazdu - rząd 9 (rząd palet 1200x1000) => T-Car 2
407	11	A407	Zbyt długi czas przejazdu - T-Car 2 => owijarka palet
122	40	A122	\N
123	40	A123	\N
124	40	A124	\N
125	40	A125	\N
126	40	A126	\N
127	40	A127	\N
128	40	A128	\N
129	40	A129	Niskie ciśnienie pneumatyczne - strefa 1
162	40	A162	Brak bezpieczeństwa kurtyny 2 - rząd buforowy palet 1200x800
163	40	A163	Brak bezpieczeństwa kurtyny 3 - rząd buforowy elementów paletyzacji
164	40	A164	\N
165	40	A165	\N
166	40	A166	\N
167	40	A167	\N
222	40	A222	\N
223	40	A223	\N
224	40	A224	\N
227	40	A227	\N
228	40	A228	\N
229	40	A229	\N
230	40	A230	\N
231	40	A231	\N
232	40	A232	\N
233	40	A233	\N
234	40	A234	\N
235	40	A235	\N
236	40	A236	\N
237	40	A237	\N
238	40	A238	\N
239	40	A239	\N
240	40	A240	\N
241	40	A241	Niskie ciśnienie pneumatyczne - strefa 3
260	40	A260	\N
263	40	A263	\N
264	40	A264	\N
265	40	A265	\N
266	40	A266	\N
267	40	A267	\N
268	40	A268	\N
269	40	A269	\N
270	40	A270	\N
271	40	A271	\N
272	40	A272	\N
273	40	A273	\N
274	40	A274	\N
275	40	A275	\N
276	40	A276	\N
277	40	A277	\N
278	40	A278	\N
279	40	A279	\N
280	40	A280	\N
281	40	A281	\N
282	40	A282	\N
283	40	A283	\N
284	40	A284	\N
285	40	A285	\N
286	40	A286	\N
287	40	A287	\N
288	40	A288	\N
289	40	A289	Brak bezpieczeństwa kurtyny 4 - odbiór kartonów do kartoniarki
290	40	A290	Brak bezpieczeństwa kurtyny 5 - rząd przenośników buforowych i przekładek
291	40	A291	Brak bezpieczeństwa kurtyny 6 - rząd palet 1200x800 i palet 1200x1000
292	40	A292	\N
293	40	A293	\N
294	40	A294	\N
295	40	A295	\N
296	40	A296	\N
297	40	A297	\N
298	40	A298	\N
299	40	A299	\N
300	40	A300	\N
301	40	A301	\N
302	40	A302	\N
303	40	A303	\N
304	40	A304	\N
319	40	A319	\N
320	40	A320	\N
336	40	A336	\N
342	40	A342	\N
343	40	A343	\N
344	40	A344	\N
345	40	A345	\N
346	40	A346	\N
347	40	A347	\N
348	40	A348	\N
349	40	A349	\N
350	40	A350	\N
351	40	A351	\N
352	40	A352	\N
374	40	A374	\N
375	40	A375	\N
376	40	A376	\N
377	40	A377	\N
378	40	A378	\N
379	40	A379	\N
380	40	A380	\N
381	40	A381	\N
382	40	A382	\N
383	40	A383	\N
384	40	A384	\N
408	40	A408	\N
410	40	A410	\N
411	40	A411	\N
412	40	A412	\N
413	40	A413	\N
414	40	A414	\N
415	40	A415	\N
416	40	A416	\N
305	40	A305	Błąd Lini Niverplast Case Erector
306	42	A306	Alarm Lini Niverplst - Crappe Tiper
307	42	A376	Błąd Lini Niverplast - Crappe Tiper
308	39	A308	Alarm Lini Niverplst - Easy Plast
309	39	A309	Błąd Lini Niverplst - Easy Plast
310	41	A310	Alarm Lini Niverplast - Transport System
311	41	A311	Błąd Lini Niverplst - Transport System
312	40	A312	Niski stan kartonów - uzupełnij
313	40	A313	Pusty stan kartonów – uzupełnij !!!
314	40	A314	Niski stan taśmy kartoniarki
315	39	A315	Jedna strona magazynu worków pusta
316	39	A316	Pusty magazyn worków Niverplast
188	40	A188	Nieryglowany zamek bramki bezpieszeństwa
317	40	A317	Alarm lini Niverplast
318	40	A318	Błąd lini Niverplast
106	2	A106	Błąd pudełko zostało odrzucone
225	8	A225	Otwarta Bramka Bezpieczeństwa
226	9	A226	Niezaryglowany zamek bramki bezpieczenstwa 
261	40	A261	Błąd napendu - przenośnik buforowy wyjazd gotowej palety
262	40	A262	Błąd napendu - przenośnik paletyzacji kartonów
\.


--
-- Data for Name: machine_part_stats; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.machine_part_stats (id, name, counter, is_empty, part_id) FROM stdin;
18		0	f	34
19		0	f	35
20		0	f	36
21		0	f	37
8	zapas	1	f	26
7	zapas	1	f	25
6	zapas	1	f	24
11	kartony do kartoniarki	0	t	23
10	kartony do kartoniarki	0	t	22
9	kartony do kartoniarki	0	t	21
3	bufor palet 1200x800	0	t	20
2	bufor palet 1200x800	0	t	19
1	bufor palet 1200x800	0	t	18
13		2	f	39
5	bufor europalet	4	f	17
4	folia do owijarki	1	f	16
12	kartony do kartoniarki	1	f	29
14		0	t	30
15		0	t	31
16		0	t	32
17		1	f	33
\.


--
-- Data for Name: machine_parts; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.machine_parts (id, machine_id, name, x, y, its_working) FROM stdin;
7	1	Part 7	33	25	t
1	1	Part 1	53	51	t
21	1	Part 21	19	80	t
22	1	Part 22	25	74	t
2	1	Part 2	48	45	t
8	1	Part 8	31	35	t
9	1	Part 9	27	37	t
3	1	Part 3	44	43	t
4	1	Part 4	42	42	t
5	1	Part 5	41	35	t
23	1	Part 23	29	67	t
10	1	Part 10	24	40	t
6	1	Part 6	37	34	t
24	1	Part 24	23	83	t
25	1	Part 25	28	78	t
26	1	Part 26	32	72	t
11	1	Part 11	20	44	t
12	1	Part 12	15	44	t
13	1	Part 13	13	60	t
14	1	Part 14	10	55	t
36	1	Part 36	27	45	t
15	1	Part 15	15	68	t
16	1	Part 16	18	62	t
17	1	Part 17	23	56	t
28	1	Part 28	38	74	t
29	1	Part 29	40	68	t
18	1	Part 18	15	74	t
30	1	Part 30	35	63	t
31	1	Part 31	39	57	t
32	1	Part 32	33	54	t
33	1	Part 33	36	48	t
34	1	Part 34	28	50	t
35	1	Part 35	32	45	t
37	1	Part 37	30	40	t
39	1	Part 39	70	40	t
27	1	Part 27	80	80	t
19	1	Part 19	21	67	t
20	1	Part 20	27	61	t
41	1	Part 41	60	60	t
42	1	Part 42	80	40	t
38	1	Part 38	70	40	t
40	1	Part 40	50	45	t
\.


--
-- Data for Name: machines; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.machines (id, company_id, name, config) FROM stdin;
2	2	Machine B	{}
1	1	Machine A	{}
\.


--
-- Name: companies_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.companies_id_seq', 1, false);


--
-- Name: errors_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.errors_id_seq', 1, false);


--
-- Name: machine_data_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.machine_data_id_seq', 1, false);


--
-- Name: machine_part_error_occurrences_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.machine_part_error_occurrences_id_seq', 9369, true);


--
-- Name: machine_part_errors_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.machine_part_errors_id_seq', 1, false);


--
-- Name: machine_part_stats_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.machine_part_stats_id_seq', 1, false);


--
-- Name: machine_parts_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.machine_parts_id_seq', 1, false);


--
-- Name: machines_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.machines_id_seq', 1, false);


--
-- Name: companies companies_login_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.companies
    ADD CONSTRAINT companies_login_key UNIQUE (login);


--
-- Name: companies companies_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.companies
    ADD CONSTRAINT companies_pkey PRIMARY KEY (id);


--
-- Name: errors errors_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.errors
    ADD CONSTRAINT errors_pkey PRIMARY KEY (id);


--
-- Name: machine_data machine_data_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.machine_data
    ADD CONSTRAINT machine_data_pkey PRIMARY KEY (id);


--
-- Name: machine_part_error_occurrences machine_part_error_occurrences_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.machine_part_error_occurrences
    ADD CONSTRAINT machine_part_error_occurrences_pkey PRIMARY KEY (id);


--
-- Name: machine_part_errors machine_part_errors_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.machine_part_errors
    ADD CONSTRAINT machine_part_errors_pkey PRIMARY KEY (id);


--
-- Name: machine_part_stats machine_part_stats_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.machine_part_stats
    ADD CONSTRAINT machine_part_stats_pkey PRIMARY KEY (id);


--
-- Name: machine_parts machine_parts_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.machine_parts
    ADD CONSTRAINT machine_parts_pkey PRIMARY KEY (id);


--
-- Name: machines machines_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.machines
    ADD CONSTRAINT machines_pkey PRIMARY KEY (id);


--
-- Name: errors errors_machine_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.errors
    ADD CONSTRAINT errors_machine_id_fkey FOREIGN KEY (machine_id) REFERENCES public.machines(id);


--
-- Name: machine_data machine_data_machine_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.machine_data
    ADD CONSTRAINT machine_data_machine_id_fkey FOREIGN KEY (machine_id) REFERENCES public.machines(id);


--
-- Name: machine_part_error_occurrences machine_part_error_occurrences_error_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.machine_part_error_occurrences
    ADD CONSTRAINT machine_part_error_occurrences_error_id_fkey FOREIGN KEY (error_id) REFERENCES public.machine_part_errors(id) ON DELETE CASCADE;


--
-- Name: machine_part_error_occurrences machine_part_error_occurrences_part_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.machine_part_error_occurrences
    ADD CONSTRAINT machine_part_error_occurrences_part_id_fkey FOREIGN KEY (part_id) REFERENCES public.machine_parts(id) ON DELETE CASCADE;


--
-- Name: machine_part_errors machine_part_errors_part_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.machine_part_errors
    ADD CONSTRAINT machine_part_errors_part_id_fkey FOREIGN KEY (part_id) REFERENCES public.machine_parts(id) ON DELETE CASCADE;


--
-- Name: machine_part_stats machine_part_stats_part_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.machine_part_stats
    ADD CONSTRAINT machine_part_stats_part_id_fkey FOREIGN KEY (part_id) REFERENCES public.machine_parts(id) ON DELETE CASCADE;


--
-- Name: machine_parts machine_parts_machine_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.machine_parts
    ADD CONSTRAINT machine_parts_machine_id_fkey FOREIGN KEY (machine_id) REFERENCES public.machines(id) ON DELETE CASCADE;


--
-- Name: machines machines_company_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.machines
    ADD CONSTRAINT machines_company_id_fkey FOREIGN KEY (company_id) REFERENCES public.companies(id);


--
-- PostgreSQL database dump complete
--

\unrestrict DCo1dctfVP3kIa8V8oRTITBpdqopvVMqTromKfr7PZIBhgA1X7EIKugstMdlmko

--
-- PostgreSQL database cluster dump complete
--

