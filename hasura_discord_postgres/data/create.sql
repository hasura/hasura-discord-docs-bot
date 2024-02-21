SET check_function_bodies = false;
CREATE FUNCTION public.set_current_timestamp_updated_at() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
  _new record;
BEGIN
  _new := NEW;
  _new."updated_at" = NOW();
  RETURN _new;
END;
$$;
CREATE TABLE public."COLLECTION_ENUM" (
    value text NOT NULL,
    comment text
);
CREATE TABLE public.configuration (
    guild_id bigint NOT NULL,
    logging_channel_id bigint NOT NULL,
    mod_role_id bigint NOT NULL,
    banned_user_ids bigint[] NOT NULL
);
CREATE TABLE public.guild_forums (
    guild_id bigint NOT NULL,
    forum_channel_id bigint NOT NULL,
    forum_collection text NOT NULL
);
CREATE TABLE public.message (
    thread_id text NOT NULL,
    message_id text NOT NULL,
    content text NOT NULL,
    from_bot boolean NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    first_message boolean NOT NULL,
    mentions_bot boolean NOT NULL,
    sources text,
    processed boolean DEFAULT false NOT NULL
);
CREATE TABLE public.thread (
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    open boolean DEFAULT true NOT NULL,
    solved boolean DEFAULT false NOT NULL,
    thread_id text NOT NULL,
    title text,
    collection text NOT NULL,
    thread_controller_id text NOT NULL,
    author_id text NOT NULL,
    solved_votes integer DEFAULT 0 NOT NULL,
    failed_votes integer DEFAULT 0 NOT NULL
);
ALTER TABLE ONLY public."COLLECTION_ENUM"
    ADD CONSTRAINT "COLLECTION_ENUM_pkey" PRIMARY KEY (value);
ALTER TABLE ONLY public.configuration
    ADD CONSTRAINT configuration_pkey PRIMARY KEY (guild_id);
ALTER TABLE ONLY public.guild_forums
    ADD CONSTRAINT guild_forums_pkey PRIMARY KEY (guild_id, forum_channel_id);
ALTER TABLE ONLY public.message
    ADD CONSTRAINT message_pkey PRIMARY KEY (thread_id, message_id);
ALTER TABLE ONLY public.thread
    ADD CONSTRAINT thread_pkey PRIMARY KEY (thread_id);
ALTER TABLE ONLY public.thread
    ADD CONSTRAINT thread_thread_controller_id_key UNIQUE (thread_controller_id);
CREATE TRIGGER set_public_message_updated_at BEFORE UPDATE ON public.message FOR EACH ROW EXECUTE FUNCTION public.set_current_timestamp_updated_at();
COMMENT ON TRIGGER set_public_message_updated_at ON public.message IS 'trigger to set value of column "updated_at" to current timestamp on row update';
CREATE TRIGGER set_public_thread_updated_at BEFORE UPDATE ON public.thread FOR EACH ROW EXECUTE FUNCTION public.set_current_timestamp_updated_at();
COMMENT ON TRIGGER set_public_thread_updated_at ON public.thread IS 'trigger to set value of column "updated_at" to current timestamp on row update';
ALTER TABLE ONLY public.guild_forums
    ADD CONSTRAINT guild_forums_forum_collection_fkey FOREIGN KEY (forum_collection) REFERENCES public."COLLECTION_ENUM"(value) ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE ONLY public.guild_forums
    ADD CONSTRAINT guild_forums_guild_id_fkey FOREIGN KEY (guild_id) REFERENCES public.configuration(guild_id) ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE ONLY public.message
    ADD CONSTRAINT message_thread_id_fkey FOREIGN KEY (thread_id) REFERENCES public.thread(thread_id) ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE ONLY public.thread
    ADD CONSTRAINT thread_collection_fkey FOREIGN KEY (collection) REFERENCES public."COLLECTION_ENUM"(value) ON UPDATE CASCADE ON DELETE CASCADE;