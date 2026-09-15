import os

from dotenv import load_dotenv
from supabase import Client, create_client

load_dotenv()

SUPABASE_URL = os.getenv("SUPABASE_URL")
SUPABASE_KEY = os.getenv("SUPABASE_KEY")
SUPABASE_SECRET_KEY = os.getenv("SUPABASE_SECRET_KEY")

# Public/read client.
# Used for science, creatures, personas, etc.
supabase: Client = create_client(
    SUPABASE_URL,
    SUPABASE_KEY,
)

# Server-only privileged client.
# Used for private backend data such as conversations/messages.
supabase_admin: Client = create_client(
    SUPABASE_URL,
    SUPABASE_SECRET_KEY,
)