const string DiffLevelError = "B��d z ustawieniem poziomu trudno�ci. Zosta� on automatycznie ustawiony na normalny. Mo�esz zmieni� go w menu.";
const string JusticeError = "B��d z ustawieniem trybu sprawiedliwo�ci. Zosta� on automatycznie ustawiony na zero. Mo�esz zmieni� go w menu.";

const int Easy = 0;			const int EasyDmg = 125; 		const int EasyEnemyDmg = 75;
const int Normal = 1; 		const int NormalDmg = 100; 		const int NormalEnemyDmg = 100;
const int Hard = 2;			const int HardDmg = 75; 		const int HardEnemyDmg = 125;
const int SuperHard = 2;	const int SuperHardDmg = 70; 	const int SuperHardEnemyDmg = 150;
const int Legendary = 4;	const int LegendaryDmg = 50; 	const int LegendaryEnemyDmg = 200;
const int defaultDMG = 5;
const int hundred = 100;

CONST INT SEL_ACTION_UNDEF			= 0;
CONST INT SEL_ACTION_BACK			= 1;
CONST INT SEL_ACTION_STARTMENU		= 2;
CONST INT SEL_ACTION_STARTITEM		= 3;
CONST INT SEL_ACTION_CLOSE			= 4;
CONST INT SEL_ACTION_CONCOMMANDS	= 5;			// -> console commands
CONST INT SEL_ACTION_PLAY_SOUND		= 6;
CONST INT SEL_ACTION_EXECCOMMANDS	= 7;			// -> dynamic build in func.


CONST INT MENU_ITEM_UNDEF		= 0;
CONST INT MENU_ITEM_TEXT		= 1;
CONST INT MENU_ITEM_SLIDER		= 2;
CONST INT MENU_ITEM_INPUT		= 3;
CONST INT MENU_ITEM_CURSOR		= 4;
CONST INT MENU_ITEM_CHOICEBOX	= 5;
CONST INT MENU_ITEM_BUTTON		= 6;
CONST INT MENU_ITEM_LISTBOX		= 7;

CONST INT IT_CHROMAKEYED		= 1;
CONST INT IT_TRANSPARENT		= 2;
CONST INT IT_SELECTABLE			= 4;
CONST INT IT_MOVEABLE			= 8;
CONST INT IT_TXT_CENTER			= 16;
CONST INT IT_DISABLED			= 32;
CONST INT IT_FADE				= 64;
const int IT_EFFECTS_NEXT		= 128;
CONST INT IT_ONLY_IN_GAME		= 512;
CONST INT IT_PERF_OPTION		= 1024;
const int IT_MULTILINE			= 2048;
const int IT_NEEDS_APPLY 		= 4096;			 // die mit dem Menuepunkt verknuepfte Option wird NUR ueber ein APPLY aktiv
const int IT_NEEDS_RESTART		= 8192; 		// die mit dem Menuepunkt verknuepfte Option wird NUR ueber ein RESTART aktiv
const int IT_EXTENDED_MENU		= 16384;

var int diffLevel;
var int JuiceMode;
instance m (zCMenuItem);
func int GetDiffLvl()
{	
	var int mPtr; mPtr =  MEM_GetMenuItemByString ("MENUITEM_OPT_JUSTICE");
	//var zCMenuItem m; 
	if(!mPtr) {return -1;};
	MEM_AssignInst (m, mPtr);
	//m.m_parItemFlags = m.m_parItemFlags | IT_SELECTABLE;
	
	var int section; section = MEM_GothOptExists ("UCIECZKA", "selectLevel");
	var int Justice; Justice = MEM_GothOptExists ("UCIECZKA", "useJustice");
	
	if(!Justice)
	{
		MEM_SetGothOpt ("UCIECZKA", "useJustice", "0");
		MEM_InfoBox(DiffLevelError);
	};
	
	if(!section)
	{
		MEM_SetGothOpt ("UCIECZKA", "selectLevel", "2");
		MEM_InfoBox(JusticeError);
	};
	
	diffLevel = STR_ToInt(MEM_GetGothOpt("UCIECZKA", "selectLevel"));
	
	if(diffLevel >= Hard)
	{
		MEM_SetGothOpt ("UCIECZKA", "useJustice", "1");
		m.m_parItemFlags = m.m_parItemFlags | IT_ONLY_OUT_GAME;
		JuiceMode = true;
	}
	else
	{
		m.m_parItemFlags = m.m_parItemFlags & ~IT_ONLY_OUT_GAME;
		if(!STR_ToInt(MEM_GetGothOpt("UCIECZKA", "useJustice")))
		{
			JuiceMode = false;
		};
	};
	
	return diffLevel;
};

func int DiffCalcDmg(var int dmg)
{
	if(diffLevel == Easy)
	{
		dmg = (dmg*EasyDmg)/hundred;
	}
	else if(diffLevel == Normal)
	{
		//dmg= (dmg*NormalDmg)/hundred;
		return dmg;
	}
	else if (difflevel == hard)
	{
		dmg = (dmg*HardDmg)/hundred;
	}	
	else if (difflevel == superhard)
	{
		dmg = (dmg*SuperHardDmg)/hundred;
	}
	else
	{
		dmg = (dmg*LegendaryDmg)/hundred;
	};
	
	if(dmg < defaultDMG)
	{
		dmg = defaultDMG;
	};
	
	return dmg;
};

func int DiffEnemyDmg(var int dmg)
{
	if(diffLevel == Easy)
	{
		dmg = (dmg*EasyEnemyDmg)/hundred;
	}
	else if(diffLevel == Normal)
	{
		//dmg= (dmg*NormalEnemyDmg)/100;
		return dmg;
	}
	else if (diffLevel == hard)
	{
		dmg  = (dmg*HardEnemyDmg)/hundred;
	}	
	else if (difflevel == superhard)
	{
		dmg = (dmg*SuperHardEnemyDmg)/hundred;
	}
	else
	{
		dmg = (dmg*LegendaryEnemyDmg)/hundred;
	};
	
	if(dmg < defaultDMG)
	{
		dmg = defaultDMG;
	};
	
	return dmg;
};

func int DiffCalcDmgAll(var int dmg, var c_npc slf)
{
	if(Npc_IsPlayer(slf))
	{
		dmg = DiffCalcDmg(dmg);
		return dmg;
	};
	dmg = DiffEnemyDmg(dmg);
	return dmg;
};



func void Update_Menu_Item(var string name, var string val) 
{
    var int itPtr;
    itPtr = MEM_GetMenuItemByString(name);
        
    if (!itPtr) 
	{
        MEM_Error(ConcatStrings("Update_Menu_Item: Invalid Menu Item: ", name));
        return;
    };
        
    //void __thiscall zCMenuItem::SetText(val = val, line = 0, drawNow = true)
    const int SetText = 5114800;
        
    CALL_IntParam(true);
    CALL_IntParam(false);
    CALL_zStringPtrParam(val);
    CALL__thiscall(itPtr, SetText);
};
    
const int oCMenu_Status__SetLearnPoints = 4707920;
const int oCMenu_Status__SetLearnPoints_Len = 6;
func void Install_Character_Menu_Hook() 
{
	const int done = false;
	if(!done) 
	{
	   HookEngineF(oCMenu_Status__SetLearnPoints, oCMenu_Status__SetLearnPoints_Len, Update_Character_Menu);
	   
	   //poziom trudno�ci
	   HookEngineF(cGameManager__ApplySomeSettings_rtn, 6, GetDiffLvl);
	   done = true;
	};
};

func void Update_Character_Menu() {

    var string StatusReputacji;
	if (rep_lowcy_s) >= 0  { StatusReputacji = "Nikt"; };
	if (rep_lowcy_s) >= 10 { StatusReputacji = "Pomocnik"; };
	if (rep_lowcy_s) >= 25 { StatusReputacji = "Kompan"; };
	if (rep_lowcy_s) >= 50 { StatusReputacji = "Zaufany"; };
	if (rep_lowcy_s) >= 75 { StatusReputacji = "Przyjaciel"; };
	if (rep_lowcy_s) >= 90 { StatusReputacji = "Brat"; };

	Update_Menu_Item("MENU_ITEM_REPUTATION_1_RANGE", StatusReputacji);
	Update_Menu_Item("MENU_ITEM_REPUTATION_1_VAL", IntToString(rep_lowcy_s));
	
	if (rep_mysliwi_s) >= 0  { StatusReputacji = "Nikt"; };
	if (rep_mysliwi_s) >= 10 { StatusReputacji = "Pomocnik"; };
	if (rep_mysliwi_s) >= 25 { StatusReputacji = "Kompan"; };
	if (rep_mysliwi_s) >= 50 { StatusReputacji = "Zaufany"; };
	if (rep_mysliwi_s) >= 75 { StatusReputacji = "Przyjaciel"; };
	if (rep_mysliwi_s) >= 90 { StatusReputacji = "Brat"; };

    Update_Menu_Item("MENU_ITEM_REPUTATION_2_RANGE", StatusReputacji);
	Update_Menu_Item("MENU_ITEM_REPUTATION_2_VAL", IntToString(rep_mysliwi_s));
	
	if (WillKnowBanditReputation == TRUE)
	{
		if (rep_bandyci_s) >= 0  { StatusReputacji = "Nikt"; };
		if (rep_bandyci_s) >= 10 { StatusReputacji = "Pomocnik"; };
		if (rep_bandyci_s) >= 25 { StatusReputacji = "Kompan"; };
		if (rep_bandyci_s) >= 50 { StatusReputacji = "Zaufany"; };
		if (rep_bandyci_s) >= 75 { StatusReputacji = "Przyjaciel"; };
		if (rep_bandyci_s) >= 90 { StatusReputacji = "Brat"; };
		
		Update_Menu_Item(" MENU_ITEM_REPUTATION_3_TITLE", "U bandyt�w:");
		Update_Menu_Item("MENU_ITEM_REPUTATION_3_RANGE", StatusReputacji);
		Update_Menu_Item("MENU_ITEM_REPUTATION_3_VAL", IntToString(rep_bandyci_s));
	} else {
		// nic sie nie wyswietla
		Update_Menu_Item("MENU_ITEM_REPUTATION_3_TITLE", "");
		Update_Menu_Item("MENU_ITEM_REPUTATION_3_RANGE", "");
		Update_Menu_Item("MENU_ITEM_REPUTATION_3_VAL", "");
	};

};