include "cVariables.xs";
int NightmareActive = 0;
int tempModIndex = 0;
int plagueMod = 5;


// <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< If you've seen the RotG vc scripts, I apologize for the mess lmao >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

rule Debug
minInterval 0
maxInterval 0
active
{
    int testVariables = cTechStatusUnobtainable;
    trChatSend(0, "VC works and variables loaded!");
    //trChatSend(0, kbGetTechName(678) ); // Wrath of Ithaqua
    //trChatSend(0, kbGetTechName(679) ); // Wrath of Ithaqua Prime
    //trChatSend(0, kbGetTechName(695) ); // Nightmare Shade
    //trChatSend(0, kbGetTechName(696) ); // Nightmare Beacons Light
    //trChatSend(0, kbGetTechName(710) ); // Yith Exclusion 1
    //trChatSend(0, kbGetTechName(652) ); // Age 1 Yog-Sothoth
    //trChatSend(0, kbGetTechName(653) ); // Age 1 Shub-Niggurath
    //trChatSend(0, kbGetTechName(777) ); // Age 1 Izanami
	//trChatSend(0, kbGetTechName(654) ); // Eldritch Civ
	//trChatSend(0, kbGetTechName(650) ); // Zeus Real
	//trChatSend(0, kbGetTechName(68)  ); // Age 1 Zeus
	//trChatSend(0, kbGetTechName(981)  ); // Age 1 Hanwi Fake
	//trchatsend(0, kbGetTechName(978)  ); // Age 1 Hanwi
	//trchatsend(0, kbGetTechName(1021)  ); // Medicinal Knowledge
	//trchatsend(0, kbGetTechName(1033)  ); // Fushimi Pilgrimage
	//trchatsend(0, kbGetTechName(1096)  ); // God Picked
	//trchatsend(0, kbGetTechName(1145)  ); // Age 2 Apollo




		
    xsDisableSelf();
}



rule MinervaGP
minInterval 0
maxInterval 0
active
{


	for (i=1; < cNumberPlayers)
    {
		xsSetContextPlayer(i);

		if (kbGetTechStatus(1133) == cTechStatusActive) {
			if (kbGetTechStatus(1166) == cTechStatusActive) {
			
				
				
				if (kbGetBuildLimit(i, kbGetProtoUnitID("MinervaGP")) > 0) {
					int techID = 1143 + kbGetBuildLimit(i, kbGetProtoUnitID("MinervaGP"));
					trTechSetStatus(i, techID, cTechStatusActive);
					trTechSetStatus(i, 1166, cTechStatusUnobtainable);
					//trchatsend(0, kbGetTechName(techID)  );
					trModifyProtounit( "MinervaGP", i, 10, (0 - kbGetBuildLimit(i, kbGetProtoUnitID("MinervaGP"))) );
				}

				for (checkID = 1144; <1144 + 9) {

					float perc = kbGetTechPercentComplete(checkID);
					float limit = 0.0;
					if (checkID - 1144 < 3) {
						limit = 0.8;
					} else if (checkID - 1144 < 6) {
						limit = 0.4;
					} else {
						limit = 0.1;
					}

					if (perc > limit && perc < 1.0) {

						int q_id = kbUnitQueryCreate("SettlementsThatTrainVillagers");
						kbUnitQuerySetPlayerID(q_id, i);
						kbUnitQuerySetUnitType(q_id,kbGetProtoUnitID("Settlement Level 1"));
						kbUnitQuerySetState(q_id,2);
						int q_len = kbUnitQueryExecute(q_id);
						for(j=0;<q_len)
						{
							researchCancelByID(checkID, kbUnitQueryGetResult(q_id,j), i);
						}

						trModifyProtounit( "MinervaGP", i, 10, (checkID - 1143 - kbGetBuildLimit(i, kbGetProtoUnitID("MinervaGP"))) );
						//trchatsend(0, kbGetTechName(checkID)  );


						if (checkID - 1144 < 3) {
							trTechSetStatus(i, 1229, cTechStatusActive);
						} else if (checkID - 1144 < 6) {
							trTechSetStatus(i, 1230, cTechStatusActive);
						} else {
							trTechSetStatus(i, 1231, cTechStatusActive);
						}




						break;
						//trTechSetStatus(i, 1145, cTechStatusActive);
					}

				}
				
			} else if  (kbGetTechStatus(1229) == cTechStatusActive) {
				trPlayerGrantResources(i, "Food", -400);
				trTechSetStatus(i, 1229, cTechStatusUnobtainable);
			} else if  (kbGetTechStatus(1230) == cTechStatusActive) {
				trPlayerGrantResources(i, "Food", -800);
				trPlayerGrantResources(i, "Gold", -500);
				trTechSetStatus(i, 1230, cTechStatusUnobtainable);

			} else if  (kbGetTechStatus(1231) == cTechStatusActive) {
				trPlayerGrantResources(i, "Food", -1000);
				trPlayerGrantResources(i, "Gold", -1000);
				trTechSetStatus(i, 1231, cTechStatusUnobtainable);
			}
		}
	}
}

rule AtlanteanAIHack
active
maxInterval 180
minInterval 180
priority 100
{
	for (i=1; < cNumberPlayers)
    {
		xsSetContextPlayer(i);
		if(kbIsPlayerHuman(i))
		{
			
		}
		else 
		{



			if(kbGetTechStatus(965) == cTechStatusActive || kbGetTechStatus(966) == cTechStatusActive || kbGetTechStatus(967) == cTechStatusActive) {
				int q_id2 = kbUnitQueryCreate("Manor");
				kbUnitQuerySetPlayerID(q_id2, i);
				kbUnitQuerySetUnitType(q_id2,kbGetProtoUnitID("Manor"));
				kbUnitQuerySetState(q_id2,2);
				int q_len2 = kbUnitQueryExecute(q_id2);
				for(j2=0;<1) {
					trUnitSelectClear();
					trUnitSelectByID(kbUnitQueryGetResult(q_id2,j2));
					trUnitChangeInArea(i, i, "Manor", "Temple", 1.5);

				}

			}
		}

	}

	xsDisableSelf();

}


rule CultistInTwistedSpire
minInterval 1
maxInterval 1
active
{
    for (i=1; < cNumberPlayers)
    {
        
		xsSetContextPlayer(i);

		if(kbGetTechStatus(654) == cTechStatusActive)
		{

			int q_id = kbUnitQueryCreate("Cultist");
			kbUnitQuerySetPlayerID(q_id, i);
			kbUnitQuerySetUnitType(q_id,kbGetProtoUnitID("Cultist"));
			kbUnitQuerySetState(q_id,2);
			int q_len = kbUnitQueryExecute(q_id);
			for(j=0;<q_len)
			{
				trUnitSelectClear();
				trUnitSelectByID(kbUnitQueryGetResult(q_id,j));

				

				if (trUnitGetIsContained("Twisted Spire")) {
					trUnitChangeProtoUnit("Twisted Spire Skull");
				}
			}

		}
	}
}


rule HuitzilopochtliPower
active
//runImmediately
minInterval 120
maxInterval 120
priority 100
{

	//trChatSend(0, kbGetTechName(873)  ); // Age 1 Huitzilopochtli
	//trEchoStatValue(1, 0); // tribute received
	//trEchoStatValue(1, 1); // tribute sent
	//trEchoStatValue(1, 2); // units killed
	//trEchoStatValue(1, 3); // buildings killed
	//trEchoStatValue(1, 4); // units killed cost
	//trEchoStatValue(1, 5); // buildings killed cost 
	//trEchoStatValue(1, 6); // Units lost
	//trEchoStatValue(1, 7); // buildings lost
	//trEchoStatValue(1, 8); // units lost cost
	//trEchoStatValue(1, 9); // buildings lost cost
	//trEchoStatValue(1, 10); // map explored
	//trEchoStatValue(1, 11); // trade profit

	for (i=1; < cNumberPlayers)
    {
		xsSetContextPlayer(i);
		
		if(kbGetTechStatus(873) == cTechStatusActive) {
			//trEchoStatValue(1, 2); // units killed
			//trEchoStatValue(1, 6); // Units lost
			if (trGetStatValue(i, 2) > trGetStatValue(i, 6)) {
				trTechGodPowerAtPosition(i, "Solar Beam", 1, 1);
			}
		}
	}
}

rule HuitzilopochtliStrength
active
//runImmediately
minInterval 5
maxInterval 5
priority 100
{


	for (i=1; < cNumberPlayers)
    {
		xsSetContextPlayer(i);
		if(kbGetTechStatus(873) == cTechStatusActive) {
			//trChatSend(0, kbGetTechName(1091)  ); // Huitzilopochtli Strength 1
			//trChatSend(0, "" );
			//trEchoStatValue(1, 4); // units killed cost
			//trEchoStatValue(1, 5); // buildings killed cost 
			//trEchoStatValue(1, 8); // units lost cost
			//trEchoStatValue(1, 9); // buildings lost cost

			int kill_cost = trGetStatValue(i, 4) + trGetStatValue(i, 5);
			int lost_cost = trGetStatValue(i, 8) + trGetStatValue(i, 9);


			if (kill_cost > lost_cost) {
				
				if (trTechStatusActive(i, 1091)) {
				} else {
					trTechSetStatus(i, 1091, cTechStatusActive);
				}
				if (kill_cost - 125 > lost_cost * 1.125) {
					
					if (trTechStatusActive(i, 1092)) {
					} else {
						trTechSetStatus(i, 1092, cTechStatusActive);
					}
					if (kill_cost - 250 > lost_cost * 1.25) {
						
						if (trTechStatusActive(i, 1093)) {
						} else {
							trTechSetStatus(i, 1093, cTechStatusActive);
						}
						if (kill_cost - 500 > lost_cost * 1.5) {
							
							if (trTechStatusActive(i, 1094)) {
							} else {
								trTechSetStatus(i, 1094, cTechStatusActive);
							}
							if (kill_cost - 1000 > lost_cost * 2) {
								//trChatSend(0, "Strength level 5");
								if (trTechStatusActive(i, 1095)) {
								} else {
									trTechSetStatus(i, 1095, cTechStatusActive);
								}
							} else {
								trTechSetStatus(i, 1095, cTechStatusUnobtainable);
								//trChatSend(0, "Strength level 4");
							}
						} else {
							trTechSetStatus(i, 1095, cTechStatusUnobtainable);
							trTechSetStatus(i, 1094, cTechStatusUnobtainable);
							//trChatSend(0, "Strength level 3");
						}

					} else {
						trTechSetStatus(i, 1095, cTechStatusUnobtainable);
						trTechSetStatus(i, 1094, cTechStatusUnobtainable);
						trTechSetStatus(i, 1093, cTechStatusUnobtainable);
						//trChatSend(0, "Strength level 2");
					}

				} else {
					trTechSetStatus(i, 1095, cTechStatusUnobtainable);
					trTechSetStatus(i, 1094, cTechStatusUnobtainable);
					trTechSetStatus(i, 1093, cTechStatusUnobtainable);
					trTechSetStatus(i, 1092, cTechStatusUnobtainable);
					//trChatSend(0, "Strength level 1");
				}

			} else {
				trTechSetStatus(i, 1095, cTechStatusUnobtainable);
				trTechSetStatus(i, 1094, cTechStatusUnobtainable);
				trTechSetStatus(i, 1093, cTechStatusUnobtainable);
				trTechSetStatus(i, 1092, cTechStatusUnobtainable);
				trTechSetStatus(i, 1091, cTechStatusUnobtainable);
				//trChatSend(0, "Strength level 0");
			}
		}
	}
}

rule AiPickZeus
inactive
//runImmediately
minInterval 1
maxInterval 1
priority 100
{
	for (i=1; < cNumberPlayers)
    {
		xsSetContextPlayer(i);
		if(kbIsPlayerHuman(i))
		{
			
		}
		else 
		{
			if(kbGetTechStatus(68) == cTechStatusActive) {
				trChatSend(0, "AI set to Zeus");
				trTechSetStatus(i, 650, cTechStatusActive);
			} else if(kbGetTechStatus(83) == cTechStatusActive) {
				trChatSend(0, "AI set to Poseidon");
				trTechSetStatus(i, 860, cTechStatusActive);
			} else if(kbGetTechStatus(82) == cTechStatusActive) {
				trChatSend(0, "AI set to Hades");
				trTechSetStatus(i, 859, cTechStatusActive);
			} else if(kbGetTechStatus(516) == cTechStatusActive) {
				trChatSend(0, "AI set to Fu Xi");
				trTechSetStatus(i, 880, cTechStatusActive);
			} else if(kbGetTechStatus(517) == cTechStatusActive) {
				trChatSend(0, "AI set to Nu Wa");
				trTechSetStatus(i, 881, cTechStatusActive);
			} else if(kbGetTechStatus(518) == cTechStatusActive) {
				trChatSend(0, "AI set to Shennong");
				trTechSetStatus(i, 882, cTechStatusActive);
			} else if(kbGetTechStatus(85) == cTechStatusActive) {
				trChatSend(0, "AI set to Ra");
				trTechSetStatus(i, 968, cTechStatusActive);
			} else if(kbGetTechStatus(86) == cTechStatusActive) {
				trChatSend(0, "AI set to Isis");
				trTechSetStatus(i, 969, cTechStatusActive);
			} else if(kbGetTechStatus(87) == cTechStatusActive) {
				trChatSend(0, "AI set to Set");
				trTechSetStatus(i, 970, cTechStatusActive);
			} else if(kbGetTechStatus(88) == cTechStatusActive) {
				trChatSend(0, "AI set to Odin");
				trTechSetStatus(i, 971, cTechStatusActive);
			} else if(kbGetTechStatus(89) == cTechStatusActive) {
				trChatSend(0, "AI set to Thor");
				trTechSetStatus(i, 972, cTechStatusActive);
			} else if(kbGetTechStatus(90) == cTechStatusActive) {
				trChatSend(0, "AI set to Loki");
				trTechSetStatus(i, 973, cTechStatusActive);
			} else if(kbGetTechStatus(392) == cTechStatusActive) {
				trChatSend(0, "AI set to Kronos");
				trTechSetStatus(i, 974, cTechStatusActive);
			} else if(kbGetTechStatus(393) == cTechStatusActive) {
				trChatSend(0, "AI set to Gaia");
				trTechSetStatus(i, 975, cTechStatusActive);
			} else if(kbGetTechStatus(395) == cTechStatusActive) {
				trChatSend(0, "AI set to Ouranos");
				trTechSetStatus(i, 976, cTechStatusActive);
			}


		}
	}
	xsDisableSelf();
}

rule KillTheMusic
active
runImmediately
minInterval 0
maxInterval 0
priority 100
{
	trMusicStop();
	xsDisableSelf();
}

rule PlayMusic
active
minInterval 75
maxInterval 75
priority 100
{
	trMusicSetCurrentMusicSet();
	trMusicPlayCurrent();
	xsDisableSelf();
}

int allDone = 0;

rule SetGodTest
minInterval 0
maxInterval 0
active
{
	int done = 1;

    for (i=1; < cNumberPlayers)
    {
		xsSetContextPlayer(i);

		//if(kbGetTechStatus(395) == cTechStatusActive) {
		//	trPlayerResetBlackMap(i);
		//}


		if(kbGetTechStatus(1097) == cTechStatusActive) {
			trChatSend(i, "I picked the old god!");


			if(kbGetTechStatus(68) == cTechStatusActive) {
				trTechSetStatus(i, 650, cTechStatusActive);
			} else if(kbGetTechStatus(83) == cTechStatusActive) {
				trTechSetStatus(i, 860, cTechStatusActive);
			} else if(kbGetTechStatus(82) == cTechStatusActive) {
				trTechSetStatus(i, 859, cTechStatusActive);
			} else if(kbGetTechStatus(516) == cTechStatusActive) {
				trTechSetStatus(i, 880, cTechStatusActive);
			} else if(kbGetTechStatus(517) == cTechStatusActive) {
				trTechSetStatus(i, 881, cTechStatusActive);
			} else if(kbGetTechStatus(518) == cTechStatusActive) {
				trTechSetStatus(i, 882, cTechStatusActive);
			} else if(kbGetTechStatus(85) == cTechStatusActive) {
				trTechSetStatus(i, 968, cTechStatusActive);
			} else if(kbGetTechStatus(86) == cTechStatusActive) {
				trTechSetStatus(i, 969, cTechStatusActive);
			} else if(kbGetTechStatus(87) == cTechStatusActive) {
				trTechSetStatus(i, 970, cTechStatusActive);
			} else if(kbGetTechStatus(88) == cTechStatusActive) {
				trTechSetStatus(i, 971, cTechStatusActive);
			} else if(kbGetTechStatus(89) == cTechStatusActive) {
				trTechSetStatus(i, 972, cTechStatusActive);
			} else if(kbGetTechStatus(90) == cTechStatusActive) {
				trTechSetStatus(i, 973, cTechStatusActive);
			} else if(kbGetTechStatus(392) == cTechStatusActive) {
				trTechSetStatus(i, 974, cTechStatusActive);
			} else if(kbGetTechStatus(393) == cTechStatusActive) {
				trTechSetStatus(i, 975, cTechStatusActive);
			} else if(kbGetTechStatus(395) == cTechStatusActive) {
				trTechSetStatus(i, 976, cTechStatusActive);
			}


		} else if(kbGetTechStatus(1098) == cTechStatusActive) {
			trChatSend(i, "I picked azathoth!");
			trTechSetStatus(i, 864, cTechStatusActive);
		} else if(kbGetTechStatus(1099) == cTechStatusActive) {
			trChatSend(i, "I picked yog-sothoth!");
			trTechSetStatus(i, 865, cTechStatusActive);
		} else if(kbGetTechStatus(1100) == cTechStatusActive) {
			trChatSend(i, "I picked shub-niggurath!");
			trTechSetStatus(i, 866, cTechStatusActive);
		} else if(kbGetTechStatus(1104) == cTechStatusActive) {
			trChatSend(i, "I picked izanagi!");
			//trTechSetStatus(i, 867, cTechStatusActive);						// UNCOMMENT WHEN DEVELOPING
		} else if(kbGetTechStatus(1105) == cTechStatusActive) {
			trChatSend(i, "I picked izanami!");
			//trTechSetStatus(i, 868, cTechStatusActive);						// UNCOMMENT WHEN DEVELOPING
		} else if(kbGetTechStatus(1106) == cTechStatusActive) {
			trChatSend(i, "I picked kagu!");
			//trTechSetStatus(i, 869, cTechStatusActive);						// UNCOMMENT WHEN DEVELOPING
		} else if(kbGetTechStatus(1101) == cTechStatusActive) {
			trChatSend(i, "I picked tezcat!");
			trSetCivAndCulture(i, 14, 4);
			trTechSetStatus(i, 874, cTechStatusActive);
			trTechSetStatus(i, 1101, cTechStatusActive);
			
			trPlayerKillAllGodPowers(i);
		} else if(kbGetTechStatus(1102) == cTechStatusActive) {
			trChatSend(i, "I picked	quetzal!");
			trSetCivAndCulture(i, 14, 4);
			trTechSetStatus(i, 875, cTechStatusActive);
			trTechSetStatus(i, 1102, cTechStatusActive);
			trPlayerKillAllGodPowers(i);
		} else if(kbGetTechStatus(1103) == cTechStatusActive) {
			trChatSend(i, "I picked huitzil!");
			trSetCivAndCulture(i, 14, 4);
			trTechSetStatus(i, 876, cTechStatusActive);
			trTechSetStatus(i, 1103, cTechStatusActive);
			trPlayerKillAllGodPowers(i);
		} else if(kbGetTechStatus(1107) == cTechStatusActive) {
			trChatSend(i, "I picked khaos!");
		} else if(kbGetTechStatus(1108) == cTechStatusActive) {
			trChatSend(i, "I picked chronos!");
		} else if(kbGetTechStatus(1109) == cTechStatusActive) {
			trChatSend(i, "I picked ananke!");
		} else if(kbGetTechStatus(1110) == cTechStatusActive) {
			trChatSend(i, "I picked nyx!");
		} else if(kbGetTechStatus(1111) == cTechStatusActive) {
			trChatSend(i, "I picked tartarus!");
		} else if(kbGetTechStatus(1112) == cTechStatusActive) {
			trChatSend(i, "I picked erebus!");
		}else if(kbGetTechStatus(1113) == cTechStatusActive) {
			trChatSend(i, "I picked jupiter!");
			trSetCivAndCulture(i, 14, 0);
			trTechSetStatus(i, 1128, cTechStatusActive);
			trTechSetStatus(i, 1113, cTechStatusActive);
			trPlayerKillAllGodPowers(i);
		}else if(kbGetTechStatus(1114) == cTechStatusActive) {
			trChatSend(i, "I picked juno!");
			trSetCivAndCulture(i, 14, 0);
			trTechSetStatus(i, 1129, cTechStatusActive);
			trTechSetStatus(i, 1114, cTechStatusActive);
			trPlayerKillAllGodPowers(i);
		}else if(kbGetTechStatus(1115) == cTechStatusActive) {
			trChatSend(i, "I picked minerva!");
			trSetCivAndCulture(i, 14, 0);
			trTechSetStatus(i, 1130, cTechStatusActive);
			trTechSetStatus(i, 1115, cTechStatusActive);
			trPlayerKillAllGodPowers(i);
		}else if(kbGetTechStatus(1116) == cTechStatusActive) {
			trChatSend(i, "I picked Ymir!");
		}else if(kbGetTechStatus(1117) == cTechStatusActive) {
			trChatSend(i, "I picked surtr!");
		}else if(kbGetTechStatus(1118) == cTechStatusActive) {
			trChatSend(i, "I picked aegir!");
		}else if(kbGetTechStatus(1119) == cTechStatusActive) {
			trChatSend(i, "I picked hanwi!");
			//trTechSetStatus(i, 981, cTechStatusActive);						// UNCOMMENT WHEN DEVELOPING
		}else if(kbGetTechStatus(1120) == cTechStatusActive) {
			trChatSend(i, "I picked unci makha!");
			//trTechSetStatus(i, 982, cTechStatusActive);						// UNCOMMENT WHEN DEVELOPING
		}else if(kbGetTechStatus(1121) == cTechStatusActive) {
			trChatSend(i, "I picked Anpetu Wi!");
			//trTechSetStatus(i, 983, cTechStatusActive);						// UNCOMMENT WHEN DEVELOPING
		}else if(kbGetTechStatus(1122) == cTechStatusActive) {
			trChatSend(i, "I picked the dagda!");
		}else if(kbGetTechStatus(1123) == cTechStatusActive) {
			trChatSend(i, "I picked lugh!");
		}else if(kbGetTechStatus(1124) == cTechStatusActive) {
			trChatSend(i, "I picked morrigan!");
		}else if(kbGetTechStatus(1125) == cTechStatusActive) {
			trChatSend(i, "I picked enlil!");
		}else if(kbGetTechStatus(1126) == cTechStatusActive) {
			trChatSend(i, "I picked inanna!");
		}else if(kbGetTechStatus(1127) == cTechStatusActive) {
			trChatSend(i, "I picked marduk!");
		} else {
			done = 0;
		}
	}






	if (done == 1) {
		trChatSend(0, "Everyone's done!");
		allDone = 1;
		xsDisableSelf();
	}

}

rule GodSwapTest
active
//runImmediately
minInterval 0
maxInterval 0
priority 100
{
	if (allDone == 1) {
	
		for (i=1; < cNumberPlayers)
		{

			xsSetContextPlayer(i);
			if (kbGetTechStatus(860) == cTechStatusActive) { // poseidon
				//trSetCivAndCulture(i, 1, 0);

				trPlayerKillAllGodPowers(i);

				trTechSetStatus(i, 863, cTechStatusActive);
				trSetCivilizationNameOverride(i, "Poseidon");
			} else if (kbGetTechStatus(859) == cTechStatusActive) { // hades
				//trSetCivAndCulture(i, 2, 0);
				trPlayerKillAllGodPowers(i);
				trTechSetStatus(i, 862, cTechStatusActive);
				trSetCivilizationNameOverride(i, "Hades");
			} else if (kbGetTechStatus(650) == cTechStatusActive) { // zeus
				//trSetCivAndCulture(i, 0, 0);
				trPlayerKillAllGodPowers(i);
				trTechSetStatus(i, 861, cTechStatusActive);
				trSetCivilizationNameOverride(i, "Zeus");
			} else if (kbGetTechStatus(864) == cTechStatusActive) { // azathoth
				//trSetCivAndCulture(i, 0, 0);
				trPlayerKillAllGodPowers(i);
				trTechSetStatus(i, 651, cTechStatusActive);
				trSetCivilizationNameOverride(i, "Azathoth");
			} else if (kbGetTechStatus(866) == cTechStatusActive) { // shub-niggurath
				//trSetCivAndCulture(i, 0, 0);
				trPlayerKillAllGodPowers(i);
				trTechSetStatus(i, 653, cTechStatusActive);
				trSetCivilizationNameOverride(i, "Shub-Niggurath");
			} else if (kbGetTechStatus(865) == cTechStatusActive) { // yog-sothoth
				//trSetCivAndCulture(i, 0, 0);
				trPlayerKillAllGodPowers(i);
				trTechSetStatus(i, 652, cTechStatusActive);
				trSetCivilizationNameOverride(i, "Yog-Sothoth");
			} else if (kbGetTechStatus(867) == cTechStatusActive) { // izanagi
				//trSetCivAndCulture(i, 0, 0);
				trPlayerKillAllGodPowers(i);
				trTechSetStatus(i, 776, cTechStatusActive);
				trSetCivilizationNameOverride(i, "Izanagi");
			} else if (kbGetTechStatus(868) == cTechStatusActive) { // izanami
				//trSetCivAndCulture(i, 0, 0);
				trPlayerKillAllGodPowers(i);
				trTechSetStatus(i, 777, cTechStatusActive);
				trSetCivilizationNameOverride(i, "Izanami");
			} else if (kbGetTechStatus(869) == cTechStatusActive) { // kagu-tsuchi
				//trSetCivAndCulture(i, 0, 0);
				trPlayerKillAllGodPowers(i);
				trTechSetStatus(i, 778, cTechStatusActive);
				trSetCivilizationNameOverride(i, "Kagu-Tsuchi");
			} else if (kbGetTechStatus(880) == cTechStatusActive) { // fu xi
				//trSetCivAndCulture(i, 12, 4);
				trPlayerKillAllGodPowers(i);
				trTechSetStatus(i, 877, cTechStatusActive);
				trSetCivilizationNameOverride(i, "Fu Xi");
			} else if (kbGetTechStatus(881) == cTechStatusActive) { // nu wa
				//trSetCivAndCulture(i, 13, 4);
				trPlayerKillAllGodPowers(i);
				trTechSetStatus(i, 878, cTechStatusActive);
				trSetCivilizationNameOverride(i, "Nu Wa");
			} else if (kbGetTechStatus(882) == cTechStatusActive) { // shennong
				//trSetCivAndCulture(i, 14, 4);
				trPlayerKillAllGodPowers(i);
				trTechSetStatus(i, 879, cTechStatusActive);
				trSetCivilizationNameOverride(i, "Shennong");
			} else if (kbGetTechStatus(874) == cTechStatusActive) { // Tezcatlipoca
				trPlayerKillAllGodPowers(i);
				trTechSetStatus(i, 871, cTechStatusActive);
				trSetCivilizationNameOverride(i, "Tezcatlipoca");
			} else if (kbGetTechStatus(875) == cTechStatusActive) { // Quetzalcoatl
				trPlayerKillAllGodPowers(i);
				trTechSetStatus(i, 872, cTechStatusActive);
				trSetCivilizationNameOverride(i, "Quetzalcoatl");
			} else if (kbGetTechStatus(876) == cTechStatusActive) { // Huitzilopochtli
				trPlayerKillAllGodPowers(i);
				trTechSetStatus(i, 873, cTechStatusActive);
				trSetCivilizationNameOverride(i, "Huitzilopochtli");
			}  else if (kbGetTechStatus(968) == cTechStatusActive) { // Ra
				//trSetCivAndCulture(i, 4, 1);
				trPlayerKillAllGodPowers(i);
				trTechSetStatus(i, 959, cTechStatusActive);
				trSetCivilizationNameOverride(i, "Ra");
			} else if (kbGetTechStatus(969) == cTechStatusActive) { // Isis
				//trSetCivAndCulture(i, 3, 1);
				trPlayerKillAllGodPowers(i);
				trTechSetStatus(i, 960, cTechStatusActive);
				trSetCivilizationNameOverride(i, "Isis");
			} else if (kbGetTechStatus(970) == cTechStatusActive) { // Set
				//trSetCivAndCulture(i, 5, 1);
				trPlayerKillAllGodPowers(i);
				trTechSetStatus(i, 961, cTechStatusActive);
				trSetCivilizationNameOverride(i, "Set");
			}  else if (kbGetTechStatus(972) == cTechStatusActive) { // Thor
				//trSetCivAndCulture(i, 7, 2);
				trPlayerKillAllGodPowers(i);
				trTechSetStatus(i, 963, cTechStatusActive);
				trSetCivilizationNameOverride(i, "Thor");
			} else if (kbGetTechStatus(971) == cTechStatusActive) { // Odin
				//trSetCivAndCulture(i, 6, 2);
				trPlayerKillAllGodPowers(i);
				trTechSetStatus(i, 962, cTechStatusActive);
				trSetCivilizationNameOverride(i, "Odin");
			} else if (kbGetTechStatus(973) == cTechStatusActive) { // Loki
				//trSetCivAndCulture(i, 8, 2);
				trPlayerKillAllGodPowers(i);
				trTechSetStatus(i, 964, cTechStatusActive);
				trSetCivilizationNameOverride(i, "Loki");
			}  else if (kbGetTechStatus(974) == cTechStatusActive) { // Kronos
				//trSetCivAndCulture(i, 9, 3);
				trPlayerKillAllGodPowers(i);
				trTechSetStatus(i, 965, cTechStatusActive);
				trSetCivilizationNameOverride(i, "Kronos");
			} else if (kbGetTechStatus(976) == cTechStatusActive) { // Ouranos
				//trSetCivAndCulture(i, 10, 3);
				trPlayerKillAllGodPowers(i);
				trTechSetStatus(i, 967, cTechStatusActive);
				trSetCivilizationNameOverride(i, "Ouranos");

				//xsSetContextPlayer(0);
				//int q_id = kbUnitQueryCreate("Settlement");
				//kbUnitQuerySetPlayerID(q_id, 0);
				//kbUnitQuerySetUnitType(q_id,kbGetProtoUnitID("Settlement"));
				//kbUnitQuerySetState(q_id,2);
				//int q_len = kbUnitQueryExecute(q_id);
				//for(j=0;<q_len)
				//{
				//	trUnitSelectClear();
				//	trUnitSelectByID(kbUnitQueryGetResult(q_id,j));
				//	trUnitChangeInArea(0, i, "Settlement", "Ouranos Settlement Hack", 7.5);
				//}

				//xsSetContextPlayer(i);
				//q_id = kbUnitQueryCreate("Ouranos Settlement Hack");
				//kbUnitQuerySetPlayerID(q_id, i);
				//kbUnitQuerySetUnitType(q_id,kbGetProtoUnitID("Ouranos Settlement Hack"));
				//kbUnitQuerySetState(q_id,2);
				//q_len = kbUnitQueryExecute(q_id);
				//for(j=0;<q_len)
				//{
				//	trUnitSelectClear();
				//	trUnitSelectByID(kbUnitQueryGetResult(q_id,j));

				//	trUnitChangeInArea(i, 0, "Ouranos Settlement Hack", "Settlement", 7.5);
				//}




			} else if (kbGetTechStatus(975) == cTechStatusActive) { // Gaia
				//trSetCivAndCulture(i, 11, 3);
				trPlayerKillAllGodPowers(i);
				trTechSetStatus(i, 966, cTechStatusActive);
				trSetCivilizationNameOverride(i, "Gaia");
				trGenerateLush();
			} else if (kbGetTechStatus(981) == cTechStatusActive) { // Hanwi
				//trSetCivAndCulture(i, 10, 3);
				trPlayerKillAllGodPowers(i);
				trTechSetStatus(i, 978, cTechStatusActive);
				trSetCivilizationNameOverride(i, "Hanwi");
			} else if (kbGetTechStatus(982) == cTechStatusActive) { // Unci Makha
				//trSetCivAndCulture(i, 10, 3);
				trPlayerKillAllGodPowers(i);
				trTechSetStatus(i, 979, cTechStatusActive);
				trSetCivilizationNameOverride(i, "Unci Makha");
			} else if (kbGetTechStatus(983) == cTechStatusActive) { // Anpao
				//trSetCivAndCulture(i, 10, 3);
				trPlayerKillAllGodPowers(i);
				trTechSetStatus(i, 980, cTechStatusActive);
				trSetCivilizationNameOverride(i, "Anpetu Wi");
			} else if (kbGetTechStatus(1128) == cTechStatusActive) { // Jupiter
				trPlayerKillAllGodPowers(i);
				trTechSetStatus(i, 1131, cTechStatusActive);
				trSetCivilizationNameOverride(i, "Jupiter");
			} else if (kbGetTechStatus(1129) == cTechStatusActive) { // Juno
				trPlayerKillAllGodPowers(i);
				trTechSetStatus(i, 1132, cTechStatusActive);
				trSetCivilizationNameOverride(i, "Juno");
			} else if (kbGetTechStatus(1130) == cTechStatusActive) { // Minerva
				trPlayerKillAllGodPowers(i);
				trTechSetStatus(i, 1133, cTechStatusActive);
				trSetCivilizationNameOverride(i, "Minerva");
			}   else {													// Nothing selected
				trChatSend(i, "This god was unimplemented -- I am playing as Zeus.");
				//trSetCivAndCulture(i, 0, 0);
				trPlayerKillAllGodPowers(i);
				trTechSetStatus(i, 861, cTechStatusActive);
				trSetCivilizationNameOverride(i, "Zeus");
			}
			
		
		}
		xsDisableSelf();
	}
}


rule Migrate
minInterval 1
maxInterval 1
active
{
	for (i=1; < cNumberPlayers) {

		xsSetContextPlayer(i);	

		if(kbGetTechStatus(984) == cTechStatusActive) { // Lakota Civ

			// this is inefficient, change later -- maybe use Nate's arrays?


			int q_id = kbUnitQueryCreate("Settlement Level 1");
			kbUnitQuerySetPlayerID(q_id, i);
			kbUnitQuerySetUnitType(q_id,kbGetProtoUnitID("Settlement Level 1"));
			kbUnitQuerySetState(q_id,2);
			int q_len = kbUnitQueryExecute(q_id);

			
			if(kbGetTechStatus(1004) == cTechStatusActive) { // Migration Trigger Age 2
				if(kbGetTechStatus(1005) != cTechStatusActive) { // Migration Flag Age 2
					trChatSend(0, "Migration Flag Found 2" );
					for(j=0;<q_len) {
						trUnitSelectClear();
						trUnitSelectByID(kbUnitQueryGetResult(q_id,j));
						trUnitChangeInArea(i, i, "Settlement Level 1", "Dead Town Center", 7.5);
						trChatSend(0, "TC Killed 2" );
					}
					trTechSetStatus(i, 1005, cTechStatusActive);
				} else if(kbGetTechStatus(1006) != cTechStatusActive) { // Migration Not Done Age 2
					trChatSend(0, "Searching for TC" );
					if (0 < q_len) {
						trTechSetStatus(i, 1006, cTechStatusActive);
						trTechSetStatus(i, 1007, cTechStatusActive);
						trChatSend(0, "TC Found 2" );
					}
				}
			}

			if(kbGetTechStatus(1008) == cTechStatusActive) { // Migration Trigger Age 3
				if(kbGetTechStatus(1009) != cTechStatusActive) { // Migration Flag Age 3
					trChatSend(0, "Migration Flag Found 3" );
					for(j=0;<q_len) {
						trUnitSelectClear();
						trUnitSelectByID(kbUnitQueryGetResult(q_id,j));
						trUnitChangeInArea(i, i, "Settlement Level 1", "Dead Town Center", 7.5);
						trChatSend(0, "TC Killed 3" );
					}
					trTechSetStatus(i, 1009, cTechStatusActive);
				} else if(kbGetTechStatus(1010) != cTechStatusActive) { // Migration Not Done Age 2
					trChatSend(0, "Searching for TC" );
					if (0 < q_len) {
						trTechSetStatus(i, 1010, cTechStatusActive);
						trTechSetStatus(i, 1011, cTechStatusActive);
						trChatSend(0, "TC Found 3" );
					}
				}
			}


			if(kbGetTechStatus(1012) == cTechStatusActive) { // Migration Trigger Age 4
				if(kbGetTechStatus(1013) != cTechStatusActive) { // Migration Flag Age 4
					trChatSend(0, "Migration Flag Found 4" );
					for(j=0;<q_len) {
						trUnitSelectClear();
						trUnitSelectByID(kbUnitQueryGetResult(q_id,j));
						trUnitChangeInArea(i, i, "Settlement Level 1", "Dead Town Center", 7.5);
						trChatSend(0, "TC Killed 4" );
					}
					trTechSetStatus(i, 1013, cTechStatusActive);
				} else if(kbGetTechStatus(1014) != cTechStatusActive) { // Migration Not Done Age 4
					trChatSend(0, "Searching for TC" );
					if (0 < q_len) {
						trTechSetStatus(i, 1014, cTechStatusActive);
						trTechSetStatus(i, 1015, cTechStatusActive);
						trChatSend(0, "TC Found 4" );
					}
				}
			}

		}
	}


}



rule HealJap
minInterval 1
maxInterval 1
active
{

    //Iterate over the players, we start at 1 as gaia should
    // not be checked (she's always popcapped anyways)
    for (i=1; < cNumberPlayers)
    {
        xsSetContextPlayer(i);

		
		
		
	if(kbGetTechStatus(775) == cTechStatusActive)
	{

			if(kbGetTechStatus(1043) == cTechStatusActive) {
				if(trPlayerResourceCount(i, "Favor") >= 50) {
					if (kbGetTechStatus(1044) != cTechStatusActive) {
						trTechSetStatus(i, 1044, cTechStatusActive);
					}
				} else {
					trTechSetStatus(i, 1044, cTechStatusUnobtainable);
				}
			}



			int q_id2 = kbUnitQueryCreate("Healing Palace");
			kbUnitQuerySetPlayerID(q_id2, i);
			kbUnitQuerySetUnitType(q_id2,kbGetProtoUnitID("jhgkjhgkjhgkjhg"));
			kbUnitQuerySetState(q_id2,2);
			int q_len2 = kbUnitQueryExecute(q_id2);
			for(j2=0;<q_len2) {
					trUnitSelectClear();
					trUnitSelectByID(kbUnitQueryGetResult(q_id2,j2));
					if (trUnitGetIsContained("Healing Palace")) {
						trUnitSetHP(kbUnitGetCurrentHitpoints(kbUnitQueryGetResult(q_id2,j2)) + 2 + kbUnitGetMaximumHitpoints(kbUnitQueryGetResult(q_id2,j2)) * 0.01 );
					}
					if (kbGetTechStatus(1038) == cTechStatusActive && trUnitGetIsContained("SettlementsThatTrainVillagers")) {
						trUnitSetHP(kbUnitGetCurrentHitpoints(kbUnitQueryGetResult(q_id2,j2)) + 2 + kbUnitGetMaximumHitpoints(kbUnitQueryGetResult(q_id2,j2)) * 0.01 );
					}



					if(kbGetTechStatus(1022) == cTechStatusActive)
					{
						
								if (trUnitGetIsContained("Healing Palace")) {
									trUnitSetHP(kbUnitGetCurrentHitpoints(kbUnitQueryGetResult(q_id2,j2)) + kbUnitGetMaximumHitpoints(kbUnitQueryGetResult(q_id2,j2)) * 0.01 );
								}
								if (kbGetTechStatus(1038) == cTechStatusActive && trUnitGetIsContained("SettlementsThatTrainVillagers")) {
									trUnitSetHP(kbUnitGetCurrentHitpoints(kbUnitQueryGetResult(q_id2,j2)) + kbUnitGetMaximumHitpoints(kbUnitQueryGetResult(q_id2,j2)) * 0.01 );
								}
						
					}

					if(kbGetTechStatus(802) == cTechStatusActive)
					{
						
								if (trUnitGetIsContained("Healing Palace")) {
									trUnitSetHP(kbUnitGetCurrentHitpoints(kbUnitQueryGetResult(q_id2,j2)) + kbUnitGetMaximumHitpoints(kbUnitQueryGetResult(q_id2,j2)) * 0.01 );
								}
								if (kbGetTechStatus(1038) == cTechStatusActive && trUnitGetIsContained("SettlementsThatTrainVillagers")) {
									trUnitSetHP(kbUnitGetCurrentHitpoints(kbUnitQueryGetResult(q_id2,j2)) + kbUnitGetMaximumHitpoints(kbUnitQueryGetResult(q_id2,j2)) * 0.01 );
								}
				
						
					}
				
			}

			if(kbGetTechStatus(1021) == cTechStatusActive)
			{
				q_id2 = kbUnitQueryCreate("Healing Palace Medicinal 1");
				kbUnitQuerySetPlayerID(q_id2, i);
				kbUnitQuerySetUnitType(q_id2,kbGetProtoUnitID("Villager Japanese"));
				kbUnitQuerySetState(q_id2,2);
				q_len2 = kbUnitQueryExecute(q_id2);
				for(j2=0;<q_len2) {
						trUnitSelectClear();
						trUnitSelectByID(kbUnitQueryGetResult(q_id2,j2));
						if (trUnitGetIsContained("Healing Palace")) {
							trUnitSetHP(kbUnitGetCurrentHitpoints(kbUnitQueryGetResult(q_id2,j2)) + 2 );
						}
						if (kbGetTechStatus(1038) == cTechStatusActive && trUnitGetIsContained("SettlementsThatTrainVillagers")) {
							trUnitSetHP(kbUnitGetCurrentHitpoints(kbUnitQueryGetResult(q_id2,j2)) + 2 );
						}
					
				}
				q_id2 = kbUnitQueryCreate("Healing Palace Medicinal 2");
				kbUnitQuerySetPlayerID(q_id2, i);
				kbUnitQuerySetUnitType(q_id2,kbGetProtoUnitID("Villager Japanese Skilled"));
				kbUnitQuerySetState(q_id2,2);
				q_len2 = kbUnitQueryExecute(q_id2);
				for(j2=0;<q_len2) {
						trUnitSelectClear();
						trUnitSelectByID(kbUnitQueryGetResult(q_id2,j2));
						if (trUnitGetIsContained("Healing Palace")) {
							trUnitSetHP(kbUnitGetCurrentHitpoints(kbUnitQueryGetResult(q_id2,j2)) + 2 );
						}
						if (kbGetTechStatus(1038) == cTechStatusActive && trUnitGetIsContained("SettlementsThatTrainVillagers")) {
							trUnitSetHP(kbUnitGetCurrentHitpoints(kbUnitQueryGetResult(q_id2,j2)) + 2 );
						}
					
				}
			}

			




			
			q_id2 = kbUnitQueryCreate("DivineIntervention");
			kbUnitQuerySetPlayerID(q_id2, i);
			kbUnitQuerySetUnitType(q_id2,kbGetProtoUnitID("DivineIntervention"));
			kbUnitQuerySetState(q_id2,2);
			q_len2 = kbUnitQueryExecute(q_id2);
				for(j2=0;<q_len2)
			{
				trUnitSelectClear();
				trUnitSelectByID(kbUnitQueryGetResult(q_id2,j2));

				vector center = kbUnitGetPosition(kbUnitQueryGetResult(q_id2,j2));
				int center_id = kbUnitQueryGetResult(q_id2,j2);


				trTechGodPowerAtPosition(i, kbGetTechName(aiGetGodPowerTechIDForSlot(1)), 1, 1);
				trTechGodPowerAtPosition(i, kbGetTechName(aiGetGodPowerTechIDForSlot(2)), 1, 1);
				trTechGodPowerAtPosition(i, kbGetTechName(aiGetGodPowerTechIDForSlot(3)), 1, 1);

		
		
				trUnitDelete(false);
			}


			q_id2 = kbUnitQueryCreate("Invoker of Golden Hour");
			kbUnitQuerySetPlayerID(q_id2, i);
			kbUnitQuerySetUnitType(q_id2,kbGetProtoUnitID("Invoker of Golden Hour"));
			kbUnitQuerySetState(q_id2,2);
			q_len2 = kbUnitQueryExecute(q_id2);
				for(j2=0;<q_len2)
			{
				trUnitSelectClear();
				trUnitSelectByID(kbUnitQueryGetResult(q_id2,j2));

				trTechGodPowerAtPosition(i, "Golden Hour", 1, 1);
				trUnitDelete(false);
			}



			int gakko_id = -1;

			q_id2 = kbUnitQueryCreate("Gakko");
			kbUnitQuerySetPlayerID(q_id2, i);
			kbUnitQuerySetUnitType(q_id2,kbGetProtoUnitID("Gakko"));
			kbUnitQuerySetState(q_id2,2);
			q_len2 = kbUnitQueryExecute(q_id2);
			if(0<q_len2)
			{
				gakko_id = kbUnitQueryGetResult(q_id2,0);
			}


			q_id2 = kbUnitQueryCreate("Skilled Serf Lesson");
			kbUnitQuerySetPlayerID(q_id2, i);
			kbUnitQuerySetUnitType(q_id2,kbGetProtoUnitID("Skilled Serf Lesson"));
			kbUnitQuerySetState(q_id2,2);
			q_len2 = kbUnitQueryExecute(q_id2);
			for(j2=0;<q_len2) {
				trUnitSelectClear();
				int gakko_success = 0;
				int q_id = kbUnitQueryCreate("Villager Japanese");
				kbUnitQuerySetPlayerID(q_id, i);
				kbUnitQuerySetUnitType(q_id,kbGetProtoUnitID("Villager Japanese"));
				kbUnitQuerySetState(q_id,2);
				int q_len = kbUnitQueryExecute(q_id);
				if (q_len > 0 && gakko_id > -1) {
					for (j=0;<q_len) {
						trUnitSelectClear();
						trUnitSelectByID(kbUnitQueryGetResult(q_id,j));
						if (trUnitGetIsContained("Gakko")) {
							trUnitChangeProtoUnit("Arrow");
							gakko_success = 1;
							break;
				}	}	}
				trUnitSelectClear();
				trUnitSelectByID(kbUnitQueryGetResult(q_id2,j2));
				if (gakko_success == 1) {
					trUnitChangeProtoUnit("Villager Japanese Skilled");
				} else {
					trUnitDelete(false);
			}	}

			q_id2 = kbUnitQueryCreate("Otsuchiman Lesson");
			kbUnitQuerySetPlayerID(q_id2, i);
			kbUnitQuerySetUnitType(q_id2,kbGetProtoUnitID("Otsuchiman Lesson"));
			kbUnitQuerySetState(q_id2,2);
			q_len2 = kbUnitQueryExecute(q_id2);
			for(j2=0;<q_len2) {
				trUnitSelectClear();
				gakko_success = 0;
				q_id = kbUnitQueryCreate("Villager Japanese");
				kbUnitQuerySetPlayerID(q_id, i);
				kbUnitQuerySetUnitType(q_id,kbGetProtoUnitID("Villager Japanese"));
				kbUnitQuerySetState(q_id,2);
				q_len = kbUnitQueryExecute(q_id);
				if (q_len > 0 && gakko_id > -1) {
					for (j=0;<q_len) {
						trUnitSelectClear();
						trUnitSelectByID(kbUnitQueryGetResult(q_id,j));
						if (trUnitGetIsContained("Gakko")) {
							trUnitChangeProtoUnit("Arrow");
							gakko_success = 1;
							break;
				}	}	}
				trUnitSelectClear();
				trUnitSelectByID(kbUnitQueryGetResult(q_id2,j2));
				if (gakko_success == 1) {
					trUnitChangeProtoUnit("Ashigaru Otsuchiman");
				} else {
					trUnitDelete(false);
			}	}

			q_id2 = kbUnitQueryCreate("Pikeman Lesson");
			kbUnitQuerySetPlayerID(q_id2, i);
			kbUnitQuerySetUnitType(q_id2,kbGetProtoUnitID("Pikeman Lesson"));
			kbUnitQuerySetState(q_id2,2);
			q_len2 = kbUnitQueryExecute(q_id2);
			for(j2=0;<q_len2) {
				trUnitSelectClear();
				gakko_success = 0;
				q_id = kbUnitQueryCreate("Villager Japanese");
				kbUnitQuerySetPlayerID(q_id, i);
				kbUnitQuerySetUnitType(q_id,kbGetProtoUnitID("Villager Japanese"));
				kbUnitQuerySetState(q_id,2);
				q_len = kbUnitQueryExecute(q_id);
				if (q_len > 0 && gakko_id > -1) {
					for (j=0;<q_len) {
						trUnitSelectClear();
						trUnitSelectByID(kbUnitQueryGetResult(q_id,j));
						if (trUnitGetIsContained("Gakko")) {
							trUnitChangeProtoUnit("Arrow");
							gakko_success = 1;
							break;
				}	}	}
				trUnitSelectClear();
				trUnitSelectByID(kbUnitQueryGetResult(q_id2,j2));
				if (gakko_success == 1) {
					trUnitChangeProtoUnit("Ashigaru Pikeman");
				} else {
					trUnitDelete(false);
			}	}

			q_id2 = kbUnitQueryCreate("Archer Lesson");
			kbUnitQuerySetPlayerID(q_id2, i);
			kbUnitQuerySetUnitType(q_id2,kbGetProtoUnitID("Archer Lesson"));
			kbUnitQuerySetState(q_id2,2);
			q_len2 = kbUnitQueryExecute(q_id2);
			for(j2=0;<q_len2) {
				trUnitSelectClear();
				gakko_success = 0;
				q_id = kbUnitQueryCreate("Villager Japanese");
				kbUnitQuerySetPlayerID(q_id, i);
				kbUnitQuerySetUnitType(q_id,kbGetProtoUnitID("Villager Japanese"));
				kbUnitQuerySetState(q_id,2);
				q_len = kbUnitQueryExecute(q_id);
				if (q_len > 0 && gakko_id > -1) {
					for (j=0;<q_len) {
						trUnitSelectClear();
						trUnitSelectByID(kbUnitQueryGetResult(q_id,j));
						if (trUnitGetIsContained("Gakko")) {
							trUnitChangeProtoUnit("Arrow");
							gakko_success = 1;
							break;
				}	}	}
				trUnitSelectClear();
				trUnitSelectByID(kbUnitQueryGetResult(q_id2,j2));
				if (gakko_success == 1) {
					trUnitChangeProtoUnit("Ashigaru Archer");
				} else {
					trUnitDelete(false);
			}	}

			q_id2 = kbUnitQueryCreate("Hata-Gumi Lesson");
			kbUnitQuerySetPlayerID(q_id2, i);
			kbUnitQuerySetUnitType(q_id2,kbGetProtoUnitID("Hata-Gumi Lesson"));
			kbUnitQuerySetState(q_id2,2);
			q_len2 = kbUnitQueryExecute(q_id2);
			for(j2=0;<q_len2) {
				trUnitSelectClear();
				gakko_success = 0;
				q_id = kbUnitQueryCreate("Villager Japanese");
				kbUnitQuerySetPlayerID(q_id, i);
				kbUnitQuerySetUnitType(q_id,kbGetProtoUnitID("Villager Japanese"));
				kbUnitQuerySetState(q_id,2);
				q_len = kbUnitQueryExecute(q_id);
				if (q_len > 0 && gakko_id > -1) {
					for (j=0;<q_len) {
						trUnitSelectClear();
						trUnitSelectByID(kbUnitQueryGetResult(q_id,j));
						if (trUnitGetIsContained("Gakko")) {
							trUnitChangeProtoUnit("Arrow");
							gakko_success = 1;
							break;
				}	}	}
				trUnitSelectClear();
				trUnitSelectByID(kbUnitQueryGetResult(q_id2,j2));
				if (gakko_success == 1) {
					trUnitChangeProtoUnit("Hata-Gumi");
				} else {
					trUnitDelete(false);
			}	}

			q_id2 = kbUnitQueryCreate("Kajutsu Lesson");
			kbUnitQuerySetPlayerID(q_id2, i);
			kbUnitQuerySetUnitType(q_id2,kbGetProtoUnitID("Kajutsu Lesson"));
			kbUnitQuerySetState(q_id2,2);
			q_len2 = kbUnitQueryExecute(q_id2);
			for(j2=0;<q_len2) {
				trUnitSelectClear();
				gakko_success = 0;
				q_id = kbUnitQueryCreate("Villager Japanese");
				kbUnitQuerySetPlayerID(q_id, i);
				kbUnitQuerySetUnitType(q_id,kbGetProtoUnitID("Villager Japanese"));
				kbUnitQuerySetState(q_id,2);
				q_len = kbUnitQueryExecute(q_id);
				if (q_len > 0 && gakko_id > -1) {
					for (j=0;<q_len) {
						trUnitSelectClear();
						trUnitSelectByID(kbUnitQueryGetResult(q_id,j));
						if (trUnitGetIsContained("Gakko")) {
							trUnitChangeProtoUnit("Arrow");
							gakko_success = 1;
							break;
				}	}	}
				trUnitSelectClear();
				trUnitSelectByID(kbUnitQueryGetResult(q_id2,j2));
				if (gakko_success == 1) {
					trUnitChangeProtoUnit("Kajutsu Shinobi");
				} else {
					trUnitDelete(false);
			}	}

			q_id2 = kbUnitQueryCreate("Shinobi Lesson");
			kbUnitQuerySetPlayerID(q_id2, i);
			kbUnitQuerySetUnitType(q_id2,kbGetProtoUnitID("Shinobi Lesson"));
			kbUnitQuerySetState(q_id2,2);
			q_len2 = kbUnitQueryExecute(q_id2);
			for(j2=0;<q_len2) {
				trUnitSelectClear();
				gakko_success = 0;
				q_id = kbUnitQueryCreate("Villager Japanese");
				kbUnitQuerySetPlayerID(q_id, i);
				kbUnitQuerySetUnitType(q_id,kbGetProtoUnitID("Villager Japanese"));
				kbUnitQuerySetState(q_id,2);
				q_len = kbUnitQueryExecute(q_id);
				if (q_len > 0 && gakko_id > -1) {
					for (j=0;<q_len) {
						trUnitSelectClear();
						trUnitSelectByID(kbUnitQueryGetResult(q_id,j));
						if (trUnitGetIsContained("Gakko")) {
							trUnitChangeProtoUnit("Arrow");
							gakko_success = 1;
							break;
				}	}	}
				trUnitSelectClear();
				trUnitSelectByID(kbUnitQueryGetResult(q_id2,j2));
				if (gakko_success == 1) {
					trUnitChangeProtoUnit("Shinobi");
				} else {
					trUnitDelete(false);
			}	}




			q_id2 = kbUnitQueryCreate("Emperor Lightning");
			kbUnitQuerySetPlayerID(q_id2, i);
			kbUnitQuerySetUnitType(q_id2,kbGetProtoUnitID("Emperor Lightning"));
			kbUnitQuerySetState(q_id2,2);
			q_len2 = kbUnitQueryExecute(q_id2);
				for(j2=0;<q_len2)
			{
				trUnitSelectClear();
				trUnitSelectByID(kbUnitQueryGetResult(q_id2,j2));

				center = kbUnitGetPosition(kbUnitQueryGetResult(q_id2,j2));
				center_id = kbUnitQueryGetResult(q_id2,j2);
				trSetDisableGPBlocking(true);
				trTechInvokeGodPower(0, "Bazinga", center, center);
				
				
		
				//trUnitDelete(false); // only uncomment this if you want it to work under god power blockers without the lightning effect.
			}

			if (q_len2 == 0) {
				trSetDisableGPBlocking(false);
			}




				 

			
			
    }

	}

}


rule RefreshGodPowers
minInterval 1
maxInterval 1
active
{
    for (i=1; < cNumberPlayers)
    {
        
		xsSetContextPlayer(i);

		if(kbGetTechStatus(654) == cTechStatusActive)
		{

		int q_id = kbUnitQueryCreate("Invoker of Bazinga");
		kbUnitQuerySetPlayerID(q_id, i);
		kbUnitQuerySetUnitType(q_id,kbGetProtoUnitID("Invoker of Bazinga"));
		kbUnitQuerySetState(q_id,2);
		int q_len = kbUnitQueryExecute(q_id);
			for(j=0;<q_len)
		{
			trUnitSelectClear();
			trUnitSelectByID(kbUnitQueryGetResult(q_id,j));
			trUnitDelete(false);
			trTechGodPowerAtPosition(i, "Bazinga", 1, 1);
		}

		q_id = kbUnitQueryCreate("Invoker of Eyegate");
		kbUnitQuerySetPlayerID(q_id, i);
		kbUnitQuerySetUnitType(q_id,kbGetProtoUnitID("Invoker of Eyegate"));
		kbUnitQuerySetState(q_id,2);
		q_len = kbUnitQueryExecute(q_id);
			for(j=0;<q_len)
		{
			trUnitSelectClear();
			trUnitSelectByID(kbUnitQueryGetResult(q_id,j));
			trUnitDelete(false);
			trTechGodPowerAtPosition(i, "Eyegate", 1, 1);
		}

		q_id = kbUnitQueryCreate("Invoker of Schism");
		kbUnitQuerySetPlayerID(q_id, i);
		kbUnitQuerySetUnitType(q_id,kbGetProtoUnitID("Invoker of Schism"));
		kbUnitQuerySetState(q_id,2);
		q_len = kbUnitQueryExecute(q_id);
			for(j=0;<q_len)
		{
			trUnitSelectClear();
			trUnitSelectByID(kbUnitQueryGetResult(q_id,j));
			trUnitDelete(false);
			trTechGodPowerAtPosition(i, "Schism", 1, 1);
		}

		q_id = kbUnitQueryCreate("Invoker of Maw");
		kbUnitQuerySetPlayerID(q_id, i);
		kbUnitQuerySetUnitType(q_id,kbGetProtoUnitID("Invoker of Maw"));
		kbUnitQuerySetState(q_id,2);
		q_len = kbUnitQueryExecute(q_id);
			for(j=0;<q_len)
		{
			trUnitSelectClear();
			trUnitSelectByID(kbUnitQueryGetResult(q_id,j));
			trUnitDelete(false);
			trTechGodPowerAtPosition(i, "Maw", 1, 1);
		}

		q_id = kbUnitQueryCreate("Invoker of Howling Gale");
		kbUnitQuerySetPlayerID(q_id, i);
		kbUnitQuerySetUnitType(q_id,kbGetProtoUnitID("Invoker of Howling Gale"));
		kbUnitQuerySetState(q_id,2);
		q_len = kbUnitQueryExecute(q_id);
			for(j=0;<q_len)
		{
			trUnitSelectClear();
			trUnitSelectByID(kbUnitQueryGetResult(q_id,j));
			trUnitDelete(false);
			trTechGodPowerAtPosition(i, "Howling Gale", 1, 1);
		}

		q_id = kbUnitQueryCreate("Invoker of Spinners Call");
		kbUnitQuerySetPlayerID(q_id, i);
		kbUnitQuerySetUnitType(q_id,kbGetProtoUnitID("Invoker of Spinners Call"));
		kbUnitQuerySetState(q_id,2);
		q_len = kbUnitQueryExecute(q_id);
			for(j=0;<q_len)
		{
			trUnitSelectClear();
			trUnitSelectByID(kbUnitQueryGetResult(q_id,j));
			trUnitDelete(false);
			trTechGodPowerAtPosition(i, "Spinners Call", 1, 1);
		}

		q_id = kbUnitQueryCreate("Invoker of Wrath of the Vile");
		kbUnitQuerySetPlayerID(q_id, i);
		kbUnitQuerySetUnitType(q_id,kbGetProtoUnitID("Invoker of Wrath of the Vile"));
		kbUnitQuerySetState(q_id,2);
		q_len = kbUnitQueryExecute(q_id);
			for(j=0;<q_len)
		{
			trUnitSelectClear();
			trUnitSelectByID(kbUnitQueryGetResult(q_id,j));
			trUnitDelete(false);
			trTechGodPowerAtPosition(i, "Wrath of the Vile", 1, 1);
		}

		q_id = kbUnitQueryCreate("Invoker of The End");
		kbUnitQuerySetPlayerID(q_id, i);
		kbUnitQuerySetUnitType(q_id,kbGetProtoUnitID("Invoker of The End"));
		kbUnitQuerySetState(q_id,2);
		q_len = kbUnitQueryExecute(q_id);
			for(j=0;<q_len)
		{
			trUnitSelectClear();
			trUnitSelectByID(kbUnitQueryGetResult(q_id,j));
			trUnitDelete(false);
			trTechGodPowerAtPosition(i, "The End", 1, 1);
		}

		q_id = kbUnitQueryCreate("Invoker of Plague");
		kbUnitQuerySetPlayerID(q_id, i);
		kbUnitQuerySetUnitType(q_id,kbGetProtoUnitID("Invoker of Plague"));
		kbUnitQuerySetState(q_id,2);
		q_len = kbUnitQueryExecute(q_id);
			for(j=0;<q_len)
		{
			trUnitSelectClear();
			trUnitSelectByID(kbUnitQueryGetResult(q_id,j));
			trUnitDelete(false);
			trTechGodPowerAtPosition(i, "Plague", 1, 1);
		}

		q_id = kbUnitQueryCreate("Invoker of Yigs Curse");
		kbUnitQuerySetPlayerID(q_id, i);
		kbUnitQuerySetUnitType(q_id,kbGetProtoUnitID("Invoker of Yigs Curse"));
		kbUnitQuerySetState(q_id,2);
		q_len = kbUnitQueryExecute(q_id);
			for(j=0;<q_len)
		{
			trUnitSelectClear();
			trUnitSelectByID(kbUnitQueryGetResult(q_id,j));
			trUnitDelete(false);
			trTechGodPowerAtPosition(i, "Yigs Curse", 1, 1);
		}

		q_id = kbUnitQueryCreate("Invoker of Pillars of Irem");
		kbUnitQuerySetPlayerID(q_id, i);
		kbUnitQuerySetUnitType(q_id,kbGetProtoUnitID("Invoker of Pillars of Irem"));
		kbUnitQuerySetState(q_id,2);
		q_len = kbUnitQueryExecute(q_id);
			for(j=0;<q_len)
		{
			trUnitSelectClear();
			trUnitSelectByID(kbUnitQueryGetResult(q_id,j));
			trUnitDelete(false);
			trTechGodPowerAtPosition(i, "Pillars of Irem", 1, 1);
		}

		q_id = kbUnitQueryCreate("Invoker of Pull of the Deep");
		kbUnitQuerySetPlayerID(q_id, i);
		kbUnitQuerySetUnitType(q_id,kbGetProtoUnitID("Invoker of Pull of the Deep"));
		kbUnitQuerySetState(q_id,2);
		q_len = kbUnitQueryExecute(q_id);
			for(j=0;<q_len)
		{
			trUnitSelectClear();
			trUnitSelectByID(kbUnitQueryGetResult(q_id,j));
			trUnitDelete(false);
			trTechGodPowerAtPosition(i, "Grand Schism", 1, 1);
		}

		q_id = kbUnitQueryCreate("Invoker of Volcano");
		kbUnitQuerySetPlayerID(q_id, i);
		kbUnitQuerySetUnitType(q_id,kbGetProtoUnitID("Invoker of Volcano"));
		kbUnitQuerySetState(q_id,2);
		q_len = kbUnitQueryExecute(q_id);
			for(j=0;<q_len)
		{
			trUnitSelectClear();
			trUnitSelectByID(kbUnitQueryGetResult(q_id,j));
			trUnitDelete(false);
			trTechGodPowerAtPosition(i, "Volcano", 1, 1);
		}

		q_id = kbUnitQueryCreate("Invoker of Grand Schism");
		kbUnitQuerySetPlayerID(q_id, i);
		kbUnitQuerySetUnitType(q_id,kbGetProtoUnitID("Invoker of Grand Schism"));
		kbUnitQuerySetState(q_id,2);
		q_len = kbUnitQueryExecute(q_id);
			for(j=0;<q_len)
		{
			trUnitSelectClear();
			trUnitSelectByID(kbUnitQueryGetResult(q_id,j));
			trUnitDelete(false);
			trTechGodPowerAtPosition(i, "Ritual of Serpents", 1, 1);
		}


		}

	}


}


// REPLACE THIS WITH PURE TECHTREE 
rule YithStrength
minInterval 2
maxInterval 2
active
{

    //Iterate over the players, we start at 1 as gaia should
    // not be checked
    for (i=1; < cNumberPlayers)
    {
        
        xsSetContextPlayer(i);
	int q_id = kbUnitQueryCreate("Yith-Possessed");
	kbUnitQuerySetPlayerID(q_id, i);
	kbUnitQuerySetUnitType(q_id,kbGetProtoUnitID("Yith-Possessed"));
	kbUnitQuerySetState(q_id,2);
	int q_len = kbUnitQueryExecute(q_id);
    if (q_len <= 7) {
		if (trTechStatusActive(i, 710)) {
		} else {
			trTechSetStatus(i, 710, cTechStatusActive);
		}
		if (q_len <= 4) {
			if (trTechStatusActive(i, 711)) {
			} else {
				trTechSetStatus(i, 711, cTechStatusActive);
			}
			if (q_len <= 2) {
				if (trTechStatusActive(i, 712)) {
				} else {
					trTechSetStatus(i, 712, cTechStatusActive);
				}
				if (q_len <= 1) {
					if (trTechStatusActive(i, 713)) {
					} else {
						trTechSetStatus(i, 713, cTechStatusActive);
					}
				} else {
					trTechSetStatus(i, 713, cTechStatusUnobtainable);
				}

			} else {
				trTechSetStatus(i, 712, cTechStatusUnobtainable);
				trTechSetStatus(i, 713, cTechStatusUnobtainable);
			}

		} else {
			trTechSetStatus(i, 711, cTechStatusUnobtainable);
			trTechSetStatus(i, 712, cTechStatusUnobtainable);
			trTechSetStatus(i, 713, cTechStatusUnobtainable);
		}

	} else {
		trTechSetStatus(i, 710, cTechStatusUnobtainable);
		trTechSetStatus(i, 711, cTechStatusUnobtainable);
		trTechSetStatus(i, 712, cTechStatusUnobtainable);
		trTechSetStatus(i, 713, cTechStatusUnobtainable);
	}


    }
}


rule ConductRituals
minInterval 1
maxInterval 1
active
{
    int checkNightmare = 0;

    //Iterate over the players, we start at 1 as gaia should
    // not be checked
    for (i=1; < cNumberPlayers)
    {
        
        xsSetContextPlayer(i);

			if(kbGetTechStatus(654) == cTechStatusActive)
	{


	trPlayerSetDiplomacy(0, i, "enemy");
	int q_id = kbUnitQueryCreate("Ritual of Lightning");
	kbUnitQuerySetPlayerID(q_id, i);
	kbUnitQuerySetUnitType(q_id,kbGetProtoUnitID("Ritual of Lightning"));
	kbUnitQuerySetState(q_id,2);
	int q_len = kbUnitQueryExecute(q_id);
        for(j=0;<q_len)
	{
		trUnitSelectClear();
		trUnitSelectByID(kbUnitQueryGetResult(q_id,j));
		//trUnitDistanceToPoint(float x, float y, float z);
		//trTechInvokeGodPower(0, "Wrath of Gaea", vector(60.03, 20.00, 60.67), vector(0,0,0));
		trTechInvokeGodPower(0, "Wrath of Gaea", kbUnitGetPosition(kbUnitQueryGetResult(q_id,j)), kbUnitGetPosition(kbUnitQueryGetResult(q_id,j)));
		//trUnitDelete(false);
	}



	q_id = kbUnitQueryCreate("Dreamers Invocation");
	kbUnitQuerySetPlayerID(q_id, i);
	kbUnitQuerySetUnitType(q_id,kbGetProtoUnitID("Dreamers Invocation"));
	kbUnitQuerySetState(q_id,2);
	q_len = kbUnitQueryExecute(q_id);
        for(j=0;<q_len)
	{
		trUnitSelectClear();
		trUnitSelectByID(kbUnitQueryGetResult(q_id,j));

		vector center = kbUnitGetPosition(kbUnitQueryGetResult(q_id,j));
		int center_id = kbUnitQueryGetResult(q_id,j);

		trTechInvokeGodPower(0, "Dreamers Invocation", center, center);
		
		trUnitDelete(false);
	}

	q_id = kbUnitQueryCreate("Black Hole");
	kbUnitQuerySetPlayerID(q_id, i);
	kbUnitQuerySetUnitType(q_id,kbGetProtoUnitID("Black Hole"));
	kbUnitQuerySetState(q_id,2);
	q_len = kbUnitQueryExecute(q_id);
        for(j=0;<q_len)
	{
		trUnitSelectClear();
		trUnitSelectByID(kbUnitQueryGetResult(q_id,j));

		center = kbUnitGetPosition(kbUnitQueryGetResult(q_id,j));
		center_id = kbUnitQueryGetResult(q_id,j);

		trTechInvokeGodPower(0, "Black Hole", center, center);
		
		trUnitDelete(false);
	}

	q_id = kbUnitQueryCreate("The King in Yellow");
	kbUnitQuerySetPlayerID(q_id, i);
	kbUnitQuerySetUnitType(q_id,kbGetProtoUnitID("The King in Yellow"));
	kbUnitQuerySetState(q_id,2);
	q_len = kbUnitQueryExecute(q_id);
        for(j=0;<q_len)
	{
		trUnitSelectClear();
		trUnitSelectByID(kbUnitQueryGetResult(q_id,j));

		center = kbUnitGetPosition(kbUnitQueryGetResult(q_id,j));
		center_id = kbUnitQueryGetResult(q_id,j);

		trUnitChangeInArea(i, i, "The King in Yellow", "Invoker Yellow Temp", 1.0);

		trTechInvokeGodPower(0, "The King In Yellow Prelude", center, center);
		
		trUnitDelete(false);
	}

	q_id = kbUnitQueryCreate("Invoker Yellow Active");
	kbUnitQuerySetPlayerID(q_id, i);
	kbUnitQuerySetUnitType(q_id,kbGetProtoUnitID("Invoker Yellow Active"));
	kbUnitQuerySetState(q_id,2);
	q_len = kbUnitQueryExecute(q_id);
        for(j=0;<q_len)
	{
		trUnitSelectClear();
		trUnitSelectByID(kbUnitQueryGetResult(q_id,j));

		center = kbUnitGetPosition(kbUnitQueryGetResult(q_id,j));
		center_id = kbUnitQueryGetResult(q_id,j);

		trTechInvokeGodPower(0, "The King in Yellow", center, center);
		
		trUnitDelete(false);
	}

	q_id = kbUnitQueryCreate("Black Grove");
	kbUnitQuerySetPlayerID(q_id, i);
	kbUnitQuerySetUnitType(q_id,kbGetProtoUnitID("Black Grove"));
	kbUnitQuerySetState(q_id,2);
	q_len = kbUnitQueryExecute(q_id);
        for(j=0;<q_len)
	{
		trUnitSelectClear();
		trUnitSelectByID(kbUnitQueryGetResult(q_id,j));

		center = kbUnitGetPosition(kbUnitQueryGetResult(q_id,j));
		center_id = kbUnitQueryGetResult(q_id,j);

		trTechInvokeGodPower(0, "Black Grove", center, center);
		
		trUnitDelete(false);
	}

	
	xsSetContextPlayer(0);

	int q_id2 = kbUnitQueryCreate("Voormis 4");
	kbUnitQuerySetPlayerID(q_id2, 0);
	kbUnitQuerySetUnitType(q_id2,kbGetProtoUnitID("Voormis 4"));
	kbUnitQuerySetState(q_id2,2);
	int q_len2 = kbUnitQueryExecute(q_id2);
        for(k=0;<q_len2)
	{
		trUnitSelectClear();
		trUnitSelectByID(kbUnitQueryGetResult(q_id2,k));
	
		trUnitConvert(i);
	}

	xsSetContextPlayer(i);

	q_id = kbUnitQueryCreate("Ritual of the Voormi");
	kbUnitQuerySetPlayerID(q_id, i);
	kbUnitQuerySetUnitType(q_id,kbGetProtoUnitID("Ritual of the Voormi"));
	kbUnitQuerySetState(q_id,2);
	q_len = kbUnitQueryExecute(q_id);
        for(j=0;<q_len)
	{
		trUnitSelectClear();
		trUnitSelectByID(kbUnitQueryGetResult(q_id,j));

		center = kbUnitGetPosition(kbUnitQueryGetResult(q_id,j));
		center_id = kbUnitQueryGetResult(q_id,j);

		trTechInvokeGodPower(0, "Voormisian", center, center);

		trUnitDelete(false);
	}

	

	

	q_id = kbUnitQueryCreate("Ritual of the New Moon");
	kbUnitQuerySetPlayerID(q_id, i);
	kbUnitQuerySetUnitType(q_id,kbGetProtoUnitID("Ritual of the New Moon"));
	kbUnitQuerySetState(q_id,2);
	q_len = kbUnitQueryExecute(q_id);
        for(j=0;<q_len)
	{
		trUnitSelectClear();
		trUnitSelectByID(kbUnitQueryGetResult(q_id,j));

		center = kbUnitGetPosition(kbUnitQueryGetResult(q_id,j));
		center_id = kbUnitQueryGetResult(q_id,j);

		trTechInvokeGodPower(0, "Ritual of the New Moon A", center, center);
		trTechInvokeGodPower(0, "Ritual of the New Moon B", center, center);
		
		trUnitDelete(false);
	}


	q_id = kbUnitQueryCreate("Ritual of Serpents");
	kbUnitQuerySetPlayerID(q_id, i);
	kbUnitQuerySetUnitType(q_id,kbGetProtoUnitID("Ritual of Serpents"));
	kbUnitQuerySetState(q_id,2);
	q_len = kbUnitQueryExecute(q_id);
        for(j=0;<q_len)
	{
		trUnitSelectClear();
		trUnitSelectByID(kbUnitQueryGetResult(q_id,j));

		center = kbUnitGetPosition(kbUnitQueryGetResult(q_id,j));
		center_id = kbUnitQueryGetResult(q_id,j);

		trTechInvokeGodPower(0, "Ritual of Serpents", center, center);
		
		trUnitDelete(false);
	}


	q_id = kbUnitQueryCreate("Ritual of Loyalty");
	kbUnitQuerySetPlayerID(q_id, i);
	kbUnitQuerySetUnitType(q_id,kbGetProtoUnitID("Ritual of Loyalty"));
	kbUnitQuerySetState(q_id,2);
	q_len = kbUnitQueryExecute(q_id);
        for(j=0;<q_len)
	{
		trUnitSelectClear();
		trUnitSelectByID(kbUnitQueryGetResult(q_id,j));

		center = kbUnitGetPosition(kbUnitQueryGetResult(q_id,j));
		center_id = kbUnitQueryGetResult(q_id,j);

		trTechInvokeGodPower(0, "Ritual of Loyalty", center, center);
		
		trUnitDelete(false);
	}





	q_id = kbUnitQueryCreate("Ritual of the Black Flame");
	kbUnitQuerySetPlayerID(q_id, i);
	kbUnitQuerySetUnitType(q_id,kbGetProtoUnitID("Ritual of the Black Flame"));
	kbUnitQuerySetState(q_id,2);
	q_len = kbUnitQueryExecute(q_id);
        for(j=0;<q_len)
	{
		trUnitSelectClear();
		trUnitSelectByID(kbUnitQueryGetResult(q_id,j));

		center = kbUnitGetPosition(kbUnitQueryGetResult(q_id,j));
		center_id = kbUnitQueryGetResult(q_id,j);

		trTechInvokeGodPower(0, "Ritual of the Black Flame", center, center);
		
		trUnitDelete(false);
	}


	q_id = kbUnitQueryCreate("Altar");
	kbUnitQuerySetPlayerID(q_id, i);
	kbUnitQuerySetUnitType(q_id,kbGetProtoUnitID("Altar"));
	kbUnitQuerySetState(q_id,2);
	q_len = kbUnitQueryExecute(q_id);
        for(j=0;<q_len)
	{
		trUnitSelectClear();
		trUnitSelectByID(kbUnitQueryGetResult(q_id,j));

		center = kbUnitGetPosition(kbUnitQueryGetResult(q_id,j));
		center_id = kbUnitQueryGetResult(q_id,j);

		trUnitChangeInArea(i, i, "Cultist", "Super Appealing Form", 2.0);

	}

	
	q_id = kbUnitQueryCreate("Ritual of the Gate");
	kbUnitQuerySetPlayerID(q_id, i);
	kbUnitQuerySetUnitType(q_id,kbGetProtoUnitID("Ritual of the Gate"));
	kbUnitQuerySetState(q_id,2);
	q_len = kbUnitQueryExecute(q_id);
        if(2 == q_len)
	{
		trUnitSelectClear();
		trUnitSelectByID(kbUnitQueryGetResult(q_id,0));

		vector center1 = kbUnitGetPosition(kbUnitQueryGetResult(q_id,0));
		vector center2 = kbUnitGetPosition(kbUnitQueryGetResult(q_id,1));

		trTechInvokeGodPower(0, "Ritual of the Gate", center1, center2);
		trTechInvokeGodPower(0, "Ritual of the Gate", center2, center1);
		
		trUnitDelete(false);

		trUnitSelectClear();
		trUnitSelectByID(kbUnitQueryGetResult(q_id,1));
		trUnitDelete(false);
	}


	q_id = kbUnitQueryCreate("Ritual of The Key");
	kbUnitQuerySetPlayerID(q_id, i);
	kbUnitQuerySetUnitType(q_id,kbGetProtoUnitID("Ritual of The Key"));
	kbUnitQuerySetState(q_id,2);
	q_len = kbUnitQueryExecute(q_id);
        if(1 == q_len)
	{
		trUnitSelectClear();
		trUnitSelectByID(kbUnitQueryGetResult(q_id,0));


		center = kbUnitGetPosition(kbUnitQueryGetResult(q_id,j));
		center_id = kbUnitQueryGetResult(q_id,j);


		q_id2 = kbUnitQueryCreate("Cultist");
		kbUnitQuerySetPlayerID(q_id2, i);
		kbUnitQuerySetUnitType(q_id2,kbGetProtoUnitID("Cultist of Yog-Sothoth"));
		kbUnitQuerySetState(q_id2,2);
		q_len2 = kbUnitQueryExecute(q_id2);

		int foundOne = 0;
        	for(k=0;<q_len2)
		{
			trUnitSelectClear();
			trUnitSelectByID(kbUnitQueryGetResult(q_id2,k));
			if (trUnitDistanceToUnitID(center_id) <= 8.0)
			{
				if (foundOne == 0) 
				{
					foundOne = 1;
				}
				else 
				{
					foundOne = 0;
					break;
				}
				
			}
		}

		
		if (foundOne == 1) {
			trUnitSelectClear();
			trUnitSelectByID(kbUnitQueryGetResult(q_id,0));

			trUnitChangeInArea(i, i,"Cultist of Yog-Sothoth","Carterite", 8.0);


			trForbidProtounit(i, "Ritual of The Key");
			trUnitDelete(false);
		}
	}

	q_id = kbUnitQueryCreate("Carterite Dead");
	kbUnitQuerySetPlayerID(q_id, i);
	kbUnitQuerySetUnitType(q_id,kbGetProtoUnitID("Carterite Dead"));
	kbUnitQuerySetState(q_id,2);
	q_len = kbUnitQueryExecute(q_id);
        if(q_len > 0)
	{
		trUnitSelectClear();
		trUnitSelectByID(kbUnitQueryGetResult(q_id,0));
		trUnforbidProtounit(i, "Ritual of The Key");
		trUnitDelete(false);
	}


	q_id = kbUnitQueryCreate("Ritual of the Blessed Birth");
	kbUnitQuerySetPlayerID(q_id, i);
	kbUnitQuerySetUnitType(q_id,kbGetProtoUnitID("Ritual of the Blessed Birth"));
	kbUnitQuerySetState(q_id,2);
	q_len = kbUnitQueryExecute(q_id);
        if(1 == q_len)
	{
		trUnitSelectClear();
		trUnitSelectByID(kbUnitQueryGetResult(q_id,0));


		center = kbUnitGetPosition(kbUnitQueryGetResult(q_id,j));
		center_id = kbUnitQueryGetResult(q_id,j);


		q_id2 = kbUnitQueryCreate("Cultist");
		kbUnitQuerySetPlayerID(q_id2, i);
		kbUnitQuerySetUnitType(q_id2,kbGetProtoUnitID("Cultist of Shub-Niggurath"));
		kbUnitQuerySetState(q_id2,2);
		q_len2 = kbUnitQueryExecute(q_id2);

		foundOne = 0;
        	for(k=0;<q_len2)
		{
			trUnitSelectClear();
			trUnitSelectByID(kbUnitQueryGetResult(q_id2,k));
			if (trUnitDistanceToUnitID(center_id) <= 8.0)
			{
				if (foundOne == 0) 
				{
					foundOne = 1;
				}
				else 
				{
					foundOne = 0;
					break;
				}
				
			}
		}

		
		if (foundOne == 1) {
			trUnitSelectClear();
			trUnitSelectByID(kbUnitQueryGetResult(q_id,0));

			trUnitChangeInArea(i, i,"Cultist of Shub-Niggurath","Blessed One", 8.0);


			trForbidProtounit(i, "Ritual of the Blessed Birth");
			trUnitDelete(false);
		}
	}

	q_id = kbUnitQueryCreate("Blessed One Dead");
	kbUnitQuerySetPlayerID(q_id, i);
	kbUnitQuerySetUnitType(q_id,kbGetProtoUnitID("Blessed One Dead"));
	kbUnitQuerySetState(q_id,2);
	q_len = kbUnitQueryExecute(q_id);
        if(q_len > 0)
	{
		trUnitSelectClear();
		trUnitSelectByID(kbUnitQueryGetResult(q_id,0));
		trUnforbidProtounit(i, "Ritual of the Blessed Birth");
		trUnitDelete(false);
	}

if(0 == 1) {
	q_id = kbUnitQueryCreate("Temp Maw");
	kbUnitQuerySetPlayerID(q_id, i);
	kbUnitQuerySetUnitType(q_id,kbGetProtoUnitID("Temp Maw"));
	kbUnitQuerySetState(q_id,2);
	q_len = kbUnitQueryExecute(q_id);
        if(0 < q_len)
	{
		trUnitSelectClear();
		trUnitSelectByID(kbUnitQueryGetResult(q_id,0));


		trUnitChangeInArea(0, i,"Deep Gate","Deep Gate", 8.0);
		trUnitDelete(false);

		
	}
}

	q_id = kbUnitQueryCreate("Maw of the Deep");
	kbUnitQuerySetPlayerID(q_id, i);
	kbUnitQuerySetUnitType(q_id,kbGetProtoUnitID("Maw of the Deep"));
	kbUnitQuerySetState(q_id,2);
	q_len = kbUnitQueryExecute(q_id);
        if(0 < q_len)
	{
		trUnitSelectClear();
		trUnitSelectByID(kbUnitQueryGetResult(q_id,0));


		center = kbUnitGetPosition(kbUnitQueryGetResult(q_id,j));
		center_id = kbUnitQueryGetResult(q_id,j);

		trUnitChangeInArea(i, i,"Cultist of Cthulhu","Cthulhi", 8.0);

if (0 == 1) {
		trUnitChangeInArea(i, i,"Cultist of Cthulhu","Temp Deep", 8.0);


		q_id2 = kbUnitQueryCreate("Temp Deep");
		kbUnitQuerySetPlayerID(q_id2, i);
		kbUnitQuerySetUnitType(q_id2,kbGetProtoUnitID("Temp Deep"));
		kbUnitQuerySetState(q_id2,2);
		q_len2 = kbUnitQueryExecute(q_id2);

        	for(k=0;<q_len2)
		{
			trUnitSelectClear();
			trUnitSelectByID(kbUnitQueryGetResult(q_id2,k));
			
			if (trUnitDistanceToUnitID(center_id) <= 8.0)
			{
				vector center_c = kbUnitGetPosition(kbUnitQueryGetResult(q_id2,k));
				trUnitDelete(false);
				trTechInvokeGodPower(0, "Pulse of the Deep", center_c, center_c);
				
			}
			
		}

		trUnitSelectClear();
		trUnitSelectByID(kbUnitQueryGetResult(q_id,0));
		trUnitChangeInArea(i, i,"Maw of the Deep","Temp Maw", 8.0);
}
		
	}


	q_id = kbUnitQueryCreate("Ritual of Wrath Active");
	kbUnitQuerySetPlayerID(q_id, i);
	kbUnitQuerySetUnitType(q_id,kbGetProtoUnitID("Ritual of Wrath Active"));
	kbUnitQuerySetState(q_id,2);
	q_len = kbUnitQueryExecute(q_id);
        if(q_len > 0)
	{
		//trUnitSelectClear();
		//trUnitSelectByID(kbUnitQueryGetResult(q_id,0));
		//trUnitDelete(false);
		
		if (trTechStatusActive(i, 678)) {
		} else {
			trTechSetStatus(i, 679, cTechStatusActive);
			trChatSend(i, "AAARRRGH I BE ANGRY");
			for (j=1; < cNumberPlayers)
    			{
			trTechSetStatus(j, 678, cTechStatusActive);
			trChatSend(j, "AAARRRGH I BE ANGRY");
			}
		}
	} else {
		if (trTechStatusActive(i, 679)) {
			trTechSetStatus(i, 679, cTechStatusUnobtainable);
			trChatSend(i, "I feel much better now, whew");
			for (j=1; < cNumberPlayers)
    			{
			trTechSetStatus(j, 678, cTechStatusUnobtainable);
			trChatSend(j, "I feel much better now, whew");
			}
		}
		
	}

	q_id = kbUnitQueryCreate("Nightmare Beacon");
	kbUnitQuerySetPlayerID(q_id, i);
	kbUnitQuerySetUnitType(q_id,kbGetProtoUnitID("Nightmare Beacon"));
	kbUnitQuerySetState(q_id,2);
	q_len = kbUnitQueryExecute(q_id);
        if(q_len > 0)
	{
		checkNightmare = 1;
		//trUnitSelectClear();
		//trUnitSelectByID(kbUnitQueryGetResult(q_id,0));
		//trUnitDelete(false);
		
		if (trTechStatusActive(i, 696)) {
		} else {
			trTechSetStatus(i, 696, cTechStatusActive);
			trChatSend(i, "I BECKON THE NIGHTMARE");

		}
	} else {
		if (trTechStatusActive(i, 696)) {
			trTechSetStatus(i, 696, cTechStatusUnobtainable);
			trChatSend(i, "I am no longer beckoning the nightmare");

		}
		
	}

	q_id = kbUnitQueryCreate("Weavers Transformation");
	kbUnitQuerySetPlayerID(q_id, i);
	kbUnitQuerySetUnitType(q_id,kbGetProtoUnitID("Weavers Transformation"));
	kbUnitQuerySetState(q_id,2);
	q_len = kbUnitQueryExecute(q_id);
        for(j=0;<q_len)
	{
		trUnitSelectClear();
		trUnitSelectByID(kbUnitQueryGetResult(q_id,j));

		center = kbUnitGetPosition(kbUnitQueryGetResult(q_id,j));
		center_id = kbUnitQueryGetResult(q_id,j);

		//rmAddPlayerResource(i, "Gold", 10000);
		
		int resources = trPlayerResourceCount(i, "Food")+trPlayerResourceCount(i, "Wood")+trPlayerResourceCount(i, "Gold");
		trPlayerGrantResources(i, "Food", (resources / 3)-trPlayerResourceCount(i, "Food"));
		trPlayerGrantResources(i, "Wood", (resources / 3)-trPlayerResourceCount(i, "Wood"));
		trPlayerGrantResources(i, "Gold", (resources / 3)-trPlayerResourceCount(i, "Gold"));
		trUnitDelete(false);
	}



	// has to be the last one in the list -- diplomacy goes wonky

	q_id = kbUnitQueryCreate("Ephiriams Ritual");
	kbUnitQuerySetPlayerID(q_id, i);
	kbUnitQuerySetUnitType(q_id,kbGetProtoUnitID("Ephiriams Ritual"));
	kbUnitQuerySetState(q_id,2);
	q_len = kbUnitQueryExecute(q_id);
        for(j=0;<q_len)
	{
		trUnitSelectClear();
		trUnitSelectByID(kbUnitQueryGetResult(q_id,j));

		center = kbUnitGetPosition(kbUnitQueryGetResult(q_id,j));
		center_id = kbUnitQueryGetResult(q_id,j);

		//trUnitDelete(false);
		

		q_id2 = kbUnitQueryCreate("Cultist Of Azathoth");
		kbUnitQuerySetPlayerID(q_id2, i);
		kbUnitQuerySetUnitType(q_id2,kbGetProtoUnitID("Cultist of Azathoth"));
		kbUnitQuerySetState(q_id2,2);
		q_len2 = kbUnitQueryExecute(q_id2);

		int count = 0;
        	for(k=0;<q_len2)
		{
			trUnitSelectClear();
			trUnitSelectByID(kbUnitQueryGetResult(q_id2,k));
			if (trUnitDistanceToUnitID(center_id) < 5)
			{
				count = count + 1;
				trUnitDelete(false);
			}
			if (count == 1)
			{
				break;
			}
		}

		if (count == 0)
		{
			trUnitSelectByID(center_id);
			//trUnitDelete(false);
			
		}

		
		for(k=0;<count)
		{
			trPlayerSetDiplomacy(0, i, "ally");
			//for (l=1; < cNumberPlayers)
			//{
			//	if (l != i){
			//	if (trPlayerGetDiplomacy(i, l) == "ally")
			//	{
			//		trPlayerSetDiplomacy(0, l, "ally");
			//	}
			//	}
			//}
			trTechInvokeGodPower(0, "Body Swap", center, center);
			//for (l=1; < cNumberPlayers)
			//{
			//	if (l != i){
			//	if (trPlayerGetDiplomacy(i, l) == "ally")
			//	{
			//		trPlayerSetDiplomacy(0, l, "enemy");
			//	}
			//	}
			//}
			
		}
		
	}

    }
    if (checkNightmare == 1 && NightmareActive == 0)
    {
	NightmareActive = 1;
	for (j=1; < cNumberPlayers)
    	{
		trTechSetStatus(j, 695, cTechStatusActive);
		trChatSend(j, "I can't see");
	}

    }

    if (checkNightmare == 0 && NightmareActive == 1)
    {
	NightmareActive = 0;

	for (j=1; < cNumberPlayers)
    	{
		trTechSetStatus(j, 695, cTechStatusUnobtainable);
		trChatSend(j, "I can see");
	}

    }

	}

}

rule SpreadPlague
minInterval 1
maxInterval 1
active
{
    tempModIndex = tempModIndex + 1;
    tempModIndex = tempModIndex % plagueMod ;

    for (i=0; < 1)
    {
        
        xsSetContextPlayer(i);

	int q_id = kbUnitQueryCreate("Plague Mushroom");
	kbUnitQuerySetPlayerID(q_id, i);
	kbUnitQuerySetUnitType(q_id,kbGetProtoUnitID("Plague Mushroom"));
	kbUnitQuerySetState(q_id,2);
	int q_len = kbUnitQueryExecute(q_id);
        for(j=0;<q_len)
	{
		if (j % plagueMod == tempModIndex) {
			trUnitSelectClear();
			trUnitSelectByID(kbUnitQueryGetResult(q_id,j));

			vector center = kbUnitGetPosition(kbUnitQueryGetResult(q_id,j));
			trTechInvokeGodPower(0, "Infect", center, center);

		}

	}

    }

}





rule UnwravelerEat
minInterval 1
maxInterval 1
active
{
    for (i=1; < cNumberPlayers)
    {
        
        xsSetContextPlayer(i);
	int q_id = kbUnitQueryCreate("Unwraveler");
	kbUnitQuerySetPlayerID(q_id, i);
	kbUnitQuerySetUnitType(q_id,kbGetProtoUnitID("Unwraveler"));
	kbUnitQuerySetState(q_id,2);
	int q_len = kbUnitQueryExecute(q_id);
        for(j=0;<q_len)
	{
		trUnitSelectClear();
		trUnitSelectByID(kbUnitQueryGetResult(q_id,j));
		if (trUnitPercentDamaged() < 9) {
			trDamageUnitPercent(9-trUnitPercentDamaged());
		}
	}

	q_id = kbUnitQueryCreate("Yellow One Attack");
	kbUnitQuerySetPlayerID(q_id, i);
	kbUnitQuerySetUnitType(q_id,kbGetProtoUnitID("Yellow One Attack"));
	kbUnitQuerySetState(q_id,2);
	q_len = kbUnitQueryExecute(q_id);
        for(j=0;<q_len)
	{
		trUnitSelectClear();
		trUnitSelectByID(kbUnitQueryGetResult(q_id,j));
		trDamageUnitPercent(5);
		
	}

	q_id = kbUnitQueryCreate("Endbringer");
	kbUnitQuerySetPlayerID(q_id, i);
	kbUnitQuerySetUnitType(q_id,kbGetProtoUnitID("Endbringer"));
	kbUnitQuerySetState(q_id,2);
	q_len = kbUnitQueryExecute(q_id);
        for(j=0;<q_len)
	{
		trUnitSelectClear();
		trUnitSelectByID(kbUnitQueryGetResult(q_id,j));
		trDamageUnitPercent(3.3);
		
	}

    }
}

rule SacrificeUnits
minInterval 4
maxInterval 4
active
{
    for (i=1; < cNumberPlayers)
    {
        
        xsSetContextPlayer(i);
	int q_id = kbUnitQueryCreate("Town Hall Ready");
	kbUnitQuerySetPlayerID(q_id, i);
	kbUnitQuerySetUnitType(q_id,kbGetProtoUnitID("Town Hall Ready"));
	kbUnitQuerySetState(q_id,2);
	int q_len = kbUnitQueryExecute(q_id);
        for(j=0;<q_len)
	{
		trUnitSelectClear();
		trUnitSelectByID(kbUnitQueryGetResult(q_id,j));
		if (trUnitGetContained() > 0) {
			trPlayerGrantResources(i, "Favor", (trUnitGetContained() * 7.5));
			trUnitDelete(false);
		}
	}


    }
}



rule ConvertSouls
minInterval 1
maxInterval 1
active
{

    for (i=1; < cNumberPlayers)
    {
        
        xsSetContextPlayer(i);


	if(kbGetTechStatus(775) == cTechStatusActive)
	{
		if(trPlayerResourceCount(i, "Favor")>100) {
			trPlayerGrantResources(i, "Favor", 100-trPlayerResourceCount(i, "Favor"));
		}
	}


	int q_id = kbUnitQueryCreate("Soul Rune");
	kbUnitQuerySetPlayerID(q_id, i);
	kbUnitQuerySetUnitType(q_id,kbGetProtoUnitID("Soul Rune"));
	kbUnitQuerySetState(q_id,2);
	int q_len = kbUnitQueryExecute(q_id);
        for(j=0;<q_len)
	{
		trUnitSelectClear();
		trUnitSelectByID(kbUnitQueryGetResult(q_id,j));

		trUnitChangeInArea(0, i, "Soul Light Wild", "Soul Light Tame", 7.5);
	}

	q_id = kbUnitQueryCreate("Soul Release");
	kbUnitQuerySetPlayerID(q_id, i);
	kbUnitQuerySetUnitType(q_id,kbGetProtoUnitID("Soul Release"));
	kbUnitQuerySetState(q_id,2);
	q_len = kbUnitQueryExecute(q_id);
        for(j=0;<q_len)
	{
		trUnitSelectClear();
		trUnitSelectByID(kbUnitQueryGetResult(q_id,j));

		trUnitChangeInArea(i, i, "Soul Light Tame", "Soul Light Dead", 7.5);
		trUnitDelete(false);
	}






    }

}


rule Fushimi
minInterval 300
maxInterval 300
active
{


    //Iterate over the players, we start at 1 as gaia should
    // not be checked (she's always popcapped anyways)
    for (i=1; < cNumberPlayers)
    {
        xsSetContextPlayer(i);
		
		if(kbGetTechStatus(1033) == cTechStatusActive)
		{


			int q_id = kbUnitQueryCreate("Villager Japanese fush");
			kbUnitQuerySetPlayerID(q_id, i);
			kbUnitQuerySetUnitType(q_id,kbGetProtoUnitID("Villager Japanese"));
			kbUnitQuerySetState(q_id,2);
			int q_len = kbUnitQueryExecute(q_id);

			int q_id2 = kbUnitQueryCreate("Villager Japanese Skilled fush");
			kbUnitQuerySetPlayerID(q_id2, i);
			kbUnitQuerySetUnitType(q_id2,kbGetProtoUnitID("Villager Japanese Skilled"));
			kbUnitQuerySetState(q_id2,2);
			int q_len2 = kbUnitQueryExecute(q_id2);


			if(kbGetTechStatus(1031) == cTechStatusActive) {
				trPlayerGrantResources(i, "Food", trPlayerResourceCount(i, "Food") * (q_len * 4 + q_len2 * 10 ) / 1000);
				trPlayerGrantResources(i, "Wood", trPlayerResourceCount(i, "Wood") * (q_len * 4 + q_len2 * 10) / 1000);
				trPlayerGrantResources(i, "Gold", trPlayerResourceCount(i, "Gold") * (q_len * 4 + q_len2 * 10) / 1000);
				trPlayerGrantResources(i, "Favor", trPlayerResourceCount(i, "Favor") * (q_len * 4 + q_len2 * 10 ) / 1000);
			} else {
				trPlayerGrantResources(i, "Food", trPlayerResourceCount(i, "Food") * (q_len * 2 + q_len2 * 5 ) / 1000);
				trPlayerGrantResources(i, "Wood", trPlayerResourceCount(i, "Wood") * (q_len * 2 + q_len2 * 5 ) / 1000);
				trPlayerGrantResources(i, "Gold", trPlayerResourceCount(i, "Gold") * (q_len * 2 + q_len2 * 5 ) / 1000);
				trPlayerGrantResources(i, "Favor", trPlayerResourceCount(i, "Favor") * (q_len * 2 + q_len2 * 5 ) / 1000);
			}
			

		}
	}
}



rule AmaterasuRefresh
minInterval 10
maxInterval 10
active
{

    //Iterate over the players, we start at 1 as gaia should
    // not be checked (she's always popcapped anyways)
    for (i=1; < cNumberPlayers) {
        xsSetContextPlayer(i);
		if(kbGetTechStatus(775) == cTechStatusActive) {
			int q_id = kbUnitQueryCreate("Amaterasu Refresh");
			kbUnitQuerySetPlayerID(q_id, i);
			kbUnitQuerySetUnitType(q_id,kbGetProtoUnitID("Amaterasu Refresh"));
			kbUnitQuerySetState(q_id,2);
			int q_len = kbUnitQueryExecute(q_id);
			for(j=0;<q_len) {
				trUnitSelectClear();
				trUnitSelectByID(kbUnitQueryGetResult(q_id,j));

				trUnitDelete(false);
			}

			if (q_len > 0) {
				kbUnitQueryCreate("Emperor Japanese 1");
				kbUnitQuerySetPlayerID(q_id, i);
				kbUnitQuerySetUnitType(q_id,kbGetProtoUnitID("Emperor Japanese 1"));
				kbUnitQuerySetState(q_id,2);
				kbUnitQueryExecute(q_id);
				for(j=0;<q_len) {
					trUnitSelectClear();
					trUnitSelectByID(kbUnitQueryGetResult(q_id,j));

					trUnitDelete(true);
				}
				kbUnitQueryCreate("Emperor Japanese 2");
				kbUnitQuerySetPlayerID(q_id, i);
				kbUnitQuerySetUnitType(q_id,kbGetProtoUnitID("Emperor Japanese 2"));
				kbUnitQuerySetState(q_id,2);
				kbUnitQueryExecute(q_id);
				for(j=0;<q_len) {
					trUnitSelectClear();
					trUnitSelectByID(kbUnitQueryGetResult(q_id,j));

					trUnitDelete(true);
				}
				kbUnitQueryCreate("Emperor Japanese 3");
				kbUnitQuerySetPlayerID(q_id, i);
				kbUnitQuerySetUnitType(q_id,kbGetProtoUnitID("Emperor Japanese 3"));
				kbUnitQuerySetState(q_id,2);
				kbUnitQueryExecute(q_id);
				for(j=0;<q_len) {
					trUnitSelectClear();
					trUnitSelectByID(kbUnitQueryGetResult(q_id,j));

					trUnitDelete(true);
				}
				kbUnitQueryCreate("Emperor Japanese 4");
				kbUnitQuerySetPlayerID(q_id, i);
				kbUnitQuerySetUnitType(q_id,kbGetProtoUnitID("Emperor Japanese 4"));
				kbUnitQuerySetState(q_id,2);
				kbUnitQueryExecute(q_id);
				for(j=0;<q_len) {
					trUnitSelectClear();
					trUnitSelectByID(kbUnitQueryGetResult(q_id,j));

					trUnitDelete(true);
				}
				kbUnitQueryCreate("Emperor Japanese 5");
				kbUnitQuerySetPlayerID(q_id, i);
				kbUnitQuerySetUnitType(q_id,kbGetProtoUnitID("Emperor Japanese 5"));
				kbUnitQuerySetState(q_id,2);
				kbUnitQueryExecute(q_id);
				for(j=0;<q_len) {
					trUnitSelectClear();
					trUnitSelectByID(kbUnitQueryGetResult(q_id,j));

					trUnitDelete(true);
				}
				kbUnitQueryCreate("Emperor Japanese 6");
				kbUnitQuerySetPlayerID(q_id, i);
				kbUnitQuerySetUnitType(q_id,kbGetProtoUnitID("Emperor Japanese 6"));
				kbUnitQuerySetState(q_id,2);
				kbUnitQueryExecute(q_id);
				for(j=0;<q_len) {
					trUnitSelectClear();
					trUnitSelectByID(kbUnitQueryGetResult(q_id,j));

					trUnitDelete(true);
				}
				kbUnitQueryCreate("Emperor Japanese 7");
				kbUnitQuerySetPlayerID(q_id, i);
				kbUnitQuerySetUnitType(q_id,kbGetProtoUnitID("Emperor Japanese 7"));
				kbUnitQuerySetState(q_id,2);
				kbUnitQueryExecute(q_id);
				for(j=0;<q_len) {
					trUnitSelectClear();
					trUnitSelectByID(kbUnitQueryGetResult(q_id,j));

					trUnitDelete(true);
				}
				kbUnitQueryCreate("Emperor Japanese 1 Dead");
				kbUnitQuerySetPlayerID(q_id, i);
				kbUnitQuerySetUnitType(q_id,kbGetProtoUnitID("Emperor Japanese 1 Dead"));
				kbUnitQuerySetState(q_id,2);
				kbUnitQueryExecute(q_id);
				for(j=0;<q_len) {
					trUnitSelectClear();
					trUnitSelectByID(kbUnitQueryGetResult(q_id,j));

					trUnitDelete(false);
				}
				kbUnitQueryCreate("Emperor Japanese 2 Dead");
				kbUnitQuerySetPlayerID(q_id, i);
				kbUnitQuerySetUnitType(q_id,kbGetProtoUnitID("Emperor Japanese 2 Dead"));
				kbUnitQuerySetState(q_id,2);
				kbUnitQueryExecute(q_id);
				for(j=0;<q_len) {
					trUnitSelectClear();
					trUnitSelectByID(kbUnitQueryGetResult(q_id,j));

					trUnitDelete(false);
				}
				kbUnitQueryCreate("Emperor Japanese 3 Dead");
				kbUnitQuerySetPlayerID(q_id, i);
				kbUnitQuerySetUnitType(q_id,kbGetProtoUnitID("Emperor Japanese 3 Dead"));
				kbUnitQuerySetState(q_id,2);
				kbUnitQueryExecute(q_id);
				for(j=0;<q_len) {
					trUnitSelectClear();
					trUnitSelectByID(kbUnitQueryGetResult(q_id,j));

					trUnitDelete(false);
				}
				kbUnitQueryCreate("Emperor Japanese 4 Dead");
				kbUnitQuerySetPlayerID(q_id, i);
				kbUnitQuerySetUnitType(q_id,kbGetProtoUnitID("Emperor Japanese 4 Dead"));
				kbUnitQuerySetState(q_id,2);
				kbUnitQueryExecute(q_id);
				for(j=0;<q_len) {
					trUnitSelectClear();
					trUnitSelectByID(kbUnitQueryGetResult(q_id,j));

					trUnitDelete(false);
				}
				kbUnitQueryCreate("Emperor Japanese 5 Dead");
				kbUnitQuerySetPlayerID(q_id, i);
				kbUnitQuerySetUnitType(q_id,kbGetProtoUnitID("Emperor Japanese 5 Dead"));
				kbUnitQuerySetState(q_id,2);
				kbUnitQueryExecute(q_id);
				for(j=0;<q_len) {
					trUnitSelectClear();
					trUnitSelectByID(kbUnitQueryGetResult(q_id,j));

					trUnitDelete(false);
				}
				kbUnitQueryCreate("Emperor Japanese 6 Dead");
				kbUnitQuerySetPlayerID(q_id, i);
				kbUnitQuerySetUnitType(q_id,kbGetProtoUnitID("Emperor Japanese 6 Dead"));
				kbUnitQuerySetState(q_id,2);
				kbUnitQueryExecute(q_id);
				for(j=0;<q_len) {
					trUnitSelectClear();
					trUnitSelectByID(kbUnitQueryGetResult(q_id,j));

					trUnitDelete(false);
				}
			}
		}
	}
}

rule VenusTempleHeal
active
minInterval 1
maxInterval 1
priority 100
{
	int prevPlayer = xsGetContextPlayer();
	for(pid=0;<cNumberPlayers)
	{
		xsSetContextPlayer(pid);
		int Qid = kbUnitQueryCreate("Temple Venus");
		kbUnitQuerySetPlayerID(Qid, pid);
		kbUnitQuerySetUnitType(Qid,kbGetProtoUnitID("Temple Venus"));
		kbUnitQuerySetState(Qid,2);
		
		int num = kbUnitQueryExecute(Qid);
		for(i=0;<num)
		{
			trUnitSelectClear();
			trUnitSelectByID(kbUnitQueryGetResult(Qid,i));
			//trDamageUnitsInArea(pid,"AbstractVillager",30,-1.0);

			for(pid2=1;<cNumberPlayers)
			{		
				if (kbIsPlayerAlly(pid2)) {
					trDamageUnitsInArea(pid2,"AbstractVillager",30,-1.0);
				}
			}
		}
	}
	xsSetContextPlayer(prevPlayer);
}

rule MercuryTempleHeal
active
minInterval 1
maxInterval 1
priority 100
{
	int prevPlayer = xsGetContextPlayer();
	for(pid=0;<cNumberPlayers)
	{
		xsSetContextPlayer(pid);
		int Qid = kbUnitQueryCreate("Temple Mercury");
		kbUnitQuerySetPlayerID(Qid, pid);
		kbUnitQuerySetUnitType(Qid,kbGetProtoUnitID("Temple Mercury"));
		kbUnitQuerySetState(Qid,2);
		
		int num = kbUnitQueryExecute(Qid);
		for(i=0;<num)
		{
			trUnitSelectClear();
			trUnitSelectByID(kbUnitQueryGetResult(Qid,i));
			//trDamageUnitsInArea(pid,"AbstractTradeUnit",40,-5.0);
			for(pid2=1;<cNumberPlayers)
			{		
				if (kbIsPlayerAlly(pid2)) {
					trDamageUnitsInArea(pid2,"AbstractTradeUnit",40,-5.0);
				}
			}
		}
	}
	xsSetContextPlayer(prevPlayer);
}


rule CeresTempleFood
active
minInterval 1
maxInterval 1
priority 100
{
	int prevPlayer = xsGetContextPlayer();
	for(pid=0;<cNumberPlayers)
	{
		xsSetContextPlayer(pid);
		int Qid = kbUnitQueryCreate("Temple Ceres");
		kbUnitQuerySetPlayerID(Qid, pid);
		kbUnitQuerySetUnitType(Qid,kbGetProtoUnitID("Temple Ceres"));
		kbUnitQuerySetState(Qid,2);
		
		int num = kbUnitQueryExecute(Qid);
		for(i=0;<num)
		{
			int foodCeres = 0;
			//trUnitSelectClear();
			//trUnitSelectByID(kbUnitQueryGetResult(Qid,i));
			//trDamageUnitsInArea(pid,"AbstractTradeUnit",40,-5.0);

			int Qid2 = kbUnitQueryCreate("Farm");
			kbUnitQuerySetPlayerID(Qid2, pid);
			kbUnitQuerySetUnitType(Qid2,kbGetProtoUnitID("Farm"));
			kbUnitQuerySetState(Qid2,2);
		
			int num2 = kbUnitQueryExecute(Qid2);
			for(i2=0;<num2)
			{
				trUnitSelectClear();
				trUnitSelectByID(kbUnitQueryGetResult(Qid2,i2));
				if (trUnitDistanceToUnitID(kbUnitQueryGetResult(Qid,i)) <= 18.0)
				{
					foodCeres = foodCeres + 5;
				}
			}
			trPlayerGrantResources(pid, "Food", foodCeres);
		}
	}
	xsSetContextPlayer(prevPlayer);
}

rule MarsTemple
active
minInterval 1
maxInterval 1
priority 100
{
	int prevPlayer = xsGetContextPlayer();
	for(pid=0;<cNumberPlayers)
	{
		xsSetContextPlayer(pid);
		int Qid = kbUnitQueryCreate("Temple Mars");
		kbUnitQuerySetPlayerID(Qid, pid);
		kbUnitQuerySetUnitType(Qid,kbGetProtoUnitID("Temple Mars"));
		kbUnitQuerySetState(Qid,2);
		
		int num = kbUnitQueryExecute(Qid);
		for(i=0;<num)
		{
			trUnitSelectClear();
			trUnitSelectByID(kbUnitQueryGetResult(Qid,i));
			//trDamageUnitsInArea(pid,"HumanSoldier",15,-1.0);

			for(pid2=1;<cNumberPlayers)
			{		
				if (kbIsPlayerEnemy(pid2)) {
					trDamageUnitsInArea(pid2,"HumanSoldier",20,2.0);
				} else if (kbIsPlayerAlly(pid2)) {
					trDamageUnitsInArea(pid,"HumanSoldier",15,-1.0);
				}
			}
		}
	}
	xsSetContextPlayer(prevPlayer);
}

