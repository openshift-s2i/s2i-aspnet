# s2i-aspnet
 Red Hat OpenShift Source-to-Image template for ASP.NET applications

This repository contains the source for creating a
https://github.com/openshift/source-to-image[source-to-image] builder image,
which be used to create reproducible Docker images from your ASP.NET project's
source code.  The resulting image can be run using https://docker.com[Docker].

For more information about using these images with OpenShift, please see
the official
https://docs.openshift.org/latest/using_images/s2i_images/php.html[OpenShift
Documentation].

# Versions

Go versions currently supported are:

* ASP.NET 7

The following operating system base images are supported:

* We are using the official docker image from Microsoft as the base

# Installation

To build a ASP.NET builder image, execute:

-------------------------------------------------------
$ git clone https://github.com/openshift-s2i/s2i-go.git
$ cd s2i-go
-------------------------------------------------------

# Usage

There are several sample Go applications included with this repository.  To
build a simple Go test application using the standalone

---------------------------------------------------------------------------------
$ s2i build https://github.com/openshift-s2i/s2i-go.git \
    --context-dir=1.4/test/test-app openshift/go-14-centos7 go-test-app
---------------------------------------------------------------------------------

The resulting image can be executed using https://docker.com[docker]:

------------------------------------------
$ docker run --rm -p 5000:5000 go-test-app
------------------------------------------

Once the container is running, it should be accessible using:

---------------------
$ curl 127.0.0.1:5000
---------------------
