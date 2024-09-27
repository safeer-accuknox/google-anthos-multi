import requests
import re

def fetch_cluster_name_from_google() -> str:
    'Fetch the cluster name from Google Cloud metadata.'
    try:
        print('Trying to fetch cluster name from Google Cloud...')
        response = requests.get(
            'http://metadata/computeMetadata/v1/instance/attributes/cluster-name',
            headers={'Metadata-Flavor': 'Google'},
            timeout=2
        )
        if response.status_code == 200:
            print('Cluster name fetched successfully from Google Cloud.')
            return response.text
        else:
            print(f'Failed to fetch from Google Cloud, status code: {response.status_code}')
    except requests.RequestException as e:
        print(f'Error occurred while fetching from Google Cloud: {e}')
    
    return None

def fetch_aws_metadata_token() -> str:
    """Fetch the AWS IMDSv2 token."""
    try:
        print("Requesting AWS metadata token...")
        token_response = requests.put(
            "http://169.254.169.254/latest/api/token",
            headers={"X-aws-ec2-metadata-token-ttl-seconds": "21600"},
            timeout=2
        )
        if token_response.status_code == 200:
            print("AWS metadata token fetched successfully.")
            return token_response.text
        else:
            print(f"Failed to fetch AWS metadata token, status code: {token_response.status_code}")
    except requests.RequestException as e:
        print(f"Error occurred while fetching AWS metadata token: {e}")
    
    return None

def fetch_cluster_name_from_aws() -> str:
    'Fetch the cluster name from AWS user-data.'
    token = fetch_aws_metadata_token()
    if not token:
        print("Failed to retrieve AWS metadata token.")
        return None
    try:
        print('Trying to fetch cluster name from AWS user-data...')
        response = requests.get(
            'http://169.254.169.254/latest/user-data',
            headers={"X-aws-ec2-metadata-token": token},
            timeout=2
        )
        if response.status_code == 200:
            print('User-data fetched successfully from AWS.')
            # Extract the EKS cluster name using regex
            match = re.search(r'(?<=/etc/eks/bootstrap.sh )\S+', response.text)
            if match:
                eks_cluster_name = match.group(0)
                print(f'Cluster name extracted from AWS user-data: {eks_cluster_name}')
                return eks_cluster_name
            else:
                print('Failed to extract cluster name from AWS user-data.')
        else:
            print(f'Failed to fetch from AWS, status code: {response.status_code}')
    except requests.RequestException as e:
        print(f'Error occurred while fetching from AWS: {e}')
    
    return None

def fetch_cluster_name() -> str:
    'Main function to fetch the cluster name, trying Google first, then AWS.'
    cluster_name = fetch_cluster_name_from_google()
    if cluster_name:
        return cluster_name

    cluster_name = fetch_cluster_name_from_aws()
    if cluster_name:
        return cluster_name

    print('Cluster name not found from both sources.')
    return ''