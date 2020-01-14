# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#
# Kubernetes Aliases for Zsh
#
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# - - - - - - - - - - - - - - - - - - - -
# Managing Multiple Aws Eks Clusters
# - - - - - - - - - - - - - - - - - - - -

alias eks-main-prod='export AWS_PROFILE=canvasprod && \
          aws eks update-kubeconfig --name prod-eks && \
          source <(kubectl completion bash)';

alias eks-main-int='export AWS_PROFILE=canvasprod && \
          aws eks update-kubeconfig --name int-eks && \
          source <(kubectl completion bash)';

alias eks-canvastest-int='export AWS_PROFILE=canvastest && \
          aws eks update-kubeconfig --name int-eks && \
          source <(kubectl completion bash)';

alias eks-canvastest-int-gc-dev='export AWS_PROFILE=canvastest && \
          aws eks update-kubeconfig --name int-eks && \
          source <(kubectl completion bash) && \
          kubectl config set-context $(kubectl config current-context) --namespace gc-dev';
