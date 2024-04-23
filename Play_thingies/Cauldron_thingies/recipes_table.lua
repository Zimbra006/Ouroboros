--[[
    stores all the recipes in game
]]

MAGIC_DUST = 1
GREAT_FLOWER = 2
SNAKE_VENOM = 3
DREAM_CRYSTAL = 5
TREE_BRANCH = 6
DINOS_ESSENCE = 8
ORCS_EYE = 11
INFERNAL_ICE = 13

recipes = {
    {
        firstIngredient = MAGIC_DUST, 
        secondIngredient = GREAT_FLOWER, 
        effect = 'poof',
        unlocked = true,
        firstIngredientName = language.ingredientsNames.magicDust,
        secondIngredientName = language.ingredientsNames.greatFlower,
        effectName = 'Wavius Disaperius'
    },
    {
        firstIngredient = MAGIC_DUST, 
        secondIngredient = SNAKE_VENOM, 
        effect = 'disapear_three',
        unlocked = true,
        firstIngredientName = language.ingredientsNames.magicDust,
        secondIngredientName = language.ingredientsNames.snakeVenom,
        effectName = 'Trius Disaperius'
    },
    {
        firstIngredient = MAGIC_DUST, 
        secondIngredient = DREAM_CRYSTAL, 
        effect = 'stronger_shot',
        unlocked = true,
        firstIngredientName = language.ingredientsNames.magicDust,
        secondIngredientName = language.ingredientsNames.dreamCrystal,
        effectName = 'Tirus Fortius'
    },
    {
        firstIngredient = MAGIC_DUST, 
        secondIngredient = TREE_BRANCH, 
        effect = 'next_jump',
        unlocked = true,
        firstIngredientName = language.ingredientsNames.magicDust,
        secondIngredientName = language.ingredientsNames.treeBranch,
        effectName = 'Deinde Preocuppo'
    },
    {
        firstIngredient = MAGIC_DUST, 
        secondIngredient = DINOS_ESSENCE, 
        effect = 'meteor',
        unlocked = true,
        firstIngredientName = language.ingredientsNames.magicDust,
        secondIngredientName = language.ingredientsNames.dinosEssence,
        effectName = 'Meteorum'
    },
    {
        firstIngredient = MAGIC_DUST, 
        secondIngredient = ORCS_EYE, 
        effect = 'abundance',
        unlocked = true,
        firstIngredientName = language.ingredientsNames.magicDust,
        secondIngredientName = language.ingredientsNames.orcsEye,
        effectName = 'Abundantia'
    },
    {
        firstIngredient = MAGIC_DUST, 
        secondIngredient = INFERNAL_ICE, 
        effect = 'freeze',
        unlocked = true,
        firstIngredientName = language.ingredientsNames.magicDust,
        secondIngredientName = language.ingredientsNames.infernalIce,
        effectName = 'Glacies'
    },
    {
        firstIngredient = GREAT_FLOWER, 
        secondIngredient = SNAKE_VENOM, 
        effect = 'poison',
        unlocked = true,
        firstIngredientName = language.ingredientsNames.greatFlower,
        secondIngredientName = language.ingredientsNames.snakeVenom,
        effectName = 'Venenum'
    },
    {
        firstIngredient = GREAT_FLOWER, 
        secondIngredient = DREAM_CRYSTAL, 
        effect = 'seduction',
        unlocked = true,
        firstIngredientName = language.ingredientsNames.greatFlower,
        secondIngredientName = language.ingredientsNames.dreamCrystal,
        effectName = 'Fascinare'
    },
    {
        firstIngredient = GREAT_FLOWER, 
        secondIngredient = TREE_BRANCH, 
        effect = 'next_weak',
        unlocked = true,
        firstIngredientName = language.ingredientsNames.greatFlower,
        secondIngredientName = language.ingredientsNames.treeBranch,
        effectName = 'Deinde Infirma'
    },
    {
        firstIngredient = GREAT_FLOWER, 
        secondIngredient = DINOS_ESSENCE, 
        effect = 'boss_drops',
        unlocked = true,
        firstIngredientName = language.ingredientsNames.greatFlower,
        secondIngredientName = language.ingredientsNames.dinosEssence,
        effectName = 'Fortis Ingrediens'
    },
    {
        firstIngredient = GREAT_FLOWER, 
        secondIngredient = ORCS_EYE, 
        effect = 'delay_wave',
        unlocked = true,
        firstIngredientName = language.ingredientsNames.orcsEye,
        secondIngredientName = language.ingredientsNames.greatFlower,
        effectName = 'Wavius Demorus'
    },
    {
        firstIngredient = GREAT_FLOWER, 
        secondIngredient = INFERNAL_ICE, 
        effect = 'more_hearts',
        unlocked = true,
        firstIngredientName = language.ingredientsNames.greatFlower,
        secondIngredientName = language.ingredientsNames.infernalIce,
        effectName = 'Plus Vita'
    },
    {
        firstIngredient = SNAKE_VENOM, 
        secondIngredient = DREAM_CRYSTAL, 
        effect = 'more_ingredients',
        unlocked = true,
        firstIngredientName = language.ingredientsNames.snakeVenom,
        secondIngredientName = language.ingredientsNames.dreamCrystal,
        effectName = 'Plus Ingrediens'
    },
    {
        firstIngredient = SNAKE_VENOM, 
        secondIngredient = TREE_BRANCH, 
        effect = 'half_gone',
        unlocked = true,
        firstIngredientName = language.ingredientsNames.treeBranch,
        secondIngredientName = language.ingredientsNames.snakeVenom,
        effectName = 'Medium Disaperius'
    },
    {
        firstIngredient = SNAKE_VENOM, 
        secondIngredient = DINOS_ESSENCE, 
        effect = 'money_end',
        unlocked = true,
        firstIngredientName = language.ingredientsNames.snakeVenom,
        secondIngredientName = language.ingredientsNames.dinosEssence,
        effectName = 'Pecunia'
    },
    {
        firstIngredient = SNAKE_VENOM, 
        secondIngredient = ORCS_EYE, 
        effect = 'coins_per_kill',
        unlocked = true,
        firstIngredientName = language.ingredientsNames.orcsEye,
        secondIngredientName = language.ingredientsNames.snakeVenom,
        effectName = 'Mortem Abundantia'
    },
    {
        firstIngredient = SNAKE_VENOM, 
        secondIngredient = INFERNAL_ICE, 
        effect = 'half_waves',
        unlocked = true,
        firstIngredientName = language.ingredientsNames.snakeVenom,
        secondIngredientName = language.ingredientsNames.infernalIce,
        effectName = 'Wavius Mediums'
    },
    {
        firstIngredient = DREAM_CRYSTAL, 
        secondIngredient = TREE_BRANCH, 
        effect = 'one_hp',
        unlocked = true,
        firstIngredientName = language.ingredientsNames.treeBranch,
        secondIngredientName = language.ingredientsNames.dreamCrystal,
        effectName = 'Wavius Infirma'
    },
    {
        firstIngredient = DREAM_CRYSTAL, 
        secondIngredient = DINOS_ESSENCE, 
        effect = 'slowness',
        unlocked = true,
        firstIngredientName = language.ingredientsNames.dreamCrystal,
        secondIngredientName = language.ingredientsNames.dinosEssence,
        effectName = 'Tarda'
    },
    {
        firstIngredient = DREAM_CRYSTAL, 
        secondIngredient = ORCS_EYE, 
        effect = 'short_waves',
        unlocked = true,
        firstIngredientName = language.ingredientsNames.orcsEye,
        secondIngredientName = language.ingredientsNames.dreamCrystal,
        effectName = 'Wavius Curtis'
    },
    {
        firstIngredient = DREAM_CRYSTAL, 
        secondIngredient = INFERNAL_ICE, 
        effect = 'faster_shot',
        unlocked = true,
        firstIngredientName = language.ingredientsNames.dreamCrystal,
        secondIngredientName = language.ingredientsNames.infernalIce,
        effectName = 'Tirus Rapidus'
    },
    {
        firstIngredient = TREE_BRANCH, 
        secondIngredient = DINOS_ESSENCE, 
        effect = 'less_per_kill',
        unlocked = true,
        firstIngredientName = language.ingredientsNames.treeBranch,
        secondIngredientName = language.ingredientsNames.dinosEssence,
        effectName = 'Mortem Shorten'
    },
    {
        firstIngredient = TREE_BRANCH, 
        secondIngredient = ORCS_EYE, 
        effect = 'double_ingredients',
        unlocked = true,
        firstIngredientName = language.ingredientsNames.orcsEye,
        secondIngredientName = language.ingredientsNames.treeBranch,
        effectName = 'Geminus Ingrediens'
    },
    {
        firstIngredient = TREE_BRANCH, 
        secondIngredient = INFERNAL_ICE, 
        effect = 'plus_one_ingredients',
        unlocked = true,
        firstIngredientName = language.ingredientsNames.treeBranch,
        secondIngredientName = language.ingredientsNames.infernalIce,
        effectName = 'Ingrediens Abundantia'
    },
    {
        firstIngredient = DINOS_ESSENCE, 
        secondIngredient = ORCS_EYE, 
        effect = 'freeze_timed',
        unlocked = true,
        firstIngredientName = language.ingredientsNames.orcsEye,
        secondIngredientName = language.ingredientsNames.dinosEssence,
        effectName = 'Glacies Curtis'
    },
    {
        firstIngredient = DINOS_ESSENCE, 
        secondIngredient = INFERNAL_ICE, 
        effect = 'boss_weak',
        unlocked = true,
        firstIngredientName = language.ingredientsNames.dinosEssence,
        secondIngredientName = language.ingredientsNames.infernalIce,
        effectName = 'Fortis Infirma'
    },
    {
        firstIngredient = ORCS_EYE, 
        secondIngredient = INFERNAL_ICE, 
        effect = 'money_times_money ',
        unlocked = true,
        firstIngredientName = language.ingredientsNames.orcsEye,
        secondIngredientName = language.ingredientsNames.infernalIce,
        effectName = 'Plus Pecunia'
    },

}