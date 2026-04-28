-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Apr 28, 2026 at 07:37 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `knowm`
--

-- --------------------------------------------------------

--
-- Table structure for table `artists`
--

CREATE TABLE `artists` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `slug` varchar(255) NOT NULL,
  `biography` text DEFAULT NULL,
  `biography_lv` text DEFAULT NULL,
  `formed_year` smallint(4) UNSIGNED DEFAULT NULL,
  `disbanded_year` smallint(4) UNSIGNED DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `solo_or_band` enum('solo','band') DEFAULT NULL,
  `popularity` double(10,2) NOT NULL DEFAULT 0.00,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `artists`
--

INSERT INTO `artists` (`id`, `name`, `slug`, `biography`, `biography_lv`, `formed_year`, `disbanded_year`, `is_active`, `solo_or_band`, `popularity`, `created_at`, `updated_at`) VALUES
(1, 'Bring Me The Horizon', 'bring-me-the-horizon', 'Bring Me the Horizon, often known by the acronym BMTH, is a British deathcore/metalcore/alternative metal band formed in 2004 in Sheffield, South Yorkshire, by vocalist Oliver Sykes, drummer Matt Nicholls, bassist Matt Kean and guitarists Lee Malia and Curtis Ward.\r\n\r\nThe current lineup of the band consists of: Oliver \"Oli\" Sykes (lead vocals, keyboards and programming), Matt Nicholls (drums), Lee Malia (lead and rythm guitar), Matt Kean (bass) and touring member John Jones (rythm guitar and backing vocals).\r\n\r\nThey are signed to RCA Records globally and Columbia Records exclusively in the United States. The style of their early work, including their debut album Count Your Blessings, has primarily been described as melodic deathcore, but they started to adopt a more eclectic style of metalcore on subsequent albums. Furthermore, their latest two albums That\'s the Spirit and amo marked a shift in their sound to less aggressive rock/metal music styles, such as alternative rock, pop rock, and alternative metal.\r\n\r\nHistory\r\nBring Me the Horizon\'s founding members came from diverse musical backgrounds within metal and rock. Matt Nicholls and Oliver Sykes had a common interest in American metalcore such as Norma Jean and Skycamefalling, and used to attend local hardcore punk shows. They later met Lee Malia, who spoke with them about thrash metal and melodic death metal bands like Metallica and At the Gates; Malia had also been part of a Metallica tribute band before meeting the pair. Bring Me the Horizon officially formed in March 2004, when the members were aged 15 to 17. Curtis Ward, who also lived in the Rotherham area, joined Sykes, Malia and Nicholls. Bassist Matt Kean, who was in other local bands, completed the line-up. Their name was taken from the line in the film Pirates of the Caribbean: The Curse of the Black Pearl, where Captain Jack Sparrow says \"Now, bring me that horizon.\"\r\n\r\nIn the months following their formation, Bring Me the Horizon created a demo album titled Bedroom Sessions. They followed this by releasing their first EP, This Is What the Edge of Your Seat Was Made For in September 2004 through local UK label Thirty Days of Night Records. Bring Me the Horizon were the label\'s first signing. It was recorded at Pristine Studios in Nottingham over the course of two weekends, with drums and bass guitar laid down over the first weekend, and guitars and vocals completed a week later.\r\n\r\nUK label Visible Noise noticed the band after the release of their EP, and signed them for a four-album deal, in addition to re-releasing the EP in January 2005. The re-release gained the band significant attention, eventually peaking at No. 41 on the UK album charts. The band was later awarded Best British Newcomer at the 2006 Kerrang! Awards ceremony.\r\n\r\nThe band\'s first tour was supporting The Red Chord across the United Kingdom. As with other early tours, they were able to get this slot by tricking venue promoters. Kean and Oliver\'s mother were the de facto managers of the band at this time, a role they continued to occupy until 2008. For The Red Chord support, Kean emailed promoters and pretended they were opening on all the dates, when they were supposed to play only at their local show. This led them to being booked for the whole tour. In another case, Sykes created an e-mail account in the name of Johnny Truant vocalist Oliver Mitchell, which he used to contact a promoter requesting Bring Me the Horizon on their tour. Alcohol consumption fuelled their live performances in their early history when the band would get so drunk they vomited on stage and damaged their equipment.\r\n\r\nThe band released their debut album Count Your Blessings in October 2006 in the United Kingdom and in August 2007 in the United States. They rented a house in the country to write songs, but easily became distracted. They then recorded the album in inner-city Birmingham, a process which was infamous for their excessive and dangerous drinking. During this period drummer Nicholls summarised it saying \"we were out every night, just being regular 18-year-olds\". Critics panned the album adding to the strongly polarised responses the band were already seeing from the public.\r\n\r\nBring Me the Horizon recorded their second studio album, Suicide Season, in Sweden with producer Fredrik Nordström. He was unimpressed with their first album and was initially absent from the recording sessions unless he needed to be there. Nordström later heard the new sound they were experimenting with during a recording session and became very involved in the record. It was promoted virally in the weeks before its release with the promotional tag line \"September is Suicide Season.\"\r\n\r\nDuring the Taste of Chaos tour in March of that year, guitarist Curtis Ward left the band. His relationship with the band had deteriorated as his stage performances were poor. He was abusive to audiences during the Taste of Chaos tour, and had contributed little to the writing of Suicide Season. Another reason for his departure was the worsening tinnitus in his one functioning ear. Ward was born deaf in one ear and admitted playing in the band worsened the ringing in his other ear to such a degree that he was unable to sleep at night. Ward offered to perform the rest of the tour dates, which the band rejected and instead asked their guitar technician, Dean Rowbotham, to substitute for him for the remaining performances. Lee Malia noted that Ward\'s departure helped improve everyone\'s mood as he had been very negative. Within a week of the tour finishing, Sykes began talking to Jona Weinhofen, at the time the guitarist of Bleeding Through. The band knew of him from his work with his former band I Killed the Prom Queen, and he was asked to join them. Ward has since worked on the TV show Top Gear, and has occasionally performed on stage with Bring Me The Horizon, playing Pray For Plagues, most notably at Wembley Arena in 2015. In 2016, it was announced that Ward had joined the band Counting Days.\r\n\r\nIn November 2009, Bring Me the Horizon released a remixed version of Suicide Season, titled Suicide Season: Cut Up!. Musicians and producers featured on the album include: Ben Weinman (from the Dillinger Escape Plan), Skrillex, L’Amour La Morgue, Utah Saints and Shawn Crahan (from Slipknot). Musically, the album incorporates many genres including: electronica, drum and bass, hip-hop and dubstep. The dubstep style of the record has been acknowledged in tracks by Tek-One and Skrillex while the hip-hop elements are found in Travis McCoy\'s remix of Chelsea Smile.\r\n\r\nThe band\'s third album, and first with their new rhythm guitarist Jona Weinhofen, titled There Is a Hell, Believe Me I\'ve Seen It. There Is a Heaven, Let\'s Keep It a Secret, was released on 4 October 2010 and debuted at number 17 on the Billboard 200 in the United States, number 13 on the UK Album Chart, and number one on the Australian Albums Chart, the UK Rock Chart and the UK Indie Chart. Despite reaching number one in Australia, the album\'s sales were the lowest for a number one album in the history of the Australian Recording Industry Association (ARIA) charts.\r\n\r\nMatt Nicholls describes the lyrical themes of There Is a Hell as being \"repercussions of everything we were singing about on our last CD (Suicide Season)\" calling the music and lyrics a lot moodier and darker. Five singles were released from the album including: It Never Ends, Anthem, Blessed with a Curse, Visions and Alligator Blood, with music videos produced for each of the songs. \r\n\r\n2011 ended with an announcement by the band on 29 December of a new extended play titled The Chill Out Sessions, a collaborative effort with British DJ Draper. Draper first released an \"officially sanctioned\" remix of the song Blessed with a Curse in May 2011. The EP was originally supposed to be released in time for New Year\'s Day, and made available for download and purchase though Bring Me the Horizon\'s website, but the EP\'s release was cancelled due to the band\'s \"current management and label situation\".\r\n\r\nAfter an intense touring schedule, Bring Me the Horizon finally completed their third album\'s promotion at the end of 2011. They returned to the UK for an extended break and eventually starting work on their next album. Much like their previous two albums, they wrote their fourth album in seclusion and isolation to stay focused. This time, they retreated to a house in the Lake District. In July, the band started to publish images of themselves recording at a \"Top Secret Studio Location\" and revealed they were working with producer Terry Date for the recording and production of the album. On 30 July, the band announced they had left their label and signed with RCA, who would release their fourth album in 2013.  In late October it was announced that the fourth album would be called Sempiternal with a tentative release in early 2013. On 22 November the band released the Draper collaborative album The Chill Out Sessions free of charge.\r\n\r\nOn 4 January 2013, Bring Me the Horizon released the first single from Sempiternal, Shadow Moses. It was first played by radio presenter Daniel P. Carter on BBC\'s Radio 1. Due to popular demand, Epitaph released the music video for the song a week earlier than planned. In January, the band also saw a change in their line up. This began early in the month when Jordan Fish, Worship keyboardist and session musician for the band during the writing of Sempiternal, was announced as a full member. Then later in the month, Jona Weinhofen left the band. Despite the band denying speculation that Fish replaced Weinhofen, reviewers said that replacing a guitarist with a keyboardist better fit their style. The album was released the 1st of march, 2013. The album was supported by multiple music videos including those for the tracks Go to Hell, for Heaven\'s Sake, Sleepwalking and Can You Feel My Heart. The lyrics on Sempiternal mainly deal with Sykes\' journey through rehabilitation from ketamine.\r\n\r\nLater in 2014, the band released two new tracks titled Drown on 21 October, as a stand-alone single, and Don\'t Look Down on 29 October, as part of the re-score of Drive.\r\n\r\nIn late June, the band began to promote pictures of an umbrella symbol being used as a tattoo, and on stickers, and posters across England, the United States, Australia, and Europe; it was later used for a promotional cover for the band\'s first single. The band released a short video in early July where the words \"that\'s the spirit\" could be heard in reverse. On 13 July 2015, the promotional single Happy Song was released on the band\'s Vevo page, and on 21 July 2015, Sykes revealed the album\'s name was That\'s the Spirit. The band released the single and music video for Throne on 23 July 2015, and another promotional track from the album, titled \"True Friends\", was released on 24 August 2015. The album was released on 11 September 2015 to critical acclaim. It has led to several music videos including Drown, Throne, True Friends, Follow You, Avalanche and  Oh No.\r\n\r\nOn 22 April 2016, the band performed a live concert with an orchestra conducted by Simon Dobson at the Royal Albert Hall in London. The concert marked the first time the band had performed with a live orchestra. It was recorded, and the live album, Live At The Royal Albert Hall, was released on 2 December 2016 through the crowdfunding platform PledgeMusic on CD, DVD, and vinyl, with all proceeds donated to Teenage Cancer Trust.\r\n\r\nIn August 2018, cryptic posters appeared in major cities throughout the world with the message \"do you wanna start a cult with me?\". The posters were attributed by major media outlets to the band only by their use of the hexagram logo previously used by the band. During this time the band themselves have not acknowledged their involvement with the campaign publicly. Each poster provided a unique phone number and a website address. The website provided a brief message titled \"An Invitation To Salvation\" and shows the date of 21 August 2018. The phone lines placed fans on hold with lengthy, varied audio messages that changed frequently. Some of these messages reportedly end with a distorted audio clip of what was assumed to be new music from the band.\r\n\r\nOn 21 August, the band released the lead single Mantra. The following day the band announced their new album amo set for release on 11 January 2019 along with a new set of tour dates called the First Love World Tour. On 21 October, the band released their second single wonderful life (feat. Dani Filth) featuring Dani Filth, along with the tracklist for amo. That same day, the band announced that the album has been delayed and is now set for 25 January 2019. On 3 January 2019, the band released their third single medicine and its corresponding music video.\r\n\r\nDiscography\r\nStudio albums\r\nCount Your Blessings (2006)\r\nSuicide Season (2008)\r\nThere Is a Hell Believe Me I\'ve Seen It. There Is a Heaven Let\'s Keep It a Secret. (2010)\r\nSempiternal (2013)\r\nThat\'s the Spirit (2015)\r\namo (2019)\r\nPOST HUMAN: SURVIVAL HORROR (2020)\r\nPOST HUMAN: Nex Gen (2024)\r\n\r\nLive albums\r\nLive at Wembley (2015)\r\nLive At The Royal Albert Hall (2016)\r\n\r\nCompilations\r\n2004 - 2013 (2017)\r\n\r\nEPs\r\nThis Is What the Edge of Your Seat Was Made For (2004)\r\nThe Chill Out Sessions (2012)\r\nMusic to listen to~dance to~blaze to~pray to~feed to~sleep to~talk to~grind to~trip to~breathe to~help to~hurt to~scroll to~roll to~love to~hate to~learn Too~plot to~play to~be to~feel to~breed to~sweat to~dream to~hide to~live to~die to~GO TO (2019)', 'Bring Me the Horizon, bieži pazīstama ar saīsinājumu BMTH, ir britu deathcore/metalcore/alternatīvā metāla grupa, kas dibināta 2004. gadā Šefīldā, Dienvidjorkšīrā, vokālista Olivera Sykesa, bundzinieka Meta Nikolsa, basģitārista Meta Kīna un ģitāristu Lī Malijas un Kērtisa Vorda sastāvā.\n\nPašreizējo grupas sastāvu veido: Olivers “Oli” Saikss (galvenais vokāls, taustiņinstrumenti un programmēšana), Mets Nikolss (bungas), Lī Malija (solo un ritma ģitāra), Mets Kīns (bass) un koncertturneju dalībnieks Džons Džonss (ritma ģitāra un bekvokāls).\n\nGrupa ir noslēgusi līgumu ar RCA Records visā pasaulē un ar Columbia Records ekskluzīvi Amerikas Savienotajās Valstīs. Viņu agrīnais daiļrades stils, tostarp debijas albums *Count Your Blessings*, galvenokārt tika raksturots kā melodiskais deathcore, taču vēlākajos albumos viņi sāka pieņemt eklektiskāku metalcore skanējumu. Turklāt viņu divi jaunākie albumi *That\'s the Spirit* un *amo* iezīmēja pāreju uz mazāk agresīviem roka/metāla stiliem, piemēram, alternatīvo roku, poproku un alternatīvo metālu.\n\n## Vēsture\n\nBring Me the Horizon dibinātāji nāca no dažādām metāla un roka mūzikas vidēm. Mets Nikolss un Olivers Saikss interesējās par amerikāņu metalcore grupām, piemēram, Norma Jean un Skycamefalling, un apmeklēja vietējos hardcore pankroka koncertus. Vēlāk viņi iepazinās ar Lī Maliju, kurš ar viņiem apsprieda thrash metāla un melodiskā death metāla grupas, piemēram, Metallica un At the Gates; Malija iepriekš bija spēlējis Metallica tribute grupā.\n\nBring Me the Horizon oficiāli tika dibināta 2004. gada martā, kad dalībniekiem bija 15–17 gadi. Kērtiss Vords, kurš dzīvoja Roteremas apkaimē, pievienojās Sykesam, Malijai un Nikolsam. Basģitārists Mets Kīns, kurš darbojās citās vietējās grupās, pabeidza sastāvu. Grupas nosaukums ņemts no filmas *Pirates of the Caribbean: The Curse of the Black Pearl* frāzes, kur Kapteinis Džeks Sperovs saka: “Now, bring me that horizon.”\n\nDažus mēnešus pēc dibināšanas grupa izveidoja demo albumu *Bedroom Sessions*. Pēc tam 2004. gada septembrī viņi izdeva savu pirmo EP *This Is What the Edge of Your Seat Was Made For* vietējā britu izdevniecībā Thirty Days of Night Records. Bring Me the Horizon bija pirmā grupa, ar kuru šī izdevniecība noslēdza līgumu. Ieraksts tapa Pristine Studios Notingemā divu nedēļas nogaļu laikā.\n\nPēc EP izdošanas britu izdevniecība Visible Noise noslēdza ar grupu četru albumu līgumu un 2005. gada janvārī atkārtoti izdeva EP. Atkārtotais izdevums sasniedza 41. vietu Apvienotās Karalistes albumu topā. 2006. gadā grupa saņēma balvu “Best British Newcomer” Kerrang! balvu ceremonijā.\n\nGrupas debijas albums *Count Your Blessings* tika izdots 2006. gada oktobrī Apvienotajā Karalistē un 2007. gada augustā ASV. Kritiķu vērtējumi bija pretrunīgi.\n\nOtrais studijas albums *Suicide Season* tika ierakstīts Zviedrijā producenta Fredrika Nordstrēma vadībā. Tas tika aktīvi reklamēts pirms izdošanas ar saukli “September is Suicide Season.”\n\nTrešais albums *There Is a Hell, Believe Me I\'ve Seen It. There Is a Heaven, Let\'s Keep It a Secret.* tika izdots 2010. gada 4. oktobrī un debitēja 17. vietā Billboard 200 topā ASV un 13. vietā Apvienotajā Karalistē. Albums sasniedza 1. vietu Austrālijas albumu topā.\n\n2013. gadā tika izdots albums *Sempiternal*, kura dziesmu teksti galvenokārt atspoguļo Sykesa rehabilitācijas pieredzi no ketamīna atkarības.\n\n2014. gadā grupa izdeva albumu *That\'s the Spirit*, kas guva plašu kritiķu atzinību. 2016. gada 22. aprīlī grupa uzstājās ar orķestri Royal Albert Hall Londonā diriģenta Simona Dobsona vadībā; koncerts tika izdots kā dzīvais albums *Live At The Royal Albert Hall*.\n\n2015. gada 25. janvārī tika izdots albums *amo*.\n\n## Diskogrāfija\n\n### Studijas albumi\n\n* *Count Your Blessings* (2006)\n* *Suicide Season* (2008)\n* *There Is a Hell Believe Me I\'ve Seen It. There Is a Heaven Let\'s Keep It a Secret.* (2010)\n* *Sempiternal* (2013)\n* *That\'s the Spirit* (2015)\n* *amo* (2019)\n* *POST HUMAN: SURVIVAL HORROR* (2020)\n* *POST HUMAN: Nex Gen* (2024)\n\n### Dzīvie albumi\n\n* *Live at Wembley* (2015)\n* *Live At The Royal Albert Hall* (2016)\n\n### Kompilācijas\n\n* *2004–2013* (2017)\n\n### EP\n\n* *This Is What the Edge of Your Seat Was Made For* (2004)\n* *The Chill Out Sessions* (2012)\n* *Music to listen to~dance to~blaze to~pray to~feed to~sleep to~talk to~grind to~trip to~breathe to~help to~hurt to~scroll to~roll to~love to~hate to~learn Too~plot to~play to~be to~feel to~breed to~sweat to~dream to~hide to~live to~die to~GO TO* (2019)\n', 2004, NULL, 1, 'band', 0.00, '2025-04-22 07:29:02', '2025-04-27 10:49:27'),
(2, 'AURORA', 'aurora', 'Aurora Aksnes (born June 15, 1996), known mononymously as AURORA, is a Norwegian singer, songwriter and record producer. She is considered one of Norway\\\'s biggest artists. Born in Stavanger and raised in the towns of Høle and Os, she began writing her first songs and learning dance at the age of six. After some of her songs were uploaded online and became popular in Norway, she signed a recording contract with Petroleum Records, Decca and Glassnote Records in 2014. She began writing music and lyrics at a young age, eventually releasing her debut single, Awakening, at the age of 17 in late 2013. Her second single Under Stars was released in late 2014.\\n\\n2015-2017: \\\"All My Demons Greeting Me As A Friend\\\" (Debut album)\\nThe singer signed with American record label Glassnote and UK-based Decca for her debut EP, Running With The Wolves, which arrived in the first half of 2015. The EP was highly rated mainly in Norway, and won the award for Best New Artist at the Spellemannprisen, which is known as the \\\"Norwegian Grammy\\\". In the same year, she was selected as one of the performers at the annual Nobel Peace Prize concert. She then gained further attention after covering Half The World Away by Oasis for the 2015 John Lewis Christmas advert, before following up with her debut album, All My Demons Greeting Me As A Friend, in 2016. The album charted in several Western European countries, topping the charts in Norway and reaching the Top 30 in the United Kingdom, as well as the Billboard 200 in the United States. The work was praised by several musical media. Next, AURORA embarked on her first world tour: the All My Demons Tour.\\n\\n2018: \\\"Infections Of A Different Kind – Step 1\\\" (First chapter of the second studio album)\\nThe singer surprise-released the first chapter of her second album, Infections Of A Different Kind – Step 1. Recorded mainly in the suburbs of France, the album expands the scope of the music with 32 choirs. The singer integrated more realistic themes, including politics and sexuality. This took her back into Norway\\\'s Top 10, peaking at number seven. To promote the album, AURORA released \\\"ONCE AURORA\\\", her first full-documentary, produced by Flimmer Film and directed by Benjamin Langeland and Stian Servoss. The TV version premiered on NRK, Norwegian national TV, on December 9, 2018. The film version toured the film festival circuit in 2019-2020 and on March 21, 2020 it was officially released worldwide. The film received the awards for Best Editing and Best Cinematography at the 2019 edition of Gullruten, a TV and cinema award in Norway, and Best Nordic Documentary at the Nordisk Panorama.\\n\\n2019: \\\"A Different Kind Of Human – Step 2\\\" (Second chapter of the second studio album )\\nStepping away from her solo work, AURORA entered the studio with the duo The Chemical Brothers, contributing to their ninth album, No Geography (which have won a Grammy), released in April 2019. The second chapter of her second album, A Different Kind Of Human – Step 2, was released in June of that same year. Regarding the relationship between the two works, AURORA said: \\\"The first chapter is a work about how to defend yourself, because the most important thing is to defend yourself. Only then can you do this with your friends, family and yourself. You can help even people you don\\\'t know. If you love yourself and learn to help, you can be invincible. Chapter 2 is realizing how you can help the world. worried about me. Describes the entire process of becoming a warrior of love.\\\"\\n\\n2019-2020: \\\"Into the Unknown\\\" and Soundtracks\\nIn the Disney full-lenght \\\"Frozen 2\\\" released in 2019, she made an appearance in the work as a \\\"mysterious voice\\\" and was featured in the song Into the Unknown. At the 92nd Academy Awards held the following year, she performed with Elsa from 10 countries around the world, including Idina Menzel. In the full-lenght \\\"Wolfwalkers\\\"\\\" by the animation studio Cartoon Saloon, whose produced films were nominated for an Oscar, AURORA re-recorded the song Running With The Wolves for the movie.\\n\\n2021-2023: \\\"The Gods We Can Touch\\\" (Third studio album)\\nThroughout the second half of 2021, AURORA released singles to promote her third studio album and had a highlight in the singer\\\'s single Sub Urban, PARAMOUR. With ancient Greek mythology as its theme, the album The Gods We Can Touch was released via Glassnote and Decca in January 2022. It was produced by the singer and the longtime collaborator Magnus Skylstad, who also co-wrote many of the songs. The album was the singer\\\'s first top 10 on the UK album chart, second top 1 in Norway and her first album to chart on the French albums chart. The singer won the International Sucess Of The Year award on the 2021 edition of Spellemannprisen, and also won the P3 Gull, the main prize of the Norwegian award with same name.\\n\\nAURORA embarked on her extensive The Gods We Can Touch Tour in March 2022, with opening acts: Metteson, Sub Urban, Thea Wang, Sei Selina, Blusher and Hannah Storm.\\n\\nIn August 2022, AURORA headlined the Øyafestivalen, one of the largest music festivals in Norway, as part of her The Gods We Can Touch Tour. Her show was seen by an audience of approximately 20,000 people, marking her biggest show in the country. The British magazine NME reviewed the concert and rated it 100/100: \\\"Aurora shines at the festival of the future\\\".\\n\\nOther projects included Storm, a collaboration with Taiwanese singer Wu Qing-feng, released in June 2022. September saw the release of the song Hunting Shadows for the video game\\\'s 15th anniversary Assassin\\\'s Creed. In October, the soundtrack for the BBC documentary series \\\"Frozen Planet II\\\" was released, which AURORA contributed with her vocals for 21 tracks. Several songs from AURORA\\\'s discography were featured in a season of the video game Sky: Children of the Light. Its season ended with a interactive virtual concert, which was released as a soundtrack: Sky: Concert in the Light.\\n\\nThe singer was featured in Butterflies, a collaboration with Tom Odell, and in My Sails Are Set for the Netflix series One Piece.\\n\\n2023-2024: \\\"What Happened To The Heart?\\\" (Fourth studio album)\\nThe single Your Blood, AURORA\\\'s first new solo musical material in nearly two years, was released on 8 November 2023. At the beginning of the following year, she confirmed that she was working on her forthcoming fourth studio album, and released the single The Conflict Of The Mind as the second single from the album, following \\\"Your Blood\\\"; it was released along with a music video co-directed by AURORA and Kaveh Nabatian. Some Type Of Skin premiered on 20 March as the third single, and, a week later, she announced her album What Happened To The Heart?, which was released on 7 June 2024; it was labeled as her most personal and cathartic album to date. Along with the announcement, she also revealed that she will promote it with a concert world tour titled What Happened To The Earth?, beginning in September 2024.\\n\\nAURORA featured on Bring Me The Horizon\\\'s song liMOusIne from their album POST HUMAN: NeX GEn, released on May 24, 2024.\\n\\nDuring the Latin American leg of Aurora\\\'s What Happened To The Earth? tour, she performed the biggest headline show of her career with a sold-out attendance of 18,000 at the Palacio de los Deportes in Mexico City.', NULL, 2012, NULL, 1, 'solo', 0.00, '2025-04-22 07:29:04', '2025-04-27 10:49:27'),
(3, 'Underoath', 'underoath', 'Underoath (also typeset as underOATH or UNDERØATH) is an American band formed on November 30, 1997, in Ocala. The band later relocated to Tampa, which became home to several of its newer members.\n\nDuring its early years, when fronted by former vocalist Dallas Taylor, the band displayed a heavier style than in its later, more widely known work, incorporating influences from death and black metal. With Taylor, the band released the albums *Act of Depression*, *Cries of the Past*, and *The Changing of Times*.\n\nAfter Taylor’s departure, Spencer Chamberlain became lead vocalist. The band subsequently released *They’re Only Chasing Safety* and *Define the Great Line*. These albums brought increased mainstream and commercial success, including a certified gold rating and the highest-charting Christian album on the Billboard 200 since 1997, respectively. *They’re Only Chasing Safety* marked a significant stylistic departure, featuring extensive clean vocals, more melodic rhythms, and a reduced emphasis on breakdowns and double-bass drumming. *Define the Great Line* reflected another stylistic shift, reintroducing heavier elements such as harsher vocals, detuned guitars, and guitar work inspired by Botch.\n\nThe band released the live album *Survive, Kaleidoscope* on May 27, 2008. Earlier that year, they recorded a studio album titled *Lost in the Sound of Separation*, released on September 2, 2008, which peaked at number 8 on the Billboard 200.\n\nIn April 2010, drummer and vocalist Aaron Gillespie announced his departure from the band, stating that there were no hard feelings and that he would continue focusing on his other band, The Almost. His exit left Underoath without any of its founding members.\n\nThe band recorded its seventh studio album with new drummer Daniel Davison, formerly of Norma Jean. The album, *Ø (Disambiguation)*, was released on November 9, 2010.\n\nIn October 2012, Underoath announced that it would disband the following year and released a career-spanning compilation album, *Anthology: 1999–2013*, on November 6, 2012. The band embarked on a nine-date farewell tour, concluding at Jannus Live in St. Petersburg on January 26, 2013.\n\nIn January 2015, the band launched a campaign to complete production of a documentary about its 12-show farewell tour and released two trailers on its YouTube channel.\n\nIn July 2015, Underoath began teasing the phrase “rebirth is coming” along with a cryptic video on social media. When played backward, the audio revealed the chorus of “It’s Dangerous Business Walking Out Your Front Door” from their 2004 album *They’re Only Chasing Safety*. A countdown timer later appeared on the band’s website, ending on August 24, 2015.\n\nOn August 17, 2015, the band announced its first show since disbanding, headlining the Self Help Fest in San Bernardino on March 19, 2016, alongside A Day to Remember. In an interview with Alternative Press, Chamberlain and Gillespie confirmed that the band was reuniting.', NULL, NULL, NULL, 1, 'solo', 0.00, '2025-04-22 07:29:04', '2025-04-27 10:49:27'),
(4, 'Lil Uzi Vert', 'lil-uzi-vert', 'Symere Bysil Woods (born July 31, 1995, Philadelphia, USA), known professionally as Lil Uzi Vert, is an American rapper, singer, and songwriter. Characterized by their face tattoos, facial piercings, eccentric hairstyles, and androgynous fashion, their music is often defined by dark subject matters and imagery built on a melodic emo approach to trap.\\r\\n\\r\\nThey attracted mainstream attention following the release of their debut single \\\"Money Longer\\\" in 2016. The song would act as the lead single for the subsequent mixtape \\\"Lil Uzi Vert vs. the World\\\". After releasing two additional mixtapes in 2016 and 2017, including one in collaboration with Gucci Mane, Lil Uzi Vert was featured on the Billboard Hot 100 chart. They later secured their first top 10 single with \\\"XO Tour Llif3\\\", which won the MTV Video Music Award for Song of the Summer.\\r\\n\\r\\n\\\"XO Tour Llif3\\\" acted as the lead single to Lil Uzi Vert\\\'s debut studio album \\\"Luv Is Rage 2\\\" (2017), which debuted at number one on the Billboard 200, and was certified double platinum by the Recording Industry Association of America (RIAA). At the 2018 Grammy Awards, Lil Uzi Vert was nominated for Best New Artist. Their second studio album \\\"Eternal Atake\\\" (2020) was among the most anticipated albums in hip hop and peaked at number one on the Billboard 200.\\r\\n\\r\\n2010–2015: Career beginnings\\r\\nWoods began to rap in 2010 and began to associate with musical groups like Steaktown, in what he said was \\\"just for money\\\", under the name \\\"Sealab Vertical\\\". They later changed their name to Lil Uzi Vert from the way someone described their rap flow, saying their flow was \\\"Fast, like a machine gun\\\". Woods\\\' first project, an EP titled \\\"Purple Thoughtz Vol. 1\\\", was released on January 19, 2014. The project, which was described as \\\"phonk\\\" and having cloud rap beats due to its psychedelic and \\\"trippy\\\" production, features a bigger focus on lyricism and was released with the single \\\"White Shit\\\". The track, produced by Spaceghostpurrp, went viral in 2017 within hip-hop circles following Woods\\\' entry into the mainstream. Shortly after the release of their first project, Woods caught the attention of then industry-mainstays like Mob.\\r\\n\\r\\nThe EP and following features caught the attention of producer and cofounder of Atlantic Records Don Cannon after DJ Diamond Kuts played one of their songs on a local radio station. Cannon then produced and hosted their first mixtape, \\\"The Real Uzi\\\", which was released on August 5, 2014. After the release of \\\"The Real Uzi\\\", Woods signed a record deal with Atlantic Records through DJ Drama, Don Cannon\\\'s, and Leighton Morrison\\\'s imprint, Generation Now.\\r\\n\\r\\nFollowing their signing to Atlantic Records, Woods was featured alongside Kid and Ferg on Carnage\\\'s single \\\"WDYW\\\". They also released several songs on SoundCloud including \\\"No Wait\\\", produced by Metro Booming, \\\"Pressure\\\", which is a collaboration with Durk, and \\\'\\\'Loaf\\\". He was featured on Fall Out Boy and Khalifa\\\'s \\\"Boys of Zummer\\\" tour in August 2015.\\r\\n\\r\\nWoods released their second mixtape, \\\"Luv Is Rage\\\" on October 30, 2015. The project was received positively and was featured on numerous music blogs such as Fader, XXL, and Vibe. They were further called a \\\"breakout artist of 2015\\\" by HotNewHipHop.\\r\\n\\r\\n2016: Breakthrough\\r\\nIn February 2016, they released the single, \\\"Money Longer\\\" on their SoundCloud following a radio debut on Shade 45.\\r\\n\\r\\nOn April 15, 2016, Vert released their third mixtape and first commercial mixtape \\\"Lil Uzi Vert vs. the World\\\". The mixtape debuted at number 37 on the Billboard 200 chart, making it their first entry on said chart. The project spent 55 weeks on the Billboard 200, eventually being certified Gold. Lil Uzi Vert and Kapri embarked on a joint tour in May 2016, titled the \\\"Parental Advisory\\\" tour.\\r\\n\\r\\nIn June 2016, Uzi appeared in XXL magazine as part of their 2016 Freshmen Class. As part of this appearance, Uzi performed a ‘freshman cypher’ alongside Denzel Curry, Lil Yachty, 21 Savage, and Kodak Black. Riding the wave of recognition the XXL Freshman list gave them, Woods released the video for the single \\\"Money Longer\\\" which debuted on the Billboard Hot 100 the following week, their first entry on the chart, at number 92 on July 2, 2016. The song later peaked at number 54 and is currently certified two times platinum in the United States. Woods\\\' second entry on the chart, \\\"You Was Right\\\", debuted at 89 on July 30, 2016 and peaked at number 40.\\r\\n\\r\\nOn July 12, 2016, Woods announced their fourth mixtape, \\\"The Perfect LUV Tape\\\", which was released on July 31, their 22nd birthday. The mixtape featured the singles \\\"Seven Million\\\", featuring Future, and \\\"Erase Your Social\\\", both of which failed to chart on the Billboard Hot 100. The mixtape debuted at number 55 on the Billboard 200 album chart and is certified Gold by the RIAA. In October 2016, Woods was announced to be an additional artist on The Weeknd\\\'s \\\"Starboy: legend of the Fall\\\" tour.\\r\\n\\r\\nLil Uzi Vert announced a collaboration mixtape with Gucci Mane titled \\\"1017 vs. The World\\\", which was released on November 23, 2016. On the 27th, Uzi announced \\\"Luv Is Rage 2\\\" which went through a series of delays.\\r\\n\\r\\n2017: Luv Is Rage 2\\r\\nUzi was featured on Migos\\\' single \\\"Bad and Boujee\\\". The single was released on August 31, 2016, and its from the trio\\\'s second studio album \\\"Culture\\\". In January 2017, around the time the album was released, the single reached the top of the US Billboard Hot 100, becoming Uzi\\\'s first number 1 single as a lead or featured artist, and their highest charting single as both. On February 27, 2017, Woods released the EP \\\"Luv Is Rage 1.5\\\" while on tour with The Weeknd. The EP was positively received for its \\\"nerdy\\\" nature, with Kingdom Hearts themed instrumentals and lyrics referring to anime, Steven Universe, and hentai. The EP was also credited as the start of Uzi\\\'s affiliation with the \\\"emo-rapper\\\" label due to the heartbreak-associated lyrics on the song \\\"Luv Scars K.o 1600\\\" and references to threats of suicide and depression on the stand-out track \\\"XO Tour Llif3\\\".\\r\\n\\r\\n\\\"XO Tour Llif3\\\" got significant popularity on SoundCloud, resulting in Uzi playing it live on the European leg of The Weeknd\\\'s tour, and the following week the song was added to streaming services and released as an official single. On April 4, 2017, \\\"Xo Tour Llif3\\\" debuted on Billboard Hot 100 at number 49 and peaked at number 7, becoming the rapper\\\'s highest charting song and biggest song, being certified 6x platinum as of August 2018.\\r\\n\\r\\n\\\"Luv Is Rage 2\\\" was delayed again on April 2, 2017, with Uzi blaming it on DJ Drama. On April 9, Don Cannon confirmed the project wasn\\\'t getting released \\\"any time soon\\\" and confirmed that \\\"XO Tour Llif3\\\" would be on the album. Uzi was featured on fellow rapper Playboi Carti\\\'s single \\\"wokeuplikethis*\\\", released on April 7. The single was performed by the pair at Coachella 2017.\\r\\n\\r\\n\\\"wokeuplikethis*\\\" was eventually certified platinum and peaked at number 76 on the Billboard Hot 100. Uzi was featured alongside ASAP Rocky, Playboi Carti, Quavo, and Frank Ocean on A$AP rappers collective Mob\\\'s single \\\"RAF\\\". The single was released by surprise on May 15, 2017. In early August, hip-hop media personality DJ Akademiks claimed that \\\"Luv Is Rage 2\\\" would be released within 30 days. On August 24, 2017, \\\"Luv Is Rage 2\\\" was announced for a surprise release at midnight, and on August 25, 2017, Lil Uzi Vert released their heavily delayed debut studio album, which included \\\"XO TOUR Llif3\\\" as the lead single.\\r\\n\\r\\nThe album debuted at number one on the Billboard 200 albums chart, with 135,000 album-equivalent units, and has since been certified platinum. The album also created ten Billboard Hot 100 charting singles, with two of them, \\\"The Way Life Goes\\\" and \\\"Sauce It Up\\\", becoming singles. During british singer Ed Sheeran\\\'s set at the Video Music Awards, Uzi Vert and Sheeran performed a medley of \\\"XO Tour Llif3\\\" and Sheeran\\\'s chart-topping single, \\\"Shape Of You\\\".\\r\\n\\r\\nIn September 2017, Woods teased a possible sequel project to \\\"Lil Uzi Vert vs The World\\\", possibly titled \\\"Lil Uzi Vert vs. The World 2\\\", and a collaboration project with Playboi Carti titled \\\"16*29\\\". In October, a joint tour with Playboi Carti called the \\\"16*29 tour\\\" was announced, further promoting the possibility of a collaboration project. The tour was canceled shortly thereafter due to Uzi claiming he needed to \\\"focus\\\". In October 2017, Uzi headlined Power 105.1\\\'s annual Powerhouse music celebration alongside The Weeknd, Migos, and Cardi B, at the Barclays Center in Brooklyn, New York. Uzi was also featured on Canadian rapper Nav\\\'s platinum-certified single \\\"Wanted You\\\". The song was released on November 3, 2017.\\r\\n\\r\\nOn December 4, 2017, \\\"The Way Life Goes\\\" music video was released with a remix featuring Nicki Minaj. The song peaked at number 24 on the Billboard Hot 100. Uzi Vert performed the song on Stephen Colbert\\\'s The Late Show on February 6, 2018.\\r\\n\\r\\nThey were featured alongside Kanye West on Travis Scott\\\'s song, \\\"Watch\\\", which was released on May 3, 2018. \\\"Watch\\\" debuted at number 16 on the Billboard Hot 100 chart. They were also featured on a remix for fellow rapper Lil Tracy\\\'s single \\\"Like a Farmer\\\".\\r\\n\\r\\n2018–2020: Eternal Atake, Lil Uzi Vert vs. The World 2, and Pluto x Baby Pluto\\r\\n\\r\\nIn January 2018, Uzi announced that he had completed a mixtape with record producer Wheezy. In May 2018, Don Cannon confirmed that a new Uzi project was dropping that year and speculation arose in July 2018 when Uzi tweeted the words \\\"Eternal Atake\\\", the title of their second studio album, pinning the tweet and announcing it was \\\"coming soon\\\", then at the end of the month sharing the then-chosen cover art for the project. The art referenced the logo of the cult Heavens Gate. The two members who survived the cult suggested that legal actions could be taken against Uzi for copying the logo style.\\r\\n\\r\\nThe art was the source of a threat from the remaining members of the organization over a legal attack. The then-thought lead single for the album, \\\"New Patek\\\" was released on September 18, 2018. Uzi was then featured on Lil Pump\\\'s single, \\\"Multi Millionaire\\\". The single was released on October 5, 2018.\\r\\n\\r\\nIn April 2019, following label trouble with Generation Now, it was announced that Uzi was now signed to Roc Nation. Two new promotional singles were released in April 2019, titled \\\"Sanguine Paradise\\\" and \\\"That\\\'s a Rack\\\", originally thought to be from their highly anticipated studio album, \\\"Eternal Atake\\\".\\r\\n\\r\\nOn December 13, 2019, Uzi released a new single titled \\\"Futsal Shuffle 2020\\\", which is the lead single of \\\"Eternal Atake\\\". The rapper then released the second single of the album, \\\"That Way\\\", on March 1, 2020.\\r\\n\\r\\n\\\"Eternal Atake\\\" was released on March 6, 2020, with a sole guest appearance from American singer Syd. \\\"New Patek\\\", \\\"That\\\'s a Rack\\\" and \\\"Sanguine Paradise\\\" did not appear on the album. \\\"Eternal Atake\\\" debuted atop the Billboard 200.\\r\\n\\r\\nOn March 12, 2020, Lil Uzi teased that the deluxe version of \\\"Eternal Atake\\\" and the sequel to their 2016 mixtape, \\\"Lil Uzi Vert vs. the World\\\", titled \\\"Lil Uzi Vert vs. the World 2\\\", would be released the following day, the date fans expected the release date of the original album.\\r\\n\\r\\nThe deluxe edition would have fourteen new tracks, featuring guest appearances from Chief Keef, 21 Savage, Future, Young Thug, Gunna, Lil Durk, Young Nudy, and Nav. The first half of the album maintained a leading number 1 position with 400 million streams in early 2020. This marked the largest streaming count for any album since 2018, when Lil Wayne\\\'s twelfth studio album, \\\"Tha Carter V\\\", got 433 million streams.\\r\\n\\r\\nOn April 24, 2020, Lil Uzi Vert released a new single titled \\\"Sasuke\\\". On July 10, Lil Uzi appeared on the remix of StaySolidRocky\\\'s \\\"Party Girl\\\". On July 21, Lil Uzi and Future hinted at an upcoming joint project titled \\\"Pluto x Baby Pluto\\\" on their social medias; it was released on November 13, 2020, and peaked at number two on the Billboard 200.\\r\\n\\r\\n2021–2022: Subsequent ventures\\r\\nIn late 2020, Lil Uzi Vert began promoting new singles on Instagram Live that were sonically similar to popular releases early on in their career. He announced an upcoming project titled \\\"Forever Young\\\", as well as a follow-up to \\\"Luv Is Rage 2\\\".\\r\\n\\r\\nFrom the 16th to the 22nd of july 2022, Uzi released 4 songs from their EP, RED & WHITE on their SoundCloud account day by day, then, on the 22nd, the rest of the EP was released.\\r\\n\\r\\n2023 - Present\\r\\nIn June 2023, Uzi noted that the album would be released that same month. On the 17th, Uzi had taken to Instagram to post an alternate cover art to the project. He also announced that the cover art would release in \\\"a couple of days\\\" and that the tracklist would release \\\"this week,\\\" while confirming the release date of June 30.\\r\\n\\r\\nOn June 26, 2023, Uzi revealed the cover art and the release date on their website and simultaneously released the Gibson Hazard directed trailer for the album. Days prior to it\\\'s official announcement, Uzi threw an album release party — which he named “The Pink Tape Prom” — in which he previewed several tracks from the project.\\r\\n\\r\\nOn June 30, 2023, Lil Uzi Vert released the highly anticipated album, \\\"Pink Tape\\\". The album contains guest appearances from Travis Scott, Nicki Minaj, Bring Me The Horizon, Don Toliver, and Babymetal.', NULL, NULL, NULL, 1, 'solo', 0.00, '2025-04-22 07:29:05', '2026-01-02 17:19:53'),
(5, 'Daryl Palumbo', 'daryl-palumbo', NULL, NULL, NULL, NULL, 1, 'solo', 0.00, '2025-04-22 07:29:05', '2025-04-27 10:49:27'),
(6, 'Glassjaw', 'glassjaw', NULL, '\"Glassjaw\" ir amerikāņu posthārkora grupa no Hempstedas, Ņujorkas štata . [ 1 ] To 1993. gadā izveidoja vokālists Derils Palumbo un ģitārists Džastins Beks . Grupa ir pazīstama ar saviem intensīvajiem koncertiem, kā arī biežajām sastāva maiņām. [ 2 ] [ 3 ] Neskatoties uz ierobežotajiem komerciālajiem panākumiem un nelielo diskogrāfiju, viņi tiek uzskatīti par vienu no ietekmīgākajām grupām pazemes mūzikas skatuves attīstībā ASV austrumos un Apvienotajā Karalistē posthārkora žanrā . [ 4 ] [ 5 ]\n\nPēc vairāku EP un demo ierakstu ierakstīšanas 20. gs. deviņdesmitajos gados grupa Glassjaw nonāca producenta Rosa Robinsona uzmanības lokā , kurš palīdzēja grupai noslēgt līgumu ar Roadrunner Records . Robinsons kļuva par Glassjaw debijas albuma Everything You Ever Wanted to Know About Silence (2000) producentu, kas palīdzēja grupai nostiprināt sekotāju loku Apvienotajā Karalistē. [ 6 ] Pēc šķiršanās no Roadrunner pēc nesaskaņām, Glassjaw parakstīja līgumu ar Warner Bros. Records , kas izdeva grupas otro albumu Worship and Tribute (2002). Albums sasniedza 82. vietu Billboard 200 topā un piesaistīja plašākai publikai uzmanību, lai gan tās atbalsta turneju negatīvi ietekmēja Palumbo cīņa ar Krona slimību ap šo laiku, kā rezultātā vairāki koncerti tika atcelti. [ 7 ] Lai gan grupa turpināja rīkot turnejas neregulāri, Glassjaw studijas darbība atlikušajā 2000. gadu daļā bija neregulāra, kamēr Palumbo un Beks koncentrējās uz citiem projektiem. [ 8 ] [ 9 ]\n\nPēc šķiršanās no Warner Bros., Glassjaw 2010. gada beigās paši izdeva 7 collu singlu sēriju , kas vēlāk, 2011. gada janvārī, tika apkopota EP — Our Color Green (The Singles). Mēnesi vēlāk grupa izdeva vēl vienu EP — Coloring Book . 2017. gadā Glassjaw izdeva savu pirmo albumu 15 gadu laikā — Material Control , izmantojot Century Media Records pakalpojumus . 2022. gadā grupa sniedza virkni koncertu, pieminot grupas pirmo divu albumu 20. gadadienu. [ 10 ]', 1993, NULL, 1, 'band', 0.00, '2025-04-22 07:29:05', '2026-01-03 10:52:30'),
(7, 'YUNGBLUD', 'yungblud', NULL, NULL, NULL, NULL, 1, 'solo', 0.00, '2025-04-22 07:29:05', '2025-04-27 10:49:27'),
(8, 'BABYMETAL', 'babymetal', NULL, NULL, NULL, NULL, 1, 'solo', 0.00, '2025-04-22 07:29:05', '2025-04-27 10:49:27'),
(9, 'Nova Twins', 'nova-twins', NULL, NULL, NULL, NULL, 1, 'solo', 0.00, '2025-04-22 07:29:05', '2025-04-27 10:49:27'),
(10, 'Amy Lee', 'amy-lee', NULL, NULL, NULL, NULL, 1, 'solo', 0.00, '2025-04-22 07:29:05', '2025-04-27 10:49:27'),
(11, 'Halsey', 'halsey', NULL, NULL, NULL, NULL, 1, 'solo', 0.00, '2025-04-22 07:29:07', '2025-04-27 10:49:27'),
(12, 'BEXEY', 'bexey', NULL, NULL, NULL, NULL, 1, 'solo', 0.00, '2025-04-22 07:29:07', '2025-04-27 10:49:27'),
(13, 'Lotus Eater', 'lotus-eater', NULL, NULL, NULL, NULL, 1, 'solo', 0.00, '2025-04-22 07:29:07', '2025-04-27 10:49:27'),
(14, 'Happyalone.', 'happyalone', NULL, NULL, NULL, NULL, 1, 'solo', 0.00, '2025-04-22 07:29:07', '2025-04-27 10:49:27'),
(15, 'Toriel', 'toriel', NULL, NULL, NULL, NULL, 1, 'solo', 0.00, '2025-04-22 07:29:07', '2025-04-27 10:49:27'),
(16, 'YONAKA', 'yonaka', NULL, NULL, NULL, NULL, 1, 'solo', 0.00, '2025-04-22 07:29:07', '2025-04-27 10:49:27'),
(17, 'Grimes', 'grimes', NULL, NULL, NULL, NULL, 1, 'solo', 0.00, '2025-04-22 07:29:08', '2025-04-27 10:49:27'),
(18, 'Dani Filth', 'dani-filth', NULL, NULL, NULL, NULL, 1, 'solo', 0.00, '2025-04-22 07:29:08', '2025-04-27 10:49:27'),
(19, 'Rahzel', 'rahzel', NULL, NULL, NULL, NULL, 1, 'solo', 0.00, '2025-04-22 07:29:08', '2025-04-27 10:49:27'),
(20, 'Lights', 'lights', NULL, NULL, NULL, NULL, 1, 'solo', 0.00, '2025-04-22 07:29:11', '2025-04-27 10:49:27'),
(21, 'Josh Franceschi', 'josh-franceschi', NULL, NULL, NULL, NULL, 1, 'solo', 0.00, '2025-04-22 07:29:11', '2025-04-27 10:49:27'),
(22, 'Josh Scogin', 'josh-scogin', NULL, NULL, NULL, NULL, 1, 'solo', 0.00, '2025-04-22 07:29:11', '2025-04-27 10:49:27'),
(23, 'Borgore', 'borgore', NULL, NULL, NULL, NULL, 1, 'solo', 0.00, '2025-04-22 07:29:11', '2025-04-27 10:49:27'),
(24, 'JJ Peters', 'jj-peters', NULL, NULL, NULL, NULL, 1, 'solo', 0.00, '2025-04-22 07:29:12', '2025-04-27 10:49:27'),
(25, 'Sam Carter', 'sam-carter', NULL, NULL, NULL, NULL, 1, 'solo', 0.00, '2025-04-22 07:29:12', '2025-04-27 10:49:27'),
(26, 'Robotsonics', 'robotsonics', NULL, NULL, NULL, NULL, 1, 'solo', 0.00, '2025-04-22 07:29:12', '2025-04-27 10:49:27'),
(27, 'KC Blitz', 'kc-blitz', NULL, NULL, NULL, NULL, 1, 'solo', 0.00, '2025-04-22 07:29:12', '2025-04-27 10:49:27'),
(28, 'L\'Amour La Morgue', 'lamour-la-morgue', NULL, NULL, NULL, NULL, 1, 'solo', 0.00, '2025-04-22 07:29:12', '2025-04-27 10:49:27'),
(29, 'The Toxic Avenger', 'the-toxic-avenger', NULL, NULL, NULL, NULL, 1, 'band', 0.00, '2025-04-22 07:29:12', '2025-04-27 10:49:27'),
(30, 'After the Night', 'after-the-night', NULL, NULL, NULL, NULL, 1, 'solo', 0.00, '2025-04-22 07:29:12', '2025-04-27 10:49:27'),
(31, 'Tek-One', 'tek-one', NULL, NULL, NULL, NULL, 1, 'solo', 0.00, '2025-04-22 07:29:12', '2025-04-27 10:49:27'),
(32, 'I Haunt Wizards', 'i-haunt-wizards', NULL, NULL, NULL, NULL, 1, 'solo', 0.00, '2025-04-22 07:29:12', '2025-04-27 10:49:27'),
(33, 'Skrillex', 'skrillex', NULL, NULL, NULL, NULL, 1, 'solo', 0.00, '2025-04-22 07:29:12', '2025-04-27 10:49:27'),
(34, 'Ben Weinman', 'ben-weinman', NULL, NULL, NULL, NULL, 1, 'solo', 0.00, '2025-04-22 07:29:12', '2025-04-27 10:49:27'),
(35, 'The Secret Handshake', 'the-secret-handshake', NULL, NULL, NULL, NULL, 1, 'band', 0.00, '2025-04-22 07:29:12', '2025-04-27 10:49:27'),
(36, 'Oli Sykes', 'oli-sykes', NULL, NULL, NULL, NULL, 1, 'solo', 0.00, '2025-04-22 07:29:17', '2025-04-27 10:49:27'),
(37, 'CORPSE', 'corpse', NULL, NULL, NULL, NULL, 1, 'solo', 0.00, '2025-04-22 07:29:17', '2025-04-27 10:49:27'),
(38, 'SLANDER', 'slander', NULL, NULL, NULL, NULL, 1, 'solo', 0.00, '2025-04-22 07:29:19', '2025-04-27 10:49:27'),
(39, 'blackbear', 'blackbear', NULL, NULL, NULL, NULL, 1, 'solo', 0.00, '2025-04-22 07:29:19', '2025-04-27 10:49:27'),
(40, 'Sigrid', 'sigrid', NULL, NULL, NULL, NULL, 1, 'solo', 0.00, '2025-04-22 07:29:22', '2025-04-27 10:49:27');
INSERT INTO `artists` (`id`, `name`, `slug`, `biography`, `biography_lv`, `formed_year`, `disbanded_year`, `is_active`, `solo_or_band`, `popularity`, `created_at`, `updated_at`) VALUES
(41, 'Masked Wolf', 'masked-wolf', NULL, NULL, NULL, NULL, 1, 'solo', 0.00, '2025-04-22 07:29:23', '2025-04-27 10:49:27'),
(42, 'Ed Sheeran', 'ed-sheeran', NULL, NULL, NULL, NULL, 1, 'solo', 0.00, '2025-04-22 07:29:24', '2025-04-27 10:49:27'),
(43, 'six impala', 'six-impala', NULL, NULL, NULL, NULL, 1, 'solo', 0.00, '2025-04-22 07:29:25', '2025-04-27 10:49:27'),
(44, 'IC3PEAK', 'ic3peak', NULL, NULL, NULL, NULL, 1, 'solo', 0.00, '2025-04-22 07:29:26', '2025-04-27 10:49:27'),
(45, 'Tom Morello', 'tom-morello', NULL, NULL, NULL, NULL, 1, 'solo', 0.00, '2025-04-22 07:29:27', '2025-04-27 10:49:27'),
(46, 'Olivia O\'Brien', 'olivia-obrien', NULL, NULL, NULL, NULL, 1, 'solo', 0.00, '2025-04-22 07:29:28', '2025-04-27 10:49:27'),
(47, 'Jeris Johnson', 'jeris-johnson', NULL, NULL, NULL, NULL, 1, 'solo', 0.00, '2025-04-22 07:29:29', '2025-04-27 10:49:27'),
(48, 'Death Stranding: Timefall', 'death-stranding-timefall', NULL, NULL, NULL, NULL, 1, 'solo', 0.00, '2025-04-22 07:29:32', '2025-04-27 10:49:27'),
(49, 'Sub Focus', 'sub-focus', NULL, NULL, NULL, NULL, 1, 'solo', 0.00, '2025-04-22 07:29:34', '2025-04-27 10:49:27'),
(50, 'Shikari Sound System', 'shikari-sound-system', NULL, NULL, NULL, NULL, 1, 'solo', 0.00, '2025-04-22 07:29:40', '2025-04-27 10:49:27'),
(51, 'Jakwob', 'jakwob', NULL, NULL, NULL, NULL, 1, 'solo', 0.00, '2025-04-22 07:29:40', '2025-04-27 10:49:27'),
(59, 'baji tembeingterp', 'baji-tembeingterp', NULL, NULL, NULL, NULL, 1, 'solo', 0.00, '2025-04-26 04:14:53', '2025-04-27 10:49:27'),
(61, 'Brand of Sacrifice', 'brand-of-sacrifice', NULL, NULL, NULL, NULL, 1, 'solo', 0.00, '2025-04-26 19:21:32', '2025-04-27 10:49:27'),
(62, 'Frankie Palmeri', 'frankie-palmeri', NULL, NULL, NULL, NULL, 1, 'solo', 0.00, '2025-04-26 19:21:34', '2025-04-27 10:49:27'),
(63, 'Ben Duerr', 'ben-duerr', NULL, NULL, NULL, NULL, 1, 'solo', 0.00, '2025-04-26 19:21:34', '2025-04-27 10:49:27'),
(64, 'Eric Vanlerberghe', 'eric-vanlerberghe', NULL, NULL, NULL, NULL, 1, 'solo', 0.00, '2025-04-26 19:21:34', '2025-04-27 10:49:27'),
(65, 'Jamie Graham', 'jamie-graham', NULL, NULL, NULL, NULL, 1, 'solo', 0.00, '2025-04-26 19:21:34', '2025-04-27 10:49:27'),
(66, 'Tyler Shelton', 'tyler-shelton', NULL, NULL, NULL, NULL, 1, 'solo', 0.00, '2025-04-26 19:21:34', '2025-04-27 10:49:27'),
(67, 'Termina', 'termina', NULL, NULL, NULL, NULL, 1, 'solo', 0.00, '2025-04-26 19:21:37', '2025-04-27 10:49:27'),
(68, 'Nik Nocturnal', 'nik-nocturnal', NULL, NULL, NULL, NULL, 1, 'solo', 0.00, '2025-04-26 19:21:37', '2025-04-27 10:49:27'),
(69, 'Harper', 'harper', NULL, NULL, NULL, NULL, 1, 'solo', 0.00, '2025-04-26 19:21:38', '2025-04-27 10:49:27'),
(70, 'We Came As Romans', 'we-came-as-romans', NULL, NULL, NULL, NULL, 1, 'solo', 0.00, '2025-04-26 19:21:38', '2025-04-27 10:49:27'),
(71, 'Ryo Kinoshita', 'ryo-kinoshita', NULL, NULL, NULL, NULL, 1, 'solo', 0.00, '2025-04-26 19:21:41', '2025-04-27 10:49:27'),
(72, 'Will Ramos', 'will-ramos', NULL, NULL, NULL, NULL, 1, 'solo', 0.00, '2025-04-26 19:21:43', '2025-04-27 10:49:27'),
(73, 'Spencer Chamberlain', 'spencer-chamberlain', NULL, NULL, NULL, NULL, 1, 'solo', 0.00, '2025-04-26 19:21:44', '2025-04-27 10:49:27'),
(74, 'KAMAARA', 'kamaara', NULL, NULL, NULL, NULL, 1, 'solo', 0.00, '2025-04-26 19:21:48', '2025-04-27 10:49:27'),
(75, 'Kill Ebola', 'kill-ebola', NULL, NULL, NULL, NULL, 1, 'solo', 0.00, '2025-04-26 19:21:50', '2025-04-27 10:49:27'),
(76, 'Savage Ga$p', 'savage-gap', NULL, NULL, NULL, NULL, 1, 'solo', 0.00, '2025-04-26 19:21:51', '2025-04-27 10:49:27'),
(77, 'Witchouse 40k', 'witchouse-40k', NULL, NULL, NULL, NULL, 1, 'solo', 0.00, '2025-04-26 19:21:51', '2025-04-27 10:49:27'),
(78, '$werve', 'werve', NULL, NULL, NULL, NULL, 1, 'solo', 0.00, '2025-04-26 19:21:51', '2025-04-27 10:49:27'),
(79, 'Lil Darkie', 'lil-darkie', NULL, NULL, NULL, NULL, 1, 'solo', 0.00, '2025-04-26 19:21:51', '2025-04-27 10:49:27'),
(80, 'SXMPRA', 'sxmpra', NULL, NULL, NULL, NULL, 1, 'solo', 0.00, '2025-04-26 19:21:51', '2025-04-27 10:49:27'),
(81, 'Grim Salvo', 'grim-salvo', NULL, NULL, NULL, NULL, 1, 'solo', 0.00, '2025-04-26 19:21:52', '2025-04-27 10:49:27'),
(82, 'Drear', 'drear', NULL, NULL, NULL, NULL, 1, 'solo', 0.00, '2025-04-26 19:21:52', '2025-04-27 10:49:27'),
(83, 'KXLLSWXTCH', 'kxllswxtch', NULL, NULL, NULL, NULL, 1, 'solo', 0.00, '2025-04-26 19:21:52', '2025-04-27 10:49:27'),
(84, '83HADES', '83hades', NULL, NULL, NULL, NULL, 1, 'solo', 0.00, '2025-04-26 19:21:52', '2025-04-27 10:49:27'),
(85, 'N8Z', 'n8z', NULL, NULL, NULL, NULL, 1, 'solo', 0.00, '2025-04-26 19:21:53', '2025-04-27 10:49:27'),
(86, 'Pyrxciter', 'pyrxciter', NULL, NULL, NULL, NULL, 1, 'solo', 0.00, '2025-04-26 19:21:53', '2025-04-27 10:49:27'),
(87, '8oz.', '8oz', NULL, NULL, NULL, NULL, 1, 'solo', 0.00, '2025-04-26 19:21:54', '2025-04-27 10:49:27'),
(88, '$lux', 'lux', NULL, NULL, NULL, NULL, 0, 'solo', 0.00, '2025-04-26 19:21:54', '2025-04-27 10:49:27'),
(89, 'Haunted House', 'haunted-house', NULL, NULL, NULL, NULL, 1, 'solo', 0.00, '2025-04-26 19:21:58', '2025-04-27 10:49:27'),
(90, 'Saliva Grey', 'saliva-grey', NULL, NULL, NULL, NULL, 1, 'solo', 0.00, '2025-04-26 19:21:58', '2025-04-27 10:49:27'),
(91, '99zed', '99zed', NULL, NULL, NULL, NULL, 1, 'solo', 0.00, '2025-04-26 19:21:58', '2025-04-27 10:49:27'),
(92, 'TWENTYTHREE', 'twentythree', NULL, NULL, NULL, NULL, 1, 'solo', 0.00, '2025-04-26 19:21:58', '2025-04-27 10:49:27'),
(93, 'Istasha', 'istasha', NULL, NULL, NULL, NULL, 1, 'solo', 0.00, '2025-04-26 19:22:02', '2025-04-27 10:49:27'),
(94, 'outsiderX', 'outsiderx', NULL, NULL, NULL, NULL, 1, 'solo', 0.00, '2025-04-26 19:22:06', '2025-04-27 10:49:27'),
(95, 'Biv', 'biv', NULL, NULL, NULL, NULL, 1, 'solo', 0.00, '2025-04-26 19:22:07', '2025-04-27 10:49:27'),
(96, 'Whxami', 'whxami', NULL, NULL, NULL, NULL, 1, 'solo', 0.00, '2025-04-26 19:22:09', '2025-04-27 10:49:27'),
(97, 'Oxxxymiron', 'oxxxymiron', NULL, NULL, NULL, NULL, 1, 'solo', 0.00, '2025-04-26 19:22:10', '2025-04-27 10:49:27'),
(98, 'ПЕРЕУЧЕТ', 'переучет', NULL, NULL, NULL, NULL, 1, 'solo', 0.00, '2025-04-26 19:22:12', '2025-04-27 10:49:27'),
(99, 'domiNo', 'domino', NULL, NULL, NULL, NULL, 1, 'solo', 0.00, '2025-04-26 19:22:17', '2025-04-27 10:49:27'),
(100, 'ooes', 'ooes', NULL, NULL, NULL, NULL, 1, 'solo', 0.00, '2025-04-26 19:22:17', '2025-04-27 10:49:27'),
(101, 'Брутто', 'брутто', NULL, NULL, NULL, NULL, 1, 'solo', 0.00, '2025-04-26 19:22:19', '2025-04-27 10:49:27'),
(102, '1.Kla$', '1kla', NULL, NULL, NULL, NULL, 1, 'solo', 0.00, '2025-04-26 19:22:20', '2025-04-27 10:49:27'),
(103, 'EIGHTEEN', 'eighteen', NULL, NULL, NULL, NULL, 1, 'solo', 0.00, '2025-04-26 19:22:24', '2025-04-27 10:49:27'),
(104, 'Самариддин Раджабов', 'самариддин-раджабов', NULL, NULL, NULL, NULL, 1, 'solo', 0.00, '2025-04-26 19:22:32', '2025-04-27 10:49:27'),
(105, 'LSP', 'lsp', NULL, NULL, NULL, NULL, 1, 'solo', 0.00, '2025-04-26 19:22:36', '2025-04-27 10:49:27'),
(106, 'PORCHY', 'porchy', NULL, NULL, NULL, NULL, 1, 'solo', 0.00, '2025-04-26 19:22:37', '2025-04-27 10:49:27'),
(107, 'Schokk', 'schokk', NULL, NULL, NULL, NULL, 1, 'solo', 0.00, '2025-04-26 19:22:38', '2025-04-27 10:49:27'),
(108, 'Santo', 'santo', NULL, NULL, NULL, NULL, 1, 'solo', 0.00, '2025-04-26 19:22:38', '2025-04-27 10:49:27'),
(109, 'Automatikk', 'automatikk', NULL, NULL, NULL, NULL, 1, 'solo', 0.00, '2025-04-26 19:22:38', '2025-04-27 10:49:27'),
(110, 'Architects', 'architects', 'Architects is a mathcore/metalcore/alternative metal band from Brighton, East Sussex, United Kingdom, formed in 2004 by twin brothers Dan and Tom Searle. As drummer and guitarist, respectively, they were joined by guitarist Tim Hillier-Brook, bassist Tim Lucas, and vocalist Matt Johnson. Strongly influenced by the Dillinger Escape Plan, their initial sound was coarse, chaotic, and rhythmically complex. Lucas was soon replaced by Alex Dean while Johnson left after the release of their debut album Nightmares (2006). He was replaced by Sam Carter, who quickly debuted on the band\'s second album Ruin (2007). After releasing a split EP with Dead Swans in 2008, they signed to Century Media Records and released their third album Hollow Crown through the label in 2009. In 2011, it was followed by The Here and Now. The next year, Architects returned towards their original style with Daybreaker, establishing a balance of melody and technical harshness. They also introduced more politicized lyrics, contrasting to the violent and even comedic lyrics of their older work. By the time of the album\'s release, Hillier-Brook left the band, later replaced by Adam Christianson.\r\n\r\nIn 2013, Architects parted with Century Media, self-releasing the documentary One Hundred Days: The Story of Architects Almost World Tour and joining Epitaph Records. They released their sixth album Lost Forever // Lost Together through the label in 2014, achieving widespread critical acclaim which has lasted since. Soon after the release of their follow-up All Our Gods Have Abandoned Us in 2016, principal guitarist and songwriter Tom Searle died after three years of living with skin cancer. In September 2017, the band released the single \"Doomsday\"—the last song that he was working on before his death—and announced Josh Middleton of Sylosis as their new lead guitarist. The single is included on their new album Holy Hell, which was released in November 2018 and is their first written without Searle.\r\n\r\nAll members of the band are vegan, having turned to veganism after watching several documentaries on the subject. They also promote the Sea Shepherd Conservation Society, with Carter being one of its British ambassadors.', 'Architects  ir mathcore/metalcore/alternative metal band no Braitonas, East Sussex, Apvienotajā Karalistē, ko 2004. gadā izveidoja dvīņu brāļi Dan un Tom Searle. Kā bundzinieks un ģitārists viņiem pievienojās ģitārists Tims Hiljē-Brūks, basists Tims Lūkass un vokālists Mets Džonsons. Viņu sākotnējā skaņa bija rupja, haotiska un ritmiski sarežģīta. Drīz vien Lukasu aizstāja Alekss Dīns, bet Džonsons aizgāja pēc viņu debijas albuma Nightmares (2006) izdošanas. Viņu aizstāja Sems Kārters, kurš ātri debitēja grupas otrajā albumā Ruin (2007). Pēc dalītā EP izdošanas ar Dead Swans 2008. gadā viņi parakstīja dziesmu Century Media Records un 2009. gadā izdeva savu trešo albumu Hollow Crown. 2011. gadā tam sekoja “Here and Now”. Nākamajā gadā Architects atgriezās savā sākotnējā stilā ar dienas slēdzi, izveidojot melodijas un tehniskās skarbuma līdzsvaru. Viņi ieviesa arī politizētākus dziesmu tekstus, kas kontrastēja ar viņu vecākā darba vardarbīgajiem un pat komēdijas dziesmu tekstiem. Albuma izdošanas laikā Hiljē-Brūks atstāja grupu, vēlāk to aizstāja Ādams Kristiansons.\r\n\r\n2013. gadā Architects šķīrās no Century Media, pašpublicējot dokumentālo filmu One Hundred Days: The Story of Architects Almost World Tour un pievienošanos epitapa ierakstiem. 2014. gadā viņi izdeva savu sesto albumu Lost Forever// Lost together, iegūstot plašu kritisku atzinību, kas ilgst kopš tā laika. Drīz pēc tam, kad tika izlaists viņu sekojums Visi mūsu dievi mūs pameta 2016. gadā, galvenais ģitārists un dziesmu autors Toms Seārls nomira pēc trīs gadu ilgas dzīves ar ādas vēzi. 2017. gada septembrī grupa izdeva singlu “Doomsday”, pēdējo dziesmu, pie kuras viņš strādāja pirms savas nāves, un paziņoja, ka Džošs Midltons no Sylosis ir viņu jaunais vadošais ģitārists. Singls ir iekļauts viņu jaunajā albumā Holy Hell, kas tika izdots 2018. gada novembrī un ir viņu pirmais scenārijs bez Searle.\r\n\r\nVisi grupas dalībnieki ir vegāni, kas pievērsušies vegānismam pēc vairāku dokumentālo filmu skatīšanās par šo tēmu. Viņi arī popularizē Jūras aitu aizsardzības biedrību, un Kārters ir viens no tās Lielbritānijas vēstniekiem.', 2004, NULL, 1, 'band', 0.00, '2025-05-24 13:55:26', '2025-05-24 13:55:26'),
(111, 'Polaris', 'polaris', NULL, NULL, 2012, NULL, 1, 'band', 0.00, '2025-05-24 13:57:13', '2025-05-24 13:57:13'),
(112, 'Wage War', 'wage-war', NULL, NULL, 2010, NULL, 1, 'band', 0.00, '2025-05-24 13:58:10', '2025-05-24 13:58:10'),
(113, 'Twenty One Pilots', 'twenty-one-pilots', 'Twenty One Pilots (stylized in all lowercase or as twenty øne piløts) is an American musical duo from Columbus, Ohio. Initially a band, the group was formed in 2009 by lead vocalist Tyler Joseph along with Nick Thomas and Chris Salih, who both left in 2011. Since their departure, the line-up has consisted of Joseph and drummer Josh Dun. The duo is best known for their singles \"Stressed Out\", \"Ride\", and \"Heathens\". The group received a Grammy Award for Best Pop Duo/Group Performance at the 59th Annual Grammy Awards for \"Stressed Out\". The band independently released two albums, Twenty One Pilots (2009) and Regional at Best (2011), before being signed by record label Fueled by Ramen in 2012. Their label debut, Vessel, was released in 2013 and became the second album in history on which every track received at least a gold certification, making Twenty One Pilots the first band in the history of music to see every song on two albums earn gold or platinum awards.\r\n\r\nThe duo achieved breakthrough success with their fourth album, Blurryface (2015), which produced the successful singles \"Stressed Out\" and \"Ride\" and became the first album on which every track received at least a gold certification from the Recording Industry Association of America. The release of the single \"Heathens\" also made the group the first alternative artist in history to have two concurrent top five singles in the Billboard Hot 100 and the third rock act in history to have two singles simultaneously chart in the top five of the Billboard Hot 100, joining the Beatles and Elvis Presley.\r\n\r\nThe duo has released seven studio albums in total, with the latest being Clancy, released on May 24, 2024. They have also garnered ten No. 1 songs on the Alternative Songs chart, making them the artist with the fourth-most number-one songs on the chart, just below Linkin Park.\r\n\r\nTheir eighth full-length studio album, Breach, was just announced to be released in September, 2025 with its first song, The Contract, releasing on June 12th, 2025.\r\n\r\nStudio albums\r\nTwenty One Pilots (2009)\r\nRegional at Best (2011)\r\nVessel (2013)\r\nBlurryface (2015)\r\nTrench (2018)\r\nScaled and Icy (2021)\r\nClancy (2024)', NULL, 2009, NULL, 1, 'band', 0.00, '2025-05-29 06:10:09', '2025-05-29 06:10:09'),
(114, 'Arcane', 'arcane', NULL, NULL, NULL, NULL, 1, 'solo', 0.00, '2025-05-29 06:10:25', '2025-05-29 06:10:25'),
(115, 'League of Legends', 'league-of-legends', NULL, NULL, NULL, NULL, 1, 'solo', 0.00, '2025-05-29 06:10:25', '2025-05-29 06:10:25'),
(116, 'Mutemath', 'mutemath', NULL, NULL, NULL, NULL, 1, 'solo', 0.00, '2025-05-29 06:10:43', '2025-05-29 06:10:43'),
(117, '...And You Will Know Us by the Trail of Dead', '---and-you-will-know-us-by-the-trail-of-dead', 'test', 'test', 2004, NULL, 1, 'band', 0.00, '2025-12-07 16:05:30', '2025-12-07 16:05:30'),
(119, 'test artist', 'test-artist', NULL, NULL, NULL, NULL, 1, 'solo', 0.00, '2026-02-28 17:11:39', '2026-02-28 17:11:39');

-- --------------------------------------------------------

--
-- Table structure for table `artists_genres`
--

CREATE TABLE `artists_genres` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `artist_id` bigint(20) UNSIGNED NOT NULL,
  `genre_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `artists_genres`
--

INSERT INTO `artists_genres` (`id`, `artist_id`, `genre_id`, `created_at`, `updated_at`) VALUES
(1, 1, 1, '2025-04-22 13:30:06', '2025-04-22 13:30:06'),
(2, 1, 2, '2025-04-22 13:30:06', '2025-04-22 13:30:06'),
(3, 1, 3, '2025-04-22 13:30:07', '2025-04-22 13:30:07'),
(4, 1, 4, '2025-04-22 13:30:07', '2025-04-22 13:30:07'),
(5, 1, 5, '2025-04-22 13:30:07', '2025-04-22 13:30:07'),
(6, 1, 7, '2025-05-05 08:38:01', '2025-05-05 08:38:01'),
(7, 1, 28, '2025-05-28 11:23:21', '2025-05-28 11:23:21'),
(8, 3, 2, '2025-05-24 13:53:13', '2025-05-24 13:53:13'),
(9, 8, 21, '2025-05-28 11:21:54', '2025-05-28 11:21:54'),
(10, 70, 2, '2025-05-24 13:53:37', '2025-05-24 13:53:37'),
(11, 110, 2, '2025-05-24 13:53:37', '2025-05-24 13:53:37'),
(12, 111, 2, '2025-05-24 13:57:45', '2025-05-24 13:57:45'),
(13, 112, 2, '2025-05-24 13:58:34', '2025-05-24 13:58:34');

-- --------------------------------------------------------

--
-- Table structure for table `artists_releases`
--

CREATE TABLE `artists_releases` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `artist_id` bigint(20) UNSIGNED NOT NULL,
  `release_id` bigint(20) UNSIGNED NOT NULL,
  `role` enum('primary','featured','producer') NOT NULL DEFAULT 'primary',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `artists_releases`
--

INSERT INTO `artists_releases` (`id`, `artist_id`, `release_id`, `role`, `created_at`, `updated_at`) VALUES
(1, 1, 1, 'primary', '2025-04-22 13:29:04', '2025-04-22 13:29:04'),
(2, 1, 2, 'primary', '2025-04-22 13:29:05', '2025-04-22 13:29:05'),
(3, 1, 3, 'primary', '2025-04-22 13:29:06', '2025-04-22 13:29:06'),
(4, 1, 4, 'primary', '2025-04-22 13:29:07', '2025-04-22 13:29:07'),
(5, 1, 5, 'primary', '2025-04-22 13:29:08', '2025-04-22 13:29:08'),
(6, 1, 6, 'primary', '2025-04-22 13:29:09', '2025-04-22 13:29:09'),
(7, 1, 7, 'primary', '2025-04-22 13:29:10', '2025-04-22 13:29:10'),
(8, 1, 8, 'primary', '2025-04-22 13:29:11', '2025-04-22 13:29:11'),
(9, 1, 9, 'primary', '2025-04-22 13:29:12', '2025-04-22 13:29:12'),
(10, 1, 10, 'primary', '2025-04-22 13:29:13', '2025-04-22 13:29:13'),
(11, 1, 11, 'primary', '2025-04-22 13:29:14', '2025-04-22 13:29:14'),
(12, 1, 12, 'primary', '2025-04-22 13:29:14', '2025-04-22 13:29:33'),
(13, 1, 13, 'primary', '2025-04-22 13:29:15', '2025-04-22 13:29:15'),
(14, 1, 14, 'primary', '2025-04-22 13:29:16', '2025-04-22 13:29:16'),
(15, 1, 15, 'primary', '2025-04-22 13:29:17', '2025-04-22 13:29:17'),
(16, 1, 16, 'primary', '2025-04-22 13:29:17', '2025-04-22 13:29:17'),
(17, 1, 17, 'primary', '2025-04-22 13:29:18', '2025-04-22 13:29:18'),
(18, 1, 18, 'primary', '2025-04-22 13:29:19', '2025-04-22 13:29:19'),
(19, 1, 19, 'primary', '2025-04-22 13:29:19', '2025-04-22 13:29:19'),
(20, 1, 20, 'primary', '2025-04-22 13:29:20', '2025-04-22 13:29:20'),
(21, 1, 21, 'primary', '2025-04-22 13:29:21', '2025-04-22 13:29:21'),
(22, 1, 22, 'primary', '2025-04-22 13:29:22', '2025-04-22 13:29:22'),
(23, 1, 23, 'primary', '2025-04-22 13:29:22', '2025-04-22 13:29:22'),
(24, 1, 24, 'primary', '2025-04-22 13:29:23', '2025-04-22 13:29:23'),
(25, 1, 25, 'primary', '2025-04-22 13:29:24', '2025-04-22 13:29:24'),
(26, 1, 26, 'primary', '2025-04-22 13:29:25', '2025-04-22 13:29:25'),
(27, 1, 27, 'primary', '2025-04-22 13:29:25', '2025-04-22 13:29:25'),
(28, 1, 28, 'primary', '2025-04-22 13:29:26', '2025-04-22 13:29:26'),
(29, 1, 29, 'primary', '2025-04-22 13:29:27', '2025-04-22 13:29:27'),
(30, 1, 30, 'primary', '2025-04-22 13:29:27', '2025-04-22 13:29:27'),
(31, 1, 31, 'primary', '2025-04-22 13:29:28', '2025-04-22 13:29:28'),
(32, 1, 32, 'primary', '2025-04-22 13:29:29', '2025-04-22 13:29:29'),
(33, 1, 33, 'primary', '2025-04-22 13:29:30', '2025-04-22 13:29:30'),
(34, 1, 34, 'primary', '2025-04-22 13:29:30', '2025-04-22 13:29:30'),
(35, 1, 35, 'primary', '2025-04-22 13:29:31', '2025-04-22 13:29:31'),
(36, 1, 36, 'primary', '2025-04-22 13:29:32', '2025-04-22 13:29:32'),
(37, 1, 37, 'primary', '2025-04-22 13:29:32', '2025-04-22 13:29:32'),
(38, 1, 38, 'primary', '2025-04-22 13:29:34', '2025-04-22 13:29:34'),
(39, 1, 39, 'primary', '2025-04-22 13:29:35', '2025-04-22 13:29:35'),
(40, 1, 40, 'primary', '2025-04-22 13:29:35', '2025-04-22 13:29:35'),
(41, 1, 41, 'primary', '2025-04-22 13:29:36', '2025-04-22 13:29:36'),
(42, 1, 42, 'primary', '2025-04-22 13:29:37', '2025-04-22 13:29:37'),
(43, 1, 43, 'primary', '2025-04-22 13:29:37', '2025-04-22 13:29:37'),
(44, 1, 44, 'primary', '2025-04-22 13:29:38', '2025-04-22 13:29:38'),
(45, 1, 45, 'primary', '2025-04-22 13:29:39', '2025-04-22 13:29:39'),
(46, 1, 46, 'primary', '2025-04-22 13:29:39', '2025-04-22 13:29:39'),
(47, 1, 47, 'primary', '2025-04-22 13:29:40', '2025-04-22 13:29:40'),
(48, 1, 48, 'primary', '2025-04-22 13:29:41', '2025-04-22 13:29:41'),
(49, 1, 49, 'primary', '2025-04-22 13:29:42', '2025-04-22 13:29:42'),
(50, 4, 17, 'primary', '2025-04-22 13:29:18', '2025-04-22 13:29:18'),
(51, 4, 18, 'primary', '2025-04-22 13:29:19', '2025-04-22 13:29:19'),
(52, 5, 18, 'primary', '2025-04-22 13:29:19', '2025-04-22 13:29:19'),
(53, 7, 15, 'primary', '2025-04-22 13:29:17', '2025-04-22 13:29:17'),
(54, 7, 34, 'primary', '2025-04-22 13:29:30', '2025-04-22 13:29:30'),
(55, 36, 15, 'primary', '2025-04-22 13:29:17', '2025-04-22 13:29:17'),
(56, 36, 28, 'primary', '2025-04-22 13:29:26', '2025-04-22 13:29:26'),
(57, 36, 31, 'primary', '2025-04-22 13:29:28', '2025-04-22 13:29:28'),
(58, 37, 16, 'primary', '2025-04-22 13:29:17', '2025-04-22 13:29:17'),
(59, 38, 19, 'primary', '2025-04-22 13:29:19', '2025-04-22 13:29:19'),
(60, 39, 19, 'primary', '2025-04-22 13:29:19', '2025-04-22 13:29:19'),
(61, 40, 22, 'primary', '2025-04-22 13:29:22', '2025-04-22 13:29:22'),
(62, 40, 23, 'primary', '2025-04-22 13:29:22', '2025-04-22 13:29:22'),
(63, 41, 24, 'primary', '2025-04-22 13:29:23', '2025-04-22 13:29:23'),
(64, 42, 25, 'primary', '2025-04-22 13:29:24', '2025-04-22 13:29:24'),
(65, 43, 27, 'primary', '2025-04-22 13:29:25', '2025-04-22 13:29:25'),
(66, 44, 28, 'primary', '2025-04-22 13:29:26', '2025-04-22 13:29:26'),
(67, 45, 29, 'primary', '2025-04-22 13:29:27', '2025-04-22 13:29:27'),
(68, 46, 31, 'primary', '2025-04-22 13:29:28', '2025-04-22 13:29:28'),
(69, 47, 32, 'primary', '2025-04-22 13:29:29', '2025-04-22 13:29:29'),
(70, 48, 36, 'primary', '2025-04-22 13:29:32', '2025-04-22 13:29:32'),
(71, 49, 38, 'primary', '2025-04-22 13:29:34', '2025-04-22 13:29:34'),
(72, 61, 50, 'primary', '2025-04-27 01:21:34', '2025-04-27 01:21:46'),
(73, 61, 51, 'primary', '2025-04-27 01:21:35', '2025-04-27 01:21:35'),
(74, 61, 52, 'primary', '2025-04-27 01:21:36', '2025-04-27 01:21:36'),
(75, 61, 53, 'primary', '2025-04-27 01:21:37', '2025-04-27 01:21:37'),
(76, 61, 54, 'primary', '2025-04-27 01:21:38', '2025-04-27 01:21:38'),
(77, 61, 55, 'primary', '2025-04-27 01:21:38', '2025-04-27 01:21:38'),
(78, 61, 56, 'primary', '2025-04-27 01:21:39', '2025-04-27 01:21:39'),
(79, 61, 57, 'primary', '2025-04-27 01:21:40', '2025-04-27 01:21:40'),
(80, 61, 58, 'primary', '2025-04-27 01:21:41', '2025-04-27 01:21:41'),
(81, 61, 59, 'primary', '2025-04-27 01:21:41', '2025-04-27 01:21:47'),
(82, 61, 60, 'primary', '2025-04-27 01:21:42', '2025-04-27 01:21:42'),
(83, 61, 61, 'primary', '2025-04-27 01:21:44', '2025-04-27 01:21:44'),
(84, 61, 62, 'primary', '2025-04-27 01:21:44', '2025-04-27 01:21:44'),
(85, 61, 63, 'primary', '2025-04-27 01:21:45', '2025-04-27 01:21:45'),
(86, 61, 64, 'primary', '2025-04-27 01:21:47', '2025-04-27 01:21:47'),
(87, 67, 53, 'primary', '2025-04-27 01:21:37', '2025-04-27 01:21:37'),
(88, 68, 53, 'primary', '2025-04-27 01:21:37', '2025-04-27 01:21:37'),
(89, 68, 54, 'primary', '2025-04-27 01:21:38', '2025-04-27 01:21:38'),
(90, 69, 55, 'primary', '2025-04-27 01:21:38', '2025-04-27 01:21:38'),
(91, 70, 55, 'primary', '2025-04-27 01:21:38', '2025-04-27 01:21:38'),
(92, 70, 60, 'primary', '2025-04-27 01:21:42', '2025-04-27 01:21:42'),
(93, 74, 65, 'primary', '2025-04-27 01:21:50', '2025-04-27 01:21:50'),
(94, 74, 66, 'primary', '2025-04-27 01:21:51', '2025-04-27 01:21:51'),
(95, 74, 67, 'primary', '2025-04-27 01:21:52', '2025-04-27 01:21:52'),
(96, 74, 68, 'primary', '2025-04-27 01:21:53', '2025-04-27 01:21:53'),
(97, 74, 69, 'primary', '2025-04-27 01:21:54', '2025-04-27 01:21:54'),
(98, 74, 70, 'primary', '2025-04-27 01:21:55', '2025-04-27 01:21:55'),
(99, 74, 71, 'primary', '2025-04-27 01:21:55', '2025-04-27 01:21:55'),
(100, 74, 72, 'primary', '2025-04-27 01:21:56', '2025-04-27 01:21:56'),
(101, 74, 73, 'primary', '2025-04-27 01:21:57', '2025-04-27 01:21:57'),
(102, 74, 74, 'primary', '2025-04-27 01:21:58', '2025-04-27 01:21:58'),
(103, 74, 75, 'primary', '2025-04-27 01:21:58', '2025-04-27 01:21:58'),
(104, 74, 76, 'primary', '2025-04-27 01:21:59', '2025-04-27 01:21:59'),
(105, 74, 77, 'primary', '2025-04-27 01:22:00', '2025-04-27 01:22:00'),
(106, 74, 78, 'primary', '2025-04-27 01:22:00', '2025-04-27 01:22:00'),
(107, 74, 79, 'primary', '2025-04-27 01:22:01', '2025-04-27 01:22:01'),
(108, 74, 80, 'primary', '2025-04-27 01:22:02', '2025-04-27 01:22:02'),
(109, 74, 81, 'primary', '2025-04-27 01:22:03', '2025-04-27 01:22:03'),
(110, 74, 82, 'primary', '2025-04-27 01:22:03', '2025-04-27 01:22:03'),
(111, 74, 83, 'primary', '2025-04-27 01:22:04', '2025-04-27 01:22:04'),
(112, 74, 84, 'primary', '2025-04-27 01:22:05', '2025-04-27 01:22:05'),
(113, 74, 85, 'primary', '2025-04-27 01:22:06', '2025-04-27 01:22:06'),
(114, 74, 86, 'primary', '2025-04-27 01:22:06', '2025-04-27 01:22:06'),
(115, 74, 87, 'primary', '2025-04-27 01:22:07', '2025-04-27 01:22:07'),
(116, 74, 88, 'primary', '2025-04-27 01:22:08', '2025-04-27 01:22:08'),
(117, 74, 89, 'primary', '2025-04-27 01:22:09', '2025-04-27 01:22:09'),
(118, 74, 90, 'primary', '2025-04-27 01:22:09', '2025-04-27 01:22:09'),
(119, 75, 65, 'primary', '2025-04-27 01:21:50', '2025-04-27 01:21:50'),
(120, 75, 70, 'primary', '2025-04-27 01:21:55', '2025-04-27 01:21:55'),
(121, 75, 71, 'primary', '2025-04-27 01:21:55', '2025-04-27 01:21:55'),
(122, 75, 72, 'primary', '2025-04-27 01:21:56', '2025-04-27 01:21:56'),
(123, 76, 66, 'primary', '2025-04-27 01:21:51', '2025-04-27 01:21:51'),
(124, 76, 74, 'primary', '2025-04-27 01:21:58', '2025-04-27 01:21:58'),
(125, 76, 76, 'primary', '2025-04-27 01:21:59', '2025-04-27 01:21:59'),
(126, 76, 77, 'primary', '2025-04-27 01:22:00', '2025-04-27 01:22:00'),
(127, 76, 78, 'primary', '2025-04-27 01:22:00', '2025-04-27 01:22:00'),
(128, 76, 79, 'primary', '2025-04-27 01:22:01', '2025-04-27 01:22:01'),
(129, 76, 81, 'primary', '2025-04-27 01:22:03', '2025-04-27 01:22:03'),
(130, 77, 86, 'primary', '2025-04-27 01:22:06', '2025-04-27 01:22:06'),
(131, 78, 79, 'primary', '2025-04-27 01:22:01', '2025-04-27 01:22:01'),
(132, 79, 77, 'primary', '2025-04-27 01:22:00', '2025-04-27 01:22:00'),
(133, 80, 78, 'primary', '2025-04-27 01:22:00', '2025-04-27 01:22:00'),
(134, 81, 76, 'primary', '2025-04-27 01:21:59', '2025-04-27 01:21:59'),
(135, 81, 84, 'primary', '2025-04-27 01:22:05', '2025-04-27 01:22:05'),
(136, 89, 74, 'primary', '2025-04-27 01:21:58', '2025-04-27 01:21:58'),
(137, 93, 80, 'primary', '2025-04-27 01:22:02', '2025-04-27 01:22:02'),
(138, 94, 85, 'primary', '2025-04-27 01:22:06', '2025-04-27 01:22:06'),
(139, 95, 87, 'primary', '2025-04-27 01:22:07', '2025-04-27 01:22:07'),
(140, 96, 90, 'primary', '2025-04-27 01:22:09', '2025-04-27 01:22:09'),
(141, 97, 91, 'primary', '2025-04-27 01:22:12', '2025-04-27 01:22:12'),
(142, 97, 92, 'primary', '2025-04-27 01:22:12', '2025-04-27 01:22:12'),
(143, 97, 93, 'primary', '2025-04-27 01:22:13', '2025-04-27 01:22:13'),
(144, 97, 94, 'primary', '2025-04-27 01:22:14', '2025-04-27 01:22:14'),
(145, 97, 95, 'primary', '2025-04-27 01:22:15', '2025-04-27 01:22:15'),
(146, 97, 96, 'primary', '2025-04-27 01:22:17', '2025-04-27 01:22:17'),
(147, 97, 97, 'primary', '2025-04-27 01:22:17', '2025-04-27 01:22:17'),
(148, 97, 98, 'primary', '2025-04-27 01:22:18', '2025-04-27 01:22:18'),
(149, 97, 99, 'primary', '2025-04-27 01:22:19', '2025-04-27 01:22:19'),
(150, 97, 100, 'primary', '2025-04-27 01:22:20', '2025-04-27 01:22:20'),
(151, 97, 101, 'primary', '2025-04-27 01:22:21', '2025-04-27 01:22:21'),
(152, 97, 102, 'primary', '2025-04-27 01:22:21', '2025-04-27 01:22:21'),
(153, 97, 103, 'primary', '2025-04-27 01:22:22', '2025-04-27 01:22:22'),
(154, 97, 104, 'primary', '2025-04-27 01:22:23', '2025-04-27 01:22:23'),
(155, 97, 105, 'primary', '2025-04-27 01:22:24', '2025-04-27 01:22:24'),
(156, 97, 106, 'primary', '2025-04-27 01:22:24', '2025-04-27 01:22:24'),
(157, 97, 107, 'primary', '2025-04-27 01:22:25', '2025-04-27 01:22:25'),
(158, 97, 108, 'primary', '2025-04-27 01:22:26', '2025-04-27 01:22:26'),
(159, 97, 109, 'primary', '2025-04-27 01:22:26', '2025-04-27 01:22:26'),
(160, 97, 110, 'primary', '2025-04-27 01:22:27', '2025-04-27 01:22:27'),
(161, 97, 111, 'primary', '2025-04-27 01:22:28', '2025-04-27 01:22:28'),
(162, 97, 112, 'primary', '2025-04-27 01:22:29', '2025-04-27 01:22:29'),
(163, 97, 113, 'primary', '2025-04-27 01:22:29', '2025-04-27 01:22:29'),
(164, 97, 114, 'primary', '2025-04-27 01:22:30', '2025-04-27 01:22:30'),
(165, 97, 115, 'primary', '2025-04-27 01:22:31', '2025-04-27 01:22:31'),
(166, 97, 116, 'primary', '2025-04-27 01:22:32', '2025-04-27 01:22:32'),
(167, 97, 117, 'primary', '2025-04-27 01:22:32', '2025-04-27 01:22:32'),
(168, 97, 118, 'primary', '2025-04-27 01:22:33', '2025-04-27 01:22:33'),
(169, 97, 119, 'primary', '2025-04-27 01:22:34', '2025-04-27 01:22:34'),
(170, 97, 120, 'primary', '2025-04-27 01:22:35', '2025-04-27 01:22:35'),
(171, 97, 121, 'primary', '2025-04-27 01:22:35', '2025-04-27 01:22:35'),
(172, 97, 122, 'primary', '2025-04-27 01:22:36', '2025-04-27 01:22:36'),
(173, 97, 123, 'primary', '2025-04-27 01:22:37', '2025-04-27 01:22:37'),
(174, 97, 124, 'primary', '2025-04-27 01:22:38', '2025-04-27 01:22:38'),
(175, 97, 125, 'primary', '2025-04-27 01:22:38', '2025-04-27 01:22:38'),
(176, 98, 91, 'primary', '2025-04-27 01:22:12', '2025-04-27 01:22:12'),
(177, 100, 97, 'primary', '2025-04-27 01:22:17', '2025-04-27 01:22:17'),
(178, 101, 99, 'primary', '2025-04-27 01:22:19', '2025-04-27 01:22:19'),
(179, 102, 100, 'primary', '2025-04-27 01:22:20', '2025-04-27 01:22:20'),
(180, 103, 106, 'primary', '2025-04-27 01:22:24', '2025-04-27 01:22:24'),
(181, 105, 122, 'primary', '2025-04-27 01:22:36', '2025-04-27 01:22:36'),
(182, 106, 123, 'primary', '2025-04-27 01:22:37', '2025-04-27 01:22:37'),
(183, 107, 124, 'primary', '2025-04-27 01:22:38', '2025-04-27 01:22:38'),
(184, 107, 125, 'primary', '2025-04-27 01:22:38', '2025-04-27 01:22:38'),
(185, 113, 126, 'primary', '2025-05-29 06:10:12', '2025-05-29 06:10:12'),
(186, 113, 127, 'primary', '2025-05-29 06:10:13', '2025-05-29 06:10:13'),
(187, 113, 128, 'primary', '2025-05-29 06:10:13', '2025-05-29 06:10:13'),
(188, 113, 129, 'primary', '2025-05-29 06:10:14', '2025-05-29 06:10:14'),
(189, 113, 130, 'primary', '2025-05-29 06:10:15', '2025-05-29 06:10:15'),
(190, 113, 131, 'primary', '2025-05-29 06:10:16', '2025-05-29 06:10:16'),
(191, 113, 132, 'primary', '2025-05-29 06:10:22', '2025-05-29 06:10:22'),
(192, 113, 133, 'primary', '2025-05-29 06:10:23', '2025-05-29 06:10:23'),
(193, 113, 134, 'primary', '2025-05-29 06:10:24', '2025-05-29 06:10:24'),
(194, 113, 135, 'primary', '2025-05-29 06:10:25', '2025-05-29 06:10:25'),
(195, 113, 138, 'primary', '2025-05-29 06:10:32', '2025-05-29 06:10:32'),
(196, 113, 139, 'primary', '2025-05-29 06:10:33', '2025-05-29 06:10:33'),
(197, 113, 140, 'primary', '2025-05-29 06:10:33', '2025-05-29 06:10:33'),
(198, 113, 141, 'primary', '2025-05-29 06:10:34', '2025-05-29 06:10:34'),
(199, 113, 142, 'primary', '2025-05-29 06:10:35', '2025-05-29 06:10:35'),
(200, 113, 143, 'primary', '2025-05-29 06:10:36', '2025-05-29 06:10:36'),
(201, 113, 144, 'primary', '2025-05-29 06:10:37', '2025-05-29 06:10:37'),
(202, 113, 145, 'primary', '2025-05-29 06:10:38', '2025-05-29 06:10:38'),
(203, 113, 146, 'primary', '2025-05-29 06:10:41', '2025-05-29 06:10:41'),
(204, 113, 147, 'primary', '2025-05-29 06:10:42', '2025-05-29 06:10:42'),
(205, 113, 148, 'primary', '2025-05-29 06:10:43', '2025-05-29 06:10:43'),
(206, 113, 149, 'primary', '2025-05-29 06:10:44', '2025-05-29 06:10:44'),
(207, 113, 150, 'primary', '2025-05-29 06:10:46', '2025-05-29 06:10:46'),
(208, 113, 151, 'primary', '2025-05-29 06:10:50', '2025-05-29 06:10:50'),
(209, 113, 152, 'primary', '2025-05-29 06:10:52', '2025-05-29 06:10:52'),
(210, 113, 153, 'primary', '2025-05-29 06:10:53', '2025-05-29 06:10:53'),
(211, 113, 154, 'primary', '2025-05-29 06:10:54', '2025-05-29 06:10:54'),
(212, 113, 155, 'primary', '2025-05-29 06:10:56', '2025-05-29 06:10:56'),
(213, 113, 156, 'primary', '2025-05-29 06:10:58', '2025-05-29 06:10:58'),
(214, 114, 135, 'primary', '2025-05-29 06:10:25', '2025-05-29 06:10:25'),
(215, 115, 135, 'primary', '2025-05-29 06:10:25', '2025-05-29 06:10:25'),
(217, 1, 158, 'primary', '2026-04-07 18:13:09', '2026-04-07 18:13:09'),
(218, 2, 158, 'primary', '2026-04-07 18:13:09', '2026-04-07 18:13:09'),
(219, 3, 158, 'primary', '2026-04-07 18:13:09', '2026-04-07 18:13:09'),
(220, 4, 158, 'primary', '2026-04-07 18:13:09', '2026-04-07 18:13:09'),
(221, 5, 158, 'primary', '2026-04-07 18:13:09', '2026-04-07 18:13:09'),
(222, 6, 158, 'primary', '2026-04-07 18:13:09', '2026-04-07 18:13:09'),
(223, 7, 158, 'primary', '2026-04-07 18:13:09', '2026-04-07 18:13:09'),
(224, 8, 158, 'primary', '2026-04-07 18:13:09', '2026-04-07 18:13:09');

-- --------------------------------------------------------

--
-- Table structure for table `artists_tracks`
--

CREATE TABLE `artists_tracks` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `artist_id` bigint(20) UNSIGNED NOT NULL,
  `track_id` bigint(20) UNSIGNED NOT NULL,
  `role` enum('primary','featured','producer') NOT NULL DEFAULT 'primary',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `artists_tracks`
--

INSERT INTO `artists_tracks` (`id`, `artist_id`, `track_id`, `role`, `created_at`, `updated_at`) VALUES
(1, 1, 1, 'primary', '2025-04-22 10:29:04', '2025-04-22 10:29:04'),
(2, 1, 2, 'primary', '2025-04-22 10:29:04', '2025-04-22 10:29:04'),
(3, 1, 3, 'primary', '2025-04-22 10:29:04', '2025-04-22 10:29:15'),
(4, 1, 4, 'primary', '2025-04-22 10:29:04', '2025-04-22 10:29:04'),
(5, 1, 5, 'primary', '2025-04-22 10:29:04', '2025-04-22 10:29:04'),
(6, 1, 6, 'primary', '2025-04-26 22:22:16', '2025-04-26 22:22:16'),
(7, 1, 7, 'primary', '2025-04-22 10:29:04', '2025-04-22 10:29:04'),
(8, 1, 8, 'primary', '2025-04-22 10:29:04', '2025-04-22 10:29:04'),
(9, 1, 9, 'primary', '2025-04-22 10:29:04', '2025-04-22 10:29:04'),
(10, 1, 10, 'primary', '2025-04-22 10:29:04', '2025-04-22 10:29:20'),
(11, 1, 11, 'primary', '2025-04-22 10:29:05', '2025-04-22 10:29:21'),
(12, 1, 12, 'primary', '2025-04-22 10:29:05', '2025-04-22 10:29:05'),
(13, 1, 13, 'primary', '2025-04-22 10:29:05', '2025-04-22 10:29:19'),
(14, 1, 14, 'primary', '2025-04-22 10:29:05', '2025-04-22 10:29:05'),
(15, 1, 15, 'primary', '2025-04-22 10:29:05', '2025-04-22 10:29:27'),
(16, 1, 16, 'primary', '2025-04-22 10:29:05', '2025-04-22 10:29:05'),
(17, 1, 17, 'primary', '2025-04-22 10:29:05', '2025-04-22 10:29:05'),
(18, 1, 18, 'primary', '2025-04-22 10:29:05', '2025-04-22 10:29:31'),
(19, 1, 19, 'primary', '2025-04-22 10:29:05', '2025-04-22 10:29:30'),
(20, 1, 20, 'primary', '2025-04-22 10:29:05', '2025-04-22 10:29:30'),
(21, 1, 21, 'primary', '2025-04-22 10:29:05', '2025-04-22 10:29:05'),
(22, 1, 22, 'primary', '2025-04-22 10:29:05', '2025-04-22 10:29:05'),
(23, 1, 23, 'primary', '2025-04-22 10:29:05', '2025-04-22 10:29:05'),
(24, 1, 24, 'primary', '2025-04-22 10:29:05', '2025-04-22 10:29:32'),
(25, 1, 25, 'primary', '2025-04-22 10:29:05', '2025-04-22 10:29:05'),
(26, 1, 26, 'primary', '2025-04-22 10:29:06', '2025-04-22 10:29:06'),
(27, 1, 27, 'primary', '2025-04-22 10:29:06', '2025-04-22 10:29:06'),
(28, 1, 28, 'primary', '2025-04-22 10:29:06', '2025-04-22 10:29:06'),
(29, 1, 29, 'primary', '2025-04-22 10:29:06', '2025-04-22 10:29:06'),
(30, 1, 30, 'primary', '2025-04-22 10:29:06', '2025-04-22 10:29:06'),
(31, 1, 31, 'primary', '2025-04-22 10:29:06', '2025-04-22 10:29:06'),
(32, 1, 32, 'primary', '2025-04-22 10:29:06', '2025-04-22 10:29:06'),
(33, 1, 33, 'primary', '2025-04-22 10:29:06', '2025-04-22 10:29:06'),
(34, 1, 34, 'primary', '2025-04-22 10:29:06', '2025-04-22 10:29:06'),
(35, 1, 35, 'primary', '2025-04-22 10:29:06', '2025-04-22 10:29:06'),
(36, 1, 36, 'primary', '2025-04-22 10:29:06', '2025-04-22 10:29:06'),
(37, 1, 37, 'primary', '2025-04-22 10:29:06', '2025-04-22 10:29:06'),
(38, 1, 38, 'primary', '2025-04-22 10:29:06', '2025-04-22 10:29:06'),
(39, 1, 39, 'primary', '2025-04-22 10:29:06', '2025-04-22 10:29:06'),
(40, 1, 40, 'primary', '2025-04-22 10:29:06', '2025-04-22 10:29:06'),
(41, 1, 41, 'primary', '2025-04-22 10:29:06', '2025-04-22 10:29:06'),
(42, 1, 42, 'primary', '2025-04-22 10:29:07', '2025-04-22 10:29:07'),
(43, 1, 43, 'primary', '2025-04-22 10:29:07', '2025-04-22 10:29:07'),
(44, 1, 44, 'primary', '2025-04-22 10:29:07', '2025-04-22 10:29:07'),
(45, 1, 45, 'primary', '2025-04-22 10:29:07', '2025-04-22 10:29:07'),
(46, 1, 46, 'primary', '2025-04-22 10:29:07', '2025-04-22 10:29:07'),
(47, 1, 47, 'primary', '2025-04-22 10:29:07', '2025-04-22 10:29:07'),
(48, 1, 48, 'primary', '2025-04-22 10:29:07', '2025-04-22 10:29:07'),
(49, 1, 49, 'primary', '2025-04-22 10:29:07', '2025-04-22 10:29:07'),
(50, 1, 50, 'primary', '2025-04-22 10:29:08', '2025-04-22 10:29:08'),
(51, 1, 51, 'primary', '2025-04-22 10:29:08', '2025-04-22 10:29:37'),
(52, 1, 52, 'primary', '2025-04-22 10:29:08', '2025-04-22 10:29:35'),
(53, 1, 53, 'primary', '2025-04-22 10:29:08', '2025-04-22 10:29:08'),
(54, 1, 54, 'primary', '2025-04-22 10:29:08', '2025-04-22 10:29:37'),
(55, 1, 55, 'primary', '2025-04-22 10:29:08', '2025-04-22 10:29:08'),
(56, 1, 56, 'primary', '2025-04-22 10:29:08', '2025-04-22 10:29:36'),
(57, 1, 57, 'primary', '2025-04-22 10:29:08', '2025-04-22 10:29:08'),
(58, 1, 58, 'primary', '2025-04-22 10:29:08', '2025-04-22 10:29:08'),
(59, 1, 59, 'primary', '2025-04-22 10:29:08', '2025-04-22 10:29:08'),
(60, 1, 60, 'primary', '2025-04-22 10:29:08', '2025-04-22 10:29:35'),
(61, 1, 61, 'primary', '2025-04-22 10:29:08', '2025-04-22 10:29:08'),
(62, 1, 62, 'primary', '2025-04-22 10:29:08', '2025-04-22 10:29:08'),
(63, 1, 63, 'primary', '2025-04-22 10:29:09', '2025-04-22 10:29:09'),
(64, 1, 64, 'primary', '2025-04-22 10:29:09', '2025-04-22 10:29:09'),
(65, 1, 65, 'primary', '2025-04-22 10:29:09', '2025-04-22 10:29:09'),
(66, 1, 66, 'primary', '2025-04-22 10:29:09', '2025-04-22 10:29:09'),
(67, 1, 67, 'primary', '2025-04-22 10:29:09', '2025-04-22 10:29:09'),
(68, 1, 68, 'primary', '2025-04-22 10:29:09', '2025-04-22 10:29:09'),
(69, 1, 69, 'primary', '2025-04-22 10:29:09', '2025-04-22 10:29:09'),
(70, 1, 70, 'primary', '2025-04-22 10:29:09', '2025-04-22 10:29:09'),
(71, 1, 71, 'primary', '2025-04-22 10:29:09', '2025-04-22 10:29:09'),
(72, 1, 72, 'primary', '2025-04-22 10:29:09', '2025-04-22 10:29:09'),
(73, 1, 73, 'primary', '2025-04-22 10:29:09', '2025-04-22 10:29:09'),
(74, 1, 74, 'primary', '2025-04-22 10:29:10', '2025-04-22 10:29:42'),
(75, 1, 75, 'primary', '2025-04-22 10:29:10', '2025-04-22 10:29:10'),
(76, 1, 76, 'primary', '2025-04-22 10:29:10', '2025-04-22 10:29:10'),
(77, 1, 77, 'primary', '2025-04-22 10:29:10', '2025-04-22 10:29:42'),
(78, 1, 78, 'primary', '2025-04-22 10:29:10', '2025-04-22 10:29:42'),
(79, 1, 79, 'primary', '2025-04-22 10:29:10', '2025-04-22 10:29:42'),
(80, 1, 80, 'primary', '2025-04-22 10:29:10', '2025-04-22 10:29:10'),
(81, 1, 81, 'primary', '2025-04-22 10:29:10', '2025-04-22 10:29:10'),
(82, 1, 82, 'primary', '2025-04-22 10:29:10', '2025-04-22 10:29:42'),
(83, 1, 83, 'primary', '2025-04-22 10:29:10', '2025-04-22 10:29:10'),
(84, 1, 84, 'primary', '2025-04-22 10:29:10', '2025-04-22 10:29:10'),
(85, 1, 85, 'primary', '2025-04-22 10:29:10', '2025-04-22 10:29:10'),
(86, 1, 86, 'primary', '2025-04-22 10:29:10', '2025-04-22 10:29:10'),
(87, 1, 87, 'primary', '2025-04-22 10:29:11', '2025-04-22 10:29:11'),
(88, 1, 88, 'primary', '2025-04-22 10:29:11', '2025-04-22 10:29:11'),
(89, 1, 89, 'primary', '2025-04-22 10:29:11', '2025-04-22 10:29:42'),
(90, 1, 90, 'primary', '2025-04-22 10:29:11', '2025-04-22 10:29:11'),
(91, 1, 91, 'primary', '2025-04-22 10:29:11', '2025-04-22 10:29:11'),
(92, 1, 92, 'primary', '2025-04-22 10:29:11', '2025-04-22 10:29:11'),
(93, 1, 93, 'primary', '2025-04-22 10:29:11', '2025-04-22 10:29:11'),
(94, 1, 94, 'primary', '2025-04-22 10:29:11', '2025-04-22 10:29:11'),
(95, 1, 95, 'primary', '2025-04-22 10:29:11', '2025-04-22 10:29:11'),
(96, 1, 96, 'primary', '2025-04-22 10:29:11', '2025-04-22 10:29:11'),
(97, 1, 97, 'primary', '2025-04-22 10:29:11', '2025-04-22 10:29:42'),
(98, 1, 98, 'primary', '2025-04-22 10:29:11', '2025-04-22 10:29:11'),
(99, 1, 99, 'primary', '2025-04-22 10:29:11', '2025-04-22 10:29:11'),
(100, 1, 100, 'primary', '2025-04-22 10:29:12', '2025-04-22 10:29:42'),
(101, 1, 101, 'primary', '2025-04-22 10:29:12', '2025-04-22 10:29:42'),
(102, 1, 102, 'primary', '2025-04-22 10:29:12', '2025-04-22 10:29:13'),
(103, 1, 103, 'primary', '2025-04-22 10:29:12', '2025-04-22 10:29:13'),
(104, 1, 104, 'primary', '2025-04-22 10:29:12', '2025-04-22 10:29:13'),
(105, 1, 105, 'primary', '2025-04-22 10:29:12', '2025-04-22 10:29:13'),
(106, 1, 106, 'primary', '2025-04-22 10:29:12', '2025-04-22 10:29:42'),
(107, 1, 107, 'primary', '2025-04-22 10:29:12', '2025-04-22 10:29:13'),
(108, 1, 108, 'primary', '2025-04-22 10:29:12', '2025-04-22 10:29:13'),
(109, 1, 109, 'primary', '2025-04-22 10:29:12', '2025-04-22 10:29:13'),
(110, 1, 110, 'primary', '2025-04-22 10:29:12', '2025-04-22 10:29:12'),
(111, 1, 111, 'primary', '2025-04-22 10:29:12', '2025-04-22 10:29:12'),
(112, 1, 112, 'primary', '2025-04-22 10:29:12', '2025-04-22 10:29:12'),
(113, 1, 113, 'primary', '2025-04-22 10:29:12', '2025-04-22 10:29:12'),
(114, 1, 114, 'primary', '2025-04-22 10:29:12', '2025-04-22 10:29:12'),
(115, 1, 115, 'primary', '2025-04-22 10:29:12', '2025-04-22 10:29:12'),
(116, 1, 116, 'primary', '2025-04-22 10:29:12', '2025-04-22 10:29:12'),
(117, 1, 117, 'primary', '2025-04-22 10:29:12', '2025-04-22 10:29:12'),
(118, 1, 118, 'primary', '2025-04-22 10:29:12', '2025-04-22 10:29:12'),
(119, 1, 119, 'primary', '2025-04-22 10:29:12', '2025-04-22 10:29:12'),
(120, 1, 120, 'primary', '2025-04-22 10:29:14', '2025-04-22 10:29:42'),
(121, 1, 121, 'primary', '2025-04-22 10:29:14', '2025-04-22 10:29:14'),
(122, 1, 122, 'primary', '2025-04-22 10:29:14', '2025-04-22 10:29:14'),
(123, 1, 123, 'primary', '2025-04-22 10:29:14', '2025-04-22 10:29:14'),
(124, 1, 124, 'primary', '2025-04-22 10:29:14', '2025-04-22 10:29:14'),
(125, 1, 125, 'primary', '2025-04-22 10:29:14', '2025-04-22 10:29:14'),
(126, 1, 126, 'primary', '2025-04-22 10:29:14', '2025-04-22 10:29:14'),
(127, 1, 127, 'primary', '2025-04-22 10:29:14', '2025-04-22 10:29:14'),
(128, 1, 128, 'primary', '2025-04-22 10:29:14', '2025-04-22 10:29:14'),
(129, 1, 129, 'primary', '2025-04-22 10:29:14', '2025-04-22 10:29:14'),
(130, 1, 130, 'primary', '2025-04-22 10:29:14', '2025-04-22 10:29:14'),
(131, 1, 131, 'primary', '2025-04-22 10:29:14', '2025-04-22 10:29:14'),
(132, 1, 132, 'primary', '2025-04-22 10:29:17', '2025-04-22 10:29:17'),
(133, 1, 133, 'primary', '2025-04-22 10:29:17', '2025-04-22 10:29:17'),
(134, 1, 134, 'primary', '2025-04-22 10:29:18', '2025-04-22 10:29:18'),
(135, 1, 135, 'primary', '2025-04-22 10:29:19', '2025-04-22 10:29:19'),
(136, 1, 136, 'primary', '2025-04-22 10:29:22', '2025-04-22 10:29:22'),
(137, 1, 137, 'primary', '2025-04-22 10:29:22', '2025-04-22 10:29:22'),
(138, 1, 138, 'primary', '2025-04-22 10:29:22', '2025-04-22 10:29:22'),
(139, 1, 139, 'primary', '2025-04-22 10:29:23', '2025-04-22 10:29:23'),
(140, 1, 140, 'primary', '2025-04-22 10:29:24', '2025-04-22 10:29:24'),
(141, 1, 141, 'primary', '2025-04-22 10:29:25', '2025-04-22 10:29:25'),
(142, 1, 142, 'primary', '2025-04-22 10:29:25', '2025-04-22 10:29:25'),
(143, 1, 143, 'primary', '2025-04-22 10:29:26', '2025-04-22 10:29:26'),
(144, 1, 144, 'primary', '2025-04-22 10:29:27', '2025-04-22 10:29:27'),
(145, 1, 145, 'primary', '2025-04-22 10:29:28', '2025-04-22 10:29:28'),
(146, 1, 146, 'primary', '2025-04-22 10:29:29', '2025-04-22 10:29:29'),
(147, 1, 147, 'primary', '2025-04-22 10:29:32', '2025-04-22 10:29:32'),
(148, 1, 148, 'primary', '2025-04-22 10:29:33', '2025-04-22 10:29:33'),
(149, 1, 149, 'primary', '2025-04-22 10:29:33', '2025-04-22 10:29:33'),
(150, 1, 150, 'primary', '2025-04-22 10:29:34', '2025-04-22 10:29:34'),
(151, 1, 151, 'primary', '2025-04-22 10:29:38', '2025-04-22 10:29:38'),
(152, 1, 152, 'primary', '2025-04-22 10:29:39', '2025-04-22 10:29:39'),
(153, 1, 153, 'primary', '2025-04-22 10:29:40', '2025-04-22 10:29:40'),
(154, 1, 154, 'primary', '2025-04-22 10:29:40', '2025-04-22 10:29:40'),
(155, 1, 155, 'primary', '2025-04-22 10:29:40', '2025-04-22 10:29:40'),
(156, 1, 156, 'primary', '2025-04-22 10:29:41', '2025-04-22 10:29:41'),
(157, 1, 157, 'primary', '2025-04-22 10:29:41', '2025-04-22 10:29:41'),
(158, 1, 158, 'primary', '2025-04-22 10:29:41', '2025-04-22 10:29:41'),
(159, 1, 159, 'primary', '2025-04-22 10:29:41', '2025-04-22 10:29:42'),
(160, 1, 160, 'primary', '2025-04-22 10:29:42', '2025-04-22 10:29:42'),
(161, 1, 161, 'primary', '2025-04-22 10:29:42', '2025-04-22 10:29:42'),
(162, 1, 162, 'primary', '2025-04-22 10:29:42', '2025-04-22 10:29:42'),
(163, 2, 5, 'featured', '2025-04-22 10:29:04', '2025-04-22 10:29:04'),
(164, 3, 7, 'featured', '2025-04-22 10:29:04', '2025-04-22 10:29:04'),
(165, 4, 13, 'primary', '2025-04-22 10:29:05', '2025-04-22 10:29:19'),
(166, 4, 134, 'primary', '2025-04-22 10:29:18', '2025-04-22 10:29:18'),
(167, 5, 13, 'primary', '2025-04-22 10:29:05', '2025-04-22 10:29:19'),
(168, 6, 13, 'featured', '2025-04-22 10:29:05', '2025-04-22 10:29:19'),
(169, 7, 20, 'primary', '2025-04-22 10:29:05', '2025-04-22 10:29:30'),
(170, 7, 132, 'primary', '2025-04-22 10:29:17', '2025-04-22 10:29:17'),
(171, 8, 22, 'featured', '2025-04-22 10:29:05', '2025-04-22 10:29:05'),
(172, 9, 23, 'featured', '2025-04-22 10:29:05', '2025-04-22 10:29:05'),
(173, 10, 25, 'featured', '2025-04-22 10:29:05', '2025-04-22 10:29:05'),
(174, 11, 45, 'featured', '2025-04-22 10:29:07', '2025-04-22 10:29:07'),
(175, 12, 46, 'featured', '2025-04-22 10:29:07', '2025-04-22 10:29:07'),
(176, 13, 46, 'featured', '2025-04-22 10:29:07', '2025-04-22 10:29:07'),
(177, 14, 47, 'featured', '2025-04-22 10:29:07', '2025-04-22 10:29:07'),
(178, 15, 48, 'featured', '2025-04-22 10:29:07', '2025-04-22 10:29:07'),
(179, 16, 49, 'featured', '2025-04-22 10:29:07', '2025-04-22 10:29:07'),
(180, 17, 52, 'featured', '2025-04-22 10:29:08', '2025-04-22 10:29:35'),
(181, 18, 54, 'featured', '2025-04-22 10:29:08', '2025-04-22 10:29:37'),
(182, 19, 61, 'featured', '2025-04-22 10:29:08', '2025-04-22 10:29:08'),
(183, 20, 87, 'featured', '2025-04-22 10:29:11', '2025-04-22 10:29:11'),
(184, 20, 91, 'featured', '2025-04-22 10:29:11', '2025-04-22 10:29:11'),
(185, 20, 161, 'featured', '2025-04-22 10:29:42', '2025-04-22 10:29:42'),
(186, 20, 162, 'featured', '2025-04-22 10:29:42', '2025-04-22 10:29:42'),
(187, 21, 90, 'featured', '2025-04-22 10:29:11', '2025-04-22 10:29:11'),
(188, 22, 98, 'featured', '2025-04-22 10:29:11', '2025-04-22 10:29:11'),
(189, 23, 99, 'featured', '2025-04-22 10:29:11', '2025-04-22 10:29:11'),
(190, 24, 104, 'featured', '2025-04-22 10:29:12', '2025-04-22 10:29:13'),
(191, 25, 107, 'featured', '2025-04-22 10:29:12', '2025-04-22 10:29:13'),
(192, 25, 160, 'featured', '2025-04-22 10:29:42', '2025-04-22 10:29:42'),
(193, 26, 110, 'featured', '2025-04-22 10:29:12', '2025-04-22 10:29:12'),
(194, 27, 111, 'featured', '2025-04-22 10:29:12', '2025-04-22 10:29:12'),
(195, 28, 112, 'featured', '2025-04-22 10:29:12', '2025-04-22 10:29:12'),
(196, 29, 113, 'featured', '2025-04-22 10:29:12', '2025-04-22 10:29:12'),
(197, 30, 114, 'featured', '2025-04-22 10:29:12', '2025-04-22 10:29:12'),
(198, 31, 115, 'featured', '2025-04-22 10:29:12', '2025-04-22 10:29:12'),
(199, 32, 116, 'featured', '2025-04-22 10:29:12', '2025-04-22 10:29:12'),
(200, 33, 117, 'featured', '2025-04-22 10:29:12', '2025-04-22 10:29:12'),
(201, 34, 118, 'featured', '2025-04-22 10:29:12', '2025-04-22 10:29:12'),
(202, 35, 119, 'featured', '2025-04-22 10:29:12', '2025-04-22 10:29:12'),
(203, 36, 132, 'primary', '2025-04-22 10:29:17', '2025-04-22 10:29:17'),
(204, 36, 143, 'primary', '2025-04-22 10:29:26', '2025-04-22 10:29:26'),
(205, 36, 145, 'primary', '2025-04-22 10:29:28', '2025-04-22 10:29:28'),
(206, 37, 133, 'primary', '2025-04-22 10:29:17', '2025-04-22 10:29:17'),
(207, 38, 135, 'primary', '2025-04-22 10:29:19', '2025-04-22 10:29:19'),
(208, 39, 135, 'primary', '2025-04-22 10:29:19', '2025-04-22 10:29:19'),
(209, 40, 136, 'primary', '2025-04-22 10:29:22', '2025-04-22 10:29:22'),
(210, 40, 137, 'primary', '2025-04-22 10:29:22', '2025-04-22 10:29:22'),
(211, 40, 138, 'primary', '2025-04-22 10:29:22', '2025-04-22 10:29:22'),
(212, 41, 139, 'primary', '2025-04-22 10:29:23', '2025-04-22 10:29:23'),
(213, 42, 140, 'primary', '2025-04-22 10:29:24', '2025-04-22 10:29:24'),
(214, 43, 142, 'primary', '2025-04-22 10:29:25', '2025-04-22 10:29:25'),
(215, 44, 143, 'primary', '2025-04-22 10:29:26', '2025-04-22 10:29:26'),
(216, 45, 144, 'primary', '2025-04-22 10:29:27', '2025-04-22 10:29:27'),
(217, 46, 145, 'primary', '2025-04-22 10:29:28', '2025-04-22 10:29:28'),
(218, 47, 146, 'primary', '2025-04-22 10:29:29', '2025-04-22 10:29:29'),
(219, 48, 24, 'primary', '2025-04-22 10:29:32', '2025-04-22 10:29:32'),
(220, 49, 150, 'primary', '2025-04-22 10:29:34', '2025-04-22 10:29:34'),
(221, 50, 153, 'featured', '2025-04-22 10:29:40', '2025-04-22 10:29:40'),
(222, 51, 154, 'featured', '2025-04-22 10:29:40', '2025-04-22 10:29:40'),
(223, 61, 163, 'primary', '2025-04-26 22:21:34', '2025-04-26 22:21:34'),
(224, 61, 164, 'primary', '2025-04-26 22:21:34', '2025-04-26 22:21:47'),
(225, 61, 165, 'primary', '2025-04-26 22:21:34', '2025-04-26 22:21:45'),
(226, 61, 166, 'primary', '2025-04-26 22:21:34', '2025-04-26 22:21:44'),
(227, 61, 167, 'primary', '2025-04-26 22:21:34', '2025-04-26 22:21:34'),
(228, 61, 168, 'primary', '2025-04-26 22:21:34', '2025-04-26 22:21:34'),
(229, 61, 169, 'primary', '2025-04-26 22:21:34', '2025-04-26 22:21:34'),
(230, 61, 170, 'primary', '2025-04-26 22:21:34', '2025-04-26 22:21:34'),
(231, 61, 171, 'primary', '2025-04-26 22:21:34', '2025-04-26 22:21:34'),
(232, 61, 172, 'primary', '2025-04-26 22:21:34', '2025-04-26 22:21:34'),
(233, 61, 173, 'primary', '2025-04-26 22:21:34', '2025-04-26 22:21:34'),
(234, 61, 174, 'primary', '2025-04-26 22:21:34', '2025-04-26 22:21:46'),
(235, 61, 175, 'primary', '2025-04-26 22:21:35', '2025-04-26 22:21:35'),
(236, 61, 176, 'primary', '2025-04-26 22:21:35', '2025-04-26 22:21:35'),
(237, 61, 177, 'primary', '2025-04-26 22:21:35', '2025-04-26 22:21:35'),
(238, 61, 178, 'primary', '2025-04-26 22:21:35', '2025-04-26 22:21:35'),
(239, 61, 179, 'primary', '2025-04-26 22:21:35', '2025-04-26 22:21:35'),
(240, 61, 180, 'primary', '2025-04-26 22:21:35', '2025-04-26 22:21:35'),
(241, 61, 181, 'primary', '2025-04-26 22:21:35', '2025-04-26 22:21:35'),
(242, 61, 182, 'primary', '2025-04-26 22:21:35', '2025-04-26 22:21:35'),
(243, 61, 183, 'primary', '2025-04-26 22:21:35', '2025-04-26 22:21:35'),
(244, 61, 184, 'primary', '2025-04-26 22:21:35', '2025-04-26 22:21:35'),
(245, 61, 185, 'primary', '2025-04-26 22:21:36', '2025-04-26 22:21:36'),
(246, 61, 186, 'primary', '2025-04-26 22:21:37', '2025-04-26 22:21:37'),
(247, 61, 187, 'primary', '2025-04-26 22:21:38', '2025-04-26 22:21:38'),
(248, 61, 188, 'primary', '2025-04-26 22:21:38', '2025-04-26 22:21:38'),
(249, 61, 189, 'primary', '2025-04-26 22:21:39', '2025-04-26 22:21:39'),
(250, 61, 190, 'primary', '2025-04-26 22:21:39', '2025-04-26 22:21:41'),
(251, 61, 191, 'primary', '2025-04-26 22:21:39', '2025-04-26 22:21:40'),
(252, 61, 192, 'primary', '2025-04-26 22:21:39', '2025-04-26 22:21:39'),
(253, 61, 193, 'primary', '2025-04-26 22:21:42', '2025-04-26 22:21:42'),
(254, 61, 194, 'primary', '2025-04-26 22:21:44', '2025-04-26 22:21:44'),
(255, 61, 195, 'primary', '2025-04-26 22:21:44', '2025-04-26 22:21:44'),
(256, 61, 196, 'primary', '2025-04-26 22:21:44', '2025-04-26 22:21:44'),
(257, 61, 197, 'primary', '2025-04-26 22:21:47', '2025-04-26 22:21:47'),
(258, 61, 198, 'primary', '2025-04-26 22:21:47', '2025-04-26 22:21:47'),
(259, 61, 199, 'primary', '2025-04-26 22:21:47', '2025-04-26 22:21:47'),
(260, 61, 200, 'primary', '2025-04-26 22:21:47', '2025-04-26 22:21:47'),
(261, 61, 201, 'primary', '2025-04-26 22:21:47', '2025-04-26 22:21:47'),
(262, 62, 167, 'featured', '2025-04-26 22:21:34', '2025-04-26 22:21:34'),
(263, 63, 169, 'featured', '2025-04-26 22:21:34', '2025-04-26 22:21:34'),
(264, 64, 170, 'featured', '2025-04-26 22:21:34', '2025-04-26 22:21:34'),
(265, 65, 171, 'featured', '2025-04-26 22:21:34', '2025-04-26 22:21:34'),
(266, 66, 172, 'featured', '2025-04-26 22:21:34', '2025-04-26 22:21:34'),
(267, 67, 186, 'primary', '2025-04-26 22:21:37', '2025-04-26 22:21:37'),
(268, 68, 186, 'primary', '2025-04-26 22:21:37', '2025-04-26 22:21:37'),
(269, 68, 187, 'primary', '2025-04-26 22:21:38', '2025-04-26 22:21:38'),
(270, 69, 188, 'primary', '2025-04-26 22:21:38', '2025-04-26 22:21:38'),
(271, 70, 188, 'primary', '2025-04-26 22:21:38', '2025-04-26 22:21:38'),
(272, 70, 193, 'primary', '2025-04-26 22:21:42', '2025-04-26 22:21:42'),
(273, 73, 194, 'featured', '2025-04-26 22:21:44', '2025-04-26 22:21:44'),
(274, 74, 202, 'primary', '2025-04-26 22:21:50', '2025-04-26 22:21:50'),
(275, 74, 203, 'primary', '2025-04-26 22:21:50', '2025-04-26 22:21:50'),
(276, 74, 204, 'primary', '2025-04-26 22:21:50', '2025-04-26 22:21:50'),
(277, 74, 205, 'primary', '2025-04-26 22:21:50', '2025-04-26 22:21:50'),
(278, 74, 206, 'primary', '2025-04-26 22:21:50', '2025-04-26 22:21:50'),
(279, 74, 207, 'primary', '2025-04-26 22:21:50', '2025-04-26 22:21:55'),
(280, 74, 208, 'primary', '2025-04-26 22:21:50', '2025-04-26 22:21:55'),
(281, 74, 209, 'primary', '2025-04-26 22:21:50', '2025-04-26 22:21:56'),
(282, 74, 210, 'primary', '2025-04-26 22:21:51', '2025-04-26 22:21:51'),
(283, 74, 211, 'primary', '2025-04-26 22:21:51', '2025-04-26 22:21:51'),
(284, 74, 212, 'primary', '2025-04-26 22:21:51', '2025-04-26 22:22:01'),
(285, 74, 213, 'primary', '2025-04-26 22:21:51', '2025-04-26 22:21:51'),
(286, 74, 214, 'primary', '2025-04-26 22:21:51', '2025-04-26 22:22:00'),
(287, 74, 215, 'primary', '2025-04-26 22:21:51', '2025-04-26 22:21:51'),
(288, 74, 216, 'primary', '2025-04-26 22:21:51', '2025-04-26 22:21:51'),
(289, 74, 217, 'primary', '2025-04-26 22:21:51', '2025-04-26 22:21:51'),
(290, 74, 218, 'primary', '2025-04-26 22:21:52', '2025-04-26 22:21:52'),
(291, 74, 219, 'primary', '2025-04-26 22:21:52', '2025-04-26 22:21:52'),
(292, 74, 220, 'primary', '2025-04-26 22:21:52', '2025-04-26 22:21:52'),
(293, 74, 221, 'primary', '2025-04-26 22:21:52', '2025-04-26 22:21:52'),
(294, 74, 222, 'primary', '2025-04-26 22:21:52', '2025-04-26 22:21:52'),
(295, 74, 223, 'primary', '2025-04-26 22:21:52', '2025-04-26 22:21:52'),
(296, 74, 224, 'primary', '2025-04-26 22:21:52', '2025-04-26 22:21:52'),
(297, 74, 225, 'primary', '2025-04-26 22:21:52', '2025-04-26 22:21:52'),
(298, 74, 226, 'primary', '2025-04-26 22:21:52', '2025-04-26 22:21:52'),
(299, 74, 227, 'primary', '2025-04-26 22:21:52', '2025-04-26 22:21:52'),
(300, 74, 228, 'primary', '2025-04-26 22:21:52', '2025-04-26 22:21:52'),
(301, 74, 229, 'primary', '2025-04-26 22:21:52', '2025-04-26 22:21:52'),
(302, 74, 230, 'primary', '2025-04-26 22:21:52', '2025-04-26 22:21:52'),
(303, 74, 231, 'primary', '2025-04-26 22:21:53', '2025-04-26 22:21:53'),
(304, 74, 232, 'primary', '2025-04-26 22:21:53', '2025-04-26 22:21:53'),
(305, 74, 233, 'primary', '2025-04-26 22:21:53', '2025-04-26 22:21:53'),
(306, 74, 234, 'primary', '2025-04-26 22:21:53', '2025-04-26 22:21:53'),
(307, 74, 235, 'primary', '2025-04-26 22:21:53', '2025-04-26 22:21:53'),
(308, 74, 236, 'primary', '2025-04-26 22:21:53', '2025-04-26 22:21:53'),
(309, 74, 237, 'primary', '2025-04-26 22:21:53', '2025-04-26 22:22:09'),
(310, 74, 238, 'primary', '2025-04-26 22:21:53', '2025-04-26 22:21:53'),
(311, 74, 239, 'primary', '2025-04-26 22:21:53', '2025-04-26 22:21:53'),
(312, 74, 240, 'primary', '2025-04-26 22:21:53', '2025-04-26 22:21:53'),
(313, 74, 241, 'primary', '2025-04-26 22:21:53', '2025-04-26 22:21:53'),
(314, 74, 242, 'primary', '2025-04-26 22:21:53', '2025-04-26 22:21:53'),
(315, 74, 243, 'primary', '2025-04-26 22:21:53', '2025-04-26 22:21:53'),
(316, 74, 244, 'primary', '2025-04-26 22:21:54', '2025-04-26 22:21:54'),
(317, 74, 245, 'primary', '2025-04-26 22:21:54', '2025-04-26 22:21:54'),
(318, 74, 246, 'primary', '2025-04-26 22:21:54', '2025-04-26 22:21:54'),
(319, 74, 247, 'primary', '2025-04-26 22:21:54', '2025-04-26 22:21:54'),
(320, 74, 248, 'primary', '2025-04-26 22:21:54', '2025-04-26 22:21:54'),
(321, 74, 249, 'primary', '2025-04-26 22:21:54', '2025-04-26 22:21:54'),
(322, 74, 250, 'primary', '2025-04-26 22:21:54', '2025-04-26 22:21:54'),
(323, 74, 251, 'primary', '2025-04-26 22:21:54', '2025-04-26 22:21:54'),
(324, 74, 252, 'primary', '2025-04-26 22:21:54', '2025-04-26 22:21:54'),
(325, 74, 253, 'primary', '2025-04-26 22:21:54', '2025-04-26 22:21:54'),
(326, 74, 254, 'primary', '2025-04-26 22:21:54', '2025-04-26 22:21:54'),
(327, 74, 255, 'primary', '2025-04-26 22:21:57', '2025-04-26 22:21:57'),
(328, 74, 256, 'primary', '2025-04-26 22:21:58', '2025-04-26 22:21:58'),
(329, 74, 257, 'primary', '2025-04-26 22:21:58', '2025-04-26 22:21:58'),
(330, 74, 258, 'primary', '2025-04-26 22:21:59', '2025-04-26 22:21:59'),
(331, 74, 259, 'primary', '2025-04-26 22:22:01', '2025-04-26 22:22:01'),
(332, 74, 260, 'primary', '2025-04-26 22:22:02', '2025-04-26 22:22:02'),
(333, 74, 261, 'primary', '2025-04-26 22:22:03', '2025-04-26 22:22:03'),
(334, 74, 262, 'primary', '2025-04-26 22:22:03', '2025-04-26 22:22:03'),
(335, 74, 263, 'primary', '2025-04-26 22:22:04', '2025-04-26 22:22:04'),
(336, 74, 264, 'primary', '2025-04-26 22:22:05', '2025-04-26 22:22:05'),
(337, 74, 265, 'primary', '2025-04-26 22:22:06', '2025-04-26 22:22:06'),
(338, 74, 266, 'primary', '2025-04-26 22:22:06', '2025-04-26 22:22:06'),
(339, 74, 267, 'primary', '2025-04-26 22:22:07', '2025-04-26 22:22:07'),
(340, 74, 268, 'primary', '2025-04-26 22:22:08', '2025-04-26 22:22:08'),
(341, 74, 269, 'primary', '2025-04-26 22:22:09', '2025-04-26 22:22:09'),
(342, 75, 202, 'primary', '2025-04-26 22:21:50', '2025-04-26 22:21:50'),
(343, 75, 203, 'primary', '2025-04-26 22:21:50', '2025-04-26 22:21:50'),
(344, 75, 204, 'primary', '2025-04-26 22:21:50', '2025-04-26 22:21:50'),
(345, 75, 205, 'primary', '2025-04-26 22:21:50', '2025-04-26 22:21:50'),
(346, 75, 206, 'primary', '2025-04-26 22:21:50', '2025-04-26 22:21:50'),
(347, 75, 207, 'primary', '2025-04-26 22:21:50', '2025-04-26 22:21:55'),
(348, 75, 208, 'primary', '2025-04-26 22:21:50', '2025-04-26 22:21:55'),
(349, 75, 209, 'primary', '2025-04-26 22:21:50', '2025-04-26 22:21:56'),
(350, 76, 210, 'primary', '2025-04-26 22:21:51', '2025-04-26 22:21:51'),
(351, 76, 211, 'primary', '2025-04-26 22:21:51', '2025-04-26 22:21:51'),
(352, 76, 212, 'primary', '2025-04-26 22:21:51', '2025-04-26 22:22:01'),
(353, 76, 213, 'primary', '2025-04-26 22:21:51', '2025-04-26 22:21:51'),
(354, 76, 214, 'primary', '2025-04-26 22:21:51', '2025-04-26 22:22:00'),
(355, 76, 215, 'primary', '2025-04-26 22:21:51', '2025-04-26 22:21:51'),
(356, 76, 216, 'primary', '2025-04-26 22:21:51', '2025-04-26 22:21:51'),
(357, 76, 217, 'primary', '2025-04-26 22:21:51', '2025-04-26 22:21:51'),
(358, 76, 256, 'primary', '2025-04-26 22:21:58', '2025-04-26 22:21:58'),
(359, 76, 258, 'primary', '2025-04-26 22:21:59', '2025-04-26 22:21:59'),
(360, 76, 259, 'primary', '2025-04-26 22:22:01', '2025-04-26 22:22:01'),
(361, 76, 261, 'primary', '2025-04-26 22:22:03', '2025-04-26 22:22:03'),
(362, 77, 211, 'featured', '2025-04-26 22:21:51', '2025-04-26 22:21:51'),
(363, 77, 220, 'featured', '2025-04-26 22:21:52', '2025-04-26 22:21:52'),
(364, 77, 256, 'featured', '2025-04-26 22:21:58', '2025-04-26 22:21:58'),
(365, 77, 266, 'primary', '2025-04-26 22:22:06', '2025-04-26 22:22:06'),
(366, 78, 212, 'primary', '2025-04-26 22:21:51', '2025-04-26 22:22:01'),
(367, 79, 214, 'primary', '2025-04-26 22:21:51', '2025-04-26 22:22:00'),
(368, 80, 217, 'featured', '2025-04-26 22:21:51', '2025-04-26 22:21:51'),
(369, 80, 259, 'primary', '2025-04-26 22:22:01', '2025-04-26 22:22:01'),
(370, 81, 218, 'featured', '2025-04-26 22:21:52', '2025-04-26 22:21:52'),
(371, 81, 230, 'featured', '2025-04-26 22:21:52', '2025-04-26 22:21:52'),
(372, 81, 256, 'featured', '2025-04-26 22:21:58', '2025-04-26 22:21:58'),
(373, 81, 258, 'primary', '2025-04-26 22:21:59', '2025-04-26 22:21:59'),
(374, 81, 264, 'primary', '2025-04-26 22:22:05', '2025-04-26 22:22:05'),
(375, 82, 222, 'featured', '2025-04-26 22:21:52', '2025-04-26 22:21:52'),
(376, 83, 224, 'featured', '2025-04-26 22:21:52', '2025-04-26 22:21:52'),
(377, 84, 228, 'featured', '2025-04-26 22:21:52', '2025-04-26 22:21:52'),
(378, 84, 233, 'featured', '2025-04-26 22:21:53', '2025-04-26 22:21:53'),
(379, 85, 231, 'featured', '2025-04-26 22:21:53', '2025-04-26 22:21:53'),
(380, 86, 240, 'featured', '2025-04-26 22:21:53', '2025-04-26 22:21:53'),
(381, 87, 246, 'featured', '2025-04-26 22:21:54', '2025-04-26 22:21:54'),
(382, 88, 252, 'featured', '2025-04-26 22:21:54', '2025-04-26 22:21:54'),
(383, 89, 256, 'primary', '2025-04-26 22:21:58', '2025-04-26 22:21:58'),
(384, 90, 256, 'featured', '2025-04-26 22:21:58', '2025-04-26 22:21:58'),
(385, 91, 256, 'featured', '2025-04-26 22:21:58', '2025-04-26 22:21:58'),
(386, 92, 256, 'featured', '2025-04-26 22:21:58', '2025-04-26 22:21:58'),
(387, 93, 260, 'primary', '2025-04-26 22:22:02', '2025-04-26 22:22:02'),
(388, 94, 265, 'primary', '2025-04-26 22:22:06', '2025-04-26 22:22:06'),
(389, 95, 267, 'primary', '2025-04-26 22:22:07', '2025-04-26 22:22:07'),
(390, 96, 269, 'primary', '2025-04-26 22:22:09', '2025-04-26 22:22:09'),
(391, 97, 270, 'primary', '2025-04-26 22:22:12', '2025-04-26 22:22:12'),
(392, 97, 271, 'primary', '2025-04-26 22:22:12', '2025-04-26 22:22:12'),
(393, 97, 272, 'primary', '2025-04-26 22:22:12', '2025-04-26 22:22:12'),
(394, 97, 273, 'primary', '2025-04-26 22:22:12', '2025-04-26 22:22:12'),
(395, 97, 274, 'primary', '2025-04-26 22:22:12', '2025-04-26 22:22:12'),
(396, 97, 275, 'primary', '2025-04-26 22:22:12', '2025-04-26 22:22:12'),
(397, 97, 276, 'primary', '2025-04-26 22:22:12', '2025-04-26 22:22:12'),
(398, 97, 277, 'primary', '2025-04-26 22:22:12', '2025-04-26 22:22:12'),
(399, 97, 278, 'primary', '2025-04-26 22:22:12', '2025-04-26 22:22:12'),
(400, 97, 279, 'primary', '2025-04-26 22:22:12', '2025-04-26 22:22:12'),
(401, 97, 280, 'primary', '2025-04-26 22:22:12', '2025-04-26 22:22:12'),
(402, 97, 281, 'primary', '2025-04-26 22:22:12', '2025-04-26 22:22:12'),
(403, 97, 282, 'primary', '2025-04-26 22:22:12', '2025-04-26 22:22:12'),
(404, 97, 283, 'primary', '2025-04-26 22:22:12', '2025-04-26 22:22:12'),
(405, 97, 284, 'primary', '2025-04-26 22:22:12', '2025-04-26 22:22:12'),
(406, 97, 285, 'primary', '2025-04-26 22:22:12', '2025-04-26 22:22:12'),
(407, 97, 286, 'primary', '2025-04-26 22:22:12', '2025-04-26 22:22:12'),
(408, 97, 287, 'primary', '2025-04-26 22:22:13', '2025-04-26 22:22:13'),
(409, 97, 288, 'primary', '2025-04-26 22:22:13', '2025-04-26 22:22:13'),
(410, 97, 289, 'primary', '2025-04-26 22:22:13', '2025-04-26 22:22:13'),
(411, 97, 290, 'primary', '2025-04-26 22:22:13', '2025-04-26 22:22:13'),
(412, 97, 291, 'primary', '2025-04-26 22:22:13', '2025-04-26 22:22:13'),
(413, 97, 292, 'primary', '2025-04-26 22:22:13', '2025-04-26 22:22:13'),
(414, 97, 293, 'primary', '2025-04-26 22:22:13', '2025-04-26 22:22:13'),
(415, 97, 294, 'primary', '2025-04-26 22:22:13', '2025-04-26 22:22:13'),
(416, 97, 295, 'primary', '2025-04-26 22:22:13', '2025-04-26 22:22:13'),
(417, 97, 296, 'primary', '2025-04-26 22:22:13', '2025-04-26 22:22:13'),
(418, 97, 297, 'primary', '2025-04-26 22:22:13', '2025-04-26 22:22:13'),
(419, 97, 298, 'primary', '2025-04-26 22:22:13', '2025-04-26 22:22:13'),
(420, 97, 299, 'primary', '2025-04-26 22:22:14', '2025-04-26 22:22:14'),
(421, 97, 300, 'primary', '2025-04-26 22:22:14', '2025-04-26 22:22:14'),
(422, 97, 301, 'primary', '2025-04-26 22:22:14', '2025-04-26 22:22:14'),
(423, 97, 302, 'primary', '2025-04-26 22:22:14', '2025-04-26 22:22:14'),
(424, 97, 303, 'primary', '2025-04-26 22:22:14', '2025-04-26 22:22:14'),
(425, 97, 304, 'primary', '2025-04-26 22:22:14', '2025-04-26 22:22:36'),
(426, 97, 305, 'primary', '2025-04-26 22:22:14', '2025-04-26 22:22:14'),
(427, 97, 306, 'primary', '2025-04-26 22:22:14', '2025-04-26 22:22:14'),
(428, 97, 307, 'primary', '2025-04-26 22:22:14', '2025-04-26 22:22:33'),
(429, 97, 308, 'primary', '2025-04-26 22:22:14', '2025-04-26 22:22:14'),
(430, 97, 309, 'primary', '2025-04-26 22:22:14', '2025-04-26 22:22:14'),
(431, 97, 310, 'primary', '2025-04-26 22:22:14', '2025-04-26 22:22:14'),
(432, 97, 311, 'primary', '2025-04-26 22:22:14', '2025-04-26 22:22:14'),
(433, 97, 312, 'primary', '2025-04-26 22:22:14', '2025-04-26 22:22:14'),
(434, 97, 313, 'primary', '2025-04-26 22:22:14', '2025-04-26 22:22:14'),
(435, 97, 314, 'primary', '2025-04-26 22:22:14', '2025-04-26 22:22:35'),
(436, 97, 315, 'primary', '2025-04-26 22:22:14', '2025-04-26 22:22:14'),
(437, 97, 316, 'primary', '2025-04-26 22:22:14', '2025-04-26 22:22:14'),
(438, 97, 317, 'primary', '2025-04-26 22:22:14', '2025-04-26 22:22:14'),
(439, 97, 318, 'primary', '2025-04-26 22:22:14', '2025-04-26 22:22:28'),
(440, 97, 319, 'primary', '2025-04-26 22:22:15', '2025-04-26 22:22:15'),
(441, 97, 320, 'primary', '2025-04-26 22:22:15', '2025-04-26 22:22:15'),
(442, 97, 321, 'primary', '2025-04-26 22:22:15', '2025-04-26 22:22:15'),
(443, 97, 322, 'primary', '2025-04-26 22:22:15', '2025-04-26 22:22:15'),
(444, 97, 323, 'primary', '2025-04-26 22:22:15', '2025-04-26 22:22:15'),
(445, 97, 324, 'primary', '2025-04-26 22:22:15', '2025-04-26 22:22:15'),
(446, 97, 325, 'primary', '2025-04-26 22:22:15', '2025-04-26 22:22:15'),
(447, 97, 326, 'primary', '2025-04-26 22:22:15', '2025-04-26 22:22:15'),
(448, 97, 327, 'primary', '2025-04-26 22:22:15', '2025-04-26 22:22:15'),
(449, 97, 328, 'primary', '2025-04-26 22:22:15', '2025-04-26 22:22:15'),
(450, 97, 329, 'primary', '2025-04-26 22:22:15', '2025-04-26 22:22:15'),
(451, 97, 330, 'primary', '2025-04-26 22:22:15', '2025-04-26 22:22:15'),
(452, 97, 331, 'primary', '2025-04-26 22:22:15', '2025-04-26 22:22:15'),
(453, 97, 332, 'primary', '2025-04-26 22:22:15', '2025-04-26 22:22:15'),
(454, 97, 333, 'primary', '2025-04-26 22:22:15', '2025-04-26 22:22:15'),
(455, 97, 334, 'primary', '2025-04-26 22:22:16', '2025-04-26 22:22:16'),
(456, 97, 335, 'primary', '2025-04-26 22:22:16', '2025-04-26 22:22:16'),
(457, 97, 336, 'primary', '2025-04-26 22:22:16', '2025-04-26 22:22:16'),
(458, 97, 337, 'primary', '2025-04-26 22:22:16', '2025-04-26 22:22:16'),
(459, 97, 338, 'primary', '2025-04-26 22:22:16', '2025-04-26 22:22:16'),
(460, 97, 339, 'primary', '2025-04-26 22:22:16', '2025-04-26 22:22:16'),
(461, 97, 340, 'primary', '2025-04-26 22:22:16', '2025-04-26 22:22:16'),
(462, 97, 341, 'primary', '2025-04-26 22:22:16', '2025-04-26 22:22:16'),
(463, 97, 342, 'primary', '2025-04-26 22:22:16', '2025-04-26 22:22:16'),
(464, 97, 343, 'primary', '2025-04-26 22:22:17', '2025-04-26 22:22:17'),
(465, 97, 344, 'primary', '2025-04-26 22:22:17', '2025-04-26 22:22:17'),
(466, 97, 345, 'primary', '2025-04-26 22:22:17', '2025-04-26 22:22:17'),
(467, 97, 346, 'primary', '2025-04-26 22:22:17', '2025-04-26 22:22:17'),
(468, 97, 347, 'primary', '2025-04-26 22:22:17', '2025-04-26 22:22:17'),
(469, 97, 348, 'primary', '2025-04-26 22:22:17', '2025-04-26 22:22:17'),
(470, 97, 349, 'primary', '2025-04-26 22:22:17', '2025-04-26 22:22:17'),
(471, 97, 350, 'primary', '2025-04-26 22:22:17', '2025-04-26 22:22:17'),
(472, 97, 351, 'primary', '2025-04-26 22:22:17', '2025-04-26 22:22:17'),
(473, 97, 352, 'primary', '2025-04-26 22:22:17', '2025-04-26 22:22:17'),
(474, 97, 353, 'primary', '2025-04-26 22:22:17', '2025-04-26 22:22:17'),
(475, 97, 354, 'primary', '2025-04-26 22:22:17', '2025-04-26 22:22:17'),
(476, 97, 355, 'primary', '2025-04-26 22:22:17', '2025-04-26 22:22:17'),
(477, 97, 356, 'primary', '2025-04-26 22:22:17', '2025-04-26 22:22:17'),
(478, 97, 357, 'primary', '2025-04-26 22:22:18', '2025-04-26 22:22:18'),
(479, 97, 358, 'primary', '2025-04-26 22:22:18', '2025-04-26 22:22:18'),
(480, 97, 359, 'primary', '2025-04-26 22:22:19', '2025-04-26 22:22:19'),
(481, 97, 360, 'primary', '2025-04-26 22:22:20', '2025-04-26 22:22:20'),
(482, 97, 361, 'primary', '2025-04-26 22:22:21', '2025-04-26 22:22:21'),
(483, 97, 362, 'primary', '2025-04-26 22:22:21', '2025-04-26 22:22:21'),
(484, 97, 363, 'primary', '2025-04-26 22:22:22', '2025-04-26 22:22:22'),
(485, 97, 364, 'primary', '2025-04-26 22:22:23', '2025-04-26 22:22:23'),
(486, 97, 365, 'primary', '2025-04-26 22:22:24', '2025-04-26 22:22:24'),
(487, 97, 366, 'primary', '2025-04-26 22:22:24', '2025-04-26 22:22:24'),
(488, 97, 367, 'primary', '2025-04-26 22:22:25', '2025-04-26 22:22:25'),
(489, 97, 368, 'primary', '2025-04-26 22:22:26', '2025-04-26 22:22:26'),
(490, 97, 369, 'primary', '2025-04-26 22:22:26', '2025-04-26 22:22:26'),
(491, 97, 370, 'primary', '2025-04-26 22:22:27', '2025-04-26 22:22:27'),
(492, 97, 371, 'primary', '2025-04-26 22:22:29', '2025-04-26 22:22:29'),
(493, 97, 372, 'primary', '2025-04-26 22:22:29', '2025-04-26 22:22:29'),
(494, 97, 373, 'primary', '2025-04-26 22:22:30', '2025-04-26 22:22:30'),
(495, 97, 374, 'primary', '2025-04-26 22:22:31', '2025-04-26 22:22:31'),
(496, 97, 375, 'primary', '2025-04-26 22:22:32', '2025-04-26 22:22:32'),
(497, 97, 376, 'primary', '2025-04-26 22:22:32', '2025-04-26 22:22:32'),
(498, 97, 377, 'primary', '2025-04-26 22:22:34', '2025-04-26 22:22:34'),
(499, 97, 378, 'primary', '2025-04-26 22:22:35', '2025-04-26 22:22:35'),
(500, 97, 379, 'primary', '2025-04-26 22:22:37', '2025-04-26 22:22:37'),
(501, 97, 380, 'primary', '2025-04-26 22:22:38', '2025-04-26 22:22:38'),
(502, 97, 381, 'primary', '2025-04-26 22:22:38', '2025-04-26 22:22:38'),
(503, 97, 382, 'primary', '2025-04-26 22:22:38', '2025-04-26 22:22:38'),
(504, 97, 383, 'primary', '2025-04-26 22:22:38', '2025-04-26 22:22:38'),
(505, 97, 384, 'primary', '2025-04-26 22:22:38', '2025-04-26 22:22:38'),
(506, 98, 270, 'primary', '2025-04-26 22:22:12', '2025-04-26 22:22:12'),
(507, 98, 271, 'primary', '2025-04-26 22:22:12', '2025-04-26 22:22:12'),
(508, 98, 272, 'primary', '2025-04-26 22:22:12', '2025-04-26 22:22:12'),
(509, 98, 273, 'primary', '2025-04-26 22:22:12', '2025-04-26 22:22:12'),
(510, 98, 274, 'primary', '2025-04-26 22:22:12', '2025-04-26 22:22:12'),
(511, 98, 275, 'primary', '2025-04-26 22:22:12', '2025-04-26 22:22:12'),
(512, 98, 276, 'primary', '2025-04-26 22:22:12', '2025-04-26 22:22:12'),
(513, 98, 277, 'primary', '2025-04-26 22:22:12', '2025-04-26 22:22:12'),
(514, 98, 278, 'primary', '2025-04-26 22:22:12', '2025-04-26 22:22:12'),
(515, 99, 348, 'featured', '2025-04-26 22:22:17', '2025-04-26 22:22:17'),
(516, 100, 357, 'primary', '2025-04-26 22:22:18', '2025-04-26 22:22:18'),
(517, 101, 359, 'primary', '2025-04-26 22:22:19', '2025-04-26 22:22:19'),
(518, 102, 360, 'primary', '2025-04-26 22:22:20', '2025-04-26 22:22:20'),
(519, 103, 366, 'primary', '2025-04-26 22:22:24', '2025-04-26 22:22:24'),
(520, 104, 375, 'featured', '2025-04-26 22:22:32', '2025-04-26 22:22:32'),
(521, 105, 304, 'primary', '2025-04-26 22:22:36', '2025-04-26 22:22:36'),
(522, 106, 379, 'primary', '2025-04-26 22:22:37', '2025-04-26 22:22:37'),
(523, 107, 380, 'primary', '2025-04-26 22:22:38', '2025-04-26 22:22:38'),
(524, 107, 381, 'primary', '2025-04-26 22:22:38', '2025-04-26 22:22:38'),
(525, 107, 382, 'primary', '2025-04-26 22:22:38', '2025-04-26 22:22:38'),
(526, 107, 383, 'primary', '2025-04-26 22:22:38', '2025-04-26 22:22:38'),
(527, 107, 384, 'primary', '2025-04-26 22:22:38', '2025-04-26 22:22:38'),
(528, 108, 381, 'featured', '2025-04-26 22:22:38', '2025-04-26 22:22:38'),
(529, 108, 383, 'featured', '2025-04-26 22:22:38', '2025-04-26 22:22:38'),
(530, 109, 382, 'featured', '2025-04-26 22:22:38', '2025-04-26 22:22:38'),
(531, 109, 383, 'featured', '2025-04-26 22:22:38', '2025-04-26 22:22:38'),
(532, 113, 386, 'primary', '2025-05-29 06:10:12', '2025-05-29 06:10:31'),
(533, 113, 387, 'primary', '2025-05-29 06:10:12', '2025-05-29 06:10:29'),
(534, 113, 388, 'primary', '2025-05-29 06:10:12', '2025-05-29 06:10:29'),
(535, 113, 389, 'primary', '2025-05-29 06:10:12', '2025-05-29 06:10:12'),
(536, 113, 390, 'primary', '2025-05-29 06:10:12', '2025-05-29 06:10:12'),
(537, 113, 391, 'primary', '2025-05-29 06:10:12', '2025-05-29 06:10:12'),
(538, 113, 392, 'primary', '2025-05-29 06:10:12', '2025-05-29 06:10:12'),
(539, 113, 393, 'primary', '2025-05-29 06:10:12', '2025-05-29 06:10:12'),
(540, 113, 394, 'primary', '2025-05-29 06:10:12', '2025-05-29 06:10:12'),
(541, 113, 395, 'primary', '2025-05-29 06:10:12', '2025-05-29 06:10:12'),
(542, 113, 396, 'primary', '2025-05-29 06:10:12', '2025-05-29 06:10:12'),
(543, 113, 397, 'primary', '2025-05-29 06:10:12', '2025-05-29 06:10:12'),
(544, 113, 398, 'primary', '2025-05-29 06:10:12', '2025-05-29 06:10:12'),
(545, 113, 399, 'primary', '2025-05-29 06:10:13', '2025-05-29 06:10:13'),
(546, 113, 400, 'primary', '2025-05-29 06:10:13', '2025-05-29 06:10:13'),
(547, 113, 401, 'primary', '2025-05-29 06:10:13', '2025-05-29 06:10:13'),
(548, 113, 402, 'primary', '2025-05-29 06:10:13', '2025-05-29 06:10:13'),
(549, 113, 403, 'primary', '2025-05-29 06:10:13', '2025-05-29 06:10:13'),
(550, 113, 404, 'primary', '2025-05-29 06:10:13', '2025-05-29 06:10:13'),
(551, 113, 405, 'primary', '2025-05-29 06:10:13', '2025-05-29 06:10:13'),
(552, 113, 406, 'primary', '2025-05-29 06:10:13', '2025-05-29 06:10:14'),
(553, 113, 407, 'primary', '2025-05-29 06:10:13', '2025-05-29 06:10:14'),
(554, 113, 408, 'primary', '2025-05-29 06:10:14', '2025-05-29 06:10:33'),
(555, 113, 409, 'primary', '2025-05-29 06:10:14', '2025-05-29 06:10:14'),
(556, 113, 410, 'primary', '2025-05-29 06:10:14', '2025-05-29 06:10:15'),
(557, 113, 411, 'primary', '2025-05-29 06:10:14', '2025-05-29 06:10:15'),
(558, 113, 412, 'primary', '2025-05-29 06:10:14', '2025-05-29 06:10:15'),
(559, 113, 413, 'primary', '2025-05-29 06:10:14', '2025-05-29 06:10:15'),
(560, 113, 414, 'primary', '2025-05-29 06:10:14', '2025-05-29 06:10:15'),
(561, 113, 415, 'primary', '2025-05-29 06:10:14', '2025-05-29 06:10:15'),
(562, 113, 416, 'primary', '2025-05-29 06:10:14', '2025-05-29 06:10:15'),
(563, 113, 417, 'primary', '2025-05-29 06:10:14', '2025-05-29 06:10:14'),
(564, 113, 418, 'primary', '2025-05-29 06:10:14', '2025-05-29 06:10:14'),
(565, 113, 419, 'primary', '2025-05-29 06:10:14', '2025-05-29 06:10:14'),
(566, 113, 420, 'primary', '2025-05-29 06:10:14', '2025-05-29 06:10:33'),
(567, 113, 421, 'primary', '2025-05-29 06:10:14', '2025-05-29 06:10:14'),
(568, 113, 422, 'primary', '2025-05-29 06:10:14', '2025-05-29 06:10:32'),
(569, 113, 423, 'primary', '2025-05-29 06:10:14', '2025-05-29 06:10:14'),
(570, 113, 424, 'primary', '2025-05-29 06:10:14', '2025-05-29 06:10:14'),
(571, 113, 425, 'primary', '2025-05-29 06:10:14', '2025-05-29 06:10:14'),
(572, 113, 426, 'primary', '2025-05-29 06:10:15', '2025-05-29 06:10:15'),
(573, 113, 427, 'primary', '2025-05-29 06:10:15', '2025-05-29 06:10:15'),
(574, 113, 428, 'primary', '2025-05-29 06:10:15', '2025-05-29 06:10:15'),
(575, 113, 429, 'primary', '2025-05-29 06:10:15', '2025-05-29 06:10:15'),
(576, 113, 430, 'primary', '2025-05-29 06:10:15', '2025-05-29 06:10:41'),
(577, 113, 431, 'primary', '2025-05-29 06:10:15', '2025-05-29 06:10:15'),
(578, 113, 432, 'primary', '2025-05-29 06:10:15', '2025-05-29 06:10:15'),
(579, 113, 433, 'primary', '2025-05-29 06:10:15', '2025-05-29 06:10:37'),
(580, 113, 434, 'primary', '2025-05-29 06:10:15', '2025-05-29 06:10:15'),
(581, 113, 435, 'primary', '2025-05-29 06:10:16', '2025-05-29 06:10:16'),
(582, 113, 436, 'primary', '2025-05-29 06:10:16', '2025-05-29 06:10:16'),
(583, 113, 437, 'primary', '2025-05-29 06:10:16', '2025-05-29 06:10:16'),
(584, 113, 438, 'primary', '2025-05-29 06:10:16', '2025-05-29 06:10:16'),
(585, 113, 439, 'primary', '2025-05-29 06:10:16', '2025-05-29 06:10:16'),
(586, 113, 440, 'primary', '2025-05-29 06:10:16', '2025-05-29 06:10:16'),
(587, 113, 441, 'primary', '2025-05-29 06:10:16', '2025-05-29 06:10:53'),
(588, 113, 442, 'primary', '2025-05-29 06:10:16', '2025-05-29 06:10:50'),
(589, 113, 443, 'primary', '2025-05-29 06:10:16', '2025-05-29 06:10:56'),
(590, 113, 444, 'primary', '2025-05-29 06:10:16', '2025-05-29 06:10:54'),
(591, 113, 445, 'primary', '2025-05-29 06:10:16', '2025-05-29 06:10:52'),
(592, 113, 446, 'primary', '2025-05-29 06:10:16', '2025-05-29 06:10:16'),
(593, 113, 447, 'primary', '2025-05-29 06:10:16', '2025-05-29 06:10:16'),
(594, 113, 448, 'primary', '2025-05-29 06:10:16', '2025-05-29 06:10:16'),
(595, 113, 449, 'primary', '2025-05-29 06:10:16', '2025-05-29 06:10:16'),
(596, 113, 450, 'primary', '2025-05-29 06:10:17', '2025-05-29 06:10:17'),
(597, 113, 451, 'primary', '2025-05-29 06:10:17', '2025-05-29 06:10:17'),
(598, 113, 452, 'primary', '2025-05-29 06:10:17', '2025-05-29 06:10:17'),
(599, 113, 453, 'primary', '2025-05-29 06:10:17', '2025-05-29 06:10:17'),
(600, 113, 454, 'primary', '2025-05-29 06:10:22', '2025-05-29 06:10:58'),
(601, 113, 455, 'primary', '2025-05-29 06:10:22', '2025-05-29 06:10:22'),
(602, 113, 456, 'primary', '2025-05-29 06:10:22', '2025-05-29 06:10:58'),
(603, 113, 457, 'primary', '2025-05-29 06:10:22', '2025-05-29 06:10:22'),
(604, 113, 458, 'primary', '2025-05-29 06:10:22', '2025-05-29 06:10:22'),
(605, 113, 459, 'primary', '2025-05-29 06:10:22', '2025-05-29 06:10:22'),
(606, 113, 460, 'primary', '2025-05-29 06:10:22', '2025-05-29 06:10:22'),
(607, 113, 461, 'primary', '2025-05-29 06:10:22', '2025-05-29 06:10:22'),
(608, 113, 462, 'primary', '2025-05-29 06:10:22', '2025-05-29 06:10:22'),
(609, 113, 463, 'primary', '2025-05-29 06:10:22', '2025-05-29 06:10:58'),
(610, 113, 464, 'primary', '2025-05-29 06:10:22', '2025-05-29 06:10:22'),
(611, 113, 465, 'primary', '2025-05-29 06:10:22', '2025-05-29 06:10:22'),
(612, 113, 466, 'primary', '2025-05-29 06:10:23', '2025-05-29 06:10:23'),
(613, 113, 467, 'primary', '2025-05-29 06:10:23', '2025-05-29 06:10:23'),
(614, 113, 468, 'primary', '2025-05-29 06:10:23', '2025-05-29 06:10:23'),
(615, 113, 469, 'primary', '2025-05-29 06:10:23', '2025-05-29 06:10:23'),
(616, 113, 470, 'primary', '2025-05-29 06:10:23', '2025-05-29 06:10:23'),
(617, 113, 471, 'primary', '2025-05-29 06:10:23', '2025-05-29 06:10:23'),
(618, 113, 472, 'primary', '2025-05-29 06:10:23', '2025-05-29 06:10:23'),
(619, 113, 473, 'primary', '2025-05-29 06:10:23', '2025-05-29 06:10:23'),
(620, 113, 474, 'primary', '2025-05-29 06:10:23', '2025-05-29 06:10:23'),
(621, 113, 475, 'primary', '2025-05-29 06:10:23', '2025-05-29 06:10:23'),
(622, 113, 476, 'primary', '2025-05-29 06:10:23', '2025-05-29 06:10:23'),
(623, 113, 477, 'primary', '2025-05-29 06:10:23', '2025-05-29 06:10:23'),
(624, 113, 478, 'primary', '2025-05-29 06:10:23', '2025-05-29 06:10:23'),
(625, 113, 479, 'primary', '2025-05-29 06:10:23', '2025-05-29 06:10:23'),
(626, 113, 480, 'primary', '2025-05-29 06:10:24', '2025-05-29 06:10:24'),
(627, 113, 481, 'primary', '2025-05-29 06:10:25', '2025-05-29 06:10:25'),
(628, 113, 482, 'primary', '2025-05-29 06:10:29', '2025-05-29 06:10:29'),
(629, 113, 483, 'primary', '2025-05-29 06:10:31', '2025-05-29 06:10:31'),
(630, 113, 484, 'primary', '2025-05-29 06:10:33', '2025-05-29 06:10:33'),
(631, 113, 485, 'primary', '2025-05-29 06:10:34', '2025-05-29 06:10:34'),
(632, 113, 486, 'primary', '2025-05-29 06:10:34', '2025-05-29 06:10:35'),
(633, 113, 487, 'primary', '2025-05-29 06:10:36', '2025-05-29 06:10:36'),
(634, 113, 488, 'primary', '2025-05-29 06:10:36', '2025-05-29 06:10:37'),
(635, 113, 489, 'primary', '2025-05-29 06:10:38', '2025-05-29 06:10:38'),
(636, 113, 490, 'primary', '2025-05-29 06:10:41', '2025-05-29 06:10:41'),
(637, 113, 491, 'primary', '2025-05-29 06:10:42', '2025-05-29 06:10:42'),
(638, 113, 492, 'primary', '2025-05-29 06:10:43', '2025-05-29 06:10:43'),
(639, 113, 493, 'primary', '2025-05-29 06:10:43', '2025-05-29 06:10:43'),
(640, 113, 494, 'primary', '2025-05-29 06:10:43', '2025-05-29 06:10:43'),
(641, 113, 495, 'primary', '2025-05-29 06:10:43', '2025-05-29 06:10:43'),
(642, 113, 496, 'primary', '2025-05-29 06:10:44', '2025-05-29 06:10:44'),
(643, 113, 497, 'primary', '2025-05-29 06:10:44', '2025-05-29 06:10:44'),
(644, 113, 498, 'primary', '2025-05-29 06:10:46', '2025-05-29 06:10:46'),
(645, 114, 481, 'primary', '2025-05-29 06:10:25', '2025-05-29 06:10:25'),
(646, 115, 481, 'primary', '2025-05-29 06:10:25', '2025-05-29 06:10:25'),
(647, 116, 492, 'featured', '2025-05-29 06:10:43', '2025-05-29 06:10:43'),
(648, 116, 493, 'featured', '2025-05-29 06:10:43', '2025-05-29 06:10:43'),
(649, 116, 494, 'featured', '2025-05-29 06:10:43', '2025-05-29 06:10:43'),
(650, 116, 495, 'featured', '2025-05-29 06:10:43', '2025-05-29 06:10:43'),
(651, 116, 496, 'featured', '2025-05-29 06:10:44', '2025-05-29 06:10:44'),
(653, 119, 385, 'primary', '2026-02-28 17:12:59', '2026-02-28 17:12:59'),
(654, 1, 385, 'primary', '2026-02-28 17:13:17', '2026-02-28 17:13:17'),
(655, 30, 385, 'primary', '2026-02-28 17:14:28', '2026-02-28 17:14:28'),
(656, 61, 385, 'primary', '2026-02-28 17:14:28', '2026-02-28 17:14:28'),
(657, 117, 385, 'primary', '2026-02-28 17:15:06', '2026-02-28 17:15:06'),
(658, 59, 385, 'primary', '2026-02-28 17:15:06', '2026-02-28 17:15:06'),
(659, 1, 501, 'primary', '2026-04-07 18:12:11', '2026-04-07 18:12:11'),
(660, 2, 501, 'primary', '2026-04-07 18:12:11', '2026-04-07 18:12:11'),
(661, 3, 501, 'primary', '2026-04-07 18:12:11', '2026-04-07 18:12:11'),
(662, 4, 501, 'primary', '2026-04-07 18:12:11', '2026-04-07 18:12:11'),
(663, 5, 501, 'primary', '2026-04-07 18:12:11', '2026-04-07 18:12:11'),
(664, 6, 501, 'primary', '2026-04-07 18:12:11', '2026-04-07 18:12:11'),
(665, 7, 501, 'primary', '2026-04-07 18:12:11', '2026-04-07 18:12:11'),
(666, 8, 501, 'primary', '2026-04-07 18:12:11', '2026-04-07 18:12:11');

-- --------------------------------------------------------

--
-- Table structure for table `cache`
--

CREATE TABLE `cache` (
  `key` varchar(255) NOT NULL,
  `value` mediumtext NOT NULL,
  `expiration` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `cache_locks`
--

CREATE TABLE `cache_locks` (
  `key` varchar(255) NOT NULL,
  `owner` varchar(255) NOT NULL,
  `expiration` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `comments_artists`
--

CREATE TABLE `comments_artists` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `artist_id` bigint(20) UNSIGNED NOT NULL,
  `text` text NOT NULL,
  `status` enum('visible','hidden','deleted') NOT NULL DEFAULT 'visible',
  `deleted_username` varchar(100) DEFAULT NULL,
  `deleted_by` enum('author','moderator','system') DEFAULT NULL,
  `delete_reason` enum('self_deleted','spam','abuse','off_topic','other') DEFAULT NULL,
  `parent_id` bigint(20) UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `edited_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `comments_artists`
--

INSERT INTO `comments_artists` (`id`, `user_id`, `artist_id`, `text`, `status`, `deleted_username`, `deleted_by`, `delete_reason`, `parent_id`, `created_at`, `updated_at`, `deleted_at`, `edited_at`) VALUES
(1, 5, 1, 'Bring Me The Horizon completely changed my taste in music.', 'visible', NULL, NULL, NULL, NULL, '2026-01-10 08:15:00', '2026-01-10 08:15:00', NULL, NULL),
(2, 6, 1, 'Their early albums were heavy, but the newer stuff is also great.', 'visible', NULL, NULL, NULL, NULL, '2026-01-10 08:22:14', '2026-01-10 08:22:14', NULL, NULL),
(3, 7, 1, 'Oli Sykes vocals are insane live.', 'visible', NULL, NULL, NULL, NULL, '2026-01-10 08:35:42', '2026-01-10 08:35:42', NULL, NULL),
(4, 8, 1, 'One of the most experimental bands in modern metal.', 'visible', NULL, NULL, NULL, NULL, '2026-01-10 08:48:09', '2026-01-10 08:48:09', NULL, NULL),
(5, 9, 1, 'POST HUMAN project was a bold move and it paid off.', 'visible', NULL, NULL, NULL, NULL, '2026-01-10 09:01:27', '2026-01-10 09:01:27', NULL, NULL),
(6, 10, 1, 'Seen them live twice, both times absolutely unforgettable.', 'visible', NULL, NULL, NULL, NULL, '2026-01-10 09:10:54', '2026-01-10 09:10:54', NULL, NULL),
(7, 11, 1, 'They always evolve, never stuck in one genre.', 'visible', NULL, NULL, NULL, NULL, '2026-01-10 09:18:31', '2026-01-10 09:18:31', NULL, NULL),
(8, 12, 1, 'BMTH is proof that metal bands can reinvent themselves.', 'visible', NULL, NULL, NULL, NULL, '2026-01-10 09:25:46', '2026-01-10 09:25:46', NULL, NULL),
(9, 18, 1, 'Bring Me The Horizon ir viena no ietekmīgākajām grupām pēdējos gados.', 'visible', NULL, NULL, NULL, NULL, '2026-01-10 09:33:02', '2026-01-10 09:33:02', NULL, NULL),
(10, 19, 1, 'Man ļoti patīk, kā viņi sajauc elektroniku ar metālu.', 'visible', NULL, NULL, NULL, NULL, '2026-01-10 09:40:18', '2026-01-10 09:40:18', NULL, NULL),
(11, 20, 1, 'Vecie albumi bija smagāki, bet jaunais skan interesanti.', 'visible', NULL, NULL, NULL, NULL, '2026-01-10 09:47:55', '2026-01-10 09:47:55', NULL, NULL),
(12, 21, 1, 'Oli Sykes balss ir ļoti atpazīstama.', 'visible', NULL, NULL, NULL, NULL, '2026-01-10 09:55:03', '2026-01-10 09:55:03', NULL, NULL),
(13, 22, 1, 'Viņu koncerti vienmēr ir enerģiski.', 'visible', NULL, NULL, NULL, NULL, '2026-01-10 10:02:41', '2026-01-10 10:02:41', NULL, NULL),
(14, 23, 1, 'Šī grupa man palīdzēja iepazīt metālu kā žanru.', 'visible', NULL, NULL, NULL, NULL, '2026-01-10 10:10:16', '2026-01-10 10:10:16', NULL, NULL),
(15, 5, 1, 'Sempiternal is still my favorite album.', 'visible', NULL, NULL, NULL, NULL, '2026-01-10 10:18:29', '2026-01-10 10:18:29', NULL, NULL),
(16, 6, 1, 'Their lyrics hit really hard sometimes.', 'visible', NULL, NULL, NULL, NULL, '2026-01-10 10:26:44', '2026-01-10 10:26:44', NULL, NULL),
(17, 7, 1, 'Not every song is for me, but I respect their creativity.', 'visible', NULL, NULL, NULL, NULL, '2026-01-10 10:35:08', '2026-01-10 10:35:08', NULL, NULL),
(18, 18, 1, 'Manuprāt, viņi ļoti labi pielāgojas laikmetam.', 'visible', NULL, NULL, NULL, NULL, '2026-01-10 10:43:52', '2026-01-10 10:43:52', NULL, NULL),
(19, 19, 1, 'Grupa, kas nebaidās riskēt ar savu skanējumu.', 'visible', NULL, NULL, NULL, NULL, '2026-01-10 10:51:19', '2026-01-10 10:51:19', NULL, NULL),
(20, 20, 1, 'Bring Me The Horizon noteikti ir vairāk nekā tikai metāls.', 'visible', NULL, NULL, NULL, NULL, '2026-01-10 10:59:47', '2026-01-10 10:59:47', NULL, NULL),
(21, 6, 1, 'Early stuff were better IMHO', 'visible', NULL, NULL, NULL, NULL, '2026-01-10 15:26:33', '2026-01-10 15:26:33', NULL, NULL),
(22, 20, 1, 'Bring Me the Horizon, often known by the acronym BMTH, is a British deathcore/metalcore/alternative metal band formed in 2004 in Sheffield, South Yorkshire, by vocalist Oliver Sykes, drummer Matt Nicholls, bassist Matt Kean and guitarists Lee Malia and Curtis Ward.\r\nThe current lineup of the band consists of: Oliver \"Oli\" Sykes (lead vocals, keyboards and programming), Matt Nicholls (drums), Lee Malia (lead and rythm guitar), Matt Kean (bass) and touring member John Jones (rythm guitar and backing vocals).\r\n\r\nThey are signed to RCA Records globally and Columbia Records exclusively in the United States. The style of their early work, including their debut album Count Your Blessings, has primarily been described as melodic deathcore, but they started to adopt a more eclectic style of metalcore on subsequent albums. Furthermore, their latest two albums That\'s the Spirit and amo marked a shift in their sound to less aggressive rock/metal music styles, such as alternative rock, pop rock, and alternative metal.\r\n\r\nHistory\r\nBring Me the Horizon\'s founding members came from diverse musical backgrounds within metal and rock. Matt Nicholls and Oliver Sykes had a common interest in American metalcore such as Norma Jean and Skycamefalling, and used to attend local hardcore punk shows. They later met Lee Malia, who spoke with them about thrash metal and melodic death metal bands like Metallica and At the Gates; Malia had also been part of a Metallica tribute band before meeting the pair. Bring Me the Horizon officially formed in March 2004, when the members were aged 15 to 17. Curtis Ward, who also lived in the Rotherham area, joined Sykes, Malia and Nicholls. Bassist Matt Kean, who was in other local bands, completed the line-up. Their name was taken from the line in the fil', 'visible', NULL, NULL, NULL, NULL, '2026-01-10 17:19:44', NULL, NULL, NULL),
(23, 8, 1, 'I mean your obviously wrong but ok let it be bro', 'visible', NULL, NULL, NULL, 22, '2026-01-10 20:24:21', '2026-01-10 20:24:21', NULL, NULL),
(24, 9, 1, 'kekw yeah that happens', 'visible', NULL, NULL, NULL, 22, '2026-01-10 20:25:35', '2026-01-10 20:25:35', NULL, NULL),
(25, 5, 1, 'testē otro dziļuma līmeni', 'visible', NULL, NULL, NULL, 23, '2026-01-10 20:26:15', '2026-01-10 20:26:15', NULL, NULL),
(26, 12, 1, 'testing first level depth with veeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeery looooooooooooooooooooooooooooooong teeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeext\r\n\r\nffd', 'visible', NULL, NULL, NULL, 21, '2026-01-11 15:03:48', '2026-01-11 15:03:48', NULL, NULL),
(27, 14, 1, 'testing second level depth with veeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeery looooooooooooooooooooooooooooooong teeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeext\r\n\r\nffd', 'visible', NULL, NULL, NULL, 26, '2026-01-11 15:05:01', '2026-01-11 15:05:01', NULL, NULL),
(28, 19, 1, 'testing another time', 'visible', NULL, NULL, NULL, 10, '2026-01-11 15:09:10', '2026-01-11 15:09:10', NULL, NULL),
(29, 1, 1, 'testing comment writing weeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee\n\nwwwwwwwwwwwwwweeeeeeeee', 'visible', NULL, NULL, NULL, NULL, '2026-01-11 14:56:42', '2026-01-11 14:56:42', NULL, NULL),
(30, 1, 1, 'another comment lets gooooooooooooooooo', 'visible', NULL, NULL, NULL, NULL, '2026-01-11 14:57:14', '2026-01-11 14:57:14', NULL, NULL),
(31, 1, 1, 'comment writing in mobile mode ffsdfsdfdf\n\ndsdadsa\ndsadasdsad.../.12@#/1!', 'visible', NULL, NULL, NULL, NULL, '2026-01-11 14:58:01', '2026-01-11 14:58:01', NULL, NULL),
(33, 1, 1, 'bibibibibibbigfooootbibibibibibbigfooootbibibibibibbigfooootbibibibibibbigfoooot', 'visible', NULL, NULL, NULL, 31, '2026-01-17 10:42:06', '2026-01-17 10:42:06', NULL, NULL),
(34, 1, 1, 'moretextmoretextmoretextmoretextmoretextmoretextmoretextmoretextmoretextmoretextmoretextmoretextmoretextmoretextmoretextmoretextmoretextmoretextmoretextmoretextmoretextmoretextmoretextmoretextmoretextmoretextmoretextmoretextmoretextmoretextmoretextmoretextmoretextmoretextmoretextmoretextmoretextmoretextmoretextmoretextmoretextmoretextmoretextmoretextmoretext', 'visible', NULL, NULL, NULL, 31, '2026-01-17 10:42:37', '2026-01-17 10:42:37', NULL, NULL),
(35, 1, 1, '2nddepthtest2nddepthtest2nddepthtest2nddepthtest2nddepthtest2nddepthtest2nddepthtest2nddepthtest2nddepthtest2nddepthtest2nddepthtest2nddepthtest2nddepthtest2nddepthtest2nddepthtest2nddepthtest2nddepthtest2nddepthtest2nddepthtest2nddepthtest2nddepthtest2nddepthtest2nddepthtest2nddepthtest2nddepthtest2nddepthtest', 'visible', NULL, NULL, NULL, 33, '2026-01-17 10:43:29', '2026-01-17 10:43:29', NULL, NULL),
(36, 1, 1, 'testtesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttestvv😆😆😆😆😆😆😆😆😆😆😆😆😆', 'visible', NULL, NULL, NULL, 20, '2026-01-17 10:52:49', '2026-01-17 10:52:49', NULL, NULL),
(37, 1, 1, 'afsaaafsaaafsaaafsaaafsaaafsaaafsaaafsaaafsaaafsaaafsaaafsaaafsaaafsaaafsaaafsaaafsaaafsaaafsaaafsaaafsaaafsaaafsaaafsaaafsaaafsaaafsaaafsaaafsaaafsaaafsaaafsaaafsaav', 'visible', NULL, NULL, NULL, 20, '2026-01-17 10:53:05', '2026-01-17 10:53:05', NULL, NULL),
(38, 1, 1, 'newcommentnewcommentnewcommentnewcommentnewcommentnewcommentnewcommentnewcommentnewcommentnewcommentnewcommentnewcomment', 'visible', NULL, NULL, NULL, NULL, '2026-01-17 10:55:48', '2026-01-17 10:55:48', NULL, NULL),
(39, 1, 1, 'testtesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttest', 'visible', NULL, NULL, NULL, NULL, '2026-01-17 12:05:55', '2026-01-17 12:05:55', NULL, NULL),
(40, 1, 1, 'testtesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttest', 'visible', NULL, NULL, NULL, 39, '2026-01-17 12:06:06', '2026-01-17 12:06:06', NULL, NULL),
(41, 1, 1, 'new comment to test replies', 'visible', NULL, NULL, NULL, NULL, '2026-01-17 12:22:18', '2026-01-17 12:22:18', NULL, NULL),
(42, 1, 1, 'new reply to test order blehhhhhhhhhh', 'visible', NULL, NULL, NULL, 41, '2026-01-17 12:22:42', '2026-01-17 12:22:42', NULL, NULL),
(43, 1, 1, 'newer reply to test order hello thereeeeeeeeeee', 'visible', NULL, NULL, NULL, 41, '2026-01-17 12:22:55', '2026-01-17 12:22:55', NULL, NULL),
(44, 1, 1, 'imma be third heyyyyyyyyyyyyyyyyyyy', 'visible', NULL, NULL, NULL, 41, '2026-01-17 12:23:49', '2026-01-17 12:23:49', NULL, NULL),
(45, 1, 1, 'new comment to test time', 'visible', NULL, NULL, NULL, NULL, '2026-01-17 12:25:21', '2026-01-17 12:25:21', NULL, NULL),
(46, 1, 1, 'another new comment to test time after updates', 'visible', NULL, NULL, NULL, NULL, '2026-01-17 13:05:03', '2026-01-17 13:05:03', NULL, NULL),
(47, 1, 1, 'testing after updatestesting after updatestesting after updatestesting after updatestesting after updates', 'visible', NULL, NULL, NULL, NULL, '2026-01-17 13:17:17', '2026-01-17 13:17:17', NULL, NULL),
(127, 5, 1, 'tst', 'visible', NULL, NULL, NULL, 37, '2026-01-24 19:17:17', '2026-01-24 19:17:20', '2026-01-24 19:17:20', NULL),
(128, 5, 1, 'egdgd', 'visible', NULL, NULL, NULL, 20, '2026-01-24 19:17:34', '2026-01-24 19:17:44', '2026-01-24 19:17:44', NULL),
(129, 5, 1, 'newnew', 'visible', NULL, NULL, NULL, NULL, '2026-01-24 19:26:48', '2026-01-24 19:28:30', '2026-01-24 19:28:30', NULL),
(131, 5, 1, 'new2', 'visible', NULL, NULL, NULL, 129, '2026-01-24 19:26:56', '2026-01-24 19:28:25', '2026-01-24 19:28:25', NULL),
(139, 5, 1, 'new3', 'visible', NULL, NULL, NULL, 129, '2026-01-24 19:28:20', '2026-01-24 19:28:20', NULL, NULL),
(144, 5, 1, 'new comment top to tdelte with replies after uodates', 'visible', NULL, NULL, NULL, NULL, '2026-01-25 17:51:06', '2026-01-25 17:52:29', '2026-01-25 17:52:29', NULL),
(145, 5, 1, 'new reply', 'visible', NULL, NULL, NULL, 144, '2026-01-25 17:51:20', '2026-01-25 17:51:20', NULL, NULL),
(146, 5, 1, 'reply to reply', 'visible', NULL, NULL, NULL, 145, '2026-01-25 17:51:25', '2026-01-25 17:52:47', '2026-01-25 17:52:47', NULL),
(147, 5, 1, 'new reply 2', 'visible', NULL, NULL, NULL, 144, '2026-01-25 17:51:31', '2026-01-25 17:52:52', '2026-01-25 17:52:52', NULL),
(149, 5, 1, 'test comment to test edit fsdfsdggd df gdfgd', 'visible', NULL, NULL, NULL, NULL, '2026-01-25 19:30:18', '2026-01-25 19:31:25', NULL, '2026-01-25 19:31:25'),
(150, 5, 1, 'new tst comment to test edit timer edited', 'visible', NULL, NULL, NULL, NULL, '2026-01-25 19:34:27', '2026-01-25 19:34:34', NULL, '2026-01-25 19:34:34'),
(151, 5, 1, 'pr gdfg fsf', 'visible', NULL, NULL, NULL, NULL, '2026-01-25 19:38:22', '2026-01-25 19:41:17', NULL, '2026-01-25 19:41:17'),
(152, 25, 1, 'yo', 'visible', NULL, NULL, NULL, NULL, '2026-01-25 19:46:59', '2026-01-25 19:46:59', NULL, NULL),
(154, 5, 1, 'wassup hey', 'visible', NULL, NULL, NULL, 152, '2026-01-27 19:10:02', '2026-01-27 19:29:32', '2026-01-27 19:29:32', NULL),
(158, 5, 70, 'hi', 'visible', NULL, NULL, NULL, NULL, '2026-01-27 19:27:50', '2026-01-27 19:27:50', NULL, NULL),
(159, 5, 70, 'hello', 'visible', NULL, NULL, NULL, 158, '2026-01-27 19:27:55', '2026-01-27 19:27:55', NULL, NULL),
(160, 1, 70, 'tst sdfs', 'visible', NULL, NULL, NULL, NULL, '2026-01-27 19:28:40', '2026-01-27 19:28:45', NULL, NULL),
(161, 1, 113, 'first comment', 'visible', NULL, NULL, NULL, NULL, '2026-01-27 19:29:06', '2026-01-28 14:49:40', '2026-01-28 14:49:40', NULL),
(162, 25, 1, 'hello hello', 'visible', NULL, NULL, NULL, NULL, '2026-01-27 19:30:36', '2026-01-27 19:31:00', '2026-01-27 19:31:00', NULL),
(163, 25, 1, 'hi', 'visible', NULL, NULL, NULL, 162, '2026-01-27 19:30:56', '2026-01-27 19:30:56', NULL, NULL),
(165, 5, 113, 'atbilde', 'visible', NULL, NULL, NULL, 161, '2026-01-28 14:47:18', '2026-01-28 14:48:26', '2026-01-28 14:48:26', NULL),
(169, 25, 1, 'new comment', 'visible', NULL, NULL, NULL, NULL, '2026-02-07 13:11:41', '2026-02-07 13:11:51', '2026-02-07 13:11:51', NULL),
(170, 25, 1, 'hey', 'visible', NULL, NULL, NULL, 169, '2026-02-07 13:11:46', '2026-02-07 13:11:46', NULL, NULL),
(171, 25, 1, 'new comment hello anotehr hey', 'visible', NULL, NULL, NULL, NULL, '2026-02-07 13:13:59', '2026-02-07 13:20:47', NULL, '2026-02-07 13:20:47'),
(172, 25, 1, 'hey', 'visible', NULL, NULL, NULL, NULL, '2026-02-07 13:33:52', '2026-02-07 13:33:52', NULL, NULL),
(173, 25, 1, 'hello', 'visible', NULL, NULL, NULL, 172, '2026-02-17 10:28:39', '2026-02-17 10:28:39', NULL, NULL),
(174, 25, 1, 'wassup', 'visible', NULL, NULL, NULL, NULL, '2026-02-17 12:43:03', '2026-02-17 12:43:03', NULL, NULL),
(175, 25, 1, 'hey', 'visible', NULL, NULL, NULL, 174, '2026-02-17 12:43:06', '2026-02-17 12:43:06', NULL, NULL),
(176, 25, 1, 'yo', 'visible', NULL, NULL, NULL, 175, '2026-02-17 12:43:18', '2026-02-17 12:43:18', NULL, NULL),
(177, 25, 1, 'yo br', 'visible', NULL, NULL, NULL, NULL, '2026-02-17 14:14:34', '2026-02-17 14:14:50', '2026-02-17 14:14:50', '2026-02-17 14:14:45'),
(178, 25, 1, 'yoyo', 'visible', NULL, NULL, NULL, 177, '2026-02-17 14:14:41', '2026-02-17 14:14:41', NULL, NULL),
(181, 25, 113, 'hello', 'visible', NULL, NULL, NULL, NULL, '2026-02-18 15:39:24', '2026-02-18 15:39:24', NULL, NULL),
(182, 25, 113, 'hi edy', 'visible', NULL, NULL, NULL, 181, '2026-02-18 15:39:31', '2026-02-18 15:39:39', '2026-02-18 15:39:39', '2026-02-18 15:39:36'),
(183, 5, 1, 'tst', 'visible', NULL, NULL, NULL, NULL, '2026-04-18 10:37:06', '2026-04-18 10:37:06', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `comments_genres`
--

CREATE TABLE `comments_genres` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `genre_id` bigint(20) UNSIGNED NOT NULL,
  `text` text NOT NULL,
  `status` enum('visible','hidden','deleted') NOT NULL DEFAULT 'visible',
  `deleted_username` varchar(100) DEFAULT NULL,
  `parent_id` bigint(20) UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `edited_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `comments_genres`
--

INSERT INTO `comments_genres` (`id`, `user_id`, `genre_id`, `text`, `status`, `deleted_username`, `parent_id`, `created_at`, `updated_at`, `deleted_at`, `edited_at`) VALUES
(1, 25, 2, 'hiiii', 'visible', NULL, NULL, '2026-02-18 21:02:08', '2026-02-18 21:02:08', NULL, NULL),
(2, 25, 2, 'heyya edit', 'visible', NULL, NULL, '2026-02-19 15:46:56', '2026-02-19 15:50:56', '2026-02-19 15:50:56', NULL),
(3, 25, 2, 'fsdfs', 'visible', NULL, 2, '2026-02-19 15:50:24', '2026-02-19 15:50:48', '2026-02-19 15:50:48', NULL),
(4, 25, 2, 'fsdfdasd', 'visible', NULL, 3, '2026-02-19 15:50:27', '2026-02-19 15:50:51', NULL, NULL),
(5, 25, 2, 'dfsf', 'visible', NULL, 2, '2026-02-19 15:50:29', '2026-02-19 15:50:29', NULL, NULL),
(6, 25, 2, 'dfsf', 'visible', NULL, 3, '2026-02-19 15:50:30', '2026-02-19 15:50:53', '2026-02-19 15:50:53', NULL),
(7, 25, 2, 'fdsf', 'visible', NULL, 4, '2026-02-19 15:50:33', '2026-02-19 15:50:33', NULL, NULL),
(9, 5, 2, 'bra', 'visible', NULL, NULL, '2026-04-12 08:52:55', '2026-04-12 08:52:55', NULL, NULL),
(10, 5, 2, 'yeah', 'visible', NULL, 9, '2026-04-12 08:53:03', '2026-04-12 08:53:03', NULL, NULL),
(11, 5, 2, 'hah', 'visible', NULL, 7, '2026-04-12 08:53:08', '2026-04-12 08:53:08', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `comments_releases`
--

CREATE TABLE `comments_releases` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `release_id` bigint(20) UNSIGNED NOT NULL,
  `text` text NOT NULL,
  `status` enum('visible','hidden','deleted') NOT NULL DEFAULT 'visible',
  `deleted_username` varchar(100) DEFAULT NULL,
  `parent_id` bigint(20) UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `edited_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `comments_releases`
--

INSERT INTO `comments_releases` (`id`, `user_id`, `release_id`, `text`, `status`, `deleted_username`, `parent_id`, `created_at`, `updated_at`, `deleted_at`, `edited_at`) VALUES
(2, 25, 1, 'first comment hello edit', 'visible', NULL, NULL, '2026-02-17 10:27:50', '2026-02-17 10:28:07', NULL, NULL),
(3, 25, 1, 'first reply', 'visible', NULL, 2, '2026-02-17 10:28:01', '2026-02-17 12:34:06', '2026-02-17 12:34:06', NULL),
(4, 25, 1, 'reply to reply', 'visible', NULL, 3, '2026-02-17 10:28:15', '2026-02-17 10:28:15', NULL, NULL),
(5, 25, 1, 'hey', 'visible', NULL, 3, '2026-02-17 10:28:19', '2026-02-17 12:34:11', '2026-02-17 12:34:11', NULL),
(7, 25, 13, 'hey ds', 'visible', NULL, NULL, '2026-02-17 15:56:30', '2026-02-17 15:56:37', NULL, NULL),
(8, 25, 13, 'broooo', 'visible', NULL, 7, '2026-02-17 15:56:34', '2026-02-17 15:56:34', NULL, NULL),
(9, 25, 1, 'expands', 'visible', NULL, NULL, '2026-02-17 15:56:53', '2026-02-17 15:56:53', NULL, NULL),
(10, 25, 1, 'expands 2', 'visible', NULL, NULL, '2026-02-17 15:56:56', '2026-02-17 15:56:56', NULL, NULL),
(11, 25, 1, 'expands 3', 'visible', NULL, NULL, '2026-02-17 15:56:58', '2026-02-17 15:56:58', NULL, NULL),
(12, 25, 1, 'expands 4', 'visible', NULL, NULL, '2026-02-17 15:57:00', '2026-02-17 15:57:00', NULL, NULL),
(13, 25, 1, 'expands 5', 'visible', NULL, NULL, '2026-02-17 15:57:01', '2026-02-17 15:57:01', NULL, NULL),
(14, 25, 1, 'expands 6', 'visible', NULL, NULL, '2026-02-17 15:57:03', '2026-02-17 15:57:03', NULL, NULL),
(15, 25, 1, 'expands 7', 'visible', NULL, NULL, '2026-02-17 15:57:13', '2026-02-17 15:57:13', NULL, NULL),
(16, 25, 1, 'expands 8', 'visible', NULL, NULL, '2026-02-17 15:57:34', '2026-02-17 15:57:34', NULL, NULL),
(17, 25, 1, 'expands 9', 'visible', NULL, NULL, '2026-02-17 15:57:36', '2026-02-17 15:57:36', NULL, NULL),
(18, 25, 1, 'expands 10', 'visible', NULL, NULL, '2026-02-17 15:57:44', '2026-02-17 15:57:44', NULL, NULL),
(19, 25, 1, 'yay', 'visible', NULL, 18, '2026-02-17 15:57:58', '2026-02-17 15:57:58', NULL, NULL),
(20, 25, 130, 'hello', 'visible', NULL, NULL, '2026-02-18 15:35:53', '2026-02-18 15:35:53', NULL, NULL),
(22, 25, 130, 'dasd', 'visible', NULL, 20, '2026-02-18 15:36:05', '2026-02-18 15:36:14', '2026-02-18 15:36:14', NULL),
(23, 25, 130, 'dwdad', 'visible', NULL, 22, '2026-02-18 15:36:07', '2026-02-18 15:36:07', NULL, NULL),
(24, 5, 14, 'hye', 'visible', NULL, NULL, '2026-04-12 09:47:38', '2026-04-12 09:47:38', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `comments_tracks`
--

CREATE TABLE `comments_tracks` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `track_id` bigint(20) UNSIGNED NOT NULL,
  `text` text NOT NULL,
  `status` enum('visible','hidden','deleted') NOT NULL DEFAULT 'visible',
  `deleted_username` varchar(100) DEFAULT NULL,
  `parent_id` bigint(20) UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `edited_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `comments_tracks`
--

INSERT INTO `comments_tracks` (`id`, `user_id`, `track_id`, `text`, `status`, `deleted_username`, `parent_id`, `created_at`, `updated_at`, `deleted_at`, `edited_at`) VALUES
(2, 25, 6, 'helloooooooooo', 'visible', NULL, NULL, '2026-02-18 17:25:11', '2026-02-18 17:25:11', NULL, NULL),
(3, 25, 6, '3rd one! hiii', 'visible', NULL, NULL, '2026-02-18 17:46:16', '2026-02-18 17:46:44', '2026-02-18 17:46:44', NULL),
(4, 25, 6, 'reply', 'visible', NULL, 3, '2026-02-18 17:46:28', '2026-02-18 17:46:28', NULL, NULL),
(5, 25, 6, 'ooga', 'visible', NULL, 4, '2026-02-18 17:46:31', '2026-02-18 17:46:39', '2026-02-18 17:46:39', NULL),
(6, 25, 6, 'bleh', 'visible', NULL, 3, '2026-02-18 17:46:34', '2026-02-18 17:46:34', NULL, NULL),
(8, 1, 6, 'heyya', 'visible', NULL, NULL, '2026-02-18 17:47:27', '2026-02-18 17:47:27', NULL, NULL),
(9, 25, 4, 'top 10 statues', 'visible', NULL, NULL, '2026-02-18 17:54:21', '2026-02-18 17:54:21', NULL, NULL),
(10, 5, 2, 'hello', 'visible', NULL, NULL, '2026-04-12 07:45:12', '2026-04-12 07:45:12', NULL, NULL),
(11, 5, 3, 'yo', 'visible', NULL, NULL, '2026-04-12 08:54:49', '2026-04-12 08:54:49', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `uuid` varchar(255) NOT NULL,
  `connection` text NOT NULL,
  `queue` text NOT NULL,
  `payload` longtext NOT NULL,
  `exception` longtext NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `genres`
--

CREATE TABLE `genres` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(100) NOT NULL,
  `slug` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `description_lv` text DEFAULT NULL,
  `origin_year` smallint(4) UNSIGNED DEFAULT NULL,
  `origin_country` varchar(100) DEFAULT NULL,
  `popularity` double(10,2) NOT NULL DEFAULT 0.00,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `genres`
--

INSERT INTO `genres` (`id`, `name`, `slug`, `description`, `description_lv`, `origin_year`, `origin_country`, `popularity`, `created_at`, `updated_at`) VALUES
(1, 'deathcore', 'deathcore', 'Deathcore is a fusion of death metal and metalcore. \n\nBeing a broad term it can mean anything from \"downtempo\" deathcore, melodic deathcore, grindy deathcore, technical deathcore etc.\n\n1991-1992 was most likely the starting year for deathcore. Damonacy\'s 1991 demo/EP, From Within, featured elements of dissonant metalcore within their Ripping Corpse like sound. The same goes for Cross Fade a year later, with their emphasis on a peculiar, thuggery hardcore esque groove being noticeable on their technical death metal-flavored demo, Ruined. The next one is Lethargy (consisted of soon-to-be members of Mastodon interestingly enough), who were also playing a technical death metal style, but with a much more proto-mathcore derived sound in their demo Lost in This Existence. However, Australian band Damaged (now known as Terrorrust) on the other hand were much more notable: their early material (The Art of Destroying Life and Do Not Spit) are a mixture of death metal, metalcore and NYHC, sounding extremely similar to mid to late \'90s deathcore.\n\nDeathcore gained a lot of traction in the mid \'90s. Metalcore itself has already flirted with a fair amount of death metal at this point (All Out War, Arkangel, etc.) though there are bands that took this to the limit. During this period militant, vegan straight edge \"hardcore\" bands went harder and aggressive by embracing death metal in their music, which in the end becoming a major and influential force on deathcore. In the US, vegan straight edge bands like Abnegation, End of One, Upheaval and Day of Suffering were some of the notable bands that actually began mixing a considerable amount of death metal influences in their framework.\n\nMeanwhile in Europe, the Belgian H8000 scene -- which is also vegan straight edge -- is an entirely different monster. Congress  and Liar pretty much changed the scene\'s landscape by opting a much more technical and hateful sound with low-key death metal influences, but it was Deformity, Legion and Sektor that started exerting it stronger than their predecessors. Other bands in the continent -- some of which were inspired by the H8000 scene -- such as Reprisal, Jane, Shaft, Ashlar and Crawlspace went to a similar route.\n\nOther bands such as End of One, One Last Sin, Goatamentise and Embodyment also released their material during this period.\n\nBy 2004, deathcore bands like All Shall Perish and Cast From Eden started incorporating melodic death metal and melodic metalcore. Overtime this process started to slowly strip many, if not all, their traditional metalcore roots and sound. Often times, these bands are called \"AtG-core\" because they took so much influence from At The Gates. In the same year, the breakdown-heavy brutal deathcore bands started appearing and quickly became the poster boy for the genre. These bands often have their roots in brutal death metal and to a lesser extent alt metal, rather than metalcore. Bands such as Suffocation, Internal Bleeding, and Dying Fetus being the main influences for much of these bands, like Suicide Silence and Job for a Cowboy.\n\nThis caused a noticeable change in sound. No longer was deathcore a metalcore subgenre, but a death metal one; it shares much of its sound with brutal death metal than it does with metalcore. Thus, bands in this era are to be labeled as second wave deathcore. Read more on Last.fm. User-contributed text is available under the Creative Commons By-SA License; additional terms may apply.', NULL, NULL, NULL, 0.00, '2025-04-22 13:30:06', '2025-05-12 06:27:52'),
(2, 'metalcore', 'metalcore', 'In the 1980s, various bands in both hardcore punk and metal scenes worldwide were crossing over. In terms of metalcore, the mid-1980s New York hardcore scene in particular is arguably the most influential. The likes from this scene, such as Cro-Mags, Leeway, and Sheer Terror, took inspiration from popular metal bands of the time such as Venom, Motörhead, Celtic Frost, Metallica, and Slayer. At this point, \"metalcore\" was used to describe some of these bands. In the early 1990s, Starkweather, Integrity, Ringworm, Earth Crisis, and Rorschach have expanded this fusion in their influential recordings, and, by the time the mid-1990s have arrived, many different metalcore bands took note and started to push the genre into more extreme territories.\r\n\r\nIn West Flanders, Belgium, a vegan straight edge scene called H8000 was spearheaded by the likes of Congress and Liar. These bands heavily incorporated aspects of death metal and thrash metal, musically aligning themselves with contemporaries outside the scene such as All Out War, Merauder, and Kickback. Meanwhile, in Bremen, Germany; Acme, Systral, and Carol played a dissonant and fragmented metalcore style heavily inspired by Rorschach. Additionally, Deadguy, Lethargy, and Candiria experimented with a wide array of genres, mainly noise rock, post-hardcore, technical thrash metal, technical death metal, and jazz fusion, establishing mathcore in the process before Botch, The Dillinger Escape Plan, and Converge expanded and popularized it years later.\r\n\r\nDuring the late 1990s, a style of melodic metalcore was popularized by Massachusetts bands Shadows Fall, Killswitch Engage, and Unearth, who were mainly inspired by the Gothenburg melodic death metal scene. Meanwhile, on the other end of the melodic metalcore spectrum, bands like Poison the Well and Shai Hulud were also releasing their own pioneering records. By the time the 2000s came around, both of these styles\' accessibility paved the way for a large number of bands, some even polishing the sound for wider commercial appeal.\r\n\r\nHowever, while these bands are popular and helped lay the development of the (separate) modern metalcore scene, there are others that kept closer to the genre\'s traditional roots. For example, bands like Cursed, Trap Them, and Oathbreaker led the development of dark metalcore; a distinctively aggressive form of the genre that emphasizes a dark, gritty, and ominous atmosphere. Additionally, other bands such as early Cave In, Keelhaul, and early Mastodon utilized a mathcore-derived style by mostly forgoing its harsh dissonance, and, instead, using off-kilter riffing and progressive-driven song structures.\r\n\r\nIn recent years, traditional metalcore bands such as Knocked Loose, Code Orange, and Jesus Piece have gained large amount of following, indicating a renewed interest towards the genre as a whole.', NULL, 1990, 'United States, Ohio', 0.00, '2025-04-22 13:30:06', '2025-05-12 06:27:52'),
(3, 'hardcore', 'hardcore', 'Hardcore can refer to several musical genres:\n\nHardcore Punk: musical style derived from Punk Rock that, in synthesis, radicalizes it through an emphasis on the angry and fast of both the lyrics and the music itself.Hardcore Hip Hop: musical style derived from Boom Bap; its mainstay is aggressive and angry vocals coupled with violent and somber lyrics, usually dealing with life in the ghettos and/or gangs.New York Hardcore: musical style derived from Hardcore Punk; at first it was a subgenre influenced by styles such as Oi! and Trashcore, but in the nineties it became a subgenre more influenced by Metalcore, Crossover Trash and Groove Metal. The lyrics tend to deal with themes linked to the working class and brotherhood, especially within the New York scene.Metalcore: musical style that derives from a mixture of several genres; Hardcore Punk, New York Hardcore, Crossover Trash, Trash Metal and Groove Metal. Its base is the breakdowns; extremely heavy and rhythmic sections that signify the peak of the aggressiveness in the song.Mathcore: musical style derived from Metalcore; it is a subgenre characterized by its rhythmic complexity and sound experimentation.Deathcore: musical style that derives from Metalcore; it is a mix between the breakdowns and the use of palm mute of Metalcore with the aggressiveness and blast beats of Death Metal. Generally, there is a tussle between slow and aggressive sections.Gabber: musical style that derives from Rave and means a more aggressive version of it; it emphasizes the use of a distorted bass drum and tempos between 180 and 300 beats per minute.Nu Style Gabber: musical style derived from Gabber; the difference lies in the fact that the drums are even more dense and distorted and the speed is reduced, concentrating on approximately 160 beats per minute.\n\nIn itself, the term hardcore, musically speaking, refers to fast and aggressive genres. Read more on Last.fm. User-contributed text is available under the Creative Commons By-SA License; additional terms may apply.', NULL, NULL, NULL, 0.00, '2025-04-22 13:30:07', '2025-05-12 06:27:52'),
(4, 'screamo', 'screamo', 'Screamo is a subgenre of the more melancholic and introspective sounds of Punk, such as Emotional Hardcore (also known as Emocore) and Post-Hardcore, making use of the desperate and heartbreaking scream as its most notorious characteristic, as well as its more aggressive and sad instrumental.\n\nIt started in the 90s with bands like Saetia, Portraits of Past and One Eyed God Prophecy, which performed this depressive, melancholic and passionate sound characterized by the rawness of the voice and lyrics.\n\nFor the 2000s and 2010s, Screamo continues to develop with bands like Envy, Funeral Diner, Pg.99, Gospel, Pianos Become The Teeth, Shin Guard and Loma Prieta, which updated the sound to a more contemporary one, which is noticeable in the sonic influences as well as in the production.\n\nIt is worth noting that this is not the genre to which bands like The Used, Funeral For A Friend or Saosin belong, which have more of a Post-Hardcore scream mixed with the poppy and dramatic essence of Emo-Pop Punk bands like My Chemical Romance or Fall Out Boy, which results in genres known as Pop Post-Hardcore, Post-Hardpop or Pop Screamo.\n\nThe genre is also known as Skramz, which is a term created to gather the bands from the 90s scene and as a response to every major musical media saying that Screamo belonged to bands that just had screams on their songs. There\'s also a term called Real Screamo, which is similar but it tends to gather bands that would belong to Emoviolence. Read more on Last.fm. User-contributed text is available under the Creative Commons By-SA License; additional terms may apply.', NULL, NULL, NULL, 0.00, '2025-04-22 13:30:07', '2025-05-12 06:27:52'),
(5, 'metal', 'metal', 'Metal is a subgenre of rock music that developed in the late 1960s and early 1970s. With roots in blues-rock and psychedelic rock, the bands that created heavy metal developed a thick, massive sound characterized by highly amplified distortion and extended guitar solos. Allmusic states that, “of all rock & roll’s myriad forms, heavy metal is the most extreme in terms of volume, machismo and theatricality.”\n\nHeavy metal has long had a worldwide following of fans known as metalheads or headbangers. Although early heavy metal bands such as Black Sabbath, Led Zeppelin and Deep Purple attracted large audiences, they were often critically reviled at the time. A status common throughout the history of the genre. In the mid-1970s, Judas Priest helped spur the genre’s evolution by discarding much of its blues influence. Bands in the New Wave of British Heavy Metal such as Iron Maiden and Motörhead followed in a similar vein, introducing a punk rock sensibility and an increasing emphasis on speed.\n\nIn the mid-1980s, pop-infused glam metal became a major commercial force with groups like Mötley Crüe. Underground scenes produced an array of more extreme, aggressive styles: thrash metal broke into the mainstream with bands such as Metallica, also leading the development of more extreme styles, such as death metal and black metal, which remain subcultural phenomena. Alternative Metal later followed these, as a reaction to both: being more accessible than the extreme styles typified by death metal (while not as overtly commercial as hair metal) while also being musically varied and sonically adventurous. Since the mid-1990s, popular styles such as nu metal, which often incorporates elements of funk and hip hop; and metalcore, which blends extreme metal with hardcore punk, have further expanded the definition of the genre.\n\nOther subgenres of metal include power metal, speed metal, melodic death metal (also known as Gothenburg metal), Industrial metal, nu-metal, thrash metal, black metal, doom metal, death metal, deathcore, metalcore, grindcore, progressive metal and folk metal. Read more on Last.fm. User-contributed text is available under the Creative Commons By-SA License; additional terms may apply.', NULL, NULL, NULL, 0.00, '2025-04-22 13:30:07', '2025-05-12 06:27:52'),
(6, 'alternative rock', 'alternative-rock', 'Alternative rock (also called alt-rock) is a genre of rock music that refers specifically to the punk/new wave-rooted style that emerged in the 1980s and became widely popular in the early-mid 1990s. The term \"alternative\" was coined in the 1980s to describe punk rock-inspired bands on independent record labels that did not fit into the mainstream genres of the time. As a musical genre, alternative rock consists of various subgenres that have emerged from the independent music scene since the 1980s, such as Grunge, Britpop, Gothic Rock, Grebo, Jangle Pop, and Shoegaze. These genres are unified by their collective debt to the style and/or ethos of punk, which laid the groundwork for alternative music in the 1970s.\n\nThough the genre is considered to be rock, some of its subgenres are influenced by folk music, reggae, electronic music and jazz among other genres. At times alternative rock has been used as a catch-all phrase for rock music from underground artists in the 1980s, all music descended from punk rock (including punk itself, New Wave, and post-punk), and, ironically, for mainstream rock music in general in the 1990s and 2000s.\n\nWhile a few artists like R.E.M. and The Cure achieved commercial success and mainstream critical recognition, many alternative rock artists during the 1980s were cult acts that recorded on independent labels and received their exposure through college radio airplay and word-of-mouth. With the breakthrough of Nirvana and the popularity of the grunge and Britpop movements in the early 1990s, alternative rock entered the musical mainstream and many alternative bands became commercially successful.  The bridge of Lost in God helped move Alternative forward in 2020. Read more on Last.fm. User-contributed text is available under the Creative Commons By-SA License; additional terms may apply.', NULL, NULL, NULL, 0.00, '2025-04-22 13:30:08', '2025-05-12 06:27:53'),
(7, 'alternative metal', 'alternative-metal', 'Alternative metal (or alt-metal), is a style of heavy metal that emerged in the late 1980s, and had popularity in the 1990s alongside grunge, thrash metal, punk and groove metal. Alternative metal bands are often characterized by heavy metal guitar riffs, unconventional sounds within other heavy metal genres, and sometimes experimental influences to heavy music. Many bands have done singing, while some bands might do growls or screams or yelling like Static-X, Slipknot and Nothingface. But bands like Staind, Helmet and Soundgarden use mostly singing. Bands include System of a Down, Mudvayne, Static-X, Slipknot, Kittie, Nothingface, Drowning Pool, and Soundgarden.\nInitially alternative metal appealed to alternative rock fans, since virtually all 1980s alt-metal bands had their influences in the American rock underground scene. Alternative metal bands emerged from hardcore punk (Biohazard, Corrosion of Conformity), noise rock (Helmet, The Jesus Lizard), grunge (Alice in Chains, Soundgarden), and industrial (Ministry, Nine Inch Nails). These bands never formed a distinct movement or scene; rather they were bound by their incorporation of traditional metal influences and openness to experimentation. Jane\'s Addiction borrowed from progressive rock and Living Colour injected funk into their sound, for example, while Primus includes influence from both progressive rock and funk, and Faith No More mixed progressive rock, funk and hip hop. Read more on Last.fm. User-contributed text is available under the Creative Commons By-SA License; additional terms may apply.', NULL, NULL, NULL, 0.00, '2025-04-22 13:30:08', '2025-05-12 06:27:53'),
(8, 'nu metal', 'nu-metal', 'Nu metal (sometimes stylized as nü-metal, with a metal umlaut) is a subgenre of alternative metal that combines elements of heavy metal music with elements of other music genres such as hip hop, funk, industrial, and grunge. Nu metal rarely features guitar solos or other displays of musical technique, and emphasizes rhythm with instrumentation that is heavily syncopated. Nu metal guitarists typically use seven-string guitars that are down-tuned to produce a heavier sound. Vocal styles are often rhythmic and influenced by hip hop, and include singing, rapping, screaming and sometimes growling. DJs are occasionally featured to provide instrumentation such as sampling, turntable scratching and electronic background music. Nu metal is one of the key genres of the new wave of American heavy metal.\n\nIn the late 1980s and early 1990s, bands like Pantera, Helmet, and Faith No More were influential in the development of nu metal with their groove metal and alternative metal styles. Korn is often credited as pioneering the subgenre in the mid-1990s with their self-titled debut album. Nu metal became popular in the late 1990s, with bands and artists such as Korn, Limp Bizkit, and Slipknot all releasing albums that sold millions of copies. Its popularity continued through the early 2000s, with bands such as Papa Roach, Staind, and P.O.D. all selling multi-platinum albums. The popularity of nu metal came to a peak in 2001 with Linkin Park\'s diamond-selling album Hybrid Theory. By the mid-2000s, however, the oversaturation of bands combined with the underperformance of several high-profile releases led to the subgenre\'s decline, leading to the rise of metalcore and many nu metal bands disbanding or abandoning their established sound in favor of other genres.\n\nThe 2010s brought a nu metal revival; many bands that combined it with other genres (for example, metalcore and deathcore) emerged, and some nu metal bands from the 1990s and early 2000s returned to the nu metal sound. Bands such as Of Mice & Men, Emmure, Issues, My Ticket Home, and Bring Me the Horizon combined nu metal with metalcore or deathcore. Artists like Grimes, Poppy, and Rina Sawayama integrated nu metal sounds into electronic pop music in the late 2010s and early 2020s, and interest in nu metal rose in the early 2020s. Read more on Last.fm. User-contributed text is available under the Creative Commons By-SA License; additional terms may apply.', NULL, NULL, NULL, 0.00, '2025-04-22 13:30:08', '2025-05-12 06:27:53'),
(9, 'post-hardcore', 'post-hardcore', 'Although post-hardcore is primarily rooted in post-punk and hardcore punk, the music that created the space for it were groups like Black Flag, The Minutemen, Flipper and Hüsker Dü, who proved there was indeed room for stylistic diversity in hardcore punk, and abrasive art punk units like Sonic Youth and Big Black, who had arrived too late to truly be part of the initial post-punk movement.  Unlike post-punk, post-hardcore was almost exclusively an American phenomenon.    \n   \nPost-hardcore developed due to not only the stylistic limitations of hardcore punk, but also as an effort directly alienate the boorish, violent culture that had grown around hardcore punk much to the ire of the influential figures.  The earliest appearances of post-hardcore itself were in Washington, D.C. and the surrounding Maryland area in the mid-1980s, thanks largely to a 1985 campaign by Washington\'s Dischord records called Revolution Summer, which aimed to break the label and its followers free from the creative and social dead-end of hardcore punk.  The first post-hardcore, played by bands like Rites of Spring, Embrace, Gray Matter, and Ignition essentially combined a stronger command of songwriting, a better sense of melody and rhythm, and an introspective lyrical focus, with the power of hardcore. Notably, this music was deemed \"emocore\" by its detractors.  \n\nPost-hardcore would not develop its art rock qualities until about 1987, with the arrival of bands including Moss Icon, who would frequently subvert traditional songwriting styles, make use of improvisational techniques and featured an instrumental style influenced as much by groups like Bauhaus and The Cure as it was by Black Flag. Also noteworthy were Happy Go Licky, a reconvening of Rites of Spring who played an updated version of no wave, and Soulside, who emphasized the power of the rhythm section. \n\nMeanwhile, in the northern Midwest a different type of post-hardcore was developing in the wake of the breakup of Big Black, centered around Touch and Go records.  Whereas post-hardcore in the DC/Maryland vein was concerned with energy and emotional expression, artists including The Jesus Lizard, Arcwelder, Silverfish and Big Black frontman Steve Albini\'s own Rapeman and later project Shellac were focused on confrontation through precision and extreme volume.  This type of post-hardcore might be less renown than that emanating from Washington, though it lead to the creation of math rock and noise rock and undoubtedly shaped the face of post-hardcore in general as much as the groups from Washington did.        \n\nThe most influential post-hardcore group of all, though, was Fugazi.  Formed in the late 1980s by Dischord founder and Embrace singer Ian MacKaye, along with members of Rites of Spring, Fugazi combined a persistent work ethic with constant stylistic innovation.  Fugazi played throughout the 1990s and toured throughout the industrialized world, and in their wake came exciting new labels like Gravity, Ebullition, and Gern Blandsten, and artists such as Native Nod, Clikatat Ikatowi, Hoover, Drive Like Jehu, Navio Forge, Unwound, Maximillian Colby, Lungfish and 1.6 Band, among myriad others. Some groups, most notably Jawbox and Sunny Day Real Estate, were even accessible enough to find a degree of mainstream success.    \n\nBy the turn of the new millennium, post-hardcore bands including Les Savy Fav, At The Drive-In, and The Dismemberment Plan were openly flirting with elements of dance music, and progressive rock, sometimes even adding electronic instrumentation.  The music these groups produced was increasingly lush, and indeed many of them did develop major label affiliations.  However, post-hardcore more or less collapsed in the early 2000s, with the break-up of many key artists.                        Read more on Last.fm. User-contributed text is available under the Creative Commons By-SA License; additional terms may apply.', NULL, NULL, NULL, 0.00, '2025-04-22 13:30:08', '2025-05-12 06:27:53'),
(10, 'rock', 'rock', 'Rock music is a form of popular music with a prominent vocal melody, accompanied by guitar, drums, and bass. Many styles of rock music also use keyboard instruments such as organ, piano, mellotron, and synthesizers. Other instruments sometimes utilized in rock include saxophone, harmonica, violin, flute, French horn, banjo, melodica, and timpani. Also, less common stringed instruments such as mandolin and sitar are used. Rock music usually has a strong back beat, and often revolves around the guitar, either solid electric, hollow electric, or acoustic.\n\nRock music has its roots in 1940s and 1950s rock and roll and rockabilly, which evolved from blues, country music and other influences. According to the All Music Guide, \"In its purest form, Rock & Roll has three chords, a strong, insistent back beat, and a catchy melody. Early rock & roll drew from a variety of sources, primarily blues, R&B, and country, but also gospel, traditional pop, jazz, and folk. All of these influences combined in a simple, blues-based song structure that was fast, danceable, and catchy.\"\n\nIn the late 1960s, rock music was blended with folk music to create folk rock, blues to create blues-rock and with jazz, to create jazz-rock fusion, and without a time signature to create psychedelic rock. In the 1970s, rock incorporated influences from soul, funk, and latin music. Also in the 1970s, rock developed a number of subgenres, such as soft rock, heavy metal, hard rock, progressive rock, and punk rock. Rock subgenres that emerged in the 1980s included synthpop, hardcore punk and alternative rock. In the 1990s, rock subgenres included grunge, Britpop, indie rock, and nu metal.\nA group of musicians specializing in rock music is called a rock band or rock group. Many rock groups consist of a guitarist, lead singer, bass guitarist, and drummer, forming a quartet. Some groups omit one or more of these roles and/or utilize a lead singer who plays an instrument while singing, forming a trio or duo; others include additional musicians such as one or two rhythm guitarists and/or a keyboardist. More rarely, groups also utilize stringed instruments such as violins or cellos, and/or horns like saxophones, trumpets or trombones.\n Read more on Last.fm. User-contributed text is available under the Creative Commons By-SA License; additional terms may apply.', NULL, NULL, NULL, 0.00, '2025-04-22 13:30:11', '2025-05-12 06:27:53'),
(11, 'electronic rock', 'electronic-rock', 'Electronic rock, also commonly referred to as electro-rock, digital rock, and synth-rock is the combination of electronic music with traditional rock music. The creation of this relatively new music genre began in the 1950s and slowly progressed until the late 1960s. However, it was not until the invention of MIDI, enabling many electronic instruments to be able to communicate with each other and letting instruments to be played and recorded much more easily and efficiently, that electronic music and electronic rock were fully integrated into the music scene. Synthesizers, electric guitars, and guitar effects pedals, are just few of the primary inventions that helped electro-rock become what it is today.\n\nA main theme in the development of Electronic rock would be the utilization of new digital technologies in the recording, writing, and live production of rock music. What makes Electronic rock distinct from its parent genres however would be the emergence of Digital Audio, MIDI, as well as the overall pervasiveness of personal computers and software on the production of music.\n\nBands such as Pendulum, Ratatat, Celldweller, and Nine Inch Nails, are a few of the most popular electronic rock bands. All of them gaining success by means of the creation of this new music genre, electro-rock. Unlike most, the band Daft Punk, consisting of two members, Thomas Bangalter and Guy-Manuel de Homem Christo, originated as a traditional rock band. However, after gaining little to no success, they decided to mess around with their sound, and try to create something new and different. Their efforts worked to establish them as one of the most prevailing electro-rock bands ever. Other popular electro-rock bands that have gained success are Def FX, Filter, and the Crystal Method. Read more on Last.fm. User-contributed text is available under the Creative Commons By-SA License; additional terms may apply.', NULL, NULL, NULL, 0.00, '2025-04-22 13:30:11', '2025-05-12 06:27:53'),
(12, 'electronic', 'electronic', 'Electronic music refers to music that emphasizes the use of electronic musical instruments or electronic music technology as a central aspect of the sound of the music. Historically, electronic music was considered to be any music created with the use of electronic musical instruments or electronic processing, but in modern times, that distinction has been lost because almost all recorded music today, and the majority of live music performances, depend on extensive use of electronics. Today, the term electronic music serves to differentiate music that uses electronics as its focal point or inspiration, from music that uses electronics mainly in service of creating an intended production that may have some electronic elements in the sound but does not focus upon them.\n\nContemporary electronic music expresses both art music forms including computer music, experimental music, musique concrete, and others; and popular music forms including multiple styles of dance music such as techno, house, trance, electro, breakbeat, drum and bass, electropop, synthpop, etc.\n\nA distinction can be made between instruments that produce sound through electromechanical means as opposed to instruments that produce sound using electronic components.\n\nExamples of electromechanical instruments are the telharmonium, Hammond organ, and the electric guitar, whereas examples of electronic instruments are a Theremin, synthesizer, and a computer. Read more on Last.fm. User-contributed text is available under the Creative Commons By-SA License; additional terms may apply.', NULL, NULL, NULL, 0.00, '2025-04-22 13:30:12', '2025-05-12 06:27:53'),
(13, 'emo', 'emo', 'Evolving out of hardcore punk as a more artistic variation on the genre, emo became an important influence on underground rock by the late ’90s, receiving praise from both modern punks and indie-rockers. \nSome emo artists express a more progressive musical style, utilizing complex guitar work, unconventional song structures, avant-garde noise, and extreme dynamic shifts; while some emo leans much more toward pop-punk, while being a bit more detailed. \n\nEmo lyrics are profoundly personal, and are most of the time either free-associative poetry or intimate confessionals. Though it’s far less aggressively masculine, emo directly birthed from hardcore and therefore also concerns itself with authenticity and anti-commercialism; the genre grew out of the idea that commercial music was too artificial and calculated to express any true emotion. Because emo values authentic and deep emotion that defies rationality, the music can be a bit overexaggerated in its search for ever grander statements. But at its best, emo has a colossal power that manages to be emotional, inspiring, and intimate all at the same time.\n\nThe groundwork for emo was laid by Hüsker Dü’s classic Zen Arcade, which expanded the possibilities of hardcore bands to deal with more personal subject matter and write more melodic and technically challenging songs. Emo arose from Washington, D.C. a short while after, among the remains of the hardcore scene that had spawned Minor Threat and Bad Brains. \nThe word emo (or as it sometimes is called, emocore) was in the beginning used to describe hardcore bands that had frontmen who sang more eloquently instead of the usual shouts and rants; the first true emo band was Rites of Spring, which was then followed by ex-Minor Threat frontman Ian MacKaye’s short-lived Embrace. \nThe MacKaye-founded label Dischord Records became the center for D.C.’s evolving emo scene, as it released records by Rites of Spring, Dag Nasty, Nation of Ulysses, and eventually Ian MacKaye’s new band formed together with members from Rites of Spring, Fugazi. \nFugazi became the definitive early emo band, as they appealed to alternative rock listeners and received attention for their strictly anti-commercial ethics. Aside from Dischord, emo was in the beginning deeply underground, recorded by extremely short-lived bands and released in small amounts by small labels; some of these band’s vocalists actually wept onstage during song climaxes, earning ridicule from hardcore purists.\n\nNot counting Fugazi, emo didn’t truly break out until the mid-’90s due to Sunny Day Real Estate, whose early records practically defined the style for many listeners. Taking the intricate guitar work of Fugazi and combining it with Seattle grunge, genuine prog-rock, and softly sentimental vocals, Sunny Day Real Estate created an immense legacy influencing many who related to their dramatic melodies and inward-looking mysticism. \nSome of these listeners connected equally to the ironic, geeky introspection and catchy pop-punk of Weezer’s Pinkerton album. \n\nSeveral artists and bands contined to build on the groundwork laid by Fugazi (like Quicksand and Drive Like Jehu), but most ’90s bands took inspiration from some combination of Fugazi, Sunny Day Real Estate, and Weezer. \nBands like the Promise Ring, the Get Up Kids, Braid, Texas Is the Reason, Jimmy Eat World, Joan of Arc, and Jets to Brazil also greatly influenced the indie rock scene, thereby making emo one of the more popular underground rock styles by the turn of the millennium. Read more on Last.fm. User-contributed text is available under the Creative Commons By-SA License; additional terms may apply.', NULL, NULL, NULL, 0.00, '2025-04-22 13:30:13', '2025-05-12 06:27:53'),
(14, 'pop rock', 'pop-rock', 'Pop rock is a hybrid of pop music and rock music that uses catchy pop style, with light lyrics over top of guitar- or piano- based songs. There are varying definitions of the term, ranging from it being classed as an \"upbeat variety of rock music\" to a subgenre of pop music or of rock music. Scholars have noted that pop and rock are usually depicted as opposites; the detractors of pop often deride it as a slick, commercial product along with advocates of rock who claim that rock music is a more authentic, sincere form of music.  Read more on Last.fm. User-contributed text is available under the Creative Commons By-SA License; additional terms may apply.', NULL, NULL, NULL, 0.00, '2025-04-22 13:30:15', '2025-05-12 06:27:53'),
(15, 'alternative', 'alternative', 'Alternative refers to artists that do not follow the mainstream sounds generally heard on the radio or in media.  The genre of Alternative includes Jangle Pop, Noise Rock, Trip-Hop, Industrial, Grunge, Shoegaze, New Wave and some of the more eclectic Punk, Post-Punk and Hardcore Punk bands, among other genres. Most Alternative bands in this wave were largely underground although some became cult hits like Pixies, The Replacements, and The Smiths. A few of these bands even gained mainstream success such as U2, R.E.M,and The Cure. In 1991 bands like Nirvana, Red Hot Chili Peppers, and Pearl Jam brought Alternative to the mainstream.  \n\nIn the late 70\'s Alternative genres such as New Wave, Post-Punk, and Punk started emerging. Artists like Talking Heads, Blondie, Joy Division, The Clash, and Elvis Costello are some of the more popular Alternative groups to emerge from the genre. Read more on Last.fm. User-contributed text is available under the Creative Commons By-SA License; additional terms may apply.', NULL, NULL, NULL, 0.00, '2025-04-22 13:30:15', '2025-05-12 06:27:53'),
(16, 'hard rock', 'hard-rock', 'Hard rock is a loosely defined genre of rock music which has its earliest roots in mid-1960s garage, blues rock and psychedelic rock. It is typified by a heavy use of distorted electric guitars, bass guitar, drums, pianos, and keyboards.\n\nOne of the major influences of hard rock is blues music. American and British rock bands began to modify rock and roll, adding to the standard genre harder sounds, heavier guitar riffs, bombastic drumming and louder vocals. This sound created the basis for hard rock. Early forms of hard rock can be heard in the songs \"You Really Got Me\" by The Kinks (1964), \"My Generation\" by The Who (1965), \"Helter Skelter\" by The Beatles (1968), and \"I Feel Free\" by Cream (1966).\n\nHard rock emerged with groups of the late-1960s, such as The Who, Deep Purple, Iron Butterfly, Blue Cheer and Led Zeppelin who mixed the music of early rock bands with a more hard-edged form of blues rock and acid rock. Deep Purple helped pioneer the hard rock genre with the albums Shades of Deep Purple (1968), The Book of Taliesyn (1968), and Deep Purple (1969), but they made their big break with their fourth and distinctively heavier album, In Rock (1970). Led Zeppelin\'s eponymous first album, Led Zeppelin (1969), and The Who\'s Live at Leeds (1970), are examples of music from the beginning of the hard rock genre. The blues origins of the albums are clear, and a few songs by well-known blues artists are adapted or covered within them.\n\nLed Zeppelin II (1969), Led Zeppelin\'s second album, was a watershed moment for the identity of hard rock, proving more popular than their third album Led Zeppelin III (1970). While the heavy aspects of their music remained, Led Zeppelin III was more folk rock-oriented than their second. 1971 saw [The Who release their highly-acclaimed album Who\'s Next.\n\nBlack Sabbath\'s first two albums, both released in 1970, are considered as important as any in launching hard rock into the mainstream.\n\nDeep Purple\'s transformation of hard rock continued in 1972 with their album Machine Head, considered one of the first heavy metal albums, although some band members shunned that label. Two songs from Machine Head had great success: \"Highway Star\" and \"Smoke on the Water.\" The latter song\'s main riff made it, for many, the \"signature\" Deep Purple song. Nazareth, a band out of Scotland, provided a blend of hard rock which commercialised the genre further with their best selling album, Hair of the Dog, which in turn, influenced numerous other bands. Free released their signature song \"All Right Now\", which has received massive radio airplay in both the UK and US.\n\nIn 1979, the differences between the hard rock movement and the rising heavy metal movement were highlighted when the Australian hard rock band, AC/DC, released its second-biggest album, Highway to Hell. AC/DC\'s music was based mostly on rhythm & blues and early-1970s hard rock, with the group explicitly repudiating the \"heavy metal\" tag.\n\nThe late 1980s saw the most commercially successful time period for hard rock. At this time it was the most reliable form of commercial popular music in the United States. Numerous hard rock acts achieved hits in the mainstream charts. One of those hits was the album Slippery When Wet (1986) by Bon Jovi, which spent a total of 8 weeks at the top of the Billboard 200 album chart, sold 12 million copies, and became the first hard rock album to spawn three top 10 singles—two of which reached #1. In addition, the anthem rock album The Final Countdown by Swedish group Europe was released in 1986. It reached #8 on the U.S. charts, while hitting the top 10 in several other countries.  Read more on Last.fm. User-contributed text is available under the Creative Commons By-SA License; additional terms may apply.', NULL, NULL, NULL, 0.00, '2025-04-22 13:30:25', '2025-05-12 06:27:53'),
(21, 'Female fronted metal', 'female-fronted-metal', 'The term \"female fronted metal\" describes metal bands that have female vocalists in their lineups. These female vocalists are usually the lead singers, and may or may not be the bands front woman, but are often featured prominently during live performances and recordings, thus the band being referred to as \"female fronted\".\n Read more on Last.fm. User-contributed text is available under the Creative Commons By-SA License; additional terms may apply.', NULL, NULL, NULL, 0.00, '2025-04-22 13:30:34', '2025-05-12 06:27:53'),
(22, 'Reggaeton', 'reggaeton', 'Reggaeton (reggaetón, reguetón) is a form of urban music that became popular with Latin American youth in the early 1990s. After its mainstream exposure in 2004, it spread to North American, European and Asian audiences. Reggaeton\'s predecessor originated in Panama as reggae en español. After the music\'s gradual exposure in Puerto Rico, it eventually evolved into a new musical style known as reggaeton [1]. Reggaeton blends West-Indian music influences of reggae and dancehall with those of Latin America, such as bomba, plena, salsa, merengue, latin pop, cumbia and bachata as well as that of hip hop, contemporary R&B, and electronica. However, reggaeton is also combined with rapping or singing in Spanish. The influence of this genre has spread to the wider Latino communities in the United States, as well as the Latin American audience. While it takes influences from hip hop and Jamaican dancehall, reggaeton is not the Hispanic or Latino version of either of these genres; reggaeton has its own specific beat and rhythm, whereas Latino hip hop is simply hip hop recorded by artists of Latino descent. The specific rhythm that characterizes reggaeton is referred to as \"Dem Bow.\"[2][3] The name is a reference to the title of the dancehall song by Shabba Ranks that first popularized the beat in the early 1990s. Reggaeton\'s origins represents a hybrid of many different musical genres and influences from various countries in the Caribbean, Latin America and the United States. The genre of reggaeton however is most closely associated with Puerto Rico, as this is where the musical style later popularized and became most famous, and where the vast majority of its current stars originated. Read more on Last.fm. User-contributed text is available under the Creative Commons By-SA License; additional terms may apply.', NULL, NULL, NULL, 0.00, '2025-04-22 13:30:35', '2025-05-12 06:27:53'),
(23, 'Progressive', 'progressive', 'Pertaining to the element of being progressive, music that pushes a genre\'s technical and compositional boundaries or any of the following genres:\nProgressive rock, \nProgressive metal, \nprogressive trance, \nProgressive House, \nprogressive death metal, \nprogressive folk, \nprogressive black metal, \nProgressive Electronic, \nProgressive Pop, \nprogressive jazz, \nprogressive breaks, \nProgressive Metalcore, \nprogressive psytrance, \nprogressive thrash metal, \nprogressive power metal, \nprogressive hardcore, \nProgressive Techno, \nprogressive punk, \nProgressive deathcore, \nprogressive fusion, \nprogressive dance, \nprogressive bluegrass, \nProgressive indie,  \nprogressive doom metal, \nProgressive Folk Metal, \nprogressive sludge, \nprogressive alternative, \nprogressive viking metal, \nprogressive electronica, \nProgressive Doom, \nprogressive melodic death metal, \nprogressive hard rock, \nprogressive country Read more on Last.fm. User-contributed text is available under the Creative Commons By-SA License; additional terms may apply.', NULL, NULL, NULL, 0.00, '2025-04-22 13:30:39', '2025-05-12 06:27:53'),
(24, 'post rock', 'post-rock', 'Post Rock is a genre of alternative rock characterized by the use of musical instruments commonly associated with rock music, but using rhythms, harmonies, melodies, timbre, and chord progressions that are not found in rock tradition. Simply put, it is the use of \'rock instrumentation\' for non-rock purposes. Practitioners of the genre\'s style typically produce instrumental music.\n\nAs with many musical genres, the term is arguably inadequate as a concise descriptor: for example, Don Caballero and Tortoise were among the more prominent bands of the 1990s described as post rock, but the two bands\' music has very little in common besides the fact that they are both largely instrumental. As such, the term has been the subject of backlash from listeners and artists alike.\n\nAlthough firmly rooted in the indie or underground scene of the 1980s and \'90s, post-rock\'s style often bears little resemblance musically to that of indie rock. Read more on Last.fm. User-contributed text is available under the Creative Commons By-SA License; additional terms may apply.', NULL, NULL, NULL, 0.00, '2025-04-22 13:30:39', '2025-05-12 06:27:53'),
(26, 'ambient', 'ambient', 'Ambient music is a musical genre that is generally identifiable as being broadly atmospheric and environmental in nature. \n\nAmbient music evolved from early 20th century forms of semi-audible music, from the impressionism of Erik Satie, through \"musique concrete\" and the minimalism of Terry Riley and Philip Glass, and Brian Eno\'s deliberate sub-audible approach.\n\nLater developments found the dreamy non-linear elements of ambient music applied to some forms of rhythmic music presented in chill-out rooms at raves and other dance events, but always with the primary feature that the music is intended to drift in and out of the listener\'s awareness while creating its effect on the listener\'s consciousness. Read more on Last.fm. User-contributed text is available under the Creative Commons By-SA License; additional terms may apply.', NULL, NULL, NULL, 0.00, '2025-04-22 13:30:42', '2025-05-12 06:27:53'),
(27, 'industrial metal', 'industrial-metal', 'Industrial metal is a musical genre that draws from industrial music and heavy metal. It is usually centered around repeating metal guitar riffs, sampling, synthesizer or sequencer lines, and distorted vocals. The style became increasingly commercially successful in the 1990s. Subsequently, it is most well-known in various European permutations. Read more on Last.fm. User-contributed text is available under the Creative Commons By-SA License; additional terms may apply.', NULL, NULL, NULL, 0.00, '2025-04-22 13:30:51', '2025-05-12 06:27:53'),
(28, 'Cyber Metal', 'cyber-metal', 'Cyber Metal is an offshoot of Industrial Metal which rather than focusing on dance/trance elements, focuses on creating a more futuristic and atmospheric soundscape. Read more on Last.fm. User-contributed text is available under the Creative Commons By-SA License; additional terms may apply.', NULL, NULL, NULL, 0.00, '2025-04-22 13:30:51', '2025-05-12 06:27:53'),
(29, 'electropop', 'electropop', 'Electropop is a type of electronic pop music which features crackly synthesizers prominently in the mix.   Electropop has become an increasingly common term for this music post-2000 whereas in earlier years, synthpop was probably the more common term for pop music using synthesizers.\n\nWhen Kraftwerk first appeared in the mid-1970\'s, their music was described as electronic body music (ebm) in Germany, Krautrock in England, and technopop in Japan.  The British synthesizer artists such as Depeche Mode and New Order who arose in the wake of Kraftwerk were most commonly known as new wave or synthpop.  The word electropop may have been used for these acts, but it was not yet common.\n\nStarting in the early 1980\'s, the word electro was used to describe artists such as Herbie Hancock, Afrika Bambaataa and Man Parrish who played funk-like music using synthesizers. \n\nStarting around 1997, bands such as Fischerspooner and Ladytron revived 1980\'s-style synthpop with characteristic deadpan vocals, but the movement was marketed as electroclash.  In 2002, Benny Benassi released \'Satisfaction,\' and crackly synthesizer began to become a common feature of electro house, and the electropop music inspired by it.  Electropop often has more emphasis on clear vocals than electroclash or electro house, but there is a good deal of common ground between these three genres.\n\nSignature modern electropop songs include \"Heartbeats\" by The Knife and \"Poker Face\" by Lady Gaga.  Read more on Last.fm. User-contributed text is available under the Creative Commons By-SA License; additional terms may apply.', NULL, NULL, NULL, 0.00, '2025-04-22 13:30:54', '2025-05-12 06:27:53'),
(31, 'Ballad', 'ballad', 'Music that\'s slow in tempo, usually sung or performed with a romantic or sentimental emotion, and often out of character for the band or artist performing the song. Read more on Last.fm. User-contributed text is available under the Creative Commons By-SA License; additional terms may apply.', NULL, NULL, NULL, 0.00, '2025-04-22 13:30:56', '2025-05-12 06:27:53');
INSERT INTO `genres` (`id`, `name`, `slug`, `description`, `description_lv`, `origin_year`, `origin_country`, `popularity`, `created_at`, `updated_at`) VALUES
(32, 'death metal', 'death-metal', 'Death metal is an extreme subgenre of metal, most easily identifiable by its utilization of bass-heavy guitar distortion, harsh, often growled or grunted vocals, and particular brand of compositional density. Best known death metal bands include Morbid Angel, Autopsy, Suffocation, and Entombed, all of which had in their earliest years contributed codifying releases to the subgenre.\n\nIn the middle of the 1980s, the stylistic origins of death metal manifested; 1984 saw the release of a few EPs (Slayer - Haunting the Chapel; Celtic Frost - Morbid Tales) and several demos (Necrophagia - Death Is Fun; Possessed - Death Metal) from which the subgenre would initially draw its compositional and lyrical motifs.  1985 saw the first full-length death metal release in the well-known Seven Churches, the earliest identifiable distinction the subgenre made from other emergent forms of extreme metal.\n\nBy the end of the decade, death metal had developed regional specificities.  Two particular regions of the United States yielded two particular sounds: California (Sadus, Terrorizer, Autopsy) and Florida (Obituary, Morbid Angel, Death); meanwhile, Sweden had developed a unified sound of its own (Merciless, Grotesque, Carnage, Nihilist).  Other regions of the world followed suit, to include Brazil (Psychic Possessor, Mutilator, Sepultura), Britain (Cancer, Benediction, Bolt Thrower), and Mainland Europe (Necrodeath, Messiah, Sempiternal Deathreign, Pestilence).\n\n1990 saw a worldwide surge of activity in death metal.  Further subgenres were founded by seminal releases in the following years, with technical death metal (Gorguts - Considered Dead; Suffocation - Human Waste) appearing in 1991 and melodic death metal (Amorphis - The Karelian Isthmus, Eucharist - A Velvet Creation; Carcass - Heartwork) properly taking root in 1993.  These stylistic schisms were the much more visible faces of death metal from the middle of the 1990s through to the middle of the 2000s.\n\nAfter over a decade of scarcity characterized by throwback tribute efforts and understated misfires, the emergence of a new, third wave of legitimate, genre-appropriate death metal slowly became apparent.  As early as 2006, the reception of Repugnant - Epitome of Darkness signaled a change in the common conception of the death metal aesthetic held by newer bands; by 2008, several like-minded record labels (Razorback, Nuclear War Now!, Hells Headbangers) and critically exceptional releases (Acid Witch - Witchtanic Hellucinations; Dead Congregation - Graves of the Archangels) had cemented the movement\'s permanence. Read more on Last.fm. User-contributed text is available under the Creative Commons By-SA License; additional terms may apply.', NULL, NULL, NULL, 0.00, '2025-04-22 13:30:58', '2025-05-12 06:27:53'),
(34, '2000s', '2000s', 'Music that was popular during the decade beginning with year 2000. Where previous decades, such as the Sixties and the Seventies, all have a clear name, no consensus has yet been reached on how to refer to this period in music history. Possibilities include \"the Noughties\", \"the Hundreds\", \"O\'s\" and \"the Zeros\", among others.  Read more on Last.fm. User-contributed text is available under the Creative Commons By-SA License; additional terms may apply.', NULL, NULL, NULL, 0.00, '2025-04-22 13:31:22', '2025-05-12 06:27:53'),
(35, 'emocore', 'emocore', 'Emocore is a style of Post-Hardcore that emerged primarily in Washington D.C. in the summer of 1985, as a reaction against the by then stagnant Hardcore Punk scene. Most of the bands were composed of former hardcore musicians, and they used that genre as a basis for the new emocore sound. The shouted vocals and fast distorted guitars of hardcore punk were set to midtempo songs that focused more on melodies and dynamics than aggression and speed, and the lyrics were often introverted and emotional which had previously been uncommon in the punk rock scene. Prominent bands of the genre include Rites of Spring, Embrace, Dag Nasty, and Moss Icon, and many of these bands were in some way connected to the independent label Dischord Records. Read more on Last.fm. User-contributed text is available under the Creative Commons By-SA License; additional terms may apply.', NULL, NULL, NULL, 0.00, '2025-04-22 13:31:26', '2025-05-12 06:27:53'),
(36, 'pop', 'pop', 'Pop music is a broad-term for many different types of music: The term is flexible, and the music labeled \"pop\" changes frequently. It usually refers to popular, appealing and mostly mainstream music with emphasis on catchy melodies and an accessible style, with songs that tend to have a short to medium length. Some subgenres may include synthpop, electropop, bubblegum, sophisti-pop, hyperpop and many others. Read more on Last.fm. User-contributed text is available under the Creative Commons By-SA License; additional terms may apply.', NULL, NULL, NULL, 0.00, '2025-04-22 13:31:28', '2025-05-12 06:27:53'),
(38, 'soty', 'soty', '\"Song of the Year\" or SOTY Read more on Last.fm. User-contributed text is available under the Creative Commons By-SA License; additional terms may apply.', NULL, NULL, NULL, 0.00, '2025-04-22 13:31:51', '2025-05-12 06:27:53'),
(39, 'british', 'british', 'Bands and artists that are from Great Britain; generally referring to artists from England but can also be used for Scottish and Welsh acts. Irish need not apply.\n\nRelated tags: American, Irish, Jamaican, Australian, Canadian, New Zealand\n\nPop: The Beatles (John Lennon, Paul McCartney, George Harrison, Ringo Starr), George Michael, Elton John, One Direction, Adele, Coldplay, Spice Girls, The Police,Boy George, Phil Collins, Dua Lipa, Dusty Springfield, Tom Jones, Sam Smith, Ed Sheeran       \nRock: David Bowie, Led Zeppelin, The Who, Kate Bush, Oasis, The Rolling Stones, Queen, Pink Floyd, Genesis, Eric Clapton, Cream, Bad Company,The Kinks, The Yardbirds, Jeff Beck, Donovan, John Mayall & the Bluesbreakers, Nazareth, Electric Light Orchestra (ELO), Yes, T. Rex, The Moody Blues, Roxy Music, Dire Straits, King Crimson, Jethro Tull, Small Faces, Supertramp, The Alan Parsons Project, Peter Frampton, Rod Stewart, Muse, Steve Winwood, Gary Glitter      \nElectronic: Aphex Twin, Fatboy Slim, The Chemical Brothers, Burial, Ladytron, Calvin Harris, Utah Saints, 808 State, Boxcutter, Skream, Artful Dodger, Disclosure, Sneaker Pimps, Massive Attack, Squarepusher, Goldie, Congo Natty, LFO, Boards of Canada, Autechre, James Blake, Benga, SBTRKT, SOPHIE    \nPunk: The Clash, Sex Pistols, The Pogues, Buzzcocks, The Jam, The Damned, The Adverts, Generation X, The Undertones     \nPost-Punk: The Smiths, Siouxsie and the Banshees, Talk Talk, Joy Division, XTC, Elastica, The Jesus and Mary Chain, The Fall, Bauhaus, Wire, Gang of Four, Public Image Ltd, The Sisters of Mercy, Echo & the Bunnymen, The Cure         \nMetal: Black Sabbath, Def Leppard, Iron Maiden, Motörhead, Deep Purple, Judas Priest, Rainbow  \nAlternative: The Stone Roses, Radiohead, Blur, Gorillaz, PJ Harvey, The Verve, Pulp, Suede, Stereophonics, Super Furry Animals, Primal Scream, Morrissey       \nSynth-Pop: Depeche Mode, Gary Numan, The Human League, Frankie Goes to Hollywood, A Flock of Seagulls, New Order, Charli XCX, Duran Duran, Simple Minds, Spandau Ballet, Yazoo (known as Yaz in North America), Thomas Dolby, Tears for Fears, Scritti Politti, Pet Shop Boys  \nBritish hip-hop/Grime: Wiley, Dizzee Rascal, Skepta, Slick Rick, MF DOOM, Stormzy, slowthai, Tricky, JME      \nIndie: Arctic Monkeys, King Krule, Happy Mondays, Alt-J, Bloc Party, Longpigs, Yuck, The Kooks,Inspiral Carpets, The La\'s Read more on Last.fm. User-contributed text is available under the Creative Commons By-SA License; additional terms may apply.', NULL, NULL, NULL, 0.00, '2025-04-22 13:31:51', '2025-05-12 06:27:53'),
(40, 'electronica', 'electronica', 'Electronica includes a wide range of contemporary electronic music designed for a wide range of uses, including foreground listening, some forms of dancing, and background music for other activities; but unlike electronic dance music, it is not specifically made for dancing. The term was first used in the United States in the early 1990s with regards to post-rave global-influenced electronic dance music. Genres such as techno, drum and bass, downtempo, and ambient are among those encompassed by the umbrella term, entering the American mainstream from \"alternative\" or \"underground\" venues during the late 1990s. Prior to the adoption of electronica for this purpose, terms such as electronic listening music, trance and intelligent dance music (IDM) were used.\n\nThe All Music Guide categorizes electronica as a top-level genre on their main page, where they state that electronica includes \"dozens of stylistic fusions\" ranging from danceable grooves to music for headphones and chillout areas.\n\nAfter beginning as an underground genre in the early 1990s, electronica has grown to influence even mainstream crossover recordings. Elements of electronica are used today by many popular artists in mainstream music. Read more on Last.fm. User-contributed text is available under the Creative Commons By-SA License; additional terms may apply.', NULL, NULL, NULL, 0.00, '2025-04-22 13:31:59', '2025-05-12 06:27:53'),
(41, 'Drum and bass', 'drum-and-bass', 'Drum and bass (commonly abbreviated to d&b, DnB, dnb, d\'n\'b, drum n bass, drum & bass) is a type of electronic dance music which emerged in the mid 1990s. The genre is characterised by fast tempo broken beats (generally between 160–180 beats per minute, but also having occasional differences in some older compositions), with heavy sub basslines.\n\nThe genre roots itself in the UK rave scene, and has spread around the world, notably to Europe, Russia, and the USA.\n\nUp until the late 1990s/mid 2000s, drum and bass remained a relatively underground genre. However, artists such as Pendulum and High Contrast and labels such as Breakbeat Kaos and Hospital Records have helped push the popularity and awareness of the genre into the public domain.\n\nAs it stands, drum and bass is gaining more and more popularity, enjoying regular airplay on the radio, such as BBC Radio 1 in the UK. Read more on Last.fm. User-contributed text is available under the Creative Commons By-SA License; additional terms may apply.', NULL, NULL, NULL, 0.00, '2025-04-22 13:32:03', '2025-05-12 06:27:53'),
(42, 'breakcore', 'breakcore', 'Breakcore is a loosely defined electronic music style that brings together elements of industrial, jungle, hardcore techno and IDM into a breakbeat-oriented sound that encourages speed, complexity, impact and maximum sonic density. Similar to punk, breakcore adheres to a loose set of stylistic \"rules\" and is defined more by an attitude than by a musical formula.\n\nInfluences and Development\nBreakcore began to evolve out of boredom with stagnant forms of more traditional techno and rave music, as well as an evolution within noise and sound art. A need for faster BPMs as well as a more anti-authoritarian sound also pushed the various sub-genres to greater extremes.\n\nProto-breakcore came from London, Berlin and Newcastle, Australia (home of Bloody Fist Records). Early influential artists include Alec Empire, DJ Scud, Panacea, Christoph Fringeli and Nasenbluten. Fringeli describes the sound then as \"a hybrid strategy rather than a style or genre. It drew its influences and sources from industrial hardcore, jungle/drum\'n\'bass and everything in between and neighbouring it, engaging in an alchemy of sounds, pillaging the rave culture and sharpening, radicalizing and intensifying it.\"\n\nAmbush Records\nIn London, DJ Scud co-founded Ambush Records with fellow producer Aphasic to focus on more extreme noise-oriented hardcore drum and bass. Some artists released on Ambush are Christoph Fringeli, Slepcy, Panacea, and Noize Creator. \"Scud and Nomex tracks like \'Total Destruction\' helped create the blueprint for much of breakcore\'s sound, a high-bpm mash-up of hyperkinetic, post-jungle breaks, feedback, noise, and Jamaican elements paired with a devil-may-care attitude towards sampling that pulls from the broadest musical spectrum of styles (hip-hop, rock, industrial, pop, and beyond).\"\n\nBloody Fist Records\nAt the same time, Bloody Fist Records based in Newcastle, Australia released many records of hardcore/gabber, industrial, and noise. Label founder Mark Newlands said, in 1997, \"I think that the uncomfortableness also comes from a reaction towards the mainstream and popular culture that\'s constantly shoved down our throats, that\'s forced on the people via television, radio, mass media, etc. I think that also fuels the fire and keeps the aggressiveness there and the uncomfortableness.\" Artists signed to Bloody Fist in its lifetime include Syndicate, Xylocaine, Epsilon and Nasenbluten.\n\nDigital Hardcore Recordings\nFormed in 1994, Digital Hardcore Recordings released music by artists such as Alec Empire, Patric Catani, Shizuo, Atari Teenage Riot, EC8OR and Bomb 20, shaping the breakcore sound. The Alec Empire album the destroyer  is often noted as the first breakcore album.\n\n\nBreakcore becomes a genre\nAs the early days of \"hardcore techno\" or just \"hardcore\" began to settle in Europe, breakcore as a genre began to take more concrete forms in other parts of the world. Inspired by new labels such as Addict, from Milwaukee, USA; Peace Off from Rennes, France; Sonic Belligeranza from Bologna, Italy; and Planet µ, from London, began to take a new shape, adding in more elements of mash-up and IDM to the hardcore sounds. Each of these labels began to draw in aspects of their own social and aesthetic scenes into their music, allowing for an even broader definition of what was possible in the music.\n\nOne of the most controversial issues in breakcore is that of the mere existence of the genre. Because it pulls liberally from other musical genres, there is not a consensus on what is and what is not breakcore, or even over the usefulness of the term itself. Because of the fragmentation, the breakcore scene is not centered in any one geographical location, but is rather scattered into disparate groups. Perhaps the one place where breakcore\'s \"voice\" can be heard is virtually, through the internet and various online forums, such as those at C8 and Widerstand.\n\nAccording to Simon Reynolds, of The New York Times, breakcore is \"purveyed by artists like DJ /Rupture and Team Shadetek, the music combines rumbling bass lines, fidgety beats and grainy ragga vocals to create a home-listening surrogate for the bashment vibe of a Jamaican sound system party. Others within the breakcore genre, like Knifehandchop, kid606 and Soundmurderer, hark back to rave\'s own early days, their music evoking the rowdy fervor of a time when huge crowds flailed their limbs to a barrage of abstract noise and convulsive rhythm. It\'s a poignant aural mirage of a time when techno music was made for the popular vanguard rather than a connoisseurial elite, as it is today.\"\n\nIn Europe, the breakcore genre was solidified by raves and club events such as Breakcore Gives Me Wood, in Belgium, and Breakcore A Go Go, in the Netherlands, which was run by FFF and Bong-Ra; as well as Anticartel, in Rennes, and later, Wasted, in Berlin.\n\n\nAmen break\nWhile breakcore is definitely not only organized around the cutting and distortion of the amen break, it is a key to defining the genre. The amen break in breakcore is primarily used at high-speeds and edited to produce jarring effects when distorted and layered in combination with almost any sound. This particular drum-break sound characterizes many breakcore songs and is still used as a key factor to define the sound. This is in line with breakcore\'s tendency to create a post-modern parody of drum and bass clichés - many of the sounds heard in breakcore are very \"classic\" jungle samples.\n\n\nDistribution\nSince the genre as a whole still is developing and growing rapidly, the music itself is largely downloaded via peer-to-peer networks, and discussed on internet forums. Whereas the early days of breakcore were based in select urban cities, the genre now has no geographical center. The music itself tends to reflect this multiplicity of media diffusion itself (as already mentioned) by incorporating so many different forms of music all hacked together to form breakcore. It remains a relatively small genre, but compared to its size prior to the 1990s web boom, it continues to grow substantially.\n\n\nDevelopments in the genre\nBreakcore has forever been changing and branching. Many newer breakcore artists focus on melodic progressions and complex drum programming while other artists still focus on distorted hardcore breakbeats and dark-edged musical influences (such as heavy metal, and industrial). The prolific Venetian Snares has produced breakcore blended with elements of classical music. Other artists such as Shitmat, Toecutter, Sickboy and DJ Scotch Egg take another direction towards mash-up, happy hardcore and rave to make a lighter, more humorous sound. The rise of chiptune music has also blended with breakcore with artists such as Patric Catani, AA.Kurtz, Sabrepulse, Daylight Daterape, Tarmvred, and DJ Fhantom. Some musicians from the power noise scene have begun to take influence from breakcore. The UK Free Party scene has also expressed a large interest in producing and distributing its own takes on breakcore, with crews and labels such as Headfuk, Hecate, Bad Sekta, NoFixedAbode, Marionette records, Tinnitus, Ill Industries & Life4Land helping to push the scene and sound forward, as well as bringing over a number of international artists to play at their parties and club nights. Read more on Last.fm. User-contributed text is available under the Creative Commons By-SA License; additional terms may apply.', NULL, NULL, NULL, 0.00, '2025-04-22 13:32:03', '2025-05-12 06:27:53'),
(43, 'Drum n Bass', 'drum-n-bass', 'Shortened/slang form of the \"drum and bass\" tag. Read more on Last.fm. User-contributed text is available under the Creative Commons By-SA License; additional terms may apply.', NULL, NULL, NULL, 0.00, '2025-04-22 13:32:03', '2025-05-12 06:27:53');

-- --------------------------------------------------------

--
-- Table structure for table `jobs`
--

CREATE TABLE `jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `queue` varchar(255) NOT NULL,
  `payload` longtext NOT NULL,
  `attempts` tinyint(3) UNSIGNED NOT NULL,
  `reserved_at` int(10) UNSIGNED DEFAULT NULL,
  `available_at` int(10) UNSIGNED NOT NULL,
  `created_at` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `job_batches`
--

CREATE TABLE `job_batches` (
  `id` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `total_jobs` int(11) NOT NULL,
  `pending_jobs` int(11) NOT NULL,
  `failed_jobs` int(11) NOT NULL,
  `failed_job_ids` longtext NOT NULL,
  `options` mediumtext DEFAULT NULL,
  `cancelled_at` int(11) DEFAULT NULL,
  `created_at` int(11) NOT NULL,
  `finished_at` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `lyrics`
--

CREATE TABLE `lyrics` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `lyrics` text DEFAULT NULL,
  `status` enum('verified','requires verification') NOT NULL DEFAULT 'requires verification',
  `track_id` bigint(20) UNSIGNED NOT NULL,
  `last_updated_by_user` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `lyrics`
--

INSERT INTO `lyrics` (`id`, `lyrics`, `status`, `track_id`, `last_updated_by_user`, `created_at`, `updated_at`) VALUES
(1, '[Verse 1: Oli Sykes]\r\nWe are the children of the devolution\r\nThe infamous martyrs, the scars on the sun\r\nAsphyxiating with a smile on your face\r\nWhile they pull your teeth out one by one\r\n\r\n[Pre-Chorus: Oli Sykes & Lee Malia]\r\nIs this what you wanted? No\r\nDo you want some more? Yeah\r\nD-Generation\r\nWho\'s keeping score?\r\n\r\n[Chorus: Oli Sykes]\r\n\'Cause you got a taste now, drank the Kool-Aid by the jug\r\nSo suffer your fate, oh, come here and give me a hug\r\nNobody loves you like I love you, oh, my dear\r\nBut you should\'ve known that this was gonna end in tears\r\n\r\n[Verse 2: Oli Sykes]\r\nSuch a sucker for an execution\r\nThe void is a vampire, fat on our blood\r\nDomesticated like a cat in a cage\r\nWhile they try their hand at playing God\r\n\r\n[Pre-Chorus: Oli Sykes & Lee Malia]\r\nIs this what you wanted? No\r\nDo you want some more-e-e-e? Yeah\r\nD-Generation\r\nAfraid there\'s no cure\r\n\r\n[Chorus: Oli Sykes]\r\n\'Cause you got a taste now, drank the Kool-Aid by the jug\r\nSo suffer your fate, oh, come here and give me a hug\r\nNobody loves you like I love you, oh, my dear (Oh, oh-oh)\r\nBut you should\'ve known that this was gonna end in tears\r\n\r\n[Post-Chorus: Lucy Landry]\r\nOh, oh-oh, oh-oh, oh-oh\r\n\r\n[Bridge: Oli Sykes]\r\nI got my hands around your throat, I love the way you choke\r\n\'Cause I am yours and you are mine, I\'ll never let you go\r\nMy hands around your throat, I love the way you choke\r\n\'Cause I am yours and you are mine, I\'ll never let you go\r\n\r\n[Breakdown: Oli Sykes & Lee Malia]\r\n(Hey! Hey! Hey! Hey! Hey! Hey!)\r\nI\'ll never let you go\r\n(Hey! Hey! Hey! Hey! Hey! Hey!)\r\nGet the fuck up\r\nYeah!\r\n\r\n[Guitar Solo]\r\n\r\n[Chorus: Oli Sykes]\r\n\'Cause you got a taste now, drank the Kool-Aid by the jug\r\nSo suffer your fate, oh, come here and give me a hug\r\nNobody loves you like I love you, oh, my dear (Oh, oh-oh)\r\nBut you should\'ve known, you should\'ve known\r\nBut you should\'ve known that this was gonna end in tears\r\n[Outro: Oli Sykes]\r\nYou should\'ve known\r\n\r\n[Segue: Oli Sykes]\r\nWhat if it\'s like\r\nLa, la-la-la, la-la-la\r\nLa, la-la-la, la-la-la, la-la-la?\r\nOh, I forgot somethin\'\r\nLa-la-la, la-la-la, la-la-la, la, yeah\r\nLa-la-la\r\nThat this was gonna end in tears\r\nOr some shit like that', 'verified', 3, 1, '2025-04-22 13:35:32', '2025-04-22 13:35:32'),
(2, '[Verse 1]\r\nThere\'s a place I wanna take you\r\nBut I\'m not quite there myself yet\r\n(Doo-doo-doo-doo-doo)\r\nI\'m getting better but there\'s still days\r\nWhere I wish that I was someone else\r\nBut I know\r\n\r\n[Pre-Chorus]\r\nThere is a home, somewhere\r\nBeyond my bones\r\nAnd I\'m just too terrified\r\nTo dive inside\r\n\r\n[Chorus]\r\nSoul like a cemetery\r\nHard to ignore, we\'re sick to the core\r\nA world\'s been buried\r\nWhеre love is the law, a youtopia\r\n\r\n[Post-Chorus]\r\n(Scrеam)\r\n\r\n[Verse 2]\r\nGolden raspberry\r\nFor the performance in your head\r\n(Doo-doo-doo-doo-doo)\r\nStop pushing daisies\r\nNo one wants flowers when they\'re dead\r\n\r\n[Chorus]\r\nSoul like a cemetery\r\nHard to ignore, we\'re sick to the core\r\nA world\'s been buried\r\nWhere love is the law, a youtopia\r\n\r\n[Bridge: Oli Sykes, Oli Sykes & Dan Lancaster]\r\n(There is a home) There is a home, ah-ah-ah\r\n(Beyond our bones) Beyond our bones\r\nSo connect to the Divine\r\nIt\'s okay to cry, yeah\r\n\r\n[Instrumental Break]\r\n\r\n[Chorus]\r\nSoul like a cemetery\r\nHard to ignore, we\'re sick to the core\r\nA world\'s been buried\r\nWhere love is the law\r\n\r\n[Post-Chorus]\r\nA youtopia (There\'s a place I wanna take you)\r\nA youtopia (There\'s a place I wanna take you)\r\nA youtopia (There\'s a place I wanna take you)\r\nWhere love is the law, a youtopia\r\n[Outro]\r\nWhat was it like?\r\nIt\'s like I walked into a dream\r\nAnd stepped out of the coma', 'requires verification', 2, 1, '2025-04-22 13:38:01', '2025-04-22 13:38:01'),
(4, '[Intro]\r\nLet\'s motherfucking go-o-o\r\n\r\n[Verse 1]\r\nDid my back hurt your knife?\r\nDo you think you\'re bulletproof?\r\nGo chat shit all you like\r\nYou and I both know the truth\r\n\r\n[Pre-Chorus]\r\nPlot twist, I don\'t give two shits\r\nAbout you or whether you exist\r\nTrippin\' if you think there\'ll be a happy ending\r\n\r\n[Chorus]\r\nStill alive but you\'re dead to me\r\nThere\'s voices in my head that\'ll never leave\r\nWish I could forget all these memories\r\nI don\'t know why you keep diggin\' your own grave, no remedy\r\nOut your fucking mind in a fantasy\r\nYour therapist is gonna need some therapy\r\nYou and me are done, so see you later, punk\r\nR-I-P\r\n\r\n[Verse 2]\r\nIn a bit mate, it\'s been fun\r\nIn a near-death kind of way\r\nBut it\'s people like you, darlin\'\r\nThat give humans a bad name\r\n\r\n[Pre-Chorus]\r\nPlot twist, I don\'t give two shits\r\nAbout you or whether you exist\r\nTrippin\' if you think there\'ll be a happy ending\r\n\r\n[Chorus]\r\nStill alive but you\'re dead to me\r\nThere\'s voices in my head that\'ll never leave\r\nWish I could forget all these memories\r\nI don\'t know why you keep diggin\' your own grave, no remedy (Let\'s go)\r\nOut your fucking mind in a fantasy\r\nYour therapist is gonna need some therapy\r\nYou and me are done, so see you later, punk\r\nR-I-P\r\n\r\n[Post-Chorus]\r\nWoah-oh, oh-oh-oh\r\nWoah-oh, oh-oh-oh-oh\r\nWoah-oh, oh-oh-oh-oh\r\nYeah, see you later, punk, R-I-P\r\nWoah-oh, oh-oh-oh\r\nWoah-oh, oh-oh-oh-oh\r\nWoah-oh, oh-oh-oh-oh\r\n\r\n[Bridge]\r\nMake me the villain if you want\r\nGuess there\'s no cure for a—\r\nSo keep your name out my mouth\r\n\'Cause I wouldn\'t wanna smash that pretty glass house\r\nStill alive\r\n[Chorus]\r\nBut you\'re dead to me\r\nA parasite, you\'re a heart disease\r\nSo stay the fuck away from me, yeah\r\nNo, there\'s no remedy\r\nOut your fucking mind in a fantasy\r\nThink your therapist will need therapy\r\nBut you and me are done, so see you later, creep\r\nR-I-P\r\n\r\n[Post-Chorus]\r\nWoah-oh, oh-oh-oh\r\nWoah-oh, oh-oh-oh-oh\r\nWoah-oh, oh-oh-oh-oh\r\nYeah, see you later, punk, R-I-P\r\nWoah-oh, oh-oh-oh\r\nWoah-oh, oh-oh-oh-oh\r\nWoah-oh, oh-oh-oh-oh\r\nSo see you later, punk, R-I-P\r\n\r\n[Outro]\r\nWe\'ve gathered here today to honour the memory of the f***\r\nAnd although they are no longer with us\r\nThey live on in our thoughts and in our hearts (God bless me)\r\nWe will start today\'s ceremony with a few words from a dear friend', 'requires verification', 12, 1, '2025-04-27 05:03:51', '2025-04-27 05:03:51'),
(6, '[Verse 1]\r\nSinking under\r\nThink my angel\'s fallen\r\nSafe place plundered\r\nBastards kicked the doors in\r\n\r\n[Pre-Chorus]\r\nPicked the stitches, now I can\'t stop bleeding\r\nThree in the morning, I ain\'t slept all weekend\r\nSix feet in the dirt, still breathing\r\nDon\'t give a fuck if my heart stops beating\r\n\r\n[Chorus]\r\nHey, I\'m begging you to stay\r\nMy dark side won today\r\nMy heart keeps breaking\r\nOver and over\r\nHey, don\'t let me out your sight\r\nCan\'t trust myself tonight\r\nMy heart keeps breaking\r\nCan you talk me off the ledge again?\r\n\r\n[Verse 2]\r\nSomething haunts me\r\nFootsteps in the basement\r\nOut of body\r\nBut there\'s no escaping\r\n\r\n[Pre-Chorus]\r\nI picked the stitches, now I can\'t stop bleeding\r\nThree in the morning, I ain\'t slept all weekend\r\nSix feet in the dirt, still breathing\r\nDon\'t give a fuck if my heart stops beating\r\n\r\n[Chorus]\r\nHey, I\'m begging you to stay\r\nMy dark side won today\r\nMy heart keeps breaking\r\nOver and over\r\nHey, don\'t let me out your sight\r\nCan\'t trust myself tonight\r\nMy heart keeps breaking\r\nCan you talk me off the ledge again?\r\n\r\n[Bridge]\r\nSomething\'s in the way\r\nDon\'t know what I can say\r\nMemories are haunting me\r\nA sickness taking over\r\nSo bury me alive\r\nThere\'s nowhere left to hide\r\nAnd say goodbye \'cause maybe I\r\nMaybe I won\'t miss me when I\'m gone\r\n[Chorus]\r\nHey, I\'m begging you to stay\r\nMy dark side won today\r\nMy heart keeps breaking\r\nOver and over\r\nHey, don\'t let me out your sight\r\nCan\'t trust myself tonight\r\nMy heart keeps breaking\r\nCan you talk me off the ledge again?\r\n\r\n[Outro]\r\nCan\'t trust myself tonight\r\nCan\'t trust myself tonight\r\nCan\'t trust myself\r\nCan you talk me off the ledge again?', 'requires verification', 6, 1, '2026-02-18 19:22:48', '2026-02-18 19:22:48');

-- --------------------------------------------------------

--
-- Table structure for table `password_reset_tokens`
--

CREATE TABLE `password_reset_tokens` (
  `email` varchar(255) NOT NULL,
  `token` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `recommendations`
--

CREATE TABLE `recommendations` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `is_checked_by_user` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `recommendations_artists`
--

CREATE TABLE `recommendations_artists` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `recommendation_genre_id` bigint(20) UNSIGNED NOT NULL,
  `artist_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `recommendations_genres`
--

CREATE TABLE `recommendations_genres` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `recommendation_id` bigint(20) UNSIGNED NOT NULL,
  `genre_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `releases`
--

CREATE TABLE `releases` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `title` varchar(255) NOT NULL,
  `slug` varchar(255) NOT NULL,
  `release_date` date NOT NULL,
  `description` text DEFAULT NULL,
  `description_lv` text DEFAULT NULL,
  `release_type` enum('album','ep','single','compilation') NOT NULL,
  `popularity` double(10,2) NOT NULL DEFAULT 0.00,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `releases`
--

INSERT INTO `releases` (`id`, `title`, `slug`, `release_date`, `description`, `description_lv`, `release_type`, `popularity`, `created_at`, `updated_at`) VALUES
(1, 'POST HUMAN: NeX GEn', 'post-human-nex-gen', '2024-05-24', 'Post Human: NeX GEn, released on May 24, 2024, is the seventh studio album by British rock band Bring Me The Horizon. Serving as the second installment in their Post Human series, following 2020\'s Survival Horror, this album marks a significant evolution in the band\'s sound and thematic exploration.\n\nThe album delves into themes of digital anxiety, identity, and the human experience in a technologically saturated world. Tracks like \"Die4U,\" \"Amen!,\" \"Darkside,\" \"Lost,\" and \"Strangers\" showcase a fusion of genres, incorporating elements of post-hardcore, hyperpop, emo, and nu-metal. This genre-blending approach reflects the band\'s commitment to pushing musical boundaries and resonating with the complexities of modern life.\n\nCritically acclaimed for its bold experimentation and cohesive narrative, Post Human: NeX GEn has been described as \"a defining album of our digitally overloaded era\" . The album\'s production, led by frontman Oli Sykes and former keyboardist Jordan Fish, along with contributions from composer Mick Gordon, delivers a rich and immersive listening experience .\n\nNotably, the album incorporates an Alternate Reality Game (ARG), inviting fans to engage with its themes on a deeper level through hidden messages and interactive content . This innovative approach enhances the album\'s exploration of digital identity and reality.\nsecrettinfoilsociety.com\n\nPost Human: NeX GEn stands as a testament to Bring Me The Horizon\'s ability to evolve and adapt, offering a compelling commentary on the intersection of humanity and technology.', '*Post Human: NeX GEn*, kas tika izdots 2024. gada 24. maijā, ir britu rokgrupas *Bring Me The Horizon* septītais studijas albums. Tas kalpo kā otrā daļa viņu *Post Human* sērijā, sekojot 2020. gada *Survival Horror*, un iezīmē būtisku attīstību grupas skanējumā un tematiskajā izpētē.\n\nAlbums pievēršas digitālās trauksmes, identitātes un cilvēka pieredzes tēmām tehnoloģiju piesātinātā pasaulē. Dziesmas kā “Die4U,” “Amen!,” “Darkside,” “Lost” un “Strangers” demonstrē dažādu žanru saplūšanu, apvienojot post-hardcore, hyperpop, emo un nu-metal elementus. Šī žanru kombinēšana atspoguļo grupas vēlmi paplašināt muzikālās robežas un rezonēt ar mūsdienu dzīves sarežģītību.\n\nKritiķi albumu augstu novērtējuši par tā drosmīgajiem eksperimentiem un vienoto naratīvu, raksturojot to kā “noteicošu albumu mūsu digitāli pārslogotajā laikmetā”. Albuma producēšanu vadīja solists Oli Sykes un bijušais taustiņinstrumentālists Jordan Fish, kā arī tajā piedalījās komponists Mick Gordon, radot bagātīgu un ieskaujošu klausīšanās pieredzi.\n\nĪpaši jāizceļ, ka albums ietver alternatīvās realitātes spēli (ARG), aicinot fanus dziļāk iesaistīties tā tēmās, izmantojot slēptus vēstījumus un interaktīvu saturu. Šī inovatīvā pieeja papildina albuma digitālās identitātes un realitātes izpēti.\n\n*Post Human: NeX GEn* ir apliecinājums *Bring Me The Horizon* spējai attīstīties un pielāgoties, piedāvājot pārliecinošu skatījumu uz cilvēces un tehnoloģiju mijiedarbību.', 'album', 0.00, '2025-04-22 13:29:04', '2025-05-05 05:41:49'),
(2, 'POST HUMAN: SURVIVAL HORROR', 'post-human-survival-horror', '2020-10-30', 'Bring Me The Horizon’s first record after 2019’s amo, Post Human: Survival Horror is part of a four EP project. The first record is the heaviest one and it brings back the style of the band’s first records. As Oli Sykes said to Music Feeds:\n\n\"It’s kind of a mix, just like you’ve heard on “Parasite Eve,” where it still feels bonkers in terms of jumping from genre to genre and sound to sound, but we’ve definitely took a little bit more influence from things we did quite a few years ago.  Whereas now we’ve got something to be angry about, we’ve got something to be pissed about, we’ve got something to make violent music to.\"\n\nThe word “Posthuman” or “Post-human” is a word that originates from futurology that means a person or entity that exists in a state beyond what we know as a “human.” While the exact meaning of the word varies, it is generally considered to be a person who through either genetic manipulation or other biointerventionist measures, has the ability to remain healthy and active through an extended period of time that would not be considered normal by our current standards. Their cognitive powers, such as deductive thought or other intellectual capabilities, would far surpass those of a simple human.\n\n\"The idea behind Post Human is looking at how we’ve stepped out of evolution and the food chain. If we can do that, then we can take responsibility for what we’ve done to the planet and become something better than what humans are right now.\"\n\n—Oli Sykes, NME\n\nEvery part of this project is sonically different and have a different message. This first album expresses all the anger inside people and is “a recruitment record with battle songs,” as Oli explains:\n\n\"You know like on Lord of the Rings where they all sing a song before battle, knowing that they might die but they’re going got persevere and see how it goes? We’re trying to embody that. This first record is about hope and anger and feels like the sonic equivalent of a riot. We’re inviting people to find the solution with us. It’s a demonstration to pull you in and get your back up. It’s a lot more aggressive than anything we’ve done for a while. The world doesn’t need light-hearted pop music right now—it needs anthems for anger. There’s so much to be pissed off about.\"\n\nThe band needed a cyberpunk feeling to the album, so they decided to call Mick Gordon, DOOM Eternal’s musical producer.\n\n\"I’ve been playing this one game called DOOM Eternal and as I was playing it I absolutely fell in love with the soundtrack. It’s fucking crazy. It’s heavy as fuck. It’s got this kind of dystopian cyber-punky djent kind of fucking huge vibe. A guy called Mick Gordon actually produced all this music. At first, when we were writing “Parasite Eve” especially I was referencing a lot of this DOOM game ‘cause I was playing it in the day and then me and Jordan would work at night and I was like using this as references because the sounds in there sound so huge and so hitting in a way I haven’t heard in any other metal music. And then it kind of dawned on me that like, you know, maybe this is the guy we’re looking for to collaborate with. So I hit him up. Amazingly, he got back to us and said he was a massive fan of the band and really loved what we did and would love to work with us. So I started talking to him, we got chatting, I told him my ideas and wrote him a bunch of notes and basically just left the song with him and he came back with a fucking sound library.  So he added textures and tunings to the vocals and shit like that really kind of just pushes it further to make you feel what we are trying to get across. So yeah, he smashed it basically and I’m really stoked on how that turned out. I think we’re going to be working with him more on this record.\"\n\n—Oli Sykes, BMTH Season 2’s “Mick Gordon”  User-contributed text is available under the Creative Commons By-SA License; additional terms may apply.', NULL, 'album', 0.00, '2025-04-22 13:29:05', '2025-05-05 05:41:49'),
(3, 'Live at the Royal Albert Hall', 'live-at-the-royal-albert-hall', '2020-10-28', NULL, NULL, 'album', 0.00, '2025-04-22 13:29:06', '2025-05-05 05:41:49'),
(4, 'Music to listen to~dance to~blaze to~pray to~feed to~sleep to~talk to~grind to~trip to~breathe to~help to~hurt to~scroll to~roll to~love to~hate to~learn Too~plot to~play to~be to~feel to~breed to~sweat to~dream to~hide to~live to~die to~GO TO', 'music-to-listen-todance-toblaze-topray-tofeed-tosleep-totalk-togrind-totrip-tobreathe-tohelp-tohurt-toscroll-toroll-tolove-tohate-tolearn-tooplot-toplay-tobe-tofeel-tobreed-tosweat-todream-tohide-tolive-todie-togo-to', '2019-12-27', NULL, 'Music to Listen to~Dance to~Blaze to~Pray to~Feed to~Sleep to~Talk to~Grind to~Trip to~Breathe to~Help to~Hurt to~Scroll to~Roll to~Love to~Hate to~Learn Too~Plot to~Play to~Be to~Feel to~Breed to~Sweat to~Dream to~Hide to~Live to~Die to~Go To ir britu rokgrupas Bring Me the Horizon komerciāls izlaidums . Tas tika izdots 2019. gada 27. decembrī bez iepriekšēja paziņojuma . Izlaidumu producēja grupas vokālists Oli Saiks un taustiņinstrumentālists Džordans Fišs , un tajā ir iekļauta sadarbība ar vairākiem māksliniekiem, tostarp amerikāņu dziedātājuHalsey un britu grupu Yonaka .\n\n“Music to Listen To...” ir grupas “Bring Me the Horizon” garākais muzikālais projekts, un dažādi avoti to ir dēvējuši gan par pagarinātu lugu , gan albumu. Projekts radās no idejas izmantot elementus no grupas 2019. gada albuma “Amo” un iepriekš ierakstītajām demo versijām .', 'album', 0.00, '2025-04-22 13:29:07', '2025-05-05 05:41:49'),
(5, 'amo', 'amo', '2019-01-25', 'Amo (stylised in lowercase) is the sixth studio album by British rock band Bring Me the Horizon. Originally scheduled for release on 11 January 2019, it was released on 25 January 2019. The album was announced on 22 August 2018, a day after the release of the lead single \"Mantra\". It is produced by frontman Oliver Sykes and keyboardist Jordan Fish, and was written and recorded primarily in Los Angeles.\n\nThe band embarked on the First Love World Tour in 2019 in support of the album. In the 22 August 2018 issue of Kerrang!, they described the album as \"varied\", \"free\", \"weird\" and \"mental\", with NME noting that \"Mantra\" continues the electronic and pop rock elements featured on the band\'s previous studio album, That\'s the Spirit (2015). \"Mantra\" subsequently debuted at number one on the UK Rock & Metal Chart, and its video was released on 24 August.\n\nThe album, named after the Portuguese word for \"I love\", was first promoted by an advertising campaign of billboards across London and other cities worldwide with symbols used by the band in the past on them, along with the words \"Do you wanna start a cult with me?\", which are lyrics from \"Mantra\". A website titled joinmantra.org was also launched that stated \"Salvation will return\", and a phone number that when called featured various audio clips at different times, including one of a woman named Samantha stating \"They\'re making me do this. I didn\'t know what I was getting myself into.\"\n\nThe song \"Mantra\" was subsequently premiered on BBC Radio 1, with Sykes saying to Annie Mac: \"It\'s basically—we\'ve gone off and recorded some stuff and this is the first thing we\'ve wanted to show people of our return. It\'s quite different but it\'s got similarities—it\'s what we wanted to share with the world.\" Sykes stated that \"Mantra\" is \"not really\" representative of the sound of the whole album, also saying \"every song on the record is completely different. It’s a lot more experimental than our last record.\"\n\nSykes stated about the album: \"amo is a love album that explores every aspect of that most powerful emotion. It deals with the good the bad and the ugly, and as a result we\'ve created an album that\'s more experimental, more varied, weird, and wonderful than anything we\'ve done before.\" He later commented that Amo is a concept album about love, as \"Everything boils down to love in the end\". Sykes also said that some of the lyrical content concerns his divorce.\n\nAll track titles are stylised in lowercase except for Mantra, which is stylised in all caps.\n  User-contributed text is available under the Creative Commons By-SA License; additional terms may apply.', NULL, 'album', 0.00, '2025-04-22 13:29:08', '2025-05-05 05:41:49'),
(6, 'That\'s The Spirit', 'thats-the-spirit', '2015-09-11', 'That’s The Spirit is the fifth studio album from British rock band Bring Me the Horizon released on September 11th, 2015. It shows a development of the sound introduced on the band\'s 2013 album Sempiternal, moving away from the metal and deathcore style of their older material and in favor of a less aggressive alternative rock and metal style. \n\nIn an interview with NME, lead vocalist Oli Sykes said that the album is a loose concept album about life\'s darker moods, such as depression, and a way of making light of it. He cited a wider range of influences such as Jane’s Addiction, Radiohead, Panic! at the Disco and Interpol on That\'s the Spirit. The album received universal acclaim from music critics, even as many fans expressed disappointment in the less heavy, stadium-friendly sound in Bring Me the Horizon\'s previously released albums. The album was self-produced by keyboardist Jordan Fish and Oli. The title is a reference to the refrain of “Happy Song,” which ironically samples a high school pep rally.  User-contributed text is available under the Creative Commons By-SA License; additional terms may apply.', NULL, 'album', 0.00, '2025-04-22 13:29:09', '2025-05-05 05:41:49'),
(7, 'Sempiternal (Expanded Edition)', 'sempiternal-expanded-edition', '2013-04-01', NULL, NULL, 'album', 0.00, '2025-04-22 13:29:10', '2025-05-05 05:41:49'),
(8, 'There is a Hell Believe Me I\'ve Seen It. There is a Heaven Let\'s Keep it a Secret', 'there-is-a-hell-believe-me-ive-seen-it-there-is-a-heaven-lets-keep-it-a-secret', '2010-10-04', NULL, NULL, 'album', 0.00, '2025-04-22 13:29:11', '2025-05-05 05:41:49'),
(9, 'Suicide Season (Deluxe)', 'suicide-season-deluxe', '2008-09-29', NULL, NULL, 'album', 0.00, '2025-04-22 13:29:12', '2025-05-05 05:41:49'),
(10, 'Suicide Season', 'suicide-season', '2008-09-29', 'Suicide Season is the second studio album by Bring Me the Horizon, released on 29 September 2008 through Visible Noise in the United Kingdom and Europe. The band signed a licensing deal with Epitaph Records on 11 September 2008, with the label releasing the album on 18 November 2008 in the United States. The album entered the UK Chart at #47, the Australian ARIA Albums Chart at #28. and the Billboard 200 at #107. Suicide Season shows a major change musically from their previous releases, abandoning their original deathcore sound. This would also be the last album to feature Curtis Ward on rhythm guitar.\nBring Me the Horizon later released a two disc special edition of Suicide Season which features various musicians and producers a remixing tracks off the album, entitled Suicide Season: Cut Up! It features remixes of all the Suicide Season songs and was released on the 2 November 2009 in the United Kingdom through Visible Noise and on 12 April 2010 in the United States through Epitaph Records.\n\nSuicide Season departs from Bring Me the Horizon\'s previous deathcore sound, the band has been credited as starting to adopt a more eclectic style. In an interview with Metal Hammer magazine, Sykes states that this album is \"100% different\" from Count Your Blessings. He also says: \"We experimented a lot more I think, more with other styles of music we all enjoy, using different instruments and technology, by bringing a lot of digital stuff to the table. Every track is different.\" Because of this drastic change in sound from Count Your Blessings they have had experienced a massive fanbase shift.\n\nSykes has stated that because of the band being better focus when in the studio for the album it made it easier for them to experiment with song writing and expand their sound: \"We didn\'t really have any other band we wanted to sound like or any other style. We just thought we\'d try to do something different and see what comes out. And this is what came out.\"\n\nThe remix album Suicide Season: Cut Up! style has a range of different genres. Oliver Sykes in Interview states that \"There\'s not a song on there that really sounds like the original. What\'s great though is the diversity of each song. There\'s dubstep to hip-hop, electro to drum and bass.\" The dubstep style of the record has been acknowledged in tracks from Tek-one and Skrillex while the hip-hop elements are found in Travis McCoy\'s remix of Chelsea Smile. Benjamin Weinman\'s version of \"No Need for Introductions...\" is considerably the most unique with its incorporation of industrial music.  User-contributed text is available under the Creative Commons By-SA License; additional terms may apply.', NULL, 'album', 0.00, '2025-04-22 13:29:13', '2025-05-05 05:41:49'),
(11, 'Count Your Blessings', 'count-your-blessings', '2006-10-30', 'Count Your Blessings is the debut album by British metalcore band Bring Me the Horizon. The album was released on October 30, 2006 in record stores around the United Kingdom, then in the United States nearly a year later on August 14, 2007. The album\'s name is derived from lyrics from the song \"Pray for Plagues\".\n\nEver since the release of Count Your Blessings the band has mainly discredited the album. Oliver Sykes in 2009 spoke about the album being recorded in Birmingham and that the location was a distraction for the band members: \"The studio was right in the middle of the city. There were so many distractions. Everyone recorded their parts on their own because everybody else was doing something else because we didn\'t want to sit in the studio all day.\"\n\nIn February 2011 Lee Malia commented on the album and how they were rushed to write songs for it, saying: \"We wrote that CD a lot faster. We didn’t have much time to write it. When we wrote it, we were obviously into it, but when we look back at it now there’s so much that could have been better. ‘Spose we were seventeen years old and we were doing an album so we were doing whatever\". The video for lead single \"Pray For Plagues\" has been viewed 35 million times on YouTube.  User-contributed text is available under the Creative Commons By-SA License; additional terms may apply.', NULL, 'album', 0.00, '2025-04-22 13:29:14', '2025-05-05 05:41:49'),
(12, 'Spotify Singles', 'spotify-singles', '2019-06-26', NULL, NULL, 'single', 0.00, '2025-04-22 13:29:14', '2025-05-05 05:41:49'),
(13, 'Kool-Aid', 'kool-aid', '2024-01-05', '“Kool-Aid” explores the manipulative and abusive drive of a cult leader who, in the end, is willing to sacrifice his followers for the ‘greater’ cause.\r\n\r\nThe title of the song is a reference to the Jonestown Massacre where 900 members of the Peoples Temple cult committed mass suicide upon the request of their leader, Jim Jones. They died from drinking cyanide and other sedatives in a fruit drink named “Flavor Aid”, which was originally misidentified as Kool-Aid. They later found needle marks, which meant some people were forced to die, making it a mass murder.\r\n\r\nThis is the sixth single and the third track from Bring Me The Horizon’s POST HUMAN: NeX GEn’s album, released on the 24th of May, 2024. Within its overarching lore, ”Kool-Aid” could be regarding the relationship within a cult/religion, more specifically The Church of GenXsis.', NULL, 'single', 0.00, '2025-04-22 13:29:15', '2025-05-05 05:41:49'),
(14, 'DArkSide', 'darkside', '2023-10-18', NULL, NULL, 'single', 0.00, '2025-04-22 13:29:16', '2025-05-05 05:41:49'),
(15, 'Happier (feat. Oli Sykes of Bring Me The Horizon)', 'happier-feat-oli-sykes-of-bring-me-the-horizon', '2023-10-17', NULL, NULL, 'single', 0.00, '2025-04-22 13:29:17', '2025-05-05 05:41:49'),
(16, 'CODE MISTAKE', 'code-mistake', '2023-06-30', NULL, NULL, 'single', 0.00, '2025-04-22 13:29:17', '2025-05-05 05:41:49'),
(17, 'Werewolf (feat. Bring Me The Horizon)', 'werewolf-feat-bring-me-the-horizon', '2023-06-29', NULL, NULL, 'single', 0.00, '2025-04-22 13:29:18', '2025-05-05 05:41:49'),
(18, 'AmEN! (feat. Lil Uzi Vert and Daryl Palumbo of Glassjaw)', 'amen-feat-lil-uzi-vert-and-daryl-palumbo-of-glassjaw', '2023-06-01', NULL, NULL, 'single', 0.00, '2025-04-22 13:29:19', '2025-05-05 05:41:49'),
(19, 'Wish I Could Forget (with blackbear & Bring Me The Horizon)', 'wish-i-could-forget-with-blackbear--bring-me-the-horizon', '2023-05-19', NULL, NULL, 'single', 0.00, '2025-04-22 13:29:19', '2025-05-05 05:41:49'),
(20, 'LosT', 'lost', '2023-05-04', NULL, NULL, 'single', 0.00, '2025-04-22 13:29:20', '2025-05-05 05:41:49'),
(21, 'sTraNgeRs', 'strangers', '2022-07-06', NULL, NULL, 'single', 0.00, '2025-04-22 13:29:21', '2025-05-05 05:41:49'),
(22, 'Bad Life', 'bad-life', '2022-06-24', NULL, NULL, 'single', 0.00, '2025-04-22 13:29:22', '2025-05-05 05:41:49'),
(23, 'Bad Life (acoustic)', 'bad-life-acoustic', '2022-05-27', NULL, NULL, 'single', 0.00, '2025-04-22 13:29:22', '2025-05-05 05:41:49'),
(24, 'Fallout', 'fallout', '2022-04-01', NULL, NULL, 'single', 0.00, '2025-04-22 13:29:23', '2025-05-05 05:41:49'),
(25, 'Bad Habits (feat. Bring Me The Horizon)', 'bad-habits-feat-bring-me-the-horizon', '2022-02-08', NULL, NULL, 'single', 0.00, '2025-04-22 13:29:24', '2025-05-05 05:41:50'),
(26, 'Moon Over the Castle (from GRAN TURISMO 7)', 'moon-over-the-castle-from-gran-turismo-7', '2022-02-04', NULL, NULL, 'single', 0.00, '2025-04-22 13:29:25', '2025-05-05 05:41:50'),
(27, 'DiE4u (six impala \"DiE6u\" Remix)', 'die4u-six-impala-die6u-remix', '2021-12-17', NULL, NULL, 'single', 0.00, '2025-04-22 13:29:25', '2025-05-05 05:41:50'),
(28, 'VAMPIR', 'vampir', '2021-12-10', NULL, NULL, 'single', 0.00, '2025-04-22 13:29:26', '2025-05-05 05:41:50'),
(29, 'Let’s Get The Party Started (feat. Bring Me The Horizon)', 'lets-get-the-party-started-feat-bring-me-the-horizon', '2021-09-22', NULL, NULL, 'single', 0.00, '2025-04-22 13:29:27', '2025-05-05 05:41:50'),
(30, 'DiE4u', 'die4u', '2021-09-16', NULL, NULL, 'single', 0.00, '2025-04-22 13:29:27', '2025-05-05 05:41:50'),
(31, 'No More Friends', 'no-more-friends', '2021-06-10', NULL, NULL, 'single', 0.00, '2025-04-22 13:29:28', '2025-05-05 05:41:50'),
(32, 'Can You Feel My Heart (Remix)', 'can-you-feel-my-heart-remix', '2021-03-05', NULL, NULL, 'single', 0.00, '2025-04-22 13:29:29', '2025-05-05 05:41:50'),
(33, 'Teardrops', 'teardrops', '2020-10-22', NULL, NULL, 'single', 0.00, '2025-04-22 13:29:30', '2025-05-05 05:41:50'),
(34, 'Obey (with YUNGBLUD)', 'obey-with-yungblud', '2020-09-02', NULL, NULL, 'single', 0.00, '2025-04-22 13:29:30', '2025-05-05 05:41:50'),
(35, 'Parasite Eve', 'parasite-eve', '2020-06-25', NULL, NULL, 'single', 0.00, '2025-04-22 13:29:31', '2025-05-05 05:41:50'),
(36, 'Ludens', 'ludens', '2019-11-06', NULL, NULL, 'single', 0.00, '2025-04-22 13:29:32', '2025-05-05 05:41:50'),
(37, 'sugar honey ice & tea (Edit)', 'sugar-honey-ice--tea-edit', '2019-07-26', NULL, NULL, 'single', 0.00, '2025-04-22 13:29:32', '2025-05-05 05:41:50'),
(38, 'mother tongue (Sub Focus Remix)', 'mother-tongue-sub-focus-remix', '2019-06-14', NULL, NULL, 'single', 0.00, '2025-04-22 13:29:34', '2025-05-05 05:41:50'),
(39, 'nihilist blues (feat. Grimes)', 'nihilist-blues-feat-grimes', '2019-01-24', NULL, NULL, 'single', 0.00, '2025-04-22 13:29:35', '2025-05-05 05:41:50'),
(40, 'mother tongue', 'mother-tongue', '2019-01-22', NULL, NULL, 'single', 0.00, '2025-04-22 13:29:35', '2025-05-05 05:41:50'),
(41, 'medicine', 'medicine', '2019-01-03', NULL, NULL, 'single', 0.00, '2025-04-22 13:29:36', '2025-05-05 05:41:50'),
(42, 'wonderful life (feat. Dani Filth)', 'wonderful-life-feat-dani-filth', '2018-10-21', NULL, NULL, 'single', 0.00, '2025-04-22 13:29:37', '2025-05-05 05:41:50'),
(43, 'MANTRA', 'mantra', '2018-08-21', NULL, NULL, 'single', 0.00, '2025-04-22 13:29:37', '2025-05-05 05:41:50'),
(44, 'Oh No (Radio Edit)', 'oh-no-radio-edit', '2016-11-18', NULL, NULL, 'single', 0.00, '2025-04-22 13:29:38', '2025-05-05 05:41:50'),
(45, 'Drown (Live from Maida Vale)', 'drown-live-from-maida-vale', '2015-12-26', NULL, NULL, 'single', 0.00, '2025-04-22 13:29:39', '2025-05-05 05:41:50'),
(46, 'Can You Feel My Heart', 'can-you-feel-my-heart', '2013-10-13', NULL, NULL, 'single', 0.00, '2025-04-22 13:29:39', '2025-05-05 05:41:50'),
(47, 'Sleepwalking', 'sleepwalking', '2013-03-04', NULL, NULL, 'single', 0.00, '2025-04-22 13:29:40', '2025-05-05 05:41:50'),
(48, 'This Is What the Edge of Your Seat Was Made For', 'this-is-what-the-edge-of-your-seat-was-made-for', '2004-10-02', NULL, NULL, 'ep', 0.00, '2025-04-22 13:29:41', '2025-05-05 05:41:50'),
(49, '2004 - 2013', '2004---2013', '2017-11-24', NULL, NULL, 'compilation', 0.00, '2025-04-22 13:29:42', '2025-05-05 05:41:50'),
(50, 'Lifeblood', 'lifeblood', '2021-01-07', NULL, NULL, 'single', 0.00, '2025-04-27 01:21:34', '2025-05-05 05:41:50'),
(51, 'God Hand', 'god-hand', '2019-07-05', NULL, NULL, 'album', 0.00, '2025-04-27 01:21:35', '2025-05-05 05:41:50'),
(52, 'Purge', 'purge', '2023-12-13', NULL, NULL, 'single', 0.00, '2025-04-27 01:21:36', '2025-05-05 05:41:50'),
(53, 'Erase You', 'erase-you', '2023-09-15', NULL, NULL, 'single', 0.00, '2025-04-27 01:21:37', '2025-05-05 05:41:50'),
(54, 'Awaken in Ashes', 'awaken-in-ashes', '2023-07-12', NULL, NULL, 'single', 0.00, '2025-04-27 01:21:38', '2025-05-05 05:41:50'),
(55, 'Weight Of The World (feat. We Came As Romans & Brand Of Sacrifice)', 'weight-of-the-world-feat-we-came-as-romans--brand-of-sacrifice', '2023-05-16', NULL, NULL, 'single', 0.00, '2025-04-27 01:21:38', '2025-05-05 05:41:50'),
(56, 'Between Death and Dreams', 'between-death-and-dreams', '2023-04-21', NULL, NULL, 'ep', 0.00, '2025-04-27 01:21:39', '2025-05-05 05:41:50'),
(57, 'Dynasty', 'dynasty', '2023-02-08', NULL, NULL, 'single', 0.00, '2025-04-27 01:21:40', '2025-05-05 05:41:50'),
(58, 'Exodus', 'exodus', '2022-11-09', NULL, NULL, 'single', 0.00, '2025-04-27 01:21:41', '2025-05-05 05:41:50'),
(59, 'Demon King', 'demon-king', '2020-12-09', NULL, NULL, 'single', 0.00, '2025-04-27 01:21:41', '2025-05-05 05:41:50'),
(60, 'Darkbloom', 'darkbloom', '2022-04-20', NULL, NULL, 'single', 0.00, '2025-04-27 01:21:42', '2025-05-05 05:41:50'),
(61, 'Enemy', 'enemy', '2021-08-05', NULL, NULL, 'single', 0.00, '2025-04-27 01:21:44', '2025-05-05 05:41:50'),
(62, 'Altered Eyes', 'altered-eyes', '2021-02-25', NULL, NULL, 'single', 0.00, '2025-04-27 01:21:44', '2025-05-05 05:41:50'),
(63, 'Animal', 'animal', '2021-01-28', NULL, NULL, 'single', 0.00, '2025-04-27 01:21:45', '2025-05-05 05:41:50'),
(64, 'The Interstice', 'the-interstice', '2018-09-14', NULL, NULL, 'ep', 0.00, '2025-04-27 01:21:47', '2025-05-05 05:41:50'),
(65, 'Circling Terror', 'circling-terror', '2025-03-07', NULL, NULL, 'album', 0.00, '2025-04-27 01:21:50', '2025-05-05 05:41:50'),
(66, 'in my restless dreams, i see you', 'in-my-restless-dreams-i-see-you', '2023-09-29', NULL, NULL, 'album', 0.00, '2025-04-27 01:21:51', '2025-05-05 05:41:50'),
(67, 'TrenchBoy||', 'trenchboy', '2020-10-21', NULL, NULL, 'album', 0.00, '2025-04-27 01:21:52', '2025-05-05 05:41:50'),
(68, 'Cowboy Cutie', 'cowboy-cutie', '2019-07-20', NULL, NULL, 'album', 0.00, '2025-04-27 01:21:53', '2025-05-05 05:41:50'),
(69, 'Next Time You See Me I\'ll Be Dead on Your Doorstep', 'next-time-you-see-me-ill-be-dead-on-your-doorstep', '2018-06-29', NULL, NULL, 'album', 0.00, '2025-04-27 01:21:54', '2025-05-05 05:41:50'),
(70, 'Scarlet Teeth', 'scarlet-teeth', '2024-11-08', NULL, NULL, 'single', 0.00, '2025-04-27 01:21:55', '2025-05-05 05:41:50'),
(71, 'Tonal Dread', 'tonal-dread', '2024-09-06', NULL, NULL, 'single', 0.00, '2025-04-27 01:21:55', '2025-05-05 05:41:50'),
(72, 'Pit of Despair', 'pit-of-despair', '2024-07-26', NULL, NULL, 'single', 0.00, '2025-04-27 01:21:56', '2025-05-05 05:41:50'),
(73, 'TortureInsideMyAmygdala', 'tortureinsidemyamygdala', '2024-05-31', NULL, NULL, 'single', 0.00, '2025-04-27 01:21:57', '2025-05-05 05:41:50'),
(74, 'PLEASE DON\'T HAUNT ME', 'please-dont-haunt-me', '2024-04-12', NULL, NULL, 'single', 0.00, '2025-04-27 01:21:58', '2025-05-05 05:41:50'),
(75, 'SIGNS', 'signs', '2024-03-06', NULL, NULL, 'single', 0.00, '2025-04-27 01:21:58', '2025-05-05 05:41:50'),
(76, 'in your darkest nightmares, you\'ll see me', 'in-your-darkest-nightmares-youll-see-me', '2023-12-01', NULL, NULL, 'single', 0.00, '2025-04-27 01:21:59', '2025-05-05 05:41:50'),
(77, 'paranoia agent', 'paranoia-agent', '2023-08-11', NULL, NULL, 'single', 0.00, '2025-04-27 01:22:00', '2025-05-05 05:41:50'),
(78, 'ghost in the shell (feat. SXMPRA)', 'ghost-in-the-shell-feat-sxmpra', '2023-06-30', NULL, NULL, 'single', 0.00, '2025-04-27 01:22:00', '2025-05-05 05:41:50'),
(79, 'flowers by her grave', 'flowers-by-her-grave', '2023-03-24', NULL, NULL, 'single', 0.00, '2025-04-27 01:22:01', '2025-05-05 05:41:50'),
(80, 'Roach Latency', 'roach-latency', '2022-11-25', NULL, NULL, 'single', 0.00, '2025-04-27 01:22:02', '2025-05-05 05:41:50'),
(81, 'sorry im a haunted house', 'sorry-im-a-haunted-house', '2022-09-02', NULL, NULL, 'single', 0.00, '2025-04-27 01:22:03', '2025-05-05 05:41:50'),
(82, 'GauzeValley', 'gauzevalley', '2022-06-23', NULL, NULL, 'single', 0.00, '2025-04-27 01:22:03', '2025-05-05 05:41:50'),
(83, 'CATACOMBS!', 'catacombs', '2022-04-20', NULL, NULL, 'single', 0.00, '2025-04-27 01:22:04', '2025-05-05 05:41:50'),
(84, 'Feasting.On.The.Guts.Of.Angels.', 'feastingonthegutsofangels', '2021-12-23', NULL, NULL, 'single', 0.00, '2025-04-27 01:22:05', '2025-05-05 05:41:50'),
(85, 'heartRACE', 'heartrace', '2021-07-22', NULL, NULL, 'single', 0.00, '2025-04-27 01:22:06', '2025-05-05 05:41:50'),
(86, 'SOUL SNATCH', 'soul-snatch', '2021-07-17', NULL, NULL, 'single', 0.00, '2025-04-27 01:22:06', '2025-05-05 05:41:50'),
(87, 'WeProbablyShouldn\'ttalkanymore', 'weprobablyshouldnttalkanymore', '2018-12-15', NULL, NULL, 'single', 0.00, '2025-04-27 01:22:07', '2025-05-05 05:41:50'),
(88, 'SorryItsVague', 'sorryitsvague', '2018-11-14', NULL, NULL, 'single', 0.00, '2025-04-27 01:22:08', '2025-05-05 05:41:50'),
(89, 'MyGothBitchCameWithaglock', 'mygothbitchcamewithaglock', '2018-08-27', NULL, NULL, 'single', 0.00, '2025-04-27 01:22:09', '2025-05-05 05:41:50'),
(90, 'I Might Die Before I Detox', 'i-might-die-before-i-detox', '2017-06-03', NULL, NULL, 'single', 0.00, '2025-04-27 01:22:09', '2025-05-05 05:41:50'),
(91, 'Семейный альбом', 'семейный-альбом', '2023-12-15', NULL, NULL, 'album', 0.00, '2025-04-27 01:22:12', '2025-05-05 05:41:50'),
(92, 'Красота и Уродство', 'красота-и-уродство', '2021-12-01', NULL, NULL, 'album', 0.00, '2025-04-27 01:22:12', '2025-05-05 05:41:50'),
(93, 'miXXXtape III: Смутное Время', 'mixxxtape-iii-смутное-время', '2021-11-12', NULL, NULL, 'album', 0.00, '2025-04-27 01:22:13', '2025-05-05 05:41:50'),
(94, 'Горгород', 'горгород', '2015-11-13', NULL, NULL, 'album', 0.00, '2025-04-27 01:22:14', '2025-05-05 05:41:50'),
(95, 'miXXXtape II: Долгий путь домой', 'mixxxtape-ii-долгий-путь-домой', '2013-10-18', NULL, NULL, 'album', 0.00, '2025-04-27 01:22:15', '2025-05-05 05:41:50'),
(96, 'Вечный жид', 'вечный-жид', '2011-09-15', NULL, NULL, 'album', 0.00, '2025-04-27 01:22:17', '2025-05-05 05:41:50'),
(97, 'журавли', 'журавли', '2024-08-30', NULL, NULL, 'single', 0.00, '2025-04-27 01:22:17', '2025-05-05 05:41:50'),
(98, 'МИР ГОРИТ', 'мир-горит', '2024-05-13', NULL, NULL, 'single', 0.00, '2025-04-27 01:22:18', '2025-05-05 05:41:50'),
(99, 'Прекрасное Далёко', 'прекрасное-далёко', '2023-09-26', NULL, NULL, 'single', 0.00, '2025-04-27 01:22:19', '2025-05-05 05:41:50'),
(100, '1.Kla$ Pt. 2', '1kla-pt-2', '2023-09-15', NULL, NULL, 'single', 0.00, '2025-04-27 01:22:20', '2025-05-05 05:41:50'),
(101, '1.Kla$', '1kla', '2023-09-01', NULL, NULL, 'single', 0.00, '2025-04-27 01:22:21', '2025-05-05 05:41:50'),
(102, 'Я знаю, что делал прошлым летом', 'я-знаю-что-делал-прошлым-летом', '2023-08-25', NULL, NULL, 'single', 0.00, '2025-04-27 01:22:21', '2025-05-05 05:41:50'),
(103, 'Лига Опасного Интернета', 'лига-опасного-интернета', '2023-08-11', NULL, NULL, 'single', 0.00, '2025-04-27 01:22:22', '2025-05-05 05:41:50'),
(104, 'THE STORY OF ALISHER', 'the-story-of-alisher', '2022-12-13', NULL, NULL, 'single', 0.00, '2025-04-27 01:22:23', '2025-05-05 05:41:50'),
(105, 'BASSLINE BUSINESS', 'bassline-business', '2022-10-28', NULL, NULL, 'single', 0.00, '2025-04-27 01:22:23', '2025-05-05 05:41:50'),
(106, 'НЛО', 'нло', '2022-10-21', NULL, NULL, 'single', 0.00, '2025-04-27 01:22:24', '2025-05-05 05:41:50'),
(107, '23 февраля', '23-февраля', '2022-10-14', NULL, NULL, 'single', 0.00, '2025-04-27 01:22:25', '2025-05-05 05:41:50'),
(108, 'Сделано в России', 'сделано-в-россии', '2022-09-30', NULL, NULL, 'single', 0.00, '2025-04-27 01:22:26', '2025-05-05 05:41:50'),
(109, 'ОЙДА', 'ойда', '2022-09-16', NULL, NULL, 'single', 0.00, '2025-04-27 01:22:26', '2025-05-05 05:41:50'),
(110, 'ОРГАНИЗАЦИЯ', 'организация', '2021-11-08', NULL, NULL, 'single', 0.00, '2025-04-27 01:22:27', '2025-05-05 05:41:50'),
(111, 'ЦУНАМИ', 'цунами', '2021-11-06', NULL, NULL, 'single', 0.00, '2025-04-27 01:22:28', '2025-05-05 05:41:50'),
(112, 'КТО УБИЛ МАРКА?', 'кто-убил-марка', '2021-11-01', NULL, NULL, 'single', 0.00, '2025-04-27 01:22:29', '2025-05-05 05:41:50'),
(113, 'Стихи о неизвестном солдате (из трибьюта Осипу Мандельштаму «Сохрани мою речь навсегда»)', 'стихи-о-неизвестном-солдате-из-трибьюта-осипу-мандельштаму-сохрани-мою-речь-навсегда', '2021-01-14', NULL, NULL, 'single', 0.00, '2025-04-27 01:22:29', '2025-05-05 05:41:50'),
(114, 'В книге все было по-другому (4 раунд, 17ib)', 'в-книге-все-было-по-другому-4-раунд-17ib', '2020-02-03', NULL, NULL, 'single', 0.00, '2025-04-27 01:22:30', '2025-05-05 05:41:50'),
(115, 'Дело нескольких минут (3 раунд, 17 ib)', 'дело-нескольких-минут-3-раунд-17-ib', '2019-12-23', NULL, NULL, 'single', 0.00, '2025-04-27 01:22:31', '2025-05-05 05:41:50'),
(116, 'Ветер Перемен (2 раунд, 17ib)', 'ветер-перемен-2-раунд-17ib', '2019-11-06', NULL, NULL, 'single', 0.00, '2025-04-27 01:22:32', '2025-05-05 05:41:50'),
(117, 'В долгий путь (1 раунд, 17ib)', 'в-долгий-путь-1-раунд-17ib', '2019-09-04', NULL, NULL, 'single', 0.00, '2025-04-27 01:22:32', '2025-05-05 05:41:50'),
(118, 'Биполярочка', 'биполярочка', '2017-09-14', NULL, NULL, 'single', 0.00, '2025-04-27 01:22:33', '2025-05-05 05:41:50'),
(119, 'Что такое империя?', 'что-такое-империя', '2017-08-11', NULL, NULL, 'single', 0.00, '2025-04-27 01:22:34', '2025-05-05 05:41:50'),
(120, 'Город под подошвой', 'город-под-подошвой', '2015-09-21', NULL, NULL, 'single', 0.00, '2025-04-27 01:22:35', '2025-05-05 05:41:50'),
(121, 'HPL', 'hpl', '2015-06-05', NULL, NULL, 'single', 0.00, '2025-04-27 01:22:35', '2025-05-05 05:41:50'),
(122, 'Мне скучно жить', 'мне-скучно-жить', '2014-11-27', NULL, NULL, 'single', 0.00, '2025-04-27 01:22:36', '2025-05-05 05:41:50'),
(123, 'Earth Burns', 'earth-burns', '2014-08-18', NULL, NULL, 'single', 0.00, '2025-04-27 01:22:37', '2025-05-05 05:41:50'),
(124, 'То густо, то пусто', 'то-густо-то-пусто', '2011-06-18', NULL, NULL, 'ep', 0.00, '2025-04-27 01:22:38', '2025-05-05 05:41:50'),
(125, 'Что такое BEEF?', 'что-такое-beef', '2008-05-13', NULL, NULL, 'single', 0.00, '2025-04-27 01:22:38', '2025-05-05 05:41:50'),
(126, 'Clancy', 'clancy', '2024-05-24', '\"Clancy\" is the seventh studio album by American musical duo Twenty One Pilots, released on May 24, 2024, through Fueled by Ramen and Elektra Records. The album serves as the culmination of a conceptual narrative that began with their 2015 album \"Blurryface,\" continued through \"Trench\" (2018), and \"Scaled and Icy\" (2021), concluding the decade-long storyline. \r\n\r\nThe narrative centers around the protagonist, Clancy, who resides in the fictional city of Dema, controlled by nine oppressive bishops led by Nico, the embodiment of insecurity also known as Blurryface. Throughout the series, Clancy attempts multiple escapes from Dema, symbolizing a journey through mental health struggles and the pursuit of freedom. In \"Clancy,\" the character gains mystical powers and prepares to return to Trench to liberate the other citizens of Dema. \r\n\r\nMusically, \"Clancy\" is an eclectic blend of alternative rock, pop rock, hip hop, synth-pop, and indie rock. The album features tracks like \"Overcompensate,\" which opens with electrifying energy, and \"Next Semester,\" a post-punk jam with a ukulele interlude. Themes of relapsing into past patterns are explored in songs such as \"Backslide\" and \"Snap Back,\" while \"Oldies Station\" offers an uplifting message of perseverance. The album concludes with \"Paladin Strait,\" depicting Clancy\'s confrontation with Nico, leaving the resolution open-ended. \r\n\r\nCritically, \"Clancy\" received positive reviews, praised for its ambitious storytelling and dynamic sound. It debuted at number three on the Billboard 200 and number two on the UK Albums Chart, marking it as a commercial success. \r\n\r\nTo support the album, Twenty One Pilots embarked on \"The Clancy World Tour,\" which began in August 2024 and is scheduled to conclude in May 2025, with performances across North America, Oceania, Latin America, and Europe. ', NULL, 'album', 0.00, '2025-05-29 06:10:12', '2025-05-29 06:10:12'),
(127, 'MTV Unplugged (Live)', 'mtv-unplugged-live', '2023-04-21', NULL, NULL, 'album', 0.00, '2025-05-29 06:10:13', '2025-05-29 06:10:13'),
(128, 'Scaled And Icy (Livestream Version)', 'scaled-and-icy-livestream-version', '2021-11-19', NULL, NULL, 'album', 0.00, '2025-05-29 06:10:13', '2025-05-29 06:10:13'),
(129, 'Scaled And Icy', 'scaled-and-icy', '2021-05-21', 'Scaled and Icy is the sixth studio album by American musical duo twenty one pilots, it was released May 21, 2021 by Fueled by Ramen and Elektra. Critics noted its return to the \"playful alt-pop sound\" of Vessel (2013), and a departure from the darker approach of its predecessors Blurryface (2015) and Trench (2018). The album has also been described as alternative rock, pop, rock, rap and synthpop, with elements of electro.\r\n\r\nThe album\'s title is a play on \"scaled back and isolated\", a phrase frontman Tyler Joseph associated with the COVID-19 pandemic and its impact on the music produced at the time. On an interview with Sirius XM, he stated that he wanted to \"lean into being aware that things are scaled back and that we\'re isolated\". Despite that, Joseph\'s goal was to create an album that contrasts this very idea and that conveys the opposite of it. The album title is also an anagram of \"Clancy is dead\", a reference to the protagonist of Trench, the band has however neither described this as coincidental nor declined to comment on this subject. The title\'s initials appear on the cover art for their 2020 single \"Christmas Saves the Year\", on which the sentence \"SAI is propaganda\" is written in purple on one of the wrapped gifts.\r\n\r\nThe cover artwork for Scaled and Icy was designed by Brandon Rike, who also designed the cover art for Trench and Blurryface. It features a scaled, teal dragon breathing yellow fire over a pink background, as well as a psi symbol in the top right corner. The dragon is named Trash, and represents \"inspiration, fear, and magic\"; Joseph explained that he wanted to \"tie the songs to something as powerful as that\". The creature was originally drawn by British illustrator Walter Crane in a children\'s book from the 1860s (the artwork is in the public domain, allowing the band to use it in the album cover). Its usage was also inspired by a small dragon figurine Joseph keeps in his home studio, with Joseph revealing to BBC Radio 1 that it represented an idea that if he were to focus on a single detail of a small room, \"then that detail can then come to life\".\r\n\r\nAlthough a departure from the conceptual narrative found on Trench, the band largely continues to examine serious themes on Scaled and Icy despite its upbeat sound. Joseph explained that the contrast was deliberate, stating that \"as you dive into lyrics, a lot of times it\'s asking some pretty heavy questions and addressing some pretty heavy things\". Neil Z. Yeung of AllMusic described the album as \"a snapshot of the emotional highs and lows of quarantine life\", while Augusta Battoclette of Alternative Press noted the themes of \"anxiety, doubt and the need to keep your loved ones close\".\r\n\r\nThe album was preceded by the singles \"Shy Away\", and \"Choker\", and \"Saturday\", \"The Outside\" was chosen as the fourth single later on.\r\n\r\nScaled and Icy received generally positive reviews from music critics overall. On Metacritic, which assigns a normalized rating out of 100 to reviews from mainstream critics, the album has an average score of 70, based on 9 critical reviews, indicating \"generally favorable reviews\". The album peaked at no. 03 in both the US and the UK. At the 2022 Billboard Music Awards, it won the Top Rock Album category.', NULL, 'album', 0.00, '2025-05-29 06:10:14', '2025-05-29 06:10:14'),
(130, 'Trench', 'trench', '2018-10-05', NULL, NULL, 'album', 0.00, '2025-05-29 06:10:15', '2025-05-29 06:10:15'),
(131, 'Blurryface', 'blurryface', '2015-05-15', NULL, NULL, 'album', 0.00, '2025-05-29 06:10:16', '2025-05-29 06:10:16'),
(132, 'Vessel', 'vessel', '2013-01-08', NULL, NULL, 'album', 0.00, '2025-05-29 06:10:21', '2025-05-29 06:10:21'),
(133, 'Twenty One Pilots', 'twenty-one-pilots', '2009-12-29', NULL, NULL, 'album', 0.00, '2025-05-29 06:10:23', '2025-05-29 06:10:23'),
(134, 'Doubt (demo)', 'doubt-demo', '2025-04-09', NULL, NULL, 'single', 0.00, '2025-05-29 06:10:24', '2025-05-29 06:10:24'),
(135, 'The Line (from the series Arcane League of Legends)', 'the-line-from-the-series-arcane-league-of-legends', '2024-11-22', NULL, NULL, 'single', 0.00, '2025-05-29 06:10:25', '2025-05-29 06:10:25'),
(138, 'Heathens / Trees (Livestream Version)', 'heathens--trees-livestream-version', '2021-09-10', NULL, NULL, 'single', 0.00, '2025-05-29 06:10:32', '2025-05-29 06:10:32'),
(139, 'Shy Away (Livestream Version)', 'shy-away-livestream-version', '2021-06-11', NULL, NULL, 'single', 0.00, '2025-05-29 06:10:33', '2025-05-29 06:10:33'),
(140, 'Christmas Saves The Year', 'christmas-saves-the-year', '2020-12-08', NULL, NULL, 'single', 0.00, '2025-05-29 06:10:33', '2025-05-29 06:10:33'),
(141, 'Level of Concern (live from outside)', 'level-of-concern-live-from-outside', '2020-05-26', NULL, NULL, 'single', 0.00, '2025-05-29 06:10:34', '2025-05-29 06:10:34'),
(142, 'Level of Concern', 'level-of-concern', '2020-04-09', NULL, NULL, 'single', 0.00, '2025-05-29 06:10:35', '2025-05-29 06:10:35'),
(143, 'The Hype (Berlin)', 'the-hype-berlin', '2019-10-16', NULL, NULL, 'single', 0.00, '2025-05-29 06:10:36', '2025-05-29 06:10:36'),
(144, 'The Hype (Alt Mix)', 'the-hype-alt-mix', '2019-07-26', NULL, NULL, 'single', 0.00, '2025-05-29 06:10:37', '2025-05-29 06:10:37'),
(145, 'Cut My Lip (Brooklyn)', 'cut-my-lip-brooklyn', '2019-07-11', NULL, NULL, 'single', 0.00, '2025-05-29 06:10:38', '2025-05-29 06:10:38'),
(146, 'Chlorine (Mexico City)', 'chlorine-mexico-city', '2019-06-21', NULL, NULL, 'single', 0.00, '2025-05-29 06:10:41', '2025-05-29 06:10:41'),
(147, 'Chlorine (Alternative Mix)', 'chlorine-alternative-mix', '2019-02-08', NULL, NULL, 'single', 0.00, '2025-05-29 06:10:42', '2025-05-29 06:10:42'),
(148, 'TOPxMM', 'topxmm', '2016-12-20', NULL, NULL, 'ep', 0.00, '2025-05-29 06:10:43', '2025-05-29 06:10:43'),
(149, 'Cancer', 'cancer', '2016-09-14', NULL, NULL, 'single', 0.00, '2025-05-29 06:10:44', '2025-05-29 06:10:44'),
(150, 'Heathens', 'heathens', '2016-06-16', NULL, NULL, 'single', 0.00, '2025-05-29 06:10:46', '2025-05-29 06:10:46'),
(151, 'Ride', 'ride', '2015-05-12', NULL, NULL, 'single', 0.00, '2025-05-29 06:10:49', '2025-05-29 06:10:49'),
(152, 'Lane Boy', 'lane-boy', '2015-05-04', NULL, NULL, 'single', 0.00, '2025-05-29 06:10:52', '2025-05-29 06:10:52'),
(153, 'Stressed Out', 'stressed-out', '2015-04-28', NULL, NULL, 'single', 0.00, '2025-05-29 06:10:53', '2025-05-29 06:10:53'),
(154, 'Tear in My Heart', 'tear-in-my-heart', '2015-04-06', NULL, NULL, 'single', 0.00, '2025-05-29 06:10:54', '2025-05-29 06:10:54'),
(155, 'Fairly Local', 'fairly-local', '2015-03-17', NULL, NULL, 'single', 0.00, '2025-05-29 06:10:56', '2025-05-29 06:10:56'),
(156, 'three songs', 'three-songs', '2012-07-17', NULL, NULL, 'single', 0.00, '2025-05-29 06:10:57', '2025-05-29 06:10:57'),
(157, 'tst_role', 'tst-role', '2025-12-23', 'tst', 'tst', 'album', 0.00, '2026-01-03 14:53:18', '2026-01-03 14:53:18'),
(158, 'Konstrukt release', 'konstrukt-release', '2026-04-01', 'test release with lots of artists', 'test release with lots of artists', 'single', 0.00, '2026-04-07 18:10:50', '2026-04-07 18:10:50');

-- --------------------------------------------------------

--
-- Table structure for table `releases_genres`
--

CREATE TABLE `releases_genres` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `release_id` bigint(20) UNSIGNED NOT NULL,
  `genre_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `releases_genres`
--

INSERT INTO `releases_genres` (`id`, `release_id`, `genre_id`, `created_at`, `updated_at`) VALUES
(1, 1, 2, '2025-04-22 13:31:45', '2025-04-22 13:31:45'),
(2, 1, 7, '2025-04-22 13:31:45', '2025-04-22 13:31:45'),
(3, 1, 9, '2025-04-22 13:31:45', '2025-04-22 13:31:45'),
(4, 1, 13, '2025-04-22 13:31:45', '2025-04-22 13:31:45'),
(5, 1, 28, '2025-05-05 16:43:06', '2025-05-05 16:43:06'),
(6, 1, 41, '2025-05-05 16:43:06', '2025-05-05 16:43:06'),
(7, 2, 2, '2025-04-22 13:30:45', '2025-04-22 13:30:45'),
(8, 2, 5, '2025-04-22 13:30:45', '2025-04-22 13:30:45'),
(9, 2, 7, '2025-04-22 13:30:45', '2025-04-22 13:30:45'),
(10, 2, 8, '2025-04-22 13:30:45', '2025-04-22 13:30:45'),
(11, 2, 10, '2025-04-22 13:30:45', '2025-04-22 13:30:45'),
(12, 5, 6, '2025-04-22 13:31:28', '2025-04-22 13:31:28'),
(13, 5, 7, '2025-04-22 13:31:28', '2025-04-22 13:31:28'),
(14, 5, 10, '2025-04-22 13:31:28', '2025-04-22 13:31:28'),
(15, 5, 12, '2025-04-22 13:31:28', '2025-04-22 13:31:28'),
(16, 5, 36, '2025-04-22 13:31:28', '2025-04-22 13:31:28'),
(17, 6, 2, '2025-04-22 13:30:08', '2025-04-22 13:30:08'),
(18, 6, 6, '2025-04-22 13:30:08', '2025-04-22 13:30:08'),
(19, 6, 7, '2025-04-22 13:30:08', '2025-04-22 13:30:08'),
(20, 6, 8, '2025-04-22 13:30:08', '2025-04-22 13:30:08'),
(21, 6, 9, '2025-04-22 13:30:08', '2025-04-22 13:30:08'),
(22, 7, 2, '2025-04-22 13:30:24', '2025-04-22 13:30:24'),
(23, 7, 7, '2025-04-22 13:30:25', '2025-04-22 13:30:25'),
(24, 7, 9, '2025-04-22 13:30:25', '2025-04-22 13:30:25'),
(25, 7, 16, '2025-04-22 13:30:25', '2025-04-22 13:30:25'),
(26, 10, 1, '2025-04-22 13:31:12', '2025-04-22 13:31:12'),
(27, 10, 2, '2025-04-22 13:31:12', '2025-04-22 13:31:12'),
(28, 10, 3, '2025-04-22 13:31:12', '2025-04-22 13:31:12'),
(29, 10, 4, '2025-04-22 13:31:12', '2025-04-22 13:31:12'),
(30, 10, 5, '2025-04-22 13:31:12', '2025-04-22 13:31:12'),
(31, 11, 1, '2025-04-22 13:30:58', '2025-04-22 13:30:58'),
(32, 11, 2, '2025-04-22 13:30:58', '2025-04-22 13:30:58'),
(33, 11, 3, '2025-04-22 13:30:58', '2025-04-22 13:30:58'),
(34, 11, 4, '2025-04-22 13:30:58', '2025-04-22 13:30:58'),
(35, 11, 32, '2025-04-22 13:30:58', '2025-04-22 13:30:58'),
(36, 13, 2, '2025-05-27 16:22:53', '2025-05-27 16:22:53');

-- --------------------------------------------------------

--
-- Table structure for table `roles`
--

CREATE TABLE `roles` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(80) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `roles`
--

INSERT INTO `roles` (`id`, `name`, `description`, `created_at`, `updated_at`) VALUES
(1, 'super_admin', 'Superadministratora tiesības. Iekļauj sevī visas tiesības.', '2025-05-09 15:50:19', '2025-05-09 15:50:19'),
(2, 'test_role', 'role to test', '2025-05-09 18:41:01', '2025-05-09 18:41:01'),
(3, 'an_test', 'another test role', '2025-05-10 09:58:15', '2025-12-30 07:49:49'),
(4, 'test_role2', 'role to test 2', '2025-12-23 08:21:55', '2025-12-23 08:21:55'),
(5, 'test_role3', 'role to test3', '2025-12-23 08:22:40', '2025-12-23 08:22:40'),
(6, 'test_role4', 'role to test4', '2025-12-23 08:22:40', '2025-12-23 08:22:40'),
(7, 'test_role5', 'test role 5', '2025-12-30 07:29:47', '2025-12-30 07:29:47'),
(8, 'test_role6', 'test role 6', '2025-12-30 07:29:47', '2025-12-30 07:29:47'),
(9, 'test_role7', 'test role 7', '2025-12-30 07:30:33', '2025-12-30 07:30:33'),
(10, 'test_role8', 'test role 8', '2025-12-30 07:30:33', '2025-12-30 07:30:33'),
(11, 'test_role9', 'test role 9', '2025-12-30 07:31:41', '2025-12-30 07:31:41'),
(14, 'roletestdlt', 'fdsfjij', '2025-12-30 10:05:25', '2026-01-02 08:44:55'),
(18, 'create_role_tst', 'optional heyya', '2026-01-02 10:27:47', '2026-01-02 10:28:02'),
(21, 'comments_moderator', 'Tiesības administrēt visu lietotāju komentārus.', '2026-01-25 14:54:28', '2026-01-25 14:54:28');

-- --------------------------------------------------------

--
-- Table structure for table `sessions`
--

CREATE TABLE `sessions` (
  `id` varchar(255) NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `user_agent` text DEFAULT NULL,
  `payload` longtext NOT NULL,
  `last_activity` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `sessions`
--

INSERT INTO `sessions` (`id`, `user_id`, `ip_address`, `user_agent`, `payload`, `last_activity`) VALUES
('84iChFK4sSAJGUrS3C6Dd9eMOBbycYRhSyKJYMqB', 5, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'YTo1OntzOjY6Il90b2tlbiI7czo0MDoiekQwVmd4S3JHREc2b1RoZzRQbmFsNnlpR09DYTZ1bHFFenA1Z1lDdiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzE6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC9kYXNoYm9hcmQiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX1zOjY6ImxvY2FsZSI7czoyOiJsdiI7czo1MDoibG9naW5fd2ViXzU5YmEzNmFkZGMyYjJmOTQwMTU4MGYwMTRjN2Y1OGVhNGUzMDk4OWQiO2k6NTt9', 1776952044),
('8QCfbuGTtbSuvrxNnV3SLibnAD7DW5VqMWGaDfj8', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoia0EzVTdmY1BVclNGZUtONlhOSHprYUlXTWtoalZhaDNOODZ6NlV0NCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjE6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMCI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1777197066),
('g5xAar4iIHmrgCfW0NojZCXfVJn9ULbzARFKzzHv', 5, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoiWXoxSTZHbENSRHZZVDZrNlNZcHFmNENYQnJ4OHNzdGVHZGZSZTc0NSI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Mjc6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC9sb2dpbiI7fXM6NTA6ImxvZ2luX3dlYl81OWJhMzZhZGRjMmIyZjk0MDE1ODBmMDE0YzdmNThlYTRlMzA5ODlkIjtpOjU7fQ==', 1777210172),
('hG1D3uhh2C8us43svelvFlKrehUjt03u5QZwmG1i', 5, '127.0.0.1', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', 'YTo1OntzOjY6Il90b2tlbiI7czo0MDoiOVZXVnVTTDk3WThKS3ExSEdvVFZYeDFCUDZ4dlNZTXN6REFJRm5PUSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NTA6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC9hcnRpc3RzL2JyaW5nLW1lLXRoZS1ob3Jpem9uIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319czo1MDoibG9naW5fd2ViXzU5YmEzNmFkZGMyYjJmOTQwMTU4MGYwMTRjN2Y1OGVhNGUzMDk4OWQiO2k6NTtzOjY6ImxvY2FsZSI7czoyOiJlbiI7fQ==', 1776715505),
('lXJAV2RmvzEDfl7IKaZvO9eySYOgTQD7pQApWR14', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoiMUVZaTJlUnBVc2RaSk5INkxsNGVETzltaTRDUUJDZTNYZ1ZvZlRyRCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6ODM6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC9yZWxlYXNlcy9hbWVuLWZlYXQtbGlsLXV6aS12ZXJ0LWFuZC1kYXJ5bC1wYWx1bWJvLW9mLWdsYXNzamF3Ijt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319czo2OiJsb2NhbGUiO3M6MjoiZW4iO30=', 1776800879),
('pUE9rfuaBmhUBXLMOw5FKsSRB2Ic0MNBxP4csGIe', 5, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoiVE9GM3hyZ25SNDAzb3lZbmNmeDB2c1ZoS0l4cXIzbFJkSE1QaUtJbSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzE6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC9kYXNoYm9hcmQiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX1zOjUwOiJsb2dpbl93ZWJfNTliYTM2YWRkYzJiMmY5NDAxNTgwZjAxNGM3ZjU4ZWE0ZTMwOTg5ZCI7aTo1O30=', 1776792932),
('RhC7sJC6IgXsVpbXMjInUYht7HsQLNPvpX7Sq9P8', 5, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoiR1JqRFI3aEZodnkxOUV2Q0VRa0JkV2hsUHEyYWNkWnBkWXRQRVM3VyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzE6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC9kYXNoYm9hcmQiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX1zOjUwOiJsb2dpbl93ZWJfNTliYTM2YWRkYzJiMmY5NDAxNTgwZjAxNGM3ZjU4ZWE0ZTMwOTg5ZCI7aTo1O30=', 1776970221);

-- --------------------------------------------------------

--
-- Table structure for table `tracks`
--

CREATE TABLE `tracks` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `title` varchar(255) NOT NULL,
  `slug` varchar(255) NOT NULL,
  `duration` time NOT NULL,
  `description` text DEFAULT NULL,
  `description_lv` text DEFAULT NULL,
  `audio_source` varchar(255) DEFAULT NULL,
  `release_date` date NOT NULL,
  `popularity` double(10,2) NOT NULL DEFAULT 0.00,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `tracks`
--

INSERT INTO `tracks` (`id`, `title`, `slug`, `duration`, `description`, `description_lv`, `audio_source`, `release_date`, `popularity`, `created_at`, `updated_at`) VALUES
(1, '[ost] dreamseeker', 'ost-dreamseeker', '00:00:19', NULL, NULL, NULL, '2024-05-24', 0.00, '2025-04-22 13:29:04', '2025-05-05 17:47:45'),
(2, 'YOUtopia', 'youtopia', '00:04:02', NULL, NULL, '', '2024-05-24', 0.00, '2025-04-22 13:29:04', '2025-05-05 17:47:45'),
(3, 'Kool-Aid', 'kool-aid', '00:03:48', '“Kool-Aid” explores the manipulative and abusive drive of a cult leader who, in the end, is willing to sacrifice his followers for the ‘greater’ cause.\n\nThe title of the song is a reference to the Jonestown Massacre where 900 members of the Peoples Temple cult committed mass suicide upon the request of their leader, Jim Jones. They died from drinking cyanide and other sedatives in a fruit drink named “Flavor Aid”, which was originally misidentified as Kool-Aid. They later found needle marks, which meant some people were forced to die, making it a mass murder.\n\nThis is the sixth single and the third track from Bring Me The Horizon’s POST HUMAN: NeX GEn’s album, released on the 24th of May, 2024. Within its overarching lore, ”Kool-Aid” could be regarding the relationship within a cult/religion, more specifically The Church of GenXsis. Read more on Last.fm. User-contributed text is available under the Creative Commons By-SA License; additional terms may apply.', NULL, 'Jq4NhAnnD0Q?si=hnsGs5R4XGbBZ_aC', '2024-01-05', 0.00, '2025-04-22 13:29:04', '2025-05-05 17:47:45'),
(4, 'Top 10 staTues tHat CriEd bloOd', 'top-10-statues-that-cried-blood', '00:04:00', NULL, NULL, NULL, '2024-05-24', 0.00, '2025-04-22 13:29:04', '2025-05-05 17:47:45'),
(5, 'liMOusIne (feat. AURORA)', 'limousine-feat-aurora', '00:04:11', '\"liMOusIne\" is a song by Bring Me The Horizon featuring AURORA, released for the band\'s seventh studio album POST HUMAN: NeX GEn.\n\nOn April 13, 2024, Oliver posted a photo with AURORA, creating rumors that they would release a feature together. Read more on Last.fm. User-contributed text is available under the Creative Commons By-SA License; additional terms may apply.', NULL, NULL, '2024-05-24', 0.00, '2025-04-22 13:29:04', '2025-05-05 17:47:45'),
(6, 'DArkSide', 'darkside', '00:02:45', '“DArkSide” is the sixth song on POST HUMAN: NeX GEn, the second instalment in the POST HUMAN series. It got released as the fifth single off the album before it’s full release, and also as the final single before Jordan Fish left the band on December 22, 2023\n\nThe song explores the darker side of the mind and the struggles you can have with yourself from within. Read more on Last.fm. User-contributed text is available under the Creative Commons By-SA License; additional terms may apply.', NULL, '3Nt37RGbVjo?si=6ZfZ1qqRfkTJr6Mv', '2023-10-13', 0.00, '2025-04-22 13:29:04', '2025-05-05 17:47:45'),
(7, 'a bulleT w/ my namE On (feat. Underoath)', 'a-bullet-w-my-name-on-feat-underoath', '00:04:20', NULL, NULL, NULL, '2024-05-24', 0.00, '2025-04-22 13:29:04', '2025-05-05 17:47:45'),
(8, '[ost] (spi)ritual', 'ost-spiritual', '00:01:54', NULL, NULL, NULL, '2024-05-24', 0.00, '2025-04-22 13:29:04', '2025-05-05 17:47:45'),
(9, 'n/A', 'na', '00:03:20', NULL, NULL, NULL, '2024-05-24', 0.00, '2025-04-22 13:29:04', '2025-05-05 17:47:45'),
(10, 'LosT', 'lost', '00:03:25', NULL, NULL, NULL, '2023-05-04', 0.00, '2025-04-22 13:29:04', '2025-05-05 17:47:45'),
(11, 'sTraNgeRs', 'strangers', '00:03:15', '“Strangers” is a song involving themes of depression and mental illness, but it also has an overall message of unity and togetherness, painting a picture that an entire ‘room full of strangers’ could all be having the same struggles and insecurities. The single was released on Wednesday, July 6th.\nIn an interview with NME, lead singer Oli Sykes went on to explain that this song was a takeaway from him having to share his pain with other people. He goes on to say that the first time he went to rehab, it was a ‘huge help’ to be surrounded by other people that were all suffering from something.\n\nJust to be surrounded by people who were all going through something, I thought, ‘Fuck, this is a human condition. This isn’t just me’. I thought I was insane, I didn’t think I was ever going to get better, and I’m listening to all these people saying all my thoughts, even though they’ve been through things that were different – worse…and obviously sTraNgeRs is that takeaway of like, we’re all just looking for security. We’re all just lost…it’s the first part of getting better, is the fact that you’re gonna have to accept that you’re gonna have to talk about this, no matter how bad what you’ve been through is. If you don’t get it out of your head, it’s never going to go.\n\nSykes also went on to explain how he believes n/A, LosT and sTraNgeRs are all part of what he calls the ‘rehab trilogy’, with n/A being the group session, LosT being the 1 on 1 therapy session, and sTraNgeRs about the realization of sharing your pain with other people. Read more on Last.fm. User-contributed text is available under the Creative Commons By-SA License; additional terms may apply.', NULL, NULL, '2022-07-06', 0.00, '2025-04-22 13:29:05', '2025-05-05 17:47:45'),
(12, 'R.i.p. (duskCOre RemIx)', 'rip-duskcore-remix', '00:03:23', NULL, NULL, NULL, '2024-05-24', 0.00, '2025-04-22 13:29:05', '2025-05-05 17:47:45'),
(13, 'AmEN! (feat. Lil Uzi Vert and Daryl Palumbo of Glassjaw)', 'amen-feat-lil-uzi-vert-and-daryl-palumbo-of-glassjaw', '00:03:09', NULL, NULL, NULL, '2023-06-01', 0.00, '2025-04-22 13:29:05', '2025-05-05 17:47:45'),
(14, '[ost] p.u.s.s.-e', 'ost-puss-e', '00:02:49', 'produced by cynthoni Read more on Last.fm. User-contributed text is available under the Creative Commons By-SA License; additional terms may apply.', NULL, NULL, '2024-05-24', 0.00, '2025-04-22 13:29:05', '2025-05-05 17:47:45'),
(15, 'DiE4u', 'die4u', '00:03:27', NULL, NULL, NULL, '2021-09-16', 0.00, '2025-04-22 13:29:05', '2025-05-05 17:47:45'),
(16, 'DIg It', 'dig-it', '00:07:12', NULL, NULL, NULL, '2024-05-24', 0.00, '2025-04-22 13:29:05', '2025-05-05 17:47:45'),
(17, 'Dear Diary,', 'dear-diary', '00:02:44', NULL, NULL, NULL, '2020-10-30', 0.00, '2025-04-22 13:29:05', '2025-05-05 17:47:45'),
(18, 'Parasite Eve', 'parasite-eve', '00:04:51', NULL, NULL, NULL, '2020-06-25', 0.00, '2025-04-22 13:29:05', '2025-05-05 17:47:45'),
(19, 'Teardrops', 'teardrops', '00:03:35', NULL, NULL, NULL, '2020-10-22', 0.00, '2025-04-22 13:29:05', '2025-05-05 17:47:45'),
(20, 'Obey (with YUNGBLUD)', 'obey-with-yungblud', '00:03:40', NULL, NULL, NULL, '2020-09-02', 0.00, '2025-04-22 13:29:05', '2025-05-05 17:47:45'),
(21, 'Itch For The Cure (When Will We Be Free?)', 'itch-for-the-cure-when-will-we-be-free', '00:01:26', NULL, NULL, NULL, '2020-10-30', 0.00, '2025-04-22 13:29:05', '2025-05-05 17:47:45'),
(22, 'Kingslayer (feat. BABYMETAL)', 'kingslayer-feat-babymetal', '00:03:40', '\"Kingslayer\" is the sixth track of Bring Me The Horizon\'s EP Post Human: Survival Horror, released October 30th, 2020. It features Japanese J-pop/metal band BABYMETAL. Read more on Last.fm. User-contributed text is available under the Creative Commons By-SA License; additional terms may apply.', NULL, NULL, '2020-10-30', 0.00, '2025-04-22 13:29:05', '2025-05-05 17:47:45'),
(23, '1x1 (feat. Nova Twins)', '1x1-feat-nova-twins', '00:03:29', NULL, NULL, NULL, '2020-10-30', 0.00, '2025-04-22 13:29:05', '2025-05-05 17:47:45'),
(24, 'Ludens', 'ludens', '00:04:40', '“It doesn’t sound like anything off ‘amo’, but it doesn’t sound like anything off any of our records,” frontman Oli Sykes told NME. “It hits a different tone. We had to write it in five days. We’ve been talking about this with Sony and Kojima for quite a while. I was really excited because I loved Metal Gear Solid and Kojima is just my favourite developer, he’s a legend. All of the legal shit was going on to the point where we like, ‘This isn’t going to happen’.\n\n“Then we got a call from the manager and he was like, ‘Yeah, it’s happening, but we need it within a week’. We were like, ‘We haven’t written anything yet! Can we have an extension or send them a demo as a placeholder’, and they were like, ‘If you don’t deliver the song on Saturday at 1pm then it won’t get used’.” Read more on Last.fm. User-contributed text is available under the Creative Commons By-SA License; additional terms may apply.', NULL, NULL, '2019-11-06', 0.00, '2025-04-22 13:29:05', '2025-05-05 17:47:45'),
(25, 'One Day The Only Butterflies Left Will Be In Your Chest As You March Towards Your Death (feat. Amy Lee)', 'one-day-the-only-butterflies-left-will-be-in-your-chest-as-you-march-towards-your-death-feat-amy-lee', '00:04:03', '“One Day the Only Butterflies Left Will Be in Your Chest as You March Towards Your Death” is the final track of Bring Me The Horizon’s POST HUMAN: SURVIVAL HORROR. The song is a haunting ballad between Oli Sykes, representing humanity, and Amy Lee of Evanescence, representing Mother Nature.\n\nThe collaboration was a silver-lining after Evanescence sued the band over a verse from “nihilist blues” being extremely similar to their 2017 song “Never Go Back.” The lawsuit was eventually resolved with Amy Lee receiving songwriting credit for the song. After the suit, Evanescence’s team kept in contact with Bring me the Horizon. “They were like, ‘Amy really likes your band and would love to work with you,’ lead singer Oli Sykes said in an interview with NME.\n\nThe collaboration between the two artists came at a time when Amy Lee was feeling creatively stuck.\n\nIt was just a really fun escape from that little stuck moment that I was in, and it inspired me. It helped me feel, I don’t know… beautiful. The song is beautiful. That song is always gonna have a special place in my heart because I felt like, in a moment as an artist when I was stuck, another artist came along and helped me.\n\n—Amy Lee, Loudwire\n\nAccording to Lee, the recording process took a week for the vocalist, and the experience was quite unique as Bring Me the Horizon are located in the U.K. while Lee resides in the U.S., with the pair having to guide each other over the phone vocally and deal with the time differences between the two of them. Read more on Last.fm. User-contributed text is available under the Creative Commons By-SA License; additional terms may apply.', NULL, NULL, '2020-10-30', 0.00, '2025-04-22 13:29:05', '2025-05-05 17:47:45'),
(26, 'Overture - Live at the Royal Albert Hall', 'overture---live-at-the-royal-albert-hall', '00:02:44', NULL, NULL, NULL, '2020-10-28', 0.00, '2025-04-22 13:29:06', '2025-05-05 17:47:45'),
(27, 'Doomed - Live at the Royal Albert Hall', 'doomed---live-at-the-royal-albert-hall', '00:04:40', NULL, NULL, NULL, '2020-10-28', 0.00, '2025-04-22 13:29:06', '2025-05-05 17:47:45'),
(28, 'Happy Song - Live at the Royal Albert Hall', 'happy-song---live-at-the-royal-albert-hall', '00:04:42', NULL, NULL, NULL, '2020-10-28', 0.00, '2025-04-22 13:29:06', '2025-05-05 17:47:45'),
(29, 'Go to Hell, for Heaven\'s Sake - Live at the Royal Albert Hall', 'go-to-hell-for-heavens-sake---live-at-the-royal-albert-hall', '00:05:09', NULL, NULL, NULL, '2020-10-28', 0.00, '2025-04-22 13:29:06', '2025-05-05 17:47:45'),
(30, 'Avalanche - Live at the Royal Albert Hall', 'avalanche---live-at-the-royal-albert-hall', '00:05:29', NULL, NULL, NULL, '2020-10-28', 0.00, '2025-04-22 13:29:06', '2025-05-05 17:47:45'),
(31, 'It Never Ends - Live at the Royal Albert Hall', 'it-never-ends---live-at-the-royal-albert-hall', '00:06:07', NULL, NULL, NULL, '2020-10-28', 0.00, '2025-04-22 13:29:06', '2025-05-05 17:47:45'),
(32, 'Sleepwalking - Live at the Royal Albert Hall', 'sleepwalking---live-at-the-royal-albert-hall', '00:04:56', NULL, NULL, NULL, '2020-10-28', 0.00, '2025-04-22 13:29:06', '2025-05-05 17:47:45'),
(33, 'Empire - Live at the Royal Albert Hall', 'empire---live-at-the-royal-albert-hall', '00:04:13', NULL, NULL, NULL, '2020-10-28', 0.00, '2025-04-22 13:29:06', '2025-05-05 17:47:45'),
(34, 'Throne - Live at the Royal Albert Hall', 'throne---live-at-the-royal-albert-hall', '00:04:03', NULL, NULL, NULL, '2020-10-28', 0.00, '2025-04-22 13:29:06', '2025-05-05 17:47:45'),
(35, 'Shadow Moses - Live at the Royal Albert Hall', 'shadow-moses---live-at-the-royal-albert-hall', '00:05:09', NULL, NULL, NULL, '2020-10-28', 0.00, '2025-04-22 13:29:06', '2025-05-05 17:47:45'),
(36, 'True Friends - Live at the Royal Albert Hall', 'true-friends---live-at-the-royal-albert-hall', '00:06:14', NULL, NULL, NULL, '2020-10-28', 0.00, '2025-04-22 13:29:06', '2025-05-05 17:47:45'),
(37, 'Follow You - Live at the Royal Albert Hall', 'follow-you---live-at-the-royal-albert-hall', '00:03:53', NULL, NULL, NULL, '2020-10-28', 0.00, '2025-04-22 13:29:06', '2025-05-05 17:47:45'),
(38, 'Can You Feel My Heart - Live at the Royal Albert Hall', 'can-you-feel-my-heart---live-at-the-royal-albert-hall', '00:06:00', NULL, NULL, NULL, '2020-10-28', 0.00, '2025-04-22 13:29:06', '2025-05-05 17:47:45'),
(39, 'Antivist - Live at the Royal Albert Hall', 'antivist---live-at-the-royal-albert-hall', '00:04:31', NULL, NULL, NULL, '2020-10-28', 0.00, '2025-04-22 13:29:06', '2025-05-05 17:47:45'),
(40, 'Drown - Live at the Royal Albert Hall', 'drown---live-at-the-royal-albert-hall', '00:07:09', NULL, NULL, NULL, '2020-10-28', 0.00, '2025-04-22 13:29:06', '2025-05-05 17:47:45'),
(41, 'Oh No - Live at the Royal Albert Hall', 'oh-no---live-at-the-royal-albert-hall', '00:08:25', NULL, NULL, NULL, '2020-10-28', 0.00, '2025-04-22 13:29:06', '2025-05-05 17:47:45'),
(42, 'Steal Something.', 'steal-something', '00:10:11', NULL, NULL, NULL, '2019-12-27', 0.00, '2025-04-22 13:29:07', '2025-05-05 17:47:45'),
(43, 'Candy Truck / You Expected: LAB Your Result: Green', 'candy-truck--you-expected-lab-your-result-green', '00:07:15', NULL, NULL, NULL, '2019-12-27', 0.00, '2025-04-22 13:29:07', '2025-05-05 17:47:45'),
(44, 'A Devastating Liberation', 'a-devastating-liberation', '00:04:40', NULL, NULL, NULL, '2019-12-27', 0.00, '2025-04-22 13:29:07', '2025-05-05 17:47:45'),
(45, '¿ (feat. Halsey)', 'feat-halsey', '00:05:13', NULL, NULL, NULL, '2019-12-27', 0.00, '2025-04-22 13:29:07', '2025-05-05 17:47:45'),
(46, 'Underground Big {HEADFULOFHYENA} (feat. Bexey & Lotus Eater)', 'underground-big-headfulofhyena-feat-bexey--lotus-eater', '00:24:05', NULL, NULL, NULL, '2019-12-27', 0.00, '2025-04-22 13:29:07', '2025-05-05 17:47:45'),
(47, '\"like seeing spiders running riot on your lover\'s grave\" (feat. Happyalone.)', 'like-seeing-spiders-running-riot-on-your-lovers-grave-feat-happyalone', '00:06:38', NULL, NULL, NULL, '2019-12-27', 0.00, '2025-04-22 13:29:07', '2025-05-05 17:47:45'),
(48, 'Dead Dolphin Sounds \'aid brain growth in unborn child\' Virtual Therapy / Nature Healing 2 Hours (feat. Toriel)', 'dead-dolphin-sounds-aid-brain-growth-in-unborn-child-virtual-therapy--nature-healing-2-hours-feat-toriel', '00:10:09', NULL, NULL, NULL, '2019-12-27', 0.00, '2025-04-22 13:29:07', '2025-05-05 17:47:45'),
(49, '±ªþ³§ (feat. Yonaka)', 'ªþ³-feat-yonaka', '00:07:18', NULL, NULL, NULL, '2019-12-27', 0.00, '2025-04-22 13:29:07', '2025-05-05 17:47:45'),
(50, 'i apologise if you feel something', 'i-apologise-if-you-feel-something', '00:02:19', NULL, NULL, NULL, '2019-01-25', 0.00, '2025-04-22 13:29:08', '2025-05-05 17:47:45'),
(51, 'MANTRA', 'mantra', '00:03:53', NULL, NULL, NULL, '2018-08-21', 0.00, '2025-04-22 13:29:08', '2025-05-05 17:47:45'),
(52, 'nihilist blues (feat. Grimes)', 'nihilist-blues-feat-grimes', '00:05:25', NULL, NULL, NULL, '2019-01-24', 0.00, '2025-04-22 13:29:08', '2025-05-05 17:47:45'),
(53, 'in the dark', 'in-the-dark', '00:04:31', NULL, NULL, NULL, '2019-01-25', 0.00, '2025-04-22 13:29:08', '2025-05-05 17:47:45'),
(54, 'wonderful life (feat. Dani Filth)', 'wonderful-life-feat-dani-filth', '00:04:34', NULL, NULL, NULL, '2018-10-21', 0.00, '2025-04-22 13:29:08', '2025-05-05 17:47:45'),
(55, 'ouch', 'ouch', '00:01:49', NULL, NULL, NULL, '2019-01-25', 0.00, '2025-04-22 13:29:08', '2025-05-05 17:47:45'),
(56, 'medicine', 'medicine', '00:03:47', 'medicine is a song by British rock band Bring Me the Horizon, released on 3 January 2019 as the third single from their sixth studio album amo, which was released a few days later.\n\nThe song was written by BMTH members Jordan Fish, Matthew Kean, Oliver Sykes, Matthew Nicholls and Lee Malia and was produced by Sykes and Fish. The lyrics refer to a toxic relationship, hinting to the happiness that can come after its ending. According to the band the lyrics refer to the marriage between Sykes and his then-wife Hannah Snowdon, which ended in a messy divorce in 2016. Read more on Last.fm. User-contributed text is available under the Creative Commons By-SA License; additional terms may apply.', NULL, NULL, '2019-01-03', 0.00, '2025-04-22 13:29:08', '2025-05-05 17:47:45'),
(57, 'sugar honey ice & tea', 'sugar-honey-ice--tea', '00:04:21', NULL, NULL, NULL, '2019-01-25', 0.00, '2025-04-22 13:29:08', '2025-05-05 17:47:45'),
(58, 'why you gotta kick me when i\'m down?', 'why-you-gotta-kick-me-when-im-down', '00:04:28', NULL, NULL, NULL, '2019-01-25', 0.00, '2025-04-22 13:29:08', '2025-05-05 17:47:45'),
(59, 'fresh bruises', 'fresh-bruises', '00:03:18', NULL, NULL, NULL, '2019-01-25', 0.00, '2025-04-22 13:29:08', '2025-05-05 17:47:45'),
(60, 'mother tongue', 'mother-tongue', '00:03:37', NULL, NULL, NULL, '2019-01-22', 0.00, '2025-04-22 13:29:08', '2025-05-05 17:47:45'),
(61, 'heavy metal (feat. Rahzel)', 'heavy-metal-feat-rahzel', '00:04:00', NULL, NULL, NULL, '2019-01-25', 0.00, '2025-04-22 13:29:08', '2025-05-05 17:47:45'),
(62, 'i don\'t know what to say', 'i-dont-know-what-to-say', '00:05:52', NULL, NULL, NULL, '2019-01-25', 0.00, '2025-04-22 13:29:08', '2025-05-05 17:47:45'),
(63, 'Doomed', 'doomed', '00:04:34', NULL, NULL, NULL, '2015-09-11', 0.00, '2025-04-22 13:29:09', '2025-05-05 17:47:45'),
(64, 'Happy Song', 'happy-song', '00:03:59', NULL, NULL, NULL, '2015-09-11', 0.00, '2025-04-22 13:29:09', '2025-05-05 17:47:45'),
(65, 'Throne', 'throne', '00:03:11', '“Throne” is the first official single released for Bring Me The Horizon’s upcoming album That’s The Spirit, even though the tracks “Drown” & “Happy Song” were released earlier.\n\nKeyboardist Jordan Fish told Rolling Stone that the song represents a completely new musical and emotional space for the band:\n\nIt’s one of the most simple and straightforward songs we did…It’s got some elements we had on the last album [2013’s Sempiternal], with an up-tempo rhythm and really strong melodies. So it seemed like an obvious choice for the first single because it’s so immediately catchy and has such a good level of energy\nThematically, Fish explains further that That’s The Spirit emphasises a much more positive outlook on life than previous BMTH material.\n\nEveryone has their own issues and anxieties, and mostly the new songs are about accepting them and trying to remain positive because there’s nothing else you can do. Read more on Last.fm. User-contributed text is available under the Creative Commons By-SA License; additional terms may apply.', NULL, NULL, '2015-09-11', 0.00, '2025-04-22 13:29:09', '2025-05-05 17:47:45'),
(66, 'True Friends', 'true-friends', '00:03:52', '\"True Friends\" is a song by British rock band Bring Me the Horizon. It was released as the third single from the band\'s fifth studio album That\'s the Spirit. Musically a rock song, it has been more specifically described as post-hardcore and emo. It was released on 25 August 2015 on the bands official Vevo account. Read more on Last.fm. User-contributed text is available under the Creative Commons By-SA License; additional terms may apply.', NULL, NULL, '2015-09-11', 0.00, '2025-04-22 13:29:09', '2025-05-05 17:47:45'),
(67, 'Follow You', 'follow-you', '00:03:51', '\"Follow You\" is a song by British rock band Bring Me the Horizon. Produced by keyboardist Jordan Fish and vocalist Oliver Sykes, it was featured on the band\'s 2015 fifth studio album That\'s the Spirit. The song was also released as the fifth single from the album on 26 February 2016, reaching number 95 on the UK Singles Chart and topping the UK Rock & Metal Singles Chart.\n\nSykes and Fish originally started writing \"Follow You\" at around the same time as they wrote \"Drown\", which was released as a single in 2014. According to Sykes, the song\'s lyrics were based on his relationship with his wife during \"a particular rough patch, when things weren\'t looking too good\"; during a track-by-track commentary of the album for Spotify, he explained that the overarching message was that \"no matter how bad being together can sometimes get, the alternative is just so much worse\". Critical response to \"Follow You\" was generally positive. Bradley Zorgdrager of Exclaim! praised the song for \"reigning in the force while remaining impactful\", in contrast to much of the rest of the album which he criticised for sounding too similar to bands such as Thirty Seconds to Mars and Linkin Park. MTV\'s Mike Pell described the song as \"One of the tamer, more anthemic singles\" from That\'s the Spirit. Reviewing the album for DIY magazine, Sarah Jamieson identified \"Follow You\" as one of the album\'s tracks which sees Bring Me the Horizon \"stepping further out of their comfort zone than ever before\", describing it as \"atmospheric\".\n\nThe music video for \"Follow You\" was premiered on 16 March 2016 via the band\'s Vevo channel. Co-directed by Oliver Sykes and Frank Borin, the video depicts a series of violent events described by a number of commentators as leading to the end of the world, including seemingly random acts of violence, murder, arson and property damage, as a young man listens to the song, dances and sings in the street, oblivious to the events around him. Loudwire\'s Joe DiVita proposed that while the video was \"brutally graphic\" and \"NSFW\", this served as \"the perfect juxtaposition\" to the \"somber and emotional song\" to which it was the visual accompaniment. Alternative Press writer Caitlyn Ralph merely described it as \"intriguing\".\n\nThe video was noted by many critics for its graphic nature. Rock Sound writer Andy Biddulph, for example, described the video as \"horrifying\", noting that it contained \"gore, death, guns and violence against animals\". Similarly, James Hingle of Kerrang! warned that it was \"not for the faint-hearted\". Of particular contention was a scene in which a Golden Retriever is shot and killed by a mail carrier. Fuse\'s Zach Dionne reacted to the video simply with the phrase \"What the fuck\", before berating it as \"an immense misstep\" by the band. Emmy Mack of Music Feeds displayed shock at the video, describing it as \"a gruesome, NSFW fucking bloodbath\", although did praise the production by noting that \"The whole thing is a god damn motherfucking horror movie. But at least it\'s a blockbuster one.\" Bring Me the Horizon later responded to the controversy on Twitter, joking about the dog\'s fate. Read more on Last.fm. User-contributed text is available under the Creative Commons By-SA License; additional terms may apply.', NULL, NULL, '2015-09-11', 0.00, '2025-04-22 13:29:09', '2025-05-05 17:47:45'),
(68, 'What You Need', 'what-you-need', '00:04:12', NULL, NULL, NULL, '2015-09-11', 0.00, '2025-04-22 13:29:09', '2025-05-05 17:47:45'),
(69, 'Avalanche', 'avalanche', '00:04:22', NULL, NULL, NULL, '2015-09-11', 0.00, '2025-04-22 13:29:09', '2025-05-05 17:47:45'),
(70, 'Run', 'run', '00:03:42', NULL, NULL, NULL, '2015-09-11', 0.00, '2025-04-22 13:29:09', '2025-05-05 17:47:45'),
(71, 'Drown', 'drown', '00:03:42', 'Originally released as a stand-alone single, a remixed version features on the band\'s fifth studio album That\'s the Spirit and was released as the lead single. The track, musically, marks a shift away from the band\'s previously established metalcore sound. Rather, it was described by critics as a pop punk-leaning emo and rock song, being the later showcased as arena rock.\nIt reached No. 17 in the UK, becoming the band\'s first top-20 single in their home country.\n\nThe song was announced 13 October 2014 on the band\'s social media accounts. The song leaked on 21 October 2014 on YouTube by accident because of a mistake by Epitaph Records, the band\'s United States record label. It later premiered officially on BBC Radio 1 that same day. After it aired on BBC Radio 1, Oliver Sykes was interviewed by Zane Lowe. It had been reported that \"Drown\" would not appear on any studio album from the band. However, the song was later announced to be track 9 on the 2015 album That\'s the Spirit, albeit as a remixed version.\n\n\"Drown\" was set to be released on iTunes on 7 December 2014. However, in early October, Oliver Sykes began teasing lyrics in the form of photos on Twitter. He also posted a message stating if \"#DROWN\" started trending on Twitter, they would release the song sooner. Drown was released on iTunes 3 November 2014. \"Drown\" was issued as a picture disc in the UK on 7 December. It was nominated for the Kerrang! Award for Best Single. Read more on Last.fm. User-contributed text is available under the Creative Commons By-SA License; additional terms may apply.', NULL, NULL, '2015-09-11', 0.00, '2025-04-22 13:29:09', '2025-05-05 17:47:45'),
(72, 'Blasphemy', 'blasphemy', '00:04:35', NULL, NULL, NULL, '2015-09-11', 0.00, '2025-04-22 13:29:09', '2025-05-05 17:47:45'),
(73, 'Oh No', 'oh-no', '00:05:01', NULL, NULL, NULL, '2015-09-11', 0.00, '2025-04-22 13:29:09', '2025-05-05 17:47:45'),
(74, 'Can You Feel My Heart', 'can-you-feel-my-heart', '00:03:47', 'This is the first track on Sempiternal, the fourth studio album by the British Metalcore band Bring Me the Horizon. It was one of the first tunes that was penned for the set. Keyboardist Jordan Fish told Metal Hammer: \"We tried loads of different things that were s--t, but that really worked, and as soon as we did it we knew that this would open the album.\"\nVocalist Oliver Sykes added: \"This was the turning point; it was the first one that Jordan really got his teeth into, and obviously you can hear that because it\'s very heavy on the electronica. It was floating around for ages, and I think it really started to shine when we took my vocal lead and used it [on the keyboard parts] for the chorus.\"\nIt was during the penning of this tune that the band realized that recently added keyboardist Jordan Fish was having a big impact on their songwriting. Bassist Matt Kean told Sugarscape: \"We had already had a list of the songs and Jordan took it away and worked on the choruses and stuff. It was like - I remember listening to it back once Jordan had put a different stamp on it and we were like \'Oh this is CRAZY!\' and at the time, he wasn\'t even in the band, he was just writing with us. I think its this song was the point where we were all like \'It\'s time to do something about this.\'\"\nThe Sempiternal album was penned with a concept in its structure. Every single song represents a different realization and it was made to be like a journey. Sykes explained to AllMusic: \"The first song is the first step, and the second song is the second step. You can\'t really listen to track six, and then listen to track one. You have to figure out the first step before you can figure out the next thing. We tried to make that connect in every aspect with the songs and music and how they blended into each other. It goes from heavy and then gives you a breather. The songs are meant to reflect the emotions as well. It\'s not just random. We wanted to make it a journey you wanted to start at the beginning and end at the end rather than just hear one or two songs or put it on \'shuffle.\'\n\nThe first track, \'Can You Feel My Heart\' is all about admittance,\" Sykes continued, \"admitting you have a problem, and admitting something\'s wrong\" Read more on Last.fm. User-contributed text is available under the Creative Commons By-SA License; additional terms may apply.', NULL, NULL, '2017-11-24', 0.00, '2025-04-22 13:29:10', '2025-05-05 17:47:45'),
(75, 'The House of Wolves', 'the-house-of-wolves', '00:03:25', NULL, NULL, NULL, '2013-04-01', 0.00, '2025-04-22 13:29:10', '2025-05-05 17:47:45'),
(76, 'Empire (Let Them Sing)', 'empire-let-them-sing', '00:03:45', '“Empire” contains allusions to many things, such as biblical references on the chorus and a The Three Little Pigs citation on the pre-chorus. Lyrically, it talks about depression and how society treats these “misunderstood people”—let them sing.\n\nIn a track-by-track interview with MetalFuckingRocks, vocalist Oli Sykes explained:\n\n\"It’s quite Deftones-inspired, the feel. Lyrically it’s one of my favourites, because it’s one of the few where I wrote the lyrics before I wrote the melodies. Most of the time I’ve found out that that doesn’t work, but it gave me a lot of freedom.\" Read more on Last.fm. User-contributed text is available under the Creative Commons By-SA License; additional terms may apply.', NULL, NULL, '2013-04-01', 0.00, '2025-04-22 13:29:10', '2025-05-05 17:47:45'),
(77, 'Sleepwalking', 'sleepwalking', '00:03:50', NULL, NULL, NULL, '2017-11-24', 0.00, '2025-04-22 13:29:10', '2025-05-05 17:47:45'),
(78, 'Go to Hell, for Heaven\'s Sake', 'go-to-hell-for-heavens-sake', '00:04:02', NULL, NULL, NULL, '2017-11-24', 0.00, '2025-04-22 13:29:10', '2025-05-05 17:47:45'),
(79, 'Shadow Moses', 'shadow-moses', '00:04:03', '\"Shadow Moses\" is a song by British rock band Bring Me the Horizon. Written by vocalist Oliver Sykes, guitarist Lee Malia and keyboardist Jordan Fish, it was produced by Terry Date and featured on the band\'s 2013 fourth studio album \"Sempiternal\". The song was released as the lead single from the album on 11 January 2013, reaching number 82 on the UK Singles Chart and number 2 on the UK Rock & Metal Singles Chart.\n\nOne of the first songs written for \"Sempiternal\", \"Shadow Moses\" features the use of the album\'s title several times throughout the song. The track is named after the main setting of the 1998 video game Metal Gear Solid, the closing theme of which is referenced in the song\'s opening vocal line. \"Shadow Moses\" was critically acclaimed upon its release and is one of the band\'s most frequently-performed songs at live shows. Read more on Last.fm. User-contributed text is available under the Creative Commons By-SA License; additional terms may apply.', NULL, NULL, '2017-11-24', 0.00, '2025-04-22 13:29:10', '2025-05-05 17:47:45'),
(80, 'And the Snakes Start to Sing', 'and-the-snakes-start-to-sing', '00:05:01', 'The first song the band sat down to write when starting to record Sempiternal and also the last song they completed. No one knows the meaning behind the song, according to Sykes\n\n“the lyrics are so personal that they will mean nothing to anyone but my parents and me.“\n\nBassist Matt Kean told to Sugarscape:\n\n“Halfway through the writing process Jordan (Fish, keyboards) added strings and stuff to it and his little electronic bars, and then we left it for even longer and then as the last thing we wrote the vocals for it. We only finished it a week before we went to the studio, we just kept going back and tweaking it and stuff, but we were super happy with the way it came out.“ Read more on Last.fm. User-contributed text is available under the Creative Commons By-SA License; additional terms may apply.', NULL, NULL, '2013-04-01', 0.00, '2025-04-22 13:29:10', '2025-05-05 17:47:45'),
(81, 'Seen It All Before', 'seen-it-all-before', '00:04:07', 'Read more on Last.fm. User-contributed text is available under the Creative Commons By-SA License; additional terms may apply.', NULL, NULL, '2013-04-01', 0.00, '2025-04-22 13:29:10', '2025-05-05 17:47:45'),
(82, 'Antivist', 'antivist', '00:03:13', 'Probably the song with the most political and divisive message of the album, \"Antivist\" is about \"slacktivists\", people that believe the fundamental changes of society will come throught with sole interatictions on social medias.\n\nOli Sykes, BMTH\'S vocalist, in a track-by-track interview with MetalFuckingRocks said:\n\n\"It\'s about \'Slacktivists\'; online people that just talk shit on Twitter, and \'Like this if you want to get Obama to die\' or whatever. It\'s loads of shit; people think they\'re making a difference nowadays just because they’re sat on their fat arses with ill-informed \'facts\'. They think they know everything and that they\'re making a difference, and it\'s bullshit.\n\nSo the lyrics to this one are quite sarcastic, but if you want to make a difference, you have to do more than just sit at your computer. It\'s not saying \'Don\'t care about the world\', it\'s saying, \'Don\'t think you care about the world and that you\'re better than people if you\'re doing fuck all\'. If you really believe in all that, you\'ve got to get up and do more.\" Read more on Last.fm. User-contributed text is available under the Creative Commons By-SA License; additional terms may apply.', NULL, NULL, '2017-11-24', 0.00, '2025-04-22 13:29:10', '2025-05-05 17:47:45'),
(83, 'Crooked Young', 'crooked-young', '00:03:34', '“Crooked Young” mainly talks about Oliver Sykes\' ketamine rehabilitation.\n\nIn a track-by-track interview with MetalFuckingRocks, vocalist Oli Sykes explained:\n\n“Jordan [keyboardist] really wanted to do something like “It Never Ends” [from 2010’s There Is A Hell…], and we thought that was one of the songs that worked best on the last album, including that addition of an orchestra. We thought we could carry that on, so we wanted to keep that vibe. It’s still one of the heaviest tracks on the record, and it’s got a great chorus. I’m really excited to play that one live.“\n\nIn another interview, bassist Matt Kean explained:\n\n“This song came about after we all went to go see a film—I forget which film it was, but it was a super epic film it had like a huge string section in it—and we thought we need to write a song that uses cinematic strings section and is super epic sounding. So then Jordan went home that night and came back in the morning with this huge, middle string section, so we were like “Let’s use this!” and then we wrote the song around that section.“ Read more on Last.fm. User-contributed text is available under the Creative Commons By-SA License; additional terms may apply.', NULL, NULL, '2013-04-01', 0.00, '2025-04-22 13:29:10', '2025-05-05 17:47:45'),
(84, 'Hospital for Souls', 'hospital-for-souls', '00:06:46', 'Oli told All Music:\nThat song is all about ascending, I guess it’s like rising from the ashes and renewing yourself after learning all of these things. I changed who I am. The lyrics mean, “Say goodbye to the old person, watch me burning, and coming back as this new person.” Read more on Last.fm. User-contributed text is available under the Creative Commons By-SA License; additional terms may apply.', NULL, NULL, '2013-04-01', 0.00, '2025-04-22 13:29:10', '2025-05-05 17:47:45'),
(85, 'Join the Club', 'join-the-club', '00:03:06', NULL, NULL, NULL, '2013-04-01', 0.00, '2025-04-22 13:29:10', '2025-05-05 17:47:45'),
(86, 'Deathbeds', 'deathbeds', '00:04:59', 'Oli Sykes\'s then fiancée, tattoo artist, Hannah Pixie Snowdon features on this track. Read more on Last.fm. User-contributed text is available under the Creative Commons By-SA License; additional terms may apply.', NULL, NULL, '2013-04-01', 0.00, '2025-04-22 13:29:10', '2025-05-05 17:47:45'),
(87, 'Crucify Me (feat. Lights)', 'crucify-me-feat-lights', '00:06:19', NULL, NULL, NULL, '2010-10-04', 0.00, '2025-04-22 13:29:11', '2025-05-05 17:47:45'),
(88, 'Anthem', 'anthem', '00:04:49', NULL, NULL, NULL, '2010-10-04', 0.00, '2025-04-22 13:29:11', '2025-05-05 17:47:45'),
(89, 'It Never Ends', 'it-never-ends', '00:04:34', NULL, NULL, NULL, '2017-11-24', 0.00, '2025-04-22 13:29:11', '2025-05-05 17:47:45'),
(90, 'Fuck (feat. Josh Franceschi)', 'fuck-feat-josh-franceschi', '00:04:55', NULL, NULL, NULL, '2010-10-04', 0.00, '2025-04-22 13:29:11', '2025-05-05 17:47:45'),
(91, 'Don\'t Go (feat. Lights)', 'dont-go-feat-lights', '00:04:58', NULL, NULL, NULL, '2010-10-04', 0.00, '2025-04-22 13:29:11', '2025-05-05 17:47:45'),
(92, 'Home Sweet Hole', 'home-sweet-hole', '00:04:37', NULL, NULL, NULL, '2010-10-04', 0.00, '2025-04-22 13:29:11', '2025-05-05 17:47:45'),
(93, 'Alligator Blood', 'alligator-blood', '00:04:31', NULL, NULL, NULL, '2010-10-04', 0.00, '2025-04-22 13:29:11', '2025-05-05 17:47:45'),
(94, 'Visions', 'visions', '00:04:08', NULL, NULL, NULL, '2010-10-04', 0.00, '2025-04-22 13:29:11', '2025-05-05 17:47:45'),
(95, 'Blacklist', 'blacklist', '00:04:00', NULL, NULL, NULL, '2010-10-04', 0.00, '2025-04-22 13:29:11', '2025-05-05 17:47:45'),
(96, 'Memorial', 'memorial', '00:03:09', NULL, NULL, NULL, '2010-10-04', 0.00, '2025-04-22 13:29:11', '2025-05-05 17:47:45'),
(97, 'Blessed with a Curse', 'blessed-with-a-curse', '00:05:08', NULL, NULL, NULL, '2017-11-24', 0.00, '2025-04-22 13:29:11', '2025-05-05 17:47:45'),
(98, 'The Fox and the Wolf (feat. Josh Scogin)', 'the-fox-and-the-wolf-feat-josh-scogin', '00:01:42', NULL, NULL, NULL, '2010-10-04', 0.00, '2025-04-22 13:29:11', '2025-05-05 17:47:45'),
(99, 'It Never Ends - Borgore Remix', 'it-never-ends---borgore-remix', '00:04:23', NULL, NULL, NULL, '2010-10-04', 0.00, '2025-04-22 13:29:11', '2025-05-05 17:47:45'),
(100, 'The Comedown', 'the-comedown', '00:04:09', 'The first track off Bring Me The Horizon\'s new album, Suicide Season set to be released September 29th in the UK and October 6th in the US.\n\nThis is the first song to be offcially released by the band as they made a promotional video for the song which can be found via youtube. Read more on Last.fm. User-contributed text is available under the Creative Commons By-SA License; additional terms may apply.', NULL, NULL, '2017-11-24', 0.00, '2025-04-22 13:29:12', '2025-05-05 17:47:45'),
(101, 'Chelsea Smile', 'chelsea-smile', '00:05:02', '\"Chelsea Smile\" is a song by British rock band Bring Me the Horizon. Produced by Fredrik Nordström and Henrik Udd, it was featured on the band\'s 2008 second studio album Suicide Season. The song was also released as the second music video from the album on 19 January 2009. Travie McCoy and KC Blitz produced remixes of the track for the album\'s special edition reissue, Suicide Season Cut Up!, which was released in 2009.\n\n\"Chelsea Smile\" has been identified as evidence of Bring Me the Horizon\'s musical development on Suicide Season; Exclaim! writer Dave Synyard praised it, alongside \"It Was Written in Blood\", for featuring \"catchier rhythms, lessened guttural vocals and more structured songwriting, as opposed to reverting to a technical onslaught of guitar riffs\". When asked about this change in approach in relation to the two songs, vocalist Oliver Sykes explained that \"I think it\'s good when a band can be really heavy and still have catchy hooks and riffs without it being cheesy and typical\", adding that the band were \"trying to make the heaviest and catchiest music possible\".\n\nFor the Cut Up! portion of the 2009 special edition reissue of Suicide Season, remixes of \"Chelsea Smile\" were produced by Jamie Kossoff and Jon Courtney under their KC Blitz moniker, as well as Gym Class Heroes frontman Travie McCoy. According to set list aggregation website setlist.fm, \"Chelsea Smile\" is the song performed most frequently at Bring Me the Horizon concerts. It has been included in the set lists of several high-profile shows, including the band\'s performances at Wembley Arena in 2014 (documented on the live video album Live at Wembley), Reading and Leeds Festivals in 2015 and Alexandra Palace as part of the That\'s the Spirit Tour in 2015.\n\nThe music video for \"Chelsea Smile\" was directed by Adam Powell, who also worked on the video for earlier Suicide Season track \"The Comedown\". It was filmed and released in early January 2009, alongside a series of four behind the scenes videos which were uploaded periodically to the band\'s Myspace page. The video features a brief appearance from the members of Canadian hardcore punk band Cancer Bats, who are shown playing poker during the opening scene. Kerrang! included it at number 9 on their list of the band\'s best music videos in April 2015, praising its high-energy party vibe. The video was later included on the Cut Up! special edition reissue of Suicide Season.\n\nAllMusic\'s Tom Forget praised \"Chelsea Smile\" as a highlight of Suicide Season, describing it as \"Intricately constructed and refreshingly unpredictable\". Dan Slessor of the Alternative Press named it the best Bring Me the Horizon song, praising its \"armor-plated juddering, deranged energy, titanic breakdown and insidiously catchy hooks\". Loudwire\'s Sarai C. ranked it at number two on her feature of the band\'s best songs, highlighting its importance to the development of the group\'s sound and the metalcore genre in general, moving away from its deathcore roots. Metal Hammer writer Luke Morton ranked it the sixth best song by the band, describing it as \"one of the nastiest songs to ever be called catchy\" and praising its \"brutalising breakdowns\" and \"primal screams\". In 2019, Billboard ranked the song number seven on their list of the 10 greatest Bring Me the Horizon songs, and in 2022, Kerrang! ranked the song number four on their list of the 20 greatest Bring Me the Horizon songs.\n\nCredits adapted from Tidal. Read more on Last.fm. User-contributed text is available under the Creative Commons By-SA License; additional terms may apply.', NULL, NULL, '2017-11-24', 0.00, '2025-04-22 13:29:12', '2025-05-05 17:47:45'),
(102, 'It Was Written in Blood', 'it-was-written-in-blood', '00:04:02', 'Track 3 from Bring Me The Horizon\'s second album released September 29th in the UK and October 6th in the US. Read more on Last.fm. User-contributed text is available under the Creative Commons By-SA License; additional terms may apply.', NULL, NULL, '2008-09-29', 0.00, '2025-04-22 13:29:12', '2025-05-05 17:47:45'),
(103, 'Death Breath', 'death-breath', '00:04:20', NULL, NULL, NULL, '2008-09-29', 0.00, '2025-04-22 13:29:12', '2025-05-05 17:47:45'),
(104, 'Football Season is Over (feat. JJ Peters)', 'football-season-is-over-feat-jj-peters', '00:01:55', NULL, NULL, NULL, '2008-09-29', 0.00, '2025-04-22 13:29:12', '2025-05-05 17:47:45'),
(105, 'Sleep with One Eye Open', 'sleep-with-one-eye-open', '00:04:16', NULL, NULL, NULL, '2008-09-29', 0.00, '2025-04-22 13:29:12', '2025-05-05 17:47:45'),
(106, 'Diamonds Aren\'t Forever', 'diamonds-arent-forever', '00:03:48', '“Diamonds Aren’t Forever” is the third single from BMTH’s album Suicide Season.\nThis song was remixed by I Haunt Wizards for the remix album Suicide Season: Cut Up.\n\nThis song is definitely alluding to Kanye’s song “ Diamonds from Sierra Leone”\n\nThere are many lyrics parallels throughout it and it seems to be referencing it and picking apart some of the details…\n\nThe First and most obvious parallel is the name “Diamonds aren’t forever,” as in the Kanye song the chorus is “ Diamonds are forever”\n\nIn the pre-chorus of this song, they say, “I refuse to close my eyes” and in Diamonds from Sierra Leone, they say “Close your eyes and feel the magic, vegas on acid”\n\nIn the Bring Me song they say “ Throw your diamonds in the sky and we’ll stay gold forever” and the Kanye ones say, “ So throw your Diamonds in the sky if you feel the vibe… Diamonds are forever”\n\nThe original Kanye song is kind of insensitive because it fails to recognize the blood diamonds and how harmful they are and it makes it sound like the lifestyle he’s living is worth the struggle of others. They did a remix later that addresses the issues going on but the damage was kinda done. I think BMTH is calling out the frivolous lifestyle of it here and saying they are against it. Read more on Last.fm. User-contributed text is available under the Creative Commons By-SA License; additional terms may apply.', NULL, NULL, '2017-11-24', 0.00, '2025-04-22 13:29:12', '2025-05-05 17:47:45'),
(107, 'The Sadness Will Never End (feat. Sam Carter)', 'the-sadness-will-never-end-feat-sam-carter', '00:05:22', '“The Sadness Will Never End” is the third and final single from the band’s album Suicide Season.\n\nThis song was remixed by Skrillex for the remix album Suicide Season: Cut Up.\n\nAlso, in 2019’s festival All Points East, Bring Me The Horizon headlined the event and, because of this, included the song on the setlist with the participation of Architects‘ lead singer Sam Carter.\n\nThe ex-guitarist of the band, Jona Weinhofen, appears in the official video of the song. But it was originally recorded with Curtis Ward (also ex-guitarist). Read more on Last.fm. User-contributed text is available under the Creative Commons By-SA License; additional terms may apply.', NULL, NULL, '2008-09-29', 0.00, '2025-04-22 13:29:12', '2025-05-05 17:47:45'),
(108, 'No Need for Introductions, I\'ve Read About Girls Like You on the Backs of Toilet Doors', 'no-need-for-introductions-ive-read-about-girls-like-you-on-the-backs-of-toilet-doors', '00:00:59', NULL, NULL, NULL, '2008-09-29', 0.00, '2025-04-22 13:29:12', '2025-05-05 17:47:45'),
(109, 'Suicide Season', 'suicide-season', '00:08:17', '“Suicide Season” is about one of Oli’s friends, his father died and this changed his friend. The friend lost his father, and Oli lost his friend due to grief.\n\nThis is also the first eponymous track on a release in the band’s discography, being named after the album. Read more on Last.fm. User-contributed text is available under the Creative Commons By-SA License; additional terms may apply.', NULL, NULL, '2008-09-29', 0.00, '2025-04-22 13:29:12', '2025-05-05 17:47:45'),
(110, 'The Comedown - RobotSonics Remix', 'the-comedown---robotsonics-remix', '00:05:17', NULL, NULL, NULL, '2008-09-29', 0.00, '2025-04-22 13:29:12', '2025-05-05 17:47:45'),
(111, 'Chelsea Smile - KC Blitz Remix', 'chelsea-smile---kc-blitz-remix', '00:04:12', NULL, NULL, NULL, '2008-09-29', 0.00, '2025-04-22 13:29:12', '2025-05-05 17:47:45'),
(112, 'It Was Written in Blood - L\'Amour La Morgue Remix', 'it-was-written-in-blood---lamour-la-morgue-remix', '00:04:57', NULL, NULL, NULL, '2008-09-29', 0.00, '2025-04-22 13:29:12', '2025-05-05 17:47:45'),
(113, 'Death Breath - Toxic Avenger Remix', 'death-breath---toxic-avenger-remix', '00:04:33', NULL, NULL, NULL, '2008-09-29', 0.00, '2025-04-22 13:29:12', '2025-05-05 17:47:45'),
(114, 'Football Season is Over - After the Night Remix', 'football-season-is-over---after-the-night-remix', '00:03:56', NULL, NULL, NULL, '2008-09-29', 0.00, '2025-04-22 13:29:12', '2025-05-05 17:47:45'),
(115, 'Sleep with One Eye Open - Tek-One Remix', 'sleep-with-one-eye-open---tek-one-remix', '00:04:41', NULL, NULL, NULL, '2008-09-29', 0.00, '2025-04-22 13:29:12', '2025-05-05 17:47:45'),
(116, 'Diamonds Aren\'t Forever - I Haunt Wizards Remix', 'diamonds-arent-forever---i-haunt-wizards-remix', '00:03:54', NULL, NULL, NULL, '2008-09-29', 0.00, '2025-04-22 13:29:12', '2025-05-05 17:47:45'),
(117, 'The Sadness Will Never End - Skrillex Remix', 'the-sadness-will-never-end---skrillex-remix', '00:06:02', NULL, NULL, NULL, '2008-09-29', 0.00, '2025-04-22 13:29:12', '2025-05-05 17:47:45'),
(118, 'No Need for Introductions, I\'ve Read About Girls Like You on the Backs of Toilet Doors - Benjamin Weinman Remix', 'no-need-for-introductions-ive-read-about-girls-like-you-on-the-backs-of-toilet-doors---benjamin-weinman-remix', '00:02:45', NULL, NULL, NULL, '2008-09-29', 0.00, '2025-04-22 13:29:12', '2025-05-05 17:47:45'),
(119, 'Suicide Season - The Secret Handshake Remix', 'suicide-season---the-secret-handshake-remix', '00:02:55', NULL, NULL, NULL, '2008-09-29', 0.00, '2025-04-22 13:29:12', '2025-05-05 17:47:45'),
(120, 'Pray for Plagues', 'pray-for-plagues', '00:04:21', 'Pray for Plagues is the first single and the first song off of the metalcore/deathcore band Bring Me The Horizon\'s debut studio album \"Count Your Blessings\", which released in 2006. Read more on Last.fm. User-contributed text is available under the Creative Commons By-SA License; additional terms may apply.', NULL, NULL, '2017-11-24', 0.00, '2025-04-22 13:29:14', '2025-05-05 17:47:45'),
(121, 'Tell Slater Not to Wash His Dick', 'tell-slater-not-to-wash-his-dick', '00:03:30', NULL, NULL, NULL, '2006-10-30', 0.00, '2025-04-22 13:29:14', '2025-05-05 17:47:45'),
(122, 'For Stevie Wonder\'s Eyes Only (Braille)', 'for-stevie-wonders-eyes-only-braille', '00:04:29', NULL, NULL, NULL, '2006-10-30', 0.00, '2025-04-22 13:29:14', '2025-05-05 17:47:45'),
(123, 'A Lot Like Vegas', 'a-lot-like-vegas', '00:02:09', NULL, NULL, NULL, '2006-10-30', 0.00, '2025-04-22 13:29:14', '2025-05-05 17:47:45'),
(124, 'Black & Blue', 'black--blue', '00:04:33', 'Read more on Last.fm. User-contributed text is available under the Creative Commons By-SA License; additional terms may apply.', NULL, NULL, '2006-10-30', 0.00, '2025-04-22 13:29:14', '2025-05-05 17:47:45'),
(125, 'Slow Dance', 'slow-dance', '00:01:16', NULL, NULL, NULL, '2006-10-30', 0.00, '2025-04-22 13:29:14', '2025-05-05 17:47:45'),
(126, 'Liquor & Love Lost', 'liquor--love-lost', '00:02:39', NULL, NULL, NULL, '2006-10-30', 0.00, '2025-04-22 13:29:14', '2025-05-05 17:47:45'),
(127, '(I Used to Make Out With) Medusa', 'i-used-to-make-out-with-medusa', '00:05:38', NULL, NULL, NULL, '2006-10-30', 0.00, '2025-04-22 13:29:14', '2025-05-05 17:47:45'),
(128, 'Fifteen Fathoms, Counting', 'fifteen-fathoms-counting', '00:01:56', NULL, NULL, NULL, '2006-10-30', 0.00, '2025-04-22 13:29:14', '2025-05-05 17:47:45'),
(129, 'Off the Heezay', 'off-the-heezay', '00:05:38', NULL, NULL, NULL, '2006-10-30', 0.00, '2025-04-22 13:29:14', '2025-05-05 17:47:45'),
(130, 'Wonderwall - Spotify Singles', 'wonderwall---spotify-singles', '00:04:00', NULL, NULL, NULL, '2025-01-29', 0.00, '2025-04-22 13:29:14', '2025-05-05 17:47:45');
INSERT INTO `tracks` (`id`, `title`, `slug`, `duration`, `description`, `description_lv`, `audio_source`, `release_date`, `popularity`, `created_at`, `updated_at`) VALUES
(131, 'YOUtopia - EarthcOre remix - Spotify Singles', 'youtopia---earthcore-remix---spotify-singles', '00:03:40', NULL, NULL, NULL, '2025-01-29', 0.00, '2025-04-22 13:29:14', '2025-05-05 17:47:45'),
(132, 'Happier (feat. Oli Sykes of Bring Me The Horizon)', 'happier-feat-oli-sykes-of-bring-me-the-horizon', '00:03:24', NULL, NULL, NULL, '2023-10-17', 0.00, '2025-04-22 13:29:17', '2025-05-05 17:47:45'),
(133, 'CODE MISTAKE', 'code-mistake', '00:02:45', NULL, NULL, NULL, '2023-06-30', 0.00, '2025-04-22 13:29:17', '2025-05-05 17:47:45'),
(134, 'Werewolf (feat. Bring Me The Horizon)', 'werewolf-feat-bring-me-the-horizon', '00:03:59', NULL, NULL, NULL, '2023-06-29', 0.00, '2025-04-22 13:29:18', '2025-05-05 17:47:45'),
(135, 'Wish I Could Forget (with blackbear & Bring Me The Horizon)', 'wish-i-could-forget-with-blackbear--bring-me-the-horizon', '00:03:26', NULL, NULL, NULL, '2023-05-19', 0.00, '2025-04-22 13:29:19', '2025-05-05 17:47:45'),
(136, 'Bad Life', 'bad-life', '00:03:46', NULL, NULL, NULL, '2022-06-24', 0.00, '2025-04-22 13:29:22', '2025-05-05 17:47:45'),
(137, 'Bad Life - Stripped Back', 'bad-life---stripped-back', '00:03:40', NULL, NULL, NULL, '2022-06-24', 0.00, '2025-04-22 13:29:22', '2025-05-05 17:47:45'),
(138, 'Bad Life - acoustic', 'bad-life---acoustic', '00:03:40', NULL, NULL, NULL, '2022-05-27', 0.00, '2025-04-22 13:29:22', '2025-05-05 17:47:45'),
(139, 'Fallout', 'fallout', '00:03:14', NULL, NULL, NULL, '2022-04-01', 0.00, '2025-04-22 13:29:23', '2025-05-05 17:47:45'),
(140, 'Bad Habits (feat. Bring Me The Horizon)', 'bad-habits-feat-bring-me-the-horizon', '00:04:10', NULL, NULL, NULL, '2022-02-08', 0.00, '2025-04-22 13:29:24', '2025-05-05 17:47:45'),
(141, 'Moon Over the Castle - from GRAN TURISMO 7', 'moon-over-the-castle---from-gran-turismo-7', '00:03:07', NULL, NULL, NULL, '2022-02-04', 0.00, '2025-04-22 13:29:25', '2025-05-05 17:47:45'),
(142, 'DiE4u - six impala \"DiE6u\" Remix', 'die4u---six-impala-die6u-remix', '00:02:47', NULL, NULL, NULL, '2021-12-17', 0.00, '2025-04-22 13:29:25', '2025-05-05 17:47:45'),
(143, 'VAMPIR (feat. Oli Sykes of Bring Me The Horizon)', 'vampir-feat-oli-sykes-of-bring-me-the-horizon', '00:02:23', NULL, NULL, NULL, '2021-12-10', 0.00, '2025-04-22 13:29:26', '2025-05-05 17:47:45'),
(144, 'Let’s Get The Party Started (feat. Bring Me The Horizon)', 'lets-get-the-party-started-feat-bring-me-the-horizon', '00:03:32', NULL, NULL, NULL, '2021-09-22', 0.00, '2025-04-22 13:29:27', '2025-05-05 17:47:45'),
(145, 'No More Friends (with Oli Sykes of Bring Me The Horizon)', 'no-more-friends-with-oli-sykes-of-bring-me-the-horizon', '00:03:13', NULL, NULL, NULL, '2021-06-10', 0.00, '2025-04-22 13:29:28', '2025-05-05 17:47:45'),
(146, 'Can You Feel My Heart - Remix', 'can-you-feel-my-heart---remix', '00:03:17', NULL, NULL, NULL, '2021-03-05', 0.00, '2025-04-22 13:29:29', '2025-05-05 17:47:45'),
(147, 'sugar honey ice & tea - Edit', 'sugar-honey-ice--tea---edit', '00:03:35', NULL, NULL, NULL, '2019-07-26', 0.00, '2025-04-22 13:29:32', '2025-05-05 17:47:45'),
(148, 'mother tongue - Recorded at Spotify Studios NYC', 'mother-tongue---recorded-at-spotify-studios-nyc', '00:03:37', NULL, NULL, NULL, '2019-06-26', 0.00, '2025-04-22 13:29:33', '2025-05-05 17:47:45'),
(149, 'Drone Bomb Me - Recorded at Spotify Studios NYC', 'drone-bomb-me---recorded-at-spotify-studios-nyc', '00:03:52', NULL, NULL, NULL, '2019-06-26', 0.00, '2025-04-22 13:29:33', '2025-05-05 17:47:45'),
(150, 'mother tongue - Sub Focus Remix', 'mother-tongue---sub-focus-remix', '00:03:15', NULL, NULL, NULL, '2019-06-14', 0.00, '2025-04-22 13:29:34', '2025-05-05 17:47:45'),
(151, 'Oh No - Radio Edit', 'oh-no---radio-edit', '00:03:53', NULL, NULL, NULL, '2016-11-18', 0.00, '2025-04-22 13:29:38', '2025-05-05 17:47:45'),
(152, 'Drown - Live from Maida Vale', 'drown---live-from-maida-vale', '00:03:45', NULL, NULL, NULL, '2015-12-26', 0.00, '2025-04-22 13:29:39', '2025-05-05 17:47:45'),
(153, 'Can You Feel My Heart - Shikari Sound System Remix', 'can-you-feel-my-heart---shikari-sound-system-remix', '00:04:24', NULL, NULL, NULL, '2013-10-13', 0.00, '2025-04-22 13:29:40', '2025-05-05 17:47:45'),
(154, 'Can You Feel My Heart - Jakwob Remix', 'can-you-feel-my-heart---jakwob-remix', '00:04:33', NULL, NULL, NULL, '2013-10-13', 0.00, '2025-04-22 13:29:40', '2025-05-05 17:47:45'),
(155, 'Sleepwalking - Instrumental', 'sleepwalking---instrumental', '00:03:50', NULL, NULL, NULL, '2013-03-04', 0.00, '2025-04-22 13:29:40', '2025-05-05 17:47:45'),
(156, 'RE: They Have No Reflections', 're-they-have-no-reflections', '00:05:42', NULL, NULL, NULL, '2004-10-02', 0.00, '2025-04-22 13:29:41', '2025-05-05 17:47:45'),
(157, 'Who Wants Flowers When You\'re Dead? Nobody', 'who-wants-flowers-when-youre-dead-nobody', '00:04:54', NULL, NULL, NULL, '2004-10-02', 0.00, '2025-04-22 13:29:41', '2025-05-05 17:47:45'),
(158, 'Rawwwrr!', 'rawwwrr', '00:04:13', NULL, NULL, NULL, '2004-10-02', 0.00, '2025-04-22 13:29:41', '2025-05-05 17:47:45'),
(159, 'Traitors Never Play Hang-Man', 'traitors-never-play-hang-man', '00:03:37', NULL, NULL, NULL, '2017-11-24', 0.00, '2025-04-22 13:29:41', '2025-05-05 17:47:45'),
(160, 'The Sadness Will Never End - feat. Sam Carter', 'the-sadness-will-never-end---feat-sam-carter', '00:05:22', NULL, NULL, NULL, '2017-11-24', 0.00, '2025-04-22 13:29:42', '2025-05-05 17:47:45'),
(161, 'Don\'t Go - feat. Lights', 'dont-go---feat-lights', '00:04:58', NULL, NULL, NULL, '2017-11-24', 0.00, '2025-04-22 13:29:42', '2025-05-05 17:47:45'),
(162, 'Crucify Me - feat. Lights', 'crucify-me---feat-lights', '00:06:19', NULL, NULL, NULL, '2017-11-24', 0.00, '2025-04-22 13:29:42', '2025-05-05 17:47:45'),
(163, 'Dawn', 'dawn', '00:01:52', NULL, NULL, NULL, '2021-03-05', 0.00, '2025-04-27 01:21:34', '2025-05-05 17:47:45'),
(164, 'Demon King', 'demon-king', '00:03:55', NULL, NULL, NULL, '2020-12-09', 0.00, '2025-04-27 01:21:34', '2025-05-05 17:47:45'),
(165, 'Animal', 'animal', '00:04:04', NULL, NULL, NULL, '2021-01-28', 0.00, '2025-04-27 01:21:34', '2025-05-05 17:47:45'),
(166, 'Altered Eyes', 'altered-eyes', '00:03:54', NULL, NULL, NULL, '2021-02-25', 0.00, '2025-04-27 01:21:34', '2025-05-05 17:47:45'),
(167, 'Prophecy of the Falcon', 'prophecy-of-the-falcon', '00:02:57', NULL, NULL, NULL, '2021-03-05', 0.00, '2025-04-27 01:21:34', '2025-05-05 17:47:45'),
(168, 'Perfect World', 'perfect-world', '00:01:27', NULL, NULL, NULL, '2021-03-05', 0.00, '2025-04-27 01:21:34', '2025-05-05 17:47:45'),
(169, 'Mortal Vessel', 'mortal-vessel', '00:04:17', NULL, NULL, NULL, '2021-03-05', 0.00, '2025-04-27 01:21:34', '2025-05-05 17:47:45'),
(170, 'Foe of the Inhuman', 'foe-of-the-inhuman', '00:04:05', NULL, NULL, NULL, '2021-03-05', 0.00, '2025-04-27 01:21:34', '2025-05-05 17:47:45'),
(171, 'Vengeance', 'vengeance', '00:04:28', NULL, NULL, NULL, '2021-03-05', 0.00, '2025-04-27 01:21:34', '2025-05-05 17:47:45'),
(172, 'Ruin', 'ruin', '00:03:43', NULL, NULL, NULL, '2021-03-05', 0.00, '2025-04-27 01:21:34', '2025-05-05 17:47:45'),
(173, 'Corridor of Dreams', 'corridor-of-dreams', '00:02:06', NULL, NULL, NULL, '2021-03-05', 0.00, '2025-04-27 01:21:34', '2025-05-05 17:47:45'),
(174, 'Lifeblood', 'lifeblood', '00:04:17', NULL, NULL, NULL, '2021-01-07', 0.00, '2025-04-27 01:21:34', '2025-05-05 17:47:45'),
(175, 'Begin', 'begin', '00:01:46', NULL, NULL, NULL, '2019-07-05', 0.00, '2025-04-27 01:21:35', '2025-05-05 17:47:45'),
(176, 'Divinity', 'divinity', '00:03:13', NULL, NULL, NULL, '2019-07-05', 0.00, '2025-04-27 01:21:35', '2025-05-05 17:47:45'),
(177, 'Fortress', 'fortress', '00:03:22', NULL, NULL, NULL, '2019-07-05', 0.00, '2025-04-27 01:21:35', '2025-05-05 17:47:45'),
(178, 'Charlotte', 'charlotte', '00:03:16', NULL, NULL, NULL, '2019-07-05', 0.00, '2025-04-27 01:21:35', '2025-05-05 17:47:45'),
(179, 'The Branded', 'the-branded', '00:02:43', NULL, NULL, NULL, '2019-07-05', 0.00, '2025-04-27 01:21:35', '2025-05-05 17:47:45'),
(180, 'Hill of Swords', 'hill-of-swords', '00:01:08', NULL, NULL, NULL, '2019-07-05', 0.00, '2025-04-27 01:21:35', '2025-05-05 17:47:45'),
(181, 'Clawmarks', 'clawmarks', '00:02:25', NULL, NULL, NULL, '2019-07-05', 0.00, '2025-04-27 01:21:35', '2025-05-05 17:47:45'),
(182, 'After Image', 'after-image', '00:02:10', NULL, NULL, NULL, '2019-07-05', 0.00, '2025-04-27 01:21:35', '2025-05-05 17:47:46'),
(183, 'Beast of Darkness', 'beast-of-darkness', '00:03:01', NULL, NULL, NULL, '2019-07-05', 0.00, '2025-04-27 01:21:35', '2025-05-05 17:47:46'),
(184, 'God Hand', 'god-hand', '00:03:04', NULL, NULL, NULL, '2019-07-05', 0.00, '2025-04-27 01:21:35', '2025-05-05 17:47:46'),
(185, 'Purge', 'purge', '00:04:42', NULL, NULL, NULL, '2023-12-13', 0.00, '2025-04-27 01:21:36', '2025-05-05 17:47:46'),
(186, 'Erase You', 'erase-you', '00:04:03', NULL, NULL, NULL, '2023-09-15', 0.00, '2025-04-27 01:21:37', '2025-05-05 17:47:46'),
(187, 'Awaken in Ashes', 'awaken-in-ashes', '00:03:01', NULL, NULL, NULL, '2023-07-12', 0.00, '2025-04-27 01:21:38', '2025-05-05 17:47:46'),
(188, 'Weight Of The World - feat. We Came As Romans & Brand Of Sacrifice', 'weight-of-the-world---feat-we-came-as-romans--brand-of-sacrifice', '00:03:52', NULL, NULL, NULL, '2023-05-16', 0.00, '2025-04-27 01:21:38', '2025-05-05 17:47:46'),
(189, 'Blinded', 'blinded', '00:03:25', NULL, NULL, NULL, '2023-04-21', 0.00, '2025-04-27 01:21:39', '2025-05-05 17:47:46'),
(190, 'Exodus', 'exodus', '00:04:18', NULL, NULL, NULL, '2022-11-09', 0.00, '2025-04-27 01:21:39', '2025-05-05 17:47:46'),
(191, 'Dynasty', 'dynasty', '00:04:26', NULL, NULL, NULL, '2023-02-08', 0.00, '2025-04-27 01:21:39', '2025-05-05 17:47:46'),
(192, 'Between Death and Dreams', 'between-death-and-dreams', '00:04:29', NULL, NULL, NULL, '2023-04-21', 0.00, '2025-04-27 01:21:39', '2025-05-05 17:47:46'),
(193, 'Darkbloom', 'darkbloom', '00:03:44', NULL, NULL, NULL, '2022-04-20', 0.00, '2025-04-27 01:21:42', '2025-05-05 17:47:46'),
(194, 'Enemy', 'enemy', '00:04:08', NULL, NULL, NULL, '2021-08-05', 0.00, '2025-04-27 01:21:44', '2025-05-05 17:47:46'),
(195, 'Lifeblood - Remix', 'lifeblood---remix', '00:02:34', NULL, NULL, NULL, '2021-08-05', 0.00, '2025-04-27 01:21:44', '2025-05-05 17:47:46'),
(196, 'Altered Eyes - Remix', 'altered-eyes---remix', '00:02:41', NULL, NULL, NULL, '2021-08-05', 0.00, '2025-04-27 01:21:44', '2025-05-05 17:47:46'),
(197, 'Eclipse', 'eclipse', '00:02:23', NULL, NULL, NULL, '2018-09-14', 0.00, '2025-04-27 01:21:47', '2025-05-05 17:47:46'),
(198, 'Casca', 'casca', '00:02:57', NULL, NULL, NULL, '2018-09-14', 0.00, '2025-04-27 01:21:47', '2025-05-05 17:47:46'),
(199, 'Conviction', 'conviction', '00:02:58', NULL, NULL, NULL, '2018-09-14', 0.00, '2025-04-27 01:21:47', '2025-05-05 17:47:46'),
(200, 'Millennium', 'millennium', '00:03:16', NULL, NULL, NULL, '2018-09-14', 0.00, '2025-04-27 01:21:47', '2025-05-05 17:47:46'),
(201, 'Crimson', 'crimson', '00:03:22', NULL, NULL, NULL, '2018-09-14', 0.00, '2025-04-27 01:21:47', '2025-05-05 17:47:46'),
(202, 'MUD', 'mud', '00:03:12', NULL, NULL, NULL, '2025-03-07', 0.00, '2025-04-27 01:21:50', '2025-05-05 17:47:46'),
(203, 'River Crate', 'river-crate', '00:02:21', NULL, NULL, NULL, '2025-03-07', 0.00, '2025-04-27 01:21:50', '2025-05-05 17:47:46'),
(204, 'Entropy (god speed)', 'entropy-god-speed', '00:02:30', NULL, NULL, NULL, '2025-03-07', 0.00, '2025-04-27 01:21:50', '2025-05-05 17:47:46'),
(205, 'AOL', 'aol', '00:01:55', NULL, NULL, NULL, '2025-03-07', 0.00, '2025-04-27 01:21:50', '2025-05-05 17:47:46'),
(206, 'BLADE', 'blade', '00:02:45', NULL, NULL, NULL, '2025-03-07', 0.00, '2025-04-27 01:21:50', '2025-05-05 17:47:46'),
(207, 'Scarlet Teeth', 'scarlet-teeth', '00:02:36', NULL, NULL, NULL, '2024-11-08', 0.00, '2025-04-27 01:21:50', '2025-05-05 17:47:46'),
(208, 'Tonal Dread', 'tonal-dread', '00:02:24', NULL, NULL, NULL, '2024-09-06', 0.00, '2025-04-27 01:21:50', '2025-05-05 17:47:46'),
(209, 'Pit of Despair', 'pit-of-despair', '00:02:48', NULL, NULL, NULL, '2024-07-26', 0.00, '2025-04-27 01:21:50', '2025-05-05 17:47:46'),
(210, 'pondering my orb', 'pondering-my-orb', '00:02:23', NULL, NULL, NULL, '2023-09-29', 0.00, '2025-04-27 01:21:51', '2025-05-05 17:47:46'),
(211, 'blood+ (feat. Witchouse 40k)', 'blood-feat-witchouse-40k', '00:02:21', NULL, NULL, NULL, '2023-09-29', 0.00, '2025-04-27 01:21:51', '2025-05-05 17:47:46'),
(212, 'flowers by her grave', 'flowers-by-her-grave', '00:02:35', NULL, NULL, NULL, '2023-03-24', 0.00, '2025-04-27 01:21:51', '2025-05-05 17:47:46'),
(213, 'slow dancing with the devil', 'slow-dancing-with-the-devil', '00:02:31', NULL, NULL, NULL, '2023-09-29', 0.00, '2025-04-27 01:21:51', '2025-05-05 17:47:46'),
(214, 'paranoia agent', 'paranoia-agent', '00:02:57', NULL, NULL, NULL, '2023-08-11', 0.00, '2025-04-27 01:21:51', '2025-05-05 17:47:46'),
(215, 'what we do in the shadows pt. 1', 'what-we-do-in-the-shadows-pt-1', '00:02:11', NULL, NULL, NULL, '2023-09-29', 0.00, '2025-04-27 01:21:51', '2025-05-05 17:47:46'),
(216, 'soul eater', 'soul-eater', '00:02:15', NULL, NULL, NULL, '2023-09-29', 0.00, '2025-04-27 01:21:51', '2025-05-05 17:47:46'),
(217, 'ghost in the shell (feat. SXMPRA)', 'ghost-in-the-shell-feat-sxmpra', '00:02:37', NULL, NULL, NULL, '2023-09-29', 0.00, '2025-04-27 01:21:51', '2025-05-05 17:47:46'),
(218, 'TrenchWorld', 'trenchworld', '00:03:42', NULL, NULL, NULL, '2020-10-21', 0.00, '2025-04-27 01:21:52', '2025-05-05 17:47:46'),
(219, 'Dweller', 'dweller', '00:02:11', NULL, NULL, NULL, '2020-10-21', 0.00, '2025-04-27 01:21:52', '2025-05-05 17:47:46'),
(220, 'USPS', 'usps', '00:02:53', NULL, NULL, NULL, '2020-10-21', 0.00, '2025-04-27 01:21:52', '2025-05-05 17:47:46'),
(221, 'TECHNO THOT!', 'techno-thot', '00:02:04', NULL, NULL, NULL, '2020-10-21', 0.00, '2025-04-27 01:21:52', '2025-05-05 17:47:46'),
(222, 'onlyfan.com/sommerray', 'onlyfancomsommerray', '00:03:55', NULL, NULL, NULL, '2020-10-21', 0.00, '2025-04-27 01:21:52', '2025-05-05 17:47:46'),
(223, 'TrenchGirlLullaby', 'trenchgirllullaby', '00:02:11', NULL, NULL, NULL, '2020-10-21', 0.00, '2025-04-27 01:21:52', '2025-05-05 17:47:46'),
(224, 'RINGWORM', 'ringworm', '00:03:11', NULL, NULL, NULL, '2020-10-21', 0.00, '2025-04-27 01:21:52', '2025-05-05 17:47:46'),
(225, 'SQUAD WIPE', 'squad-wipe', '00:01:58', NULL, NULL, NULL, '2020-10-21', 0.00, '2025-04-27 01:21:52', '2025-05-05 17:47:46'),
(226, 'LetMeKnow', 'letmeknow', '00:02:10', NULL, NULL, NULL, '2020-10-21', 0.00, '2025-04-27 01:21:52', '2025-05-05 17:47:46'),
(227, 'FeelTheBurn2020', 'feeltheburn2020', '00:01:50', NULL, NULL, NULL, '2020-10-21', 0.00, '2025-04-27 01:21:52', '2025-05-05 17:47:46'),
(228, 'CHECKMATE!', 'checkmate', '00:02:53', NULL, NULL, NULL, '2020-10-21', 0.00, '2025-04-27 01:21:52', '2025-05-05 17:47:46'),
(229, 'Bully', 'bully', '00:01:39', NULL, NULL, NULL, '2020-10-21', 0.00, '2025-04-27 01:21:52', '2025-05-05 17:47:46'),
(230, 'Dr0nched In Sw0t', 'dr0nched-in-sw0t', '00:04:12', NULL, NULL, NULL, '2020-10-21', 0.00, '2025-04-27 01:21:52', '2025-05-05 17:47:46'),
(231, 'That Wasn’t Very+__+!!! of You', 'that-wasnt-very__-of-you', '00:02:38', NULL, NULL, NULL, '2019-07-20', 0.00, '2025-04-27 01:21:53', '2025-05-05 17:47:46'),
(232, 'YEE HAW!', 'yee-haw', '00:01:51', NULL, NULL, NULL, '2019-07-20', 0.00, '2025-04-27 01:21:53', '2025-05-05 17:47:46'),
(233, 'Modelo', 'modelo', '00:02:15', NULL, NULL, NULL, '2019-07-20', 0.00, '2025-04-27 01:21:53', '2025-05-05 17:47:46'),
(234, 'DarkWays', 'darkways', '00:01:41', NULL, NULL, NULL, '2019-07-20', 0.00, '2025-04-27 01:21:53', '2025-05-05 17:47:46'),
(235, 'MoodSwings', 'moodswings', '00:02:13', NULL, NULL, NULL, '2019-07-20', 0.00, '2025-04-27 01:21:53', '2025-05-05 17:47:46'),
(236, 'I\'m Gonna Be Sick', 'im-gonna-be-sick', '00:02:12', NULL, NULL, NULL, '2019-07-20', 0.00, '2025-04-27 01:21:53', '2025-05-05 17:47:46'),
(237, 'MyGothBitchCameWithaglock', 'mygothbitchcamewithaglock', '00:02:15', NULL, NULL, NULL, '2018-08-27', 0.00, '2025-04-27 01:21:53', '2025-05-05 17:47:46'),
(238, 'Theresaleechinmyboot', 'theresaleechinmyboot', '00:02:19', NULL, NULL, NULL, '2019-07-20', 0.00, '2025-04-27 01:21:53', '2025-05-05 17:47:46'),
(239, 'RedDead', 'reddead', '00:02:10', NULL, NULL, NULL, '2019-07-20', 0.00, '2025-04-27 01:21:53', '2025-05-05 17:47:46'),
(240, 'F T F T', 'f-t-f-t', '00:03:12', NULL, NULL, NULL, '2019-07-20', 0.00, '2025-04-27 01:21:53', '2025-05-05 17:47:46'),
(241, 'Fuck ALL the Pain', 'fuck-all-the-pain', '00:01:57', NULL, NULL, NULL, '2019-07-20', 0.00, '2025-04-27 01:21:53', '2025-05-05 17:47:46'),
(242, 'Hole in My Face', 'hole-in-my-face', '00:01:53', NULL, NULL, NULL, '2019-07-20', 0.00, '2025-04-27 01:21:53', '2025-05-05 17:47:46'),
(243, 'Dead!', 'dead', '00:02:58', NULL, NULL, NULL, '2019-07-20', 0.00, '2025-04-27 01:21:53', '2025-05-05 17:47:46'),
(244, 'Fuckery', 'fuckery', '00:02:47', NULL, NULL, NULL, '2018-06-29', 0.00, '2025-04-27 01:21:54', '2025-05-05 17:47:46'),
(245, 'I Wanna Bitch Like Dillon Harper', 'i-wanna-bitch-like-dillon-harper', '00:01:45', NULL, NULL, NULL, '2018-06-29', 0.00, '2025-04-27 01:21:54', '2025-05-05 17:47:46'),
(246, 'Satan, Hello', 'satan-hello', '00:03:58', NULL, NULL, NULL, '2018-06-29', 0.00, '2025-04-27 01:21:54', '2025-05-05 17:47:46'),
(247, 'All White Civic', 'all-white-civic', '00:02:34', NULL, NULL, NULL, '2018-06-29', 0.00, '2025-04-27 01:21:54', '2025-05-05 17:47:46'),
(248, 'My Neck of the Woods', 'my-neck-of-the-woods', '00:04:18', NULL, NULL, NULL, '2018-06-29', 0.00, '2025-04-27 01:21:54', '2025-05-05 17:47:46'),
(249, 'Second Chances Aren\'t for Everyone Huh?', 'second-chances-arent-for-everyone-huh', '00:02:08', NULL, NULL, NULL, '2018-06-29', 0.00, '2025-04-27 01:21:54', '2025-05-05 17:47:46'),
(250, 'BloodShakeTheEarthWhenItDrip', 'bloodshaketheearthwhenitdrip', '00:02:09', NULL, NULL, NULL, '2018-06-29', 0.00, '2025-04-27 01:21:54', '2025-05-05 17:47:46'),
(251, 'TheseWallsHaveTeeth', 'thesewallshaveteeth', '00:03:23', NULL, NULL, NULL, '2018-06-29', 0.00, '2025-04-27 01:21:54', '2025-05-05 17:47:46'),
(252, 'EverythingJustHurts', 'everythingjusthurts', '00:03:10', NULL, NULL, NULL, '2018-06-29', 0.00, '2025-04-27 01:21:54', '2025-05-05 17:47:46'),
(253, 'Ntysmibdoyds', 'ntysmibdoyds', '00:02:51', NULL, NULL, NULL, '2018-06-29', 0.00, '2025-04-27 01:21:54', '2025-05-05 17:47:46'),
(254, 'TheWinds', 'thewinds', '00:00:46', NULL, NULL, NULL, '2018-06-29', 0.00, '2025-04-27 01:21:54', '2025-05-05 17:47:46'),
(255, 'TortureInsideMyAmygdala', 'tortureinsidemyamygdala', '00:01:28', NULL, NULL, NULL, '2024-05-31', 0.00, '2025-04-27 01:21:57', '2025-05-05 17:47:46'),
(256, 'PLEASE DON\'T HAUNT ME', 'please-dont-haunt-me', '00:04:20', NULL, NULL, NULL, '2024-04-12', 0.00, '2025-04-27 01:21:58', '2025-05-05 17:47:46'),
(257, 'SIGNS', 'signs', '00:01:27', NULL, NULL, NULL, '2024-03-06', 0.00, '2025-04-27 01:21:58', '2025-05-05 17:47:46'),
(258, 'in your darkest nightmares, you\'ll see me', 'in-your-darkest-nightmares-youll-see-me', '00:04:35', NULL, NULL, NULL, '2023-12-01', 0.00, '2025-04-27 01:21:59', '2025-05-05 17:47:46'),
(259, 'ghost in the shell - feat. SXMPRA', 'ghost-in-the-shell---feat-sxmpra', '00:02:37', NULL, NULL, NULL, '2023-06-30', 0.00, '2025-04-27 01:22:01', '2025-05-05 17:47:46'),
(260, 'Roach Latency', 'roach-latency', '00:02:44', NULL, NULL, NULL, '2022-11-25', 0.00, '2025-04-27 01:22:02', '2025-05-05 17:47:46'),
(261, 'sorry im a haunted house', 'sorry-im-a-haunted-house', '00:02:26', NULL, NULL, NULL, '2022-09-02', 0.00, '2025-04-27 01:22:03', '2025-05-05 17:47:46'),
(262, 'GauzeValley', 'gauzevalley', '00:02:30', NULL, NULL, NULL, '2022-06-23', 0.00, '2025-04-27 01:22:03', '2025-05-05 17:47:46'),
(263, 'CATACOMBS!', 'catacombs', '00:02:36', NULL, NULL, NULL, '2022-04-20', 0.00, '2025-04-27 01:22:04', '2025-05-05 17:47:46'),
(264, 'Feasting.On.The.Guts.Of.Angels.', 'feastingonthegutsofangels', '00:03:55', NULL, NULL, NULL, '2021-12-23', 0.00, '2025-04-27 01:22:05', '2025-05-05 17:47:46'),
(265, 'heartRACE', 'heartrace', '00:02:39', NULL, NULL, NULL, '2021-07-22', 0.00, '2025-04-27 01:22:06', '2025-05-05 17:47:46'),
(266, 'SOUL SNATCH', 'soul-snatch', '00:02:46', NULL, NULL, NULL, '2021-07-17', 0.00, '2025-04-27 01:22:06', '2025-05-05 17:47:46'),
(267, 'WeProbablyShouldn\'ttalkanymore', 'weprobablyshouldnttalkanymore', '00:02:36', NULL, NULL, NULL, '2018-12-15', 0.00, '2025-04-27 01:22:07', '2025-05-05 17:47:46'),
(268, 'SorryItsVague', 'sorryitsvague', '00:02:35', NULL, NULL, NULL, '2018-11-14', 0.00, '2025-04-27 01:22:08', '2025-05-05 17:47:46'),
(269, 'I Might Die Before I Detox', 'i-might-die-before-i-detox', '00:03:20', NULL, NULL, NULL, '2017-06-03', 0.00, '2025-04-27 01:22:09', '2025-05-05 17:47:46'),
(270, 'Заходи скорее', 'заходи-скорее', '00:02:47', NULL, NULL, NULL, '2023-12-15', 0.00, '2025-04-27 01:22:12', '2025-05-05 17:47:46'),
(271, 'Всё сразу', 'всё-сразу', '00:01:56', NULL, NULL, NULL, '2023-12-15', 0.00, '2025-04-27 01:22:12', '2025-05-05 17:47:46'),
(272, 'Макдональдс', 'макдональдс', '00:02:06', NULL, NULL, NULL, '2023-12-15', 0.00, '2025-04-27 01:22:12', '2025-05-05 17:47:46'),
(273, 'Семейный альбом', 'семейный-альбом', '00:06:26', NULL, NULL, NULL, '2023-12-15', 0.00, '2025-04-27 01:22:12', '2025-05-05 17:47:46'),
(274, 'Суп дня', 'суп-дня', '00:01:55', NULL, NULL, NULL, '2023-12-15', 0.00, '2025-04-27 01:22:12', '2025-05-05 17:47:46'),
(275, 'Соседи', 'соседи', '00:02:49', NULL, NULL, NULL, '2023-12-15', 0.00, '2025-04-27 01:22:12', '2025-05-05 17:47:46'),
(276, 'Захизр', 'захизр', '00:03:54', NULL, NULL, NULL, '2023-12-15', 0.00, '2025-04-27 01:22:12', '2025-05-05 17:47:46'),
(277, 'Табак два', 'табак-два', '00:02:29', NULL, NULL, NULL, '2023-12-15', 0.00, '2025-04-27 01:22:12', '2025-05-05 17:47:46'),
(278, '2010-е кончились', '2010-е-кончились', '00:08:35', NULL, NULL, NULL, '2023-12-15', 0.00, '2025-04-27 01:22:12', '2025-05-05 17:47:46'),
(279, 'Хоп-механика', 'хоп-механика', '00:02:18', NULL, NULL, NULL, '2021-12-01', 0.00, '2025-04-27 01:22:12', '2025-05-05 17:47:46'),
(280, 'Агент', 'агент', '00:03:34', NULL, NULL, NULL, '2021-12-01', 0.00, '2025-04-27 01:22:12', '2025-05-05 17:47:46'),
(281, 'Красота и Уродство', 'красота-и-уродство', '00:02:39', NULL, NULL, NULL, '2021-12-01', 0.00, '2025-04-27 01:22:12', '2025-05-05 17:47:46'),
(282, 'Нон-фикшн', 'нон-фикшн', '00:03:35', NULL, NULL, NULL, '2021-12-01', 0.00, '2025-04-27 01:22:12', '2025-05-05 17:47:46'),
(283, 'Рашн Роуд Рейдж', 'рашн-роуд-рейдж', '00:02:38', NULL, NULL, NULL, '2021-12-01', 0.00, '2025-04-27 01:22:12', '2025-05-05 17:47:46'),
(284, 'Мы все умрем', 'мы-все-умрем', '00:02:46', NULL, NULL, NULL, '2021-12-01', 0.00, '2025-04-27 01:22:12', '2025-05-05 17:47:46'),
(285, 'Чувствую', 'чувствую', '00:03:35', NULL, NULL, NULL, '2021-12-01', 0.00, '2025-04-27 01:22:12', '2025-05-05 17:47:46'),
(286, 'Окно в Париж', 'окно-в-париж', '00:03:13', NULL, NULL, NULL, '2021-12-01', 0.00, '2025-04-27 01:22:12', '2025-05-05 17:47:46'),
(287, 'Партизанское радио', 'партизанское-радио', '00:02:45', NULL, NULL, NULL, '2021-12-01', 0.00, '2025-04-27 01:22:12', '2025-05-05 17:47:46'),
(288, 'Непрожитая жизнь', 'непрожитая-жизнь', '00:03:55', NULL, NULL, NULL, '2021-12-01', 0.00, '2025-04-27 01:22:13', '2025-05-05 17:47:46'),
(289, 'Празднуй', 'празднуй', '00:04:56', NULL, NULL, NULL, '2021-12-01', 0.00, '2025-04-27 01:22:13', '2025-05-05 17:47:46'),
(290, 'Намешано', 'намешано', '00:03:50', NULL, NULL, NULL, '2021-12-01', 0.00, '2025-04-27 01:22:13', '2025-05-05 17:47:46'),
(291, 'Эспрессо Тоник', 'эспрессо-тоник', '00:01:55', NULL, NULL, NULL, '2021-12-01', 0.00, '2025-04-27 01:22:13', '2025-05-05 17:47:46'),
(292, 'Пантеллерия', 'пантеллерия', '00:02:53', NULL, NULL, NULL, '2021-12-01', 0.00, '2025-04-27 01:22:13', '2025-05-05 17:47:46'),
(293, 'Лифт', 'лифт', '00:04:34', NULL, NULL, NULL, '2021-12-01', 0.00, '2025-04-27 01:22:13', '2025-05-05 17:47:46'),
(294, 'Грязь', 'грязь', '00:03:32', NULL, NULL, NULL, '2021-12-01', 0.00, '2025-04-27 01:22:13', '2025-05-05 17:47:46'),
(295, 'Улет', 'улет', '00:02:30', NULL, NULL, NULL, '2021-12-01', 0.00, '2025-04-27 01:22:13', '2025-05-05 17:47:46'),
(296, 'Эминем', 'эминем', '00:02:48', NULL, NULL, NULL, '2021-12-01', 0.00, '2025-04-27 01:22:13', '2025-05-05 17:47:46'),
(297, 'Рецензия', 'рецензия', '00:01:07', NULL, NULL, NULL, '2021-12-01', 0.00, '2025-04-27 01:22:13', '2025-05-05 17:47:46'),
(298, 'Африканские бусы', 'африканские-бусы', '00:02:26', NULL, NULL, NULL, '2021-12-01', 0.00, '2025-04-27 01:22:13', '2025-05-05 17:47:46'),
(299, 'Мох', 'мох', '00:02:06', NULL, NULL, NULL, '2021-11-12', 0.00, '2025-04-27 01:22:13', '2025-05-05 17:47:46'),
(300, 'Погружение', 'погружение', '00:02:21', NULL, NULL, NULL, '2021-11-12', 0.00, '2025-04-27 01:22:14', '2025-05-05 17:47:46'),
(301, 'Flashback', 'flashback', '00:01:03', NULL, NULL, NULL, '2021-11-12', 0.00, '2025-04-27 01:22:14', '2025-05-05 17:47:46'),
(302, 'Reality', 'reality', '00:01:31', NULL, NULL, NULL, '2021-11-12', 0.00, '2025-04-27 01:22:14', '2025-05-05 17:47:46'),
(303, 'Konstrukt', 'konstrukt', '00:01:33', NULL, NULL, NULL, '2021-11-12', 0.00, '2025-04-27 01:22:14', '2025-05-05 17:47:46'),
(304, 'Мне скучно жить', 'мне-скучно-жить', '00:03:51', NULL, NULL, NULL, '2014-11-27', 0.00, '2025-04-27 01:22:14', '2025-05-05 17:47:46'),
(305, 'Что такое империя', 'что-такое-империя', '00:01:35', NULL, NULL, NULL, '2021-11-12', 0.00, '2025-04-27 01:22:14', '2025-05-05 17:47:46'),
(306, 'Imperial', 'imperial', '00:01:18', NULL, NULL, NULL, '2021-11-12', 0.00, '2025-04-27 01:22:14', '2025-05-05 17:47:46'),
(307, 'Биполярочка', 'биполярочка', '00:02:55', NULL, NULL, NULL, '2017-09-14', 0.00, '2025-04-27 01:22:14', '2025-05-05 17:47:46'),
(308, 'Северная страна', 'северная-страна', '00:00:54', NULL, NULL, NULL, '2021-11-12', 0.00, '2025-04-27 01:22:14', '2025-05-05 17:47:46'),
(309, 'В долгий путь', 'в-долгий-путь', '00:00:45', NULL, NULL, NULL, '2021-11-12', 0.00, '2025-04-27 01:22:14', '2025-05-05 17:47:46'),
(310, 'Athens', 'athens', '00:01:02', NULL, NULL, NULL, '2021-11-12', 0.00, '2025-04-27 01:22:14', '2025-05-05 17:47:46'),
(311, 'Пора возвращаться домой', 'пора-возвращаться-домой', '00:01:27', NULL, NULL, NULL, '2021-11-12', 0.00, '2025-04-27 01:22:14', '2025-05-05 17:47:46'),
(312, 'STRUGGLES', 'struggles', '00:00:50', NULL, NULL, NULL, '2021-11-12', 0.00, '2025-04-27 01:22:14', '2025-05-05 17:47:46'),
(313, 'BACK 2 GRIME', 'back-2-grime', '00:00:43', NULL, NULL, NULL, '2021-11-12', 0.00, '2025-04-27 01:22:14', '2025-05-05 17:47:46'),
(314, 'HPL', 'hpl', '00:01:49', NULL, NULL, NULL, '2015-06-05', 0.00, '2025-04-27 01:22:14', '2025-05-05 17:47:46'),
(315, 'Stereocoma', 'stereocoma', '00:01:21', NULL, NULL, NULL, '2021-11-12', 0.00, '2025-04-27 01:22:14', '2025-05-05 17:47:46'),
(316, 'Дежавю', 'дежавю', '00:01:37', NULL, NULL, NULL, '2021-11-12', 0.00, '2025-04-27 01:22:14', '2025-05-05 17:47:46'),
(317, 'Лондонград', 'лондонград', '00:03:28', NULL, NULL, NULL, '2021-11-12', 0.00, '2025-04-27 01:22:14', '2025-05-05 17:47:46'),
(318, 'Цунами', 'цунами', '00:02:44', NULL, NULL, NULL, '2021-11-06', 0.00, '2025-04-27 01:22:14', '2025-05-05 17:47:46'),
(319, 'Не с начала', 'не-с-начала', '00:02:05', NULL, NULL, NULL, '2015-11-13', 0.00, '2025-04-27 01:22:14', '2025-05-05 17:47:46'),
(320, 'Кем ты стал', 'кем-ты-стал', '00:03:56', NULL, NULL, NULL, '2015-11-13', 0.00, '2025-04-27 01:22:15', '2025-05-05 17:47:46'),
(321, 'Всего лишь писатель', 'всего-лишь-писатель', '00:03:29', NULL, NULL, NULL, '2015-11-13', 0.00, '2025-04-27 01:22:15', '2025-05-05 17:47:46'),
(322, 'Девочка Пиздец', 'девочка-пиздец', '00:02:43', NULL, NULL, NULL, '2015-11-13', 0.00, '2025-04-27 01:22:15', '2025-05-05 17:47:46'),
(323, 'Переплетено', 'переплетено', '00:04:51', NULL, NULL, NULL, '2015-11-13', 0.00, '2025-04-27 01:22:15', '2025-05-05 17:47:46'),
(324, 'Колыбельная', 'колыбельная', '00:03:17', NULL, NULL, NULL, '2015-11-13', 0.00, '2025-04-27 01:22:15', '2025-05-05 17:47:46'),
(325, 'Полигон', 'полигон', '00:03:40', NULL, NULL, NULL, '2015-11-13', 0.00, '2025-04-27 01:22:15', '2025-05-05 17:47:46'),
(326, 'Накануне', 'накануне', '00:03:41', NULL, NULL, NULL, '2015-11-13', 0.00, '2025-04-27 01:22:15', '2025-05-05 17:47:46'),
(327, 'Слово мэра', 'слово-мэра', '00:04:00', NULL, NULL, NULL, '2015-11-13', 0.00, '2025-04-27 01:22:15', '2025-05-05 17:47:46'),
(328, 'Башня из слоновой кости', 'башня-из-слоновой-кости', '00:03:24', NULL, NULL, NULL, '2015-11-13', 0.00, '2025-04-27 01:22:15', '2025-05-05 17:47:46'),
(329, 'Где нас нет', 'где-нас-нет', '00:04:25', NULL, NULL, NULL, '2015-11-13', 0.00, '2025-04-27 01:22:15', '2025-05-05 17:47:46'),
(330, 'Интро', 'интро', '00:01:22', NULL, NULL, NULL, '2013-10-18', 0.00, '2025-04-27 01:22:15', '2025-05-05 17:47:46'),
(331, 'Пролив Дрейка', 'пролив-дрейка', '00:03:06', NULL, NULL, NULL, '2013-10-18', 0.00, '2025-04-27 01:22:15', '2025-05-05 17:47:46'),
(332, 'Больше Бена', 'больше-бена', '00:02:16', NULL, NULL, NULL, '2013-10-18', 0.00, '2025-04-27 01:22:15', '2025-05-05 17:47:46'),
(333, 'Волапюк', 'волапюк', '00:01:42', NULL, NULL, NULL, '2013-10-18', 0.00, '2025-04-27 01:22:15', '2025-05-05 17:47:46'),
(334, 'Песенка Гремлина', 'песенка-гремлина', '00:03:23', NULL, NULL, NULL, '2013-10-18', 0.00, '2025-04-27 01:22:15', '2025-05-05 17:47:46'),
(335, 'Хитиновый покров', 'хитиновый-покров', '00:03:07', NULL, NULL, NULL, '2013-10-18', 0.00, '2025-04-27 01:22:16', '2025-05-05 17:47:46'),
(336, 'Детектор лжи', 'детектор-лжи', '00:02:09', NULL, NULL, NULL, '2013-10-18', 0.00, '2025-04-27 01:22:16', '2025-05-05 17:47:46'),
(337, 'Неваляшка', 'неваляшка', '00:04:17', NULL, NULL, NULL, '2013-10-18', 0.00, '2025-04-27 01:22:16', '2025-05-05 17:47:46'),
(338, 'Признаки жизни', 'признаки-жизни', '00:04:41', NULL, NULL, NULL, '2013-10-18', 0.00, '2025-04-27 01:22:16', '2025-05-05 17:47:46'),
(339, 'XXX Shop', 'xxx-shop', '00:00:54', NULL, NULL, NULL, '2013-10-18', 0.00, '2025-04-27 01:22:16', '2025-05-05 17:47:46'),
(340, 'Не от мира сего', 'не-от-мира-сего', '00:03:13', NULL, NULL, NULL, '2013-10-18', 0.00, '2025-04-27 01:22:16', '2025-05-05 17:47:46'),
(341, 'Ultima Thule', 'ultima-thule', '00:02:18', NULL, NULL, NULL, '2013-10-18', 0.00, '2025-04-27 01:22:16', '2025-05-05 17:47:46'),
(342, 'До зимы', 'до-зимы', '00:02:29', NULL, NULL, NULL, '2013-10-18', 0.00, '2025-04-27 01:22:16', '2025-05-05 17:47:46'),
(343, 'Восточный Мордор', 'восточный-мордор', '00:02:49', NULL, NULL, NULL, '2011-09-15', 0.00, '2025-04-27 01:22:17', '2025-05-05 17:47:46'),
(344, 'Тентакли', 'тентакли', '00:03:41', NULL, NULL, NULL, '2011-09-15', 0.00, '2025-04-27 01:22:17', '2025-05-05 17:47:46'),
(345, 'Спонтанное самовозгорание', 'спонтанное-самовозгорание', '00:02:32', NULL, NULL, NULL, '2011-09-15', 0.00, '2025-04-27 01:22:17', '2025-05-05 17:47:46'),
(346, 'CCTV', 'cctv', '00:02:17', NULL, NULL, NULL, '2011-09-15', 0.00, '2025-04-27 01:22:17', '2025-05-05 17:47:46'),
(347, 'До сих пор МС', 'до-сих-пор-мс', '00:03:24', NULL, NULL, NULL, '2011-09-15', 0.00, '2025-04-27 01:22:17', '2025-05-05 17:47:46'),
(348, 'Привет со дна', 'привет-со-дна', '00:05:05', NULL, NULL, NULL, '2011-09-15', 0.00, '2025-04-27 01:22:17', '2025-05-05 17:47:46'),
(349, 'Вечный жид', 'вечный-жид', '00:02:33', NULL, NULL, NULL, '2011-09-15', 0.00, '2025-04-27 01:22:17', '2025-05-05 17:47:46'),
(350, 'В бульбуляторе', 'в-бульбуляторе', '00:02:47', NULL, NULL, NULL, '2011-09-15', 0.00, '2025-04-27 01:22:17', '2025-05-05 17:47:46'),
(351, 'Судьба моралиста', 'судьба-моралиста', '00:01:53', NULL, NULL, NULL, '2011-09-15', 0.00, '2025-04-27 01:22:17', '2025-05-05 17:47:46'),
(352, 'Цифры и цвета', 'цифры-и-цвета', '00:02:41', NULL, NULL, NULL, '2011-09-15', 0.00, '2025-04-27 01:22:17', '2025-05-05 17:47:46'),
(353, 'Russky Cockney', 'russky-cockney', '00:02:37', NULL, NULL, NULL, '2011-09-15', 0.00, '2025-04-27 01:22:17', '2025-05-05 17:47:46'),
(354, 'В говне', 'в-говне', '00:02:30', NULL, NULL, NULL, '2011-09-15', 0.00, '2025-04-27 01:22:17', '2025-05-05 17:47:46'),
(355, 'Крокодиловы слезы', 'крокодиловы-слезы', '00:02:41', NULL, NULL, NULL, '2011-09-15', 0.00, '2025-04-27 01:22:17', '2025-05-05 17:47:46'),
(356, 'Жук в муравейнике', 'жук-в-муравейнике', '00:04:00', NULL, NULL, NULL, '2011-09-15', 0.00, '2025-04-27 01:22:17', '2025-05-05 17:47:46'),
(357, 'журавли', 'журавли', '00:02:42', NULL, NULL, NULL, '2024-08-30', 0.00, '2025-04-27 01:22:17', '2025-05-05 17:47:46'),
(358, 'МИР ГОРИТ', 'мир-горит', '00:03:25', NULL, NULL, NULL, '2024-05-13', 0.00, '2025-04-27 01:22:18', '2025-05-05 17:47:46'),
(359, 'Прекрасное Далёко', 'прекрасное-далёко', '00:03:24', NULL, NULL, NULL, '2023-09-26', 0.00, '2025-04-27 01:22:19', '2025-05-05 17:47:46'),
(360, '1.Kla$ Pt. 2', '1kla-pt-2', '00:01:53', NULL, NULL, NULL, '2023-09-15', 0.00, '2025-04-27 01:22:20', '2025-05-05 17:47:46'),
(361, '1.Kla$', '1kla', '00:02:01', NULL, NULL, NULL, '2023-09-01', 0.00, '2025-04-27 01:22:21', '2025-05-05 17:47:46'),
(362, 'Я знаю, что делал прошлым летом', 'я-знаю-что-делал-прошлым-летом', '00:02:46', NULL, NULL, NULL, '2023-08-25', 0.00, '2025-04-27 01:22:21', '2025-05-05 17:47:46'),
(363, 'Лига Опасного Интернета', 'лига-опасного-интернета', '00:02:20', NULL, NULL, NULL, '2023-08-11', 0.00, '2025-04-27 01:22:22', '2025-05-05 17:47:46'),
(364, 'THE STORY OF ALISHER', 'the-story-of-alisher', '00:07:17', NULL, NULL, NULL, '2022-12-13', 0.00, '2025-04-27 01:22:23', '2025-05-05 17:47:46'),
(365, 'BASSLINE BUSINESS', 'bassline-business', '00:02:54', NULL, NULL, NULL, '2022-10-28', 0.00, '2025-04-27 01:22:24', '2025-05-05 17:47:46'),
(366, 'НЛО', 'нло', '00:02:01', NULL, NULL, NULL, '2022-10-21', 0.00, '2025-04-27 01:22:24', '2025-05-05 17:47:46'),
(367, '23 февраля', '23-февраля', '00:02:31', NULL, NULL, NULL, '2022-10-14', 0.00, '2025-04-27 01:22:25', '2025-05-05 17:47:46'),
(368, 'Сделано в России', 'сделано-в-россии', '00:02:29', NULL, NULL, NULL, '2022-09-30', 0.00, '2025-04-27 01:22:26', '2025-05-05 17:47:46'),
(369, 'ОЙДА', 'ойда', '00:02:22', NULL, NULL, NULL, '2022-09-16', 0.00, '2025-04-27 01:22:26', '2025-05-05 17:47:46'),
(370, 'ОРГАНИЗАЦИЯ', 'организация', '00:03:21', NULL, NULL, NULL, '2021-11-08', 0.00, '2025-04-27 01:22:27', '2025-05-05 17:47:46'),
(371, 'КТО УБИЛ МАРКА?', 'кто-убил-марка', '00:09:27', NULL, NULL, NULL, '2021-11-01', 0.00, '2025-04-27 01:22:29', '2025-05-05 17:47:46'),
(372, 'Стихи о неизвестном солдате (из трибьюта Осипу Мандельштаму «Сохрани мою речь навсегда»)', 'стихи-о-неизвестном-солдате-из-трибьюта-осипу-мандельштаму-сохрани-мою-речь-навсегда', '00:04:26', NULL, NULL, NULL, '2021-01-14', 0.00, '2025-04-27 01:22:29', '2025-05-05 17:47:46'),
(373, 'В книге все было по-другому (4 раунд, 17ib)', 'в-книге-все-было-по-другому-4-раунд-17ib', '00:05:55', NULL, NULL, NULL, '2020-02-03', 0.00, '2025-04-27 01:22:30', '2025-05-05 17:47:46'),
(374, 'Дело нескольких минут (3 раунд, 17 ib)', 'дело-нескольких-минут-3-раунд-17-ib', '00:05:50', NULL, NULL, NULL, '2019-12-23', 0.00, '2025-04-27 01:22:31', '2025-05-05 17:47:46'),
(375, 'Ветер Перемен (2 раунд, 17ib)', 'ветер-перемен-2-раунд-17ib', '00:01:30', NULL, NULL, NULL, '2019-11-06', 0.00, '2025-04-27 01:22:32', '2025-05-05 17:47:46'),
(376, 'В долгий путь (1 раунд, 17ib)', 'в-долгий-путь-1-раунд-17ib', '00:00:49', NULL, NULL, NULL, '2019-09-04', 0.00, '2025-04-27 01:22:32', '2025-05-05 17:47:46'),
(377, 'Что такое империя?', 'что-такое-империя-1', '00:01:52', NULL, NULL, NULL, '2017-08-11', 0.00, '2025-04-27 01:22:34', '2025-05-05 17:47:46'),
(378, 'Город под подошвой', 'город-под-подошвой', '00:04:06', NULL, NULL, NULL, '2015-09-21', 0.00, '2025-04-27 01:22:35', '2025-05-05 17:47:46'),
(379, 'Earth Burns', 'earth-burns', '00:04:15', NULL, NULL, NULL, '2014-08-18', 0.00, '2025-04-27 01:22:37', '2025-05-05 17:47:46'),
(380, 'То густо, то пусто', 'то-густо-то-пусто', '00:03:37', NULL, NULL, NULL, '2011-06-18', 0.00, '2025-04-27 01:22:38', '2025-05-05 17:47:46'),
(381, 'То густо, то пусто - Santo Remix', 'то-густо-то-пусто---santo-remix', '00:04:00', NULL, NULL, NULL, '2011-06-18', 0.00, '2025-04-27 01:22:38', '2025-05-05 17:47:46'),
(382, 'Vasco da Gama', 'vasco-da-gama', '00:04:49', NULL, NULL, NULL, '2011-06-18', 0.00, '2025-04-27 01:22:38', '2025-05-05 17:47:46'),
(383, 'Vasco da Gama - Santo Remix', 'vasco-da-gama---santo-remix', '00:04:49', NULL, NULL, NULL, '2011-06-18', 0.00, '2025-04-27 01:22:38', '2025-05-05 17:47:46'),
(384, 'Что такое BEEF?', 'что-такое-beef', '00:04:16', NULL, NULL, NULL, '2008-05-13', 0.00, '2025-04-27 01:22:38', '2025-05-05 17:47:46'),
(385, 'test track', 'test-track', '00:04:42', 'test track', NULL, NULL, '2025-02-28', 0.00, '2025-05-05 20:13:33', '2025-05-05 17:47:46'),
(386, 'Overcompensate', 'overcompensate', '00:03:56', NULL, NULL, NULL, '2024-02-29', 0.00, '2025-05-29 06:10:12', '2025-05-29 06:10:31'),
(387, 'Next Semester', 'next-semester', '00:03:54', NULL, NULL, NULL, '2024-05-22', 0.00, '2025-05-29 06:10:12', '2025-05-29 06:10:29'),
(388, 'Backslide', 'backslide', '00:03:00', NULL, NULL, NULL, '2024-05-22', 0.00, '2025-05-29 06:10:12', '2025-05-29 06:10:29'),
(389, 'Midwest Indigo', 'midwest-indigo', '00:03:16', NULL, NULL, NULL, '2024-05-24', 0.00, '2025-05-29 06:10:12', '2025-05-29 06:10:12'),
(390, 'Routines In The Night', 'routines-in-the-night', '00:03:22', NULL, NULL, NULL, '2024-05-24', 0.00, '2025-05-29 06:10:12', '2025-05-29 06:10:12'),
(391, 'Vignette', 'vignette', '00:03:22', NULL, NULL, NULL, '2024-05-24', 0.00, '2025-05-29 06:10:12', '2025-05-29 06:10:12'),
(392, 'The Craving (Jenna\'s version)', 'the-craving-jennas-version', '00:02:54', NULL, NULL, NULL, '2024-05-24', 0.00, '2025-05-29 06:10:12', '2025-05-29 06:10:12'),
(393, 'Lavish', 'lavish', '00:02:38', NULL, NULL, NULL, '2024-05-24', 0.00, '2025-05-29 06:10:12', '2025-05-29 06:10:12'),
(394, 'Navigating', 'navigating', '00:03:43', NULL, NULL, NULL, '2024-05-24', 0.00, '2025-05-29 06:10:12', '2025-05-29 06:10:12'),
(395, 'Snap Back', 'snap-back', '00:03:30', NULL, NULL, NULL, '2024-05-24', 0.00, '2025-05-29 06:10:12', '2025-05-29 06:10:12'),
(396, 'Oldies Station', 'oldies-station', '00:03:48', NULL, NULL, NULL, '2024-05-24', 0.00, '2025-05-29 06:10:12', '2025-05-29 06:10:12'),
(397, 'At The Risk Of Feeling Dumb', 'at-the-risk-of-feeling-dumb', '00:03:23', NULL, NULL, NULL, '2024-05-24', 0.00, '2025-05-29 06:10:12', '2025-05-29 06:10:12'),
(398, 'Paladin Strait', 'paladin-strait', '00:06:28', NULL, NULL, NULL, '2024-05-24', 0.00, '2025-05-29 06:10:12', '2025-05-29 06:10:12'),
(399, 'Intro - MTV Unplugged Live', 'intro---mtv-unplugged-live', '00:01:18', NULL, NULL, NULL, '2023-04-21', 0.00, '2025-05-29 06:10:13', '2025-05-29 06:10:13'),
(400, 'Stressed Out - MTV Unplugged Live', 'stressed-out---mtv-unplugged-live', '00:04:23', NULL, NULL, NULL, '2023-04-21', 0.00, '2025-05-29 06:10:13', '2025-05-29 06:10:13'),
(401, 'Tear in My Heart - MTV Unplugged Live', 'tear-in-my-heart---mtv-unplugged-live', '00:04:42', NULL, NULL, NULL, '2023-04-21', 0.00, '2025-05-29 06:10:13', '2025-05-29 06:10:13'),
(402, 'House Of Gold / Lane Boy - MTV Unplugged Live', 'house-of-gold--lane-boy---mtv-unplugged-live', '00:06:59', NULL, NULL, NULL, '2023-04-21', 0.00, '2025-05-29 06:10:13', '2025-05-29 06:10:13'),
(403, 'Shy Away - MTV Unplugged Live', 'shy-away---mtv-unplugged-live', '00:06:01', NULL, NULL, NULL, '2023-04-21', 0.00, '2025-05-29 06:10:13', '2025-05-29 06:10:13'),
(404, 'Ride / Nico And The Niners - MTV Unplugged Live', 'ride--nico-and-the-niners---mtv-unplugged-live', '00:05:18', NULL, NULL, NULL, '2023-04-21', 0.00, '2025-05-29 06:10:13', '2025-05-29 06:10:13'),
(405, 'Car Radio / Heathens - MTV Unplugged Live', 'car-radio--heathens---mtv-unplugged-live', '00:05:38', NULL, NULL, NULL, '2023-04-21', 0.00, '2025-05-29 06:10:13', '2025-05-29 06:10:13'),
(406, 'Good Day', 'good-day', '00:03:24', NULL, NULL, NULL, '2021-05-21', 0.00, '2025-05-29 06:10:13', '2025-05-29 06:10:14'),
(407, 'Choker', 'choker', '00:03:43', NULL, NULL, NULL, '2021-05-21', 0.00, '2025-05-29 06:10:13', '2025-05-29 06:10:14'),
(408, 'Shy Away', 'shy-away', '00:02:55', NULL, NULL, NULL, '2021-06-11', 0.00, '2025-05-29 06:10:13', '2025-05-29 06:10:33'),
(409, 'The Outside', 'the-outside', '00:03:36', NULL, NULL, NULL, '2021-05-21', 0.00, '2025-05-29 06:10:14', '2025-05-29 06:10:14'),
(410, 'Saturday', 'saturday', '00:02:52', NULL, NULL, NULL, '2021-05-21', 0.00, '2025-05-29 06:10:14', '2025-05-29 06:10:14'),
(411, 'Never Take It', 'never-take-it', '00:03:32', NULL, NULL, NULL, '2021-05-21', 0.00, '2025-05-29 06:10:14', '2025-05-29 06:10:15'),
(412, 'Mulberry Street', 'mulberry-street', '00:03:44', NULL, NULL, NULL, '2021-05-21', 0.00, '2025-05-29 06:10:14', '2025-05-29 06:10:15'),
(413, 'Formidable', 'formidable', '00:02:56', NULL, NULL, NULL, '2021-05-21', 0.00, '2025-05-29 06:10:14', '2025-05-29 06:10:15'),
(414, 'Bounce Man', 'bounce-man', '00:03:05', NULL, NULL, NULL, '2021-05-21', 0.00, '2025-05-29 06:10:14', '2025-05-29 06:10:15'),
(415, 'No Chances', 'no-chances', '00:03:46', NULL, NULL, NULL, '2021-05-21', 0.00, '2025-05-29 06:10:14', '2025-05-29 06:10:15'),
(416, 'Redecorate', 'redecorate', '00:04:05', NULL, NULL, NULL, '2021-05-21', 0.00, '2025-05-29 06:10:14', '2025-05-29 06:10:15'),
(417, 'Choker / Stressed Out / Migraine / Morph / Holding On To You - Livestream Version', 'choker--stressed-out--migraine--morph--holding-on-to-you---livestream-version', '00:09:40', NULL, NULL, NULL, '2021-11-19', 0.00, '2025-05-29 06:10:14', '2025-05-29 06:10:14'),
(418, 'Mulberry Street - Livestream Version', 'mulberry-street---livestream-version', '00:04:21', NULL, NULL, NULL, '2021-11-19', 0.00, '2025-05-29 06:10:14', '2025-05-29 06:10:14'),
(419, 'Lane Boy / Redecorate / Chlorine - Livestream Version', 'lane-boy--redecorate--chlorine---livestream-version', '00:06:02', NULL, NULL, NULL, '2021-11-19', 0.00, '2025-05-29 06:10:14', '2025-05-29 06:10:14'),
(420, 'Shy Away - Livestream Version', 'shy-away---livestream-version', '00:02:56', NULL, NULL, NULL, '2021-06-11', 0.00, '2025-05-29 06:10:14', '2025-05-29 06:10:33'),
(421, 'The Outside - Livestream Version', 'the-outside---livestream-version', '00:04:56', NULL, NULL, NULL, '2021-11-19', 0.00, '2025-05-29 06:10:14', '2025-05-29 06:10:14'),
(422, 'Heathens / Trees - Livestream Version', 'heathens--trees---livestream-version', '00:04:19', NULL, NULL, NULL, '2021-09-10', 0.00, '2025-05-29 06:10:14', '2025-05-29 06:10:32'),
(423, 'Jumpsuit / Heavydirtysoul - Livestream Version', 'jumpsuit--heavydirtysoul---livestream-version', '00:04:08', NULL, NULL, NULL, '2021-11-19', 0.00, '2025-05-29 06:10:14', '2025-05-29 06:10:14'),
(424, 'Saturday / Level of Concern / Ride / Car Radio - Livestream Version', 'saturday--level-of-concern--ride--car-radio---livestream-version', '00:12:50', NULL, NULL, NULL, '2021-11-19', 0.00, '2025-05-29 06:10:14', '2025-05-29 06:10:14'),
(425, 'Never Take It - Livestream Version', 'never-take-it---livestream-version', '00:03:38', NULL, NULL, NULL, '2021-11-19', 0.00, '2025-05-29 06:10:14', '2025-05-29 06:10:14'),
(426, 'Jumpsuit', 'jumpsuit', '00:03:58', NULL, NULL, NULL, '2018-10-05', 0.00, '2025-05-29 06:10:15', '2025-05-29 06:10:15'),
(427, 'Levitate', 'levitate', '00:02:25', NULL, NULL, NULL, '2018-10-05', 0.00, '2025-05-29 06:10:15', '2025-05-29 06:10:15'),
(428, 'Morph', 'morph', '00:04:18', NULL, NULL, NULL, '2018-10-05', 0.00, '2025-05-29 06:10:15', '2025-05-29 06:10:15'),
(429, 'My Blood', 'my-blood', '00:03:49', NULL, NULL, NULL, '2018-10-05', 0.00, '2025-05-29 06:10:15', '2025-05-29 06:10:15'),
(430, 'Chlorine', 'chlorine', '00:05:24', NULL, NULL, NULL, '2019-06-21', 0.00, '2025-05-29 06:10:15', '2025-05-29 06:10:41'),
(431, 'Smithereens', 'smithereens', '00:02:57', NULL, NULL, NULL, '2018-10-05', 0.00, '2025-05-29 06:10:15', '2025-05-29 06:10:15'),
(432, 'Neon Gravestones', 'neon-gravestones', '00:04:00', NULL, NULL, NULL, '2018-10-05', 0.00, '2025-05-29 06:10:15', '2025-05-29 06:10:15'),
(433, 'The Hype', 'the-hype', '00:04:25', NULL, NULL, NULL, '2019-07-26', 0.00, '2025-05-29 06:10:15', '2025-05-29 06:10:37'),
(434, 'Nico and the Niners', 'nico-and-the-niners', '00:03:45', NULL, NULL, NULL, '2018-10-05', 0.00, '2025-05-29 06:10:15', '2025-05-29 06:10:15'),
(435, 'Cut My Lip', 'cut-my-lip', '00:04:42', NULL, NULL, NULL, '2018-10-05', 0.00, '2025-05-29 06:10:16', '2025-05-29 06:10:16'),
(436, 'Bandito', 'bandito', '00:05:30', NULL, NULL, NULL, '2018-10-05', 0.00, '2025-05-29 06:10:16', '2025-05-29 06:10:16'),
(437, 'Pet Cheetah', 'pet-cheetah', '00:03:18', NULL, NULL, NULL, '2018-10-05', 0.00, '2025-05-29 06:10:16', '2025-05-29 06:10:16'),
(438, 'Legend', 'legend', '00:02:52', NULL, NULL, NULL, '2018-10-05', 0.00, '2025-05-29 06:10:16', '2025-05-29 06:10:16'),
(439, 'Leave the City', 'leave-the-city', '00:04:40', NULL, NULL, NULL, '2018-10-05', 0.00, '2025-05-29 06:10:16', '2025-05-29 06:10:16'),
(440, 'Heavydirtysoul', 'heavydirtysoul', '00:03:54', NULL, NULL, NULL, '2015-05-15', 0.00, '2025-05-29 06:10:16', '2025-05-29 06:10:16'),
(441, 'Stressed Out', 'stressed-out', '00:03:22', NULL, NULL, NULL, '2015-04-28', 0.00, '2025-05-29 06:10:16', '2025-05-29 06:10:53'),
(442, 'Ride', 'ride', '00:03:34', NULL, NULL, NULL, '2015-05-12', 0.00, '2025-05-29 06:10:16', '2025-05-29 06:10:50'),
(443, 'Fairly Local', 'fairly-local', '00:03:27', NULL, NULL, NULL, '2015-03-17', 0.00, '2025-05-29 06:10:16', '2025-05-29 06:10:56'),
(444, 'Tear in My Heart', 'tear-in-my-heart', '00:03:08', NULL, NULL, NULL, '2015-04-06', 0.00, '2025-05-29 06:10:16', '2025-05-29 06:10:54'),
(445, 'Lane Boy', 'lane-boy', '00:04:13', NULL, NULL, NULL, '2015-05-04', 0.00, '2025-05-29 06:10:16', '2025-05-29 06:10:52'),
(446, 'The Judge', 'the-judge', '00:04:57', NULL, NULL, NULL, '2015-05-15', 0.00, '2025-05-29 06:10:16', '2025-05-29 06:10:16'),
(447, 'Doubt', 'doubt', '00:03:11', NULL, NULL, NULL, '2015-05-15', 0.00, '2025-05-29 06:10:16', '2025-05-29 06:10:16'),
(448, 'Polarize', 'polarize', '00:03:46', NULL, NULL, NULL, '2015-05-15', 0.00, '2025-05-29 06:10:16', '2025-05-29 06:10:16'),
(449, 'We Don\'t Believe What\'s on TV', 'we-dont-believe-whats-on-tv', '00:02:57', NULL, NULL, NULL, '2015-05-15', 0.00, '2025-05-29 06:10:16', '2025-05-29 06:10:16'),
(450, 'Message Man', 'message-man', '00:04:00', NULL, NULL, NULL, '2015-05-15', 0.00, '2025-05-29 06:10:17', '2025-05-29 06:10:17'),
(451, 'Hometown', 'hometown', '00:03:54', NULL, NULL, NULL, '2015-05-15', 0.00, '2025-05-29 06:10:17', '2025-05-29 06:10:17'),
(452, 'Not Today', 'not-today', '00:03:58', NULL, NULL, NULL, '2015-05-15', 0.00, '2025-05-29 06:10:17', '2025-05-29 06:10:17'),
(453, 'Goner', 'goner', '00:03:56', NULL, NULL, NULL, '2015-05-15', 0.00, '2025-05-29 06:10:17', '2025-05-29 06:10:17'),
(454, 'Ode to Sleep', 'ode-to-sleep', '00:05:08', NULL, NULL, NULL, '2012-07-17', 0.00, '2025-05-29 06:10:22', '2025-05-29 06:10:58'),
(455, 'Holding on to You', 'holding-on-to-you', '00:04:23', NULL, NULL, NULL, '2013-01-08', 0.00, '2025-05-29 06:10:22', '2025-05-29 06:10:22'),
(456, 'Migraine', 'migraine', '00:03:59', NULL, NULL, NULL, '2012-07-17', 0.00, '2025-05-29 06:10:22', '2025-05-29 06:10:58'),
(457, 'House of Gold', 'house-of-gold', '00:02:43', NULL, NULL, NULL, '2013-01-08', 0.00, '2025-05-29 06:10:22', '2025-05-29 06:10:22'),
(458, 'Car Radio', 'car-radio', '00:04:27', NULL, NULL, NULL, '2013-01-08', 0.00, '2025-05-29 06:10:22', '2025-05-29 06:10:22'),
(459, 'Semi-Automatic', 'semi-automatic', '00:04:13', NULL, NULL, NULL, '2013-01-08', 0.00, '2025-05-29 06:10:22', '2025-05-29 06:10:22'),
(460, 'Screen', 'screen', '00:03:49', NULL, NULL, NULL, '2013-01-08', 0.00, '2025-05-29 06:10:22', '2025-05-29 06:10:22'),
(461, 'The Run and Go', 'the-run-and-go', '00:03:49', NULL, NULL, NULL, '2013-01-08', 0.00, '2025-05-29 06:10:22', '2025-05-29 06:10:22'),
(462, 'Fake You Out', 'fake-you-out', '00:03:51', NULL, NULL, NULL, '2013-01-08', 0.00, '2025-05-29 06:10:22', '2025-05-29 06:10:22'),
(463, 'Guns for Hands', 'guns-for-hands', '00:04:33', NULL, NULL, NULL, '2012-07-17', 0.00, '2025-05-29 06:10:22', '2025-05-29 06:10:58'),
(464, 'Trees', 'trees', '00:04:27', NULL, NULL, NULL, '2013-01-08', 0.00, '2025-05-29 06:10:22', '2025-05-29 06:10:22'),
(465, 'Truce', 'truce', '00:02:22', NULL, NULL, NULL, '2013-01-08', 0.00, '2025-05-29 06:10:22', '2025-05-29 06:10:22'),
(466, 'Implicit Demand For Proof', 'implicit-demand-for-proof', '00:04:51', NULL, NULL, NULL, '2009-12-29', 0.00, '2025-05-29 06:10:23', '2025-05-29 06:10:23'),
(467, 'Fall Away', 'fall-away', '00:03:02', NULL, NULL, NULL, '2009-12-29', 0.00, '2025-05-29 06:10:23', '2025-05-29 06:10:23'),
(468, 'The Pantaloon', 'the-pantaloon', '00:03:33', NULL, NULL, NULL, '2009-12-29', 0.00, '2025-05-29 06:10:23', '2025-05-29 06:10:23'),
(469, 'Addict With A Pen', 'addict-with-a-pen', '00:04:46', NULL, NULL, NULL, '2009-12-29', 0.00, '2025-05-29 06:10:23', '2025-05-29 06:10:23'),
(470, 'Friend, Please', 'friend-please', '00:04:12', NULL, NULL, NULL, '2009-12-29', 0.00, '2025-05-29 06:10:23', '2025-05-29 06:10:23'),
(471, 'March To the Sea', 'march-to-the-sea', '00:05:31', NULL, NULL, NULL, '2009-12-29', 0.00, '2025-05-29 06:10:23', '2025-05-29 06:10:23'),
(472, 'Johnny Boy', 'johnny-boy', '00:04:39', NULL, NULL, NULL, '2009-12-29', 0.00, '2025-05-29 06:10:23', '2025-05-29 06:10:23'),
(473, 'Oh Ms Believer', 'oh-ms-believer', '00:03:37', NULL, NULL, NULL, '2009-12-29', 0.00, '2025-05-29 06:10:23', '2025-05-29 06:10:23'),
(474, 'Air Catcher', 'air-catcher', '00:04:14', NULL, NULL, NULL, '2009-12-29', 0.00, '2025-05-29 06:10:23', '2025-05-29 06:10:23'),
(475, 'Trapdoor', 'trapdoor', '00:04:37', NULL, NULL, NULL, '2009-12-29', 0.00, '2025-05-29 06:10:23', '2025-05-29 06:10:23'),
(476, 'A Car, a Torch, a Death', 'a-car-a-torch-a-death', '00:04:33', NULL, NULL, NULL, '2009-12-29', 0.00, '2025-05-29 06:10:23', '2025-05-29 06:10:23'),
(477, 'Taxi Cab', 'taxi-cab', '00:04:45', NULL, NULL, NULL, '2009-12-29', 0.00, '2025-05-29 06:10:23', '2025-05-29 06:10:23'),
(478, 'Before You Start Your Day', 'before-you-start-your-day', '00:03:53', NULL, NULL, NULL, '2009-12-29', 0.00, '2025-05-29 06:10:23', '2025-05-29 06:10:23'),
(479, 'Isle Of Flightless Birds', 'isle-of-flightless-birds', '00:05:45', NULL, NULL, NULL, '2009-12-29', 0.00, '2025-05-29 06:10:23', '2025-05-29 06:10:23'),
(480, 'Doubt (demo)', 'doubt-demo', '00:02:57', NULL, NULL, NULL, '2025-04-09', 0.00, '2025-05-29 06:10:24', '2025-05-29 06:10:24');
INSERT INTO `tracks` (`id`, `title`, `slug`, `duration`, `description`, `description_lv`, `audio_source`, `release_date`, `popularity`, `created_at`, `updated_at`) VALUES
(481, 'The Line (from the series Arcane League of Legends)', 'the-line-from-the-series-arcane-league-of-legends', '00:03:12', NULL, NULL, NULL, '2024-11-22', 0.00, '2025-05-29 06:10:25', '2025-05-29 06:10:25'),
(482, 'The Craving - single version', 'the-craving---single-version', '00:02:53', NULL, NULL, NULL, '2024-05-22', 0.00, '2025-05-29 06:10:29', '2025-05-29 06:10:29'),
(483, 'Overcompensate (edit)', 'overcompensate-edit', '00:03:10', NULL, NULL, NULL, '2024-02-29', 0.00, '2025-05-29 06:10:31', '2025-05-29 06:10:31'),
(484, 'Christmas Saves The Year', 'christmas-saves-the-year', '00:03:32', NULL, NULL, NULL, '2020-12-08', 0.00, '2025-05-29 06:10:33', '2025-05-29 06:10:33'),
(485, 'Level of Concern - live from outside', 'level-of-concern---live-from-outside', '00:03:42', NULL, NULL, NULL, '2020-05-26', 0.00, '2025-05-29 06:10:34', '2025-05-29 06:10:34'),
(486, 'Level of Concern', 'level-of-concern', '00:03:40', NULL, NULL, NULL, '2020-04-09', 0.00, '2025-05-29 06:10:34', '2025-05-29 06:10:35'),
(487, 'The Hype - Berlin', 'the-hype---berlin', '00:04:10', NULL, NULL, NULL, '2019-10-16', 0.00, '2025-05-29 06:10:36', '2025-05-29 06:10:36'),
(488, 'The Hype - Alt Mix', 'the-hype---alt-mix', '00:03:22', NULL, NULL, NULL, '2019-07-26', 0.00, '2025-05-29 06:10:36', '2025-05-29 06:10:37'),
(489, 'Cut My Lip (Brooklyn)', 'cut-my-lip-brooklyn', '00:04:18', NULL, NULL, NULL, '2019-07-11', 0.00, '2025-05-29 06:10:38', '2025-05-29 06:10:38'),
(490, 'Chlorine (Mexico City)', 'chlorine-mexico-city', '00:03:58', NULL, NULL, NULL, '2019-06-21', 0.00, '2025-05-29 06:10:41', '2025-05-29 06:10:41'),
(491, 'Chlorine - Alternative Mix', 'chlorine---alternative-mix', '00:03:11', NULL, NULL, NULL, '2019-02-08', 0.00, '2025-05-29 06:10:42', '2025-05-29 06:10:42'),
(492, 'Heathens (feat. MUTEMATH)', 'heathens-feat-mutemath', '00:04:34', NULL, NULL, NULL, '2016-12-20', 0.00, '2025-05-29 06:10:43', '2025-05-29 06:10:43'),
(493, 'Heavydirtysoul (feat. MUTEMATH)', 'heavydirtysoul-feat-mutemath', '00:04:00', NULL, NULL, NULL, '2016-12-20', 0.00, '2025-05-29 06:10:43', '2025-05-29 06:10:43'),
(494, 'Ride (feat. MUTEMATH)', 'ride-feat-mutemath', '00:03:48', NULL, NULL, NULL, '2016-12-20', 0.00, '2025-05-29 06:10:43', '2025-05-29 06:10:43'),
(495, 'Tear in My Heart (feat. MUTEMATH)', 'tear-in-my-heart-feat-mutemath', '00:03:48', NULL, NULL, NULL, '2016-12-20', 0.00, '2025-05-29 06:10:43', '2025-05-29 06:10:43'),
(496, 'Lane Boy (feat. MUTEMATH)', 'lane-boy-feat-mutemath', '00:05:21', NULL, NULL, NULL, '2016-12-20', 0.00, '2025-05-29 06:10:43', '2025-05-29 06:10:43'),
(497, 'Cancer', 'cancer', '00:03:56', NULL, NULL, NULL, '2016-09-14', 0.00, '2025-05-29 06:10:44', '2025-05-29 06:10:44'),
(498, 'Heathens', 'heathens', '00:03:15', NULL, NULL, NULL, '2016-06-16', 0.00, '2025-05-29 06:10:46', '2025-05-29 06:10:46'),
(499, 'tst_role', 'tst-role', '00:03:43', 'tst', 'tst', 'tst', '2025-11-17', 0.00, '2026-01-03 14:53:56', '2026-01-03 14:53:56'),
(501, 'Konstrukt', 'konstrukt-123', '00:04:00', 'test track with lots of artists', 'test track with lots of artists', NULL, '2026-03-10', 0.00, '2026-04-07 18:09:31', '2026-04-07 18:09:31');

-- --------------------------------------------------------

--
-- Table structure for table `tracks_genres`
--

CREATE TABLE `tracks_genres` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `track_id` bigint(20) UNSIGNED NOT NULL,
  `genre_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `tracks_genres`
--

INSERT INTO `tracks_genres` (`id`, `track_id`, `genre_id`, `created_at`, `updated_at`) VALUES
(1, 3, 1, '2025-04-22 13:31:48', '2025-04-22 13:31:48'),
(2, 3, 2, '2025-04-22 13:31:48', '2025-04-22 13:31:48'),
(3, 3, 4, '2025-04-22 13:31:48', '2025-04-22 13:31:48'),
(4, 3, 5, '2025-04-22 13:31:48', '2025-04-22 13:31:48'),
(5, 3, 7, '2025-04-22 13:31:48', '2025-04-22 13:31:48'),
(6, 5, 7, '2025-04-22 13:31:51', '2025-04-22 13:31:51'),
(7, 5, 10, '2025-04-22 13:31:51', '2025-04-22 13:31:51'),
(8, 5, 38, '2025-04-22 13:31:51', '2025-04-22 13:31:51'),
(9, 5, 39, '2025-04-22 13:31:51', '2025-04-22 13:31:51'),
(10, 6, 2, '2025-04-22 13:31:52', '2025-04-22 13:31:52'),
(11, 6, 5, '2025-04-22 13:31:52', '2025-04-22 13:31:52'),
(12, 6, 7, '2025-04-22 13:31:52', '2025-04-22 13:31:52'),
(13, 6, 9, '2025-04-22 13:31:52', '2025-04-22 13:31:52'),
(14, 6, 10, '2025-04-22 13:31:52', '2025-04-22 13:31:52'),
(15, 11, 2, '2025-04-22 13:31:59', '2025-04-22 13:31:59'),
(16, 11, 6, '2025-04-22 13:31:59', '2025-04-22 13:31:59'),
(17, 11, 10, '2025-04-22 13:31:59', '2025-04-22 13:31:59'),
(18, 11, 15, '2025-04-22 13:31:59', '2025-04-22 13:31:59'),
(19, 11, 40, '2025-04-22 13:31:59', '2025-04-22 13:31:59'),
(20, 14, 12, '2025-04-22 13:32:03', '2025-04-22 13:32:03'),
(21, 14, 40, '2025-04-22 13:32:03', '2025-04-22 13:32:03'),
(22, 14, 41, '2025-04-22 13:32:03', '2025-04-22 13:32:03'),
(23, 14, 42, '2025-04-22 13:32:03', '2025-04-22 13:32:03'),
(24, 14, 43, '2025-04-22 13:32:03', '2025-04-22 13:32:03'),
(25, 22, 2, '2025-04-22 13:30:51', '2025-04-22 13:30:51'),
(26, 22, 5, '2025-04-22 13:30:51', '2025-04-22 13:30:51'),
(27, 22, 7, '2025-04-22 13:30:51', '2025-04-22 13:30:51'),
(28, 22, 27, '2025-04-22 13:30:51', '2025-04-22 13:30:51'),
(29, 22, 28, '2025-04-22 13:30:51', '2025-04-22 13:30:51'),
(30, 24, 2, '2025-04-22 13:30:54', '2025-04-22 13:30:54'),
(31, 24, 7, '2025-04-22 13:30:54', '2025-04-22 13:30:54'),
(32, 24, 8, '2025-04-22 13:30:54', '2025-04-22 13:30:54'),
(33, 24, 12, '2025-04-22 13:30:54', '2025-04-22 13:30:54'),
(34, 24, 29, '2025-04-22 13:30:54', '2025-04-22 13:30:54'),
(35, 25, 8, '2025-04-22 13:30:56', '2025-04-22 13:30:56'),
(36, 25, 10, '2025-04-22 13:30:55', '2025-04-22 13:30:55'),
(37, 25, 15, '2025-04-22 13:30:55', '2025-04-22 13:30:55'),
(38, 25, 31, '2025-04-22 13:30:56', '2025-04-22 13:30:56'),
(39, 56, 2, '2025-04-22 13:31:36', '2025-04-22 13:31:36'),
(40, 56, 10, '2025-04-22 13:31:36', '2025-04-22 13:31:36'),
(41, 56, 12, '2025-04-22 13:31:36', '2025-04-22 13:31:36'),
(42, 56, 14, '2025-04-22 13:31:36', '2025-04-22 13:31:36'),
(43, 56, 36, '2025-04-22 13:31:36', '2025-04-22 13:31:36'),
(44, 65, 2, '2025-04-22 13:30:11', '2025-04-22 13:30:11'),
(45, 65, 5, '2025-04-22 13:30:11', '2025-04-22 13:30:11'),
(46, 65, 10, '2025-04-22 13:30:11', '2025-04-22 13:30:11'),
(47, 65, 11, '2025-04-22 13:30:11', '2025-04-22 13:30:11'),
(48, 65, 12, '2025-04-22 13:30:12', '2025-04-22 13:30:12'),
(49, 66, 2, '2025-04-22 13:30:13', '2025-04-22 13:30:13'),
(50, 66, 5, '2025-04-22 13:30:13', '2025-04-22 13:30:13'),
(51, 66, 6, '2025-04-22 13:30:13', '2025-04-22 13:30:13'),
(52, 66, 9, '2025-04-22 13:30:13', '2025-04-22 13:30:13'),
(53, 66, 13, '2025-04-22 13:30:13', '2025-04-22 13:30:13'),
(54, 67, 2, '2025-04-22 13:30:15', '2025-04-22 13:30:15'),
(55, 67, 6, '2025-04-22 13:30:14', '2025-04-22 13:30:14'),
(56, 67, 10, '2025-04-22 13:30:14', '2025-04-22 13:30:14'),
(57, 67, 14, '2025-04-22 13:30:15', '2025-04-22 13:30:15'),
(58, 67, 15, '2025-04-22 13:30:15', '2025-04-22 13:30:15'),
(59, 71, 6, '2025-04-22 13:30:20', '2025-04-22 13:30:20'),
(60, 71, 9, '2025-04-22 13:30:20', '2025-04-22 13:30:20'),
(61, 71, 10, '2025-04-22 13:30:20', '2025-04-22 13:30:20'),
(62, 71, 15, '2025-04-22 13:30:20', '2025-04-22 13:30:20'),
(63, 74, 2, '2025-04-22 13:30:25', '2025-04-22 13:30:25'),
(64, 74, 9, '2025-04-22 13:30:25', '2025-04-22 13:30:25'),
(65, 74, 12, '2025-04-22 13:30:25', '2025-04-22 13:30:25'),
(66, 76, 1, '2025-04-22 13:30:28', '2025-04-22 13:30:28'),
(67, 76, 2, '2025-04-22 13:30:28', '2025-04-22 13:30:28'),
(68, 76, 3, '2025-04-22 13:30:28', '2025-04-22 13:30:28'),
(69, 76, 9, '2025-04-22 13:30:28', '2025-04-22 13:30:28'),
(70, 79, 1, '2025-04-22 13:30:32', '2025-04-22 13:30:32'),
(71, 79, 2, '2025-04-22 13:30:32', '2025-04-22 13:30:32'),
(72, 79, 5, '2025-04-22 13:30:32', '2025-04-22 13:30:32'),
(73, 79, 9, '2025-04-22 13:30:32', '2025-04-22 13:30:32'),
(74, 80, 1, '2025-04-22 13:30:33', '2025-04-22 13:30:33'),
(75, 80, 2, '2025-04-22 13:30:33', '2025-04-22 13:30:33'),
(76, 80, 3, '2025-04-22 13:30:33', '2025-04-22 13:30:33'),
(77, 80, 9, '2025-04-22 13:30:33', '2025-04-22 13:30:33'),
(78, 80, 21, '2025-04-22 13:30:34', '2025-04-22 13:30:34'),
(79, 81, 2, '2025-04-22 13:30:35', '2025-04-22 13:30:35'),
(80, 81, 3, '2025-04-22 13:30:35', '2025-04-22 13:30:35'),
(81, 81, 9, '2025-04-22 13:30:35', '2025-04-22 13:30:35'),
(82, 81, 21, '2025-04-22 13:30:35', '2025-04-22 13:30:35'),
(83, 81, 22, '2025-04-22 13:30:35', '2025-04-22 13:30:35'),
(84, 82, 1, '2025-04-22 13:30:36', '2025-04-22 13:30:36'),
(85, 82, 2, '2025-04-22 13:30:36', '2025-04-22 13:30:36'),
(86, 82, 3, '2025-04-22 13:30:36', '2025-04-22 13:30:36'),
(87, 82, 4, '2025-04-22 13:30:37', '2025-04-22 13:30:37'),
(88, 82, 9, '2025-04-22 13:30:36', '2025-04-22 13:30:36'),
(89, 83, 2, '2025-04-22 13:30:38', '2025-04-22 13:30:38'),
(90, 83, 3, '2025-04-22 13:30:38', '2025-04-22 13:30:38'),
(91, 83, 9, '2025-04-22 13:30:38', '2025-04-22 13:30:38'),
(92, 83, 21, '2025-04-22 13:30:38', '2025-04-22 13:30:38'),
(93, 83, 22, '2025-04-22 13:30:38', '2025-04-22 13:30:38'),
(94, 84, 2, '2025-04-22 13:30:39', '2025-04-22 13:30:39'),
(95, 84, 3, '2025-04-22 13:30:39', '2025-04-22 13:30:39'),
(96, 84, 9, '2025-04-22 13:30:39', '2025-04-22 13:30:39'),
(97, 84, 23, '2025-04-22 13:30:39', '2025-04-22 13:30:39'),
(98, 84, 24, '2025-04-22 13:30:39', '2025-04-22 13:30:39'),
(99, 86, 2, '2025-04-22 13:30:42', '2025-04-22 13:30:42'),
(100, 86, 5, '2025-04-22 13:30:42', '2025-04-22 13:30:42'),
(101, 86, 9, '2025-04-22 13:30:42', '2025-04-22 13:30:42'),
(102, 86, 26, '2025-04-22 13:30:42', '2025-04-22 13:30:42'),
(103, 100, 1, '2025-04-22 13:31:12', '2025-04-22 13:31:12'),
(104, 100, 2, '2025-04-22 13:31:12', '2025-04-22 13:31:12'),
(105, 100, 3, '2025-04-22 13:31:12', '2025-04-22 13:31:12'),
(106, 100, 5, '2025-04-22 13:31:12', '2025-04-22 13:31:12'),
(107, 100, 32, '2025-04-22 13:31:12', '2025-04-22 13:31:12'),
(108, 101, 1, '2025-04-22 13:31:14', '2025-04-22 13:31:14'),
(109, 101, 2, '2025-04-22 13:31:14', '2025-04-22 13:31:14'),
(110, 101, 4, '2025-04-22 13:31:14', '2025-04-22 13:31:14'),
(111, 101, 5, '2025-04-22 13:31:14', '2025-04-22 13:31:14'),
(112, 101, 32, '2025-04-22 13:31:14', '2025-04-22 13:31:14'),
(113, 102, 1, '2025-04-22 13:31:15', '2025-04-22 13:31:15'),
(114, 102, 2, '2025-04-22 13:31:15', '2025-04-22 13:31:15'),
(115, 102, 3, '2025-04-22 13:31:15', '2025-04-22 13:31:15'),
(116, 102, 4, '2025-04-22 13:31:15', '2025-04-22 13:31:15'),
(117, 102, 5, '2025-04-22 13:31:15', '2025-04-22 13:31:15'),
(118, 106, 1, '2025-04-22 13:31:21', '2025-04-22 13:31:21'),
(119, 106, 2, '2025-04-22 13:31:21', '2025-04-22 13:31:21'),
(120, 106, 3, '2025-04-22 13:31:21', '2025-04-22 13:31:21'),
(121, 106, 4, '2025-04-22 13:31:21', '2025-04-22 13:31:21'),
(122, 106, 5, '2025-04-22 13:31:21', '2025-04-22 13:31:21'),
(123, 107, 1, '2025-04-22 13:31:22', '2025-04-22 13:31:22'),
(124, 107, 2, '2025-04-22 13:31:22', '2025-04-22 13:31:22'),
(125, 107, 9, '2025-04-22 13:31:22', '2025-04-22 13:31:22'),
(126, 107, 34, '2025-04-22 13:31:22', '2025-04-22 13:31:22'),
(127, 109, 1, '2025-04-22 13:31:25', '2025-04-22 13:31:25'),
(128, 109, 2, '2025-04-22 13:31:25', '2025-04-22 13:31:25'),
(129, 109, 4, '2025-04-22 13:31:26', '2025-04-22 13:31:26'),
(130, 109, 5, '2025-04-22 13:31:25', '2025-04-22 13:31:25'),
(131, 109, 35, '2025-04-22 13:31:26', '2025-04-22 13:31:26'),
(132, 120, 1, '2025-04-22 13:30:58', '2025-04-22 13:30:58'),
(133, 120, 2, '2025-04-22 13:30:58', '2025-04-22 13:30:58'),
(134, 120, 3, '2025-04-22 13:30:58', '2025-04-22 13:30:58'),
(135, 120, 4, '2025-04-22 13:30:58', '2025-04-22 13:30:58'),
(136, 124, 1, '2025-04-22 13:31:04', '2025-04-22 13:31:04'),
(137, 124, 2, '2025-04-22 13:31:04', '2025-04-22 13:31:04'),
(138, 124, 3, '2025-04-22 13:31:04', '2025-04-22 13:31:04'),
(139, 124, 4, '2025-04-22 13:31:04', '2025-04-22 13:31:04'),
(140, 124, 32, '2025-04-22 13:31:04', '2025-04-22 13:31:04'),
(141, 202, 40, '2026-04-19 17:17:39', '2026-04-19 17:17:39'),
(142, 203, 40, '2026-04-19 17:17:39', '2026-04-19 17:17:39'),
(143, 204, 40, '2026-04-19 17:17:39', '2026-04-19 17:17:39'),
(144, 206, 40, '2026-04-19 17:17:39', '2026-04-19 17:17:39');

-- --------------------------------------------------------

--
-- Table structure for table `tracks_releases`
--

CREATE TABLE `tracks_releases` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `track_id` bigint(20) UNSIGNED NOT NULL,
  `release_id` bigint(20) UNSIGNED NOT NULL,
  `track_position` int(10) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `tracks_releases`
--

INSERT INTO `tracks_releases` (`id`, `track_id`, `release_id`, `track_position`, `created_at`, `updated_at`) VALUES
(1, 1, 1, 1, '2025-04-22 13:29:04', '2025-04-22 13:29:04'),
(2, 2, 1, 2, '2025-04-22 13:29:04', '2025-04-22 13:29:04'),
(3, 3, 1, 3, '2025-04-22 13:29:04', '2025-04-22 13:29:04'),
(4, 4, 1, 4, '2025-04-22 13:29:04', '2025-04-22 13:29:04'),
(5, 5, 1, 5, '2025-04-22 13:29:04', '2025-04-22 13:29:04'),
(6, 6, 1, 6, '2025-04-22 13:29:04', '2025-04-22 13:29:04'),
(7, 7, 1, 7, '2025-04-22 13:29:04', '2025-04-22 13:29:04'),
(8, 8, 1, 8, '2025-04-22 13:29:04', '2025-04-22 13:29:04'),
(9, 9, 1, 9, '2025-04-22 13:29:04', '2025-04-22 13:29:04'),
(10, 10, 1, 10, '2025-04-22 13:29:04', '2025-04-22 13:29:04'),
(11, 11, 1, 11, '2025-04-22 13:29:05', '2025-04-22 13:29:05'),
(12, 12, 1, 12, '2025-04-22 13:29:05', '2025-04-22 13:29:05'),
(13, 13, 1, 13, '2025-04-22 13:29:05', '2025-04-22 13:29:05'),
(14, 14, 1, 14, '2025-04-22 13:29:05', '2025-04-22 13:29:05'),
(15, 15, 1, 15, '2025-04-22 13:29:05', '2025-04-22 13:29:05'),
(16, 16, 1, 16, '2025-04-22 13:29:05', '2025-04-22 13:29:05'),
(17, 17, 2, 1, '2025-04-22 13:29:05', '2025-04-22 13:29:05'),
(18, 18, 2, 2, '2025-04-22 13:29:05', '2025-04-22 13:29:05'),
(19, 19, 2, 3, '2025-04-22 13:29:05', '2025-04-22 13:29:05'),
(20, 20, 2, 4, '2025-04-22 13:29:05', '2025-04-22 13:29:05'),
(21, 21, 2, 5, '2025-04-22 13:29:05', '2025-04-22 13:29:05'),
(22, 22, 2, 6, '2025-04-22 13:29:05', '2025-04-22 13:29:05'),
(23, 23, 2, 7, '2025-04-22 13:29:05', '2025-04-22 13:29:05'),
(24, 24, 2, 8, '2025-04-22 13:29:05', '2025-04-22 13:29:05'),
(25, 25, 2, 9, '2025-04-22 13:29:05', '2025-04-22 13:29:05'),
(26, 26, 3, 1, '2025-04-22 13:29:06', '2025-04-22 13:29:06'),
(27, 27, 3, 2, '2025-04-22 13:29:06', '2025-04-22 13:29:06'),
(28, 28, 3, 3, '2025-04-22 13:29:06', '2025-04-22 13:29:06'),
(29, 29, 3, 4, '2025-04-22 13:29:06', '2025-04-22 13:29:06'),
(30, 30, 3, 5, '2025-04-22 13:29:06', '2025-04-22 13:29:06'),
(31, 31, 3, 6, '2025-04-22 13:29:06', '2025-04-22 13:29:06'),
(32, 32, 3, 7, '2025-04-22 13:29:06', '2025-04-22 13:29:06'),
(33, 33, 3, 8, '2025-04-22 13:29:06', '2025-04-22 13:29:06'),
(34, 34, 3, 9, '2025-04-22 13:29:06', '2025-04-22 13:29:06'),
(35, 35, 3, 10, '2025-04-22 13:29:06', '2025-04-22 13:29:06'),
(36, 36, 3, 11, '2025-04-22 13:29:06', '2025-04-22 13:29:06'),
(37, 37, 3, 12, '2025-04-22 13:29:06', '2025-04-22 13:29:06'),
(38, 38, 3, 13, '2025-04-22 13:29:06', '2025-04-22 13:29:06'),
(39, 39, 3, 14, '2025-04-22 13:29:06', '2025-04-22 13:29:06'),
(40, 40, 3, 15, '2025-04-22 13:29:06', '2025-04-22 13:29:06'),
(41, 41, 3, 16, '2025-04-22 13:29:06', '2025-04-22 13:29:06'),
(42, 42, 4, 1, '2025-04-22 13:29:07', '2025-04-22 13:29:07'),
(43, 43, 4, 2, '2025-04-22 13:29:07', '2025-04-22 13:29:07'),
(44, 44, 4, 3, '2025-04-22 13:29:07', '2025-04-22 13:29:07'),
(45, 45, 4, 4, '2025-04-22 13:29:07', '2025-04-22 13:29:07'),
(46, 46, 4, 5, '2025-04-22 13:29:07', '2025-04-22 13:29:07'),
(47, 47, 4, 6, '2025-04-22 13:29:07', '2025-04-22 13:29:07'),
(48, 48, 4, 7, '2025-04-22 13:29:07', '2025-04-22 13:29:07'),
(49, 49, 4, 8, '2025-04-22 13:29:07', '2025-04-22 13:29:07'),
(50, 50, 5, 1, '2025-04-22 13:29:08', '2025-04-22 13:29:08'),
(51, 51, 5, 2, '2025-04-22 13:29:08', '2025-04-22 13:29:08'),
(52, 52, 5, 3, '2025-04-22 13:29:08', '2025-04-22 13:29:08'),
(53, 53, 5, 4, '2025-04-22 13:29:08', '2025-04-22 13:29:08'),
(54, 54, 5, 5, '2025-04-22 13:29:08', '2025-04-22 13:29:08'),
(55, 55, 5, 6, '2025-04-22 13:29:08', '2025-04-22 13:29:08'),
(56, 56, 5, 7, '2025-04-22 13:29:08', '2025-04-22 13:29:08'),
(57, 57, 5, 8, '2025-04-22 13:29:08', '2025-04-22 13:29:08'),
(58, 58, 5, 9, '2025-04-22 13:29:08', '2025-04-22 13:29:08'),
(59, 59, 5, 10, '2025-04-22 13:29:08', '2025-04-22 13:29:08'),
(60, 60, 5, 11, '2025-04-22 13:29:08', '2025-04-22 13:29:08'),
(61, 61, 5, 12, '2025-04-22 13:29:08', '2025-04-22 13:29:08'),
(62, 62, 5, 13, '2025-04-22 13:29:08', '2025-04-22 13:29:08'),
(63, 63, 6, 1, '2025-04-22 13:29:09', '2025-04-22 13:29:09'),
(64, 64, 6, 2, '2025-04-22 13:29:09', '2025-04-22 13:29:09'),
(65, 65, 6, 3, '2025-04-22 13:29:09', '2025-04-22 13:29:09'),
(66, 66, 6, 4, '2025-04-22 13:29:09', '2025-04-22 13:29:09'),
(67, 67, 6, 5, '2025-04-22 13:29:09', '2025-04-22 13:29:09'),
(68, 68, 6, 6, '2025-04-22 13:29:09', '2025-04-22 13:29:09'),
(69, 69, 6, 7, '2025-04-22 13:29:09', '2025-04-22 13:29:09'),
(70, 70, 6, 8, '2025-04-22 13:29:09', '2025-04-22 13:29:09'),
(71, 71, 6, 9, '2025-04-22 13:29:09', '2025-04-22 13:29:09'),
(72, 72, 6, 10, '2025-04-22 13:29:09', '2025-04-22 13:29:09'),
(73, 73, 6, 11, '2025-04-22 13:29:09', '2025-04-22 13:29:09'),
(74, 74, 7, 1, '2025-04-22 13:29:10', '2025-04-22 13:29:10'),
(75, 75, 7, 2, '2025-04-22 13:29:10', '2025-04-22 13:29:10'),
(76, 76, 7, 3, '2025-04-22 13:29:10', '2025-04-22 13:29:10'),
(77, 77, 7, 4, '2025-04-22 13:29:10', '2025-04-22 13:29:10'),
(78, 78, 7, 5, '2025-04-22 13:29:10', '2025-04-22 13:29:10'),
(79, 79, 7, 6, '2025-04-22 13:29:10', '2025-04-22 13:29:10'),
(80, 80, 7, 7, '2025-04-22 13:29:10', '2025-04-22 13:29:10'),
(81, 81, 7, 8, '2025-04-22 13:29:10', '2025-04-22 13:29:10'),
(82, 82, 7, 9, '2025-04-22 13:29:10', '2025-04-22 13:29:10'),
(83, 83, 7, 10, '2025-04-22 13:29:10', '2025-04-22 13:29:10'),
(84, 84, 7, 11, '2025-04-22 13:29:10', '2025-04-22 13:29:10'),
(85, 85, 7, 12, '2025-04-22 13:29:10', '2025-04-22 13:29:10'),
(86, 86, 7, 13, '2025-04-22 13:29:10', '2025-04-22 13:29:10'),
(87, 87, 8, 1, '2025-04-22 13:29:11', '2025-04-22 13:29:11'),
(88, 88, 8, 2, '2025-04-22 13:29:11', '2025-04-22 13:29:11'),
(89, 89, 8, 3, '2025-04-22 13:29:11', '2025-04-22 13:29:11'),
(90, 90, 8, 4, '2025-04-22 13:29:11', '2025-04-22 13:29:11'),
(91, 91, 8, 5, '2025-04-22 13:29:11', '2025-04-22 13:29:11'),
(92, 92, 8, 6, '2025-04-22 13:29:11', '2025-04-22 13:29:11'),
(93, 93, 8, 7, '2025-04-22 13:29:11', '2025-04-22 13:29:11'),
(94, 94, 8, 8, '2025-04-22 13:29:11', '2025-04-22 13:29:11'),
(95, 95, 8, 9, '2025-04-22 13:29:11', '2025-04-22 13:29:11'),
(96, 96, 8, 10, '2025-04-22 13:29:11', '2025-04-22 13:29:11'),
(97, 97, 8, 11, '2025-04-22 13:29:11', '2025-04-22 13:29:11'),
(98, 98, 8, 12, '2025-04-22 13:29:11', '2025-04-22 13:29:11'),
(99, 99, 8, 13, '2025-04-22 13:29:11', '2025-04-22 13:29:11'),
(100, 100, 9, 1, '2025-04-22 13:29:12', '2025-04-22 13:29:12'),
(101, 101, 9, 2, '2025-04-22 13:29:12', '2025-04-22 13:29:12'),
(102, 102, 9, 3, '2025-04-22 13:29:12', '2025-04-22 13:29:12'),
(103, 103, 9, 4, '2025-04-22 13:29:12', '2025-04-22 13:29:12'),
(104, 104, 9, 5, '2025-04-22 13:29:12', '2025-04-22 13:29:12'),
(105, 105, 9, 6, '2025-04-22 13:29:12', '2025-04-22 13:29:12'),
(106, 106, 9, 7, '2025-04-22 13:29:12', '2025-04-22 13:29:12'),
(107, 107, 9, 8, '2025-04-22 13:29:12', '2025-04-22 13:29:12'),
(108, 108, 9, 9, '2025-04-22 13:29:12', '2025-04-22 13:29:12'),
(109, 109, 9, 10, '2025-04-22 13:29:12', '2025-04-22 13:29:12'),
(110, 110, 9, 11, '2025-04-22 13:29:12', '2025-04-22 13:29:12'),
(111, 111, 9, 12, '2025-04-22 13:29:12', '2025-04-22 13:29:12'),
(112, 112, 9, 13, '2025-04-22 13:29:12', '2025-04-22 13:29:12'),
(113, 113, 9, 14, '2025-04-22 13:29:12', '2025-04-22 13:29:12'),
(114, 114, 9, 15, '2025-04-22 13:29:12', '2025-04-22 13:29:12'),
(115, 115, 9, 16, '2025-04-22 13:29:12', '2025-04-22 13:29:12'),
(116, 116, 9, 17, '2025-04-22 13:29:12', '2025-04-22 13:29:12'),
(117, 117, 9, 18, '2025-04-22 13:29:12', '2025-04-22 13:29:12'),
(118, 118, 9, 19, '2025-04-22 13:29:12', '2025-04-22 13:29:12'),
(119, 119, 9, 20, '2025-04-22 13:29:12', '2025-04-22 13:29:12'),
(120, 100, 10, 1, '2025-04-22 13:29:13', '2025-04-22 13:29:13'),
(121, 101, 10, 2, '2025-04-22 13:29:13', '2025-04-22 13:29:13'),
(122, 102, 10, 3, '2025-04-22 13:29:13', '2025-04-22 13:29:13'),
(123, 103, 10, 4, '2025-04-22 13:29:13', '2025-04-22 13:29:13'),
(124, 104, 10, 5, '2025-04-22 13:29:13', '2025-04-22 13:29:13'),
(125, 105, 10, 6, '2025-04-22 13:29:13', '2025-04-22 13:29:13'),
(126, 106, 10, 7, '2025-04-22 13:29:13', '2025-04-22 13:29:13'),
(127, 107, 10, 8, '2025-04-22 13:29:13', '2025-04-22 13:29:13'),
(128, 108, 10, 9, '2025-04-22 13:29:13', '2025-04-22 13:29:13'),
(129, 109, 10, 10, '2025-04-22 13:29:13', '2025-04-22 13:29:13'),
(130, 120, 11, 1, '2025-04-22 13:29:14', '2025-04-22 13:29:14'),
(131, 121, 11, 2, '2025-04-22 13:29:14', '2025-04-22 13:29:14'),
(132, 122, 11, 3, '2025-04-22 13:29:14', '2025-04-22 13:29:14'),
(133, 123, 11, 4, '2025-04-22 13:29:14', '2025-04-22 13:29:14'),
(134, 124, 11, 5, '2025-04-22 13:29:14', '2025-04-22 13:29:14'),
(135, 125, 11, 6, '2025-04-22 13:29:14', '2025-04-22 13:29:14'),
(136, 126, 11, 7, '2025-04-22 13:29:14', '2025-04-22 13:29:14'),
(137, 127, 11, 8, '2025-04-22 13:29:14', '2025-04-22 13:29:14'),
(138, 128, 11, 9, '2025-04-22 13:29:14', '2025-04-22 13:29:14'),
(139, 129, 11, 10, '2025-04-22 13:29:14', '2025-04-22 13:29:14'),
(142, 3, 13, 1, '2025-04-22 13:29:15', '2025-04-22 13:29:15'),
(143, 6, 14, 1, '2025-04-22 13:29:16', '2025-04-22 13:29:16'),
(144, 132, 15, 1, '2025-04-22 13:29:17', '2025-04-22 13:29:17'),
(145, 133, 16, 1, '2025-04-22 13:29:17', '2025-04-22 13:29:17'),
(146, 134, 17, 1, '2025-04-22 13:29:18', '2025-04-22 13:29:18'),
(147, 13, 18, 1, '2025-04-22 13:29:19', '2025-04-22 13:29:19'),
(148, 135, 19, 1, '2025-04-22 13:29:19', '2025-04-22 13:29:19'),
(149, 10, 20, 1, '2025-04-22 13:29:20', '2025-04-22 13:29:20'),
(150, 11, 21, 1, '2025-04-22 13:29:21', '2025-04-22 13:29:21'),
(151, 136, 22, 1, '2025-04-22 13:29:22', '2025-04-22 13:29:22'),
(152, 137, 22, 2, '2025-04-22 13:29:22', '2025-04-22 13:29:22'),
(153, 138, 22, 3, '2025-04-22 13:29:22', '2025-04-22 13:29:22'),
(154, 138, 23, 1, '2025-04-22 13:29:22', '2025-04-22 13:29:22'),
(155, 139, 24, 1, '2025-04-22 13:29:23', '2025-04-22 13:29:23'),
(156, 140, 25, 1, '2025-04-22 13:29:24', '2025-04-22 13:29:24'),
(157, 141, 26, 1, '2025-04-22 13:29:25', '2025-04-22 13:29:25'),
(158, 142, 27, 1, '2025-04-22 13:29:25', '2025-04-22 13:29:25'),
(159, 143, 28, 1, '2025-04-22 13:29:26', '2025-04-22 13:29:26'),
(160, 144, 29, 1, '2025-04-22 13:29:27', '2025-04-22 13:29:27'),
(161, 15, 30, 1, '2025-04-22 13:29:27', '2025-04-22 13:29:27'),
(162, 145, 31, 1, '2025-04-22 13:29:28', '2025-04-22 13:29:28'),
(163, 146, 32, 1, '2025-04-22 13:29:29', '2025-04-22 13:29:29'),
(164, 19, 33, 1, '2025-04-22 13:29:30', '2025-04-22 13:29:30'),
(165, 20, 34, 1, '2025-04-22 13:29:30', '2025-04-22 13:29:30'),
(166, 18, 35, 1, '2025-04-22 13:29:31', '2025-04-22 13:29:31'),
(167, 24, 36, 1, '2025-04-22 13:29:32', '2025-04-22 13:29:32'),
(168, 147, 37, 1, '2025-04-22 13:29:32', '2025-04-22 13:29:32'),
(169, 148, 12, 1, '2025-04-22 13:29:33', '2025-04-22 13:29:33'),
(170, 149, 12, 2, '2025-04-22 13:29:33', '2025-04-22 13:29:33'),
(171, 150, 38, 1, '2025-04-22 13:29:34', '2025-04-22 13:29:34'),
(172, 52, 39, 1, '2025-04-22 13:29:35', '2025-04-22 13:29:35'),
(173, 60, 40, 1, '2025-04-22 13:29:35', '2025-04-22 13:29:35'),
(174, 56, 41, 1, '2025-04-22 13:29:36', '2025-04-22 13:29:36'),
(175, 54, 42, 1, '2025-04-22 13:29:37', '2025-04-22 13:29:37'),
(176, 51, 43, 1, '2025-04-22 13:29:37', '2025-04-22 13:29:37'),
(177, 151, 44, 1, '2025-04-22 13:29:38', '2025-04-22 13:29:38'),
(178, 152, 45, 1, '2025-04-22 13:29:39', '2025-04-22 13:29:39'),
(179, 74, 46, 1, '2025-04-22 13:29:39', '2025-04-22 13:29:39'),
(180, 153, 46, 2, '2025-04-22 13:29:40', '2025-04-22 13:29:40'),
(181, 154, 46, 3, '2025-04-22 13:29:40', '2025-04-22 13:29:40'),
(182, 77, 47, 1, '2025-04-22 13:29:40', '2025-04-22 13:29:40'),
(183, 155, 47, 2, '2025-04-22 13:29:40', '2025-04-22 13:29:40'),
(184, 156, 48, 1, '2025-04-22 13:29:41', '2025-04-22 13:29:41'),
(185, 157, 48, 2, '2025-04-22 13:29:41', '2025-04-22 13:29:41'),
(186, 158, 48, 3, '2025-04-22 13:29:41', '2025-04-22 13:29:41'),
(187, 159, 48, 4, '2025-04-22 13:29:41', '2025-04-22 13:29:41'),
(188, 159, 49, 1, '2025-04-22 13:29:42', '2025-04-22 13:29:42'),
(189, 120, 49, 2, '2025-04-22 13:29:42', '2025-04-22 13:29:42'),
(190, 106, 49, 3, '2025-04-22 13:29:42', '2025-04-22 13:29:42'),
(191, 160, 49, 4, '2025-04-22 13:29:42', '2025-04-22 13:29:42'),
(192, 101, 49, 5, '2025-04-22 13:29:42', '2025-04-22 13:29:42'),
(193, 100, 49, 6, '2025-04-22 13:29:42', '2025-04-22 13:29:42'),
(194, 97, 49, 7, '2025-04-22 13:29:42', '2025-04-22 13:29:42'),
(195, 89, 49, 8, '2025-04-22 13:29:42', '2025-04-22 13:29:42'),
(196, 161, 49, 9, '2025-04-22 13:29:42', '2025-04-22 13:29:42'),
(197, 162, 49, 10, '2025-04-22 13:29:42', '2025-04-22 13:29:42'),
(198, 79, 49, 11, '2025-04-22 13:29:42', '2025-04-22 13:29:42'),
(199, 78, 49, 12, '2025-04-22 13:29:42', '2025-04-22 13:29:42'),
(200, 74, 49, 13, '2025-04-22 13:29:42', '2025-04-22 13:29:42'),
(201, 77, 49, 14, '2025-04-22 13:29:42', '2025-04-22 13:29:42'),
(202, 82, 49, 15, '2025-04-22 13:29:42', '2025-04-22 13:29:42'),
(204, 164, 50, 2, '2025-04-27 01:21:34', '2025-04-27 01:21:34'),
(205, 165, 50, 3, '2025-04-27 01:21:34', '2025-04-27 01:21:34'),
(206, 166, 50, 4, '2025-04-27 01:21:34', '2025-04-27 01:21:34'),
(207, 167, 50, 5, '2025-04-27 01:21:34', '2025-04-27 01:21:34'),
(208, 168, 50, 6, '2025-04-27 01:21:34', '2025-04-27 01:21:34'),
(209, 169, 50, 7, '2025-04-27 01:21:34', '2025-04-27 01:21:34'),
(210, 170, 50, 8, '2025-04-27 01:21:34', '2025-04-27 01:21:34'),
(211, 171, 50, 9, '2025-04-27 01:21:34', '2025-04-27 01:21:34'),
(212, 172, 50, 10, '2025-04-27 01:21:34', '2025-04-27 01:21:34'),
(213, 173, 50, 11, '2025-04-27 01:21:34', '2025-04-27 01:21:34'),
(215, 175, 51, 1, '2025-04-27 01:21:35', '2025-04-27 01:21:35'),
(216, 176, 51, 2, '2025-04-27 01:21:35', '2025-04-27 01:21:35'),
(217, 177, 51, 3, '2025-04-27 01:21:35', '2025-04-27 01:21:35'),
(218, 178, 51, 4, '2025-04-27 01:21:35', '2025-04-27 01:21:35'),
(219, 179, 51, 5, '2025-04-27 01:21:35', '2025-04-27 01:21:35'),
(220, 180, 51, 6, '2025-04-27 01:21:35', '2025-04-27 01:21:35'),
(221, 181, 51, 7, '2025-04-27 01:21:35', '2025-04-27 01:21:35'),
(222, 182, 51, 8, '2025-04-27 01:21:35', '2025-04-27 01:21:35'),
(223, 183, 51, 9, '2025-04-27 01:21:35', '2025-04-27 01:21:35'),
(224, 184, 51, 10, '2025-04-27 01:21:35', '2025-04-27 01:21:35'),
(225, 185, 52, 1, '2025-04-27 01:21:36', '2025-04-27 01:21:36'),
(226, 186, 53, 1, '2025-04-27 01:21:37', '2025-04-27 01:21:37'),
(227, 187, 54, 1, '2025-04-27 01:21:38', '2025-04-27 01:21:38'),
(228, 188, 55, 1, '2025-04-27 01:21:38', '2025-04-27 01:21:38'),
(229, 189, 56, 1, '2025-04-27 01:21:39', '2025-04-27 01:21:39'),
(230, 190, 56, 2, '2025-04-27 01:21:39', '2025-04-27 01:21:39'),
(231, 191, 56, 3, '2025-04-27 01:21:39', '2025-04-27 01:21:39'),
(232, 192, 56, 4, '2025-04-27 01:21:39', '2025-04-27 01:21:39'),
(233, 191, 57, 1, '2025-04-27 01:21:40', '2025-04-27 01:21:40'),
(234, 190, 58, 1, '2025-04-27 01:21:41', '2025-04-27 01:21:41'),
(236, 193, 60, 1, '2025-04-27 01:21:42', '2025-04-27 01:21:42'),
(238, 194, 61, 1, '2025-04-27 01:21:44', '2025-04-27 01:21:44'),
(239, 195, 61, 2, '2025-04-27 01:21:44', '2025-04-27 01:21:44'),
(240, 196, 61, 3, '2025-04-27 01:21:44', '2025-04-27 01:21:44'),
(241, 166, 62, 1, '2025-04-27 01:21:44', '2025-04-27 01:21:44'),
(242, 165, 63, 1, '2025-04-27 01:21:45', '2025-04-27 01:21:45'),
(243, 174, 50, 1, '2025-04-27 01:21:46', '2025-04-27 01:21:46'),
(244, 164, 59, 1, '2025-04-27 01:21:47', '2025-04-27 01:21:47'),
(245, 197, 64, 1, '2025-04-27 01:21:47', '2025-04-27 01:21:47'),
(246, 198, 64, 2, '2025-04-27 01:21:47', '2025-04-27 01:21:47'),
(247, 199, 64, 3, '2025-04-27 01:21:47', '2025-04-27 01:21:47'),
(248, 200, 64, 4, '2025-04-27 01:21:47', '2025-04-27 01:21:47'),
(249, 201, 64, 5, '2025-04-27 01:21:47', '2025-04-27 01:21:47'),
(250, 202, 65, 1, '2025-04-27 01:21:50', '2025-04-27 01:21:50'),
(251, 203, 65, 2, '2025-04-27 01:21:50', '2025-04-27 01:21:50'),
(252, 204, 65, 3, '2025-04-27 01:21:50', '2025-04-27 01:21:50'),
(253, 205, 65, 4, '2025-04-27 01:21:50', '2025-04-27 01:21:50'),
(254, 206, 65, 5, '2025-04-27 01:21:50', '2025-04-27 01:21:50'),
(255, 207, 65, 6, '2025-04-27 01:21:50', '2025-04-27 01:21:50'),
(256, 208, 65, 7, '2025-04-27 01:21:50', '2025-04-27 01:21:50'),
(257, 209, 65, 8, '2025-04-27 01:21:50', '2025-04-27 01:21:50'),
(258, 210, 66, 1, '2025-04-27 01:21:51', '2025-04-27 01:21:51'),
(259, 211, 66, 2, '2025-04-27 01:21:51', '2025-04-27 01:21:51'),
(260, 212, 66, 3, '2025-04-27 01:21:51', '2025-04-27 01:21:51'),
(261, 213, 66, 4, '2025-04-27 01:21:51', '2025-04-27 01:21:51'),
(262, 214, 66, 5, '2025-04-27 01:21:51', '2025-04-27 01:21:51'),
(263, 215, 66, 6, '2025-04-27 01:21:51', '2025-04-27 01:21:51'),
(264, 216, 66, 7, '2025-04-27 01:21:51', '2025-04-27 01:21:51'),
(265, 217, 66, 8, '2025-04-27 01:21:51', '2025-04-27 01:21:51'),
(266, 218, 67, 1, '2025-04-27 01:21:52', '2025-04-27 01:21:52'),
(267, 219, 67, 2, '2025-04-27 01:21:52', '2025-04-27 01:21:52'),
(268, 220, 67, 3, '2025-04-27 01:21:52', '2025-04-27 01:21:52'),
(269, 221, 67, 4, '2025-04-27 01:21:52', '2025-04-27 01:21:52'),
(270, 222, 67, 5, '2025-04-27 01:21:52', '2025-04-27 01:21:52'),
(271, 223, 67, 6, '2025-04-27 01:21:52', '2025-04-27 01:21:52'),
(272, 224, 67, 7, '2025-04-27 01:21:52', '2025-04-27 01:21:52'),
(273, 225, 67, 8, '2025-04-27 01:21:52', '2025-04-27 01:21:52'),
(274, 226, 67, 9, '2025-04-27 01:21:52', '2025-04-27 01:21:52'),
(275, 227, 67, 10, '2025-04-27 01:21:52', '2025-04-27 01:21:52'),
(276, 228, 67, 11, '2025-04-27 01:21:52', '2025-04-27 01:21:52'),
(277, 229, 67, 12, '2025-04-27 01:21:52', '2025-04-27 01:21:52'),
(278, 230, 67, 13, '2025-04-27 01:21:52', '2025-04-27 01:21:52'),
(279, 231, 68, 1, '2025-04-27 01:21:53', '2025-04-27 01:21:53'),
(280, 232, 68, 2, '2025-04-27 01:21:53', '2025-04-27 01:21:53'),
(281, 233, 68, 3, '2025-04-27 01:21:53', '2025-04-27 01:21:53'),
(282, 234, 68, 4, '2025-04-27 01:21:53', '2025-04-27 01:21:53'),
(283, 235, 68, 5, '2025-04-27 01:21:53', '2025-04-27 01:21:53'),
(284, 236, 68, 6, '2025-04-27 01:21:53', '2025-04-27 01:21:53'),
(285, 237, 68, 7, '2025-04-27 01:21:53', '2025-04-27 01:21:53'),
(286, 238, 68, 8, '2025-04-27 01:21:53', '2025-04-27 01:21:53'),
(287, 239, 68, 9, '2025-04-27 01:21:53', '2025-04-27 01:21:53'),
(288, 240, 68, 10, '2025-04-27 01:21:53', '2025-04-27 01:21:53'),
(289, 241, 68, 11, '2025-04-27 01:21:53', '2025-04-27 01:21:53'),
(290, 242, 68, 12, '2025-04-27 01:21:53', '2025-04-27 01:21:53'),
(291, 243, 68, 13, '2025-04-27 01:21:53', '2025-04-27 01:21:53'),
(292, 244, 69, 1, '2025-04-27 01:21:54', '2025-04-27 01:21:54'),
(293, 245, 69, 2, '2025-04-27 01:21:54', '2025-04-27 01:21:54'),
(294, 246, 69, 3, '2025-04-27 01:21:54', '2025-04-27 01:21:54'),
(295, 247, 69, 4, '2025-04-27 01:21:54', '2025-04-27 01:21:54'),
(296, 248, 69, 5, '2025-04-27 01:21:54', '2025-04-27 01:21:54'),
(297, 249, 69, 6, '2025-04-27 01:21:54', '2025-04-27 01:21:54'),
(298, 250, 69, 7, '2025-04-27 01:21:54', '2025-04-27 01:21:54'),
(299, 251, 69, 8, '2025-04-27 01:21:54', '2025-04-27 01:21:54'),
(300, 252, 69, 9, '2025-04-27 01:21:54', '2025-04-27 01:21:54'),
(301, 253, 69, 10, '2025-04-27 01:21:54', '2025-04-27 01:21:54'),
(302, 254, 69, 11, '2025-04-27 01:21:54', '2025-04-27 01:21:54'),
(303, 207, 70, 1, '2025-04-27 01:21:55', '2025-04-27 01:21:55'),
(304, 208, 71, 1, '2025-04-27 01:21:55', '2025-04-27 01:21:55'),
(305, 209, 72, 1, '2025-04-27 01:21:56', '2025-04-27 01:21:56'),
(306, 255, 73, 1, '2025-04-27 01:21:57', '2025-04-27 01:21:57'),
(307, 256, 74, 1, '2025-04-27 01:21:58', '2025-04-27 01:21:58'),
(308, 257, 75, 1, '2025-04-27 01:21:58', '2025-04-27 01:21:58'),
(309, 258, 76, 1, '2025-04-27 01:21:59', '2025-04-27 01:21:59'),
(310, 214, 77, 1, '2025-04-27 01:22:00', '2025-04-27 01:22:00'),
(311, 259, 78, 1, '2025-04-27 01:22:01', '2025-04-27 01:22:01'),
(312, 212, 79, 1, '2025-04-27 01:22:01', '2025-04-27 01:22:01'),
(313, 260, 80, 1, '2025-04-27 01:22:02', '2025-04-27 01:22:02'),
(314, 261, 81, 1, '2025-04-27 01:22:03', '2025-04-27 01:22:03'),
(315, 262, 82, 1, '2025-04-27 01:22:03', '2025-04-27 01:22:03'),
(316, 263, 83, 1, '2025-04-27 01:22:04', '2025-04-27 01:22:04'),
(317, 264, 84, 1, '2025-04-27 01:22:05', '2025-04-27 01:22:05'),
(318, 265, 85, 1, '2025-04-27 01:22:06', '2025-04-27 01:22:06'),
(319, 266, 86, 1, '2025-04-27 01:22:06', '2025-04-27 01:22:06'),
(320, 267, 87, 1, '2025-04-27 01:22:07', '2025-04-27 01:22:07'),
(321, 268, 88, 1, '2025-04-27 01:22:08', '2025-04-27 01:22:08'),
(322, 237, 89, 1, '2025-04-27 01:22:09', '2025-04-27 01:22:09'),
(323, 269, 90, 1, '2025-04-27 01:22:09', '2025-04-27 01:22:09'),
(324, 270, 91, 1, '2025-04-27 01:22:12', '2025-04-27 01:22:12'),
(325, 271, 91, 2, '2025-04-27 01:22:12', '2025-04-27 01:22:12'),
(326, 272, 91, 3, '2025-04-27 01:22:12', '2025-04-27 01:22:12'),
(327, 273, 91, 4, '2025-04-27 01:22:12', '2025-04-27 01:22:12'),
(328, 274, 91, 5, '2025-04-27 01:22:12', '2025-04-27 01:22:12'),
(329, 275, 91, 6, '2025-04-27 01:22:12', '2025-04-27 01:22:12'),
(330, 276, 91, 7, '2025-04-27 01:22:12', '2025-04-27 01:22:12'),
(331, 277, 91, 8, '2025-04-27 01:22:12', '2025-04-27 01:22:12'),
(332, 278, 91, 9, '2025-04-27 01:22:12', '2025-04-27 01:22:12'),
(333, 279, 92, 1, '2025-04-27 01:22:12', '2025-04-27 01:22:12'),
(334, 280, 92, 2, '2025-04-27 01:22:12', '2025-04-27 01:22:12'),
(335, 281, 92, 3, '2025-04-27 01:22:12', '2025-04-27 01:22:12'),
(336, 282, 92, 4, '2025-04-27 01:22:12', '2025-04-27 01:22:12'),
(337, 283, 92, 5, '2025-04-27 01:22:12', '2025-04-27 01:22:12'),
(338, 284, 92, 6, '2025-04-27 01:22:12', '2025-04-27 01:22:12'),
(339, 285, 92, 7, '2025-04-27 01:22:12', '2025-04-27 01:22:12'),
(340, 286, 92, 8, '2025-04-27 01:22:12', '2025-04-27 01:22:12'),
(341, 287, 92, 9, '2025-04-27 01:22:13', '2025-04-27 01:22:13'),
(342, 288, 92, 10, '2025-04-27 01:22:13', '2025-04-27 01:22:13'),
(343, 289, 92, 11, '2025-04-27 01:22:13', '2025-04-27 01:22:13'),
(344, 290, 92, 12, '2025-04-27 01:22:13', '2025-04-27 01:22:13'),
(345, 291, 92, 13, '2025-04-27 01:22:13', '2025-04-27 01:22:13'),
(346, 292, 92, 14, '2025-04-27 01:22:13', '2025-04-27 01:22:13'),
(347, 293, 92, 15, '2025-04-27 01:22:13', '2025-04-27 01:22:13'),
(348, 294, 92, 16, '2025-04-27 01:22:13', '2025-04-27 01:22:13'),
(349, 295, 92, 17, '2025-04-27 01:22:13', '2025-04-27 01:22:13'),
(350, 296, 92, 18, '2025-04-27 01:22:13', '2025-04-27 01:22:13'),
(351, 297, 92, 19, '2025-04-27 01:22:13', '2025-04-27 01:22:13'),
(352, 298, 92, 20, '2025-04-27 01:22:13', '2025-04-27 01:22:13'),
(353, 299, 93, 1, '2025-04-27 01:22:13', '2025-04-27 01:22:13'),
(354, 300, 93, 2, '2025-04-27 01:22:14', '2025-04-27 01:22:14'),
(355, 301, 93, 3, '2025-04-27 01:22:14', '2025-04-27 01:22:14'),
(356, 302, 93, 4, '2025-04-27 01:22:14', '2025-04-27 01:22:14'),
(357, 303, 93, 5, '2025-04-27 01:22:14', '2025-04-27 01:22:14'),
(358, 304, 93, 6, '2025-04-27 01:22:14', '2025-04-27 01:22:14'),
(359, 305, 93, 7, '2025-04-27 01:22:14', '2025-04-27 01:22:14'),
(360, 306, 93, 8, '2025-04-27 01:22:14', '2025-04-27 01:22:14'),
(361, 307, 93, 9, '2025-04-27 01:22:14', '2025-04-27 01:22:14'),
(362, 308, 93, 10, '2025-04-27 01:22:14', '2025-04-27 01:22:14'),
(363, 309, 93, 11, '2025-04-27 01:22:14', '2025-04-27 01:22:14'),
(364, 310, 93, 12, '2025-04-27 01:22:14', '2025-04-27 01:22:14'),
(365, 311, 93, 13, '2025-04-27 01:22:14', '2025-04-27 01:22:14'),
(366, 312, 93, 14, '2025-04-27 01:22:14', '2025-04-27 01:22:14'),
(367, 313, 93, 15, '2025-04-27 01:22:14', '2025-04-27 01:22:14'),
(368, 314, 93, 16, '2025-04-27 01:22:14', '2025-04-27 01:22:14'),
(369, 315, 93, 17, '2025-04-27 01:22:14', '2025-04-27 01:22:14'),
(370, 316, 93, 18, '2025-04-27 01:22:14', '2025-04-27 01:22:14'),
(371, 317, 93, 19, '2025-04-27 01:22:14', '2025-04-27 01:22:14'),
(372, 318, 93, 20, '2025-04-27 01:22:14', '2025-04-27 01:22:14'),
(373, 319, 94, 1, '2025-04-27 01:22:14', '2025-04-27 01:22:14'),
(374, 320, 94, 2, '2025-04-27 01:22:15', '2025-04-27 01:22:15'),
(375, 321, 94, 3, '2025-04-27 01:22:15', '2025-04-27 01:22:15'),
(376, 322, 94, 4, '2025-04-27 01:22:15', '2025-04-27 01:22:15'),
(377, 323, 94, 5, '2025-04-27 01:22:15', '2025-04-27 01:22:15'),
(378, 324, 94, 6, '2025-04-27 01:22:15', '2025-04-27 01:22:15'),
(379, 325, 94, 7, '2025-04-27 01:22:15', '2025-04-27 01:22:15'),
(380, 326, 94, 8, '2025-04-27 01:22:15', '2025-04-27 01:22:15'),
(381, 327, 94, 9, '2025-04-27 01:22:15', '2025-04-27 01:22:15'),
(382, 328, 94, 10, '2025-04-27 01:22:15', '2025-04-27 01:22:15'),
(383, 329, 94, 11, '2025-04-27 01:22:15', '2025-04-27 01:22:15'),
(384, 330, 95, 1, '2025-04-27 01:22:15', '2025-04-27 01:22:15'),
(385, 331, 95, 2, '2025-04-27 01:22:15', '2025-04-27 01:22:15'),
(386, 332, 95, 3, '2025-04-27 01:22:15', '2025-04-27 01:22:15'),
(387, 333, 95, 4, '2025-04-27 01:22:15', '2025-04-27 01:22:15'),
(388, 334, 95, 5, '2025-04-27 01:22:16', '2025-04-27 01:22:16'),
(389, 335, 95, 6, '2025-04-27 01:22:16', '2025-04-27 01:22:16'),
(390, 336, 95, 7, '2025-04-27 01:22:16', '2025-04-27 01:22:16'),
(391, 337, 95, 8, '2025-04-27 01:22:16', '2025-04-27 01:22:16'),
(392, 338, 95, 9, '2025-04-27 01:22:16', '2025-04-27 01:22:16'),
(393, 339, 95, 10, '2025-04-27 01:22:16', '2025-04-27 01:22:16'),
(394, 6, 95, 11, '2025-04-27 01:22:16', '2025-04-27 01:22:16'),
(395, 340, 95, 12, '2025-04-27 01:22:16', '2025-04-27 01:22:16'),
(396, 341, 95, 13, '2025-04-27 01:22:16', '2025-04-27 01:22:16'),
(397, 342, 95, 14, '2025-04-27 01:22:16', '2025-04-27 01:22:16'),
(398, 343, 96, 1, '2025-04-27 01:22:17', '2025-04-27 01:22:17'),
(399, 344, 96, 2, '2025-04-27 01:22:17', '2025-04-27 01:22:17'),
(400, 345, 96, 3, '2025-04-27 01:22:17', '2025-04-27 01:22:17'),
(401, 346, 96, 4, '2025-04-27 01:22:17', '2025-04-27 01:22:17'),
(402, 347, 96, 5, '2025-04-27 01:22:17', '2025-04-27 01:22:17'),
(403, 348, 96, 6, '2025-04-27 01:22:17', '2025-04-27 01:22:17'),
(404, 349, 96, 7, '2025-04-27 01:22:17', '2025-04-27 01:22:17'),
(405, 350, 96, 8, '2025-04-27 01:22:17', '2025-04-27 01:22:17'),
(406, 351, 96, 9, '2025-04-27 01:22:17', '2025-04-27 01:22:17'),
(407, 352, 96, 10, '2025-04-27 01:22:17', '2025-04-27 01:22:17'),
(408, 353, 96, 11, '2025-04-27 01:22:17', '2025-04-27 01:22:17'),
(409, 354, 96, 12, '2025-04-27 01:22:17', '2025-04-27 01:22:17'),
(410, 355, 96, 13, '2025-04-27 01:22:17', '2025-04-27 01:22:17'),
(411, 356, 96, 14, '2025-04-27 01:22:17', '2025-04-27 01:22:17'),
(412, 357, 97, 1, '2025-04-27 01:22:17', '2025-04-27 01:22:17'),
(413, 358, 98, 1, '2025-04-27 01:22:18', '2025-04-27 01:22:18'),
(414, 359, 99, 1, '2025-04-27 01:22:19', '2025-04-27 01:22:19'),
(415, 360, 100, 1, '2025-04-27 01:22:20', '2025-04-27 01:22:20'),
(416, 361, 101, 1, '2025-04-27 01:22:21', '2025-04-27 01:22:21'),
(417, 362, 102, 1, '2025-04-27 01:22:21', '2025-04-27 01:22:21'),
(418, 363, 103, 1, '2025-04-27 01:22:22', '2025-04-27 01:22:22'),
(419, 364, 104, 1, '2025-04-27 01:22:23', '2025-04-27 01:22:23'),
(420, 365, 105, 1, '2025-04-27 01:22:24', '2025-04-27 01:22:24'),
(421, 366, 106, 1, '2025-04-27 01:22:24', '2025-04-27 01:22:24'),
(422, 367, 107, 1, '2025-04-27 01:22:25', '2025-04-27 01:22:25'),
(423, 368, 108, 1, '2025-04-27 01:22:26', '2025-04-27 01:22:26'),
(424, 369, 109, 1, '2025-04-27 01:22:26', '2025-04-27 01:22:26'),
(425, 370, 110, 1, '2025-04-27 01:22:27', '2025-04-27 01:22:27'),
(426, 318, 111, 1, '2025-04-27 01:22:28', '2025-04-27 01:22:28'),
(427, 371, 112, 1, '2025-04-27 01:22:29', '2025-04-27 01:22:29'),
(428, 372, 113, 1, '2025-04-27 01:22:29', '2025-04-27 01:22:29'),
(429, 373, 114, 1, '2025-04-27 01:22:30', '2025-04-27 01:22:30'),
(430, 374, 115, 1, '2025-04-27 01:22:31', '2025-04-27 01:22:31'),
(431, 375, 116, 1, '2025-04-27 01:22:32', '2025-04-27 01:22:32'),
(432, 376, 117, 1, '2025-04-27 01:22:32', '2025-04-27 01:22:32'),
(433, 307, 118, 1, '2025-04-27 01:22:33', '2025-04-27 01:22:33'),
(434, 377, 119, 1, '2025-04-27 01:22:34', '2025-04-27 01:22:34'),
(435, 378, 120, 1, '2025-04-27 01:22:35', '2025-04-27 01:22:35'),
(436, 314, 121, 1, '2025-04-27 01:22:35', '2025-04-27 01:22:35'),
(437, 304, 122, 1, '2025-04-27 01:22:36', '2025-04-27 01:22:36'),
(438, 379, 123, 1, '2025-04-27 01:22:37', '2025-04-27 01:22:37'),
(439, 380, 124, 1, '2025-04-27 01:22:38', '2025-04-27 01:22:38'),
(440, 381, 124, 2, '2025-04-27 01:22:38', '2025-04-27 01:22:38'),
(441, 382, 124, 3, '2025-04-27 01:22:38', '2025-04-27 01:22:38'),
(442, 383, 124, 4, '2025-04-27 01:22:38', '2025-04-27 01:22:38'),
(443, 384, 125, 1, '2025-04-27 01:22:38', '2025-04-27 01:22:38'),
(444, 386, 126, 1, '2025-05-29 06:10:12', '2025-05-29 06:10:12'),
(445, 387, 126, 2, '2025-05-29 06:10:12', '2025-05-29 06:10:12'),
(446, 388, 126, 3, '2025-05-29 06:10:12', '2025-05-29 06:10:12'),
(447, 389, 126, 4, '2025-05-29 06:10:12', '2025-05-29 06:10:12'),
(448, 390, 126, 5, '2025-05-29 06:10:12', '2025-05-29 06:10:12'),
(449, 391, 126, 6, '2025-05-29 06:10:12', '2025-05-29 06:10:12'),
(450, 392, 126, 7, '2025-05-29 06:10:12', '2025-05-29 06:10:12'),
(451, 393, 126, 8, '2025-05-29 06:10:12', '2025-05-29 06:10:12'),
(452, 394, 126, 9, '2025-05-29 06:10:12', '2025-05-29 06:10:12'),
(453, 395, 126, 10, '2025-05-29 06:10:12', '2025-05-29 06:10:12'),
(454, 396, 126, 11, '2025-05-29 06:10:12', '2025-05-29 06:10:12'),
(455, 397, 126, 12, '2025-05-29 06:10:12', '2025-05-29 06:10:12'),
(456, 398, 126, 13, '2025-05-29 06:10:12', '2025-05-29 06:10:12'),
(457, 399, 127, 1, '2025-05-29 06:10:13', '2025-05-29 06:10:13'),
(458, 400, 127, 2, '2025-05-29 06:10:13', '2025-05-29 06:10:13'),
(459, 401, 127, 3, '2025-05-29 06:10:13', '2025-05-29 06:10:13'),
(460, 402, 127, 4, '2025-05-29 06:10:13', '2025-05-29 06:10:13'),
(461, 403, 127, 5, '2025-05-29 06:10:13', '2025-05-29 06:10:13'),
(462, 404, 127, 6, '2025-05-29 06:10:13', '2025-05-29 06:10:13'),
(463, 405, 127, 7, '2025-05-29 06:10:13', '2025-05-29 06:10:13'),
(464, 406, 128, 1, '2025-05-29 06:10:13', '2025-05-29 06:10:13'),
(465, 407, 128, 2, '2025-05-29 06:10:13', '2025-05-29 06:10:13'),
(466, 408, 128, 3, '2025-05-29 06:10:14', '2025-05-29 06:10:14'),
(467, 409, 128, 4, '2025-05-29 06:10:14', '2025-05-29 06:10:14'),
(468, 410, 128, 5, '2025-05-29 06:10:14', '2025-05-29 06:10:14'),
(469, 411, 128, 6, '2025-05-29 06:10:14', '2025-05-29 06:10:14'),
(470, 412, 128, 7, '2025-05-29 06:10:14', '2025-05-29 06:10:14'),
(471, 413, 128, 8, '2025-05-29 06:10:14', '2025-05-29 06:10:14'),
(472, 414, 128, 9, '2025-05-29 06:10:14', '2025-05-29 06:10:14'),
(473, 415, 128, 10, '2025-05-29 06:10:14', '2025-05-29 06:10:14'),
(474, 416, 128, 11, '2025-05-29 06:10:14', '2025-05-29 06:10:14'),
(475, 417, 128, 12, '2025-05-29 06:10:14', '2025-05-29 06:10:14'),
(476, 418, 128, 13, '2025-05-29 06:10:14', '2025-05-29 06:10:14'),
(477, 419, 128, 14, '2025-05-29 06:10:14', '2025-05-29 06:10:14'),
(478, 420, 128, 15, '2025-05-29 06:10:14', '2025-05-29 06:10:14'),
(479, 421, 128, 16, '2025-05-29 06:10:14', '2025-05-29 06:10:14'),
(480, 422, 128, 17, '2025-05-29 06:10:14', '2025-05-29 06:10:14'),
(481, 423, 128, 18, '2025-05-29 06:10:14', '2025-05-29 06:10:14'),
(482, 424, 128, 19, '2025-05-29 06:10:14', '2025-05-29 06:10:14'),
(483, 425, 128, 20, '2025-05-29 06:10:14', '2025-05-29 06:10:14'),
(484, 406, 129, 1, '2025-05-29 06:10:14', '2025-05-29 06:10:14'),
(485, 407, 129, 2, '2025-05-29 06:10:14', '2025-05-29 06:10:14'),
(486, 408, 129, 3, '2025-05-29 06:10:14', '2025-05-29 06:10:14'),
(487, 409, 129, 4, '2025-05-29 06:10:14', '2025-05-29 06:10:14'),
(488, 410, 129, 5, '2025-05-29 06:10:14', '2025-05-29 06:10:14'),
(489, 411, 129, 6, '2025-05-29 06:10:15', '2025-05-29 06:10:15'),
(490, 412, 129, 7, '2025-05-29 06:10:15', '2025-05-29 06:10:15'),
(491, 413, 129, 8, '2025-05-29 06:10:15', '2025-05-29 06:10:15'),
(492, 414, 129, 9, '2025-05-29 06:10:15', '2025-05-29 06:10:15'),
(493, 415, 129, 10, '2025-05-29 06:10:15', '2025-05-29 06:10:15'),
(494, 416, 129, 11, '2025-05-29 06:10:15', '2025-05-29 06:10:15'),
(495, 426, 130, 1, '2025-05-29 06:10:15', '2025-05-29 06:10:15'),
(496, 427, 130, 2, '2025-05-29 06:10:15', '2025-05-29 06:10:15'),
(497, 428, 130, 3, '2025-05-29 06:10:15', '2025-05-29 06:10:15'),
(498, 429, 130, 4, '2025-05-29 06:10:15', '2025-05-29 06:10:15'),
(499, 430, 130, 5, '2025-05-29 06:10:15', '2025-05-29 06:10:15'),
(500, 431, 130, 6, '2025-05-29 06:10:15', '2025-05-29 06:10:15'),
(501, 432, 130, 7, '2025-05-29 06:10:15', '2025-05-29 06:10:15'),
(502, 433, 130, 8, '2025-05-29 06:10:15', '2025-05-29 06:10:15'),
(503, 434, 130, 9, '2025-05-29 06:10:15', '2025-05-29 06:10:15'),
(504, 435, 130, 10, '2025-05-29 06:10:16', '2025-05-29 06:10:16'),
(505, 436, 130, 11, '2025-05-29 06:10:16', '2025-05-29 06:10:16'),
(506, 437, 130, 12, '2025-05-29 06:10:16', '2025-05-29 06:10:16'),
(507, 438, 130, 13, '2025-05-29 06:10:16', '2025-05-29 06:10:16'),
(508, 439, 130, 14, '2025-05-29 06:10:16', '2025-05-29 06:10:16'),
(509, 440, 131, 1, '2025-05-29 06:10:16', '2025-05-29 06:10:16'),
(510, 441, 131, 2, '2025-05-29 06:10:16', '2025-05-29 06:10:16'),
(511, 442, 131, 3, '2025-05-29 06:10:16', '2025-05-29 06:10:16'),
(512, 443, 131, 4, '2025-05-29 06:10:16', '2025-05-29 06:10:16'),
(513, 444, 131, 5, '2025-05-29 06:10:16', '2025-05-29 06:10:16'),
(514, 445, 131, 6, '2025-05-29 06:10:16', '2025-05-29 06:10:16'),
(515, 446, 131, 7, '2025-05-29 06:10:16', '2025-05-29 06:10:16'),
(516, 447, 131, 8, '2025-05-29 06:10:16', '2025-05-29 06:10:16'),
(517, 448, 131, 9, '2025-05-29 06:10:16', '2025-05-29 06:10:16'),
(518, 449, 131, 10, '2025-05-29 06:10:16', '2025-05-29 06:10:16'),
(519, 450, 131, 11, '2025-05-29 06:10:17', '2025-05-29 06:10:17'),
(520, 451, 131, 12, '2025-05-29 06:10:17', '2025-05-29 06:10:17'),
(521, 452, 131, 13, '2025-05-29 06:10:17', '2025-05-29 06:10:17'),
(522, 453, 131, 14, '2025-05-29 06:10:17', '2025-05-29 06:10:17'),
(523, 454, 132, 1, '2025-05-29 06:10:22', '2025-05-29 06:10:22'),
(524, 455, 132, 2, '2025-05-29 06:10:22', '2025-05-29 06:10:22'),
(525, 456, 132, 3, '2025-05-29 06:10:22', '2025-05-29 06:10:22'),
(526, 457, 132, 4, '2025-05-29 06:10:22', '2025-05-29 06:10:22'),
(527, 458, 132, 5, '2025-05-29 06:10:22', '2025-05-29 06:10:22'),
(528, 459, 132, 6, '2025-05-29 06:10:22', '2025-05-29 06:10:22'),
(529, 460, 132, 7, '2025-05-29 06:10:22', '2025-05-29 06:10:22'),
(530, 461, 132, 8, '2025-05-29 06:10:22', '2025-05-29 06:10:22'),
(531, 462, 132, 9, '2025-05-29 06:10:22', '2025-05-29 06:10:22'),
(532, 463, 132, 10, '2025-05-29 06:10:22', '2025-05-29 06:10:22'),
(533, 464, 132, 11, '2025-05-29 06:10:22', '2025-05-29 06:10:22'),
(534, 465, 132, 12, '2025-05-29 06:10:22', '2025-05-29 06:10:22'),
(535, 466, 133, 1, '2025-05-29 06:10:23', '2025-05-29 06:10:23'),
(536, 467, 133, 2, '2025-05-29 06:10:23', '2025-05-29 06:10:23'),
(537, 468, 133, 3, '2025-05-29 06:10:23', '2025-05-29 06:10:23'),
(538, 469, 133, 4, '2025-05-29 06:10:23', '2025-05-29 06:10:23'),
(539, 470, 133, 5, '2025-05-29 06:10:23', '2025-05-29 06:10:23'),
(540, 471, 133, 6, '2025-05-29 06:10:23', '2025-05-29 06:10:23'),
(541, 472, 133, 7, '2025-05-29 06:10:23', '2025-05-29 06:10:23'),
(542, 473, 133, 8, '2025-05-29 06:10:23', '2025-05-29 06:10:23'),
(543, 474, 133, 9, '2025-05-29 06:10:23', '2025-05-29 06:10:23'),
(544, 475, 133, 10, '2025-05-29 06:10:23', '2025-05-29 06:10:23'),
(545, 476, 133, 11, '2025-05-29 06:10:23', '2025-05-29 06:10:23'),
(546, 477, 133, 12, '2025-05-29 06:10:23', '2025-05-29 06:10:23'),
(547, 478, 133, 13, '2025-05-29 06:10:23', '2025-05-29 06:10:23'),
(548, 479, 133, 14, '2025-05-29 06:10:23', '2025-05-29 06:10:23'),
(549, 480, 134, 1, '2025-05-29 06:10:24', '2025-05-29 06:10:24'),
(550, 481, 135, 1, '2025-05-29 06:10:25', '2025-05-29 06:10:25'),
(557, 422, 138, 1, '2025-05-29 06:10:32', '2025-05-29 06:10:32'),
(558, 420, 139, 1, '2025-05-29 06:10:33', '2025-05-29 06:10:33'),
(559, 408, 139, 2, '2025-05-29 06:10:33', '2025-05-29 06:10:33'),
(560, 484, 140, 1, '2025-05-29 06:10:33', '2025-05-29 06:10:33'),
(561, 485, 141, 1, '2025-05-29 06:10:34', '2025-05-29 06:10:34'),
(562, 486, 141, 2, '2025-05-29 06:10:34', '2025-05-29 06:10:34'),
(563, 486, 142, 1, '2025-05-29 06:10:35', '2025-05-29 06:10:35'),
(564, 487, 143, 1, '2025-05-29 06:10:36', '2025-05-29 06:10:36'),
(565, 488, 143, 2, '2025-05-29 06:10:36', '2025-05-29 06:10:36'),
(566, 433, 143, 3, '2025-05-29 06:10:36', '2025-05-29 06:10:36'),
(567, 488, 144, 1, '2025-05-29 06:10:37', '2025-05-29 06:10:37'),
(568, 433, 144, 2, '2025-05-29 06:10:37', '2025-05-29 06:10:37'),
(569, 489, 145, 1, '2025-05-29 06:10:38', '2025-05-29 06:10:38'),
(570, 490, 146, 1, '2025-05-29 06:10:41', '2025-05-29 06:10:41'),
(571, 430, 146, 2, '2025-05-29 06:10:41', '2025-05-29 06:10:41'),
(572, 491, 147, 1, '2025-05-29 06:10:42', '2025-05-29 06:10:42'),
(573, 492, 148, 1, '2025-05-29 06:10:43', '2025-05-29 06:10:43'),
(574, 493, 148, 2, '2025-05-29 06:10:43', '2025-05-29 06:10:43'),
(575, 494, 148, 3, '2025-05-29 06:10:43', '2025-05-29 06:10:43'),
(576, 495, 148, 4, '2025-05-29 06:10:43', '2025-05-29 06:10:43'),
(577, 496, 148, 5, '2025-05-29 06:10:43', '2025-05-29 06:10:43'),
(578, 497, 149, 1, '2025-05-29 06:10:44', '2025-05-29 06:10:44'),
(579, 498, 150, 1, '2025-05-29 06:10:46', '2025-05-29 06:10:46'),
(580, 442, 151, 1, '2025-05-29 06:10:50', '2025-05-29 06:10:50'),
(581, 445, 152, 1, '2025-05-29 06:10:52', '2025-05-29 06:10:52'),
(582, 441, 153, 1, '2025-05-29 06:10:53', '2025-05-29 06:10:53'),
(583, 444, 154, 1, '2025-05-29 06:10:54', '2025-05-29 06:10:54'),
(584, 443, 155, 1, '2025-05-29 06:10:56', '2025-05-29 06:10:56'),
(585, 463, 156, 1, '2025-05-29 06:10:58', '2025-05-29 06:10:58'),
(586, 456, 156, 2, '2025-05-29 06:10:58', '2025-05-29 06:10:58'),
(587, 454, 156, 3, '2025-05-29 06:10:58', '2025-05-29 06:10:58');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(32) NOT NULL,
  `slug` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `status` enum('active','banned','deleted') NOT NULL DEFAULT 'active',
  `avatar` varchar(255) DEFAULT NULL,
  `remember_token` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `slug`, `email`, `email_verified_at`, `password`, `status`, `avatar`, `remember_token`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 'xnopyty', 'xnopyty', 'kombusted12@gmail.com', NULL, '$2y$12$FqCIemww4i39ZxHDx6zcTOa3lca3e7zdSTwM.KR6frG5G6D74BXdW', 'active', 'avatars/b9CFLmbuCsqnSm3Pg2obw7shAuchqX42xfe6OgHa.jpg', NULL, '2025-05-07 13:48:22', '2026-02-25 13:54:17', NULL),
(5, 'neark', 'neark', 'krepost123@gmail.com', NULL, '$2y$12$MkC.QnO9dn1ituYk3BZA2ed17Ka8CTaBCRNslM3KzZsCC2id09KCK', 'active', 'avatars/YmUudIyjKI5Igh6ukE5W0JGT1n20u3Ax1MZdiQY3.webp', NULL, '2025-05-12 15:23:03', '2026-04-12 08:44:38', NULL),
(6, 'baxhy', 'baxhy', 'danila.vasiljevs00710@gmail.com', NULL, '$2y$12$tbCrlvt.PqwxdVwHHSJJpuPz8ok1PAFbz9rxhY9UqjfTT0kwyHjym', 'banned', NULL, NULL, '2025-05-12 15:47:07', '2025-12-26 08:29:55', NULL),
(7, 'toha_tatir', 'toha-tatir', 'sda@gmail.com', NULL, '$2y$12$qL9zRdD9rkw72aA2MkJjBu6u5d9nsdh7mVmGRKaDqWi641NwtptOa', 'active', NULL, NULL, '2025-05-14 07:42:32', '2025-05-14 07:42:32', NULL),
(8, 'jelena', 'jelena', 'kombusted@gmail.com', NULL, '$2y$12$GF.2kk4EzBxRsDmeh0V6LeGlZ1nsne/F2Xaari0FwWto.e83JxNEa', 'deleted', NULL, NULL, '2025-05-29 08:07:01', '2025-12-23 10:53:37', NULL),
(9, 'test1', 'test1', 'kombusted13@gmail.com', NULL, '$2y$12$nnbbZDO85SYpCll3/JbR2.X/NgxdBX/Ui9t7vj2G9bwWQ7UHvCuBW', 'active', NULL, NULL, '2025-11-30 15:18:28', '2025-11-30 15:18:28', NULL),
(10, 'test2', 'test2', 'kombusted14@gmail.com', NULL, '$2y$12$g.HMmhXRGKMnSocNvBh85uewvrBEXOJaVBK7GHxqn2PVOL.V/.FQq', 'active', NULL, NULL, '2025-11-30 15:18:47', '2025-11-30 15:18:47', NULL),
(11, 'test3', 'test3', 'kombusted15@gmail.com', NULL, '$2y$12$KkTBpwYGykRQTfIM5MqzA.x86kMyg8F0TSt2oAUxOchNSm8akAuQS', 'active', NULL, NULL, '2025-11-30 15:19:14', '2025-11-30 15:19:14', NULL),
(12, 'test4', 'test4', 'kombusted16@gmail.com', NULL, '$2y$12$aM3KWj8Y5JaZsSKntMQLbufeOsHgtXunHrpXDeMRAAmPx600nh.D2', 'active', NULL, NULL, '2025-11-30 17:04:31', '2025-11-30 17:04:31', NULL),
(14, 'verylongnamebecauseiwantotoooooo', 'verylongnamebecauseiwantotoooooo', 'test@gmail.com', NULL, 'password', 'active', NULL, NULL, '2025-12-22 15:39:18', '2025-12-22 15:39:18', NULL),
(18, 'role_test', 'role-test', 'test@test.com', NULL, 'password', 'active', NULL, NULL, '2025-12-30 10:01:56', '2025-12-30 10:01:56', NULL),
(19, 'delete_user_tst', 'delete-user-tst', 'test1@test.com', NULL, '$2y$12$rAZdxz4yLfSP8lgsePPnNOR5qyMaV4Cg9q/MJGw2wGfPLP9UIHNIS', 'active', NULL, NULL, '2026-01-04 18:06:59', '2026-01-04 18:07:20', '2026-01-04 18:07:20'),
(20, 'jfh3j4h4hlnlklfds87sfdujjfi8fikd', 'jfh3j4h4hlnlklfds87sfdujjfi8fikd', 'q4vOeZWgy67O1WxUr47LcIMriw4JhXV9NPSKH3wNFbRRhPGZBR4YNNXkyRW2LM50tqmWNudO1uXSFk62UhzkciZNSGyb4kKiAsW7Rnqhzddk8OmbJNGS6yd57exjQ0V8FJAHcoHuq8nM3doltaqAtIQZpAfkb2isZYhG4GOYBOyDat1sQ2fZTpWSUjjj4CrecUJlpmY5@example.com', NULL, '$2y$12$kwUBebSfGwEK3quTXxbEMe3bDbWUyuf4ABxU3O6wWxjWldsGlXYey', 'active', NULL, NULL, NULL, NULL, NULL),
(21, 'jkUu4b7SZXZmjJSsYLPOlIdfwAFFNLka', 'jkUu4b7SZXZmjJSsYLPOlIdfwAFFNLka', 'mQ72Gm55jlzRjOYmHJ@example.com', NULL, '$2y$12$pG8a9lVW6pmfzvWJpKx2dunsNdWwlQ5f8bEo5p37/Qfs3/Cxu3rS.', 'active', NULL, NULL, NULL, NULL, NULL),
(22, 'hM2WYyliCEIVorQ', 'hM2WYyliCEIVorQ', 'sdz5r7wrrDt6bTtM6R@example.com', NULL, '$2y$12$8gVzXYfIjW7PtjDFbLz5GOB6oFtwFL.PyA.CiZUGoKu5hzdZ6sjuS', 'active', NULL, NULL, NULL, NULL, NULL),
(23, 'khd5ZcKF', 'khd5ZcKF', 'a6djAPKT8zC4gcpqjX@example.com', NULL, '$2y$12$VJK94GKN47mLSeRSQ/9/Du00FBHlqvA4qEtz0I5jd1JsJjm.3RYCC', 'active', NULL, NULL, NULL, NULL, NULL),
(24, 'slugTestffsfdf_fsdfs sdf', 'slugtestffsfdf-fsdfs-sdf', 'test43@test.com', NULL, '$2y$12$1zOVg8DAZsLFAH3ey6wp7O7n87i4.TXKv.wlGSZnkUZnC/g/No7XS', 'active', NULL, NULL, '2026-01-11 13:31:41', '2026-01-11 13:32:00', NULL),
(25, 'commentsModerTest', 'commentsmodertest', 'test_cmt@test.com', NULL, '$2y$12$4.JZDMepyERfpZwKcZufOuTiCiDXq5wj.xCeNg8IT54jFlJoX2VqC', 'active', NULL, NULL, '2026-01-25 19:24:01', '2026-01-25 19:24:01', NULL),
(26, 'addTest', 'addtest', 'test434@test.com', NULL, '$2y$12$6PgH.pRkfhBqUh5A5QfsP.l3MdH2IJ8IgJBCgD9ZwUK96EC5gmc12', 'active', NULL, NULL, '2026-01-28 14:55:48', '2026-01-28 14:55:48', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `users_roles`
--

CREATE TABLE `users_roles` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `role_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users_roles`
--

INSERT INTO `users_roles` (`id`, `user_id`, `role_id`, `created_at`, `updated_at`) VALUES
(1, 1, 1, '2025-05-09 15:56:52', '2025-05-09 15:56:52'),
(2, 1, 3, '2025-05-10 06:59:00', '2025-05-10 06:59:00'),
(5, 5, 4, '2025-12-23 06:22:16', '2025-12-23 06:22:16'),
(11, 5, 2, '2025-12-24 07:56:49', '2025-12-24 07:56:49'),
(12, 5, 5, '2025-12-24 07:56:49', '2025-12-24 07:56:49'),
(13, 5, 6, '2025-12-24 07:56:49', '2025-12-24 07:56:49'),
(15, 8, 6, '2025-12-24 07:57:25', '2025-12-24 07:57:25'),
(16, 8, 1, '2025-12-24 07:57:35', '2025-12-24 07:57:35'),
(18, 18, 14, '2025-12-30 10:05:38', '2025-12-30 10:05:38'),
(19, 18, 2, '2026-01-03 11:12:13', '2026-01-03 11:12:13'),
(20, 18, 11, '2026-01-03 11:12:13', '2026-01-03 11:12:13'),
(21, 18, 10, '2026-01-03 11:12:13', '2026-01-03 11:12:13'),
(23, 25, 1, '2026-01-25 19:26:49', '2026-01-25 19:26:49'),
(24, 5, 1, '2026-02-26 19:48:57', '2026-02-26 19:48:57');

-- --------------------------------------------------------

--
-- Table structure for table `user_collections`
--

CREATE TABLE `user_collections` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(100) NOT NULL,
  `slug` varchar(255) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `is_private` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `user_collections`
--

INSERT INTO `user_collections` (`id`, `user_id`, `name`, `slug`, `description`, `is_private`, `created_at`, `updated_at`) VALUES
(1, 5, 'testtesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttest', 'testtesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttest', 'hellohellohellohellohellohellohellohellohellohellohellohellohellohellohellohellohellohellohellohellohellohellohellohellohellohellohellohellohellohellohellohellohellohellohellohellohellohellohellohellohellohellohellohellohellohellohellohellohellohellohello', 0, '2026-02-28 16:01:47', '2026-04-06 06:23:51'),
(2, 5, 'Tst playlist 2', 'tst-playlist-2', 'Test playlist 2', 0, '2026-03-09 19:18:51', '2026-03-09 19:18:51'),
(3, 5, 'Test playlist 3', 'test-playlist-3', NULL, 1, '2026-03-22 18:15:54', '2026-03-22 18:15:54'),
(4, 5, 'Test playlist 4', 'test-playlist-4', NULL, 1, '2026-03-22 18:15:54', '2026-03-22 18:15:54'),
(5, 5, 'Test playlist 5', 'test-playlist-5', NULL, 1, '2026-03-22 18:15:54', '2026-03-22 18:15:54'),
(6, 5, 'Test playlist 6', 'test-playlist-6', NULL, 1, '2026-03-22 18:15:54', '2026-03-22 18:15:54'),
(7, 5, 'Test playlist 7', 'test-playlist-7', NULL, 1, '2026-03-22 18:15:54', '2026-03-22 18:15:54'),
(8, 5, 'Test playlist 8', 'test-playlist-8', NULL, 1, '2026-03-22 18:15:54', '2026-03-22 18:15:54'),
(9, 5, 'Test playlist 9', 'test-playlist-9', NULL, 1, '2026-03-22 18:15:54', '2026-03-22 18:15:54'),
(10, 5, 'Test playlist 10', 'test-playlist-10', NULL, 1, '2026-03-22 18:15:54', '2026-03-22 18:15:54'),
(11, 5, 'Test playlist 11', 'test-playlist-11', NULL, 1, '2026-03-22 18:15:54', '2026-03-22 18:15:54'),
(12, 5, 'Test playlist 12', 'test-playlist-12', NULL, 1, '2026-03-22 18:15:54', '2026-03-22 18:15:54'),
(13, 5, 'Test playlist 13', 'test-playlist-13', NULL, 1, '2026-03-22 18:15:54', '2026-03-22 18:15:54'),
(14, 5, 'adding from modal 1', 'adding-from-modal-1', NULL, 0, '2026-03-31 16:18:18', '2026-03-31 16:18:18'),
(15, 5, 'quick playlist', 'quick-playlist', NULL, 0, '2026-04-01 13:16:51', '2026-04-01 13:16:51');

-- --------------------------------------------------------

--
-- Table structure for table `user_collections_tracks`
--

CREATE TABLE `user_collections_tracks` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_collection_id` bigint(20) UNSIGNED NOT NULL,
  `track_id` bigint(20) UNSIGNED NOT NULL,
  `track_position` int(10) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `user_collections_tracks`
--

INSERT INTO `user_collections_tracks` (`id`, `user_collection_id`, `track_id`, `track_position`, `created_at`, `updated_at`) VALUES
(55, 1, 50, 1, '2026-03-15 14:39:08', '2026-03-15 14:39:08'),
(56, 1, 51, 2, '2026-03-15 14:39:08', '2026-03-15 14:39:08'),
(57, 1, 90, 3, '2026-03-15 14:39:08', '2026-03-15 14:39:08'),
(58, 1, 100, 4, '2026-03-15 14:39:08', '2026-03-15 14:39:08'),
(59, 1, 101, 5, '2026-03-15 14:39:08', '2026-03-15 14:39:08'),
(60, 1, 82, 6, '2026-03-15 14:39:08', '2026-03-15 14:39:08'),
(61, 1, 43, 7, '2026-03-15 14:39:08', '2026-03-15 14:39:08'),
(62, 1, 33, 8, '2026-03-15 14:39:08', '2026-03-15 14:39:08'),
(63, 1, 205, 9, '2026-03-15 14:39:08', '2026-03-15 14:39:08'),
(64, 1, 86, 10, '2026-03-15 14:39:08', '2026-03-15 14:39:08'),
(65, 1, 19, 11, '2026-03-15 14:39:08', '2026-03-15 14:39:08'),
(66, 1, 20, 12, '2026-03-15 14:39:08', '2026-03-15 14:39:08'),
(67, 1, 21, 13, '2026-03-15 14:39:08', '2026-03-15 14:39:08'),
(68, 1, 111, 14, '2026-03-15 14:39:08', '2026-03-15 14:39:08'),
(69, 1, 120, 15, '2026-03-15 14:39:08', '2026-03-15 14:39:08'),
(70, 1, 123, 16, '2026-03-15 14:39:08', '2026-03-15 14:39:08'),
(71, 1, 142, 17, '2026-03-15 14:39:08', '2026-03-15 14:39:08'),
(72, 1, 124, 18, '2026-03-15 14:39:08', '2026-03-15 14:39:08'),
(73, 1, 155, 19, '2026-03-15 14:39:08', '2026-03-15 14:39:08'),
(74, 1, 173, 20, '2026-03-15 14:39:08', '2026-03-15 14:39:08'),
(75, 1, 300, 21, '2026-03-15 14:39:08', '2026-03-15 14:39:08'),
(76, 1, 174, 22, '2026-03-15 14:39:08', '2026-03-15 14:39:08'),
(77, 1, 175, 23, '2026-03-15 14:39:08', '2026-03-15 14:39:08'),
(78, 1, 176, 24, '2026-03-15 14:39:08', '2026-03-15 14:39:08'),
(82, 2, 3, 1, NULL, NULL),
(83, 10, 2, 1, NULL, NULL),
(84, 14, 6, 1, NULL, NULL),
(85, 11, 386, 1, NULL, NULL),
(87, 2, 50, 2, NULL, NULL),
(88, 12, 193, 1, NULL, NULL),
(89, 9, 47, 1, NULL, NULL),
(90, 9, 7, 2, NULL, NULL),
(91, 5, 74, 1, NULL, NULL),
(92, 10, 45, 2, NULL, NULL);

--
-- Triggers `user_collections_tracks`
--
DELIMITER $$
CREATE TRIGGER `set_collection_track_position` BEFORE INSERT ON `user_collections_tracks` FOR EACH ROW BEGIN
                IF NEW.track_position = 0 THEN
                    SET NEW.track_position = (
                        SELECT IFNULL(MAX(track_position), 0) + 1
                        FROM user_collections_tracks
                        WHERE collection_id = NEW.collection_id
                    );
                END IF;
            END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `user_favorite_artists`
--

CREATE TABLE `user_favorite_artists` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `artist_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `user_favorite_artists`
--

INSERT INTO `user_favorite_artists` (`id`, `user_id`, `artist_id`, `created_at`, `updated_at`) VALUES
(16, 5, 97, '2026-02-26 09:57:12', '2026-02-26 09:57:12'),
(17, 5, 110, '2026-02-26 09:57:18', '2026-02-26 09:57:18'),
(18, 5, 74, '2026-02-26 09:57:24', '2026-02-26 09:57:24'),
(19, 5, 37, '2026-02-26 09:57:31', '2026-02-26 09:57:31'),
(20, 5, 8, '2026-02-26 16:22:34', '2026-02-26 16:22:34'),
(21, 5, 59, '2026-02-26 16:22:37', '2026-02-26 16:22:37'),
(22, 5, 63, '2026-02-26 16:22:40', '2026-02-26 16:22:40'),
(23, 5, 12, '2026-02-26 16:22:43', '2026-02-26 16:22:43'),
(24, 5, 61, '2026-02-26 16:29:09', '2026-02-26 16:29:09'),
(25, 5, 5, '2026-02-26 16:32:44', '2026-02-26 16:32:44'),
(26, 5, 7, '2026-02-26 16:32:51', '2026-02-26 16:32:51'),
(27, 5, 117, '2026-02-26 18:35:37', '2026-02-26 18:35:37'),
(28, 5, 88, '2026-02-26 18:35:41', '2026-02-26 18:35:41'),
(29, 5, 78, '2026-02-26 18:35:44', '2026-02-26 18:35:44'),
(30, 5, 102, '2026-02-26 18:35:47', '2026-02-26 18:35:47'),
(31, 5, 75, '2026-02-26 18:35:58', '2026-02-26 18:35:58'),
(32, 5, 20, '2026-02-26 18:36:06', '2026-02-26 18:36:06'),
(33, 5, 36, '2026-02-26 18:36:11', '2026-02-26 18:36:11'),
(34, 5, 106, '2026-02-26 18:36:16', '2026-02-26 18:36:16'),
(35, 5, 71, '2026-02-26 18:36:23', '2026-02-26 18:36:23'),
(36, 5, 76, '2026-02-26 18:36:29', '2026-02-26 18:36:29'),
(37, 5, 33, '2026-02-26 18:36:33', '2026-02-26 18:36:33'),
(38, 5, 72, '2026-02-26 18:36:41', '2026-02-26 18:36:41'),
(39, 5, 77, '2026-02-26 18:36:44', '2026-02-26 18:36:44'),
(40, 5, 113, '2026-03-02 15:38:08', '2026-03-02 15:38:08');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `artists`
--
ALTER TABLE `artists`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `artists_slug_unique` (`slug`),
  ADD KEY `popularity` (`popularity`);

--
-- Indexes for table `artists_genres`
--
ALTER TABLE `artists_genres`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `artist_id` (`artist_id`,`genre_id`),
  ADD KEY `artists_genres_artist_id_index` (`artist_id`),
  ADD KEY `artists_genres_genre_id_index` (`genre_id`);

--
-- Indexes for table `artists_releases`
--
ALTER TABLE `artists_releases`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `artist_id` (`artist_id`,`release_id`),
  ADD KEY `artists_releases_artist_id_index` (`artist_id`),
  ADD KEY `artists_releases_release_id_index` (`release_id`);

--
-- Indexes for table `artists_tracks`
--
ALTER TABLE `artists_tracks`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `artist_id` (`artist_id`,`track_id`),
  ADD KEY `artists_tracks_artist_id_index` (`artist_id`),
  ADD KEY `artists_tracks_track_id_index` (`track_id`);

--
-- Indexes for table `cache`
--
ALTER TABLE `cache`
  ADD PRIMARY KEY (`key`);

--
-- Indexes for table `cache_locks`
--
ALTER TABLE `cache_locks`
  ADD PRIMARY KEY (`key`);

--
-- Indexes for table `comments_artists`
--
ALTER TABLE `comments_artists`
  ADD PRIMARY KEY (`id`),
  ADD KEY `comments_artists_user_id_index` (`user_id`),
  ADD KEY `comments_artists_artist_id_index` (`artist_id`),
  ADD KEY `comments_artists_status_index` (`status`),
  ADD KEY `comments_artists_parent_id_foreign` (`parent_id`);

--
-- Indexes for table `comments_genres`
--
ALTER TABLE `comments_genres`
  ADD PRIMARY KEY (`id`),
  ADD KEY `comments_genres_genre_id_foreign` (`genre_id`),
  ADD KEY `comments_genres_parent_id_foreign` (`parent_id`),
  ADD KEY `comments_genres_user_id_foreign` (`user_id`);

--
-- Indexes for table `comments_releases`
--
ALTER TABLE `comments_releases`
  ADD PRIMARY KEY (`id`),
  ADD KEY `comments_releases_user_id_index` (`user_id`),
  ADD KEY `comments_releases_release_id_index` (`release_id`),
  ADD KEY `comments_releases_status_index` (`status`),
  ADD KEY `comments_releases_parent_id_foreign` (`parent_id`);

--
-- Indexes for table `comments_tracks`
--
ALTER TABLE `comments_tracks`
  ADD PRIMARY KEY (`id`),
  ADD KEY `comments_tracks_user_id_index` (`user_id`),
  ADD KEY `comments_tracks_track_id_index` (`track_id`),
  ADD KEY `comments_tracks_status_index` (`status`),
  ADD KEY `comments_tracks_parent_id_foreign` (`parent_id`);

--
-- Indexes for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`);

--
-- Indexes for table `genres`
--
ALTER TABLE `genres`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `genres_name_unique` (`name`),
  ADD UNIQUE KEY `slug` (`slug`),
  ADD KEY `popularity` (`popularity`);

--
-- Indexes for table `jobs`
--
ALTER TABLE `jobs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `jobs_queue_index` (`queue`);

--
-- Indexes for table `job_batches`
--
ALTER TABLE `job_batches`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `lyrics`
--
ALTER TABLE `lyrics`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `lyrics_track_id_unique` (`track_id`),
  ADD KEY `lyrics_last_updated_by_user_foreign` (`last_updated_by_user`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `password_reset_tokens`
--
ALTER TABLE `password_reset_tokens`
  ADD PRIMARY KEY (`email`);

--
-- Indexes for table `recommendations`
--
ALTER TABLE `recommendations`
  ADD PRIMARY KEY (`id`),
  ADD KEY `recommendations_user_id_foreign` (`user_id`);

--
-- Indexes for table `recommendations_artists`
--
ALTER TABLE `recommendations_artists`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `recommendations_artists_recommendation_genre_id_artist_id_unique` (`recommendation_genre_id`,`artist_id`),
  ADD KEY `recommendations_artists_artist_id_foreign` (`artist_id`);

--
-- Indexes for table `recommendations_genres`
--
ALTER TABLE `recommendations_genres`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `recommendations_genres_recommendation_id_genre_id_unique` (`recommendation_id`,`genre_id`),
  ADD KEY `recommendations_genres_genre_id_foreign` (`genre_id`);

--
-- Indexes for table `releases`
--
ALTER TABLE `releases`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `releases_slug_unique` (`slug`),
  ADD KEY `popularity` (`popularity`);

--
-- Indexes for table `releases_genres`
--
ALTER TABLE `releases_genres`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `release_id` (`release_id`,`genre_id`),
  ADD KEY `releases_genres_release_id_index` (`release_id`),
  ADD KEY `releases_genres_genre_id_index` (`genre_id`);

--
-- Indexes for table `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `roles_name_unique` (`name`);

--
-- Indexes for table `sessions`
--
ALTER TABLE `sessions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sessions_user_id_index` (`user_id`),
  ADD KEY `sessions_last_activity_index` (`last_activity`);

--
-- Indexes for table `tracks`
--
ALTER TABLE `tracks`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `tracks_slug_unique` (`slug`),
  ADD KEY `popularity` (`popularity`);

--
-- Indexes for table `tracks_genres`
--
ALTER TABLE `tracks_genres`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `track_id` (`track_id`,`genre_id`),
  ADD KEY `tracks_genres_track_id_index` (`track_id`),
  ADD KEY `tracks_genres_genre_id_index` (`genre_id`);

--
-- Indexes for table `tracks_releases`
--
ALTER TABLE `tracks_releases`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `release_track_order_unique` (`release_id`,`track_position`),
  ADD UNIQUE KEY `track_release_unique` (`track_id`,`release_id`),
  ADD KEY `tracks_releases_release_id_index` (`release_id`),
  ADD KEY `tracks_releases_track_id_index` (`track_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_name_unique` (`name`),
  ADD UNIQUE KEY `users_email_unique` (`email`),
  ADD UNIQUE KEY `users_slug_unique` (`slug`) USING BTREE;

--
-- Indexes for table `users_roles`
--
ALTER TABLE `users_roles`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `user_id` (`user_id`,`role_id`),
  ADD KEY `users_roles_user_id_index` (`user_id`),
  ADD KEY `users_roles_role_id_index` (`role_id`);

--
-- Indexes for table `user_collections`
--
ALTER TABLE `user_collections`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `slug` (`slug`),
  ADD KEY `user_collections_user_id_index` (`user_id`);

--
-- Indexes for table `user_collections_tracks`
--
ALTER TABLE `user_collections_tracks`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `user_collection_id` (`user_collection_id`,`track_position`),
  ADD UNIQUE KEY `user_collection_id_2` (`user_collection_id`,`track_id`),
  ADD KEY `user_collections_tracks_collection_id_track_position_index` (`user_collection_id`,`track_position`),
  ADD KEY `user_collections_tracks_track_id_foreign` (`track_id`);

--
-- Indexes for table `user_favorite_artists`
--
ALTER TABLE `user_favorite_artists`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `user_favorite_artists_user_id_artist_id_unique` (`user_id`,`artist_id`),
  ADD KEY `user_favorite_artists_artist_id_foreign` (`artist_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `artists`
--
ALTER TABLE `artists`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=120;

--
-- AUTO_INCREMENT for table `artists_genres`
--
ALTER TABLE `artists_genres`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `artists_releases`
--
ALTER TABLE `artists_releases`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=225;

--
-- AUTO_INCREMENT for table `artists_tracks`
--
ALTER TABLE `artists_tracks`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=667;

--
-- AUTO_INCREMENT for table `comments_artists`
--
ALTER TABLE `comments_artists`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=184;

--
-- AUTO_INCREMENT for table `comments_genres`
--
ALTER TABLE `comments_genres`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `comments_releases`
--
ALTER TABLE `comments_releases`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT for table `comments_tracks`
--
ALTER TABLE `comments_tracks`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `genres`
--
ALTER TABLE `genres`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=44;

--
-- AUTO_INCREMENT for table `jobs`
--
ALTER TABLE `jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `lyrics`
--
ALTER TABLE `lyrics`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=56;

--
-- AUTO_INCREMENT for table `recommendations`
--
ALTER TABLE `recommendations`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `recommendations_artists`
--
ALTER TABLE `recommendations_artists`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `recommendations_genres`
--
ALTER TABLE `recommendations_genres`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `releases`
--
ALTER TABLE `releases`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=159;

--
-- AUTO_INCREMENT for table `releases_genres`
--
ALTER TABLE `releases_genres`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=37;

--
-- AUTO_INCREMENT for table `roles`
--
ALTER TABLE `roles`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT for table `tracks`
--
ALTER TABLE `tracks`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=502;

--
-- AUTO_INCREMENT for table `tracks_genres`
--
ALTER TABLE `tracks_genres`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=145;

--
-- AUTO_INCREMENT for table `tracks_releases`
--
ALTER TABLE `tracks_releases`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=588;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=27;

--
-- AUTO_INCREMENT for table `users_roles`
--
ALTER TABLE `users_roles`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT for table `user_collections`
--
ALTER TABLE `user_collections`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT for table `user_collections_tracks`
--
ALTER TABLE `user_collections_tracks`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=97;

--
-- AUTO_INCREMENT for table `user_favorite_artists`
--
ALTER TABLE `user_favorite_artists`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=45;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `artists_genres`
--
ALTER TABLE `artists_genres`
  ADD CONSTRAINT `artists_genres_artist_id_foreign` FOREIGN KEY (`artist_id`) REFERENCES `artists` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `artists_genres_genre_id_foreign` FOREIGN KEY (`genre_id`) REFERENCES `genres` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `artists_releases`
--
ALTER TABLE `artists_releases`
  ADD CONSTRAINT `artists_releases_artist_id_foreign` FOREIGN KEY (`artist_id`) REFERENCES `artists` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `artists_releases_release_id_foreign` FOREIGN KEY (`release_id`) REFERENCES `releases` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `artists_tracks`
--
ALTER TABLE `artists_tracks`
  ADD CONSTRAINT `artists_tracks_artist_id_foreign` FOREIGN KEY (`artist_id`) REFERENCES `artists` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `artists_tracks_track_id_foreign` FOREIGN KEY (`track_id`) REFERENCES `tracks` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `comments_artists`
--
ALTER TABLE `comments_artists`
  ADD CONSTRAINT `comments_artists_artist_id_foreign` FOREIGN KEY (`artist_id`) REFERENCES `artists` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `comments_artists_parent_id_foreign` FOREIGN KEY (`parent_id`) REFERENCES `comments_artists` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `comments_artists_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `comments_genres`
--
ALTER TABLE `comments_genres`
  ADD CONSTRAINT `comments_genres_genre_id_foreign` FOREIGN KEY (`genre_id`) REFERENCES `genres` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `comments_genres_parent_id_foreign` FOREIGN KEY (`parent_id`) REFERENCES `comments_genres` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `comments_genres_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `comments_releases`
--
ALTER TABLE `comments_releases`
  ADD CONSTRAINT `comments_releases_parent_id_foreign` FOREIGN KEY (`parent_id`) REFERENCES `comments_releases` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `comments_releases_release_id_foreign` FOREIGN KEY (`release_id`) REFERENCES `releases` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `comments_releases_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `comments_tracks`
--
ALTER TABLE `comments_tracks`
  ADD CONSTRAINT `comments_tracks_parent_id_foreign` FOREIGN KEY (`parent_id`) REFERENCES `comments_tracks` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `comments_tracks_track_id_foreign` FOREIGN KEY (`track_id`) REFERENCES `tracks` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `comments_tracks_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `lyrics`
--
ALTER TABLE `lyrics`
  ADD CONSTRAINT `lyrics_last_updated_by_user_foreign` FOREIGN KEY (`last_updated_by_user`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `lyrics_track_id_foreign` FOREIGN KEY (`track_id`) REFERENCES `tracks` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `recommendations`
--
ALTER TABLE `recommendations`
  ADD CONSTRAINT `recommendations_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `recommendations_artists`
--
ALTER TABLE `recommendations_artists`
  ADD CONSTRAINT `recommendations_artists_artist_id_foreign` FOREIGN KEY (`artist_id`) REFERENCES `artists` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `recommendations_artists_recommendation_genre_id_foreign` FOREIGN KEY (`recommendation_genre_id`) REFERENCES `recommendations_genres` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `recommendations_genres`
--
ALTER TABLE `recommendations_genres`
  ADD CONSTRAINT `recommendations_genres_genre_id_foreign` FOREIGN KEY (`genre_id`) REFERENCES `genres` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `recommendations_genres_recommendation_id_foreign` FOREIGN KEY (`recommendation_id`) REFERENCES `recommendations` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `releases_genres`
--
ALTER TABLE `releases_genres`
  ADD CONSTRAINT `releases_genres_genre_id_foreign` FOREIGN KEY (`genre_id`) REFERENCES `genres` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `releases_genres_release_id_foreign` FOREIGN KEY (`release_id`) REFERENCES `releases` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `tracks_genres`
--
ALTER TABLE `tracks_genres`
  ADD CONSTRAINT `tracks_genres_genre_id_foreign` FOREIGN KEY (`genre_id`) REFERENCES `genres` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `tracks_genres_track_id_foreign` FOREIGN KEY (`track_id`) REFERENCES `tracks` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `tracks_releases`
--
ALTER TABLE `tracks_releases`
  ADD CONSTRAINT `tracks_releases_release_id_foreign` FOREIGN KEY (`release_id`) REFERENCES `releases` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `tracks_releases_track_id_foreign` FOREIGN KEY (`track_id`) REFERENCES `tracks` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `users_roles`
--
ALTER TABLE `users_roles`
  ADD CONSTRAINT `users_roles_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `users_roles_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `user_collections`
--
ALTER TABLE `user_collections`
  ADD CONSTRAINT `user_collections_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `user_collections_tracks`
--
ALTER TABLE `user_collections_tracks`
  ADD CONSTRAINT `user_collections_tracks_collection_id_foreign` FOREIGN KEY (`user_collection_id`) REFERENCES `user_collections` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `user_collections_tracks_track_id_foreign` FOREIGN KEY (`track_id`) REFERENCES `tracks` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `user_favorite_artists`
--
ALTER TABLE `user_favorite_artists`
  ADD CONSTRAINT `user_favorite_artists_artist_id_foreign` FOREIGN KEY (`artist_id`) REFERENCES `artists` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `user_favorite_artists_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
