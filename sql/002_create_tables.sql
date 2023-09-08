CREATE TABLE "public"."users" (
  "id" serial PRIMARY KEY,
  "first_name" varchar NOT NULL,
  "last_name" varchar NOT NULL,
  "email" varchar NOT NULL,
  "password" varchar,
  "created_at" TIMESTAMP DEFAULT NOW()
);

CREATE TABLE "public"."projects" (
  "id" serial PRIMARY KEY,
  "title" varchar NOT NULL,
  "description" text,
  "manager_user_id" integer NOT NULL,
  "created_at" TIMESTAMP DEFAULT NOW()
);

CREATE TABLE "public"."project_members" (
  "id" serial PRIMARY KEY,
  "user_id" integer NOT NULL,
  "project_id" integer NOT NULL,
  "created_at" TIMESTAMP DEFAULT NOW()
);

CREATE TABLE "public"."tasks" (
  "id" serial PRIMARY KEY,
  "project_id" integer NOT NULL,
  "key" varchar,
  "title" varchar NOT NULL,
  "description" text,
  "task_type_id" integer NOT NULL,
  "parameters" json,
  "results" json,
  "created_at" TIMESTAMP DEFAULT NOW(),
  "started_at" timestamp,
  "finished_at" timestamp
);

CREATE TABLE "public"."task_types" (
  "id" serial PRIMARY KEY,
  "title" varchar,
  "created_at" TIMESTAMP DEFAULT NOW()
);

COMMENT ON COLUMN "public"."projects"."description" IS 'Description of the project';

COMMENT ON COLUMN "public"."tasks"."description" IS 'Description of the task';

ALTER TABLE "public"."project_members" ADD CONSTRAINT project_members_user_id_fkey FOREIGN KEY (user_id)
        REFERENCES public.users (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE CASCADE;

ALTER TABLE "public"."project_members" ADD CONSTRAINT project_members_project_id_fkey FOREIGN KEY (project_id)
        REFERENCES public.projects (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE CASCADE;

ALTER TABLE "public"."projects" ADD CONSTRAINT projects_manager_user_id_fkey FOREIGN KEY (manager_user_id)
        REFERENCES public.users (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE SET NULL;

ALTER TABLE "public"."tasks" ADD CONSTRAINT tasks_project_id_fkey FOREIGN KEY (project_id)
        REFERENCES public.projects (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE CASCADE;

ALTER TABLE "public"."tasks" ADD FOREIGN KEY ("task_type_id") REFERENCES "public"."task_types" ("id");

ALTER TABLE "public"."project_members" ADD CONSTRAINT project_members_user_project_unique UNIQUE (user_id, project_id);

GRANT ALL ON TABLE public.users TO api_anon_user;
GRANT ALL ON TABLE public.projects TO api_anon_user;
GRANT ALL ON TABLE public.project_members TO api_anon_user;
GRANT ALL ON TABLE public.tasks TO api_anon_user;
GRANT ALL ON TABLE public.task_types TO api_anon_user;

GRANT USAGE, SELECT ON ALL SEQUENCES IN SCHEMA public TO api_anon_user;