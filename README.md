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
the official OpenShift Documentation (https://docs.openshift.org/latest/using_images/s2i_images/php.html) .

# Versions

ASP.NET versions currently supported are:

* ASP.NET 5

We are using the official docker image from Microsoft as the base (http://docs.asp.net/en/latest/getting-started/installing-on-linux.html#id9)

# Installation

To build a ASP.NET builder image, execute:

```
$ git clone https://github.com/openshift-s2i/s2i-aspnet.git
$ cd s2i-aspnet
$ docker build -t aspapp .
```

# Usage

We generated a sample ASP.NET application using Yeoman (http://docs.asp.net/en/latest/client-side/yeoman.html) and moved the source code into a folder called "source".   To build with your own project, just replace the contents in the folder "source" and execute the s2i tool. 

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

Personally, I use a Mac to generate my code and docker image so I just open a browser to http://192.168.99.100:5000/`
