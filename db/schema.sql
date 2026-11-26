DROP schema public CASCADE; 
CREATE SCHEMA public;

CREATE TYPE status1 AS ENUM ('active', 'deload', 'completed');
CREATE TYPE set_type1 as ENUM ('warmup', 'working');
CREATE TYPE equipment as ENUM('barbell', 'dumbell', 'machine', 'cable', 'bodyweight');


CREATE TABLE IF NOT EXISTS exercises (
    exercise_id serial primary key,
    exercise_name varchar(50) unique not null,
    primary_muscle_group varchar(50) not null,
    secondary_muscle_groups VARCHAR(50)[],
    equipment_type equipment,
    default_load_increment decimal check(default_load_increment > 0)
);


CREATE TABLE IF NOT EXISTS mesocycles (
    meso_name varchar(50) primary key,
    starting_date TIMESTAMP not null,
    ending_date TIMESTAMP,
    current_status status1 not null
);

create unique index unique_active_status on mesocycles (current_status)
where current_status = 'active';



CREATE TABLE IF NOT EXISTS workout_templates (
    temp_id serial primary key,
	temp_name varchar(50) unique not null
);

create table if not exists template_exercises (
	temp_id int references workout_templates (temp_id),
	exercise_id int references exercises(exercise_id),
	work_sets int not null check (work_sets > 0),
	exercise_order int not null check (exercise_order > 0),
	min_reps int not null check (min_reps > 0),
	max_reps int not null check (max_reps >= min_reps),
	primary key (temp_id, exercise_id),
	unique (temp_id,exercise_order)
);


CREATE TABLE IF NOT EXISTS work_session (
    session_id serial primary key,
    temp_id int references workout_templates (temp_id),
    session_date TIMESTAMP not null,
    meso_name varchar(50) references mesocycles (meso_name),
    curr_bw decimal not null check (curr_bw > 0)
);




CREATE TABLE IF NOT EXISTS logged_sets (
    session_id int references work_session (session_id),
    exercise_id int references exercises (exercise_id),
    set_order int not null check(set_order > 0),
    set_type set_type1 not null,
    weight_kg decimal not null check (weight_kg >= 0),
    reps int not null check (reps >0),
    rir int check (rir between 0 and 5 or rir is null),
    primary key (session_id,exercise_id,set_order)
);

create index logging on logged_sets (exercise_id, session_id);
CREATE INDEX idx_session_meso_date ON work_session (meso_name, session_date DESC);
