CREATE TABLE "public"."conversations" (
  "id"          uuid                     NOT NULL DEFAULT gen_random_uuid(),
  "creature_id" text                     NOT NULL,
  "user_id"     uuid,
  "created_at"  timestamp with time zone NOT NULL DEFAULT now(),
  "updated_at"  timestamp with time zone NOT NULL DEFAULT now(),
  CONSTRAINT "conversations_pkey" PRIMARY KEY (id)
);

ALTER TABLE "public"."conversations"
  ENABLE ROW LEVEL SECURITY;

CREATE TABLE "public"."messages" (
  "id"              uuid                     NOT NULL DEFAULT gen_random_uuid(),
  "conversation_id" uuid                     NOT NULL,
  "sender_type"     text                     NOT NULL,
  "content"         text                     NOT NULL,
  "created_at"      timestamp with time zone NOT NULL DEFAULT now(),
  CONSTRAINT "messages_pkey" PRIMARY KEY (id),
  CONSTRAINT "messages_sender_type_check" CHECK ((sender_type = ANY (ARRAY['human'::text, 'creature'::text])))
);

ALTER TABLE "public"."messages"
  ENABLE ROW LEVEL SECURITY;

ALTER TABLE "public"."conversations"
  ADD CONSTRAINT "conversations_creature_id_fkey" FOREIGN KEY (creature_id) REFERENCES public.creatures(id) ON UPDATE CASCADE ON DELETE RESTRICT;

ALTER TABLE "public"."conversations"
  ADD CONSTRAINT "conversations_user_id_fkey" FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;

ALTER TABLE "public"."messages"
  ADD CONSTRAINT "messages_conversation_id_fkey" FOREIGN KEY (conversation_id) REFERENCES public.conversations(id) ON DELETE CASCADE;

GRANT MAINTAIN, REFERENCES, TRIGGER, TRUNCATE ON TABLE "public"."conversations" TO "anon", "authenticated";

GRANT DELETE, INSERT, MAINTAIN, REFERENCES, SELECT, TRIGGER, TRUNCATE, UPDATE ON TABLE "public"."conversations" TO "postgres";

GRANT INSERT, MAINTAIN, REFERENCES, SELECT, TRIGGER, TRUNCATE, UPDATE ON TABLE "public"."conversations" TO "service_role";

GRANT MAINTAIN, REFERENCES, TRIGGER, TRUNCATE ON TABLE "public"."messages" TO "anon", "authenticated";

GRANT DELETE, INSERT, MAINTAIN, REFERENCES, SELECT, TRIGGER, TRUNCATE, UPDATE ON TABLE "public"."messages" TO "postgres";

GRANT INSERT, MAINTAIN, REFERENCES, SELECT, TRIGGER, TRUNCATE ON TABLE "public"."messages" TO "service_role";

