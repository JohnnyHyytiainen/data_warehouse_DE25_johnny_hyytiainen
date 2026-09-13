---
title: "Data load tool to extract and load data (theory)"
video_id: m4zrj5ZUWs4
source_url: https://www.youtube.com/watch?v=m4zrj5ZUWs4
language: en
transcript_type: auto_generated
fetched_at: 2026-09-13T14:05:27+00:00
source_type: youtube_transcript
---

# Data load tool to extract and load data (theory)

**[00:00]** hello and welcome to this video on data load tool so this is a tool for extracting and loading the data into a uh Target destination so from a source to a Target destination and in this case we will load the data into snowflake so moving on to the keynote we have so using data load tools from DT Hub to extract and load data from various sources into our data warehouse so remember the data pipeline we have in this course so we have different data sources we have extract and load this is where DT comes in and then we'll go into the data warehouse and in the data warehouse we have transform and then we serve a bi dashboard so we'll now focus on extracting loading uh into the data

**[01:02]** warehouse so more specifically we'll focus on the staging layer so loading from Source data to staging layer so this is the first time I show this uh more detailed view of the data warehouse itself what it contains uh and this uh what it contains it depends on your um how how you would like to uh model your data warehouse and in this course I've chosen this approach to have a staging layer uh a warehouse layer and a Mart layer uh in other um many may use like staging is very common they might use refine layer and serving layer so it's different depending on how you how you name them and how you define them uh and um more in more details like this

**[02:00]** uh different layers uh in my design in this course it's uh we will have different schemas for them so we have a schema for the staging we have a schema for the warehouse layer and we have schemas for the Mars layers uh so but we'll focus on the staging layer in the in the DLT part so we're ingesting the data into the data warehouse from different data sources so why do we need a specialized tool to load the data well you have a bi analyst data scientist and data engineer the bi analyst says I need data for dashboards data scientist I need data for AI and the data engineer okay fine I will use my valuable time to create data pipelines with custom scripts and these scripts are unfortunately in many cases cases not

**[03:00]** very robust they need to you need to adapt them to different use cases you need to make sure that the connection Works etc etc uh how how about we don't do that we take a tool that already exists that has several connectors to various places and one of these tools is DT oh right so I forgot to say this also so we have here we have data going to bi analyst and data to data scientist different data so the data load tool it's an open source data ingestion tool it's a lightweight python library for moving data from source to destination it solves the E part of elt so extract and load so there's a lots of connectors to different sources and destinations that can be used out of box that means you

**[04:00]** don't have to have so much code however the code is still in Python so it's a python [Music] Library so this is the DLT Hub uh and note then there are other a lot of other tools also both uh open source and proprietary that solves data ingestions uh so you don't need to use DLT and the DLT Hub uh there are several others so we'll be using DL but some of this dimensions are airite five Tran talend Apache cfes Amazon Kinesis aure data Factory Stitch matian so these are a few others Dimension there are probably many more and there are probably many more that will show up uh uh in in the near future as well so when when you watch this video maybe there's other tools that are

**[05:00]** a state ofthe art I don't know so with this uh thank you for watching this video and see you in the next video bye
