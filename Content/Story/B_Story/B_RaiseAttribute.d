// ****************
// B_RaiseAttribute
// ****************

// ---------------------------------------
func void B_RaiseRealAttributeLearnCounter (var C_NPC oth, var int attrib, var int points)
{
	if 		(attrib == ATR_STRENGTH)	{	oth.aivar[REAL_STRENGTH] = oth.aivar[REAL_STRENGTH] + points;	}
	else if (attrib == ATR_DEXTERITY)	{	oth.aivar[REAL_DEXTERITY] = oth.aivar[REAL_DEXTERITY] + points;	}
	else if (attrib == ATR_MANA_MAX)	{	oth.aivar[REAL_MANA_MAX] = oth.aivar[REAL_MANA_MAX] + points;	};
};
const int Sneak_Anim_Speed = 20;
// ---------------------------------------
func void B_RaiseAttribute (var C_NPC oth, var int attrib, var int points, var int real_attribute)
{
	var string concatText;
	
	// ------ STR steigern ------
	if (attrib == ATR_STRENGTH)			
	{	
		oth.attribute[ATR_STRENGTH] = oth.attribute[ATR_STRENGTH] + points;				//bzw. Npc_ChangeAttribute (oth, attrib, points);
		
		concatText = ConcatStrings(PRINT_LearnSTR, IntToString(points));
		//PrintScreen	(concatText, -1, -1, FONT_SCREEN, 2);
		PrintS_Ext(concatText, RGBA(255,255,255,0));
	};
	
	// ------ DEX steigern ------
	if (attrib == ATR_DEXTERITY)			
	{	
		oth.attribute[ATR_DEXTERITY] = oth.attribute[ATR_DEXTERITY] + points;

			if (oth.attribute[ATR_DEXTERITY] >= 90)
			&& (Npc_GetTalentSkill (oth, NPC_TALENT_ACROBAT) == 0)
			{
				//Npc_SetTalentSkill 	(oth, NPC_TALENT_ACROBAT, 1);
				//PrintScreen	(PRINT_Addon_AcrobatBonus, -1, 55, FONT_Screen, 2);
			};
			
		var int speed; speed = (oth.attribute[ATR_DEXTERITY]*points)/100;
		Set_AniSpeed(oth, STR_UPPER("s_sneakl"),Sneak_Anim_Speed+speed);
		Set_AniSpeed(oth, STR_UPPER("s_sneakbl"),Sneak_Anim_Speed+speed);
		Set_AniSpeed(oth, STR_UPPER("t_sneak_2_sneakbl"),Sneak_Anim_Speed+speed);
		//Set_AniSpeed(oth, STR_UPPER("t_cbowsneak_2_bowsneakl"),Sneak_Anim_Speed+speed);
		Set_AniSpeed(oth, STR_UPPER("t_bowsneak_2_bowsneakl"),Sneak_Anim_Speed+speed);
		Set_AniSpeed(oth, STR_UPPER("s_cbowsneakl"),Sneak_Anim_Speed+speed);
		Set_AniSpeed(oth, STR_UPPER("s_bowsneakl"),Sneak_Anim_Speed+speed);
		Set_AniSpeed(oth, STR_UPPER("t_sneakbl_2_sneak"),Sneak_Anim_Speed+speed);
		Set_AniSpeed(oth, STR_UPPER("t_sneakbl_2_sneak"),Sneak_Anim_Speed+speed);
		Sneak_Anim_Speed+=speed;

		concatText = ConcatStrings(PRINT_LearnDEX, IntToString(points));
		//PrintScreen	(concatText, -1, -1, FONT_SCREEN, 2);
		PrintS_Ext(concatText, RGBA(255,255,255,0));
	};
	
	// ------ MANA_MAX steigern ------
	if (attrib == ATR_MANA_MAX)			
	{	
		oth.attribute[ATR_MANA_MAX] = oth.attribute[ATR_MANA_MAX] + points;

		concatText = ConcatStrings(PRINT_LearnMANA_MAX, IntToString(points));
		//PrintScreen	(concatText, -1, -1, FONT_SCREEN, 2);
		PrintS_Ext(concatText, RGBA(255,255,255,0));
	};
	
	// ------ HITPOINTS_MAX steigern ------
	if (attrib == ATR_HITPOINTS_MAX)			
	{	
		oth.attribute[ATR_HITPOINTS_MAX] = oth.attribute[ATR_HITPOINTS_MAX] + points;

		concatText = ConcatStrings(PRINT_Learnhitpoints_MAX, IntToString(points));
		//PrintScreen	(concatText, -1, -1, FONT_SCREEN, 2);
		PrintS_Ext(concatText, RGBA(255,255,255,0));
	};
	
	if (real_attribute) {
		B_RaiseRealAttributeLearnCounter (oth, attrib, points);
	};
};
