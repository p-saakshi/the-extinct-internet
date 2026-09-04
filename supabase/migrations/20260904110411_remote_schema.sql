CREATE POLICY "Public can read creature locations" ON "public"."creature_locations"
  FOR SELECT
  TO "anon", "authenticated"
  USING (true);

CREATE POLICY "Public can read creatures" ON "public"."creatures"
  FOR SELECT
  TO "anon", "authenticated"
  USING (true);

CREATE POLICY "Public can read ecology" ON "public"."ecology"
  FOR SELECT
  TO "anon", "authenticated"
  USING (true);

CREATE POLICY "Public can read locations" ON "public"."locations"
  FOR SELECT
  TO "anon", "authenticated"
  USING (true);

CREATE POLICY "Public can read relationships" ON "public"."relationships"
  FOR SELECT
  TO "anon", "authenticated"
  USING (true);

CREATE POLICY "Public can read scientific sources" ON "public"."scientific_sources"
  FOR SELECT
  TO "anon", "authenticated"
  USING (true);

CREATE POLICY "Public can read taxonomy" ON "public"."taxonomy"
  FOR SELECT
  TO "anon", "authenticated"
  USING (true);

CREATE POLICY "Public can read temporal ranges" ON "public"."temporal_ranges"
  FOR SELECT
  TO "anon", "authenticated"
  USING (true);

REVOKE ALL ON TABLE "public"."creature_locations" FROM "anon";

GRANT MAINTAIN, REFERENCES, SELECT, TRIGGER, TRUNCATE ON TABLE "public"."creature_locations" TO "anon";

REVOKE ALL ON TABLE "public"."creature_locations" FROM "authenticated";

GRANT MAINTAIN, REFERENCES, SELECT, TRIGGER, TRUNCATE ON TABLE "public"."creature_locations" TO "authenticated";

REVOKE ALL ON TABLE "public"."creatures" FROM "anon";

GRANT MAINTAIN, REFERENCES, SELECT, TRIGGER, TRUNCATE ON TABLE "public"."creatures" TO "anon";

REVOKE ALL ON TABLE "public"."creatures" FROM "authenticated";

GRANT MAINTAIN, REFERENCES, SELECT, TRIGGER, TRUNCATE ON TABLE "public"."creatures" TO "authenticated";

REVOKE ALL ON TABLE "public"."ecology" FROM "anon";

GRANT MAINTAIN, REFERENCES, SELECT, TRIGGER, TRUNCATE ON TABLE "public"."ecology" TO "anon";

REVOKE ALL ON TABLE "public"."ecology" FROM "authenticated";

GRANT MAINTAIN, REFERENCES, SELECT, TRIGGER, TRUNCATE ON TABLE "public"."ecology" TO "authenticated";

REVOKE ALL ON TABLE "public"."locations" FROM "anon";

GRANT MAINTAIN, REFERENCES, SELECT, TRIGGER, TRUNCATE ON TABLE "public"."locations" TO "anon";

REVOKE ALL ON TABLE "public"."locations" FROM "authenticated";

GRANT MAINTAIN, REFERENCES, SELECT, TRIGGER, TRUNCATE ON TABLE "public"."locations" TO "authenticated";

REVOKE ALL ON TABLE "public"."relationships" FROM "anon";

GRANT MAINTAIN, REFERENCES, SELECT, TRIGGER, TRUNCATE ON TABLE "public"."relationships" TO "anon";

REVOKE ALL ON TABLE "public"."relationships" FROM "authenticated";

GRANT MAINTAIN, REFERENCES, SELECT, TRIGGER, TRUNCATE ON TABLE "public"."relationships" TO "authenticated";

REVOKE ALL ON TABLE "public"."scientific_sources" FROM "anon";

GRANT MAINTAIN, REFERENCES, SELECT, TRIGGER, TRUNCATE ON TABLE "public"."scientific_sources" TO "anon";

REVOKE ALL ON TABLE "public"."scientific_sources" FROM "authenticated";

GRANT MAINTAIN, REFERENCES, SELECT, TRIGGER, TRUNCATE ON TABLE "public"."scientific_sources" TO "authenticated";

REVOKE ALL ON TABLE "public"."taxonomy" FROM "anon";

GRANT MAINTAIN, REFERENCES, SELECT, TRIGGER, TRUNCATE ON TABLE "public"."taxonomy" TO "anon";

REVOKE ALL ON TABLE "public"."taxonomy" FROM "authenticated";

GRANT MAINTAIN, REFERENCES, SELECT, TRIGGER, TRUNCATE ON TABLE "public"."taxonomy" TO "authenticated";

REVOKE ALL ON TABLE "public"."temporal_ranges" FROM "anon";

GRANT MAINTAIN, REFERENCES, SELECT, TRIGGER, TRUNCATE ON TABLE "public"."temporal_ranges" TO "anon";

REVOKE ALL ON TABLE "public"."temporal_ranges" FROM "authenticated";

GRANT MAINTAIN, REFERENCES, SELECT, TRIGGER, TRUNCATE ON TABLE "public"."temporal_ranges" TO "authenticated";

