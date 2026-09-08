CREATE TABLE "public"."creature_relationship_dynamics" (
  "id"                  text                     NOT NULL,
  "subject_creature_id" text                     NOT NULL,
  "object_creature_id"  text                     NOT NULL,
  "relationship_label"  text                     NOT NULL,
  "trust"               integer                  NOT NULL DEFAULT 0,
  "respect"             integer                  NOT NULL DEFAULT 0,
  "fear"                integer                  NOT NULL DEFAULT 0,
  "annoyance"           integer                  NOT NULL DEFAULT 0,
  "affection"           integer                  NOT NULL DEFAULT 0,
  "rivalry"             integer                  NOT NULL DEFAULT 0,
  "protectiveness"      integer                  NOT NULL DEFAULT 0,
  "interaction_style"   text,
  "private_opinion"     text,
  "shared_lore"         text,
  "created_at"          timestamp with time zone NOT NULL DEFAULT now(),
  CONSTRAINT "creature_relationship_dynamics_affection_check" CHECK (((affection >= 0) AND (affection <= 10))),
  CONSTRAINT "creature_relationship_dynamics_annoyance_check" CHECK (((annoyance >= 0) AND (annoyance <= 10))),
  CONSTRAINT "creature_relationship_dynamics_fear_check" CHECK (((fear >= 0) AND (fear <= 10))),
  CONSTRAINT "creature_relationship_dynamics_no_self" CHECK ((subject_creature_id <> object_creature_id)),
  CONSTRAINT "creature_relationship_dynamics_pkey" PRIMARY KEY (id),
  CONSTRAINT "creature_relationship_dynamics_protectiveness_check" CHECK (((protectiveness >= 0) AND (protectiveness <= 10))),
  CONSTRAINT "creature_relationship_dynamics_respect_check" CHECK (((respect >= 0) AND (respect <= 10))),
  CONSTRAINT "creature_relationship_dynamics_rivalry_check" CHECK (((rivalry >= 0) AND (rivalry <= 10))),
  CONSTRAINT "creature_relationship_dynamics_trust_check" CHECK (((trust >= 0) AND (trust <= 10))),
  CONSTRAINT "creature_relationship_dynamics_unique_direction" UNIQUE (subject_creature_id, object_creature_id)
);

ALTER TABLE "public"."creature_relationship_dynamics"
  ENABLE ROW LEVEL SECURITY;

CREATE TABLE "public"."personas" (
  "id"                  text                     NOT NULL,
  "creature_id"         text                     NOT NULL,
  "username"            text,
  "bio"                 text,
  "personality_summary" text                     NOT NULL,
  "core_traits"         text[]                   NOT NULL,
  "speech_style"        text                     NOT NULL,
  "humor_style"         text,
  "social_style"        text,
  "friendliness"        text,
  "temperament"         text,
  "likes"               text[],
  "dislikes"            text[],
  "fears"               text[],
  "quirks"              text[],
  "boundaries"          text[],
  "roleplay_rules"      text[],
  "lore_notes"          text,
  "created_at"          timestamp with time zone NOT NULL DEFAULT now(),
  CONSTRAINT "personas_creature_id_key" UNIQUE (creature_id),
  CONSTRAINT "personas_pkey" PRIMARY KEY (id)
);

ALTER TABLE "public"."personas"
  ENABLE ROW LEVEL SECURITY;

ALTER TABLE "public"."creature_relationship_dynamics"
  ADD CONSTRAINT "creature_relationship_dynamics_object_creature_id_fkey" FOREIGN KEY (object_creature_id) REFERENCES public.creatures(id) ON UPDATE CASCADE ON DELETE RESTRICT;

ALTER TABLE "public"."creature_relationship_dynamics"
  ADD CONSTRAINT "creature_relationship_dynamics_subject_creature_id_fkey" FOREIGN KEY (subject_creature_id) REFERENCES public.creatures(id) ON UPDATE CASCADE ON DELETE RESTRICT;

ALTER TABLE "public"."personas"
  ADD CONSTRAINT "personas_creature_id_fkey" FOREIGN KEY (creature_id) REFERENCES public.creatures(id) ON UPDATE CASCADE ON DELETE RESTRICT;

GRANT MAINTAIN, REFERENCES, TRIGGER, TRUNCATE ON TABLE "public"."creature_relationship_dynamics" TO "anon", "authenticated";

GRANT DELETE, INSERT, MAINTAIN, REFERENCES, SELECT, TRIGGER, TRUNCATE, UPDATE ON TABLE "public"."creature_relationship_dynamics" TO "postgres";

GRANT MAINTAIN, REFERENCES, TRIGGER, TRUNCATE ON TABLE "public"."creature_relationship_dynamics" TO "service_role";

GRANT MAINTAIN, REFERENCES, TRIGGER, TRUNCATE ON TABLE "public"."personas" TO "anon", "authenticated";

GRANT DELETE, INSERT, MAINTAIN, REFERENCES, SELECT, TRIGGER, TRUNCATE, UPDATE ON TABLE "public"."personas" TO "postgres";

GRANT MAINTAIN, REFERENCES, TRIGGER, TRUNCATE ON TABLE "public"."personas" TO "service_role";

