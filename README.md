# Kubectl Helm AWS CLI Action

A custom GitHub Action to use `kubectl`, `helm`, and `AWS CLI` in one package. This action is based on an Amazon Linux image and allows you to run commands with these tools in your workflows.

## Usage

To use this action in your workflow, add the following step to your `.github/workflows/<workflow>.yaml` file:

Remember that tag is combination of kubectl, helm, and aws-cli versions. For example, `1.31.0-3.14.0-2.17.31` means kubectl version `1.31.0`, helm version `3.14.0`, and aws-cli version `2.17.31`.
All available releases can be found [here](https://github.com/noose/kubectl-helm-awscli/releases)

```yaml
jobs:
  build:
    runs-on: ubuntu-latest
    steps:
    - name: Checkout repository
      uses: actions/checkout@v4

    - name: Configure AWS credentials
      uses: aws-actions/configure-aws-credentials@v2
      with:
        aws-access-key-id: ${{ secrets.AWS_ACCESS_KEY_ID }}
        aws-secret-access-key: ${{ secrets.AWS_SECRET_ACCESS_KEY }}
        aws-region: us-west-2

    - name: Run Kubectl Helm AWS CLI Action
      uses: noose/kubectl-helm-awscli@1.31.0-3.14.0-2.17.31
      with:
        args: |
          aws eks update-kubeconfig --name <cluster>
          kubectl get pods
```

## Inputs

- `args`: The command to run with `kubectl`, `helm`, and `AWS CLI`.

## Examples

### Example 1: List Kubernetes Pods

```yaml
jobs:
  build:
    runs-on: ubuntu-latest
    steps:
    - name: Checkout repository
      uses: actions/checkout@v4

    - name: Configure AWS credentials
      uses: aws-actions/configure-aws-credentials@v2
      with:
        aws-access-key-id: ${{ secrets.AWS_ACCESS_KEY_ID }}
        aws-secret-access-key: ${{ secrets.AWS_SECRET_ACCESS_KEY }}
        aws-region: us-west-2

    - name: List Kubernetes Pods
      uses: noose/kubectl-helm-awscli@1.31.0-3.14.0-2.17.31
      with:
        args: |
          aws eks update-kubeconfig --name <cluster>
          kubectl get pods
```

### Example 2: Deploy Helm Chart

```yaml
jobs:
  build:
    runs-on: ubuntu-latest
    steps:
    - name: Checkout repository
      uses: actions/checkout@v4

    - name: Configure AWS credentials
      uses: aws-actions/configure-aws-credentials@v2
      with:
        aws-access-key-id: ${{ secrets.AWS_ACCESS_KEY_ID }}
        aws-secret-access-key: ${{ secrets.AWS_SECRET_ACCESS_KEY }}
        aws-region: us-west-2

    - name: Deploy Helm Chart
      uses: noose/kubectl-helm-awscli@1.31.0-3.14.0-2.17.31
      with:
        args: |
          aws eks update-kubeconfig --name <cluster>
          helm install my-chart stable/my-chart
```

### Example 3: AWS CLI Command

```yaml
jobs:
  build:
    runs-on: ubuntu-latest
    steps:
    - name: Checkout repository
      uses: actions/checkout@v4

    - name: Configure AWS credentials
      uses: aws-actions/configure-aws-credentials@v2
      with:
        aws-access-key-id: ${{ secrets.AWS_ACCESS_KEY_ID }}
        aws-secret-access-key: ${{ secrets.AWS_SECRET_ACCESS_KEY }}
        aws-region: us-west-2

    - name: AWS CLI Command
      uses: noose/kubectl-helm-awscli@1.31.0-3.14.0-2.17.31
      with:
        args: |
          aws s3 ls
```

## Environment Variables

- `KUBE_CONFIG_DATA`: Base64 encoded kubeconfig (default: `Cg==` for empty).
- `AWS_ACCESS_KEY_ID`: AWS access key ID (can be populated from `aws-actions/configure-aws-credentials`).
- `AWS_SECRET_ACCESS_KEY`: AWS secret access key (can be populated from `aws-actions/configure-aws-credentials`).

## License

This project is licensed under the MIT License.
