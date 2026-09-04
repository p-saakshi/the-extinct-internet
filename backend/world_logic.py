def temporal_overlap(range_a, range_b):
    if not range_a or not range_b:
        return False

    oldest_common = min(range_a["max_ma"], range_b["max_ma"])
    youngest_common = max(range_a["min_ma"], range_b["min_ma"])

    return youngest_common <= oldest_common


def get_shared_locations(locations_a, locations_b):
    ids_a = {
        location["location_id"]
        for location in locations_a
    }

    ids_b = {
        location["location_id"]
        for location in locations_b
    }

    shared_ids = ids_a.intersection(ids_b)

    shared_locations = []

    for location in locations_a:
        if location["location_id"] in shared_ids:
            shared_locations.append(location["locations"])

    return shared_locations


def classify_knowledge(
    has_temporal_overlap,
    shared_locations,
    creator_knowledge=False,
):
    if creator_knowledge:
        return "CREATOR_KNOWLEDGE"

    if has_temporal_overlap and shared_locations:
        return "PERSONALLY_PLAUSIBLE"

    if has_temporal_overlap:
        return "HEARD_OF_CONTEMPORARY"

    return "UNKNOWN"