from fastapi import FastAPI, Body
from fastapi.responses import JSONResponse
import base64
import json

app = FastAPI()

cluster_name = "testing"

def create_patch(existing: bool) -> str:
    patch_operation = {
        "op": "replace" if existing else "add",
        "path": "/data/CLUSTERNAME",
        "value": cluster_name
    }
    patch_operations = [patch_operation]
    return base64.b64encode(json.dumps(patch_operations).encode()).decode()

def admission_review(uid: str, existing: bool) -> dict:
    return {
        "apiVersion": "admission.k8s.io/v1",
        "kind": "AdmissionReview",
        "response": {
            "uid": uid,
            "allowed": True,
            "patchType": "JSONPatch",
            "patch": create_patch(existing),
        },
    }

@app.post("/mutate")
async def mutate_request(request: dict = Body(...)):
    uid = request["request"]["uid"]
    data = request["request"]["object"].get("data", {})
    existing = "CLUSTERNAME" in data

    return JSONResponse(content=admission_review(uid, existing))

if __name__ == "__main__":
    import uvicorn
    uvicorn.run(app, host="0.0.0.0", port=5000)