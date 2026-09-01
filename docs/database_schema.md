# The Extinct Internet --- V1 Database Schema

## Purpose

This document defines the locked V1 database structure for **The Extinct Internet**.

The goal of V1 is to build a small but extensible foundation so future versions can add new creatures, communities, content, and features without redesigning the core database.

The schema separates:

- scientific facts
- fictional/worldbuilding data
- social content
- human user activity
- conversations

The AI chatbot must never become the source of scientific truth. Scientific data lives in the database; personas and world lore remain separate.

---

# Core Design Principles

1. **Scientific data and fictional persona data must remain separate.**
2. **Humans visit; extinct organisms own the internet.**
3. Human users cannot create posts, stories, or communities.
4. Creature behavior should be data-driven rather than hardcoded per creature.
5. V1 tables should support future expansion without requiring structural rewrites.
6. Events are excluded from V1 and will be added in V2.
7. Supabase PostgreSQL is the application source of truth.
8. Primary keys should remain stable even if display names or scientific interpretations change.
9. Foreign keys should be used wherever records logically depend on other records.
10. Junction tables should be used for many-to-many relationships.

---

# Table Groups

The V1 schema is organized into five logical groups:

1. Scientific / World Data
2. Fiction / Worldbuilding
3. Content
4. Human / Social
5. Conversations

---

# 1. Scientific / World Data

## `creatures`

Stores the main identity of every extinct user.

One row represents one creature account.

### Columns

| Column | Purpose |
|---|---|
| `id` | Primary key |
| `scientific_name` | Scientific name |
| `display_name` | Name shown in the app |
| `slug` | URL-safe identifier |
| `taxon_rank` | Species, genus, etc. |
| `short_description` | Short profile/scientific summary |
| `profile_image_url` | Profile image location |
| `is_active` | Whether the extinct user is currently available in the app |
| `created_at` | Record creation timestamp |

### Example

```text
id: 1
scientific_name: Tyrannosaurus rex
display_name: T. rex
slug: tyrannosaurus-rex
taxon_rank: species
```

* * * * *

`taxonomy`
----------

Stores the taxonomic classification of a creature.

### Columns

| Column | Purpose |
| --- | --- |
| `id` | Primary key |
| `creature_id` | Foreign key → `creatures.id` |
| `kingdom` | Taxonomic kingdom |
| `phylum` | Taxonomic phylum |
| `class` | Taxonomic class |
| `order_name` | Taxonomic order |
| `family` | Taxonomic family |
| `genus` | Genus |
| `species` | Species |

* * * * *

`temporal_ranges`
-----------------

Stores when a creature existed.

### Columns

| Column | Purpose |
| --- | --- |
| `id` | Primary key |
| `creature_id` | Foreign key → `creatures.id` |
| `max_ma` | Oldest boundary in millions of years ago |
| `min_ma` | Youngest boundary in millions of years ago |
| `era` | Geological era |
| `period` | Geological period |
| `epoch` | Geological epoch |
| `stage` | Geological stage |

### Example

```
T. rex
max_ma = 68
min_ma = 66
```

* * * * *

`ecology`
---------

Stores ecological and biological information needed for profiles and chatbot grounding.

### Columns

| Column | Purpose |
| --- | --- |
| `id` | Primary key |
| `creature_id` | Foreign key → `creatures.id` |
| `diet` | Herbivore, carnivore, omnivore, etc. |
| `feeding_strategy` | Feeding behavior or strategy |
| `locomotion` | Bipedal, quadrupedal, etc. |
| `length_min_m` | Minimum estimated length |
| `length_max_m` | Maximum estimated length |
| `mass_min_kg` | Minimum estimated mass |
| `mass_max_kg` | Maximum estimated mass |
| `habitat_summary` | Short habitat/environment summary |

* * * * *

`locations`
-----------

Stores paleogeographic locations, formations, ecosystems, or regions.

### Columns

| Column | Purpose |
| --- | --- |
| `id` | Primary key |
| `name` | Location name |
| `location_type` | Formation, ecosystem, region, island, basin, etc. |
| `modern_region` | Present-day geographic region |
| `description` | Short description |

### Examples

```
Hell Creek Formation
Wrangel Island
Western North America
Mammoth Steppe
```

* * * * *

`creature_locations`
--------------------

Junction table connecting creatures to one or more locations.

### Columns

| Column | Purpose |
| --- | --- |
| `id` | Primary key |
| `creature_id` | Foreign key → `creatures.id` |
| `location_id` | Foreign key → `locations.id` |
| `occurrence_type` | Formation, ecosystem, geographic occurrence, etc. |
| `confidence` | Confidence in the association |

* * * * *

`scientific_sources`
--------------------

Stores references used to support scientific facts.

### Columns

| Column | Purpose |
| --- | --- |
| `id` | Primary key |
| `title` | Source title |
| `authors` | Authors |
| `publication_year` | Publication year |
| `publisher` | Publisher, journal, museum, etc. |
| `url` | Source URL |
| `doi` | DOI if available |
| `source_type` | Journal, museum, database, book, etc. |

* * * * *

`relationships`
---------------

Stores scientifically supported or manually interpreted creature-to-creature relationships.

### Columns

| Column | Purpose |
| --- | --- |
| `id` | Primary key |
| `subject_creature_id` | Foreign key → `creatures.id` |
| `object_creature_id` | Foreign key → `creatures.id` |
| `relationship_type` | Type of relationship |
| `confidence` | Confidence level |
| `evidence_summary` | Short explanation |
| `source_id` | Foreign key → `scientific_sources.id` |

### Example relationship types

```
possible_predator_prey
ecosystem_contemporary
possible_competition
taxonomic_similarity
```

### Important rule

Relationships that can be calculated directly from data should not be duplicated here.

For example:

```
temporal overlap
shared formation
same diet
```

should be calculated by backend logic whenever possible.

* * * * *

2\. Fiction / Worldbuilding
===========================

`personas`
----------

Stores fictional characterization for each extinct user.

This table must remain separate from scientific facts.

### Columns

| Column | Purpose |
| --- | --- |
| `id` | Primary key |
| `creature_id` | Foreign key → `creatures.id` |
| `username` | Social-media username |
| `bio` | Fictional profile bio |
| `personality_summary` | Core personality |
| `speech_style` | How the character talks |
| `humour_style` | Humor style |
| `friendliness` | General friendliness level |
| `temperament` | Temperament |
| `likes` | Fictional likes |
| `dislikes` | Fictional dislikes |
| `roleplay_rules` | Character-specific chatbot rules |

* * * * *

`communities`
-------------

Stores predefined communities created by the admin.

Human users cannot create communities.

### Columns

| Column | Purpose |
| --- | --- |
| `id` | Primary key |
| `name` | Community name |
| `slug` | URL-safe identifier |
| `description` | Community description |
| `image_url` | Community image or banner |
| `created_at` | Creation timestamp |

### V1 community

```
Cretaceous Herbivores
```

* * * * *

`creature_community_memberships`
--------------------------------

Junction table connecting extinct users to communities.

### Columns

| Column | Purpose |
| --- | --- |
| `id` | Primary key |
| `community_id` | Foreign key → `communities.id` |
| `creature_id` | Foreign key → `creatures.id` |
| `role` | Optional role inside the community |
| `joined_at` | Membership timestamp |

### V1 membership

```
Cretaceous Herbivores
├── Triceratops
├── Edmontosaurus
└── Ankylosaurus
```

* * * * *

3\. Content
===========

`posts`
-------

Stores posts published on behalf of extinct users.

Only the admin creates posts.

### Columns

| Column | Purpose |
| --- | --- |
| `id` | Primary key |
| `author_creature_id` | Foreign key → `creatures.id` |
| `community_id` | Foreign key → `communities.id`, nullable |
| `content` | Post text or content |
| `post_type` | Normal post, community post, etc. |
| `status` | Draft, published, archived |
| `created_at` | Creation timestamp |
| `published_at` | Publication timestamp |

* * * * *

`stories`
---------

Stores temporary story content published by the admin on behalf of extinct users.

### Columns

| Column | Purpose |
| --- | --- |
| `id` | Primary key |
| `creature_id` | Foreign key → `creatures.id` |
| `media_url` | Story image or media URL |
| `caption` | Optional caption |
| `created_at` | Creation timestamp |
| `expires_at` | Expiry timestamp |
| `is_active` | Whether the story is currently visible |

* * * * *

4\. Human / Social
==================

`profiles`
----------

Stores application-specific information for authenticated human users.

Authentication credentials are managed by Supabase Auth.

Passwords must never be stored in this table.

### Columns

| Column | Purpose |
| --- | --- |
| `id` | Primary key; linked to Supabase Auth user ID |
| `username` | Unique username |
| `display_name` | Display name |
| `avatar_url` | Optional avatar |
| `role` | `user` or `admin` |
| `created_at` | Creation timestamp |

* * * * *

`follows`
---------

Junction table connecting human users to extinct users they follow.

### Columns

| Column | Purpose |
| --- | --- |
| `id` | Primary key |
| `user_id` | Foreign key → `profiles.id` |
| `creature_id` | Foreign key → `creatures.id` |
| `created_at` | Follow timestamp |

### Constraint

A user should not be able to follow the same creature twice.

* * * * *

`likes`
-------

Stores post likes.

### Columns

| Column | Purpose |
| --- | --- |
| `id` | Primary key |
| `user_id` | Foreign key → `profiles.id` |
| `post_id` | Foreign key → `posts.id` |
| `created_at` | Like timestamp |

### Constraint

A user should only be able to like a specific post once.

* * * * *

`comments`
----------

Stores comments written by human users on extinct-user posts.

### Columns

| Column | Purpose |
| --- | --- |
| `id` | Primary key |
| `user_id` | Foreign key → `profiles.id` |
| `post_id` | Foreign key → `posts.id` |
| `content` | Comment text |
| `created_at` | Creation timestamp |
| `updated_at` | Last edit timestamp |

* * * * *

`user_community_memberships`
----------------------------

Junction table connecting human users to predefined communities.

### Columns

| Column | Purpose |
| --- | --- |
| `id` | Primary key |
| `user_id` | Foreign key → `profiles.id` |
| `community_id` | Foreign key → `communities.id` |
| `joined_at` | Join timestamp |

* * * * *

`notifications`
---------------

Stores lightweight user notifications.

### Columns

| Column | Purpose |
| --- | --- |
| `id` | Primary key |
| `user_id` | Foreign key → `profiles.id` |
| `notification_type` | Type of notification |
| `entity_id` | Related entity ID |
| `is_read` | Read or unread status |
| `created_at` | Creation timestamp |

* * * * *

5\. Conversations
=================

`conversations`
---------------

Stores one-to-one conversations between a human user and an extinct user.

### Columns

| Column | Purpose |
| --- | --- |
| `id` | Primary key |
| `user_id` | Foreign key → `profiles.id` |
| `creature_id` | Foreign key → `creatures.id` |
| `created_at` | Creation timestamp |
| `updated_at` | Last activity timestamp |

* * * * *

`messages`
----------

Stores individual messages inside conversations.

### Columns

| Column | Purpose |
| --- | --- |
| `id` | Primary key |
| `conversation_id` | Foreign key → `conversations.id` |
| `sender_type` | `user` or `creature` |
| `content` | Message text |
| `created_at` | Message timestamp |

* * * * *

Relationship Summary
====================

```
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

Relationship Logic
==================

The backend should calculate scientific and world relationships wherever possible.

Temporal overlap
----------------

Two creatures can potentially coexist only if their numerical time ranges overlap.

Example:

```
T. rex
68--66 Ma

Triceratops
~69--66 Ma
```

Result:

```
temporal_overlap = true
```

T. rex versus woolly mammoth:

```
temporal_overlap = false
```

* * * * *

Geographic / Ecosystem overlap
------------------------------

If two creatures share a formation, ecosystem, or region, the backend may classify them as more likely to have encountered one another.

Example:

```
T. rex
+
Triceratops
+
Hell Creek Formation
```

Result:

```
shared_ecosystem = true
```

* * * * *

Chatbot Knowledge Classes
=========================

`PERSONALLY_PLAUSIBLE`
----------------------

The creature lived at the same time and in a compatible ecosystem or location.

Example:

```
T. rex → Triceratops
```

* * * * *

`HEARD_OF_CONTEMPORARY`
-----------------------

The organism existed during an overlapping time but in another region or ecosystem.

Example response style:

```
Never met them. Heard things from the other side of the world, though.
```

* * * * *

`CREATOR_KNOWLEDGE`
-------------------

The subject belongs outside the creature's natural time or world, but the creator may have told the extinct user about it.

Examples:

```
humans
phones
cars
woolly mammoths for T. rex
```

Example response style:

```
Yeah, our creator told us about those. Sounds weird if you ask me.
```

* * * * *

`UNKNOWN`
---------

The system does not have enough information to safely classify or discuss the subject.

The bot should not invent scientific evidence.

* * * * *

AI Failure Behavior
===================

If the LLM or API is unavailable, the application must not fake a canned creature reply.

Instead, show an in-world error state such as:

```
This extinct user seems to be offline.
```

* * * * *

V1 Human Permissions
===
Human users may:

-   create an account

-   log in and log out

-   browse extinct users

-   search

-   follow and unfollow creatures

-   like and unlike posts

-   comment

-   edit or delete their own comments

-   message extinct users

-   join and leave predefined communities

-   view stories

-   receive notifications

Human users may not:

-   create posts

-   create stories

-   upload media

-   create communities

-   edit extinct profiles

-   edit personas

-   access admin tools

* * * * *

Admin Permissions
=================

The admin or creator may:

-   create, edit, and archive posts

-   create and manage stories

-   manage extinct-user profiles

-   manage personas

-   manage communities

-   manage creature-community memberships

-   curate the fictional world

Scientific tables may be edited directly in Supabase when a dedicated admin interface is unnecessary.

* * * * *

V1 Extinct Users
================

The V1 roster is locked to five organisms:

1.  Tyrannosaurus rex

2.  Triceratops

3.  Edmontosaurus

4.  Ankylosaurus

5.  Woolly mammoth

No additional creatures are added during V1.

* * * * *

V1 Community
============

The single V1 community is:

```
Cretaceous Herbivores
```

Members:

-   Triceratops

-   Edmontosaurus

-   Ankylosaurus

Not members:

-   Tyrannosaurus rex

-   Woolly mammoth

* * * * *

V2 Compatibility
================

Events are deliberately excluded from V1.

V2 may introduce:

```
events
event_creatures
event-related posts
event-related stories
```

Existing V1 content tables should be designed so optional event foreign keys can be added later.

The V1 schema should not require restructuring when events are introduced.

* * * * *

Supabase Rules
==============

Supabase will provide:

-   PostgreSQL database

-   Authentication

-   Storage

-   Data API

Important security rules:

1.  Row Level Security should remain enabled.

2.  New tables should not be automatically exposed without deliberate policies.

3.  Users should only edit records they own.

4.  Admin-only operations must be protected.

5.  Secrets and service-role keys must never be committed to GitHub.

6.  Passwords must only be handled by Supabase Auth.

* * * * *

Final V1 Schema List
====================

Scientific / World Data
-----------------------

```
creatures
taxonomy
temporal_ranges
ecology
locations
creature_locations
scientific_sources
relationships
```

Fiction / Worldbuilding
-----------------------

```
personas
communities
creature_community_memberships
```

Content
-------

```
posts
stories
```

Human / Social
--------------

```
profiles
follows
likes
comments
user_community_memberships
notifications
```

Conversations
-------------

```
conversations
messages
```
