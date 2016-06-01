FROM openshift/base-centos7

MAINTAINER Albert Wong <albert@redhat.com>

ENV \ 
    ASPNETCORE_VERSION=1.0.0-preview1 \
    INSTALLER_ASPNETCORE_VERSION=1.0.0-preview1-002702 \
    HOME=/opt/app-root/src

# Set the labels that are used for Openshift to describe the builder image.
LABEL io.k8s.description="ASP.NET Core 1.0" \
    io.k8s.display-name="ASP.NET Core 1.0" \
    io.openshift.expose-services="5000:http" \
    io.openshift.tags="builder,webserver,html,aspdotnet" \
    io.openshift.s2i.scripts-url="image:///usr/libexec/s2i" \
    io.openshift.s2i.destination="/opt/app-root"

RUN yum install -y libunwind libicu && \
    yum clean all -y && \
    mkdir -p ${HOME} && \
    chown -R 1001:0 ${HOME}/ && \
    chown -R 1001:0 /opt/app-root && \
    curl -L -o /tmp/dotnet-install.sh https://raw.githubusercontent.com/dotnet/cli/v$ASPNETCORE_VERSION/scripts/obtain/dotnet-install.sh && \
    chmod +x /tmp/dotnet-install.sh && \
    /tmp/dotnet-install.sh --version $INSTALLER_ASPNETCORE_VERSION --install-dir /dotnet && \
    ln -s /dotnet/dotnet /usr/local/bin && \
    rm -rf /tmp/dotnet-install.sh


EXPOSE 5000/tcp

# Copy the S2I scripts to /usr/libexec/s2i since we set the label that way
COPY  ["s2i/run", "s2i/assemble", "s2i/save-artifacts", "s2i/usage", "/usr/libexec/s2i/"]

USER 1001

WORKDIR $HOME

# Modify the usage script in your application dir to inform the user how to run
# this image.
CMD ["/usr/libexec/s2i/usage"]


