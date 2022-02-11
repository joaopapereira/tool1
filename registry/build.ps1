Write-Host Building registry binary and image
$version=$(select-string -Path Dockerfile -Pattern "ENV DISTRIBUTION_VERSION").ToString().split()[-1].SubString(1)
docker build -t ghcr.io/joaopapereira/tool1/registry .
docker tag ghcr.io/joaopapereira/tool1/registry:latest registry:$version
