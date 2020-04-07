all: proto diagrams
.PHONY: proto diagrams
proto:
	protoc --sysl_out=sysl/generated proto/*.proto
	
diagrams:
