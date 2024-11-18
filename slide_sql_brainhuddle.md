---
theme: gaia
_class: lead
paginate: true
backgroundColor: #fff
backgroundImage: url('https://marp.app/assets/hero-background.svg')
footer: '![height:40px grayscale opacity:0.5](https://www.vogelwarte.ch/wp-content/themes/vogelwarte/assets/images/logo.svg)'
---

![bg left:40% 80%](https://www.vogelwarte.ch/wp-content/themes/vogelwarte/assets/images/logo.svg)

# **Database/SQL for researcher with R knowledge**

## Postgres/PostGIS at the Vogelwarte

---

## Overview
- SQL core principles
- Tools and connections
- **How to's** with R
- Practicle examples with the red kite

---

## SQL Core principles

### Relations 1
![bg right fit](./slide_images/relations.png)
- unique key (id's) and foreign key
- Joins (left, inner, outer)
- similar you know `INDEX` or `VLOOKUP` in Excel
- do you know `d(b)yplr` - ...joins?


---
### Relations 2

- on delete instruction if you build the relation 
`FOREIGN KEY (id_person) REFERENCES member(id_person) ON DELETE CASCADE`
  - `CASCADE` is useful for parent-child relationships where child records should be deleted when the parent is removed
  - `SET DEFAULT` allows a custom default value to signify an orphaned relationship
  - `SET NULL` is helpful when retaining child records but indicating the parent is gone.
  - `RESTRICT` ensure data integrity by preventing deletions if a relationship exists.

---

## SQL Statements
- **SQL DDL** - `Data Definition Language`
- Queries
- [Cheatsheet](https://www.sqltutorial.org/wp-content/uploads/2016/04/SQL-cheat-sheet.pdf)

---

## Tools

- [PGAdmin](https://www.pgadmin.org)
- [DBeavber](https://dbeaver.io)
- R/RStudio
- Microsoft Excel, Access
- [QGIS]()

___

## **How to's** with R

- Explain RProject with renv, .Renviron and multiple files
- Connect DB
- Create DB / Table
- Indexes (Unique)

---

## DB Connection on Server

- Host: dbspatialdata_projects
- Database: playground
- User: sql_brainhuddle
- Password: VoWa20241119
