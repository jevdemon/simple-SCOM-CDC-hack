# simple-SCOM-CDC-hack
Simple scripts to push CDC messages into an event log for SCOM
==============================================================

The Problem: Subscribe to table updates in a SQL Server database but you cannot add any code to the production environment or make any major changes to the database.

The Solution: This was a _major_ hack.  The scripts enable CDC to track updates to a table and push them into the event log.  This enables SCOM (which was already enabled) to pick up the updates and "publish" them for consumption by an external system.  See the png file for an illustration of how this hack was used.

This wasn't a typical scenario but the CDC and SQL Agent scripts might still be useful to someone.