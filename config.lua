Config = {}

-- General settings
Config.Language = 'es'
Config.InitialBankBalance = 1000

-- Job definitions: key = job name
Config.Jobs = {
    police = { label = 'Polic\u00eda', type = 'government', salary = 500 },
    ambulance = { label = 'Servicio M\u00e9dico', type = 'government', salary = 450 },
    mechanic = { label = 'Mec\u00e1nico', type = 'business', salary = 300 },
    taxi = { label = 'Taxista', type = 'business', salary = 250 },
    unemployed = { label = 'Desempleado', type = 'civilian', salary = 0 }
}

-- Vehicles available in personal garage
Config.GarageVehicles = {
    { model = 'blista', label = 'Blista', price = 10000 },
    { model = 'sultan', label = 'Sultan', price = 30000 },
    { model = 'police', label = 'Police Cruiser', price = 0, job = 'police' }
}

-- Dealerships and available vehicles
Config.Dealerships = {
    {
        name = 'Concesionario Central',
        location = { x = -55.8, y = -1096.7, z = 26.4 },
        vehicles = {
            { model = 'adder', label = 'Adder', price = 1000000 },
            { model = 'buffalo', label = 'Buffalo', price = 50000 },
            { model = 'vacca', label = 'Vacca', price = 750000 }
        }
    }
}

-- Properties available for purchase by organizations or gangs
Config.Properties = {
    {
        id = 1,
        name = 'Oficina Peque\u00f1a',
        price = 50000,
        type = 'office',
        coords = { x = -100.1, y = -100.5, z = 100.0 }
    },
    {
        id = 2,
        name = 'Almac\u00e9n',
        price = 75000,
        type = 'storage',
        coords = { x = 10.0, y = -200.0, z = 70.0 }
    }
}

-- Missions per job or organization type
Config.Missions = {
    police = {
        { id = 'patrol', label = 'Patrullar la ciudad' },
        { id = 'pursuit', label = 'Perseguir sospechoso' },
        { id = 'traffic_stop', label = 'Realizar control de tr\u00e1fico' }
    },
    ambulance = {
        { id = 'rescue', label = 'Atender emergencia m\u00e9dica' },
        { id = 'transport', label = 'Transportar paciente' }
    },
    mechanic = {
        { id = 'tow', label = 'Remolcar veh\u00edculo' },
        { id = 'repair', label = 'Reparar veh\u00edculo' }
    },
    taxi = {
        { id = 'pickup', label = 'Recoger pasajero' },
        { id = 'delivery', label = 'Entrega de paquete' }
    },
    gangs = {
        { id = 'robbery', label = 'Robo a tienda' },
        { id = 'drugrun', label = 'Entrega de drogas' }
    }
}

-- Illegal dealer configuration
Config.Dealer = {
    locations = {
        { x = 120.0, y = -1278.0, z = 29.2 },
        { x = -230.5, y = -1545.7, z = 31.0 },
        { x = 500.0, y = -600.0, z = 30.0 }
    },
    items = {
        { name = 'cocaina', label = 'Coca\u00edna', price = 500 },
        { name = 'marihuana', label = 'Marihuana', price = 300 },
        { name = 'metanfetamina', label = 'Metanfetamina', price = 700 }
    }
}

-- Cost to create a business or gang
Config.OrganizationCreationPrice = 50000
Config.GangCreationPrice = 30000

-- Organizations definition (inherits ranks from LSPD config)
Config.Organizations = {
    government = {
        lspd = {
            label = 'Los Santos Police Department',
            ranks = {
                [20] = 'Chief of Police',
                [19] = 'Assistant Chief',
                [18] = 'Deputy Chief',
                [17] = 'Commander',
                [16] = 'Captain III',
                [15] = 'Captain II',
                [14] = 'Captain I',
                [13] = 'Lieutenant II',
                [12] = 'Lieutenant I',
                [11] = 'Sergeant II',
                [10] = 'Sergeant I',
                [9] = 'Detective III',
                [8] = 'Detective II',
                [7] = 'Detective I',
                [6] = 'Officer III+1',
                [5] = 'Officer III',
                [4] = 'Officer II',
                [3] = 'Officer I',
                [2] = 'Probationary Officer',
                [1] = 'Cadet'
            }
        }
    },
    business = {},
    gangs = {}
}
