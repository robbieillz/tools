import kopf
from kubernetes import client, config

# Load Kubernetes configuration from default location
config.load_kube_config()

# Create a Kubernetes API client
api = client.CoreV1Api()

@kopf.on.create('example.com', 'v1', 'userquotas')
@kopf.on.update('example.com', 'v1', 'userquotas')
def update_quota(spec, meta, status, old, new, diff, **kwargs):
    namespace = meta['namespace']
    name = meta['name']
    quota_name = f'{name}-quota'

    # Check if a resource quota already exists for the user
    try:
        quota = api.read_namespaced_resource_quota(quota_name, namespace)
    except client.exceptions.ApiException as e:
        if e.status == 404:
            # If the resource quota does not exist, create a new one
            quota = client.V1ResourceQuota(
                metadata=client.V1ObjectMeta(name=quota_name),
                spec=client.V1ResourceQuotaSpec()
            )
            api.create_namespaced_resource_quota(namespace, quota)
        else:
            # Handle other API exceptions
            raise

    # Update the resource quota based on requests and limits
    quota.spec.hard = {
        'requests.cpu': spec.get('requests', {}).get('cpu'),
        'requests.memory': spec.get('requests', {}).get('memory'),
        'limits.cpu': spec.get('limits', {}).get('cpu'),
        'limits.memory': spec.get('limits', {}).get('memory')
    }

    api.replace_namespaced_resource_quota(quota_name, namespace, quota)

    return {'message': f'Updated resource quota for {name}'}

if __name__ == '__main__':
    kopf.run(default_registry=None)
