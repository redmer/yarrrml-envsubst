# `ghcr.io/redmer/yarrrml-envsubst`

Repository for a Docker image that

1. Substitutes environment variables in Yarrrml files
1. Processes Yarrrml files into RML files

This can then be used for processes like `docker.io/rmlio/rmlmapper-java`.

## Usage

> `docker run -v $(pwd)/rml:/data ghcr.io/redmer/yarrrml-envsubst /data/source.rml.yaml`

## Container layout

- `/app`: working directory
- `/tmp`: secrets substituted YARRRML file
- `/data`: compiled RML

## FAQ

**Why compile YARRRML**  
YARRRML is definitely hand-writable, moreso than RML in any RDF serialization.
The RMLMapper or RMLStreamer libraries however cannot interpret YARRRML, so it needs to be compiled.
First, environment variables are mixed in the YAML file; this allows for further configuration, like database passwords.
Then, the YAML file is converted to conventional RML RDF and output as Turtle.
