#! /bin/bash

# Text normalization script for all tests
tr '[:upper:]' '[:lower:]' | \
    sed -r 's#<s>##gi' | \
    sed -r 's#</s>##gi' | \
    sed -r 's#&# and #gi' | \
    sed -r 's#$[\b]*([0-9]+)#\1 dollars #gi' | \
    sed -r 's#([0-9]+)[\b]*%#\1 percent #gi' | \
    sed -r 's#([a-z]+)\-in\-law#\1 in law#gi' | \
    sed -r 's#([a-z]+)\-minute#\1 minute#gi' | \
    sed -r 's#([0-9]+):([0-9]+)#\1 \2#gi' | \
    sed -r 's#(north|south)-(east|west)#\1 \2#gi' | \
    sed -r 's#<space>##gi' | \
    ##
    ## remove the noisy tags
    ## 
    #sed 's/\bNOISE\b/ /gi' | \
    #sed 's/\bSPOKENNOISE\b/ /gi' | \
    sed 's/SPOKEN_NOISE/SPOKENNOISE/gi' | \
    sed 's/\bSPN\b/ /gi' | \
    sed 's/\bNSN\b/ /gi' | \
    
    # split year 20xx
    sed -r 's/\b200([1-9])(ST|ND|RD|TH)?\b/2 THOUSAND \1\2/gi' | \
    sed -r 's/\b20([1-9][0-9])(ST|ND|RD|TH)?\b/2 THOUSAND \1\2/gi' | \
	# separate tens and ones
	# Watch out: because of this step we cannot differentiate between
	# "ninetyeight" (98) and "ninety eigth" (meant as "90 and 8")
	# The second case may be relevant for telephon numbers.
    sed 's/\(twenty\|thirty\|forty\|fifty\|\sixty\|seventy\|eighty\|ninety\)\(one\|two\|three\|four\|five\|six\|seven\|eight\|nine\|first\|second\|third\|fourth\|fifth\|sixth\|seventh\|eighth\|nineth\)/\1 \2/gi' | \
    sed -r 's/\b([2-9])([1-9]\b)/\10 \2/gi' | \
    sed -r 's/\b([2-9])(1ST|2ND|3RD|[4-9]TH)\b/\10 \2/gi' | \
	# convert cardinal numbers 0-20 + 30, 40, 50, 60, 70, 80, 90
	#sed 's/\boh\b/0/gi' | \
	sed 's/\bzero\b/0/gi' | \
	sed 's/\bone\b/1/gi' | \
	sed 's/\btwo\b/2/gi' | \
	sed 's/\bthree\b/3/gi' | \
	sed 's/\bfour\b/4/gi' | \
	sed 's/\bfive\b/5/gi' | \
	sed 's/\bsix\b/6/gi' | \
	sed 's/\bseven\b/7/gi' | \
	sed 's/\beight\b/8/gi' | \
	sed 's/\bnine\b/9/gi' | \
	sed 's/\bten\b/10/gi' | \
	sed 's/\beleven\b/11/gi' | \
	sed 's/\btwelve\b/12/gi' | \
	sed 's/\bthirteen\b/13/gi' | \
        sed 's/\bfourteen\b/14/gi' | \
	sed 's/\bforteen\b/14/gi' | \
	sed 's/\bfifteen\b/15/gi' | \
	sed 's/\bsixteen\b/16/gi' | \
	sed 's/\bseventeen\b/17/gi' | \
	sed 's/\beighteen\b/18/gi' | \
	sed 's/\bnineteen\b/19/gi' | \
	sed 's/\btwenty\b/20/gi' | \
	sed 's/\bthirty\b/30/gi' | \
	sed 's/\bforty\b/40/gi' | \
	sed 's/\bfifty\b/50/gi' | \
	sed 's/\bsixty\b/60/gi' | \
	sed 's/\bseventy\b/70/gi' | \
	sed 's/\beighty\b/80/gi' | \
	sed 's/\bninety\b/90/gi' | \
	# convert ordinal numbers 1-20 + 30, 40, 50, 60, 70, 80, 90
	sed 's/\bfirst\b/1ST/gi' | \
	sed 's/\bsecond\b/2ND/gi' | \
	sed 's/\bthird\b/3RD/gi' | \
	sed 's/\bfourth\b/4TH/gi' | \
	sed 's/\bfifth\b/5TH/gi' | \
	sed 's/\bsixth\b/6TH/gi' | \
	sed 's/\bseventh\b/7TH/gi' | \
	sed 's/\beighth\b/8TH/gi' | \
	sed 's/\bninth\b/9TH/gi' | \
        sed 's/\bnineth\b/9TH/gi' | \
	sed 's/\btenth\b/10TH/gi' | \
	sed 's/\beleventh\b/11TH/gi' | \
	sed 's/\btwelfth\b/12TH/gi' | \
	sed 's/\btwelveth\b/12TH/gi' | \
	sed 's/\bthirteenth\b/13TH/gi' | \
	sed 's/\bfourteenth\b/14TH/gi' | \
        sed 's/\bforteenth\b/14TH/gi' | \
	sed 's/\bfifteenth\b/15TH/gi' | \
	sed 's/\bsixteenth\b/16TH/gi' | \
	sed 's/\bseventeenth\b/17TH/gi' | \
	sed 's/\beighteenth\b/18TH/gi' | \
	sed 's/\bnineteenth\b/19TH/gi' | \
	sed 's/\btwentieth\b/20TH/gi' | \
	sed 's/\bthirtieth\b/30TH/gi' | \
	sed 's/\bfortieth\b/40TH/gi' | \
	sed 's/\bfiftieth\b/50TH/gi' | \
	sed 's/\bsixtieth\b/60TH/gi' | \
	sed 's/\bseventieth\b/70TH/gi' | \
	sed 's/\beightieth\b/80TH/gi' | \
	sed 's/\bninetieth\b/90TH/gi' | \
	# join dangling ST, ND, RD and TH to their preceeding numbers
	sed 's/1 ST\b/1ST/gi' | \
	sed 's/2 ND\b/2ND/gi' | \
	sed 's/3 RD\b/3RD/gi' | \
	sed -r 's/([456789]) TH\b/\1TH/gi' | \
        # Clock format
        sed -r "s#([0-9]+) (oclock|o'clock)#\1 0 0#gi" | \
	# normalize am/pm
	sed -r 's/\b((1)?[0-9])([ap]( )?m)/\1 \3/gi' | \
	sed 's/\bA\.M\.\b/AM/gi' | \
	sed 's/\bP\.M\.\b/PM/gi' | \
	sed 's/\bA\ M\b/AM/gi' | \
	sed 's/\bP\ M\b/PM/gi' | \
	# misc
	sed 's/\(\ \|^\)ten\(\ \|$\)/ 10 /gi' | \
	sed 's/\(\ \|^\)ten\(\ \|$\)/ 10 /gi' | \
	sed 's/\b49 ERS\b/FORTY NINERS/gi' | \
        sed 's/\b49 ER\b/FORTY NINER/gi' | \
	sed 's/\b40 NINERS\b/FORTY NINERS/gi' | \
        sed 's/\b40 NINER\b/FORTY NINER/gi' | \
        sed 's/\b40 9 ERS\b/FORTY NINERS/gi' | \
        sed 's/\b40 9 ER\b/FORTY NINERS/gi' | \
	sed 's/\bevery\b\ day/EVERYDAY/gi' | \
	sed 's/\bnear\b\ by/NEARBY/gi'  | \
	sed 's/\bwheres\b/WHERE IS/gi'  | \
	sed 's/\bfast\b\ food/FASTFOOD/gi'  | \
	sed 's/\bi\ hop\b/IHOP/gi'  | \
	sed 's/\ba\ t\ and\b\ t/ATT/gi'  | \
	sed 's/\bseven\ eleven\b/7ELEVEN/gi'  | \
	sed 's/\bu\ s\b\ /US /gi'  | \
	sed 's/\blocations\b/LOCATION/gi'  | \
	sed 's/\bdirections\b/DIRECTION/gi'  | \
	sed 's/\bpizzahut\b/PIZZA\ HUT/gi'  | \
	sed 's/\bparlour\b/PARLOR/gi'  | \
	sed 's/\bradioshack\b/RADIO\ SHACK/gi'  | \
	sed 's/\bbestbuy\b/BEST BUY/gi'  | \
	sed 's/\bstations\b/STATION/gi'  | \
	sed 's/\bhotels\b/HOTEL/gi' | \
	sed 's/\brest room\b/restroom/gi' | \
	sed 's/\bair sickness\b/airsickness/gi' | \
	sed 's/\bduty free\b/dutyfree/gi' | \
	sed 's/\b1 day\b/oneday/gi' | \
	sed 's/\bweek days\b/weekdays/gi' | \
	sed 's/\bnon touristy\b/nontouristy/gi' | \
	sed 's/\bhigh end\b/highend/gi' | \
	##
	## start : en-GB TC Specific Changes
	##
	sed 's/\bmyrtle field\b/myrtlefield/gi' | \
	sed 's/\bd p d dot\b/dpd dot/gi' | \
	sed 's/\bdot u k\b/dot uk/gi' | \
	sed 's/\bx43a\b/x 40 3 a/gi' | \
	sed 's/\bw w w dot\b/www dot/gi' | \
	sed 's/\bporn hub\b/pornhub/gi' | \
	sed 's/\bdot s g\b/dot sg/gi' | \
	sed 's/\bcheats ps 3\b/cheats ps3/gi' | \
	sed 's/\bdiesel max\b/dieselmax/gi' | \
	sed 's/\bopen u r l\b/open url/gi' | \
	sed 's/\b8 j e on\b/8je on/gi' | \
	sed 's/\biphone 4 s\b/iphone 4s/gi' | \
	sed 's/\bx videos dot\b/xvideos dot/gi' | \
	sed 's/\bfor j c b\b/for jcb/gi' | \
	sed 's/\bgoogle j c b\b/google jcb/gi' | \
	sed 's/\bdot c b s\b/dot cbs/gi' | \
	sed 's/\bon s 4\b/on s4/gi' | \
	sed 's/\bgoogle s a s\b/google sas/gi' | \
	sed 's/\bheterosexual\b/hetrosexual/gi' | \
	sed 's/\bjet pack\b/jetpack/gi' | \
	sed 's/\bpain killer\b/painkiller/gi' | \
	sed 's/\bgoogle play store\b/google playstore/gi' | \
	sed 's/\bthe x n x x\b/the xnxx/gi' | \
	sed 's/\bwood chuck\b/woodchuck/gi' | \
	sed 's/\bcamp site\b/campsite/gi' | \
	sed 's/\bpoopoo\b/poo poo/gi' | \
	sed 's/\bgoogle plus\b/google/gi' | \
	sed 's/\byou tube\b/youtube/gi' | \
	sed 's/\bshe male\b/shemale/gi' | \
	sed 's/\bgalaxy s 4\b/galaxy s4/gi' | \
	sed 's/\bsearch j c b\b/search jcb/gi' | \
	sed 's/\bclass mates\b/classmates/gi' | \
	sed 's/\blovefilm\b/love film/gi' | \
	sed 's/\bgalaxy s 3\b/galaxy s3/gi' | \
	sed 's/\btrip advisor\b/tripadvisor/gi' | \
	sed 's/\blovehearts\b/love hearts/gi' | \
	sed 's/\bh d video\b/hd video/gi' | \
	sed 's/\bv w south\b/vw south/gi' | \
	sed 's/\blove struck\b/lovestruck/gi' | \
	sed 's/\bpornstar\b/porn star/gi' | \
	sed 's/\bto n 16\b/to n16/gi' | \
	sed 's/\bsoccer net\b/soccernet/gi' | \
	sed 's/\baudi a 3\b/audi a 3/gi' | \
	sed 's/\blog in\b/login/gi' | \
	sed 's/\bradcliffeontrent\b/radcliffe on trent/gi' | \
	sed 's/\bwaterlooville\b/waterloo ville/gi' | \
	sed 's/\bhong kong\b/hongkong/gi' | \
	sed 's/\blong term\b/longterm/gi' | \
	sed 's/\bBOSNIA HERZEGOVNIA\b/BOSNIA HERZEGOVNIA/gi' | \
	sed 's/\bBOSNIAHERCEGOVINA\b/BOSNIA HERZEGOVNIA/gi' | \
	sed 's/\bsofia grad\b/sofiagrad/gi' | \
	sed 's/\bHOPTONONSEA\b/HOPTON ON SEA/gi' | \
	sed 's/\bben fleet\b/benfleet/gi' | \
	sed 's/\bstop watch\b/stopwatch/gi' | \
	sed 's/\bgalaxynote\b/galaxy note/gi' | \
	sed 's/\b4X4 driving\b/4 by 4 driving/gi' | \
	sed 's/\bn w 1 6 a a\b/nw1 6aa/gi' | \
	sed 's/\bSUPERCALIFRAGILISTIC EXPIALIDOCIOUS\b/SUPERCALAFRAGILISTICEXPIALIDOCIOUS/gi' | \
	sed 's/\bnikon d 7\b/nikon d7/gi' | \
	sed 's/\bwwwfacebookcom\b/www dot facebok dot com/gi' | \
	sed 's/\bjayz\b/jay z/gi' | \
	sed 's/\bring tone\b/ringtone/gi' | \
	sed 's/\bweek day\b/weekday/gi' | \
	sed 's/\bcountrywide\b/country wide/gi' | \
	sed 's/\ba s a p\b/asap/gi' | \
	sed 's/\bvoice mail\b/voicemail/gi' | \
	sed 's/\bin u a e\b/in uae/gi' | \
	sed 's/\bstonehouse\b/stone house/gi' | \
	sed 's/\bbarbershop\b/barber shop/gi' | \
	sed 's/\bfree m p 3\b/free mp3/gi' | \
	sed 's/\bsong d r\b/song dr/gi' | \
	sed 's/\bthe v a t rate\b/the vat rate/gi' | \
	sed 's/\bused in s 4\b/used in s4/gi' | \
	sed 's/\bof u a e\b/of uae/gi' | \
	sed 's/\bg m t\b/gmt/gi' | \
	sed 's/\bon d v d\b/on dvd/gi' | \
	sed 's/\bon line\b/online/gi' | \
	sed 's/\btext a j\b/text aj/gi' | \
	sed 's/\bnever mind\b/nevermind/gi' | \
	sed 's/\bgoodnight\b/good night/gi' | \
	sed 's/\bB M T C\b/BMTC/gi' | \
	sed 's/\bTHEATRE\b/THEATER/gi' | \
	sed 's/\bO M C\b/OMC/gi' | \
	sed 's/\bB G\b/BG/gi' | \
	sed 's/\bS T A\b/STA/gi' | \
	sed 's/\bA P\b/AP/gi' | \
        sed 's/\bW S K\b/WSK/gi' | \
	sed 's/\bI D\b/ID/gi' | \
	sed 's/\bVOICE MAIL\b/VOICEMAIL/gi' | \
	sed 's/\bO H\b/O/gi' | \
	sed 's/\bFOX HILL\b/FOXHILL/gi' | \
	sed 's/\bU A E\b/UAE/gi' | \
	sed 's/\bB P\b/BP/gi' | \
	sed 's/\bSTONE MARKET\b/STONEMARKET/gi' | \
        sed 's/\bDEHLI\b/DELHI/gi' | \
        sed 's/\bCENTRE\b/CENTER/gi' | \
        sed 's/\bCLOSET\b/CLOSEST/gi' | \
	sed 's/\bNEW PORT\b/NEWPORT/gi' | \
        sed 's/\bM P 3\b/MP3/gi' | \
	sed 's/\bBASKET BALL\b/BASKETBALL/gi' | \
	sed 's/\bD R\b/DR/gi' | \
	sed 's/\bC D\b/CD/gi' | \
	sed 's/\bOSULLIVAN\b/O SULLIVAN/gi' | \
	sed 's/\bPLAY LIST\b/PLAYLIST/gi' | \
	sed 's/\bSUMMER TIME\b/SUMMERTIME/gi' | \
	sed 's/\bC N N\b/CNN/gi' | \
	sed 's/\bB B C\b/BBC/gi' | \
	sed 's/\bLOVE STRUCK\b/LOVESTRUCK/gi' | \
	sed 's/\bE S P N\b/ESPN/gi' | \
	sed 's/\bB M X\b/BMX/gi' | \
	sed 's/\bCANDYCRUSH\b/CANDY CRUSH/gi' | \
	sed 's/\bS VOICE\b/SVOICE/gi' | \
	sed 's/\bC S R\b/CSR/gi' | \
	sed 's/\bFLASH LIGHT\b/FLASHLIGHT/gi' | \
	sed 's/\bM 1\b/M1/gi' | \
	sed 's/\bG D P\b/GDP/gi' | \
	sed 's/\bUS A\b/USA/gi' | \
	sed 's/\bM 6\b/M6/gi' | \
	sed 's/\bTRANSEXUAL\b/TRANSSEXUAL/gi' | \
	sed 's/\bT V\b/TV/gi' | \
	sed 's/\bF M\b/FM/gi' | \
	sed 's/\bBIRTHSTONE\b/BIRTH STONE/gi' | \
	sed 's/\bU A E\b/UAE/gi' | \
	sed 's/\bDICKHEAD\b/DICK HEAD/gi' | \
	sed 's/\bANTIVIRUS\b/ANTI VIRUS/gi' | \
	sed 's/\bU K\b/UK/gi' | \
	sed 's/\bF C\b/FC/gi' | \
	sed 's/\bG M T\b/GMT/gi' | \
	sed 's/\bD V D\b/DVD/gi' | \
	sed 's/\bJ C B\b/JCB/gi' | \
	sed 's/\bDIESELMAX\b/DIESEL MAX/gi' | \
	sed 's/\bPLAY STORE\b/PLAYSTORE/gi' | \
	sed 's/\bU K\b/UK/gi' | \
	sed 's/\bBET3 6 5\b/BET365/gi' | \
	sed 's/\bBET 3 6 5\b/BET365/gi' | \
	sed 's/\bF C\b/FC/gi' | \
	sed 's/\bW W W\b/WWW/gi' | \
	sed 's/\bPORN START\b/PORNSTAR/gi' | \
	sed 's/\bNEPALSTOCK\b/NEPAL STOCK/gi' | \
	sed 's/\bLOVESTRUCK\b/LOVE STRUCK/gi' | \
	sed 's/\bH D\b/HD/gi' | \
	sed 's/\bBUTTERCREAM\b/BUTTER CREAM/gi' | \
	sed 's/\bLOVEFILM\b/LOVE FILM/gi' | \
	sed 's/\bV W\b/VW/gi' | \
	sed 's/\bD P D\b/DPD/gi' | \
	sed 's/\bX 40 3 A\b/X43A/gi' | \
	sed 's/\bPORN HUB\b/PORNHUB/gi' | \
	sed 's/\bB M W\b/BMW/gi' | \
	sed 's/\bS G\b/SG/gi' | \
	sed 's/\bN W ANIME\b/NWANIME/gi' | \
	sed 's/\bG T A\b/GTA/gi' | \
	##
	## test_clock tc
	##
	sed 's/\bIIN\b/IN/gi' | \
	sed 's/\bBUENOS BIRES\b/BUNEOS ARIES/gi' | \
	sed 's/\bI T\b/IT/gi' | \
	sed 's/\bPHILLIPINES\b/PHILIPPINES/gi' | \
	sed 's/\bCHOCAGO\b/CHICAGO/gi' | \
	##
	## test_notification tc
	##
	sed 's/\bMARGERITA\b/MARGARITA/gi' | \
	sed 's/\bWHATTSAPP\b/WHATSAPP/gi' | \
	##
	## test_qna tc
	##
	sed 's/\bSRILANKA\b/SRI LANKA/gi' | \
	sed 's/\bORGANIZATION\b/ORGANISATION/gi' | \
	sed 's/\b5 S\b/5S/gi' | \
	sed 's/\bRECOMMENED\b/RECOMMENDED/gi' | \
	sed 's/\bFLAVOR\b/FLAVOUR/gi' | \
	sed 's/\bBANGLORE\b/BANGALORE/gi' | \
	sed 's/\b4 G\b/4G/gi' | \
	sed 's/\bS 3\b/S3/gi' | \
	sed 's/\bS 4\b/S4/gi' | \
	sed 's/\bS 5\b/S5/gi' | \
	sed 's/\bS 6\b/S6/gi' | \
	sed 's/\bAUSTRAILIAN\b/AUSTRALIAN/gi' | \
	sed 's/\bKILOMETERS\b/KILOMETRES/gi' | \
	##
	## test_openapp tc
	##
	sed 's/\bTV GUIDE\b/TVGUIDE/gi' | \
	sed 's/\bWATCH ON\b/WATCHON/gi' | \
	sed 's/\bFLASHFLIGHT\b/FLASHLIGHT/gi' | \
	sed 's/\bEUROSPORT\b/EURO SPORT/gi' | \
	sed 's/\bTHERES\b/THERE IS/gi' | \
	##
	## test_music tc
	##
	sed 's/\bFAVORITES\b/FAVOURITES/gi' | \
	sed 's/\bFAVORITE\b/FAVOURITE/gi' | \
	sed 's/\bM M M P 2\b/MMMP2/gi' | \
	sed 's/\bGREEN DAY\b/GREENDAY/gi' | \
	sed 's/\bNINETIES\b/90 S/gi' | \
	##
	## test_weather tc
	##
	sed 's/\bHOPTONONSEA\b/HOPTON ON SEA/gi' | \
	sed 's/\bPUTAPARTY\b/PUTTAPARTHI/gi' | \
	sed 's/\bSOFIAGRAD\b/SOFIA GRAD/gi' | \
	sed 's/\bSTOCKTONONTEASE\b/STOCKON ON TEASE/gi' | \
	sed 's/\bCHRISTMASTIME\b/CHRISTMAS TIME/gi' | \
	sed 's/\bHOWS\b/HOW IS/gi' | \
	sed 's/\bHONG KONG\b/HONGKONG/gi' | \
	sed 's/\bCAPETOWN\b/CAPE TOWN/gi' | \
	sed 's/\bKINGDOME\b/KINGDOM/gi' | \
	sed 's/\bNORTHAMPTON\b/NORTH HAMPTON/gi' | \
	sed 's/\bWHATS\b/WHAT IS/gi' | \
	sed 's/\bBARBADOES\b/BARBADOS/gi' | \
	sed 's/\bWATERLOOVILLE\b/WATERLOO VILLE/gi' | \
	##
	## test_websearch tc
	##
	sed 's/\bN FC\b/NFC/gi' | \
	sed 's/\bN 16\b/N16/gi' | \
	sed 's/\bB T\b/BT/gi' | \
	sed 's/\bSEARH\b/SEARCH/gi' | \
	sed 's/\bSEACH\b/SEARCH/gi' | \
	sed 's/\bSPANK WIRE\b/SPANKWIRE/gi' | \
	sed 's/\bCRIC INFO\b/CRICINFO/gi' | \
	sed 's/\bX FORTY THREE\b/X43/gi' | \
	sed 's/\bI M D B\b/IMDB/gi' | \
	sed 's/\bG T C\b/GTC/gi' | \
	sed 's/\bMOVIE 2 K\b/MOVIE2K/gi' | \
	sed 's/\bB T\b/BT/gi' | \
	sed 's/\b1 0 0 0\b/THOUSAND/gi' | \
	sed 's/\bRIGHT BACKS\b/RIGHTBACKS/gi' | \
	sed 's/\bP C\b/PC/gi' | \
	sed 's/\bP S 3\b/PS3/gi' | \
	sed 's/\bA 3\b/A3/gi' | \
	##
	## test_timer tc
	##
	sed 's/\bSTOP WATCH\b/STOPWATCH/gi' | \
	sed 's/\bCOUNT DOWN\b/COUNTDOWN/gi' | \
	##
	## test_splanner tc
	##
	sed 's/\bSPN\b/ /gi' | \
	sed 's/\bI B M\b/IBM/gi' | \
	sed 's/\bORGANIZE\b/ORGANISE/gi' | \
	sed 's/\bCALENDER\b/CALENDAR/gi' | \
	sed 's/\bENTERIES\b/ENTRIES/gi' | \
	sed 's/\bG T A\b/GTA/gi' | \
	sed 's/\bDINER\b/DINNER/gi' | \
	##
	## test_splanner tc
	##
	sed 's/\bOKAY\b/OK/gi' | \
	sed 's/\bAKBAR\b/AHKBAR/gi' | 
	sed 's/\bDICK HEAD\b/DICKHEAD/gi' | \
	sed 's/\bGOOD NIGHT\b/GOODNIGHT/gi' | \
	sed 's/\bLKE\b/LIKE/gi' | \
	sed 's/\bO 2\b/O2/gi' | \
	sed 's/\bYOURE\b/YOU ARE/gi' | \
	sed 's/\bB B M\b/BBM/gi' | \
	sed 's/\bTEXT K\b/TEXT KAY/gi' | \
	sed 's/\bL O L\b/LOL/gi' | \
	sed 's/\bAVAILABE\b/AVAILABLE/gi' | \
	##
        ## en-GB names tc
        ##
        sed 's/\bMISTER\b/MR/gi' | \
	##
        ## test_onlynumber (call <number>)
	## 
	sed 's/\bDOUBLE 4\b/4 4/gi' | \
	sed 's/\bDOUBLE 7\b/7 7/gi' | \
	sed 's/\bDOUBLE 8\b/8 8/gi' | \
	sed 's/\bDOUBLE 9\b/9 9/gi' | \
	sed 's/\bCALL O2\b/CALL 0 2/gi' | \
	#sed 's/\bO\b/0/gi' | \
	sed 's/\bMrs \b/Missus /gi' | \
	sed 's/\bMr \b/Mister /gi' | \
	sed 's/\bMs \b/Miss /gi' | \
	sed 's/\bDr \b/Doctor /gi' | \
	sed 's/\bCapt \b/Captain /gi' | \
	sed 's/\bProf \b/Professor /gi' | \
        sed 's/\bSgt \b/Sargent /gi' | \
	##
	## gtc1 openapp
	##
	sed 's/\bCHAT ON\b/CHATON/gi' | \
	sed 's/\bDROP BOX\b/DROPBOX/gi' | \
	sed 's/\bG MAIL\b/GMAIL/gi' | \
	sed 's/\bJ F K\b/JFK/gi' | \
	sed 's/\bH T M L\b/HTML/gi' | \
	##
	## end : en-GB TC Specific Changes
	##
        sed 's/apple bees/applebees/gi' | \
	sed 's/s m s/sms/gi' | \
	tr '[:lower:]' '[:upper:]' | \
  sed -r 's/([0-9])([0-9])([0-9])([0-9])([0-9])([0-9])([0-9])([0-9])([0-9])([0-9])\b/\1 \2 \3 \4 \5 \6 \7 \8 \9 \10/g' | \
  sed -r 's/([0-9])([0-9])([0-9])([0-9])([0-9])([0-9])([0-9])([0-9])([0-9])\b/\1 \2 \3 \4 \5 \6 \7 \8 \9/g' | \
  sed -r 's/([0-9])([0-9])([0-9])([0-9])([0-9])([0-9])([0-9])([0-9])\b/\1 \2 \3 \4 \5 \6 \7 \8/g' | \
  sed -r 's/([0-9])([0-9])([0-9])([0-9])([0-9])([0-9])([0-9])\b/\1 \2 \3 \4 \5 \6 \7/g' | \
  sed -r 's/([0-9])([0-9])([0-9])([0-9])([0-9])([0-9])\b/\1 \2 \3 \4 \5 \6 /g' | \
  sed -r 's/([0-9])([0-9])([0-9])([0-9])([0-9])\b/\1 \2 \3 \4 \5 /g' | \
  sed -r 's/([0-9])([0-9])([0-9])([0-9])\b/\1 \2 \3 \4 /g' | \
  sed -r 's/([0-9])([0-9])([0-9])\b/\1 \2 \3 /g' | \
  sed 's#  *# #g' | \
  sed 's# *$##g' |\
  # Q&A
  sed 's/\bq and a\b/qna/gi' | sed 's/\bq n a\b/qna/gi'


