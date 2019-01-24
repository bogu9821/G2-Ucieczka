
instance NASZ_303_Nod (Npc_Default)
{
	// ------ NSC ------
	name 		= "Nod"; 
	guild 		= GIL_SLD;
	id 			= 303;
	voice 		= 2;
	flags       = 2;							//NPC_FLAG_IMMORTAL oder 0
	npctype		= NPCTYPE_OCAMBIENT;
	
	aivar[AIV_IgnoresArmor] 	= TRUE;

	// ------ Attribute ------
	B_SetAttributesToChapter (self, 4);																	//setzt Attribute und LEVEL entsprechend dem angegebenen Kapitel (1-6)
		
	// ------ Kampf-Taktik ------
	fight_tactic		= FAI_HUMAN_MASTER;	// MASTER / STRONG / COWARD
	
	// ------ Equippte Waffen ------																	//Munition wird automatisch generiert, darf aber angegeben werden
	EquipItem			(self, ItNa_Ban_Weapon_M);
	
	// ------ Inventory ------
	B_CreateAmbientInv 	(self);
	
		
	// ------ visuals ------																			//Muss NACH Attributen kommen, weil in B_SetNpcVisual die Breite abh. v. STR skaliert wird
	
	B_SetNpcVisual 		(self, MALE, "Hum_Head_Bald", Face_N_Weak_BaalNetbek, BodyTex_N, ITNA_BAN_H);	
	Mdl_SetModelFatness    (self, 2);
	//by FC	);
	Mdl_ApplyOverlayMds	(self, "Humans_Relaxed.mds"); // Tired / Militia / Mage / Arrogance / Relaxed
	
	// ------ NSC-relevante Talente vergeben ------
	B_GiveNpcTalents (self);
	
	// ------ Kampf-Talente ------																		//Der enthaltene B_AddFightSkill setzt Talent-Ani abh�ngig von TrefferChance% - alle Kampftalente werden gleichhoch gesetzt
	B_SetFightSkills (self, 80); //Grenzen f�r Talent-Level liegen bei 30 und 60

	// ------ TA anmelden ------
	daily_routine 		= Rtn_Start_303;
};

FUNC VOID Rtn_Start_303 ()
{	
	TA_Sit_Throne		(08,00,22,00,"NASZ_BANDYCI_TRON_01");
  TA_Smalltalk 			(22,00,08,00,"NASZ_BANDYCI_TRON_03");
};

FUNC VOID Rtn_Artefakt_303 ()
{	
	TA_RunToWP		(08,00,22,00,"OW_PATH_092");
 TA_RunToWP		(22,00,08,00,"OW_PATH_092");
};

FUNC VOID Rtn_Przelacznik_303 ()
{	
	TA_Stand_ArmsCrossed		(08,00,22,00,"OW_PATH_093");
 TA_Stand_ArmsCrossed		(22,00,08,00,"OW_PATH_093");
};
