# How to automate release documentation of protobufs

Sysl is a "system specification language" that takes the likes of swagger or proto, although it attempts to go futher than just specifying API definitions, but also the interactions between those services. 

Over the last couple of months me and a couple of colleagues have been working on a solution to ease the pain of creating diagram documentation by automating the process with the diagram generation capabilities of sysl. 
In this example I'll be focusing on generating sequence diagrams for a grpc demo.
So how does it work?

There are two parts of it;
1. Generating sysl from protos
2. Generating Diagrams from sysl

Generating sysl from protos
The first tool we'll be using is actually a proto plugin; [protoc-gen-sysl](https://github.com/anz-bank/protoc-gen-sysl)
This generates proto source code from your proto source files

to run this tool, you can run
```
protoc --sysl_out=sysl/generated proto/*.proto

```
This will generate a index.sysl file in `sysl/generated/` - Now we need to write some sysl:

create a file named "myservice.sysl" in the sysl/ directory and add the following lines:
```
Example sysl goes here
```
Now this is where the fun begins

2. Generating Diagrams from sysl
Now we've got our Project setup we can use the `sysl-catalog` tool to automatically generate our diagrams:
install sysl-catalog 
```
go get -u github.com/anz-bank/sysl-catalog
```
and set `export SYSL_PLANTUML=http://www.plantuml.com/plantuml` to tell sysl which plantuml service to use - If you don't want to send plantuml all of your launch codes you can run [plantuml in a docker container](https://hub.docker.com/r/plantuml/plantuml-server/). 
now run `sysl-catalog --server sysl/example.sysl` and go to `localhost:6900`
Now you've got a complete view of how your system fits together. 
You can edit the source sysl files and web view will update.

Once you're happy with the diagrams run
```
sysl-catalog -o docs/ sysl/myservice.sysl
```

And now all the markdown is generated to the docs directory! 
This example is available at [http://github.com/joshcarp/sysl-catalog-example]()

Please leave an issue on [http://github.com/anz-bank/sysl-catalog]() or [http://github.com/anz-bank/protoc-gen-sysl]() is you're having any problems; lots of this is in the very early stages and it'll be good to get your feedback on how to develop this futhur