from fastapi import HTTPException

from supabase_client import supabase_admin


def create_conversation(
    creature_id: str,
    user_id: str | None = None,
):
    response = (
        supabase_admin
        .table("conversations")
        .insert(
            {
                "creature_id": creature_id,
                "user_id": user_id,
            }
        )
        .execute()
    )

    if not response.data:
        raise HTTPException(
            status_code=500,
            detail="Could not create conversation",
        )

    return response.data[0]


def save_message(
    conversation_id: str,
    sender_type: str,
    content: str,
):
    response = (
        supabase_admin
        .table("messages")
        .insert(
            {
                "conversation_id": conversation_id,
                "sender_type": sender_type,
                "content": content,
            }
        )
        .execute()
    )

    if not response.data:
        raise HTTPException(
            status_code=500,
            detail="Could not save message",
        )

    return response.data[0]


def get_conversation_messages(
    conversation_id: str,
    limit: int = 20,
):
    response = (
        supabase_admin
        .table("messages")
        .select("*")
        .eq("conversation_id", conversation_id)
        .order("created_at")
        .limit(limit)
        .execute()
    )

    return response.data