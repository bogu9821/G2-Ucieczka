var int B_Greg_ComesToDexter_OneTime;
func void B_Greg_ComesToDexter ()
{
	
		if (B_Greg_ComesToDexter_OneTime == FALSE)
		{
			//dexter.aivar[AIV_EnemyOverride] = FALSE;
			GregLocation = Greg_Dexter;
			//B_StartOtherRoutine	(Greg_NW,"Dexter");
			//Wld_InsertNpc 	(Giant_Rat,"NW_CASTLEMINE_TOWER_CAMPFIRE_02"); //Mike: nicht mehr n�tig (AI-Fix)
			B_Greg_ComesToDexter_OneTime = TRUE;
		};
	
};
