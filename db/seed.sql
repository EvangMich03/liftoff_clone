INSERT INTO exercises (exercise_name,primary_muscle_group,secondary_muscle_groups,equipment_type,default_load_increment)
VALUES  ('hacksquat','quadriceps','{hamstrings,glutes}','machine',2.5), 
		('barbell bench','chest','{triceps,shoulders}','barbell',1.25),
		('lateral raises','shoulders',NULL,'dumbell',1.25),
		('hamstring curl','hamtrings',NULL,'machine',2.5),
		('bicep curl','biceps',NULL,'dumbell',1.25),
		('calf raises','calves',NULL,'machine',1.25),
		('lat pulldown','back','{biceps}','machine',2.5),
		('dips','chest','{shoulders,triceps}','bodyweight',2.5),
		('hip thrust','glutes',NULL,'machine',2.5)
		on conflict do nothing;

insert into WORKOUT_TEMPLATES (temp_name) 
values ('Upper A'), ('Lower A')
on conflict do nothing;



INSERT INTO TEMPLATE_EXERCISES  (temp_id,exercise_id,work_sets,exercise_order,min_reps,max_reps)
select wt.temp_id,e.exercise_id,v.work_sets,v.exercise_oder,v.min_reps,v.max_reps
from 	(values ('Upper A','barbell bench',2,1,8,12),
				('Upper A','bicep curl',3,2,10,15)				
) as v(temp_name,exercise_name,work_sets,exercise_oder,min_reps,max_reps)
join WORKOUT_TEMPLATES WT on wt.temp_name = v.temp_name
join exercises e on e.EXERCISE_NAME  = v.EXERCISE_NAME
on conflict do nothing;

select * from TEMPLATE_EXERCISES TE;


			
