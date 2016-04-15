# s2i-aspnet
 Red Hat OpenShift Source-to-Image template for ASP.NET applications

This repository contains the source for creating a
source-to-image (https://github.com/openshift/source-to-image) builder image,
which be used to create reproducible Docker images from your ASP.NET project's
source code.  The resulting image can be run using Docker.

For more information about using these images with OpenShift, please see
the official OpenShift Documentation (https://docs.openshift.org/latest/using_images/s2i_images/php.html) .

# Versions

Go versions currently supported are:

* ASP.NET 5

The following operating system base images are supported:

* We are using the official docker image from Microsoft as the base

# Installation

To build a ASP.NET builder image, execute:

```
$ git clone https://github.com/openshift-s2i/s2i-aspnet.git
$ cd s2i-aspnet
$ docker build -t aspapp .
```

# Usage

There are several sample Go applications included with this repository.  To
build a simple Go test application using the standalone

```
$ s2i build source/ aspapp aspnet-app --loglevel=5
```

The resulting image can be executed using docker:

```
$ docker run -t -p 5000:5000 aspnet-app
```

Once the container is running, it should be accessible using:

```
$ curl 127.0.0.1:5000
```
