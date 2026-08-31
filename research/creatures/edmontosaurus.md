Edmontosaurus --- Research Notes
==============================

1\. Basic Identity
------------------

**Scientific name:** Edmontosaurus\
**Display name:** Edmontosaurus\
**Taxon rank:** Genus\
**Common name:** Edmontosaurus

### Notes

For V1, we should again use the **genus-level account**, because *Edmontosaurus* includes more than one recognized species and they did not all live at exactly the same time or place.

Two major species relevant here are:

-   *Edmontosaurus regalis*
-   *Edmontosaurus annectens*

*E. regalis* is older and is especially associated with the Horseshoe Canyon Formation of Alberta, while *E. annectens* occurs later and is the species found in the Hell Creek Formation.

So for our app:

**Account identity:** `Edmontosaurus`\
**Taxon rank:** `genus`

But whenever we talk specifically about the Hell Creek version interacting with T. rex and Triceratops, we are effectively grounding that part of the character in **E. annectens**.

* * * * *

2\. Taxonomy
------------

**Kingdom:** Animalia\
**Phylum:** Chordata\
**Class:** Reptilia\
**Order:** Ornithischia\
**Family:** Hadrosauridae\
**Subfamily:** Saurolophinae\
**Genus:** Edmontosaurus\
**Species:** Leave nullable / genus-level account

The Natural History Museum classifies Edmontosaurus as an ornithischian hadrosaurid dinosaur.

* * * * *

3\. Geological Time
-------------------

**Era:** Mesozoic\
**Period:** Cretaceous\
**Epoch:** Late Cretaceous

Because we are representing the whole genus, the total range is broader than our first two creatures.

**Oldest known range --- max_ma:** approximately 73\
**Youngest known range --- min_ma:** approximately 66

### Species-level timing

**Edmontosaurus regalis:** roughly 73--71 Ma in the Horseshoe Canyon region.

**Edmontosaurus annectens:** latest Maastrichtian, including roughly 67--66 Ma in Hell Creek.

### V1 Logic Note

This is important.

Our social character is **Edmontosaurus**, but the version that can naturally coexist with:

-   T. rex
-   Triceratops
-   Ankylosaurus

is primarily the later **E. annectens** portion of the genus.

So we should not simply use the genus-wide 73--66 Ma range to pretend that every Edmontosaurus population coexisted with every other V1 dinosaur.

The backend can eventually use location + time together, not time alone.

* * * * *

4\. Ecology
-----------

**Diet:** Herbivore

**Feeding strategy:** Large browsing and grazing herbivore using a broad beak to crop vegetation and extensive dental batteries to grind and process plant material.

**Locomotion:** Facultatively bipedal and quadrupedal --- capable of moving on either two or four legs.

**Estimated maximum length:** around 12--13 m

**Approximate mass:** several tonnes; estimates vary significantly by specimen and method.

The Natural History Museum gives a length of about 13 m and describes Edmontosaurus as herbivorous, with a horny beak and a very large number of grinding cheek teeth. It also notes that it could move on two or four legs.

### Feeding Notes

Edmontosaurus had:

-   a broad, keratin-covered beak
-   large dental batteries
-   hundreds of continually replaced teeth
-   strong grinding/shearing surfaces

The animal was extremely well adapted for processing vegetation.

Plant material historically reported in association with Edmontosaurus includes:

-   conifer material
-   twigs
-   seeds
-   other tough vegetation

However, fossil "stomach contents" can sometimes be difficult to interpret, so the bot should not act as though we know its exact favourite food menu.

* * * * *

5\. Geography and Occurrence
----------------------------

### Known Regions

-   Western North America
-   Canada
-   United States
-   Alberta
-   Montana
-   South Dakota and nearby regions

### Important Formations / Ecosystems

-   Hell Creek Formation
-   Horseshoe Canyon Formation
-   Lance Formation
-   other Late Cretaceous western North American deposits

### V1 Primary Ecosystem

**Hell Creek Formation**

For our V1 character, Hell Creek is the most useful anchor because *E. annectens* is strongly represented there.

A large Edmontosaurus bonebed at the Ruth Mason Dinosaur Quarry in South Dakota contains more than 10,000 bones of *E. annectens* and dates to roughly 67--66 Ma in the Hell Creek Formation.

* * * * *

6\. Relevant Contemporaries
---------------------------

| Organism | Same time? | Same region/ecosystem? | Relevant relationship |
| --- | --- | --- | --- |
| T. rex | Yes | Yes | Strong predator-prey evidence / ecosystem contemporary |
| Triceratops | Yes | Yes | Herbivore ecosystem contemporary |
| Ankylosaurus | Yes | Yes | Herbivore ecosystem contemporary |
| Woolly mammoth | No | No | Impossible natural encounter |

* * * * *

7\. Scientific Relationships
----------------------------

### Edmontosaurus → T. rex

**Relationship type:** Predator-prey / ecosystem interaction\
**Confidence:** High

This is one of the strongest relationships in our entire V1 roster.

We already had direct evidence from the T. rex research: a tyrannosaur tooth embedded in healed hadrosaur vertebrae demonstrates that the animal survived an attack.

There is also recent work describing tyrannosaurid bite damage and an embedded tooth in an Edmontosaurus skull from the Hell Creek Formation.

So for our app, it is completely reasonable for Edmontosaurus and T. rex to have a tense fictional relationship.

The scientifically grounded part is:

-   they overlapped in time
-   they overlapped geographically
-   tyrannosaur feeding/attack evidence exists on Edmontosaurus

The fictional part is them personally gossiping about each other.

Which is, fortunately, exactly what we're doing.

* * * * *

### Edmontosaurus → Triceratops

**Relationship type:** Ecosystem contemporary / herbivore contemporary\
**Confidence:** High

Both occur in the latest Cretaceous ecosystems represented by Hell Creek.

They were both large herbivores, although they had different skulls, feeding systems, and likely occupied somewhat different ecological roles.

For V1 they can absolutely be treated as creatures that could plausibly encounter one another.

* * * * *

### Edmontosaurus → Ankylosaurus

**Relationship type:** Ecosystem contemporary / herbivore contemporary\
**Confidence:** High

Both lived in the same broad Hell Creek ecosystem during the latest Cretaceous.

No strong direct behavioral relationship needs to be claimed.

* * * * *

### Edmontosaurus → Edmontosaurus

**Relationship type:** Group association / population-level social behavior possible\
**Confidence:** Moderate to high

This is where Edmontosaurus gets particularly interesting.

The Ruth Mason Dinosaur Quarry contains the remains of a very large number of *E. annectens* individuals and has been interpreted as a catastrophic death assemblage belonging to a population.

That does not automatically prove a permanent modern-style "herd society," but it does give us much better evidence for group association than we had for Triceratops.

For character-building later, Edmontosaurus can plausibly be more socially oriented.

* * * * *

8\. Chatbot-Relevant Scientific Facts
-------------------------------------

### Identity

-   Edmontosaurus was a large hadrosaurid dinosaur.
-   It was a herbivore.
-   It lived during the Late Cretaceous.
-   The genus existed across several million years.

### Anatomy

-   Broad duck-bill-like snout
-   Keratinous beak
-   Huge dental batteries
-   Hundreds of teeth available in rows
-   Preserved skin is known from exceptionally complete specimens

The "duck-billed dinosaur" nickname is convenient, but the snout should not literally be described as having a duck's bill.

### Diet

-   Herbivorous
-   Capable of processing tough vegetation
-   Used a beak to crop food
-   Used complex dental batteries to grind and shear plants

### Movement

Edmontosaurus could move:

-   on four legs
-   on two legs

That makes it different from our permanently quadrupedal Triceratops and Ankylosaurus.

### Size

-   Large adults could reach approximately 12--13 m in length.
-   Mass estimates vary substantially.

### Contemporary V1 Creatures

The late *E. annectens*-grounded version of our character could plausibly encounter:

-   T. rex
-   Triceratops
-   Ankylosaurus

It could not naturally encounter:

-   Woolly mammoth

* * * * *

9\. Uncertainty / Disputed Information
--------------------------------------

| Topic | What is uncertain? | How should the app handle it? |
| --- | --- | --- |
| Genus-wide time range | *E. regalis* and *E. annectens* lived at different times | Use genus account but Hell Creek interactions should be grounded mainly in *E. annectens* |
| Exact body mass | Estimates vary strongly with specimen and reconstruction | Avoid one exact universal weight |
| Herding | Bonebeds support group association, but exact social structure is unknown | Group-living can be plausible; don't invent complex herd hierarchy as fact |
| Diet details | Plant remains have been associated with specimens but interpretation is imperfect | Keep diet broad |
| Bipedal vs quadrupedal behavior | It could use both, but exactly when each gait was preferred is harder to reconstruct | Say it could move on two or four legs |
| Individual T. rex attacks | Bite evidence supports real interaction, not a specific fictional individual | Personal rivalry remains fictional |
| Species identity | Genus spans multiple species | Use `Edmontosaurus` as the account identity |

* * * * *

10\. Sources
------------

### Source 1

**Title:** Edmontosaurus\
**Institution:** Natural History Museum, London\
**Source type:** Museum / scientific reference

**Facts supported:**

-   herbivorous diet
-   broad beak
-   dental batteries
-   approximate size
-   two- or four-legged locomotion
-   general Late Cretaceous occurrence
-   taxonomy

* * * * *

### Source 2

**Title:** Osteohistological and taphonomic life-history assessment of Edmontosaurus annectens from the Ruth Mason Dinosaur Quarry\
**Authors:** Wosik and colleagues\
**Year:** 2022\
**Source type:** Peer-reviewed research paper

**Facts supported:**

-   *E. annectens* in Hell Creek
-   South Dakota occurrence
-   approximately 67--66 Ma age
-   large monodominant bonebed
-   population and growth information
-   thousands of preserved bones

* * * * *

### Source 3

**Title:** Supplementary cranial description of the types of Edmontosaurus regalis\
**Source type:** Peer-reviewed research paper

**Facts supported:**

-   *E. regalis* identity
-   Alberta occurrence
-   Horseshoe Canyon Formation
-   older age than *E. annectens*
-   anatomical distinction between species

* * * * *

### Source 4

**Title:** High-precision dating and chronostratigraphy of the Horseshoe Canyon Formation\
**Source type:** Peer-reviewed geological research

**Facts supported:**

-   age of the Horseshoe Canyon Formation
-   *E. regalis* assemblage around 73.1--71.5 Ma
-   paleoenvironmental changes through the formation

* * * * *

### Source 5

**Title:** Behavioral implications of an embedded tyrannosaurid tooth and associated tooth marks on an articulated skull of Edmontosaurus\
**Authors:** Wyenberg-Henzler and Scannella\
**Year:** 2026\
**Source type:** Peer-reviewed research paper

**Facts supported:**

-   direct tyrannosaurid feeding/interaction evidence on Edmontosaurus
-   Hell Creek occurrence
-   predator-prey relationship grounding

* * * * *

Final Structured Record
=======================

Creature
--------

**scientific_name:** Edmontosaurus\
**display_name:** Edmontosaurus\
**slug:** edmontosaurus\
**taxon_rank:** genus

* * * * *

Taxonomy
--------

**kingdom:** Animalia\
**phylum:** Chordata\
**class:** Reptilia\
**order_name:** Ornithischia\
**family:** Hadrosauridae\
**genus:** Edmontosaurus\
**species:** null

* * * * *

Temporal Range
--------------

**max_ma:** approximately 73\
**min_ma:** approximately 66\
**era:** Mesozoic\
**period:** Cretaceous\
**epoch:** Late Cretaceous\
**stage:** spans Campanian to Maastrichtian at genus level

### Important V1 Context

Hell Creek / *E. annectens* context:

**approximately 67--66 Ma**

* * * * *

Ecology
-------

**diet:** herbivore

**feeding_strategy:** herbivore using a broad beak and extensive dental batteries to crop and process vegetation

**locomotion:** facultative bipedal/quadrupedal

**length_min_m:** approximately 8 for smaller adults / specimens

**length_max_m:** approximately 13

**mass_min_kg:** do not hard-lock yet

**mass_max_kg:** do not hard-lock yet

**habitat_summary:** vegetated floodplains, coastal plains, river systems and other terrestrial environments of western North America

For the database, I'd rather leave the mass range unresolved until we deliberately choose a consistent scientific source than insert fake precision.

* * * * *

Locations
---------

-   Hell Creek Formation
-   Horseshoe Canyon Formation
-   Lance Formation
-   Western North America

* * * * *

V1 Relationship Notes
---------------------

### T. rex

**Temporal overlap:** Yes\
**Ecosystem overlap:** Yes\
**Chatbot classification:** PERSONALLY_PLAUSIBLE\
**Relationship:** Predator-prey / ecosystem contemporary\
**Confidence:** High

### Triceratops

**Temporal overlap:** Yes\
**Ecosystem overlap:** Yes\
**Chatbot classification:** PERSONALLY_PLAUSIBLE\
**Relationship:** Herbivore ecosystem contemporary

### Ankylosaurus

**Temporal overlap:** Yes\
**Ecosystem overlap:** Yes\
**Chatbot classification:** PERSONALLY_PLAUSIBLE\
**Relationship:** Herbivore ecosystem contemporary

### Woolly mammoth

**Temporal overlap:** No\
**Ecosystem overlap:** No\
**Chatbot classification:** CREATOR_KNOWLEDGE

* * * * *

V1 Community
------------

**Community:** Cretaceous Herbivores\
**Membership:** Yes

Other members:

-   Triceratops
-   Ankylosaurus

* * * * *

Confidence / Caveats
--------------------

-   Genus-level Edmontosaurus spans more time than the Hell Creek population.
-   Hell Creek interactions should primarily be grounded in *Edmontosaurus annectens*.
-   *E. regalis* is older and geographically/stratigraphically separated from *E. annectens*.
-   Hell Creek coexistence with T. rex, Triceratops, and Ankylosaurus is well supported.
-   T. rex--Edmontosaurus predator-prey interaction has unusually strong fossil evidence.
-   Group association is plausible and supported by large bonebeds, but detailed herd behavior should not be invented as scientific fact.