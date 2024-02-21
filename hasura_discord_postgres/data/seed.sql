COPY public."COLLECTION_ENUM" (value, comment) FROM stdin;
v3	\N
\.
COPY public.configuration (guild_id, logging_channel_id, mod_role_id, banned_user_ids) FROM stdin;
1204239405011832883	1204239405456297995	1209640032747528202	{}
\.
COPY public.guild_forums (guild_id, forum_channel_id, forum_collection) FROM stdin;
1204239405011832883	1204246613145419806	v3
\.
