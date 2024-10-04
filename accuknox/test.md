# google-anthos

v1


helm upgrade --install agents oci://registry-1.docker.io/accuknox/accuknox-agents \
  --version "v0.7.1" \
  --set joinToken="579f8dbd-e015-4fe0-9b72-83a4cd939f3a" \
  --set spireHost="spire.demo.accuknox.com" \
  --set ppsHost="pps.demo.accuknox.com" \
  --set knoxGateway="knox-gw.demo.accuknox.com:3000" \
  --set install.localRegistryAgent=false \
  -n agents --create-namespace
  




helm upgrade --install agents oci://registry-1.docker.io/accuknox/accuknox-agents \
  --version "v0.7.1" --values values.yaml \
  -n agents --create-namespace

{"level":"debug","time":"2024-09-29T09:50:23Z","message":"scaling down agents: [discovery-engine policy-enforcement-agent shared-informer-agent feeder-service local-registry-agent]"}
{"level":"warn","time":"2024-09-29T09:50:23Z","message":"could not scale deployment local-registry-agent: deployments.apps \"local-registry-agent\" not found"}
{"level":"info","time":"2024-09-29T09:50:23Z","message":"Initialing spire server health check at http://spire.demo.accuknox.com:9090/ready"}
{"level":"info","time":"2024-09-29T09:50:23Z","message":"Spire server is live at spire.demo.accuknox.com"}
{"level":"info","time":"2024-09-29T09:50:23Z","message":"Using access token for onboarding"}
{"level":"error","time":"2024-09-29T09:50:24Z","message":"failed to get join token: received error code: error-500 message: error in processing access token service: no token found"}
{"level":"error","time":"2024-09-29T09:50:25Z","message":"failed to get join token: received error code: error-500 message: error in processing access token service: no token found"}
{"level":"error","time":"2024-09-29T09:50:27Z","message":"failed to get join token: received error code: error-500 message: error in processing access token service: no token found"}
{"level":"error","time":"2024-09-29T09:50:31Z","message":"failed to get join token: received error code: error-500 message: error in processing access token service: no token found"}


```
 kubectl get deployment -n agents agents-operator -o yaml | grep -A 5 -i "access" | head                
        - name: access_token                                                                                                           
          value: eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzLXRva2VuIiwiZXhwIjoxNzMwMTYwMDAwLCJqdGkiOiJjNDU5YTZmM
DcyMDA0MWE1YjFlMzFiMzNmYjIxZTMxNSIsInVzZXJfaWQiOjExOTE5LCJuYW1lIjoidGVzdCIsImV4cGlyeV9kYXRlIjoiMjAyNC0xMC0yOSIsIm1heF9jbHVzdGVyc19hbGxv
d2VkIjoxMDAsInRlbmFudC1pZCI6MTY3LCJyZWFsbV9hY2Nlc3MiOnsicm9sZXMiOlsiY3liZXJhaWRlIiwibGlzdF9jb250cm9sc19hY2NvdW50X2lkcyIsImRlZmF1bHRfZml
sdGVyX2xpc3QiLCJsaXN0X2NvbnRyb2xzX3JlZ2lvbiIsInJ1bl9zY2FucyIsInJlY29tbWVuZGVkX2luc2lnaHRzIiwiZGVsZXRlX2RhdGFsaXN0X2NvbmZpZyIsImFzc2V0c1
9hZGRfdGFnIiwiY2hhbmdlX3BvbGljeV9zdGF0dXMiLCJnZXRfZGF0YXBpcGVsaW5lX3RlbGVtZXRyeSIsImFzc2V0c191cGRhdGVfYmFzZWxpbmVzIiwiZGVsZXRlX2Nsb3VkX
2FjY291bnRzIiwicmVwb3NpdG9yaWVzX3ZpZXciLCJyZXBvc2l0b3JpZXNfY3JlYXRlIiwiY3JlYXRlX3RhcmdldHMiLCJjcmVhdGVfY29uZGl0aW9uIiwiZGVsZXRlX2NvbmRp
dGlvbiIsInZpZXdfbWluaW9ucyIsImNyZWF0ZV9taW5pb25zIiwiZGVsZXRlX21pbmlvbnMiLCJ2aWV3X21vZHVsZXMiLCJ2aWV3X2Z1bmN0aW9ucyIsInZpZXdfZXhwZWN0ZWR
fdmFyaWFibGUiLCJjcmVhdGVfbm90aWZpY2F0aW9ucyIsInZpZX
```
