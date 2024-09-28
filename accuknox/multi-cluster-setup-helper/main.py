from fastapi import FastAPI, Body
from fastapi.responses import JSONResponse
import base64
import json
import requests
from utils import fetch_cluster_name

app = FastAPI()


def create_patch(existing: bool) -> str:
    cluster_name = fetch_cluster_name()
    patch_operations = []

    patch_operations.append({
        'op': 'replace' if existing else 'add',
        'path': '/data/CLUSTER_NAME',
        'value': cluster_name
    })

    patch_operations.append({
        'op': 'replace' if existing else 'add',
        'path': '/data/cluster_name',
        'value': cluster_name
    })

    return base64.b64encode(json.dumps(patch_operations).encode()).decode()

def admission_review(uid: str, existing: bool) -> dict:
    result = {
        'apiVersion': 'admission.k8s.io/v1',
        'kind': 'AdmissionReview',
        'response': {
            'uid': uid,
            'allowed': True
        },
    }
    result['response']['patchType'] = 'JSONPatch'
    result['response']['patch'] = create_patch(existing)
    return result

@app.post('/mutate')
async def mutate_request(request: dict = Body(...)):
    configmap_name = request['request']['object']['metadata']['name']
    uid = request['request']['uid']
    existing = False

    data = request['request']['object'].get('data', {})
    existing = 'CLUSTER_NAME' in data or 'cluster_name' in data
    print('patched', configmap_name)
    return JSONResponse(content=admission_review(uid, existing))

@app.get('/')
async def root():
    return {"message": "Hello, World!"}

if __name__ == '__main__':
    import uvicorn
    uvicorn.run(app, host='0.0.0.0', port=5000)