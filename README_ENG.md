# Overview of Satellites Launched Since the Beginning of Space Exploration
**Mentees:** Anastasiia Mozharova, Anwar Pospíšil 

**Mentors:** Petr Holík, Zuzana Katich 

Topic Selection
---
At the start, we both came up with several ideas in areas such as the film industry, gender equality, and mental health, but there wasn't much overlap. The topic we ultimately chose was simply the one we both agreed interested us: space exploration.

**Anwar:** Space has fascinated me since childhood. I was captivated by various astronomical phenomena and read many books on the subject. Additionally, I’ve been a member of the largest Czech Star Trek fan club for over ten years. So when Nastya suggested something about space missions, I thought, "That sounds great."

**Anastasiia:** I was born in Russia, where space is a big topic. We even have a special holiday called "Cosmonautics Day," and from the first grade, we created posters and projects for it. Right before the academy started, I finished watching the series "For All Mankind", which deeply resonated with me and sparked a minor obsession with space. This inspired me to propose a space-themed project.

Data Source
---

Our primary data source was the [Jonathan´s Space Report.](https://planet4589.org/space/index.html). This free online newsletter, established in 1989, provides technical details about satellite launches. Its author, Jonathan McDowell, is an astrophysicist and spaceflight historian at Harvard. He researches the history of space exploration using original sources and regularly updates the site with new information. His database offers the most comprehensive historical record of satellite launches, starting with Sputnik. The website includes various tables in multiple formats, complete with column descriptions, which proved incredibly useful. Although we initially considered other sources, they either contained less data overall or focused solely on American satellites. We were more interested in a global overview.

Initially, we used two starting datasets: Launchlog from Jonathan's Space Report and the USC Satellite Database. However, we eventually relied solely on the former.

![Zdrojová tabulka](./images/table.png)


Workflow and Iterations
---
We began by discussing what type of information we wanted to analyze and designed a data model based on that. Naturally, as we progressed, we realized that some things didn’t work as expected—certain attributes needed to belong to other entities, some tables were unnecessary, and new ones had to be created. Our mentors also suggested creating a separate table for time data, making it easier to filter dates in the final visualizations.

The final data model, which we were satisfied with, looks like this:

![Datový model](./images/dm.png)

Then came the longest and most challenging part: populating and cleaning the data.

We started by downloading the tables in TSV format and uploading them to Google Sheets. From there, we imported them into Keboola. We also decided that SQL would be our primary tool for the project.
During the first hackathon, we began building and populating individual tables using Keboola. Once completed, we noticed that some columns were only 27% filled. This prompted us to reassess our original data sources. At this stage, we decided to rely solely on Jonathan’s Space Report because its tables contained the most comprehensive data. Missing information, such as the country of origin or satellite purpose, was found in other sections of the dataset, specifically the Payload and Organization tables.

One of the challenges was the inconsistent formatting of some data in Jonathan’s tables. For example, in the launch date, values ranged from just the year to the exact date and time, down to hundredths of a second. We normalized this data using this code:

![Příklad kódu 1](./images/first_code.png)

Another interesting experience was when the mentors guided us through creating a spreadsheet with dates.

![Příklad kódu 2](./images/2%20code.png)

When it comes to Transmission End and Operation End Dates, they included months written as text, requiring separation and standardization. For data with only a year (no month or day), we set January 1 as a placeholder to maintain consistency. Active satellites were marked with an asterisk, which meant their format couldn’t be converted to a date. For these rows, we created a new column, STATUS, as a string format.

![Příklad kódu 3](./images/3%20code.png)

During the second hackathon, we worked on visualizations. At this stage, we discovered another issue: not all country codes in the base table matched the standard two-letter format. For example, Japan was listed as “J” instead of “JP.” To improve visualization clarity, we decided to add new columns for full country names, business regions, and continents.

Our base table didn't include a column for full country names, so initially, we manually looked them up online and wrote CASE WHEN conditions for each country.

![Příklad kódu 4](./images/4%20code.png)

Our mentors suggested a smarter approach: creating additional input tables with all the needed information, which significantly shortened and simplified the code. To streamline the process further, Nastya used ChatGPT to generate tables with full country names and their regional classifications.

Outputs
---

During our analysis, we sought answers to several questions. For some, we had an idea of what the answer might be, and it was usually confirmed.
It’s no surprise that the USA leads with 12,809 satellites, while countries such as Sudan, Bolivia, Laos, Jordan, Tunisia, Armenia, Senegal, Ghana, Lithuania, Costa Rica, Djibouti, Sri Lanka, Moldova, Rwanda, Uganda, Guatemala, Zimbabwe, Papua New Guinea, and Paraguay have each launched just one. Moreover, not all of these launches were successful.

![První graf](./images/Top%2015%20zemí%20podle%20počtu%20startů%20satelitů%20a%20jejich%20stavů.png)

Currently, the most successful agency is SpaceX. This chart shows the top five agencies and the percentage distribution of the various satellite types they have launched.

![Druhý graf](./images/K%20jakým%20účelům%20vypouštějí%20satelity%20top%205%20agentur.png)

We created a map of launch sites, including the number of launches at each location. We also added a filter to view the historical development over time.

![Třetí graf](./images/Porovnání%20základen%20podle%20počtu%20provedených%20startů.png)

The next chart displays global satellite usage statistics. When exploring the results by individual countries, it’s not surprising to find that in North Korea, satellites are primarily used for military purposes.

![Čtvrtý graf](./images/Celosvětová%20statistika%20využití%20satelitů.png)

What would a space exploration project be without mentioning the rivalry between the USA and the Soviet Union? This chart shows the annual number of objects launched by these two superpowers during this historic period.

![Pátý graf](./images/Star%20Wars%20USA%20vs.%20SSSR%20(1957–1991).png)

Another question we explored was how individual countries perform in terms of launch success (whether the launch occurred and whether the entire payload didn’t explode).

![Šestý graf](./images/Celosvětový%20podíl%20úspěšnosti.png)

Some specific numbers and fun facts to conclude:
---
Total satellites launched accrding to our sources: 22,757

Still transmitting: 10,228

Czech and Slovak satellites launched: 17, all of which launched successfully, with 8 still operational.

First satellite ever launched: Sputnik 1, on October 4, 1957. It was launched from the Russian Baikonur Cosmodrome. This approximately 80-kg sphere with antennas and a transmitter burned up in the atmosphere three months later.

Oldest still-functioning satellite: Reportedly, the American satellite NNS 30020. It was launched on December 13, 1964, by the US Air Force Space Systems Division and is used by the US Navy for navigation.

Other dashboards and charts can be viewed here:

https://public.tableau.com/app/profile/anastasiia.mozharova/vizzes 

GitHub repository:

https://github.com/jjnastya/DA_project

Blog post:

https://bit.ly/dadpp2024projekt14

Division of labor
---
**Anwar** 

We worked on almost everything together, usually through chat or video calls on Discord. From choosing the topic to finding input data, creating the data model, cleaning, visualizations, and the final report. We only split tasks at the very end, where I wrote the project annotation and the first draft of this article, while Nastya finalized the last few adjustments to our output tables. She also added the images, her reflections on the topic selection and task division, and several additional details to the article. I then reviewed the entire text again to check grammar and improve readability.

**Anastasiia**

As Anwar said, we did most of the work together, only solving some tasks individually toward the end. I worked on the data for transmission and operation end dates, where I standardized them. I also worked on country codes, regions, and continents, grouped satellite launch purposes, and added full country names. 

Additionally, I worked on the blog, made various adjustments and improvements to the visualizations, uploaded everything to GitHub and prepared visuals of our the presenation.

What did we gain from this project?
---
**Anwar:** I applied to the digital academy to gain a new skill set and make a complete career change. This project was a fantastic way to experience the work of a data analyst, practice using the tools we learned during the course, and see how we respond to challenges. It was an exciting experience, and I definitely want to continue in this field.

**Anastasiia:** My goal for the academy was to learn new hard skills, which I believe I achieved. I particularly enjoyed working with SQL, Keboola, and Tableau, and I’d like to refine these skills further. This project solidified my interest in data analytics, and I’m excited to pursue this specialization.
