
CREATE TABLE public.authors (
    author_id integer NOT NULL,
    author_name character varying(255) NOT NULL,
    author_nationality character varying(100),
    author_dob date
);


ALTER TABLE public.authors OWNER TO postgres;

--
-- TOC entry 228 (class 1259 OID 16564)
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
-- TOC entry 5040 (class 0 OID 0)
-- Dependencies: 228
-- Name: authors_author_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.authors_author_id_seq OWNED BY public.authors.author_id;


--
-- TOC entry 227 (class 1259 OID 16538)
-- Name: book_categories; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.book_categories (
    book_id integer NOT NULL,
    category_id integer NOT NULL
);


ALTER TABLE public.book_categories OWNER TO postgres;

--
-- TOC entry 222 (class 1259 OID 16487)
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
-- TOC entry 221 (class 1259 OID 16486)
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
-- TOC entry 5041 (class 0 OID 0)
-- Dependencies: 221
-- Name: books_book_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.books_book_id_seq OWNED BY public.books.book_id;


--
-- TOC entry 226 (class 1259 OID 16528)
-- Name: categories; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.categories (
    category_id integer NOT NULL,
    name character varying(100) NOT NULL
);


ALTER TABLE public.categories OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 16527)
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
-- TOC entry 5042 (class 0 OID 0)
-- Dependencies: 225
-- Name: categories_category_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.categories_category_id_seq OWNED BY public.categories.category_id;


--
-- TOC entry 224 (class 1259 OID 16503)
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
-- TOC entry 223 (class 1259 OID 16502)
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
-- TOC entry 5043 (class 0 OID 0)
-- Dependencies: 223
-- Name: lending_lending_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.lending_lending_id_seq OWNED BY public.lending.lending_id;


--
-- TOC entry 231 (class 1259 OID 31416)
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
-- TOC entry 230 (class 1259 OID 31415)
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
-- TOC entry 5044 (class 0 OID 0)
-- Dependencies: 230
-- Name: lendings_lending_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.lendings_lending_id_seq OWNED BY public.lendings.lending_id;


--
-- TOC entry 220 (class 1259 OID 16472)
-- Name: members; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.members (
    member_id integer NOT NULL,
    first_name character varying(100) NOT NULL,
    last_name character varying(100) NOT NULL,
    email character varying(255) NOT NULL,
    phone character varying(20),
    membership_start date DEFAULT CURRENT_DATE NOT NULL,
    password character varying(255) CONSTRAINT members_password_hash_not_null NOT NULL
);


ALTER TABLE public.members OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 16471)
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
-- TOC entry 5045 (class 0 OID 0)
-- Dependencies: 219
-- Name: members_member_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.members_member_id_seq OWNED BY public.members.member_id;


--
-- TOC entry 4844 (class 2604 OID 16568)
-- Name: authors author_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authors ALTER COLUMN author_id SET DEFAULT nextval('public.authors_author_id_seq'::regclass);


--
-- TOC entry 4840 (class 2604 OID 16490)
-- Name: books book_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.books ALTER COLUMN book_id SET DEFAULT nextval('public.books_book_id_seq'::regclass);


--
-- TOC entry 4843 (class 2604 OID 16531)
-- Name: categories category_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categories ALTER COLUMN category_id SET DEFAULT nextval('public.categories_category_id_seq'::regclass);


--
-- TOC entry 4841 (class 2604 OID 16506)
-- Name: lending lending_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lending ALTER COLUMN lending_id SET DEFAULT nextval('public.lending_lending_id_seq'::regclass);


--
-- TOC entry 4845 (class 2604 OID 31419)
-- Name: lendings lending_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lendings ALTER COLUMN lending_id SET DEFAULT nextval('public.lendings_lending_id_seq'::regclass);


--
-- TOC entry 4838 (class 2604 OID 16475)
-- Name: members member_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.members ALTER COLUMN member_id SET DEFAULT nextval('public.members_member_id_seq'::regclass);


--
-- TOC entry 5030 (class 0 OID 16565)
-- Dependencies: 229
-- Data for Name: authors; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.authors (author_id, author_name, author_nationality, author_dob) VALUES (1, 'Isabella Greene', 'Canadian', '1983-07-19') ON CONFLICT DO NOTHING;
INSERT INTO public.authors (author_id, author_name, author_nationality, author_dob) VALUES (2, 'Haruki Murakami', 'Japanese', '1949-01-12') ON CONFLICT DO NOTHING;
INSERT INTO public.authors (author_id, author_name, author_nationality, author_dob) VALUES (3, 'Chimamanda Ngozi Adichie', 'Nigerian', '1977-09-15') ON CONFLICT DO NOTHING;
INSERT INTO public.authors (author_id, author_name, author_nationality, author_dob) VALUES (4, 'George R. R. Martin', 'American', '1948-09-20') ON CONFLICT DO NOTHING;
INSERT INTO public.authors (author_id, author_name, author_nationality, author_dob) VALUES (5, 'Elena Ferrante', 'Italian', '1943-10-05') ON CONFLICT DO NOTHING;
INSERT INTO public.authors (author_id, author_name, author_nationality, author_dob) VALUES (6, 'Kazuo Ishiguro', 'British', '1954-11-08') ON CONFLICT DO NOTHING;
INSERT INTO public.authors (author_id, author_name, author_nationality, author_dob) VALUES (7, 'Nguyễn Nhật Ánh', 'Vietnamese', '1955-05-07') ON CONFLICT DO NOTHING;
INSERT INTO public.authors (author_id, author_name, author_nationality, author_dob) VALUES (8, 'N. K. Jemisin', 'American', '1972-09-19') ON CONFLICT DO NOTHING;
INSERT INTO public.authors (author_id, author_name, author_nationality, author_dob) VALUES (9, 'Liu Cixin', 'Chinese', '1963-06-23') ON CONFLICT DO NOTHING;
INSERT INTO public.authors (author_id, author_name, author_nationality, author_dob) VALUES (10, 'Margaret Atwood', 'Canadian', '1939-11-18') ON CONFLICT DO NOTHING;
INSERT INTO public.authors (author_id, author_name, author_nationality, author_dob) VALUES (11, 'Paulo Coelho', 'Brazilian', '1947-08-24') ON CONFLICT DO NOTHING;
INSERT INTO public.authors (author_id, author_name, author_nationality, author_dob) VALUES (12, 'Duc', 'Vietnam', '2004-05-09') ON CONFLICT DO NOTHING;


--
-- TOC entry 5028 (class 0 OID 16538)
-- Dependencies: 227
-- Data for Name: book_categories; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 5023 (class 0 OID 16487)
-- Dependencies: 222
-- Data for Name: books; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.books (book_id, title, published_year, author_id) VALUES (1, 'Networks of Tomorrow', 2021, 1) ON CONFLICT DO NOTHING;
INSERT INTO public.books (book_id, title, published_year, author_id) VALUES (4, 'Whispers of the North', 2009, 1) ON CONFLICT DO NOTHING;
INSERT INTO public.books (book_id, title, published_year, author_id) VALUES (5, 'Autumn over Halifax', 2013, 1) ON CONFLICT DO NOTHING;
INSERT INTO public.books (book_id, title, published_year, author_id) VALUES (6, 'Mapping Quiet Lakes', 2018, 1) ON CONFLICT DO NOTHING;
INSERT INTO public.books (book_id, title, published_year, author_id) VALUES (7, 'Midnight Café Tales', 1982, 2) ON CONFLICT DO NOTHING;
INSERT INTO public.books (book_id, title, published_year, author_id) VALUES (8, 'Echoes of Tokyo', 1994, 2) ON CONFLICT DO NOTHING;
INSERT INTO public.books (book_id, title, published_year, author_id) VALUES (9, 'Kafka on the Shoreline', 2002, 2) ON CONFLICT DO NOTHING;
INSERT INTO public.books (book_id, title, published_year, author_id) VALUES (10, 'Purple Hibiscus Skies', 2003, 3) ON CONFLICT DO NOTHING;
INSERT INTO public.books (book_id, title, published_year, author_id) VALUES (11, 'Half of a Bright Sun', 2006, 3) ON CONFLICT DO NOTHING;
INSERT INTO public.books (book_id, title, published_year, author_id) VALUES (12, 'Americanah Roads', 2013, 3) ON CONFLICT DO NOTHING;
INSERT INTO public.books (book_id, title, published_year, author_id) VALUES (13, 'A Storm of Quills', 1996, 4) ON CONFLICT DO NOTHING;
INSERT INTO public.books (book_id, title, published_year, author_id) VALUES (14, 'Feast for Scribes', 2000, 4) ON CONFLICT DO NOTHING;
INSERT INTO public.books (book_id, title, published_year, author_id) VALUES (15, 'Dreams of Winterglass', 2011, 4) ON CONFLICT DO NOTHING;
INSERT INTO public.books (book_id, title, published_year, author_id) VALUES (16, 'My Brilliant Alley', 2011, 5) ON CONFLICT DO NOTHING;
INSERT INTO public.books (book_id, title, published_year, author_id) VALUES (17, 'Daughters of Naples', 2015, 5) ON CONFLICT DO NOTHING;
INSERT INTO public.books (book_id, title, published_year, author_id) VALUES (18, 'Frantumaglia Streets', 2018, 5) ON CONFLICT DO NOTHING;
INSERT INTO public.books (book_id, title, published_year, author_id) VALUES (19, 'Never Let Me Drift', 2005, 6) ON CONFLICT DO NOTHING;
INSERT INTO public.books (book_id, title, published_year, author_id) VALUES (20, 'The Buried Giantess', 2015, 6) ON CONFLICT DO NOTHING;
INSERT INTO public.books (book_id, title, published_year, author_id) VALUES (21, 'Artist of a Floating World', 1986, 6) ON CONFLICT DO NOTHING;
INSERT INTO public.books (book_id, title, published_year, author_id) VALUES (22, 'Cho Em Gần Hơn', 1998, 7) ON CONFLICT DO NOTHING;
INSERT INTO public.books (book_id, title, published_year, author_id) VALUES (23, 'Mắt Biếc', 1990, 7) ON CONFLICT DO NOTHING;
INSERT INTO public.books (book_id, title, published_year, author_id) VALUES (24, 'Trường Xưa Ký Ức', 2002, 7) ON CONFLICT DO NOTHING;
INSERT INTO public.books (book_id, title, published_year, author_id) VALUES (25, 'The Fifth Seasoned Path', 2015, 8) ON CONFLICT DO NOTHING;
INSERT INTO public.books (book_id, title, published_year, author_id) VALUES (26, 'Obelisk Gateways', 2016, 8) ON CONFLICT DO NOTHING;
INSERT INTO public.books (book_id, title, published_year, author_id) VALUES (27, 'Stone Sky Horizons', 2017, 8) ON CONFLICT DO NOTHING;
INSERT INTO public.books (book_id, title, published_year, author_id) VALUES (28, 'Three-Body Harbor', 2008, 9) ON CONFLICT DO NOTHING;
INSERT INTO public.books (book_id, title, published_year, author_id) VALUES (29, 'Dark Forest Signals', 2008, 9) ON CONFLICT DO NOTHING;
INSERT INTO public.books (book_id, title, published_year, author_id) VALUES (30, 'Redemption of Timepiece', 2010, 9) ON CONFLICT DO NOTHING;
INSERT INTO public.books (book_id, title, published_year, author_id) VALUES (31, 'Handmaid’s Window', 1985, 10) ON CONFLICT DO NOTHING;
INSERT INTO public.books (book_id, title, published_year, author_id) VALUES (32, 'Alias Gracefield', 1996, 10) ON CONFLICT DO NOTHING;
INSERT INTO public.books (book_id, title, published_year, author_id) VALUES (33, 'Oryx and Crakebird', 2003, 10) ON CONFLICT DO NOTHING;
INSERT INTO public.books (book_id, title, published_year, author_id) VALUES (34, 'The Alchemist’s Path', 1988, 11) ON CONFLICT DO NOTHING;
INSERT INTO public.books (book_id, title, published_year, author_id) VALUES (35, 'Brida’s Circle', 1990, 11) ON CONFLICT DO NOTHING;
INSERT INTO public.books (book_id, title, published_year, author_id) VALUES (36, 'Veronika Awakens', 1998, 11) ON CONFLICT DO NOTHING;
INSERT INTO public.books (book_id, title, published_year, author_id) VALUES (37, 'Snowfall on Bay Street', 2020, 1) ON CONFLICT DO NOTHING;
INSERT INTO public.books (book_id, title, published_year, author_id) VALUES (38, 'Wind-Up Notes', 1997, 2) ON CONFLICT DO NOTHING;
INSERT INTO public.books (book_id, title, published_year, author_id) VALUES (39, 'Notes on Lagos', 2021, 3) ON CONFLICT DO NOTHING;
INSERT INTO public.books (book_id, title, published_year, author_id) VALUES (40, 'Kings of Summerhall', 2014, 4) ON CONFLICT DO NOTHING;
INSERT INTO public.books (book_id, title, published_year, author_id) VALUES (41, 'The Lost Neapolitan', 2019, 5) ON CONFLICT DO NOTHING;
INSERT INTO public.books (book_id, title, published_year, author_id) VALUES (42, 'Pale View of Hillside', 1982, 6) ON CONFLICT DO NOTHING;
INSERT INTO public.books (book_id, title, published_year, author_id) VALUES (43, 'Thần Đồng Phố Cổ', 2007, 7) ON CONFLICT DO NOTHING;
INSERT INTO public.books (book_id, title, published_year, author_id) VALUES (44, 'City We Became Again', 2020, 8) ON CONFLICT DO NOTHING;
INSERT INTO public.books (book_id, title, published_year, author_id) VALUES (45, 'Ball Lightning Trails', 2005, 9) ON CONFLICT DO NOTHING;
INSERT INTO public.books (book_id, title, published_year, author_id) VALUES (46, 'Blind Assassin’s Thread', 2000, 10) ON CONFLICT DO NOTHING;
INSERT INTO public.books (book_id, title, published_year, author_id) VALUES (47, 'Eleven Minutes More', 2003, 11) ON CONFLICT DO NOTHING;
INSERT INTO public.books (book_id, title, published_year, author_id) VALUES (48, 'Coastal Cartographies', 2016, 1) ON CONFLICT DO NOTHING;
INSERT INTO public.books (book_id, title, published_year, author_id) VALUES (49, 'Colorless Tsukuru Notes', 2013, 2) ON CONFLICT DO NOTHING;
INSERT INTO public.books (book_id, title, published_year, author_id) VALUES (50, 'Zikora Stories', 2020, 3) ON CONFLICT DO NOTHING;
INSERT INTO public.books (book_id, title, published_year, author_id) VALUES (51, 'Tales of Old Valyria', 2018, 4) ON CONFLICT DO NOTHING;
INSERT INTO public.books (book_id, title, published_year, author_id) VALUES (52, 'Naples in Winter Light', 2022, 5) ON CONFLICT DO NOTHING;


--
-- TOC entry 5027 (class 0 OID 16528)
-- Dependencies: 226
-- Data for Name: categories; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 5025 (class 0 OID 16503)
-- Dependencies: 224
-- Data for Name: lending; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 5032 (class 0 OID 31416)
-- Dependencies: 231
-- Data for Name: lendings; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 5021 (class 0 OID 16472)
-- Dependencies: 220
-- Data for Name: members; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.members (member_id, first_name, last_name, email, phone, membership_start, password) VALUES (3, 'Ada', 'Lovelace', 'ada.lovelace@example.com', '+84-912-345-678', '2025-10-16', 'scrypt:32768:8:1$jj7vJmOc4pciGCNQ$498463d8e1b36a4cd6f735093b3e7322050c467e71d67f45618412efde83e007e1e1e7d426a0f6a36c407ada051f762ecf854c07b599187593cf01a3a3876b8e') ON CONFLICT DO NOTHING;
INSERT INTO public.members (member_id, first_name, last_name, email, phone, membership_start, password) VALUES (4, 'John', 'Doe', 'johndoe@example.com', '123-456-7890', '2025-10-23', 'scrypt:32768:8:1$P98Aha2GRVjpE2DG$f292346d294446b5c4c1178372459e6bb1f41436a49e74055027122acfc9829065871d26a7f46b161e5d61dee2c5f1a4187bff66cd7130e36ff939f0b3ce4b4a') ON CONFLICT DO NOTHING;


--
-- TOC entry 5046 (class 0 OID 0)
-- Dependencies: 228
-- Name: authors_author_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.authors_author_id_seq', 12, true);


--
-- TOC entry 5047 (class 0 OID 0)
-- Dependencies: 221
-- Name: books_book_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.books_book_id_seq', 52, true);


--
-- TOC entry 5048 (class 0 OID 0)
-- Dependencies: 225
-- Name: categories_category_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.categories_category_id_seq', 1, false);


--
-- TOC entry 5049 (class 0 OID 0)
-- Dependencies: 223
-- Name: lending_lending_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.lending_lending_id_seq', 1, false);


--
-- TOC entry 5050 (class 0 OID 0)
-- Dependencies: 230
-- Name: lendings_lending_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.lendings_lending_id_seq', 1, true);


--
-- TOC entry 5051 (class 0 OID 0)
-- Dependencies: 219
-- Name: members_member_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.members_member_id_seq', 4, true);


--
-- TOC entry 4863 (class 2606 OID 16572)
-- Name: authors authors_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authors
    ADD CONSTRAINT authors_pkey PRIMARY KEY (author_id);


--
-- TOC entry 4861 (class 2606 OID 16544)
-- Name: book_categories book_categories_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.book_categories
    ADD CONSTRAINT book_categories_pkey PRIMARY KEY (book_id, category_id);


--
-- TOC entry 4853 (class 2606 OID 16501)
-- Name: books books_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.books
    ADD CONSTRAINT books_pkey PRIMARY KEY (book_id);


--
-- TOC entry 4857 (class 2606 OID 16537)
-- Name: categories categories_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_name_key UNIQUE (name);


--
-- TOC entry 4859 (class 2606 OID 16535)
-- Name: categories categories_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_pkey PRIMARY KEY (category_id);


--
-- TOC entry 4855 (class 2606 OID 16516)
-- Name: lending lending_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lending
    ADD CONSTRAINT lending_pkey PRIMARY KEY (lending_id);


--
-- TOC entry 4865 (class 2606 OID 31426)
-- Name: lendings lendings_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lendings
    ADD CONSTRAINT lendings_pkey PRIMARY KEY (lending_id);


--
-- TOC entry 4849 (class 2606 OID 16485)
-- Name: members members_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.members
    ADD CONSTRAINT members_email_key UNIQUE (email);


--
-- TOC entry 4851 (class 2606 OID 16483)
-- Name: members members_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.members
    ADD CONSTRAINT members_pkey PRIMARY KEY (member_id);


--
-- TOC entry 4869 (class 2606 OID 16545)
-- Name: book_categories book_categories_book_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.book_categories
    ADD CONSTRAINT book_categories_book_id_fkey FOREIGN KEY (book_id) REFERENCES public.books(book_id) ON DELETE CASCADE;


--
-- TOC entry 4870 (class 2606 OID 16550)
-- Name: book_categories book_categories_category_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.book_categories
    ADD CONSTRAINT book_categories_category_id_fkey FOREIGN KEY (category_id) REFERENCES public.categories(category_id) ON DELETE CASCADE;


--
-- TOC entry 4866 (class 2606 OID 16573)
-- Name: books books_author_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.books
    ADD CONSTRAINT books_author_id_fkey FOREIGN KEY (author_id) REFERENCES public.authors(author_id);


--
-- TOC entry 4867 (class 2606 OID 16517)
-- Name: lending lending_book_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lending
    ADD CONSTRAINT lending_book_id_fkey FOREIGN KEY (book_id) REFERENCES public.books(book_id) ON DELETE CASCADE;


--
-- TOC entry 4868 (class 2606 OID 16522)
-- Name: lending lending_member_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lending
    ADD CONSTRAINT lending_member_id_fkey FOREIGN KEY (member_id) REFERENCES public.members(member_id) ON DELETE CASCADE;


--
-- TOC entry 4871 (class 2606 OID 31427)
-- Name: lendings lendings_book_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lendings
    ADD CONSTRAINT lendings_book_id_fkey FOREIGN KEY (book_id) REFERENCES public.books(book_id);


--
-- TOC entry 4872 (class 2606 OID 31432)
-- Name: lendings lendings_member_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lendings
    ADD CONSTRAINT lendings_member_id_fkey FOREIGN KEY (member_id) REFERENCES public.members(member_id);


-- Completed on 2025-10-28 17:52:48

--
-- PostgreSQL database dump complete
--

