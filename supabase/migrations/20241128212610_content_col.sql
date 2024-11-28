drop index if exists "public"."_pages_v_autosave_idx";

drop index if exists "public"."_pages_v_blocks_form_block_form_idx";

drop index if exists "public"."_pages_v_blocks_image_image_idx";

drop index if exists "public"."_pages_v_blocks_text_image_image_idx";

drop index if exists "public"."_pages_v_created_at_idx";

drop index if exists "public"."_pages_v_latest_idx";

drop index if exists "public"."_pages_v_parent_idx";

drop index if exists "public"."_pages_v_rels_pages_id_idx";

drop index if exists "public"."_pages_v_updated_at_idx";

drop index if exists "public"."_pages_v_version_meta_version_meta_image_idx";

drop index if exists "public"."_pages_v_version_version__status_idx";

drop index if exists "public"."_pages_v_version_version_created_at_idx";

drop index if exists "public"."_pages_v_version_version_created_by_idx";

drop index if exists "public"."_pages_v_version_version_slug_idx";

drop index if exists "public"."_pages_v_version_version_updated_at_idx";

drop index if exists "public"."_posts_v_autosave_idx";

drop index if exists "public"."_posts_v_created_at_idx";

drop index if exists "public"."_posts_v_latest_idx";

drop index if exists "public"."_posts_v_parent_idx";

drop index if exists "public"."_posts_v_rels_categories_id_idx";

drop index if exists "public"."_posts_v_rels_posts_id_idx";

drop index if exists "public"."_posts_v_rels_users_id_idx";

drop index if exists "public"."_posts_v_updated_at_idx";

drop index if exists "public"."_posts_v_version_meta_version_meta_image_idx";

drop index if exists "public"."_posts_v_version_version__status_idx";

drop index if exists "public"."_posts_v_version_version_created_at_idx";

drop index if exists "public"."_posts_v_version_version_slug_idx";

drop index if exists "public"."_posts_v_version_version_updated_at_idx";

drop index if exists "public"."categories_created_at_idx";

drop index if exists "public"."categories_updated_at_idx";

drop index if exists "public"."footer_logo_idx";

drop index if exists "public"."footer_rels_pages_id_idx";

drop index if exists "public"."form_submissions_created_at_idx";

drop index if exists "public"."form_submissions_form_idx";

drop index if exists "public"."form_submissions_updated_at_idx";

drop index if exists "public"."forms_created_at_idx";

drop index if exists "public"."forms_updated_at_idx";

drop index if exists "public"."header_logo_idx";

drop index if exists "public"."header_rels_pages_id_idx";

drop index if exists "public"."media_created_at_idx";

drop index if exists "public"."media_filename_idx";

drop index if exists "public"."media_updated_at_idx";

drop index if exists "public"."pages__status_idx";

drop index if exists "public"."pages_blocks_form_block_form_idx";

drop index if exists "public"."pages_blocks_image_image_idx";

drop index if exists "public"."pages_blocks_text_image_image_idx";

drop index if exists "public"."pages_created_at_idx";

drop index if exists "public"."pages_created_by_idx";

drop index if exists "public"."pages_meta_meta_image_idx";

drop index if exists "public"."pages_rels_pages_id_idx";

drop index if exists "public"."pages_slug_idx";

drop index if exists "public"."pages_updated_at_idx";

drop index if exists "public"."payload_locked_documents_created_at_idx";

drop index if exists "public"."payload_locked_documents_global_slug_idx";

drop index if exists "public"."payload_locked_documents_rels_categories_id_idx";

drop index if exists "public"."payload_locked_documents_rels_form_submissions_id_idx";

drop index if exists "public"."payload_locked_documents_rels_forms_id_idx";

drop index if exists "public"."payload_locked_documents_rels_media_id_idx";

drop index if exists "public"."payload_locked_documents_rels_pages_id_idx";

drop index if exists "public"."payload_locked_documents_rels_posts_id_idx";

drop index if exists "public"."payload_locked_documents_rels_redirects_id_idx";

drop index if exists "public"."payload_locked_documents_rels_users_id_idx";

drop index if exists "public"."payload_locked_documents_updated_at_idx";

drop index if exists "public"."payload_migrations_created_at_idx";

drop index if exists "public"."payload_migrations_updated_at_idx";

drop index if exists "public"."payload_preferences_created_at_idx";

drop index if exists "public"."payload_preferences_key_idx";

drop index if exists "public"."payload_preferences_rels_users_id_idx";

drop index if exists "public"."payload_preferences_updated_at_idx";

drop index if exists "public"."posts__status_idx";

drop index if exists "public"."posts_created_at_idx";

drop index if exists "public"."posts_meta_meta_image_idx";

drop index if exists "public"."posts_rels_categories_id_idx";

drop index if exists "public"."posts_rels_posts_id_idx";

drop index if exists "public"."posts_rels_users_id_idx";

drop index if exists "public"."posts_slug_idx";

drop index if exists "public"."posts_updated_at_idx";

drop index if exists "public"."redirects_created_at_idx";

drop index if exists "public"."redirects_from_idx";

drop index if exists "public"."redirects_rels_pages_id_idx";

drop index if exists "public"."redirects_updated_at_idx";

drop index if exists "public"."users_created_at_idx";

drop index if exists "public"."users_email_idx";

drop index if exists "public"."users_updated_at_idx";

alter table "public"."_pages_v_blocks_text_image" add column "content" character varying;

alter table "public"."pages_blocks_text_image" add column "content" character varying;

CREATE INDEX _pages_v_autosave_2_idx ON public._pages_v USING btree (autosave);

CREATE INDEX _pages_v_blocks_form_block_form_2_idx ON public._pages_v_blocks_form_block USING btree (form_id);

CREATE INDEX _pages_v_blocks_image_image_2_idx ON public._pages_v_blocks_image USING btree (image_id);

CREATE INDEX _pages_v_blocks_text_image_image_2_idx ON public._pages_v_blocks_text_image USING btree (image_id);

CREATE INDEX _pages_v_created_at_2_idx ON public._pages_v USING btree (created_at);

CREATE INDEX _pages_v_latest_2_idx ON public._pages_v USING btree (latest);

CREATE INDEX _pages_v_parent_2_idx ON public._pages_v USING btree (parent_id);

CREATE INDEX _pages_v_rels_pages_id_2_idx ON public._pages_v_rels USING btree (pages_id);

CREATE INDEX _pages_v_updated_at_2_idx ON public._pages_v USING btree (updated_at);

CREATE INDEX _pages_v_version_meta_version_meta_image_2_idx ON public._pages_v USING btree (version_meta_image_id);

CREATE INDEX _pages_v_version_version__status_2_idx ON public._pages_v USING btree (version__status);

CREATE INDEX _pages_v_version_version_created_at_2_idx ON public._pages_v USING btree (version_created_at);

CREATE INDEX _pages_v_version_version_created_by_2_idx ON public._pages_v USING btree (version_created_by_id);

CREATE INDEX _pages_v_version_version_slug_2_idx ON public._pages_v USING btree (version_slug);

CREATE INDEX _pages_v_version_version_updated_at_2_idx ON public._pages_v USING btree (version_updated_at);

CREATE INDEX _posts_v_autosave_2_idx ON public._posts_v USING btree (autosave);

CREATE INDEX _posts_v_created_at_2_idx ON public._posts_v USING btree (created_at);

CREATE INDEX _posts_v_latest_2_idx ON public._posts_v USING btree (latest);

CREATE INDEX _posts_v_parent_2_idx ON public._posts_v USING btree (parent_id);

CREATE INDEX _posts_v_rels_categories_id_2_idx ON public._posts_v_rels USING btree (categories_id);

CREATE INDEX _posts_v_rels_posts_id_2_idx ON public._posts_v_rels USING btree (posts_id);

CREATE INDEX _posts_v_rels_users_id_2_idx ON public._posts_v_rels USING btree (users_id);

CREATE INDEX _posts_v_updated_at_2_idx ON public._posts_v USING btree (updated_at);

CREATE INDEX _posts_v_version_meta_version_meta_image_2_idx ON public._posts_v USING btree (version_meta_image_id);

CREATE INDEX _posts_v_version_version__status_2_idx ON public._posts_v USING btree (version__status);

CREATE INDEX _posts_v_version_version_created_at_2_idx ON public._posts_v USING btree (version_created_at);

CREATE INDEX _posts_v_version_version_slug_2_idx ON public._posts_v USING btree (version_slug);

CREATE INDEX _posts_v_version_version_updated_at_2_idx ON public._posts_v USING btree (version_updated_at);

CREATE INDEX categories_created_at_2_idx ON public.categories USING btree (created_at);

CREATE INDEX categories_updated_at_2_idx ON public.categories USING btree (updated_at);

CREATE INDEX footer_logo_2_idx ON public.footer USING btree (logo_id);

CREATE INDEX footer_rels_pages_id_2_idx ON public.footer_rels USING btree (pages_id);

CREATE INDEX form_submissions_created_at_2_idx ON public.form_submissions USING btree (created_at);

CREATE INDEX form_submissions_form_2_idx ON public.form_submissions USING btree (form_id);

CREATE INDEX form_submissions_updated_at_2_idx ON public.form_submissions USING btree (updated_at);

CREATE INDEX forms_created_at_2_idx ON public.forms USING btree (created_at);

CREATE INDEX forms_updated_at_2_idx ON public.forms USING btree (updated_at);

CREATE INDEX header_logo_2_idx ON public.header USING btree (logo_id);

CREATE INDEX header_rels_pages_id_2_idx ON public.header_rels USING btree (pages_id);

CREATE INDEX media_created_at_2_idx ON public.media USING btree (created_at);

CREATE UNIQUE INDEX media_filename_2_idx ON public.media USING btree (filename);

CREATE INDEX media_updated_at_2_idx ON public.media USING btree (updated_at);

CREATE INDEX pages__status_2_idx ON public.pages USING btree (_status);

CREATE INDEX pages_blocks_form_block_form_2_idx ON public.pages_blocks_form_block USING btree (form_id);

CREATE INDEX pages_blocks_image_image_2_idx ON public.pages_blocks_image USING btree (image_id);

CREATE INDEX pages_blocks_text_image_image_2_idx ON public.pages_blocks_text_image USING btree (image_id);

CREATE INDEX pages_created_at_2_idx ON public.pages USING btree (created_at);

CREATE INDEX pages_created_by_2_idx ON public.pages USING btree (created_by_id);

CREATE INDEX pages_meta_meta_image_2_idx ON public.pages USING btree (meta_image_id);

CREATE INDEX pages_rels_pages_id_2_idx ON public.pages_rels USING btree (pages_id);

CREATE INDEX pages_slug_2_idx ON public.pages USING btree (slug);

CREATE INDEX pages_updated_at_2_idx ON public.pages USING btree (updated_at);

CREATE INDEX payload_locked_documents_created_at_2_idx ON public.payload_locked_documents USING btree (created_at);

CREATE INDEX payload_locked_documents_global_slug_2_idx ON public.payload_locked_documents USING btree (global_slug);

CREATE INDEX payload_locked_documents_rels_categories_id_2_idx ON public.payload_locked_documents_rels USING btree (categories_id);

CREATE INDEX payload_locked_documents_rels_form_submissions_id_2_idx ON public.payload_locked_documents_rels USING btree (form_submissions_id);

CREATE INDEX payload_locked_documents_rels_forms_id_2_idx ON public.payload_locked_documents_rels USING btree (forms_id);

CREATE INDEX payload_locked_documents_rels_media_id_2_idx ON public.payload_locked_documents_rels USING btree (media_id);

CREATE INDEX payload_locked_documents_rels_pages_id_2_idx ON public.payload_locked_documents_rels USING btree (pages_id);

CREATE INDEX payload_locked_documents_rels_posts_id_2_idx ON public.payload_locked_documents_rels USING btree (posts_id);

CREATE INDEX payload_locked_documents_rels_redirects_id_2_idx ON public.payload_locked_documents_rels USING btree (redirects_id);

CREATE INDEX payload_locked_documents_rels_users_id_2_idx ON public.payload_locked_documents_rels USING btree (users_id);

CREATE INDEX payload_locked_documents_updated_at_2_idx ON public.payload_locked_documents USING btree (updated_at);

CREATE INDEX payload_migrations_created_at_2_idx ON public.payload_migrations USING btree (created_at);

CREATE INDEX payload_migrations_updated_at_2_idx ON public.payload_migrations USING btree (updated_at);

CREATE INDEX payload_preferences_created_at_2_idx ON public.payload_preferences USING btree (created_at);

CREATE INDEX payload_preferences_key_2_idx ON public.payload_preferences USING btree (key);

CREATE INDEX payload_preferences_rels_users_id_2_idx ON public.payload_preferences_rels USING btree (users_id);

CREATE INDEX payload_preferences_updated_at_2_idx ON public.payload_preferences USING btree (updated_at);

CREATE INDEX posts__status_2_idx ON public.posts USING btree (_status);

CREATE INDEX posts_created_at_2_idx ON public.posts USING btree (created_at);

CREATE INDEX posts_meta_meta_image_2_idx ON public.posts USING btree (meta_image_id);

CREATE INDEX posts_rels_categories_id_2_idx ON public.posts_rels USING btree (categories_id);

CREATE INDEX posts_rels_posts_id_2_idx ON public.posts_rels USING btree (posts_id);

CREATE INDEX posts_rels_users_id_2_idx ON public.posts_rels USING btree (users_id);

CREATE INDEX posts_slug_2_idx ON public.posts USING btree (slug);

CREATE INDEX posts_updated_at_2_idx ON public.posts USING btree (updated_at);

CREATE INDEX redirects_created_at_2_idx ON public.redirects USING btree (created_at);

CREATE INDEX redirects_from_2_idx ON public.redirects USING btree ("from");

CREATE INDEX redirects_rels_pages_id_2_idx ON public.redirects_rels USING btree (pages_id);

CREATE INDEX redirects_updated_at_2_idx ON public.redirects USING btree (updated_at);

CREATE INDEX users_created_at_2_idx ON public.users USING btree (created_at);

CREATE UNIQUE INDEX users_email_2_idx ON public.users USING btree (email);

CREATE INDEX users_updated_at_2_idx ON public.users USING btree (updated_at);


