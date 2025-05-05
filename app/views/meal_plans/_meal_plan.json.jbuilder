json.extract! meal_plan, :id, :start_date, :end_date, :user_id, :created_at, :updated_at
json.url meal_plan_url(meal_plan, format: :json)
