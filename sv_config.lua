return {
    -- Targets
    methprocess = { vector = vector3(978.22, -147.1, -48.53), length = 1.6, width = 1.8, minZ = -50.33, maxZ = -45.53 },
    methtempup = { vector = vector3(982.56, -145.59, -49.0), length = 1.2, width = 1.4, minZ = -50.3, maxZ = -47.3 },
    methtempdown = { vector = vector3(979.59, -144.14, -49.0), length = 1.2, width = 0.5, minZ = -49.2, maxZ = -47.9 },
    methbagging = { vector = vector3(987.44, -140.5, -49.0), length = 0.5, width = 0.7, minZ = -49.35, maxZ = -48.65 },
    thychloride = { vector = vector3(1972.48, 3812.79, 33.43), length = 1.0, width = 1.0, minZ = 32.43, maxZ = 34.43 },
    lsdpro = { vector = vector3(1394.62, 3600.84, 38.94), length = 1.0, width = 1.0, minZ = 34.94, maxZ = 42.94 },
    heroinproc = { vector = vector3(728.39, 4190.37, 40.64), length = 1.0, width = 1.0, minZ = 38.64, maxZ = 42.64 },
    heroinproces = { vector = vector3(1443.24, 6331.78, 23.98), length = 2.5, width = 2.5, minZ = 22.98, maxZ = 24.98 },
    chemmenu = { vector = vector3(92.98, 3755.27, 40.77), length = 1.65, width = 2.4, minZ = 39.77, maxZ = 41.77 },
    seedproces = { vector = vector3(1038.37, -3205.87, -38.17), length = 1.4, width = 1.0, minZ = -41.77, maxZ = -37.77 },
    weedproces = { vector = vector3(1036.34, -3202.95, -38.17), length = 1.4, width = 1.0, minZ = -41.77, maxZ = -37.77 },
    cokeleafproc = { vector = vector3(1086.2, -3194.9, -38.99), length = 2.5, width = 1.4, minZ = -39.39, maxZ = -38.39 },
    cokepowdercut = { vector = vector3(1092.89, -3195.78, -38.99), length = 7.65, width = 1.2, minZ = -39.39, maxZ = -38.44 },
    cokebricked = { vector = vector3(1100.51, -3199.46, -38.93), length = 2.6, width = 1.0, minZ = -39.99, maxZ = -38.59 },

    -- Labs
    MethLab = {
        Enterlab = {
            coords = vector3(4993.18, -5193.63, 2.51),
            teleport = vector4(969.37, -147.15, -46.40, 270.80)
        },
        LeaveLab = {
            coords = vector3(969.37, -147.15, -46.40),
            teleport = vector4(4993.32, -5193.67, 2.51, 30.69)
        }
    },
    WeedLab = {
        Enterlab = {
            coords = vector3(521.52, -1917.59, 25.92),
            teleport = vector4(1066.28, -3183.41, -39.16, 91.91)
        },
        LeaveLab = {
            coords = vector3(1066.27, -3183.41, -39.17),
            teleport = vector4(521.52, -1917.59, 25.92, 38.20)
        }
    },
    CokeLab = {
        Enterlab = {
            coords = vector3(813.25, -2398.66, 23.66),
            teleport = vector4(1088.69, -3187.64, -38.99, 181.20)
        },
        LeaveLab = {
            coords = vector3(1088.68, -3187.68, -39.00),
            teleport = vector4(813.24, -2398.87, 23.66, 180.12)
        }
    },

    -- Zones
    Zones = {
        WeedField = {
            coords = vector3(291.75, 4335.85, 48.27),
            radius = 40.0
        },
        CokeField = {
            coords = vector3(2806.5, 4774.46, 46.98),
            radius = 20.0
        },
        HydrochloricAcidFarm = {
            coords = vector3(-194.93, 6641.60, 1.60),
            radius = 40.0
        },
        SulfuricAcidFarm = {
            coords = vector3(2033.71, 3877.66, 31.90),
            radius = 25.0
        },
        SodiumHydroxideFarm = {
            coords = vector3(1487.69, -2350.00, 72.79),
            radius = 40.0
        },
        ChemicalFarm = {
            coords = vector3(5478.2, -5846.32, 21.96),
            radius = 30.0
        },
        HeroinField = {
            coords = vector3(-2339.15, -54.32, 95.05),
            radius = 40.0
        }
    }
}