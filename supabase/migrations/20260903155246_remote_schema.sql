SET local check_function_bodies = off;

ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" REVOKE ALL ON SEQUENCES FROM "anon";

ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" REVOKE ALL ON SEQUENCES FROM "authenticated";

ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" REVOKE ALL ON SEQUENCES FROM "service_role";

ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" REVOKE ALL ON FUNCTIONS FROM "anon";

ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" REVOKE ALL ON FUNCTIONS FROM "authenticated";

ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" REVOKE ALL ON FUNCTIONS FROM "service_role";

ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" REVOKE ALL ON TABLES FROM "anon";

ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" REVOKE ALL ON TABLES FROM "authenticated";

ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" REVOKE ALL ON TABLES FROM "service_role";

CREATE TABLE "public"."creature_locations" (
  "id"              text NOT NULL,
  "creature_id"     text NOT NULL,
  "location_id"     text NOT NULL,
  "occurrence_type" text NOT NULL,
  "confidence"      text NOT NULL,
  CONSTRAINT "creature_locations_pkey" PRIMARY KEY (id)
);

ALTER TABLE "public"."creature_locations"
  ENABLE ROW LEVEL SECURITY;

CREATE TABLE "public"."creatures" (
  "id"                text                     NOT NULL,
  "scientific_name"   text                     NOT NULL,
  "display_name"      text                     NOT NULL,
  "slug"              text                     NOT NULL,
  "taxon_rank"        text                     NOT NULL,
  "short_description" text,
  "profile_image_url" text,
  "is_active"         boolean                  NOT NULL DEFAULT true,
  "created_at"        timestamp with time zone NOT NULL DEFAULT now(),
  CONSTRAINT "creatures_pkey" PRIMARY KEY (id),
  CONSTRAINT "creatures_slug_key" UNIQUE (slug)
);

ALTER TABLE "public"."creatures"
  ENABLE ROW LEVEL SECURITY;

CREATE TABLE "public"."ecology" (
  "id"               text    NOT NULL,
  "creature_id"      text    NOT NULL,
  "diet"             text    NOT NULL,
  "feeding_strategy" text,
  "locomotion"       text    NOT NULL,
  "length_min_m"     numeric,
  "length_max_m"     numeric,
  "mass_min_kg"      numeric,
  "mass_max_kg"      numeric,
  "habitat_summary"  text,
  CONSTRAINT "ecology_pkey" PRIMARY KEY (id)
);

ALTER TABLE "public"."ecology"
  ENABLE ROW LEVEL SECURITY;

CREATE TABLE "public"."locations" (
  "id"            text NOT NULL,
  "name"          text NOT NULL,
  "location_type" text NOT NULL,
  "modern_region" text,
  "description"   text,
  CONSTRAINT "locations_pkey" PRIMARY KEY (id)
);

ALTER TABLE "public"."locations"
  ENABLE ROW LEVEL SECURITY;

CREATE TABLE "public"."relationships" (
  "id"                  text NOT NULL,
  "subject_creature_id" text NOT NULL,
  "object_creature_id"  text NOT NULL,
  "relationship_type"   text NOT NULL,
  "confidence"          text NOT NULL,
  "evidence_summary"    text,
  "source_id"           text,
  CONSTRAINT "relationships_pkey" PRIMARY KEY (id)
);

ALTER TABLE "public"."relationships"
  ENABLE ROW LEVEL SECURITY;

CREATE TABLE "public"."scientific_sources" (
  "id"               text    NOT NULL,
  "title"            text    NOT NULL,
  "authors"          text,
  "publication_year" integer,
  "publisher"        text,
  "url"              text,
  "doi"              text,
  "source_type"      text    NOT NULL,
  CONSTRAINT "scientific_sources_pkey" PRIMARY KEY (id)
);

ALTER TABLE "public"."scientific_sources"
  ENABLE ROW LEVEL SECURITY;

CREATE TABLE "public"."taxonomy" (
  "id"          text NOT NULL,
  "creature_id" text NOT NULL,
  "phylum"      text NOT NULL,
  "class"       text NOT NULL,
  "order_name"  text NOT NULL,
  "family"      text NOT NULL,
  "genus"       text NOT NULL,
  "species"     text,
  "kingdom"     text NOT NULL,
  CONSTRAINT "taxonomy_pkey" PRIMARY KEY (id)
);

ALTER TABLE "public"."taxonomy"
  ENABLE ROW LEVEL SECURITY;

CREATE TABLE "public"."temporal_ranges" (
  "id"          text    NOT NULL,
  "creature_id" text    NOT NULL,
  "max_ma"      numeric NOT NULL,
  "min_ma"      numeric NOT NULL,
  "era"         text    NOT NULL,
  "period"      text    NOT NULL,
  "epoch"       text    NOT NULL,
  "stage"       text,
  CONSTRAINT "temporal_ranges_pkey" PRIMARY KEY (id)
);

ALTER TABLE "public"."temporal_ranges"
  ENABLE ROW LEVEL SECURITY;

CREATE OR REPLACE FUNCTION public.rls_auto_enable()
  RETURNS event_trigger
  LANGUAGE plpgsql
  SECURITY DEFINER
  SET search_path TO 'pg_catalog'
  AS $function$
DECLARE
  cmd record;
BEGIN
  FOR cmd IN
    SELECT *
    FROM pg_event_trigger_ddl_commands()
    WHERE command_tag IN ('CREATE TABLE', 'CREATE TABLE AS', 'SELECT INTO')
      AND object_type IN ('table','partitioned table')
  LOOP
     IF cmd.schema_name IS NOT NULL AND cmd.schema_name IN ('public') AND cmd.schema_name NOT IN ('pg_catalog','information_schema') AND cmd.schema_name NOT LIKE 'pg_toast%' AND cmd.schema_name NOT LIKE 'pg_temp%' THEN
      BEGIN
        EXECUTE format('alter table if exists %s enable row level security', cmd.object_identity);
        RAISE LOG 'rls_auto_enable: enabled RLS on %', cmd.object_identity;
      EXCEPTION
        WHEN OTHERS THEN
          RAISE LOG 'rls_auto_enable: failed to enable RLS on %', cmd.object_identity;
      END;
     ELSE
        RAISE LOG 'rls_auto_enable: skip % (either system schema or not in enforced list: %.)', cmd.object_identity, cmd.schema_name;
     END IF;
  END LOOP;
END;
$function$;

ALTER TABLE "public"."creature_locations"
  ADD CONSTRAINT "creature_locations_creature_id_fkey" FOREIGN KEY (creature_id) REFERENCES public.creatures(id) ON UPDATE CASCADE ON DELETE RESTRICT;

ALTER TABLE "public"."ecology"
  ADD CONSTRAINT "ecology_creature_id_fkey" FOREIGN KEY (creature_id) REFERENCES public.creatures(id) ON UPDATE CASCADE ON DELETE RESTRICT;

ALTER TABLE "public"."creature_locations"
  ADD CONSTRAINT "creature_locations_location_id_fkey" FOREIGN KEY (location_id) REFERENCES public.locations(id) ON UPDATE CASCADE ON DELETE RESTRICT;

ALTER TABLE "public"."relationships"
  ADD CONSTRAINT "relationships_object_creature_id_fkey" FOREIGN KEY (object_creature_id) REFERENCES public.creatures(id) ON UPDATE CASCADE ON DELETE RESTRICT;

ALTER TABLE "public"."relationships"
  ADD CONSTRAINT "relationships_subject_creature_id_fkey" FOREIGN KEY (subject_creature_id) REFERENCES public.creatures(id) ON UPDATE CASCADE ON DELETE RESTRICT;

ALTER TABLE "public"."relationships"
  ADD CONSTRAINT "relationships_source_id_fkey" FOREIGN KEY (source_id) REFERENCES public.scientific_sources(id) ON UPDATE CASCADE ON DELETE RESTRICT;

ALTER TABLE "public"."taxonomy"
  ADD CONSTRAINT "taxonomy_creature_id_fkey" FOREIGN KEY (creature_id) REFERENCES public.creatures(id) ON UPDATE CASCADE ON DELETE RESTRICT;

ALTER TABLE "public"."temporal_ranges"
  ADD CONSTRAINT "temporal_ranges_creature_id_fkey" FOREIGN KEY (creature_id) REFERENCES public.creatures(id) ON UPDATE CASCADE ON DELETE RESTRICT;

CREATE EVENT TRIGGER "ensure_rls"
  ON ddl_command_end
  WHEN TAG IN ('CREATE TABLE', 'CREATE TABLE AS', 'SELECT INTO')
  EXECUTE FUNCTION "public"."rls_auto_enable"();

GRANT EXECUTE ON FUNCTION "public"."rls_auto_enable"() TO PUBLIC, "postgres";

GRANT MAINTAIN, REFERENCES, TRIGGER, TRUNCATE ON TABLE "public"."creature_locations" TO "anon", "authenticated";

GRANT DELETE, INSERT, MAINTAIN, REFERENCES, SELECT, TRIGGER, TRUNCATE, UPDATE ON TABLE "public"."creature_locations" TO "postgres";

GRANT MAINTAIN, REFERENCES, TRIGGER, TRUNCATE ON TABLE "public"."creature_locations" TO "service_role";

GRANT MAINTAIN, REFERENCES, TRIGGER, TRUNCATE ON TABLE "public"."creatures" TO "anon", "authenticated";

GRANT DELETE, INSERT, MAINTAIN, REFERENCES, SELECT, TRIGGER, TRUNCATE, UPDATE ON TABLE "public"."creatures" TO "postgres";

GRANT MAINTAIN, REFERENCES, TRIGGER, TRUNCATE ON TABLE "public"."creatures" TO "service_role";

GRANT MAINTAIN, REFERENCES, TRIGGER, TRUNCATE ON TABLE "public"."ecology" TO "anon", "authenticated";

GRANT DELETE, INSERT, MAINTAIN, REFERENCES, SELECT, TRIGGER, TRUNCATE, UPDATE ON TABLE "public"."ecology" TO "postgres";

GRANT MAINTAIN, REFERENCES, TRIGGER, TRUNCATE ON TABLE "public"."ecology" TO "service_role";

GRANT MAINTAIN, REFERENCES, TRIGGER, TRUNCATE ON TABLE "public"."locations" TO "anon", "authenticated";

GRANT DELETE, INSERT, MAINTAIN, REFERENCES, SELECT, TRIGGER, TRUNCATE, UPDATE ON TABLE "public"."locations" TO "postgres";

GRANT MAINTAIN, REFERENCES, TRIGGER, TRUNCATE ON TABLE "public"."locations" TO "service_role";

GRANT MAINTAIN, REFERENCES, TRIGGER, TRUNCATE ON TABLE "public"."relationships" TO "anon", "authenticated";

GRANT DELETE, INSERT, MAINTAIN, REFERENCES, SELECT, TRIGGER, TRUNCATE, UPDATE ON TABLE "public"."relationships" TO "postgres";

GRANT MAINTAIN, REFERENCES, TRIGGER, TRUNCATE ON TABLE "public"."relationships" TO "service_role";

GRANT MAINTAIN, REFERENCES, TRIGGER, TRUNCATE ON TABLE "public"."scientific_sources" TO "anon", "authenticated";

GRANT DELETE, INSERT, MAINTAIN, REFERENCES, SELECT, TRIGGER, TRUNCATE, UPDATE ON TABLE "public"."scientific_sources" TO "postgres";

GRANT MAINTAIN, REFERENCES, TRIGGER, TRUNCATE ON TABLE "public"."scientific_sources" TO "service_role";

GRANT MAINTAIN, REFERENCES, TRIGGER, TRUNCATE ON TABLE "public"."taxonomy" TO "anon", "authenticated";

GRANT DELETE, INSERT, MAINTAIN, REFERENCES, SELECT, TRIGGER, TRUNCATE, UPDATE ON TABLE "public"."taxonomy" TO "postgres";

GRANT MAINTAIN, REFERENCES, TRIGGER, TRUNCATE ON TABLE "public"."taxonomy" TO "service_role";

GRANT MAINTAIN, REFERENCES, TRIGGER, TRUNCATE ON TABLE "public"."temporal_ranges" TO "anon", "authenticated";

GRANT DELETE, INSERT, MAINTAIN, REFERENCES, SELECT, TRIGGER, TRUNCATE, UPDATE ON TABLE "public"."temporal_ranges" TO "postgres";

GRANT MAINTAIN, REFERENCES, TRIGGER, TRUNCATE ON TABLE "public"."temporal_ranges" TO "service_role";

ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT MAINTAIN, REFERENCES, TRIGGER, TRUNCATE ON TABLES TO "anon";

ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT MAINTAIN, REFERENCES, TRIGGER, TRUNCATE ON TABLES TO "authenticated";

ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT MAINTAIN, REFERENCES, TRIGGER, TRUNCATE ON TABLES TO "service_role";

