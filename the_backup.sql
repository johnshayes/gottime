--
-- PostgreSQL database dump
--

-- Dumped from database version 9.6.3
-- Dumped by pg_dump version 9.6.3

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner:
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner:
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: ar_internal_metadata; Type: TABLE; Schema: public; Owner: moritz
--

CREATE TABLE ar_internal_metadata (
    key character varying NOT NULL,
    value character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE ar_internal_metadata OWNER TO moritz;

--
-- Name: blacklists; Type: TABLE; Schema: public; Owner: moritz
--

CREATE TABLE blacklists (
    id bigint NOT NULL,
    user_id bigint,
    friend_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE blacklists OWNER TO moritz;

--
-- Name: blacklists_id_seq; Type: SEQUENCE; Schema: public; Owner: moritz
--

CREATE SEQUENCE blacklists_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE blacklists_id_seq OWNER TO moritz;

--
-- Name: blacklists_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: moritz
--

ALTER SEQUENCE blacklists_id_seq OWNED BY blacklists.id;


--
-- Name: chat_rooms; Type: TABLE; Schema: public; Owner: moritz
--

CREATE TABLE chat_rooms (
    id bigint NOT NULL,
    name character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    meeting_id bigint
);


ALTER TABLE chat_rooms OWNER TO moritz;

--
-- Name: chat_rooms_id_seq; Type: SEQUENCE; Schema: public; Owner: moritz
--

CREATE SEQUENCE chat_rooms_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE chat_rooms_id_seq OWNER TO moritz;

--
-- Name: chat_rooms_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: moritz
--

ALTER SEQUENCE chat_rooms_id_seq OWNED BY chat_rooms.id;


--
-- Name: listings; Type: TABLE; Schema: public; Owner: moritz
--

CREATE TABLE listings (
    id bigint NOT NULL,
    offered_datetime timestamp without time zone,
    activity character varying,
    location character varying,
    comment character varying,
    friends_circle character varying,
    user_id bigint,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    offered_datetime_text character varying,
    status character varying DEFAULT 'open'::character varying
);


ALTER TABLE listings OWNER TO moritz;

--
-- Name: listings_id_seq; Type: SEQUENCE; Schema: public; Owner: moritz
--

CREATE SEQUENCE listings_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE listings_id_seq OWNER TO moritz;

--
-- Name: listings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: moritz
--

ALTER SEQUENCE listings_id_seq OWNED BY listings.id;


--
-- Name: meetings; Type: TABLE; Schema: public; Owner: moritz
--

CREATE TABLE meetings (
    id bigint NOT NULL,
    listing_id bigint,
    status character varying DEFAULT 'active'::character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE meetings OWNER TO moritz;

--
-- Name: meetings_id_seq; Type: SEQUENCE; Schema: public; Owner: moritz
--

CREATE SEQUENCE meetings_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE meetings_id_seq OWNER TO moritz;

--
-- Name: meetings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: moritz
--

ALTER SEQUENCE meetings_id_seq OWNED BY meetings.id;


--
-- Name: messages; Type: TABLE; Schema: public; Owner: moritz
--

CREATE TABLE messages (
    id bigint NOT NULL,
    user_id bigint,
    text character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    chat_room_id bigint
);


ALTER TABLE messages OWNER TO moritz;

--
-- Name: messages_id_seq; Type: SEQUENCE; Schema: public; Owner: moritz
--

CREATE SEQUENCE messages_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE messages_id_seq OWNER TO moritz;

--
-- Name: messages_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: moritz
--

ALTER SEQUENCE messages_id_seq OWNED BY messages.id;


--
-- Name: participants; Type: TABLE; Schema: public; Owner: moritz
--

CREATE TABLE participants (
    id bigint NOT NULL,
    user_id bigint,
    meeting_id bigint,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE participants OWNER TO moritz;

--
-- Name: participants_id_seq; Type: SEQUENCE; Schema: public; Owner: moritz
--

CREATE SEQUENCE participants_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE participants_id_seq OWNER TO moritz;

--
-- Name: participants_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: moritz
--

ALTER SEQUENCE participants_id_seq OWNED BY participants.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: moritz
--

CREATE TABLE schema_migrations (
    version character varying NOT NULL
);


ALTER TABLE schema_migrations OWNER TO moritz;

--
-- Name: users; Type: TABLE; Schema: public; Owner: moritz
--

CREATE TABLE users (
    id bigint NOT NULL,
    email character varying DEFAULT ''::character varying NOT NULL,
    encrypted_password character varying DEFAULT ''::character varying NOT NULL,
    reset_password_token character varying,
    reset_password_sent_at timestamp without time zone,
    remember_created_at timestamp without time zone,
    sign_in_count integer DEFAULT 0 NOT NULL,
    current_sign_in_at timestamp without time zone,
    last_sign_in_at timestamp without time zone,
    current_sign_in_ip inet,
    last_sign_in_ip inet,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    first_name character varying,
    last_name character varying,
    fb_profile character varying,
    phone_number character varying,
    location character varying,
    defaults_listing character varying,
    defaults_contact character varying,
    provider character varying,
    uid character varying,
    facebook_picture_url character varying,
    friends character varying,
    friendlists character varying,
    token character varying,
    token_expiry timestamp without time zone,
    photo character varying,
    user_friends json,
    admin boolean DEFAULT false NOT NULL
);


ALTER TABLE users OWNER TO moritz;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: moritz
--

CREATE SEQUENCE users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE users_id_seq OWNER TO moritz;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: moritz
--

ALTER SEQUENCE users_id_seq OWNED BY users.id;


--
-- Name: blacklists id; Type: DEFAULT; Schema: public; Owner: moritz
--

ALTER TABLE ONLY blacklists ALTER COLUMN id SET DEFAULT nextval('blacklists_id_seq'::regclass);


--
-- Name: chat_rooms id; Type: DEFAULT; Schema: public; Owner: moritz
--

ALTER TABLE ONLY chat_rooms ALTER COLUMN id SET DEFAULT nextval('chat_rooms_id_seq'::regclass);


--
-- Name: listings id; Type: DEFAULT; Schema: public; Owner: moritz
--

ALTER TABLE ONLY listings ALTER COLUMN id SET DEFAULT nextval('listings_id_seq'::regclass);


--
-- Name: meetings id; Type: DEFAULT; Schema: public; Owner: moritz
--

ALTER TABLE ONLY meetings ALTER COLUMN id SET DEFAULT nextval('meetings_id_seq'::regclass);


--
-- Name: messages id; Type: DEFAULT; Schema: public; Owner: moritz
--

ALTER TABLE ONLY messages ALTER COLUMN id SET DEFAULT nextval('messages_id_seq'::regclass);


--
-- Name: participants id; Type: DEFAULT; Schema: public; Owner: moritz
--

ALTER TABLE ONLY participants ALTER COLUMN id SET DEFAULT nextval('participants_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: moritz
--

ALTER TABLE ONLY users ALTER COLUMN id SET DEFAULT nextval('users_id_seq'::regclass);


--
-- Data for Name: ar_internal_metadata; Type: TABLE DATA; Schema: public; Owner: moritz
--

COPY ar_internal_metadata (key, value, created_at, updated_at) FROM stdin;
environment	development	2017-08-29 14:10:07.365817	2017-08-29 14:10:07.365817
\.


--
-- Data for Name: blacklists; Type: TABLE DATA; Schema: public; Owner: moritz
--

COPY blacklists (id, user_id, friend_id, created_at, updated_at) FROM stdin;
\.


--
-- Name: blacklists_id_seq; Type: SEQUENCE SET; Schema: public; Owner: moritz
--

SELECT pg_catalog.setval('blacklists_id_seq', 16, true);


--
-- Data for Name: chat_rooms; Type: TABLE DATA; Schema: public; Owner: moritz
--

COPY chat_rooms (id, name, created_at, updated_at, meeting_id) FROM stdin;
1	12_chatroom	2017-09-01 10:42:58.789849	2017-09-01 10:42:58.789849	1
2	12_chatroom	2017-09-01 13:20:21.857473	2017-09-01 13:20:21.857473	2
3	23_chatroom	2017-09-03 20:34:00.814364	2017-09-03 20:34:00.814364	3
4	24_chatroom	2017-09-04 10:02:50.836886	2017-09-04 10:02:50.836886	4
5	17_chatroom	2017-09-04 16:07:36.999661	2017-09-04 16:07:36.999661	5
6	26_chatroom	2017-09-04 16:31:03.767056	2017-09-04 16:31:03.767056	6
7	27_chatroom	2017-09-05 08:41:54.626289	2017-09-05 08:41:54.626289	7
\.


--
-- Name: chat_rooms_id_seq; Type: SEQUENCE SET; Schema: public; Owner: moritz
--

SELECT pg_catalog.setval('chat_rooms_id_seq', 7, true);


--
-- Data for Name: listings; Type: TABLE DATA; Schema: public; Owner: moritz
--

COPY listings (id, offered_datetime, activity, location, comment, friends_circle, user_id, created_at, updated_at, offered_datetime_text, status) FROM stdin;
6	2017-08-30 15:37:56.823382	🍽	\N	\N	\N	4	2017-08-30 15:37:56.8247	2017-09-04 15:32:43.044836	NOW	expired
12	2017-08-31 14:52:16.230321	🥘	\N	\N	\N	5	2017-08-31 14:52:16.232416	2017-09-04 15:32:43.051864	NOW	expired
16	2017-09-01 11:47:59.087253	🥘	\N	\N	\N	6	2017-09-01 11:47:59.090901	2017-09-04 15:32:43.055949	NOW	expired
19	2017-09-01 18:00:00	🚀	\N	\N	\N	8	2017-09-01 11:52:44.534711	2017-09-04 15:32:43.064046	TONIGHT	expired
20	2017-09-01 11:54:29.562594	🤷	\N	\N	\N	9	2017-09-01 11:54:29.563842	2017-09-04 15:32:43.067686	NOW	expired
22	2017-09-02 14:29:35.852552	💘	\N	\N	\N	3	2017-09-02 13:29:35.867202	2017-09-04 15:32:43.071494	+1h	expired
23	2017-09-03 20:33:34.474732	🍽	\N	\N	\N	10	2017-09-03 20:33:34.484203	2017-09-04 15:32:43.074858	NOW	expired
17	2017-09-01 11:50:13.009022	🎉	\N	\N	\N	7	2017-09-01 11:50:13.010148	2017-09-04 16:07:37.010278	NOW	in use
26	2017-09-04 20:00:00	🎉	\N	\N	\N	10	2017-09-04 16:30:43.969168	2017-09-04 16:31:03.773789	TONIGHT	in use
24	2017-09-04 18:00:00	🥘	\N	\N	\N	3	2017-09-04 10:01:46.534563	2017-09-04 18:00:50.522076	TONIGHT	expired
27	2017-09-05 20:00:00	🎉	\N	\N	\N	10	2017-09-05 08:30:32.049024	2017-09-05 08:41:54.632335	TONIGHT	in use
28	2017-09-05 09:01:28.739664	🤷	\N	\N	\N	3	2017-09-05 08:31:28.741378	2017-09-05 09:04:30.043257	NOW	expired
\.


--
-- Name: listings_id_seq; Type: SEQUENCE SET; Schema: public; Owner: moritz
--

SELECT pg_catalog.setval('listings_id_seq', 28, true);


--
-- Data for Name: meetings; Type: TABLE DATA; Schema: public; Owner: moritz
--

COPY meetings (id, listing_id, status, created_at, updated_at) FROM stdin;
1	12		2017-09-01 10:42:58.781369	2017-09-01 10:42:58.781369
2	12		2017-09-01 13:20:21.852203	2017-09-01 13:20:21.852203
3	23	inactive	2017-09-03 20:34:00.802836	2017-09-04 15:48:49.434693
4	24	inactive	2017-09-04 10:02:50.830554	2017-09-04 15:48:49.442678
5	17	inactive	2017-09-04 16:07:36.990965	2017-09-04 21:24:23.571318
6	26	inactive	2017-09-04 16:31:03.759424	2017-09-04 23:24:56.463417
7	27	active	2017-09-05 08:41:54.620524	2017-09-05 08:41:54.620524
\.


--
-- Name: meetings_id_seq; Type: SEQUENCE SET; Schema: public; Owner: moritz
--

SELECT pg_catalog.setval('meetings_id_seq', 7, true);


--
-- Data for Name: messages; Type: TABLE DATA; Schema: public; Owner: moritz
--

COPY messages (id, user_id, text, created_at, updated_at, chat_room_id) FROM stdin;
\.


--
-- Name: messages_id_seq; Type: SEQUENCE SET; Schema: public; Owner: moritz
--

SELECT pg_catalog.setval('messages_id_seq', 1, false);


--
-- Data for Name: participants; Type: TABLE DATA; Schema: public; Owner: moritz
--

COPY participants (id, user_id, meeting_id, created_at, updated_at) FROM stdin;
1	3	1	2017-09-01 10:42:58.786661	2017-09-01 10:42:58.786661
2	3	2	2017-09-01 13:20:21.855098	2017-09-01 13:20:21.855098
3	3	3	2017-09-03 20:34:00.807023	2017-09-03 20:34:00.807023
4	10	4	2017-09-04 10:02:50.834566	2017-09-04 10:02:50.834566
5	3	5	2017-09-04 16:07:36.996115	2017-09-04 16:07:36.996115
6	3	6	2017-09-04 16:31:03.763662	2017-09-04 16:31:03.763662
7	3	7	2017-09-05 08:41:54.623271	2017-09-05 08:41:54.623271
8	10	7	2017-09-05 08:41:54.624848	2017-09-05 08:41:54.624848
\.


--
-- Name: participants_id_seq; Type: SEQUENCE SET; Schema: public; Owner: moritz
--

SELECT pg_catalog.setval('participants_id_seq', 8, true);


--
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: public; Owner: moritz
--

COPY schema_migrations (version) FROM stdin;
20170828135342
20170828135913
20170828140224
20170828140411
20170828140412
20170828140452
20170829092547
20170829140340
20170829163244
20170830145404
20170831122632
20170831084626
20170831090722
20170831132611
20170904102439
20170904120939
20170904133403
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: moritz
--

COPY users (id, email, encrypted_password, reset_password_token, reset_password_sent_at, remember_created_at, sign_in_count, current_sign_in_at, last_sign_in_at, current_sign_in_ip, last_sign_in_ip, created_at, updated_at, first_name, last_name, fb_profile, phone_number, location, defaults_listing, defaults_contact, provider, uid, facebook_picture_url, friends, friendlists, token, token_expiry, photo, user_friends, admin) FROM stdin;
8	kristofer.espinosa@mail.mcgill.ca	$2a$11$Gquv7ukbK9nQidPR9fWhOenQTb7vfooLEKu.oTfU0E9v.qyo57rZy	\N	\N	\N	1	2017-09-01 11:52:01.330344	2017-09-01 11:52:01.330344	127.0.0.1	127.0.0.1	2017-09-01 11:52:01.326678	2017-09-01 11:52:01.331087	Totof	Espinosa	\N	\N	\N	\N	\N	facebook	10159764793165643	https://graph.facebook.com/v2.6/10159764793165643/picture?type=square	\N	\N	EAAYwEKxaN7ABAA2MdnWZCpkObGjjj06mvFtAp12WFIZBE1CbNZBGD4KnzIKaW8c0NkAMyHV4qn8k1Xpfw9LfF6YM3oYER8CDakCJRNbIYjrlTcyxiSJKAfVYPIVaVXGOe8WyPAStFDZAfrr1RPdECAGCQkWXCpkZD	2017-10-31 11:52:00	\N	\N	f
9	derkili.spam@me.com	$2a$11$ppO6HBsnogtV1H7RZlgiVupX7tJ/2K6245lEp6c6B3Tf7WWSAqfkC	\N	\N	\N	1	2017-09-01 11:54:27.175808	2017-09-01 11:54:27.175808	127.0.0.1	127.0.0.1	2017-09-01 11:54:27.17228	2017-09-01 11:54:27.17648	Kilian	Martin	\N	\N	\N	\N	\N	facebook	10214664810720934	https://graph.facebook.com/v2.6/10214664810720934/picture?type=square	\N	\N	EAAYwEKxaN7ABAE4EDkHxvxXnB2lFm5LRsZAw62xTYZCweQ6zUGL6byZA1K0CbMgKCZAMm9ANJEMPgNu1BRIBfIX5llEZAsmHOZCi68hqEJpH1FZAZBnayWyq2Sv1LW30znIrClFy71Xj1LMSR4PSvXnrZBVHw2G1DBBwZD	2017-10-30 13:19:00	\N	\N	f
10	danielgadea@t-online.de	$2a$11$ddp96cADyI6DFq2Yu37rPeAGArv7ybEjRZJ.2ZFLXqxtINZUoqYeC	\N	\N	\N	1	2017-09-03 20:33:29.328129	2017-09-03 20:33:29.328129	127.0.0.1	127.0.0.1	2017-09-03 20:33:29.319568	2017-09-03 20:33:29.32889	Daniel	Gadea	\N	\N	\N	\N	\N	facebook	10211622816780986	https://graph.facebook.com/v2.6/10211622816780986/picture?type=square	\N	\N	EAAYwEKxaN7ABAIETWMvMzL2yJR9k0Sq6T0CVA5qilOwZAnaZA3NkUqBAHDOAwEbVwmyH0pUlTve6Y4FgKoWfIuwa8cvbitv1XhIoXn56DZBHDOnzAGVsDvlsnRALIu2ZBpshHukIH6C9LHpfgTjkHQeGZAUNNZCYWjFydP2hdE5GG9qdKSfInE	2017-11-02 20:33:28	\N	\N	f
6	wahrlich@live.de	$2a$11$K8zcIR6rzDjqyiko1g7Z3uenXHw/jtYgOqxIjh40U9hxw3BCJR1PS	\N	\N	\N	1	2017-09-01 11:47:56.119197	2017-09-01 11:47:56.119197	127.0.0.1	127.0.0.1	2017-09-01 11:47:56.115175	2017-09-01 11:47:56.119664	Moritz	Wahrlich	\N	\N	\N	\N	\N	facebook	10214768514713490	https://graph.facebook.com/v2.6/10214768514713490/picture?type=square	\N	\N	EAAYwEKxaN7ABALLwsWisBqy8E1GaUsBdjPQBveCRJTV1XwP11TMJCxgRynicl3y8U0hlYcoZBihPquNhiw0Q7yp8M0pKmz7o0CeQOkDEjlfP2reM172kKmZBAiQqg1apnJRZBv9REoqD80QQpI0SpnZAZAktpi3AZD	2017-10-31 11:47:55	\N	\N	f
7	alice.claouis@gmail.com	$2a$11$czFRNvfsHsscQS/fk5.wzOq6DmzyFM6ZqNz9dsNzz40BvIE3onwgi	\N	\N	\N	1	2017-09-01 11:50:03.369985	2017-09-01 11:50:03.369985	127.0.0.1	127.0.0.1	2017-09-01 11:50:03.366246	2017-09-01 11:50:03.370807	Alice	Clavel	\N	\N	\N	\N	\N	facebook	1564481376905675	https://graph.facebook.com/v2.6/1564481376905675/picture?type=square	\N	\N	EAAYwEKxaN7ABAEEbSIvsIuRkENCTjyggN6aLSy0JZCizDEtiofS3gJtI6F6jsFaH1oFBDPFe88t4pfLZA1asNeKWhBZCglFAYbiEPTZCICxb2rF9mcdvdHrPz5wUJKp35xUSklx4mdcdZBHvaGvW2iNMZAIn4ZADjfyPU3Kv9ev2gZDZD	2017-10-31 11:50:02	\N	\N	f
4	johnhayesbikes@gmail.com	$2a$11$SX8JCt7bFoMKB34cu0eXw.hTKmA61nYXOVpbgMiOEtm0lcGWD0H2G	\N	\N	\N	1	2017-08-30 15:37:53.953747	2017-08-30 15:37:53.953747	127.0.0.1	127.0.0.1	2017-08-30 15:37:53.950203	2017-08-30 15:37:53.954535	John	Hayes	\N	\N	\N	\N	\N	facebook	1991644531072433	https://graph.facebook.com/v2.6/1991644531072433/picture?type=square	\N	\N	EAAYwEKxaN7ABAB0td4kDT2oewv62ARxZAPI3EepFbwMC0B91ob6VfECGTto2LR9Eq61lxSmnc1I0aG96Dy0RsGoaoIsUKisZA8c5fhsvpOuo51vebPUgo7fvpfko805OrepoIjK9peZCtDaCrpxNNlh3TsHG1l0fJC0wNPccAZDZD	2017-10-29 15:37:52	\N	\N	f
5	flgpc@hotmail.com	$2a$11$baU6sBMXEapEiq63UlsA3O4PkN85KOu/I0SW6RBBI5LpNjZanxq3G	\N	\N	\N	1	2017-08-31 14:52:13.105491	2017-08-31 14:52:13.105491	127.0.0.1	127.0.0.1	2017-08-31 14:52:13.101678	2017-08-31 14:52:13.106131	Francisco	Pc	\N	\N	\N	\N	\N	facebook	10155660379541624	https://graph.facebook.com/v2.6/10155660379541624/picture?type=square	\N	\N	EAAYwEKxaN7ABAI3qZBwW7Vn0F1gv06ARhHfPLwd8fPZBTWFAYM7xZAfREJZBGyC9FEsEnlwildlsAZAq2Xf5H7Up2aD32iNu38PxnnNWbqdwPWMcPmNRXiqneSupnvtAfwGDbq1VInqXLrjg0s9Qx0fsNl9iPhIZANtR5FpyNI8QZDZD	2017-10-30 14:52:11	\N	\N	f
3	fkugland@mac.com	$2a$11$vOcM.kSFnPMleLLm/4AjbO7/gja81m9crCA2ZRSKXUVxE9/FwTpdS	\N	\N	\N	23	2017-09-04 10:01:38.445998	2017-09-01 10:42:50.268824	127.0.0.1	127.0.0.1	2017-08-30 13:35:47.082354	2017-09-04 14:26:48.907908 moritz	Kugland	\N	\N	\N	\N	\N	facebook	1626632277356399	https://graph.facebook.com/v2.6/1626632277356399/picture?type=square	\N	\N	EAAYwEKxaN7ABANUD3WmEaVUjhGac7OTH7RvRm5MQgSqXW8ZBppfHWiLUBx3mH14ry3wXvZB5OoHbZCj5ljKEMgT6LTZCiBbqENtXBxBxub1joVQbhxQJiwBK4Q4CtZBQ2ZBtSQezfzNGauReAELdAyzp1iK6P4d5crTZAjt8XJrYAZDZD	2017-11-03 10:01:36	\N	\N	t
\.


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: moritz
--

SELECT pg_catalog.setval('users_id_seq', 10, true);


--
-- Name: ar_internal_metadata ar_internal_metadata_pkey; Type: CONSTRAINT; Schema: public; Owner: moritz
--

ALTER TABLE ONLY ar_internal_metadata
    ADD CONSTRAINT ar_internal_metadata_pkey PRIMARY KEY (key);


--
-- Name: blacklists blacklists_pkey; Type: CONSTRAINT; Schema: public; Owner: moritz
--

ALTER TABLE ONLY blacklists
    ADD CONSTRAINT blacklists_pkey PRIMARY KEY (id);


--
-- Name: chat_rooms chat_rooms_pkey; Type: CONSTRAINT; Schema: public; Owner: moritz
--

ALTER TABLE ONLY chat_rooms
    ADD CONSTRAINT chat_rooms_pkey PRIMARY KEY (id);


--
-- Name: listings listings_pkey; Type: CONSTRAINT; Schema: public; Owner: moritz
--

ALTER TABLE ONLY listings
    ADD CONSTRAINT listings_pkey PRIMARY KEY (id);


--
-- Name: meetings meetings_pkey; Type: CONSTRAINT; Schema: public; Owner: moritz
--

ALTER TABLE ONLY meetings
    ADD CONSTRAINT meetings_pkey PRIMARY KEY (id);


--
-- Name: messages messages_pkey; Type: CONSTRAINT; Schema: public; Owner: moritz
--

ALTER TABLE ONLY messages
    ADD CONSTRAINT messages_pkey PRIMARY KEY (id);


--
-- Name: participants participants_pkey; Type: CONSTRAINT; Schema: public; Owner: moritz
--

ALTER TABLE ONLY participants
    ADD CONSTRAINT participants_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: moritz
--

ALTER TABLE ONLY schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: moritz
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: index_blacklists_on_user_id; Type: INDEX; Schema: public; Owner: moritz
--

CREATE INDEX index_blacklists_on_user_id ON blacklists USING btree (user_id);


--
-- Name: index_chat_rooms_on_meeting_id; Type: INDEX; Schema: public; Owner: moritz
--

CREATE INDEX index_chat_rooms_on_meeting_id ON chat_rooms USING btree (meeting_id);


--
-- Name: index_listings_on_user_id; Type: INDEX; Schema: public; Owner: moritz
--

CREATE INDEX index_listings_on_user_id ON listings USING btree (user_id);


--
-- Name: index_meetings_on_listing_id; Type: INDEX; Schema: public; Owner: moritz
--

CREATE INDEX index_meetings_on_listing_id ON meetings USING btree (listing_id);


--
-- Name: index_messages_on_chat_room_id; Type: INDEX; Schema: public; Owner: moritz
--

CREATE INDEX index_messages_on_chat_room_id ON messages USING btree (chat_room_id);


--
-- Name: index_messages_on_user_id; Type: INDEX; Schema: public; Owner: moritz
--

CREATE INDEX index_messages_on_user_id ON messages USING btree (user_id);


--
-- Name: index_participants_on_meeting_id; Type: INDEX; Schema: public; Owner: moritz
--

CREATE INDEX index_participants_on_meeting_id ON participants USING btree (meeting_id);


--
-- Name: index_participants_on_user_id; Type: INDEX; Schema: public; Owner: moritz
--

CREATE INDEX index_participants_on_user_id ON participants USING btree (user_id);


--
-- Name: index_users_on_email; Type: INDEX; Schema: public; Owner: moritz
--

CREATE UNIQUE INDEX index_users_on_email ON users USING btree (email);


--
-- Name: index_users_on_reset_password_token; Type: INDEX; Schema: public; Owner: moritz
--

CREATE UNIQUE INDEX index_users_on_reset_password_token ON users USING btree (reset_password_token);


--
-- Name: messages fk_rails_00aac238e8; Type: FK CONSTRAINT; Schema: public; Owner: moritz
--

ALTER TABLE ONLY messages
    ADD CONSTRAINT fk_rails_00aac238e8 FOREIGN KEY (chat_room_id) REFERENCES chat_rooms(id);


--
-- Name: blacklists fk_rails_23fa4463b8; Type: FK CONSTRAINT; Schema: public; Owner: moritz
--

ALTER TABLE ONLY blacklists
    ADD CONSTRAINT fk_rails_23fa4463b8 FOREIGN KEY (user_id) REFERENCES users(id);


--
-- Name: messages fk_rails_273a25a7a6; Type: FK CONSTRAINT; Schema: public; Owner: moritz
--

ALTER TABLE ONLY messages
    ADD CONSTRAINT fk_rails_273a25a7a6 FOREIGN KEY (user_id) REFERENCES users(id);


--
-- Name: participants fk_rails_59ae73a91d; Type: FK CONSTRAINT; Schema: public; Owner: moritz
--

ALTER TABLE ONLY participants
    ADD CONSTRAINT fk_rails_59ae73a91d FOREIGN KEY (meeting_id) REFERENCES meetings(id);


--
-- Name: participants fk_rails_b9a3c50f15; Type: FK CONSTRAINT; Schema: public; Owner: moritz
--

ALTER TABLE ONLY participants
    ADD CONSTRAINT fk_rails_b9a3c50f15 FOREIGN KEY (user_id) REFERENCES users(id);


--
-- Name: listings fk_rails_baa008bfd2; Type: FK CONSTRAINT; Schema: public; Owner: moritz
--

ALTER TABLE ONLY listings
    ADD CONSTRAINT fk_rails_baa008bfd2 FOREIGN KEY (user_id) REFERENCES users(id);


--
-- Name: meetings fk_rails_bb617aa3bf; Type: FK CONSTRAINT; Schema: public; Owner: moritz
--

ALTER TABLE ONLY meetings
    ADD CONSTRAINT fk_rails_bb617aa3bf FOREIGN KEY (listing_id) REFERENCES listings(id);


--
-- Name: chat_rooms fk_rails_d0dd415561; Type: FK CONSTRAINT; Schema: public; Owner: moritz
--

ALTER TABLE ONLY chat_rooms
    ADD CONSTRAINT fk_rails_d0dd415561 FOREIGN KEY (meeting_id) REFERENCES meetings(id);


--
-- PostgreSQL database dump complete
--

