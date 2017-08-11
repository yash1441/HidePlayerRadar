#pragma semicolon 1 
#include <sdktools> 

Handle g_hSetIsSpotted, g_hClearSpottedBy; 

//In fact these are flags Spotted the player, to understand them laziness but by default 9, 0 - blocks player update on the radar 
//I did not notice that the game changed the flags in the middle of the game, player can change commands but the value does not change, as i understand it is put only 1 time at the entrance 
Address g_aCanBeSpotted = view_as<Address>(892); //windows 868 

public void OnPluginStart() 
{ 
    //I was looking for functions only for linux, you can do it without them but then you will understand what they are for 
    StartPrepSDKCall(SDKCall_Entity); 
    PrepSDKCall_SetSignature(SDKLibrary_Server, "\x55\x89\xE5\x83\xEC\x48\x0F\xB6\x55\x0C", 10); //linux 
    PrepSDKCall_AddParameter(SDKType_PlainOldData, SDKPass_Plain); 
    g_hSetIsSpotted = EndPrepSDKCall(); 
    
    StartPrepSDKCall(SDKCall_Entity); 
    PrepSDKCall_SetSignature(SDKLibrary_Server, "\x55\xB9\x04\x00\x00\x00\x89\xE5\x83\xEC\x48\x8B\x45\x08", 14); //linux 
    g_hClearSpottedBy = EndPrepSDKCall(); 
    
    
    
    RegConsoleCmd("hide", hide);  
    RegConsoleCmd("uhide", uhide);  
} 

public Action hide(int iClient, int args)  
{ 
    //It is necessary that when we block update player on the radar, he did not remain constantly visible on it 
    //Without them you need to block update only when player is visible on the radar(Player does not see enemy player), Otherwise it will be visible through whole map to all opponents 
    SDKCall(g_hSetIsSpotted, iClient, 0); 
    SDKCall(g_hClearSpottedBy, iClient); 
    
    //set flags to 0 
    StoreToAddress(GetEntityAddress(iClient)+g_aCanBeSpotted, 0, NumberType_Int32); 
} 

public Action uhide(int iClient, int args)  
{ 
    //Flags are set by default 
    StoreToAddress(GetEntityAddress(iClient)+g_aCanBeSpotted, 9, NumberType_Int32); 
}  
