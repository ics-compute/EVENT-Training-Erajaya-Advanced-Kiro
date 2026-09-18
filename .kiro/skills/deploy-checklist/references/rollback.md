# Rollback

Loaded only when the deploy goes wrong. Keeping it out of SKILL.md is the
whole point of progressive disclosure: it costs nothing until it is needed.

1. Stop the rollout before you debug it. Availability first, root cause later.
2. Roll back to the previous known-good release tag.
3. Verify the health check is green again, then say so in the incident channel.
4. Only now open the investigation. Keep the failing artefact — do not delete
   the evidence you are about to need.
5. Write the timeline while the detail is fresh: what changed, when it was
   noticed, what was done, what is still open.
