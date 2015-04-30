# AsanaIguana - Points counter for Asana
This is a simple webapp that speeds up the process of tracking an Agile-style points system in Asana. I threw together the initial version over the course of a few days. Currently all it does is tally points-per-person (based off of tasks with number tags) for any given date range. If there's interest, I'll probably expand it further.  

Hosted site: [asanaiguana.jotdashed.com](https://asanaiguana.jotdashed.com)

## Feature Backlog
In no particular order:

- Add a better date picker
- User accounts w/ Asana omniauth.
- Caching of project data for faster lookups/updates.
- More types of reports.
- Auto-generated weekly summaries.
- Move all the code to either tableless models, or just go straight to a full DB.
- Design a better interface (hey, at least it's not *raw* text).