FROM --platform=arm64 node:18.5.0

# amd用
# RUN apt-get update && apt-get install -y gnupg software-properties-common
# RUN wget -O- https://apt.releases.hashicorp.com/gpg | \
#     gpg --dearmor | \
#     tee /usr/share/keyrings/hashicorp-archive-keyring.gpg
# RUN gpg --no-default-keyring \
#     --keyring /usr/share/keyrings/hashicorp-archive-keyring.gpg \
#     --fingerprint
# RUN echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] \
#     https://apt.releases.hashicorp.com $(lsb_release -cs) main" | \
#     tee /etc/apt/sources.list.d/hashicorp.list
# RUN apt-get update && apt-get install terraform

# arm64はbuild済みのものしかない
WORKDIR /workspace
RUN wget https://releases.hashicorp.com/terraform/1.3.7/terraform_1.3.7_linux_amd64.zip
RUN unzip terraform_1.3.7_linux_amd64.zip
RUN mv terraform /usr/local/bin/
RUN terraform -install-autocomplete

RUN type -p curl >/dev/null || apt install curl -y
RUN curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg \
    && chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg \
    && echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | tee /etc/apt/sources.list.d/github-cli.list > /dev/null \
    && apt update \
    && apt install gh -y