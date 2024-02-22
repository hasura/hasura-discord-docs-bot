# Hello! 👋

We're glad you are here!

If you are interested in contributing, please feel free to fork the repo, create a branch, and open a PR.

If your PR has something interesting or useful, it'll get merged! Feel free to reach out in the Hasura Discord Channel
to discuss ideas. We will add onto this page if there is interest.

I'll certainly be adding things to this bot, I hope to make it a bit of a QA-hub and add support for things like
Zendesk, Slack, and maybe even create threads from StackOverflow and Reddit as well.

Some things I'm interested in doing:

* Add user tracking, and add context to the bot on who the users are
* Use the user tracking to implement a leaderboard
* Instead of only marking something as solved, allow also the marking of specific messages as helpful or non-helpful
* Add a slash command for generating a "golden thread". I.e. Convert the conversation into a perfect conversation based
  on the determined final answer. Perhaps...
    1. The bot uses the entire thread to create questions to get needed details the user reveals throughout the
       conversation.
    2. The bot generates the answers to those questions, pretending to be the user.
    3. The bot generates the final answer having got the important information from the user.
    4. This new thread is used in the future to fine-tune the bot.
* The current database design is very simple. It would be nice to decouple things from Discord and add an enum so that
  the same underlying chatbot could work with multiple tools. I.e. a source field on the thread and each bot can have
  its own task_loop.
* It would be good to add some commands/crons for report generation, especially pretty PDFs with charts
* We should automate the vectorization of conversations and things, and also have 1 collection with ALL incoming info in
  it aggregated.
* It might be good to do things like use ChatGPT to curate tags and create enriched metadata for the data-points.
* It would be good to make it so that prompts and more of the "constants" are stored in the database. This would make it
  simpler to do things like change the prompts for example.
* It would be good to be able to benchmark against different prompts.
* It would be good to add a front-end wrapper with a purpose-designed application rather than having to deal with
  external APIs.
* There are lots of opportunities to add slash commands and things.

We host office hours every Tuesday at 10AM PST, (As in me! The guy who wrote this whole thing, *I* host the Office
hours, so come keep me company!)

[Join our Discord server](https://discord.gg/hasura)