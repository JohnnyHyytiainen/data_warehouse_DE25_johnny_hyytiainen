---
title: "Snowflake role hierarchy (theory)"
video_id: NZlaNhDUqOE
source_url: https://www.youtube.com/watch?v=NZlaNhDUqOE
language: en
transcript_type: auto_generated
fetched_at: 2026-09-13T14:01:49+00:00
source_type: youtube_transcript
---

# Snowflake role hierarchy (theory)

**[00:00]** hello and welcome to this video on users and roles in Snowflake which is a very important topic in order to manage your security so moving on to the key key note so we'll collaborate and manage security of uses and roles in Snowflake so the hierarchy of snowflake objects we have the organization and then we have the account and we have this other uh uh objects where Warehouse database role uses and other account objects and this and then we go on to database rle and schemas and there's a lot of uh datab a lot of objects under the schemas so in this lecture we'll go into the role and the user so in the access control in Snowflake it works in this way we have

**[01:00]** have discretionary Access Control where each object has an owner an owner can grant privilege to access the object which it owns and also we have our back so have role based Access Control in uh in Snowflake so uh we the access privileges they're assigned to roles and roles are in turn assigned to other roles and users so so you so you have a role hierarchy in snowfake in order to gain more access privileges so example of Access Control we have a ro one it owns an object uh object one Warehouse which could be a warehouse virtual Warehouse it has the it has certain privileges on this Warehouse

**[02:01]** and it may own a database as well and it has privileges there it can grant this privilege to another role you can grant it to other roles you can also Grant a role to another role and the role can grant can be granted to a user so we can grant it to user one user two and this other databas this other object the database the Privileges can be granted to another role and these roles can also be granted further to either a user or a role so in this case user two has uh several so here let's see

**[03:07]** okay oh right now now it works I'll go back here this one yes so here user two has both the role of two and the role of three so in in that way it will get both the object Warehouse object with those Privileges and uh the object uh oh it cannot see actually ah sorry for that uh

**[04:01]** stop okay so privileges are inherited so we have r one r two R three with different privileges so if you have user one and we Grant the role to user one Grant Ro one then uh user one only have privilege one right now but if you grant rooll one to roll two to roll one now the user one also has privilege one and two and similarly here now the user one has privileges 1 2 and three so the Privileges are inherited and another important topic is the system defined roles so here uh in in order to give the right uh access and the right privileges uh we we need to use the right uh roles to do that uh so so starting we have a or org

**[05:01]** admin which is the organization admin and it manages operations in organizational level it can create accounts in organizations then we have the account admin which is a top level role and this should be granted to very few users a common mistake in some companies is that uh account admin or similar roles in different programs as well uh are granted to to many users and uh and they have too much privilege they they don't need they should have as much privilege to do their job uh and not more uh in order to ensure security this is the principle of least privilege uh so security admin comes next and here we have they can manage object and grants globally and we have CIS admin which can create Warehouse database they can create all objects and

**[06:01]** create all custom roles so note that whenever you want to for example create the warehouse of course you can do that with account admin but you shouldn't do that with account admin uh since sus admin which is a lower ranking role uh can can perform this task then you should use S admin instead and we have user admin which can uh which has user enroll management and we have finally the public which uh where objects owned by public is available to everyone and it's a Pudo Ro so Grant it's granted to every user androll they get the public role by default uh so the Hier workk of roles and inherited privileges so we have account admin uh it inherits from security admin and CIS admin they in turn security admin uh inheres from user admin and syst admin

**[07:00]** you inherit from the custom roles which it creates and you can have custom roles to other custom roles uh and they inherit the Privileges and the public everyone inherits from the public thank you and see you in the next lecture
