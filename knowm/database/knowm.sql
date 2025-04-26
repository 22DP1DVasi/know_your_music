-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Apr 26, 2025 at 09:33 AM
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
  `biography` text DEFAULT NULL,
  `formed_year` smallint(5) UNSIGNED DEFAULT NULL,
  `disbanded_year` smallint(5) UNSIGNED DEFAULT NULL,
  `solo_or_band` enum('solo','band') DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `artists`
--

INSERT INTO `artists` (`id`, `name`, `biography`, `formed_year`, `disbanded_year`, `solo_or_band`, `created_at`, `updated_at`) VALUES
(1, 'Bring Me The Horizon', 'Bring Me the Horizon, often known by the acronym BMTH, is a British deathcore/metalcore/alternative metal band formed in 2004 in Sheffield, South Yorkshire, by vocalist Oliver Sykes, drummer Matt Nicholls, bassist Matt Kean and guitarists Lee Malia and Curtis Ward.\n\nThe current lineup of the band consists of: Oliver \"Oli\" Sykes (lead vocals, keyboards and programming), Matt Nicholls (drums), Lee Malia (lead and rythm guitar), Matt Kean (bass) and touring member John Jones (rythm guitar and backing vocals).\n\nThey are signed to RCA Records globally and Columbia Records exclusively in the United States. The style of their early work, including their debut album Count Your Blessings, has primarily been described as melodic deathcore, but they started to adopt a more eclectic style of metalcore on subsequent albums. Furthermore, their latest two albums That\'s the Spirit and amo marked a shift in their sound to less aggressive rock/metal music styles, such as alternative rock, pop rock, and alternative metal.\n\nHistory\nBring Me the Horizon\'s founding members came from diverse musical backgrounds within metal and rock. Matt Nicholls and Oliver Sykes had a common interest in American metalcore such as Norma Jean and Skycamefalling, and used to attend local hardcore punk shows. They later met Lee Malia, who spoke with them about thrash metal and melodic death metal bands like Metallica and At the Gates; Malia had also been part of a Metallica tribute band before meeting the pair. Bring Me the Horizon officially formed in March 2004, when the members were aged 15 to 17. Curtis Ward, who also lived in the Rotherham area, joined Sykes, Malia and Nicholls. Bassist Matt Kean, who was in other local bands, completed the line-up. Their name was taken from the line in the film Pirates of the Caribbean: The Curse of the Black Pearl, where Captain Jack Sparrow says \"Now, bring me that horizon.\"\n\nIn the months following their formation, Bring Me the Horizon created a demo album titled Bedroom Sessions. They followed this by releasing their first EP, This Is What the Edge of Your Seat Was Made For in September 2004 through local UK label Thirty Days of Night Records. Bring Me the Horizon were the label\'s first signing. It was recorded at Pristine Studios in Nottingham over the course of two weekends, with drums and bass guitar laid down over the first weekend, and guitars and vocals completed a week later.\n\nUK label Visible Noise noticed the band after the release of their EP, and signed them for a four-album deal, in addition to re-releasing the EP in January 2005. The re-release gained the band significant attention, eventually peaking at No. 41 on the UK album charts. The band was later awarded Best British Newcomer at the 2006 Kerrang! Awards ceremony.\n\nThe band\'s first tour was supporting The Red Chord across the United Kingdom. As with other early tours, they were able to get this slot by tricking venue promoters. Kean and Oliver\'s mother were the de facto managers of the band at this time, a role they continued to occupy until 2008. For The Red Chord support, Kean emailed promoters and pretended they were opening on all the dates, when they were supposed to play only at their local show. This led them to being booked for the whole tour. In another case, Sykes created an e-mail account in the name of Johnny Truant vocalist Oliver Mitchell, which he used to contact a promoter requesting Bring Me the Horizon on their tour. Alcohol consumption fuelled their live performances in their early history when the band would get so drunk they vomited on stage and damaged their equipment.\n\nThe band released their debut album Count Your Blessings in October 2006 in the United Kingdom and in August 2007 in the United States. They rented a house in the country to write songs, but easily became distracted. They then recorded the album in inner-city Birmingham, a process which was infamous for their excessive and dangerous drinking. During this period drummer Nicholls summarised it saying \"we were out every night, just being regular 18-year-olds\". Critics panned the album adding to the strongly polarised responses the band were already seeing from the public.\n\nBring Me the Horizon recorded their second studio album, Suicide Season, in Sweden with producer Fredrik Nordström. He was unimpressed with their first album and was initially absent from the recording sessions unless he needed to be there. Nordström later heard the new sound they were experimenting with during a recording session and became very involved in the record. It was promoted virally in the weeks before its release with the promotional tag line \"September is Suicide Season.\"\n\nDuring the Taste of Chaos tour in March of that year, guitarist Curtis Ward left the band. His relationship with the band had deteriorated as his stage performances were poor. He was abusive to audiences during the Taste of Chaos tour, and had contributed little to the writing of Suicide Season. Another reason for his departure was the worsening tinnitus in his one functioning ear. Ward was born deaf in one ear and admitted playing in the band worsened the ringing in his other ear to such a degree that he was unable to sleep at night. Ward offered to perform the rest of the tour dates, which the band rejected and instead asked their guitar technician, Dean Rowbotham, to substitute for him for the remaining performances. Lee Malia noted that Ward\'s departure helped improve everyone\'s mood as he had been very negative. Within a week of the tour finishing, Sykes began talking to Jona Weinhofen, at the time the guitarist of Bleeding Through. The band knew of him from his work with his former band I Killed the Prom Queen, and he was asked to join them. Ward has since worked on the TV show Top Gear, and has occasionally performed on stage with Bring Me The Horizon, playing Pray For Plagues, most notably at Wembley Arena in 2015. In 2016, it was announced that Ward had joined the band Counting Days.\n\nIn November 2009, Bring Me the Horizon released a remixed version of Suicide Season, titled Suicide Season: Cut Up!. Musicians and producers featured on the album include: Ben Weinman (from the Dillinger Escape Plan), Skrillex, L’Amour La Morgue, Utah Saints and Shawn Crahan (from Slipknot). Musically, the album incorporates many genres including: electronica, drum and bass, hip-hop and dubstep. The dubstep style of the record has been acknowledged in tracks by Tek-One and Skrillex while the hip-hop elements are found in Travis McCoy\'s remix of Chelsea Smile.\n\nThe band\'s third album, and first with their new rhythm guitarist Jona Weinhofen, titled There Is a Hell, Believe Me I\'ve Seen It. There Is a Heaven, Let\'s Keep It a Secret, was released on 4 October 2010 and debuted at number 17 on the Billboard 200 in the United States, number 13 on the UK Album Chart, and number one on the Australian Albums Chart, the UK Rock Chart and the UK Indie Chart. Despite reaching number one in Australia, the album\'s sales were the lowest for a number one album in the history of the Australian Recording Industry Association (ARIA) charts.\n\nMatt Nicholls describes the lyrical themes of There Is a Hell as being \"repercussions of everything we were singing about on our last CD (Suicide Season)\" calling the music and lyrics a lot moodier and darker. Five singles were released from the album including: It Never Ends, Anthem, Blessed with a Curse, Visions and Alligator Blood, with music videos produced for each of the songs. \n\n2011 ended with an announcement by the band on 29 December of a new extended play titled The Chill Out Sessions, a collaborative effort with British DJ Draper. Draper first released an \"officially sanctioned\" remix of the song Blessed with a Curse in May 2011. The EP was originally supposed to be released in time for New Year\'s Day, and made available for download and purchase though Bring Me the Horizon\'s website, but the EP\'s release was cancelled due to the band\'s \"current management and label situation\".\n\nAfter an intense touring schedule, Bring Me the Horizon finally completed their third album\'s promotion at the end of 2011. They returned to the UK for an extended break and eventually starting work on their next album. Much like their previous two albums, they wrote their fourth album in seclusion and isolation to stay focused. This time, they retreated to a house in the Lake District. In July, the band started to publish images of themselves recording at a \"Top Secret Studio Location\" and revealed they were working with producer Terry Date for the recording and production of the album. On 30 July, the band announced they had left their label and signed with RCA, who would release their fourth album in 2013.  In late October it was announced that the fourth album would be called Sempiternal with a tentative release in early 2013. On 22 November the band released the Draper collaborative album The Chill Out Sessions free of charge.\n\nOn 4 January 2013, Bring Me the Horizon released the first single from Sempiternal, Shadow Moses. It was first played by radio presenter Daniel P. Carter on BBC\'s Radio 1. Due to popular demand, Epitaph released the music video for the song a week earlier than planned. In January, the band also saw a change in their line up. This began early in the month when Jordan Fish, Worship keyboardist and session musician for the band during the writing of Sempiternal, was announced as a full member. Then later in the month, Jona Weinhofen left the band. Despite the band denying speculation that Fish replaced Weinhofen, reviewers said that replacing a guitarist with a keyboardist better fit their style. The album was released the 1st of march, 2013. The album was supported by multiple music videos including those for the tracks Go to Hell, for Heaven\'s Sake, Sleepwalking and Can You Feel My Heart. The lyrics on Sempiternal mainly deal with Sykes\' journey through rehabilitation from ketamine.\n\nLater in 2014, the band released two new tracks titled Drown on 21 October, as a stand-alone single, and Don\'t Look Down on 29 October, as part of the re-score of Drive.\n\nIn late June, the band began to promote pictures of an umbrella symbol being used as a tattoo, and on stickers, and posters across England, the United States, Australia, and Europe; it was later used for a promotional cover for the band\'s first single. The band released a short video in early July where the words \"that\'s the spirit\" could be heard in reverse. On 13 July 2015, the promotional single Happy Song was released on the band\'s Vevo page, and on 21 July 2015, Sykes revealed the album\'s name was That\'s the Spirit. The band released the single and music video for Throne on 23 July 2015, and another promotional track from the album, titled \"True Friends\", was released on 24 August 2015. The album was released on 11 September 2015 to critical acclaim. It has led to several music videos including Drown, Throne, True Friends, Follow You, Avalanche and  Oh No.\n\nOn 22 April 2016, the band performed a live concert with an orchestra conducted by Simon Dobson at the Royal Albert Hall in London. The concert marked the first time the band had performed with a live orchestra. It was recorded, and the live album, Live At The Royal Albert Hall, was released on 2 December 2016 through the crowdfunding platform PledgeMusic on CD, DVD, and vinyl, with all proceeds donated to Teenage Cancer Trust.\n\nIn August 2018, cryptic posters appeared in major cities throughout the world with the message \"do you wanna start a cult with me?\". The posters were attributed by major media outlets to the band only by their use of the hexagram logo previously used by the band. During this time the band themselves have not acknowledged their involvement with the campaign publicly. Each poster provided a unique phone number and a website address. The website provided a brief message titled \"An Invitation To Salvation\" and shows the date of 21 August 2018. The phone lines placed fans on hold with lengthy, varied audio messages that changed frequently. Some of these messages reportedly end with a distorted audio clip of what was assumed to be new music from the band.\n\nOn 21 August, the band released the lead single Mantra. The following day the band announced their new album amo set for release on 11 January 2019 along with a new set of tour dates called the First Love World Tour. On 21 October, the band released their second single wonderful life (feat. Dani Filth) featuring Dani Filth, along with the tracklist for amo. That same day, the band announced that the album has been delayed and is now set for 25 January 2019. On 3 January 2019, the band released their third single medicine and its corresponding music video.\n\nDiscography\nStudio albums\nCount Your Blessings (2006)Suicide Season (2008)There Is a Hell Believe Me I\'ve Seen It. There Is a Heaven Let\'s Keep It a Secret. (2010)Sempiternal (2013)That\'s the Spirit (2015)amo (2019)POST HUMAN: SURVIVAL HORROR (2020)POST HUMAN: Nex Gen (2024)\n\nLive albums\nLive at Wembley (2015)Live At The Royal Albert Hall (2016)\n\nCompilations\n2004 - 2013 (2017)\n\nEPs\nThis Is What the Edge of Your Seat Was Made For (2004)The Chill Out Sessions (2012)Music to listen to~dance to~blaze to~pray to~feed to~sleep to~talk to~grind to~trip to~breathe to~help to~hurt to~scroll to~roll to~love to~hate to~learn Too~plot to~play to~be to~feel to~breed to~sweat to~dream to~hide to~live to~die to~GO TO (2019)\n\nExternal links\nEnglish Wikipedia  User-contributed text is available under the Creative Commons By-SA License; additional terms may apply.', NULL, NULL, 'band', '2025-04-22 16:29:02', '2025-04-22 16:30:05'),
(2, 'AURORA', 'Aurora Aksnes (born June 15, 1996), known mononymously as AURORA, is a Norwegian singer, songwriter and record producer. She is considered one of Norway\\\'s biggest artists. Born in Stavanger and raised in the towns of Høle and Os, she began writing her first songs and learning dance at the age of six. After some of her songs were uploaded online and became popular in Norway, she signed a recording contract with Petroleum Records, Decca and Glassnote Records in 2014. She began writing music and lyrics at a young age, eventually releasing her debut single, Awakening, at the age of 17 in late 2013. Her second single Under Stars was released in late 2014.\\n\\n2015-2017: \\\"All My Demons Greeting Me As A Friend\\\" (Debut album)\\nThe singer signed with American record label Glassnote and UK-based Decca for her debut EP, Running With The Wolves, which arrived in the first half of 2015. The EP was highly rated mainly in Norway, and won the award for Best New Artist at the Spellemannprisen, which is known as the \\\"Norwegian Grammy\\\". In the same year, she was selected as one of the performers at the annual Nobel Peace Prize concert. She then gained further attention after covering Half The World Away by Oasis for the 2015 John Lewis Christmas advert, before following up with her debut album, All My Demons Greeting Me As A Friend, in 2016. The album charted in several Western European countries, topping the charts in Norway and reaching the Top 30 in the United Kingdom, as well as the Billboard 200 in the United States. The work was praised by several musical media. Next, AURORA embarked on her first world tour: the All My Demons Tour.\\n\\n2018: \\\"Infections Of A Different Kind – Step 1\\\" (First chapter of the second studio album)\\nThe singer surprise-released the first chapter of her second album, Infections Of A Different Kind – Step 1. Recorded mainly in the suburbs of France, the album expands the scope of the music with 32 choirs. The singer integrated more realistic themes, including politics and sexuality. This took her back into Norway\\\'s Top 10, peaking at number seven. To promote the album, AURORA released \\\"ONCE AURORA\\\", her first full-documentary, produced by Flimmer Film and directed by Benjamin Langeland and Stian Servoss. The TV version premiered on NRK, Norwegian national TV, on December 9, 2018. The film version toured the film festival circuit in 2019-2020 and on March 21, 2020 it was officially released worldwide. The film received the awards for Best Editing and Best Cinematography at the 2019 edition of Gullruten, a TV and cinema award in Norway, and Best Nordic Documentary at the Nordisk Panorama.\\n\\n2019: \\\"A Different Kind Of Human – Step 2\\\" (Second chapter of the second studio album )\\nStepping away from her solo work, AURORA entered the studio with the duo The Chemical Brothers, contributing to their ninth album, No Geography (which have won a Grammy), released in April 2019. The second chapter of her second album, A Different Kind Of Human – Step 2, was released in June of that same year. Regarding the relationship between the two works, AURORA said: \\\"The first chapter is a work about how to defend yourself, because the most important thing is to defend yourself. Only then can you do this with your friends, family and yourself. You can help even people you don\\\'t know. If you love yourself and learn to help, you can be invincible. Chapter 2 is realizing how you can help the world. worried about me. Describes the entire process of becoming a warrior of love.\\\"\\n\\n2019-2020: \\\"Into the Unknown\\\" and Soundtracks\\nIn the Disney full-lenght \\\"Frozen 2\\\" released in 2019, she made an appearance in the work as a \\\"mysterious voice\\\" and was featured in the song Into the Unknown. At the 92nd Academy Awards held the following year, she performed with Elsa from 10 countries around the world, including Idina Menzel. In the full-lenght \\\"Wolfwalkers\\\"\\\" by the animation studio Cartoon Saloon, whose produced films were nominated for an Oscar, AURORA re-recorded the song Running With The Wolves for the movie.\\n\\n2021-2023: \\\"The Gods We Can Touch\\\" (Third studio album)\\nThroughout the second half of 2021, AURORA released singles to promote her third studio album and had a highlight in the singer\\\'s single Sub Urban, PARAMOUR. With ancient Greek mythology as its theme, the album The Gods We Can Touch was released via Glassnote and Decca in January 2022. It was produced by the singer and the longtime collaborator Magnus Skylstad, who also co-wrote many of the songs. The album was the singer\\\'s first top 10 on the UK album chart, second top 1 in Norway and her first album to chart on the French albums chart. The singer won the International Sucess Of The Year award on the 2021 edition of Spellemannprisen, and also won the P3 Gull, the main prize of the Norwegian award with same name.\\n\\nAURORA embarked on her extensive The Gods We Can Touch Tour in March 2022, with opening acts: Metteson, Sub Urban, Thea Wang, Sei Selina, Blusher and Hannah Storm.\\n\\nIn August 2022, AURORA headlined the Øyafestivalen, one of the largest music festivals in Norway, as part of her The Gods We Can Touch Tour. Her show was seen by an audience of approximately 20,000 people, marking her biggest show in the country. The British magazine NME reviewed the concert and rated it 100/100: \\\"Aurora shines at the festival of the future\\\".\\n\\nOther projects included Storm, a collaboration with Taiwanese singer Wu Qing-feng, released in June 2022. September saw the release of the song Hunting Shadows for the video game\\\'s 15th anniversary Assassin\\\'s Creed. In October, the soundtrack for the BBC documentary series \\\"Frozen Planet II\\\" was released, which AURORA contributed with her vocals for 21 tracks. Several songs from AURORA\\\'s discography were featured in a season of the video game Sky: Children of the Light. Its season ended with a interactive virtual concert, which was released as a soundtrack: Sky: Concert in the Light.\\n\\nThe singer was featured in Butterflies, a collaboration with Tom Odell, and in My Sails Are Set for the Netflix series One Piece.\\n\\n2023-2024: \\\"What Happened To The Heart?\\\" (Fourth studio album)\\nThe single Your Blood, AURORA\\\'s first new solo musical material in nearly two years, was released on 8 November 2023. At the beginning of the following year, she confirmed that she was working on her forthcoming fourth studio album, and released the single The Conflict Of The Mind as the second single from the album, following \\\"Your Blood\\\"; it was released along with a music video co-directed by AURORA and Kaveh Nabatian. Some Type Of Skin premiered on 20 March as the third single, and, a week later, she announced her album What Happened To The Heart?, which was released on 7 June 2024; it was labeled as her most personal and cathartic album to date. Along with the announcement, she also revealed that she will promote it with a concert world tour titled What Happened To The Earth?, beginning in September 2024.\\n\\nAURORA featured on Bring Me The Horizon\\\'s song liMOusIne from their album POST HUMAN: NeX GEn, released on May 24, 2024.\\n\\nDuring the Latin American leg of Aurora\\\'s What Happened To The Earth? tour, she performed the biggest headline show of her career with a sold-out attendance of 18,000 at the Palacio de los Deportes in Mexico City.', NULL, NULL, 'solo', '2025-04-22 16:29:04', '2025-04-22 16:29:04'),
(3, 'Underoath', 'Underoath (occasionally typeset as underOATH or UNDERØATH) is an American band originally formed on November 30, 1997 in Ocala, Florida, but later relocated to Tampa, Florida, which was home to some of their newer members.\\r\\n\\r\\nDuring the band\\\'s early years, when they were fronted by former vocalist Dallas Taylor, Underoath displayed a heavier style than their later, more well-known work, incorporating disparate influences from death and black metal. With Taylor, they released Act of Depression, Cries of the Past, and The Changing of Times. Following Taylor\\\'s departure, Spencer Chamberlain became lead vocalist. The band then released They\\\'re Only Chasing Safety and Define the Great Line, gaining a certified gold rating and the highest-charting Christian album on The Billboard 200 since 1997, respectively. These two albums have given them more mainstream and commercial success. They\\\'re Only Chasing Safety marked an extreme departure from their earlier work, with extensive use of clean vocals and poppy rhythms, and a near-complete eradication of breakdowns and the use of double-bass. Define The Great Line reflected another shift in style, once again incorporating heavier styles into Underoath\\\'s sound. While the album still featured extensive clean vocals, its use of heavier vocals, detuned guitars, and Botch-inspired guitar work paved the way for Underoath\\\'s future.\\r\\n\\r\\nUnderoath released a live album called Survive, Kaleidoscope on May 27, 2008. Earlier that year, the band recorded a new studio album called Lost in the Sound of Separation, which was released on September 2, 2008, peaking at number 8 on the Billboard 200. In April 2010, Aaron Gillespie announced his resignation from the band, stating that there are no hard feelings and that he will continue to pursue his other band, The Almost, leaving Underoath with none of its founding members.\\r\\n\\r\\nThe band recorded their seventh album with new drummer Daniel Davison, formerly of Norma Jean. The album, Ø (Disambiguation), was released on November 9, 2010.\\r\\n\\r\\nIn October 2012, Underoath announced that they would be disbanding the following year, in addition to a career-spanning compilation album, Anthology: 1999–2013, which was released on November 6, 2012. The band then embarked on a nine-date farewell tour, which wrapped up at Jannus Live in St. Petersburg, Florida on January 26, 2013.\\r\\n\\r\\nIn January 2015, the band launched a campaign to finalize production of documentary film about their farewell tour of 12 shows, posting two trailers on that subject to their YouTube channel.\\r\\n\\r\\nIn July 2015, Underoath began teasing the phrase \\\"rebirth is coming\\\" and an accompanying cryptic video across their social media accounts. The audio portion to the cryptic video, when played backwards, turned out to be the chorus for \\\"It\\\'s Dangerous Business Walking Out Your Front Door\\\" off the band\\\'s 2004 album They\\\'re Only Chasing Safety, and later a countdown timer ending on August 24, 2015 later appeared on the band\\\'s website.\\r\\n\\r\\nOn August 17, 2015, the band\\\'s first show since disbanding in 2013 was announced, headlining the Self Help Fest in San Bernardino, California on March 19, 2016, along with A Day to Remember. In an interview article for Alternative Press, Chamberlain and Gillespie confirmed that the band was reuniting.', NULL, NULL, 'solo', '2025-04-22 16:29:04', '2025-04-22 16:29:04'),
(4, 'Lil Uzi Vert', 'Symere Bysil Woods (born July 31, 1995, Philadelphia, USA), known professionally as Lil Uzi Vert, is an American rapper, singer, and songwriter. Characterized by their face tattoos, facial piercings, eccentric hairstyles, and androgynous fashion, their music is often defined by dark subject matters and imagery built on a melodic emo approach to trap.\\r\\n\\r\\nThey attracted mainstream attention following the release of their debut single \\\"Money Longer\\\" in 2016. The song would act as the lead single for the subsequent mixtape \\\"Lil Uzi Vert vs. the World\\\". After releasing two additional mixtapes in 2016 and 2017, including one in collaboration with Gucci Mane, Lil Uzi Vert was featured on the Billboard Hot 100 chart. They later secured their first top 10 single with \\\"XO Tour Llif3\\\", which won the MTV Video Music Award for Song of the Summer.\\r\\n\\r\\n\\\"XO Tour Llif3\\\" acted as the lead single to Lil Uzi Vert\\\'s debut studio album \\\"Luv Is Rage 2\\\" (2017), which debuted at number one on the Billboard 200, and was certified double platinum by the Recording Industry Association of America (RIAA). At the 2018 Grammy Awards, Lil Uzi Vert was nominated for Best New Artist. Their second studio album \\\"Eternal Atake\\\" (2020) was among the most anticipated albums in hip hop and peaked at number one on the Billboard 200.\\r\\n\\r\\n2010–2015: Career beginnings\\r\\nWoods began to rap in 2010 and began to associate with musical groups like Steaktown, in what he said was \\\"just for money\\\", under the name \\\"Sealab Vertical\\\". They later changed their name to Lil Uzi Vert from the way someone described their rap flow, saying their flow was \\\"Fast, like a machine gun\\\". Woods\\\' first project, an EP titled \\\"Purple Thoughtz Vol. 1\\\", was released on January 19, 2014. The project, which was described as \\\"phonk\\\" and having cloud rap beats due to its psychedelic and \\\"trippy\\\" production, features a bigger focus on lyricism and was released with the single \\\"White Shit\\\". The track, produced by Spaceghostpurrp, went viral in 2017 within hip-hop circles following Woods\\\' entry into the mainstream. Shortly after the release of their first project, Woods caught the attention of then industry-mainstays like Mob.\\r\\n\\r\\nThe EP and following features caught the attention of producer and cofounder of Atlantic Records Don Cannon after DJ Diamond Kuts played one of their songs on a local radio station. Cannon then produced and hosted their first mixtape, \\\"The Real Uzi\\\", which was released on August 5, 2014. After the release of \\\"The Real Uzi\\\", Woods signed a record deal with Atlantic Records through DJ Drama, Don Cannon\\\'s, and Leighton Morrison\\\'s imprint, Generation Now.\\r\\n\\r\\nFollowing their signing to Atlantic Records, Woods was featured alongside Kid and Ferg on Carnage\\\'s single \\\"WDYW\\\". They also released several songs on SoundCloud including \\\"No Wait\\\", produced by Metro Booming, \\\"Pressure\\\", which is a collaboration with Durk, and \\\'\\\'Loaf\\\". He was featured on Fall Out Boy and Khalifa\\\'s \\\"Boys of Zummer\\\" tour in August 2015.\\r\\n\\r\\nWoods released their second mixtape, \\\"Luv Is Rage\\\" on October 30, 2015. The project was received positively and was featured on numerous music blogs such as Fader, XXL, and Vibe. They were further called a \\\"breakout artist of 2015\\\" by HotNewHipHop.\\r\\n\\r\\n2016: Breakthrough\\r\\nIn February 2016, they released the single, \\\"Money Longer\\\" on their SoundCloud following a radio debut on Shade 45.\\r\\n\\r\\nOn April 15, 2016, Vert released their third mixtape and first commercial mixtape \\\"Lil Uzi Vert vs. the World\\\". The mixtape debuted at number 37 on the Billboard 200 chart, making it their first entry on said chart. The project spent 55 weeks on the Billboard 200, eventually being certified Gold. Lil Uzi Vert and Kapri embarked on a joint tour in May 2016, titled the \\\"Parental Advisory\\\" tour.\\r\\n\\r\\nIn June 2016, Uzi appeared in XXL magazine as part of their 2016 Freshmen Class. As part of this appearance, Uzi performed a ‘freshman cypher’ alongside Denzel Curry, Lil Yachty, 21 Savage, and Kodak Black. Riding the wave of recognition the XXL Freshman list gave them, Woods released the video for the single \\\"Money Longer\\\" which debuted on the Billboard Hot 100 the following week, their first entry on the chart, at number 92 on July 2, 2016. The song later peaked at number 54 and is currently certified two times platinum in the United States. Woods\\\' second entry on the chart, \\\"You Was Right\\\", debuted at 89 on July 30, 2016 and peaked at number 40.\\r\\n\\r\\nOn July 12, 2016, Woods announced their fourth mixtape, \\\"The Perfect LUV Tape\\\", which was released on July 31, their 22nd birthday. The mixtape featured the singles \\\"Seven Million\\\", featuring Future, and \\\"Erase Your Social\\\", both of which failed to chart on the Billboard Hot 100. The mixtape debuted at number 55 on the Billboard 200 album chart and is certified Gold by the RIAA. In October 2016, Woods was announced to be an additional artist on The Weeknd\\\'s \\\"Starboy: legend of the Fall\\\" tour.\\r\\n\\r\\nLil Uzi Vert announced a collaboration mixtape with Gucci Mane titled \\\"1017 vs. The World\\\", which was released on November 23, 2016. On the 27th, Uzi announced \\\"Luv Is Rage 2\\\" which went through a series of delays.\\r\\n\\r\\n2017: Luv Is Rage 2\\r\\nUzi was featured on Migos\\\' single \\\"Bad and Boujee\\\". The single was released on August 31, 2016, and its from the trio\\\'s second studio album \\\"Culture\\\". In January 2017, around the time the album was released, the single reached the top of the US Billboard Hot 100, becoming Uzi\\\'s first number 1 single as a lead or featured artist, and their highest charting single as both. On February 27, 2017, Woods released the EP \\\"Luv Is Rage 1.5\\\" while on tour with The Weeknd. The EP was positively received for its \\\"nerdy\\\" nature, with Kingdom Hearts themed instrumentals and lyrics referring to anime, Steven Universe, and hentai. The EP was also credited as the start of Uzi\\\'s affiliation with the \\\"emo-rapper\\\" label due to the heartbreak-associated lyrics on the song \\\"Luv Scars K.o 1600\\\" and references to threats of suicide and depression on the stand-out track \\\"XO Tour Llif3\\\".\\r\\n\\r\\n\\\"XO Tour Llif3\\\" got significant popularity on SoundCloud, resulting in Uzi playing it live on the European leg of The Weeknd\\\'s tour, and the following week the song was added to streaming services and released as an official single. On April 4, 2017, \\\"Xo Tour Llif3\\\" debuted on Billboard Hot 100 at number 49 and peaked at number 7, becoming the rapper\\\'s highest charting song and biggest song, being certified 6x platinum as of August 2018.\\r\\n\\r\\n\\\"Luv Is Rage 2\\\" was delayed again on April 2, 2017, with Uzi blaming it on DJ Drama. On April 9, Don Cannon confirmed the project wasn\\\'t getting released \\\"any time soon\\\" and confirmed that \\\"XO Tour Llif3\\\" would be on the album. Uzi was featured on fellow rapper Playboi Carti\\\'s single \\\"wokeuplikethis*\\\", released on April 7. The single was performed by the pair at Coachella 2017.\\r\\n\\r\\n\\\"wokeuplikethis*\\\" was eventually certified platinum and peaked at number 76 on the Billboard Hot 100. Uzi was featured alongside ASAP Rocky, Playboi Carti, Quavo, and Frank Ocean on A$AP rappers collective Mob\\\'s single \\\"RAF\\\". The single was released by surprise on May 15, 2017. In early August, hip-hop media personality DJ Akademiks claimed that \\\"Luv Is Rage 2\\\" would be released within 30 days. On August 24, 2017, \\\"Luv Is Rage 2\\\" was announced for a surprise release at midnight, and on August 25, 2017, Lil Uzi Vert released their heavily delayed debut studio album, which included \\\"XO TOUR Llif3\\\" as the lead single.\\r\\n\\r\\nThe album debuted at number one on the Billboard 200 albums chart, with 135,000 album-equivalent units, and has since been certified platinum. The album also created ten Billboard Hot 100 charting singles, with two of them, \\\"The Way Life Goes\\\" and \\\"Sauce It Up\\\", becoming singles. During british singer Ed Sheeran\\\'s set at the Video Music Awards, Uzi Vert and Sheeran performed a medley of \\\"XO Tour Llif3\\\" and Sheeran\\\'s chart-topping single, \\\"Shape Of You\\\".\\r\\n\\r\\nIn September 2017, Woods teased a possible sequel project to \\\"Lil Uzi Vert vs The World\\\", possibly titled \\\"Lil Uzi Vert vs. The World 2\\\", and a collaboration project with Playboi Carti titled \\\"16*29\\\". In October, a joint tour with Playboi Carti called the \\\"16*29 tour\\\" was announced, further promoting the possibility of a collaboration project. The tour was canceled shortly thereafter due to Uzi claiming he needed to \\\"focus\\\". In October 2017, Uzi headlined Power 105.1\\\'s annual Powerhouse music celebration alongside The Weeknd, Migos, and Cardi B, at the Barclays Center in Brooklyn, New York. Uzi was also featured on Canadian rapper Nav\\\'s platinum-certified single \\\"Wanted You\\\". The song was released on November 3, 2017.\\r\\n\\r\\nOn December 4, 2017, \\\"The Way Life Goes\\\" music video was released with a remix featuring Nicki Minaj. The song peaked at number 24 on the Billboard Hot 100. Uzi Vert performed the song on Stephen Colbert\\\'s The Late Show on February 6, 2018.\\r\\n\\r\\nThey were featured alongside Kanye West on Travis Scott\\\'s song, \\\"Watch\\\", which was released on May 3, 2018. \\\"Watch\\\" debuted at number 16 on the Billboard Hot 100 chart. They were also featured on a remix for fellow rapper Lil Tracy\\\'s single \\\"Like a Farmer\\\".\\r\\n\\r\\n2018–2020: Eternal Atake, Lil Uzi Vert vs. The World 2, and Pluto x Baby Pluto\\r\\n\\r\\nIn January 2018, Uzi announced that he had completed a mixtape with record producer Wheezy. In May 2018, Don Cannon confirmed that a new Uzi project was dropping that year and speculation arose in July 2018 when Uzi tweeted the words \\\"Eternal Atake\\\", the title of their second studio album, pinning the tweet and announcing it was \\\"coming soon\\\", then at the end of the month sharing the then-chosen cover art for the project. The art referenced the logo of the cult Heavens Gate. The two members who survived the cult suggested that legal actions could be taken against Uzi for copying the logo style.\\r\\n\\r\\nThe art was the source of a threat from the remaining members of the organization over a legal attack. The then-thought lead single for the album, \\\"New Patek\\\" was released on September 18, 2018. Uzi was then featured on Lil Pump\\\'s single, \\\"Multi Millionaire\\\". The single was released on October 5, 2018.\\r\\n\\r\\nIn April 2019, following label trouble with Generation Now, it was announced that Uzi was now signed to Roc Nation. Two new promotional singles were released in April 2019, titled \\\"Sanguine Paradise\\\" and \\\"That\\\'s a Rack\\\", originally thought to be from their highly anticipated studio album, \\\"Eternal Atake\\\".\\r\\n\\r\\nOn December 13, 2019, Uzi released a new single titled \\\"Futsal Shuffle 2020\\\", which is the lead single of \\\"Eternal Atake\\\". The rapper then released the second single of the album, \\\"That Way\\\", on March 1, 2020.\\r\\n\\r\\n\\\"Eternal Atake\\\" was released on March 6, 2020, with a sole guest appearance from American singer Syd. \\\"New Patek\\\", \\\"That\\\'s a Rack\\\" and \\\"Sanguine Paradise\\\" did not appear on the album. \\\"Eternal Atake\\\" debuted atop the Billboard 200.\\r\\n\\r\\nOn March 12, 2020, Lil Uzi teased that the deluxe version of \\\"Eternal Atake\\\" and the sequel to their 2016 mixtape, \\\"Lil Uzi Vert vs. the World\\\", titled \\\"Lil Uzi Vert vs. the World 2\\\", would be released the following day, the date fans expected the release date of the original album.\\r\\n\\r\\nThe deluxe edition would have fourteen new tracks, featuring guest appearances from Chief Keef, 21 Savage, Future, Young Thug, Gunna, Lil Durk, Young Nudy, and Nav. The first half of the album maintained a leading number 1 position with 400 million streams in early 2020. This marked the largest streaming count for any album since 2018, when Lil Wayne\\\'s twelfth studio album, \\\"Tha Carter V\\\", got 433 million streams.\\r\\n\\r\\nOn April 24, 2020, Lil Uzi Vert released a new single titled \\\"Sasuke\\\". On July 10, Lil Uzi appeared on the remix of StaySolidRocky\\\'s \\\"Party Girl\\\". On July 21, Lil Uzi and Future hinted at an upcoming joint project titled \\\"Pluto x Baby Pluto\\\" on their social medias; it was released on November 13, 2020, and peaked at number two on the Billboard 200.\\r\\n\\r\\n2021–2022: Subsequent ventures\\r\\nIn late 2020, Lil Uzi Vert began promoting new singles on Instagram Live that were sonically similar to popular releases early on in their career. He announced an upcoming project titled \\\"Forever Young\\\", as well as a follow-up to \\\"Luv Is Rage 2\\\".\\r\\n\\r\\nFrom the 16th to the 22nd of july 2022, Uzi released 4 songs from their EP, RED & WHITE on their SoundCloud account day by day, then, on the 22nd, the rest of the EP was released.\\r\\n\\r\\n2023 - Present\\r\\nIn June 2023, Uzi noted that the album would be released that same month. On the 17th, Uzi had taken to Instagram to post an alternate cover art to the project. He also announced that the cover art would release in \\\"a couple of days\\\" and that the tracklist would release \\\"this week,\\\" while confirming the release date of June 30.\\r\\n\\r\\nOn June 26, 2023, Uzi revealed the cover art and the release date on their website and simultaneously released the Gibson Hazard directed trailer for the album. Days prior to it\\\'s official announcement, Uzi threw an album release party — which he named “The Pink Tape Prom” — in which he previewed several tracks from the project.\\r\\n\\r\\nOn June 30, 2023, Lil Uzi Vert released the highly anticipated album, \\\"Pink Tape\\\". The album contains guest appearances from Travis Scott, Nicki Minaj, Bring Me The Horizon, Don Toliver, and Babymetal.', NULL, NULL, 'solo', '2025-04-22 16:29:05', '2025-04-22 16:29:05'),
(5, 'Daryl Palumbo', NULL, NULL, NULL, 'solo', '2025-04-22 16:29:05', '2025-04-22 16:29:05'),
(6, 'Glassjaw', NULL, NULL, NULL, 'solo', '2025-04-22 16:29:05', '2025-04-22 16:29:05'),
(7, 'YUNGBLUD', NULL, NULL, NULL, 'solo', '2025-04-22 16:29:05', '2025-04-22 16:29:05'),
(8, 'BABYMETAL', NULL, NULL, NULL, 'solo', '2025-04-22 16:29:05', '2025-04-22 16:29:05'),
(9, 'Nova Twins', NULL, NULL, NULL, 'solo', '2025-04-22 16:29:05', '2025-04-22 16:29:05'),
(10, 'Amy Lee', NULL, NULL, NULL, 'solo', '2025-04-22 16:29:05', '2025-04-22 16:29:05'),
(11, 'Halsey', NULL, NULL, NULL, 'solo', '2025-04-22 16:29:07', '2025-04-22 16:29:07'),
(12, 'BEXEY', NULL, NULL, NULL, 'solo', '2025-04-22 16:29:07', '2025-04-22 16:29:07'),
(13, 'Lotus Eater', NULL, NULL, NULL, 'solo', '2025-04-22 16:29:07', '2025-04-22 16:29:07'),
(14, 'Happyalone.', NULL, NULL, NULL, 'solo', '2025-04-22 16:29:07', '2025-04-22 16:29:07'),
(15, 'Toriel', NULL, NULL, NULL, 'solo', '2025-04-22 16:29:07', '2025-04-22 16:29:07'),
(16, 'YONAKA', NULL, NULL, NULL, 'solo', '2025-04-22 16:29:07', '2025-04-22 16:29:07'),
(17, 'Grimes', NULL, NULL, NULL, 'solo', '2025-04-22 16:29:08', '2025-04-22 16:29:08'),
(18, 'Dani Filth', NULL, NULL, NULL, 'solo', '2025-04-22 16:29:08', '2025-04-22 16:29:08'),
(19, 'Rahzel', NULL, NULL, NULL, 'solo', '2025-04-22 16:29:08', '2025-04-22 16:29:08'),
(20, 'Lights', NULL, NULL, NULL, 'solo', '2025-04-22 16:29:11', '2025-04-22 16:29:11'),
(21, 'Josh Franceschi', NULL, NULL, NULL, 'solo', '2025-04-22 16:29:11', '2025-04-22 16:29:11'),
(22, 'Josh Scogin', NULL, NULL, NULL, 'solo', '2025-04-22 16:29:11', '2025-04-22 16:29:11'),
(23, 'Borgore', NULL, NULL, NULL, 'solo', '2025-04-22 16:29:11', '2025-04-22 16:29:11'),
(24, 'JJ Peters', NULL, NULL, NULL, 'solo', '2025-04-22 16:29:12', '2025-04-22 16:29:12'),
(25, 'Sam Carter', NULL, NULL, NULL, 'solo', '2025-04-22 16:29:12', '2025-04-22 16:29:12'),
(26, 'Robotsonics', NULL, NULL, NULL, 'solo', '2025-04-22 16:29:12', '2025-04-22 16:29:12'),
(27, 'KC Blitz', NULL, NULL, NULL, 'solo', '2025-04-22 16:29:12', '2025-04-22 16:29:12'),
(28, 'L\'Amour La Morgue', NULL, NULL, NULL, 'solo', '2025-04-22 16:29:12', '2025-04-22 16:29:12'),
(29, 'The Toxic Avenger', NULL, NULL, NULL, 'band', '2025-04-22 16:29:12', '2025-04-22 16:29:12'),
(30, 'After the Night', NULL, NULL, NULL, 'solo', '2025-04-22 16:29:12', '2025-04-22 16:29:12'),
(31, 'Tek-One', NULL, NULL, NULL, 'solo', '2025-04-22 16:29:12', '2025-04-22 16:29:12'),
(32, 'I Haunt Wizards', NULL, NULL, NULL, 'solo', '2025-04-22 16:29:12', '2025-04-22 16:29:12'),
(33, 'Skrillex', NULL, NULL, NULL, 'solo', '2025-04-22 16:29:12', '2025-04-22 16:29:12'),
(34, 'Ben Weinman', NULL, NULL, NULL, 'solo', '2025-04-22 16:29:12', '2025-04-22 16:29:12'),
(35, 'The Secret Handshake', NULL, NULL, NULL, 'band', '2025-04-22 16:29:12', '2025-04-22 16:29:12'),
(36, 'Oli Sykes', NULL, NULL, NULL, 'solo', '2025-04-22 16:29:17', '2025-04-22 16:29:17'),
(37, 'CORPSE', NULL, NULL, NULL, 'solo', '2025-04-22 16:29:17', '2025-04-22 16:29:17'),
(38, 'SLANDER', NULL, NULL, NULL, 'solo', '2025-04-22 16:29:19', '2025-04-22 16:29:19'),
(39, 'blackbear', NULL, NULL, NULL, 'solo', '2025-04-22 16:29:19', '2025-04-22 16:29:19'),
(40, 'Sigrid', NULL, NULL, NULL, 'solo', '2025-04-22 16:29:22', '2025-04-22 16:29:22'),
(41, 'Masked Wolf', NULL, NULL, NULL, 'solo', '2025-04-22 16:29:23', '2025-04-22 16:29:23'),
(42, 'Ed Sheeran', NULL, NULL, NULL, 'solo', '2025-04-22 16:29:24', '2025-04-22 16:29:24'),
(43, 'six impala', NULL, NULL, NULL, 'solo', '2025-04-22 16:29:25', '2025-04-22 16:29:25'),
(44, 'IC3PEAK', NULL, NULL, NULL, 'solo', '2025-04-22 16:29:26', '2025-04-22 16:29:26'),
(45, 'Tom Morello', NULL, NULL, NULL, 'solo', '2025-04-22 16:29:27', '2025-04-22 16:29:27'),
(46, 'Olivia O\'Brien', NULL, NULL, NULL, 'solo', '2025-04-22 16:29:28', '2025-04-22 16:29:28'),
(47, 'Jeris Johnson', NULL, NULL, NULL, 'solo', '2025-04-22 16:29:29', '2025-04-22 16:29:29'),
(48, 'Death Stranding: Timefall', NULL, NULL, NULL, 'solo', '2025-04-22 16:29:32', '2025-04-22 16:29:32'),
(49, 'Sub Focus', NULL, NULL, NULL, 'solo', '2025-04-22 16:29:34', '2025-04-22 16:29:34'),
(50, 'Shikari Sound System', NULL, NULL, NULL, 'solo', '2025-04-22 16:29:40', '2025-04-22 16:29:40'),
(51, 'Jakwob', NULL, NULL, NULL, 'solo', '2025-04-22 16:29:40', '2025-04-22 16:29:40'),
(52, 'Bring Babangida', NULL, NULL, NULL, 'solo', '2025-04-24 19:28:04', '2025-04-24 19:28:04'),
(53, 'Linkin Bring Pachuca', NULL, NULL, NULL, 'band', '2025-04-24 19:28:29', '2025-04-24 19:28:29'),
(54, 'R1fmaBringBes', NULL, NULL, NULL, 'solo', '2025-04-24 19:29:33', '2025-04-24 19:29:33'),
(55, 'Halloween Bring Poh', NULL, NULL, NULL, 'solo', '2025-04-24 19:29:45', '2025-04-24 19:29:45'),
(56, 'Raybax brInG king', NULL, NULL, NULL, 'solo', '2025-04-24 19:30:19', '2025-04-24 19:30:19');

-- --------------------------------------------------------

--
-- Table structure for table `artists_genres`
--

CREATE TABLE `artists_genres` (
  `artist_id` bigint(20) UNSIGNED NOT NULL,
  `genre_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `artists_genres`
--

INSERT INTO `artists_genres` (`artist_id`, `genre_id`, `created_at`, `updated_at`) VALUES
(1, 1, '2025-04-22 16:30:06', '2025-04-22 16:30:06'),
(1, 2, '2025-04-22 16:30:06', '2025-04-22 16:30:06'),
(1, 3, '2025-04-22 16:30:07', '2025-04-22 16:30:07'),
(1, 4, '2025-04-22 16:30:07', '2025-04-22 16:30:07'),
(1, 5, '2025-04-22 16:30:07', '2025-04-22 16:30:07');

-- --------------------------------------------------------

--
-- Table structure for table `artists_releases`
--

CREATE TABLE `artists_releases` (
  `artist_id` bigint(20) UNSIGNED NOT NULL,
  `release_id` bigint(20) UNSIGNED NOT NULL,
  `role` enum('primary','featured','producer') NOT NULL DEFAULT 'primary',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `artists_releases`
--

INSERT INTO `artists_releases` (`artist_id`, `release_id`, `role`, `created_at`, `updated_at`) VALUES
(1, 1, 'primary', '2025-04-22 16:29:04', '2025-04-22 16:29:04'),
(1, 2, 'primary', '2025-04-22 16:29:05', '2025-04-22 16:29:05'),
(1, 3, 'primary', '2025-04-22 16:29:06', '2025-04-22 16:29:06'),
(1, 4, 'primary', '2025-04-22 16:29:07', '2025-04-22 16:29:07'),
(1, 5, 'primary', '2025-04-22 16:29:08', '2025-04-22 16:29:08'),
(1, 6, 'primary', '2025-04-22 16:29:09', '2025-04-22 16:29:09'),
(1, 7, 'primary', '2025-04-22 16:29:10', '2025-04-22 16:29:10'),
(1, 8, 'primary', '2025-04-22 16:29:11', '2025-04-22 16:29:11'),
(1, 9, 'primary', '2025-04-22 16:29:12', '2025-04-22 16:29:12'),
(1, 10, 'primary', '2025-04-22 16:29:13', '2025-04-22 16:29:13'),
(1, 11, 'primary', '2025-04-22 16:29:14', '2025-04-22 16:29:14'),
(1, 12, 'primary', '2025-04-22 16:29:14', '2025-04-22 16:29:33'),
(1, 13, 'primary', '2025-04-22 16:29:15', '2025-04-22 16:29:15'),
(1, 14, 'primary', '2025-04-22 16:29:16', '2025-04-22 16:29:16'),
(1, 15, 'primary', '2025-04-22 16:29:17', '2025-04-22 16:29:17'),
(1, 16, 'primary', '2025-04-22 16:29:17', '2025-04-22 16:29:17'),
(1, 17, 'primary', '2025-04-22 16:29:18', '2025-04-22 16:29:18'),
(1, 18, 'primary', '2025-04-22 16:29:19', '2025-04-22 16:29:19'),
(1, 19, 'primary', '2025-04-22 16:29:19', '2025-04-22 16:29:19'),
(1, 20, 'primary', '2025-04-22 16:29:20', '2025-04-22 16:29:20'),
(1, 21, 'primary', '2025-04-22 16:29:21', '2025-04-22 16:29:21'),
(1, 22, 'primary', '2025-04-22 16:29:22', '2025-04-22 16:29:22'),
(1, 23, 'primary', '2025-04-22 16:29:22', '2025-04-22 16:29:22'),
(1, 24, 'primary', '2025-04-22 16:29:23', '2025-04-22 16:29:23'),
(1, 25, 'primary', '2025-04-22 16:29:24', '2025-04-22 16:29:24'),
(1, 26, 'primary', '2025-04-22 16:29:25', '2025-04-22 16:29:25'),
(1, 27, 'primary', '2025-04-22 16:29:25', '2025-04-22 16:29:25'),
(1, 28, 'primary', '2025-04-22 16:29:26', '2025-04-22 16:29:26'),
(1, 29, 'primary', '2025-04-22 16:29:27', '2025-04-22 16:29:27'),
(1, 30, 'primary', '2025-04-22 16:29:27', '2025-04-22 16:29:27'),
(1, 31, 'primary', '2025-04-22 16:29:28', '2025-04-22 16:29:28'),
(1, 32, 'primary', '2025-04-22 16:29:29', '2025-04-22 16:29:29'),
(1, 33, 'primary', '2025-04-22 16:29:30', '2025-04-22 16:29:30'),
(1, 34, 'primary', '2025-04-22 16:29:30', '2025-04-22 16:29:30'),
(1, 35, 'primary', '2025-04-22 16:29:31', '2025-04-22 16:29:31'),
(1, 36, 'primary', '2025-04-22 16:29:32', '2025-04-22 16:29:32'),
(1, 37, 'primary', '2025-04-22 16:29:32', '2025-04-22 16:29:32'),
(1, 38, 'primary', '2025-04-22 16:29:34', '2025-04-22 16:29:34'),
(1, 39, 'primary', '2025-04-22 16:29:35', '2025-04-22 16:29:35'),
(1, 40, 'primary', '2025-04-22 16:29:35', '2025-04-22 16:29:35'),
(1, 41, 'primary', '2025-04-22 16:29:36', '2025-04-22 16:29:36'),
(1, 42, 'primary', '2025-04-22 16:29:37', '2025-04-22 16:29:37'),
(1, 43, 'primary', '2025-04-22 16:29:37', '2025-04-22 16:29:37'),
(1, 44, 'primary', '2025-04-22 16:29:38', '2025-04-22 16:29:38'),
(1, 45, 'primary', '2025-04-22 16:29:39', '2025-04-22 16:29:39'),
(1, 46, 'primary', '2025-04-22 16:29:39', '2025-04-22 16:29:39'),
(1, 47, 'primary', '2025-04-22 16:29:40', '2025-04-22 16:29:40'),
(1, 48, 'primary', '2025-04-22 16:29:41', '2025-04-22 16:29:41'),
(1, 49, 'primary', '2025-04-22 16:29:42', '2025-04-22 16:29:42'),
(4, 17, 'primary', '2025-04-22 16:29:18', '2025-04-22 16:29:18'),
(4, 18, 'primary', '2025-04-22 16:29:19', '2025-04-22 16:29:19'),
(5, 18, 'primary', '2025-04-22 16:29:19', '2025-04-22 16:29:19'),
(7, 15, 'primary', '2025-04-22 16:29:17', '2025-04-22 16:29:17'),
(7, 34, 'primary', '2025-04-22 16:29:30', '2025-04-22 16:29:30'),
(36, 15, 'primary', '2025-04-22 16:29:17', '2025-04-22 16:29:17'),
(36, 28, 'primary', '2025-04-22 16:29:26', '2025-04-22 16:29:26'),
(36, 31, 'primary', '2025-04-22 16:29:28', '2025-04-22 16:29:28'),
(37, 16, 'primary', '2025-04-22 16:29:17', '2025-04-22 16:29:17'),
(38, 19, 'primary', '2025-04-22 16:29:19', '2025-04-22 16:29:19'),
(39, 19, 'primary', '2025-04-22 16:29:19', '2025-04-22 16:29:19'),
(40, 22, 'primary', '2025-04-22 16:29:22', '2025-04-22 16:29:22'),
(40, 23, 'primary', '2025-04-22 16:29:22', '2025-04-22 16:29:22'),
(41, 24, 'primary', '2025-04-22 16:29:23', '2025-04-22 16:29:23'),
(42, 25, 'primary', '2025-04-22 16:29:24', '2025-04-22 16:29:24'),
(43, 27, 'primary', '2025-04-22 16:29:25', '2025-04-22 16:29:25'),
(44, 28, 'primary', '2025-04-22 16:29:26', '2025-04-22 16:29:26'),
(45, 29, 'primary', '2025-04-22 16:29:27', '2025-04-22 16:29:27'),
(46, 31, 'primary', '2025-04-22 16:29:28', '2025-04-22 16:29:28'),
(47, 32, 'primary', '2025-04-22 16:29:29', '2025-04-22 16:29:29'),
(48, 36, 'primary', '2025-04-22 16:29:32', '2025-04-22 16:29:32'),
(49, 38, 'primary', '2025-04-22 16:29:34', '2025-04-22 16:29:34');

-- --------------------------------------------------------

--
-- Table structure for table `artists_tracks`
--

CREATE TABLE `artists_tracks` (
  `artist_id` bigint(20) UNSIGNED NOT NULL,
  `track_id` bigint(20) UNSIGNED NOT NULL,
  `role` enum('primary','featured','producer') NOT NULL DEFAULT 'primary',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `artists_tracks`
--

INSERT INTO `artists_tracks` (`artist_id`, `track_id`, `role`, `created_at`, `updated_at`) VALUES
(1, 1, 'primary', '2025-04-22 16:29:04', '2025-04-22 16:29:04'),
(1, 2, 'primary', '2025-04-22 16:29:04', '2025-04-22 16:29:04'),
(1, 3, 'primary', '2025-04-22 16:29:04', '2025-04-22 16:29:15'),
(1, 4, 'primary', '2025-04-22 16:29:04', '2025-04-22 16:29:04'),
(1, 5, 'primary', '2025-04-22 16:29:04', '2025-04-22 16:29:04'),
(1, 6, 'primary', '2025-04-22 16:29:04', '2025-04-22 16:29:16'),
(1, 7, 'primary', '2025-04-22 16:29:04', '2025-04-22 16:29:04'),
(1, 8, 'primary', '2025-04-22 16:29:04', '2025-04-22 16:29:04'),
(1, 9, 'primary', '2025-04-22 16:29:04', '2025-04-22 16:29:04'),
(1, 10, 'primary', '2025-04-22 16:29:04', '2025-04-22 16:29:20'),
(1, 11, 'primary', '2025-04-22 16:29:05', '2025-04-22 16:29:21'),
(1, 12, 'primary', '2025-04-22 16:29:05', '2025-04-22 16:29:05'),
(1, 13, 'primary', '2025-04-22 16:29:05', '2025-04-22 16:29:19'),
(1, 14, 'primary', '2025-04-22 16:29:05', '2025-04-22 16:29:05'),
(1, 15, 'primary', '2025-04-22 16:29:05', '2025-04-22 16:29:27'),
(1, 16, 'primary', '2025-04-22 16:29:05', '2025-04-22 16:29:05'),
(1, 17, 'primary', '2025-04-22 16:29:05', '2025-04-22 16:29:05'),
(1, 18, 'primary', '2025-04-22 16:29:05', '2025-04-22 16:29:31'),
(1, 19, 'primary', '2025-04-22 16:29:05', '2025-04-22 16:29:30'),
(1, 20, 'primary', '2025-04-22 16:29:05', '2025-04-22 16:29:30'),
(1, 21, 'primary', '2025-04-22 16:29:05', '2025-04-22 16:29:05'),
(1, 22, 'primary', '2025-04-22 16:29:05', '2025-04-22 16:29:05'),
(1, 23, 'primary', '2025-04-22 16:29:05', '2025-04-22 16:29:05'),
(1, 24, 'primary', '2025-04-22 16:29:05', '2025-04-22 16:29:32'),
(1, 25, 'primary', '2025-04-22 16:29:05', '2025-04-22 16:29:05'),
(1, 26, 'primary', '2025-04-22 16:29:06', '2025-04-22 16:29:06'),
(1, 27, 'primary', '2025-04-22 16:29:06', '2025-04-22 16:29:06'),
(1, 28, 'primary', '2025-04-22 16:29:06', '2025-04-22 16:29:06'),
(1, 29, 'primary', '2025-04-22 16:29:06', '2025-04-22 16:29:06'),
(1, 30, 'primary', '2025-04-22 16:29:06', '2025-04-22 16:29:06'),
(1, 31, 'primary', '2025-04-22 16:29:06', '2025-04-22 16:29:06'),
(1, 32, 'primary', '2025-04-22 16:29:06', '2025-04-22 16:29:06'),
(1, 33, 'primary', '2025-04-22 16:29:06', '2025-04-22 16:29:06'),
(1, 34, 'primary', '2025-04-22 16:29:06', '2025-04-22 16:29:06'),
(1, 35, 'primary', '2025-04-22 16:29:06', '2025-04-22 16:29:06'),
(1, 36, 'primary', '2025-04-22 16:29:06', '2025-04-22 16:29:06'),
(1, 37, 'primary', '2025-04-22 16:29:06', '2025-04-22 16:29:06'),
(1, 38, 'primary', '2025-04-22 16:29:06', '2025-04-22 16:29:06'),
(1, 39, 'primary', '2025-04-22 16:29:06', '2025-04-22 16:29:06'),
(1, 40, 'primary', '2025-04-22 16:29:06', '2025-04-22 16:29:06'),
(1, 41, 'primary', '2025-04-22 16:29:06', '2025-04-22 16:29:06'),
(1, 42, 'primary', '2025-04-22 16:29:07', '2025-04-22 16:29:07'),
(1, 43, 'primary', '2025-04-22 16:29:07', '2025-04-22 16:29:07'),
(1, 44, 'primary', '2025-04-22 16:29:07', '2025-04-22 16:29:07'),
(1, 45, 'primary', '2025-04-22 16:29:07', '2025-04-22 16:29:07'),
(1, 46, 'primary', '2025-04-22 16:29:07', '2025-04-22 16:29:07'),
(1, 47, 'primary', '2025-04-22 16:29:07', '2025-04-22 16:29:07'),
(1, 48, 'primary', '2025-04-22 16:29:07', '2025-04-22 16:29:07'),
(1, 49, 'primary', '2025-04-22 16:29:07', '2025-04-22 16:29:07'),
(1, 50, 'primary', '2025-04-22 16:29:08', '2025-04-22 16:29:08'),
(1, 51, 'primary', '2025-04-22 16:29:08', '2025-04-22 16:29:37'),
(1, 52, 'primary', '2025-04-22 16:29:08', '2025-04-22 16:29:35'),
(1, 53, 'primary', '2025-04-22 16:29:08', '2025-04-22 16:29:08'),
(1, 54, 'primary', '2025-04-22 16:29:08', '2025-04-22 16:29:37'),
(1, 55, 'primary', '2025-04-22 16:29:08', '2025-04-22 16:29:08'),
(1, 56, 'primary', '2025-04-22 16:29:08', '2025-04-22 16:29:36'),
(1, 57, 'primary', '2025-04-22 16:29:08', '2025-04-22 16:29:08'),
(1, 58, 'primary', '2025-04-22 16:29:08', '2025-04-22 16:29:08'),
(1, 59, 'primary', '2025-04-22 16:29:08', '2025-04-22 16:29:08'),
(1, 60, 'primary', '2025-04-22 16:29:08', '2025-04-22 16:29:35'),
(1, 61, 'primary', '2025-04-22 16:29:08', '2025-04-22 16:29:08'),
(1, 62, 'primary', '2025-04-22 16:29:08', '2025-04-22 16:29:08'),
(1, 63, 'primary', '2025-04-22 16:29:09', '2025-04-22 16:29:09'),
(1, 64, 'primary', '2025-04-22 16:29:09', '2025-04-22 16:29:09'),
(1, 65, 'primary', '2025-04-22 16:29:09', '2025-04-22 16:29:09'),
(1, 66, 'primary', '2025-04-22 16:29:09', '2025-04-22 16:29:09'),
(1, 67, 'primary', '2025-04-22 16:29:09', '2025-04-22 16:29:09'),
(1, 68, 'primary', '2025-04-22 16:29:09', '2025-04-22 16:29:09'),
(1, 69, 'primary', '2025-04-22 16:29:09', '2025-04-22 16:29:09'),
(1, 70, 'primary', '2025-04-22 16:29:09', '2025-04-22 16:29:09'),
(1, 71, 'primary', '2025-04-22 16:29:09', '2025-04-22 16:29:09'),
(1, 72, 'primary', '2025-04-22 16:29:09', '2025-04-22 16:29:09'),
(1, 73, 'primary', '2025-04-22 16:29:09', '2025-04-22 16:29:09'),
(1, 74, 'primary', '2025-04-22 16:29:10', '2025-04-22 16:29:42'),
(1, 75, 'primary', '2025-04-22 16:29:10', '2025-04-22 16:29:10'),
(1, 76, 'primary', '2025-04-22 16:29:10', '2025-04-22 16:29:10'),
(1, 77, 'primary', '2025-04-22 16:29:10', '2025-04-22 16:29:42'),
(1, 78, 'primary', '2025-04-22 16:29:10', '2025-04-22 16:29:42'),
(1, 79, 'primary', '2025-04-22 16:29:10', '2025-04-22 16:29:42'),
(1, 80, 'primary', '2025-04-22 16:29:10', '2025-04-22 16:29:10'),
(1, 81, 'primary', '2025-04-22 16:29:10', '2025-04-22 16:29:10'),
(1, 82, 'primary', '2025-04-22 16:29:10', '2025-04-22 16:29:42'),
(1, 83, 'primary', '2025-04-22 16:29:10', '2025-04-22 16:29:10'),
(1, 84, 'primary', '2025-04-22 16:29:10', '2025-04-22 16:29:10'),
(1, 85, 'primary', '2025-04-22 16:29:10', '2025-04-22 16:29:10'),
(1, 86, 'primary', '2025-04-22 16:29:10', '2025-04-22 16:29:10'),
(1, 87, 'primary', '2025-04-22 16:29:11', '2025-04-22 16:29:11'),
(1, 88, 'primary', '2025-04-22 16:29:11', '2025-04-22 16:29:11'),
(1, 89, 'primary', '2025-04-22 16:29:11', '2025-04-22 16:29:42'),
(1, 90, 'primary', '2025-04-22 16:29:11', '2025-04-22 16:29:11'),
(1, 91, 'primary', '2025-04-22 16:29:11', '2025-04-22 16:29:11'),
(1, 92, 'primary', '2025-04-22 16:29:11', '2025-04-22 16:29:11'),
(1, 93, 'primary', '2025-04-22 16:29:11', '2025-04-22 16:29:11'),
(1, 94, 'primary', '2025-04-22 16:29:11', '2025-04-22 16:29:11'),
(1, 95, 'primary', '2025-04-22 16:29:11', '2025-04-22 16:29:11'),
(1, 96, 'primary', '2025-04-22 16:29:11', '2025-04-22 16:29:11'),
(1, 97, 'primary', '2025-04-22 16:29:11', '2025-04-22 16:29:42'),
(1, 98, 'primary', '2025-04-22 16:29:11', '2025-04-22 16:29:11'),
(1, 99, 'primary', '2025-04-22 16:29:11', '2025-04-22 16:29:11'),
(1, 100, 'primary', '2025-04-22 16:29:12', '2025-04-22 16:29:42'),
(1, 101, 'primary', '2025-04-22 16:29:12', '2025-04-22 16:29:42'),
(1, 102, 'primary', '2025-04-22 16:29:12', '2025-04-22 16:29:13'),
(1, 103, 'primary', '2025-04-22 16:29:12', '2025-04-22 16:29:13'),
(1, 104, 'primary', '2025-04-22 16:29:12', '2025-04-22 16:29:13'),
(1, 105, 'primary', '2025-04-22 16:29:12', '2025-04-22 16:29:13'),
(1, 106, 'primary', '2025-04-22 16:29:12', '2025-04-22 16:29:42'),
(1, 107, 'primary', '2025-04-22 16:29:12', '2025-04-22 16:29:13'),
(1, 108, 'primary', '2025-04-22 16:29:12', '2025-04-22 16:29:13'),
(1, 109, 'primary', '2025-04-22 16:29:12', '2025-04-22 16:29:13'),
(1, 110, 'primary', '2025-04-22 16:29:12', '2025-04-22 16:29:12'),
(1, 111, 'primary', '2025-04-22 16:29:12', '2025-04-22 16:29:12'),
(1, 112, 'primary', '2025-04-22 16:29:12', '2025-04-22 16:29:12'),
(1, 113, 'primary', '2025-04-22 16:29:12', '2025-04-22 16:29:12'),
(1, 114, 'primary', '2025-04-22 16:29:12', '2025-04-22 16:29:12'),
(1, 115, 'primary', '2025-04-22 16:29:12', '2025-04-22 16:29:12'),
(1, 116, 'primary', '2025-04-22 16:29:12', '2025-04-22 16:29:12'),
(1, 117, 'primary', '2025-04-22 16:29:12', '2025-04-22 16:29:12'),
(1, 118, 'primary', '2025-04-22 16:29:12', '2025-04-22 16:29:12'),
(1, 119, 'primary', '2025-04-22 16:29:12', '2025-04-22 16:29:12'),
(1, 120, 'primary', '2025-04-22 16:29:14', '2025-04-22 16:29:42'),
(1, 121, 'primary', '2025-04-22 16:29:14', '2025-04-22 16:29:14'),
(1, 122, 'primary', '2025-04-22 16:29:14', '2025-04-22 16:29:14'),
(1, 123, 'primary', '2025-04-22 16:29:14', '2025-04-22 16:29:14'),
(1, 124, 'primary', '2025-04-22 16:29:14', '2025-04-22 16:29:14'),
(1, 125, 'primary', '2025-04-22 16:29:14', '2025-04-22 16:29:14'),
(1, 126, 'primary', '2025-04-22 16:29:14', '2025-04-22 16:29:14'),
(1, 127, 'primary', '2025-04-22 16:29:14', '2025-04-22 16:29:14'),
(1, 128, 'primary', '2025-04-22 16:29:14', '2025-04-22 16:29:14'),
(1, 129, 'primary', '2025-04-22 16:29:14', '2025-04-22 16:29:14'),
(1, 130, 'primary', '2025-04-22 16:29:14', '2025-04-22 16:29:14'),
(1, 131, 'primary', '2025-04-22 16:29:14', '2025-04-22 16:29:14'),
(1, 132, 'primary', '2025-04-22 16:29:17', '2025-04-22 16:29:17'),
(1, 133, 'primary', '2025-04-22 16:29:17', '2025-04-22 16:29:17'),
(1, 134, 'primary', '2025-04-22 16:29:18', '2025-04-22 16:29:18'),
(1, 135, 'primary', '2025-04-22 16:29:19', '2025-04-22 16:29:19'),
(1, 136, 'primary', '2025-04-22 16:29:22', '2025-04-22 16:29:22'),
(1, 137, 'primary', '2025-04-22 16:29:22', '2025-04-22 16:29:22'),
(1, 138, 'primary', '2025-04-22 16:29:22', '2025-04-22 16:29:22'),
(1, 139, 'primary', '2025-04-22 16:29:23', '2025-04-22 16:29:23'),
(1, 140, 'primary', '2025-04-22 16:29:24', '2025-04-22 16:29:24'),
(1, 141, 'primary', '2025-04-22 16:29:25', '2025-04-22 16:29:25'),
(1, 142, 'primary', '2025-04-22 16:29:25', '2025-04-22 16:29:25'),
(1, 143, 'primary', '2025-04-22 16:29:26', '2025-04-22 16:29:26'),
(1, 144, 'primary', '2025-04-22 16:29:27', '2025-04-22 16:29:27'),
(1, 145, 'primary', '2025-04-22 16:29:28', '2025-04-22 16:29:28'),
(1, 146, 'primary', '2025-04-22 16:29:29', '2025-04-22 16:29:29'),
(1, 147, 'primary', '2025-04-22 16:29:32', '2025-04-22 16:29:32'),
(1, 148, 'primary', '2025-04-22 16:29:33', '2025-04-22 16:29:33'),
(1, 149, 'primary', '2025-04-22 16:29:33', '2025-04-22 16:29:33'),
(1, 150, 'primary', '2025-04-22 16:29:34', '2025-04-22 16:29:34'),
(1, 151, 'primary', '2025-04-22 16:29:38', '2025-04-22 16:29:38'),
(1, 152, 'primary', '2025-04-22 16:29:39', '2025-04-22 16:29:39'),
(1, 153, 'primary', '2025-04-22 16:29:40', '2025-04-22 16:29:40'),
(1, 154, 'primary', '2025-04-22 16:29:40', '2025-04-22 16:29:40'),
(1, 155, 'primary', '2025-04-22 16:29:40', '2025-04-22 16:29:40'),
(1, 156, 'primary', '2025-04-22 16:29:41', '2025-04-22 16:29:41'),
(1, 157, 'primary', '2025-04-22 16:29:41', '2025-04-22 16:29:41'),
(1, 158, 'primary', '2025-04-22 16:29:41', '2025-04-22 16:29:41'),
(1, 159, 'primary', '2025-04-22 16:29:41', '2025-04-22 16:29:42'),
(1, 160, 'primary', '2025-04-22 16:29:42', '2025-04-22 16:29:42'),
(1, 161, 'primary', '2025-04-22 16:29:42', '2025-04-22 16:29:42'),
(1, 162, 'primary', '2025-04-22 16:29:42', '2025-04-22 16:29:42'),
(2, 5, 'featured', '2025-04-22 16:29:04', '2025-04-22 16:29:04'),
(3, 7, 'featured', '2025-04-22 16:29:04', '2025-04-22 16:29:04'),
(4, 13, 'primary', '2025-04-22 16:29:05', '2025-04-22 16:29:19'),
(4, 134, 'primary', '2025-04-22 16:29:18', '2025-04-22 16:29:18'),
(5, 13, 'primary', '2025-04-22 16:29:05', '2025-04-22 16:29:19'),
(6, 13, 'featured', '2025-04-22 16:29:05', '2025-04-22 16:29:19'),
(7, 20, 'primary', '2025-04-22 16:29:05', '2025-04-22 16:29:30'),
(7, 132, 'primary', '2025-04-22 16:29:17', '2025-04-22 16:29:17'),
(8, 22, 'featured', '2025-04-22 16:29:05', '2025-04-22 16:29:05'),
(9, 23, 'featured', '2025-04-22 16:29:05', '2025-04-22 16:29:05'),
(10, 25, 'featured', '2025-04-22 16:29:05', '2025-04-22 16:29:05'),
(11, 45, 'featured', '2025-04-22 16:29:07', '2025-04-22 16:29:07'),
(12, 46, 'featured', '2025-04-22 16:29:07', '2025-04-22 16:29:07'),
(13, 46, 'featured', '2025-04-22 16:29:07', '2025-04-22 16:29:07'),
(14, 47, 'featured', '2025-04-22 16:29:07', '2025-04-22 16:29:07'),
(15, 48, 'featured', '2025-04-22 16:29:07', '2025-04-22 16:29:07'),
(16, 49, 'featured', '2025-04-22 16:29:07', '2025-04-22 16:29:07'),
(17, 52, 'featured', '2025-04-22 16:29:08', '2025-04-22 16:29:35'),
(18, 54, 'featured', '2025-04-22 16:29:08', '2025-04-22 16:29:37'),
(19, 61, 'featured', '2025-04-22 16:29:08', '2025-04-22 16:29:08'),
(20, 87, 'featured', '2025-04-22 16:29:11', '2025-04-22 16:29:11'),
(20, 91, 'featured', '2025-04-22 16:29:11', '2025-04-22 16:29:11'),
(20, 161, 'featured', '2025-04-22 16:29:42', '2025-04-22 16:29:42'),
(20, 162, 'featured', '2025-04-22 16:29:42', '2025-04-22 16:29:42'),
(21, 90, 'featured', '2025-04-22 16:29:11', '2025-04-22 16:29:11'),
(22, 98, 'featured', '2025-04-22 16:29:11', '2025-04-22 16:29:11'),
(23, 99, 'featured', '2025-04-22 16:29:11', '2025-04-22 16:29:11'),
(24, 104, 'featured', '2025-04-22 16:29:12', '2025-04-22 16:29:13'),
(25, 107, 'featured', '2025-04-22 16:29:12', '2025-04-22 16:29:13'),
(25, 160, 'featured', '2025-04-22 16:29:42', '2025-04-22 16:29:42'),
(26, 110, 'featured', '2025-04-22 16:29:12', '2025-04-22 16:29:12'),
(27, 111, 'featured', '2025-04-22 16:29:12', '2025-04-22 16:29:12'),
(28, 112, 'featured', '2025-04-22 16:29:12', '2025-04-22 16:29:12'),
(29, 113, 'featured', '2025-04-22 16:29:12', '2025-04-22 16:29:12'),
(30, 114, 'featured', '2025-04-22 16:29:12', '2025-04-22 16:29:12'),
(31, 115, 'featured', '2025-04-22 16:29:12', '2025-04-22 16:29:12'),
(32, 116, 'featured', '2025-04-22 16:29:12', '2025-04-22 16:29:12'),
(33, 117, 'featured', '2025-04-22 16:29:12', '2025-04-22 16:29:12'),
(34, 118, 'featured', '2025-04-22 16:29:12', '2025-04-22 16:29:12'),
(35, 119, 'featured', '2025-04-22 16:29:12', '2025-04-22 16:29:12'),
(36, 132, 'primary', '2025-04-22 16:29:17', '2025-04-22 16:29:17'),
(36, 143, 'primary', '2025-04-22 16:29:26', '2025-04-22 16:29:26'),
(36, 145, 'primary', '2025-04-22 16:29:28', '2025-04-22 16:29:28'),
(37, 133, 'primary', '2025-04-22 16:29:17', '2025-04-22 16:29:17'),
(38, 135, 'primary', '2025-04-22 16:29:19', '2025-04-22 16:29:19'),
(39, 135, 'primary', '2025-04-22 16:29:19', '2025-04-22 16:29:19'),
(40, 136, 'primary', '2025-04-22 16:29:22', '2025-04-22 16:29:22'),
(40, 137, 'primary', '2025-04-22 16:29:22', '2025-04-22 16:29:22'),
(40, 138, 'primary', '2025-04-22 16:29:22', '2025-04-22 16:29:22'),
(41, 139, 'primary', '2025-04-22 16:29:23', '2025-04-22 16:29:23'),
(42, 140, 'primary', '2025-04-22 16:29:24', '2025-04-22 16:29:24'),
(43, 142, 'primary', '2025-04-22 16:29:25', '2025-04-22 16:29:25'),
(44, 143, 'primary', '2025-04-22 16:29:26', '2025-04-22 16:29:26'),
(45, 144, 'primary', '2025-04-22 16:29:27', '2025-04-22 16:29:27'),
(46, 145, 'primary', '2025-04-22 16:29:28', '2025-04-22 16:29:28'),
(47, 146, 'primary', '2025-04-22 16:29:29', '2025-04-22 16:29:29'),
(48, 24, 'primary', '2025-04-22 16:29:32', '2025-04-22 16:29:32'),
(49, 150, 'primary', '2025-04-22 16:29:34', '2025-04-22 16:29:34'),
(50, 153, 'featured', '2025-04-22 16:29:40', '2025-04-22 16:29:40'),
(51, 154, 'featured', '2025-04-22 16:29:40', '2025-04-22 16:29:40');

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
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `artist_id` bigint(20) UNSIGNED NOT NULL,
  `text` text NOT NULL,
  `status` enum('visible','hidden','deleted') NOT NULL DEFAULT 'visible',
  `deleted_username` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `comments_releases`
--

CREATE TABLE `comments_releases` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `release_id` bigint(20) UNSIGNED NOT NULL,
  `text` text NOT NULL,
  `status` enum('visible','hidden','deleted') NOT NULL DEFAULT 'visible',
  `deleted_username` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `comments_tracks`
--

CREATE TABLE `comments_tracks` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `track_id` bigint(20) UNSIGNED NOT NULL,
  `text` text NOT NULL,
  `status` enum('visible','hidden','deleted') NOT NULL DEFAULT 'visible',
  `deleted_username` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

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
  `description` text DEFAULT NULL,
  `origin_year` smallint(5) UNSIGNED DEFAULT NULL,
  `origin_country` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `genres`
--

INSERT INTO `genres` (`id`, `name`, `description`, `origin_year`, `origin_country`, `created_at`, `updated_at`) VALUES
(1, 'deathcore', 'Deathcore is a fusion of death metal and metalcore. \n\nBeing a broad term it can mean anything from \"downtempo\" deathcore, melodic deathcore, grindy deathcore, technical deathcore etc.\n\n1991-1992 was most likely the starting year for deathcore. Damonacy\'s 1991 demo/EP, From Within, featured elements of dissonant metalcore within their Ripping Corpse like sound. The same goes for Cross Fade a year later, with their emphasis on a peculiar, thuggery hardcore esque groove being noticeable on their technical death metal-flavored demo, Ruined. The next one is Lethargy (consisted of soon-to-be members of Mastodon interestingly enough), who were also playing a technical death metal style, but with a much more proto-mathcore derived sound in their demo Lost in This Existence. However, Australian band Damaged (now known as Terrorrust) on the other hand were much more notable: their early material (The Art of Destroying Life and Do Not Spit) are a mixture of death metal, metalcore and NYHC, sounding extremely similar to mid to late \'90s deathcore.\n\nDeathcore gained a lot of traction in the mid \'90s. Metalcore itself has already flirted with a fair amount of death metal at this point (All Out War, Arkangel, etc.) though there are bands that took this to the limit. During this period militant, vegan straight edge \"hardcore\" bands went harder and aggressive by embracing death metal in their music, which in the end becoming a major and influential force on deathcore. In the US, vegan straight edge bands like Abnegation, End of One, Upheaval and Day of Suffering were some of the notable bands that actually began mixing a considerable amount of death metal influences in their framework.\n\nMeanwhile in Europe, the Belgian H8000 scene -- which is also vegan straight edge -- is an entirely different monster. Congress  and Liar pretty much changed the scene\'s landscape by opting a much more technical and hateful sound with low-key death metal influences, but it was Deformity, Legion and Sektor that started exerting it stronger than their predecessors. Other bands in the continent -- some of which were inspired by the H8000 scene -- such as Reprisal, Jane, Shaft, Ashlar and Crawlspace went to a similar route.\n\nOther bands such as End of One, One Last Sin, Goatamentise and Embodyment also released their material during this period.\n\nBy 2004, deathcore bands like All Shall Perish and Cast From Eden started incorporating melodic death metal and melodic metalcore. Overtime this process started to slowly strip many, if not all, their traditional metalcore roots and sound. Often times, these bands are called \"AtG-core\" because they took so much influence from At The Gates. In the same year, the breakdown-heavy brutal deathcore bands started appearing and quickly became the poster boy for the genre. These bands often have their roots in brutal death metal and to a lesser extent alt metal, rather than metalcore. Bands such as Suffocation, Internal Bleeding, and Dying Fetus being the main influences for much of these bands, like Suicide Silence and Job for a Cowboy.\n\nThis caused a noticeable change in sound. No longer was deathcore a metalcore subgenre, but a death metal one; it shares much of its sound with brutal death metal than it does with metalcore. Thus, bands in this era are to be labeled as second wave deathcore. Read more on Last.fm. User-contributed text is available under the Creative Commons By-SA License; additional terms may apply.', NULL, NULL, '2025-04-22 16:30:06', '2025-04-22 16:30:06'),
(2, 'metalcore', 'In the 1980s, various bands in both hardcore punk and metal scenes worldwide were crossing over. In terms of metalcore, the mid-1980s New York hardcore scene in particular is arguably the most influential. The likes from this scene, such as Cro-Mags, Leeway, and Sheer Terror, took inspiration from popular metal bands of the time such as Venom, Motörhead, Celtic Frost, Metallica, and Slayer. At this point, \"metalcore\" was used to describe some of these bands. In the early 1990s, Starkweather, Integrity, Ringworm, Earth Crisis, and Rorschach have expanded this fusion in their influential recordings, and, by the time the mid-1990s have arrived, many different metalcore bands took note and started to push the genre into more extreme territories.\n\nIn West Flanders, Belgium, a vegan straight edge scene called H8000 was spearheaded by the likes of Congress and Liar. These bands heavily incorporated aspects of death metal and thrash metal, musically aligning themselves with contemporaries outside the scene such as All Out War, Merauder, and Kickback. Meanwhile, in Bremen, Germany; Acme, Systral, and Carol played a dissonant and fragmented metalcore style heavily inspired by Rorschach. Additionally, Deadguy, Lethargy, and Candiria experimented with a wide array of genres, mainly noise rock, post-hardcore, technical thrash metal, technical death metal, and jazz fusion, establishing mathcore in the process before Botch, The Dillinger Escape Plan, and Converge expanded and popularized it years later.\n\nDuring the late 1990s, a style of melodic metalcore was popularized by Massachusetts bands Shadows Fall, Killswitch Engage, and Unearth, who were mainly inspired by the Gothenburg melodic death metal scene. Meanwhile, on the other end of the melodic metalcore spectrum, bands like Poison the Well and Shai Hulud were also releasing their own pioneering records. By the time the 2000s came around, both of these styles\' accessibility paved the way for a large number of bands, some even polishing the sound for wider commercial appeal.\n\nHowever, while these bands are popular and helped lay the development of the (separate) modern metalcore scene, there are others that kept closer to the genre\'s traditional roots. For example, bands like Cursed, Trap Them, and Oathbreaker led the development of dark metalcore; a distinctively aggressive form of the genre that emphasizes a dark, gritty, and ominous atmosphere. Additionally, other bands such as early Cave In, Keelhaul, and early Mastodon utilized a mathcore-derived style by mostly forgoing its harsh dissonance, and, instead, using off-kilter riffing and progressive-driven song structures.\n\nIn recent years, traditional metalcore bands such as Knocked Loose, Code Orange, and Jesus Piece have gained large amount of following, indicating a renewed interest towards the genre as a whole. Read more on Last.fm. User-contributed text is available under the Creative Commons By-SA License; additional terms may apply.', NULL, NULL, '2025-04-22 16:30:06', '2025-04-22 16:30:06'),
(3, 'hardcore', 'Hardcore can refer to several musical genres:\n\nHardcore Punk: musical style derived from Punk Rock that, in synthesis, radicalizes it through an emphasis on the angry and fast of both the lyrics and the music itself.Hardcore Hip Hop: musical style derived from Boom Bap; its mainstay is aggressive and angry vocals coupled with violent and somber lyrics, usually dealing with life in the ghettos and/or gangs.New York Hardcore: musical style derived from Hardcore Punk; at first it was a subgenre influenced by styles such as Oi! and Trashcore, but in the nineties it became a subgenre more influenced by Metalcore, Crossover Trash and Groove Metal. The lyrics tend to deal with themes linked to the working class and brotherhood, especially within the New York scene.Metalcore: musical style that derives from a mixture of several genres; Hardcore Punk, New York Hardcore, Crossover Trash, Trash Metal and Groove Metal. Its base is the breakdowns; extremely heavy and rhythmic sections that signify the peak of the aggressiveness in the song.Mathcore: musical style derived from Metalcore; it is a subgenre characterized by its rhythmic complexity and sound experimentation.Deathcore: musical style that derives from Metalcore; it is a mix between the breakdowns and the use of palm mute of Metalcore with the aggressiveness and blast beats of Death Metal. Generally, there is a tussle between slow and aggressive sections.Gabber: musical style that derives from Rave and means a more aggressive version of it; it emphasizes the use of a distorted bass drum and tempos between 180 and 300 beats per minute.Nu Style Gabber: musical style derived from Gabber; the difference lies in the fact that the drums are even more dense and distorted and the speed is reduced, concentrating on approximately 160 beats per minute.\n\nIn itself, the term hardcore, musically speaking, refers to fast and aggressive genres. Read more on Last.fm. User-contributed text is available under the Creative Commons By-SA License; additional terms may apply.', NULL, NULL, '2025-04-22 16:30:07', '2025-04-22 16:30:07'),
(4, 'screamo', 'Screamo is a subgenre of the more melancholic and introspective sounds of Punk, such as Emotional Hardcore (also known as Emocore) and Post-Hardcore, making use of the desperate and heartbreaking scream as its most notorious characteristic, as well as its more aggressive and sad instrumental.\n\nIt started in the 90s with bands like Saetia, Portraits of Past and One Eyed God Prophecy, which performed this depressive, melancholic and passionate sound characterized by the rawness of the voice and lyrics.\n\nFor the 2000s and 2010s, Screamo continues to develop with bands like Envy, Funeral Diner, Pg.99, Gospel, Pianos Become The Teeth, Shin Guard and Loma Prieta, which updated the sound to a more contemporary one, which is noticeable in the sonic influences as well as in the production.\n\nIt is worth noting that this is not the genre to which bands like The Used, Funeral For A Friend or Saosin belong, which have more of a Post-Hardcore scream mixed with the poppy and dramatic essence of Emo-Pop Punk bands like My Chemical Romance or Fall Out Boy, which results in genres known as Pop Post-Hardcore, Post-Hardpop or Pop Screamo.\n\nThe genre is also known as Skramz, which is a term created to gather the bands from the 90s scene and as a response to every major musical media saying that Screamo belonged to bands that just had screams on their songs. There\'s also a term called Real Screamo, which is similar but it tends to gather bands that would belong to Emoviolence. Read more on Last.fm. User-contributed text is available under the Creative Commons By-SA License; additional terms may apply.', NULL, NULL, '2025-04-22 16:30:07', '2025-04-22 16:30:07'),
(5, 'metal', 'Metal is a subgenre of rock music that developed in the late 1960s and early 1970s. With roots in blues-rock and psychedelic rock, the bands that created heavy metal developed a thick, massive sound characterized by highly amplified distortion and extended guitar solos. Allmusic states that, “of all rock & roll’s myriad forms, heavy metal is the most extreme in terms of volume, machismo and theatricality.”\n\nHeavy metal has long had a worldwide following of fans known as metalheads or headbangers. Although early heavy metal bands such as Black Sabbath, Led Zeppelin and Deep Purple attracted large audiences, they were often critically reviled at the time. A status common throughout the history of the genre. In the mid-1970s, Judas Priest helped spur the genre’s evolution by discarding much of its blues influence. Bands in the New Wave of British Heavy Metal such as Iron Maiden and Motörhead followed in a similar vein, introducing a punk rock sensibility and an increasing emphasis on speed.\n\nIn the mid-1980s, pop-infused glam metal became a major commercial force with groups like Mötley Crüe. Underground scenes produced an array of more extreme, aggressive styles: thrash metal broke into the mainstream with bands such as Metallica, also leading the development of more extreme styles, such as death metal and black metal, which remain subcultural phenomena. Alternative Metal later followed these, as a reaction to both: being more accessible than the extreme styles typified by death metal (while not as overtly commercial as hair metal) while also being musically varied and sonically adventurous. Since the mid-1990s, popular styles such as nu metal, which often incorporates elements of funk and hip hop; and metalcore, which blends extreme metal with hardcore punk, have further expanded the definition of the genre.\n\nOther subgenres of metal include power metal, speed metal, melodic death metal (also known as Gothenburg metal), Industrial metal, nu-metal, thrash metal, black metal, doom metal, death metal, deathcore, metalcore, grindcore, progressive metal and folk metal. Read more on Last.fm. User-contributed text is available under the Creative Commons By-SA License; additional terms may apply.', NULL, NULL, '2025-04-22 16:30:07', '2025-04-22 16:30:07'),
(6, 'alternative rock', 'Alternative rock (also called alt-rock) is a genre of rock music that refers specifically to the punk/new wave-rooted style that emerged in the 1980s and became widely popular in the early-mid 1990s. The term \"alternative\" was coined in the 1980s to describe punk rock-inspired bands on independent record labels that did not fit into the mainstream genres of the time. As a musical genre, alternative rock consists of various subgenres that have emerged from the independent music scene since the 1980s, such as Grunge, Britpop, Gothic Rock, Grebo, Jangle Pop, and Shoegaze. These genres are unified by their collective debt to the style and/or ethos of punk, which laid the groundwork for alternative music in the 1970s.\n\nThough the genre is considered to be rock, some of its subgenres are influenced by folk music, reggae, electronic music and jazz among other genres. At times alternative rock has been used as a catch-all phrase for rock music from underground artists in the 1980s, all music descended from punk rock (including punk itself, New Wave, and post-punk), and, ironically, for mainstream rock music in general in the 1990s and 2000s.\n\nWhile a few artists like R.E.M. and The Cure achieved commercial success and mainstream critical recognition, many alternative rock artists during the 1980s were cult acts that recorded on independent labels and received their exposure through college radio airplay and word-of-mouth. With the breakthrough of Nirvana and the popularity of the grunge and Britpop movements in the early 1990s, alternative rock entered the musical mainstream and many alternative bands became commercially successful.  The bridge of Lost in God helped move Alternative forward in 2020. Read more on Last.fm. User-contributed text is available under the Creative Commons By-SA License; additional terms may apply.', NULL, NULL, '2025-04-22 16:30:08', '2025-04-22 16:30:08'),
(7, 'alternative metal', 'Alternative metal (or alt-metal), is a style of heavy metal that emerged in the late 1980s, and had popularity in the 1990s alongside grunge, thrash metal, punk and groove metal. Alternative metal bands are often characterized by heavy metal guitar riffs, unconventional sounds within other heavy metal genres, and sometimes experimental influences to heavy music. Many bands have done singing, while some bands might do growls or screams or yelling like Static-X, Slipknot and Nothingface. But bands like Staind, Helmet and Soundgarden use mostly singing. Bands include System of a Down, Mudvayne, Static-X, Slipknot, Kittie, Nothingface, Drowning Pool, and Soundgarden.\nInitially alternative metal appealed to alternative rock fans, since virtually all 1980s alt-metal bands had their influences in the American rock underground scene. Alternative metal bands emerged from hardcore punk (Biohazard, Corrosion of Conformity), noise rock (Helmet, The Jesus Lizard), grunge (Alice in Chains, Soundgarden), and industrial (Ministry, Nine Inch Nails). These bands never formed a distinct movement or scene; rather they were bound by their incorporation of traditional metal influences and openness to experimentation. Jane\'s Addiction borrowed from progressive rock and Living Colour injected funk into their sound, for example, while Primus includes influence from both progressive rock and funk, and Faith No More mixed progressive rock, funk and hip hop. Read more on Last.fm. User-contributed text is available under the Creative Commons By-SA License; additional terms may apply.', NULL, NULL, '2025-04-22 16:30:08', '2025-04-22 16:30:08'),
(8, 'nu metal', 'Nu metal (sometimes stylized as nü-metal, with a metal umlaut) is a subgenre of alternative metal that combines elements of heavy metal music with elements of other music genres such as hip hop, funk, industrial, and grunge. Nu metal rarely features guitar solos or other displays of musical technique, and emphasizes rhythm with instrumentation that is heavily syncopated. Nu metal guitarists typically use seven-string guitars that are down-tuned to produce a heavier sound. Vocal styles are often rhythmic and influenced by hip hop, and include singing, rapping, screaming and sometimes growling. DJs are occasionally featured to provide instrumentation such as sampling, turntable scratching and electronic background music. Nu metal is one of the key genres of the new wave of American heavy metal.\n\nIn the late 1980s and early 1990s, bands like Pantera, Helmet, and Faith No More were influential in the development of nu metal with their groove metal and alternative metal styles. Korn is often credited as pioneering the subgenre in the mid-1990s with their self-titled debut album. Nu metal became popular in the late 1990s, with bands and artists such as Korn, Limp Bizkit, and Slipknot all releasing albums that sold millions of copies. Its popularity continued through the early 2000s, with bands such as Papa Roach, Staind, and P.O.D. all selling multi-platinum albums. The popularity of nu metal came to a peak in 2001 with Linkin Park\'s diamond-selling album Hybrid Theory. By the mid-2000s, however, the oversaturation of bands combined with the underperformance of several high-profile releases led to the subgenre\'s decline, leading to the rise of metalcore and many nu metal bands disbanding or abandoning their established sound in favor of other genres.\n\nThe 2010s brought a nu metal revival; many bands that combined it with other genres (for example, metalcore and deathcore) emerged, and some nu metal bands from the 1990s and early 2000s returned to the nu metal sound. Bands such as Of Mice & Men, Emmure, Issues, My Ticket Home, and Bring Me the Horizon combined nu metal with metalcore or deathcore. Artists like Grimes, Poppy, and Rina Sawayama integrated nu metal sounds into electronic pop music in the late 2010s and early 2020s, and interest in nu metal rose in the early 2020s. Read more on Last.fm. User-contributed text is available under the Creative Commons By-SA License; additional terms may apply.', NULL, NULL, '2025-04-22 16:30:08', '2025-04-22 16:30:08'),
(9, 'post-hardcore', 'Although post-hardcore is primarily rooted in post-punk and hardcore punk, the music that created the space for it were groups like Black Flag, The Minutemen, Flipper and Hüsker Dü, who proved there was indeed room for stylistic diversity in hardcore punk, and abrasive art punk units like Sonic Youth and Big Black, who had arrived too late to truly be part of the initial post-punk movement.  Unlike post-punk, post-hardcore was almost exclusively an American phenomenon.    \n   \nPost-hardcore developed due to not only the stylistic limitations of hardcore punk, but also as an effort directly alienate the boorish, violent culture that had grown around hardcore punk much to the ire of the influential figures.  The earliest appearances of post-hardcore itself were in Washington, D.C. and the surrounding Maryland area in the mid-1980s, thanks largely to a 1985 campaign by Washington\'s Dischord records called Revolution Summer, which aimed to break the label and its followers free from the creative and social dead-end of hardcore punk.  The first post-hardcore, played by bands like Rites of Spring, Embrace, Gray Matter, and Ignition essentially combined a stronger command of songwriting, a better sense of melody and rhythm, and an introspective lyrical focus, with the power of hardcore. Notably, this music was deemed \"emocore\" by its detractors.  \n\nPost-hardcore would not develop its art rock qualities until about 1987, with the arrival of bands including Moss Icon, who would frequently subvert traditional songwriting styles, make use of improvisational techniques and featured an instrumental style influenced as much by groups like Bauhaus and The Cure as it was by Black Flag. Also noteworthy were Happy Go Licky, a reconvening of Rites of Spring who played an updated version of no wave, and Soulside, who emphasized the power of the rhythm section. \n\nMeanwhile, in the northern Midwest a different type of post-hardcore was developing in the wake of the breakup of Big Black, centered around Touch and Go records.  Whereas post-hardcore in the DC/Maryland vein was concerned with energy and emotional expression, artists including The Jesus Lizard, Arcwelder, Silverfish and Big Black frontman Steve Albini\'s own Rapeman and later project Shellac were focused on confrontation through precision and extreme volume.  This type of post-hardcore might be less renown than that emanating from Washington, though it lead to the creation of math rock and noise rock and undoubtedly shaped the face of post-hardcore in general as much as the groups from Washington did.        \n\nThe most influential post-hardcore group of all, though, was Fugazi.  Formed in the late 1980s by Dischord founder and Embrace singer Ian MacKaye, along with members of Rites of Spring, Fugazi combined a persistent work ethic with constant stylistic innovation.  Fugazi played throughout the 1990s and toured throughout the industrialized world, and in their wake came exciting new labels like Gravity, Ebullition, and Gern Blandsten, and artists such as Native Nod, Clikatat Ikatowi, Hoover, Drive Like Jehu, Navio Forge, Unwound, Maximillian Colby, Lungfish and 1.6 Band, among myriad others. Some groups, most notably Jawbox and Sunny Day Real Estate, were even accessible enough to find a degree of mainstream success.    \n\nBy the turn of the new millennium, post-hardcore bands including Les Savy Fav, At The Drive-In, and The Dismemberment Plan were openly flirting with elements of dance music, and progressive rock, sometimes even adding electronic instrumentation.  The music these groups produced was increasingly lush, and indeed many of them did develop major label affiliations.  However, post-hardcore more or less collapsed in the early 2000s, with the break-up of many key artists.                        Read more on Last.fm. User-contributed text is available under the Creative Commons By-SA License; additional terms may apply.', NULL, NULL, '2025-04-22 16:30:08', '2025-04-22 16:30:08'),
(10, 'rock', 'Rock music is a form of popular music with a prominent vocal melody, accompanied by guitar, drums, and bass. Many styles of rock music also use keyboard instruments such as organ, piano, mellotron, and synthesizers. Other instruments sometimes utilized in rock include saxophone, harmonica, violin, flute, French horn, banjo, melodica, and timpani. Also, less common stringed instruments such as mandolin and sitar are used. Rock music usually has a strong back beat, and often revolves around the guitar, either solid electric, hollow electric, or acoustic.\n\nRock music has its roots in 1940s and 1950s rock and roll and rockabilly, which evolved from blues, country music and other influences. According to the All Music Guide, \"In its purest form, Rock & Roll has three chords, a strong, insistent back beat, and a catchy melody. Early rock & roll drew from a variety of sources, primarily blues, R&B, and country, but also gospel, traditional pop, jazz, and folk. All of these influences combined in a simple, blues-based song structure that was fast, danceable, and catchy.\"\n\nIn the late 1960s, rock music was blended with folk music to create folk rock, blues to create blues-rock and with jazz, to create jazz-rock fusion, and without a time signature to create psychedelic rock. In the 1970s, rock incorporated influences from soul, funk, and latin music. Also in the 1970s, rock developed a number of subgenres, such as soft rock, heavy metal, hard rock, progressive rock, and punk rock. Rock subgenres that emerged in the 1980s included synthpop, hardcore punk and alternative rock. In the 1990s, rock subgenres included grunge, Britpop, indie rock, and nu metal.\nA group of musicians specializing in rock music is called a rock band or rock group. Many rock groups consist of a guitarist, lead singer, bass guitarist, and drummer, forming a quartet. Some groups omit one or more of these roles and/or utilize a lead singer who plays an instrument while singing, forming a trio or duo; others include additional musicians such as one or two rhythm guitarists and/or a keyboardist. More rarely, groups also utilize stringed instruments such as violins or cellos, and/or horns like saxophones, trumpets or trombones.\n Read more on Last.fm. User-contributed text is available under the Creative Commons By-SA License; additional terms may apply.', NULL, NULL, '2025-04-22 16:30:11', '2025-04-22 16:30:11'),
(11, 'electronic rock', 'Electronic rock, also commonly referred to as electro-rock, digital rock, and synth-rock is the combination of electronic music with traditional rock music. The creation of this relatively new music genre began in the 1950s and slowly progressed until the late 1960s. However, it was not until the invention of MIDI, enabling many electronic instruments to be able to communicate with each other and letting instruments to be played and recorded much more easily and efficiently, that electronic music and electronic rock were fully integrated into the music scene. Synthesizers, electric guitars, and guitar effects pedals, are just few of the primary inventions that helped electro-rock become what it is today.\n\nA main theme in the development of Electronic rock would be the utilization of new digital technologies in the recording, writing, and live production of rock music. What makes Electronic rock distinct from its parent genres however would be the emergence of Digital Audio, MIDI, as well as the overall pervasiveness of personal computers and software on the production of music.\n\nBands such as Pendulum, Ratatat, Celldweller, and Nine Inch Nails, are a few of the most popular electronic rock bands. All of them gaining success by means of the creation of this new music genre, electro-rock. Unlike most, the band Daft Punk, consisting of two members, Thomas Bangalter and Guy-Manuel de Homem Christo, originated as a traditional rock band. However, after gaining little to no success, they decided to mess around with their sound, and try to create something new and different. Their efforts worked to establish them as one of the most prevailing electro-rock bands ever. Other popular electro-rock bands that have gained success are Def FX, Filter, and the Crystal Method. Read more on Last.fm. User-contributed text is available under the Creative Commons By-SA License; additional terms may apply.', NULL, NULL, '2025-04-22 16:30:11', '2025-04-22 16:30:11'),
(12, 'electronic', 'Electronic music refers to music that emphasizes the use of electronic musical instruments or electronic music technology as a central aspect of the sound of the music. Historically, electronic music was considered to be any music created with the use of electronic musical instruments or electronic processing, but in modern times, that distinction has been lost because almost all recorded music today, and the majority of live music performances, depend on extensive use of electronics. Today, the term electronic music serves to differentiate music that uses electronics as its focal point or inspiration, from music that uses electronics mainly in service of creating an intended production that may have some electronic elements in the sound but does not focus upon them.\n\nContemporary electronic music expresses both art music forms including computer music, experimental music, musique concrete, and others; and popular music forms including multiple styles of dance music such as techno, house, trance, electro, breakbeat, drum and bass, electropop, synthpop, etc.\n\nA distinction can be made between instruments that produce sound through electromechanical means as opposed to instruments that produce sound using electronic components.\n\nExamples of electromechanical instruments are the telharmonium, Hammond organ, and the electric guitar, whereas examples of electronic instruments are a Theremin, synthesizer, and a computer. Read more on Last.fm. User-contributed text is available under the Creative Commons By-SA License; additional terms may apply.', NULL, NULL, '2025-04-22 16:30:12', '2025-04-22 16:30:12'),
(13, 'emo', 'Evolving out of hardcore punk as a more artistic variation on the genre, emo became an important influence on underground rock by the late ’90s, receiving praise from both modern punks and indie-rockers. \nSome emo artists express a more progressive musical style, utilizing complex guitar work, unconventional song structures, avant-garde noise, and extreme dynamic shifts; while some emo leans much more toward pop-punk, while being a bit more detailed. \n\nEmo lyrics are profoundly personal, and are most of the time either free-associative poetry or intimate confessionals. Though it’s far less aggressively masculine, emo directly birthed from hardcore and therefore also concerns itself with authenticity and anti-commercialism; the genre grew out of the idea that commercial music was too artificial and calculated to express any true emotion. Because emo values authentic and deep emotion that defies rationality, the music can be a bit overexaggerated in its search for ever grander statements. But at its best, emo has a colossal power that manages to be emotional, inspiring, and intimate all at the same time.\n\nThe groundwork for emo was laid by Hüsker Dü’s classic Zen Arcade, which expanded the possibilities of hardcore bands to deal with more personal subject matter and write more melodic and technically challenging songs. Emo arose from Washington, D.C. a short while after, among the remains of the hardcore scene that had spawned Minor Threat and Bad Brains. \nThe word emo (or as it sometimes is called, emocore) was in the beginning used to describe hardcore bands that had frontmen who sang more eloquently instead of the usual shouts and rants; the first true emo band was Rites of Spring, which was then followed by ex-Minor Threat frontman Ian MacKaye’s short-lived Embrace. \nThe MacKaye-founded label Dischord Records became the center for D.C.’s evolving emo scene, as it released records by Rites of Spring, Dag Nasty, Nation of Ulysses, and eventually Ian MacKaye’s new band formed together with members from Rites of Spring, Fugazi. \nFugazi became the definitive early emo band, as they appealed to alternative rock listeners and received attention for their strictly anti-commercial ethics. Aside from Dischord, emo was in the beginning deeply underground, recorded by extremely short-lived bands and released in small amounts by small labels; some of these band’s vocalists actually wept onstage during song climaxes, earning ridicule from hardcore purists.\n\nNot counting Fugazi, emo didn’t truly break out until the mid-’90s due to Sunny Day Real Estate, whose early records practically defined the style for many listeners. Taking the intricate guitar work of Fugazi and combining it with Seattle grunge, genuine prog-rock, and softly sentimental vocals, Sunny Day Real Estate created an immense legacy influencing many who related to their dramatic melodies and inward-looking mysticism. \nSome of these listeners connected equally to the ironic, geeky introspection and catchy pop-punk of Weezer’s Pinkerton album. \n\nSeveral artists and bands contined to build on the groundwork laid by Fugazi (like Quicksand and Drive Like Jehu), but most ’90s bands took inspiration from some combination of Fugazi, Sunny Day Real Estate, and Weezer. \nBands like the Promise Ring, the Get Up Kids, Braid, Texas Is the Reason, Jimmy Eat World, Joan of Arc, and Jets to Brazil also greatly influenced the indie rock scene, thereby making emo one of the more popular underground rock styles by the turn of the millennium. Read more on Last.fm. User-contributed text is available under the Creative Commons By-SA License; additional terms may apply.', NULL, NULL, '2025-04-22 16:30:13', '2025-04-22 16:30:13'),
(14, 'pop rock', 'Pop rock is a hybrid of pop music and rock music that uses catchy pop style, with light lyrics over top of guitar- or piano- based songs. There are varying definitions of the term, ranging from it being classed as an \"upbeat variety of rock music\" to a subgenre of pop music or of rock music. Scholars have noted that pop and rock are usually depicted as opposites; the detractors of pop often deride it as a slick, commercial product along with advocates of rock who claim that rock music is a more authentic, sincere form of music.  Read more on Last.fm. User-contributed text is available under the Creative Commons By-SA License; additional terms may apply.', NULL, NULL, '2025-04-22 16:30:15', '2025-04-22 16:30:15'),
(15, 'alternative', 'Alternative refers to artists that do not follow the mainstream sounds generally heard on the radio or in media.  The genre of Alternative includes Jangle Pop, Noise Rock, Trip-Hop, Industrial, Grunge, Shoegaze, New Wave and some of the more eclectic Punk, Post-Punk and Hardcore Punk bands, among other genres. Most Alternative bands in this wave were largely underground although some became cult hits like Pixies, The Replacements, and The Smiths. A few of these bands even gained mainstream success such as U2, R.E.M,and The Cure. In 1991 bands like Nirvana, Red Hot Chili Peppers, and Pearl Jam brought Alternative to the mainstream.  \n\nIn the late 70\'s Alternative genres such as New Wave, Post-Punk, and Punk started emerging. Artists like Talking Heads, Blondie, Joy Division, The Clash, and Elvis Costello are some of the more popular Alternative groups to emerge from the genre. Read more on Last.fm. User-contributed text is available under the Creative Commons By-SA License; additional terms may apply.', NULL, NULL, '2025-04-22 16:30:15', '2025-04-22 16:30:15'),
(16, 'hard rock', 'Hard rock is a loosely defined genre of rock music which has its earliest roots in mid-1960s garage, blues rock and psychedelic rock. It is typified by a heavy use of distorted electric guitars, bass guitar, drums, pianos, and keyboards.\n\nOne of the major influences of hard rock is blues music. American and British rock bands began to modify rock and roll, adding to the standard genre harder sounds, heavier guitar riffs, bombastic drumming and louder vocals. This sound created the basis for hard rock. Early forms of hard rock can be heard in the songs \"You Really Got Me\" by The Kinks (1964), \"My Generation\" by The Who (1965), \"Helter Skelter\" by The Beatles (1968), and \"I Feel Free\" by Cream (1966).\n\nHard rock emerged with groups of the late-1960s, such as The Who, Deep Purple, Iron Butterfly, Blue Cheer and Led Zeppelin who mixed the music of early rock bands with a more hard-edged form of blues rock and acid rock. Deep Purple helped pioneer the hard rock genre with the albums Shades of Deep Purple (1968), The Book of Taliesyn (1968), and Deep Purple (1969), but they made their big break with their fourth and distinctively heavier album, In Rock (1970). Led Zeppelin\'s eponymous first album, Led Zeppelin (1969), and The Who\'s Live at Leeds (1970), are examples of music from the beginning of the hard rock genre. The blues origins of the albums are clear, and a few songs by well-known blues artists are adapted or covered within them.\n\nLed Zeppelin II (1969), Led Zeppelin\'s second album, was a watershed moment for the identity of hard rock, proving more popular than their third album Led Zeppelin III (1970). While the heavy aspects of their music remained, Led Zeppelin III was more folk rock-oriented than their second. 1971 saw [The Who release their highly-acclaimed album Who\'s Next.\n\nBlack Sabbath\'s first two albums, both released in 1970, are considered as important as any in launching hard rock into the mainstream.\n\nDeep Purple\'s transformation of hard rock continued in 1972 with their album Machine Head, considered one of the first heavy metal albums, although some band members shunned that label. Two songs from Machine Head had great success: \"Highway Star\" and \"Smoke on the Water.\" The latter song\'s main riff made it, for many, the \"signature\" Deep Purple song. Nazareth, a band out of Scotland, provided a blend of hard rock which commercialised the genre further with their best selling album, Hair of the Dog, which in turn, influenced numerous other bands. Free released their signature song \"All Right Now\", which has received massive radio airplay in both the UK and US.\n\nIn 1979, the differences between the hard rock movement and the rising heavy metal movement were highlighted when the Australian hard rock band, AC/DC, released its second-biggest album, Highway to Hell. AC/DC\'s music was based mostly on rhythm & blues and early-1970s hard rock, with the group explicitly repudiating the \"heavy metal\" tag.\n\nThe late 1980s saw the most commercially successful time period for hard rock. At this time it was the most reliable form of commercial popular music in the United States. Numerous hard rock acts achieved hits in the mainstream charts. One of those hits was the album Slippery When Wet (1986) by Bon Jovi, which spent a total of 8 weeks at the top of the Billboard 200 album chart, sold 12 million copies, and became the first hard rock album to spawn three top 10 singles—two of which reached #1. In addition, the anthem rock album The Final Countdown by Swedish group Europe was released in 1986. It reached #8 on the U.S. charts, while hitting the top 10 in several other countries.  Read more on Last.fm. User-contributed text is available under the Creative Commons By-SA License; additional terms may apply.', NULL, NULL, '2025-04-22 16:30:25', '2025-04-22 16:30:25'),
(20, 'post hardcore', 'Please see \"post-hardcore\". Read more on Last.fm. User-contributed text is available under the Creative Commons By-SA License; additional terms may apply.', NULL, NULL, '2025-04-22 16:30:32', '2025-04-22 16:30:32'),
(21, 'Female fronted metal', 'The term \"female fronted metal\" describes metal bands that have female vocalists in their lineups. These female vocalists are usually the lead singers, and may or may not be the bands front woman, but are often featured prominently during live performances and recordings, thus the band being referred to as \"female fronted\".\n Read more on Last.fm. User-contributed text is available under the Creative Commons By-SA License; additional terms may apply.', NULL, NULL, '2025-04-22 16:30:34', '2025-04-22 16:30:34'),
(22, 'Reggaeton', 'Reggaeton (reggaetón, reguetón) is a form of urban music that became popular with Latin American youth in the early 1990s. After its mainstream exposure in 2004, it spread to North American, European and Asian audiences. Reggaeton\'s predecessor originated in Panama as reggae en español. After the music\'s gradual exposure in Puerto Rico, it eventually evolved into a new musical style known as reggaeton [1]. Reggaeton blends West-Indian music influences of reggae and dancehall with those of Latin America, such as bomba, plena, salsa, merengue, latin pop, cumbia and bachata as well as that of hip hop, contemporary R&B, and electronica. However, reggaeton is also combined with rapping or singing in Spanish. The influence of this genre has spread to the wider Latino communities in the United States, as well as the Latin American audience. While it takes influences from hip hop and Jamaican dancehall, reggaeton is not the Hispanic or Latino version of either of these genres; reggaeton has its own specific beat and rhythm, whereas Latino hip hop is simply hip hop recorded by artists of Latino descent. The specific rhythm that characterizes reggaeton is referred to as \"Dem Bow.\"[2][3] The name is a reference to the title of the dancehall song by Shabba Ranks that first popularized the beat in the early 1990s. Reggaeton\'s origins represents a hybrid of many different musical genres and influences from various countries in the Caribbean, Latin America and the United States. The genre of reggaeton however is most closely associated with Puerto Rico, as this is where the musical style later popularized and became most famous, and where the vast majority of its current stars originated. Read more on Last.fm. User-contributed text is available under the Creative Commons By-SA License; additional terms may apply.', NULL, NULL, '2025-04-22 16:30:35', '2025-04-22 16:30:35'),
(23, 'Progressive', 'Pertaining to the element of being progressive, music that pushes a genre\'s technical and compositional boundaries or any of the following genres:\nProgressive rock, \nProgressive metal, \nprogressive trance, \nProgressive House, \nprogressive death metal, \nprogressive folk, \nprogressive black metal, \nProgressive Electronic, \nProgressive Pop, \nprogressive jazz, \nprogressive breaks, \nProgressive Metalcore, \nprogressive psytrance, \nprogressive thrash metal, \nprogressive power metal, \nprogressive hardcore, \nProgressive Techno, \nprogressive punk, \nProgressive deathcore, \nprogressive fusion, \nprogressive dance, \nprogressive bluegrass, \nProgressive indie,  \nprogressive doom metal, \nProgressive Folk Metal, \nprogressive sludge, \nprogressive alternative, \nprogressive viking metal, \nprogressive electronica, \nProgressive Doom, \nprogressive melodic death metal, \nprogressive hard rock, \nprogressive country Read more on Last.fm. User-contributed text is available under the Creative Commons By-SA License; additional terms may apply.', NULL, NULL, '2025-04-22 16:30:39', '2025-04-22 16:30:39'),
(24, 'post rock', 'Post Rock is a genre of alternative rock characterized by the use of musical instruments commonly associated with rock music, but using rhythms, harmonies, melodies, timbre, and chord progressions that are not found in rock tradition. Simply put, it is the use of \'rock instrumentation\' for non-rock purposes. Practitioners of the genre\'s style typically produce instrumental music.\n\nAs with many musical genres, the term is arguably inadequate as a concise descriptor: for example, Don Caballero and Tortoise were among the more prominent bands of the 1990s described as post rock, but the two bands\' music has very little in common besides the fact that they are both largely instrumental. As such, the term has been the subject of backlash from listeners and artists alike.\n\nAlthough firmly rooted in the indie or underground scene of the 1980s and \'90s, post-rock\'s style often bears little resemblance musically to that of indie rock. Read more on Last.fm. User-contributed text is available under the Creative Commons By-SA License; additional terms may apply.', NULL, NULL, '2025-04-22 16:30:39', '2025-04-22 16:30:39'),
(25, 'post-rock', 'Post-rock is a subgenre of rock music characterized by the influence and use of instruments commonly associated with rock, but using rhythms and \"guitars as facilitators of timbre and textures\" not traditionally found in rock. Post-rock bands are often without vocals.\n\nThe post-rock sound incorporates characteristics from a variety of musical genres, including ambient, jazz, electronica, and experimental. Post-rock compositions often make use of repetition of musical motifs and subtle changes with an extremely wide range of dynamics. In some respects, this is similar to the music of Steve Reich, Philip Glass and Brian Eno, pioneers of minimalism. \n\nTypically, post-rock pieces are lengthy and instrumental, containing repetitive build-ups of timbre, dynamics and texture. When vocals are included the use is typically non-traditional: some post-rock bands employ vocals as purely instrumental efforts and incidental to the sound, rather than a more traditional use where \"clean\", easily-interpretable vocals are important for poetic and lyrical meaning. When present, post-rock vocals are often soft or droning and are typically infrequent or present in irregular intervals.\n\nIn the late 1990s, Chicago was the home base for a variety of post-rock associated performers. Both John McEntire of Tortoise and Jim O\'Rourke of Brise-Glace and Gastr del Sol were important producers for many of the groups. One of the most eminent post-rock locales is Montreal, where Godspeed You! Black Emperor and similar groups, including Silver Mt. Zion, Do Make Say Think, and Fly Pan Am record on Constellation Records, a notable post-rock record label.\n\nSigur Rós, with the release of Ágætis byrjun in 1999, has become among the most well known post-rock bands of the 2000s. Explosions in the Sky, This Will Destroy You, Russian Circles, and Mono are some of the more popular post-rock bands of the 2000s.[30] With a few exceptions, most notably Sigur Rós and Mogwai, the post-rock of the 21st century has generally eliminated vocals from its repertoire. Read more on Last.fm. User-contributed text is available under the Creative Commons By-SA License; additional terms may apply.', NULL, NULL, '2025-04-22 16:30:42', '2025-04-22 16:30:42'),
(26, 'ambient', 'Ambient music is a musical genre that is generally identifiable as being broadly atmospheric and environmental in nature. \n\nAmbient music evolved from early 20th century forms of semi-audible music, from the impressionism of Erik Satie, through \"musique concrete\" and the minimalism of Terry Riley and Philip Glass, and Brian Eno\'s deliberate sub-audible approach.\n\nLater developments found the dreamy non-linear elements of ambient music applied to some forms of rhythmic music presented in chill-out rooms at raves and other dance events, but always with the primary feature that the music is intended to drift in and out of the listener\'s awareness while creating its effect on the listener\'s consciousness. Read more on Last.fm. User-contributed text is available under the Creative Commons By-SA License; additional terms may apply.', NULL, NULL, '2025-04-22 16:30:42', '2025-04-22 16:30:42'),
(27, 'industrial metal', 'Industrial metal is a musical genre that draws from industrial music and heavy metal. It is usually centered around repeating metal guitar riffs, sampling, synthesizer or sequencer lines, and distorted vocals. The style became increasingly commercially successful in the 1990s. Subsequently, it is most well-known in various European permutations. Read more on Last.fm. User-contributed text is available under the Creative Commons By-SA License; additional terms may apply.', NULL, NULL, '2025-04-22 16:30:51', '2025-04-22 16:30:51'),
(28, 'Cyber Metal', 'Cyber Metal is an offshoot of Industrial Metal which rather than focusing on dance/trance elements, focuses on creating a more futuristic and atmospheric soundscape. Read more on Last.fm. User-contributed text is available under the Creative Commons By-SA License; additional terms may apply.', NULL, NULL, '2025-04-22 16:30:51', '2025-04-22 16:30:51'),
(29, 'electropop', 'Electropop is a type of electronic pop music which features crackly synthesizers prominently in the mix.   Electropop has become an increasingly common term for this music post-2000 whereas in earlier years, synthpop was probably the more common term for pop music using synthesizers.\n\nWhen Kraftwerk first appeared in the mid-1970\'s, their music was described as electronic body music (ebm) in Germany, Krautrock in England, and technopop in Japan.  The British synthesizer artists such as Depeche Mode and New Order who arose in the wake of Kraftwerk were most commonly known as new wave or synthpop.  The word electropop may have been used for these acts, but it was not yet common.\n\nStarting in the early 1980\'s, the word electro was used to describe artists such as Herbie Hancock, Afrika Bambaataa and Man Parrish who played funk-like music using synthesizers. \n\nStarting around 1997, bands such as Fischerspooner and Ladytron revived 1980\'s-style synthpop with characteristic deadpan vocals, but the movement was marketed as electroclash.  In 2002, Benny Benassi released \'Satisfaction,\' and crackly synthesizer began to become a common feature of electro house, and the electropop music inspired by it.  Electropop often has more emphasis on clear vocals than electroclash or electro house, but there is a good deal of common ground between these three genres.\n\nSignature modern electropop songs include \"Heartbeats\" by The Knife and \"Poker Face\" by Lady Gaga.  Read more on Last.fm. User-contributed text is available under the Creative Commons By-SA License; additional terms may apply.', NULL, NULL, '2025-04-22 16:30:54', '2025-04-22 16:30:54'),
(31, 'Ballad', 'Music that\'s slow in tempo, usually sung or performed with a romantic or sentimental emotion, and often out of character for the band or artist performing the song. Read more on Last.fm. User-contributed text is available under the Creative Commons By-SA License; additional terms may apply.', NULL, NULL, '2025-04-22 16:30:56', '2025-04-22 16:30:56');
INSERT INTO `genres` (`id`, `name`, `description`, `origin_year`, `origin_country`, `created_at`, `updated_at`) VALUES
(32, 'death metal', 'Death metal is an extreme subgenre of metal, most easily identifiable by its utilization of bass-heavy guitar distortion, harsh, often growled or grunted vocals, and particular brand of compositional density. Best known death metal bands include Morbid Angel, Autopsy, Suffocation, and Entombed, all of which had in their earliest years contributed codifying releases to the subgenre.\n\nIn the middle of the 1980s, the stylistic origins of death metal manifested; 1984 saw the release of a few EPs (Slayer - Haunting the Chapel; Celtic Frost - Morbid Tales) and several demos (Necrophagia - Death Is Fun; Possessed - Death Metal) from which the subgenre would initially draw its compositional and lyrical motifs.  1985 saw the first full-length death metal release in the well-known Seven Churches, the earliest identifiable distinction the subgenre made from other emergent forms of extreme metal.\n\nBy the end of the decade, death metal had developed regional specificities.  Two particular regions of the United States yielded two particular sounds: California (Sadus, Terrorizer, Autopsy) and Florida (Obituary, Morbid Angel, Death); meanwhile, Sweden had developed a unified sound of its own (Merciless, Grotesque, Carnage, Nihilist).  Other regions of the world followed suit, to include Brazil (Psychic Possessor, Mutilator, Sepultura), Britain (Cancer, Benediction, Bolt Thrower), and Mainland Europe (Necrodeath, Messiah, Sempiternal Deathreign, Pestilence).\n\n1990 saw a worldwide surge of activity in death metal.  Further subgenres were founded by seminal releases in the following years, with technical death metal (Gorguts - Considered Dead; Suffocation - Human Waste) appearing in 1991 and melodic death metal (Amorphis - The Karelian Isthmus, Eucharist - A Velvet Creation; Carcass - Heartwork) properly taking root in 1993.  These stylistic schisms were the much more visible faces of death metal from the middle of the 1990s through to the middle of the 2000s.\n\nAfter over a decade of scarcity characterized by throwback tribute efforts and understated misfires, the emergence of a new, third wave of legitimate, genre-appropriate death metal slowly became apparent.  As early as 2006, the reception of Repugnant - Epitome of Darkness signaled a change in the common conception of the death metal aesthetic held by newer bands; by 2008, several like-minded record labels (Razorback, Nuclear War Now!, Hells Headbangers) and critically exceptional releases (Acid Witch - Witchtanic Hellucinations; Dead Congregation - Graves of the Archangels) had cemented the movement\'s permanence. Read more on Last.fm. User-contributed text is available under the Creative Commons By-SA License; additional terms may apply.', NULL, NULL, '2025-04-22 16:30:58', '2025-04-22 16:30:58'),
(34, '2000s', 'Music that was popular during the decade beginning with year 2000. Where previous decades, such as the Sixties and the Seventies, all have a clear name, no consensus has yet been reached on how to refer to this period in music history. Possibilities include \"the Noughties\", \"the Hundreds\", \"O\'s\" and \"the Zeros\", among others.  Read more on Last.fm. User-contributed text is available under the Creative Commons By-SA License; additional terms may apply.', NULL, NULL, '2025-04-22 16:31:22', '2025-04-22 16:31:22'),
(35, 'emocore', 'Emocore is a style of Post-Hardcore that emerged primarily in Washington D.C. in the summer of 1985, as a reaction against the by then stagnant Hardcore Punk scene. Most of the bands were composed of former hardcore musicians, and they used that genre as a basis for the new emocore sound. The shouted vocals and fast distorted guitars of hardcore punk were set to midtempo songs that focused more on melodies and dynamics than aggression and speed, and the lyrics were often introverted and emotional which had previously been uncommon in the punk rock scene. Prominent bands of the genre include Rites of Spring, Embrace, Dag Nasty, and Moss Icon, and many of these bands were in some way connected to the independent label Dischord Records. Read more on Last.fm. User-contributed text is available under the Creative Commons By-SA License; additional terms may apply.', NULL, NULL, '2025-04-22 16:31:26', '2025-04-22 16:31:26'),
(36, 'pop', 'Pop music is a broad-term for many different types of music: The term is flexible, and the music labeled \"pop\" changes frequently. It usually refers to popular, appealing and mostly mainstream music with emphasis on catchy melodies and an accessible style, with songs that tend to have a short to medium length. Some subgenres may include synthpop, electropop, bubblegum, sophisti-pop, hyperpop and many others. Read more on Last.fm. User-contributed text is available under the Creative Commons By-SA License; additional terms may apply.', NULL, NULL, '2025-04-22 16:31:28', '2025-04-22 16:31:28'),
(38, 'soty', '\"Song of the Year\" or SOTY Read more on Last.fm. User-contributed text is available under the Creative Commons By-SA License; additional terms may apply.', NULL, NULL, '2025-04-22 16:31:51', '2025-04-22 16:31:51'),
(39, 'british', 'Bands and artists that are from Great Britain; generally referring to artists from England but can also be used for Scottish and Welsh acts. Irish need not apply.\n\nRelated tags: American, Irish, Jamaican, Australian, Canadian, New Zealand\n\nPop: The Beatles (John Lennon, Paul McCartney, George Harrison, Ringo Starr), George Michael, Elton John, One Direction, Adele, Coldplay, Spice Girls, The Police,Boy George, Phil Collins, Dua Lipa, Dusty Springfield, Tom Jones, Sam Smith, Ed Sheeran       \nRock: David Bowie, Led Zeppelin, The Who, Kate Bush, Oasis, The Rolling Stones, Queen, Pink Floyd, Genesis, Eric Clapton, Cream, Bad Company,The Kinks, The Yardbirds, Jeff Beck, Donovan, John Mayall & the Bluesbreakers, Nazareth, Electric Light Orchestra (ELO), Yes, T. Rex, The Moody Blues, Roxy Music, Dire Straits, King Crimson, Jethro Tull, Small Faces, Supertramp, The Alan Parsons Project, Peter Frampton, Rod Stewart, Muse, Steve Winwood, Gary Glitter      \nElectronic: Aphex Twin, Fatboy Slim, The Chemical Brothers, Burial, Ladytron, Calvin Harris, Utah Saints, 808 State, Boxcutter, Skream, Artful Dodger, Disclosure, Sneaker Pimps, Massive Attack, Squarepusher, Goldie, Congo Natty, LFO, Boards of Canada, Autechre, James Blake, Benga, SBTRKT, SOPHIE    \nPunk: The Clash, Sex Pistols, The Pogues, Buzzcocks, The Jam, The Damned, The Adverts, Generation X, The Undertones     \nPost-Punk: The Smiths, Siouxsie and the Banshees, Talk Talk, Joy Division, XTC, Elastica, The Jesus and Mary Chain, The Fall, Bauhaus, Wire, Gang of Four, Public Image Ltd, The Sisters of Mercy, Echo & the Bunnymen, The Cure         \nMetal: Black Sabbath, Def Leppard, Iron Maiden, Motörhead, Deep Purple, Judas Priest, Rainbow  \nAlternative: The Stone Roses, Radiohead, Blur, Gorillaz, PJ Harvey, The Verve, Pulp, Suede, Stereophonics, Super Furry Animals, Primal Scream, Morrissey       \nSynth-Pop: Depeche Mode, Gary Numan, The Human League, Frankie Goes to Hollywood, A Flock of Seagulls, New Order, Charli XCX, Duran Duran, Simple Minds, Spandau Ballet, Yazoo (known as Yaz in North America), Thomas Dolby, Tears for Fears, Scritti Politti, Pet Shop Boys  \nBritish hip-hop/Grime: Wiley, Dizzee Rascal, Skepta, Slick Rick, MF DOOM, Stormzy, slowthai, Tricky, JME      \nIndie: Arctic Monkeys, King Krule, Happy Mondays, Alt-J, Bloc Party, Longpigs, Yuck, The Kooks,Inspiral Carpets, The La\'s Read more on Last.fm. User-contributed text is available under the Creative Commons By-SA License; additional terms may apply.', NULL, NULL, '2025-04-22 16:31:51', '2025-04-22 16:31:51'),
(40, 'electronica', 'Electronica includes a wide range of contemporary electronic music designed for a wide range of uses, including foreground listening, some forms of dancing, and background music for other activities; but unlike electronic dance music, it is not specifically made for dancing. The term was first used in the United States in the early 1990s with regards to post-rave global-influenced electronic dance music. Genres such as techno, drum and bass, downtempo, and ambient are among those encompassed by the umbrella term, entering the American mainstream from \"alternative\" or \"underground\" venues during the late 1990s. Prior to the adoption of electronica for this purpose, terms such as electronic listening music, trance and intelligent dance music (IDM) were used.\n\nThe All Music Guide categorizes electronica as a top-level genre on their main page, where they state that electronica includes \"dozens of stylistic fusions\" ranging from danceable grooves to music for headphones and chillout areas.\n\nAfter beginning as an underground genre in the early 1990s, electronica has grown to influence even mainstream crossover recordings. Elements of electronica are used today by many popular artists in mainstream music. Read more on Last.fm. User-contributed text is available under the Creative Commons By-SA License; additional terms may apply.', NULL, NULL, '2025-04-22 16:31:59', '2025-04-22 16:31:59'),
(41, 'Drum and bass', 'Drum and bass (commonly abbreviated to d&b, DnB, dnb, d\'n\'b, drum n bass, drum & bass) is a type of electronic dance music which emerged in the mid 1990s. The genre is characterised by fast tempo broken beats (generally between 160–180 beats per minute, but also having occasional differences in some older compositions), with heavy sub basslines.\n\nThe genre roots itself in the UK rave scene, and has spread around the world, notably to Europe, Russia, and the USA.\n\nUp until the late 1990s/mid 2000s, drum and bass remained a relatively underground genre. However, artists such as Pendulum and High Contrast and labels such as Breakbeat Kaos and Hospital Records have helped push the popularity and awareness of the genre into the public domain.\n\nAs it stands, drum and bass is gaining more and more popularity, enjoying regular airplay on the radio, such as BBC Radio 1 in the UK. Read more on Last.fm. User-contributed text is available under the Creative Commons By-SA License; additional terms may apply.', NULL, NULL, '2025-04-22 16:32:03', '2025-04-22 16:32:03'),
(42, 'breakcore', 'Breakcore is a loosely defined electronic music style that brings together elements of industrial, jungle, hardcore techno and IDM into a breakbeat-oriented sound that encourages speed, complexity, impact and maximum sonic density. Similar to punk, breakcore adheres to a loose set of stylistic \"rules\" and is defined more by an attitude than by a musical formula.\n\nInfluences and Development\nBreakcore began to evolve out of boredom with stagnant forms of more traditional techno and rave music, as well as an evolution within noise and sound art. A need for faster BPMs as well as a more anti-authoritarian sound also pushed the various sub-genres to greater extremes.\n\nProto-breakcore came from London, Berlin and Newcastle, Australia (home of Bloody Fist Records). Early influential artists include Alec Empire, DJ Scud, Panacea, Christoph Fringeli and Nasenbluten. Fringeli describes the sound then as \"a hybrid strategy rather than a style or genre. It drew its influences and sources from industrial hardcore, jungle/drum\'n\'bass and everything in between and neighbouring it, engaging in an alchemy of sounds, pillaging the rave culture and sharpening, radicalizing and intensifying it.\"\n\nAmbush Records\nIn London, DJ Scud co-founded Ambush Records with fellow producer Aphasic to focus on more extreme noise-oriented hardcore drum and bass. Some artists released on Ambush are Christoph Fringeli, Slepcy, Panacea, and Noize Creator. \"Scud and Nomex tracks like \'Total Destruction\' helped create the blueprint for much of breakcore\'s sound, a high-bpm mash-up of hyperkinetic, post-jungle breaks, feedback, noise, and Jamaican elements paired with a devil-may-care attitude towards sampling that pulls from the broadest musical spectrum of styles (hip-hop, rock, industrial, pop, and beyond).\"\n\nBloody Fist Records\nAt the same time, Bloody Fist Records based in Newcastle, Australia released many records of hardcore/gabber, industrial, and noise. Label founder Mark Newlands said, in 1997, \"I think that the uncomfortableness also comes from a reaction towards the mainstream and popular culture that\'s constantly shoved down our throats, that\'s forced on the people via television, radio, mass media, etc. I think that also fuels the fire and keeps the aggressiveness there and the uncomfortableness.\" Artists signed to Bloody Fist in its lifetime include Syndicate, Xylocaine, Epsilon and Nasenbluten.\n\nDigital Hardcore Recordings\nFormed in 1994, Digital Hardcore Recordings released music by artists such as Alec Empire, Patric Catani, Shizuo, Atari Teenage Riot, EC8OR and Bomb 20, shaping the breakcore sound. The Alec Empire album the destroyer  is often noted as the first breakcore album.\n\n\nBreakcore becomes a genre\nAs the early days of \"hardcore techno\" or just \"hardcore\" began to settle in Europe, breakcore as a genre began to take more concrete forms in other parts of the world. Inspired by new labels such as Addict, from Milwaukee, USA; Peace Off from Rennes, France; Sonic Belligeranza from Bologna, Italy; and Planet µ, from London, began to take a new shape, adding in more elements of mash-up and IDM to the hardcore sounds. Each of these labels began to draw in aspects of their own social and aesthetic scenes into their music, allowing for an even broader definition of what was possible in the music.\n\nOne of the most controversial issues in breakcore is that of the mere existence of the genre. Because it pulls liberally from other musical genres, there is not a consensus on what is and what is not breakcore, or even over the usefulness of the term itself. Because of the fragmentation, the breakcore scene is not centered in any one geographical location, but is rather scattered into disparate groups. Perhaps the one place where breakcore\'s \"voice\" can be heard is virtually, through the internet and various online forums, such as those at C8 and Widerstand.\n\nAccording to Simon Reynolds, of The New York Times, breakcore is \"purveyed by artists like DJ /Rupture and Team Shadetek, the music combines rumbling bass lines, fidgety beats and grainy ragga vocals to create a home-listening surrogate for the bashment vibe of a Jamaican sound system party. Others within the breakcore genre, like Knifehandchop, kid606 and Soundmurderer, hark back to rave\'s own early days, their music evoking the rowdy fervor of a time when huge crowds flailed their limbs to a barrage of abstract noise and convulsive rhythm. It\'s a poignant aural mirage of a time when techno music was made for the popular vanguard rather than a connoisseurial elite, as it is today.\"\n\nIn Europe, the breakcore genre was solidified by raves and club events such as Breakcore Gives Me Wood, in Belgium, and Breakcore A Go Go, in the Netherlands, which was run by FFF and Bong-Ra; as well as Anticartel, in Rennes, and later, Wasted, in Berlin.\n\n\nAmen break\nWhile breakcore is definitely not only organized around the cutting and distortion of the amen break, it is a key to defining the genre. The amen break in breakcore is primarily used at high-speeds and edited to produce jarring effects when distorted and layered in combination with almost any sound. This particular drum-break sound characterizes many breakcore songs and is still used as a key factor to define the sound. This is in line with breakcore\'s tendency to create a post-modern parody of drum and bass clichés - many of the sounds heard in breakcore are very \"classic\" jungle samples.\n\n\nDistribution\nSince the genre as a whole still is developing and growing rapidly, the music itself is largely downloaded via peer-to-peer networks, and discussed on internet forums. Whereas the early days of breakcore were based in select urban cities, the genre now has no geographical center. The music itself tends to reflect this multiplicity of media diffusion itself (as already mentioned) by incorporating so many different forms of music all hacked together to form breakcore. It remains a relatively small genre, but compared to its size prior to the 1990s web boom, it continues to grow substantially.\n\n\nDevelopments in the genre\nBreakcore has forever been changing and branching. Many newer breakcore artists focus on melodic progressions and complex drum programming while other artists still focus on distorted hardcore breakbeats and dark-edged musical influences (such as heavy metal, and industrial). The prolific Venetian Snares has produced breakcore blended with elements of classical music. Other artists such as Shitmat, Toecutter, Sickboy and DJ Scotch Egg take another direction towards mash-up, happy hardcore and rave to make a lighter, more humorous sound. The rise of chiptune music has also blended with breakcore with artists such as Patric Catani, AA.Kurtz, Sabrepulse, Daylight Daterape, Tarmvred, and DJ Fhantom. Some musicians from the power noise scene have begun to take influence from breakcore. The UK Free Party scene has also expressed a large interest in producing and distributing its own takes on breakcore, with crews and labels such as Headfuk, Hecate, Bad Sekta, NoFixedAbode, Marionette records, Tinnitus, Ill Industries & Life4Land helping to push the scene and sound forward, as well as bringing over a number of international artists to play at their parties and club nights. Read more on Last.fm. User-contributed text is available under the Creative Commons By-SA License; additional terms may apply.', NULL, NULL, '2025-04-22 16:32:03', '2025-04-22 16:32:03'),
(43, 'Drum n Bass', 'Shortened/slang form of the \"drum and bass\" tag. Read more on Last.fm. User-contributed text is available under the Creative Commons By-SA License; additional terms may apply.', NULL, NULL, '2025-04-22 16:32:03', '2025-04-22 16:32:03');

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
  `last_updated_by_user` bigint(20) UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `lyrics`
--

INSERT INTO `lyrics` (`id`, `lyrics`, `status`, `track_id`, `last_updated_by_user`, `created_at`, `updated_at`) VALUES
(1, '[Verse 1: Oli Sykes]\\r\\nWe are the children of the devolution\\r\\nThe infamous martyrs, the scars on the sun\\r\\nAsphyxiating with a smile on your face\\r\\nWhile they pull your teeth out one by one\\r\\n\\r\\n[Pre-Chorus: Oli Sykes & Lee Malia]\\r\\nIs this what you wanted? No\\r\\nDo you want some more? Yeah\\r\\nD-Generation\\r\\nWho\\\'s keeping score?\\r\\n\\r\\n[Chorus: Oli Sykes]\\r\\n\\\'Cause you got a taste now, drank the Kool-Aid by the jug\\r\\nSo suffer your fate, oh, come here and give me a hug\\r\\nNobody loves you like I love you, oh, my dear\\r\\nBut you should\\\'ve known that this was gonna end in tears\\r\\n\\r\\n[Verse 2: Oli Sykes]\\r\\nSuch a sucker for an execution\\r\\nThe void is a vampire, fat on our blood\\r\\nDomesticated like a cat in a cage\\r\\nWhile they try their hand at playing God\\r\\n\\r\\n[Pre-Chorus: Oli Sykes & Lee Malia]\\r\\nIs this what you wanted? No\\r\\nDo you want some more-e-e-e? Yeah\\r\\nD-Generation\\r\\nAfraid there\\\'s no cure\\r\\n\\r\\n[Chorus: Oli Sykes]\\r\\n\\\'Cause you got a taste now, drank the Kool-Aid by the jug\\r\\nSo suffer your fate, oh, come here and give me a hug\\r\\nNobody loves you like I love you, oh, my dear (Oh, oh-oh)\\r\\nBut you should\\\'ve known that this was gonna end in tears\\r\\n\\r\\n[Post-Chorus: Lucy Landry]\\r\\nOh, oh-oh, oh-oh, oh-oh\\r\\n\\r\\n[Bridge: Oli Sykes]\\r\\nI got my hands around your throat, I love the way you choke\\r\\n\\\'Cause I am yours and you are mine, I\\\'ll never let you go\\r\\nMy hands around your throat, I love the way you choke\\r\\n\\\'Cause I am yours and you are mine, I\\\'ll never let you go\\r\\n\\r\\n[Breakdown: Oli Sykes & Lee Malia]\\r\\n(Hey! Hey! Hey! Hey! Hey! Hey!)\\r\\nI\\\'ll never let you go\\r\\n(Hey! Hey! Hey! Hey! Hey! Hey!)\\r\\nGet the fuck up\\r\\nYeah!\\r\\n\\r\\n[Guitar Solo]\\r\\n\\r\\n[Chorus: Oli Sykes]\\r\\n\\\'Cause you got a taste now, drank the Kool-Aid by the jug\\r\\nSo suffer your fate, oh, come here and give me a hug\\r\\nNobody loves you like I love you, oh, my dear (Oh, oh-oh)\\r\\nBut you should\\\'ve known, you should\\\'ve known\\r\\nBut you should\\\'ve known that this was gonna end in tears\\r\\n[Outro: Oli Sykes]\\r\\nYou should\\\'ve known\\r\\n\\r\\n[Segue: Oli Sykes]\\r\\nWhat if it\\\'s like\\r\\nLa, la-la-la, la-la-la\\r\\nLa, la-la-la, la-la-la, la-la-la?\\r\\nOh, I forgot somethin\\\'\\r\\nLa-la-la, la-la-la, la-la-la, la, yeah\\r\\nLa-la-la\\r\\nThat this was gonna end in tears\\r\\nOr some shit like that', 'requires verification', 3, NULL, '2025-04-22 19:35:32', '2025-04-22 19:35:32'),
(2, '[Verse 1]\\r\\nThere\\\'s a place I wanna take you\\r\\nBut I\\\'m not quite there myself yet\\r\\n(Doo-doo-doo-doo-doo)\\r\\nI\\\'m getting better but there\\\'s still days\\r\\nWhere I wish that I was someone else\\r\\nBut I know\\r\\n\\r\\n[Pre-Chorus]\\r\\nThere is a home, somewhere\\r\\nBeyond my bones\\r\\nAnd I\\\'m just too terrified\\r\\nTo dive inside\\r\\n\\r\\n[Chorus]\\r\\nSoul like a cemetery\\r\\nHard to ignore, we\\\'re sick to the core\\r\\nA world\\\'s been buried\\r\\nWhеre love is the law, a youtopia\\r\\n\\r\\n[Post-Chorus]\\r\\n(Scrеam)\\r\\n\\r\\n[Verse 2]\\r\\nGolden raspberry\\r\\nFor the performance in your head\\r\\n(Doo-doo-doo-doo-doo)\\r\\nStop pushing daisies\\r\\nNo one wants flowers when they\\\'re dead\\r\\n\\r\\n[Chorus]\\r\\nSoul like a cemetery\\r\\nHard to ignore, we\\\'re sick to the core\\r\\nA world\\\'s been buried\\r\\nWhere love is the law, a youtopia\\r\\n\\r\\n[Bridge: Oli Sykes, Oli Sykes & Dan Lancaster]\\r\\n(There is a home) There is a home, ah-ah-ah\\r\\n(Beyond our bones) Beyond our bones\\r\\nSo connect to the Divine\\r\\nIt\\\'s okay to cry, yeah\\r\\n\\r\\n[Instrumental Break]\\r\\n\\r\\n[Chorus]\\r\\nSoul like a cemetery\\r\\nHard to ignore, we\\\'re sick to the core\\r\\nA world\\\'s been buried\\r\\nWhere love is the law\\r\\n\\r\\n[Post-Chorus]\\r\\nA youtopia (There\\\'s a place I wanna take you)\\r\\nA youtopia (There\\\'s a place I wanna take you)\\r\\nA youtopia (There\\\'s a place I wanna take you)\\r\\nWhere love is the law, a youtopia\\r\\n\\r\\n[Outro]\\r\\nWhat was it like?\\r\\nIt\\\'s like I walked into a dream\\r\\nAnd stepped out of the coma', 'requires verification', 2, NULL, '2025-04-22 19:38:01', '2025-04-22 19:38:01');

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '0001_01_01_000000_create_users_table', 1),
(2, '0001_01_01_000001_create_cache_table', 1),
(3, '0001_01_01_000002_create_jobs_table', 1),
(4, '2025_03_19_082740_create_genres_table', 1),
(5, '2025_03_19_084131_create_artists_table', 1),
(6, '2025_03_19_085251_create_releases_table', 1),
(7, '2025_03_19_090516_create_tracks_table', 1),
(8, '2025_03_19_102139_create_lyrics_table', 1),
(9, '2025_03_19_110832_create_artists_genres_table', 1),
(10, '2025_03_19_111040_create_releases_genres_table', 1),
(11, '2025_03_30_160539_create_tracks_genres_table', 1),
(12, '2025_03_30_160841_create_artists_releases_table', 1),
(13, '2025_03_30_161945_create_artists_tracks_table', 1),
(14, '2025_03_30_165959_create_comments_releases_table', 1),
(15, '2025_03_30_171840_create_comments_artists_table', 1),
(16, '2025_03_30_172446_create_comments_tracks_table', 1),
(17, '2025_03_30_184056_create_user_collections_table', 1),
(18, '2025_03_30_185746_create_user_collections_tracks_table', 1),
(19, '2025_03_30_191037_create_recommendations_table', 1),
(20, '2025_03_30_191216_create_recommendations_genres_table', 1),
(21, '2025_03_30_191509_create_recommendations_artists_table', 1),
(22, '2025_04_01_183108_create_user_favorite_artists_table', 1),
(23, '2025_04_12_122711_create_tracks_releases_table', 1),
(24, '2025_04_22_181327_create_roles_table', 1),
(25, '2025_04_22_181931_create_users_roles_table', 1);

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
  `user_rating` enum('1','2','3','4','5','not_rated') NOT NULL DEFAULT 'not_rated',
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
  `release_date` date NOT NULL,
  `description` text DEFAULT NULL,
  `release_type` enum('album','ep','single','compilation') NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `releases`
--

INSERT INTO `releases` (`id`, `title`, `release_date`, `description`, `release_type`, `created_at`, `updated_at`) VALUES
(1, 'POST HUMAN: NeX GEn', '2024-05-24', 'POST HUMAN: NeX GEn is the second installment in the POST HUMAN series, coming after POST HUMAN: SURVIVAL HORROR, revealed on Twitter by the band on June 9th 2023 and initially set to be released on September 15th 2023. Described by the band as a mix of emo, pop-punk, hyperpop and post-hardcore.\nOn August 23rd, 2023, Bring Me The Horizon delayed the album\'s release date to an unspecified period due to NeX GEn not being complete yet. \n\nThe album was released on May 24th, 2024.  User-contributed text is available under the Creative Commons By-SA License; additional terms may apply.', 'album', '2025-04-22 16:29:04', '2025-04-22 16:31:45'),
(2, 'POST HUMAN: SURVIVAL HORROR', '2020-10-30', 'Bring Me The Horizon’s first record after 2019’s amo, Post Human: Survival Horror is part of a four EP project. The first record is the heaviest one and it brings back the style of the band’s first records. As Oli Sykes said to Music Feeds:\n\n\"It’s kind of a mix, just like you’ve heard on “Parasite Eve,” where it still feels bonkers in terms of jumping from genre to genre and sound to sound, but we’ve definitely took a little bit more influence from things we did quite a few years ago.  Whereas now we’ve got something to be angry about, we’ve got something to be pissed about, we’ve got something to make violent music to.\"\n\nThe word “Posthuman” or “Post-human” is a word that originates from futurology that means a person or entity that exists in a state beyond what we know as a “human.” While the exact meaning of the word varies, it is generally considered to be a person who through either genetic manipulation or other biointerventionist measures, has the ability to remain healthy and active through an extended period of time that would not be considered normal by our current standards. Their cognitive powers, such as deductive thought or other intellectual capabilities, would far surpass those of a simple human.\n\n\"The idea behind Post Human is looking at how we’ve stepped out of evolution and the food chain. If we can do that, then we can take responsibility for what we’ve done to the planet and become something better than what humans are right now.\"\n\n—Oli Sykes, NME\n\nEvery part of this project is sonically different and have a different message. This first album expresses all the anger inside people and is “a recruitment record with battle songs,” as Oli explains:\n\n\"You know like on Lord of the Rings where they all sing a song before battle, knowing that they might die but they’re going got persevere and see how it goes? We’re trying to embody that. This first record is about hope and anger and feels like the sonic equivalent of a riot. We’re inviting people to find the solution with us. It’s a demonstration to pull you in and get your back up. It’s a lot more aggressive than anything we’ve done for a while. The world doesn’t need light-hearted pop music right now—it needs anthems for anger. There’s so much to be pissed off about.\"\n\nThe band needed a cyberpunk feeling to the album, so they decided to call Mick Gordon, DOOM Eternal’s musical producer.\n\n\"I’ve been playing this one game called DOOM Eternal and as I was playing it I absolutely fell in love with the soundtrack. It’s fucking crazy. It’s heavy as fuck. It’s got this kind of dystopian cyber-punky djent kind of fucking huge vibe. A guy called Mick Gordon actually produced all this music. At first, when we were writing “Parasite Eve” especially I was referencing a lot of this DOOM game ‘cause I was playing it in the day and then me and Jordan would work at night and I was like using this as references because the sounds in there sound so huge and so hitting in a way I haven’t heard in any other metal music. And then it kind of dawned on me that like, you know, maybe this is the guy we’re looking for to collaborate with. So I hit him up. Amazingly, he got back to us and said he was a massive fan of the band and really loved what we did and would love to work with us. So I started talking to him, we got chatting, I told him my ideas and wrote him a bunch of notes and basically just left the song with him and he came back with a fucking sound library.  So he added textures and tunings to the vocals and shit like that really kind of just pushes it further to make you feel what we are trying to get across. So yeah, he smashed it basically and I’m really stoked on how that turned out. I think we’re going to be working with him more on this record.\"\n\n—Oli Sykes, BMTH Season 2’s “Mick Gordon”  User-contributed text is available under the Creative Commons By-SA License; additional terms may apply.', 'album', '2025-04-22 16:29:05', '2025-04-22 16:30:45'),
(3, 'Live at the Royal Albert Hall', '2020-10-28', NULL, 'album', '2025-04-22 16:29:06', '2025-04-22 16:29:06'),
(4, 'Music to listen to~dance to~blaze to~pray to~feed to~sleep to~talk to~grind to~trip to~breathe to~help to~hurt to~scroll to~roll to~love to~hate to~learn Too~plot to~play to~be to~feel to~breed to~sweat to~dream to~hide to~live to~die to~GO TO', '2019-12-27', NULL, 'album', '2025-04-22 16:29:07', '2025-04-22 16:29:07'),
(5, 'amo', '2019-01-25', 'Amo (stylised in lowercase) is the sixth studio album by British rock band Bring Me the Horizon. Originally scheduled for release on 11 January 2019, it was released on 25 January 2019. The album was announced on 22 August 2018, a day after the release of the lead single \"Mantra\". It is produced by frontman Oliver Sykes and keyboardist Jordan Fish, and was written and recorded primarily in Los Angeles.\n\nThe band embarked on the First Love World Tour in 2019 in support of the album. In the 22 August 2018 issue of Kerrang!, they described the album as \"varied\", \"free\", \"weird\" and \"mental\", with NME noting that \"Mantra\" continues the electronic and pop rock elements featured on the band\'s previous studio album, That\'s the Spirit (2015). \"Mantra\" subsequently debuted at number one on the UK Rock & Metal Chart, and its video was released on 24 August.\n\nThe album, named after the Portuguese word for \"I love\", was first promoted by an advertising campaign of billboards across London and other cities worldwide with symbols used by the band in the past on them, along with the words \"Do you wanna start a cult with me?\", which are lyrics from \"Mantra\". A website titled joinmantra.org was also launched that stated \"Salvation will return\", and a phone number that when called featured various audio clips at different times, including one of a woman named Samantha stating \"They\'re making me do this. I didn\'t know what I was getting myself into.\"\n\nThe song \"Mantra\" was subsequently premiered on BBC Radio 1, with Sykes saying to Annie Mac: \"It\'s basically—we\'ve gone off and recorded some stuff and this is the first thing we\'ve wanted to show people of our return. It\'s quite different but it\'s got similarities—it\'s what we wanted to share with the world.\" Sykes stated that \"Mantra\" is \"not really\" representative of the sound of the whole album, also saying \"every song on the record is completely different. It’s a lot more experimental than our last record.\"\n\nSykes stated about the album: \"amo is a love album that explores every aspect of that most powerful emotion. It deals with the good the bad and the ugly, and as a result we\'ve created an album that\'s more experimental, more varied, weird, and wonderful than anything we\'ve done before.\" He later commented that Amo is a concept album about love, as \"Everything boils down to love in the end\". Sykes also said that some of the lyrical content concerns his divorce.\n\nAll track titles are stylised in lowercase except for Mantra, which is stylised in all caps.\n  User-contributed text is available under the Creative Commons By-SA License; additional terms may apply.', 'album', '2025-04-22 16:29:08', '2025-04-22 16:31:28'),
(6, 'That\'s The Spirit', '2015-09-11', 'That’s The Spirit is the fifth studio album from British rock band Bring Me the Horizon released on September 11th, 2015. It shows a development of the sound introduced on the band\'s 2013 album Sempiternal, moving away from the metal and deathcore style of their older material and in favor of a less aggressive alternative rock and metal style. \n\nIn an interview with NME, lead vocalist Oli Sykes said that the album is a loose concept album about life\'s darker moods, such as depression, and a way of making light of it. He cited a wider range of influences such as Jane’s Addiction, Radiohead, Panic! at the Disco and Interpol on That\'s the Spirit. The album received universal acclaim from music critics, even as many fans expressed disappointment in the less heavy, stadium-friendly sound in Bring Me the Horizon\'s previously released albums. The album was self-produced by keyboardist Jordan Fish and Oli. The title is a reference to the refrain of “Happy Song,” which ironically samples a high school pep rally.  User-contributed text is available under the Creative Commons By-SA License; additional terms may apply.', 'album', '2025-04-22 16:29:09', '2025-04-22 16:30:07'),
(7, 'Sempiternal (Expanded Edition)', '2013-04-01', NULL, 'album', '2025-04-22 16:29:10', '2025-04-22 16:29:10'),
(8, 'There is a Hell Believe Me I\'ve Seen It. There is a Heaven Let\'s Keep it a Secret', '2010-10-04', NULL, 'album', '2025-04-22 16:29:11', '2025-04-22 16:29:11'),
(9, 'Suicide Season (Deluxe)', '2008-09-29', NULL, 'album', '2025-04-22 16:29:12', '2025-04-22 16:29:12'),
(10, 'Suicide Season', '2008-09-29', 'Suicide Season is the second studio album by Bring Me the Horizon, released on 29 September 2008 through Visible Noise in the United Kingdom and Europe. The band signed a licensing deal with Epitaph Records on 11 September 2008, with the label releasing the album on 18 November 2008 in the United States. The album entered the UK Chart at #47, the Australian ARIA Albums Chart at #28. and the Billboard 200 at #107. Suicide Season shows a major change musically from their previous releases, abandoning their original deathcore sound. This would also be the last album to feature Curtis Ward on rhythm guitar.\nBring Me the Horizon later released a two disc special edition of Suicide Season which features various musicians and producers a remixing tracks off the album, entitled Suicide Season: Cut Up! It features remixes of all the Suicide Season songs and was released on the 2 November 2009 in the United Kingdom through Visible Noise and on 12 April 2010 in the United States through Epitaph Records.\n\nSuicide Season departs from Bring Me the Horizon\'s previous deathcore sound, the band has been credited as starting to adopt a more eclectic style. In an interview with Metal Hammer magazine, Sykes states that this album is \"100% different\" from Count Your Blessings. He also says: \"We experimented a lot more I think, more with other styles of music we all enjoy, using different instruments and technology, by bringing a lot of digital stuff to the table. Every track is different.\" Because of this drastic change in sound from Count Your Blessings they have had experienced a massive fanbase shift.\n\nSykes has stated that because of the band being better focus when in the studio for the album it made it easier for them to experiment with song writing and expand their sound: \"We didn\'t really have any other band we wanted to sound like or any other style. We just thought we\'d try to do something different and see what comes out. And this is what came out.\"\n\nThe remix album Suicide Season: Cut Up! style has a range of different genres. Oliver Sykes in Interview states that \"There\'s not a song on there that really sounds like the original. What\'s great though is the diversity of each song. There\'s dubstep to hip-hop, electro to drum and bass.\" The dubstep style of the record has been acknowledged in tracks from Tek-one and Skrillex while the hip-hop elements are found in Travis McCoy\'s remix of Chelsea Smile. Benjamin Weinman\'s version of \"No Need for Introductions...\" is considerably the most unique with its incorporation of industrial music.  User-contributed text is available under the Creative Commons By-SA License; additional terms may apply.', 'album', '2025-04-22 16:29:13', '2025-04-22 16:31:12'),
(11, 'Count Your Blessings', '2006-10-30', 'Count Your Blessings is the debut album by British metalcore band Bring Me the Horizon. The album was released on October 30, 2006 in record stores around the United Kingdom, then in the United States nearly a year later on August 14, 2007. The album\'s name is derived from lyrics from the song \"Pray for Plagues\".\n\nEver since the release of Count Your Blessings the band has mainly discredited the album. Oliver Sykes in 2009 spoke about the album being recorded in Birmingham and that the location was a distraction for the band members: \"The studio was right in the middle of the city. There were so many distractions. Everyone recorded their parts on their own because everybody else was doing something else because we didn\'t want to sit in the studio all day.\"\n\nIn February 2011 Lee Malia commented on the album and how they were rushed to write songs for it, saying: \"We wrote that CD a lot faster. We didn’t have much time to write it. When we wrote it, we were obviously into it, but when we look back at it now there’s so much that could have been better. ‘Spose we were seventeen years old and we were doing an album so we were doing whatever\". The video for lead single \"Pray For Plagues\" has been viewed 35 million times on YouTube.  User-contributed text is available under the Creative Commons By-SA License; additional terms may apply.', 'album', '2025-04-22 16:29:14', '2025-04-22 16:30:58'),
(12, 'Spotify Singles', '2019-06-26', NULL, 'single', '2025-04-22 16:29:14', '2025-04-22 16:29:33'),
(13, 'Kool-Aid', '2024-01-05', NULL, 'single', '2025-04-22 16:29:15', '2025-04-22 16:29:15'),
(14, 'DArkSide', '2023-10-18', NULL, 'single', '2025-04-22 16:29:16', '2025-04-22 16:29:16'),
(15, 'Happier (feat. Oli Sykes of Bring Me The Horizon)', '2023-10-17', NULL, 'single', '2025-04-22 16:29:17', '2025-04-22 16:29:17'),
(16, 'CODE MISTAKE', '2023-06-30', NULL, 'single', '2025-04-22 16:29:17', '2025-04-22 16:29:17'),
(17, 'Werewolf (feat. Bring Me The Horizon)', '2023-06-29', NULL, 'single', '2025-04-22 16:29:18', '2025-04-22 16:29:18'),
(18, 'AmEN! (feat. Lil Uzi Vert and Daryl Palumbo of Glassjaw)', '2023-06-01', NULL, 'single', '2025-04-22 16:29:19', '2025-04-22 16:29:19'),
(19, 'Wish I Could Forget (with blackbear & Bring Me The Horizon)', '2023-05-19', NULL, 'single', '2025-04-22 16:29:19', '2025-04-22 16:29:19'),
(20, 'LosT', '2023-05-04', NULL, 'single', '2025-04-22 16:29:20', '2025-04-22 16:29:20'),
(21, 'sTraNgeRs', '2022-07-06', NULL, 'single', '2025-04-22 16:29:21', '2025-04-22 16:29:21'),
(22, 'Bad Life', '2022-06-24', NULL, 'single', '2025-04-22 16:29:22', '2025-04-22 16:29:22'),
(23, 'Bad Life (acoustic)', '2022-05-27', NULL, 'single', '2025-04-22 16:29:22', '2025-04-22 16:29:22'),
(24, 'Fallout', '2022-04-01', NULL, 'single', '2025-04-22 16:29:23', '2025-04-22 16:29:23'),
(25, 'Bad Habits (feat. Bring Me The Horizon)', '2022-02-08', NULL, 'single', '2025-04-22 16:29:24', '2025-04-22 16:29:24'),
(26, 'Moon Over the Castle (from GRAN TURISMO 7)', '2022-02-04', NULL, 'single', '2025-04-22 16:29:25', '2025-04-22 16:29:25'),
(27, 'DiE4u (six impala \"DiE6u\" Remix)', '2021-12-17', NULL, 'single', '2025-04-22 16:29:25', '2025-04-22 16:29:25'),
(28, 'VAMPIR', '2021-12-10', NULL, 'single', '2025-04-22 16:29:26', '2025-04-22 16:29:26'),
(29, 'Let’s Get The Party Started (feat. Bring Me The Horizon)', '2021-09-22', NULL, 'single', '2025-04-22 16:29:27', '2025-04-22 16:29:27'),
(30, 'DiE4u', '2021-09-16', NULL, 'single', '2025-04-22 16:29:27', '2025-04-22 16:29:27'),
(31, 'No More Friends', '2021-06-10', NULL, 'single', '2025-04-22 16:29:28', '2025-04-22 16:29:28'),
(32, 'Can You Feel My Heart (Remix)', '2021-03-05', NULL, 'single', '2025-04-22 16:29:29', '2025-04-22 16:29:29'),
(33, 'Teardrops', '2020-10-22', NULL, 'single', '2025-04-22 16:29:30', '2025-04-22 16:29:30'),
(34, 'Obey (with YUNGBLUD)', '2020-09-02', NULL, 'single', '2025-04-22 16:29:30', '2025-04-22 16:29:30'),
(35, 'Parasite Eve', '2020-06-25', NULL, 'single', '2025-04-22 16:29:31', '2025-04-22 16:29:31'),
(36, 'Ludens', '2019-11-06', NULL, 'single', '2025-04-22 16:29:32', '2025-04-22 16:29:32'),
(37, 'sugar honey ice & tea (Edit)', '2019-07-26', NULL, 'single', '2025-04-22 16:29:32', '2025-04-22 16:29:32'),
(38, 'mother tongue (Sub Focus Remix)', '2019-06-14', NULL, 'single', '2025-04-22 16:29:34', '2025-04-22 16:29:34'),
(39, 'nihilist blues (feat. Grimes)', '2019-01-24', NULL, 'single', '2025-04-22 16:29:35', '2025-04-22 16:29:35'),
(40, 'mother tongue', '2019-01-22', NULL, 'single', '2025-04-22 16:29:35', '2025-04-22 16:29:35'),
(41, 'medicine', '2019-01-03', NULL, 'single', '2025-04-22 16:29:36', '2025-04-22 16:29:36'),
(42, 'wonderful life (feat. Dani Filth)', '2018-10-21', NULL, 'single', '2025-04-22 16:29:37', '2025-04-22 16:29:37'),
(43, 'MANTRA', '2018-08-21', NULL, 'single', '2025-04-22 16:29:37', '2025-04-22 16:29:37'),
(44, 'Oh No (Radio Edit)', '2016-11-18', NULL, 'single', '2025-04-22 16:29:38', '2025-04-22 16:29:38'),
(45, 'Drown (Live from Maida Vale)', '2015-12-26', NULL, 'single', '2025-04-22 16:29:39', '2025-04-22 16:29:39'),
(46, 'Can You Feel My Heart', '2013-10-13', NULL, 'single', '2025-04-22 16:29:39', '2025-04-22 16:29:39'),
(47, 'Sleepwalking', '2013-03-04', NULL, 'single', '2025-04-22 16:29:40', '2025-04-22 16:29:40'),
(48, 'This Is What the Edge of Your Seat Was Made For', '2004-10-02', NULL, 'ep', '2025-04-22 16:29:41', '2025-04-22 16:29:41'),
(49, '2004 - 2013', '2017-11-24', NULL, 'compilation', '2025-04-22 16:29:42', '2025-04-22 16:29:42');

-- --------------------------------------------------------

--
-- Table structure for table `releases_genres`
--

CREATE TABLE `releases_genres` (
  `release_id` bigint(20) UNSIGNED NOT NULL,
  `genre_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `releases_genres`
--

INSERT INTO `releases_genres` (`release_id`, `genre_id`, `created_at`, `updated_at`) VALUES
(1, 2, '2025-04-22 16:31:45', '2025-04-22 16:31:45'),
(1, 7, '2025-04-22 16:31:45', '2025-04-22 16:31:45'),
(1, 9, '2025-04-22 16:31:45', '2025-04-22 16:31:45'),
(1, 13, '2025-04-22 16:31:45', '2025-04-22 16:31:45'),
(2, 2, '2025-04-22 16:30:45', '2025-04-22 16:30:45'),
(2, 5, '2025-04-22 16:30:45', '2025-04-22 16:30:45'),
(2, 7, '2025-04-22 16:30:45', '2025-04-22 16:30:45'),
(2, 8, '2025-04-22 16:30:45', '2025-04-22 16:30:45'),
(2, 10, '2025-04-22 16:30:45', '2025-04-22 16:30:45'),
(5, 6, '2025-04-22 16:31:28', '2025-04-22 16:31:28'),
(5, 7, '2025-04-22 16:31:28', '2025-04-22 16:31:28'),
(5, 10, '2025-04-22 16:31:28', '2025-04-22 16:31:28'),
(5, 12, '2025-04-22 16:31:28', '2025-04-22 16:31:28'),
(5, 36, '2025-04-22 16:31:28', '2025-04-22 16:31:28'),
(6, 2, '2025-04-22 16:30:08', '2025-04-22 16:30:08'),
(6, 6, '2025-04-22 16:30:08', '2025-04-22 16:30:08'),
(6, 7, '2025-04-22 16:30:08', '2025-04-22 16:30:08'),
(6, 8, '2025-04-22 16:30:08', '2025-04-22 16:30:08'),
(6, 9, '2025-04-22 16:30:08', '2025-04-22 16:30:08'),
(7, 2, '2025-04-22 16:30:24', '2025-04-22 16:30:24'),
(7, 7, '2025-04-22 16:30:25', '2025-04-22 16:30:25'),
(7, 9, '2025-04-22 16:30:25', '2025-04-22 16:30:25'),
(7, 16, '2025-04-22 16:30:25', '2025-04-22 16:30:25'),
(10, 1, '2025-04-22 16:31:12', '2025-04-22 16:31:12'),
(10, 2, '2025-04-22 16:31:12', '2025-04-22 16:31:12'),
(10, 3, '2025-04-22 16:31:12', '2025-04-22 16:31:12'),
(10, 4, '2025-04-22 16:31:12', '2025-04-22 16:31:12'),
(10, 5, '2025-04-22 16:31:12', '2025-04-22 16:31:12'),
(11, 1, '2025-04-22 16:30:58', '2025-04-22 16:30:58'),
(11, 2, '2025-04-22 16:30:58', '2025-04-22 16:30:58'),
(11, 3, '2025-04-22 16:30:58', '2025-04-22 16:30:58'),
(11, 4, '2025-04-22 16:30:58', '2025-04-22 16:30:58'),
(11, 32, '2025-04-22 16:30:58', '2025-04-22 16:30:58');

-- --------------------------------------------------------

--
-- Table structure for table `roles`
--

CREATE TABLE `roles` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(50) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

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
('f5js9usQPqQPYGDj8vVoXJUsB6nl5KP9jRbNCRtE', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiZVJPMFZta1dORlZFVFlQWVNDR3JlbXBlU2xHQmU2T0E2ZU5GVWhjSyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjE6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMCI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1745615777),
('vHJ7S3PvSMQFYtmTJwkVQGr9qCoarUpqmDFI1p3B', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiaGZoM2NtZFAyakZycmp3NFp6RmFTS3dKUm1yMUxNczlGelloS2J1ayI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjE6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMCI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1745652685);

-- --------------------------------------------------------

--
-- Table structure for table `tracks`
--

CREATE TABLE `tracks` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `title` varchar(255) NOT NULL,
  `duration` time NOT NULL,
  `description` text DEFAULT NULL,
  `audio_source` varchar(255) DEFAULT NULL,
  `release_date` date NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `tracks`
--

INSERT INTO `tracks` (`id`, `title`, `duration`, `description`, `audio_source`, `release_date`, `created_at`, `updated_at`) VALUES
(1, '[ost] dreamseeker', '00:00:19', NULL, NULL, '2024-05-24', '2025-04-22 16:29:04', '2025-04-22 16:29:04'),
(2, 'YOUtopia', '00:04:02', NULL, NULL, '2024-05-24', '2025-04-22 16:29:04', '2025-04-22 16:29:04'),
(3, 'Kool-Aid', '00:03:48', '“Kool-Aid” explores the manipulative and abusive drive of a cult leader who, in the end, is willing to sacrifice his followers for the ‘greater’ cause.\n\nThe title of the song is a reference to the Jonestown Massacre where 900 members of the Peoples Temple cult committed mass suicide upon the request of their leader, Jim Jones. They died from drinking cyanide and other sedatives in a fruit drink named “Flavor Aid”, which was originally misidentified as Kool-Aid. They later found needle marks, which meant some people were forced to die, making it a mass murder.\n\nThis is the sixth single and the third track from Bring Me The Horizon’s POST HUMAN: NeX GEn’s album, released on the 24th of May, 2024. Within its overarching lore, ”Kool-Aid” could be regarding the relationship within a cult/religion, more specifically The Church of GenXsis. Read more on Last.fm. User-contributed text is available under the Creative Commons By-SA License; additional terms may apply.', NULL, '2024-01-05', '2025-04-22 16:29:04', '2025-04-22 16:31:48'),
(4, 'Top 10 staTues tHat CriEd bloOd', '00:04:00', NULL, NULL, '2024-05-24', '2025-04-22 16:29:04', '2025-04-22 16:29:04'),
(5, 'liMOusIne (feat. AURORA)', '00:04:11', '\"liMOusIne\" is a song by Bring Me The Horizon featuring AURORA, released for the band\'s seventh studio album POST HUMAN: NeX GEn.\n\nOn April 13, 2024, Oliver posted a photo with AURORA, creating rumors that they would release a feature together. Read more on Last.fm. User-contributed text is available under the Creative Commons By-SA License; additional terms may apply.', NULL, '2024-05-24', '2025-04-22 16:29:04', '2025-04-22 16:31:51'),
(6, 'DArkSide', '00:02:44', '“DArkSide” is the sixth song on POST HUMAN: NeX GEn, the second instalment in the POST HUMAN series. It got released as the fifth single off the album before it’s full release, and also as the final single before Jordan Fish left the band on December 22, 2023\n\nThe song explores the darker side of the mind and the struggles you can have with yourself from within. Read more on Last.fm. User-contributed text is available under the Creative Commons By-SA License; additional terms may apply.', NULL, '2023-10-18', '2025-04-22 16:29:04', '2025-04-22 16:31:52'),
(7, 'a bulleT w/ my namE On (feat. Underoath)', '00:04:20', NULL, NULL, '2024-05-24', '2025-04-22 16:29:04', '2025-04-22 16:29:04'),
(8, '[ost] (spi)ritual', '00:01:54', NULL, NULL, '2024-05-24', '2025-04-22 16:29:04', '2025-04-22 16:29:04'),
(9, 'n/A', '00:03:20', NULL, NULL, '2024-05-24', '2025-04-22 16:29:04', '2025-04-22 16:29:04'),
(10, 'LosT', '00:03:25', NULL, NULL, '2023-05-04', '2025-04-22 16:29:04', '2025-04-22 16:29:20'),
(11, 'sTraNgeRs', '00:03:15', '“Strangers” is a song involving themes of depression and mental illness, but it also has an overall message of unity and togetherness, painting a picture that an entire ‘room full of strangers’ could all be having the same struggles and insecurities. The single was released on Wednesday, July 6th.\nIn an interview with NME, lead singer Oli Sykes went on to explain that this song was a takeaway from him having to share his pain with other people. He goes on to say that the first time he went to rehab, it was a ‘huge help’ to be surrounded by other people that were all suffering from something.\n\nJust to be surrounded by people who were all going through something, I thought, ‘Fuck, this is a human condition. This isn’t just me’. I thought I was insane, I didn’t think I was ever going to get better, and I’m listening to all these people saying all my thoughts, even though they’ve been through things that were different – worse…and obviously sTraNgeRs is that takeaway of like, we’re all just looking for security. We’re all just lost…it’s the first part of getting better, is the fact that you’re gonna have to accept that you’re gonna have to talk about this, no matter how bad what you’ve been through is. If you don’t get it out of your head, it’s never going to go.\n\nSykes also went on to explain how he believes n/A, LosT and sTraNgeRs are all part of what he calls the ‘rehab trilogy’, with n/A being the group session, LosT being the 1 on 1 therapy session, and sTraNgeRs about the realization of sharing your pain with other people. Read more on Last.fm. User-contributed text is available under the Creative Commons By-SA License; additional terms may apply.', NULL, '2022-07-06', '2025-04-22 16:29:05', '2025-04-22 16:31:59'),
(12, 'R.i.p. (duskCOre RemIx)', '00:03:23', NULL, NULL, '2024-05-24', '2025-04-22 16:29:05', '2025-04-22 16:29:05'),
(13, 'AmEN! (feat. Lil Uzi Vert and Daryl Palumbo of Glassjaw)', '00:03:09', NULL, NULL, '2023-06-01', '2025-04-22 16:29:05', '2025-04-22 16:29:19'),
(14, '[ost] p.u.s.s.-e', '00:02:49', 'produced by cynthoni Read more on Last.fm. User-contributed text is available under the Creative Commons By-SA License; additional terms may apply.', NULL, '2024-05-24', '2025-04-22 16:29:05', '2025-04-22 16:32:02'),
(15, 'DiE4u', '00:03:27', NULL, NULL, '2021-09-16', '2025-04-22 16:29:05', '2025-04-22 16:29:27'),
(16, 'DIg It', '00:07:12', NULL, NULL, '2024-05-24', '2025-04-22 16:29:05', '2025-04-22 16:29:05'),
(17, 'Dear Diary,', '00:02:44', NULL, NULL, '2020-10-30', '2025-04-22 16:29:05', '2025-04-22 16:29:05'),
(18, 'Parasite Eve', '00:04:51', NULL, NULL, '2020-06-25', '2025-04-22 16:29:05', '2025-04-22 16:29:31'),
(19, 'Teardrops', '00:03:35', NULL, NULL, '2020-10-22', '2025-04-22 16:29:05', '2025-04-22 16:29:30'),
(20, 'Obey (with YUNGBLUD)', '00:03:40', NULL, NULL, '2020-09-02', '2025-04-22 16:29:05', '2025-04-22 16:29:30'),
(21, 'Itch For The Cure (When Will We Be Free?)', '00:01:26', NULL, NULL, '2020-10-30', '2025-04-22 16:29:05', '2025-04-22 16:29:05'),
(22, 'Kingslayer (feat. BABYMETAL)', '00:03:40', '\"Kingslayer\" is the sixth track of Bring Me The Horizon\'s EP Post Human: Survival Horror, released October 30th, 2020. It features Japanese J-pop/metal band BABYMETAL. Read more on Last.fm. User-contributed text is available under the Creative Commons By-SA License; additional terms may apply.', NULL, '2020-10-30', '2025-04-22 16:29:05', '2025-04-22 16:30:51'),
(23, '1x1 (feat. Nova Twins)', '00:03:29', NULL, NULL, '2020-10-30', '2025-04-22 16:29:05', '2025-04-22 16:29:05'),
(24, 'Ludens', '00:04:40', '“It doesn’t sound like anything off ‘amo’, but it doesn’t sound like anything off any of our records,” frontman Oli Sykes told NME. “It hits a different tone. We had to write it in five days. We’ve been talking about this with Sony and Kojima for quite a while. I was really excited because I loved Metal Gear Solid and Kojima is just my favourite developer, he’s a legend. All of the legal shit was going on to the point where we like, ‘This isn’t going to happen’.\n\n“Then we got a call from the manager and he was like, ‘Yeah, it’s happening, but we need it within a week’. We were like, ‘We haven’t written anything yet! Can we have an extension or send them a demo as a placeholder’, and they were like, ‘If you don’t deliver the song on Saturday at 1pm then it won’t get used’.” Read more on Last.fm. User-contributed text is available under the Creative Commons By-SA License; additional terms may apply.', NULL, '2019-11-06', '2025-04-22 16:29:05', '2025-04-22 16:30:54'),
(25, 'One Day The Only Butterflies Left Will Be In Your Chest As You March Towards Your Death (feat. Amy Lee)', '00:04:03', '“One Day the Only Butterflies Left Will Be in Your Chest as You March Towards Your Death” is the final track of Bring Me The Horizon’s POST HUMAN: SURVIVAL HORROR. The song is a haunting ballad between Oli Sykes, representing humanity, and Amy Lee of Evanescence, representing Mother Nature.\n\nThe collaboration was a silver-lining after Evanescence sued the band over a verse from “nihilist blues” being extremely similar to their 2017 song “Never Go Back.” The lawsuit was eventually resolved with Amy Lee receiving songwriting credit for the song. After the suit, Evanescence’s team kept in contact with Bring me the Horizon. “They were like, ‘Amy really likes your band and would love to work with you,’ lead singer Oli Sykes said in an interview with NME.\n\nThe collaboration between the two artists came at a time when Amy Lee was feeling creatively stuck.\n\nIt was just a really fun escape from that little stuck moment that I was in, and it inspired me. It helped me feel, I don’t know… beautiful. The song is beautiful. That song is always gonna have a special place in my heart because I felt like, in a moment as an artist when I was stuck, another artist came along and helped me.\n\n—Amy Lee, Loudwire\n\nAccording to Lee, the recording process took a week for the vocalist, and the experience was quite unique as Bring Me the Horizon are located in the U.K. while Lee resides in the U.S., with the pair having to guide each other over the phone vocally and deal with the time differences between the two of them. Read more on Last.fm. User-contributed text is available under the Creative Commons By-SA License; additional terms may apply.', NULL, '2020-10-30', '2025-04-22 16:29:05', '2025-04-22 16:30:55'),
(26, 'Overture - Live at the Royal Albert Hall', '00:02:44', NULL, NULL, '2020-10-28', '2025-04-22 16:29:06', '2025-04-22 16:29:06'),
(27, 'Doomed - Live at the Royal Albert Hall', '00:04:40', NULL, NULL, '2020-10-28', '2025-04-22 16:29:06', '2025-04-22 16:29:06'),
(28, 'Happy Song - Live at the Royal Albert Hall', '00:04:42', NULL, NULL, '2020-10-28', '2025-04-22 16:29:06', '2025-04-22 16:29:06'),
(29, 'Go to Hell, for Heaven\'s Sake - Live at the Royal Albert Hall', '00:05:09', NULL, NULL, '2020-10-28', '2025-04-22 16:29:06', '2025-04-22 16:29:06'),
(30, 'Avalanche - Live at the Royal Albert Hall', '00:05:29', NULL, NULL, '2020-10-28', '2025-04-22 16:29:06', '2025-04-22 16:29:06'),
(31, 'It Never Ends - Live at the Royal Albert Hall', '00:06:07', NULL, NULL, '2020-10-28', '2025-04-22 16:29:06', '2025-04-22 16:29:06'),
(32, 'Sleepwalking - Live at the Royal Albert Hall', '00:04:56', NULL, NULL, '2020-10-28', '2025-04-22 16:29:06', '2025-04-22 16:29:06'),
(33, 'Empire - Live at the Royal Albert Hall', '00:04:13', NULL, NULL, '2020-10-28', '2025-04-22 16:29:06', '2025-04-22 16:29:06'),
(34, 'Throne - Live at the Royal Albert Hall', '00:04:03', NULL, NULL, '2020-10-28', '2025-04-22 16:29:06', '2025-04-22 16:29:06'),
(35, 'Shadow Moses - Live at the Royal Albert Hall', '00:05:09', NULL, NULL, '2020-10-28', '2025-04-22 16:29:06', '2025-04-22 16:29:06'),
(36, 'True Friends - Live at the Royal Albert Hall', '00:06:14', NULL, NULL, '2020-10-28', '2025-04-22 16:29:06', '2025-04-22 16:29:06'),
(37, 'Follow You - Live at the Royal Albert Hall', '00:03:53', NULL, NULL, '2020-10-28', '2025-04-22 16:29:06', '2025-04-22 16:29:06'),
(38, 'Can You Feel My Heart - Live at the Royal Albert Hall', '00:06:00', NULL, NULL, '2020-10-28', '2025-04-22 16:29:06', '2025-04-22 16:29:06'),
(39, 'Antivist - Live at the Royal Albert Hall', '00:04:31', NULL, NULL, '2020-10-28', '2025-04-22 16:29:06', '2025-04-22 16:29:06'),
(40, 'Drown - Live at the Royal Albert Hall', '00:07:09', NULL, NULL, '2020-10-28', '2025-04-22 16:29:06', '2025-04-22 16:29:06'),
(41, 'Oh No - Live at the Royal Albert Hall', '00:08:25', NULL, NULL, '2020-10-28', '2025-04-22 16:29:06', '2025-04-22 16:29:06'),
(42, 'Steal Something.', '00:10:11', NULL, NULL, '2019-12-27', '2025-04-22 16:29:07', '2025-04-22 16:29:07'),
(43, 'Candy Truck / You Expected: LAB Your Result: Green', '00:07:15', NULL, NULL, '2019-12-27', '2025-04-22 16:29:07', '2025-04-22 16:29:07'),
(44, 'A Devastating Liberation', '00:04:40', NULL, NULL, '2019-12-27', '2025-04-22 16:29:07', '2025-04-22 16:29:07'),
(45, '¿ (feat. Halsey)', '00:05:13', NULL, NULL, '2019-12-27', '2025-04-22 16:29:07', '2025-04-22 16:29:07'),
(46, 'Underground Big {HEADFULOFHYENA} (feat. Bexey & Lotus Eater)', '00:24:05', NULL, NULL, '2019-12-27', '2025-04-22 16:29:07', '2025-04-22 16:29:07'),
(47, '\"like seeing spiders running riot on your lover\'s grave\" (feat. Happyalone.)', '00:06:38', NULL, NULL, '2019-12-27', '2025-04-22 16:29:07', '2025-04-22 16:29:07'),
(48, 'Dead Dolphin Sounds \'aid brain growth in unborn child\' Virtual Therapy / Nature Healing 2 Hours (feat. Toriel)', '00:10:09', NULL, NULL, '2019-12-27', '2025-04-22 16:29:07', '2025-04-22 16:29:07'),
(49, '±ªþ³§ (feat. Yonaka)', '00:07:18', NULL, NULL, '2019-12-27', '2025-04-22 16:29:07', '2025-04-22 16:29:07'),
(50, 'i apologise if you feel something', '00:02:19', NULL, NULL, '2019-01-25', '2025-04-22 16:29:08', '2025-04-22 16:29:08'),
(51, 'MANTRA', '00:03:53', NULL, NULL, '2018-08-21', '2025-04-22 16:29:08', '2025-04-22 16:29:37'),
(52, 'nihilist blues (feat. Grimes)', '00:05:25', NULL, NULL, '2019-01-24', '2025-04-22 16:29:08', '2025-04-22 16:29:35'),
(53, 'in the dark', '00:04:31', NULL, NULL, '2019-01-25', '2025-04-22 16:29:08', '2025-04-22 16:29:08'),
(54, 'wonderful life (feat. Dani Filth)', '00:04:34', NULL, NULL, '2018-10-21', '2025-04-22 16:29:08', '2025-04-22 16:29:37'),
(55, 'ouch', '00:01:49', NULL, NULL, '2019-01-25', '2025-04-22 16:29:08', '2025-04-22 16:29:08'),
(56, 'medicine', '00:03:47', 'medicine is a song by British rock band Bring Me the Horizon, released on 3 January 2019 as the third single from their sixth studio album amo, which was released a few days later.\n\nThe song was written by BMTH members Jordan Fish, Matthew Kean, Oliver Sykes, Matthew Nicholls and Lee Malia and was produced by Sykes and Fish. The lyrics refer to a toxic relationship, hinting to the happiness that can come after its ending. According to the band the lyrics refer to the marriage between Sykes and his then-wife Hannah Snowdon, which ended in a messy divorce in 2016. Read more on Last.fm. User-contributed text is available under the Creative Commons By-SA License; additional terms may apply.', NULL, '2019-01-03', '2025-04-22 16:29:08', '2025-04-22 16:31:36'),
(57, 'sugar honey ice & tea', '00:04:21', NULL, NULL, '2019-01-25', '2025-04-22 16:29:08', '2025-04-22 16:29:08'),
(58, 'why you gotta kick me when i\'m down?', '00:04:28', NULL, NULL, '2019-01-25', '2025-04-22 16:29:08', '2025-04-22 16:29:08'),
(59, 'fresh bruises', '00:03:18', NULL, NULL, '2019-01-25', '2025-04-22 16:29:08', '2025-04-22 16:29:08'),
(60, 'mother tongue', '00:03:37', NULL, NULL, '2019-01-22', '2025-04-22 16:29:08', '2025-04-22 16:29:35'),
(61, 'heavy metal (feat. Rahzel)', '00:04:00', NULL, NULL, '2019-01-25', '2025-04-22 16:29:08', '2025-04-22 16:29:08'),
(62, 'i don\'t know what to say', '00:05:52', NULL, NULL, '2019-01-25', '2025-04-22 16:29:08', '2025-04-22 16:29:08'),
(63, 'Doomed', '00:04:34', NULL, NULL, '2015-09-11', '2025-04-22 16:29:09', '2025-04-22 16:29:09'),
(64, 'Happy Song', '00:03:59', NULL, NULL, '2015-09-11', '2025-04-22 16:29:09', '2025-04-22 16:29:09'),
(65, 'Throne', '00:03:11', '“Throne” is the first official single released for Bring Me The Horizon’s upcoming album That’s The Spirit, even though the tracks “Drown” & “Happy Song” were released earlier.\n\nKeyboardist Jordan Fish told Rolling Stone that the song represents a completely new musical and emotional space for the band:\n\nIt’s one of the most simple and straightforward songs we did…It’s got some elements we had on the last album [2013’s Sempiternal], with an up-tempo rhythm and really strong melodies. So it seemed like an obvious choice for the first single because it’s so immediately catchy and has such a good level of energy\nThematically, Fish explains further that That’s The Spirit emphasises a much more positive outlook on life than previous BMTH material.\n\nEveryone has their own issues and anxieties, and mostly the new songs are about accepting them and trying to remain positive because there’s nothing else you can do. Read more on Last.fm. User-contributed text is available under the Creative Commons By-SA License; additional terms may apply.', NULL, '2015-09-11', '2025-04-22 16:29:09', '2025-04-22 16:30:11'),
(66, 'True Friends', '00:03:52', '\"True Friends\" is a song by British rock band Bring Me the Horizon. It was released as the third single from the band\'s fifth studio album That\'s the Spirit. Musically a rock song, it has been more specifically described as post-hardcore and emo. It was released on 25 August 2015 on the bands official Vevo account. Read more on Last.fm. User-contributed text is available under the Creative Commons By-SA License; additional terms may apply.', NULL, '2015-09-11', '2025-04-22 16:29:09', '2025-04-22 16:30:13'),
(67, 'Follow You', '00:03:51', '\"Follow You\" is a song by British rock band Bring Me the Horizon. Produced by keyboardist Jordan Fish and vocalist Oliver Sykes, it was featured on the band\'s 2015 fifth studio album That\'s the Spirit. The song was also released as the fifth single from the album on 26 February 2016, reaching number 95 on the UK Singles Chart and topping the UK Rock & Metal Singles Chart.\n\nSykes and Fish originally started writing \"Follow You\" at around the same time as they wrote \"Drown\", which was released as a single in 2014. According to Sykes, the song\'s lyrics were based on his relationship with his wife during \"a particular rough patch, when things weren\'t looking too good\"; during a track-by-track commentary of the album for Spotify, he explained that the overarching message was that \"no matter how bad being together can sometimes get, the alternative is just so much worse\". Critical response to \"Follow You\" was generally positive. Bradley Zorgdrager of Exclaim! praised the song for \"reigning in the force while remaining impactful\", in contrast to much of the rest of the album which he criticised for sounding too similar to bands such as Thirty Seconds to Mars and Linkin Park. MTV\'s Mike Pell described the song as \"One of the tamer, more anthemic singles\" from That\'s the Spirit. Reviewing the album for DIY magazine, Sarah Jamieson identified \"Follow You\" as one of the album\'s tracks which sees Bring Me the Horizon \"stepping further out of their comfort zone than ever before\", describing it as \"atmospheric\".\n\nThe music video for \"Follow You\" was premiered on 16 March 2016 via the band\'s Vevo channel. Co-directed by Oliver Sykes and Frank Borin, the video depicts a series of violent events described by a number of commentators as leading to the end of the world, including seemingly random acts of violence, murder, arson and property damage, as a young man listens to the song, dances and sings in the street, oblivious to the events around him. Loudwire\'s Joe DiVita proposed that while the video was \"brutally graphic\" and \"NSFW\", this served as \"the perfect juxtaposition\" to the \"somber and emotional song\" to which it was the visual accompaniment. Alternative Press writer Caitlyn Ralph merely described it as \"intriguing\".\n\nThe video was noted by many critics for its graphic nature. Rock Sound writer Andy Biddulph, for example, described the video as \"horrifying\", noting that it contained \"gore, death, guns and violence against animals\". Similarly, James Hingle of Kerrang! warned that it was \"not for the faint-hearted\". Of particular contention was a scene in which a Golden Retriever is shot and killed by a mail carrier. Fuse\'s Zach Dionne reacted to the video simply with the phrase \"What the fuck\", before berating it as \"an immense misstep\" by the band. Emmy Mack of Music Feeds displayed shock at the video, describing it as \"a gruesome, NSFW fucking bloodbath\", although did praise the production by noting that \"The whole thing is a god damn motherfucking horror movie. But at least it\'s a blockbuster one.\" Bring Me the Horizon later responded to the controversy on Twitter, joking about the dog\'s fate. Read more on Last.fm. User-contributed text is available under the Creative Commons By-SA License; additional terms may apply.', NULL, '2015-09-11', '2025-04-22 16:29:09', '2025-04-22 16:30:14'),
(68, 'What You Need', '00:04:12', NULL, NULL, '2015-09-11', '2025-04-22 16:29:09', '2025-04-22 16:29:09'),
(69, 'Avalanche', '00:04:22', NULL, NULL, '2015-09-11', '2025-04-22 16:29:09', '2025-04-22 16:29:09'),
(70, 'Run', '00:03:42', NULL, NULL, '2015-09-11', '2025-04-22 16:29:09', '2025-04-22 16:29:09'),
(71, 'Drown', '00:03:42', 'Originally released as a stand-alone single, a remixed version features on the band\'s fifth studio album That\'s the Spirit and was released as the lead single. The track, musically, marks a shift away from the band\'s previously established metalcore sound. Rather, it was described by critics as a pop punk-leaning emo and rock song, being the later showcased as arena rock.\nIt reached No. 17 in the UK, becoming the band\'s first top-20 single in their home country.\n\nThe song was announced 13 October 2014 on the band\'s social media accounts. The song leaked on 21 October 2014 on YouTube by accident because of a mistake by Epitaph Records, the band\'s United States record label. It later premiered officially on BBC Radio 1 that same day. After it aired on BBC Radio 1, Oliver Sykes was interviewed by Zane Lowe. It had been reported that \"Drown\" would not appear on any studio album from the band. However, the song was later announced to be track 9 on the 2015 album That\'s the Spirit, albeit as a remixed version.\n\n\"Drown\" was set to be released on iTunes on 7 December 2014. However, in early October, Oliver Sykes began teasing lyrics in the form of photos on Twitter. He also posted a message stating if \"#DROWN\" started trending on Twitter, they would release the song sooner. Drown was released on iTunes 3 November 2014. \"Drown\" was issued as a picture disc in the UK on 7 December. It was nominated for the Kerrang! Award for Best Single. Read more on Last.fm. User-contributed text is available under the Creative Commons By-SA License; additional terms may apply.', NULL, '2015-09-11', '2025-04-22 16:29:09', '2025-04-22 16:30:20'),
(72, 'Blasphemy', '00:04:35', NULL, NULL, '2015-09-11', '2025-04-22 16:29:09', '2025-04-22 16:29:09'),
(73, 'Oh No', '00:05:01', NULL, NULL, '2015-09-11', '2025-04-22 16:29:09', '2025-04-22 16:29:09'),
(74, 'Can You Feel My Heart', '00:03:47', 'This is the first track on Sempiternal, the fourth studio album by the British Metalcore band Bring Me the Horizon. It was one of the first tunes that was penned for the set. Keyboardist Jordan Fish told Metal Hammer: \"We tried loads of different things that were s--t, but that really worked, and as soon as we did it we knew that this would open the album.\"\nVocalist Oliver Sykes added: \"This was the turning point; it was the first one that Jordan really got his teeth into, and obviously you can hear that because it\'s very heavy on the electronica. It was floating around for ages, and I think it really started to shine when we took my vocal lead and used it [on the keyboard parts] for the chorus.\"\nIt was during the penning of this tune that the band realized that recently added keyboardist Jordan Fish was having a big impact on their songwriting. Bassist Matt Kean told Sugarscape: \"We had already had a list of the songs and Jordan took it away and worked on the choruses and stuff. It was like - I remember listening to it back once Jordan had put a different stamp on it and we were like \'Oh this is CRAZY!\' and at the time, he wasn\'t even in the band, he was just writing with us. I think its this song was the point where we were all like \'It\'s time to do something about this.\'\"\nThe Sempiternal album was penned with a concept in its structure. Every single song represents a different realization and it was made to be like a journey. Sykes explained to AllMusic: \"The first song is the first step, and the second song is the second step. You can\'t really listen to track six, and then listen to track one. You have to figure out the first step before you can figure out the next thing. We tried to make that connect in every aspect with the songs and music and how they blended into each other. It goes from heavy and then gives you a breather. The songs are meant to reflect the emotions as well. It\'s not just random. We wanted to make it a journey you wanted to start at the beginning and end at the end rather than just hear one or two songs or put it on \'shuffle.\'\n\nThe first track, \'Can You Feel My Heart\' is all about admittance,\" Sykes continued, \"admitting you have a problem, and admitting something\'s wrong\" Read more on Last.fm. User-contributed text is available under the Creative Commons By-SA License; additional terms may apply.', NULL, '2017-11-24', '2025-04-22 16:29:10', '2025-04-22 16:30:25'),
(75, 'The House of Wolves', '00:03:25', NULL, NULL, '2013-04-01', '2025-04-22 16:29:10', '2025-04-22 16:29:10'),
(76, 'Empire (Let Them Sing)', '00:03:45', '“Empire” contains allusions to many things, such as biblical references on the chorus and a The Three Little Pigs citation on the pre-chorus. Lyrically, it talks about depression and how society treats these “misunderstood people”—let them sing.\n\nIn a track-by-track interview with MetalFuckingRocks, vocalist Oli Sykes explained:\n\n\"It’s quite Deftones-inspired, the feel. Lyrically it’s one of my favourites, because it’s one of the few where I wrote the lyrics before I wrote the melodies. Most of the time I’ve found out that that doesn’t work, but it gave me a lot of freedom.\" Read more on Last.fm. User-contributed text is available under the Creative Commons By-SA License; additional terms may apply.', NULL, '2013-04-01', '2025-04-22 16:29:10', '2025-04-22 16:30:28'),
(77, 'Sleepwalking', '00:03:50', NULL, NULL, '2017-11-24', '2025-04-22 16:29:10', '2025-04-22 16:29:42'),
(78, 'Go to Hell, for Heaven\'s Sake', '00:04:02', NULL, NULL, '2017-11-24', '2025-04-22 16:29:10', '2025-04-22 16:29:42'),
(79, 'Shadow Moses', '00:04:03', '\"Shadow Moses\" is a song by British rock band Bring Me the Horizon. Written by vocalist Oliver Sykes, guitarist Lee Malia and keyboardist Jordan Fish, it was produced by Terry Date and featured on the band\'s 2013 fourth studio album \"Sempiternal\". The song was released as the lead single from the album on 11 January 2013, reaching number 82 on the UK Singles Chart and number 2 on the UK Rock & Metal Singles Chart.\n\nOne of the first songs written for \"Sempiternal\", \"Shadow Moses\" features the use of the album\'s title several times throughout the song. The track is named after the main setting of the 1998 video game Metal Gear Solid, the closing theme of which is referenced in the song\'s opening vocal line. \"Shadow Moses\" was critically acclaimed upon its release and is one of the band\'s most frequently-performed songs at live shows. Read more on Last.fm. User-contributed text is available under the Creative Commons By-SA License; additional terms may apply.', NULL, '2017-11-24', '2025-04-22 16:29:10', '2025-04-22 16:30:32'),
(80, 'And the Snakes Start to Sing', '00:05:01', 'The first song the band sat down to write when starting to record Sempiternal and also the last song they completed. No one knows the meaning behind the song, according to Sykes\n\n“the lyrics are so personal that they will mean nothing to anyone but my parents and me.“\n\nBassist Matt Kean told to Sugarscape:\n\n“Halfway through the writing process Jordan (Fish, keyboards) added strings and stuff to it and his little electronic bars, and then we left it for even longer and then as the last thing we wrote the vocals for it. We only finished it a week before we went to the studio, we just kept going back and tweaking it and stuff, but we were super happy with the way it came out.“ Read more on Last.fm. User-contributed text is available under the Creative Commons By-SA License; additional terms may apply.', NULL, '2013-04-01', '2025-04-22 16:29:10', '2025-04-22 16:30:33'),
(81, 'Seen It All Before', '00:04:07', 'Read more on Last.fm. User-contributed text is available under the Creative Commons By-SA License; additional terms may apply.', NULL, '2013-04-01', '2025-04-22 16:29:10', '2025-04-22 16:30:35'),
(82, 'Antivist', '00:03:13', 'Probably the song with the most political and divisive message of the album, \"Antivist\" is about \"slacktivists\", people that believe the fundamental changes of society will come throught with sole interatictions on social medias.\n\nOli Sykes, BMTH\'S vocalist, in a track-by-track interview with MetalFuckingRocks said:\n\n\"It\'s about \'Slacktivists\'; online people that just talk shit on Twitter, and \'Like this if you want to get Obama to die\' or whatever. It\'s loads of shit; people think they\'re making a difference nowadays just because they’re sat on their fat arses with ill-informed \'facts\'. They think they know everything and that they\'re making a difference, and it\'s bullshit.\n\nSo the lyrics to this one are quite sarcastic, but if you want to make a difference, you have to do more than just sit at your computer. It\'s not saying \'Don\'t care about the world\', it\'s saying, \'Don\'t think you care about the world and that you\'re better than people if you\'re doing fuck all\'. If you really believe in all that, you\'ve got to get up and do more.\" Read more on Last.fm. User-contributed text is available under the Creative Commons By-SA License; additional terms may apply.', NULL, '2017-11-24', '2025-04-22 16:29:10', '2025-04-22 16:30:36'),
(83, 'Crooked Young', '00:03:34', '“Crooked Young” mainly talks about Oliver Sykes\' ketamine rehabilitation.\n\nIn a track-by-track interview with MetalFuckingRocks, vocalist Oli Sykes explained:\n\n“Jordan [keyboardist] really wanted to do something like “It Never Ends” [from 2010’s There Is A Hell…], and we thought that was one of the songs that worked best on the last album, including that addition of an orchestra. We thought we could carry that on, so we wanted to keep that vibe. It’s still one of the heaviest tracks on the record, and it’s got a great chorus. I’m really excited to play that one live.“\n\nIn another interview, bassist Matt Kean explained:\n\n“This song came about after we all went to go see a film—I forget which film it was, but it was a super epic film it had like a huge string section in it—and we thought we need to write a song that uses cinematic strings section and is super epic sounding. So then Jordan went home that night and came back in the morning with this huge, middle string section, so we were like “Let’s use this!” and then we wrote the song around that section.“ Read more on Last.fm. User-contributed text is available under the Creative Commons By-SA License; additional terms may apply.', NULL, '2013-04-01', '2025-04-22 16:29:10', '2025-04-22 16:30:38'),
(84, 'Hospital for Souls', '00:06:46', 'Oli told All Music:\nThat song is all about ascending, I guess it’s like rising from the ashes and renewing yourself after learning all of these things. I changed who I am. The lyrics mean, “Say goodbye to the old person, watch me burning, and coming back as this new person.” Read more on Last.fm. User-contributed text is available under the Creative Commons By-SA License; additional terms may apply.', NULL, '2013-04-01', '2025-04-22 16:29:10', '2025-04-22 16:30:39'),
(85, 'Join the Club', '00:03:06', NULL, NULL, '2013-04-01', '2025-04-22 16:29:10', '2025-04-22 16:29:10'),
(86, 'Deathbeds', '00:04:59', 'Oli Sykes\'s then fiancée, tattoo artist, Hannah Pixie Snowdon features on this track. Read more on Last.fm. User-contributed text is available under the Creative Commons By-SA License; additional terms may apply.', NULL, '2013-04-01', '2025-04-22 16:29:10', '2025-04-22 16:30:42'),
(87, 'Crucify Me (feat. Lights)', '00:06:19', NULL, NULL, '2010-10-04', '2025-04-22 16:29:11', '2025-04-22 16:29:11'),
(88, 'Anthem', '00:04:49', NULL, NULL, '2010-10-04', '2025-04-22 16:29:11', '2025-04-22 16:29:11'),
(89, 'It Never Ends', '00:04:34', NULL, NULL, '2017-11-24', '2025-04-22 16:29:11', '2025-04-22 16:29:42'),
(90, 'Fuck (feat. Josh Franceschi)', '00:04:55', NULL, NULL, '2010-10-04', '2025-04-22 16:29:11', '2025-04-22 16:29:11'),
(91, 'Don\'t Go (feat. Lights)', '00:04:58', NULL, NULL, '2010-10-04', '2025-04-22 16:29:11', '2025-04-22 16:29:11'),
(92, 'Home Sweet Hole', '00:04:37', NULL, NULL, '2010-10-04', '2025-04-22 16:29:11', '2025-04-22 16:29:11'),
(93, 'Alligator Blood', '00:04:31', NULL, NULL, '2010-10-04', '2025-04-22 16:29:11', '2025-04-22 16:29:11'),
(94, 'Visions', '00:04:08', NULL, NULL, '2010-10-04', '2025-04-22 16:29:11', '2025-04-22 16:29:11'),
(95, 'Blacklist', '00:04:00', NULL, NULL, '2010-10-04', '2025-04-22 16:29:11', '2025-04-22 16:29:11'),
(96, 'Memorial', '00:03:09', NULL, NULL, '2010-10-04', '2025-04-22 16:29:11', '2025-04-22 16:29:11'),
(97, 'Blessed with a Curse', '00:05:08', NULL, NULL, '2017-11-24', '2025-04-22 16:29:11', '2025-04-22 16:29:42'),
(98, 'The Fox and the Wolf (feat. Josh Scogin)', '00:01:42', NULL, NULL, '2010-10-04', '2025-04-22 16:29:11', '2025-04-22 16:29:11'),
(99, 'It Never Ends - Borgore Remix', '00:04:23', NULL, NULL, '2010-10-04', '2025-04-22 16:29:11', '2025-04-22 16:29:11'),
(100, 'The Comedown', '00:04:09', 'The first track off Bring Me The Horizon\'s new album, Suicide Season set to be released September 29th in the UK and October 6th in the US.\n\nThis is the first song to be offcially released by the band as they made a promotional video for the song which can be found via youtube. Read more on Last.fm. User-contributed text is available under the Creative Commons By-SA License; additional terms may apply.', NULL, '2017-11-24', '2025-04-22 16:29:12', '2025-04-22 16:31:12'),
(101, 'Chelsea Smile', '00:05:02', '\"Chelsea Smile\" is a song by British rock band Bring Me the Horizon. Produced by Fredrik Nordström and Henrik Udd, it was featured on the band\'s 2008 second studio album Suicide Season. The song was also released as the second music video from the album on 19 January 2009. Travie McCoy and KC Blitz produced remixes of the track for the album\'s special edition reissue, Suicide Season Cut Up!, which was released in 2009.\n\n\"Chelsea Smile\" has been identified as evidence of Bring Me the Horizon\'s musical development on Suicide Season; Exclaim! writer Dave Synyard praised it, alongside \"It Was Written in Blood\", for featuring \"catchier rhythms, lessened guttural vocals and more structured songwriting, as opposed to reverting to a technical onslaught of guitar riffs\". When asked about this change in approach in relation to the two songs, vocalist Oliver Sykes explained that \"I think it\'s good when a band can be really heavy and still have catchy hooks and riffs without it being cheesy and typical\", adding that the band were \"trying to make the heaviest and catchiest music possible\".\n\nFor the Cut Up! portion of the 2009 special edition reissue of Suicide Season, remixes of \"Chelsea Smile\" were produced by Jamie Kossoff and Jon Courtney under their KC Blitz moniker, as well as Gym Class Heroes frontman Travie McCoy. According to set list aggregation website setlist.fm, \"Chelsea Smile\" is the song performed most frequently at Bring Me the Horizon concerts. It has been included in the set lists of several high-profile shows, including the band\'s performances at Wembley Arena in 2014 (documented on the live video album Live at Wembley), Reading and Leeds Festivals in 2015 and Alexandra Palace as part of the That\'s the Spirit Tour in 2015.\n\nThe music video for \"Chelsea Smile\" was directed by Adam Powell, who also worked on the video for earlier Suicide Season track \"The Comedown\". It was filmed and released in early January 2009, alongside a series of four behind the scenes videos which were uploaded periodically to the band\'s Myspace page. The video features a brief appearance from the members of Canadian hardcore punk band Cancer Bats, who are shown playing poker during the opening scene. Kerrang! included it at number 9 on their list of the band\'s best music videos in April 2015, praising its high-energy party vibe. The video was later included on the Cut Up! special edition reissue of Suicide Season.\n\nAllMusic\'s Tom Forget praised \"Chelsea Smile\" as a highlight of Suicide Season, describing it as \"Intricately constructed and refreshingly unpredictable\". Dan Slessor of the Alternative Press named it the best Bring Me the Horizon song, praising its \"armor-plated juddering, deranged energy, titanic breakdown and insidiously catchy hooks\". Loudwire\'s Sarai C. ranked it at number two on her feature of the band\'s best songs, highlighting its importance to the development of the group\'s sound and the metalcore genre in general, moving away from its deathcore roots. Metal Hammer writer Luke Morton ranked it the sixth best song by the band, describing it as \"one of the nastiest songs to ever be called catchy\" and praising its \"brutalising breakdowns\" and \"primal screams\". In 2019, Billboard ranked the song number seven on their list of the 10 greatest Bring Me the Horizon songs, and in 2022, Kerrang! ranked the song number four on their list of the 20 greatest Bring Me the Horizon songs.\n\nCredits adapted from Tidal. Read more on Last.fm. User-contributed text is available under the Creative Commons By-SA License; additional terms may apply.', NULL, '2017-11-24', '2025-04-22 16:29:12', '2025-04-22 16:31:14'),
(102, 'It Was Written in Blood', '00:04:02', 'Track 3 from Bring Me The Horizon\'s second album released September 29th in the UK and October 6th in the US. Read more on Last.fm. User-contributed text is available under the Creative Commons By-SA License; additional terms may apply.', NULL, '2008-09-29', '2025-04-22 16:29:12', '2025-04-22 16:31:15'),
(103, 'Death Breath', '00:04:20', NULL, NULL, '2008-09-29', '2025-04-22 16:29:12', '2025-04-22 16:29:12'),
(104, 'Football Season is Over (feat. JJ Peters)', '00:01:55', NULL, NULL, '2008-09-29', '2025-04-22 16:29:12', '2025-04-22 16:29:12'),
(105, 'Sleep with One Eye Open', '00:04:16', NULL, NULL, '2008-09-29', '2025-04-22 16:29:12', '2025-04-22 16:29:12'),
(106, 'Diamonds Aren\'t Forever', '00:03:48', '“Diamonds Aren’t Forever” is the third single from BMTH’s album Suicide Season.\nThis song was remixed by I Haunt Wizards for the remix album Suicide Season: Cut Up.\n\nThis song is definitely alluding to Kanye’s song “ Diamonds from Sierra Leone”\n\nThere are many lyrics parallels throughout it and it seems to be referencing it and picking apart some of the details…\n\nThe First and most obvious parallel is the name “Diamonds aren’t forever,” as in the Kanye song the chorus is “ Diamonds are forever”\n\nIn the pre-chorus of this song, they say, “I refuse to close my eyes” and in Diamonds from Sierra Leone, they say “Close your eyes and feel the magic, vegas on acid”\n\nIn the Bring Me song they say “ Throw your diamonds in the sky and we’ll stay gold forever” and the Kanye ones say, “ So throw your Diamonds in the sky if you feel the vibe… Diamonds are forever”\n\nThe original Kanye song is kind of insensitive because it fails to recognize the blood diamonds and how harmful they are and it makes it sound like the lifestyle he’s living is worth the struggle of others. They did a remix later that addresses the issues going on but the damage was kinda done. I think BMTH is calling out the frivolous lifestyle of it here and saying they are against it. Read more on Last.fm. User-contributed text is available under the Creative Commons By-SA License; additional terms may apply.', NULL, '2017-11-24', '2025-04-22 16:29:12', '2025-04-22 16:31:21'),
(107, 'The Sadness Will Never End (feat. Sam Carter)', '00:05:22', '“The Sadness Will Never End” is the third and final single from the band’s album Suicide Season.\n\nThis song was remixed by Skrillex for the remix album Suicide Season: Cut Up.\n\nAlso, in 2019’s festival All Points East, Bring Me The Horizon headlined the event and, because of this, included the song on the setlist with the participation of Architects‘ lead singer Sam Carter.\n\nThe ex-guitarist of the band, Jona Weinhofen, appears in the official video of the song. But it was originally recorded with Curtis Ward (also ex-guitarist). Read more on Last.fm. User-contributed text is available under the Creative Commons By-SA License; additional terms may apply.', NULL, '2008-09-29', '2025-04-22 16:29:12', '2025-04-22 16:31:22'),
(108, 'No Need for Introductions, I\'ve Read About Girls Like You on the Backs of Toilet Doors', '00:00:59', NULL, NULL, '2008-09-29', '2025-04-22 16:29:12', '2025-04-22 16:29:12'),
(109, 'Suicide Season', '00:08:17', '“Suicide Season” is about one of Oli’s friends, his father died and this changed his friend. The friend lost his father, and Oli lost his friend due to grief.\n\nThis is also the first eponymous track on a release in the band’s discography, being named after the album. Read more on Last.fm. User-contributed text is available under the Creative Commons By-SA License; additional terms may apply.', NULL, '2008-09-29', '2025-04-22 16:29:12', '2025-04-22 16:31:25'),
(110, 'The Comedown - RobotSonics Remix', '00:05:17', NULL, NULL, '2008-09-29', '2025-04-22 16:29:12', '2025-04-22 16:29:12'),
(111, 'Chelsea Smile - KC Blitz Remix', '00:04:12', NULL, NULL, '2008-09-29', '2025-04-22 16:29:12', '2025-04-22 16:29:12'),
(112, 'It Was Written in Blood - L\'Amour La Morgue Remix', '00:04:57', NULL, NULL, '2008-09-29', '2025-04-22 16:29:12', '2025-04-22 16:29:12'),
(113, 'Death Breath - Toxic Avenger Remix', '00:04:33', NULL, NULL, '2008-09-29', '2025-04-22 16:29:12', '2025-04-22 16:29:12'),
(114, 'Football Season is Over - After the Night Remix', '00:03:56', NULL, NULL, '2008-09-29', '2025-04-22 16:29:12', '2025-04-22 16:29:12'),
(115, 'Sleep with One Eye Open - Tek-One Remix', '00:04:41', NULL, NULL, '2008-09-29', '2025-04-22 16:29:12', '2025-04-22 16:29:12'),
(116, 'Diamonds Aren\'t Forever - I Haunt Wizards Remix', '00:03:54', NULL, NULL, '2008-09-29', '2025-04-22 16:29:12', '2025-04-22 16:29:12'),
(117, 'The Sadness Will Never End - Skrillex Remix', '00:06:02', NULL, NULL, '2008-09-29', '2025-04-22 16:29:12', '2025-04-22 16:29:12'),
(118, 'No Need for Introductions, I\'ve Read About Girls Like You on the Backs of Toilet Doors - Benjamin Weinman Remix', '00:02:45', NULL, NULL, '2008-09-29', '2025-04-22 16:29:12', '2025-04-22 16:29:12'),
(119, 'Suicide Season - The Secret Handshake Remix', '00:02:55', NULL, NULL, '2008-09-29', '2025-04-22 16:29:12', '2025-04-22 16:29:12'),
(120, 'Pray for Plagues', '00:04:21', 'Pray for Plagues is the first single and the first song off of the metalcore/deathcore band Bring Me The Horizon\'s debut studio album \"Count Your Blessings\", which released in 2006. Read more on Last.fm. User-contributed text is available under the Creative Commons By-SA License; additional terms may apply.', NULL, '2017-11-24', '2025-04-22 16:29:14', '2025-04-22 16:30:58'),
(121, 'Tell Slater Not to Wash His Dick', '00:03:30', NULL, NULL, '2006-10-30', '2025-04-22 16:29:14', '2025-04-22 16:29:14'),
(122, 'For Stevie Wonder\'s Eyes Only (Braille)', '00:04:29', NULL, NULL, '2006-10-30', '2025-04-22 16:29:14', '2025-04-22 16:29:14'),
(123, 'A Lot Like Vegas', '00:02:09', NULL, NULL, '2006-10-30', '2025-04-22 16:29:14', '2025-04-22 16:29:14'),
(124, 'Black & Blue', '00:04:33', 'Read more on Last.fm. User-contributed text is available under the Creative Commons By-SA License; additional terms may apply.', NULL, '2006-10-30', '2025-04-22 16:29:14', '2025-04-22 16:31:04'),
(125, 'Slow Dance', '00:01:16', NULL, NULL, '2006-10-30', '2025-04-22 16:29:14', '2025-04-22 16:29:14'),
(126, 'Liquor & Love Lost', '00:02:39', NULL, NULL, '2006-10-30', '2025-04-22 16:29:14', '2025-04-22 16:29:14'),
(127, '(I Used to Make Out With) Medusa', '00:05:38', NULL, NULL, '2006-10-30', '2025-04-22 16:29:14', '2025-04-22 16:29:14'),
(128, 'Fifteen Fathoms, Counting', '00:01:56', NULL, NULL, '2006-10-30', '2025-04-22 16:29:14', '2025-04-22 16:29:14'),
(129, 'Off the Heezay', '00:05:38', NULL, NULL, '2006-10-30', '2025-04-22 16:29:14', '2025-04-22 16:29:14'),
(130, 'Wonderwall - Spotify Singles', '00:04:00', NULL, NULL, '2025-01-29', '2025-04-22 16:29:14', '2025-04-22 16:29:14'),
(131, 'YOUtopia - EarthcOre remix - Spotify Singles', '00:03:40', NULL, NULL, '2025-01-29', '2025-04-22 16:29:14', '2025-04-22 16:29:14'),
(132, 'Happier (feat. Oli Sykes of Bring Me The Horizon)', '00:03:24', NULL, NULL, '2023-10-17', '2025-04-22 16:29:17', '2025-04-22 16:29:17'),
(133, 'CODE MISTAKE', '00:02:45', NULL, NULL, '2023-06-30', '2025-04-22 16:29:17', '2025-04-22 16:29:17'),
(134, 'Werewolf (feat. Bring Me The Horizon)', '00:03:59', NULL, NULL, '2023-06-29', '2025-04-22 16:29:18', '2025-04-22 16:29:18'),
(135, 'Wish I Could Forget (with blackbear & Bring Me The Horizon)', '00:03:26', NULL, NULL, '2023-05-19', '2025-04-22 16:29:19', '2025-04-22 16:29:19'),
(136, 'Bad Life', '00:03:46', NULL, NULL, '2022-06-24', '2025-04-22 16:29:22', '2025-04-22 16:29:22'),
(137, 'Bad Life - Stripped Back', '00:03:40', NULL, NULL, '2022-06-24', '2025-04-22 16:29:22', '2025-04-22 16:29:22'),
(138, 'Bad Life - acoustic', '00:03:40', NULL, NULL, '2022-05-27', '2025-04-22 16:29:22', '2025-04-22 16:29:22'),
(139, 'Fallout', '00:03:14', NULL, NULL, '2022-04-01', '2025-04-22 16:29:23', '2025-04-22 16:29:23'),
(140, 'Bad Habits (feat. Bring Me The Horizon)', '00:04:10', NULL, NULL, '2022-02-08', '2025-04-22 16:29:24', '2025-04-22 16:29:24'),
(141, 'Moon Over the Castle - from GRAN TURISMO 7', '00:03:07', NULL, NULL, '2022-02-04', '2025-04-22 16:29:25', '2025-04-22 16:29:25'),
(142, 'DiE4u - six impala \"DiE6u\" Remix', '00:02:47', NULL, NULL, '2021-12-17', '2025-04-22 16:29:25', '2025-04-22 16:29:25'),
(143, 'VAMPIR (feat. Oli Sykes of Bring Me The Horizon)', '00:02:23', NULL, NULL, '2021-12-10', '2025-04-22 16:29:26', '2025-04-22 16:29:26'),
(144, 'Let’s Get The Party Started (feat. Bring Me The Horizon)', '00:03:32', NULL, NULL, '2021-09-22', '2025-04-22 16:29:27', '2025-04-22 16:29:27'),
(145, 'No More Friends (with Oli Sykes of Bring Me The Horizon)', '00:03:13', NULL, NULL, '2021-06-10', '2025-04-22 16:29:28', '2025-04-22 16:29:28'),
(146, 'Can You Feel My Heart - Remix', '00:03:17', NULL, NULL, '2021-03-05', '2025-04-22 16:29:29', '2025-04-22 16:29:29'),
(147, 'sugar honey ice & tea - Edit', '00:03:35', NULL, NULL, '2019-07-26', '2025-04-22 16:29:32', '2025-04-22 16:29:32'),
(148, 'mother tongue - Recorded at Spotify Studios NYC', '00:03:37', NULL, NULL, '2019-06-26', '2025-04-22 16:29:33', '2025-04-22 16:29:33'),
(149, 'Drone Bomb Me - Recorded at Spotify Studios NYC', '00:03:52', NULL, NULL, '2019-06-26', '2025-04-22 16:29:33', '2025-04-22 16:29:33'),
(150, 'mother tongue - Sub Focus Remix', '00:03:15', NULL, NULL, '2019-06-14', '2025-04-22 16:29:34', '2025-04-22 16:29:34'),
(151, 'Oh No - Radio Edit', '00:03:53', NULL, NULL, '2016-11-18', '2025-04-22 16:29:38', '2025-04-22 16:29:38'),
(152, 'Drown - Live from Maida Vale', '00:03:45', NULL, NULL, '2015-12-26', '2025-04-22 16:29:39', '2025-04-22 16:29:39'),
(153, 'Can You Feel My Heart - Shikari Sound System Remix', '00:04:24', NULL, NULL, '2013-10-13', '2025-04-22 16:29:40', '2025-04-22 16:29:40'),
(154, 'Can You Feel My Heart - Jakwob Remix', '00:04:33', NULL, NULL, '2013-10-13', '2025-04-22 16:29:40', '2025-04-22 16:29:40'),
(155, 'Sleepwalking - Instrumental', '00:03:50', NULL, NULL, '2013-03-04', '2025-04-22 16:29:40', '2025-04-22 16:29:40'),
(156, 'RE: They Have No Reflections', '00:05:42', NULL, NULL, '2004-10-02', '2025-04-22 16:29:41', '2025-04-22 16:29:41'),
(157, 'Who Wants Flowers When You\'re Dead? Nobody', '00:04:54', NULL, NULL, '2004-10-02', '2025-04-22 16:29:41', '2025-04-22 16:29:41'),
(158, 'Rawwwrr!', '00:04:13', NULL, NULL, '2004-10-02', '2025-04-22 16:29:41', '2025-04-22 16:29:41'),
(159, 'Traitors Never Play Hang-Man', '00:03:37', NULL, NULL, '2017-11-24', '2025-04-22 16:29:41', '2025-04-22 16:29:42'),
(160, 'The Sadness Will Never End - feat. Sam Carter', '00:05:22', NULL, NULL, '2017-11-24', '2025-04-22 16:29:42', '2025-04-22 16:29:42'),
(161, 'Don\'t Go - feat. Lights', '00:04:58', NULL, NULL, '2017-11-24', '2025-04-22 16:29:42', '2025-04-22 16:29:42'),
(162, 'Crucify Me - feat. Lights', '00:06:19', NULL, NULL, '2017-11-24', '2025-04-22 16:29:42', '2025-04-22 16:29:42');

-- --------------------------------------------------------

--
-- Table structure for table `tracks_genres`
--

CREATE TABLE `tracks_genres` (
  `track_id` bigint(20) UNSIGNED NOT NULL,
  `genre_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `tracks_genres`
--

INSERT INTO `tracks_genres` (`track_id`, `genre_id`, `created_at`, `updated_at`) VALUES
(3, 1, '2025-04-22 16:31:48', '2025-04-22 16:31:48'),
(3, 2, '2025-04-22 16:31:48', '2025-04-22 16:31:48'),
(3, 4, '2025-04-22 16:31:48', '2025-04-22 16:31:48'),
(3, 5, '2025-04-22 16:31:48', '2025-04-22 16:31:48'),
(3, 7, '2025-04-22 16:31:48', '2025-04-22 16:31:48'),
(5, 7, '2025-04-22 16:31:51', '2025-04-22 16:31:51'),
(5, 10, '2025-04-22 16:31:51', '2025-04-22 16:31:51'),
(5, 38, '2025-04-22 16:31:51', '2025-04-22 16:31:51'),
(5, 39, '2025-04-22 16:31:51', '2025-04-22 16:31:51'),
(6, 2, '2025-04-22 16:31:52', '2025-04-22 16:31:52'),
(6, 5, '2025-04-22 16:31:52', '2025-04-22 16:31:52'),
(6, 7, '2025-04-22 16:31:52', '2025-04-22 16:31:52'),
(6, 9, '2025-04-22 16:31:52', '2025-04-22 16:31:52'),
(6, 10, '2025-04-22 16:31:52', '2025-04-22 16:31:52'),
(11, 2, '2025-04-22 16:31:59', '2025-04-22 16:31:59'),
(11, 6, '2025-04-22 16:31:59', '2025-04-22 16:31:59'),
(11, 10, '2025-04-22 16:31:59', '2025-04-22 16:31:59'),
(11, 15, '2025-04-22 16:31:59', '2025-04-22 16:31:59'),
(11, 40, '2025-04-22 16:31:59', '2025-04-22 16:31:59'),
(14, 12, '2025-04-22 16:32:03', '2025-04-22 16:32:03'),
(14, 40, '2025-04-22 16:32:03', '2025-04-22 16:32:03'),
(14, 41, '2025-04-22 16:32:03', '2025-04-22 16:32:03'),
(14, 42, '2025-04-22 16:32:03', '2025-04-22 16:32:03'),
(14, 43, '2025-04-22 16:32:03', '2025-04-22 16:32:03'),
(22, 2, '2025-04-22 16:30:51', '2025-04-22 16:30:51'),
(22, 5, '2025-04-22 16:30:51', '2025-04-22 16:30:51'),
(22, 7, '2025-04-22 16:30:51', '2025-04-22 16:30:51'),
(22, 27, '2025-04-22 16:30:51', '2025-04-22 16:30:51'),
(22, 28, '2025-04-22 16:30:51', '2025-04-22 16:30:51'),
(24, 2, '2025-04-22 16:30:54', '2025-04-22 16:30:54'),
(24, 7, '2025-04-22 16:30:54', '2025-04-22 16:30:54'),
(24, 8, '2025-04-22 16:30:54', '2025-04-22 16:30:54'),
(24, 12, '2025-04-22 16:30:54', '2025-04-22 16:30:54'),
(24, 29, '2025-04-22 16:30:54', '2025-04-22 16:30:54'),
(25, 8, '2025-04-22 16:30:56', '2025-04-22 16:30:56'),
(25, 10, '2025-04-22 16:30:55', '2025-04-22 16:30:55'),
(25, 15, '2025-04-22 16:30:55', '2025-04-22 16:30:55'),
(25, 31, '2025-04-22 16:30:56', '2025-04-22 16:30:56'),
(56, 2, '2025-04-22 16:31:36', '2025-04-22 16:31:36'),
(56, 10, '2025-04-22 16:31:36', '2025-04-22 16:31:36'),
(56, 12, '2025-04-22 16:31:36', '2025-04-22 16:31:36'),
(56, 14, '2025-04-22 16:31:36', '2025-04-22 16:31:36'),
(56, 36, '2025-04-22 16:31:36', '2025-04-22 16:31:36'),
(65, 2, '2025-04-22 16:30:11', '2025-04-22 16:30:11'),
(65, 5, '2025-04-22 16:30:11', '2025-04-22 16:30:11'),
(65, 10, '2025-04-22 16:30:11', '2025-04-22 16:30:11'),
(65, 11, '2025-04-22 16:30:11', '2025-04-22 16:30:11'),
(65, 12, '2025-04-22 16:30:12', '2025-04-22 16:30:12'),
(66, 2, '2025-04-22 16:30:13', '2025-04-22 16:30:13'),
(66, 5, '2025-04-22 16:30:13', '2025-04-22 16:30:13'),
(66, 6, '2025-04-22 16:30:13', '2025-04-22 16:30:13'),
(66, 9, '2025-04-22 16:30:13', '2025-04-22 16:30:13'),
(66, 13, '2025-04-22 16:30:13', '2025-04-22 16:30:13'),
(67, 2, '2025-04-22 16:30:15', '2025-04-22 16:30:15'),
(67, 6, '2025-04-22 16:30:14', '2025-04-22 16:30:14'),
(67, 10, '2025-04-22 16:30:14', '2025-04-22 16:30:14'),
(67, 14, '2025-04-22 16:30:15', '2025-04-22 16:30:15'),
(67, 15, '2025-04-22 16:30:15', '2025-04-22 16:30:15'),
(71, 6, '2025-04-22 16:30:20', '2025-04-22 16:30:20'),
(71, 9, '2025-04-22 16:30:20', '2025-04-22 16:30:20'),
(71, 10, '2025-04-22 16:30:20', '2025-04-22 16:30:20'),
(71, 15, '2025-04-22 16:30:20', '2025-04-22 16:30:20'),
(74, 2, '2025-04-22 16:30:25', '2025-04-22 16:30:25'),
(74, 9, '2025-04-22 16:30:25', '2025-04-22 16:30:25'),
(74, 12, '2025-04-22 16:30:25', '2025-04-22 16:30:25'),
(76, 1, '2025-04-22 16:30:28', '2025-04-22 16:30:28'),
(76, 2, '2025-04-22 16:30:28', '2025-04-22 16:30:28'),
(76, 3, '2025-04-22 16:30:28', '2025-04-22 16:30:28'),
(76, 9, '2025-04-22 16:30:28', '2025-04-22 16:30:28'),
(79, 1, '2025-04-22 16:30:32', '2025-04-22 16:30:32'),
(79, 2, '2025-04-22 16:30:32', '2025-04-22 16:30:32'),
(79, 5, '2025-04-22 16:30:32', '2025-04-22 16:30:32'),
(79, 9, '2025-04-22 16:30:32', '2025-04-22 16:30:32'),
(79, 20, '2025-04-22 16:30:32', '2025-04-22 16:30:32'),
(80, 1, '2025-04-22 16:30:33', '2025-04-22 16:30:33'),
(80, 2, '2025-04-22 16:30:33', '2025-04-22 16:30:33'),
(80, 3, '2025-04-22 16:30:33', '2025-04-22 16:30:33'),
(80, 9, '2025-04-22 16:30:33', '2025-04-22 16:30:33'),
(80, 21, '2025-04-22 16:30:34', '2025-04-22 16:30:34'),
(81, 2, '2025-04-22 16:30:35', '2025-04-22 16:30:35'),
(81, 3, '2025-04-22 16:30:35', '2025-04-22 16:30:35'),
(81, 9, '2025-04-22 16:30:35', '2025-04-22 16:30:35'),
(81, 21, '2025-04-22 16:30:35', '2025-04-22 16:30:35'),
(81, 22, '2025-04-22 16:30:35', '2025-04-22 16:30:35'),
(82, 1, '2025-04-22 16:30:36', '2025-04-22 16:30:36'),
(82, 2, '2025-04-22 16:30:36', '2025-04-22 16:30:36'),
(82, 3, '2025-04-22 16:30:36', '2025-04-22 16:30:36'),
(82, 4, '2025-04-22 16:30:37', '2025-04-22 16:30:37'),
(82, 9, '2025-04-22 16:30:36', '2025-04-22 16:30:36'),
(83, 2, '2025-04-22 16:30:38', '2025-04-22 16:30:38'),
(83, 3, '2025-04-22 16:30:38', '2025-04-22 16:30:38'),
(83, 9, '2025-04-22 16:30:38', '2025-04-22 16:30:38'),
(83, 21, '2025-04-22 16:30:38', '2025-04-22 16:30:38'),
(83, 22, '2025-04-22 16:30:38', '2025-04-22 16:30:38'),
(84, 2, '2025-04-22 16:30:39', '2025-04-22 16:30:39'),
(84, 3, '2025-04-22 16:30:39', '2025-04-22 16:30:39'),
(84, 9, '2025-04-22 16:30:39', '2025-04-22 16:30:39'),
(84, 23, '2025-04-22 16:30:39', '2025-04-22 16:30:39'),
(84, 24, '2025-04-22 16:30:39', '2025-04-22 16:30:39'),
(86, 2, '2025-04-22 16:30:42', '2025-04-22 16:30:42'),
(86, 5, '2025-04-22 16:30:42', '2025-04-22 16:30:42'),
(86, 9, '2025-04-22 16:30:42', '2025-04-22 16:30:42'),
(86, 25, '2025-04-22 16:30:42', '2025-04-22 16:30:42'),
(86, 26, '2025-04-22 16:30:42', '2025-04-22 16:30:42'),
(100, 1, '2025-04-22 16:31:12', '2025-04-22 16:31:12'),
(100, 2, '2025-04-22 16:31:12', '2025-04-22 16:31:12'),
(100, 3, '2025-04-22 16:31:12', '2025-04-22 16:31:12'),
(100, 5, '2025-04-22 16:31:12', '2025-04-22 16:31:12'),
(100, 32, '2025-04-22 16:31:12', '2025-04-22 16:31:12'),
(101, 1, '2025-04-22 16:31:14', '2025-04-22 16:31:14'),
(101, 2, '2025-04-22 16:31:14', '2025-04-22 16:31:14'),
(101, 4, '2025-04-22 16:31:14', '2025-04-22 16:31:14'),
(101, 5, '2025-04-22 16:31:14', '2025-04-22 16:31:14'),
(101, 32, '2025-04-22 16:31:14', '2025-04-22 16:31:14'),
(102, 1, '2025-04-22 16:31:15', '2025-04-22 16:31:15'),
(102, 2, '2025-04-22 16:31:15', '2025-04-22 16:31:15'),
(102, 3, '2025-04-22 16:31:15', '2025-04-22 16:31:15'),
(102, 4, '2025-04-22 16:31:15', '2025-04-22 16:31:15'),
(102, 5, '2025-04-22 16:31:15', '2025-04-22 16:31:15'),
(106, 1, '2025-04-22 16:31:21', '2025-04-22 16:31:21'),
(106, 2, '2025-04-22 16:31:21', '2025-04-22 16:31:21'),
(106, 3, '2025-04-22 16:31:21', '2025-04-22 16:31:21'),
(106, 4, '2025-04-22 16:31:21', '2025-04-22 16:31:21'),
(106, 5, '2025-04-22 16:31:21', '2025-04-22 16:31:21'),
(107, 1, '2025-04-22 16:31:22', '2025-04-22 16:31:22'),
(107, 2, '2025-04-22 16:31:22', '2025-04-22 16:31:22'),
(107, 9, '2025-04-22 16:31:22', '2025-04-22 16:31:22'),
(107, 34, '2025-04-22 16:31:22', '2025-04-22 16:31:22'),
(109, 1, '2025-04-22 16:31:25', '2025-04-22 16:31:25'),
(109, 2, '2025-04-22 16:31:25', '2025-04-22 16:31:25'),
(109, 4, '2025-04-22 16:31:26', '2025-04-22 16:31:26'),
(109, 5, '2025-04-22 16:31:25', '2025-04-22 16:31:25'),
(109, 35, '2025-04-22 16:31:26', '2025-04-22 16:31:26'),
(120, 1, '2025-04-22 16:30:58', '2025-04-22 16:30:58'),
(120, 2, '2025-04-22 16:30:58', '2025-04-22 16:30:58'),
(120, 3, '2025-04-22 16:30:58', '2025-04-22 16:30:58'),
(120, 4, '2025-04-22 16:30:58', '2025-04-22 16:30:58'),
(124, 1, '2025-04-22 16:31:04', '2025-04-22 16:31:04'),
(124, 2, '2025-04-22 16:31:04', '2025-04-22 16:31:04'),
(124, 3, '2025-04-22 16:31:04', '2025-04-22 16:31:04'),
(124, 4, '2025-04-22 16:31:04', '2025-04-22 16:31:04'),
(124, 32, '2025-04-22 16:31:04', '2025-04-22 16:31:04');

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
(1, 1, 1, 1, '2025-04-22 16:29:04', '2025-04-22 16:29:04'),
(2, 2, 1, 2, '2025-04-22 16:29:04', '2025-04-22 16:29:04'),
(3, 3, 1, 3, '2025-04-22 16:29:04', '2025-04-22 16:29:04'),
(4, 4, 1, 4, '2025-04-22 16:29:04', '2025-04-22 16:29:04'),
(5, 5, 1, 5, '2025-04-22 16:29:04', '2025-04-22 16:29:04'),
(6, 6, 1, 6, '2025-04-22 16:29:04', '2025-04-22 16:29:04'),
(7, 7, 1, 7, '2025-04-22 16:29:04', '2025-04-22 16:29:04'),
(8, 8, 1, 8, '2025-04-22 16:29:04', '2025-04-22 16:29:04'),
(9, 9, 1, 9, '2025-04-22 16:29:04', '2025-04-22 16:29:04'),
(10, 10, 1, 10, '2025-04-22 16:29:04', '2025-04-22 16:29:04'),
(11, 11, 1, 11, '2025-04-22 16:29:05', '2025-04-22 16:29:05'),
(12, 12, 1, 12, '2025-04-22 16:29:05', '2025-04-22 16:29:05'),
(13, 13, 1, 13, '2025-04-22 16:29:05', '2025-04-22 16:29:05'),
(14, 14, 1, 14, '2025-04-22 16:29:05', '2025-04-22 16:29:05'),
(15, 15, 1, 15, '2025-04-22 16:29:05', '2025-04-22 16:29:05'),
(16, 16, 1, 16, '2025-04-22 16:29:05', '2025-04-22 16:29:05'),
(17, 17, 2, 1, '2025-04-22 16:29:05', '2025-04-22 16:29:05'),
(18, 18, 2, 2, '2025-04-22 16:29:05', '2025-04-22 16:29:05'),
(19, 19, 2, 3, '2025-04-22 16:29:05', '2025-04-22 16:29:05'),
(20, 20, 2, 4, '2025-04-22 16:29:05', '2025-04-22 16:29:05'),
(21, 21, 2, 5, '2025-04-22 16:29:05', '2025-04-22 16:29:05'),
(22, 22, 2, 6, '2025-04-22 16:29:05', '2025-04-22 16:29:05'),
(23, 23, 2, 7, '2025-04-22 16:29:05', '2025-04-22 16:29:05'),
(24, 24, 2, 8, '2025-04-22 16:29:05', '2025-04-22 16:29:05'),
(25, 25, 2, 9, '2025-04-22 16:29:05', '2025-04-22 16:29:05'),
(26, 26, 3, 1, '2025-04-22 16:29:06', '2025-04-22 16:29:06'),
(27, 27, 3, 2, '2025-04-22 16:29:06', '2025-04-22 16:29:06'),
(28, 28, 3, 3, '2025-04-22 16:29:06', '2025-04-22 16:29:06'),
(29, 29, 3, 4, '2025-04-22 16:29:06', '2025-04-22 16:29:06'),
(30, 30, 3, 5, '2025-04-22 16:29:06', '2025-04-22 16:29:06'),
(31, 31, 3, 6, '2025-04-22 16:29:06', '2025-04-22 16:29:06'),
(32, 32, 3, 7, '2025-04-22 16:29:06', '2025-04-22 16:29:06'),
(33, 33, 3, 8, '2025-04-22 16:29:06', '2025-04-22 16:29:06'),
(34, 34, 3, 9, '2025-04-22 16:29:06', '2025-04-22 16:29:06'),
(35, 35, 3, 10, '2025-04-22 16:29:06', '2025-04-22 16:29:06'),
(36, 36, 3, 11, '2025-04-22 16:29:06', '2025-04-22 16:29:06'),
(37, 37, 3, 12, '2025-04-22 16:29:06', '2025-04-22 16:29:06'),
(38, 38, 3, 13, '2025-04-22 16:29:06', '2025-04-22 16:29:06'),
(39, 39, 3, 14, '2025-04-22 16:29:06', '2025-04-22 16:29:06'),
(40, 40, 3, 15, '2025-04-22 16:29:06', '2025-04-22 16:29:06'),
(41, 41, 3, 16, '2025-04-22 16:29:06', '2025-04-22 16:29:06'),
(42, 42, 4, 1, '2025-04-22 16:29:07', '2025-04-22 16:29:07'),
(43, 43, 4, 2, '2025-04-22 16:29:07', '2025-04-22 16:29:07'),
(44, 44, 4, 3, '2025-04-22 16:29:07', '2025-04-22 16:29:07'),
(45, 45, 4, 4, '2025-04-22 16:29:07', '2025-04-22 16:29:07'),
(46, 46, 4, 5, '2025-04-22 16:29:07', '2025-04-22 16:29:07'),
(47, 47, 4, 6, '2025-04-22 16:29:07', '2025-04-22 16:29:07'),
(48, 48, 4, 7, '2025-04-22 16:29:07', '2025-04-22 16:29:07'),
(49, 49, 4, 8, '2025-04-22 16:29:07', '2025-04-22 16:29:07'),
(50, 50, 5, 1, '2025-04-22 16:29:08', '2025-04-22 16:29:08'),
(51, 51, 5, 2, '2025-04-22 16:29:08', '2025-04-22 16:29:08'),
(52, 52, 5, 3, '2025-04-22 16:29:08', '2025-04-22 16:29:08'),
(53, 53, 5, 4, '2025-04-22 16:29:08', '2025-04-22 16:29:08'),
(54, 54, 5, 5, '2025-04-22 16:29:08', '2025-04-22 16:29:08'),
(55, 55, 5, 6, '2025-04-22 16:29:08', '2025-04-22 16:29:08'),
(56, 56, 5, 7, '2025-04-22 16:29:08', '2025-04-22 16:29:08'),
(57, 57, 5, 8, '2025-04-22 16:29:08', '2025-04-22 16:29:08'),
(58, 58, 5, 9, '2025-04-22 16:29:08', '2025-04-22 16:29:08'),
(59, 59, 5, 10, '2025-04-22 16:29:08', '2025-04-22 16:29:08'),
(60, 60, 5, 11, '2025-04-22 16:29:08', '2025-04-22 16:29:08'),
(61, 61, 5, 12, '2025-04-22 16:29:08', '2025-04-22 16:29:08'),
(62, 62, 5, 13, '2025-04-22 16:29:08', '2025-04-22 16:29:08'),
(63, 63, 6, 1, '2025-04-22 16:29:09', '2025-04-22 16:29:09'),
(64, 64, 6, 2, '2025-04-22 16:29:09', '2025-04-22 16:29:09'),
(65, 65, 6, 3, '2025-04-22 16:29:09', '2025-04-22 16:29:09'),
(66, 66, 6, 4, '2025-04-22 16:29:09', '2025-04-22 16:29:09'),
(67, 67, 6, 5, '2025-04-22 16:29:09', '2025-04-22 16:29:09'),
(68, 68, 6, 6, '2025-04-22 16:29:09', '2025-04-22 16:29:09'),
(69, 69, 6, 7, '2025-04-22 16:29:09', '2025-04-22 16:29:09'),
(70, 70, 6, 8, '2025-04-22 16:29:09', '2025-04-22 16:29:09'),
(71, 71, 6, 9, '2025-04-22 16:29:09', '2025-04-22 16:29:09'),
(72, 72, 6, 10, '2025-04-22 16:29:09', '2025-04-22 16:29:09'),
(73, 73, 6, 11, '2025-04-22 16:29:09', '2025-04-22 16:29:09'),
(74, 74, 7, 1, '2025-04-22 16:29:10', '2025-04-22 16:29:10'),
(75, 75, 7, 2, '2025-04-22 16:29:10', '2025-04-22 16:29:10'),
(76, 76, 7, 3, '2025-04-22 16:29:10', '2025-04-22 16:29:10'),
(77, 77, 7, 4, '2025-04-22 16:29:10', '2025-04-22 16:29:10'),
(78, 78, 7, 5, '2025-04-22 16:29:10', '2025-04-22 16:29:10'),
(79, 79, 7, 6, '2025-04-22 16:29:10', '2025-04-22 16:29:10'),
(80, 80, 7, 7, '2025-04-22 16:29:10', '2025-04-22 16:29:10'),
(81, 81, 7, 8, '2025-04-22 16:29:10', '2025-04-22 16:29:10'),
(82, 82, 7, 9, '2025-04-22 16:29:10', '2025-04-22 16:29:10'),
(83, 83, 7, 10, '2025-04-22 16:29:10', '2025-04-22 16:29:10'),
(84, 84, 7, 11, '2025-04-22 16:29:10', '2025-04-22 16:29:10'),
(85, 85, 7, 12, '2025-04-22 16:29:10', '2025-04-22 16:29:10'),
(86, 86, 7, 13, '2025-04-22 16:29:10', '2025-04-22 16:29:10'),
(87, 87, 8, 1, '2025-04-22 16:29:11', '2025-04-22 16:29:11'),
(88, 88, 8, 2, '2025-04-22 16:29:11', '2025-04-22 16:29:11'),
(89, 89, 8, 3, '2025-04-22 16:29:11', '2025-04-22 16:29:11'),
(90, 90, 8, 4, '2025-04-22 16:29:11', '2025-04-22 16:29:11'),
(91, 91, 8, 5, '2025-04-22 16:29:11', '2025-04-22 16:29:11'),
(92, 92, 8, 6, '2025-04-22 16:29:11', '2025-04-22 16:29:11'),
(93, 93, 8, 7, '2025-04-22 16:29:11', '2025-04-22 16:29:11'),
(94, 94, 8, 8, '2025-04-22 16:29:11', '2025-04-22 16:29:11'),
(95, 95, 8, 9, '2025-04-22 16:29:11', '2025-04-22 16:29:11'),
(96, 96, 8, 10, '2025-04-22 16:29:11', '2025-04-22 16:29:11'),
(97, 97, 8, 11, '2025-04-22 16:29:11', '2025-04-22 16:29:11'),
(98, 98, 8, 12, '2025-04-22 16:29:11', '2025-04-22 16:29:11'),
(99, 99, 8, 13, '2025-04-22 16:29:11', '2025-04-22 16:29:11'),
(100, 100, 9, 1, '2025-04-22 16:29:12', '2025-04-22 16:29:12'),
(101, 101, 9, 2, '2025-04-22 16:29:12', '2025-04-22 16:29:12'),
(102, 102, 9, 3, '2025-04-22 16:29:12', '2025-04-22 16:29:12'),
(103, 103, 9, 4, '2025-04-22 16:29:12', '2025-04-22 16:29:12'),
(104, 104, 9, 5, '2025-04-22 16:29:12', '2025-04-22 16:29:12'),
(105, 105, 9, 6, '2025-04-22 16:29:12', '2025-04-22 16:29:12'),
(106, 106, 9, 7, '2025-04-22 16:29:12', '2025-04-22 16:29:12'),
(107, 107, 9, 8, '2025-04-22 16:29:12', '2025-04-22 16:29:12'),
(108, 108, 9, 9, '2025-04-22 16:29:12', '2025-04-22 16:29:12'),
(109, 109, 9, 10, '2025-04-22 16:29:12', '2025-04-22 16:29:12'),
(110, 110, 9, 11, '2025-04-22 16:29:12', '2025-04-22 16:29:12'),
(111, 111, 9, 12, '2025-04-22 16:29:12', '2025-04-22 16:29:12'),
(112, 112, 9, 13, '2025-04-22 16:29:12', '2025-04-22 16:29:12'),
(113, 113, 9, 14, '2025-04-22 16:29:12', '2025-04-22 16:29:12'),
(114, 114, 9, 15, '2025-04-22 16:29:12', '2025-04-22 16:29:12'),
(115, 115, 9, 16, '2025-04-22 16:29:12', '2025-04-22 16:29:12'),
(116, 116, 9, 17, '2025-04-22 16:29:12', '2025-04-22 16:29:12'),
(117, 117, 9, 18, '2025-04-22 16:29:12', '2025-04-22 16:29:12'),
(118, 118, 9, 19, '2025-04-22 16:29:12', '2025-04-22 16:29:12'),
(119, 119, 9, 20, '2025-04-22 16:29:12', '2025-04-22 16:29:12'),
(120, 100, 10, 1, '2025-04-22 16:29:13', '2025-04-22 16:29:13'),
(121, 101, 10, 2, '2025-04-22 16:29:13', '2025-04-22 16:29:13'),
(122, 102, 10, 3, '2025-04-22 16:29:13', '2025-04-22 16:29:13'),
(123, 103, 10, 4, '2025-04-22 16:29:13', '2025-04-22 16:29:13'),
(124, 104, 10, 5, '2025-04-22 16:29:13', '2025-04-22 16:29:13'),
(125, 105, 10, 6, '2025-04-22 16:29:13', '2025-04-22 16:29:13'),
(126, 106, 10, 7, '2025-04-22 16:29:13', '2025-04-22 16:29:13'),
(127, 107, 10, 8, '2025-04-22 16:29:13', '2025-04-22 16:29:13'),
(128, 108, 10, 9, '2025-04-22 16:29:13', '2025-04-22 16:29:13'),
(129, 109, 10, 10, '2025-04-22 16:29:13', '2025-04-22 16:29:13'),
(130, 120, 11, 1, '2025-04-22 16:29:14', '2025-04-22 16:29:14'),
(131, 121, 11, 2, '2025-04-22 16:29:14', '2025-04-22 16:29:14'),
(132, 122, 11, 3, '2025-04-22 16:29:14', '2025-04-22 16:29:14'),
(133, 123, 11, 4, '2025-04-22 16:29:14', '2025-04-22 16:29:14'),
(134, 124, 11, 5, '2025-04-22 16:29:14', '2025-04-22 16:29:14'),
(135, 125, 11, 6, '2025-04-22 16:29:14', '2025-04-22 16:29:14'),
(136, 126, 11, 7, '2025-04-22 16:29:14', '2025-04-22 16:29:14'),
(137, 127, 11, 8, '2025-04-22 16:29:14', '2025-04-22 16:29:14'),
(138, 128, 11, 9, '2025-04-22 16:29:14', '2025-04-22 16:29:14'),
(139, 129, 11, 10, '2025-04-22 16:29:14', '2025-04-22 16:29:14'),
(142, 3, 13, 1, '2025-04-22 16:29:15', '2025-04-22 16:29:15'),
(143, 6, 14, 1, '2025-04-22 16:29:16', '2025-04-22 16:29:16'),
(144, 132, 15, 1, '2025-04-22 16:29:17', '2025-04-22 16:29:17'),
(145, 133, 16, 1, '2025-04-22 16:29:17', '2025-04-22 16:29:17'),
(146, 134, 17, 1, '2025-04-22 16:29:18', '2025-04-22 16:29:18'),
(147, 13, 18, 1, '2025-04-22 16:29:19', '2025-04-22 16:29:19'),
(148, 135, 19, 1, '2025-04-22 16:29:19', '2025-04-22 16:29:19'),
(149, 10, 20, 1, '2025-04-22 16:29:20', '2025-04-22 16:29:20'),
(150, 11, 21, 1, '2025-04-22 16:29:21', '2025-04-22 16:29:21'),
(151, 136, 22, 1, '2025-04-22 16:29:22', '2025-04-22 16:29:22'),
(152, 137, 22, 2, '2025-04-22 16:29:22', '2025-04-22 16:29:22'),
(153, 138, 22, 3, '2025-04-22 16:29:22', '2025-04-22 16:29:22'),
(154, 138, 23, 1, '2025-04-22 16:29:22', '2025-04-22 16:29:22'),
(155, 139, 24, 1, '2025-04-22 16:29:23', '2025-04-22 16:29:23'),
(156, 140, 25, 1, '2025-04-22 16:29:24', '2025-04-22 16:29:24'),
(157, 141, 26, 1, '2025-04-22 16:29:25', '2025-04-22 16:29:25'),
(158, 142, 27, 1, '2025-04-22 16:29:25', '2025-04-22 16:29:25'),
(159, 143, 28, 1, '2025-04-22 16:29:26', '2025-04-22 16:29:26'),
(160, 144, 29, 1, '2025-04-22 16:29:27', '2025-04-22 16:29:27'),
(161, 15, 30, 1, '2025-04-22 16:29:27', '2025-04-22 16:29:27'),
(162, 145, 31, 1, '2025-04-22 16:29:28', '2025-04-22 16:29:28'),
(163, 146, 32, 1, '2025-04-22 16:29:29', '2025-04-22 16:29:29'),
(164, 19, 33, 1, '2025-04-22 16:29:30', '2025-04-22 16:29:30'),
(165, 20, 34, 1, '2025-04-22 16:29:30', '2025-04-22 16:29:30'),
(166, 18, 35, 1, '2025-04-22 16:29:31', '2025-04-22 16:29:31'),
(167, 24, 36, 1, '2025-04-22 16:29:32', '2025-04-22 16:29:32'),
(168, 147, 37, 1, '2025-04-22 16:29:32', '2025-04-22 16:29:32'),
(169, 148, 12, 1, '2025-04-22 16:29:33', '2025-04-22 16:29:33'),
(170, 149, 12, 2, '2025-04-22 16:29:33', '2025-04-22 16:29:33'),
(171, 150, 38, 1, '2025-04-22 16:29:34', '2025-04-22 16:29:34'),
(172, 52, 39, 1, '2025-04-22 16:29:35', '2025-04-22 16:29:35'),
(173, 60, 40, 1, '2025-04-22 16:29:35', '2025-04-22 16:29:35'),
(174, 56, 41, 1, '2025-04-22 16:29:36', '2025-04-22 16:29:36'),
(175, 54, 42, 1, '2025-04-22 16:29:37', '2025-04-22 16:29:37'),
(176, 51, 43, 1, '2025-04-22 16:29:37', '2025-04-22 16:29:37'),
(177, 151, 44, 1, '2025-04-22 16:29:38', '2025-04-22 16:29:38'),
(178, 152, 45, 1, '2025-04-22 16:29:39', '2025-04-22 16:29:39'),
(179, 74, 46, 1, '2025-04-22 16:29:39', '2025-04-22 16:29:39'),
(180, 153, 46, 2, '2025-04-22 16:29:40', '2025-04-22 16:29:40'),
(181, 154, 46, 3, '2025-04-22 16:29:40', '2025-04-22 16:29:40'),
(182, 77, 47, 1, '2025-04-22 16:29:40', '2025-04-22 16:29:40'),
(183, 155, 47, 2, '2025-04-22 16:29:40', '2025-04-22 16:29:40'),
(184, 156, 48, 1, '2025-04-22 16:29:41', '2025-04-22 16:29:41'),
(185, 157, 48, 2, '2025-04-22 16:29:41', '2025-04-22 16:29:41'),
(186, 158, 48, 3, '2025-04-22 16:29:41', '2025-04-22 16:29:41'),
(187, 159, 48, 4, '2025-04-22 16:29:41', '2025-04-22 16:29:41'),
(188, 159, 49, 1, '2025-04-22 16:29:42', '2025-04-22 16:29:42'),
(189, 120, 49, 2, '2025-04-22 16:29:42', '2025-04-22 16:29:42'),
(190, 106, 49, 3, '2025-04-22 16:29:42', '2025-04-22 16:29:42'),
(191, 160, 49, 4, '2025-04-22 16:29:42', '2025-04-22 16:29:42'),
(192, 101, 49, 5, '2025-04-22 16:29:42', '2025-04-22 16:29:42'),
(193, 100, 49, 6, '2025-04-22 16:29:42', '2025-04-22 16:29:42'),
(194, 97, 49, 7, '2025-04-22 16:29:42', '2025-04-22 16:29:42'),
(195, 89, 49, 8, '2025-04-22 16:29:42', '2025-04-22 16:29:42'),
(196, 161, 49, 9, '2025-04-22 16:29:42', '2025-04-22 16:29:42'),
(197, 162, 49, 10, '2025-04-22 16:29:42', '2025-04-22 16:29:42'),
(198, 79, 49, 11, '2025-04-22 16:29:42', '2025-04-22 16:29:42'),
(199, 78, 49, 12, '2025-04-22 16:29:42', '2025-04-22 16:29:42'),
(200, 74, 49, 13, '2025-04-22 16:29:42', '2025-04-22 16:29:42'),
(201, 77, 49, 14, '2025-04-22 16:29:42', '2025-04-22 16:29:42'),
(202, 82, 49, 15, '2025-04-22 16:29:42', '2025-04-22 16:29:42');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `status` enum('active','banned','deleted') NOT NULL DEFAULT 'active',
  `remember_token` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `users_roles`
--

CREATE TABLE `users_roles` (
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `role_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `user_collections`
--

CREATE TABLE `user_collections` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(100) NOT NULL,
  `description` text DEFAULT NULL,
  `is_private` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `user_collections_tracks`
--

CREATE TABLE `user_collections_tracks` (
  `collection_id` bigint(20) UNSIGNED NOT NULL,
  `track_id` bigint(20) UNSIGNED NOT NULL,
  `track_position` int(10) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

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
  `sort_order` smallint(5) UNSIGNED NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `artists`
--
ALTER TABLE `artists`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `artists_name_unique` (`name`);

--
-- Indexes for table `artists_genres`
--
ALTER TABLE `artists_genres`
  ADD PRIMARY KEY (`artist_id`,`genre_id`),
  ADD KEY `artists_genres_artist_id_index` (`artist_id`),
  ADD KEY `artists_genres_genre_id_index` (`genre_id`);

--
-- Indexes for table `artists_releases`
--
ALTER TABLE `artists_releases`
  ADD PRIMARY KEY (`artist_id`,`release_id`),
  ADD KEY `artists_releases_artist_id_index` (`artist_id`),
  ADD KEY `artists_releases_release_id_index` (`release_id`);

--
-- Indexes for table `artists_tracks`
--
ALTER TABLE `artists_tracks`
  ADD PRIMARY KEY (`artist_id`,`track_id`),
  ADD KEY `artists_tracks_artist_id_index` (`artist_id`),
  ADD KEY `artists_tracks_track_id_index` (`track_id`),
  ADD KEY `artists_tracks_artist_id_role_index` (`artist_id`,`role`),
  ADD KEY `artists_tracks_track_id_role_index` (`track_id`,`role`);

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
  ADD KEY `comments_artists_status_index` (`status`);

--
-- Indexes for table `comments_releases`
--
ALTER TABLE `comments_releases`
  ADD PRIMARY KEY (`id`),
  ADD KEY `comments_releases_user_id_index` (`user_id`),
  ADD KEY `comments_releases_release_id_index` (`release_id`),
  ADD KEY `comments_releases_status_index` (`status`);

--
-- Indexes for table `comments_tracks`
--
ALTER TABLE `comments_tracks`
  ADD PRIMARY KEY (`id`),
  ADD KEY `comments_tracks_user_id_index` (`user_id`),
  ADD KEY `comments_tracks_track_id_index` (`track_id`),
  ADD KEY `comments_tracks_status_index` (`status`);

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
  ADD UNIQUE KEY `genres_name_unique` (`name`);

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
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `releases_genres`
--
ALTER TABLE `releases_genres`
  ADD PRIMARY KEY (`release_id`,`genre_id`),
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
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tracks_genres`
--
ALTER TABLE `tracks_genres`
  ADD PRIMARY KEY (`track_id`,`genre_id`),
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
  ADD UNIQUE KEY `users_email_unique` (`email`);

--
-- Indexes for table `users_roles`
--
ALTER TABLE `users_roles`
  ADD PRIMARY KEY (`user_id`,`role_id`),
  ADD KEY `users_roles_user_id_index` (`user_id`),
  ADD KEY `users_roles_role_id_index` (`role_id`);

--
-- Indexes for table `user_collections`
--
ALTER TABLE `user_collections`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_collections_user_id_index` (`user_id`);

--
-- Indexes for table `user_collections_tracks`
--
ALTER TABLE `user_collections_tracks`
  ADD PRIMARY KEY (`collection_id`,`track_id`),
  ADD KEY `user_collections_tracks_collection_id_track_position_index` (`collection_id`,`track_position`),
  ADD KEY `user_collections_tracks_track_id_foreign` (`track_id`);

--
-- Indexes for table `user_favorite_artists`
--
ALTER TABLE `user_favorite_artists`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `user_favorite_artists_user_id_artist_id_unique` (`user_id`,`artist_id`),
  ADD KEY `user_favorite_artists_user_id_sort_order_index` (`user_id`,`sort_order`),
  ADD KEY `user_favorite_artists_artist_id_foreign` (`artist_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `artists`
--
ALTER TABLE `artists`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=57;

--
-- AUTO_INCREMENT for table `comments_artists`
--
ALTER TABLE `comments_artists`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `comments_releases`
--
ALTER TABLE `comments_releases`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `comments_tracks`
--
ALTER TABLE `comments_tracks`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

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
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

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
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=50;

--
-- AUTO_INCREMENT for table `roles`
--
ALTER TABLE `roles`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tracks`
--
ALTER TABLE `tracks`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=163;

--
-- AUTO_INCREMENT for table `tracks_releases`
--
ALTER TABLE `tracks_releases`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=203;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `user_collections`
--
ALTER TABLE `user_collections`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `user_favorite_artists`
--
ALTER TABLE `user_favorite_artists`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `artists_genres`
--
ALTER TABLE `artists_genres`
  ADD CONSTRAINT `artists_genres_artist_id_foreign` FOREIGN KEY (`artist_id`) REFERENCES `artists` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `artists_genres_genre_id_foreign` FOREIGN KEY (`genre_id`) REFERENCES `genres` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `artists_releases`
--
ALTER TABLE `artists_releases`
  ADD CONSTRAINT `artists_releases_artist_id_foreign` FOREIGN KEY (`artist_id`) REFERENCES `artists` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `artists_releases_release_id_foreign` FOREIGN KEY (`release_id`) REFERENCES `releases` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `artists_tracks`
--
ALTER TABLE `artists_tracks`
  ADD CONSTRAINT `artists_tracks_artist_id_foreign` FOREIGN KEY (`artist_id`) REFERENCES `artists` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `artists_tracks_track_id_foreign` FOREIGN KEY (`track_id`) REFERENCES `tracks` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `comments_artists`
--
ALTER TABLE `comments_artists`
  ADD CONSTRAINT `comments_artists_artist_id_foreign` FOREIGN KEY (`artist_id`) REFERENCES `artists` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `comments_artists_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `comments_releases`
--
ALTER TABLE `comments_releases`
  ADD CONSTRAINT `comments_releases_release_id_foreign` FOREIGN KEY (`release_id`) REFERENCES `releases` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `comments_releases_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `comments_tracks`
--
ALTER TABLE `comments_tracks`
  ADD CONSTRAINT `comments_tracks_track_id_foreign` FOREIGN KEY (`track_id`) REFERENCES `tracks` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `comments_tracks_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `lyrics`
--
ALTER TABLE `lyrics`
  ADD CONSTRAINT `lyrics_last_updated_by_user_foreign` FOREIGN KEY (`last_updated_by_user`) REFERENCES `users` (`id`) ON DELETE SET NULL,
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
  ADD CONSTRAINT `recommendations_artists_artist_id_foreign` FOREIGN KEY (`artist_id`) REFERENCES `artists` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `recommendations_artists_recommendation_genre_id_foreign` FOREIGN KEY (`recommendation_genre_id`) REFERENCES `recommendations_genres` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `recommendations_genres`
--
ALTER TABLE `recommendations_genres`
  ADD CONSTRAINT `recommendations_genres_genre_id_foreign` FOREIGN KEY (`genre_id`) REFERENCES `genres` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `recommendations_genres_recommendation_id_foreign` FOREIGN KEY (`recommendation_id`) REFERENCES `recommendations` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `releases_genres`
--
ALTER TABLE `releases_genres`
  ADD CONSTRAINT `releases_genres_genre_id_foreign` FOREIGN KEY (`genre_id`) REFERENCES `genres` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `releases_genres_release_id_foreign` FOREIGN KEY (`release_id`) REFERENCES `releases` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `tracks_genres`
--
ALTER TABLE `tracks_genres`
  ADD CONSTRAINT `tracks_genres_genre_id_foreign` FOREIGN KEY (`genre_id`) REFERENCES `genres` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `tracks_genres_track_id_foreign` FOREIGN KEY (`track_id`) REFERENCES `tracks` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `tracks_releases`
--
ALTER TABLE `tracks_releases`
  ADD CONSTRAINT `tracks_releases_release_id_foreign` FOREIGN KEY (`release_id`) REFERENCES `releases` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `tracks_releases_track_id_foreign` FOREIGN KEY (`track_id`) REFERENCES `tracks` (`id`);

--
-- Constraints for table `users_roles`
--
ALTER TABLE `users_roles`
  ADD CONSTRAINT `users_roles_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`),
  ADD CONSTRAINT `users_roles_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `user_collections`
--
ALTER TABLE `user_collections`
  ADD CONSTRAINT `user_collections_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `user_collections_tracks`
--
ALTER TABLE `user_collections_tracks`
  ADD CONSTRAINT `user_collections_tracks_collection_id_foreign` FOREIGN KEY (`collection_id`) REFERENCES `user_collections` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `user_collections_tracks_track_id_foreign` FOREIGN KEY (`track_id`) REFERENCES `tracks` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `user_favorite_artists`
--
ALTER TABLE `user_favorite_artists`
  ADD CONSTRAINT `user_favorite_artists_artist_id_foreign` FOREIGN KEY (`artist_id`) REFERENCES `artists` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `user_favorite_artists_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
