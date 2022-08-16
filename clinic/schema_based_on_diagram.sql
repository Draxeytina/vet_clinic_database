--Create clinic databased
CREATE DATABASE clinic

--Create patients table
CREATE TABLE patients  (
  id INT GENERATED BY DEFAULT AS IDENTITY,
  name VARCHAR(30),
  date_of_birth DATE,
  PRIMARY KEY(id)
);

--Create medical histories table
CREATE TABLE medical_histories (
  id INT GENERATED BY DEFAULT AS IDENTITY,
  admitted_at TIMESTAMP,
  patient_id INT,
  FOREIGN KEY(patient_id) REFERENCES patients(id),
  status VARCHAR,
  PRIMARY KEY(id)
);

--Create treatments table
CREATE TABLE treatments (
  id INT GENERATED BY DEFAULT AS IDENTITY,
  type VARCHAR,
  name VARCHAR,
  PRIMARY KEY (id)
);

--Create invoices table
CREATE TABLE invoices (
id INT GENERATED BY DEFAULT AS IDENTITY,
total_amount DECIMAL,
generated_at TIMESTAMP,
payed_at TIMESTAMP,
medical_history_id INT,
FOREIGN KEY (medical_history_id) REFERENCES medical_histories(id),
PRIMARY KEY (id)
);

--Create invoice items table
CREATE TABLE invoice_items (
id INT GENERATED BY DEFAULT AS IDENTITY,
unit_price DECIMAL,
quantity INT,
total_price DECIMAL,
invoice_id INT,
treatment_id INT,
FOREIGN KEY (invoice_id) REFERENCES invoices(id),
FOREIGN KEY (treatment_id) REFERENCES treatments(id),
PRIMARY KEY (id)
);

--Join table for medical history and treatment
CREATE TABLE treatment_history_link (
medical_history_id INT,
treatments_id INT,
FOREIGN KEY (medical_history_id) REFERENCES medical_histories(id),
FOREIGN KEY (treatments_id) REFERENCES treatments (id)
);

--Create indexes for the join table
CREATE INDEX medical_history_id_asc ON treatment_history_link(medical_history_id ASC)
CREATE INDEX treatments_id_asc ON treatment_history_link(treatments_id ASC)
CREATE INDEX patients_id_asc ON medical_histories(patient_id asc)
CREATE INDEX invoice_id_asc ON invoice_items(invoice_id)
CREATE INDEX treatment_id_asc ON invoice_items(treatment_id)
CREATE INDEX medical_history_id_asc2 ON invoices(medical_history_id)