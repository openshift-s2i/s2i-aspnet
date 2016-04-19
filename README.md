# s2i-aspnet
![Travis CI](https://travis-ci.org/openshift-s2i/s2i-aspnet.svg?branch=master)

Red Hat OpenShift Source-to-Image template for ASP.NET applications

This repository contains the source for creating a
source-to-image (https://github.com/openshift/source-to-image) builder image,
which be used to create reproducible Docker images from your ASP.NET project's
source code.  The resulting image can be run using Docker.

High level process

1. Create the OpenShift ASP.NET base image (creates docker image 'aspapp')
2. Merge source code using the S2I tool into the OpenShift image (creates docker image 'aspnet-app')
3. Run the new OpenShift ASP.NET base+code image

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

Login to OpenShift using the Command Line Interface (CLI) tools

    oc login -u <user> <openshift_server>

Enter the password at the prompt

Create a new project (in this example, we created a project called "dot-net")

```
oc new-project dot-net
```

Start a new build of the S2I builder

    oc new-build https://github.com/openshift-s2i/s2i-aspnet
	
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