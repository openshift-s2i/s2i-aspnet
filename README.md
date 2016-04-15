# s2i-aspnet
 Red Hat OpenShift Source-to-Image template for ASP.NET applications

This repository contains the source for creating a
source-to-image (https://github.com/openshift/source-to-image) builder image,
which be used to create reproducible Docker images from your ASP.NET project's
source code.  The resulting image can be run using Docker.

High level process

1. Create the OpenShift ASP.NET base image (creates docker image 'aspapp')
2. Merge source code using the S2I tool into the OpenShift image (creates docker image 'aspnet-app')
3. Run the new OpenShift ASP.NET base image

For more information about using these images with OpenShift, please see
the official OpenShift Documentation (https://docs.openshift.com/enterprise/3.1/creating_images/s2i.html) .

# Versions

ASP.NET versions currently supported are:

* ASP.NET 5

We are using the official docker image from Microsoft as the base (http://docs.asp.net/en/latest/getting-started/installing-on-linux.html#id9)

# Demo Application

A sample ASP.NET application was generated using Yeoman (http://docs.asp.net/en/latest/client-side/yeoman.html) and moved the source code into a folder called "source" to provide an example of an application that was built using the builder

# Building and Running 

The builder and demo application can be built and run either in standalone or within OpenShift

# OpenShift

Use the following steps to builder the builder image and then execute a S2I build of the application.

Login to OpenShift using the Command Line Interface (CLI) tools and create a new project (in this example, we created a project called "dot-net")

```
oc new-project dot-net
```

Start a new build of the S2I builder

oc new-build https://github.com/sabre1041/s2i-aspnet#ose-support
	
Use `oc get builds` to track the status of the build.

Once the build has completed, create a new application

```
oc new-app s2i-aspnet~https://github.com/openshift-s2i/s2i-aspnet --context-dir=source --name=aspnet-app
```

Create a new route so that the application is accessible outside the OpenShift environment

```
oc expose service aspnet-app
```

The application will now be available at http://aspnet-app-dot-net.&lt;default_subdomain&gt;

# Standalone

To build a ASP.NET builder image, execute:

```
$ git clone https://github.com/openshift-s2i/s2i-aspnet.git
$ cd s2i-aspnet
$ docker build -t aspapp .
```

With the builder image now available, execute the s2i tool to build a new image of the application:

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

# Openshift Usage

create the s2i builder image, dont need service or deployment

    oc new-project aspnet --display-name="ASP.NET s2i" --description='ASP.NET s2i'
    oc new-app https://github.com/eformat/s2i-aspnet --name=aspapp --strategy=docker
    oc delete svc aspapp
    oc delete dc aspapp

s2i needs access to docker dameon, so as the cluster amdin

    oadm policy add-scc-to-user privileged system:serviceaccount:aspnet:builder

and now build the application

    oc new-app --image-stream=aspnet/aspapp --code=https://github.com/eformat/s2i-aspnet --context-dir=source --name=aspnet-app --strategy=source
    oc expose svc/aspnet-app --hostname=microsoft-loves-linux.apps.hpteams.com
