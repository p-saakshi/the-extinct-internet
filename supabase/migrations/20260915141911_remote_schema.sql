CREATE POLICY "Allow public read access to creature relationship dynamics" ON "public"."creature_relationship_dynamics"
  FOR SELECT
  TO "anon", "authenticated"
  USING (true);

CREATE POLICY "Allow public read access to personas" ON "public"."personas"
  FOR SELECT
  TO "anon", "authenticated"
  USING (true);

REVOKE ALL ON TABLE "public"."creature_relationship_dynamics" FROM "anon";

GRANT MAINTAIN, REFERENCES, SELECT, TRIGGER, TRUNCATE ON TABLE "public"."creature_relationship_dynamics" TO "anon";

REVOKE ALL ON TABLE "public"."creature_relationship_dynamics" FROM "authenticated";

GRANT MAINTAIN, REFERENCES, SELECT, TRIGGER, TRUNCATE ON TABLE "public"."creature_relationship_dynamics" TO "authenticated";

REVOKE ALL ON TABLE "public"."personas" FROM "anon";

GRANT MAINTAIN, REFERENCES, SELECT, TRIGGER, TRUNCATE ON TABLE "public"."personas" TO "anon";

REVOKE ALL ON TABLE "public"."personas" FROM "authenticated";

GRANT MAINTAIN, REFERENCES, SELECT, TRIGGER, TRUNCATE ON TABLE "public"."personas" TO "authenticated";

