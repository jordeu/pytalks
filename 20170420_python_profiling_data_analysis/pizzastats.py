import random
import pandas as pd

def pizzas_per_member(data, sampling=1000):
    
    pizzas = [15.0, 16.5, 18.0, 19.5, 21.0, 22.5, 24.0, 25.5, 27.0, 28.5, 30.0]
    
    slices_member = [0] * len(data)
    slices_active = [0] * len(data)
    
    data_total = data['total'].tolist()
    data_active = data['active'].tolist()
    
    for _ in range(sampling):
        
        pizzas_meetup = random.choices(pizzas, k=len(data_total))                          
        
        for i, (total, active) in enumerate( zip( data_total, data_active ) ):
            
            a = (1 / sampling)
            d = pizzas_meetup[i] * 8
            
            b = d / total
            c = d / active
            
            e = a * min(b, 8)
            f = a * min(c, 8)
                        
            slices_member[i] += e
            slices_active[i] += f
            
    return pd.DataFrame.from_dict({'date': data.index, 'active': slices_active, 'total': slices_member}).set_index(['date'])