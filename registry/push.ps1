$version=$(select-string -Path Dockerfile -Pattern "ENV DISTRIBUTION_VERSION").ToString().split()[-1].SubString(1)
docker tag ghcr.io/joaopapereira/tool1/registry:$version  ghcr.io/joaopapereira/tool1/registry-windows:$version-2022
docker push  ghcr.io/joaopapereira/tool1/registry-windows:$version-2022
