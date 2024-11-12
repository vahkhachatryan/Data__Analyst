import pandas as pd
from sqlalchemy import create_engine
from sqlalchemy.types import String


file_path = 'Impact_of_Remote_Work_on_Mental_Health.csv'
data = pd.read_csv(file_path)

engine = create_engine('postgresql://postgres:postgres@localhost:5432/Final_Project')

data.columns = data.columns.str.lower()

data['employee_id'] = data['employee_id'].astype(str)

employees_data = data[['employee_id', 'age', 'gender', 'job_role', 'industry', 'years_of_experience', 'region']]

employees_data['age'] = employees_data['age'].fillna(0).astype(int).astype(str)
employees_data['years_of_experience'] = employees_data['years_of_experience'].fillna(0).astype(float).astype(str)

try:
    employees_data.to_sql('employees', engine, if_exists='append', index=False, 
                          dtype={'employee_id': String(), 'age': String(), 'gender': String(), 
                                 'job_role': String(), 'industry': String(), 
                                 'years_of_experience': String(), 'region': String()})
    print("Employees data inserted successfully!")
except Exception as e:
    print(f"Error inserting employees data: {e}")

work_info_data = data[['employee_id', 'work_location', 'hours_worked_per_week', 'number_of_virtual_meetings', 'work_life_balance_rating', 'company_support_for_remote_work']]

work_info_data['hours_worked_per_week'] = work_info_data['hours_worked_per_week'].fillna(0).astype(float).astype(str)
work_info_data['number_of_virtual_meetings'] = work_info_data['number_of_virtual_meetings'].fillna(0).astype(int).astype(str)
work_info_data['work_life_balance_rating'] = work_info_data['work_life_balance_rating'].fillna(0).astype(int).astype(str)

try:
    work_info_data.to_sql('work_info', engine, if_exists='append', index=False, 
                          dtype={'employee_id': String(), 'work_location': String(), 
                                 'hours_worked_per_week': String(), 'number_of_virtual_meetings': String(), 
                                 'work_life_balance_rating': String(), 'company_support_for_remote_work': String()})
    print("Work info data inserted successfully!")
except Exception as e:
    print(f"Error inserting work info data: {e}")

mental_health_data = data[['employee_id', 'stress_level', 'mental_health_condition', 'access_to_mental_health_resources', 'social_isolation_rating', 'satisfaction_with_remote_work', 'productivity_change']]

mental_health_data['stress_level'] = mental_health_data['stress_level'].fillna('Unknown').astype(str)
mental_health_data['social_isolation_rating'] = mental_health_data['social_isolation_rating'].fillna('Unknown').astype(str)
mental_health_data['satisfaction_with_remote_work'] = mental_health_data['satisfaction_with_remote_work'].fillna('Unknown').astype(str)
mental_health_data['productivity_change'] = mental_health_data['productivity_change'].fillna(0).astype(float).astype(str)

try:
    mental_health_data.to_sql('mental_health', engine, if_exists='append', index=False, 
                              dtype={'employee_id': String(), 'stress_level': String(), 
                                     'mental_health_condition': String(), 
                                     'access_to_mental_health_resources': String(), 
                                     'social_isolation_rating': String(), 
                                     'satisfaction_with_remote_work': String(), 
                                     'productivity_change': String()})
    print("Mental health data inserted successfully!")
except Exception as e:
    print(f"Error inserting mental health data: {e}")

wellness_data = data[['employee_id', 'physical_activity', 'sleep_quality']]

wellness_data['physical_activity'] = wellness_data['physical_activity'].fillna('Unknown').astype(str)
wellness_data['sleep_quality'] = wellness_data['sleep_quality'].fillna('Unknown').astype(str)

try:
    wellness_data.to_sql('wellness', engine, if_exists='append', index=False, 
                         dtype={'employee_id': String(), 'physical_activity': String(), 
                                'sleep_quality': String()})
    print("Wellness data inserted successfully!")
except Exception as e:
    print(f"Error inserting wellness data: {e}")
