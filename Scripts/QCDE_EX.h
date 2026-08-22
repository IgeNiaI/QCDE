#linklibrary "QCDE_EX"

enum
{
    QCDE_EX_VOX_COUNT,
    QCDE_EX_VOX_SUBTITLE
};

extern void QCDE_EX_AddClass (str class, str displayName, str portrait, int health, int armor,
                              str tickScript, int activeCooldown = 35, int activeCooldownPVE = 35, int activeDuration = 35,
                              int activeDurationPVE = 35, str activeAbilityScript = null, str activeIconOn = null, str activeIconOff = null,
                              bool activeMultiuse = false, int multiuseCooldown = 0, str multiuseFailSnd = null, str voiceCallback = null);
extern void QCDE_EX_UpdateStacks (str class);
extern void QCDE_EX_CallActiveAbility (str class);

extern int QCDE_EX_GetActiveCooldown (str class);
extern int QCDE_EX_GetActiveDuration (str class);
extern int QCDE_EX_GetActiveMultiuse (str class);
extern int QCDE_EX_GetMultiuseFailSnd (str class);
extern int QCDE_EX_GetMultiuseCooldown (str class);
extern str QCDE_EX_GetVoiceCallback (str class);
