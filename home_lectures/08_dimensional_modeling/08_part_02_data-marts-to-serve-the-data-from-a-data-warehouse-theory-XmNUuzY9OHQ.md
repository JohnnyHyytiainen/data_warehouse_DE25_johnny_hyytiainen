---
title: "Data marts to serve the data from a data warehouse (theory)"
video_id: XmNUuzY9OHQ
source_url: https://www.youtube.com/watch?v=XmNUuzY9OHQ
language: en
transcript_type: auto_generated
fetched_at: 2026-09-21T15:18:49+00:00
source_type: youtube_transcript
---

# Data marts to serve the data from a data warehouse (theory)

**[00:00]** hello and welcome to this video where we'll go into the mar layer of uh the data warehouse so join facts with Dimensions to efficiently serve the data Downstream in data marks so remember this data pipeline where we have uh we have data sources going into extracting and loading in to our data warehouse where we transform it and then we serve it to the dashboard and we'll go into the data warehouse part and in the mark uh layers so this is where we Ser our data and the data marks basically so we have our star schema We join the fact with attributes from various Dimensions to build data marks so we join back tables with

**[01:01]** different dimensions and scope of the Mars it depends on the stakeholders needs so it could be by departmental basis it could be for certain type of stakeholders Etc this should be discussed with your uh your business and your stakeholders and an example of the data Mart for example of the job ads listing that we're working with we have um so we we we start with a CTE Common Table expression where we have this fact table we have this job details and we have this employer we see we see that we we select from each of these and we do a join We join on the foreign keys so we join on each foreign key

**[02:00]** and in this way we have all these columns that we can use to enrich our data so we can choose to for example one Department one data Mart don't want to show all the columns but some of the columns so these here you can slice and dice the data and get different types of aggregations to different types of users and for the bi Tool uh it should only access the data marks layer uh in order to build the dashboards so then they can use the data marks directly to build the dashboard uh and um do minimal uh Transformations inside of the data inside of the bi tool itself yes

**[03:00]** thank you for this video and see you in the next one thank you bye
