
<img width="9149" height="2224" alt="bedrock4_logogray" src="https://github.com/user-attachments/assets/f5c9591a-f4fd-4103-91dc-991ce287c1b7" />

## What is Bedrock?

**Bedrock** is a **TM1 / Planning Analytics** best practice that brings together information and experiences for business intelligence professionals. The code and resource libraries on this site specifically assist the **IBM TM1 / Planning Analytics** user community and contain assets to increase the value of TM1-based applications within minutes. This collective knowledge is shared here from a vast array of projects in different organisations and industries globally.

Bedrock is TM1 Best Practice assets built from years of TM1 experience consisting of Training, White Papers and Toolkits.

Trialled and implemented for over many years in numerous highly complex TM1 sites, results have shown:
* 30-50% reduction in TI coding due to a new functional method employed. 
* Increased scalability in terms of business logic complexity, data sizes & concurrency.
* Dramatically faster proto-typing phase. 
* Increased auditing & testing via standardised logging system.
* Reduction in Developer/Administration training.
* Reduction in cost of Administrating TM1.

## Minimum TM1 / IBM Planning Analytics Version

The latest release [**bedrock v4.1.3**](https://github.com/cubewise-code/bedrock/releases/tag/v4.1.3) is a complete rebuild of the bedrock library for Planning Analytics 2.x (TM1 Server 11.x). Due to incorporation of support for new Planning Analytics features (alternate hierarchies, temporary objects, processes execution on independent threads) please note that the _**minimum supported version is PA 2.0.6 (TM1 Server 11.4)**_.

### What do I need for v4?
For bedrock v4 the TI process _source code_ has been split into 2 folders:

* **main**: this contains all the bedrock 4 processes. For any new project using Planning Analytics theses are the processes you need
* **b3shell**: the processes in this folder have the same names as the old bedrock v3 processes. However, they are _not_ the old processes. Rather they are "caller shells" which do nothing more than call the new bedrock 4 processes to produce the same behaviour from the same parametes as in bedrock 3. These processes are included for _backwards compatibility_ and _unit testing_ for models where bedrock 3 is already implemented. This allows anyone with a model where many custom processes call the bedrock library to switch and test bedrock 4 without any code change to existing custom processes. For anyone implementing bedrock for the frst time you _don't need and shouldn't include_ these processes. 

### Where is Bedrock v3?

If you are still using TM1 Server 10.2.2 the Bedrock 3 processes are still available. You can find them in the [v3-archive branch](https://github.com/cubewise-code/bedrock/tree/v3-archive).

## Why Bedrock?

Given that there is a large uptake of **TM1** globally there exists an education gap that is ever widening. With this hunger for standards and experience, **Bedrock** is not just a home for all these questions on how TM1 works from the ground up or what the best implementation methodologies are. Uniquely, it is a quick-start collection of assets to dramatically increase efficiency and effectiveness of your **TM1** system.

There is a firm belief within the contributors of this site that TM1 systems are capable of much more valuable business insights than other products in the marketplace. Financial Reporting, Financial Budgeting or Operational Planning systems may be attempted by many products and could easily be successful. However, these are "First Phase" systems and business value takes a quantum leap when the Operational and Financial are automatically linked - not by over-night batch processing but by real-time automatic calculations. Bedrock's genesis was exactly this - a code name for an internal methodology originally named to **"initiate standards and Best Practice TM1"**, ultimately culminating in the uninhibited growth of TM1 systems. Hence Bedrock is about "Second Phase" TM1 systems and beyond.

It should be emphasized that Bedrock is not intended as a vehicle for commercial gain. See “**How to Licence**”. It is intended solely to increase TM1 knowledge and standards so that all implementers, whether professional services or end users can drive better results for the end user company and ultimately ensure TM1's unique platform is demonstrably superior to other business intelligence products.

The future for Bedrock depends largely on the TM1 community to help build out the education and tools already contained on this site. If you benefit from these assets, please take the time to give back in the near future.

## Who is it for?

Resources at **Bedrock** should be used by anyone involved in the creation, implementation, management and support of **IBM TM1 / Planning Anaytics** systems especially those with an interest in a shared, best practice approach.

This includes developers, support analysts, administrators, IT managers, consultancies, sub-contractors and even end users wanting to step into development or administration.

### Developers, Consultancies and Sub-contractors

Each and every TM1 system is a balance of Functionality, Performance & Maintainability. It is a never-ending battle as business requirements and environments changes. **Bedrock for TM1** incorporates up-to-date Black Belt Best Practice techniques and tools so that your end-customer can get the optimal balance right now and into the future. Developer's build-time will be reduced with greater ease of proto-typing ensuring a greater fit-for-purpose to suit the business needs better.

### Administrators and IT Managers

Business as Usual (BAU) administrators will be more responsive due to more consistent auditing and more simplistic, standardised code. They will see more audited activity culminating in less "black box" risk. Succession issues will be less risky due to better standards and understanding of the system.

### End Users

End Users who never thought they could develop now find TM1 simpler and clearer to develop and administrate. **Bedrock for TM1** shortens and flattens the Learning Curve for development.

## Where can I get more information?

The first place for further information is the [code.cubewise.com/bedrock](https://code.cubewise.com/bedrock) website. 

**Key resources**:
* Check out the [What's New](https://github.com/cubewise-code/bedrock/wiki/WhatsNew) page to familiarize yourself with what is different versus the previous version. 
* [Bedrock Wiki](https://github.com/cubewise-code/bedrock/wiki). Each process has a full documentation of what it does, the intended purpose, needed parameters, and dependencies within the library.

**White Papers**:
* [Bedrock Modular Approach](https://downloads.cubewise.com/Bedrock/whitepapers/White_Paper_Modular_Approach.pdf)
* [Best Practice Turbo Integrator](https://downloads.cubewise.com/Bedrock/whitepapers/White_Paper_Best_Practice_Turbo_Integrator.pdf)
* [Best Practice Cube Design](https://downloads.cubewise.com/Bedrock/whitepapers/White_Paper_Best_Practice_Cube_Design.pdf)
* [Best Practice Rules](https://downloads.cubewise.com/Bedrock/whitepapers/White_Paper_Best_Practice_Rules.pdf)

## How to License

Anyone is free to copy, modify, use, compile, sell or distribute the original Bedrock code, documents and information (the information), either in source code form or as a compiled binary, for any purpose, commercial or non-commercial, and by any means, with the exception that you may not reproduce or publish the information on any web site, online service or printed media without prior express permission.

Where the information is copied, modified, used, compiled, sold or distributed, credit to the original author or authors must be left intact in the code or document.

All of the deliverable code on this site has been written from scratch. No code has been taken from other projects or from the open internet. Every line of code can be traced back to its original author. So the Bedrock code base is clean and is uncontaminated with licensed code from other projects.

## Warranties

All of the code, documents and information in Bedrock for TM1 are to be deemed without warranty.

## Contributions

The source code is hosted at [github.com/cubewise-code/bedrock](https://github.com/cubewise-code/bedrock). If you find a bug or feel like you can contribute please [fork](https://help.github.com/articles/fork-a-repo/) the repository, update the code and then create a [pull request](https://help.github.com/articles/about-pull-requests/) so we can merge in the changes.
<img src="https://s3-ap-southeast-2.amazonaws.com/downloads.cubewise.com/web_assets/CubewiseLogos/Bedrock+FOUR+logo+2019_Orange.png" style="width: 70%; height: 70%;text-align: center"/>
