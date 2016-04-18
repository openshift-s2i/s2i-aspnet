FROM microsoft/aspnet

MAINTAINER Albert Wong <albert@redhat.com>

ENV \ 
    ASPNET_VERSION=5.0 \
    HOME=/opt/app-root/src

# Set the labels that are used for Openshift to describe the builder image.
LABEL io.k8s.description="ASP.NET 5.0" \
    io.k8s.display-name="ASP.NET 5.0" \
    io.openshift.expose-services="5000:http" \
    io.openshift.tags="builder,webserver,html,aspnet" \
    # this label tells s2i where to find its mandatory scripts
    # (run, assemble, save-artifacts)
    io.openshift.s2i.scripts-url="image:///usr/libexec/s2i"

RUN printf "deb http://ftp.us.debian.org/debian jessie main\n" >> /etc/apt/sources.list && \
    apt-get -qq update && apt-get install -qqy sqlite3 libsqlite3-dev && rm -rf /var/lib/apt/lists/* && \
    mkdir -p ${HOME} && \
    chown -R 1001:0 ${HOME}/ && \
    useradd -u 1001 -r -g 0 -d ${HOME} -s /sbin/nologin -c "Default Application User" default && \
    chown -R 1001:0 /opt/app-root

#COPY . /app
#WORKDIR /app
#RUN ["dnu", "restore"]

EXPOSE 5000/tcp
#ENTRYPOINT ["dnx", "-p", "source/project.json", "Microsoft.AspNet.Server.Kestrel", "--server.urls", "http://0.0.0.0:5000"]

# Copy the S2I scripts to /usr/libexec/s2i since we set the label that way
COPY  ["s2i/run", "s2i/assemble", "s2i/save-artifacts", "s2i/usage", "/usr/libexec/s2i/"]

USER 1001

# Modify the usage script in your application dir to inform the user how to run
# this image.
CMD ["/usr/libexec/s2i/usage"]


