Hospital Admissions Database: Vital Link
-----------------------------------------
Overview
------------
The Hospital Admissions Database is the central control system for patient intake, designed to operate with high speed and accuracy in the hospital's fast-paced environment. The system's core function is to automatically assign the optimal Doctor, Branch, and Bed (Standard, ICU, or Emergency) based on a patient's initial profile and priority level.

Getting Started
-------------------
  In order to run this locally, you will need my PHP Admin.

1. On my PHP Admin, import the HospitalAdmission.sql file.
2. Then, import DataInsert.sql and Discharge.sql 

File Structure
----------------------------------
     The entire system is created with three important SQL files, each containing specific logic and functionality:
HospitalAdmissions.sql(Core System file)
Contains All the table definitions (data type, constraints, and Primary Key information). It also has information on different types of Triggers, FUNCTIONS & PROCEDURES, and Views.

Discharge.sql,(Post-Admission Logic)
Contains Information on managing a patient's discharge. We are using the Hospital Admissions file, the main one linked to this one, to show information on patients who are admitted and patients who are discharged

Datainsert.sql(data Testing)
Contains a demo of data inserted into the database as a test to make sure all functionality works

Key Components
---------------------------------------
The system's logic is driven by server-side code  to enforce business rules automatically:
- Triggers: Automatic rules that prevent bad data and enforce critical hospital safety policies before an admission record can even be saved.
- Procedures:Automated scripts for complex tasks (like assigning a bed based on priority)
- Views:reports used for system monitoring

How to use the web Interface
------------------------------------
To get the web interface files:

1.Download the Hospital-app folder to your local system.

2.Place this folder inside the XAMPP web server directory (htdocs).

The user interface (UI) is contained within a separate file named Hospital-app. Which contains PHP files, CSS files, and text files. The web interface is shown from our viewpoint as the admission team on how we utilize the database to make sure patients are admitted into the system. This application allows the team to perform actions like adding a patient, admitting them, and running analytical reports. Additionally, to run the UI, you must ensure that XAMPP is running so the web interface can connect and communicate with the MySQL database.

---------------------------------
-------------------------------
Creation date: 11/8/2025

File names:
-----------------------------
  - readme.md
  - HospitalAdmissions.sql
  - Datainsert.sql
  - Discharge.sql
  - hospital_app file
-------------------------------------------    
Authors:
-----------------------------
  - Iniquez Rusk
  - Peace Amichoh
  - Jalen Grills
  - Talha Khalid
  - Caleb Allen
  - Adewole Karunwi
