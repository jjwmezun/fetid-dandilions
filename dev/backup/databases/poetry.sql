--
-- PostgreSQL database dump
--

-- Dumped from database version 12.7 (Ubuntu 12.7-0ubuntu0.20.04.1)
-- Dumped by pg_dump version 12.7 (Ubuntu 12.7-0ubuntu0.20.04.1)

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
-- Name: category; Type: TABLE; Schema: public; Owner: poetryadmin
--

CREATE TABLE public.category (
    category_id integer NOT NULL,
    category_parent_id integer,
    category_title text,
    category_slug text,
    category_desc text,
    category_created timestamp without time zone,
    category_updated timestamp without time zone
);


ALTER TABLE public.category OWNER TO poetryadmin;

--
-- Name: category_category_id_seq; Type: SEQUENCE; Schema: public; Owner: poetryadmin
--

ALTER TABLE public.category ALTER COLUMN category_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.category_category_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: page; Type: TABLE; Schema: public; Owner: poetryadmin
--

CREATE TABLE public.page (
    page_id integer NOT NULL,
    page_title text,
    page_slug text,
    page_content text,
    page_created timestamp without time zone,
    page_updated timestamp without time zone
);


ALTER TABLE public.page OWNER TO poetryadmin;

--
-- Name: page_page_id_seq; Type: SEQUENCE; Schema: public; Owner: poetryadmin
--

ALTER TABLE public.page ALTER COLUMN page_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.page_page_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: poem; Type: TABLE; Schema: public; Owner: poetryadmin
--

CREATE TABLE public.poem (
    poem_id integer NOT NULL,
    poem_title text,
    poem_slug text,
    poem_content text,
    poem_created timestamp without time zone,
    poem_updated timestamp without time zone
);


ALTER TABLE public.poem OWNER TO poetryadmin;

--
-- Name: poem_category; Type: TABLE; Schema: public; Owner: poetryadmin
--

CREATE TABLE public.poem_category (
    poem_category_id integer NOT NULL,
    poem_category_poem_id integer,
    poem_category_category integer
);


ALTER TABLE public.poem_category OWNER TO poetryadmin;

--
-- Name: poem_category_poem_category_id_seq; Type: SEQUENCE; Schema: public; Owner: poetryadmin
--

ALTER TABLE public.poem_category ALTER COLUMN poem_category_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.poem_category_poem_category_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: poem_poem_id_seq; Type: SEQUENCE; Schema: public; Owner: poetryadmin
--

ALTER TABLE public.poem ALTER COLUMN poem_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.poem_poem_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Data for Name: category; Type: TABLE DATA; Schema: public; Owner: poetryadmin
--

COPY public.category (category_id, category_parent_id, category_title, category_slug, category_desc, category_created, category_updated) FROM stdin;
\.


--
-- Data for Name: page; Type: TABLE DATA; Schema: public; Owner: poetryadmin
--

COPY public.page (page_id, page_title, page_slug, page_content, page_created, page_updated) FROM stdin;
\.


--
-- Data for Name: poem; Type: TABLE DATA; Schema: public; Owner: poetryadmin
--

COPY public.poem (poem_id, poem_title, poem_slug, poem_content, poem_created, poem_updated) FROM stdin;
26	thru blinds [ DIESER ORT IN MEINEM KOPF DIESER ORT AN DEM ICH MICH GERNE VERSTECKE ]	\N	<content>\n        <stanza>\n            <ln>¡Clack! ¡Clack! ¡Clack! ~</ln>\n            <ln>thru blinds, eyeing crows,</ln>\n            <ln>the cat’s tail.</ln>\n        </stanza>\n    </content>	\N	\N
\.


--
-- Data for Name: poem_category; Type: TABLE DATA; Schema: public; Owner: poetryadmin
--

COPY public.poem_category (poem_category_id, poem_category_poem_id, poem_category_category) FROM stdin;
\.


--
-- Name: category_category_id_seq; Type: SEQUENCE SET; Schema: public; Owner: poetryadmin
--

SELECT pg_catalog.setval('public.category_category_id_seq', 1, false);


--
-- Name: page_page_id_seq; Type: SEQUENCE SET; Schema: public; Owner: poetryadmin
--

SELECT pg_catalog.setval('public.page_page_id_seq', 1, false);


--
-- Name: poem_category_poem_category_id_seq; Type: SEQUENCE SET; Schema: public; Owner: poetryadmin
--

SELECT pg_catalog.setval('public.poem_category_poem_category_id_seq', 1, false);


--
-- Name: poem_poem_id_seq; Type: SEQUENCE SET; Schema: public; Owner: poetryadmin
--

SELECT pg_catalog.setval('public.poem_poem_id_seq', 26, true);


--
-- Name: category category_pkey; Type: CONSTRAINT; Schema: public; Owner: poetryadmin
--

ALTER TABLE ONLY public.category
    ADD CONSTRAINT category_pkey PRIMARY KEY (category_id);


--
-- Name: page page_pkey; Type: CONSTRAINT; Schema: public; Owner: poetryadmin
--

ALTER TABLE ONLY public.page
    ADD CONSTRAINT page_pkey PRIMARY KEY (page_id);


--
-- Name: poem_category poem_category_pkey; Type: CONSTRAINT; Schema: public; Owner: poetryadmin
--

ALTER TABLE ONLY public.poem_category
    ADD CONSTRAINT poem_category_pkey PRIMARY KEY (poem_category_id);


--
-- Name: poem poem_pkey; Type: CONSTRAINT; Schema: public; Owner: poetryadmin
--

ALTER TABLE ONLY public.poem
    ADD CONSTRAINT poem_pkey PRIMARY KEY (poem_id);


--
-- Name: category fk_category; Type: FK CONSTRAINT; Schema: public; Owner: poetryadmin
--

ALTER TABLE ONLY public.category
    ADD CONSTRAINT fk_category FOREIGN KEY (category_parent_id) REFERENCES public.category(category_id);


--
-- Name: poem_category fk_poem_category_category; Type: FK CONSTRAINT; Schema: public; Owner: poetryadmin
--

ALTER TABLE ONLY public.poem_category
    ADD CONSTRAINT fk_poem_category_category FOREIGN KEY (poem_category_category) REFERENCES public.category(category_id);


--
-- Name: poem_category fk_poem_category_poem; Type: FK CONSTRAINT; Schema: public; Owner: poetryadmin
--

ALTER TABLE ONLY public.poem_category
    ADD CONSTRAINT fk_poem_category_poem FOREIGN KEY (poem_category_poem_id) REFERENCES public.poem(poem_id);


--
-- Name: TABLE category; Type: ACL; Schema: public; Owner: poetryadmin
--

GRANT SELECT ON TABLE public.category TO poetry;


--
-- Name: TABLE page; Type: ACL; Schema: public; Owner: poetryadmin
--

GRANT SELECT ON TABLE public.page TO poetry;


--
-- Name: TABLE poem; Type: ACL; Schema: public; Owner: poetryadmin
--

GRANT SELECT ON TABLE public.poem TO poetry;


--
-- Name: TABLE poem_category; Type: ACL; Schema: public; Owner: poetryadmin
--

GRANT SELECT ON TABLE public.poem_category TO poetry;


--
-- PostgreSQL database dump complete
--

