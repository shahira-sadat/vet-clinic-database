DROP DATABASE IF EXISTS clinic;
CREATE DATABASE clinic;

/* create patients table */
CREATE TABLE patients (
    id BIGSERIAL NOT NULL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    date_of_birth DATE NOT NULL
);

/* create table medical_histories */
CREATE TABLE medical_histories (
    id BIGSERIAL NOT NULL PRIMARY KEY,
    admitted_at TIMESTAMP NOT NULL,
    patient_id BIGINT NOT NULL REFERENCES patients(id),
    status VARCHAR(255) NOT NULL
);

/* create table invoices with one to one relationship with medical_histories
   which means medical_history will be the primary key of invoices table */
CREATE TABLE invoices (
    medical_history_id BIGINT NOT NULL REFERENCES medical_histories(id),
    total_amount DECIMAL(10,2) NOT NULL,
    generated_at TIMESTAMP NOT NULL,
    payed_at TIMESTAMP NOT NULL
);

/* create table treatments */
CREATE TABLE treatments (
    id BIGSERIAL NOT NULL PRIMARY KEY,
    type VARCHAR(50) NOT NULL,
    name VARCHAR(100) NOT NULL
);

/* create table treatments_medical_histories(m:n relation) */
CREATE TABLE treatments_medical_histories (
    treatments_id INT NOT NULL REFERENCES treatments(id),
    medical_history_id INT NOT NULL REFERENCES medical_histories(id)
);

/* create table invoice_items */
CREATE TABLE invoice_items (
    id BIGSERIAL NOT NULL PRIMARY KEY,
    unit_price DECIMAL(10,2) NOT NULL,
    quantity INT NOT NULL,
    total_price DECIMAL(10,2) NOT NULL,
    invoice_id INT NOT NULL REFERENCES invoices(medical_history_id) ,
    treatments_id INT REFERENCES treatments(id)
);

CREATE INDEX ON medical_histories (patient_id);
CREATE INDEX ON invoice_items (invoice_id);
CREATE INDEX ON invoices (medical_history_id);
CREATE INDEX ON treatments_medical_histories (treatments_id);
CREATE INDEX ON treatments_medical_histories (medical_history_id);
CREATE INDEX ON invoice_items (treatments_id);

