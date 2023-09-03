# ChatAndFileService - Backend

This is the backend component of the ChatAndFileService project. It is built using Java and Maven.

## Why Maven?

Maven was selected over alternatives like Gradle for its well-established ecosystem, strong dependency management, and integration with our Java backend.

Maven follows "convetion over configuration" which provides more upfront defaults helping developers focus more on development and less on setup.

Maven is also the industry standard for dependency management.

## Setup Commands

The folder was initialized using: 

```bash
mvn archetype:generate \
  -DgroupId=com.computationista \
  -DartifactId=ChatAndFileService \
  -DarchetypeGroupId=org.apache.maven.archetypes \
  -DarchetypeArtifactId=maven-archetype-quickstart

```

## Build and Install

1. Navigate to the `backend/` folder.
2. Run `mvn clean install` to build and install the project.

For more detailed instructions, refer to [official Maven documentation](https://maven.apache.org/guides/).
