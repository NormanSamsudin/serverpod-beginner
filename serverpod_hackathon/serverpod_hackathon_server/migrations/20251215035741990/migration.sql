BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "menu_item" (
    "id" bigserial PRIMARY KEY,
    "restaurantName" text NOT NULL,
    "name" text NOT NULL,
    "description" text NOT NULL,
    "price" double precision NOT NULL,
    "category" text NOT NULL,
    "cuisine" text NOT NULL,
    "isVegetarian" boolean NOT NULL DEFAULT false,
    "isHalal" boolean NOT NULL DEFAULT false,
    "spicyLevel" bigint NOT NULL DEFAULT 0,
    "allergens" text,
    "tags" text,
    "imageUrl" text,
    "embedding" text
);


--
-- MIGRATION VERSION FOR serverpod_hackathon
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod_hackathon', '20251215035741990', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20251215035741990', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod', '20251208110333922-v3-0-0', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20251208110333922-v3-0-0', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod_auth_idp
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod_auth_idp', '20251208110420531-v3-0-0', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20251208110420531-v3-0-0', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod_auth_core
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod_auth_core', '20251208110412389-v3-0-0', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20251208110412389-v3-0-0', "timestamp" = now();


COMMIT;
