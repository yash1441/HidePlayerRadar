#pragma semicolon 1 
#include <sdktools> 

//In fact these are flags Spotted the player, to understand them laziness but by default 9, 0 - blocks player update on the radar 
//I did not notice that the game changed the flags in the middle of the game, player can change commands but the value does not change, as i understand it is put only 1 time at the entrance 
Address g_aCanBeSpotted = view_as<Address>(892); //windows 868 

public void OnPluginStart() 
{ 
    RegConsoleCmd("hide", hide);  
    RegConsoleCmd("uhide", uhide);  
} 

public Action hide(int iClient, int args)  
{ 
    //It is necessary that when we block update player on the radar, he did not remain constantly visible on it 
    SetEntProp(iClient, Prop_Send, "m_bSpotted", false); 
    SetEntProp(iClient, Prop_Send, "m_bSpottedByMask", 0, 4, 0); 
    SetEntProp(iClient, Prop_Send, "m_bSpottedByMask", 0, 4, 1); 
    
    //set flags to 0 
    StoreToAddress(GetEntityAddress(iClient)+g_aCanBeSpotted, 0, NumberType_Int32); 
} 

public Action uhide(int iClient, int args)  
{ 
    //Flags are set by default 
    StoreToAddress(GetEntityAddress(iClient)+g_aCanBeSpotted, 9, NumberType_Int32); 
}  
