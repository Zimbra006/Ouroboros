--[[
    Support for multiple languages
]]


english = {
    -- English language
    metalanguage = 'English',
    play = 'Play',
    language = 'Language',
    road = 'Road',
    roadDesc = 'Where enemies walk.',
    instructions = 'Instructions',
    instructions1 = 'You can choose a tower from the ones available.',
    instructions2 = 'Once chosen, place the tower on the ground, and it will shoot.',
    instructions3 = "Win! Or better, just survive, you can't really win.",
    towersTitle = love.graphics.newImage('Graphics/Book&Titles/titles/TOWERS.png'),
    towers = {
        {
            name = 'Basic',
            desc = 'Reliable'
        },
        {
            name = 'Sniper',
            desc = 'Long-Shot Killer'
        },
        {
            name = 'reCaptain',
            desc = 'Anti-Bot'
        },
        {
            name = 'Glass Tower',
            desc = 'Freezing'
        },
        {
            name = 'Clamp',
            desc = 'Totally not a bot'
        },
        {
            name = 'Magic Light',
            desc = 'The power of the Sun'
        },
        {
            name = 'Caged Flower',
            desc = 'Beware of the curse'
        },
        {
            name = 'Plasma Beam',
            desc = 'Pew pew'
        },
        {
            name = 'Tesla',
            desc = 'Shocking'
        },
        {
            name = 'Sauron',
            desc = 'FIRE DAMAGE!'
        },
        {
            name = 'Cannon',
            desc = 'Kabum!!'
        },
        {
            name = 'Tank',
            desc = 'Massive Kabum!!'
        }
    },
    towerBaseStats = 'Base stats:',
    towerStatRange = 'Range',
    towerStatDamage = 'Damage',
    towerStatShootVel = 'Shoot Velocity',
    towerStatShootDelay = 'Shoot Delay',
    objectives = {
        name = 'OBJECTIVES',
        killEnemies = {'Kill ', ' enemies'},
        dealDamage = {'Deal ', ' damage'},
        surviveWaves = {'Survive ', ' waves'},
        killElfs = {'Kill ', ' Elfs'},
        killImps = {'Kill ', ' Imps'},
        killGenies = {'Kill ', ' Genies'},
        killLandMen = {'Kill ', ' Land Men'},
        killDinos = {'Kill ', ' Dinos'},
        killBoitatas = {'Kill ', ' Boitatas'}
    },
    notEnoughMoney = 'Not enough money!',
    pause = 'Paused',
    resume = 'Resume',
    menu = 'Menu',
    restart = 'Restart',
    deathSentence = love.graphics.newImage('Graphics/Details/game_over.png'),
    blocks = {
        {
            name = 'Road',
            desc = 'Where enemies walk'
        },
        {
            name = 'Earth',
            desc = 'Here you can place towers'
        },
        {
            name = 'Portal',
            desc = 'Enemies come out of here'
        },
        {
            name = 'Base',
            desc = 'Defend it at all costs'
        }
    },
    upgrade = 'Upgrade',
    deckTitle = love.graphics.newImage('Graphics/Book&Titles/titles/CARDS.png'),
    cards = {
        'Halves enemy speed',
        'Adds burning chance',
        'More money',
        'Cheaper towers',
        'Cheaper upgrades',
        'Adds two initial towers',
        'More overall damage',
        'Faster shot'
    },
    yourDeck = 'Your deck',
    stats = {
        highscore = 'Maximum waves survived: ',
        killing = 'Killing:',
        totalKilled = 'How many lives you ended: ',
        boosKilled = 'How many elfs: ',
        meaniesKilled = 'How many imps: ',
        vampirinsKilled = 'How many genies: ',
        skellysKilled = 'How many land men: ',
        dinosKilled = 'How many dinos: ',
        snakiesKilled = 'How many boitatas: ',
        expenses = 'Expenses:',
        towersBought = 'How many towers you bought: ',
        basicsBought = 'How many basics: ',
        snipersBought = 'How many snipers: ',
        cannonsBought = 'How many cannons: ',
        sauronsBought = 'How many saurons: ',
        damage = 'Damage:',
        totalDamage = 'How much damage you did: ',
        basicDamage = 'How much by basic: ',
        sniperDamage = 'How much by sniper: ',
        cannonDamage = 'How much by cannon: ',
        sauronDamage = 'How much by sauron: '
    },
    achievementsTitle = love.graphics.newImage('Graphics/Book&Titles/titles/ACHIEVEMENTS.png'),
    condition = 'Condition:',
    unlock = 'Unlocks:',
    achievementsNames = {
        'Begining',
        'Killer',
        'Hellspawn',
        'MAGIC'
    },
    achievementsDescs = {
        {'Play ', ' game(s)'},
        {'Kill ', ' enemies'},
        {'Kill ', ' Imps'},
        {'Kill ', ' Boos'}
    },
    achievementsUnlocks = {
        'Sniper',
        'Cannon',
        'Sauron',
        'Slowness'
    },
    enemiesTitle = love.graphics.newImage('Graphics/Book&Titles/titles/ENEMIES.png'),
    enemiesNames = {
        'Elf',
        'Imp',
        'Genie',
        'Land Man',
        'Dino',
        'Boitatá',
        'Centaur',
        'Medusa',
        'Old Sage',
        'Witch',
        'Orc',
        'Headless Mula',
        'Black Goat',
        'Ouroboros'
    },
    enemiesDesc = {
        'The most powerful of all magical kingdoms, with powers over the entire earth, created an Land Man, who he recruited to join the group and dominate the world.',
        'Coming from the depths of the earth, he arrived to spread discord and wherever he goes, causing his enemies to divert their attention by arguing with each other and, so that his way is free.',
        'This Genie will not grant you three wishes — if, you accidentally find her, you will be responsible for turning into reality all her wishes.',
        "Created by the hands of the most powerful elf, he's entirely composed by the most fertile and powerful land of the planet and uses its powers to involve those who fight against it through poisonous plants, asphyxiating them.",
        "Straight from the past, he doesn't know where he is, but he feels the power of the tree and is going to eat everyone who stands in his way",
        "Boitatá is a fire snake that is always ready to protect it's bad friends who wants to dominate the world. We are it's enemies.",
        "Barbarian creature, does what it wants and good luck for those who stand in its way.",
        "Medusa is, in Greek mythology, a chthonic female monster and anyone who looks at her is turned into a stone.",
        "He was expelled from the union of wizards for using his powers for evil. Nowadays he's together with the witch to seek planet domination.",
        "The greediest enemy. Able to destroy everyone who crosses her way, so that she can easily dominate the world, spreading her spells over the whole earth.",
        "A creature that has no magical powers, but is undoubtedly the strongest among all monsters. Can destroy everyone who tries to fight against him.",
        "She was a woman who, for her sins, was cursed and condemned to live as headless mule who, today, wants her revenge.",
        "They tell the tale of the black cat because nobody ever survived a black goat.",
        "A being beyond time, even trying to bargain, you will feel stuck in an endless loop "
    },
    recipesTitle = love.graphics.newImage('Graphics/Book&Titles/titles/RECIPES.png'),
    ingredients = 'Ingredients:',
    ingredientsNames = {
        magicDust = 'Magic Dust',
        greatFlower = 'Great Flower',
        snakeVenom = 'Snake Venom',
        dreamCrystal = 'Dream Crystal',
        treeBranch = 'Tree Branch',
        dinosEssence = "Dino's Essence",
        orcsEye = "Orc's Eye",
        infernalIce = 'Infernal Ice'
    },
    effect = 'Effect:'
}
portuguese = {
    -- Portuguese Language
    metalanguage = 'Português',
    play = 'Jogar',
    language = 'Idioma',
    instructions = 'Instruções',
    instructions1 = 'Escolha uma torre dentre as diponíveis.',
    instructions2 = 'Quando se decidir, coloque-a no mapa; ela atirará sozinha.',
    instructions3 = "Ganhe! Ou melhor, só sobreviva, não é como se você fosse ganhar.",
    towersTitle = love.graphics.newImage('Graphics/Book&Titles/titles/TORRES.png'),
    towers = {
        {
            name = 'Básica',
            desc = 'Confiável'
        },
        {
            name = 'Sniper',
            desc = 'Assassino à distância'
        },
        {
            name = 'reCaptain',
            desc = 'Anti-Bot'
        },
        {
            name = 'Torre de Vidro',
            desc = 'Congelante'
        },
        {
            name = 'Clamp',
            desc = 'Obviamente não é um bot'
        },
        {
            name = 'Luz Astral',
            desc = 'O poder do Sol'
        },
        {
            name = 'Flor Aprisionada',
            desc = 'Cuidado com a maldição'
        },
        {
            name = 'Feixe de Plasma',
            desc = 'Pew pew'
        },
        {
            name = 'Tesla',
            desc = 'Chocante'
        },
        {
            name = 'Sauron',
            desc = 'DANO DE FOGO!'
        },
        {
            name = 'Cannon',
            desc = 'Kabum!!'
        },
        {
            name = 'Tank',
            desc = 'Kabum massivo!!'
        }
    },
    towerBaseStats = 'Estatísticas base:',
    towerStatRange = 'Alcance',
    towerStatDamage = 'Dano',
    towerStatShootVel = 'Velocidade de tiro',
    towerStatShootDelay = 'Tempo para atirar',
    objectives = {
        name = 'OBJETIVOS',
        killEnemies = {'Mate ', ' inimigos'},
        dealDamage = {'Dê ', ' de dano'},
        surviveWaves = {'Sobreviva à ', ' ondas'},
        killElfs = {'Mate ', ' Elfos'},
        killImps = {'Mate ', ' Diabretes'},
        killGenies = {'Mate ', ' Gênias'},
        killLandMen = {'Mate ', ' Terríneos'},
        killDinos = {'Mate ', ' Dinos'},
        killBoitatas = {'Mate ', ' Boitatás'}
    },
    notEnoughMoney = 'Sem dinheiro suficiente!',
    pause = 'Pausado',
    resume = 'Resumir',
    menu = 'Menu',
    restart = 'Reiniciar',
    deathSentence = love.graphics.newImage('Graphics/Details/fim_de_jogo.png'),
    blocks = {
        {
            name = 'Estrada',
            desc = 'Por onde inimigos andam'
        },
        {
            name = 'Terra',
            desc = 'Torres são colocadas aqui'
        },
        {
            name = 'Portal',
            desc = 'Daqui saem inimigos'
        },
        {
            name = 'Base',
            desc = 'Defenda a todo custo'
        }
    },
    upgrade = 'Aprimorar',
    deckTitle = love.graphics.newImage('Graphics/Book&Titles/titles/CARTAS.png'),
    cards = {
        'Inimigos mais lentos',
        'Adiciona dano de fogo',
        'Mais dinheiro',
        'Torres barateadas',
        'Aprimoramentos barateados',
        'Adiciona duas torres iniciais',
        'Toda torre da mais dano',
        'Maior frequência de tiro'
    },
    yourDeck = 'Seu deck',
    stats = {
        highscore = 'Máximo de ondas sobrevividas: ',
        killing = 'Matança:',
        totalKilled = 'Quantas vidas você matou: ',
        boosKilled = 'Quantos Boos: ',
        meaniesKilled = 'Quantos diabretes: ',
        vampirinsKilled = 'Quantos vampirins: ',
        skellysKilled = 'Quantos esqueletins: ',
        dinosKilled = 'Quantos dinos: ',
        snakiesKilled = 'Quantas cobrins: ',
        expenses = 'Despesas:',
        towersBought = 'Quantas torres você comprou: ',
        basicsBought = 'Quantas básicas: ',
        snipersBought = 'Quantas snipers: ',
        cannonsBought = 'Quantos canhões: ',
        sauronsBought = 'Quantos saurons: ',
        damage = 'Dano:',
        totalDamage = 'Quanto dano você causou: ',
        basicDamage = 'Quanto pela básica: ',
        sniperDamage = 'Qaunto pela sniper: ',
        cannonDamage = 'Quanto pelo canhão: ',
        sauronDamage = 'Quanto pela sauron: '
    },
    achievementsTitle = love.graphics.newImage('Graphics/Book&Titles/titles/CONQUISTAS.png'),
    condition = 'Condição:',
    unlock = 'Libera:',
    achievementsNames = {
        'Começos',
        'Matador',
        'Cria Infernal',
        'MAGIA'
    },
    achievementsDescs = {
        {'Jogar ', ' jogo(s)'},
        {'Mate ', ' inimigos'},
        {'Mate ', ' Diabretes'},
        {'Mate ', ' Boos'}
    },
    achievementsUnlocks = {
        'Sniper',
        'Canhão',
        'Sauron',
        'Lentidão'
    },
    enemiesTitle = love.graphics.newImage('Graphics/Book&Titles/titles/INIMIGOS.png'),
    enemiesNames = {
        'Elfo',
        'Diabrete',
        'Gênia',
        'Terríneo',
        'Dino',
        'Boitatá',
        'Centauro',
        'Medusa',
        'Ancião',
        'Bruxa',
        'Ogro',
        'Mula Sem Cabeça',
        'Cabra Negra',
        'Ouroboros'
    },
    enemiesDesc = {
        'O mais poderoso de todo reino mágico, com poderes sobre toda a extensão terrestre, criou um Homem de Terra, recrutado para, junto a ele se unir ao grupo e dominar o mundo. ',
        'Vindo das profundezas da terra, chegou para espalhar a discórdia e por onde passe, fazendo com que seus inimigos desviem sua atenção por discutir entre si e, dessa forma, deixem seu caminho livre.',
        'Esta Gênia não vai te conceder três desejos — se, por acidente, a encontrar, será você o responsável por fazer todas as suas vontades.',
        'Criado pelas mãos do elfo mais poderoso é inteiramente composto pela terra mais fértil e poderosa do planeta, usa seus poderes para envolver aqueles que lutem contra ele por eras venenosas, os asfixiando.',
        'Vindo do passado, ele não sabe onde está, mas sente o poder da árvore e está pronto para caçar aqueles em seu caminho.',
        'O Boitatá é uma cobra de fogo que está pronta para proteger seus companheiros. Seus inimigos somos nós.',
        'Criatura bábara, faz o que quer e ai de quem tentar entrar em seu caminho',
        'A Medusa é na, mitologia grega, um monstro ctônico do gênero feminino e qualquer pessoa que a olhe diretamente é transformado em pedra.',
        'Expulso da união de magos por usar seus poderes para o mal, hoje, se uniu à bruxa para buscar o domínio de todo o planeta.',
        'A inimiga mais gananciosa. Capaz de destruir todos o que cruzem seu caminho para poder, livremente, dominar o mundo, espalhando seus feitiços sobre toda a terra.',
        'Uma criatura que não possui poderes mágicos, mas é sem dúvidas o mais forte entre todos os monstros, destruí todos que o tentem vencer.',
        'Era uma mulher que, por seus pecados, foi amaldiçoada e condenada a vivir como uma mula sem cabeça que, hoje, busca sua vingança.',
        'Só ouvimos sobre gatos pretos porque aqueles que os viram sobreviveram.',
        'Um ser além do tempo, você pode até tentar barganhar, mas se sentirá em um eterno ciclo'
    },
    recipesTitle = love.graphics.newImage('Graphics/Book&Titles/titles/RECEITAS.png'),
    ingredients = 'Ingredientes:',
    ingredientsNames = {
        magicDust = 'Pó Mágico',
        greatFlower = 'Grã-Flor',
        snakeVenom = 'Veneno de Cobra',
        dreamCrystal = 'Cristal Onírico',
        treeBranch = 'Ramo da Árvore',
        dinosEssence = "Essência de Dino",
        orcsEye = "Olho de Ogro",
        infernalIce = 'Gelo Infernal'
    },
    effect = 'Efeito:'
}
