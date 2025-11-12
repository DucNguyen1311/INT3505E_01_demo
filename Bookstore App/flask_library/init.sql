--
-- PostgreSQL database dump
--

\restrict AzwvDqdouRexJ0md1l76kC4EG8vCQecvvZgx9XxWMl0n9ys6YvvB64MyuXXghmU

-- Dumped from database version 16.10 (Debian 16.10-1.pgdg13+1)
-- Dumped by pg_dump version 16.10 (Debian 16.10-1.pgdg13+1)

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
-- Name: authors; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.authors (
    author_id integer NOT NULL,
    author_name character varying(255) NOT NULL,
    author_nationality character varying(100),
    author_dob date
);


ALTER TABLE public.authors OWNER TO postgres;

--
-- Name: authors_author_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.authors_author_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.authors_author_id_seq OWNER TO postgres;

--
-- Name: authors_author_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.authors_author_id_seq OWNED BY public.authors.author_id;


--
-- Name: book_categories; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.book_categories (
    book_id integer NOT NULL,
    category_id integer NOT NULL
);


ALTER TABLE public.book_categories OWNER TO postgres;

--
-- Name: books; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.books (
    book_id integer NOT NULL,
    title character varying(255) NOT NULL,
    published_year integer,
    author_id integer
);


ALTER TABLE public.books OWNER TO postgres;

--
-- Name: books_book_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.books_book_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.books_book_id_seq OWNER TO postgres;

--
-- Name: books_book_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.books_book_id_seq OWNED BY public.books.book_id;


--
-- Name: categories; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.categories (
    category_id integer NOT NULL,
    name character varying(100) NOT NULL
);


ALTER TABLE public.categories OWNER TO postgres;

--
-- Name: categories_category_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.categories_category_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.categories_category_id_seq OWNER TO postgres;

--
-- Name: categories_category_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.categories_category_id_seq OWNED BY public.categories.category_id;


--
-- Name: lending; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.lending (
    lending_id integer NOT NULL,
    book_id integer NOT NULL,
    member_id integer NOT NULL,
    lend_date date DEFAULT CURRENT_DATE NOT NULL,
    due_date date NOT NULL,
    return_date date,
    CONSTRAINT check_due_date CHECK ((due_date > lend_date)),
    CONSTRAINT check_return_date CHECK (((return_date IS NULL) OR (return_date >= lend_date)))
);


ALTER TABLE public.lending OWNER TO postgres;

--
-- Name: lending_lending_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.lending_lending_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.lending_lending_id_seq OWNER TO postgres;

--
-- Name: lending_lending_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.lending_lending_id_seq OWNED BY public.lending.lending_id;


--
-- Name: lendings; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.lendings (
    lending_id integer NOT NULL,
    book_id integer NOT NULL,
    member_id integer NOT NULL,
    lend_date date NOT NULL,
    due_date date NOT NULL,
    return_date date
);


ALTER TABLE public.lendings OWNER TO postgres;

--
-- Name: lendings_lending_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.lendings_lending_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.lendings_lending_id_seq OWNER TO postgres;

--
-- Name: lendings_lending_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.lendings_lending_id_seq OWNED BY public.lendings.lending_id;


--
-- Name: members; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.members (
    member_id integer NOT NULL,
    first_name character varying(100) NOT NULL,
    last_name character varying(100) NOT NULL,
    email character varying(255) NOT NULL,
    phone character varying(20),
    membership_start date DEFAULT CURRENT_DATE NOT NULL,
    password character varying(255) NOT NULL,
    member_type character varying(50) DEFAULT 'basic'::character varying NOT NULL
);


ALTER TABLE public.members OWNER TO postgres;

--
-- Name: members_member_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.members_member_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.members_member_id_seq OWNER TO postgres;

--
-- Name: members_member_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.members_member_id_seq OWNED BY public.members.member_id;


--
-- Name: authors author_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authors ALTER COLUMN author_id SET DEFAULT nextval('public.authors_author_id_seq'::regclass);


--
-- Name: books book_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.books ALTER COLUMN book_id SET DEFAULT nextval('public.books_book_id_seq'::regclass);


--
-- Name: categories category_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categories ALTER COLUMN category_id SET DEFAULT nextval('public.categories_category_id_seq'::regclass);


--
-- Name: lending lending_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lending ALTER COLUMN lending_id SET DEFAULT nextval('public.lending_lending_id_seq'::regclass);


--
-- Name: lendings lending_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lendings ALTER COLUMN lending_id SET DEFAULT nextval('public.lendings_lending_id_seq'::regclass);


--
-- Name: members member_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.members ALTER COLUMN member_id SET DEFAULT nextval('public.members_member_id_seq'::regclass);


--
-- Data for Name: authors; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.authors (author_id, author_name, author_nationality, author_dob) FROM stdin;
1	Isabella Greene	Canadian	1983-07-19
2	Haruki Murakami	Japanese	1949-01-12
3	Chimamanda Ngozi Adichie	Nigerian	1977-09-15
4	George R. R. Martin	American	1948-09-20
5	Elena Ferrante	Italian	1943-10-05
6	Kazuo Ishiguro	British	1954-11-08
7	Nguyễn Nhật Ánh	Vietnamese	1955-05-07
8	N. K. Jemisin	American	1972-09-19
9	Liu Cixin	Chinese	1963-06-23
10	Margaret Atwood	Canadian	1939-11-18
11	Paulo Coelho	Brazilian	1947-08-24
12	Duc	Vietnam	2004-05-09
\.


--
-- Data for Name: book_categories; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.book_categories (book_id, category_id) FROM stdin;
\.


--
-- Data for Name: books; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.books (book_id, title, published_year, author_id) FROM stdin;
1	Networks of Tomorrow	2021	1
4	Whispers of the North	2009	1
5	Autumn over Halifax	2013	1
6	Mapping Quiet Lakes	2018	1
7	Midnight Café Tales	1982	2
8	Echoes of Tokyo	1994	2
9	Kafka on the Shoreline	2002	2
10	Purple Hibiscus Skies	2003	3
11	Half of a Bright Sun	2006	3
12	Americanah Roads	2013	3
13	A Storm of Quills	1996	4
14	Feast for Scribes	2000	4
15	Dreams of Winterglass	2011	4
16	My Brilliant Alley	2011	5
17	Daughters of Naples	2015	5
18	Frantumaglia Streets	2018	5
19	Never Let Me Drift	2005	6
20	The Buried Giantess	2015	6
21	Artist of a Floating World	1986	6
22	Cho Em Gần Hơn	1998	7
23	Mắt Biếc	1990	7
24	Trường Xưa Ký Ức	2002	7
25	The Fifth Seasoned Path	2015	8
26	Obelisk Gateways	2016	8
27	Stone Sky Horizons	2017	8
28	Three-Body Harbor	2008	9
29	Dark Forest Signals	2008	9
30	Redemption of Timepiece	2010	9
31	Handmaid’s Window	1985	10
32	Alias Gracefield	1996	10
33	Oryx and Crakebird	2003	10
34	The Alchemist’s Path	1988	11
35	Brida’s Circle	1990	11
36	Veronika Awakens	1998	11
37	Snowfall on Bay Street	2020	1
38	Wind-Up Notes	1997	2
39	Notes on Lagos	2021	3
40	Kings of Summerhall	2014	4
41	The Lost Neapolitan	2019	5
42	Pale View of Hillside	1982	6
43	Thần Đồng Phố Cổ	2007	7
44	City We Became Again	2020	8
45	Ball Lightning Trails	2005	9
46	Blind Assassin’s Thread	2000	10
47	Eleven Minutes More	2003	11
48	Coastal Cartographies	2016	1
49	Colorless Tsukuru Notes	2013	2
50	Zikora Stories	2020	3
51	Tales of Old Valyria	2018	4
52	Naples in Winter Light	2022	5
\.


--
-- Data for Name: categories; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.categories (category_id, name) FROM stdin;
\.


--
-- Data for Name: lending; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.lending (lending_id, book_id, member_id, lend_date, due_date, return_date) FROM stdin;
\.


--
-- Data for Name: lendings; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.lendings (lending_id, book_id, member_id, lend_date, due_date, return_date) FROM stdin;
\.


--
-- Data for Name: members; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.members (member_id, first_name, last_name, email, phone, membership_start, password, member_type) FROM stdin;
4	John	Doe	johndoe@example.com	123-456-7890	2025-10-23	scrypt:32768:8:1$P98Aha2GRVjpE2DG$f292346d294446b5c4c1178372459e6bb1f41436a49e74055027122acfc9829065871d26a7f46b161e5d61dee2c5f1a4187bff66cd7130e36ff939f0b3ce4b4a	ctv
3	Ada	Lovelace	ada.lovelace@example.com	+84-912-345-678	2025-10-16	scrypt:32768:8:1$P98Aha2GRVjpE2DG$f292346d294446b5c4c1178372459e6bb1f41436a49e74055027122acfc9829065871d26a7f46b161e5d61dee2c5f1a4187bff66cd7130e36ff939f0b3ce4b4a	basic
\.


--
-- Name: authors_author_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.authors_author_id_seq', 12, true);


--
-- Name: books_book_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.books_book_id_seq', 52, true);


--
-- Name: categories_category_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.categories_category_id_seq', 1, false);


--
-- Name: lending_lending_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.lending_lending_id_seq', 1, false);


--
-- Name: lendings_lending_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.lendings_lending_id_seq', 1, true);


--
-- Name: members_member_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.members_member_id_seq', 4, true);


--
-- Name: authors authors_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authors
    ADD CONSTRAINT authors_pkey PRIMARY KEY (author_id);


--
-- Name: book_categories book_categories_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.book_categories
    ADD CONSTRAINT book_categories_pkey PRIMARY KEY (book_id, category_id);


--
-- Name: books books_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.books
    ADD CONSTRAINT books_pkey PRIMARY KEY (book_id);


--
-- Name: categories categories_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_name_key UNIQUE (name);


--
-- Name: categories categories_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_pkey PRIMARY KEY (category_id);


--
-- Name: lending lending_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lending
    ADD CONSTRAINT lending_pkey PRIMARY KEY (lending_id);


--
-- Name: lendings lendings_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lendings
    ADD CONSTRAINT lendings_pkey PRIMARY KEY (lending_id);


--
-- Name: members members_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.members
    ADD CONSTRAINT members_email_key UNIQUE (email);


--
-- Name: members members_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.members
    ADD CONSTRAINT members_pkey PRIMARY KEY (member_id);


--
-- Name: book_categories book_categories_book_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.book_categories
    ADD CONSTRAINT book_categories_book_id_fkey FOREIGN KEY (book_id) REFERENCES public.books(book_id) ON DELETE CASCADE;


--
-- Name: book_categories book_categories_category_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.book_categories
    ADD CONSTRAINT book_categories_category_id_fkey FOREIGN KEY (category_id) REFERENCES public.categories(category_id) ON DELETE CASCADE;


--
-- Name: books books_author_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.books
    ADD CONSTRAINT books_author_id_fkey FOREIGN KEY (author_id) REFERENCES public.authors(author_id);


--
-- Name: lending lending_book_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lending
    ADD CONSTRAINT lending_book_id_fkey FOREIGN KEY (book_id) REFERENCES public.books(book_id) ON DELETE CASCADE;


--
-- Name: lending lending_member_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lending
    ADD CONSTRAINT lending_member_id_fkey FOREIGN KEY (member_id) REFERENCES public.members(member_id) ON DELETE CASCADE;


--
-- Name: lendings lendings_book_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lendings
    ADD CONSTRAINT lendings_book_id_fkey FOREIGN KEY (book_id) REFERENCES public.books(book_id);


--
-- Name: lendings lendings_member_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lendings
    ADD CONSTRAINT lendings_member_id_fkey FOREIGN KEY (member_id) REFERENCES public.members(member_id);


--
-- PostgreSQL database dump complete
--

\unrestrict AzwvDqdouRexJ0md1l76kC4EG8vCQecvvZgx9XxWMl0n9ys6YvvB64MyuXXghmU

