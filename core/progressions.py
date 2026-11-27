import pandas as pd
import numpy as np
import math
import logging


logging.basicConfig(level=logging.INFO)



def calculate_e1rm(weight: float, reps:int) -> float:
    if reps <= 0:
        raise ValueError("You are not allowed to use zero or negative reps")

    if weight < 0:
        raise ValueError("You cannot use negative weight")
    
    if reps == 1:
        return weight
    else:
        return round(weight * (1 + (reps/30)),2)



def calculate_relative_strength(e1rm:float, bw:float) -> float:
    if bw <=0:
        raise ValueError("You are not allowed to input 0 or negative bw")

    return round(e1rm/bw,2)


def evaluate_progression(target_work_sets:int, min_reps:int, max_reps:int, load_increment_kg:float, set_list: list):
    #INITIAL_CALIBRATION = (suggested_weight_kg = None, target_reps = min_reps)

    old_work_sets = [(set_type,weight_kg,reps) for (set_type,weight_kg,reps) in set_list if set_type != 'warmup']
    reps = [(set_type,weight_kg,reps) for (set_type,weight_kg,reps) in old_work_sets if reps >= max_reps]
    if len(old_work_sets) == 0:
        return None,min_reps

    elif len(old_work_sets) >= target_work_sets and len(reps) >= target_work_sets:
        return old_work_sets[0][1] + load_increment_kg, min_reps

    else:
        return old_work_sets[0][0],max_reps



def aggregate_weekly_volume(logged_sets:list[dict]):
    logged_sets = repositories.get_logged_sets()
    volume = {}
    if logged_sets['status'] == 'warmup':
        logged_sets.remove[x]
    if current_status == 'deload':
        return

    if secondary_muscle_groups:
        volume[secondary_muscle_groups]+=0.5
    else:
        volume[primary_muscle_group]+=1.0    




    

def main():

    set_list = [('warmup',30,5),('working',80,8),('working',80,10)]

    reps =  [3,4,5]
    logging.info(np.array(reps)>=4)
    old_work_sets = [(set_type,weight_kg,reps) for (set_type,weight_kg,reps) in set_list if set_type != 'warmup']
    logging.info(old_work_sets[2])

    logging.info(calculate_relative_strength(100,-1))

if __name__ == '__main__':
    main()