from fastapi import FastAPI, HTTPException
from supabase_client import supabase
from world_logic import (
    classify_knowledge,
    get_shared_locations,
    temporal_overlap,
)

app = FastAPI(title="The Extinct Internet API")


@app.get("/health")
def health_check():
    return {"status": "ok"}


@app.get("/creatures")
def get_creatures():
    response = supabase.table("creatures").select("*").execute()
    return response.data


@app.get("/creatures/{slug}")
def get_creature(slug: str):
    response = (
        supabase
        .table("creatures")
        .select("*")
        .eq("slug", slug)
        .execute()
    )

    if not response.data:
        raise HTTPException(status_code=404, detail="Creature not found")

    return response.data[0]

@app.get("/creatures/{slug}/profile")
def get_creature_profile(slug: str):
    creature_response = (
        supabase
        .table("creatures")
        .select("*")
        .eq("slug", slug)
        .execute()
    )

    if not creature_response.data:
        raise HTTPException(status_code=404, detail="Creature not found")

    creature = creature_response.data[0]
    creature_id = creature["id"]

    taxonomy = (
        supabase
        .table("taxonomy")
        .select("*")
        .eq("creature_id", creature_id)
        .execute()
        .data
    )

    temporal_range = (
        supabase
        .table("temporal_ranges")
        .select("*")
        .eq("creature_id", creature_id)
        .execute()
        .data
    )

    ecology = (
        supabase
        .table("ecology")
        .select("*")
        .eq("creature_id", creature_id)
        .execute()
        .data
    )

    creature_locations = (
        supabase
        .table("creature_locations")
        .select("*, locations(*)")
        .eq("creature_id", creature_id)
        .execute()
        .data
    )

    return {
        "creature": creature,
        "taxonomy": taxonomy[0] if taxonomy else None,
        "temporal_range": temporal_range[0] if temporal_range else None,
        "ecology": ecology[0] if ecology else None,
        "locations": creature_locations,
    }
@app.get("/creatures/{slug}/relationships")
def get_creature_relationships(slug: str):
    creature_response = (
        supabase
        .table("creatures")
        .select("id, display_name, slug")
        .eq("slug", slug)
        .execute()
    )

    if not creature_response.data:
        raise HTTPException(status_code=404, detail="Creature not found")

    creature = creature_response.data[0]
    creature_id = creature["id"]

    subject_relationships = (
        supabase
        .table("relationships")
        .select(
            "*, "
            "subject:creatures!relationships_subject_creature_id_fkey(id, display_name, slug), "
            "object:creatures!relationships_object_creature_id_fkey(id, display_name, slug), "
            "source:scientific_sources(id, title, url, doi)"
        )
        .eq("subject_creature_id", creature_id)
        .execute()
        .data
    )

    object_relationships = (
        supabase
        .table("relationships")
        .select(
            "*, "
            "subject:creatures!relationships_subject_creature_id_fkey(id, display_name, slug), "
            "object:creatures!relationships_object_creature_id_fkey(id, display_name, slug), "
            "source:scientific_sources(id, title, url, doi)"
        )
        .eq("object_creature_id", creature_id)
        .execute()
        .data
    )

    relationships = subject_relationships.copy()

    for relationship in object_relationships:
        if relationship["id"] not in {
            existing["id"] for existing in relationships
        }:
            relationships.append(relationship)

    return {
        "creature": creature,
        "relationships": relationships,
    }

@app.get("/world/compare/{slug_a}/{slug_b}")
def compare_creatures(slug_a: str, slug_b: str):
    creatures_response = (
        supabase
        .table("creatures")
        .select("id, display_name, slug")
        .in_("slug", [slug_a, slug_b])
        .execute()
    )

    creatures = {
        creature["slug"]: creature
        for creature in creatures_response.data
    }

    if slug_a not in creatures:
        raise HTTPException(
            status_code=404,
            detail=f"Creature not found: {slug_a}",
        )

    if slug_b not in creatures:
        raise HTTPException(
            status_code=404,
            detail=f"Creature not found: {slug_b}",
        )

    creature_a = creatures[slug_a]
    creature_b = creatures[slug_b]

    range_a_response = (
        supabase
        .table("temporal_ranges")
        .select("*")
        .eq("creature_id", creature_a["id"])
        .execute()
        .data
    )

    range_b_response = (
        supabase
        .table("temporal_ranges")
        .select("*")
        .eq("creature_id", creature_b["id"])
        .execute()
        .data
    )

    range_a = range_a_response[0] if range_a_response else None
    range_b = range_b_response[0] if range_b_response else None

    locations_a = (
        supabase
        .table("creature_locations")
        .select("*, locations(*)")
        .eq("creature_id", creature_a["id"])
        .execute()
        .data
    )

    locations_b = (
        supabase
        .table("creature_locations")
        .select("*, locations(*)")
        .eq("creature_id", creature_b["id"])
        .execute()
        .data
    )

    overlaps = temporal_overlap(range_a, range_b)

    shared_locations = get_shared_locations(
        locations_a,
        locations_b,
    )

    knowledge_class = classify_knowledge(
        overlaps,
        shared_locations,
    )

    return {
        "creature_a": creature_a,
        "creature_b": creature_b,
        "temporal_overlap": overlaps,
        "shared_locations": shared_locations,
        "knowledge_class": knowledge_class,
    }