# SUPPORT HERO coding exercise

The purpose of this application is to store and display the on-duty schedule for a team.

### Features
* Display today’s Support Hero
* Display a single user’s schedule showing the days they are assigned to Support Hero
* Display the full schedule for all users in the current month
* Users should be able to mark one of their days on duty as undoable
  * The system should reschedule accordingly
  * Should take into account weekends and California’s holidays
* Users should be able to swap duty with another user’s specific day

For demo purpose, highly recommend seeding the database
```sh
$ rake db:seed
```

### Structure
* Root page is `support_duties#index`, where users can look at all support heros, as well as reschedule support duties
* User page shows a list of support duties belonged to the current user, with options to mark certain dates as unavailable
* SupportDuty and User model MVC, feature tests
* Policy objects `DutySchedulePolicy` and `DutyReschedulePolicy`
* Cron job which runs every day at 12 am to update support duty states eg. from 'current' to 'completed'


