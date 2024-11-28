create type "public"."enum__pages_v_blocks_text_image_alignment" as enum ('left', 'right');

create type "public"."enum__pages_v_blocks_text_image_buttons_link_appearance" as enum ('default', 'outline');

create type "public"."enum__pages_v_blocks_text_image_buttons_link_type" as enum ('reference', 'custom');

create type "public"."enum__pages_v_version_status" as enum ('draft', 'published');

create type "public"."enum__posts_v_version_status" as enum ('draft', 'published');

create type "public"."enum_footer_links_children_link_type" as enum ('reference', 'custom');

create type "public"."enum_footer_links_link_type" as enum ('reference', 'custom');

create type "public"."enum_forms_confirmation_type" as enum ('message', 'redirect');

create type "public"."enum_header_links_children_link_type" as enum ('reference', 'custom');

create type "public"."enum_header_links_link_type" as enum ('reference', 'custom');

create type "public"."enum_pages_blocks_text_image_alignment" as enum ('left', 'right');

create type "public"."enum_pages_blocks_text_image_buttons_link_appearance" as enum ('default', 'outline');

create type "public"."enum_pages_blocks_text_image_buttons_link_type" as enum ('reference', 'custom');

create type "public"."enum_pages_status" as enum ('draft', 'published');

create type "public"."enum_posts_status" as enum ('draft', 'published');

create type "public"."enum_redirects_to_type" as enum ('reference', 'custom');

create sequence "public"."_pages_v_blocks_confetti_header_id_seq";

create sequence "public"."_pages_v_blocks_cover_id_seq";

create sequence "public"."_pages_v_blocks_form_block_id_seq";

create sequence "public"."_pages_v_blocks_github_globe_id_seq";

create sequence "public"."_pages_v_blocks_hero_highlight_id_seq";

create sequence "public"."_pages_v_blocks_image_id_seq";

create sequence "public"."_pages_v_blocks_infinite_moving_cards_cards_id_seq";

create sequence "public"."_pages_v_blocks_infinite_moving_cards_id_seq";

create sequence "public"."_pages_v_blocks_links_preview_id_seq";

create sequence "public"."_pages_v_blocks_links_preview_rows_id_seq";

create sequence "public"."_pages_v_blocks_rich_text_id_seq";

create sequence "public"."_pages_v_blocks_spotlight_id_seq";

create sequence "public"."_pages_v_blocks_text_effect_id_seq";

create sequence "public"."_pages_v_blocks_text_image_buttons_id_seq";

create sequence "public"."_pages_v_blocks_text_image_id_seq";

create sequence "public"."_pages_v_blocks_tik_tac_toe_id_seq";

create sequence "public"."_pages_v_id_seq";

create sequence "public"."_pages_v_rels_id_seq";

create sequence "public"."_posts_v_id_seq";

create sequence "public"."_posts_v_rels_id_seq";

create sequence "public"."_posts_v_version_populated_authors_id_seq";

create sequence "public"."categories_id_seq";

create sequence "public"."footer_id_seq";

create sequence "public"."footer_rels_id_seq";

create sequence "public"."form_submissions_id_seq";

create sequence "public"."forms_id_seq";

create sequence "public"."header_id_seq";

create sequence "public"."header_rels_id_seq";

create sequence "public"."media_id_seq";

create sequence "public"."pages_id_seq";

create sequence "public"."pages_rels_id_seq";

create sequence "public"."payload_locked_documents_id_seq";

create sequence "public"."payload_locked_documents_rels_id_seq";

create sequence "public"."payload_migrations_id_seq";

create sequence "public"."payload_preferences_id_seq";

create sequence "public"."payload_preferences_rels_id_seq";

create sequence "public"."posts_id_seq";

create sequence "public"."posts_rels_id_seq";

create sequence "public"."redirects_id_seq";

create sequence "public"."redirects_rels_id_seq";

create sequence "public"."users_id_seq";

create table "public"."_pages_v" (
    "id" integer not null default nextval('_pages_v_id_seq'::regclass),
    "parent_id" integer,
    "version_title" character varying,
    "version_slug" character varying,
    "version_meta_title" character varying,
    "version_meta_image_id" integer,
    "version_meta_description" character varying,
    "version_updated_at" timestamp(3) with time zone,
    "version_created_at" timestamp(3) with time zone,
    "version__status" enum__pages_v_version_status default 'draft'::enum__pages_v_version_status,
    "created_at" timestamp(3) with time zone not null default now(),
    "updated_at" timestamp(3) with time zone not null default now(),
    "latest" boolean,
    "version_created_by_id" integer,
    "version_slug_lock" boolean default true,
    "autosave" boolean
);


create table "public"."_pages_v_blocks_confetti_header" (
    "_order" integer not null,
    "_parent_id" integer not null,
    "_path" text not null,
    "id" integer not null default nextval('_pages_v_blocks_confetti_header_id_seq'::regclass),
    "title" character varying,
    "_uuid" character varying,
    "block_name" character varying
);


create table "public"."_pages_v_blocks_cover" (
    "_order" integer not null,
    "_parent_id" integer not null,
    "_path" text not null,
    "id" integer not null default nextval('_pages_v_blocks_cover_id_seq'::regclass),
    "title" character varying,
    "subtitle" character varying,
    "_uuid" character varying,
    "block_name" character varying
);


create table "public"."_pages_v_blocks_form_block" (
    "_order" integer not null,
    "_parent_id" integer not null,
    "_path" text not null,
    "id" integer not null default nextval('_pages_v_blocks_form_block_id_seq'::regclass),
    "form_id" integer,
    "enable_intro" boolean,
    "intro_content" jsonb,
    "_uuid" character varying,
    "block_name" character varying
);


create table "public"."_pages_v_blocks_github_globe" (
    "_order" integer not null,
    "_parent_id" integer not null,
    "_path" text not null,
    "id" integer not null default nextval('_pages_v_blocks_github_globe_id_seq'::regclass),
    "title" character varying,
    "description" character varying,
    "_uuid" character varying,
    "block_name" character varying
);


create table "public"."_pages_v_blocks_hero_highlight" (
    "_order" integer not null,
    "_parent_id" integer not null,
    "_path" text not null,
    "id" integer not null default nextval('_pages_v_blocks_hero_highlight_id_seq'::regclass),
    "title" character varying,
    "highlight" character varying,
    "_uuid" character varying,
    "block_name" character varying
);


create table "public"."_pages_v_blocks_image" (
    "_order" integer not null,
    "_parent_id" integer not null,
    "_path" text not null,
    "id" integer not null default nextval('_pages_v_blocks_image_id_seq'::regclass),
    "image_id" integer,
    "_uuid" character varying,
    "block_name" character varying
);


create table "public"."_pages_v_blocks_infinite_moving_cards" (
    "_order" integer not null,
    "_parent_id" integer not null,
    "_path" text not null,
    "id" integer not null default nextval('_pages_v_blocks_infinite_moving_cards_id_seq'::regclass),
    "_uuid" character varying,
    "block_name" character varying
);


create table "public"."_pages_v_blocks_infinite_moving_cards_cards" (
    "_order" integer not null,
    "_parent_id" integer not null,
    "id" integer not null default nextval('_pages_v_blocks_infinite_moving_cards_cards_id_seq'::regclass),
    "quote" character varying,
    "name" character varying,
    "title" character varying,
    "_uuid" character varying
);


create table "public"."_pages_v_blocks_links_preview" (
    "_order" integer not null,
    "_parent_id" integer not null,
    "_path" text not null,
    "id" integer not null default nextval('_pages_v_blocks_links_preview_id_seq'::regclass),
    "_uuid" character varying,
    "block_name" character varying
);


create table "public"."_pages_v_blocks_links_preview_rows" (
    "_order" integer not null,
    "_parent_id" integer not null,
    "id" integer not null default nextval('_pages_v_blocks_links_preview_rows_id_seq'::regclass),
    "first_link_link" character varying,
    "first_link_title" character varying,
    "_uuid" character varying,
    "first_text" character varying,
    "second_text" character varying,
    "second_link_link" character varying,
    "second_link_title" character varying,
    "third_text" character varying
);


create table "public"."_pages_v_blocks_rich_text" (
    "_order" integer not null,
    "_parent_id" integer not null,
    "_path" text not null,
    "id" integer not null default nextval('_pages_v_blocks_rich_text_id_seq'::regclass),
    "content" jsonb,
    "_uuid" character varying,
    "block_name" character varying
);


create table "public"."_pages_v_blocks_spotlight" (
    "_order" integer not null,
    "_parent_id" integer not null,
    "_path" text not null,
    "id" integer not null default nextval('_pages_v_blocks_spotlight_id_seq'::regclass),
    "title" character varying,
    "description" character varying,
    "_uuid" character varying,
    "block_name" character varying
);


create table "public"."_pages_v_blocks_text_effect" (
    "_order" integer not null,
    "_parent_id" integer not null,
    "_path" text not null,
    "id" integer not null default nextval('_pages_v_blocks_text_effect_id_seq'::regclass),
    "text" character varying,
    "_uuid" character varying,
    "block_name" character varying
);


create table "public"."_pages_v_blocks_text_image" (
    "_order" integer not null,
    "_parent_id" integer not null,
    "_path" text not null,
    "id" integer not null default nextval('_pages_v_blocks_text_image_id_seq'::regclass),
    "title" character varying,
    "description" character varying,
    "image_id" integer,
    "_uuid" character varying,
    "block_name" character varying,
    "alignment" enum__pages_v_blocks_text_image_alignment
);


create table "public"."_pages_v_blocks_text_image_buttons" (
    "_order" integer not null,
    "_parent_id" integer not null,
    "id" integer not null default nextval('_pages_v_blocks_text_image_buttons_id_seq'::regclass),
    "link_type" enum__pages_v_blocks_text_image_buttons_link_type default 'reference'::enum__pages_v_blocks_text_image_buttons_link_type,
    "link_new_tab" boolean,
    "link_url" character varying,
    "link_label" character varying,
    "link_appearance" enum__pages_v_blocks_text_image_buttons_link_appearance default 'default'::enum__pages_v_blocks_text_image_buttons_link_appearance,
    "_uuid" character varying
);


create table "public"."_pages_v_blocks_tik_tac_toe" (
    "_order" integer not null,
    "_parent_id" integer not null,
    "_path" text not null,
    "id" integer not null default nextval('_pages_v_blocks_tik_tac_toe_id_seq'::regclass),
    "_uuid" character varying,
    "block_name" character varying
);


create table "public"."_pages_v_rels" (
    "id" integer not null default nextval('_pages_v_rels_id_seq'::regclass),
    "order" integer,
    "parent_id" integer not null,
    "path" character varying not null,
    "pages_id" integer
);


create table "public"."_posts_v" (
    "id" integer not null default nextval('_posts_v_id_seq'::regclass),
    "parent_id" integer,
    "version_title" character varying,
    "version_content" jsonb,
    "version_meta_title" character varying,
    "version_meta_image_id" integer,
    "version_meta_description" character varying,
    "version_published_at" timestamp(3) with time zone,
    "version_slug" character varying,
    "version_slug_lock" boolean default true,
    "version_updated_at" timestamp(3) with time zone,
    "version_created_at" timestamp(3) with time zone,
    "version__status" enum__posts_v_version_status default 'draft'::enum__posts_v_version_status,
    "created_at" timestamp(3) with time zone not null default now(),
    "updated_at" timestamp(3) with time zone not null default now(),
    "latest" boolean,
    "autosave" boolean
);


create table "public"."_posts_v_rels" (
    "id" integer not null default nextval('_posts_v_rels_id_seq'::regclass),
    "order" integer,
    "parent_id" integer not null,
    "path" character varying not null,
    "posts_id" integer,
    "categories_id" integer,
    "users_id" integer
);


create table "public"."_posts_v_version_populated_authors" (
    "_order" integer not null,
    "_parent_id" integer not null,
    "id" integer not null default nextval('_posts_v_version_populated_authors_id_seq'::regclass),
    "_uuid" character varying,
    "name" character varying
);


create table "public"."categories" (
    "id" integer not null default nextval('categories_id_seq'::regclass),
    "title" character varying not null,
    "updated_at" timestamp(3) with time zone not null default now(),
    "created_at" timestamp(3) with time zone not null default now()
);


create table "public"."footer" (
    "id" integer not null default nextval('footer_id_seq'::regclass),
    "logo_id" integer not null,
    "copyright" character varying not null,
    "updated_at" timestamp(3) with time zone,
    "created_at" timestamp(3) with time zone
);


create table "public"."footer_links" (
    "_order" integer not null,
    "_parent_id" integer not null,
    "id" character varying not null,
    "link_type" enum_footer_links_link_type default 'reference'::enum_footer_links_link_type,
    "link_new_tab" boolean,
    "link_url" character varying,
    "link_label" character varying not null
);


create table "public"."footer_links_children" (
    "_order" integer not null,
    "_parent_id" character varying not null,
    "id" character varying not null,
    "link_type" enum_footer_links_children_link_type default 'reference'::enum_footer_links_children_link_type,
    "link_new_tab" boolean,
    "link_url" character varying,
    "link_label" character varying
);


create table "public"."footer_rels" (
    "id" integer not null default nextval('footer_rels_id_seq'::regclass),
    "order" integer,
    "parent_id" integer not null,
    "path" character varying not null,
    "pages_id" integer
);


create table "public"."form_submissions" (
    "id" integer not null default nextval('form_submissions_id_seq'::regclass),
    "form_id" integer not null,
    "updated_at" timestamp(3) with time zone not null default now(),
    "created_at" timestamp(3) with time zone not null default now()
);


create table "public"."form_submissions_submission_data" (
    "_order" integer not null,
    "_parent_id" integer not null,
    "id" character varying not null,
    "field" character varying not null,
    "value" character varying not null
);


create table "public"."forms" (
    "id" integer not null default nextval('forms_id_seq'::regclass),
    "title" character varying not null,
    "submit_button_label" character varying,
    "confirmation_type" enum_forms_confirmation_type default 'message'::enum_forms_confirmation_type,
    "confirmation_message" jsonb,
    "redirect_url" character varying,
    "updated_at" timestamp(3) with time zone not null default now(),
    "created_at" timestamp(3) with time zone not null default now()
);


create table "public"."forms_blocks_checkbox" (
    "_order" integer not null,
    "_parent_id" integer not null,
    "_path" text not null,
    "id" character varying not null,
    "name" character varying not null,
    "label" character varying,
    "width" numeric,
    "required" boolean,
    "default_value" boolean,
    "block_name" character varying
);


create table "public"."forms_blocks_country" (
    "_order" integer not null,
    "_parent_id" integer not null,
    "_path" text not null,
    "id" character varying not null,
    "name" character varying not null,
    "label" character varying,
    "width" numeric,
    "required" boolean,
    "block_name" character varying
);


create table "public"."forms_blocks_email" (
    "_order" integer not null,
    "_parent_id" integer not null,
    "_path" text not null,
    "id" character varying not null,
    "name" character varying not null,
    "label" character varying,
    "width" numeric,
    "required" boolean,
    "block_name" character varying
);


create table "public"."forms_blocks_message" (
    "_order" integer not null,
    "_parent_id" integer not null,
    "_path" text not null,
    "id" character varying not null,
    "message" jsonb,
    "block_name" character varying
);


create table "public"."forms_blocks_number" (
    "_order" integer not null,
    "_parent_id" integer not null,
    "_path" text not null,
    "id" character varying not null,
    "name" character varying not null,
    "label" character varying,
    "width" numeric,
    "default_value" numeric,
    "required" boolean,
    "block_name" character varying
);


create table "public"."forms_blocks_select" (
    "_order" integer not null,
    "_parent_id" integer not null,
    "_path" text not null,
    "id" character varying not null,
    "name" character varying not null,
    "label" character varying,
    "width" numeric,
    "default_value" character varying,
    "required" boolean,
    "block_name" character varying
);


create table "public"."forms_blocks_select_options" (
    "_order" integer not null,
    "_parent_id" character varying not null,
    "id" character varying not null,
    "label" character varying not null,
    "value" character varying not null
);


create table "public"."forms_blocks_state" (
    "_order" integer not null,
    "_parent_id" integer not null,
    "_path" text not null,
    "id" character varying not null,
    "name" character varying not null,
    "label" character varying,
    "width" numeric,
    "required" boolean,
    "block_name" character varying
);


create table "public"."forms_blocks_text" (
    "_order" integer not null,
    "_parent_id" integer not null,
    "_path" text not null,
    "id" character varying not null,
    "name" character varying not null,
    "label" character varying,
    "width" numeric,
    "default_value" character varying,
    "required" boolean,
    "block_name" character varying
);


create table "public"."forms_blocks_textarea" (
    "_order" integer not null,
    "_parent_id" integer not null,
    "_path" text not null,
    "id" character varying not null,
    "name" character varying not null,
    "label" character varying,
    "width" numeric,
    "default_value" character varying,
    "required" boolean,
    "block_name" character varying
);


create table "public"."forms_emails" (
    "_order" integer not null,
    "_parent_id" integer not null,
    "id" character varying not null,
    "email_to" character varying,
    "cc" character varying,
    "bcc" character varying,
    "reply_to" character varying,
    "email_from" character varying,
    "subject" character varying not null default 'You''''ve received a new message.'::character varying,
    "message" jsonb
);


create table "public"."header" (
    "id" integer not null default nextval('header_id_seq'::regclass),
    "logo_id" integer not null,
    "updated_at" timestamp(3) with time zone,
    "created_at" timestamp(3) with time zone
);


create table "public"."header_links" (
    "_order" integer not null,
    "_parent_id" integer not null,
    "id" character varying not null,
    "link_type" enum_header_links_link_type default 'reference'::enum_header_links_link_type,
    "link_new_tab" boolean,
    "link_url" character varying,
    "link_label" character varying not null
);


create table "public"."header_links_children" (
    "_order" integer not null,
    "_parent_id" character varying not null,
    "id" character varying not null,
    "link_type" enum_header_links_children_link_type default 'reference'::enum_header_links_children_link_type,
    "link_new_tab" boolean,
    "link_url" character varying,
    "link_label" character varying
);


create table "public"."header_rels" (
    "id" integer not null default nextval('header_rels_id_seq'::regclass),
    "order" integer,
    "parent_id" integer not null,
    "path" character varying not null,
    "pages_id" integer
);


create table "public"."media" (
    "id" integer not null default nextval('media_id_seq'::regclass),
    "alt" character varying not null,
    "prefix" character varying default 'media'::character varying,
    "updated_at" timestamp(3) with time zone not null default now(),
    "created_at" timestamp(3) with time zone not null default now(),
    "url" character varying,
    "thumbnail_u_r_l" character varying,
    "filename" character varying,
    "mime_type" character varying,
    "filesize" numeric,
    "width" numeric,
    "height" numeric,
    "focal_x" numeric,
    "focal_y" numeric
);


create table "public"."pages" (
    "id" integer not null default nextval('pages_id_seq'::regclass),
    "title" character varying,
    "slug" character varying,
    "meta_title" character varying,
    "meta_image_id" integer,
    "meta_description" character varying,
    "updated_at" timestamp(3) with time zone not null default now(),
    "created_at" timestamp(3) with time zone not null default now(),
    "_status" enum_pages_status default 'draft'::enum_pages_status,
    "created_by_id" integer,
    "slug_lock" boolean default true
);


create table "public"."pages_blocks_confetti_header" (
    "_order" integer not null,
    "_parent_id" integer not null,
    "_path" text not null,
    "id" character varying not null,
    "title" character varying,
    "block_name" character varying
);


create table "public"."pages_blocks_cover" (
    "_order" integer not null,
    "_parent_id" integer not null,
    "_path" text not null,
    "id" character varying not null,
    "title" character varying,
    "subtitle" character varying,
    "block_name" character varying
);


create table "public"."pages_blocks_form_block" (
    "_order" integer not null,
    "_parent_id" integer not null,
    "_path" text not null,
    "id" character varying not null,
    "form_id" integer,
    "enable_intro" boolean,
    "intro_content" jsonb,
    "block_name" character varying
);


create table "public"."pages_blocks_github_globe" (
    "_order" integer not null,
    "_parent_id" integer not null,
    "_path" text not null,
    "id" character varying not null,
    "title" character varying,
    "description" character varying,
    "block_name" character varying
);


create table "public"."pages_blocks_hero_highlight" (
    "_order" integer not null,
    "_parent_id" integer not null,
    "_path" text not null,
    "id" character varying not null,
    "title" character varying,
    "highlight" character varying,
    "block_name" character varying
);


create table "public"."pages_blocks_image" (
    "_order" integer not null,
    "_parent_id" integer not null,
    "_path" text not null,
    "id" character varying not null,
    "image_id" integer,
    "block_name" character varying
);


create table "public"."pages_blocks_infinite_moving_cards" (
    "_order" integer not null,
    "_parent_id" integer not null,
    "_path" text not null,
    "id" character varying not null,
    "block_name" character varying
);


create table "public"."pages_blocks_infinite_moving_cards_cards" (
    "_order" integer not null,
    "_parent_id" character varying not null,
    "id" character varying not null,
    "quote" character varying,
    "name" character varying,
    "title" character varying
);


create table "public"."pages_blocks_links_preview" (
    "_order" integer not null,
    "_parent_id" integer not null,
    "_path" text not null,
    "id" character varying not null,
    "block_name" character varying
);


create table "public"."pages_blocks_links_preview_rows" (
    "_order" integer not null,
    "_parent_id" character varying not null,
    "id" character varying not null,
    "first_link_link" character varying,
    "first_link_title" character varying,
    "first_text" character varying,
    "second_text" character varying,
    "second_link_link" character varying,
    "second_link_title" character varying,
    "third_text" character varying
);


create table "public"."pages_blocks_rich_text" (
    "_order" integer not null,
    "_parent_id" integer not null,
    "_path" text not null,
    "id" character varying not null,
    "content" jsonb,
    "block_name" character varying
);


create table "public"."pages_blocks_spotlight" (
    "_order" integer not null,
    "_parent_id" integer not null,
    "_path" text not null,
    "id" character varying not null,
    "title" character varying,
    "description" character varying,
    "block_name" character varying
);


create table "public"."pages_blocks_text_effect" (
    "_order" integer not null,
    "_parent_id" integer not null,
    "_path" text not null,
    "id" character varying not null,
    "text" character varying,
    "block_name" character varying
);


create table "public"."pages_blocks_text_image" (
    "_order" integer not null,
    "_parent_id" integer not null,
    "_path" text not null,
    "id" character varying not null,
    "title" character varying,
    "description" character varying,
    "image_id" integer,
    "block_name" character varying,
    "alignment" enum_pages_blocks_text_image_alignment
);


create table "public"."pages_blocks_text_image_buttons" (
    "_order" integer not null,
    "_parent_id" character varying not null,
    "id" character varying not null,
    "link_type" enum_pages_blocks_text_image_buttons_link_type default 'reference'::enum_pages_blocks_text_image_buttons_link_type,
    "link_new_tab" boolean,
    "link_url" character varying,
    "link_label" character varying,
    "link_appearance" enum_pages_blocks_text_image_buttons_link_appearance default 'default'::enum_pages_blocks_text_image_buttons_link_appearance
);


create table "public"."pages_blocks_tik_tac_toe" (
    "_order" integer not null,
    "_parent_id" integer not null,
    "_path" text not null,
    "id" character varying not null,
    "block_name" character varying
);


create table "public"."pages_rels" (
    "id" integer not null default nextval('pages_rels_id_seq'::regclass),
    "order" integer,
    "parent_id" integer not null,
    "path" character varying not null,
    "pages_id" integer
);


create table "public"."payload_locked_documents" (
    "id" integer not null default nextval('payload_locked_documents_id_seq'::regclass),
    "global_slug" character varying,
    "updated_at" timestamp(3) with time zone not null default now(),
    "created_at" timestamp(3) with time zone not null default now()
);


create table "public"."payload_locked_documents_rels" (
    "id" integer not null default nextval('payload_locked_documents_rels_id_seq'::regclass),
    "order" integer,
    "parent_id" integer not null,
    "path" character varying not null,
    "pages_id" integer,
    "posts_id" integer,
    "categories_id" integer,
    "users_id" integer,
    "media_id" integer,
    "redirects_id" integer,
    "forms_id" integer,
    "form_submissions_id" integer
);


create table "public"."payload_migrations" (
    "id" integer not null default nextval('payload_migrations_id_seq'::regclass),
    "name" character varying,
    "batch" numeric,
    "updated_at" timestamp(3) with time zone not null default now(),
    "created_at" timestamp(3) with time zone not null default now()
);


create table "public"."payload_preferences" (
    "id" integer not null default nextval('payload_preferences_id_seq'::regclass),
    "key" character varying,
    "value" jsonb,
    "updated_at" timestamp(3) with time zone not null default now(),
    "created_at" timestamp(3) with time zone not null default now()
);


create table "public"."payload_preferences_rels" (
    "id" integer not null default nextval('payload_preferences_rels_id_seq'::regclass),
    "order" integer,
    "parent_id" integer not null,
    "path" character varying not null,
    "users_id" integer
);


create table "public"."posts" (
    "id" integer not null default nextval('posts_id_seq'::regclass),
    "title" character varying,
    "content" jsonb,
    "meta_title" character varying,
    "meta_image_id" integer,
    "meta_description" character varying,
    "published_at" timestamp(3) with time zone,
    "slug" character varying,
    "slug_lock" boolean default true,
    "updated_at" timestamp(3) with time zone not null default now(),
    "created_at" timestamp(3) with time zone not null default now(),
    "_status" enum_posts_status default 'draft'::enum_posts_status
);


create table "public"."posts_populated_authors" (
    "_order" integer not null,
    "_parent_id" integer not null,
    "id" character varying not null,
    "name" character varying
);


create table "public"."posts_rels" (
    "id" integer not null default nextval('posts_rels_id_seq'::regclass),
    "order" integer,
    "parent_id" integer not null,
    "path" character varying not null,
    "posts_id" integer,
    "categories_id" integer,
    "users_id" integer
);


create table "public"."redirects" (
    "id" integer not null default nextval('redirects_id_seq'::regclass),
    "from" character varying not null,
    "to_type" enum_redirects_to_type default 'reference'::enum_redirects_to_type,
    "to_url" character varying,
    "updated_at" timestamp(3) with time zone not null default now(),
    "created_at" timestamp(3) with time zone not null default now()
);


create table "public"."redirects_rels" (
    "id" integer not null default nextval('redirects_rels_id_seq'::regclass),
    "order" integer,
    "parent_id" integer not null,
    "path" character varying not null,
    "pages_id" integer
);


create table "public"."users" (
    "id" integer not null default nextval('users_id_seq'::regclass),
    "name" character varying,
    "updated_at" timestamp(3) with time zone not null default now(),
    "created_at" timestamp(3) with time zone not null default now(),
    "email" character varying not null,
    "reset_password_token" character varying,
    "reset_password_expiration" timestamp(3) with time zone,
    "salt" character varying,
    "hash" character varying,
    "login_attempts" numeric default 0,
    "lock_until" timestamp(3) with time zone
);


alter sequence "public"."_pages_v_blocks_confetti_header_id_seq" owned by "public"."_pages_v_blocks_confetti_header"."id";

alter sequence "public"."_pages_v_blocks_cover_id_seq" owned by "public"."_pages_v_blocks_cover"."id";

alter sequence "public"."_pages_v_blocks_form_block_id_seq" owned by "public"."_pages_v_blocks_form_block"."id";

alter sequence "public"."_pages_v_blocks_github_globe_id_seq" owned by "public"."_pages_v_blocks_github_globe"."id";

alter sequence "public"."_pages_v_blocks_hero_highlight_id_seq" owned by "public"."_pages_v_blocks_hero_highlight"."id";

alter sequence "public"."_pages_v_blocks_image_id_seq" owned by "public"."_pages_v_blocks_image"."id";

alter sequence "public"."_pages_v_blocks_infinite_moving_cards_cards_id_seq" owned by "public"."_pages_v_blocks_infinite_moving_cards_cards"."id";

alter sequence "public"."_pages_v_blocks_infinite_moving_cards_id_seq" owned by "public"."_pages_v_blocks_infinite_moving_cards"."id";

alter sequence "public"."_pages_v_blocks_links_preview_id_seq" owned by "public"."_pages_v_blocks_links_preview"."id";

alter sequence "public"."_pages_v_blocks_links_preview_rows_id_seq" owned by "public"."_pages_v_blocks_links_preview_rows"."id";

alter sequence "public"."_pages_v_blocks_rich_text_id_seq" owned by "public"."_pages_v_blocks_rich_text"."id";

alter sequence "public"."_pages_v_blocks_spotlight_id_seq" owned by "public"."_pages_v_blocks_spotlight"."id";

alter sequence "public"."_pages_v_blocks_text_effect_id_seq" owned by "public"."_pages_v_blocks_text_effect"."id";

alter sequence "public"."_pages_v_blocks_text_image_buttons_id_seq" owned by "public"."_pages_v_blocks_text_image_buttons"."id";

alter sequence "public"."_pages_v_blocks_text_image_id_seq" owned by "public"."_pages_v_blocks_text_image"."id";

alter sequence "public"."_pages_v_blocks_tik_tac_toe_id_seq" owned by "public"."_pages_v_blocks_tik_tac_toe"."id";

alter sequence "public"."_pages_v_id_seq" owned by "public"."_pages_v"."id";

alter sequence "public"."_pages_v_rels_id_seq" owned by "public"."_pages_v_rels"."id";

alter sequence "public"."_posts_v_id_seq" owned by "public"."_posts_v"."id";

alter sequence "public"."_posts_v_rels_id_seq" owned by "public"."_posts_v_rels"."id";

alter sequence "public"."_posts_v_version_populated_authors_id_seq" owned by "public"."_posts_v_version_populated_authors"."id";

alter sequence "public"."categories_id_seq" owned by "public"."categories"."id";

alter sequence "public"."footer_id_seq" owned by "public"."footer"."id";

alter sequence "public"."footer_rels_id_seq" owned by "public"."footer_rels"."id";

alter sequence "public"."form_submissions_id_seq" owned by "public"."form_submissions"."id";

alter sequence "public"."forms_id_seq" owned by "public"."forms"."id";

alter sequence "public"."header_id_seq" owned by "public"."header"."id";

alter sequence "public"."header_rels_id_seq" owned by "public"."header_rels"."id";

alter sequence "public"."media_id_seq" owned by "public"."media"."id";

alter sequence "public"."pages_id_seq" owned by "public"."pages"."id";

alter sequence "public"."pages_rels_id_seq" owned by "public"."pages_rels"."id";

alter sequence "public"."payload_locked_documents_id_seq" owned by "public"."payload_locked_documents"."id";

alter sequence "public"."payload_locked_documents_rels_id_seq" owned by "public"."payload_locked_documents_rels"."id";

alter sequence "public"."payload_migrations_id_seq" owned by "public"."payload_migrations"."id";

alter sequence "public"."payload_preferences_id_seq" owned by "public"."payload_preferences"."id";

alter sequence "public"."payload_preferences_rels_id_seq" owned by "public"."payload_preferences_rels"."id";

alter sequence "public"."posts_id_seq" owned by "public"."posts"."id";

alter sequence "public"."posts_rels_id_seq" owned by "public"."posts_rels"."id";

alter sequence "public"."redirects_id_seq" owned by "public"."redirects"."id";

alter sequence "public"."redirects_rels_id_seq" owned by "public"."redirects_rels"."id";

alter sequence "public"."users_id_seq" owned by "public"."users"."id";

CREATE INDEX _pages_v_autosave_idx ON public._pages_v USING btree (autosave);

CREATE INDEX _pages_v_blocks_confetti_header_order_idx ON public._pages_v_blocks_confetti_header USING btree (_order);

CREATE INDEX _pages_v_blocks_confetti_header_parent_id_idx ON public._pages_v_blocks_confetti_header USING btree (_parent_id);

CREATE INDEX _pages_v_blocks_confetti_header_path_idx ON public._pages_v_blocks_confetti_header USING btree (_path);

CREATE UNIQUE INDEX _pages_v_blocks_confetti_header_pkey ON public._pages_v_blocks_confetti_header USING btree (id);

CREATE INDEX _pages_v_blocks_cover_order_idx ON public._pages_v_blocks_cover USING btree (_order);

CREATE INDEX _pages_v_blocks_cover_parent_id_idx ON public._pages_v_blocks_cover USING btree (_parent_id);

CREATE INDEX _pages_v_blocks_cover_path_idx ON public._pages_v_blocks_cover USING btree (_path);

CREATE UNIQUE INDEX _pages_v_blocks_cover_pkey ON public._pages_v_blocks_cover USING btree (id);

CREATE INDEX _pages_v_blocks_form_block_form_idx ON public._pages_v_blocks_form_block USING btree (form_id);

CREATE INDEX _pages_v_blocks_form_block_order_idx ON public._pages_v_blocks_form_block USING btree (_order);

CREATE INDEX _pages_v_blocks_form_block_parent_id_idx ON public._pages_v_blocks_form_block USING btree (_parent_id);

CREATE INDEX _pages_v_blocks_form_block_path_idx ON public._pages_v_blocks_form_block USING btree (_path);

CREATE UNIQUE INDEX _pages_v_blocks_form_block_pkey ON public._pages_v_blocks_form_block USING btree (id);

CREATE INDEX _pages_v_blocks_github_globe_order_idx ON public._pages_v_blocks_github_globe USING btree (_order);

CREATE INDEX _pages_v_blocks_github_globe_parent_id_idx ON public._pages_v_blocks_github_globe USING btree (_parent_id);

CREATE INDEX _pages_v_blocks_github_globe_path_idx ON public._pages_v_blocks_github_globe USING btree (_path);

CREATE UNIQUE INDEX _pages_v_blocks_github_globe_pkey ON public._pages_v_blocks_github_globe USING btree (id);

CREATE INDEX _pages_v_blocks_hero_highlight_order_idx ON public._pages_v_blocks_hero_highlight USING btree (_order);

CREATE INDEX _pages_v_blocks_hero_highlight_parent_id_idx ON public._pages_v_blocks_hero_highlight USING btree (_parent_id);

CREATE INDEX _pages_v_blocks_hero_highlight_path_idx ON public._pages_v_blocks_hero_highlight USING btree (_path);

CREATE UNIQUE INDEX _pages_v_blocks_hero_highlight_pkey ON public._pages_v_blocks_hero_highlight USING btree (id);

CREATE INDEX _pages_v_blocks_image_image_idx ON public._pages_v_blocks_image USING btree (image_id);

CREATE INDEX _pages_v_blocks_image_order_idx ON public._pages_v_blocks_image USING btree (_order);

CREATE INDEX _pages_v_blocks_image_parent_id_idx ON public._pages_v_blocks_image USING btree (_parent_id);

CREATE INDEX _pages_v_blocks_image_path_idx ON public._pages_v_blocks_image USING btree (_path);

CREATE UNIQUE INDEX _pages_v_blocks_image_pkey ON public._pages_v_blocks_image USING btree (id);

CREATE INDEX _pages_v_blocks_infinite_moving_cards_cards_order_idx ON public._pages_v_blocks_infinite_moving_cards_cards USING btree (_order);

CREATE INDEX _pages_v_blocks_infinite_moving_cards_cards_parent_id_idx ON public._pages_v_blocks_infinite_moving_cards_cards USING btree (_parent_id);

CREATE UNIQUE INDEX _pages_v_blocks_infinite_moving_cards_cards_pkey ON public._pages_v_blocks_infinite_moving_cards_cards USING btree (id);

CREATE INDEX _pages_v_blocks_infinite_moving_cards_order_idx ON public._pages_v_blocks_infinite_moving_cards USING btree (_order);

CREATE INDEX _pages_v_blocks_infinite_moving_cards_parent_id_idx ON public._pages_v_blocks_infinite_moving_cards USING btree (_parent_id);

CREATE INDEX _pages_v_blocks_infinite_moving_cards_path_idx ON public._pages_v_blocks_infinite_moving_cards USING btree (_path);

CREATE UNIQUE INDEX _pages_v_blocks_infinite_moving_cards_pkey ON public._pages_v_blocks_infinite_moving_cards USING btree (id);

CREATE INDEX _pages_v_blocks_links_preview_order_idx ON public._pages_v_blocks_links_preview USING btree (_order);

CREATE INDEX _pages_v_blocks_links_preview_parent_id_idx ON public._pages_v_blocks_links_preview USING btree (_parent_id);

CREATE INDEX _pages_v_blocks_links_preview_path_idx ON public._pages_v_blocks_links_preview USING btree (_path);

CREATE UNIQUE INDEX _pages_v_blocks_links_preview_pkey ON public._pages_v_blocks_links_preview USING btree (id);

CREATE INDEX _pages_v_blocks_links_preview_rows_order_idx ON public._pages_v_blocks_links_preview_rows USING btree (_order);

CREATE INDEX _pages_v_blocks_links_preview_rows_parent_id_idx ON public._pages_v_blocks_links_preview_rows USING btree (_parent_id);

CREATE UNIQUE INDEX _pages_v_blocks_links_preview_rows_pkey ON public._pages_v_blocks_links_preview_rows USING btree (id);

CREATE INDEX _pages_v_blocks_rich_text_order_idx ON public._pages_v_blocks_rich_text USING btree (_order);

CREATE INDEX _pages_v_blocks_rich_text_parent_id_idx ON public._pages_v_blocks_rich_text USING btree (_parent_id);

CREATE INDEX _pages_v_blocks_rich_text_path_idx ON public._pages_v_blocks_rich_text USING btree (_path);

CREATE UNIQUE INDEX _pages_v_blocks_rich_text_pkey ON public._pages_v_blocks_rich_text USING btree (id);

CREATE INDEX _pages_v_blocks_spotlight_order_idx ON public._pages_v_blocks_spotlight USING btree (_order);

CREATE INDEX _pages_v_blocks_spotlight_parent_id_idx ON public._pages_v_blocks_spotlight USING btree (_parent_id);

CREATE INDEX _pages_v_blocks_spotlight_path_idx ON public._pages_v_blocks_spotlight USING btree (_path);

CREATE UNIQUE INDEX _pages_v_blocks_spotlight_pkey ON public._pages_v_blocks_spotlight USING btree (id);

CREATE INDEX _pages_v_blocks_text_effect_order_idx ON public._pages_v_blocks_text_effect USING btree (_order);

CREATE INDEX _pages_v_blocks_text_effect_parent_id_idx ON public._pages_v_blocks_text_effect USING btree (_parent_id);

CREATE INDEX _pages_v_blocks_text_effect_path_idx ON public._pages_v_blocks_text_effect USING btree (_path);

CREATE UNIQUE INDEX _pages_v_blocks_text_effect_pkey ON public._pages_v_blocks_text_effect USING btree (id);

CREATE INDEX _pages_v_blocks_text_image_buttons_order_idx ON public._pages_v_blocks_text_image_buttons USING btree (_order);

CREATE INDEX _pages_v_blocks_text_image_buttons_parent_id_idx ON public._pages_v_blocks_text_image_buttons USING btree (_parent_id);

CREATE UNIQUE INDEX _pages_v_blocks_text_image_buttons_pkey ON public._pages_v_blocks_text_image_buttons USING btree (id);

CREATE INDEX _pages_v_blocks_text_image_image_idx ON public._pages_v_blocks_text_image USING btree (image_id);

CREATE INDEX _pages_v_blocks_text_image_order_idx ON public._pages_v_blocks_text_image USING btree (_order);

CREATE INDEX _pages_v_blocks_text_image_parent_id_idx ON public._pages_v_blocks_text_image USING btree (_parent_id);

CREATE INDEX _pages_v_blocks_text_image_path_idx ON public._pages_v_blocks_text_image USING btree (_path);

CREATE UNIQUE INDEX _pages_v_blocks_text_image_pkey ON public._pages_v_blocks_text_image USING btree (id);

CREATE INDEX _pages_v_blocks_tik_tac_toe_order_idx ON public._pages_v_blocks_tik_tac_toe USING btree (_order);

CREATE INDEX _pages_v_blocks_tik_tac_toe_parent_id_idx ON public._pages_v_blocks_tik_tac_toe USING btree (_parent_id);

CREATE INDEX _pages_v_blocks_tik_tac_toe_path_idx ON public._pages_v_blocks_tik_tac_toe USING btree (_path);

CREATE UNIQUE INDEX _pages_v_blocks_tik_tac_toe_pkey ON public._pages_v_blocks_tik_tac_toe USING btree (id);

CREATE INDEX _pages_v_created_at_idx ON public._pages_v USING btree (created_at);

CREATE INDEX _pages_v_latest_idx ON public._pages_v USING btree (latest);

CREATE INDEX _pages_v_parent_idx ON public._pages_v USING btree (parent_id);

CREATE UNIQUE INDEX _pages_v_pkey ON public._pages_v USING btree (id);

CREATE INDEX _pages_v_rels_order_idx ON public._pages_v_rels USING btree ("order");

CREATE INDEX _pages_v_rels_pages_id_idx ON public._pages_v_rels USING btree (pages_id);

CREATE INDEX _pages_v_rels_parent_idx ON public._pages_v_rels USING btree (parent_id);

CREATE INDEX _pages_v_rels_path_idx ON public._pages_v_rels USING btree (path);

CREATE UNIQUE INDEX _pages_v_rels_pkey ON public._pages_v_rels USING btree (id);

CREATE INDEX _pages_v_updated_at_idx ON public._pages_v USING btree (updated_at);

CREATE INDEX _pages_v_version_meta_version_meta_image_idx ON public._pages_v USING btree (version_meta_image_id);

CREATE INDEX _pages_v_version_version__status_idx ON public._pages_v USING btree (version__status);

CREATE INDEX _pages_v_version_version_created_at_idx ON public._pages_v USING btree (version_created_at);

CREATE INDEX _pages_v_version_version_created_by_idx ON public._pages_v USING btree (version_created_by_id);

CREATE INDEX _pages_v_version_version_slug_idx ON public._pages_v USING btree (version_slug);

CREATE INDEX _pages_v_version_version_updated_at_idx ON public._pages_v USING btree (version_updated_at);

CREATE INDEX _posts_v_autosave_idx ON public._posts_v USING btree (autosave);

CREATE INDEX _posts_v_created_at_idx ON public._posts_v USING btree (created_at);

CREATE INDEX _posts_v_latest_idx ON public._posts_v USING btree (latest);

CREATE INDEX _posts_v_parent_idx ON public._posts_v USING btree (parent_id);

CREATE UNIQUE INDEX _posts_v_pkey ON public._posts_v USING btree (id);

CREATE INDEX _posts_v_rels_categories_id_idx ON public._posts_v_rels USING btree (categories_id);

CREATE INDEX _posts_v_rels_order_idx ON public._posts_v_rels USING btree ("order");

CREATE INDEX _posts_v_rels_parent_idx ON public._posts_v_rels USING btree (parent_id);

CREATE INDEX _posts_v_rels_path_idx ON public._posts_v_rels USING btree (path);

CREATE UNIQUE INDEX _posts_v_rels_pkey ON public._posts_v_rels USING btree (id);

CREATE INDEX _posts_v_rels_posts_id_idx ON public._posts_v_rels USING btree (posts_id);

CREATE INDEX _posts_v_rels_users_id_idx ON public._posts_v_rels USING btree (users_id);

CREATE INDEX _posts_v_updated_at_idx ON public._posts_v USING btree (updated_at);

CREATE INDEX _posts_v_version_meta_version_meta_image_idx ON public._posts_v USING btree (version_meta_image_id);

CREATE INDEX _posts_v_version_populated_authors_order_idx ON public._posts_v_version_populated_authors USING btree (_order);

CREATE INDEX _posts_v_version_populated_authors_parent_id_idx ON public._posts_v_version_populated_authors USING btree (_parent_id);

CREATE UNIQUE INDEX _posts_v_version_populated_authors_pkey ON public._posts_v_version_populated_authors USING btree (id);

CREATE INDEX _posts_v_version_version__status_idx ON public._posts_v USING btree (version__status);

CREATE INDEX _posts_v_version_version_created_at_idx ON public._posts_v USING btree (version_created_at);

CREATE INDEX _posts_v_version_version_slug_idx ON public._posts_v USING btree (version_slug);

CREATE INDEX _posts_v_version_version_updated_at_idx ON public._posts_v USING btree (version_updated_at);

CREATE INDEX categories_created_at_idx ON public.categories USING btree (created_at);

CREATE UNIQUE INDEX categories_pkey ON public.categories USING btree (id);

CREATE INDEX categories_updated_at_idx ON public.categories USING btree (updated_at);

CREATE INDEX footer_links_children_order_idx ON public.footer_links_children USING btree (_order);

CREATE INDEX footer_links_children_parent_id_idx ON public.footer_links_children USING btree (_parent_id);

CREATE UNIQUE INDEX footer_links_children_pkey ON public.footer_links_children USING btree (id);

CREATE INDEX footer_links_order_idx ON public.footer_links USING btree (_order);

CREATE INDEX footer_links_parent_id_idx ON public.footer_links USING btree (_parent_id);

CREATE UNIQUE INDEX footer_links_pkey ON public.footer_links USING btree (id);

CREATE INDEX footer_logo_idx ON public.footer USING btree (logo_id);

CREATE UNIQUE INDEX footer_pkey ON public.footer USING btree (id);

CREATE INDEX footer_rels_order_idx ON public.footer_rels USING btree ("order");

CREATE INDEX footer_rels_pages_id_idx ON public.footer_rels USING btree (pages_id);

CREATE INDEX footer_rels_parent_idx ON public.footer_rels USING btree (parent_id);

CREATE INDEX footer_rels_path_idx ON public.footer_rels USING btree (path);

CREATE UNIQUE INDEX footer_rels_pkey ON public.footer_rels USING btree (id);

CREATE INDEX form_submissions_created_at_idx ON public.form_submissions USING btree (created_at);

CREATE INDEX form_submissions_form_idx ON public.form_submissions USING btree (form_id);

CREATE UNIQUE INDEX form_submissions_pkey ON public.form_submissions USING btree (id);

CREATE INDEX form_submissions_submission_data_order_idx ON public.form_submissions_submission_data USING btree (_order);

CREATE INDEX form_submissions_submission_data_parent_id_idx ON public.form_submissions_submission_data USING btree (_parent_id);

CREATE UNIQUE INDEX form_submissions_submission_data_pkey ON public.form_submissions_submission_data USING btree (id);

CREATE INDEX form_submissions_updated_at_idx ON public.form_submissions USING btree (updated_at);

CREATE INDEX forms_blocks_checkbox_order_idx ON public.forms_blocks_checkbox USING btree (_order);

CREATE INDEX forms_blocks_checkbox_parent_id_idx ON public.forms_blocks_checkbox USING btree (_parent_id);

CREATE INDEX forms_blocks_checkbox_path_idx ON public.forms_blocks_checkbox USING btree (_path);

CREATE UNIQUE INDEX forms_blocks_checkbox_pkey ON public.forms_blocks_checkbox USING btree (id);

CREATE INDEX forms_blocks_country_order_idx ON public.forms_blocks_country USING btree (_order);

CREATE INDEX forms_blocks_country_parent_id_idx ON public.forms_blocks_country USING btree (_parent_id);

CREATE INDEX forms_blocks_country_path_idx ON public.forms_blocks_country USING btree (_path);

CREATE UNIQUE INDEX forms_blocks_country_pkey ON public.forms_blocks_country USING btree (id);

CREATE INDEX forms_blocks_email_order_idx ON public.forms_blocks_email USING btree (_order);

CREATE INDEX forms_blocks_email_parent_id_idx ON public.forms_blocks_email USING btree (_parent_id);

CREATE INDEX forms_blocks_email_path_idx ON public.forms_blocks_email USING btree (_path);

CREATE UNIQUE INDEX forms_blocks_email_pkey ON public.forms_blocks_email USING btree (id);

CREATE INDEX forms_blocks_message_order_idx ON public.forms_blocks_message USING btree (_order);

CREATE INDEX forms_blocks_message_parent_id_idx ON public.forms_blocks_message USING btree (_parent_id);

CREATE INDEX forms_blocks_message_path_idx ON public.forms_blocks_message USING btree (_path);

CREATE UNIQUE INDEX forms_blocks_message_pkey ON public.forms_blocks_message USING btree (id);

CREATE INDEX forms_blocks_number_order_idx ON public.forms_blocks_number USING btree (_order);

CREATE INDEX forms_blocks_number_parent_id_idx ON public.forms_blocks_number USING btree (_parent_id);

CREATE INDEX forms_blocks_number_path_idx ON public.forms_blocks_number USING btree (_path);

CREATE UNIQUE INDEX forms_blocks_number_pkey ON public.forms_blocks_number USING btree (id);

CREATE INDEX forms_blocks_select_options_order_idx ON public.forms_blocks_select_options USING btree (_order);

CREATE INDEX forms_blocks_select_options_parent_id_idx ON public.forms_blocks_select_options USING btree (_parent_id);

CREATE UNIQUE INDEX forms_blocks_select_options_pkey ON public.forms_blocks_select_options USING btree (id);

CREATE INDEX forms_blocks_select_order_idx ON public.forms_blocks_select USING btree (_order);

CREATE INDEX forms_blocks_select_parent_id_idx ON public.forms_blocks_select USING btree (_parent_id);

CREATE INDEX forms_blocks_select_path_idx ON public.forms_blocks_select USING btree (_path);

CREATE UNIQUE INDEX forms_blocks_select_pkey ON public.forms_blocks_select USING btree (id);

CREATE INDEX forms_blocks_state_order_idx ON public.forms_blocks_state USING btree (_order);

CREATE INDEX forms_blocks_state_parent_id_idx ON public.forms_blocks_state USING btree (_parent_id);

CREATE INDEX forms_blocks_state_path_idx ON public.forms_blocks_state USING btree (_path);

CREATE UNIQUE INDEX forms_blocks_state_pkey ON public.forms_blocks_state USING btree (id);

CREATE INDEX forms_blocks_text_order_idx ON public.forms_blocks_text USING btree (_order);

CREATE INDEX forms_blocks_text_parent_id_idx ON public.forms_blocks_text USING btree (_parent_id);

CREATE INDEX forms_blocks_text_path_idx ON public.forms_blocks_text USING btree (_path);

CREATE UNIQUE INDEX forms_blocks_text_pkey ON public.forms_blocks_text USING btree (id);

CREATE INDEX forms_blocks_textarea_order_idx ON public.forms_blocks_textarea USING btree (_order);

CREATE INDEX forms_blocks_textarea_parent_id_idx ON public.forms_blocks_textarea USING btree (_parent_id);

CREATE INDEX forms_blocks_textarea_path_idx ON public.forms_blocks_textarea USING btree (_path);

CREATE UNIQUE INDEX forms_blocks_textarea_pkey ON public.forms_blocks_textarea USING btree (id);

CREATE INDEX forms_created_at_idx ON public.forms USING btree (created_at);

CREATE INDEX forms_emails_order_idx ON public.forms_emails USING btree (_order);

CREATE INDEX forms_emails_parent_id_idx ON public.forms_emails USING btree (_parent_id);

CREATE UNIQUE INDEX forms_emails_pkey ON public.forms_emails USING btree (id);

CREATE UNIQUE INDEX forms_pkey ON public.forms USING btree (id);

CREATE INDEX forms_updated_at_idx ON public.forms USING btree (updated_at);

CREATE INDEX header_links_children_order_idx ON public.header_links_children USING btree (_order);

CREATE INDEX header_links_children_parent_id_idx ON public.header_links_children USING btree (_parent_id);

CREATE UNIQUE INDEX header_links_children_pkey ON public.header_links_children USING btree (id);

CREATE INDEX header_links_order_idx ON public.header_links USING btree (_order);

CREATE INDEX header_links_parent_id_idx ON public.header_links USING btree (_parent_id);

CREATE UNIQUE INDEX header_links_pkey ON public.header_links USING btree (id);

CREATE INDEX header_logo_idx ON public.header USING btree (logo_id);

CREATE UNIQUE INDEX header_pkey ON public.header USING btree (id);

CREATE INDEX header_rels_order_idx ON public.header_rels USING btree ("order");

CREATE INDEX header_rels_pages_id_idx ON public.header_rels USING btree (pages_id);

CREATE INDEX header_rels_parent_idx ON public.header_rels USING btree (parent_id);

CREATE INDEX header_rels_path_idx ON public.header_rels USING btree (path);

CREATE UNIQUE INDEX header_rels_pkey ON public.header_rels USING btree (id);

CREATE INDEX media_created_at_idx ON public.media USING btree (created_at);

CREATE UNIQUE INDEX media_filename_idx ON public.media USING btree (filename);

CREATE UNIQUE INDEX media_pkey ON public.media USING btree (id);

CREATE INDEX media_updated_at_idx ON public.media USING btree (updated_at);

CREATE INDEX pages__status_idx ON public.pages USING btree (_status);

CREATE INDEX pages_blocks_confetti_header_order_idx ON public.pages_blocks_confetti_header USING btree (_order);

CREATE INDEX pages_blocks_confetti_header_parent_id_idx ON public.pages_blocks_confetti_header USING btree (_parent_id);

CREATE INDEX pages_blocks_confetti_header_path_idx ON public.pages_blocks_confetti_header USING btree (_path);

CREATE UNIQUE INDEX pages_blocks_confetti_header_pkey ON public.pages_blocks_confetti_header USING btree (id);

CREATE INDEX pages_blocks_cover_order_idx ON public.pages_blocks_cover USING btree (_order);

CREATE INDEX pages_blocks_cover_parent_id_idx ON public.pages_blocks_cover USING btree (_parent_id);

CREATE INDEX pages_blocks_cover_path_idx ON public.pages_blocks_cover USING btree (_path);

CREATE UNIQUE INDEX pages_blocks_cover_pkey ON public.pages_blocks_cover USING btree (id);

CREATE INDEX pages_blocks_form_block_form_idx ON public.pages_blocks_form_block USING btree (form_id);

CREATE INDEX pages_blocks_form_block_order_idx ON public.pages_blocks_form_block USING btree (_order);

CREATE INDEX pages_blocks_form_block_parent_id_idx ON public.pages_blocks_form_block USING btree (_parent_id);

CREATE INDEX pages_blocks_form_block_path_idx ON public.pages_blocks_form_block USING btree (_path);

CREATE UNIQUE INDEX pages_blocks_form_block_pkey ON public.pages_blocks_form_block USING btree (id);

CREATE INDEX pages_blocks_github_globe_order_idx ON public.pages_blocks_github_globe USING btree (_order);

CREATE INDEX pages_blocks_github_globe_parent_id_idx ON public.pages_blocks_github_globe USING btree (_parent_id);

CREATE INDEX pages_blocks_github_globe_path_idx ON public.pages_blocks_github_globe USING btree (_path);

CREATE UNIQUE INDEX pages_blocks_github_globe_pkey ON public.pages_blocks_github_globe USING btree (id);

CREATE INDEX pages_blocks_hero_highlight_order_idx ON public.pages_blocks_hero_highlight USING btree (_order);

CREATE INDEX pages_blocks_hero_highlight_parent_id_idx ON public.pages_blocks_hero_highlight USING btree (_parent_id);

CREATE INDEX pages_blocks_hero_highlight_path_idx ON public.pages_blocks_hero_highlight USING btree (_path);

CREATE UNIQUE INDEX pages_blocks_hero_highlight_pkey ON public.pages_blocks_hero_highlight USING btree (id);

CREATE INDEX pages_blocks_image_image_idx ON public.pages_blocks_image USING btree (image_id);

CREATE INDEX pages_blocks_image_order_idx ON public.pages_blocks_image USING btree (_order);

CREATE INDEX pages_blocks_image_parent_id_idx ON public.pages_blocks_image USING btree (_parent_id);

CREATE INDEX pages_blocks_image_path_idx ON public.pages_blocks_image USING btree (_path);

CREATE UNIQUE INDEX pages_blocks_image_pkey ON public.pages_blocks_image USING btree (id);

CREATE INDEX pages_blocks_infinite_moving_cards_cards_order_idx ON public.pages_blocks_infinite_moving_cards_cards USING btree (_order);

CREATE INDEX pages_blocks_infinite_moving_cards_cards_parent_id_idx ON public.pages_blocks_infinite_moving_cards_cards USING btree (_parent_id);

CREATE UNIQUE INDEX pages_blocks_infinite_moving_cards_cards_pkey ON public.pages_blocks_infinite_moving_cards_cards USING btree (id);

CREATE INDEX pages_blocks_infinite_moving_cards_order_idx ON public.pages_blocks_infinite_moving_cards USING btree (_order);

CREATE INDEX pages_blocks_infinite_moving_cards_parent_id_idx ON public.pages_blocks_infinite_moving_cards USING btree (_parent_id);

CREATE INDEX pages_blocks_infinite_moving_cards_path_idx ON public.pages_blocks_infinite_moving_cards USING btree (_path);

CREATE UNIQUE INDEX pages_blocks_infinite_moving_cards_pkey ON public.pages_blocks_infinite_moving_cards USING btree (id);

CREATE INDEX pages_blocks_links_preview_order_idx ON public.pages_blocks_links_preview USING btree (_order);

CREATE INDEX pages_blocks_links_preview_parent_id_idx ON public.pages_blocks_links_preview USING btree (_parent_id);

CREATE INDEX pages_blocks_links_preview_path_idx ON public.pages_blocks_links_preview USING btree (_path);

CREATE UNIQUE INDEX pages_blocks_links_preview_pkey ON public.pages_blocks_links_preview USING btree (id);

CREATE INDEX pages_blocks_links_preview_rows_order_idx ON public.pages_blocks_links_preview_rows USING btree (_order);

CREATE INDEX pages_blocks_links_preview_rows_parent_id_idx ON public.pages_blocks_links_preview_rows USING btree (_parent_id);

CREATE UNIQUE INDEX pages_blocks_links_preview_rows_pkey ON public.pages_blocks_links_preview_rows USING btree (id);

CREATE INDEX pages_blocks_rich_text_order_idx ON public.pages_blocks_rich_text USING btree (_order);

CREATE INDEX pages_blocks_rich_text_parent_id_idx ON public.pages_blocks_rich_text USING btree (_parent_id);

CREATE INDEX pages_blocks_rich_text_path_idx ON public.pages_blocks_rich_text USING btree (_path);

CREATE UNIQUE INDEX pages_blocks_rich_text_pkey ON public.pages_blocks_rich_text USING btree (id);

CREATE INDEX pages_blocks_spotlight_order_idx ON public.pages_blocks_spotlight USING btree (_order);

CREATE INDEX pages_blocks_spotlight_parent_id_idx ON public.pages_blocks_spotlight USING btree (_parent_id);

CREATE INDEX pages_blocks_spotlight_path_idx ON public.pages_blocks_spotlight USING btree (_path);

CREATE UNIQUE INDEX pages_blocks_spotlight_pkey ON public.pages_blocks_spotlight USING btree (id);

CREATE INDEX pages_blocks_text_effect_order_idx ON public.pages_blocks_text_effect USING btree (_order);

CREATE INDEX pages_blocks_text_effect_parent_id_idx ON public.pages_blocks_text_effect USING btree (_parent_id);

CREATE INDEX pages_blocks_text_effect_path_idx ON public.pages_blocks_text_effect USING btree (_path);

CREATE UNIQUE INDEX pages_blocks_text_effect_pkey ON public.pages_blocks_text_effect USING btree (id);

CREATE INDEX pages_blocks_text_image_buttons_order_idx ON public.pages_blocks_text_image_buttons USING btree (_order);

CREATE INDEX pages_blocks_text_image_buttons_parent_id_idx ON public.pages_blocks_text_image_buttons USING btree (_parent_id);

CREATE UNIQUE INDEX pages_blocks_text_image_buttons_pkey ON public.pages_blocks_text_image_buttons USING btree (id);

CREATE INDEX pages_blocks_text_image_image_idx ON public.pages_blocks_text_image USING btree (image_id);

CREATE INDEX pages_blocks_text_image_order_idx ON public.pages_blocks_text_image USING btree (_order);

CREATE INDEX pages_blocks_text_image_parent_id_idx ON public.pages_blocks_text_image USING btree (_parent_id);

CREATE INDEX pages_blocks_text_image_path_idx ON public.pages_blocks_text_image USING btree (_path);

CREATE UNIQUE INDEX pages_blocks_text_image_pkey ON public.pages_blocks_text_image USING btree (id);

CREATE INDEX pages_blocks_tik_tac_toe_order_idx ON public.pages_blocks_tik_tac_toe USING btree (_order);

CREATE INDEX pages_blocks_tik_tac_toe_parent_id_idx ON public.pages_blocks_tik_tac_toe USING btree (_parent_id);

CREATE INDEX pages_blocks_tik_tac_toe_path_idx ON public.pages_blocks_tik_tac_toe USING btree (_path);

CREATE UNIQUE INDEX pages_blocks_tik_tac_toe_pkey ON public.pages_blocks_tik_tac_toe USING btree (id);

CREATE INDEX pages_created_at_idx ON public.pages USING btree (created_at);

CREATE INDEX pages_created_by_idx ON public.pages USING btree (created_by_id);

CREATE INDEX pages_meta_meta_image_idx ON public.pages USING btree (meta_image_id);

CREATE UNIQUE INDEX pages_pkey ON public.pages USING btree (id);

CREATE INDEX pages_rels_order_idx ON public.pages_rels USING btree ("order");

CREATE INDEX pages_rels_pages_id_idx ON public.pages_rels USING btree (pages_id);

CREATE INDEX pages_rels_parent_idx ON public.pages_rels USING btree (parent_id);

CREATE INDEX pages_rels_path_idx ON public.pages_rels USING btree (path);

CREATE UNIQUE INDEX pages_rels_pkey ON public.pages_rels USING btree (id);

CREATE INDEX pages_slug_idx ON public.pages USING btree (slug);

CREATE INDEX pages_updated_at_idx ON public.pages USING btree (updated_at);

CREATE INDEX payload_locked_documents_created_at_idx ON public.payload_locked_documents USING btree (created_at);

CREATE INDEX payload_locked_documents_global_slug_idx ON public.payload_locked_documents USING btree (global_slug);

CREATE UNIQUE INDEX payload_locked_documents_pkey ON public.payload_locked_documents USING btree (id);

CREATE INDEX payload_locked_documents_rels_categories_id_idx ON public.payload_locked_documents_rels USING btree (categories_id);

CREATE INDEX payload_locked_documents_rels_form_submissions_id_idx ON public.payload_locked_documents_rels USING btree (form_submissions_id);

CREATE INDEX payload_locked_documents_rels_forms_id_idx ON public.payload_locked_documents_rels USING btree (forms_id);

CREATE INDEX payload_locked_documents_rels_media_id_idx ON public.payload_locked_documents_rels USING btree (media_id);

CREATE INDEX payload_locked_documents_rels_order_idx ON public.payload_locked_documents_rels USING btree ("order");

CREATE INDEX payload_locked_documents_rels_pages_id_idx ON public.payload_locked_documents_rels USING btree (pages_id);

CREATE INDEX payload_locked_documents_rels_parent_idx ON public.payload_locked_documents_rels USING btree (parent_id);

CREATE INDEX payload_locked_documents_rels_path_idx ON public.payload_locked_documents_rels USING btree (path);

CREATE UNIQUE INDEX payload_locked_documents_rels_pkey ON public.payload_locked_documents_rels USING btree (id);

CREATE INDEX payload_locked_documents_rels_posts_id_idx ON public.payload_locked_documents_rels USING btree (posts_id);

CREATE INDEX payload_locked_documents_rels_redirects_id_idx ON public.payload_locked_documents_rels USING btree (redirects_id);

CREATE INDEX payload_locked_documents_rels_users_id_idx ON public.payload_locked_documents_rels USING btree (users_id);

CREATE INDEX payload_locked_documents_updated_at_idx ON public.payload_locked_documents USING btree (updated_at);

CREATE INDEX payload_migrations_created_at_idx ON public.payload_migrations USING btree (created_at);

CREATE UNIQUE INDEX payload_migrations_pkey ON public.payload_migrations USING btree (id);

CREATE INDEX payload_migrations_updated_at_idx ON public.payload_migrations USING btree (updated_at);

CREATE INDEX payload_preferences_created_at_idx ON public.payload_preferences USING btree (created_at);

CREATE INDEX payload_preferences_key_idx ON public.payload_preferences USING btree (key);

CREATE UNIQUE INDEX payload_preferences_pkey ON public.payload_preferences USING btree (id);

CREATE INDEX payload_preferences_rels_order_idx ON public.payload_preferences_rels USING btree ("order");

CREATE INDEX payload_preferences_rels_parent_idx ON public.payload_preferences_rels USING btree (parent_id);

CREATE INDEX payload_preferences_rels_path_idx ON public.payload_preferences_rels USING btree (path);

CREATE UNIQUE INDEX payload_preferences_rels_pkey ON public.payload_preferences_rels USING btree (id);

CREATE INDEX payload_preferences_rels_users_id_idx ON public.payload_preferences_rels USING btree (users_id);

CREATE INDEX payload_preferences_updated_at_idx ON public.payload_preferences USING btree (updated_at);

CREATE INDEX posts__status_idx ON public.posts USING btree (_status);

CREATE INDEX posts_created_at_idx ON public.posts USING btree (created_at);

CREATE INDEX posts_meta_meta_image_idx ON public.posts USING btree (meta_image_id);

CREATE UNIQUE INDEX posts_pkey ON public.posts USING btree (id);

CREATE INDEX posts_populated_authors_order_idx ON public.posts_populated_authors USING btree (_order);

CREATE INDEX posts_populated_authors_parent_id_idx ON public.posts_populated_authors USING btree (_parent_id);

CREATE UNIQUE INDEX posts_populated_authors_pkey ON public.posts_populated_authors USING btree (id);

CREATE INDEX posts_rels_categories_id_idx ON public.posts_rels USING btree (categories_id);

CREATE INDEX posts_rels_order_idx ON public.posts_rels USING btree ("order");

CREATE INDEX posts_rels_parent_idx ON public.posts_rels USING btree (parent_id);

CREATE INDEX posts_rels_path_idx ON public.posts_rels USING btree (path);

CREATE UNIQUE INDEX posts_rels_pkey ON public.posts_rels USING btree (id);

CREATE INDEX posts_rels_posts_id_idx ON public.posts_rels USING btree (posts_id);

CREATE INDEX posts_rels_users_id_idx ON public.posts_rels USING btree (users_id);

CREATE INDEX posts_slug_idx ON public.posts USING btree (slug);

CREATE INDEX posts_updated_at_idx ON public.posts USING btree (updated_at);

CREATE INDEX redirects_created_at_idx ON public.redirects USING btree (created_at);

CREATE INDEX redirects_from_idx ON public.redirects USING btree ("from");

CREATE UNIQUE INDEX redirects_pkey ON public.redirects USING btree (id);

CREATE INDEX redirects_rels_order_idx ON public.redirects_rels USING btree ("order");

CREATE INDEX redirects_rels_pages_id_idx ON public.redirects_rels USING btree (pages_id);

CREATE INDEX redirects_rels_parent_idx ON public.redirects_rels USING btree (parent_id);

CREATE INDEX redirects_rels_path_idx ON public.redirects_rels USING btree (path);

CREATE UNIQUE INDEX redirects_rels_pkey ON public.redirects_rels USING btree (id);

CREATE INDEX redirects_updated_at_idx ON public.redirects USING btree (updated_at);

CREATE INDEX users_created_at_idx ON public.users USING btree (created_at);

CREATE UNIQUE INDEX users_email_idx ON public.users USING btree (email);

CREATE UNIQUE INDEX users_pkey ON public.users USING btree (id);

CREATE INDEX users_updated_at_idx ON public.users USING btree (updated_at);

alter table "public"."_pages_v" add constraint "_pages_v_pkey" PRIMARY KEY using index "_pages_v_pkey";

alter table "public"."_pages_v_blocks_confetti_header" add constraint "_pages_v_blocks_confetti_header_pkey" PRIMARY KEY using index "_pages_v_blocks_confetti_header_pkey";

alter table "public"."_pages_v_blocks_cover" add constraint "_pages_v_blocks_cover_pkey" PRIMARY KEY using index "_pages_v_blocks_cover_pkey";

alter table "public"."_pages_v_blocks_form_block" add constraint "_pages_v_blocks_form_block_pkey" PRIMARY KEY using index "_pages_v_blocks_form_block_pkey";

alter table "public"."_pages_v_blocks_github_globe" add constraint "_pages_v_blocks_github_globe_pkey" PRIMARY KEY using index "_pages_v_blocks_github_globe_pkey";

alter table "public"."_pages_v_blocks_hero_highlight" add constraint "_pages_v_blocks_hero_highlight_pkey" PRIMARY KEY using index "_pages_v_blocks_hero_highlight_pkey";

alter table "public"."_pages_v_blocks_image" add constraint "_pages_v_blocks_image_pkey" PRIMARY KEY using index "_pages_v_blocks_image_pkey";

alter table "public"."_pages_v_blocks_infinite_moving_cards" add constraint "_pages_v_blocks_infinite_moving_cards_pkey" PRIMARY KEY using index "_pages_v_blocks_infinite_moving_cards_pkey";

alter table "public"."_pages_v_blocks_infinite_moving_cards_cards" add constraint "_pages_v_blocks_infinite_moving_cards_cards_pkey" PRIMARY KEY using index "_pages_v_blocks_infinite_moving_cards_cards_pkey";

alter table "public"."_pages_v_blocks_links_preview" add constraint "_pages_v_blocks_links_preview_pkey" PRIMARY KEY using index "_pages_v_blocks_links_preview_pkey";

alter table "public"."_pages_v_blocks_links_preview_rows" add constraint "_pages_v_blocks_links_preview_rows_pkey" PRIMARY KEY using index "_pages_v_blocks_links_preview_rows_pkey";

alter table "public"."_pages_v_blocks_rich_text" add constraint "_pages_v_blocks_rich_text_pkey" PRIMARY KEY using index "_pages_v_blocks_rich_text_pkey";

alter table "public"."_pages_v_blocks_spotlight" add constraint "_pages_v_blocks_spotlight_pkey" PRIMARY KEY using index "_pages_v_blocks_spotlight_pkey";

alter table "public"."_pages_v_blocks_text_effect" add constraint "_pages_v_blocks_text_effect_pkey" PRIMARY KEY using index "_pages_v_blocks_text_effect_pkey";

alter table "public"."_pages_v_blocks_text_image" add constraint "_pages_v_blocks_text_image_pkey" PRIMARY KEY using index "_pages_v_blocks_text_image_pkey";

alter table "public"."_pages_v_blocks_text_image_buttons" add constraint "_pages_v_blocks_text_image_buttons_pkey" PRIMARY KEY using index "_pages_v_blocks_text_image_buttons_pkey";

alter table "public"."_pages_v_blocks_tik_tac_toe" add constraint "_pages_v_blocks_tik_tac_toe_pkey" PRIMARY KEY using index "_pages_v_blocks_tik_tac_toe_pkey";

alter table "public"."_pages_v_rels" add constraint "_pages_v_rels_pkey" PRIMARY KEY using index "_pages_v_rels_pkey";

alter table "public"."_posts_v" add constraint "_posts_v_pkey" PRIMARY KEY using index "_posts_v_pkey";

alter table "public"."_posts_v_rels" add constraint "_posts_v_rels_pkey" PRIMARY KEY using index "_posts_v_rels_pkey";

alter table "public"."_posts_v_version_populated_authors" add constraint "_posts_v_version_populated_authors_pkey" PRIMARY KEY using index "_posts_v_version_populated_authors_pkey";

alter table "public"."categories" add constraint "categories_pkey" PRIMARY KEY using index "categories_pkey";

alter table "public"."footer" add constraint "footer_pkey" PRIMARY KEY using index "footer_pkey";

alter table "public"."footer_links" add constraint "footer_links_pkey" PRIMARY KEY using index "footer_links_pkey";

alter table "public"."footer_links_children" add constraint "footer_links_children_pkey" PRIMARY KEY using index "footer_links_children_pkey";

alter table "public"."footer_rels" add constraint "footer_rels_pkey" PRIMARY KEY using index "footer_rels_pkey";

alter table "public"."form_submissions" add constraint "form_submissions_pkey" PRIMARY KEY using index "form_submissions_pkey";

alter table "public"."form_submissions_submission_data" add constraint "form_submissions_submission_data_pkey" PRIMARY KEY using index "form_submissions_submission_data_pkey";

alter table "public"."forms" add constraint "forms_pkey" PRIMARY KEY using index "forms_pkey";

alter table "public"."forms_blocks_checkbox" add constraint "forms_blocks_checkbox_pkey" PRIMARY KEY using index "forms_blocks_checkbox_pkey";

alter table "public"."forms_blocks_country" add constraint "forms_blocks_country_pkey" PRIMARY KEY using index "forms_blocks_country_pkey";

alter table "public"."forms_blocks_email" add constraint "forms_blocks_email_pkey" PRIMARY KEY using index "forms_blocks_email_pkey";

alter table "public"."forms_blocks_message" add constraint "forms_blocks_message_pkey" PRIMARY KEY using index "forms_blocks_message_pkey";

alter table "public"."forms_blocks_number" add constraint "forms_blocks_number_pkey" PRIMARY KEY using index "forms_blocks_number_pkey";

alter table "public"."forms_blocks_select" add constraint "forms_blocks_select_pkey" PRIMARY KEY using index "forms_blocks_select_pkey";

alter table "public"."forms_blocks_select_options" add constraint "forms_blocks_select_options_pkey" PRIMARY KEY using index "forms_blocks_select_options_pkey";

alter table "public"."forms_blocks_state" add constraint "forms_blocks_state_pkey" PRIMARY KEY using index "forms_blocks_state_pkey";

alter table "public"."forms_blocks_text" add constraint "forms_blocks_text_pkey" PRIMARY KEY using index "forms_blocks_text_pkey";

alter table "public"."forms_blocks_textarea" add constraint "forms_blocks_textarea_pkey" PRIMARY KEY using index "forms_blocks_textarea_pkey";

alter table "public"."forms_emails" add constraint "forms_emails_pkey" PRIMARY KEY using index "forms_emails_pkey";

alter table "public"."header" add constraint "header_pkey" PRIMARY KEY using index "header_pkey";

alter table "public"."header_links" add constraint "header_links_pkey" PRIMARY KEY using index "header_links_pkey";

alter table "public"."header_links_children" add constraint "header_links_children_pkey" PRIMARY KEY using index "header_links_children_pkey";

alter table "public"."header_rels" add constraint "header_rels_pkey" PRIMARY KEY using index "header_rels_pkey";

alter table "public"."media" add constraint "media_pkey" PRIMARY KEY using index "media_pkey";

alter table "public"."pages" add constraint "pages_pkey" PRIMARY KEY using index "pages_pkey";

alter table "public"."pages_blocks_confetti_header" add constraint "pages_blocks_confetti_header_pkey" PRIMARY KEY using index "pages_blocks_confetti_header_pkey";

alter table "public"."pages_blocks_cover" add constraint "pages_blocks_cover_pkey" PRIMARY KEY using index "pages_blocks_cover_pkey";

alter table "public"."pages_blocks_form_block" add constraint "pages_blocks_form_block_pkey" PRIMARY KEY using index "pages_blocks_form_block_pkey";

alter table "public"."pages_blocks_github_globe" add constraint "pages_blocks_github_globe_pkey" PRIMARY KEY using index "pages_blocks_github_globe_pkey";

alter table "public"."pages_blocks_hero_highlight" add constraint "pages_blocks_hero_highlight_pkey" PRIMARY KEY using index "pages_blocks_hero_highlight_pkey";

alter table "public"."pages_blocks_image" add constraint "pages_blocks_image_pkey" PRIMARY KEY using index "pages_blocks_image_pkey";

alter table "public"."pages_blocks_infinite_moving_cards" add constraint "pages_blocks_infinite_moving_cards_pkey" PRIMARY KEY using index "pages_blocks_infinite_moving_cards_pkey";

alter table "public"."pages_blocks_infinite_moving_cards_cards" add constraint "pages_blocks_infinite_moving_cards_cards_pkey" PRIMARY KEY using index "pages_blocks_infinite_moving_cards_cards_pkey";

alter table "public"."pages_blocks_links_preview" add constraint "pages_blocks_links_preview_pkey" PRIMARY KEY using index "pages_blocks_links_preview_pkey";

alter table "public"."pages_blocks_links_preview_rows" add constraint "pages_blocks_links_preview_rows_pkey" PRIMARY KEY using index "pages_blocks_links_preview_rows_pkey";

alter table "public"."pages_blocks_rich_text" add constraint "pages_blocks_rich_text_pkey" PRIMARY KEY using index "pages_blocks_rich_text_pkey";

alter table "public"."pages_blocks_spotlight" add constraint "pages_blocks_spotlight_pkey" PRIMARY KEY using index "pages_blocks_spotlight_pkey";

alter table "public"."pages_blocks_text_effect" add constraint "pages_blocks_text_effect_pkey" PRIMARY KEY using index "pages_blocks_text_effect_pkey";

alter table "public"."pages_blocks_text_image" add constraint "pages_blocks_text_image_pkey" PRIMARY KEY using index "pages_blocks_text_image_pkey";

alter table "public"."pages_blocks_text_image_buttons" add constraint "pages_blocks_text_image_buttons_pkey" PRIMARY KEY using index "pages_blocks_text_image_buttons_pkey";

alter table "public"."pages_blocks_tik_tac_toe" add constraint "pages_blocks_tik_tac_toe_pkey" PRIMARY KEY using index "pages_blocks_tik_tac_toe_pkey";

alter table "public"."pages_rels" add constraint "pages_rels_pkey" PRIMARY KEY using index "pages_rels_pkey";

alter table "public"."payload_locked_documents" add constraint "payload_locked_documents_pkey" PRIMARY KEY using index "payload_locked_documents_pkey";

alter table "public"."payload_locked_documents_rels" add constraint "payload_locked_documents_rels_pkey" PRIMARY KEY using index "payload_locked_documents_rels_pkey";

alter table "public"."payload_migrations" add constraint "payload_migrations_pkey" PRIMARY KEY using index "payload_migrations_pkey";

alter table "public"."payload_preferences" add constraint "payload_preferences_pkey" PRIMARY KEY using index "payload_preferences_pkey";

alter table "public"."payload_preferences_rels" add constraint "payload_preferences_rels_pkey" PRIMARY KEY using index "payload_preferences_rels_pkey";

alter table "public"."posts" add constraint "posts_pkey" PRIMARY KEY using index "posts_pkey";

alter table "public"."posts_populated_authors" add constraint "posts_populated_authors_pkey" PRIMARY KEY using index "posts_populated_authors_pkey";

alter table "public"."posts_rels" add constraint "posts_rels_pkey" PRIMARY KEY using index "posts_rels_pkey";

alter table "public"."redirects" add constraint "redirects_pkey" PRIMARY KEY using index "redirects_pkey";

alter table "public"."redirects_rels" add constraint "redirects_rels_pkey" PRIMARY KEY using index "redirects_rels_pkey";

alter table "public"."users" add constraint "users_pkey" PRIMARY KEY using index "users_pkey";

alter table "public"."_pages_v" add constraint "_pages_v_parent_id_pages_id_fk" FOREIGN KEY (parent_id) REFERENCES pages(id) ON DELETE SET NULL not valid;

alter table "public"."_pages_v" validate constraint "_pages_v_parent_id_pages_id_fk";

alter table "public"."_pages_v" add constraint "_pages_v_version_created_by_id_users_id_fk" FOREIGN KEY (version_created_by_id) REFERENCES users(id) ON DELETE SET NULL not valid;

alter table "public"."_pages_v" validate constraint "_pages_v_version_created_by_id_users_id_fk";

alter table "public"."_pages_v" add constraint "_pages_v_version_meta_image_id_media_id_fk" FOREIGN KEY (version_meta_image_id) REFERENCES media(id) ON DELETE SET NULL not valid;

alter table "public"."_pages_v" validate constraint "_pages_v_version_meta_image_id_media_id_fk";

alter table "public"."_pages_v_blocks_confetti_header" add constraint "_pages_v_blocks_confetti_header_parent_id_fk" FOREIGN KEY (_parent_id) REFERENCES _pages_v(id) ON DELETE CASCADE not valid;

alter table "public"."_pages_v_blocks_confetti_header" validate constraint "_pages_v_blocks_confetti_header_parent_id_fk";

alter table "public"."_pages_v_blocks_cover" add constraint "_pages_v_blocks_cover_parent_id_fk" FOREIGN KEY (_parent_id) REFERENCES _pages_v(id) ON DELETE CASCADE not valid;

alter table "public"."_pages_v_blocks_cover" validate constraint "_pages_v_blocks_cover_parent_id_fk";

alter table "public"."_pages_v_blocks_form_block" add constraint "_pages_v_blocks_form_block_form_id_forms_id_fk" FOREIGN KEY (form_id) REFERENCES forms(id) ON DELETE SET NULL not valid;

alter table "public"."_pages_v_blocks_form_block" validate constraint "_pages_v_blocks_form_block_form_id_forms_id_fk";

alter table "public"."_pages_v_blocks_form_block" add constraint "_pages_v_blocks_form_block_parent_id_fk" FOREIGN KEY (_parent_id) REFERENCES _pages_v(id) ON DELETE CASCADE not valid;

alter table "public"."_pages_v_blocks_form_block" validate constraint "_pages_v_blocks_form_block_parent_id_fk";

alter table "public"."_pages_v_blocks_github_globe" add constraint "_pages_v_blocks_github_globe_parent_id_fk" FOREIGN KEY (_parent_id) REFERENCES _pages_v(id) ON DELETE CASCADE not valid;

alter table "public"."_pages_v_blocks_github_globe" validate constraint "_pages_v_blocks_github_globe_parent_id_fk";

alter table "public"."_pages_v_blocks_hero_highlight" add constraint "_pages_v_blocks_hero_highlight_parent_id_fk" FOREIGN KEY (_parent_id) REFERENCES _pages_v(id) ON DELETE CASCADE not valid;

alter table "public"."_pages_v_blocks_hero_highlight" validate constraint "_pages_v_blocks_hero_highlight_parent_id_fk";

alter table "public"."_pages_v_blocks_image" add constraint "_pages_v_blocks_image_image_id_media_id_fk" FOREIGN KEY (image_id) REFERENCES media(id) ON DELETE SET NULL not valid;

alter table "public"."_pages_v_blocks_image" validate constraint "_pages_v_blocks_image_image_id_media_id_fk";

alter table "public"."_pages_v_blocks_image" add constraint "_pages_v_blocks_image_parent_id_fk" FOREIGN KEY (_parent_id) REFERENCES _pages_v(id) ON DELETE CASCADE not valid;

alter table "public"."_pages_v_blocks_image" validate constraint "_pages_v_blocks_image_parent_id_fk";

alter table "public"."_pages_v_blocks_infinite_moving_cards" add constraint "_pages_v_blocks_infinite_moving_cards_parent_id_fk" FOREIGN KEY (_parent_id) REFERENCES _pages_v(id) ON DELETE CASCADE not valid;

alter table "public"."_pages_v_blocks_infinite_moving_cards" validate constraint "_pages_v_blocks_infinite_moving_cards_parent_id_fk";

alter table "public"."_pages_v_blocks_infinite_moving_cards_cards" add constraint "_pages_v_blocks_infinite_moving_cards_cards_parent_id_fk" FOREIGN KEY (_parent_id) REFERENCES _pages_v_blocks_infinite_moving_cards(id) ON DELETE CASCADE not valid;

alter table "public"."_pages_v_blocks_infinite_moving_cards_cards" validate constraint "_pages_v_blocks_infinite_moving_cards_cards_parent_id_fk";

alter table "public"."_pages_v_blocks_links_preview" add constraint "_pages_v_blocks_links_preview_parent_id_fk" FOREIGN KEY (_parent_id) REFERENCES _pages_v(id) ON DELETE CASCADE not valid;

alter table "public"."_pages_v_blocks_links_preview" validate constraint "_pages_v_blocks_links_preview_parent_id_fk";

alter table "public"."_pages_v_blocks_links_preview_rows" add constraint "_pages_v_blocks_links_preview_rows_parent_id_fk" FOREIGN KEY (_parent_id) REFERENCES _pages_v_blocks_links_preview(id) ON DELETE CASCADE not valid;

alter table "public"."_pages_v_blocks_links_preview_rows" validate constraint "_pages_v_blocks_links_preview_rows_parent_id_fk";

alter table "public"."_pages_v_blocks_rich_text" add constraint "_pages_v_blocks_rich_text_parent_id_fk" FOREIGN KEY (_parent_id) REFERENCES _pages_v(id) ON DELETE CASCADE not valid;

alter table "public"."_pages_v_blocks_rich_text" validate constraint "_pages_v_blocks_rich_text_parent_id_fk";

alter table "public"."_pages_v_blocks_spotlight" add constraint "_pages_v_blocks_spotlight_parent_id_fk" FOREIGN KEY (_parent_id) REFERENCES _pages_v(id) ON DELETE CASCADE not valid;

alter table "public"."_pages_v_blocks_spotlight" validate constraint "_pages_v_blocks_spotlight_parent_id_fk";

alter table "public"."_pages_v_blocks_text_effect" add constraint "_pages_v_blocks_text_effect_parent_id_fk" FOREIGN KEY (_parent_id) REFERENCES _pages_v(id) ON DELETE CASCADE not valid;

alter table "public"."_pages_v_blocks_text_effect" validate constraint "_pages_v_blocks_text_effect_parent_id_fk";

alter table "public"."_pages_v_blocks_text_image" add constraint "_pages_v_blocks_text_image_image_id_media_id_fk" FOREIGN KEY (image_id) REFERENCES media(id) ON DELETE SET NULL not valid;

alter table "public"."_pages_v_blocks_text_image" validate constraint "_pages_v_blocks_text_image_image_id_media_id_fk";

alter table "public"."_pages_v_blocks_text_image" add constraint "_pages_v_blocks_text_image_parent_id_fk" FOREIGN KEY (_parent_id) REFERENCES _pages_v(id) ON DELETE CASCADE not valid;

alter table "public"."_pages_v_blocks_text_image" validate constraint "_pages_v_blocks_text_image_parent_id_fk";

alter table "public"."_pages_v_blocks_text_image_buttons" add constraint "_pages_v_blocks_text_image_buttons_parent_id_fk" FOREIGN KEY (_parent_id) REFERENCES _pages_v_blocks_text_image(id) ON DELETE CASCADE not valid;

alter table "public"."_pages_v_blocks_text_image_buttons" validate constraint "_pages_v_blocks_text_image_buttons_parent_id_fk";

alter table "public"."_pages_v_blocks_tik_tac_toe" add constraint "_pages_v_blocks_tik_tac_toe_parent_id_fk" FOREIGN KEY (_parent_id) REFERENCES _pages_v(id) ON DELETE CASCADE not valid;

alter table "public"."_pages_v_blocks_tik_tac_toe" validate constraint "_pages_v_blocks_tik_tac_toe_parent_id_fk";

alter table "public"."_pages_v_rels" add constraint "_pages_v_rels_pages_fk" FOREIGN KEY (pages_id) REFERENCES pages(id) ON DELETE CASCADE not valid;

alter table "public"."_pages_v_rels" validate constraint "_pages_v_rels_pages_fk";

alter table "public"."_pages_v_rels" add constraint "_pages_v_rels_parent_fk" FOREIGN KEY (parent_id) REFERENCES _pages_v(id) ON DELETE CASCADE not valid;

alter table "public"."_pages_v_rels" validate constraint "_pages_v_rels_parent_fk";

alter table "public"."_posts_v" add constraint "_posts_v_parent_id_posts_id_fk" FOREIGN KEY (parent_id) REFERENCES posts(id) ON DELETE SET NULL not valid;

alter table "public"."_posts_v" validate constraint "_posts_v_parent_id_posts_id_fk";

alter table "public"."_posts_v" add constraint "_posts_v_version_meta_image_id_media_id_fk" FOREIGN KEY (version_meta_image_id) REFERENCES media(id) ON DELETE SET NULL not valid;

alter table "public"."_posts_v" validate constraint "_posts_v_version_meta_image_id_media_id_fk";

alter table "public"."_posts_v_rels" add constraint "_posts_v_rels_categories_fk" FOREIGN KEY (categories_id) REFERENCES categories(id) ON DELETE CASCADE not valid;

alter table "public"."_posts_v_rels" validate constraint "_posts_v_rels_categories_fk";

alter table "public"."_posts_v_rels" add constraint "_posts_v_rels_parent_fk" FOREIGN KEY (parent_id) REFERENCES _posts_v(id) ON DELETE CASCADE not valid;

alter table "public"."_posts_v_rels" validate constraint "_posts_v_rels_parent_fk";

alter table "public"."_posts_v_rels" add constraint "_posts_v_rels_posts_fk" FOREIGN KEY (posts_id) REFERENCES posts(id) ON DELETE CASCADE not valid;

alter table "public"."_posts_v_rels" validate constraint "_posts_v_rels_posts_fk";

alter table "public"."_posts_v_rels" add constraint "_posts_v_rels_users_fk" FOREIGN KEY (users_id) REFERENCES users(id) ON DELETE CASCADE not valid;

alter table "public"."_posts_v_rels" validate constraint "_posts_v_rels_users_fk";

alter table "public"."_posts_v_version_populated_authors" add constraint "_posts_v_version_populated_authors_parent_id_fk" FOREIGN KEY (_parent_id) REFERENCES _posts_v(id) ON DELETE CASCADE not valid;

alter table "public"."_posts_v_version_populated_authors" validate constraint "_posts_v_version_populated_authors_parent_id_fk";

alter table "public"."footer" add constraint "footer_logo_id_media_id_fk" FOREIGN KEY (logo_id) REFERENCES media(id) ON DELETE SET NULL not valid;

alter table "public"."footer" validate constraint "footer_logo_id_media_id_fk";

alter table "public"."footer_links" add constraint "footer_links_parent_id_fk" FOREIGN KEY (_parent_id) REFERENCES footer(id) ON DELETE CASCADE not valid;

alter table "public"."footer_links" validate constraint "footer_links_parent_id_fk";

alter table "public"."footer_links_children" add constraint "footer_links_children_parent_id_fk" FOREIGN KEY (_parent_id) REFERENCES footer_links(id) ON DELETE CASCADE not valid;

alter table "public"."footer_links_children" validate constraint "footer_links_children_parent_id_fk";

alter table "public"."footer_rels" add constraint "footer_rels_pages_fk" FOREIGN KEY (pages_id) REFERENCES pages(id) ON DELETE CASCADE not valid;

alter table "public"."footer_rels" validate constraint "footer_rels_pages_fk";

alter table "public"."footer_rels" add constraint "footer_rels_parent_fk" FOREIGN KEY (parent_id) REFERENCES footer(id) ON DELETE CASCADE not valid;

alter table "public"."footer_rels" validate constraint "footer_rels_parent_fk";

alter table "public"."form_submissions" add constraint "form_submissions_form_id_forms_id_fk" FOREIGN KEY (form_id) REFERENCES forms(id) ON DELETE SET NULL not valid;

alter table "public"."form_submissions" validate constraint "form_submissions_form_id_forms_id_fk";

alter table "public"."form_submissions_submission_data" add constraint "form_submissions_submission_data_parent_id_fk" FOREIGN KEY (_parent_id) REFERENCES form_submissions(id) ON DELETE CASCADE not valid;

alter table "public"."form_submissions_submission_data" validate constraint "form_submissions_submission_data_parent_id_fk";

alter table "public"."forms_blocks_checkbox" add constraint "forms_blocks_checkbox_parent_id_fk" FOREIGN KEY (_parent_id) REFERENCES forms(id) ON DELETE CASCADE not valid;

alter table "public"."forms_blocks_checkbox" validate constraint "forms_blocks_checkbox_parent_id_fk";

alter table "public"."forms_blocks_country" add constraint "forms_blocks_country_parent_id_fk" FOREIGN KEY (_parent_id) REFERENCES forms(id) ON DELETE CASCADE not valid;

alter table "public"."forms_blocks_country" validate constraint "forms_blocks_country_parent_id_fk";

alter table "public"."forms_blocks_email" add constraint "forms_blocks_email_parent_id_fk" FOREIGN KEY (_parent_id) REFERENCES forms(id) ON DELETE CASCADE not valid;

alter table "public"."forms_blocks_email" validate constraint "forms_blocks_email_parent_id_fk";

alter table "public"."forms_blocks_message" add constraint "forms_blocks_message_parent_id_fk" FOREIGN KEY (_parent_id) REFERENCES forms(id) ON DELETE CASCADE not valid;

alter table "public"."forms_blocks_message" validate constraint "forms_blocks_message_parent_id_fk";

alter table "public"."forms_blocks_number" add constraint "forms_blocks_number_parent_id_fk" FOREIGN KEY (_parent_id) REFERENCES forms(id) ON DELETE CASCADE not valid;

alter table "public"."forms_blocks_number" validate constraint "forms_blocks_number_parent_id_fk";

alter table "public"."forms_blocks_select" add constraint "forms_blocks_select_parent_id_fk" FOREIGN KEY (_parent_id) REFERENCES forms(id) ON DELETE CASCADE not valid;

alter table "public"."forms_blocks_select" validate constraint "forms_blocks_select_parent_id_fk";

alter table "public"."forms_blocks_select_options" add constraint "forms_blocks_select_options_parent_id_fk" FOREIGN KEY (_parent_id) REFERENCES forms_blocks_select(id) ON DELETE CASCADE not valid;

alter table "public"."forms_blocks_select_options" validate constraint "forms_blocks_select_options_parent_id_fk";

alter table "public"."forms_blocks_state" add constraint "forms_blocks_state_parent_id_fk" FOREIGN KEY (_parent_id) REFERENCES forms(id) ON DELETE CASCADE not valid;

alter table "public"."forms_blocks_state" validate constraint "forms_blocks_state_parent_id_fk";

alter table "public"."forms_blocks_text" add constraint "forms_blocks_text_parent_id_fk" FOREIGN KEY (_parent_id) REFERENCES forms(id) ON DELETE CASCADE not valid;

alter table "public"."forms_blocks_text" validate constraint "forms_blocks_text_parent_id_fk";

alter table "public"."forms_blocks_textarea" add constraint "forms_blocks_textarea_parent_id_fk" FOREIGN KEY (_parent_id) REFERENCES forms(id) ON DELETE CASCADE not valid;

alter table "public"."forms_blocks_textarea" validate constraint "forms_blocks_textarea_parent_id_fk";

alter table "public"."forms_emails" add constraint "forms_emails_parent_id_fk" FOREIGN KEY (_parent_id) REFERENCES forms(id) ON DELETE CASCADE not valid;

alter table "public"."forms_emails" validate constraint "forms_emails_parent_id_fk";

alter table "public"."header" add constraint "header_logo_id_media_id_fk" FOREIGN KEY (logo_id) REFERENCES media(id) ON DELETE SET NULL not valid;

alter table "public"."header" validate constraint "header_logo_id_media_id_fk";

alter table "public"."header_links" add constraint "header_links_parent_id_fk" FOREIGN KEY (_parent_id) REFERENCES header(id) ON DELETE CASCADE not valid;

alter table "public"."header_links" validate constraint "header_links_parent_id_fk";

alter table "public"."header_links_children" add constraint "header_links_children_parent_id_fk" FOREIGN KEY (_parent_id) REFERENCES header_links(id) ON DELETE CASCADE not valid;

alter table "public"."header_links_children" validate constraint "header_links_children_parent_id_fk";

alter table "public"."header_rels" add constraint "header_rels_pages_fk" FOREIGN KEY (pages_id) REFERENCES pages(id) ON DELETE CASCADE not valid;

alter table "public"."header_rels" validate constraint "header_rels_pages_fk";

alter table "public"."header_rels" add constraint "header_rels_parent_fk" FOREIGN KEY (parent_id) REFERENCES header(id) ON DELETE CASCADE not valid;

alter table "public"."header_rels" validate constraint "header_rels_parent_fk";

alter table "public"."pages" add constraint "pages_created_by_id_users_id_fk" FOREIGN KEY (created_by_id) REFERENCES users(id) ON DELETE SET NULL not valid;

alter table "public"."pages" validate constraint "pages_created_by_id_users_id_fk";

alter table "public"."pages" add constraint "pages_meta_image_id_media_id_fk" FOREIGN KEY (meta_image_id) REFERENCES media(id) ON DELETE SET NULL not valid;

alter table "public"."pages" validate constraint "pages_meta_image_id_media_id_fk";

alter table "public"."pages_blocks_confetti_header" add constraint "pages_blocks_confetti_header_parent_id_fk" FOREIGN KEY (_parent_id) REFERENCES pages(id) ON DELETE CASCADE not valid;

alter table "public"."pages_blocks_confetti_header" validate constraint "pages_blocks_confetti_header_parent_id_fk";

alter table "public"."pages_blocks_cover" add constraint "pages_blocks_cover_parent_id_fk" FOREIGN KEY (_parent_id) REFERENCES pages(id) ON DELETE CASCADE not valid;

alter table "public"."pages_blocks_cover" validate constraint "pages_blocks_cover_parent_id_fk";

alter table "public"."pages_blocks_form_block" add constraint "pages_blocks_form_block_form_id_forms_id_fk" FOREIGN KEY (form_id) REFERENCES forms(id) ON DELETE SET NULL not valid;

alter table "public"."pages_blocks_form_block" validate constraint "pages_blocks_form_block_form_id_forms_id_fk";

alter table "public"."pages_blocks_form_block" add constraint "pages_blocks_form_block_parent_id_fk" FOREIGN KEY (_parent_id) REFERENCES pages(id) ON DELETE CASCADE not valid;

alter table "public"."pages_blocks_form_block" validate constraint "pages_blocks_form_block_parent_id_fk";

alter table "public"."pages_blocks_github_globe" add constraint "pages_blocks_github_globe_parent_id_fk" FOREIGN KEY (_parent_id) REFERENCES pages(id) ON DELETE CASCADE not valid;

alter table "public"."pages_blocks_github_globe" validate constraint "pages_blocks_github_globe_parent_id_fk";

alter table "public"."pages_blocks_hero_highlight" add constraint "pages_blocks_hero_highlight_parent_id_fk" FOREIGN KEY (_parent_id) REFERENCES pages(id) ON DELETE CASCADE not valid;

alter table "public"."pages_blocks_hero_highlight" validate constraint "pages_blocks_hero_highlight_parent_id_fk";

alter table "public"."pages_blocks_image" add constraint "pages_blocks_image_image_id_media_id_fk" FOREIGN KEY (image_id) REFERENCES media(id) ON DELETE SET NULL not valid;

alter table "public"."pages_blocks_image" validate constraint "pages_blocks_image_image_id_media_id_fk";

alter table "public"."pages_blocks_image" add constraint "pages_blocks_image_parent_id_fk" FOREIGN KEY (_parent_id) REFERENCES pages(id) ON DELETE CASCADE not valid;

alter table "public"."pages_blocks_image" validate constraint "pages_blocks_image_parent_id_fk";

alter table "public"."pages_blocks_infinite_moving_cards" add constraint "pages_blocks_infinite_moving_cards_parent_id_fk" FOREIGN KEY (_parent_id) REFERENCES pages(id) ON DELETE CASCADE not valid;

alter table "public"."pages_blocks_infinite_moving_cards" validate constraint "pages_blocks_infinite_moving_cards_parent_id_fk";

alter table "public"."pages_blocks_infinite_moving_cards_cards" add constraint "pages_blocks_infinite_moving_cards_cards_parent_id_fk" FOREIGN KEY (_parent_id) REFERENCES pages_blocks_infinite_moving_cards(id) ON DELETE CASCADE not valid;

alter table "public"."pages_blocks_infinite_moving_cards_cards" validate constraint "pages_blocks_infinite_moving_cards_cards_parent_id_fk";

alter table "public"."pages_blocks_links_preview" add constraint "pages_blocks_links_preview_parent_id_fk" FOREIGN KEY (_parent_id) REFERENCES pages(id) ON DELETE CASCADE not valid;

alter table "public"."pages_blocks_links_preview" validate constraint "pages_blocks_links_preview_parent_id_fk";

alter table "public"."pages_blocks_links_preview_rows" add constraint "pages_blocks_links_preview_rows_parent_id_fk" FOREIGN KEY (_parent_id) REFERENCES pages_blocks_links_preview(id) ON DELETE CASCADE not valid;

alter table "public"."pages_blocks_links_preview_rows" validate constraint "pages_blocks_links_preview_rows_parent_id_fk";

alter table "public"."pages_blocks_rich_text" add constraint "pages_blocks_rich_text_parent_id_fk" FOREIGN KEY (_parent_id) REFERENCES pages(id) ON DELETE CASCADE not valid;

alter table "public"."pages_blocks_rich_text" validate constraint "pages_blocks_rich_text_parent_id_fk";

alter table "public"."pages_blocks_spotlight" add constraint "pages_blocks_spotlight_parent_id_fk" FOREIGN KEY (_parent_id) REFERENCES pages(id) ON DELETE CASCADE not valid;

alter table "public"."pages_blocks_spotlight" validate constraint "pages_blocks_spotlight_parent_id_fk";

alter table "public"."pages_blocks_text_effect" add constraint "pages_blocks_text_effect_parent_id_fk" FOREIGN KEY (_parent_id) REFERENCES pages(id) ON DELETE CASCADE not valid;

alter table "public"."pages_blocks_text_effect" validate constraint "pages_blocks_text_effect_parent_id_fk";

alter table "public"."pages_blocks_text_image" add constraint "pages_blocks_text_image_image_id_media_id_fk" FOREIGN KEY (image_id) REFERENCES media(id) ON DELETE SET NULL not valid;

alter table "public"."pages_blocks_text_image" validate constraint "pages_blocks_text_image_image_id_media_id_fk";

alter table "public"."pages_blocks_text_image" add constraint "pages_blocks_text_image_parent_id_fk" FOREIGN KEY (_parent_id) REFERENCES pages(id) ON DELETE CASCADE not valid;

alter table "public"."pages_blocks_text_image" validate constraint "pages_blocks_text_image_parent_id_fk";

alter table "public"."pages_blocks_text_image_buttons" add constraint "pages_blocks_text_image_buttons_parent_id_fk" FOREIGN KEY (_parent_id) REFERENCES pages_blocks_text_image(id) ON DELETE CASCADE not valid;

alter table "public"."pages_blocks_text_image_buttons" validate constraint "pages_blocks_text_image_buttons_parent_id_fk";

alter table "public"."pages_blocks_tik_tac_toe" add constraint "pages_blocks_tik_tac_toe_parent_id_fk" FOREIGN KEY (_parent_id) REFERENCES pages(id) ON DELETE CASCADE not valid;

alter table "public"."pages_blocks_tik_tac_toe" validate constraint "pages_blocks_tik_tac_toe_parent_id_fk";

alter table "public"."pages_rels" add constraint "pages_rels_pages_fk" FOREIGN KEY (pages_id) REFERENCES pages(id) ON DELETE CASCADE not valid;

alter table "public"."pages_rels" validate constraint "pages_rels_pages_fk";

alter table "public"."pages_rels" add constraint "pages_rels_parent_fk" FOREIGN KEY (parent_id) REFERENCES pages(id) ON DELETE CASCADE not valid;

alter table "public"."pages_rels" validate constraint "pages_rels_parent_fk";

alter table "public"."payload_locked_documents_rels" add constraint "payload_locked_documents_rels_categories_fk" FOREIGN KEY (categories_id) REFERENCES categories(id) ON DELETE CASCADE not valid;

alter table "public"."payload_locked_documents_rels" validate constraint "payload_locked_documents_rels_categories_fk";

alter table "public"."payload_locked_documents_rels" add constraint "payload_locked_documents_rels_form_submissions_fk" FOREIGN KEY (form_submissions_id) REFERENCES form_submissions(id) ON DELETE CASCADE not valid;

alter table "public"."payload_locked_documents_rels" validate constraint "payload_locked_documents_rels_form_submissions_fk";

alter table "public"."payload_locked_documents_rels" add constraint "payload_locked_documents_rels_forms_fk" FOREIGN KEY (forms_id) REFERENCES forms(id) ON DELETE CASCADE not valid;

alter table "public"."payload_locked_documents_rels" validate constraint "payload_locked_documents_rels_forms_fk";

alter table "public"."payload_locked_documents_rels" add constraint "payload_locked_documents_rels_media_fk" FOREIGN KEY (media_id) REFERENCES media(id) ON DELETE CASCADE not valid;

alter table "public"."payload_locked_documents_rels" validate constraint "payload_locked_documents_rels_media_fk";

alter table "public"."payload_locked_documents_rels" add constraint "payload_locked_documents_rels_pages_fk" FOREIGN KEY (pages_id) REFERENCES pages(id) ON DELETE CASCADE not valid;

alter table "public"."payload_locked_documents_rels" validate constraint "payload_locked_documents_rels_pages_fk";

alter table "public"."payload_locked_documents_rels" add constraint "payload_locked_documents_rels_parent_fk" FOREIGN KEY (parent_id) REFERENCES payload_locked_documents(id) ON DELETE CASCADE not valid;

alter table "public"."payload_locked_documents_rels" validate constraint "payload_locked_documents_rels_parent_fk";

alter table "public"."payload_locked_documents_rels" add constraint "payload_locked_documents_rels_posts_fk" FOREIGN KEY (posts_id) REFERENCES posts(id) ON DELETE CASCADE not valid;

alter table "public"."payload_locked_documents_rels" validate constraint "payload_locked_documents_rels_posts_fk";

alter table "public"."payload_locked_documents_rels" add constraint "payload_locked_documents_rels_redirects_fk" FOREIGN KEY (redirects_id) REFERENCES redirects(id) ON DELETE CASCADE not valid;

alter table "public"."payload_locked_documents_rels" validate constraint "payload_locked_documents_rels_redirects_fk";

alter table "public"."payload_locked_documents_rels" add constraint "payload_locked_documents_rels_users_fk" FOREIGN KEY (users_id) REFERENCES users(id) ON DELETE CASCADE not valid;

alter table "public"."payload_locked_documents_rels" validate constraint "payload_locked_documents_rels_users_fk";

alter table "public"."payload_preferences_rels" add constraint "payload_preferences_rels_parent_fk" FOREIGN KEY (parent_id) REFERENCES payload_preferences(id) ON DELETE CASCADE not valid;

alter table "public"."payload_preferences_rels" validate constraint "payload_preferences_rels_parent_fk";

alter table "public"."payload_preferences_rels" add constraint "payload_preferences_rels_users_fk" FOREIGN KEY (users_id) REFERENCES users(id) ON DELETE CASCADE not valid;

alter table "public"."payload_preferences_rels" validate constraint "payload_preferences_rels_users_fk";

alter table "public"."posts" add constraint "posts_meta_image_id_media_id_fk" FOREIGN KEY (meta_image_id) REFERENCES media(id) ON DELETE SET NULL not valid;

alter table "public"."posts" validate constraint "posts_meta_image_id_media_id_fk";

alter table "public"."posts_populated_authors" add constraint "posts_populated_authors_parent_id_fk" FOREIGN KEY (_parent_id) REFERENCES posts(id) ON DELETE CASCADE not valid;

alter table "public"."posts_populated_authors" validate constraint "posts_populated_authors_parent_id_fk";

alter table "public"."posts_rels" add constraint "posts_rels_categories_fk" FOREIGN KEY (categories_id) REFERENCES categories(id) ON DELETE CASCADE not valid;

alter table "public"."posts_rels" validate constraint "posts_rels_categories_fk";

alter table "public"."posts_rels" add constraint "posts_rels_parent_fk" FOREIGN KEY (parent_id) REFERENCES posts(id) ON DELETE CASCADE not valid;

alter table "public"."posts_rels" validate constraint "posts_rels_parent_fk";

alter table "public"."posts_rels" add constraint "posts_rels_posts_fk" FOREIGN KEY (posts_id) REFERENCES posts(id) ON DELETE CASCADE not valid;

alter table "public"."posts_rels" validate constraint "posts_rels_posts_fk";

alter table "public"."posts_rels" add constraint "posts_rels_users_fk" FOREIGN KEY (users_id) REFERENCES users(id) ON DELETE CASCADE not valid;

alter table "public"."posts_rels" validate constraint "posts_rels_users_fk";

alter table "public"."redirects_rels" add constraint "redirects_rels_pages_fk" FOREIGN KEY (pages_id) REFERENCES pages(id) ON DELETE CASCADE not valid;

alter table "public"."redirects_rels" validate constraint "redirects_rels_pages_fk";

alter table "public"."redirects_rels" add constraint "redirects_rels_parent_fk" FOREIGN KEY (parent_id) REFERENCES redirects(id) ON DELETE CASCADE not valid;

alter table "public"."redirects_rels" validate constraint "redirects_rels_parent_fk";

grant delete on table "public"."_pages_v" to "anon";

grant insert on table "public"."_pages_v" to "anon";

grant references on table "public"."_pages_v" to "anon";

grant select on table "public"."_pages_v" to "anon";

grant trigger on table "public"."_pages_v" to "anon";

grant truncate on table "public"."_pages_v" to "anon";

grant update on table "public"."_pages_v" to "anon";

grant delete on table "public"."_pages_v" to "authenticated";

grant insert on table "public"."_pages_v" to "authenticated";

grant references on table "public"."_pages_v" to "authenticated";

grant select on table "public"."_pages_v" to "authenticated";

grant trigger on table "public"."_pages_v" to "authenticated";

grant truncate on table "public"."_pages_v" to "authenticated";

grant update on table "public"."_pages_v" to "authenticated";

grant delete on table "public"."_pages_v" to "service_role";

grant insert on table "public"."_pages_v" to "service_role";

grant references on table "public"."_pages_v" to "service_role";

grant select on table "public"."_pages_v" to "service_role";

grant trigger on table "public"."_pages_v" to "service_role";

grant truncate on table "public"."_pages_v" to "service_role";

grant update on table "public"."_pages_v" to "service_role";

grant delete on table "public"."_pages_v_blocks_confetti_header" to "anon";

grant insert on table "public"."_pages_v_blocks_confetti_header" to "anon";

grant references on table "public"."_pages_v_blocks_confetti_header" to "anon";

grant select on table "public"."_pages_v_blocks_confetti_header" to "anon";

grant trigger on table "public"."_pages_v_blocks_confetti_header" to "anon";

grant truncate on table "public"."_pages_v_blocks_confetti_header" to "anon";

grant update on table "public"."_pages_v_blocks_confetti_header" to "anon";

grant delete on table "public"."_pages_v_blocks_confetti_header" to "authenticated";

grant insert on table "public"."_pages_v_blocks_confetti_header" to "authenticated";

grant references on table "public"."_pages_v_blocks_confetti_header" to "authenticated";

grant select on table "public"."_pages_v_blocks_confetti_header" to "authenticated";

grant trigger on table "public"."_pages_v_blocks_confetti_header" to "authenticated";

grant truncate on table "public"."_pages_v_blocks_confetti_header" to "authenticated";

grant update on table "public"."_pages_v_blocks_confetti_header" to "authenticated";

grant delete on table "public"."_pages_v_blocks_confetti_header" to "service_role";

grant insert on table "public"."_pages_v_blocks_confetti_header" to "service_role";

grant references on table "public"."_pages_v_blocks_confetti_header" to "service_role";

grant select on table "public"."_pages_v_blocks_confetti_header" to "service_role";

grant trigger on table "public"."_pages_v_blocks_confetti_header" to "service_role";

grant truncate on table "public"."_pages_v_blocks_confetti_header" to "service_role";

grant update on table "public"."_pages_v_blocks_confetti_header" to "service_role";

grant delete on table "public"."_pages_v_blocks_cover" to "anon";

grant insert on table "public"."_pages_v_blocks_cover" to "anon";

grant references on table "public"."_pages_v_blocks_cover" to "anon";

grant select on table "public"."_pages_v_blocks_cover" to "anon";

grant trigger on table "public"."_pages_v_blocks_cover" to "anon";

grant truncate on table "public"."_pages_v_blocks_cover" to "anon";

grant update on table "public"."_pages_v_blocks_cover" to "anon";

grant delete on table "public"."_pages_v_blocks_cover" to "authenticated";

grant insert on table "public"."_pages_v_blocks_cover" to "authenticated";

grant references on table "public"."_pages_v_blocks_cover" to "authenticated";

grant select on table "public"."_pages_v_blocks_cover" to "authenticated";

grant trigger on table "public"."_pages_v_blocks_cover" to "authenticated";

grant truncate on table "public"."_pages_v_blocks_cover" to "authenticated";

grant update on table "public"."_pages_v_blocks_cover" to "authenticated";

grant delete on table "public"."_pages_v_blocks_cover" to "service_role";

grant insert on table "public"."_pages_v_blocks_cover" to "service_role";

grant references on table "public"."_pages_v_blocks_cover" to "service_role";

grant select on table "public"."_pages_v_blocks_cover" to "service_role";

grant trigger on table "public"."_pages_v_blocks_cover" to "service_role";

grant truncate on table "public"."_pages_v_blocks_cover" to "service_role";

grant update on table "public"."_pages_v_blocks_cover" to "service_role";

grant delete on table "public"."_pages_v_blocks_form_block" to "anon";

grant insert on table "public"."_pages_v_blocks_form_block" to "anon";

grant references on table "public"."_pages_v_blocks_form_block" to "anon";

grant select on table "public"."_pages_v_blocks_form_block" to "anon";

grant trigger on table "public"."_pages_v_blocks_form_block" to "anon";

grant truncate on table "public"."_pages_v_blocks_form_block" to "anon";

grant update on table "public"."_pages_v_blocks_form_block" to "anon";

grant delete on table "public"."_pages_v_blocks_form_block" to "authenticated";

grant insert on table "public"."_pages_v_blocks_form_block" to "authenticated";

grant references on table "public"."_pages_v_blocks_form_block" to "authenticated";

grant select on table "public"."_pages_v_blocks_form_block" to "authenticated";

grant trigger on table "public"."_pages_v_blocks_form_block" to "authenticated";

grant truncate on table "public"."_pages_v_blocks_form_block" to "authenticated";

grant update on table "public"."_pages_v_blocks_form_block" to "authenticated";

grant delete on table "public"."_pages_v_blocks_form_block" to "service_role";

grant insert on table "public"."_pages_v_blocks_form_block" to "service_role";

grant references on table "public"."_pages_v_blocks_form_block" to "service_role";

grant select on table "public"."_pages_v_blocks_form_block" to "service_role";

grant trigger on table "public"."_pages_v_blocks_form_block" to "service_role";

grant truncate on table "public"."_pages_v_blocks_form_block" to "service_role";

grant update on table "public"."_pages_v_blocks_form_block" to "service_role";

grant delete on table "public"."_pages_v_blocks_github_globe" to "anon";

grant insert on table "public"."_pages_v_blocks_github_globe" to "anon";

grant references on table "public"."_pages_v_blocks_github_globe" to "anon";

grant select on table "public"."_pages_v_blocks_github_globe" to "anon";

grant trigger on table "public"."_pages_v_blocks_github_globe" to "anon";

grant truncate on table "public"."_pages_v_blocks_github_globe" to "anon";

grant update on table "public"."_pages_v_blocks_github_globe" to "anon";

grant delete on table "public"."_pages_v_blocks_github_globe" to "authenticated";

grant insert on table "public"."_pages_v_blocks_github_globe" to "authenticated";

grant references on table "public"."_pages_v_blocks_github_globe" to "authenticated";

grant select on table "public"."_pages_v_blocks_github_globe" to "authenticated";

grant trigger on table "public"."_pages_v_blocks_github_globe" to "authenticated";

grant truncate on table "public"."_pages_v_blocks_github_globe" to "authenticated";

grant update on table "public"."_pages_v_blocks_github_globe" to "authenticated";

grant delete on table "public"."_pages_v_blocks_github_globe" to "service_role";

grant insert on table "public"."_pages_v_blocks_github_globe" to "service_role";

grant references on table "public"."_pages_v_blocks_github_globe" to "service_role";

grant select on table "public"."_pages_v_blocks_github_globe" to "service_role";

grant trigger on table "public"."_pages_v_blocks_github_globe" to "service_role";

grant truncate on table "public"."_pages_v_blocks_github_globe" to "service_role";

grant update on table "public"."_pages_v_blocks_github_globe" to "service_role";

grant delete on table "public"."_pages_v_blocks_hero_highlight" to "anon";

grant insert on table "public"."_pages_v_blocks_hero_highlight" to "anon";

grant references on table "public"."_pages_v_blocks_hero_highlight" to "anon";

grant select on table "public"."_pages_v_blocks_hero_highlight" to "anon";

grant trigger on table "public"."_pages_v_blocks_hero_highlight" to "anon";

grant truncate on table "public"."_pages_v_blocks_hero_highlight" to "anon";

grant update on table "public"."_pages_v_blocks_hero_highlight" to "anon";

grant delete on table "public"."_pages_v_blocks_hero_highlight" to "authenticated";

grant insert on table "public"."_pages_v_blocks_hero_highlight" to "authenticated";

grant references on table "public"."_pages_v_blocks_hero_highlight" to "authenticated";

grant select on table "public"."_pages_v_blocks_hero_highlight" to "authenticated";

grant trigger on table "public"."_pages_v_blocks_hero_highlight" to "authenticated";

grant truncate on table "public"."_pages_v_blocks_hero_highlight" to "authenticated";

grant update on table "public"."_pages_v_blocks_hero_highlight" to "authenticated";

grant delete on table "public"."_pages_v_blocks_hero_highlight" to "service_role";

grant insert on table "public"."_pages_v_blocks_hero_highlight" to "service_role";

grant references on table "public"."_pages_v_blocks_hero_highlight" to "service_role";

grant select on table "public"."_pages_v_blocks_hero_highlight" to "service_role";

grant trigger on table "public"."_pages_v_blocks_hero_highlight" to "service_role";

grant truncate on table "public"."_pages_v_blocks_hero_highlight" to "service_role";

grant update on table "public"."_pages_v_blocks_hero_highlight" to "service_role";

grant delete on table "public"."_pages_v_blocks_image" to "anon";

grant insert on table "public"."_pages_v_blocks_image" to "anon";

grant references on table "public"."_pages_v_blocks_image" to "anon";

grant select on table "public"."_pages_v_blocks_image" to "anon";

grant trigger on table "public"."_pages_v_blocks_image" to "anon";

grant truncate on table "public"."_pages_v_blocks_image" to "anon";

grant update on table "public"."_pages_v_blocks_image" to "anon";

grant delete on table "public"."_pages_v_blocks_image" to "authenticated";

grant insert on table "public"."_pages_v_blocks_image" to "authenticated";

grant references on table "public"."_pages_v_blocks_image" to "authenticated";

grant select on table "public"."_pages_v_blocks_image" to "authenticated";

grant trigger on table "public"."_pages_v_blocks_image" to "authenticated";

grant truncate on table "public"."_pages_v_blocks_image" to "authenticated";

grant update on table "public"."_pages_v_blocks_image" to "authenticated";

grant delete on table "public"."_pages_v_blocks_image" to "service_role";

grant insert on table "public"."_pages_v_blocks_image" to "service_role";

grant references on table "public"."_pages_v_blocks_image" to "service_role";

grant select on table "public"."_pages_v_blocks_image" to "service_role";

grant trigger on table "public"."_pages_v_blocks_image" to "service_role";

grant truncate on table "public"."_pages_v_blocks_image" to "service_role";

grant update on table "public"."_pages_v_blocks_image" to "service_role";

grant delete on table "public"."_pages_v_blocks_infinite_moving_cards" to "anon";

grant insert on table "public"."_pages_v_blocks_infinite_moving_cards" to "anon";

grant references on table "public"."_pages_v_blocks_infinite_moving_cards" to "anon";

grant select on table "public"."_pages_v_blocks_infinite_moving_cards" to "anon";

grant trigger on table "public"."_pages_v_blocks_infinite_moving_cards" to "anon";

grant truncate on table "public"."_pages_v_blocks_infinite_moving_cards" to "anon";

grant update on table "public"."_pages_v_blocks_infinite_moving_cards" to "anon";

grant delete on table "public"."_pages_v_blocks_infinite_moving_cards" to "authenticated";

grant insert on table "public"."_pages_v_blocks_infinite_moving_cards" to "authenticated";

grant references on table "public"."_pages_v_blocks_infinite_moving_cards" to "authenticated";

grant select on table "public"."_pages_v_blocks_infinite_moving_cards" to "authenticated";

grant trigger on table "public"."_pages_v_blocks_infinite_moving_cards" to "authenticated";

grant truncate on table "public"."_pages_v_blocks_infinite_moving_cards" to "authenticated";

grant update on table "public"."_pages_v_blocks_infinite_moving_cards" to "authenticated";

grant delete on table "public"."_pages_v_blocks_infinite_moving_cards" to "service_role";

grant insert on table "public"."_pages_v_blocks_infinite_moving_cards" to "service_role";

grant references on table "public"."_pages_v_blocks_infinite_moving_cards" to "service_role";

grant select on table "public"."_pages_v_blocks_infinite_moving_cards" to "service_role";

grant trigger on table "public"."_pages_v_blocks_infinite_moving_cards" to "service_role";

grant truncate on table "public"."_pages_v_blocks_infinite_moving_cards" to "service_role";

grant update on table "public"."_pages_v_blocks_infinite_moving_cards" to "service_role";

grant delete on table "public"."_pages_v_blocks_infinite_moving_cards_cards" to "anon";

grant insert on table "public"."_pages_v_blocks_infinite_moving_cards_cards" to "anon";

grant references on table "public"."_pages_v_blocks_infinite_moving_cards_cards" to "anon";

grant select on table "public"."_pages_v_blocks_infinite_moving_cards_cards" to "anon";

grant trigger on table "public"."_pages_v_blocks_infinite_moving_cards_cards" to "anon";

grant truncate on table "public"."_pages_v_blocks_infinite_moving_cards_cards" to "anon";

grant update on table "public"."_pages_v_blocks_infinite_moving_cards_cards" to "anon";

grant delete on table "public"."_pages_v_blocks_infinite_moving_cards_cards" to "authenticated";

grant insert on table "public"."_pages_v_blocks_infinite_moving_cards_cards" to "authenticated";

grant references on table "public"."_pages_v_blocks_infinite_moving_cards_cards" to "authenticated";

grant select on table "public"."_pages_v_blocks_infinite_moving_cards_cards" to "authenticated";

grant trigger on table "public"."_pages_v_blocks_infinite_moving_cards_cards" to "authenticated";

grant truncate on table "public"."_pages_v_blocks_infinite_moving_cards_cards" to "authenticated";

grant update on table "public"."_pages_v_blocks_infinite_moving_cards_cards" to "authenticated";

grant delete on table "public"."_pages_v_blocks_infinite_moving_cards_cards" to "service_role";

grant insert on table "public"."_pages_v_blocks_infinite_moving_cards_cards" to "service_role";

grant references on table "public"."_pages_v_blocks_infinite_moving_cards_cards" to "service_role";

grant select on table "public"."_pages_v_blocks_infinite_moving_cards_cards" to "service_role";

grant trigger on table "public"."_pages_v_blocks_infinite_moving_cards_cards" to "service_role";

grant truncate on table "public"."_pages_v_blocks_infinite_moving_cards_cards" to "service_role";

grant update on table "public"."_pages_v_blocks_infinite_moving_cards_cards" to "service_role";

grant delete on table "public"."_pages_v_blocks_links_preview" to "anon";

grant insert on table "public"."_pages_v_blocks_links_preview" to "anon";

grant references on table "public"."_pages_v_blocks_links_preview" to "anon";

grant select on table "public"."_pages_v_blocks_links_preview" to "anon";

grant trigger on table "public"."_pages_v_blocks_links_preview" to "anon";

grant truncate on table "public"."_pages_v_blocks_links_preview" to "anon";

grant update on table "public"."_pages_v_blocks_links_preview" to "anon";

grant delete on table "public"."_pages_v_blocks_links_preview" to "authenticated";

grant insert on table "public"."_pages_v_blocks_links_preview" to "authenticated";

grant references on table "public"."_pages_v_blocks_links_preview" to "authenticated";

grant select on table "public"."_pages_v_blocks_links_preview" to "authenticated";

grant trigger on table "public"."_pages_v_blocks_links_preview" to "authenticated";

grant truncate on table "public"."_pages_v_blocks_links_preview" to "authenticated";

grant update on table "public"."_pages_v_blocks_links_preview" to "authenticated";

grant delete on table "public"."_pages_v_blocks_links_preview" to "service_role";

grant insert on table "public"."_pages_v_blocks_links_preview" to "service_role";

grant references on table "public"."_pages_v_blocks_links_preview" to "service_role";

grant select on table "public"."_pages_v_blocks_links_preview" to "service_role";

grant trigger on table "public"."_pages_v_blocks_links_preview" to "service_role";

grant truncate on table "public"."_pages_v_blocks_links_preview" to "service_role";

grant update on table "public"."_pages_v_blocks_links_preview" to "service_role";

grant delete on table "public"."_pages_v_blocks_links_preview_rows" to "anon";

grant insert on table "public"."_pages_v_blocks_links_preview_rows" to "anon";

grant references on table "public"."_pages_v_blocks_links_preview_rows" to "anon";

grant select on table "public"."_pages_v_blocks_links_preview_rows" to "anon";

grant trigger on table "public"."_pages_v_blocks_links_preview_rows" to "anon";

grant truncate on table "public"."_pages_v_blocks_links_preview_rows" to "anon";

grant update on table "public"."_pages_v_blocks_links_preview_rows" to "anon";

grant delete on table "public"."_pages_v_blocks_links_preview_rows" to "authenticated";

grant insert on table "public"."_pages_v_blocks_links_preview_rows" to "authenticated";

grant references on table "public"."_pages_v_blocks_links_preview_rows" to "authenticated";

grant select on table "public"."_pages_v_blocks_links_preview_rows" to "authenticated";

grant trigger on table "public"."_pages_v_blocks_links_preview_rows" to "authenticated";

grant truncate on table "public"."_pages_v_blocks_links_preview_rows" to "authenticated";

grant update on table "public"."_pages_v_blocks_links_preview_rows" to "authenticated";

grant delete on table "public"."_pages_v_blocks_links_preview_rows" to "service_role";

grant insert on table "public"."_pages_v_blocks_links_preview_rows" to "service_role";

grant references on table "public"."_pages_v_blocks_links_preview_rows" to "service_role";

grant select on table "public"."_pages_v_blocks_links_preview_rows" to "service_role";

grant trigger on table "public"."_pages_v_blocks_links_preview_rows" to "service_role";

grant truncate on table "public"."_pages_v_blocks_links_preview_rows" to "service_role";

grant update on table "public"."_pages_v_blocks_links_preview_rows" to "service_role";

grant delete on table "public"."_pages_v_blocks_rich_text" to "anon";

grant insert on table "public"."_pages_v_blocks_rich_text" to "anon";

grant references on table "public"."_pages_v_blocks_rich_text" to "anon";

grant select on table "public"."_pages_v_blocks_rich_text" to "anon";

grant trigger on table "public"."_pages_v_blocks_rich_text" to "anon";

grant truncate on table "public"."_pages_v_blocks_rich_text" to "anon";

grant update on table "public"."_pages_v_blocks_rich_text" to "anon";

grant delete on table "public"."_pages_v_blocks_rich_text" to "authenticated";

grant insert on table "public"."_pages_v_blocks_rich_text" to "authenticated";

grant references on table "public"."_pages_v_blocks_rich_text" to "authenticated";

grant select on table "public"."_pages_v_blocks_rich_text" to "authenticated";

grant trigger on table "public"."_pages_v_blocks_rich_text" to "authenticated";

grant truncate on table "public"."_pages_v_blocks_rich_text" to "authenticated";

grant update on table "public"."_pages_v_blocks_rich_text" to "authenticated";

grant delete on table "public"."_pages_v_blocks_rich_text" to "service_role";

grant insert on table "public"."_pages_v_blocks_rich_text" to "service_role";

grant references on table "public"."_pages_v_blocks_rich_text" to "service_role";

grant select on table "public"."_pages_v_blocks_rich_text" to "service_role";

grant trigger on table "public"."_pages_v_blocks_rich_text" to "service_role";

grant truncate on table "public"."_pages_v_blocks_rich_text" to "service_role";

grant update on table "public"."_pages_v_blocks_rich_text" to "service_role";

grant delete on table "public"."_pages_v_blocks_spotlight" to "anon";

grant insert on table "public"."_pages_v_blocks_spotlight" to "anon";

grant references on table "public"."_pages_v_blocks_spotlight" to "anon";

grant select on table "public"."_pages_v_blocks_spotlight" to "anon";

grant trigger on table "public"."_pages_v_blocks_spotlight" to "anon";

grant truncate on table "public"."_pages_v_blocks_spotlight" to "anon";

grant update on table "public"."_pages_v_blocks_spotlight" to "anon";

grant delete on table "public"."_pages_v_blocks_spotlight" to "authenticated";

grant insert on table "public"."_pages_v_blocks_spotlight" to "authenticated";

grant references on table "public"."_pages_v_blocks_spotlight" to "authenticated";

grant select on table "public"."_pages_v_blocks_spotlight" to "authenticated";

grant trigger on table "public"."_pages_v_blocks_spotlight" to "authenticated";

grant truncate on table "public"."_pages_v_blocks_spotlight" to "authenticated";

grant update on table "public"."_pages_v_blocks_spotlight" to "authenticated";

grant delete on table "public"."_pages_v_blocks_spotlight" to "service_role";

grant insert on table "public"."_pages_v_blocks_spotlight" to "service_role";

grant references on table "public"."_pages_v_blocks_spotlight" to "service_role";

grant select on table "public"."_pages_v_blocks_spotlight" to "service_role";

grant trigger on table "public"."_pages_v_blocks_spotlight" to "service_role";

grant truncate on table "public"."_pages_v_blocks_spotlight" to "service_role";

grant update on table "public"."_pages_v_blocks_spotlight" to "service_role";

grant delete on table "public"."_pages_v_blocks_text_effect" to "anon";

grant insert on table "public"."_pages_v_blocks_text_effect" to "anon";

grant references on table "public"."_pages_v_blocks_text_effect" to "anon";

grant select on table "public"."_pages_v_blocks_text_effect" to "anon";

grant trigger on table "public"."_pages_v_blocks_text_effect" to "anon";

grant truncate on table "public"."_pages_v_blocks_text_effect" to "anon";

grant update on table "public"."_pages_v_blocks_text_effect" to "anon";

grant delete on table "public"."_pages_v_blocks_text_effect" to "authenticated";

grant insert on table "public"."_pages_v_blocks_text_effect" to "authenticated";

grant references on table "public"."_pages_v_blocks_text_effect" to "authenticated";

grant select on table "public"."_pages_v_blocks_text_effect" to "authenticated";

grant trigger on table "public"."_pages_v_blocks_text_effect" to "authenticated";

grant truncate on table "public"."_pages_v_blocks_text_effect" to "authenticated";

grant update on table "public"."_pages_v_blocks_text_effect" to "authenticated";

grant delete on table "public"."_pages_v_blocks_text_effect" to "service_role";

grant insert on table "public"."_pages_v_blocks_text_effect" to "service_role";

grant references on table "public"."_pages_v_blocks_text_effect" to "service_role";

grant select on table "public"."_pages_v_blocks_text_effect" to "service_role";

grant trigger on table "public"."_pages_v_blocks_text_effect" to "service_role";

grant truncate on table "public"."_pages_v_blocks_text_effect" to "service_role";

grant update on table "public"."_pages_v_blocks_text_effect" to "service_role";

grant delete on table "public"."_pages_v_blocks_text_image" to "anon";

grant insert on table "public"."_pages_v_blocks_text_image" to "anon";

grant references on table "public"."_pages_v_blocks_text_image" to "anon";

grant select on table "public"."_pages_v_blocks_text_image" to "anon";

grant trigger on table "public"."_pages_v_blocks_text_image" to "anon";

grant truncate on table "public"."_pages_v_blocks_text_image" to "anon";

grant update on table "public"."_pages_v_blocks_text_image" to "anon";

grant delete on table "public"."_pages_v_blocks_text_image" to "authenticated";

grant insert on table "public"."_pages_v_blocks_text_image" to "authenticated";

grant references on table "public"."_pages_v_blocks_text_image" to "authenticated";

grant select on table "public"."_pages_v_blocks_text_image" to "authenticated";

grant trigger on table "public"."_pages_v_blocks_text_image" to "authenticated";

grant truncate on table "public"."_pages_v_blocks_text_image" to "authenticated";

grant update on table "public"."_pages_v_blocks_text_image" to "authenticated";

grant delete on table "public"."_pages_v_blocks_text_image" to "service_role";

grant insert on table "public"."_pages_v_blocks_text_image" to "service_role";

grant references on table "public"."_pages_v_blocks_text_image" to "service_role";

grant select on table "public"."_pages_v_blocks_text_image" to "service_role";

grant trigger on table "public"."_pages_v_blocks_text_image" to "service_role";

grant truncate on table "public"."_pages_v_blocks_text_image" to "service_role";

grant update on table "public"."_pages_v_blocks_text_image" to "service_role";

grant delete on table "public"."_pages_v_blocks_text_image_buttons" to "anon";

grant insert on table "public"."_pages_v_blocks_text_image_buttons" to "anon";

grant references on table "public"."_pages_v_blocks_text_image_buttons" to "anon";

grant select on table "public"."_pages_v_blocks_text_image_buttons" to "anon";

grant trigger on table "public"."_pages_v_blocks_text_image_buttons" to "anon";

grant truncate on table "public"."_pages_v_blocks_text_image_buttons" to "anon";

grant update on table "public"."_pages_v_blocks_text_image_buttons" to "anon";

grant delete on table "public"."_pages_v_blocks_text_image_buttons" to "authenticated";

grant insert on table "public"."_pages_v_blocks_text_image_buttons" to "authenticated";

grant references on table "public"."_pages_v_blocks_text_image_buttons" to "authenticated";

grant select on table "public"."_pages_v_blocks_text_image_buttons" to "authenticated";

grant trigger on table "public"."_pages_v_blocks_text_image_buttons" to "authenticated";

grant truncate on table "public"."_pages_v_blocks_text_image_buttons" to "authenticated";

grant update on table "public"."_pages_v_blocks_text_image_buttons" to "authenticated";

grant delete on table "public"."_pages_v_blocks_text_image_buttons" to "service_role";

grant insert on table "public"."_pages_v_blocks_text_image_buttons" to "service_role";

grant references on table "public"."_pages_v_blocks_text_image_buttons" to "service_role";

grant select on table "public"."_pages_v_blocks_text_image_buttons" to "service_role";

grant trigger on table "public"."_pages_v_blocks_text_image_buttons" to "service_role";

grant truncate on table "public"."_pages_v_blocks_text_image_buttons" to "service_role";

grant update on table "public"."_pages_v_blocks_text_image_buttons" to "service_role";

grant delete on table "public"."_pages_v_blocks_tik_tac_toe" to "anon";

grant insert on table "public"."_pages_v_blocks_tik_tac_toe" to "anon";

grant references on table "public"."_pages_v_blocks_tik_tac_toe" to "anon";

grant select on table "public"."_pages_v_blocks_tik_tac_toe" to "anon";

grant trigger on table "public"."_pages_v_blocks_tik_tac_toe" to "anon";

grant truncate on table "public"."_pages_v_blocks_tik_tac_toe" to "anon";

grant update on table "public"."_pages_v_blocks_tik_tac_toe" to "anon";

grant delete on table "public"."_pages_v_blocks_tik_tac_toe" to "authenticated";

grant insert on table "public"."_pages_v_blocks_tik_tac_toe" to "authenticated";

grant references on table "public"."_pages_v_blocks_tik_tac_toe" to "authenticated";

grant select on table "public"."_pages_v_blocks_tik_tac_toe" to "authenticated";

grant trigger on table "public"."_pages_v_blocks_tik_tac_toe" to "authenticated";

grant truncate on table "public"."_pages_v_blocks_tik_tac_toe" to "authenticated";

grant update on table "public"."_pages_v_blocks_tik_tac_toe" to "authenticated";

grant delete on table "public"."_pages_v_blocks_tik_tac_toe" to "service_role";

grant insert on table "public"."_pages_v_blocks_tik_tac_toe" to "service_role";

grant references on table "public"."_pages_v_blocks_tik_tac_toe" to "service_role";

grant select on table "public"."_pages_v_blocks_tik_tac_toe" to "service_role";

grant trigger on table "public"."_pages_v_blocks_tik_tac_toe" to "service_role";

grant truncate on table "public"."_pages_v_blocks_tik_tac_toe" to "service_role";

grant update on table "public"."_pages_v_blocks_tik_tac_toe" to "service_role";

grant delete on table "public"."_pages_v_rels" to "anon";

grant insert on table "public"."_pages_v_rels" to "anon";

grant references on table "public"."_pages_v_rels" to "anon";

grant select on table "public"."_pages_v_rels" to "anon";

grant trigger on table "public"."_pages_v_rels" to "anon";

grant truncate on table "public"."_pages_v_rels" to "anon";

grant update on table "public"."_pages_v_rels" to "anon";

grant delete on table "public"."_pages_v_rels" to "authenticated";

grant insert on table "public"."_pages_v_rels" to "authenticated";

grant references on table "public"."_pages_v_rels" to "authenticated";

grant select on table "public"."_pages_v_rels" to "authenticated";

grant trigger on table "public"."_pages_v_rels" to "authenticated";

grant truncate on table "public"."_pages_v_rels" to "authenticated";

grant update on table "public"."_pages_v_rels" to "authenticated";

grant delete on table "public"."_pages_v_rels" to "service_role";

grant insert on table "public"."_pages_v_rels" to "service_role";

grant references on table "public"."_pages_v_rels" to "service_role";

grant select on table "public"."_pages_v_rels" to "service_role";

grant trigger on table "public"."_pages_v_rels" to "service_role";

grant truncate on table "public"."_pages_v_rels" to "service_role";

grant update on table "public"."_pages_v_rels" to "service_role";

grant delete on table "public"."_posts_v" to "anon";

grant insert on table "public"."_posts_v" to "anon";

grant references on table "public"."_posts_v" to "anon";

grant select on table "public"."_posts_v" to "anon";

grant trigger on table "public"."_posts_v" to "anon";

grant truncate on table "public"."_posts_v" to "anon";

grant update on table "public"."_posts_v" to "anon";

grant delete on table "public"."_posts_v" to "authenticated";

grant insert on table "public"."_posts_v" to "authenticated";

grant references on table "public"."_posts_v" to "authenticated";

grant select on table "public"."_posts_v" to "authenticated";

grant trigger on table "public"."_posts_v" to "authenticated";

grant truncate on table "public"."_posts_v" to "authenticated";

grant update on table "public"."_posts_v" to "authenticated";

grant delete on table "public"."_posts_v" to "service_role";

grant insert on table "public"."_posts_v" to "service_role";

grant references on table "public"."_posts_v" to "service_role";

grant select on table "public"."_posts_v" to "service_role";

grant trigger on table "public"."_posts_v" to "service_role";

grant truncate on table "public"."_posts_v" to "service_role";

grant update on table "public"."_posts_v" to "service_role";

grant delete on table "public"."_posts_v_rels" to "anon";

grant insert on table "public"."_posts_v_rels" to "anon";

grant references on table "public"."_posts_v_rels" to "anon";

grant select on table "public"."_posts_v_rels" to "anon";

grant trigger on table "public"."_posts_v_rels" to "anon";

grant truncate on table "public"."_posts_v_rels" to "anon";

grant update on table "public"."_posts_v_rels" to "anon";

grant delete on table "public"."_posts_v_rels" to "authenticated";

grant insert on table "public"."_posts_v_rels" to "authenticated";

grant references on table "public"."_posts_v_rels" to "authenticated";

grant select on table "public"."_posts_v_rels" to "authenticated";

grant trigger on table "public"."_posts_v_rels" to "authenticated";

grant truncate on table "public"."_posts_v_rels" to "authenticated";

grant update on table "public"."_posts_v_rels" to "authenticated";

grant delete on table "public"."_posts_v_rels" to "service_role";

grant insert on table "public"."_posts_v_rels" to "service_role";

grant references on table "public"."_posts_v_rels" to "service_role";

grant select on table "public"."_posts_v_rels" to "service_role";

grant trigger on table "public"."_posts_v_rels" to "service_role";

grant truncate on table "public"."_posts_v_rels" to "service_role";

grant update on table "public"."_posts_v_rels" to "service_role";

grant delete on table "public"."_posts_v_version_populated_authors" to "anon";

grant insert on table "public"."_posts_v_version_populated_authors" to "anon";

grant references on table "public"."_posts_v_version_populated_authors" to "anon";

grant select on table "public"."_posts_v_version_populated_authors" to "anon";

grant trigger on table "public"."_posts_v_version_populated_authors" to "anon";

grant truncate on table "public"."_posts_v_version_populated_authors" to "anon";

grant update on table "public"."_posts_v_version_populated_authors" to "anon";

grant delete on table "public"."_posts_v_version_populated_authors" to "authenticated";

grant insert on table "public"."_posts_v_version_populated_authors" to "authenticated";

grant references on table "public"."_posts_v_version_populated_authors" to "authenticated";

grant select on table "public"."_posts_v_version_populated_authors" to "authenticated";

grant trigger on table "public"."_posts_v_version_populated_authors" to "authenticated";

grant truncate on table "public"."_posts_v_version_populated_authors" to "authenticated";

grant update on table "public"."_posts_v_version_populated_authors" to "authenticated";

grant delete on table "public"."_posts_v_version_populated_authors" to "service_role";

grant insert on table "public"."_posts_v_version_populated_authors" to "service_role";

grant references on table "public"."_posts_v_version_populated_authors" to "service_role";

grant select on table "public"."_posts_v_version_populated_authors" to "service_role";

grant trigger on table "public"."_posts_v_version_populated_authors" to "service_role";

grant truncate on table "public"."_posts_v_version_populated_authors" to "service_role";

grant update on table "public"."_posts_v_version_populated_authors" to "service_role";

grant delete on table "public"."categories" to "anon";

grant insert on table "public"."categories" to "anon";

grant references on table "public"."categories" to "anon";

grant select on table "public"."categories" to "anon";

grant trigger on table "public"."categories" to "anon";

grant truncate on table "public"."categories" to "anon";

grant update on table "public"."categories" to "anon";

grant delete on table "public"."categories" to "authenticated";

grant insert on table "public"."categories" to "authenticated";

grant references on table "public"."categories" to "authenticated";

grant select on table "public"."categories" to "authenticated";

grant trigger on table "public"."categories" to "authenticated";

grant truncate on table "public"."categories" to "authenticated";

grant update on table "public"."categories" to "authenticated";

grant delete on table "public"."categories" to "service_role";

grant insert on table "public"."categories" to "service_role";

grant references on table "public"."categories" to "service_role";

grant select on table "public"."categories" to "service_role";

grant trigger on table "public"."categories" to "service_role";

grant truncate on table "public"."categories" to "service_role";

grant update on table "public"."categories" to "service_role";

grant delete on table "public"."footer" to "anon";

grant insert on table "public"."footer" to "anon";

grant references on table "public"."footer" to "anon";

grant select on table "public"."footer" to "anon";

grant trigger on table "public"."footer" to "anon";

grant truncate on table "public"."footer" to "anon";

grant update on table "public"."footer" to "anon";

grant delete on table "public"."footer" to "authenticated";

grant insert on table "public"."footer" to "authenticated";

grant references on table "public"."footer" to "authenticated";

grant select on table "public"."footer" to "authenticated";

grant trigger on table "public"."footer" to "authenticated";

grant truncate on table "public"."footer" to "authenticated";

grant update on table "public"."footer" to "authenticated";

grant delete on table "public"."footer" to "service_role";

grant insert on table "public"."footer" to "service_role";

grant references on table "public"."footer" to "service_role";

grant select on table "public"."footer" to "service_role";

grant trigger on table "public"."footer" to "service_role";

grant truncate on table "public"."footer" to "service_role";

grant update on table "public"."footer" to "service_role";

grant delete on table "public"."footer_links" to "anon";

grant insert on table "public"."footer_links" to "anon";

grant references on table "public"."footer_links" to "anon";

grant select on table "public"."footer_links" to "anon";

grant trigger on table "public"."footer_links" to "anon";

grant truncate on table "public"."footer_links" to "anon";

grant update on table "public"."footer_links" to "anon";

grant delete on table "public"."footer_links" to "authenticated";

grant insert on table "public"."footer_links" to "authenticated";

grant references on table "public"."footer_links" to "authenticated";

grant select on table "public"."footer_links" to "authenticated";

grant trigger on table "public"."footer_links" to "authenticated";

grant truncate on table "public"."footer_links" to "authenticated";

grant update on table "public"."footer_links" to "authenticated";

grant delete on table "public"."footer_links" to "service_role";

grant insert on table "public"."footer_links" to "service_role";

grant references on table "public"."footer_links" to "service_role";

grant select on table "public"."footer_links" to "service_role";

grant trigger on table "public"."footer_links" to "service_role";

grant truncate on table "public"."footer_links" to "service_role";

grant update on table "public"."footer_links" to "service_role";

grant delete on table "public"."footer_links_children" to "anon";

grant insert on table "public"."footer_links_children" to "anon";

grant references on table "public"."footer_links_children" to "anon";

grant select on table "public"."footer_links_children" to "anon";

grant trigger on table "public"."footer_links_children" to "anon";

grant truncate on table "public"."footer_links_children" to "anon";

grant update on table "public"."footer_links_children" to "anon";

grant delete on table "public"."footer_links_children" to "authenticated";

grant insert on table "public"."footer_links_children" to "authenticated";

grant references on table "public"."footer_links_children" to "authenticated";

grant select on table "public"."footer_links_children" to "authenticated";

grant trigger on table "public"."footer_links_children" to "authenticated";

grant truncate on table "public"."footer_links_children" to "authenticated";

grant update on table "public"."footer_links_children" to "authenticated";

grant delete on table "public"."footer_links_children" to "service_role";

grant insert on table "public"."footer_links_children" to "service_role";

grant references on table "public"."footer_links_children" to "service_role";

grant select on table "public"."footer_links_children" to "service_role";

grant trigger on table "public"."footer_links_children" to "service_role";

grant truncate on table "public"."footer_links_children" to "service_role";

grant update on table "public"."footer_links_children" to "service_role";

grant delete on table "public"."footer_rels" to "anon";

grant insert on table "public"."footer_rels" to "anon";

grant references on table "public"."footer_rels" to "anon";

grant select on table "public"."footer_rels" to "anon";

grant trigger on table "public"."footer_rels" to "anon";

grant truncate on table "public"."footer_rels" to "anon";

grant update on table "public"."footer_rels" to "anon";

grant delete on table "public"."footer_rels" to "authenticated";

grant insert on table "public"."footer_rels" to "authenticated";

grant references on table "public"."footer_rels" to "authenticated";

grant select on table "public"."footer_rels" to "authenticated";

grant trigger on table "public"."footer_rels" to "authenticated";

grant truncate on table "public"."footer_rels" to "authenticated";

grant update on table "public"."footer_rels" to "authenticated";

grant delete on table "public"."footer_rels" to "service_role";

grant insert on table "public"."footer_rels" to "service_role";

grant references on table "public"."footer_rels" to "service_role";

grant select on table "public"."footer_rels" to "service_role";

grant trigger on table "public"."footer_rels" to "service_role";

grant truncate on table "public"."footer_rels" to "service_role";

grant update on table "public"."footer_rels" to "service_role";

grant delete on table "public"."form_submissions" to "anon";

grant insert on table "public"."form_submissions" to "anon";

grant references on table "public"."form_submissions" to "anon";

grant select on table "public"."form_submissions" to "anon";

grant trigger on table "public"."form_submissions" to "anon";

grant truncate on table "public"."form_submissions" to "anon";

grant update on table "public"."form_submissions" to "anon";

grant delete on table "public"."form_submissions" to "authenticated";

grant insert on table "public"."form_submissions" to "authenticated";

grant references on table "public"."form_submissions" to "authenticated";

grant select on table "public"."form_submissions" to "authenticated";

grant trigger on table "public"."form_submissions" to "authenticated";

grant truncate on table "public"."form_submissions" to "authenticated";

grant update on table "public"."form_submissions" to "authenticated";

grant delete on table "public"."form_submissions" to "service_role";

grant insert on table "public"."form_submissions" to "service_role";

grant references on table "public"."form_submissions" to "service_role";

grant select on table "public"."form_submissions" to "service_role";

grant trigger on table "public"."form_submissions" to "service_role";

grant truncate on table "public"."form_submissions" to "service_role";

grant update on table "public"."form_submissions" to "service_role";

grant delete on table "public"."form_submissions_submission_data" to "anon";

grant insert on table "public"."form_submissions_submission_data" to "anon";

grant references on table "public"."form_submissions_submission_data" to "anon";

grant select on table "public"."form_submissions_submission_data" to "anon";

grant trigger on table "public"."form_submissions_submission_data" to "anon";

grant truncate on table "public"."form_submissions_submission_data" to "anon";

grant update on table "public"."form_submissions_submission_data" to "anon";

grant delete on table "public"."form_submissions_submission_data" to "authenticated";

grant insert on table "public"."form_submissions_submission_data" to "authenticated";

grant references on table "public"."form_submissions_submission_data" to "authenticated";

grant select on table "public"."form_submissions_submission_data" to "authenticated";

grant trigger on table "public"."form_submissions_submission_data" to "authenticated";

grant truncate on table "public"."form_submissions_submission_data" to "authenticated";

grant update on table "public"."form_submissions_submission_data" to "authenticated";

grant delete on table "public"."form_submissions_submission_data" to "service_role";

grant insert on table "public"."form_submissions_submission_data" to "service_role";

grant references on table "public"."form_submissions_submission_data" to "service_role";

grant select on table "public"."form_submissions_submission_data" to "service_role";

grant trigger on table "public"."form_submissions_submission_data" to "service_role";

grant truncate on table "public"."form_submissions_submission_data" to "service_role";

grant update on table "public"."form_submissions_submission_data" to "service_role";

grant delete on table "public"."forms" to "anon";

grant insert on table "public"."forms" to "anon";

grant references on table "public"."forms" to "anon";

grant select on table "public"."forms" to "anon";

grant trigger on table "public"."forms" to "anon";

grant truncate on table "public"."forms" to "anon";

grant update on table "public"."forms" to "anon";

grant delete on table "public"."forms" to "authenticated";

grant insert on table "public"."forms" to "authenticated";

grant references on table "public"."forms" to "authenticated";

grant select on table "public"."forms" to "authenticated";

grant trigger on table "public"."forms" to "authenticated";

grant truncate on table "public"."forms" to "authenticated";

grant update on table "public"."forms" to "authenticated";

grant delete on table "public"."forms" to "service_role";

grant insert on table "public"."forms" to "service_role";

grant references on table "public"."forms" to "service_role";

grant select on table "public"."forms" to "service_role";

grant trigger on table "public"."forms" to "service_role";

grant truncate on table "public"."forms" to "service_role";

grant update on table "public"."forms" to "service_role";

grant delete on table "public"."forms_blocks_checkbox" to "anon";

grant insert on table "public"."forms_blocks_checkbox" to "anon";

grant references on table "public"."forms_blocks_checkbox" to "anon";

grant select on table "public"."forms_blocks_checkbox" to "anon";

grant trigger on table "public"."forms_blocks_checkbox" to "anon";

grant truncate on table "public"."forms_blocks_checkbox" to "anon";

grant update on table "public"."forms_blocks_checkbox" to "anon";

grant delete on table "public"."forms_blocks_checkbox" to "authenticated";

grant insert on table "public"."forms_blocks_checkbox" to "authenticated";

grant references on table "public"."forms_blocks_checkbox" to "authenticated";

grant select on table "public"."forms_blocks_checkbox" to "authenticated";

grant trigger on table "public"."forms_blocks_checkbox" to "authenticated";

grant truncate on table "public"."forms_blocks_checkbox" to "authenticated";

grant update on table "public"."forms_blocks_checkbox" to "authenticated";

grant delete on table "public"."forms_blocks_checkbox" to "service_role";

grant insert on table "public"."forms_blocks_checkbox" to "service_role";

grant references on table "public"."forms_blocks_checkbox" to "service_role";

grant select on table "public"."forms_blocks_checkbox" to "service_role";

grant trigger on table "public"."forms_blocks_checkbox" to "service_role";

grant truncate on table "public"."forms_blocks_checkbox" to "service_role";

grant update on table "public"."forms_blocks_checkbox" to "service_role";

grant delete on table "public"."forms_blocks_country" to "anon";

grant insert on table "public"."forms_blocks_country" to "anon";

grant references on table "public"."forms_blocks_country" to "anon";

grant select on table "public"."forms_blocks_country" to "anon";

grant trigger on table "public"."forms_blocks_country" to "anon";

grant truncate on table "public"."forms_blocks_country" to "anon";

grant update on table "public"."forms_blocks_country" to "anon";

grant delete on table "public"."forms_blocks_country" to "authenticated";

grant insert on table "public"."forms_blocks_country" to "authenticated";

grant references on table "public"."forms_blocks_country" to "authenticated";

grant select on table "public"."forms_blocks_country" to "authenticated";

grant trigger on table "public"."forms_blocks_country" to "authenticated";

grant truncate on table "public"."forms_blocks_country" to "authenticated";

grant update on table "public"."forms_blocks_country" to "authenticated";

grant delete on table "public"."forms_blocks_country" to "service_role";

grant insert on table "public"."forms_blocks_country" to "service_role";

grant references on table "public"."forms_blocks_country" to "service_role";

grant select on table "public"."forms_blocks_country" to "service_role";

grant trigger on table "public"."forms_blocks_country" to "service_role";

grant truncate on table "public"."forms_blocks_country" to "service_role";

grant update on table "public"."forms_blocks_country" to "service_role";

grant delete on table "public"."forms_blocks_email" to "anon";

grant insert on table "public"."forms_blocks_email" to "anon";

grant references on table "public"."forms_blocks_email" to "anon";

grant select on table "public"."forms_blocks_email" to "anon";

grant trigger on table "public"."forms_blocks_email" to "anon";

grant truncate on table "public"."forms_blocks_email" to "anon";

grant update on table "public"."forms_blocks_email" to "anon";

grant delete on table "public"."forms_blocks_email" to "authenticated";

grant insert on table "public"."forms_blocks_email" to "authenticated";

grant references on table "public"."forms_blocks_email" to "authenticated";

grant select on table "public"."forms_blocks_email" to "authenticated";

grant trigger on table "public"."forms_blocks_email" to "authenticated";

grant truncate on table "public"."forms_blocks_email" to "authenticated";

grant update on table "public"."forms_blocks_email" to "authenticated";

grant delete on table "public"."forms_blocks_email" to "service_role";

grant insert on table "public"."forms_blocks_email" to "service_role";

grant references on table "public"."forms_blocks_email" to "service_role";

grant select on table "public"."forms_blocks_email" to "service_role";

grant trigger on table "public"."forms_blocks_email" to "service_role";

grant truncate on table "public"."forms_blocks_email" to "service_role";

grant update on table "public"."forms_blocks_email" to "service_role";

grant delete on table "public"."forms_blocks_message" to "anon";

grant insert on table "public"."forms_blocks_message" to "anon";

grant references on table "public"."forms_blocks_message" to "anon";

grant select on table "public"."forms_blocks_message" to "anon";

grant trigger on table "public"."forms_blocks_message" to "anon";

grant truncate on table "public"."forms_blocks_message" to "anon";

grant update on table "public"."forms_blocks_message" to "anon";

grant delete on table "public"."forms_blocks_message" to "authenticated";

grant insert on table "public"."forms_blocks_message" to "authenticated";

grant references on table "public"."forms_blocks_message" to "authenticated";

grant select on table "public"."forms_blocks_message" to "authenticated";

grant trigger on table "public"."forms_blocks_message" to "authenticated";

grant truncate on table "public"."forms_blocks_message" to "authenticated";

grant update on table "public"."forms_blocks_message" to "authenticated";

grant delete on table "public"."forms_blocks_message" to "service_role";

grant insert on table "public"."forms_blocks_message" to "service_role";

grant references on table "public"."forms_blocks_message" to "service_role";

grant select on table "public"."forms_blocks_message" to "service_role";

grant trigger on table "public"."forms_blocks_message" to "service_role";

grant truncate on table "public"."forms_blocks_message" to "service_role";

grant update on table "public"."forms_blocks_message" to "service_role";

grant delete on table "public"."forms_blocks_number" to "anon";

grant insert on table "public"."forms_blocks_number" to "anon";

grant references on table "public"."forms_blocks_number" to "anon";

grant select on table "public"."forms_blocks_number" to "anon";

grant trigger on table "public"."forms_blocks_number" to "anon";

grant truncate on table "public"."forms_blocks_number" to "anon";

grant update on table "public"."forms_blocks_number" to "anon";

grant delete on table "public"."forms_blocks_number" to "authenticated";

grant insert on table "public"."forms_blocks_number" to "authenticated";

grant references on table "public"."forms_blocks_number" to "authenticated";

grant select on table "public"."forms_blocks_number" to "authenticated";

grant trigger on table "public"."forms_blocks_number" to "authenticated";

grant truncate on table "public"."forms_blocks_number" to "authenticated";

grant update on table "public"."forms_blocks_number" to "authenticated";

grant delete on table "public"."forms_blocks_number" to "service_role";

grant insert on table "public"."forms_blocks_number" to "service_role";

grant references on table "public"."forms_blocks_number" to "service_role";

grant select on table "public"."forms_blocks_number" to "service_role";

grant trigger on table "public"."forms_blocks_number" to "service_role";

grant truncate on table "public"."forms_blocks_number" to "service_role";

grant update on table "public"."forms_blocks_number" to "service_role";

grant delete on table "public"."forms_blocks_select" to "anon";

grant insert on table "public"."forms_blocks_select" to "anon";

grant references on table "public"."forms_blocks_select" to "anon";

grant select on table "public"."forms_blocks_select" to "anon";

grant trigger on table "public"."forms_blocks_select" to "anon";

grant truncate on table "public"."forms_blocks_select" to "anon";

grant update on table "public"."forms_blocks_select" to "anon";

grant delete on table "public"."forms_blocks_select" to "authenticated";

grant insert on table "public"."forms_blocks_select" to "authenticated";

grant references on table "public"."forms_blocks_select" to "authenticated";

grant select on table "public"."forms_blocks_select" to "authenticated";

grant trigger on table "public"."forms_blocks_select" to "authenticated";

grant truncate on table "public"."forms_blocks_select" to "authenticated";

grant update on table "public"."forms_blocks_select" to "authenticated";

grant delete on table "public"."forms_blocks_select" to "service_role";

grant insert on table "public"."forms_blocks_select" to "service_role";

grant references on table "public"."forms_blocks_select" to "service_role";

grant select on table "public"."forms_blocks_select" to "service_role";

grant trigger on table "public"."forms_blocks_select" to "service_role";

grant truncate on table "public"."forms_blocks_select" to "service_role";

grant update on table "public"."forms_blocks_select" to "service_role";

grant delete on table "public"."forms_blocks_select_options" to "anon";

grant insert on table "public"."forms_blocks_select_options" to "anon";

grant references on table "public"."forms_blocks_select_options" to "anon";

grant select on table "public"."forms_blocks_select_options" to "anon";

grant trigger on table "public"."forms_blocks_select_options" to "anon";

grant truncate on table "public"."forms_blocks_select_options" to "anon";

grant update on table "public"."forms_blocks_select_options" to "anon";

grant delete on table "public"."forms_blocks_select_options" to "authenticated";

grant insert on table "public"."forms_blocks_select_options" to "authenticated";

grant references on table "public"."forms_blocks_select_options" to "authenticated";

grant select on table "public"."forms_blocks_select_options" to "authenticated";

grant trigger on table "public"."forms_blocks_select_options" to "authenticated";

grant truncate on table "public"."forms_blocks_select_options" to "authenticated";

grant update on table "public"."forms_blocks_select_options" to "authenticated";

grant delete on table "public"."forms_blocks_select_options" to "service_role";

grant insert on table "public"."forms_blocks_select_options" to "service_role";

grant references on table "public"."forms_blocks_select_options" to "service_role";

grant select on table "public"."forms_blocks_select_options" to "service_role";

grant trigger on table "public"."forms_blocks_select_options" to "service_role";

grant truncate on table "public"."forms_blocks_select_options" to "service_role";

grant update on table "public"."forms_blocks_select_options" to "service_role";

grant delete on table "public"."forms_blocks_state" to "anon";

grant insert on table "public"."forms_blocks_state" to "anon";

grant references on table "public"."forms_blocks_state" to "anon";

grant select on table "public"."forms_blocks_state" to "anon";

grant trigger on table "public"."forms_blocks_state" to "anon";

grant truncate on table "public"."forms_blocks_state" to "anon";

grant update on table "public"."forms_blocks_state" to "anon";

grant delete on table "public"."forms_blocks_state" to "authenticated";

grant insert on table "public"."forms_blocks_state" to "authenticated";

grant references on table "public"."forms_blocks_state" to "authenticated";

grant select on table "public"."forms_blocks_state" to "authenticated";

grant trigger on table "public"."forms_blocks_state" to "authenticated";

grant truncate on table "public"."forms_blocks_state" to "authenticated";

grant update on table "public"."forms_blocks_state" to "authenticated";

grant delete on table "public"."forms_blocks_state" to "service_role";

grant insert on table "public"."forms_blocks_state" to "service_role";

grant references on table "public"."forms_blocks_state" to "service_role";

grant select on table "public"."forms_blocks_state" to "service_role";

grant trigger on table "public"."forms_blocks_state" to "service_role";

grant truncate on table "public"."forms_blocks_state" to "service_role";

grant update on table "public"."forms_blocks_state" to "service_role";

grant delete on table "public"."forms_blocks_text" to "anon";

grant insert on table "public"."forms_blocks_text" to "anon";

grant references on table "public"."forms_blocks_text" to "anon";

grant select on table "public"."forms_blocks_text" to "anon";

grant trigger on table "public"."forms_blocks_text" to "anon";

grant truncate on table "public"."forms_blocks_text" to "anon";

grant update on table "public"."forms_blocks_text" to "anon";

grant delete on table "public"."forms_blocks_text" to "authenticated";

grant insert on table "public"."forms_blocks_text" to "authenticated";

grant references on table "public"."forms_blocks_text" to "authenticated";

grant select on table "public"."forms_blocks_text" to "authenticated";

grant trigger on table "public"."forms_blocks_text" to "authenticated";

grant truncate on table "public"."forms_blocks_text" to "authenticated";

grant update on table "public"."forms_blocks_text" to "authenticated";

grant delete on table "public"."forms_blocks_text" to "service_role";

grant insert on table "public"."forms_blocks_text" to "service_role";

grant references on table "public"."forms_blocks_text" to "service_role";

grant select on table "public"."forms_blocks_text" to "service_role";

grant trigger on table "public"."forms_blocks_text" to "service_role";

grant truncate on table "public"."forms_blocks_text" to "service_role";

grant update on table "public"."forms_blocks_text" to "service_role";

grant delete on table "public"."forms_blocks_textarea" to "anon";

grant insert on table "public"."forms_blocks_textarea" to "anon";

grant references on table "public"."forms_blocks_textarea" to "anon";

grant select on table "public"."forms_blocks_textarea" to "anon";

grant trigger on table "public"."forms_blocks_textarea" to "anon";

grant truncate on table "public"."forms_blocks_textarea" to "anon";

grant update on table "public"."forms_blocks_textarea" to "anon";

grant delete on table "public"."forms_blocks_textarea" to "authenticated";

grant insert on table "public"."forms_blocks_textarea" to "authenticated";

grant references on table "public"."forms_blocks_textarea" to "authenticated";

grant select on table "public"."forms_blocks_textarea" to "authenticated";

grant trigger on table "public"."forms_blocks_textarea" to "authenticated";

grant truncate on table "public"."forms_blocks_textarea" to "authenticated";

grant update on table "public"."forms_blocks_textarea" to "authenticated";

grant delete on table "public"."forms_blocks_textarea" to "service_role";

grant insert on table "public"."forms_blocks_textarea" to "service_role";

grant references on table "public"."forms_blocks_textarea" to "service_role";

grant select on table "public"."forms_blocks_textarea" to "service_role";

grant trigger on table "public"."forms_blocks_textarea" to "service_role";

grant truncate on table "public"."forms_blocks_textarea" to "service_role";

grant update on table "public"."forms_blocks_textarea" to "service_role";

grant delete on table "public"."forms_emails" to "anon";

grant insert on table "public"."forms_emails" to "anon";

grant references on table "public"."forms_emails" to "anon";

grant select on table "public"."forms_emails" to "anon";

grant trigger on table "public"."forms_emails" to "anon";

grant truncate on table "public"."forms_emails" to "anon";

grant update on table "public"."forms_emails" to "anon";

grant delete on table "public"."forms_emails" to "authenticated";

grant insert on table "public"."forms_emails" to "authenticated";

grant references on table "public"."forms_emails" to "authenticated";

grant select on table "public"."forms_emails" to "authenticated";

grant trigger on table "public"."forms_emails" to "authenticated";

grant truncate on table "public"."forms_emails" to "authenticated";

grant update on table "public"."forms_emails" to "authenticated";

grant delete on table "public"."forms_emails" to "service_role";

grant insert on table "public"."forms_emails" to "service_role";

grant references on table "public"."forms_emails" to "service_role";

grant select on table "public"."forms_emails" to "service_role";

grant trigger on table "public"."forms_emails" to "service_role";

grant truncate on table "public"."forms_emails" to "service_role";

grant update on table "public"."forms_emails" to "service_role";

grant delete on table "public"."header" to "anon";

grant insert on table "public"."header" to "anon";

grant references on table "public"."header" to "anon";

grant select on table "public"."header" to "anon";

grant trigger on table "public"."header" to "anon";

grant truncate on table "public"."header" to "anon";

grant update on table "public"."header" to "anon";

grant delete on table "public"."header" to "authenticated";

grant insert on table "public"."header" to "authenticated";

grant references on table "public"."header" to "authenticated";

grant select on table "public"."header" to "authenticated";

grant trigger on table "public"."header" to "authenticated";

grant truncate on table "public"."header" to "authenticated";

grant update on table "public"."header" to "authenticated";

grant delete on table "public"."header" to "service_role";

grant insert on table "public"."header" to "service_role";

grant references on table "public"."header" to "service_role";

grant select on table "public"."header" to "service_role";

grant trigger on table "public"."header" to "service_role";

grant truncate on table "public"."header" to "service_role";

grant update on table "public"."header" to "service_role";

grant delete on table "public"."header_links" to "anon";

grant insert on table "public"."header_links" to "anon";

grant references on table "public"."header_links" to "anon";

grant select on table "public"."header_links" to "anon";

grant trigger on table "public"."header_links" to "anon";

grant truncate on table "public"."header_links" to "anon";

grant update on table "public"."header_links" to "anon";

grant delete on table "public"."header_links" to "authenticated";

grant insert on table "public"."header_links" to "authenticated";

grant references on table "public"."header_links" to "authenticated";

grant select on table "public"."header_links" to "authenticated";

grant trigger on table "public"."header_links" to "authenticated";

grant truncate on table "public"."header_links" to "authenticated";

grant update on table "public"."header_links" to "authenticated";

grant delete on table "public"."header_links" to "service_role";

grant insert on table "public"."header_links" to "service_role";

grant references on table "public"."header_links" to "service_role";

grant select on table "public"."header_links" to "service_role";

grant trigger on table "public"."header_links" to "service_role";

grant truncate on table "public"."header_links" to "service_role";

grant update on table "public"."header_links" to "service_role";

grant delete on table "public"."header_links_children" to "anon";

grant insert on table "public"."header_links_children" to "anon";

grant references on table "public"."header_links_children" to "anon";

grant select on table "public"."header_links_children" to "anon";

grant trigger on table "public"."header_links_children" to "anon";

grant truncate on table "public"."header_links_children" to "anon";

grant update on table "public"."header_links_children" to "anon";

grant delete on table "public"."header_links_children" to "authenticated";

grant insert on table "public"."header_links_children" to "authenticated";

grant references on table "public"."header_links_children" to "authenticated";

grant select on table "public"."header_links_children" to "authenticated";

grant trigger on table "public"."header_links_children" to "authenticated";

grant truncate on table "public"."header_links_children" to "authenticated";

grant update on table "public"."header_links_children" to "authenticated";

grant delete on table "public"."header_links_children" to "service_role";

grant insert on table "public"."header_links_children" to "service_role";

grant references on table "public"."header_links_children" to "service_role";

grant select on table "public"."header_links_children" to "service_role";

grant trigger on table "public"."header_links_children" to "service_role";

grant truncate on table "public"."header_links_children" to "service_role";

grant update on table "public"."header_links_children" to "service_role";

grant delete on table "public"."header_rels" to "anon";

grant insert on table "public"."header_rels" to "anon";

grant references on table "public"."header_rels" to "anon";

grant select on table "public"."header_rels" to "anon";

grant trigger on table "public"."header_rels" to "anon";

grant truncate on table "public"."header_rels" to "anon";

grant update on table "public"."header_rels" to "anon";

grant delete on table "public"."header_rels" to "authenticated";

grant insert on table "public"."header_rels" to "authenticated";

grant references on table "public"."header_rels" to "authenticated";

grant select on table "public"."header_rels" to "authenticated";

grant trigger on table "public"."header_rels" to "authenticated";

grant truncate on table "public"."header_rels" to "authenticated";

grant update on table "public"."header_rels" to "authenticated";

grant delete on table "public"."header_rels" to "service_role";

grant insert on table "public"."header_rels" to "service_role";

grant references on table "public"."header_rels" to "service_role";

grant select on table "public"."header_rels" to "service_role";

grant trigger on table "public"."header_rels" to "service_role";

grant truncate on table "public"."header_rels" to "service_role";

grant update on table "public"."header_rels" to "service_role";

grant delete on table "public"."media" to "anon";

grant insert on table "public"."media" to "anon";

grant references on table "public"."media" to "anon";

grant select on table "public"."media" to "anon";

grant trigger on table "public"."media" to "anon";

grant truncate on table "public"."media" to "anon";

grant update on table "public"."media" to "anon";

grant delete on table "public"."media" to "authenticated";

grant insert on table "public"."media" to "authenticated";

grant references on table "public"."media" to "authenticated";

grant select on table "public"."media" to "authenticated";

grant trigger on table "public"."media" to "authenticated";

grant truncate on table "public"."media" to "authenticated";

grant update on table "public"."media" to "authenticated";

grant delete on table "public"."media" to "service_role";

grant insert on table "public"."media" to "service_role";

grant references on table "public"."media" to "service_role";

grant select on table "public"."media" to "service_role";

grant trigger on table "public"."media" to "service_role";

grant truncate on table "public"."media" to "service_role";

grant update on table "public"."media" to "service_role";

grant delete on table "public"."pages" to "anon";

grant insert on table "public"."pages" to "anon";

grant references on table "public"."pages" to "anon";

grant select on table "public"."pages" to "anon";

grant trigger on table "public"."pages" to "anon";

grant truncate on table "public"."pages" to "anon";

grant update on table "public"."pages" to "anon";

grant delete on table "public"."pages" to "authenticated";

grant insert on table "public"."pages" to "authenticated";

grant references on table "public"."pages" to "authenticated";

grant select on table "public"."pages" to "authenticated";

grant trigger on table "public"."pages" to "authenticated";

grant truncate on table "public"."pages" to "authenticated";

grant update on table "public"."pages" to "authenticated";

grant delete on table "public"."pages" to "service_role";

grant insert on table "public"."pages" to "service_role";

grant references on table "public"."pages" to "service_role";

grant select on table "public"."pages" to "service_role";

grant trigger on table "public"."pages" to "service_role";

grant truncate on table "public"."pages" to "service_role";

grant update on table "public"."pages" to "service_role";

grant delete on table "public"."pages_blocks_confetti_header" to "anon";

grant insert on table "public"."pages_blocks_confetti_header" to "anon";

grant references on table "public"."pages_blocks_confetti_header" to "anon";

grant select on table "public"."pages_blocks_confetti_header" to "anon";

grant trigger on table "public"."pages_blocks_confetti_header" to "anon";

grant truncate on table "public"."pages_blocks_confetti_header" to "anon";

grant update on table "public"."pages_blocks_confetti_header" to "anon";

grant delete on table "public"."pages_blocks_confetti_header" to "authenticated";

grant insert on table "public"."pages_blocks_confetti_header" to "authenticated";

grant references on table "public"."pages_blocks_confetti_header" to "authenticated";

grant select on table "public"."pages_blocks_confetti_header" to "authenticated";

grant trigger on table "public"."pages_blocks_confetti_header" to "authenticated";

grant truncate on table "public"."pages_blocks_confetti_header" to "authenticated";

grant update on table "public"."pages_blocks_confetti_header" to "authenticated";

grant delete on table "public"."pages_blocks_confetti_header" to "service_role";

grant insert on table "public"."pages_blocks_confetti_header" to "service_role";

grant references on table "public"."pages_blocks_confetti_header" to "service_role";

grant select on table "public"."pages_blocks_confetti_header" to "service_role";

grant trigger on table "public"."pages_blocks_confetti_header" to "service_role";

grant truncate on table "public"."pages_blocks_confetti_header" to "service_role";

grant update on table "public"."pages_blocks_confetti_header" to "service_role";

grant delete on table "public"."pages_blocks_cover" to "anon";

grant insert on table "public"."pages_blocks_cover" to "anon";

grant references on table "public"."pages_blocks_cover" to "anon";

grant select on table "public"."pages_blocks_cover" to "anon";

grant trigger on table "public"."pages_blocks_cover" to "anon";

grant truncate on table "public"."pages_blocks_cover" to "anon";

grant update on table "public"."pages_blocks_cover" to "anon";

grant delete on table "public"."pages_blocks_cover" to "authenticated";

grant insert on table "public"."pages_blocks_cover" to "authenticated";

grant references on table "public"."pages_blocks_cover" to "authenticated";

grant select on table "public"."pages_blocks_cover" to "authenticated";

grant trigger on table "public"."pages_blocks_cover" to "authenticated";

grant truncate on table "public"."pages_blocks_cover" to "authenticated";

grant update on table "public"."pages_blocks_cover" to "authenticated";

grant delete on table "public"."pages_blocks_cover" to "service_role";

grant insert on table "public"."pages_blocks_cover" to "service_role";

grant references on table "public"."pages_blocks_cover" to "service_role";

grant select on table "public"."pages_blocks_cover" to "service_role";

grant trigger on table "public"."pages_blocks_cover" to "service_role";

grant truncate on table "public"."pages_blocks_cover" to "service_role";

grant update on table "public"."pages_blocks_cover" to "service_role";

grant delete on table "public"."pages_blocks_form_block" to "anon";

grant insert on table "public"."pages_blocks_form_block" to "anon";

grant references on table "public"."pages_blocks_form_block" to "anon";

grant select on table "public"."pages_blocks_form_block" to "anon";

grant trigger on table "public"."pages_blocks_form_block" to "anon";

grant truncate on table "public"."pages_blocks_form_block" to "anon";

grant update on table "public"."pages_blocks_form_block" to "anon";

grant delete on table "public"."pages_blocks_form_block" to "authenticated";

grant insert on table "public"."pages_blocks_form_block" to "authenticated";

grant references on table "public"."pages_blocks_form_block" to "authenticated";

grant select on table "public"."pages_blocks_form_block" to "authenticated";

grant trigger on table "public"."pages_blocks_form_block" to "authenticated";

grant truncate on table "public"."pages_blocks_form_block" to "authenticated";

grant update on table "public"."pages_blocks_form_block" to "authenticated";

grant delete on table "public"."pages_blocks_form_block" to "service_role";

grant insert on table "public"."pages_blocks_form_block" to "service_role";

grant references on table "public"."pages_blocks_form_block" to "service_role";

grant select on table "public"."pages_blocks_form_block" to "service_role";

grant trigger on table "public"."pages_blocks_form_block" to "service_role";

grant truncate on table "public"."pages_blocks_form_block" to "service_role";

grant update on table "public"."pages_blocks_form_block" to "service_role";

grant delete on table "public"."pages_blocks_github_globe" to "anon";

grant insert on table "public"."pages_blocks_github_globe" to "anon";

grant references on table "public"."pages_blocks_github_globe" to "anon";

grant select on table "public"."pages_blocks_github_globe" to "anon";

grant trigger on table "public"."pages_blocks_github_globe" to "anon";

grant truncate on table "public"."pages_blocks_github_globe" to "anon";

grant update on table "public"."pages_blocks_github_globe" to "anon";

grant delete on table "public"."pages_blocks_github_globe" to "authenticated";

grant insert on table "public"."pages_blocks_github_globe" to "authenticated";

grant references on table "public"."pages_blocks_github_globe" to "authenticated";

grant select on table "public"."pages_blocks_github_globe" to "authenticated";

grant trigger on table "public"."pages_blocks_github_globe" to "authenticated";

grant truncate on table "public"."pages_blocks_github_globe" to "authenticated";

grant update on table "public"."pages_blocks_github_globe" to "authenticated";

grant delete on table "public"."pages_blocks_github_globe" to "service_role";

grant insert on table "public"."pages_blocks_github_globe" to "service_role";

grant references on table "public"."pages_blocks_github_globe" to "service_role";

grant select on table "public"."pages_blocks_github_globe" to "service_role";

grant trigger on table "public"."pages_blocks_github_globe" to "service_role";

grant truncate on table "public"."pages_blocks_github_globe" to "service_role";

grant update on table "public"."pages_blocks_github_globe" to "service_role";

grant delete on table "public"."pages_blocks_hero_highlight" to "anon";

grant insert on table "public"."pages_blocks_hero_highlight" to "anon";

grant references on table "public"."pages_blocks_hero_highlight" to "anon";

grant select on table "public"."pages_blocks_hero_highlight" to "anon";

grant trigger on table "public"."pages_blocks_hero_highlight" to "anon";

grant truncate on table "public"."pages_blocks_hero_highlight" to "anon";

grant update on table "public"."pages_blocks_hero_highlight" to "anon";

grant delete on table "public"."pages_blocks_hero_highlight" to "authenticated";

grant insert on table "public"."pages_blocks_hero_highlight" to "authenticated";

grant references on table "public"."pages_blocks_hero_highlight" to "authenticated";

grant select on table "public"."pages_blocks_hero_highlight" to "authenticated";

grant trigger on table "public"."pages_blocks_hero_highlight" to "authenticated";

grant truncate on table "public"."pages_blocks_hero_highlight" to "authenticated";

grant update on table "public"."pages_blocks_hero_highlight" to "authenticated";

grant delete on table "public"."pages_blocks_hero_highlight" to "service_role";

grant insert on table "public"."pages_blocks_hero_highlight" to "service_role";

grant references on table "public"."pages_blocks_hero_highlight" to "service_role";

grant select on table "public"."pages_blocks_hero_highlight" to "service_role";

grant trigger on table "public"."pages_blocks_hero_highlight" to "service_role";

grant truncate on table "public"."pages_blocks_hero_highlight" to "service_role";

grant update on table "public"."pages_blocks_hero_highlight" to "service_role";

grant delete on table "public"."pages_blocks_image" to "anon";

grant insert on table "public"."pages_blocks_image" to "anon";

grant references on table "public"."pages_blocks_image" to "anon";

grant select on table "public"."pages_blocks_image" to "anon";

grant trigger on table "public"."pages_blocks_image" to "anon";

grant truncate on table "public"."pages_blocks_image" to "anon";

grant update on table "public"."pages_blocks_image" to "anon";

grant delete on table "public"."pages_blocks_image" to "authenticated";

grant insert on table "public"."pages_blocks_image" to "authenticated";

grant references on table "public"."pages_blocks_image" to "authenticated";

grant select on table "public"."pages_blocks_image" to "authenticated";

grant trigger on table "public"."pages_blocks_image" to "authenticated";

grant truncate on table "public"."pages_blocks_image" to "authenticated";

grant update on table "public"."pages_blocks_image" to "authenticated";

grant delete on table "public"."pages_blocks_image" to "service_role";

grant insert on table "public"."pages_blocks_image" to "service_role";

grant references on table "public"."pages_blocks_image" to "service_role";

grant select on table "public"."pages_blocks_image" to "service_role";

grant trigger on table "public"."pages_blocks_image" to "service_role";

grant truncate on table "public"."pages_blocks_image" to "service_role";

grant update on table "public"."pages_blocks_image" to "service_role";

grant delete on table "public"."pages_blocks_infinite_moving_cards" to "anon";

grant insert on table "public"."pages_blocks_infinite_moving_cards" to "anon";

grant references on table "public"."pages_blocks_infinite_moving_cards" to "anon";

grant select on table "public"."pages_blocks_infinite_moving_cards" to "anon";

grant trigger on table "public"."pages_blocks_infinite_moving_cards" to "anon";

grant truncate on table "public"."pages_blocks_infinite_moving_cards" to "anon";

grant update on table "public"."pages_blocks_infinite_moving_cards" to "anon";

grant delete on table "public"."pages_blocks_infinite_moving_cards" to "authenticated";

grant insert on table "public"."pages_blocks_infinite_moving_cards" to "authenticated";

grant references on table "public"."pages_blocks_infinite_moving_cards" to "authenticated";

grant select on table "public"."pages_blocks_infinite_moving_cards" to "authenticated";

grant trigger on table "public"."pages_blocks_infinite_moving_cards" to "authenticated";

grant truncate on table "public"."pages_blocks_infinite_moving_cards" to "authenticated";

grant update on table "public"."pages_blocks_infinite_moving_cards" to "authenticated";

grant delete on table "public"."pages_blocks_infinite_moving_cards" to "service_role";

grant insert on table "public"."pages_blocks_infinite_moving_cards" to "service_role";

grant references on table "public"."pages_blocks_infinite_moving_cards" to "service_role";

grant select on table "public"."pages_blocks_infinite_moving_cards" to "service_role";

grant trigger on table "public"."pages_blocks_infinite_moving_cards" to "service_role";

grant truncate on table "public"."pages_blocks_infinite_moving_cards" to "service_role";

grant update on table "public"."pages_blocks_infinite_moving_cards" to "service_role";

grant delete on table "public"."pages_blocks_infinite_moving_cards_cards" to "anon";

grant insert on table "public"."pages_blocks_infinite_moving_cards_cards" to "anon";

grant references on table "public"."pages_blocks_infinite_moving_cards_cards" to "anon";

grant select on table "public"."pages_blocks_infinite_moving_cards_cards" to "anon";

grant trigger on table "public"."pages_blocks_infinite_moving_cards_cards" to "anon";

grant truncate on table "public"."pages_blocks_infinite_moving_cards_cards" to "anon";

grant update on table "public"."pages_blocks_infinite_moving_cards_cards" to "anon";

grant delete on table "public"."pages_blocks_infinite_moving_cards_cards" to "authenticated";

grant insert on table "public"."pages_blocks_infinite_moving_cards_cards" to "authenticated";

grant references on table "public"."pages_blocks_infinite_moving_cards_cards" to "authenticated";

grant select on table "public"."pages_blocks_infinite_moving_cards_cards" to "authenticated";

grant trigger on table "public"."pages_blocks_infinite_moving_cards_cards" to "authenticated";

grant truncate on table "public"."pages_blocks_infinite_moving_cards_cards" to "authenticated";

grant update on table "public"."pages_blocks_infinite_moving_cards_cards" to "authenticated";

grant delete on table "public"."pages_blocks_infinite_moving_cards_cards" to "service_role";

grant insert on table "public"."pages_blocks_infinite_moving_cards_cards" to "service_role";

grant references on table "public"."pages_blocks_infinite_moving_cards_cards" to "service_role";

grant select on table "public"."pages_blocks_infinite_moving_cards_cards" to "service_role";

grant trigger on table "public"."pages_blocks_infinite_moving_cards_cards" to "service_role";

grant truncate on table "public"."pages_blocks_infinite_moving_cards_cards" to "service_role";

grant update on table "public"."pages_blocks_infinite_moving_cards_cards" to "service_role";

grant delete on table "public"."pages_blocks_links_preview" to "anon";

grant insert on table "public"."pages_blocks_links_preview" to "anon";

grant references on table "public"."pages_blocks_links_preview" to "anon";

grant select on table "public"."pages_blocks_links_preview" to "anon";

grant trigger on table "public"."pages_blocks_links_preview" to "anon";

grant truncate on table "public"."pages_blocks_links_preview" to "anon";

grant update on table "public"."pages_blocks_links_preview" to "anon";

grant delete on table "public"."pages_blocks_links_preview" to "authenticated";

grant insert on table "public"."pages_blocks_links_preview" to "authenticated";

grant references on table "public"."pages_blocks_links_preview" to "authenticated";

grant select on table "public"."pages_blocks_links_preview" to "authenticated";

grant trigger on table "public"."pages_blocks_links_preview" to "authenticated";

grant truncate on table "public"."pages_blocks_links_preview" to "authenticated";

grant update on table "public"."pages_blocks_links_preview" to "authenticated";

grant delete on table "public"."pages_blocks_links_preview" to "service_role";

grant insert on table "public"."pages_blocks_links_preview" to "service_role";

grant references on table "public"."pages_blocks_links_preview" to "service_role";

grant select on table "public"."pages_blocks_links_preview" to "service_role";

grant trigger on table "public"."pages_blocks_links_preview" to "service_role";

grant truncate on table "public"."pages_blocks_links_preview" to "service_role";

grant update on table "public"."pages_blocks_links_preview" to "service_role";

grant delete on table "public"."pages_blocks_links_preview_rows" to "anon";

grant insert on table "public"."pages_blocks_links_preview_rows" to "anon";

grant references on table "public"."pages_blocks_links_preview_rows" to "anon";

grant select on table "public"."pages_blocks_links_preview_rows" to "anon";

grant trigger on table "public"."pages_blocks_links_preview_rows" to "anon";

grant truncate on table "public"."pages_blocks_links_preview_rows" to "anon";

grant update on table "public"."pages_blocks_links_preview_rows" to "anon";

grant delete on table "public"."pages_blocks_links_preview_rows" to "authenticated";

grant insert on table "public"."pages_blocks_links_preview_rows" to "authenticated";

grant references on table "public"."pages_blocks_links_preview_rows" to "authenticated";

grant select on table "public"."pages_blocks_links_preview_rows" to "authenticated";

grant trigger on table "public"."pages_blocks_links_preview_rows" to "authenticated";

grant truncate on table "public"."pages_blocks_links_preview_rows" to "authenticated";

grant update on table "public"."pages_blocks_links_preview_rows" to "authenticated";

grant delete on table "public"."pages_blocks_links_preview_rows" to "service_role";

grant insert on table "public"."pages_blocks_links_preview_rows" to "service_role";

grant references on table "public"."pages_blocks_links_preview_rows" to "service_role";

grant select on table "public"."pages_blocks_links_preview_rows" to "service_role";

grant trigger on table "public"."pages_blocks_links_preview_rows" to "service_role";

grant truncate on table "public"."pages_blocks_links_preview_rows" to "service_role";

grant update on table "public"."pages_blocks_links_preview_rows" to "service_role";

grant delete on table "public"."pages_blocks_rich_text" to "anon";

grant insert on table "public"."pages_blocks_rich_text" to "anon";

grant references on table "public"."pages_blocks_rich_text" to "anon";

grant select on table "public"."pages_blocks_rich_text" to "anon";

grant trigger on table "public"."pages_blocks_rich_text" to "anon";

grant truncate on table "public"."pages_blocks_rich_text" to "anon";

grant update on table "public"."pages_blocks_rich_text" to "anon";

grant delete on table "public"."pages_blocks_rich_text" to "authenticated";

grant insert on table "public"."pages_blocks_rich_text" to "authenticated";

grant references on table "public"."pages_blocks_rich_text" to "authenticated";

grant select on table "public"."pages_blocks_rich_text" to "authenticated";

grant trigger on table "public"."pages_blocks_rich_text" to "authenticated";

grant truncate on table "public"."pages_blocks_rich_text" to "authenticated";

grant update on table "public"."pages_blocks_rich_text" to "authenticated";

grant delete on table "public"."pages_blocks_rich_text" to "service_role";

grant insert on table "public"."pages_blocks_rich_text" to "service_role";

grant references on table "public"."pages_blocks_rich_text" to "service_role";

grant select on table "public"."pages_blocks_rich_text" to "service_role";

grant trigger on table "public"."pages_blocks_rich_text" to "service_role";

grant truncate on table "public"."pages_blocks_rich_text" to "service_role";

grant update on table "public"."pages_blocks_rich_text" to "service_role";

grant delete on table "public"."pages_blocks_spotlight" to "anon";

grant insert on table "public"."pages_blocks_spotlight" to "anon";

grant references on table "public"."pages_blocks_spotlight" to "anon";

grant select on table "public"."pages_blocks_spotlight" to "anon";

grant trigger on table "public"."pages_blocks_spotlight" to "anon";

grant truncate on table "public"."pages_blocks_spotlight" to "anon";

grant update on table "public"."pages_blocks_spotlight" to "anon";

grant delete on table "public"."pages_blocks_spotlight" to "authenticated";

grant insert on table "public"."pages_blocks_spotlight" to "authenticated";

grant references on table "public"."pages_blocks_spotlight" to "authenticated";

grant select on table "public"."pages_blocks_spotlight" to "authenticated";

grant trigger on table "public"."pages_blocks_spotlight" to "authenticated";

grant truncate on table "public"."pages_blocks_spotlight" to "authenticated";

grant update on table "public"."pages_blocks_spotlight" to "authenticated";

grant delete on table "public"."pages_blocks_spotlight" to "service_role";

grant insert on table "public"."pages_blocks_spotlight" to "service_role";

grant references on table "public"."pages_blocks_spotlight" to "service_role";

grant select on table "public"."pages_blocks_spotlight" to "service_role";

grant trigger on table "public"."pages_blocks_spotlight" to "service_role";

grant truncate on table "public"."pages_blocks_spotlight" to "service_role";

grant update on table "public"."pages_blocks_spotlight" to "service_role";

grant delete on table "public"."pages_blocks_text_effect" to "anon";

grant insert on table "public"."pages_blocks_text_effect" to "anon";

grant references on table "public"."pages_blocks_text_effect" to "anon";

grant select on table "public"."pages_blocks_text_effect" to "anon";

grant trigger on table "public"."pages_blocks_text_effect" to "anon";

grant truncate on table "public"."pages_blocks_text_effect" to "anon";

grant update on table "public"."pages_blocks_text_effect" to "anon";

grant delete on table "public"."pages_blocks_text_effect" to "authenticated";

grant insert on table "public"."pages_blocks_text_effect" to "authenticated";

grant references on table "public"."pages_blocks_text_effect" to "authenticated";

grant select on table "public"."pages_blocks_text_effect" to "authenticated";

grant trigger on table "public"."pages_blocks_text_effect" to "authenticated";

grant truncate on table "public"."pages_blocks_text_effect" to "authenticated";

grant update on table "public"."pages_blocks_text_effect" to "authenticated";

grant delete on table "public"."pages_blocks_text_effect" to "service_role";

grant insert on table "public"."pages_blocks_text_effect" to "service_role";

grant references on table "public"."pages_blocks_text_effect" to "service_role";

grant select on table "public"."pages_blocks_text_effect" to "service_role";

grant trigger on table "public"."pages_blocks_text_effect" to "service_role";

grant truncate on table "public"."pages_blocks_text_effect" to "service_role";

grant update on table "public"."pages_blocks_text_effect" to "service_role";

grant delete on table "public"."pages_blocks_text_image" to "anon";

grant insert on table "public"."pages_blocks_text_image" to "anon";

grant references on table "public"."pages_blocks_text_image" to "anon";

grant select on table "public"."pages_blocks_text_image" to "anon";

grant trigger on table "public"."pages_blocks_text_image" to "anon";

grant truncate on table "public"."pages_blocks_text_image" to "anon";

grant update on table "public"."pages_blocks_text_image" to "anon";

grant delete on table "public"."pages_blocks_text_image" to "authenticated";

grant insert on table "public"."pages_blocks_text_image" to "authenticated";

grant references on table "public"."pages_blocks_text_image" to "authenticated";

grant select on table "public"."pages_blocks_text_image" to "authenticated";

grant trigger on table "public"."pages_blocks_text_image" to "authenticated";

grant truncate on table "public"."pages_blocks_text_image" to "authenticated";

grant update on table "public"."pages_blocks_text_image" to "authenticated";

grant delete on table "public"."pages_blocks_text_image" to "service_role";

grant insert on table "public"."pages_blocks_text_image" to "service_role";

grant references on table "public"."pages_blocks_text_image" to "service_role";

grant select on table "public"."pages_blocks_text_image" to "service_role";

grant trigger on table "public"."pages_blocks_text_image" to "service_role";

grant truncate on table "public"."pages_blocks_text_image" to "service_role";

grant update on table "public"."pages_blocks_text_image" to "service_role";

grant delete on table "public"."pages_blocks_text_image_buttons" to "anon";

grant insert on table "public"."pages_blocks_text_image_buttons" to "anon";

grant references on table "public"."pages_blocks_text_image_buttons" to "anon";

grant select on table "public"."pages_blocks_text_image_buttons" to "anon";

grant trigger on table "public"."pages_blocks_text_image_buttons" to "anon";

grant truncate on table "public"."pages_blocks_text_image_buttons" to "anon";

grant update on table "public"."pages_blocks_text_image_buttons" to "anon";

grant delete on table "public"."pages_blocks_text_image_buttons" to "authenticated";

grant insert on table "public"."pages_blocks_text_image_buttons" to "authenticated";

grant references on table "public"."pages_blocks_text_image_buttons" to "authenticated";

grant select on table "public"."pages_blocks_text_image_buttons" to "authenticated";

grant trigger on table "public"."pages_blocks_text_image_buttons" to "authenticated";

grant truncate on table "public"."pages_blocks_text_image_buttons" to "authenticated";

grant update on table "public"."pages_blocks_text_image_buttons" to "authenticated";

grant delete on table "public"."pages_blocks_text_image_buttons" to "service_role";

grant insert on table "public"."pages_blocks_text_image_buttons" to "service_role";

grant references on table "public"."pages_blocks_text_image_buttons" to "service_role";

grant select on table "public"."pages_blocks_text_image_buttons" to "service_role";

grant trigger on table "public"."pages_blocks_text_image_buttons" to "service_role";

grant truncate on table "public"."pages_blocks_text_image_buttons" to "service_role";

grant update on table "public"."pages_blocks_text_image_buttons" to "service_role";

grant delete on table "public"."pages_blocks_tik_tac_toe" to "anon";

grant insert on table "public"."pages_blocks_tik_tac_toe" to "anon";

grant references on table "public"."pages_blocks_tik_tac_toe" to "anon";

grant select on table "public"."pages_blocks_tik_tac_toe" to "anon";

grant trigger on table "public"."pages_blocks_tik_tac_toe" to "anon";

grant truncate on table "public"."pages_blocks_tik_tac_toe" to "anon";

grant update on table "public"."pages_blocks_tik_tac_toe" to "anon";

grant delete on table "public"."pages_blocks_tik_tac_toe" to "authenticated";

grant insert on table "public"."pages_blocks_tik_tac_toe" to "authenticated";

grant references on table "public"."pages_blocks_tik_tac_toe" to "authenticated";

grant select on table "public"."pages_blocks_tik_tac_toe" to "authenticated";

grant trigger on table "public"."pages_blocks_tik_tac_toe" to "authenticated";

grant truncate on table "public"."pages_blocks_tik_tac_toe" to "authenticated";

grant update on table "public"."pages_blocks_tik_tac_toe" to "authenticated";

grant delete on table "public"."pages_blocks_tik_tac_toe" to "service_role";

grant insert on table "public"."pages_blocks_tik_tac_toe" to "service_role";

grant references on table "public"."pages_blocks_tik_tac_toe" to "service_role";

grant select on table "public"."pages_blocks_tik_tac_toe" to "service_role";

grant trigger on table "public"."pages_blocks_tik_tac_toe" to "service_role";

grant truncate on table "public"."pages_blocks_tik_tac_toe" to "service_role";

grant update on table "public"."pages_blocks_tik_tac_toe" to "service_role";

grant delete on table "public"."pages_rels" to "anon";

grant insert on table "public"."pages_rels" to "anon";

grant references on table "public"."pages_rels" to "anon";

grant select on table "public"."pages_rels" to "anon";

grant trigger on table "public"."pages_rels" to "anon";

grant truncate on table "public"."pages_rels" to "anon";

grant update on table "public"."pages_rels" to "anon";

grant delete on table "public"."pages_rels" to "authenticated";

grant insert on table "public"."pages_rels" to "authenticated";

grant references on table "public"."pages_rels" to "authenticated";

grant select on table "public"."pages_rels" to "authenticated";

grant trigger on table "public"."pages_rels" to "authenticated";

grant truncate on table "public"."pages_rels" to "authenticated";

grant update on table "public"."pages_rels" to "authenticated";

grant delete on table "public"."pages_rels" to "service_role";

grant insert on table "public"."pages_rels" to "service_role";

grant references on table "public"."pages_rels" to "service_role";

grant select on table "public"."pages_rels" to "service_role";

grant trigger on table "public"."pages_rels" to "service_role";

grant truncate on table "public"."pages_rels" to "service_role";

grant update on table "public"."pages_rels" to "service_role";

grant delete on table "public"."payload_locked_documents" to "anon";

grant insert on table "public"."payload_locked_documents" to "anon";

grant references on table "public"."payload_locked_documents" to "anon";

grant select on table "public"."payload_locked_documents" to "anon";

grant trigger on table "public"."payload_locked_documents" to "anon";

grant truncate on table "public"."payload_locked_documents" to "anon";

grant update on table "public"."payload_locked_documents" to "anon";

grant delete on table "public"."payload_locked_documents" to "authenticated";

grant insert on table "public"."payload_locked_documents" to "authenticated";

grant references on table "public"."payload_locked_documents" to "authenticated";

grant select on table "public"."payload_locked_documents" to "authenticated";

grant trigger on table "public"."payload_locked_documents" to "authenticated";

grant truncate on table "public"."payload_locked_documents" to "authenticated";

grant update on table "public"."payload_locked_documents" to "authenticated";

grant delete on table "public"."payload_locked_documents" to "service_role";

grant insert on table "public"."payload_locked_documents" to "service_role";

grant references on table "public"."payload_locked_documents" to "service_role";

grant select on table "public"."payload_locked_documents" to "service_role";

grant trigger on table "public"."payload_locked_documents" to "service_role";

grant truncate on table "public"."payload_locked_documents" to "service_role";

grant update on table "public"."payload_locked_documents" to "service_role";

grant delete on table "public"."payload_locked_documents_rels" to "anon";

grant insert on table "public"."payload_locked_documents_rels" to "anon";

grant references on table "public"."payload_locked_documents_rels" to "anon";

grant select on table "public"."payload_locked_documents_rels" to "anon";

grant trigger on table "public"."payload_locked_documents_rels" to "anon";

grant truncate on table "public"."payload_locked_documents_rels" to "anon";

grant update on table "public"."payload_locked_documents_rels" to "anon";

grant delete on table "public"."payload_locked_documents_rels" to "authenticated";

grant insert on table "public"."payload_locked_documents_rels" to "authenticated";

grant references on table "public"."payload_locked_documents_rels" to "authenticated";

grant select on table "public"."payload_locked_documents_rels" to "authenticated";

grant trigger on table "public"."payload_locked_documents_rels" to "authenticated";

grant truncate on table "public"."payload_locked_documents_rels" to "authenticated";

grant update on table "public"."payload_locked_documents_rels" to "authenticated";

grant delete on table "public"."payload_locked_documents_rels" to "service_role";

grant insert on table "public"."payload_locked_documents_rels" to "service_role";

grant references on table "public"."payload_locked_documents_rels" to "service_role";

grant select on table "public"."payload_locked_documents_rels" to "service_role";

grant trigger on table "public"."payload_locked_documents_rels" to "service_role";

grant truncate on table "public"."payload_locked_documents_rels" to "service_role";

grant update on table "public"."payload_locked_documents_rels" to "service_role";

grant delete on table "public"."payload_migrations" to "anon";

grant insert on table "public"."payload_migrations" to "anon";

grant references on table "public"."payload_migrations" to "anon";

grant select on table "public"."payload_migrations" to "anon";

grant trigger on table "public"."payload_migrations" to "anon";

grant truncate on table "public"."payload_migrations" to "anon";

grant update on table "public"."payload_migrations" to "anon";

grant delete on table "public"."payload_migrations" to "authenticated";

grant insert on table "public"."payload_migrations" to "authenticated";

grant references on table "public"."payload_migrations" to "authenticated";

grant select on table "public"."payload_migrations" to "authenticated";

grant trigger on table "public"."payload_migrations" to "authenticated";

grant truncate on table "public"."payload_migrations" to "authenticated";

grant update on table "public"."payload_migrations" to "authenticated";

grant delete on table "public"."payload_migrations" to "service_role";

grant insert on table "public"."payload_migrations" to "service_role";

grant references on table "public"."payload_migrations" to "service_role";

grant select on table "public"."payload_migrations" to "service_role";

grant trigger on table "public"."payload_migrations" to "service_role";

grant truncate on table "public"."payload_migrations" to "service_role";

grant update on table "public"."payload_migrations" to "service_role";

grant delete on table "public"."payload_preferences" to "anon";

grant insert on table "public"."payload_preferences" to "anon";

grant references on table "public"."payload_preferences" to "anon";

grant select on table "public"."payload_preferences" to "anon";

grant trigger on table "public"."payload_preferences" to "anon";

grant truncate on table "public"."payload_preferences" to "anon";

grant update on table "public"."payload_preferences" to "anon";

grant delete on table "public"."payload_preferences" to "authenticated";

grant insert on table "public"."payload_preferences" to "authenticated";

grant references on table "public"."payload_preferences" to "authenticated";

grant select on table "public"."payload_preferences" to "authenticated";

grant trigger on table "public"."payload_preferences" to "authenticated";

grant truncate on table "public"."payload_preferences" to "authenticated";

grant update on table "public"."payload_preferences" to "authenticated";

grant delete on table "public"."payload_preferences" to "service_role";

grant insert on table "public"."payload_preferences" to "service_role";

grant references on table "public"."payload_preferences" to "service_role";

grant select on table "public"."payload_preferences" to "service_role";

grant trigger on table "public"."payload_preferences" to "service_role";

grant truncate on table "public"."payload_preferences" to "service_role";

grant update on table "public"."payload_preferences" to "service_role";

grant delete on table "public"."payload_preferences_rels" to "anon";

grant insert on table "public"."payload_preferences_rels" to "anon";

grant references on table "public"."payload_preferences_rels" to "anon";

grant select on table "public"."payload_preferences_rels" to "anon";

grant trigger on table "public"."payload_preferences_rels" to "anon";

grant truncate on table "public"."payload_preferences_rels" to "anon";

grant update on table "public"."payload_preferences_rels" to "anon";

grant delete on table "public"."payload_preferences_rels" to "authenticated";

grant insert on table "public"."payload_preferences_rels" to "authenticated";

grant references on table "public"."payload_preferences_rels" to "authenticated";

grant select on table "public"."payload_preferences_rels" to "authenticated";

grant trigger on table "public"."payload_preferences_rels" to "authenticated";

grant truncate on table "public"."payload_preferences_rels" to "authenticated";

grant update on table "public"."payload_preferences_rels" to "authenticated";

grant delete on table "public"."payload_preferences_rels" to "service_role";

grant insert on table "public"."payload_preferences_rels" to "service_role";

grant references on table "public"."payload_preferences_rels" to "service_role";

grant select on table "public"."payload_preferences_rels" to "service_role";

grant trigger on table "public"."payload_preferences_rels" to "service_role";

grant truncate on table "public"."payload_preferences_rels" to "service_role";

grant update on table "public"."payload_preferences_rels" to "service_role";

grant delete on table "public"."posts" to "anon";

grant insert on table "public"."posts" to "anon";

grant references on table "public"."posts" to "anon";

grant select on table "public"."posts" to "anon";

grant trigger on table "public"."posts" to "anon";

grant truncate on table "public"."posts" to "anon";

grant update on table "public"."posts" to "anon";

grant delete on table "public"."posts" to "authenticated";

grant insert on table "public"."posts" to "authenticated";

grant references on table "public"."posts" to "authenticated";

grant select on table "public"."posts" to "authenticated";

grant trigger on table "public"."posts" to "authenticated";

grant truncate on table "public"."posts" to "authenticated";

grant update on table "public"."posts" to "authenticated";

grant delete on table "public"."posts" to "service_role";

grant insert on table "public"."posts" to "service_role";

grant references on table "public"."posts" to "service_role";

grant select on table "public"."posts" to "service_role";

grant trigger on table "public"."posts" to "service_role";

grant truncate on table "public"."posts" to "service_role";

grant update on table "public"."posts" to "service_role";

grant delete on table "public"."posts_populated_authors" to "anon";

grant insert on table "public"."posts_populated_authors" to "anon";

grant references on table "public"."posts_populated_authors" to "anon";

grant select on table "public"."posts_populated_authors" to "anon";

grant trigger on table "public"."posts_populated_authors" to "anon";

grant truncate on table "public"."posts_populated_authors" to "anon";

grant update on table "public"."posts_populated_authors" to "anon";

grant delete on table "public"."posts_populated_authors" to "authenticated";

grant insert on table "public"."posts_populated_authors" to "authenticated";

grant references on table "public"."posts_populated_authors" to "authenticated";

grant select on table "public"."posts_populated_authors" to "authenticated";

grant trigger on table "public"."posts_populated_authors" to "authenticated";

grant truncate on table "public"."posts_populated_authors" to "authenticated";

grant update on table "public"."posts_populated_authors" to "authenticated";

grant delete on table "public"."posts_populated_authors" to "service_role";

grant insert on table "public"."posts_populated_authors" to "service_role";

grant references on table "public"."posts_populated_authors" to "service_role";

grant select on table "public"."posts_populated_authors" to "service_role";

grant trigger on table "public"."posts_populated_authors" to "service_role";

grant truncate on table "public"."posts_populated_authors" to "service_role";

grant update on table "public"."posts_populated_authors" to "service_role";

grant delete on table "public"."posts_rels" to "anon";

grant insert on table "public"."posts_rels" to "anon";

grant references on table "public"."posts_rels" to "anon";

grant select on table "public"."posts_rels" to "anon";

grant trigger on table "public"."posts_rels" to "anon";

grant truncate on table "public"."posts_rels" to "anon";

grant update on table "public"."posts_rels" to "anon";

grant delete on table "public"."posts_rels" to "authenticated";

grant insert on table "public"."posts_rels" to "authenticated";

grant references on table "public"."posts_rels" to "authenticated";

grant select on table "public"."posts_rels" to "authenticated";

grant trigger on table "public"."posts_rels" to "authenticated";

grant truncate on table "public"."posts_rels" to "authenticated";

grant update on table "public"."posts_rels" to "authenticated";

grant delete on table "public"."posts_rels" to "service_role";

grant insert on table "public"."posts_rels" to "service_role";

grant references on table "public"."posts_rels" to "service_role";

grant select on table "public"."posts_rels" to "service_role";

grant trigger on table "public"."posts_rels" to "service_role";

grant truncate on table "public"."posts_rels" to "service_role";

grant update on table "public"."posts_rels" to "service_role";

grant delete on table "public"."redirects" to "anon";

grant insert on table "public"."redirects" to "anon";

grant references on table "public"."redirects" to "anon";

grant select on table "public"."redirects" to "anon";

grant trigger on table "public"."redirects" to "anon";

grant truncate on table "public"."redirects" to "anon";

grant update on table "public"."redirects" to "anon";

grant delete on table "public"."redirects" to "authenticated";

grant insert on table "public"."redirects" to "authenticated";

grant references on table "public"."redirects" to "authenticated";

grant select on table "public"."redirects" to "authenticated";

grant trigger on table "public"."redirects" to "authenticated";

grant truncate on table "public"."redirects" to "authenticated";

grant update on table "public"."redirects" to "authenticated";

grant delete on table "public"."redirects" to "service_role";

grant insert on table "public"."redirects" to "service_role";

grant references on table "public"."redirects" to "service_role";

grant select on table "public"."redirects" to "service_role";

grant trigger on table "public"."redirects" to "service_role";

grant truncate on table "public"."redirects" to "service_role";

grant update on table "public"."redirects" to "service_role";

grant delete on table "public"."redirects_rels" to "anon";

grant insert on table "public"."redirects_rels" to "anon";

grant references on table "public"."redirects_rels" to "anon";

grant select on table "public"."redirects_rels" to "anon";

grant trigger on table "public"."redirects_rels" to "anon";

grant truncate on table "public"."redirects_rels" to "anon";

grant update on table "public"."redirects_rels" to "anon";

grant delete on table "public"."redirects_rels" to "authenticated";

grant insert on table "public"."redirects_rels" to "authenticated";

grant references on table "public"."redirects_rels" to "authenticated";

grant select on table "public"."redirects_rels" to "authenticated";

grant trigger on table "public"."redirects_rels" to "authenticated";

grant truncate on table "public"."redirects_rels" to "authenticated";

grant update on table "public"."redirects_rels" to "authenticated";

grant delete on table "public"."redirects_rels" to "service_role";

grant insert on table "public"."redirects_rels" to "service_role";

grant references on table "public"."redirects_rels" to "service_role";

grant select on table "public"."redirects_rels" to "service_role";

grant trigger on table "public"."redirects_rels" to "service_role";

grant truncate on table "public"."redirects_rels" to "service_role";

grant update on table "public"."redirects_rels" to "service_role";

grant delete on table "public"."users" to "anon";

grant insert on table "public"."users" to "anon";

grant references on table "public"."users" to "anon";

grant select on table "public"."users" to "anon";

grant trigger on table "public"."users" to "anon";

grant truncate on table "public"."users" to "anon";

grant update on table "public"."users" to "anon";

grant delete on table "public"."users" to "authenticated";

grant insert on table "public"."users" to "authenticated";

grant references on table "public"."users" to "authenticated";

grant select on table "public"."users" to "authenticated";

grant trigger on table "public"."users" to "authenticated";

grant truncate on table "public"."users" to "authenticated";

grant update on table "public"."users" to "authenticated";

grant delete on table "public"."users" to "service_role";

grant insert on table "public"."users" to "service_role";

grant references on table "public"."users" to "service_role";

grant select on table "public"."users" to "service_role";

grant trigger on table "public"."users" to "service_role";

grant truncate on table "public"."users" to "service_role";

grant update on table "public"."users" to "service_role";


