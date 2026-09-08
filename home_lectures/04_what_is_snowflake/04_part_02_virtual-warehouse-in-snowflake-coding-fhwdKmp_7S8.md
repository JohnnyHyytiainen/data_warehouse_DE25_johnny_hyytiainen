---
title: "Virtual warehouse in snowflake (coding)"
video_id: fhwdKmp_7S8
source_url: https://www.youtube.com/watch?v=fhwdKmp_7S8
language: en
transcript_type: auto_generated
fetched_at: 2026-09-08T10:53:12+00:00
source_type: youtube_transcript
---

# Virtual warehouse in snowflake (coding)

**[00:00]** hello and welcome to this video where we will go into the virtual Warehouse so I will create a virtual Warehouse in SQL script uh in the snow SQL and then we'll configure it a little bit so moving on to visous Studio code here I'm in vious studio code and first of all I will change my language mode so that we have snowflake yes and uh start with showing Warehouse this no active snowflake session right I need to go into snowflake here and I need to sign in and also when I'm signing in actually I think I do need to have yeah exactly if you have multiactor all please complete the MFA process okay I'll just go into my phone and do that uh approve yes so I'm inside of uh snowflake

**[01:01]** so show warehouses let's do that okay and here we see a few warehouses that I have and you might you Pro if you have just started out you have fewer warehouses than I have but that's no no issue so let's create our warehouse uh create the warehouse demo warehouse and uh with Warehouse size equals uh so so here you can pick uh the T-shirt sizes so I will pick the smallest One X small to to go a little bit higher you can use uh X small you can use medium you can use large extra large uh so XL uh X XL I think Al and and and so on

**[02:01]** and so forth so the the higher the the larger the warehouse size uh then you're scaling vertically so you're scaling upwards uh and then it costs more per so it utilizes more credits okay so we will do some we'll do auto sus spend equals 300 so after 5 minutes it will auto suspend we do autor resume equals true so it will resume after it has been suspended uh whenever you're active again with this Warehouse so you don't need to uh explicitly uh activate it you don't need to explicitly um uh resume it that is so initially suspended if = 2 that is also good so we

**[03:01]** we save some costs uh so when we have created it it will be initially suspended and let's do a comment here it's a demo Warehouse rated through a worksheet so I run it and we see Warehouse demo Warehouse successfully created so if I do show warehouses we'll see that yeah we have the demo Warehouse here great uh let Let's uh do something I will uh I will uh alter so so you can use DD when when you have created your Warehouse or you have an existing Warehouse already you can alter it this is a ddl operation so data definition language uh you can alter and modify the compute resources and database objects

**[04:00]** so we we do the alter command here alter Warehouse actually I want to alter compute Warehouse uh since it actually by default it has Auto suspend for 300 however I'll set it to uh set auto suspend equal 60 so I'll make it into 1 minute instead so uh after 1 minute it will suspend uh if we're not use if it has been idle for 1 minute minute uh and this is to or decrease the cost however uh if you have a lot of um smaller operations that you run sequently uh then then it will uh means um uh there's a risk for uh the warehouse to start and stop and start and stop and start and stop and this will uh this will incur more costs so this is a tradeoff that you have to investigate yourself before decide

**[05:01]** and I'll also do this uh alter Warehouse uh demo Warehouse uh I will set the max cluster Max cluster count equals fre and for me uh it doesn't work since uh I I have an invalid property Max cluster count and this is because I'm in the standard edition and in the standard edition we don't have uh we cannot scale uh out so so we cannot add more clusters uh automatically so but but if you're in the Enterprise uh addition you can do this and this means that uh for example when when uh when needed uh it will uh uh it will create more clusters uh so more comput uh more virtual warehouses of the same size uh to handle several uh queries in parallel

**[06:00]** so note that this is the scaling out part and we'll come back to the theory about it uh so we have scaling up uh choosing the T-shirt size we have scaling out uh then the number of clusters right uh and let's see we can uh uh but now I want to clean up so I'll drop Warehouse uh demo Warehouse I'll drop this one and I will do show Warehouse here warehouses yes it's dropped great then we have done the clean up and uh thank you for this video and see you in the next one bye
