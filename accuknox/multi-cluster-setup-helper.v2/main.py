from fastapi import FastAPI, Body
from fastapi.responses import JSONResponse
import base64
import json

app = FastAPI()

cluster_name = 'testing'

def create_patch(existing: bool) -> str:
    patch_operation = {
        'op': 'replace' if existing else 'add',
        'path': '/data/CLUSTERNAME',
        'value': cluster_name
    }
    patch_operations = [patch_operation]
    return base64.b64encode(json.dumps(patch_operations).encode()).decode()

def admission_review(uid: str, existing: bool, matched: bool) -> dict:
    result = {
        'apiVersion': 'admission.k8s.io/v1',
        'kind': 'AdmissionReview',
        'response': {
            'uid': uid,
            'allowed': True
        },
    }
    if matched:
        result['response']['patchType'] = 'JSONPatch'
        result['response']['patch'] = create_patch(existing),

    return result

@app.post('/mutate')
async def mutate_request(request: dict = Body(...)):
    print('mutation: STARTED')
    configmap_name = request['request']['object']['metadata']['name']
    uid = request['request']['uid']
    existing = False

    if configmap_name in ['onboarding-vars']:
        data = request['request']['object'].get('data', {})
        existing = 'CLUSTERNAME' in data
        print('mutation', data)
        return JSONResponse(content=admission_review(uid, existing, True))
    return JSONResponse(content=admission_review(uid, existing, False))

if __name__ == '__main__':
    import uvicorn
    uvicorn.run(app, host='0.0.0.0', port=5000)