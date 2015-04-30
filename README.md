# Asana Iguana - Points counter for Asana
This is a simple webapp that speeds up the process of tracking an Agile-style points system in Asana. I threw together the initial version over the course of a few days. Currently all it does is tally points-per-person (based off of tasks with number tags) for any given date range. I'll be expanding it further after I get tests up for the current functionality.

Hosted site: [https://asana-iguana.herokuapp.com/](https://asana-iguana.herokuapp.com/)

## Feature Backlog
In no particular order:

- Add a better date picker
- User accounts w/ Asana omniauth.
- Caching of project data for faster lookups/updates.
- More types of reports.
- Auto-generated weekly summaries.
- Move all the code to either tableless models, or just go straight to a full DB.
- Design a better interface (hey, at least it's not *raw* text).