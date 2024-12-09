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

Another challenge was the inconsistent formatting of some data in Jonathan’s tables. 

![Příklad kódu 1](./images/first_code.png)

Launch Date: Values ranged from just the year to the exact date and time, down to hundredths of a second. We normalized this data using this code:

![Příklad kódu 2](./images/2%20code.png)

Transmission End and Operation End Dates: These included months written as text, requiring separation and standardization. For data with only a year (no month or day), we set January 1 as a placeholder to maintain consistency. Active satellites were marked with an asterisk, which meant their format couldn’t be converted to a date. For these rows, we created a new column, STATUS, as a string format.

![Příklad kódu 3](./images/3%20code.png)

------------ (thats where i stopped)

Během druhého hackathonu jsme se pustily do vizualizací. V této fázi jsme objevily další problém: ne všechny kódy zemí ve výchozí tabulce odpovídaly obvyklému dvoupísmennému formátu. Například Japonsko bylo uvedeno jako „J“ místo „JP“. Pro lepší čitelnost vizualizací jsme se také rozhodly přidat nový sloupec s plnými názvy zemí a sloupce pro obchodní regiony a kontinenty.

Naše výchozí tabulka neobsahovala sloupec s plnými názvy zemí, takže jsme je začaly dohledávat na internetu a ručně psát podmínky pomocí CASE WHEN pro každou zemi.

![Příklad kódu 4](./images/4%20code.png)

Naši mentoři nám ale navrhli chytřejší přístup: vytvořit dodatečné vstupní tabulky s těmito informacemi, což významně zkrátilo a zjednodušilo kód.
Abychom proces ještě více zefektivnily, použila Nasťa ChatGPT k vytvoření tabulek s plnými názvy všech zemí a jejich rozdělením do regionů a kontinentů.

Výstupy
---
Během naší analýzy jsme hledaly odpovědi na několik otázek. U některých jsme měly představu, jaká asi bude odpověď, a obvykle se potvrdila. 
Nejvíce vypuštěných satelitů mají nepřekvapivě USA (12 809) a nejméně státy Súdán, Bolívie, Laos, Jordánsko, Tunisko, Arménie, Senegal, Ghana, Litva, Kostarika, Džibuti, Srí Lanka, Moldávie, Rwanda, Uganda, Guatemala, Zimbabwe, Papua Nová Guinea a Paraguay, které mají každý po jednom satelitu. Navíc ne všechny z nich odstartovaly úspěšně. 

![První graf](./images/Top%2015%20zemí%20podle%20počtu%20startů%20satelitů%20a%20jejich%20stavů.png)

Nejúspěšnější agentura je v současnosti SpaceX. Tento graf zobrazuje top 5 agentur a procentuální rozložení toho, jaké různé typy satelitů zatím vyslaly. 

![Druhý graf](./images/K%20jakým%20účelům%20vypouštějí%20satelity%20top%205%20agentur.png)

Vytvořily jsme mapu startovních ploch včetně počtu startů ke každé z nich. I k ní jsme přidaly filtr, aby bylo možné si prohlédnout postupný vývoj. 

![Třetí graf](./images/Porovnání%20základen%20podle%20počtu%20provedených%20startů.png)

Celosvětovou statistiku využití satelitů zobrazuje následující graf. Při proklikávání výsledků po jednotlivých zemích asi nikoho nepřekvapí, že v Severní Koreji využívá satelity hlavně armáda. 

![Čtvrtý graf](./images/Celosvětová%20statistika%20využití%20satelitů.png)

Co by to bylo za projekt o vesmírném průzkumu, kdyby se tam neobjevilo nic o závodech mezi USA a Sovětským svazem. Zde vidíme vývoj toho, kolik objektů ročně během této části historie obě mocnosti vypustily.

![Pátý graf](./images/Star%20Wars%20USA%20vs.%20SSSR%20(1957–1991).png)

Další otázka, která nás zajímala, byla, jak si vedou jednotlivé státy pokud jde o úspěšnost startů (tedy jestli ke startu vůbec dojde a jestli celé těleso nevybouchne). 

![Šestý graf](./images/Celosvětový%20podíl%20úspěšnosti.png)

Nějaká konkrétní čísla a zajímavosti na závěr: 
---
Celkový počet vypuštěných satelitů podle našeho zdroje: 22 757

Z toho počet satelitů, které stále vysílají: 10 228

Českých a slovenských satelitů dohromady bylo vypuštěno celkem 17.  A navíc, na rozdíl od těch amerických, všechny odstartovaly úspěšně. :-D 8 jich stále funguje.

První vypuštěný satelit celosvětově: Sputnik 1, 4. října 1957. Odstartoval z ruského Bajkonuru, byla to zhruba osmdesátikilová koule s anténami a vysílačkou a o tři měsíce později shořel v atmosféře. 

Nejstarší stále funkční satelit: prý americký satelit pojmenovaný NNS 30020. Vypustila jej 13. prosince 1964 US Air Force Space Systems Division a využívá jej armáda, konkrétně námořnictvo, k navigaci. 

Ostatní grafy a dashboardy je možné si prohlédnout na tomto odkazu:

https://public.tableau.com/app/profile/anastasiia.mozharova/vizzes 

Odkaz na git hub:

https://github.com/jjnastya/DA_project

Odkaz na blog:

https://bit.ly/dadpp2024projekt14

Na čem kdo pracoval
---
**Anwar** 

Skoro na všem jsme pracovaly spolu, obvykle přes chat nebo videohovor na Discordu. Od výběru tématu, přes hledání vstupních dat, vytváření datového modelu a čištění po vizualizace a finální report. Práci jsme si rozdělily až ke konci, kdy jsem já napsala anotaci projektu a první verzi textu tohoto článku, zatímco Nasťa ještě dokončovala posledních několik úprav našich výstupních tabulek. Nakonec ještě doplnila do článku obrázky, svoje vyjádření k výběru tématu a rozdělení práce a několik dalších informací. Následně jsem celý text ještě jednou prošla já, abych zkontrolovala gramatiku a upravila věty do formy, která se bude lépe číst. 

**Anastasiia**

Jak Anwar řekla, většinu práce jsme dělaly společně, jen ke konci jsme bez většího přemýšlení začaly některé úkoly řešit samostatně. Já jsem se tedy pustila do práce s daty o konci přenosu a provozu, kde jsem je standardizovala. Dále jsem pracovala s kódy zemí, regiony a kontinenty a seskupila účely startů satelitů a také jsem doplnila jejich plné názvy.

Kromě toho jsem také pracovala na blogu a co se týče vizualizací, snažila jsem se do nich přidat úpravy a vylepšení.

A co jsme si z toho odnesly? 
---
**Anwar:** Do digitální akademie jsem se hlásila s tím, že chci novou sadu dovedností a kompletní změnu kariéry. Projekt byl skvělý způsob, jak si vyzkoušet práci datového analytika, procvičit používání nástrojů, se kterými jsme se během studia seznámily, a zjistit, jak budeme reagovat, pokud narazíme na problém. Byla to zajímavá zkušenost a určitě chci tímto směrem pokračovat. 

**Anastasiia:** Mým cílem pro akademii bylo naučit se nové hard skills, což si myslím, že se mi podařilo. Nejvíce mě bavila práce s SQL, Keboolou a Tableau, a v budoucnu bych se v těchto nástrojích chtěla ještě více zdokonalit. Tento projekt mi jasně ukázal, že práce datového analytika mě opravdu zajímá, a ráda bych v této specializaci pokračovala.
