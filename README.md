# s2i-dotnet

[![Travis CI Build Status](https://travis-ci.org/openshift-s2i/s2i-aspnet.svg?branch=master)](https://travis-ci.org/openshift-s2i/s2i-aspnet)

Red Hat OpenShift Source-to-Image template for ASP.NET Core applications

This repository contains the source for creating a
source-to-image (https://github.com/openshift/source-to-image) builder image,
which be used to create reproducible Docker images from your ASP.NET Core project's
source code.

For more information about using Source to Image with OpenShift, please see
the official OpenShift Documentation (https://docs.openshift.com/enterprise/3.1/creating_images/s2i.html) .

# Building the Builder Image

This S2I builder can be built within OpenShift or locally using docker. The following will describe the steps necessary to produce a new builder image called *s2i-dotnet* that can be used to produce S2I builds of .NET Core applications. 

## OpenShift

After logging into an OpenShift environment and creating a new project, start a new build of the S2I builder

    oc new-build https://github.com/openshift-s2i/s2i-aspnet

Or, to push the contents of the repository that has been cloned to the local machine, run the following command:

```
oc new-build microsoft/dotnet --name=s2i-aspnet --binary=true
oc start-build s2i-aspnet --from-dir=.
```
	
Use `oc get builds` to track the status of the build. Once complete, the builder image can be used to produce new images containing ASP.NET Core applications.
 
## Docker

Execute the following steps to build a new docker image containing the S2I builder:

```
git clone https://github.com/openshift-s2i/s2i-aspnet.git
cd s2i-aspnet
docker build -t s2i-aspnet .
```

The resulting image can be used by the S2I to combine the application source into a new image or pushed to OpenShift's internal registry for use within the platform.


# Versions

ASP.NET Core versions currently supported are:

* ASP.NET Core 1.0.0 RC2+

We are using the official docker image from Microsoft as the base (https://github.com/dotnet/dotnet-docker)

# Demo Application

A sample ASP.NET Core application is available to demonstrate the the functionality of this S2I builder. Full instructions can be found at the following location:
 
[https://github.com/openshift-s2i/s2i-aspnet-example](https://github.com/openshift-s2i/s2i-aspnet-example)


