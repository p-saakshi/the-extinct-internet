from fastapi import HTTPException

from supabase_client import supabase

def get_bot_context(slug: str):
    creature_response = (
        supabase
        .table("creatures")
        .select("*")
        .eq("slug", slug)
        .execute()
    )

    if not creature_response.data:
        raise HTTPException(
            status_code=404,
            detail="Creature not found",
        )

    creature = creature_response.data[0]
    creature_id = creature["id"]

    taxonomy_response = (
        supabase
        .table("taxonomy")
        .select("*")
        .eq("creature_id", creature_id)
        .execute()
        .data
    )

    temporal_response = (
        supabase
        .table("temporal_ranges")
        .select("*")
        .eq("creature_id", creature_id)
        .execute()
        .data
    )

    ecology_response = (
        supabase
        .table("ecology")
        .select("*")
        .eq("creature_id", creature_id)
        .execute()
        .data
    )

    locations_response = (
        supabase
        .table("creature_locations")
        .select("*, locations(*)")
        .eq("creature_id", creature_id)
        .execute()
        .data
    )

    persona_response = (
        supabase
        .table("personas")
        .select("*")
        .eq("creature_id", creature_id)
        .execute()
        .data
    )

    relationship_dynamics_response = (
        supabase
        .table("creature_relationship_dynamics")
        .select(
            "*, "
            "object:creatures!"
            "creature_relationship_dynamics_object_creature_id_fkey"
            "(id, scientific_name, display_name, slug)"
        )
        .eq("subject_creature_id", creature_id)
        .execute()
        .data
    )

    return {
        "creature": creature,
        "taxonomy": taxonomy_response[0] if taxonomy_response else None,
        "temporal_range": temporal_response[0] if temporal_response else None,
        "ecology": ecology_response[0] if ecology_response else None,
        "locations": locations_response,
        "persona": persona_response[0] if persona_response else None,
        "relationship_dynamics": relationship_dynamics_response,
    }
