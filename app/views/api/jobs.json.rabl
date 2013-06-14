collection @jobs, :object_root => false

attributes  :id,
            :kind,
            :role,
            :skills,
            :title,
            :truncated_title,
            :zip_code,
            :address,
            :company_name,
            :formatted_salary_low,
            :formatted_salary_high,
            :formatted_hourly_low,
            :formatted_hourly_high,
            :formatted_equity_low,
            :formatted_equity_high,
            :city_name,
            :posted_date,
            :posted_date_timestamp,
            :thumbnail_url,
            :email,
            :clickthrough

attributes  :salary_comp? => :salary_comp,
            :equity_comp? => :equity_comp,
            :hourly_comp? => :hourly_comp
