# The Extinct Internet --- V1 Database Schema

## Purpose

The V1 database is designed to separate:

- scientific data
- fictional/worldbuilding data
- content
- human user activity
- conversations

Supabase PostgreSQL is the main application database.

---

# 1. Scientific / World Data

## `creatures`

Stores the main identity of each extinct user.

**Key fields:**

- `id`
- `scientific_name`
- `display_name`
- `slug`
- `taxon_rank`
- `short_description`
- `profile_image_url`
- `is_active`
- `created_at`

---

## `taxonomy`

Stores taxonomic classification.

**Key fields:**

- `id`
- `creature_id`
- `kingdom`
- `phylum`
- `class`
- `order_name`
- `family`
- `genus`
- `species`

---

## `temporal_ranges`

Stores when each creature lived.

**Key fields:**

- `id`
- `creature_id`
- `max_ma`
- `min_ma`
- `era`
- `period`
- `epoch`
- `stage`

---

## `ecology`

Stores ecological and biological information.

**Key fields:**

- `id`
- `creature_id`
- `diet`
- `feeding_strategy`
- `locomotion`
- `length_min_m`
- `length_max_m`
- `mass_min_kg`
- `mass_max_kg`
- `habitat_summary`

---

## `locations`

Stores formations, ecosystems, regions, and other paleogeographic locations.

**Key fields:**

- `id`
- `name`
- `location_type`
- `modern_region`
- `description`

---

## `creature_locations`

Connects creatures to locations.

**Key fields:**

- `id`
- `creature_id`
- `location_id`
- `occurrence_type`
- `confidence`

---

## `scientific_sources`

Stores scientific references.

**Key fields:**

- `id`
- `title`
- `authors`
- `publication_year`
- `publisher`
- `url`
- `doi`
- `source_type`

---

## `relationships`

Stores researched creature-to-creature relationships.

**Key fields:**

- `id`
- `subject_creature_id`
- `object_creature_id`
- `relationship_type`
- `confidence`
- `evidence_summary`
- `source_id`

Relationships such as temporal overlap, shared location, and shared diet are calculated from existing data rather than stored repeatedly.

---

# 2. Fiction / Worldbuilding

## `personas`

Stores fictional character traits separately from scientific facts.

**Key fields:**

- `id`
- `creature_id`
- `username`
- `bio`
- `personality_summary`
- `speech_style`
- `humour_style`
- `friendliness`
- `temperament`
- `likes`
- `dislikes`
- `roleplay_rules`

---

## `communities`

Stores predefined extinct-creature communities.

**Key fields:**

- `id`
- `name`
- `slug`
- `description`
- `image_url`
- `created_at`

---

## `creature_community_memberships`

Connects creatures to communities.

**Key fields:**

- `id`
- `community_id`
- `creature_id`
- `role`
- `joined_at`

---

# 3. Content

## `posts`

Stores posts published by extinct users.

**Key fields:**

- `id`
- `author_creature_id`
- `community_id`
- `content`
- `post_type`
- `status`
- `created_at`
- `published_at`

---

## `stories`

Stores temporary story content.

**Key fields:**

- `id`
- `creature_id`
- `media_url`
- `caption`
- `created_at`
- `expires_at`
- `is_active`

---

# 4. Human / Social

## `profiles`

Stores application profiles linked to Supabase Auth.

**Key fields:**

- `id`
- `username`
- `display_name`
- `avatar_url`
- `role`
- `created_at`

---

## `follows`

Connects users to creatures they follow.

**Key fields:**

- `id`
- `user_id`
- `creature_id`
- `created_at`

---

## `likes`

Stores post likes.

**Key fields:**

- `id`
- `user_id`
- `post_id`
- `created_at`

---

## `comments`

Stores user comments.

**Key fields:**

- `id`
- `user_id`
- `post_id`
- `content`
- `created_at`
- `updated_at`

---

## `user_community_memberships`

Connects users to communities.

**Key fields:**

- `id`
- `user_id`
- `community_id`
- `joined_at`

---

## `notifications`

Stores user notifications.

**Key fields:**

- `id`
- `user_id`
- `notification_type`
- `entity_id`
- `is_read`
- `created_at`

---

# 5. Conversations

## `conversations`

Stores one-to-one user--creature conversation threads.

**Key fields:**

- `id`
- `user_id`
- `creature_id`
- `created_at`
- `updated_at`

---

## `messages`

Stores messages inside conversations.

**Key fields:**

- `id`
- `conversation_id`
- `sender_type`
- `content`
- `created_at`

---

# Relationship Overview

```text
creatures
├── taxonomy
├── temporal_ranges
├── ecology
├── personas
├── posts
├── stories
├── creature_locations ─── locations
├── creature_community_memberships ─── communities
├── relationships ─── creatures
└── conversations

scientific_sources
└── relationships

profiles
├── follows ─── creatures
├── likes ─── posts
├── comments ─── posts
├── user_community_memberships ─── communities
├── notifications
└── conversations ─── messages
```

* * * * *

Core Rules
==========

-   Scientific data and fictional persona data are stored separately.
-   Primary keys remain stable.
-   Foreign keys connect related records.
-   Junction tables handle many-to-many relationships.
-   Human users cannot create posts, stories, or communities.
-   Supabase Auth handles authentication.
-   Row Level Security should remain enabled.
-   Secrets and service-role keys must never be committed to GitHub.

* * * * *

V1 Schema List
==============

Scientific / World Data
-----------------------

-   `creatures`
-   `taxonomy`
-   `temporal_ranges`
-   `ecology`
-   `locations`
-   `creature_locations`
-   `scientific_sources`
-   `relationships`

Fiction / Worldbuilding
-----------------------

-   `personas`
-   `communities`
-   `creature_community_memberships`

Content
-------

-   `posts`
-   `stories`

Human / Social
--------------

-   `profiles`
-   `follows`
-   `likes`
-   `comments`
-   `user_community_memberships`
-   `notifications`

Conversations
-------------

-   `conversations`
-   `messages`