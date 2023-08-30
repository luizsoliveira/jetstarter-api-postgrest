# Rapid REST API development with PostgREST (under construction...)

This repository consists of providing a functional playground that allows you to build a REST API ecosystem in just 1 min. 

![](./doc/images/API-ecosystem-Postgrest-OverviewArchitecture.png "")
*Figure 1. API ecosystem with Docker-compose, Postgres, PostgREST, and Swagger*

In a real world environment, a REST API does not work by itself in isolation. Figure 1 illustrates the basic infrastructure ecosystem of a typical API that serves information persisted by a database.
 
 * Postgres: relational database that will perform the function of data persistence preserving referential integrity.
 * PostgREST: Web server responsible for exposing REST endoints and an API description according to the  OpenAPI standard.
 * Swagger: service that generates an HTML documentation page from the OpenAPI description.

 ## Deploying a REST API in 1 min
 
 Unlike many tutorials available on the internet, which will require extensive step-by-step tasks to be carried out, in this case the entire process is automated through Infrastructure as Code (Iac) with Docker-compose.

 Before running the codes below, make sure you already have Docker installed and started on your computer. [Link](https://docs.docker.com/get-docker/) with instructions to install Docker.

```shell
git clone https://github.com/luizsoliveira/jetstarter-api-postgrest

cd jetstarter-api-postgrest

docker-compose up

```

The sequence of commands above fetchs the microservices/containers infrastructure shown in Figure 1. After downloading the images and initializing the containers, the services are available at the following URLs:

* OpenAPI description: http://localhost:3000/
* Public REST endpoint: http://localhost:3000/countries
* API documentation: http://localhost:8080/

## Understanding what's behind the magic

When it comes to systems development, a subject that always arouses my interest is reuse and automatic code generation. There is a fair amount of project code, especially at the project's beginning, that can be generated automatically using special tools.

An excellent example for applying this technique can be the rapid development of a REST API, a demand common to almost all projects. In this article we will talk about PostgREST.

According to the official website, PostgREST is a standalone web server that turns your PostgreSQL database directly into a RESTful API. The structural constraints and permissions in the database determine the API endpoints and operations.

The strategy applied by PostgREST consists in the belief that the database has all the information about the model needed to generate the endpoints of a REST API. According to the creators, writing exclusive code for the API ends up incurring in duplication of business rules or inconsistency with what was defined in the database.

With this principle in mind, PostgREST performs a robust introspection in the database, gathering all the necessary information about structures and permissions. With this information, it creates a database schema cache that is used to operationalize the API endpoints.

![](./doc/images/API-ecosystem-Postgrest-Workflow.png "")
*Figure 2. API development workflow with PostgREST*

Figure 2 illustrates the development flow of an REST API using the PostgREST + Swagger ecosystem. According to the workflow above, the only necessary code input are the SQL commands responsible for defining the relational model.

As previously mentioned, in this approach the only source of knowledge is the database, from which all information about structures and access permissions can be obtained.

Through the introspection of the structures present in the database, such as schemas, tables, relationships, views, functions, among others, PostgREST builds a cache that is used for the dynamic generation of structures that would be equivalent to the controllers of a traditional development.

For the implementation of CRUD endpoints, the effort is minimal, just modeling the structures in the database, which would already be done anyway. With only the input of SQLs, PostgREST is already able to offer the CRUD endpoints of each entity, as well as the technical description of the API in OpenAPI format. Finally, from this description Swagger renders the documentation page.




