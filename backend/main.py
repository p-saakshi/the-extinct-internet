from fastapi import FastAPI

from supabase_client import supabase

app = FastAPI(title="The Extinct Internet API")


@app.get("/health")
def health_check():
    return {"status": "ok"}


@app.get("/creatures")
def get_creatures():
    response = supabase.table("creatures").select("*").execute()
    return response.data