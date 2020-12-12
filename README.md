# osRs-Hiscores
A simple set of scripts to scrape the [OSRS hiscores](https://secure.runescape.com/m=hiscore_oldschool/overall) based on user-controlled variables and parameters. It is designed to scrape a large number of accounts at once, rather than individual accounts.

## Scripts
- **run.R** - this is the script that users should use to safely run the code. It sources the other scripts to run.
- **setup.R** - this should only be edited by developers. It contains the code to setup and prepare empty databases to add account data to.
- **parameters.R** - this contains all of the variables/parameters that users have the opportunity to edit.
- **functions.R** - this contains a few custom functions to make the code elsewhere less repetitive.
- **identify.R** - search hiscores for users that the match parameters defined in `parameters.R`.
- **personal.R** - search personal hiscores for individual account stats.
- **download.R** - this creates a .xlsx file that contains the hiscores, and the key variables/parameters that were used to generate the hiscores.


*Note that a script named `parameters-example.R` has also been created to show an example parameter setup. It will search the top 10,000 killcounts on the [Zulrah hiscores](https://secure.runescape.com/m=hiscore_oldschool/overall?category_type=1&table=54#headerHiscores).

## Setup
1. **This project was created in R**. To run it, users will need to either download [R](https://www.r-project.org/) & [RStudio](https://rstudio.com/products/rstudio/download/) and run R locally, OR sign up to [RStudio Cloud](https://rstudio.cloud/) and access R via any supported browser.
2. **Clone the repository and port it into R**. Guidance on how to do this is available [here](https://resources.github.com/whitepapers/github-and-rstudio/); the rest of the page can be ignored.
3. **Install the following packages**: tidyverse, rvest, RCurl, data.table, openxlsx. You can do this by running the following command in R: `install.packages("tidyverse","rvest","RCurl","data.table","openxlsx")`.

If you were able to follow the above steps, you're good to go!

## User Guide
By default, only a specific set of skills, minigames and bosses are scraped; ones which I believed were more likely to be targeted by bots. However, due to the number of skills, minigames & bosses in OSRS, this can take a long time to run (i.e. days). It's recommended that you take a moment to think about what you want to look for and then begin from there. 

#### Interpretation:
**All stats for a user will be returned once it has been identified in the parameters**. The resulting database will include the full hiscore details for each of the accounts identified - experience for every skill, all boss killcounts, and other tracked minigame scores.

#### How To Change the Parameters:
1. **Access `parameters.R`** as this contains all of the parameters that can be edited.
2. **Restrictive Account Identifiers:
You can filter out accounts which do/do not include the following criteria:
  - `onlyNumber` only includes accounts with numbers in the name
  - `inclIron` - if you want to include ironmen in your search, set `inclIron == TRUE`.
3. **Fixed Variables**. You can change a number of high level variables that impact everything searched for:
  - `skillSearch` &  `miniSearch` - set `== TRUE` to enable searching for skills/bosses&minigames.
  - `skillStartPage` & `miniStartPage` - set to the first page of the respective hiscore to search (whereby '1' equals the front page, i.e. Top 25 accounts).
  - `skillPage` & `miniPage` - search for ?% of the users that meet the above criteria; `1.00` = 100% of accounts for each parameter.
  - `minigames$max` lets you directly edit how many accounts you want to search on the bosses/minigames hiscores.
4. **Specific Skills/Minigames**. You can also specifically turn on/off any skills/bosses/minigames. To do this:
  - Ensure `uniqueSearch == TRUE`
  - Set individual variables to `TRUE` to include it, or `FALSE` to exclude it. This also listens for `skillSearch` and `miniSearch`, so be sure to check these are turned on if you need them!

## Issues & Warnings
As a rule of thumb, **it takes approximately ~5 seconds (average)** ***per account***. If you attempt to search *everything* in the default parameters (i.e. all 99 skills, all bosses/minigames), it would take ***over a week*** to run in full. It is recommended that you target your searches to reduce this impact. For example: searching for *only* the top 10,000 Zulrah killcounts, without any restrictive parameters, will take ~ten hours.


Occasionally, the project may run into an error whilst attempting to read a webpage (hiscore or personal). If this happens, it will try again twice (i.e. a total of three times) before moving onto the next page.

## Developer Guide
#### **SETUP:**
- Access required packages from installed library.
- Provide template URLs for scraping.
- Generate an empty Hiscores database by scraping the [default hiscore webpage](https://secure.runescape.com/m=hiscore_oldschool/overall) to identify full list of skills/minigames.
- Generate an empty user database consisting of important user information (username and URL for personal hiscores).
- Access [OSRS Wiki](https://oldschool.runescape.wiki/w/Template:99s?action=edit) to identify number of 99s (as default is to only look into those with 99 in the specific skill).
#### **PARAMETERS:**
- Once setup is complete, import the user-edited parameters from `parameters.R` to make any required changes to default parameters.
#### **FUNCTIONS:**
- Create a few repetitive functions in `functions.R` that do the bulk of the generic hiscore scraping (i.e. not personal hiscores).
#### **HISCORE SCRAPING:**
- Begin searching all of the hiscores, page by page, skill by skill, and so on...as defined in `parameters.R` and add results to the user database. This is done through simple loops.
- Clean up the user database by removing any duplicates and, if needed, removing all ironmen accounts.
#### **PERSONAL HISCORE SCRAPING:**
- One-by-one, personal hiscores are searched through using the [RS API](https://runescape.wiki/w/Application_programming_interface#Old_School_Hiscores). Only experience, boss killcount and minigame scores are taken; levels and ranks are excluded. League Points are also excluded. An example of what the API looks like can be found [here](https://secure.runescape.com/m=hiscore_oldschool/index_lite.ws?player=Lynx+Titan).
#### **DOWNLOAD:**
- Once all personal hiscores have been scraped, the resulting database is downloaded automatically as an .xlsx file.

## Future Developments
- **Improve accessibility** - create a basic web-based application, using [RShiny](https://shiny.rstudio.com/), to makes editing parameters easier.
- **Code progress** - add a progress bar to estimate how much longer the code will run.
- **Retry missed pages** - try to search any missed pages again, rather than skip altogether.
- **Account Filters** - add more account filters to reduce required account searches.
- **Custom Bot Identification** - create custom functions to identify potential bot accounts for each skill/minigame.

## FAQ
#### How does the iron account filter work?
Once all the accounts have been identified, it checks to see if any of them are iron accounts. If they are, it removes them before the personal hiscore search begins.

#### I don't have any coding knowledge. Will I still be able to use this?
Hopefully! I've tried to make it readable for anyone - even those without any programming knowledge - as R is quite user-friendly now that it has cloud support. Read this file carefully and you should be good to go!

#### Can I provide feedback on the code itself?
Yes! Absolutely! This was a learning process for me; I'd love to hear thoughts or suggestions or how it (and my abilities) can be improved.

#### Can I suggest future ideas for the project?
Sure! I can't promise I'll add them, but if they promise to add useful insights I'll try!

#### Why did you create this?
I was inspired to create some sort of easily accessible hiscore database after seeing [this post on Reddit](https://www.reddit.com/r/2007scape/comments/jzsv34/vorkath_only_account_progression_163k_kills_in_50/). The hiscores have the potential to uncover many more accounts like this; they just need to be easier to navigate. **My long term ambition is to convince JaGeX to provide their own public version that won't rely on time-intensive web-scraping.**
